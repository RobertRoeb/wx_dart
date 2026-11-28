// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-11-15
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxWindow ----------------------

int _nextWindowHandle = 1;
final Map<int, WxWindow> _windowsByHandle = {};
WxWindow? _capturedWindow;

/// The popup menu currently shown by [WxWindow.popupMenu]
WxMenu? _currentPopupMenu;
Completer<bool>? _popupCompleter;

/// Windows whose sizer layout has to be redone during idle time
final Set<WxWindow> _pendingLayouts = {};

void _doPendingLayouts() {
  if (_pendingLayouts.isEmpty) return;
  final windows = _pendingLayouts.toList();
  _pendingLayouts.clear();
  // parents first, their layout may already resize the children
  windows.sort((a, b) => a._depth().compareTo(b._depth()));
  for (final window in windows) {
    if (!window._isDestroyed) window.layout();
  }
}

/// Base class of all windows.
///
/// In wxDart Web, every window is a DOM element managed by wxc.js and
/// positioned absolutely within its parent. A window gets an HTML canvas
/// as soon as a paint handler is bound with [bindPaintEvent]; [WxPaintDC]
/// then draws onto that canvas.
///
/// Windows are either placed by a [WxSizer] (see [setSizer]) or use the
/// position and size passed to the constructor or set with [setSize] and
/// [setPosition]. As in wxWidgets, a [WxFrame] without a sizer but with
/// a single child window makes that child fill its client area.
///
/// # Events emitted
/// [Paint](/wxdart/wxGetPaintEventType.html) event
/// | ----------------- |
/// | void bindPaintEvent( OnPaintEventFunc ) |
/// | void unbindPaintEvent() |
/// [Size](/wxdart/wxGetSizeEventType.html) event
/// | ----------------- |
/// | void bindSizeEvent( OnSizeEventFunc ) |
/// | void unbindSizeEvent() |
/// Mouse events (LeftDown, LeftUp, LeftDClick, RightDown, ..., Motion,
/// EnterWindow, LeaveWindow, MouseWheel), key events (KeyDown, KeyUp,
/// Char, CharHook), [WxIdleEvent] and [WxUpdateUIEvent].
class WxWindow extends WxEvtHandler {
  /// Creates a custom window with given parent, id, size and style
  WxWindow(this._parent, this._id, this._position, this._size, this._style) {
    if (_id == wxID_ANY) {
      _id = _wxNewControlId();
    }
    _handle = _nextWindowHandle++;
    _windowsByHandle[_handle] = this;
    if (_parent != null) {
      _parent!._children.add(this);
      _position = _toContentPosition(_position);
    }
    _jsCreateWindow(_handle, _parent?._handle ?? 0, _jsKind, _style);
    _applyRect();
  }

  late final int _handle;
  final List<WxWindow> _children = [];
  WxWindow? _parent;
  int _id;
  WxPoint _position;
  WxSize _size;
  int _style;
  WxSize _minSize = wxDefaultSize;
  WxRect _rect = WxRect(0, 0, 0, 0);
  bool _rectApplied = false;
  WxSize? _bestSize;
  bool _hidden = false;
  bool _disabled = false;
  bool _isDestroyed = false;
  bool _paintEnabled = false;
  _Ctx2D? _paintCtx; // only valid during a paint event
  String _label = "";
  String? _tooltip;
  WxFont? _font;
  WxColour? _foregroundColour;
  WxColour? _backgroundColour;
  int _backgroundStyle = wxBG_STYLE_ERASE;
  WxSizer? _sizer;
  WxSizer? _containingSizer;
  WxScrolledWindow? _scrollOwner; // set if this window is scrolled by a WxScrolledWindow
  WxSize _virtualSize = wxDefaultSize;

  /// The kind of DOM element wxc.js creates for this window
  String get _jsKind => 'window';

  // ------------------------- life cycle ----------------------

  /// Deletes this window and removes it from the parent's child window list.
  ///
  /// Will also call [dispose] on this window and from there all child windows.
  bool destroy() {
    if (_isDestroyed) return true;
    _containingSizer?.removeWindow(this);
    _forget();
    if (_parent != null) {
      _parent!._children.remove(this);
    }
    _jsDestroyWindow(_handle);
    return true;
  }

  // removes this window and its children from the Dart side. [dispose]
  // is called first, while the window and its children still exist.
  void _forget() {
    if (_isDestroyed) return;
    dispose();
    _isDestroyed = true;
    for (final child in List<WxWindow>.of(_children)) {
      if (child is WxNonOwnedWindow) {
        child.destroy(); // lives in its own DOM tree (dialogs, popups)
      } else {
        child._forget();
      }
    }
    _children.clear();
    _windowsByHandle.remove(_handle);
    _pendingLayouts.remove(this);
    if (_capturedWindow == this) _capturedWindow = null;
  }

  /// Gets called before the window is destroyed and can be used to e.g.
  /// close a database or network connection or to stop a [WxTimer].
  ///
  /// Called for this window first, then for all child windows, while
  /// all of them still exist.
  ///
  /// Don't forget to call super.dispose() when overriding.
  @override
  void dispose() {
    super.dispose();
  }

  /// Deletes all child windows
  bool destroyChildren() {
    for (final child in List<WxWindow>.of(_children)) {
      child.destroy();
    }
    return true;
  }

  // ------------------------- hierarchy ----------------------

  /// Returns the parent of this window, or null, if this window does not have
  /// a parent window (only possible toplevel windows)
  WxWindow? getParent() {
    return _parent;
  }

  List<WxWindow> getChildren() {
    return List<WxWindow>.unmodifiable(_children);
  }

  List<WxWindow> _getChildren() {
    return _children;
  }

  /// Returns the number of child windows
  ///
  /// see [getChild]
  int getChildCount() {
    return _children.length;
  }

  /// Returns the nth child window
  ///
  /// see [getChildCount]
  WxWindow? getChild(int index) {
    return _children.elementAtOrNull(index);
  }

  /// Returns window with given [id] or null if not found
  WxWindow? findWindow(int id) {
    for (final child in _children) {
      if (child.getId() == id) return child;
      final found = child.findWindow(id);
      if (found != null) return found;
    }
    return null;
  }

  bool isTopLevel() {
    return false;
  }

  /// Returns ID of the window
  int getId() {
    return _id;
  }

  /// Sets the ID of the window
  void setId(int id) {
    _id = id;
  }

  // ------------------------- geometry ----------------------

  /// Size used if no size was given. Overridden by controls.
  WxSize _doGetBestSize() {
    return const WxSize(20, 20);
  }

  /// Returns the size the window would like to have. For a window
  /// with a sizer, this is the minimal size of the sizer.
  ///
  /// A window that is scrolled (a [WxScrolledWindow] or its target window)
  /// does not need the size of its content in the directions in which it
  /// scrolls: there, it asks only for its minimal size (see [setMinSize])
  /// or a small default size, like in wxWidgets. Otherwise, a sizer would
  /// make it as large as its content and it would never scroll. If it has
  /// a sizer, this also applies to the direction that does not scroll,
  /// because the content wraps there and adapts to the given size.
  WxSize getBestSize() {
    final sizer = _sizer;
    WxSize best;
    if (sizer != null) {
      best = clientToWindowSize(sizer.getMinSize());
    } else {
      _bestSize ??= _doGetBestSize();
      best = _bestSize!;
    }
    final owner = _scrollOwner;
    if (owner != null) {
      const scrollBar = 16;
      const smallest = 50;
      final scrollX = owner._canScrollX();
      final scrollY = owner._canScrollY();
      // With a sizer, the content adapts to the width in the direction
      // that does not scroll (wrapping texts, WxWrapSizer), so its minimal
      // size there depends on the last layout and must not determine the
      // size of the window either, otherwise the window could only grow.
      // wxWidgets does the same (wxScrollHelper::FilterBestSize).
      final reflows = sizer != null;
      int w = best.x, h = best.y;
      if (scrollX || (reflows && scrollY)) {
        w = _minSize.x > 0 ? _minSize.x : smallest;
      }
      if (scrollY && !scrollX) {
        w += scrollBar; // room for the vertical scroll bar
      }
      if (scrollY || (reflows && scrollX)) {
        h = _minSize.y > 0 ? _minSize.y : smallest;
      }
      if (scrollX && !scrollY) {
        h += scrollBar; // room for the horizontal scroll bar
      }
      best = WxSize(w, h);
    }
    return best;
  }

  /// Instructs control to recalculate its best size
  void invalidateBestSize() {
    _bestSize = null;
    _requestLayoutOfParents();
  }

  /// Calls [update] and recalculates the best size once [bitmap] has been
  /// loaded: bitmaps from assets or URLs are loaded asynchronously and
  /// their size, and so the best size of e.g. a [WxStaticBitmap], is only
  /// known then. Does nothing if the bitmap is loaded (or has failed) already.
  void _updateWhenLoaded(WxBitmap bitmap, void Function() update) {
    if (bitmap.isOk() || bitmap.hasFailed()) return;
    bitmap.ready.then((_) {
      if (_isDestroyed) return;
      update();
      invalidateBestSize();
    });
  }

  /// The minimal size used by sizers: the size set with [setMinSize] or
  /// passed to the constructor, else the best size.
  WxSize getEffectiveMinSize() {
    int w = _minSize.x != -1 ? _minSize.x : _size.x;
    int h = _minSize.y != -1 ? _minSize.y : _size.y;
    if ((w == -1) || (h == -1)) {
      final best = getBestSize();
      if (w == -1) w = best.x;
      if (h == -1) h = best.y;
    }
    return WxSize(w, h);
  }

  void _applyRect() {
    if (this is WxTopLevelWindow) return;
    if (_containingSizer != null && _rectApplied) {
      // placed by a sizer: let it recalculate
      _requestLayoutOfParents();
      return;
    }
    int w = _size.x;
    int h = _size.y;
    if ((w == -1) || (h == -1)) {
      final best = getBestSize();
      if (w == -1) w = best.x;
      if (h == -1) h = best.y;
    }
    if (_minSize.x != -1 && w < _minSize.x) w = _minSize.x;
    if (_minSize.y != -1 && h < _minSize.y) h = _minSize.y;
    final x = _position.x == -1 ? 0 : _position.x;
    final y = _position.y == -1 ? 0 : _position.y;
    _setActualRect(x, y, w, h);
  }

  void _setActualRect(int x, int y, int w, int h) {
    final sizeChanged = (w != _rect.width) || (h != _rect.height);
    final posChanged = (x != _rect.x) || (y != _rect.y);
    if (_rectApplied && !sizeChanged && !posChanged) return;
    _rect = WxRect(x, y, w, h);
    _rectApplied = true;
    _jsSetRect(_handle, x, y, w, h);
    if (sizeChanged) {
      // like wxWidgets: the application's size handler first (it may
      // change the sizer, e.g. borders that depend on the width), then
      // the layout. Unlike wxWidgets, the layout happens even if the
      // handler does not call skip(), as in wxDart Flutter.
      _sendSizeEvent();
      if (_sizer != null) layout();
      refresh();
    }
  }

  int _depth() {
    int depth = 0;
    WxWindow? current = _parent;
    while (current != null) {
      depth++;
      current = current._parent;
    }
    return depth;
  }

  /// Schedules a sizer layout of this window during idle time
  void _requestLayout() {
    if (_isDestroyed) return;
    _pendingLayouts.add(this);
    _scheduleIdle();
  }

  /// The minimal size of this window changed: the parent (and its
  /// parents, if they are placed by sizers) need a new layout.
  void _requestLayoutOfParents() {
    WxWindow window = this;
    while (window._containingSizer != null && window._parent != null) {
      window = window._parent!;
      window._requestLayout();
      if (window is WxTopLevelWindow) break;
    }
  }

  void _sendSizeEvent() {
    final event = WxSizeEvent(getSize(), id: getId());
    event.setRect(getRect());
    event.setEventObject(this);
    processEvent(event);
  }

  void _sendSizeEventsRecursive() {
    for (final child in _children) {
      if (child is WxTopLevelWindow) continue;
      child._sendSizeEvent();
      child._sendSizeEventsRecursive();
    }
  }

  /// Returns the current actual size, if known aleady.
  WxSize getSize() {
    return WxSize(_rect.width, _rect.height);
  }

  /// Returns window size minus border and scrollbar size, of present
  WxSize getClientSize() {
    if (_scrollOwner != null && _rectApplied) {
      // without the scroll bars
      final s = _jsClientSize(_handle);
      if (s.w > 0 || s.h > 0) return WxSize(s.w, s.h);
    }
    return getSize();
  }

  // ------------------------- virtual size ----------------------

  /// Returns the virtual size set by a scrolled window or the
  /// client size which ever is bigger
  WxSize getVirtualSize() {
    final client = getClientSize();
    return WxSize(max(client.x, _virtualSize.x), max(client.y, _virtualSize.y));
  }

  /// Sets the virtual size of the client area in a scrolled window
  void setVirtualSize(WxSize size) {
    _virtualSize = size;
    _applyVirtualSize();
  }

  void _applyVirtualSize() {
    if (_scrollOwner != null) {
      _jsSetVirtualSize(_handle, max(0, _virtualSize.x), max(0, _virtualSize.y));
    }
  }

  /// Tells the window how much space it gets in [direction] (wxHORIZONTAL
  /// or wxVERTICAL) before its best size is computed. A [WxStaticText]
  /// with wxST_WRAP uses this to wrap its text. Returns true if the
  /// information was used. The default implementation passes the size on
  /// to the sizer of the window, so that a [WxWrapSizer] or a wrapping
  /// text in a child window knows it too. Otherwise, they would compute
  /// their minimal size with the size of the last layout, or none at all.
  bool informFirstDirection(int direction, int size, int availableOtherDir) {
    final sizer = _sizer;
    if (sizer == null || size < 0) return false;
    // where the window scrolls, its content does not depend on its size
    final owner = _scrollOwner;
    if (owner != null && (direction == wxHORIZONTAL ? owner._canScrollX() : owner._canScrollY())) {
    return false;
  }
    final horizontal = direction == wxHORIZONTAL;
    final client = windowToClientSize(horizontal ? WxSize(size, 0) : WxSize(0, size));
    return sizer.informFirstDirection(direction, max(0, horizontal ? client.x : client.y), -1);
  }

  /// Sets the virtual size to the minimal size of the sizer
  void fitInside() {
    final sizer = _sizer;
    if (sizer != null) {
      setVirtualSize(sizer.getMinSize());
      layout();
    }
  }

  /// Returns the x device offset relevant for scrolling
  int getDeviceOffsetX() {
    return 0;
  }

  /// Returns the x device offset relevant for scrolling
  int getDeviceOffsetY() {
    return 0;
  }

  /// Scrolls the content by [dx], [dy] pixels (if scrolled by a
  /// [WxScrolledWindow]); positive values move the content right/down.
  void scrollWindow(int dx, int dy) {
    final owner = _scrollOwner;
    if (owner == null) return;
    final start = owner.getViewStartPixels();
    _jsScrollTo(_handle, max(0, start.x - dx), max(0, start.y - dy));
  }

  /// Returns client area origin relative to window origin
  WxPoint getClientAreaOrigin() {
    return WxPoint.zero;
  }

  /// Returns rectangle of window's client area
  WxRect getClientRect() {
    final size = getClientSize();
    return WxRect(0, 0, size.x, size.y);
  }

  /// Returns the position and size relative to the parent window. In a
  /// scrolled parent, the position is relative to its visible area, see
  /// [getPosition].
  WxRect getRect() {
    final start = _parentScrollOffset();
    return WxRect(_rect.x - start.x, _rect.y - start.y, _rect.width, _rect.height);
  }

  /// Returns current position relative to parent window
  ///
  /// As in wxWidgets, the position of a child of a scrolled window is
  /// relative to the visible area: it changes when the parent scrolls. A
  /// child at y = 900 is at y = 0 once the parent has been scrolled down by
  /// 900 pixels. [WxScrolledWindow.calcUnscrolledPosition] gives the
  /// position in the whole (virtual) area.
  WxPoint getPosition() {
    final start = _parentScrollOffset();
    return WxPoint(_rect.x - start.x, _rect.y - start.y);
  }

  /// How far the parent has been scrolled, if it is the scrolled area of a
  /// [WxScrolledWindow] (positions of its children are client coordinates,
  /// the page and _rect use coordinates of the whole area)
  WxPoint _parentScrollOffset() {
    final owner = _parent?._scrollOwner;
    if (owner == null) return const WxPoint(0, 0);
    return owner.getViewStartPixels();
  }

  /// Converts a position given by the application (client coordinates of
  /// the parent) to coordinates of the whole area; -1 stays -1
  WxPoint _toContentPosition(WxPoint pos) {
    if (pos.x == -1 && pos.y == -1) return pos;
    final start = _parentScrollOffset();
    return WxPoint(pos.x == -1 ? -1 : pos.x + start.x, pos.y == -1 ? -1 : pos.y + start.y);
  }

  /// Returns minimal size as determined by the system and/or
  /// the initial size.
  ///
  /// It is usually enough to call [setSize] or [setMinSize]
  /// to set the size request for a given window. However, since
  /// it is quite common in wxWidgets C++ and wxPython to override
  /// [getMinSize], this sole function can be overridden in user
  /// code to allow more complex size request calculation.
  WxSize getMinSize() {
    return _minSize;
  }

  /// Sets the requested size of the control with -1 indicating that
  /// the control should calculate the dimension itself or do a guess.
  ///
  /// see [setSize], [getMinSize]
  void setMinSize(WxSize size) {
    _minSize = size;
    _applyRect();
  }

  /// Sets the requested size of the control with -1 indicating no change.
  ///
  /// see [setMinSize]
  void setSize(WxSize size) {
    _size = size;
    _applyRect();
  }

  /// Sets the requested client size of the control with -1 indicating
  /// no change, adding space for a border.
  ///
  /// see [setSize], [setMinSize]
  void setClientSize(WxSize size) {
    setSize(size);
  }

  /// Sets current position relative to parent window (relative to the
  /// visible area of a scrolled parent, see [getPosition])
  void setPosition(WxPoint pos) {
    _position = _toContentPosition(pos);
    _applyRect();
  }

  void move(int x, int y) {
    setPosition(WxPoint(x, y));
  }

  /// Sets the position and size of the window.
  ///
  /// A value of -1 indicates default values if possible
  void setPositionAndSize(int x, int y, int width, int height) {
    _position = _toContentPosition(WxPoint(x, y));
    _size = WxSize(width, height);
    _applyRect();
  }

  /// Converts client area size size to corresponding window size.
  /// In other words, the returned value is what would [getSize]
  /// return if this window had client area of given size.
  WxSize clientToWindowSize(WxSize size) {
    return size;
  }

  /// Converts window size size to corresponding client area size.
  /// In other words, the returned value is what would [getClientSize]
  /// return if this window had given window size.
  WxSize windowToClientSize(WxSize size) {
    return size;
  }

  /// Centres the window on its parent window in the given direction
  ///
  /// [direction] can be either of wxHORIZONTAL, wxVERTICAL or wxBOTH
  void centreOnParent({int direction = wxBOTH}) {
    final parent = _parent;
    if (parent == null) return;
    final ps = parent.getClientSize();
    final s = getSize();
    int x = _rect.x;
    int y = _rect.y;
    if ((direction & wxHORIZONTAL) != 0) x = (ps.x - s.x) ~/ 2;
    if ((direction & wxVERTICAL) != 0) y = (ps.y - s.y) ~/ 2;
    setPosition(WxPoint(x, y));
  }

  void centre({int direction = wxBOTH}) {
    centreOnParent(direction: direction);
  }

  // ------------------------- sizers ----------------------

  /// Associate [sizer] with this window
  void setSizer(WxSizer? sizer, {bool deleteOld = true}) {
    final old = _sizer;
    if (old != null && old != sizer && deleteOld) {
      old.clear();
    }
    _sizer = sizer;
    if (sizer != null) {
      sizer._setOwningWindow(this);
      _requestLayout();
    }
    _requestLayoutOfParents();
  }

  /// Returns the [WxSizer] currently associated with this window, or null
  WxSizer? getSizer() {
    return _sizer;
  }

  /// Associate [sizer] with this window and resize it to make it fit the
  /// minimal constraints of it. Under wxDart Flutter, the fitting is automatically
  /// achieved by the Flutter layout mechanism.
  void setSizerAndFit(WxSizer sizer, {bool deleteOld = true}) {
    setSizer(sizer, deleteOld: deleteOld);
    sizer.setSizeHints(this);
    sizer.fit(this);
  }

  void setContainingSizer(WxSizer? sizer) {
    _containingSizer = sizer;
  }

  WxSizer? getContainingSizer() {
    return _containingSizer;
  }

  /// If any [WxSizer] has been associated with this window, perform a layout.
  ///
  /// The window or dialog will perform a layout when initially shown, but
  /// when something changes _after_ the window was shown, then you need
  /// to call layout. In wxDart Flutter, the window layout will get updated
  /// automatically eventually but calling [layout] will do it immediatly.
  bool layout() {
    _pendingLayouts.remove(this);
    final sizer = _sizer;
    if (sizer == null) return false;
    final owner = _scrollOwner;
    if (owner == null) {
      sizer.setDimension(WxPoint.zero, getClientSize());
      return true;
    }
    // a scrolled window: the sizer defines the virtual size and is laid
    // out in it (at least as large as the visible area)
    final scrollX = owner._canScrollX();
    WxSize client = getClientSize();
    WxSize minSize = WxSize.zero;
    // without horizontal scrolling, the content gets the visible width and
    // may wrap (texts, WxWrapSizer). The vertical scroll bar can appear
    // or disappear as a result and change the width, so try twice.
    for (int pass = 0; pass < 2; pass++) {
      if (!scrollX) sizer.informFirstDirection(wxHORIZONTAL, client.x, -1);
      minSize = sizer.getMinSize();
      _virtualSize = scrollX ? minSize : WxSize(min(minSize.x, client.x), minSize.y);
      _applyVirtualSize(); // first, so that the scroll bars appear or disappear
      final newClient = getClientSize();
      final changed = newClient.x != client.x;
      client = newClient;
      if (scrollX || !changed) break;
      if (pass == 1) {
        // still changing: lay out for the final width anyway
        sizer.informFirstDirection(wxHORIZONTAL, client.x, -1);
        minSize = sizer.getMinSize();
      }
    }
    final width = owner._canScrollX() ? max(client.x, minSize.x) : client.x;
    final height = owner._canScrollY() ? max(client.y, minSize.y) : client.y;
    sizer.setDimension(WxPoint.zero, WxSize(width, height));
    return true;
  }

  /// Resizes the window to fit its sizer (or its best size)
  void fit() {
    final sizer = _sizer;
    if (sizer != null) {
      setClientSize(sizer.getMinSize());
    } else {
      setSize(getBestSize());
    }
  }

  /// Returns the area of the window that needs to get updated
  /// during a paint event handler. This will often return the
  /// entire client area.
  ///
  /// The update region is always the whole window in wxDart Web
  WxRect getUpdateClientRect() {
    return getClientRect();
  }

  /// Apply the current DPI scale factor to [x]
  int fromDIP(int x) {
    return x;
  }

  /// Apply the current DPI scale factor to [size]
  WxSize sizeFromDIP(WxSize size) {
    return size;
  }

  /// Returns the content scale factor relevant for producing high
  /// resolution bitmaps (e.g. 64x64) even if the logical scale on
  /// screen is 32x32. Used internally by [WxBitmapBundle].
  ///
  /// see [getDPIScaleFactor]
  double getContentScaleFactor() {
    return _jsDevicePixelRatio();
  }

  /// Returns the current DPI scale factor on system which use device
  /// dependent pixel scaling, essentially only wxDart Native on Windows.
  /// All other system and wxDart Flutter on all platforms (including
  /// Windows) return 1.0.
  ///
  /// See [getContentScaleFactor];
  double getDPIScaleFactor() {
    return _jsDevicePixelRatio();
  }

  // ------------------------- appearance ----------------------

  /// Sets the label of control. This can be the main text, e.g.
  /// in a [WxButton] or name associated with the control in the
  /// context of accessibilty
  void setLabel(String label) {
    _label = label;
    _jsSetLabel(_handle, label);
    _labelOrFontChanged();
  }

  /// Returns the current label
  String getLabel() {
    return _label;
  }

  void _labelOrFontChanged() {
    _bestSize = null;
    if (_containingSizer != null) {
      _requestLayoutOfParents();
    } else if ((_size.x == -1) || (_size.y == -1)) {
      _applyRect();
    }
  }

  /// Sets the font of the window. This can have different effects in different
  /// controls. Be careful with different default font sizes on different platforms.
  ///
  /// As in wxWidgets, the window keeps a copy: changing [font] afterwards
  /// (e.g. with [WxFont.makeLarger]) doesn't change the window.
  void setFont(WxFont? font) {
    _font = font?.clone();
    _jsSetFont(_handle, font == null ? "" : font._css());
    _labelOrFontChanged();
    refresh();
  }

  /// Returns a copy of the font of the window (or of [wxNORMAL_FONT]):
  /// changing it doesn't change the window, call [setFont] for that.
  WxFont getFont() {
    return _effectiveFont;
  }

  /// The font used by the window, without copying it (for internal use)
  WxFont get _effectiveFont => _font ?? wxNORMAL_FONT;

  /// Returns the size if [text] when using the current font
  WxSize getTextExtent(String text) {
    final m = _jsMeasureText(_effectiveFont._css(), text);
    return WxSize(m.w.ceil(), (m.ascent + m.descent).ceil());
  }

  int getCharHeight() {
    return getTextExtent("Xg").y;
  }

  int getCharWidth() {
    return getTextExtent("x").x;
  }

  /// Set the foreground colour of the window or control. This can have different
  /// meaning in different controls.
  void setForegroundColour(WxColour col) {
    _foregroundColour = col;
    _updateColours();
  }

  /// Returns foreground colour
  WxColour getForegroundColour() {
    if (_foregroundColour != null) return _foregroundColour!;
    return wxTheApp.isDark() ? WxColour(232, 232, 232) : WxColour(27, 27, 27);
  }

  /// Returns true if a specific, non-default, foreground colour has been
  /// specified.
  bool useForegroundColour() {
    return _foregroundColour != null;
  }

  /// Set the background colour of the window or control. This can have different
  /// meaning in different controls.
  void setBackgroundColour(WxColour col) {
    _backgroundColour = col;
    _updateColours();
  }

  /// Returns background colour
  WxColour getBackgroundColour() {
    if (_backgroundColour != null) return _backgroundColour!;
    return wxTheApp.isDark() ? WxColour(32, 33, 36) : WxColour(243, 243, 243);
  }

  /// Returns true if a specific, non-default, foreground colour has been
  /// specified.
  bool useBackgroundColour() {
    return _backgroundColour != null;
  }

  void _updateColours() {
    _jsSetColours(
        _handle,
        _foregroundColour == null ? "" : _cssColour(_foregroundColour!),
        _backgroundColour == null ? "" : _cssColour(_backgroundColour!));
  }

  /// Currently, wxDart sets these flags itself in the background so this is
  /// for information only. In wxDart the background is always drawn into the window buffer. You
  /// can paint over it, e.g. with a gradient or pure white.
  ///
  /// | constant | value (meaning) |
  /// | -------- | -------- |
  /// | wxBG_STYLE_ERASE | 0 (disabled in wxDart) |
  /// | wxBG_STYLE_SYSTEM | 1 (disabled in wxDart) |
  /// | wxBG_STYLE_PAINT | 2 (the default in wxDart|
  /// | wxBG_STYLE_TRANSPARENT | 3 (chosen for translucent windows) |
  void setBackgroundStyle(int style) {
    _backgroundStyle = style;
  }

  /// Returns background style
  int getBackgroundStyle() {
    return _backgroundStyle;
  }

  /// Sets the tooltip for the window
  ///
  /// See [unsetToolTip]
  void setToolTip(String tip) {
    _tooltip = tip;
    _jsSetToolTip(_handle, tip);
  }

  /// Removes the tooltip from the window
  ///
  /// See [setToolTip]
  void unsetToolTip() {
    _tooltip = null;
    _jsSetToolTip(_handle, "");
  }

  /// Returns the tooltip text
  ///
  /// See [setToolTip]
  String getToolTipText() {
    return _tooltip ?? "";
  }

  // ------------------------- painting ----------------------

  /// Binds the paint event and creates the canvas for this window
  @override
  void bindPaintEvent(OnPaintEventFunc func) {
    super.bindPaintEvent(func);
    if (!_paintEnabled) {
      _paintEnabled = true;
      _jsEnablePaint(_handle);
    }
  }

  /// Refreshes window. If a batch of updates is happening, you
  /// may want to freeze and then thaw the window.
  ///
  /// see [freeze] and [thaw]
  void refresh() {
    if (_paintEnabled) {
      _jsRefresh(_handle);
    }
  }

  void refreshRect(WxRect rect) {
    refresh();
  }

  /// Painting happens in the next animation frame anyway
  void update() {}

  void _refreshRecursive() {
    refresh();
    for (final child in _children) {
      if (child is! WxTopLevelWindow) child._refreshRecursive();
    }
  }

  /// Stops updates to this window if a batch of updates occur
  ///
  /// see [thaw]
  void freeze() {}
  /// Updates window at the end of a batch of updates occur
  ///
  /// see [freeze] and [isFrozen]
  void thaw() {}
  /// Returns true if window doesn't update while in a batch
  /// of smaller updates
  ///
  /// see [freeze] and [thaw]
/// Enable generation of gesture events
/// 
/// # Event mask constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxTOUCH_NONE | 0 |
/// | wxTOUCH_HORIZONTAL_PAN_GESTURE | 0x0001 |
/// | wxTOUCH_VERTICAL_PAN_GESTURE | 0x0002 |
/// | wxTOUCH_PAN_GESTURES | wxTOUCH_VERTICAL_PAN_GESTURE | wxTOUCH_HORIZONTAL_PAN_GESTURE |
/// | wxTOUCH_ZOOM_GESTURE | 0x0004 |
/// | wxTOUCH_ROTATE_GESTURE | 0x0008 |
/// | wxTOUCH_PRESS_GESTURES | 0x0010 |
/// | wxTOUCH_ALL_GESTURES | 0x001f |
/// | wxTOUCH_RAW_EVENTS | 0x0020 |
///
/// In wxDart Web, one finger sends [WxPanGestureEvent] and two fingers
/// send [WxZoomGestureEvent]. Fingers on this window then send no mouse
/// events, except that a tap arrives as left button down and up. The
/// mouse and pens keep sending mouse events. Rotate and press gestures
/// and raw events are not supported yet.
  void enableTouchEvents( int eventsMask ) {
    _touchEventMask = eventsMask;
    _jsTouchEvents( _handle, eventsMask );
  }

  int _touchEventMask = 0;

  bool isFrozen() {
    return false;
  }

  // ------------------------- state ----------------------

  /// Show or hide window (depending on [show])
  void show({bool show = true}) {
    if (_hidden == !show) return;
    _hidden = !show;
    _jsShow(_handle, show);
    if (_containingSizer != null) {
      _requestLayoutOfParents();
    } else if (_parent is WxFrame) {
      (_parent as WxFrame)._layoutChildren();
    }
  }

  /// Hide window
  void hide() {
    show(show: false);
  }

  /// Returns true if not hidden.
  ///
  /// The window may still be hidden behind other windows or
  /// off-screen or not yet actually shown.
  bool isShown() {
    return !_hidden;
  }

  /// Enables the control (usually the default)
  ///
  /// see [disable]
  void enable({bool enable = true}) {
    _disabled = !enable;
    _jsEnable(_handle, enable);
  }

  /// Disables the control (usually turn it grey)
  ///
  /// see [enable]
  void disable() {
    enable(enable: false);
  }

  bool isThisEnabled() {
    return !_disabled;
  }

  /// Returns true if enabled
  ///
  /// see [enable] and [disable]
  bool isEnabled() {
    if (_disabled) return false;
    if (this is WxTopLevelWindow) return true;
    return _parent?.isEnabled() ?? true;
  }

  /// Returns window style/flag
  ///
  /// Same as [getWindowStyleFlag]
  int getWindowStyle() {
    return _style;
  }

  /// Returns window style/flag
  ///
  /// Same as [getWindowStyle]
  int getWindowStyleFlag() {
    return _style;
  }

  /// Returns true if the window style/flag was set
  bool hasFlag(int flag) {
    return (_style & flag) != 0;
  }

  /// Sets window style/flag. Many style can only be
  /// created in the constructor of a control and have no effect when set later.
  ///
  /// Same as [setWindowStyle]
  void setWindowStyleFlag(int style) {
    _style = style;
  }

  /// Same as [setWindowStyleFlag]
  void setWindowStyle(int style) {
    _style = style;
  }

  // ------------------------- focus and capture ----------------------

  /// Tries to set the focus to this window/control
  void setFocus() {
    _jsSetFocus(_handle);
  }

  /// Returns true if the window currently has the keyboard focus
  bool hasFocus() {
    return _jsHasFocus(_handle);
  }

  /// Indicates if the control can receive the focus. Cannot be overridden in wxDart yet.
  ///
  /// Use [setCanFocus], [isFocusable] and [canAcceptFocus]
  bool acceptsFocus() {
    return _acceptsFocus;
  }

  bool _acceptsFocus = true;
  bool _disableAcceptsFocusFromKeyboard = false;
  WxCursor? _cursor;

  // ------------------------- drag and drop ----------------------

  WxDropTarget? _dropTarget;
  WxDropSource? _dropSource;

  /// Associates the given drop target to this window. This
  /// allows data to be dropped on this window from a drag and
  /// drop operation.
  ///
  /// See [WxDropTarget]
  void setDropTarget( WxDropTarget? target ) {
    _dropTarget = target;
    _jsSetDropTarget( _handle, target != null );
  }

  /// Returns the associated [WxDropTarget], if any
  WxDropTarget? getDropTarget( ) {
    return _dropTarget;
  }

  /// Converts the [point] from local client coordinates
  /// to coordinates on screen.
  ///
  /// Currently uses the top level FlutterView as the
  /// definition of screen in wxDart Flutter.
  ///
  /// See [screenToClient].
  ///
  /// Converts a position in client coordinates to screen coordinates
  /// (in wxDart Web: relative to the browser's viewport)
  WxPoint clientToScreen( WxPoint pt ) {
    final origin = _jsClientOrigin( _handle );
    return WxPoint( pt.x + origin.x, pt.y + origin.y );
  }

  /// Converts the [point] from screen coordinates
  /// to local client coordinates.
  ///
  /// Currently uses the top level FlutterView as the
  /// definition of screen in wxDart Flutter.
  ///
  /// See [clientToScreen].
  ///
  /// Converts a position in screen coordinates (relative to the
  /// browser's viewport) to client coordinates
  WxPoint screenToClient( WxPoint pt ) {
    final origin = _jsClientOrigin( _handle );
    return WxPoint( pt.x - origin.x, pt.y - origin.y );
  }

  /// Indicates if the control can receive the focus from keyboard. Cannot be overridden in wxDart yet.
  ///
  /// Use [disableFocusFromKeyboard], [setCanFocus], [isFocusable] and [canAcceptFocus]
  bool acceptsFocusFromKeyboard() {
    return acceptsFocus() && !_disableAcceptsFocusFromKeyboard;
  }

  /// Returns true if this window or one of its child windows can accept focus, is shown and is enabled
  bool canAcceptFocus() {
    return acceptsFocus() && isShown() && isEnabled();
  }

  /// Returns true if this window/control can accept focus, is shown and is enabled
  bool isFocusable() {
    return acceptsFocus();
  }

  /// Indicate that this window or control cannot received the focus.
  ///
  /// Use [acceptsFocus], [isFocusable] and [canAcceptFocus]
  void setCanFocus(bool canFocus) {
    _acceptsFocus = canFocus;
    _jsSetCanFocus(_handle, canFocus);
  }

  void disableFocusFromKeyboard() {
    _disableAcceptsFocusFromKeyboard = true;
  }

  /// Sets the window to have the [cursor] or fall back to the default one
  void setCursor(WxCursor? cursor) {
    _cursor = cursor;
    _jsSetCursor(_handle, cursor == null ? "" : _cssCursor(cursor.getStockCursor()));
  }

  /// Returns current cursor or null, if default one is used
  WxCursor? getCursor() {
    return _cursor;
  }

  /// Removes the [child] window from the list of child windows of this window
  void removeChild(WxWindow child) {
    _children.remove(child);
  }

  /// True if the browser should handle this key itself (e.g. Enter in a
  /// focused button or a multi-line text control) instead of the dialog's
  /// default button or a menu accelerator.
  bool _wantsNativeKey(int keyCode) {
    return false;
  }

  /// Captures mouse
  ///
  /// see [releaseMouse] and [hasCapture]
  void captureMouse() {
    _capturedWindow = this;
    _jsCaptureMouse(_handle);
  }

  /// Releases mouse capture
  ///
  /// see [captureMouse] and [hasCapture]
  void releaseMouse() {
    if (_capturedWindow == this) _capturedWindow = null;
    _jsReleaseMouse(_handle);
  }

  /// Returns true if mouse is being captured
  ///
  /// see [captureMouse] and [releaseMouse]
  bool hasCapture() {
    return _capturedWindow == this;
  }

  static WxWindow? getCapture() {
    return _capturedWindow;
  }

  // ------------------------- idle processing ----------------------

  /// Used internally in parallel to [WxIdleEvent]s.
  void onInternalIdle() {}

  /// Sends WxUpdateUIEvent; overridden by controls
  void _sendUpdateUI() {}

  void _sendUpdateUIRecursive() {
    if (_hidden) return;
    _sendUpdateUI();
    for (final child in List<WxWindow>.of(_children)) {
      if (child is WxTopLevelWindow) continue;
      child._sendUpdateUIRecursive();
    }
  }

  /// Returns true if more idle events were requested
  bool _sendIdleRecursive() {
    onInternalIdle();
    final event = WxIdleEvent(id: getId());
    event.setEventObject(this);
    processEvent(event);
    bool more = event.moreRequested();
    for (final child in List<WxWindow>.of(_children)) {
      if (child is WxTopLevelWindow) continue;
      if (child._sendIdleRecursive()) more = true;
    }
    return more;
  }

  // ------------------------- popup menu ----------------------

  /// Shows a popup menu at the given [pos] or next to the mouse cursor
  /// if no [pos] is given.
  ///
  /// The menu entries will be updated using a [WxUpdateUIEvent] event
  /// before showing the actual menu.
  Future<bool> popupMenu(WxMenu menu, {WxPoint pos = wxDefaultPosition}) {
    _closePopupMenu();
    menu.setInvokingWindow(this);
    menu._updateUI();
    final event = WxMenuEvent(wxGetMenuOpenEventType(), -1, menu: menu);
    event.setEventObject(menu);
    menu.processEvent(event);
    _currentPopupMenu = menu;
    final completer = Completer<bool>();
    _popupCompleter = completer;
    _jsPopupMenu(_handle, jsonEncode(menu._toJson()), pos.x, pos.y);
    return completer.future;
  }

  // ------------------------- misc ----------------------

  void printChildren() {
    for (final child in _children) {
      print(child.runtimeType);
    }
  }
}

/// Called when wxc.js closed the popup menu (or before a new one opens)
void _closePopupMenu() {
  final menu = _currentPopupMenu;
  final completer = _popupCompleter;
  _currentPopupMenu = null;
  _popupCompleter = null;
  if (menu != null) {
    final event = WxMenuEvent(wxGetMenuCloseEventType(), -1, menu: menu);
    event.setEventObject(menu);
    menu.processEvent(event);
  }
  if (completer != null && !completer.isCompleted) completer.complete(true);
}

String _cssCursor(int stock) {
  switch (stock) {
    case wxCURSOR_NONE: return "none";
    case wxCURSOR_HAND: return "pointer";
    case wxCURSOR_IBEAM: return "text";
    case wxCURSOR_CROSS: return "crosshair";
    case wxCURSOR_SIZEWE: return "ew-resize";
    case wxCURSOR_SIZENS: return "ns-resize";
    case wxCURSOR_SIZENESW: return "nesw-resize";
    case wxCURSOR_SIZENWSE: return "nwse-resize";
    case wxCURSOR_SIZING: return "move";
    case wxCURSOR_NO_ENTRY: return "not-allowed";
    case wxCURSOR_QUESTION_ARROW: return "help";
    case wxCURSOR_WAIT: return "wait";
    case wxCURSOR_WATCH: return "progress";
    case wxCURSOR_MAGNIFIER: return "zoom-in";
    case wxCURSOR_CHAR: return "text";
    default: return "default";
  }
}
