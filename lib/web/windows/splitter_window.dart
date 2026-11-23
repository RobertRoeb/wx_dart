// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01 (wxDart Web: 2026-11-15)
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxSplitterEvent ----------------------

// ------------------------- wxSplitterWindow ----------------------

const int wxSP_NOBORDER = 0x0000;
const int wxSP_THIN_SASH = 0x0000;
const int wxSP_NOSASH = 0x0010;
const int wxSP_PERMIT_UNSPLIT = 0x0040;
const int wxSP_LIVE_UPDATE = 0x0080;
const int wxSP_3DSASH = 0x0100;
const int wxSP_3DBORDER = 0x0200;
const int wxSP_NO_XP_THEME = 0x0400;
const int wxSP_BORDER = wxSP_3DBORDER;
const int wxSP_3D = (wxSP_3DBORDER | wxSP_3DSASH);

const int wxSPLIT_HORIZONTAL = 1;
const int wxSPLIT_VERTICAL = 2;

// ------------------------- wxSplitterWindow ----------------------

/// This class manages up to two subwindows. The current view can be split
/// either horizontally or vertically. 
/// 
/// The user can change the dimensions of the two windows by dragging the
/// splitter sash around. If the wxSP_PERMIT_UNSPLIT flag is set, then the
/// user can unsplit the window, i.e. one window gets hidden. 
/// 
/// Main interface:
/// * [splitVertically]
/// * [splitHorizontally]
/// * [setSashPosition]
/// * [setMinimumPaneSize]
/// 
/// Example usage with user unsplitting:
/// ```dart
///class MyMainWindow extends WxSplitterWindow
///{
///  MyMainWindow( MyFrame parent ) : super( parent, -1, style: wxSP_LIVE_UPDATE|wxSP_PERMIT_UNSPLIT )
///  {
///    // Create two windows
///    _leftWindow = MyWindow(this);
///    _rightWindow = MyWindow(this);
///
///    // Tell WxSplitterWindow how to split them
///    splitVertically(_leftWindow, _rightWindow);
///
///    // Set initial split/sash position
///    setSashPosition(450);
///
///    bindSplitterUnsplitEvent( (_) {
///      // User unsplit, do something.
///    }, -1 );
///  }
///
///  late MyWindow _leftWindow;
///  late MyWindow _rightWindow;
///}
///```
///
/// Example usage without user unsplitting:
/// ```dart
///class MyMainWindow extends WxSplitterWindow
///{
///  MyMainWindow( MyFrame parent ) : super( parent, -1, style: wxSP_LIVE_UPDATE|wxSP_3DSASH )
///  {
///    // Create two windows
///    _leftWindow = MyWindow(this);
///    _rightWindow = MyWindow(this);
///
///    // Tell WxSplitterWindow how to split them
///    splitVertically(_leftWindow, _rightWindow);
///
///    // Set minumum size
///    setMinimumPaneSize(100);
///
///    // Set initial split/sash position
///    setSashPosition(450);
///  }
///
///  late MyWindow _leftWindow;
///  late MyWindow _rightWindow;
///}
///```
///
/// # Events emitted
/// [SplitterSashPosChanging](/wxdart/wxGetSplitterSashPosChangingEventType.html) event gets sent when the user drags the sash. |
/// | ----------------- |
/// | void bindSplitterSashPosChangingEvent( void function( [WxSplitterEvent] event ) ) |
/// | void unbindSplitterSashPosChangingEvent() |
/// [SplitterSashPosChanged](/wxdart/wxGetSplitterSashPosChangedEventType.html) event gets sent when the drag is finished. |
/// | ----------------- |
/// | void bindSplitterSashPosChangedEvent( void function( [WxSplitterEvent] event ) ) |
/// | void unbindSplitterSashPosChangedEvent() |
/// [SplitterUnsplit](/wxdart/wxGetSplitterUnsplitEventType.html) event gets sent when user ended the split. |
/// | ----------------- |
/// | void bindSplitterUnsplitEvent( void function( [WxSplitterEvent] event ) ) |
/// | void unbindSplitterUnsplitEvent() |
/// [SplitterDoubleClick](/wxdart/wxGetSplitterDoubleClickEventType.html) event gets sent when the user double clicks on the sash |
/// | ----------------- |
/// | void bindSplitterDoubleClickEvent( void function( [WxSplitterEvent] event ) ) |
/// | void unbindSplitterDoubleClickEvent() |
/// 
/// # Window styles
/// | constant | meaning |
/// | -------- | -------- |
/// | wxSP_NOBORDER | 0x0000 |
/// | wxSP_THIN_SASH | 0x0000 |
/// | wxSP_NOSASH | 0x0010 |
/// | wxSP_PERMIT_UNSPLIT | 0x0040 |
/// | wxSP_LIVE_UPDATE | 0x0080 |
/// | wxSP_3DSASH | 0x0100 |
/// | wxSP_3DBORDER | 0x0200 |
/// | wxSP_BORDER | wxSP_3DBORDER |
/// | wxSP_3D | (wxSP_3DBORDER | wxSP_3DSASH) |

class WxSplitterWindow extends WxWindow {
  /// Creates the splitter window. Call [splitHorizontally] or [splitVertically] afterwards
  WxSplitterWindow( WxWindow parent, int id, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = wxSP_3D } ) :
    super( parent, id, pos, size, style )
  {
    bindPaintEvent( _onPaint );
    bindLeftDownEvent( _onLeftDown );
    bindMotionEvent( _onMotion );
    bindLeftUpEvent( _onLeftUp );
    bindLeftDClickEvent( _onDClick );
  }

  WxWindow? _window1;
  WxWindow? _window2;
  int _splitMode = wxSPLIT_VERTICAL;
  bool _isSplit = false;
  int _minimumPaneSize = 0;
  int _requestedPos = 0;      // as given: > 0 from left/top, < 0 from right/bottom, 0 middle
  int _pos = -1;              // actual position of the sash (left/top edge)
  double _gravity = 0.0;
  bool _sashInvisible = false;
  bool _dragging = false;
  int _dragOffset = 0;
  int _posBeforeDrag = 0;
  WxSize _lastSize = WxSize.zero;

  static const int _kSashSize = 6;

  // ---------------- geometry

  bool get _vertical => _splitMode == wxSPLIT_VERTICAL;

  /// Thickness of the sash
  int getSashSize( ) {
    if (_sashInvisible || hasFlag( wxSP_NOSASH )) return 0;
    return _kSashSize;
  }

  int _length() {
    final size = getClientSize();
    return _vertical ? size.x : size.y;
  }

  int _clamp( int pos ) {
    final length = _length();
    final minPane = max( _minimumPaneSize, 0 );
    final hi = length - getSashSize() - minPane;
    if (hi < minPane) return max( 0, length ~/ 2 - getSashSize() ~/ 2 );
    return pos.clamp( minPane, hi );
  }

  int _resolve( int requested ) {
    final length = _length();
    if (requested > 0) return requested;
    if (requested < 0) return length + requested - getSashSize();
    return (length - getSashSize()) ~/ 2;
  }

  void _layoutWindows() {
    final size = getClientSize();
    if (size.x <= 0 || size.y <= 0) return;
    if (!_isSplit) {
      final only = _window1 ?? _window2;
      if (only != null) only._setActualRect( 0, 0, size.x, size.y );
      return;
    }
    if (_pos < 0) _pos = _clamp( _resolve( _requestedPos ) );
    final sash = getSashSize();
    if (_vertical) {
      _window1!._setActualRect( 0, 0, _pos, size.y );
      _window2!._setActualRect( _pos + sash, 0, max( 0, size.x - _pos - sash ), size.y );
    } else {
      _window1!._setActualRect( 0, 0, size.x, _pos );
      _window2!._setActualRect( 0, _pos + sash, size.x, max( 0, size.y - _pos - sash ) );
    }
  }

  @override
  void _sendSizeEvent() {
    final size = getClientSize();
    if (_isSplit && _pos >= 0 && _lastSize != WxSize.zero) {
      // the gravity decides which window gets the extra space
      final delta = _vertical ? size.x - _lastSize.x : size.y - _lastSize.y;
      _pos = _clamp( _pos + (delta * _gravity).round() );
    }
    _lastSize = size;
    _layoutWindows();
    refresh();
    super._sendSizeEvent();
  }

  /// Passes the size on to the windows, in the direction in which they
  /// are not side by side (in the other one, their share is not known yet)
  @override
  bool informFirstDirection( int direction, int size, int availableOtherDir ) {
    if (size < 0) return false;
    if (_isSplit && (direction == wxHORIZONTAL) == _vertical) return false;
    bool used = false;
    used |= _window1?.informFirstDirection( direction, size, -1 ) ?? false;
    used |= _window2?.informFirstDirection( direction, size, -1 ) ?? false;
    if (used) _bestSize = null;
    return used;
  }

  @override
  WxSize _doGetBestSize() {
    final w1 = _window1?.getEffectiveMinSize() ?? WxSize.zero;
    final w2 = _window2?.getEffectiveMinSize() ?? WxSize.zero;
    if (!_isSplit) {
      final only = _window1 ?? _window2;
      final s = only?.getEffectiveMinSize() ?? const WxSize( 100, 100 );
      return WxSize( max( s.x, 20 ), max( s.y, 20 ) );
    }
    if (_vertical) {
      return WxSize( w1.x + w2.x + getSashSize(), max( w1.y, w2.y ) );
    }
    return WxSize( max( w1.x, w2.x ), w1.y + w2.y + getSashSize() );
  }

  // ---------------- API

  /// Shows only [window] (unsplit)
  void initialize( WxWindow window ) {
    _window1 = window;
    _window2 = null;
    _isSplit = false;
    window.show();
    _layoutWindows();
  }

  bool _split( WxWindow window1, WxWindow window2, int sashPosition, int mode ) {
    if (_isSplit) return false;
    _window1 = window1;
    _window2 = window2;
    _splitMode = mode;
    _isSplit = true;
    _requestedPos = sashPosition;
    _pos = -1;
    window1.show();
    window2.show();
    setCursor( WxCursor( _vertical ? wxCURSOR_SIZEWE : wxCURSOR_SIZENS ) );
    invalidateBestSize();
    _layoutWindows();
    refresh();
    return true;
  }

  /// Split the window horizontally with the two child windows [window1],[window2] at position [sashPosition]
  bool splitHorizontally( WxWindow window1, WxWindow window2, { int sashPosition = 0 } ) {
    return _split( window1, window2, sashPosition, wxSPLIT_HORIZONTAL );
  }

  /// Split the window vertically with the two child windows [window1],[window2] at position [sashPosition]
  bool splitVertically( WxWindow window1, WxWindow window2, { int sashPosition = 0 } ) {
    return _split( window1, window2, sashPosition, wxSPLIT_VERTICAL );
  }

  /// Unsplit the splitter window, removing [toRemove] from the splitter without actually deleting it
  bool unsplit( { WxWindow? toRemove } ) {
    if (!_isSplit) return false;
    final removed = toRemove ?? _window2;
    if (removed != _window1 && removed != _window2) return false;
    final event = WxSplitterEvent( wxGetSplitterUnsplitEventType(), getId() );
    event._windowBeingRemoved = removed;
    event.setEventObject( this );
    processEvent( event );
    removed!.hide();
    if (removed == _window1) {
      _window1 = _window2;
    }
    _window2 = null;
    _isSplit = false;
    setCursor( null );
    invalidateBestSize();
    _layoutWindows();
    refresh();
    return true;
  }

  /// Replaces [winOld] by [winNew], keeping the sash position
  bool replaceWindow( WxWindow winOld, WxWindow winNew ) {
    if (winOld == _window1) {
      _window1 = winNew;
    } else if (winOld == _window2) {
      _window2 = winNew;
    } else {
      return false;
    }
    winNew.show();
    _layoutWindows();
    return true;
  }

  WxWindow? getWindow1( ) {
    return _window1;
  }

  WxWindow? getWindow2( ) {
    return _window2;
  }

  /// Returns wxSPLIT_VERTICAL or wxSPLIT_HORIZONTAL
  int getSplitMode( ) {
    return _splitMode;
  }

  void setSplitMode( int mode ) {
    _splitMode = mode;
    _pos = -1;
    _layoutWindows();
    refresh();
  }

  /// Set the minimum size of the two panes (currently not supported in wxDart Flutter)
  void setMinimumPaneSize( int paneSize ) {
    _minimumPaneSize = paneSize;
    if (_pos >= 0) _pos = _clamp( _pos );
    _layoutWindows();
  }

  int getMinimumPaneSize( ) {
    return _minimumPaneSize;
  }

  /// Returns true, if the window is split
  bool isSplit( ) {
    return _isSplit;
  }

  /// Returns true of the sash is invisible even if the window
  /// is currently split.
  bool isSashInvisible( ) {
    return _sashInvisible;
  }

  /// Makes the sash invisible (or visible, depending on [invisible])
  ///
  /// If invisible, it is impossible for the user to resize the windows.
  void setSashInvisible( { bool invisible = true } )
  {
    _sashInvisible = invisible;
    if (_pos >= 0) _pos = _clamp( _pos );
    _layoutWindows();
    refresh();
  }

  /// Retunns the position of the sash in pixels, either from the left or the top
  int getSashPosition( ) {
    if (!_isSplit) return 0;
    if (_pos < 0) return _resolve( _requestedPos );
    return _pos;
  }

  /// Sets the position of the sash in pixels, either from the left or the top
  void setSashPosition( int pos, { bool redraw = true } ) {
    _requestedPos = pos;
    _pos = _length() > 0 ? _clamp( _resolve( pos ) ) : -1;
    _layoutWindows();
    if (redraw) refresh();
  }

  /// Sets the gravity which controls position of the sash while resizing.
  /// Value is between 0.0 and 1.0 with the following meaning:
  /// * 0.0: only the bottom/right window grows or shrinks
  /// * 0.5: both windows grow equally
  /// * 1.0: only the left/top window grows or shrinks
  ///
  /// In wxDart Flutter only implemented if the sash is invisble by [setSashInvisible]
  void setSashGravity( double gravity ) {
    _gravity = gravity.clamp( 0.0, 1.0 );
  }

  /// Returns the gravity
  ///
  /// See [setSashGravity]
  double getSashGravity( ) {
    return _gravity;
  }

  /// In wxDart Native, updates the window sizes.  This can be useful
  /// for reducing flicker by updating the sizes before a window is shown.
  void updateSize( ) {
    _layoutWindows();
  }

  // ---------------- the sash

  bool _isOnSash( WxPoint p ) {
    if (!_isSplit || getSashSize() == 0 || _pos < 0) return false;
    final v = _vertical ? p.x : p.y;
    return v >= _pos - 2 && v < _pos + getSashSize() + 2;
  }

  void _onPaint( WxPaintEvent event ) {
    final dc = WxPaintDC( this );
    if (!_isSplit || getSashSize() == 0 || _pos < 0) return;
    final size = getClientSize();
    final colour = wxGetSystemSettings().getColour( wxSYS_COLOUR_GRIDLINES );
    dc.setPen( WxPen( colour ) );
    final mid = _pos + getSashSize() ~/ 2;
    if (_vertical) {
      dc.drawLine( mid, 0, mid, size.y );
    } else {
      dc.drawLine( 0, mid, size.x, mid );
    }
  }

  void _onLeftDown( WxMouseEvent event ) {
    if (!_isOnSash( event.getPosition() )) {
      event.skip();
      return;
    }
    _dragging = true;
    _posBeforeDrag = _pos;
    _dragOffset = (_vertical ? event.getX() : event.getY()) - _pos;
    captureMouse();
  }

  void _onMotion( WxMouseEvent event ) {
    if (!_dragging) {
      event.skip();
      return;
    }
    final wanted = _clamp( (_vertical ? event.getX() : event.getY()) - _dragOffset );
    if (wanted == _pos) return;
    final changing = WxSplitterEvent( wxGetSplitterSashPosChangingEventType(), getId() );
    changing._pos = wanted;
    changing.setEventObject( this );
    processEvent( changing );
    if (!changing.isAllowed()) return;
    // the handler may have changed the position with setSashPosition on the event
    _pos = _clamp( changing._pos );
    _requestedPos = _pos;
    _layoutWindows();
    refresh();
  }

  void _onLeftUp( WxMouseEvent event ) {
    if (!_dragging) {
      event.skip();
      return;
    }
    _endDrag( true );
  }

  void _endDrag( bool notify ) {
    if (!_dragging) return;
    _dragging = false;
    releaseMouse();
    if (!notify || _pos == _posBeforeDrag) return;
    final changed = WxSplitterEvent( wxGetSplitterSashPosChangedEventType(), getId() );
    changed._pos = _pos;
    changed.setEventObject( this );
    processEvent( changed );
  }

  void _onDClick( WxMouseEvent event ) {
    if (!_isOnSash( event.getPosition() )) {
      event.skip();
      return;
    }
    final dclick = WxSplitterEvent( wxGetSplitterDoubleClickEventType(), getId() );
    dclick._x = event.getX();
    dclick._y = event.getY();
    dclick.setEventObject( this );
    processEvent( dclick );
    // as in wxWidgets: unsplit unless vetoed and if a pane may vanish
    if (dclick.isAllowed() && (_minimumPaneSize == 0 || hasFlag( wxSP_PERMIT_UNSPLIT ))) {
      unsplit();
    }
  }
}
