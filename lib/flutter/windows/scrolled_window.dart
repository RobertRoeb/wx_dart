// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxScrolledWindow ----------------------

/// Windows class that implements scrolling content in a virtual client area
/// using scrollbars, touch scrolling, the scroll wheel and/or track pad.
/// 
/// You can define the size of the scrollable (virtual) area either using
/// [setScrollbars] or [WxWindow.setVirtualSize].
/// 
/// On mobile platforms, but more and more commonly also on desktop screens,
/// it is common to allow vertical scrolling only and use [WxSizer]s to layout
/// controls. You need to use the wxVSCROLL flag in this case (see below) and
/// wxDart will take care of setting scrollbars and layout out the controls:
/// 
///```dart
///class MySizerWindow extends WxScrolledWindow {
///  MySizerWindow( WxWindow parent ) : super( parent, -1, style: wxVSCROLL )
///  {
///    final mainSizer = WxBoxSizer( wxVERTICAL );
///    setSizer( mainSizer );
///  }
///}
///```
/// 
/// You can use [setTargetWindow] to do the actual scrolling in a child
/// window. In wxDart Flutter, the scrollbars will appear in the actual
/// target window. In wxDart Native, the scrollbars will appear in the 
/// WxScrolledWindow (this window) on desktop platforms and on the target
/// window in iOS.
/// 
/// When drawing into a scrolled window, it is important to note that 
/// a [WxPaintDC] acts in unscrolled window coordinates. Also mouse coordinates
/// from [WxMouseEvent] and the coordinates of [WxWindow.getUpdateClientRect]
/// use unscrolled window coordinates.
/// 
/// When drawing into a window, adapt the coordinate system using
/// [WxScrolledWindow.doPrepareDC] like this.
/// 
/// ```dart
/// // Derive new class from WxWindow
/// class MyWindow extends WxScrolledWindow {
///   MyWindow( super.parent, super.id )
///   {
///     // Create scroll area of 600x2000 pixel
///     setScrollbars(10, 10, 60, 200 );
/// 
///     // Bind to paint event
///     bindPaintEvent(onPaint);
///   }
/// 
///   // define new paint event handler
///   void onPaint( WxPaintEvent event )
///   {
///     // create paint device context during paint event
///     final dc = WxPaintDC( this );
/// 
///     // adjust for scrolling
///     doPrepareDC(dc);
/// 
///     // draw a line
///     dc.drawLine( 10, 10, 100, 100 );
///   }
/// }
/// ```

class WxScrolledWindow extends WxWindow {

  /// Create window
  WxScrolledWindow( WxWindow parent, int id, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = wxTAB_TRAVERSAL } ) 
    : super( parent, id, pos, size, style )
  {
    _scrollTargetWindow = this;
    _scrollOwnerWindow = this;

    if (!_onlyVerticalScrolling()) {
      _horizontalController.addListener(_handleHorizontalControllerNotification );
    }
    _verticalController.addListener(_handleVerticalControllerNotification );
  }

  late WxWindow _scrollTargetWindow;

  int _pixelsPerUnitX = 0;
  int _pixelsPerUnitY = 0;

  bool _useInitialScrollPos = true;  // until widget has been built
  int _initialScrollPosX = 0;
  int _initialScrollPosY = 0;

  final ScrollController _horizontalController = ScrollController();
  final ScrollController _verticalController = ScrollController();

  /// Set size and set up scrollbars
  @override
  void setSizer( WxSizer sizer )
  {
    super.setSizer( sizer );
    setScrollbars( 10, 10, 0, 0 );
  }

  /// Instructs to do scrolling on child window, not this window itself.
  void setTargetWindow( WxWindow target )
  {
    _scrollTargetWindow = target;
    target._scrollOwnerWindow = this;
    _scrollOwnerWindow = null; // don't scroll yourself anymore
    _setState();
  }

  /// Sets up scroll area and scrollbars. The size of the scroll area will
  /// be the product of [noUnitsX] and [pixelsPerUnitX] horizontally and
  /// the equivalent for the Y-axis. [xPos] and [yPos] define the intial
  /// scroll positions in units, not pixels.
  void setScrollbars( int pixelsPerUnitX, int pixelsPerUnitY, 
                 int noUnitsX, int noUnitsY,
                 { int xPos = 0, int yPos = 0, bool noRefresh = false } )
  {  
    _pixelsPerUnitX = pixelsPerUnitX;
    _pixelsPerUnitY = pixelsPerUnitY;
    _scrollTargetWindow.setVirtualSize( 
      WxSize( _pixelsPerUnitX*noUnitsX, _pixelsPerUnitY*noUnitsY ) );
    // = xPos;  // jumpTo ?
    // = yPos;
    if (_sizer == null) {
      // this causes an endless loop if a sizer is there
      _setState();
    }
  }

  /// Scroll [x] and [y] number of units (not pixels)
  void scroll( int x, int y )
  {
    if (x != -1) {
      _horizontalController.jumpTo( (x * _pixelsPerUnitX).toDouble() );
    }
    if (y != -1) {
      _verticalController.jumpTo( (y * _pixelsPerUnitY).toDouble() );
    }
  }

  /// Returns the view start (how much has been scrolled) in units, not pixels
  WxPoint getViewStart( ) {
    final viewstart = getViewStartPixels();
    return WxPoint( viewstart.x ~/ _pixelsPerUnitX, viewstart.y ~/ _pixelsPerUnitY );
  }

  /// Returns the view start (how much has been scrolled) in pixels
  WxPoint getViewStartPixels( )
  {
    if (_onlyVerticalScrolling()) {
      return WxPoint( 0, _verticalController.offset.floor() );
    } else {
      return WxPoint( _horizontalController.offset.floor(), _verticalController.offset.floor() );
    }
  }

  /// Sets the size of scroll units (pixels per scroll step)
  void setScrollRate( int pixelsPerUnitX, int pixelsPerUnitY ) {
    _pixelsPerUnitX = pixelsPerUnitX;
    _pixelsPerUnitY = pixelsPerUnitY;
  }

  /// Returns number of pixels per horizontal scroll step
  int getScrollPixelsPerUnitX() {
    return _pixelsPerUnitX;
  }

  /// Returns number of pixels per vertical scroll step
  int getScrollPixelsPerUnitY() {
    return _pixelsPerUnitY;
  }

  /// Transforms window coordinates to scrolled coordinates 
  WxPoint calcScrolledPosition( WxPoint pt)
  {
    if (_onlyVerticalScrolling())
    {
      return WxPoint(
        pt.x, 
        pt.y-_verticalController.offset.floor() );
    }
    else
    {
      return WxPoint(
        pt.x-_horizontalController.offset.floor(), 
        pt.y-_verticalController.offset.floor() );
    }
  }

  /// Transforms scrolled coordinates to window coordinates 
  WxPoint calcUnscrolledPosition( WxPoint pt)
  {
    if (_onlyVerticalScrolling())
    {
      return WxPoint(
        pt.x, 
        pt.y+_verticalController.offset.floor() );
    }
    else
    {
      return WxPoint(
        pt.x+_horizontalController.offset.floor(), 
        pt.y+_verticalController.offset.floor() );
    }
  }

  /// Returns origin of the client area
  WxPoint getClientOrigin() {
    return WxPoint( 0, 0 );
  }

  /// Adapts the [dc] to the amount scrolled
  void doPrepareDC( WxDC dc )
  {
    if (_onlyVerticalScrolling())
    {
      dc.setDeviceOrigin(
        0,
        -_verticalController.offset.floor() );
    }
    else
    {
      dc.setDeviceOrigin(
        -_horizontalController.offset.floor(), 
        -_verticalController.offset.floor() );
    }
  }

  // internal 

  void _handleHorizontalControllerNotification()
  {
    if (_blockScrollEvents) return;
    if (_onlyVerticalScrolling()) return; // can this happen?
    if (getVirtualSize().x < 2) return;
    final offset = _horizontalController.offset;
    int hPos = (offset / _pixelsPerUnitX).floor();
    WxScrollWinEvent event = WxScrollWinEvent(wxGetScrollWinThumbTrackEventType(), 
      orientation: wxHORIZONTAL, position: hPos );
    event.setPixelOffset(offset.floor() % _pixelsPerUnitX);
    processEvent(event);
    _setState();
  }
  void _handleVerticalControllerNotification()
  {
    if (_blockScrollEvents) return;
    if (getVirtualSize().y < 2) return;
    final offset = _verticalController.offset;
    int vPos = (offset / _pixelsPerUnitY).floor();
    WxScrollWinEvent event = WxScrollWinEvent(wxGetScrollWinThumbTrackEventType(), 
      orientation: wxVERTICAL, position: vPos );
    event.setPixelOffset(offset.floor() % _pixelsPerUnitY);
    processEvent(event);
    _setState();
  }

  /// Returns device offset, identical to view start 
  @override
  int getDeviceOffsetX()
  {
    if (_useInitialScrollPos) {
      return _initialScrollPosX;
    }
    if (_onlyVerticalScrolling()) {
      return 0;
    }
    return _horizontalController.offset.floor();
  }

  /// Returns device offset, identical to view start 
  @override
  int getDeviceOffsetY()
  {
      if (_useInitialScrollPos) {
      return _initialScrollPosY;
    }
    return _verticalController.offset.floor();
  }

  @override
  Widget _build(BuildContext context)
  {
    _useInitialScrollPos = false;  // use scrollcontrollers from now on
    if (_scrollTargetWindow == this) {
      return super._build( context );
    }

    Widget child = _doBuildChildrenWithOrWithoutSizer(context);

    child = _doBuildSystemEventHandlers(context, child);

    child = _doBuildBackgroundAndBorder(context, child);

    return _doBuildSizeEventHandler(context, child);
  }
}
