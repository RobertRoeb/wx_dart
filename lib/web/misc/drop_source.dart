// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01 (wxDart Web: 2026-11-15)
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxDropSource ----------------------

const int wxDRAG_COPY_ONLY = 0;
const int wxDRAG_ALLOW_MOVE = 1;

const int wxDRAG_DEFAULT_MOVE = 3;
const int wxDRAG_RESULT_ERROR = 0;
const int wxDRAG_RESULT_NONE = 1;
const int wxDRAG_RESULT_COPY = 2;
const int wxDRAG_RESULT_MOVE = 3;
const int wxDRAG_RESULT_LINK = 4;
const int wxDRAG_RESULT_CANCEL = 5;

/// [WxDropSource] is used to initiate a Drag and Drop operation.
/// 
/// It has to be associated with a [WxDataObject] that contains
/// the data and its format or formats.
/// 
/// In wxDart Web, [WxDropSource] works within the app only. A
/// [WxDropTarget] also accepts text, links, images and files dragged from
/// other apps or browser tabs. Press Escape to cancel a drag.
/// 
/// [doDragDrop] passes the result to a callback [onDone], in all ports
/// of wxDart (the drop target has received the data by then).
/// 
/// 
/// By default, [WxDropSource] gives visual feedback if a copy
/// or a move operation is intended. You can override this by
/// catching the [WxDragEvent] and call [WxDragEvent.veto].
/// 
/// See [WxDataObject], [WxTextDataObject], [WxDataFormat], [WxDropTarget]
/// 
/// Main interface:
/// * [doDragDrop]
/// 
/// Example usage:
///```Dart
///class MyDropSourceWindow extends WxWindow {
///  MyDropSourceWindow( WxWindow parent, WxSize size ) : super( parent, -1, wxDefaultPosition, size, 0)
///  {
///    // Mouse code to catch a drag start operation
///    bindLeftDownEvent((event) { _isDown = true; _start = event.getPosition(); } );
///    bindLeftUpEvent((_) => _isDown = false );
///    bindLeaveWindowEvent( (_) => _isDown = false );
///    bindMotionEvent(onMotion);
///  }
///
///  bool _isDown = false;
///  WxPoint _start = WxPoint.zero;
///
///  void onMotion( WxMouseEvent event )
///  {
///    if (!_isDown) return;
///    final dx = (event.getPosition().x - _start.x).toDouble();
///    final dy = (event.getPosition().y - _start.y).toDouble();
///    final dist = dx*dx + dy*dy;
///    if (dist > 64) {
///      // Drag has been long enough, start DnD
///      _isDown = false;
///
///      // Create data object with text
///      final data = WxTextDataObject( "This is so cool" );
///
///      // Create WxDropSource with data
///      final source = WxDropSource(data, this);
///
///      // Start DnD
///      source.doDragDrop();
///    }
///  }
///}
///
///```
/// # Drag operation constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxDRAG_COPY_ONLY | 0 |
/// | wxDRAG_ALLOW_MOVE | 1 |
/// | wxDRAG_DEFAULT_MOVE | 3 |
/// 
/// # Drag resuls constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxDRAG_RESULT_ERROR | 0 |
/// | wxDRAG_RESULT_NONE | 1 |
/// | wxDRAG_RESULT_COPY | 2 |
/// | wxDRAG_RESULT_MOVE | 3 |
/// | wxDRAG_RESULT_LINK | 4 |
/// | wxDRAG_RESULT_CANCEL | 5 |
/// 
/// Event emitted:
/// [DragFeedback](/wxdart/wxGetDragFeedbackEventType.html) event gets sent to allow the user to create visual feedback. |
/// | ----------------- |
/// | void bindDragFeedbackEvent( void function( [WxDragEvent] event) ) |
/// | void unbindDragFeedbackEvent() |

class WxDropSource extends WxClass {

  /// Creates WxDropSource with associated [data] for [win]
  WxDropSource( WxDataObject data, WxWindow win ) {
    _window = win;
    _dataObject = data;
  }

  late WxWindow _window;
  late WxDataObject _dataObject;
  bool _isDragging = false;
  bool _allowMove = false;
  bool _isMove = false;
  bool _giveFeedback = true;
  bool _isNoEntry = true;
  WxWindow? _oldWindowUnderMouse;
  void Function( int result )? _onDone;

  /// The drag currently in progress (at most one)
  static WxDropSource? _current;

  @override
  void dispose() {
    if (_isDragging) _finish( wxDRAG_RESULT_CANCEL );
    super.dispose();
  }

  /// Initiate Drag and Drop operation
  ///
  /// With [flags] wxDRAG_ALLOW_MOVE, the user can request a move by
  /// holding down Shift.
  ///
  /// The same in all ports of wxDart: the result is passed to [onDone]
  /// when the drag is over (wxDRAG_RESULT_COPY, wxDRAG_RESULT_MOVE,
  /// wxDRAG_RESULT_NONE or wxDRAG_RESULT_ERROR). In wxDart Flutter and
  /// wxDart Web, [doDragDrop] returns immediately and [onDone] is called
  /// later; in wxDart Native, [onDone] is called before [doDragDrop]
  /// returns. In each case, the drop target has received the data before
  /// [onDone] is called.
  ///
  /// ```dart
  ///   source.doDragDrop( flags: wxDRAG_ALLOW_MOVE, onDone: (result) {
  ///     if (result == wxDRAG_RESULT_MOVE) deleteSelection();
  ///   } );
  /// ```
  ///
  /// The same in all ports of wxDart: the result is passed to [onDone]
  /// when the drag is over (wxDRAG_RESULT_COPY, wxDRAG_RESULT_MOVE,
  /// wxDRAG_RESULT_NONE, wxDRAG_RESULT_CANCEL or wxDRAG_RESULT_ERROR).
  /// In wxDart Web and wxDart Flutter, [doDragDrop] returns immediately
  /// and [onDone] is called later; in wxDart Native, [onDone] is called
  /// before [doDragDrop] returns. In each case, the drop target has
  /// received the data before [onDone] is called.
  void doDragDrop( { int flags = 0, void Function( int result )? onDone } )
  {
    if (_current != null) {
      wxLogError( "Already dragging." );
      onDone?.call( wxDRAG_RESULT_ERROR );
      return;
    }
    _current = this;
    _window._dropSource = this;
    _isDragging = true;
    _allowMove = (flags & wxDRAG_ALLOW_MOVE) != 0;
    _onDone = onDone;
    _window.captureMouse();
    _onMotion( false );
  }

  /// The window under the mouse and the position relative to it
  (WxWindow?, WxPoint) _hitTest() {
    final mouse = _jsMousePosition();
    final hit = _jsWindowAt( mouse.x, mouse.y );
    return ( _windowFromHandle( hit.id ), WxPoint( hit.x, hit.y ) );
  }

  bool _accepts( WxWindow? win ) {
    if (win == null || win._dropTarget == null) return false;
    final format = win._dropTarget!._dataObject.getPreferredFormat();
    return _dataObject.isSupported( format );
  }

  void _sendLeave() {
    final old = _oldWindowUnderMouse;
    _oldWindowUnderMouse = null;
    if (old == null || old._isDestroyed) return;
    old.processEvent( _makeDropEvent( wxGetDropLeaveEventType(), old, 0, 0 ) );
  }

  void _onMotion( bool shiftDown ) {
    _isMove = _allowMove && shiftDown;
    final (winUnderMouse, pos) = _hitTest();

    if (_oldWindowUnderMouse != null && _oldWindowUnderMouse != winUnderMouse) {
      _sendLeave();
    }
    _isNoEntry = true;
    if (_accepts( winUnderMouse )) {
      final win = winUnderMouse!;
      if (_oldWindowUnderMouse == null) {
        win.processEvent( _makeDropEvent( wxGetDropEnterEventType(), win, pos.x, pos.y ) );
        _oldWindowUnderMouse = win;
      }
      final dropEvent = _makeDropEvent( wxGetDropDragOverEventType(), win, pos.x, pos.y );
      dropEvent.setResult( _isMove ? wxDRAG_RESULT_MOVE : wxDRAG_RESULT_COPY );
      win.processEvent( dropEvent );
      if (dropEvent.isAllowed() && dropEvent.getResult() != wxDRAG_RESULT_NONE) {
        _isNoEntry = false;
      }
    }

    // Give chance to give hint?
    final devent = WxDragEvent( _window.getId() );
    devent.setEventObject( _window );
    devent.setFeedback( _isMove ? wxDRAG_ALLOW_MOVE : wxDRAG_COPY_ONLY );
    _window.processEvent( devent );
    _giveFeedback = devent.isAllowed();
    _jsDragFeedback( !_giveFeedback ? 'hidden' : (_isNoEntry ? 'none' : (_isMove ? 'move' : 'copy')) );
  }

  void _onUp() {
    int result = wxDRAG_RESULT_NONE;
    final (winUnderMouse, pos) = _hitTest();
    _sendLeave();
    if (_accepts( winUnderMouse ) && !_isNoEntry) {
      final win = winUnderMouse!;
      if (_wxDoDrop( win, win._dropTarget!, _dataObject, pos.x, pos.y )) {
        result = _isMove ? wxDRAG_RESULT_MOVE : wxDRAG_RESULT_COPY;
      }
    }
    _finish( result );
  }

  void _finish( int result ) {
    if (!_isDragging) return;
    if (result == wxDRAG_RESULT_CANCEL) _sendLeave();
    _isDragging = false;
    _current = null;
    _window._dropSource = null;
    _window.releaseMouse();
    _jsDragFeedback( '' );
    final onDone = _onDone;
    _onDone = null;
    if (onDone != null) onDone( result );
  }
}

/// Called by the dispatcher for mouse and key events during a drag.
/// Returns true if the event has been consumed.
bool _wxDropSourceFilter( _JsEvent e ) {
  final source = WxDropSource._current;
  if (source == null) return false;
  switch (e.type) {
    case 'motion':
      source._onMotion( e.shift );
      return true;
    case 'mouseup':
      source._onUp();
      return true;
    case 'mousedown':
    case 'dclick':
    case 'wheel':
      return true;
    case 'keydown':
      if (e.key == 'Escape') {
        source._finish( wxDRAG_RESULT_CANCEL );
        return true;
      }
      if (e.key == 'Shift') source._onMotion( true );
      return false;
    case 'keyup':
      if (e.key == 'Shift') source._onMotion( false );
      return false;
  }
  return false;
}
