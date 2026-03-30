// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------ create a proxy render object to catch size ------

/// @nodoc

typedef OnWidgetSizeChange = void Function(Size contentSize);

/// @nodoc

class ReportSizeRenderObject extends RenderProxyBox {
  ReportSizeRenderObject(this.onSizeChange);
  final OnWidgetSizeChange onSizeChange;

  @override
  void performLayout() {
    super.performLayout();
    if (child == null) return;
    if (!child!.hasSize) return;
    if (child!.size.width.isNaN) return;
    if (child!.size.height.isNaN) return;
    if (child!.size.width.isInfinite) return;
    if (child!.size.height.isInfinite) return; 
    onSizeChange(child!.size);
  }
}

/// @nodoc

class ReportSize extends SingleChildRenderObjectWidget {
  final OnWidgetSizeChange onSizeChange;
  const ReportSize({
    super.key,
    required this.onSizeChange,
    required Widget child,
  }) : super(child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return ReportSizeRenderObject(onSizeChange);
  }
}

// ------------ WxCustomPainter --------------

/// @nodoc

class WxCustomPainter extends CustomPainter {

  WxCustomPainter( this.window, this.context );

  final WxWindow window;
  final BuildContext context;

  @override
  void paint(Canvas canvas, Size size)
  {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.clipRect(rect);
    window._canvas = canvas;
    window._canvasSize = size;
    window._context = context;
    WxPaintEvent event = WxPaintEvent(window);
    window.processEvent(event);
    window._canvas = null;
    window._context = null;
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

// ------------------------- wxWindow ----------------------

const int wxCENTRE = 0x0001;
const int wxCENTER = wxCENTRE;
const int wxCENTER_FRAME = 0x0000;
const int wxCENTRE_ON_SCREEN = 0x0002;
const int wxCENTER_ON_SCREEN = wxCENTRE_ON_SCREEN;
const int wxHORIZONTAL = 0x0004;
const int wxVERTICAL = 0x0008;
const int wxBOTH = wxVERTICAL | wxHORIZONTAL;
const int wxORIENTATION_MASK = wxBOTH;
const int wxBORDER_DEFAULT = 0;
const int wxBORDER_NONE = 0x00200000;
const int wxBORDER_STATIC = 0x01000000;
const int wxBORDER_SIMPLE = 0x02000000;
const int wxBORDER_RAISED = 0x04000000;
const int wxBORDER_SUNKEN = 0x08000000;
const int wxBORDER_DOUBLE = 0x10000000;
const int wxBORDER_THEME = wxBORDER_DOUBLE;
const int wxBORDER_MASK = 0x1f200000;
const int wxDEFAULT_CONTROL_BORDER = wxBORDER_SUNKEN;
const int wxVSCROLL = 0x80000000;
const int wxHSCROLL = 0x40000000;
const int wxCAPTION = 0x20000000;
const int wxALWAYS_SHOW_SB = 0x00800000;
const int wxTRANSLUCENT_WINDOW = 0x00100000;
const int wxTAB_TRAVERSAL = 0x00080000;
const int wxWANTS_CHARS = 0x00040000;
const int wxPOPUP_WINDOW = 0x00020000;
const int wxFULL_REPAINT_ON_RESIZE = 0x00010000;

const int wxBG_STYLE_ERASE = 0;
const int wxBG_STYLE_SYSTEM = 1;
const int wxBG_STYLE_PAINT = 2;
const int wxBG_STYLE_TRANSPARENT = 3;

const int wxTOUCH_NONE = 0;
const int wxTOUCH_HORIZONTAL_PAN_GESTURE = 0x0001;
const int wxTOUCH_VERTICAL_PAN_GESTURE = 0x0002;
const int wxTOUCH_PAN_GESTURES = wxTOUCH_VERTICAL_PAN_GESTURE | wxTOUCH_HORIZONTAL_PAN_GESTURE;
const int wxTOUCH_ZOOM_GESTURE = 0x0004;
const int wxTOUCH_ROTATE_GESTURE = 0x0008;
const int wxTOUCH_PRESS_GESTURES = 0x0010;
const int wxTOUCH_ALL_GESTURES = 0x001f;
const int wxTOUCH_RAW_EVENTS = 0x0020;

/// Main window class from which all window classes derive.
/// 
/// Some functions have no meaning in derived classes such as the scrolling
/// code for simple controls with no scrollbars. 
/// 
/// # Constants
/// 
/// These are used in the context of centering windows on screen or on 
/// other windows
/// 
/// | constant | value (meaning) |
/// | -------- | -------- |
/// | wxCENTRE | 0x0001 |
/// | wxCENTER | wxCENTRE |
/// | wxCENTER_FRAME | 0x0000 |
/// | wxCENTRE_ON_SCREEN | 0x0002 |
/// | wxCENTER_ON_SCREEN | wxCENTRE_ON_SCREEN |
/// 
/// These are used in the context of the orientation of windows
/// or items in sizer
/// 
/// | constant | value (meaning) |
/// | -------- | -------- |
/// | wxHORIZONTAL | 0x0004 |
/// | wxVERTICAL | 0x0008 |
/// | wxBOTH | wxVERTICAL | wxHORIZONTAL |
/// | wxORIENTATION_MASK | wxBOTH |
/// 
/// These are window flags or styles for many windows. Not all flags
/// or styles are supported in all windows or in all ports. Some of
/// the flags can be combined with others (which is why we cannot
/// use an enum in Dart). 
/// 
/// Window style have to be specified at window creation (mostly in 
/// the constructor) and usually cannot be change later on, at least
/// on some ports of wxDart.
/// 
/// | constant | value (meaning) |
/// | -------- | -------- |
/// | wxBORDER_DEFAULT | 0 (leave the decision to the platform ) |
/// | wxBORDER_NONE | 0x00200000 |
/// | wxBORDER_STATIC | 0x01000000 |
/// | wxBORDER_SIMPLE | 0x02000000 |
/// | wxBORDER_RAISED | 0x04000000 |
/// | wxBORDER_SUNKEN | 0x08000000 |
/// | wxBORDER_DOUBLE | 0x10000000 |
/// | wxBORDER_THEME | wxBORDER_DOUBLE |
/// | wxBORDER_MASK | 0x1f200000 |
/// | wxDEFAULT_CONTROL_BORDER | wxBORDER_SUNKEN |
/// | wxVSCROLL | 0x80000000 (use this flag to only allow vertical scrolling) |
/// | wxHSCROLL | 0x40000000 |
/// | wxCAPTION | 0x20000000 (mostly relevant for frame and dialog) |
/// | wxALWAYS_SHOW_SB | 0x00800000 (always show scrollbar, not supported on many platforms anymore) |
/// | wxTRANSLUCENT_WINDOW | 0x00100000 (special flag of translucent windows on macOS using NSVisualEffect) |
/// | wxTAB_TRAVERSAL | 0x00080000 |
/// | wxWANTS_CHARS | 0x00040000 (catch tab traversing characters) |
/// | wxPOPUP_WINDOW | 0x00020000 (a borderless window on top, usually dismissed with click outside) |
/// | wxFULL_REPAINT_ON_RESIZE | 0x00010000 (Repaint whole window when resizing, not just the parts uncovered) |
///
/// Flags for use with [setBackgroundStyle()]. Currently, wxDart sets these flags itself in the background
/// so this is for information only. In wxDart the background is always drawn into the window buffer. You
/// can paint over it, e.g. with a gradient or pure white.
///
/// | constant | value (meaning) |
/// | -------- | -------- |
/// | wxBG_STYLE_ERASE | 0 (disabled in wxDart) |
/// | wxBG_STYLE_SYSTEM | 1 (disabled in wxDart) |
/// | wxBG_STYLE_PAINT | 2 (the default in wxDart|
/// | wxBG_STYLE_TRANSPARENT | 3 (chosen for translucent windows) |

class WxWindow extends WxEvtHandler {
  WxWindow( this._parent, this._id, this._position, this._size, this._style )
  {
    if (_parent != null)
    {
      _parent!.addChild( this );
      if ((_position.x != -1) || (_position.y != -1))
      {
        if (_parent!._scrollOwnerWindow != null)
        {
          final xoff = _parent!._scrollOwnerWindow!.getDeviceOffsetX();
          final yoff = _parent!._scrollOwnerWindow!.getDeviceOffsetY();
          _position = WxPoint( _position.x + xoff, _position.y + yoff );
        }
      }
    }
    _initialSize = _size;

    if (_id == wxID_ANY) {
      _id = _wxNewControlId();
    }
  }

  final GlobalKey _widgetKey = GlobalKey();
  GlobalKey _getWidgetKey() {
    return _widgetKey;
  }

  final List<WxWindow> _children = [];
  final WxWindow? _parent;
  WxScrolledWindow? _scrollOwnerWindow;
  Canvas? _canvas;        // only valid during OnPaint();
  BuildContext? _context; // only valid during OnPaint();
  Size _canvasSize = Size.zero;

  List <WxEvtHandler>? _eventHandlers;

  WxPoint _position;
  WxSize _size;
  late WxSize _initialSize;
  int _id;
  int _style;
  int _touchEventMask = 0;
  bool _hidden = false;
  bool _disabled = false;
  bool _frozen = false;
  WxCursor ?_cursor;
  bool _captureMouse = false;
  WxSizer? _sizer;
  WxColour? _backgroundColour;
  WxColour? _foregroundColour;
  WxFont? _font;
  int _backgroundStyle = wxBG_STYLE_ERASE;
  bool _blockScrollEvents = false;
  WxSize _virtualSize = wxDefaultSize;
  Timer? _doubleClickTimer;
  bool _hasRecentlyClicked = false;
  bool _hasFocus2 = false; // 2 in order to avoid accidentally overriding it
  FocusNode? _focusNode;
  bool _lastButtonWasright = false;
  bool _isTwoDimensionalScrollView = false;
  int _counter = 0;
  WxWindow? _sliverView;

  @override
  void dispose() {
    _doubleClickTimer?.cancel();
    if (_focusNode != null) {
      _focusNode!.dispose();
    } 
    super.dispose();
  }

  /// Delete this window and remove it from the parent's child window list
  bool destroy() {
    if (_parent != null) {
      _parent!.removeChild(this);
    }
    dispose();
    return true;
  }

  /// Returns window with given [id] or null if not found
  WxWindow? findWindow( int id )
  {
    if (getId() == id) {
      return this;
    }
    WxWindow? res;
    for (final child in _children) {
      if (child is WxTopLevelWindow) continue;
      res = child.findWindow( id );
      if (res != null) {
        return res;
      }
    }
    return null;
  }

  /// Delete all child windows
  bool destroyChildren() {
    while (_children.isNotEmpty) {
      _children.first.destroy();
    }
    return true;
  }

  /// Returns window size minus border and scrollbar size, of present
  WxSize getClientSize() {
    // add border calculation
    return getSize();
  }
  /// Returns client area origin relative to window origin
  WxPoint getClientAreaOrigin() {
    // add border calculation
    return WxPoint(0,0);
  }
  /// Returns rectangle of window's client area
  WxRect getClientRect() {
    WxSize size = getClientSize();
    return WxRect( 0, 0, size.x, size.y );
  }

  /// Returns minimal size as determined by the system and/or
  /// the initial size
  WxSize getMinSize() {
    return _initialSize;
  }

  /// Returns the current actual size, if known aleady
  WxSize getSize() {
    return _size;
  }

  /// Set the size if the controls
  void setSize( WxSize size ) {
    _initialSize = size;
    _setSizeInternal( size );
    _setState();
  }

  void _setSizeInternal( WxSize size ) 
  {
    if (size == _size) return;
    if ((size.x < 1) || (size.y < 1)) return;
    _size = size;
    if (((_eventHandlers != null) || (_onSizeFunc != null))) {
        WxSizeEvent event = WxSizeEvent( _size, id: getId() );
        processEvent(event);
    }
    if (((_style & wxFULL_REPAINT_ON_RESIZE) != 0) &&
         ((_eventHandlers != null) || (_onPaintFunc != null))) {
          refresh();
    }
  }

  /// Instructs control to recalculate its best size
  void invalidateBestSize() {
  }

  /// Returns current position relative to parent window
  WxPoint getPosition() {
    if (getParent() == null) {
      return WxPoint(-1, -1);
    }
    final RenderObject? renderObject = _widgetKey.currentContext?.findRenderObject();
    if (renderObject == null) {
      return WxPoint(-1, -1);
    }
    final RenderObject? renderParentObject = getParent()!._widgetKey.currentContext?.findRenderObject();
    if (renderParentObject == null) {
      return WxPoint(-1, -1);
    }
    final RenderBox renderBox = renderObject as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero, ancestor: renderParentObject);
    if ((offset.dx.isNaN) || (offset.dx.isInfinite) || (offset.dy.isNaN) || (offset.dy.isInfinite)) {
      return WxPoint(-1, -1);
    }
    return WxPoint( offset.dx.floor(), offset.dy.floor());
  }

  /// Sets current position relative to parent window
  void setPosition( WxPoint pos ) {
    _position = pos;
    _setState();
    // wxMoveEvent
  }

  /// Returns the virtual size set by a scrolled window or the 
  /// client size which ever is bigger
  WxSize getVirtualSize()
  {
    final clientSize = getClientSize();
    return WxSize( max(clientSize.x,_virtualSize.x), max(clientSize.y,_virtualSize.y) ); 
  }

  /// Sets the virtual size of the client area in a scrolled window
  void setVirtualSize( WxSize size ) {
    _virtualSize = size;
  }

  /// Brings window to the front (among its window siblings)
  void raise()
  {
    if (_parent != null)
    {
      final children = _parent!._children;
      final index = children.indexOf(this);
      children.removeAt( index );
      children.insert( 0, this );
      _parent!._setState();
    }
  }

  /// Brings window to the back (among its window siblings)
  void lower()
  {
    if (_parent != null)
    {
      final children = _parent!._children;
      final index = children.indexOf(this);
      children.removeAt( index );
      children.add( this );
      _parent!._setState();
    }
  }

  /// Returns the area of the window that needs to get updated
  /// during a paint event handler. This will often return the
  /// entire client area.
  WxRect getUpdateClientRect() {
    WxSize size = getClientSize();
    return WxRect( 0, 0, size.x, size.y );
  }

  /// Apply the current DPI scale factor to [x]
  int fromDIP( int x ) {
    return x;
  }
  /// Apply the current DPI scale factor to [size]
  WxSize sizeFromDIP( WxSize size ) {
    return WxSize( size.x, size.y );
  }

  /// Returns the current DPI scale factor. This is 1.0 on normal screens
  /// and a value between 1.25 and 2.0 on larger screens (maybe more).
  double getDPIScaleFactor( ) {
    return 1.0;
  }

  /// Sets the font of the window. This can have different effects in different
  /// controls. Be careful with different default font sizes on different platforms.
  void setFont( WxFont? font ) {
    _font = font;
    _setState();
  }

  /// Returns the size if [text] when using the current font
  WxSize getTextExtent( String text )
  {
    TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: null), maxLines: 1, textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return WxSize( textPainter.size.width.floor(), textPainter.size.height.floor() );
  }

  /// Set the foreground colour of the window or control. This can have different
  /// meaning in different controls.
  void setForegroundColour( WxColour col ) {
    _foregroundColour = col;
    _setState();
  }
  /// Returns foreground colour
  WxColour getForegroundColour() {
    if (_foregroundColour == null) return wxTheApp.isDark() ? wxWHITE : wxBLACK;
    return _foregroundColour!;
  }
  /// Returns true if a specific, non-default, foreground colour has been
  /// specified.
  bool useForegroundColour( ) {
    return (_foregroundColour != null);
  }

  /// Set the background colour of the window or control. This can have different
  /// meaning in different controls.
  void setBackgroundColour( WxColour col ) {
    _backgroundColour = col;
    _setState();
  }
  /// Returns background colour
  WxColour getBackgroundColour() {
    if (_backgroundColour == null) return wxTheApp.isDark() ? WxColour(42,48,50) : wxWHITE;
    return _backgroundColour!;
  }
  /// Returns true if a specific, non-default, foreground colour has been
  /// specified.
  bool useBackgroundColour( ) {
    return (_backgroundColour != null);
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
  void setBackgroundStyle( int style ) {
    _backgroundStyle = style;
  }

/// Returns background style
  int getBackgroundStyle( ) {
    return _backgroundStyle;
  }

  void _setSliverView( WxWindow? sliverView ) {
    _sliverView = sliverView;
  }

  Widget _build( BuildContext context )
  {
    Widget child = _doBuildChildrenWithOrWithoutSizer( context ); 

    child = _doBuildSystemEventHandlers( context, child );

    if (_scrollOwnerWindow != null)
    {
      if (_scrollOwnerWindow!.hasFlag(wxVSCROLL) && !_scrollOwnerWindow!.hasFlag(wxHSCROLL))
      {
        if (_sliverView != null)
        {
          child = 
            NotificationListener<ScrollMetricsNotification>(
              onNotification: _handleScrollMetricsNotification,
                child: NotificationListener<ScrollNotification>(
                onNotification: _handleScrollNotification,
                child:
                    CustomScrollView(
                      slivers: [
                        _sliverView!._build( context ),
                        SliverToBoxAdapter(
                          child: SingleChildScrollView(
                            controller: _scrollOwnerWindow!._verticalController,
                            child: child )
                        )
                      ]
                    )
                ) 
              );
        }
        else
        {
          child = 
            NotificationListener<ScrollMetricsNotification>(
              onNotification: _handleScrollMetricsNotification,
                child: NotificationListener<ScrollNotification>(
                onNotification: _handleScrollNotification,
                child:
                  Scrollbar(
                    controller: _scrollOwnerWindow!._verticalController,
                    scrollbarOrientation: ScrollbarOrientation.right,
                    interactive: true,
                    thumbVisibility: true,
                    trackVisibility: true,
                    child: SingleChildScrollView(
                        controller: _scrollOwnerWindow!._verticalController,
                        child: child
                    ) ) ) 
              );
        }
      }
      else
      {
        _isTwoDimensionalScrollView = true;
        child = 
        NotificationListener<ScrollMetricsNotification>(
          onNotification: _handleScrollMetricsNotification,
            child: NotificationListener<ScrollNotification>(
            onNotification: _handleScrollNotification,
            child:
              Scrollbar(
                controller: _scrollOwnerWindow!._verticalController,
                scrollbarOrientation: ScrollbarOrientation.right,
                interactive: true,
                thumbVisibility: true,
                trackVisibility: true,
                child: Scrollbar(
                  controller: _scrollOwnerWindow!._horizontalController,
                  scrollbarOrientation: ScrollbarOrientation.bottom,
                  interactive: true,
                  thumbVisibility: true,
                  trackVisibility: true,
                  child: SingleChildTwoDimensionalScrollView(
                    verticalController: _scrollOwnerWindow!._verticalController,
                    horizontalController: _scrollOwnerWindow!._horizontalController,
                    diagonalDragBehavior: DiagonalDragBehavior.free,
                    child: child
                  ) ) ) 
                  ) );
      }
    } 

    child = _doBuildBackgroundAndBorder( context, child );

    child = _doBuildMouseEventHandler(context, child);

    child = _doBuildRadioButtonGroup(context, child);

    return _doBuildSizeEventHandler( context, child );
  }

  Widget _doBuildRadioButtonGroup( BuildContext context, Widget widget )
  {
    for (final child in _children)
    {
      if (child is WxRadioButton)
      {
        if (child.hasFlag(wxRB_GROUP ))
        {
          return  RadioGroup<int>( 
            groupValue: child._selection,
            onChanged: (value) {
              if (value != null)
              {
                child._selection = value;
                _setState();
                final subRadiobutton = child._getNthRadioButton( value );
                if (subRadiobutton != null)
                {
                  final event = WxCommandEvent( wxGetRadioButtonEventType(), subRadiobutton.getId() );
                  event.setEventObject(subRadiobutton);
                  event.setInt( 1 );
                  subRadiobutton.processEvent( event );
                }
              }
            },
            child: widget );
        }
      }
    }
    return widget;
  }

  bool _onlyVerticalScrolling() {
    return (hasFlag(wxVSCROLL) && !hasFlag(wxHSCROLL));
  }

  void scrollWindow( int dx, int dy )
  {
    if (_onlyVerticalScrolling()) 
    {
      if (_scrollOwnerWindow != null) {
        double voffset = _scrollOwnerWindow!._verticalController.offset + dy.toDouble();        
        _scrollOwnerWindow!._verticalController.jumpTo(voffset);
      }
    }
    else
    {
      if (_scrollOwnerWindow != null) {
        double voffset = _scrollOwnerWindow!._verticalController.offset + dy.toDouble();
        double hoffset = _scrollOwnerWindow!._horizontalController.offset + dx.toDouble();        
        _scrollOwnerWindow!._verticalController.jumpTo(voffset);
        _scrollOwnerWindow!._horizontalController.jumpTo(hoffset);
      }
    }
  }

  bool _isCoveredByChild( int x, int y )
  {
    final size = getSize();
    if ((size.x == -1) || (size.y == -1)) return false;
    if (_verticalScrollbarVisible()) {
      if (x > size.x - 15) {
        return true;
      }
    }
    if (_horizontalScrollbarVisible()) {
      if (y > size.y - 15) {
        return true;
      }
    }
    for (final WxWindow child in _children)
    {
      if (!child.isShown() || (child is WxTopLevelWindow)) continue;
      final extent = WxRect.fromPositionAndSize( child.getPosition(), child.getSize() );
      if (extent.isEmpty()) continue;
      if (extent.contains(x, y)) {
        return true;
      }
    }
    return false;
  }

  bool _verticalScrollbarVisible()
  {
    if (_scrollOwnerWindow != null) {
      if (_scrollOwnerWindow!._verticalController.position.maxScrollExtent.isNaN) return false;
      if (_scrollOwnerWindow!._verticalController.position.maxScrollExtent.isInfinite) return false;
      return (_scrollOwnerWindow!._verticalController.position.maxScrollExtent).floor() > 0;
    }
    return false;
  }

  bool _horizontalScrollbarVisible()
  {
    if (_scrollOwnerWindow != null) {
      if (_scrollOwnerWindow!._onlyVerticalScrolling()) return false;
      if (_scrollOwnerWindow!._horizontalController.position.maxScrollExtent.isNaN) return false;
      if (_scrollOwnerWindow!._horizontalController.position.maxScrollExtent.isInfinite) return false;
      return (_scrollOwnerWindow!._horizontalController.position.maxScrollExtent).floor() > 0;
    }
    return false;
  }

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

  void enableTouchEvents( int eventsMask ) {
    _touchEventMask = eventsMask;
    _setState();
  }

  static int gestureNone = 0;
  static int gesturePan = 1;
  static int gestureScale = 2;
  int _currentGesture = gestureNone;
  bool _isPanningAfterScaling = false;
  double _lastZoomGestureFactor = 1.0;
  WxPoint _lastPenGestureDelta = WxPoint.zero;
  double _accumulatedDeltaX = 0.0;
  double _accumulatedDeltaY = 0.0;

  Widget _doBuildMouseEventHandlerTouch( BuildContext context, Widget child )
  {
    child = GestureDetector( 
      onScaleStart: (ScaleStartDetails details)
      {
        // print("ScaleStartDetails, ${details.pointerCount}");

        // _currentScale = 1.0;
        if (details.pointerCount == 1) {
            _currentGesture = gesturePan;
            // Pan start
            final wxevent = WxPanGestureEvent(getId());
            wxevent.setEventObject( this );
            wxevent.setGestureStart();
            _lastPenGestureDelta = WxPoint.zero;
            _accumulatedDeltaX = 0.0;
            _accumulatedDeltaY = 0.0;
            wxevent.setDelta(_lastPenGestureDelta);
            if (_touchEventMask & wxTOUCH_PAN_GESTURES != 0) {
              processEvent( wxevent );
            }
        } else if (details.pointerCount == 2) {
            _currentGesture = gestureScale;
            // Scale start
            final wxevent = WxZoomGestureEvent(getId());
            wxevent.setEventObject( this );
            wxevent.setGestureStart();
            _lastZoomGestureFactor = 1.0;
            wxevent.setZoomFactor(_lastZoomGestureFactor);
            if (_touchEventMask & wxTOUCH_ZOOM_GESTURE != 0) {
              processEvent( wxevent );
            }
        } else {
            _currentGesture = gestureNone;
            // Nothing
        }
      },
      onScaleUpdate: (ScaleUpdateDetails details)
      {
        if (_currentGesture == gesturePan)
        {
          if (details.pointerCount != 1) {
            return;
          }
          // We are in a pan gesture
          if (_isPanningAfterScaling) {
            // skip first
            _isPanningAfterScaling = false;
            return;
          }
          _accumulatedDeltaX += details.focalPointDelta.dx;
          _accumulatedDeltaY += details.focalPointDelta.dy;
          final newPanGestureDelta = WxPoint( _accumulatedDeltaX.floor(), _accumulatedDeltaY.floor() );
          if ((newPanGestureDelta.x == _lastPenGestureDelta.x) && 
              (newPanGestureDelta.y == _lastPenGestureDelta.y)) {
                // no difference in rounded steps
                return;
          }
          final delta = WxPoint( newPanGestureDelta.x-_lastPenGestureDelta.x, newPanGestureDelta.y-_lastPenGestureDelta.y );
          _lastPenGestureDelta = WxPoint( _lastPenGestureDelta.x + delta.x, _lastPenGestureDelta.y + delta.y );
          final wxevent = WxPanGestureEvent(getId());
          wxevent.setEventObject( this );
          wxevent.setDelta(delta);
          if (_touchEventMask & wxTOUCH_PAN_GESTURES != 0) {
            processEvent( wxevent );
          }
        } 
        else if (_currentGesture == gestureScale)
        {
          if (details.pointerCount != 2) {
            return;
          }
          // We are in a scale gesture
          _lastZoomGestureFactor = details.scale;

          final wxevent = WxZoomGestureEvent(getId());
          wxevent.setEventObject( this );
          wxevent.setZoomFactor(_lastZoomGestureFactor);
          if (_touchEventMask & wxTOUCH_ZOOM_GESTURE != 0) {
            processEvent( wxevent );
          }
        }
      },
      onScaleEnd: (ScaleEndDetails details)
      {
        // WxFrame frame = wxTheApp.getTopWindow() as WxFrame;
        // frame.setStatusText("ScaleEndDetails, ${details.pointerCount}");

        if (_currentGesture == gesturePan)
        {
          // don't skip next pan
          _isPanningAfterScaling = false;

          final wxevent = WxPanGestureEvent(getId());
          wxevent.setEventObject( this );
          wxevent.setGestureEnd();
          if (_touchEventMask & wxTOUCH_PAN_GESTURES != 0) {
            processEvent( wxevent );
          }
        } else 
        if (_currentGesture == gestureScale)
        {
          // skip next pan
          _isPanningAfterScaling = true;

          final wxevent = WxZoomGestureEvent(getId());
          wxevent.setEventObject( this );
          wxevent.setGestureEnd();
          wxevent.setZoomFactor(_lastZoomGestureFactor);
          if (_touchEventMask & wxTOUCH_ZOOM_GESTURE != 0) {
            processEvent( wxevent );
          }
        } 
        else 
        {
          // How the hell did we get here?
          // print( "onScaleEnd, count ${details.pointerCount}" );
        }
        _currentGesture == gestureNone;
        _lastZoomGestureFactor = 1.0;
        _lastPenGestureDelta = WxPoint.zero;

      },
/*
      onTap: () {
      },
      onTapDown: (details)
      {
          if (_focusNode != null)
          {
              if (acceptsFocus() && (!_focusNode!.hasPrimaryFocus)) {
                
                for (int i = 0; i < _children.length; i++) {
                  final WxWindow child = _children[i];
                  if (!child.isShown()) continue;
                  if (child is WxTopLevelWindow) continue;
                  if (child.hasFocus()) {
                    // try to steal the focus from the child widget
                    // print( "Steal focus from: " );
                    // child.printName();
                    final event = WxFocusEvent( wxGetKillFocusEventType(), child.getId() );
                    event.setEventObject( child );
                    child.processEvent( event );
                    // leave here, we cannot remove the focus from more then one
                    // child window and quite likely, that one will get deleted
                    break;
                  }
                }
                _focusNode!.requestFocus();
              }
          }

          final wxevent = WxMouseEvent( wxGetLeftDownEventType() );
          wxevent.setEventObject( this );
          wxevent.setX( details.localPosition.dx.floor() ); 
          wxevent.setY( details.localPosition.dy.floor() ); 
          processEvent( wxevent );
      },
      onTapUp: (details) {
          final wxevent = WxMouseEvent( wxGetLeftUpEventType() );
          wxevent.setEventObject( this );
          wxevent.setX( details.localPosition.dx.floor() ); 
          wxevent.setY( details.localPosition.dy.floor() ); 
          processEvent( wxevent );
      },
      onDoubleTap: () {
      },
      onDoubleTapDown: (details) {
          final wxevent = WxMouseEvent( wxGetLeftDClickEventType() );
          wxevent.setEventObject( this );
          wxevent.setX( details.localPosition.dx.floor() ); 
          wxevent.setY( details.localPosition.dy.floor() ); 
          processEvent( wxevent );
      },
      onTapMove: (details) {
          final wxevent = WxMouseEvent( wxGetMotionEventType() );
          wxevent.setEventObject( this );
          wxevent.setX( details.localPosition.dx.floor() ); 
          wxevent.setY( details.localPosition.dy.floor() ); 
          processEvent(wxevent);
      },
*/
      child: child
    );

    return child;
  }

  Widget _doBuildMouseEventHandler( BuildContext context, Widget child )
  {
      if (_touchEventMask != 0) {
        return _doBuildMouseEventHandlerTouch( context, child );
      }

      MouseCursor cursor = MouseCursor.defer;
      if (_cursor != null) {
        switch (_cursor!.getStockCursor()) {
          case wxCURSOR_HAND: 
            cursor = SystemMouseCursors.click;
            break;
          case wxCURSOR_NO_ENTRY: 
            cursor = SystemMouseCursors.forbidden;
            break;
          case wxCURSOR_IBEAM: 
            cursor = SystemMouseCursors.text;
            break;
          case wxCURSOR_MAGNIFIER: 
            cursor = SystemMouseCursors.zoomIn;
            break;
          case wxCURSOR_QUESTION_ARROW: 
            cursor = SystemMouseCursors.help;
            break;
          case wxCURSOR_CROSS: 
          case wxCURSOR_BULLSEYE: 
            cursor = SystemMouseCursors.precise;
            break;
          case wxCURSOR_WAIT: 
            cursor = SystemMouseCursors.wait;
            break;
          case wxCURSOR_WATCH: 
            cursor = SystemMouseCursors.progress;
            break;
          case wxCURSOR_SIZENS: 
            cursor = SystemMouseCursors.resizeUpDown;
            break;
          case wxCURSOR_SIZEWE: 
            cursor = SystemMouseCursors.resizeLeftRight;
            break;
          case wxCURSOR_SIZENWSE: 
            cursor = SystemMouseCursors.resizeUpLeftDownRight;
            break;
          case wxCURSOR_SIZENESW: 
            cursor = SystemMouseCursors.resizeUpLeftDownRight;
            break;
          case wxCURSOR_SIZING:
            cursor = SystemMouseCursors.resizeUpLeftDownRight;
            break;
          default:
            cursor = SystemMouseCursors.basic;
            break;
        }
      }

      child = Listener(
        behavior: HitTestBehavior.deferToChild,
        onPointerSignal: (event)
        {
          if (event is PointerScrollEvent)
          {
            final x = event.localPosition.dx.floor();
            final y = event.localPosition.dy.floor();
            if (_isCoveredByChild(x,y)) return;
            // Ignore horizontal for the moment
            final rotation = ((event.scrollDelta.dy + 30)/30).floor() * 120;
            final wxevent = WxMouseEvent( wxGetMouseWheelEventType() );
            wxevent.setEventObject( this );
            wxevent.setX( x ); 
            wxevent.setY( y ); 
            wxevent._wheelRotation = rotation;
            processEvent(wxevent);
          }
        },
        onPointerHover: (event)
        {
          final x = event.localPosition.dx.floor();
          final y = event.localPosition.dy.floor();
          if (_isCoveredByChild(x,y)) return;
          final wxevent = WxMouseEvent( wxGetMotionEventType() );
          wxevent.setEventObject( this );
          wxevent.setX( x ); 
          wxevent.setY( y ); 
          processEvent(wxevent);
        },
        onPointerMove: (event) {
          final x = event.localPosition.dx.floor();
          final y = event.localPosition.dy.floor();
          if (_isCoveredByChild(x,y)) return;
          final wxevent = WxMouseEvent( wxGetMotionEventType() );
          wxevent.setEventObject( this );
          wxevent.setX( x ); 
          wxevent.setY( y ); 
          wxevent.setLeftDown( (event.buttons & kPrimaryMouseButton) != 0 );
          wxevent.setRightDown( (event.buttons & kSecondaryMouseButton) != 0 );
          wxevent.setMiddleDown( (event.buttons & kTertiaryButton) != 0 ); 
          processEvent(wxevent);
        },
        onPointerDown: (event)
        {
          final x = event.localPosition.dx.floor();
          final y = event.localPosition.dy.floor();
          if (_isCoveredByChild(x,y))
          {
            // print( "$_counter event eaten" );
            return;
          }

          if (_focusNode != null)
          {
              if (acceptsFocus() && (!_focusNode!.hasPrimaryFocus)) {
                
                for (int i = 0; i < _children.length; i++) {
                  final WxWindow child = _children[i];
                  if (!child.isShown()) continue;
                  if (child is WxTopLevelWindow) continue;
                  if (child.hasFocus()) {
                    // try to steal the focus from the child widget
                    // print( "Steal focus from: " );
                    // child.printName();
                    final event = WxFocusEvent( wxGetKillFocusEventType(), child.getId() );
                    event.setEventObject( child );
                    child.processEvent( event );
                    // leave here, we cannot remove the focus from more then one
                    // child window and quite likely, that one will get deleted
                    break;
                  }
                }
                _focusNode!.requestFocus();
              }
          }

          final wxevent = WxMouseEvent( wxGetLeftDownEventType() );
          if ((event.buttons & kSecondaryMouseButton) != 0) {
            wxevent.setEventType(wxGetRightDownEventType());
          } else 
          if ((event.buttons & kTertiaryButton) != 0) {
            wxevent.setEventType(wxGetMiddleDownEventType());
          }
          if (_hasRecentlyClicked) {
            _hasRecentlyClicked = false;
            _doubleClickTimer?.cancel();
            if (wxevent.getEventType() == wxGetLeftDownEventType()) {
              wxevent.setEventType(wxGetLeftDClickEventType());
            } else if (wxevent.getEventType() == wxGetRightDownEventType()) {
              wxevent.setEventType(wxGetRightDClickEventType());
            } else if (wxevent.getEventType() == wxGetMiddleDownEventType()) {
              wxevent.setEventType(wxGetMiddleDClickEventType());
            } 
          } else {
            _hasRecentlyClicked = true;
            _doubleClickTimer = Timer( const Duration(milliseconds: 500), () {
              _hasRecentlyClicked = false;
            });
          }

          wxevent.setEventObject( this );
          wxevent.setX( x ); 
          wxevent.setY( y ); 
          wxevent.setLeftDown( (event.buttons & kPrimaryMouseButton) != 0 );
          wxevent.setRightDown( (event.buttons & kSecondaryMouseButton) != 0 );
          wxevent.setMiddleDown( (event.buttons & kTertiaryButton) != 0 ); 
          if (wxevent.controlDown() && wxevent.leftDown())
          {
            // required for right mouse click on single button mice on Mac
            wxevent.setEventType(wxGetRightDownEventType());
            wxevent.setLeftDown(false);
            wxevent.setRightDown(true);
            _lastButtonWasright = true;
          } else {
            _lastButtonWasright = false;
          }
          processEvent(wxevent);
        },
        onPointerUp: (event)
        {
          final x = event.localPosition.dx.floor();
          final y = event.localPosition.dy.floor();
          if (_isCoveredByChild(x,y))
          {
            // print( "$_counter event eaten" );
            return;
          }
          final wxevent = WxMouseEvent( wxGetLeftUpEventType() );
          if ((event.buttons & kSecondaryMouseButton) != 0) {
            wxevent.setEventType(wxGetRightUpEventType());
          } else 
          if ((event.buttons & kTertiaryButton) != 0) {
            wxevent.setEventType(wxGetMiddleUpEventType());
          }
          wxevent.setEventObject( this );
          wxevent.setX( x ); 
          wxevent.setY( y ); 

          if (_lastButtonWasright)
          {
            // required for right mouse click on single button mice on Mac
            wxevent.setEventType(wxGetRightUpEventType());
          }
          _lastButtonWasright = false;

          processEvent(wxevent);
        },
        child: 

       MouseRegion(
        hitTestBehavior: _captureMouse ? HitTestBehavior.opaque : null,
        cursor: cursor,
        opaque: true,
        onEnter: (event) {
          final wxevent = WxMouseEvent( wxGetEnterWindowEventType() );
          wxevent.setEventObject( this );
          wxevent.setX( event.localPosition.dx.floor() ); 
          wxevent.setY( event.localPosition.dy.floor() ); 
          wxevent.setLeftDown( (event.buttons & kPrimaryMouseButton) != 0 );
          wxevent.setRightDown( (event.buttons & kSecondaryMouseButton) != 0 );
          wxevent.setMiddleDown( (event.buttons & kTertiaryButton) != 0 );
          processEvent(wxevent);
        },
        onExit: (event) {
          final wxevent = WxMouseEvent( wxGetLeaveWindowEventType() );
          wxevent.setEventObject( this );
          wxevent.setX( event.localPosition.dx.floor() ); 
          wxevent.setY( event.localPosition.dy.floor() ); 
          wxevent.setLeftDown( (event.buttons & kPrimaryMouseButton) != 0 );
          wxevent.setRightDown( (event.buttons & kSecondaryMouseButton) != 0 );
          wxevent.setMiddleDown( (event.buttons & kTertiaryButton) != 0 ); 
          processEvent(wxevent);
        },
        child: child
      ) );

      return child;
  }

  Widget _doBuildSizeEventHandler( BuildContext context, Widget child )
  {
    return ReportSize( 
      key: _widgetKey,
      child: child, 
      onSizeChange: (size) {
        _setSizeInternal( WxSize(size.width.floor(),size.height.floor()) );
      } 
    );
  }

  WxWindow? _findAncestorWithPrimaryFocus( WxWindow current )
  {
    if (current._focusNode != null) {
      if (current._focusNode!.hasPrimaryFocus) {
        return current;
      }
    }
    for (final child in current._children) {
      final pf = _findAncestorWithPrimaryFocus( child );
      if (pf != null) return pf;
    }
    return null;
  }

  Widget _doBuildSystemEventHandlers( BuildContext context, Widget child )
  {
    if ((_eventHandlers != null) || (_onPaintFunc != null)) {
      child = CustomPaint( painter: WxCustomPainter(this, context), child: child );
    }

    if (acceptsFocus())
    {
      _focusNode ??= FocusNode();
      final focusCtrl = Focus (
        focusNode: _focusNode,
        autofocus: false,
        onFocusChange: (enter) {
          if (enter) {
            _hasFocus2 = true;
            final event = WxFocusEvent( wxGetSetFocusEventType(), getId() );
            event.setEventObject( this );
            processEvent(event);
          } else {
            _hasFocus2 = false;
            final event = WxFocusEvent( wxGetKillFocusEventType(), getId() );
            event.setEventObject( this );
            processEvent(event);
          }
        },
        onKeyEvent: (node, event)
        {
          if (!_focusNode!.hasPrimaryFocus)
          {
            WxWindow? primaryFocus = _findAncestorWithPrimaryFocus(this);
            if (primaryFocus != null)
            {
              final wxevent = WxKeyEvent(wxGetKeyDownEventType());
              wxevent.setEventObject(primaryFocus);
              wxevent.setKeyCode( _getKeyCodeFromKeyEvent( event ) );
              if (primaryFocus.processEvent(wxevent)) {
                return KeyEventResult.handled;
              }
            }
            if (this is WxDialog) {
              if (event.logicalKey == LogicalKeyboardKey.escape) {
                final wxevent = WxCommandEvent( wxGetButtonEventType(), wxID_CANCEL );
                wxevent.setEventObject( this );
                if (processEvent(wxevent)) {
                  return KeyEventResult.handled;
                }
              } else 
              if (event.logicalKey == LogicalKeyboardKey.enter) {
                if (primaryFocus != null) {
                  if (primaryFocus.hasFlag(wxTE_PROCESS_ENTER)) {
                    return KeyEventResult.ignored;
                  }
                }
                final wxevent = WxCommandEvent( wxGetButtonEventType(), wxID_OK );
                wxevent.setEventObject( this );
                if (processEvent(wxevent)) {
                  return KeyEventResult.handled;
                }
              }

            }
            return KeyEventResult.ignored;
          }
          // int unicodeKey = _getUnicodeFromKeyEvent ( event );
          // int rawKeyCode = _getRawKeyFromKeyEvent( event );
          if (event is KeyDownEvent)
          {
            final wxevent = WxKeyEvent(wxGetKeyDownEventType());
            wxevent.setEventObject(this);
            wxevent.setKeyCode( _getKeyCodeFromKeyEvent( event ) );
            if (processEvent(wxevent)) {
              return KeyEventResult.handled;
            }
            wxevent.setEventType(wxGetCharEventType());
            if (processEvent(wxevent)) {
              return KeyEventResult.handled;
            }
          } else 
          if (event is KeyDownEvent)
          {
            final wxevent = WxKeyEvent(wxGetKeyUpEventType());
            wxevent.setEventObject(this);
            wxevent.setKeyCode( _getKeyCodeFromKeyEvent( event ) );
            if (processEvent(wxevent)) {
              return KeyEventResult.handled;
            }
          } if (event is KeyRepeatEvent) {
            final wxevent = WxKeyEvent(wxGetCharEventType());
            wxevent.setEventObject(this);
            wxevent.setKeyCode( _getKeyCodeFromKeyEvent( event ) );
            if (processEvent(wxevent)) {
              return KeyEventResult.handled;
            }
          }
          // return event.logicalKey == LogicalKeyboardKey.tab ? KeyEventResult.ignored : KeyEventResult.handled;
          return KeyEventResult.ignored;
        },
        child: child
      );

      child = focusCtrl;
    }

    return child;
  }

  Widget _doBuildBackgroundAndBorder( BuildContext context, Widget child )
  {
    
    if (_backgroundColour != null) {
      child = ColoredBox(color: 
      Color.fromARGB( _backgroundColour!.alpha, _backgroundColour!.red, 
                      _backgroundColour!.green, _backgroundColour!.blue), 
      child: child );
    }
    

    if ((_style & wxBORDER_SIMPLE) != 0) {
      child = DecoratedBox( 
        decoration: BoxDecoration(
           border: Border.all(
             width: 0.5,
             color: wxTheApp.isDark() ? Colors.grey : Colors.black,
             ) ),
        child: Padding(padding: EdgeInsetsGeometry.all(1), child: child ) );
    } else 
    if ((_style & wxBORDER_DOUBLE) != 0) {
      child = DecoratedBox( 
        decoration: BoxDecoration(
           border: Border.all( 
            width: 1.5,
            color: wxTheApp.isDark() ? Colors.grey : Colors.black,
             ) ),
        child: Padding(padding: EdgeInsetsGeometry.all(2), child: child ) );
    } 
    // do other borders ?

    if (_disabled) {
      child = AbsorbPointer(
        absorbing: true,
        child: Opacity(
          opacity: 0.4,
          child: child
      ) );
    }

    return child;
  }

  Widget _doBuildChildrenWithOrWithoutSizer( BuildContext context )
  {
    if (_sizer != null)
    {
      // WxSize clientSize = getClientSize();
      if ((_virtualSize.x > 0) || (_virtualSize.y > 0))
      {
        return _sizer!._build( context, this );
/*
        printName();
        print( "MyInfoPage _virtualSize ${_virtualSize.x},${_virtualSize.y}" );
        return SizedBox(  
           width: 500, // _virtualSize.x > 0 ? _virtualSize.x.toDouble() : 500,    // clientSize.x.toDouble(), 
           height: 500,
           // Ignore height as we assume the sizer will size vertically.
           // height: size.y > 0 ? size.y.toDouble() : clientSize.y.toDouble(), 
           child: _sizer!._build( context, this ) );
*/
/*
           child: Row( 
            mainAxisSize: MainAxisSize.min,
            children: [
              Text( "Text" ),
              Expanded( flex: 1, 
              child: Align( 
               alignment: const Alignment(0, -1.0),
               child: TextField() ) )
           ] ) );
*/
      }
      else
      {
        // the underlying SizedBox is added in WxSizer
        return _sizer!._build( context, this );
      }
    } 
    else 
    {
      return _doBuildChildrenNoSizer(context);
    }
  }

  Widget _doBuildChildrenNoSizer( BuildContext context )
  {
    final clientSize = getClientSize();

    // If setVirtualSize() has been called but the client area
    // is bigger than that, then stretch out to the entire clien
    // area using -1 here and double.infinity further down.
    int vX = _virtualSize.x;
    if (clientSize.x > vX) vX = -1;
    int vY = _virtualSize.y;
    if (clientSize.y > vY) vY = -1;

    // an explicit size given overrides everything
    int width = max(vX,_initialSize.x);
    int height = max(vY,_initialSize.y);

    if (_children.isEmpty)
    {
      return SizedBox(  
          width: width > 0 ? width.toDouble() : double.infinity, 
          height: height > 0 ? height.toDouble() : double.infinity );
    }

    if (/* (this is WxPanel) || */(this is WxTopLevelWindow))
    {
      int nonTLWs = 0;
      WxWindow? onlyChild;
      for (WxWindow child in _children) {
        if (child is WxTopLevelWindow) continue;
        if (!child.isShown())
        {
          // If there are hidden windows, don't try this
          nonTLWs = 0;
          break;
        } 
        nonTLWs++;
        onlyChild = child;
        if (nonTLWs == 2) break;
      }
      if (nonTLWs == 1) {
        return onlyChild!._build(context);
      }
    }

    Stack stack = Stack( children: <Widget>[] );
    for (WxWindow child in _children)
    {
      if (!child.isShown()) continue;
      if (child is WxTopLevelWindow) continue;
      WxPoint pos = child._position;  // don't use getPosition to avoid correction for scrolling
      WxSize childSize = child._initialSize;
        stack.children.add( 
          Positioned(
            top: pos.y.toDouble(),
            left: pos.x.toDouble(),
            width: childSize.x > 0 ? childSize.x.toDouble() : null,
            height: childSize.y > 0 ? childSize.y.toDouble() : null,
            child: child._build( context ) ) );
    }

    return SizedBox( 
        width: width > 0 ? width.toDouble() : double.infinity, 
        height: height > 0 ? height.toDouble() : double.infinity, 
        child: stack );
  }

  /// Used internally in parallel to [WxIdleEvent]s.
  void onInternalIdle() {
  }
  void _updateTheme() {
  }

  /// Shows a popup menu at the given [pos] or next to the mouse cursor. The
  /// menu entries will be updated using a [WxUpdateUIEvent] event before showing
  /// the actual menu.
  Future<bool> popupMenu( WxMenu menu, { WxPoint pos = wxDefaultPosition } ) async
  {
    BuildContext? context = _navigatorKey.currentContext;
    if (context == null) {
      wxLogError("No context to build popup menu" );
      return false;
    }

    menu.onInternalIdle();

    double x = pos.x.toDouble();
    double y = pos.y.toDouble();
    if (pos == wxDefaultPosition) {
      x = _globalMousePosition.x.toDouble();
      y = _globalMousePosition.y.toDouble();
    }

    final event = WxMenuEvent( wxGetMenuOpenEventType(), -1, menu: menu );
    event.setEventObject( menu ); 
    menu.processEvent(event);

    double right = MediaQuery.sizeOf(context).width - x;
    await showMenu( 
      position: RelativeRect.fromLTRB(x, y, right, 10),
      context: context, 
      shadowColor: wxTheApp._getSeedColor(),
      popUpAnimationStyle: AnimationStyle(
        duration: Duration()
      ),
      items: menu._buildPopMenu(context, this ) );

    final event2 = WxMenuEvent( wxGetMenuCloseEventType(), -1, menu: menu );
    event2.setEventObject( menu ); 
    menu.processEvent(event2);

    return true;
  }

  /// Sets the window to have the [cursor] or fall back to the default one
  void setCursor( WxCursor? cursor ) {
    _cursor = cursor;
    _setState();
  }

  /// Returns current cursor or null, if default one is used
  WxCursor? getCursor() {
    return _cursor;
  }

  /// If any [WxSizer] has been associated with this window, perform a layout.
  /// 
  /// The window or dialog will perform a layout when initially shown, but
  /// when something changes _after_ the window was shown, then you need
  /// to call layout in wxDart Native. In wxDart Flutter, the window layout
  /// will get updated automatically and this function will not do anything.
  void layout() {
    // do nothing
  }

  /// Associate [sizer] with this window
  void setSizer( WxSizer sizer ) {
    _sizer = sizer;
  }

  /// Returns the [WxSizer] currently associated with this window, or null
  WxSizer? getSizer() {
    return _sizer;
  }

  /// Associate [sizer] with this window and resize it to make it fit the 
  /// minimal constraints of it. Under wxDart Flutter, the fitting is automatically
  /// achieved by the Flutter layout mechanism. 
  void setSizerAndFit( WxSizer sizer ) {
    _sizer = sizer;
  }

  /// Returns the parent of this window, or null, if this window does not have
  /// a parent window (only possible toplevel windows) 
  WxWindow? getParent() {
    return _parent;
  }

  /// Returns the list of child window of this window
  List<WxWindow> getChildren() {
    return _children;
  }

  /// Adds [child] to the list of child windows of this window  
  void addChild( WxWindow child ) {
    _children.add( child );
  }

  /// Removes the [child] window from the list of child windows of this window  
  void removeChild( WxWindow child ) {
    _children.remove( child );
  }

  /// Show or hide window (depending on [show])
  void show( { bool show = true } )
  {
    _hidden = !show;
    if (_children.isNotEmpty && (show==false))
    {
      // required to not make TwoDimensionalScrollView crash with this:
      // flutter: Null check operator used on a null value
      // flutter: #0      RenderObject.invokeLayoutCallback (package:flutter/src/rendering/object.dart:2893)
      // flutter: #1      RenderTwoDimensionalViewport.performLayout (package:flutter/src/widgets/two_dimensional_viewport.dart:1252)
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _setState();
      });
    }
    else
    {
        _setState();
    }
  }

  /// Hide window
  void hide() {
    show( show: false );
  }

  /// Returns true if not hidden.
  /// 
  /// The window may still be hidden behind other windows or
  /// off-screen or not yet actually shown.
  bool isShown() {
    return !_hidden;
  }

  /// Returns true if enabled
  /// 
  /// see [enable] and [disable]
  bool isEnabled() {
    return !_disabled;
  }

  /// Enables the control (usually the default)
  /// 
  /// see [disable]
  void enable( { bool enable=true} ) {
    _disabled = !enable;
    _setState();
  }

  /// Disables the control (usually turn it grey)
  /// 
  /// see [enable]
  void disable() {
    enable( enable: false );
  }

  /// Refreshes window. If a batch of updates is happening, you
  /// may want to freeze and then thaw the window.
  /// 
  /// see [freeze] and [thaw]
  void refresh() {
    _setState();
  }

  void _setState() {
    if (!_frozen) {
       wxTheApp._setState();
    }
  }

  /// Stops updates to this window if a batch of updates occur
  /// 
  /// see [thaw]
  void freeze() {
    _frozen = true;
  }

  /// Updates window at the end of a batch of updates occur
  /// 
  /// see [freeze] and [isFrozen]
  void thaw() {
    _frozen = false;
    _setState();
  }

  /// Returns true if window doesn't update while in a batch
  /// of smaller updates
  /// 
  /// see [freeze] and [thaw]
  bool isFrozen() {
    return _frozen;
  }

  /// Returns true if window uses a backing store (double buffering against flicker)
  bool isRetained() {
    return true;
  }

  /// Returns ID of the window
  int getId() {
    return _id;
  }

  /// Sets the ID of the window
  void setId( int id ) {
    _id = id;
  }

  /// Captures mouse
  /// 
  /// see [releaseMouse] and [hasCapture]
  void captureMouse() {
    _captureMouse = true;
    _setState();
  }

  /// Releases mouse capture
  /// 
  /// see [captureMouse] and [hasCapture]
  void releaseMouse() {
    _captureMouse = false;
    _setState();
  }

  /// Returns true if mouse is being captured
  /// 
  /// see [captureMouse] and [releaseMouse]
  bool hasCapture() {
    return _captureMouse;
  }

  /// Tries to set the focus to this window/control
  void setFocus() {
    if (_focusNode != null) {
      if (!_hasFocus2) {
        _focusNode!.requestFocus();
      }
    } else {
      // Request focus before creation
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!_hasFocus2) {
          _focusNode!.requestFocus();
        }
      });
    }
  }

  /// Returns true if the window currently has the keyboard focus
  bool hasFocus() {
    return _hasFocus2;
  }

  /// Not implemented in wxDart yet
  bool isFocusable() {
    return acceptsFocus();
  }

  /// Not implemented in wxDart yet
  bool acceptsFocusFromKeyboard() { 
    return acceptsFocus();
  }

  /// Not implemented in wxDart yet
  bool acceptsFocus() {
    return true;
  }

  void _sendFocusEvents( bool enter ) 
  {
    _setState();
          if (enter) {
            _hasFocus2 = true;
            final event = WxFocusEvent( wxGetSetFocusEventType(), getId() );
            event.setEventObject( this );
            processEvent(event);
          } else {
            _hasFocus2 = false;
            final event = WxFocusEvent( wxGetKillFocusEventType(), getId() );
            event.setEventObject( this );
            processEvent(event);
          }
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
  bool hasFlag( int flag ) {
    return _style & flag != 0;
  }

  /// Sets window style/flag. Many style can only be
  /// created in the constructor of a control and have no effect when set later.
  /// 
  /// Same as [setWindowStyle]
  void setWindowStyleFlag( int style ) {
    _style = style;
    _setState();
  }

  /// Same as [setWindowStyleFlag]
  void setWindowStyle( int style ) {
    _style = style;
    _setState();
  }

  void printChildren() {
    for (WxWindow child in _children) {
      child.printName();
    }
  }

  // internal -----------------------

  /// Returns the x device offset relevant for scrolling
  int getDeviceOffsetX() {
    return 0; 
  }
  /// Returns the x device offset relevant for scrolling
  int getDeviceOffsetY() {
    return 0;
  }

  bool _handleScrollMetricsNotification(ScrollMetricsNotification notification) {
    // print( "ScrollMetricsNotification" );
    return false;
  }
  bool _handleScrollNotification(ScrollNotification notification) {
    if (_scrollOwnerWindow == null) return false;
    if (notification is ScrollEndNotification) {
      if (_blockScrollEvents) return false;
      // print( "End ScrollNotification" );
      _blockScrollEvents = true;
      _scrollOwnerWindow!._blockScrollEvents = true;

      /* int vPos = (_scrollOwnerWindow!.verticalController.offset / _pixelsPerUnitY).floor();
      _scrollOwnerWindow!.verticalController.jumpTo( (vPos*_pixelsPerUnitY).toDouble() );
      int hPos = (_scrollOwnerWindow!.horizontalController.offset / _pixelsPerUnitX).floor(); 
      _scrollOwnerWindow!.horizontalController.jumpTo( (hPos*_pixelsPerUnitX).toDouble() ); */

      _blockScrollEvents = false;
      _scrollOwnerWindow!._blockScrollEvents = false;
    }
    return false;
  }
}

/// helper functions

int _getUnicodeFromKeyEvent ( KeyEvent event ) 
{
  int unicode = 0;
  return unicode;
}

int _getKeyCodeFromKeyEvent( KeyEvent event )
{
  switch (event.logicalKey)
  {
    case LogicalKeyboardKey.arrowUp:          return WXK_UP;
    case LogicalKeyboardKey.arrowDown:        return WXK_DOWN;
    case LogicalKeyboardKey.arrowRight:       return WXK_RIGHT;
    case LogicalKeyboardKey.arrowLeft:        return WXK_LEFT;
    case LogicalKeyboardKey.space:            return WXK_SPACE;
    case LogicalKeyboardKey.enter:            return WXK_RETURN;
    case LogicalKeyboardKey.numpadEnter:      return WXK_RETURN;
    case LogicalKeyboardKey.home:             return WXK_HOME;
    case LogicalKeyboardKey.end:              return WXK_END;
    case LogicalKeyboardKey.pageUp:           return WXK_PAGEUP;
    case LogicalKeyboardKey.pageDown:         return WXK_PAGEDOWN;
    case LogicalKeyboardKey.add:              return WXK_ADD;
    case LogicalKeyboardKey.minus:            return WXK_SUBTRACT;
    case LogicalKeyboardKey.escape:           return WXK_ESCAPE;
    case LogicalKeyboardKey.backspace:        return WXK_BACK;
    case LogicalKeyboardKey.f1:               return WXK_F1;
    case LogicalKeyboardKey.f2:               return WXK_F2;
    case LogicalKeyboardKey.f3:               return WXK_F3;
    case LogicalKeyboardKey.f4:               return WXK_F4;
    case LogicalKeyboardKey.f5:               return WXK_F5;
    case LogicalKeyboardKey.f6:               return WXK_F6;
    case LogicalKeyboardKey.f7:               return WXK_F7;
    case LogicalKeyboardKey.f8:               return WXK_F8;
    case LogicalKeyboardKey.f9:               return WXK_F9;
    case LogicalKeyboardKey.f10:              return WXK_F10;
    case LogicalKeyboardKey.f11:              return WXK_F11;
    case LogicalKeyboardKey.f12:              return WXK_F12;

    case LogicalKeyboardKey.tab:              return WXK_TAB;
    case LogicalKeyboardKey.delete:           return WXK_DELETE;
    case LogicalKeyboardKey.insert:           return WXK_INSERT;

    case LogicalKeyboardKey.alt:              return WXK_ALT;
    case LogicalKeyboardKey.shift:            return WXK_SHIFT;
    case LogicalKeyboardKey.control:          return WXK_CONTROL;

    case LogicalKeyboardKey.exclamation:      return 33;
    case LogicalKeyboardKey.numberSign:       return 35;
    case LogicalKeyboardKey.dollar:           return 36;
    case LogicalKeyboardKey.percent:          return 37;
    case LogicalKeyboardKey.quoteSingle:      return 39;
    case LogicalKeyboardKey.backslash:        return 92;
    case LogicalKeyboardKey.braceLeft:        return 123;
    case LogicalKeyboardKey.braceRight:       return 125;
    case LogicalKeyboardKey.tilde:            return 126;
    case LogicalKeyboardKey.bracketLeft:      return 91;
    case LogicalKeyboardKey.bracketRight:     return 93;

    case LogicalKeyboardKey.comma:            return 44;
    case LogicalKeyboardKey.quote:            return 45;
    case LogicalKeyboardKey.period:           return 46;

    // case LogicalKeyboardKey.divide:           return 47;
    case LogicalKeyboardKey.digit0:           return 48;
    case LogicalKeyboardKey.digit1:           return 49;
    case LogicalKeyboardKey.digit2:           return 50;
    case LogicalKeyboardKey.digit3:           return 51;
    case LogicalKeyboardKey.digit4:           return 52;
    case LogicalKeyboardKey.digit5:           return 53;
    case LogicalKeyboardKey.digit6:           return 54;
    case LogicalKeyboardKey.digit7:           return 55;
    case LogicalKeyboardKey.digit8:           return 56;
    case LogicalKeyboardKey.digit9:           return 57;
    case LogicalKeyboardKey.colon:            return 58;
    case LogicalKeyboardKey.semicolon:        return 59;
    case LogicalKeyboardKey.less:             return 60;
    case LogicalKeyboardKey.equal:            return 61;
    case LogicalKeyboardKey.greater:          return 62;
    case LogicalKeyboardKey.question:         return 63;
    case LogicalKeyboardKey.at:               return 64;

    case LogicalKeyboardKey.keyA:             return 65;
    case LogicalKeyboardKey.keyB:             return 66;
    case LogicalKeyboardKey.keyC:             return 67;
    case LogicalKeyboardKey.keyD:             return 68;
    case LogicalKeyboardKey.keyE:             return 69;
    case LogicalKeyboardKey.keyF:             return 70;
    case LogicalKeyboardKey.keyG:             return 71;
    case LogicalKeyboardKey.keyH:             return 72;
    case LogicalKeyboardKey.keyI:             return 73;
    case LogicalKeyboardKey.keyJ:             return 74;
    case LogicalKeyboardKey.keyK:             return 75;
    case LogicalKeyboardKey.keyL:             return 76;
    case LogicalKeyboardKey.keyM:             return 77;
    case LogicalKeyboardKey.keyN:             return 78;
    case LogicalKeyboardKey.keyO:             return 79;
    case LogicalKeyboardKey.keyP:             return 80;
    case LogicalKeyboardKey.keyQ:             return 81;
    case LogicalKeyboardKey.keyR:             return 82;
    case LogicalKeyboardKey.keyS:             return 83;
    case LogicalKeyboardKey.keyT:             return 84;
    case LogicalKeyboardKey.keyU:             return 85;
    case LogicalKeyboardKey.keyV:             return 86;
    case LogicalKeyboardKey.keyW:             return 87;
    case LogicalKeyboardKey.keyX:             return 88;
    case LogicalKeyboardKey.keyY:             return 89;
    case LogicalKeyboardKey.keyZ:             return 90;

  }
  return WXK_NONE;
}

int _getRawKeyFromKeyEvent( KeyEvent event )
{
  int raw = _getKeyCodeFromKeyEvent(event);
  return raw;
}

