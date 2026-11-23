// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-11-15
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxSizerItem ----------------------

enum WxSizerKind { none, spacer, sizer, window }

/// An entry in a [WxSizer]: a window, a nested sizer or a spacer,
/// together with its proportion, flags and border.
class WxSizerItem {
  WxSizerItem._asSpacer(int width, int height) {
    _kind = WxSizerKind.spacer;
    _spacerSize = WxSize(width, height);
  }

  WxSizerItem._asSizer(this._sizer, this._proportion, this._flag, this._border) {
    _kind = WxSizerKind.sizer;
  }

  WxSizerItem._asWindow(this._window, this._proportion, this._flag, this._border) {
    _kind = WxSizerKind.window;
  }

  WxSizerKind _kind = WxSizerKind.none;
  int _proportion = 0;
  int _flag = 0;
  int _border = 0;
  WxSizer? _sizer;
  WxWindow? _window;
  WxSize _spacerSize = WxSize.zero;
  WxSize _minSize = wxDefaultSize;
  bool _shown = true;
  WxRect _rect = WxRect(0, 0, 0, 0);

  /// Returns true if item is a sizer
  bool isSizer() {
    return _kind == WxSizerKind.sizer;
  }

  /// Returns true if item is a spacer
  bool isSpacer() {
    return _kind == WxSizerKind.spacer;
  }

  /// Returns true if item is a window
  bool isWindow() {
    return _kind == WxSizerKind.window;
  }

  /// Returns the associated sizer, or null.
  WxSizer? getSizer() {
    return _sizer;
  }

  /// Returns the associated window, or null.
  WxWindow? getWindow() {
    return _window;
  }

  /// Hidden windows (and sizers containing only hidden items) take
  /// no space.
  bool isShown() {
    switch (_kind) {
      case WxSizerKind.window:
        return _window!.isShown();
      case WxSizerKind.sizer:
        return _shown && _sizer!._hasShownItems();
      default:
        return _shown;
    }
  }

  void show(bool show) {
    if (_kind == WxSizerKind.window) {
      _window!.show(show: show);
    } else {
      _shown = show;
    }
  }

  /// Returns the current position on the parent window, if already known
  /// or wxDefaultPosition of not known yet.
  WxPoint getPosition() {
    return WxPoint(_rect.x, _rect.y);
  }

  /// Returns the current size on the parent window, if already known
  /// or [wxDefaultSize] if not known yet.
  WxSize getSize() {
    return WxSize(_rect.width, _rect.height);
  }

  WxRect getRect() {
    return WxRect(_rect.x, _rect.y, _rect.width, _rect.height);
  }

  /// Returns the border width around the item.
  int getBorder() {
    return _border;
  }

  /// Sets the border width around the item.
  void setBorder(int border) {
    _border = border;
  }

  /// Returns the flag parameter (which determines alignment and
  /// where the borders are). A bitwise combination of the below constants.
  ///
  /// These flags determine on which side of a control extra 'border' space should be added
  ///
  /// | constant | value |
  /// | -------- | -------- |
  /// | wxLEFT | 0x0010 |
  /// | wxRIGHT | 0x0020 |
  /// | wxUP | 0x0040 |
  /// | wxDOWN | 0x0080 |
  /// | wxTOP | wxUP |
  /// | wxBOTTOM | wxDOWN |
  /// | wxNORTH | wxUP |
  /// | wxSOUTH | wxDOWN |
  /// | wxWEST | wxLEFT |
  /// | wxEAST | wxRIGHT |
  /// | wxALL | (wxUP \| wxDOWN \| wxRIGHT \| wxLEFT) |
  /// | wxDIRECTION_MASK | wxALL |
  ///
  /// These flags determine the alignment
  ///
  /// | constant | value |
  /// | -------- | -------- |
  /// | wxALIGN_INVALID | -1 |
  /// | wxALIGN_NOT | 0x0000 |
  /// | wxALIGN_CENTER_HORIZONTAL | 0x0100 |
  /// | wxALIGN_CENTRE_HORIZONTAL | wxALIGN_CENTER_HORIZONTAL |
  /// | wxALIGN_LEFT | wxALIGN_NOT |
  /// | wxALIGN_TOP | wxALIGN_NOT |
  /// | wxALIGN_RIGHT | 0x0200 |
  /// | wxALIGN_BOTTOM | 0x0400 |
  /// | wxALIGN_CENTER_VERTICAL | 0x0800 |
  /// | wxALIGN_CENTRE_VERTICAL | wxALIGN_CENTER_VERTICAL |
  /// | wxALIGN_CENTER | (wxALIGN_CENTER_HORIZONTAL \| wxALIGN_CENTER_VERTICAL) |
  /// | wxALIGN_CENTRE | wxALIGN_CENTER |
  /// | wxALIGN_MASK | 0x0f00 |
  ///
  /// These flags determine the stretch behaviour. [wxEXPAND] is used for the
  /// secondary direction (vertical stretch behaviour in a horizontal sizer and
  /// vice versa). The _proportion_ parameter in [WxSizer.add] determines the
  /// stretch behaviour in the primary direction.
  ///
  /// | constant | value |
  /// | -------- | -------- |
  /// | wxSTRETCH_NOT | 0x0000 |
  /// | wxSHRINK | 0x1000 (shrink below minimal/initial size, always on in wxDart Flutter) |
  /// | wxGROW | 0x2000 |
  /// | wxEXPAND | wxGROW |
  /// | wxSHAPED | 0x4000 (not supported in wxDart Flutter)|
  /// | wxTILE | 0xc000 |
  /// | wxSTRETCH_MASK | 0x7000 |
  int getFlag() {
    return _flag;
  }

  /// Sets the flag parameter (which determines alignment and
  /// were the borders are). A bitwise combination of the below constants.
  ///
  /// See [getFlag].
  void setFlag(int flag) {
    _flag = flag;
  }

  /// Returns the proportion parameter which determines the relative stretch factor
  /// in the respective primary direction.
  int getProportion() {
    return _proportion;
  }

  /// Sets the proportion parameter which determines the relative stretch factor
  /// in the respective primary direction.
  void setProportion(int proportion) {
    _proportion = proportion;
  }

  /// Sets the minimal size of the item (without border)
  void setMinSize(WxSize size) {
    _minSize = size;
    if (_kind == WxSizerKind.spacer) _spacerSize = size;
  }

  /// Minimal size without border
  WxSize getMinSize() {
    return _calcMin();
  }

  WxSize _calcMin() {
    WxSize size;
    switch (_kind) {
      case WxSizerKind.window:
        size = _window!.getEffectiveMinSize();
        break;
      case WxSizerKind.sizer:
        size = _sizer!.getMinSize();
        break;
      default:
        size = _spacerSize;
    }
    if (_kind != WxSizerKind.spacer) {
      size = WxSize(max(size.x, _minSize.x), max(size.y, _minSize.y));
    }
    return size;
  }

  int get _borderLeft => (_flag & wxLEFT) != 0 ? _border : 0;
  int get _borderRight => (_flag & wxRIGHT) != 0 ? _border : 0;
  int get _borderTop => (_flag & wxTOP) != 0 ? _border : 0;
  int get _borderBottom => (_flag & wxBOTTOM) != 0 ? _border : 0;

  /// Minimal size including the border
  WxSize getMinSizeWithBorder() {
    final s = _calcMin();
    return WxSize(s.x + _borderLeft + _borderRight, s.y + _borderTop + _borderBottom);
  }

  /// Tells the item how much space it gets in [direction] (wxHORIZONTAL
  /// or wxVERTICAL), including the border, before its minimal size is
  /// computed. Items whose size in the other direction depends on it (a
  /// [WxWrapSizer], a wrapping [WxStaticText]) adapt their minimal size.
  /// Returns true if the information was used.
  bool informFirstDirection(int direction, int size, int availableOtherDir) {
    if (size < 0) return false;
    final border = direction == wxHORIZONTAL ? _borderLeft + _borderRight : _borderTop + _borderBottom;
    final available = max(0, size - border);
    switch (_kind) {
      case WxSizerKind.window:
        return _window!.informFirstDirection(direction, available, availableOtherDir);
      case WxSizerKind.sizer:
        return _sizer!.informFirstDirection(direction, available, availableOtherDir);
      default:
        return false;
    }
  }

  /// Positions the item; [pos] and [size] include the border
  void setDimension(WxPoint pos, WxSize size) {
    _rect = WxRect(pos.x, pos.y, size.x, size.y);
    final x = pos.x + _borderLeft;
    final y = pos.y + _borderTop;
    final w = max(0, size.x - _borderLeft - _borderRight);
    final h = max(0, size.y - _borderTop - _borderBottom);
    switch (_kind) {
      case WxSizerKind.window:
        _window!._setActualRect(x, y, w, h);
        break;
      case WxSizerKind.sizer:
        _sizer!.setDimension(WxPoint(x, y), WxSize(w, h));
        break;
      default:
        break;
    }
  }
}

// ------------------------- wxSizer ----------------------

/// Base class of all sizers. Sizers compute the minimal size of a set
/// of windows and arrange them within the space given to them.
///
/// The layout is computed in Dart; positions and sizes are then passed
/// to wxc.js. A window with a sizer lays out its children whenever its
/// size changes. Adding or removing items, showing or hiding windows and
/// changing labels schedule a new layout automatically (during idle
/// time); [layout] does it immediately.
///
/// ```dart
///   final sizer = WxBoxSizer(wxVERTICAL);
///   sizer.add(WxStaticText(this, -1, "Name:"), flag: wxLEFT|wxTOP, border: 10);
///   sizer.add(WxTextCtrl(this, -1), flag: wxEXPAND|wxALL, border: 10);
///   setSizerAndFit(sizer);
/// ```
class WxSizer extends WxObject {
  /// This class is abstract. Do not create it directly.
  WxSizer();

  final List<WxSizerItem> _items = [];
  WxWindow? _owningWindow;
  WxPoint _position = WxPoint.zero;
  WxSize _size = WxSize.zero;
  WxSize _minSize = wxDefaultSize;

  // ------------------------- to be overridden ----------------------

  /// Computes the minimal size needed by the items
  WxSize calcMin() {
    return WxSize.zero;
  }

  /// Arranges the items within [getPosition] and [getSize]
  void repositionChildren() {}

  /// Tells the sizer how much space it gets in [direction] (wxHORIZONTAL or
  /// wxVERTICAL) before its minimal size is computed, so that e.g. a
  /// [WxWrapSizer] knows where to wrap. Returns true if the information
  /// was used. The default implementation does nothing.
  bool informFirstDirection(int direction, int size, int availableOtherDir) {
    return false;
  }

  // ------------------------- size ----------------------

  /// The larger one of [calcMin] and the size set with [setMinSize]
  WxSize getMinSize() {
    final m = calcMin();
    return WxSize(max(m.x, _minSize.x), max(m.y, _minSize.y));
  }

  void setMinSize(WxSize size) {
    _minSize = size;
    _requestLayout();
  }

  /// Positions the sizer and arranges its items
  void setDimension(WxPoint pos, WxSize size) {
    _position = pos;
    _size = size;
    repositionChildren();
  }

  void setDimensionRect(WxRect rect) {
    setDimension(rect.getPosition(), rect.getSize());
  }

  /// Returns the current position of this sizer on the owning
  /// window, if known already.
  WxPoint getPosition() {
    return _position;
  }

  /// Returns the current size of this sizer, if known already.
  WxSize getSize() {
    return _size;
  }

  /// Tells the sizer to layout its children and update the
  /// screen.
  void layout() {
    final window = _owningWindow;
    if (window != null && window.getSizer() == this) {
      window.layout();
    } else {
      repositionChildren();
    }
  }

  /// Sets the window's client size to the minimal size of the sizer and
  /// returns the new window size.
  WxSize fit(WxWindow window) {
    window.setClientSize(getMinSize());
    return window.getSize();
  }

  /// Sets the minimal size of [window] to the minimal size of the sizer
  void setSizeHints(WxWindow window) {
    window.setMinSize(window.clientToWindowSize(getMinSize()));
  }

  WxWindow? getContainingWindow() {
    return _owningWindow;
  }

  // ------------------------- items ----------------------

  /// Returns the number of sizer items (either windows,
  /// child sizers or spaces).
  int getItemCount() {
    return _items.length;
  }

  List<WxSizerItem> getChildren() {
    return List<WxSizerItem>.unmodifiable(_items);
  }

  /// Returns the [WxSizerItem] at the position given by [index] or
  /// null if the index is our of bounds.
  WxSizerItem? getItem(int index) {
    if ((index < 0) || (index >= _items.length)) return null;
    return _items[index];
  }

  /// Returns the [WxSizerItem] that holds the [window] or
  /// null if not found.
  WxSizerItem? getWindowItem(WxWindow window) {
    for (final item in _items) {
      if (item._window == window) return item;
    }
    return null;
  }

  /// Returns the [WxSizerItem] that holds the [sizer] or
  /// null if not found.
  WxSizerItem? getSizerItem(WxSizer sizer) {
    for (final item in _items) {
      if (item._sizer == sizer) return item;
    }
    return null;
  }

  bool _hasShownItems() {
    for (final item in _items) {
      if (item.isShown()) return true;
    }
    return false;
  }

  void _testParentWindow(WxWindow window) {
    final owner = _owningWindow;
    if (owner != null && window.getParent() != owner) {
      wxLogError("$runtimeType has ${window.runtimeType} owned by wrong parent window");
    }
  }

  WxSizerItem _insertItem(int index, WxSizerItem item) {
    if (index < 0 || index > _items.length) index = _items.length;
    if (item._window != null) {
      if (getWindowItem(item._window!) != null) {
        wxLogError("$runtimeType: window already added");
      }
      _testParentWindow(item._window!);
      item._window!._containingSizer = this;
    }
    if (item._sizer != null) {
      if (getSizerItem(item._sizer!) != null) {
        wxLogError("$runtimeType: ${item._sizer.runtimeType} already added");
      }
      if (_owningWindow != null) item._sizer!._setOwningWindow(_owningWindow!);
    }
    _items.insert(index, item);
    _requestLayout();
    return item;
  }

  /// Adds a [window] with the
  /// given parameters that control aligment, stretch behaviour and borders.
  ///
  /// Returns the newly created [WxSizerItem]
  WxSizerItem add(WxWindow window, {int proportion = 0, int flag = 0, int border = 0}) {
    return _insertItem(-1, WxSizerItem._asWindow(window, proportion, flag, border));
  }

  /// Prepends a [window] with the
  /// given parameters that control aligment, stretch behaviour and borders.
  ///
  /// Returns the newly created [WxSizerItem]
  WxSizerItem prepend(WxWindow window, {int proportion = 0, int flag = 0, int border = 0}) {
    return _insertItem(0, WxSizerItem._asWindow(window, proportion, flag, border));
  }

  /// Inserts a [window] at the position given by [index] with the
  /// given parameters that control aligment, stretch behaviour and borders.
  ///
  /// Returns the newly created [WxSizerItem]
  WxSizerItem insert(int index, WxWindow window, {int proportion = 0, int flag = 0, int border = 0}) {
    return _insertItem(index, WxSizerItem._asWindow(window, proportion, flag, border));
  }

  /// Adds a sizer with the given parameters that control aligment,
  /// stretch behaviour and borders.
  ///
  /// Returns the newly created [WxSizerItem]
  WxSizerItem addSizer(WxSizer sizer, {int proportion = 0, int flag = 0, int border = 0}) {
    return _insertItem(-1, WxSizerItem._asSizer(sizer, proportion, flag, border));
  }

  /// Prepends a sizer with the given parameters that control aligment,
  /// stretch behaviour and borders.
  ///
  /// Returns the newly created [WxSizerItem]
  WxSizerItem prependSizer(WxSizer sizer, {int proportion = 0, int flag = 0, int border = 0}) {
    return _insertItem(0, WxSizerItem._asSizer(sizer, proportion, flag, border));
  }

  /// Inserts a [sizer] at the position given by [index] with the
  /// given parameters that control aligment, stretch behaviour and borders.
  ///
  /// Returns the newly created [WxSizerItem]
  WxSizerItem insertSizer(int index, WxSizer sizer, {int proportion = 0, int flag = 0, int border = 0}) {
    return _insertItem(index, WxSizerItem._asSizer(sizer, proportion, flag, border));
  }

  /// Adds a spacer with the given [size]
  ///
  /// Returns the newly created [WxSizerItem]
  WxSizerItem addSpacer(int size) {
    return _insertItem(-1, WxSizerItem._asSpacer(size, size));
  }

  /// Adds a spacer of the given width and height
  WxSizerItem addSpacerSize(int width, int height, {int proportion = 0, int flag = 0, int border = 0}) {
    final item = WxSizerItem._asSpacer(width, height);
    item._proportion = proportion;
    item._flag = flag;
    item._border = border;
    return _insertItem(-1, item);
  }

  /// Adds a stretchable spacer with the given relative proportion
  ///
  /// Returns the newly created [WxSizerItem]
  WxSizerItem addStretchSpacer({int prop = 1}) {
    final item = WxSizerItem._asSpacer(0, 0);
    item._proportion = prop;
    return _insertItem(-1, item);
  }

  /// Prepends a spacer with the given [size]
  ///
  /// Returns the newly created [WxSizerItem]
  WxSizerItem prependSpacer(int size) {
    return _insertItem(0, WxSizerItem._asSpacer(size, size));
  }

  /// Prepends a stretchable spacer with the given relative proportion
  ///
  /// Returns the newly created [WxSizerItem]
  WxSizerItem prependStretchSpacer({int prop = 1}) {
    final item = WxSizerItem._asSpacer(0, 0);
    item._proportion = prop;
    return _insertItem(0, item);
  }

  /// Inserts a spacer with the given [size] at the position given by [index]
  ///
  /// Returns the newly created [WxSizerItem]
  WxSizerItem insertSpacer(int index, int size) {
    return _insertItem(index, WxSizerItem._asSpacer(size, size));
  }

  /// Inserts a stretchable spacer with the given relative proportion at [index]
  ///
  /// Returns the newly created [WxSizerItem]
  WxSizerItem insertStretchSpacer(int index, {int prop = 1}) {
    final item = WxSizerItem._asSpacer(0, 0);
    item._proportion = prop;
    return _insertItem(index, item);
  }

  void _forgetItem(WxSizerItem item) {
    if (item._window != null && item._window!._containingSizer == this) {
      item._window!._containingSizer = null;
    }
  }

  /// Removes the item at the position given by [index] from the sizer.
  /// This does not actually destroy the window if the item is a window
  /// of if the item is a sizer containing windows.
  /// Call [WxWindow.destroy] to delete the windows and
  /// remove them from the parent window.
  ///
  /// Returns true on success.
  ///
  /// Assuming that item 0 is a window and you do want to destroy it
  /// ```dart
  ///  // Get the first [WxSizerItem]
  ///  final item = sizer.getItem(0);
  ///  // Get the window from it
  ///  final win = item!.getWindow();
  ///
  ///  // Now remove the first sizer item from the size
  ///  sizer.remove(0);
  ///
  ///  // Now destroy the window
  ///  win!.destroy();
  /// ```
  bool remove(int index) {
    if ((index < 0) || (index >= _items.length)) return false;
    _forgetItem(_items.removeAt(index));
    _requestLayout();
    return true;
  }

  /// Removes the [sizer] from the sizer and deletes [sizer]
  /// This does not actually destroy the windows handled by that
  /// sizer (if any) as they are owned by the parent window and they
  /// remain child windows of that parent window until they are
  /// deleted. Call [WxWindow.destroy] to delete the windows and
  /// remove them from the parent window.
  ///
  /// Returns true if [sizer] was found and removed.
  bool removeSizer(WxSizer sizer) {
    final item = getSizerItem(sizer);
    if (item == null) return false;
    _items.remove(item);
    _requestLayout();
    return true;
  }

  /// Removes the [window] from the sizer. This does not actually
  /// destroy the window as it is owned by the parent window and it
  /// remains a child window of that parent window until it is
  /// deleted. Call [WxWindow.destroy] to delete the window and
  /// remove it from the parent window.
  ///
  /// Returns true if [window] was found and removed.
  bool removeWindow(WxWindow window) {
    final item = getWindowItem(window);
    if (item == null) return false;
    _items.remove(item);
    _forgetItem(item);
    _requestLayout();
    return true;
  }

  /// Same as [removeWindow]
  bool detach(WxWindow window) {
    return removeWindow(window);
  }

  bool detachSizer(WxSizer sizer) {
    return removeSizer(sizer);
  }

  /// Removes all items, optionally destroying the windows
  void clear({bool deleteWindows = false}) {
    for (final item in List<WxSizerItem>.of(_items)) {
      _forgetItem(item);
      if (deleteWindows) {
        item._window?.destroy();
        item._sizer?.clear(deleteWindows: true);
      }
    }
    _items.clear();
    _requestLayout();
  }

  /// Shows or hides a window managed by this sizer (or a nested one)
  bool show(WxWindow window, {bool show = true}) {
    final item = _findWindowRecursive(window);
    if (item == null) return false;
    item.show(show);
    _requestLayout();
    return true;
  }

  bool hide(WxWindow window) {
    return show(window, show: false);
  }

  bool showSizer(WxSizer sizer, {bool show = true}) {
    final item = getSizerItem(sizer);
    if (item == null) return false;
    item.show(show);
    sizer.showItems(show);
    _requestLayout();
    return true;
  }

  void showItems(bool show) {
    for (final item in _items) {
      item.show(show);
      if (item._sizer != null) item._sizer!.showItems(show);
    }
    _requestLayout();
  }

  bool isShown(WxWindow window) {
    return _findWindowRecursive(window)?.isShown() ?? false;
  }

  WxSizerItem? _findWindowRecursive(WxWindow window) {
    for (final item in _items) {
      if (item._window == window) return item;
      if (item._sizer != null) {
        final found = item._sizer!._findWindowRecursive(window);
        if (found != null) return found;
      }
    }
    return null;
  }

  // ------------------------- owning window ----------------------

  void _setOwningWindow(WxWindow window) {
    _owningWindow = window;
    for (final item in _items) {
      if (item._sizer != null) item._sizer!._setOwningWindow(window);
      if (item._window != null) _testParentWindow(item._window!);
    }
  }

  void _requestLayout() {
    _owningWindow?._requestLayout();
  }

  /// Sets an item's dimension within a cell, respecting wxEXPAND and the
  /// alignment flags.
  void _placeInCell(WxSizerItem item, int x, int y, int cellWidth, int cellHeight) {
    final minSize = item.getMinSizeWithBorder();
    final flag = item.getFlag();
    int w = minSize.x, h = minSize.y;
    int dx = 0, dy = 0;
    if ((flag & wxEXPAND) != 0) {
      w = cellWidth;
      h = cellHeight;
    } else {
      if ((flag & wxALIGN_CENTER_HORIZONTAL) != 0) {
        dx = (cellWidth - w) ~/ 2;
      } else if ((flag & wxALIGN_RIGHT) != 0) {
        dx = cellWidth - w;
      }
      if ((flag & wxALIGN_CENTER_VERTICAL) != 0) {
        dy = (cellHeight - h) ~/ 2;
      } else if ((flag & wxALIGN_BOTTOM) != 0) {
        dy = cellHeight - h;
      }
    }
    item.setDimension(WxPoint(x + dx, y + dy), WxSize(w, h));
  }
}
