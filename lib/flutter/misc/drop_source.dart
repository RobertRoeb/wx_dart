// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- WxDropSource ----------------------

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
/// In wxDart Flutter, drag and drop is only implemented within the app,
/// except for wxDart Flutter on the Web, where you can also drop text or
/// and a bitmap from other apps into a [WxDropTarget] holding a [WxTextDataObject]
/// or a [WxBitmapDataObject].
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
/// | void bindDragFeedbackEvent( void function( [WxDragEvent] event), int id ) |
/// | void unbindDragFeedbackEvent( int id ) |

class WxDropSource extends WxClass {

  /// Creates WxDropSource with associated [data] for [win]
  WxDropSource( WxDataObject data, WxWindow win ) {
    _window = win;
    _dataObject = data;
  }

  late WxWindow _window;
  late WxDataObject _dataObject;
  bool _isDragging = false;
  WxPoint _dragPosition = WxPoint.zero;
  OverlayPortalController? _controller;
  bool _isMove = false;
  bool _giveFeedback = true;
  bool _isNoEntry = false;
  WxWindow? _oldWindowUnterMouse;

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _removeOverlay() {
    _controller = null;
  }

  bool _isInDrag() {
    return _controller != null;
  }

  Widget _buildOverlay( BuildContext context, Widget child ) {
    if (!_giveFeedback) {
      return child;
    }
    return
      OverlayPortal(
          controller: _controller!,
          child: child,
          overlayChildBuilder: (BuildContext context) {
            return Positioned(
              left: _dragPosition.x.toDouble() + 7,
              top: _dragPosition.y.toDouble() + 7,
              child: Icon( _isNoEntry ? Icons.block : (_isMove ? Icons.copy_all : Icons.content_copy_rounded), color: Colors.grey[700] ) );
          } );
  }

  void _createOverlay() {
    _controller = OverlayPortalController();
    _controller!.show();
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
  void doDragDrop( { int flags = 0, void Function( int result )? onDone } )
  {
    if (_isDragging) {
      wxLogError( "Already dragging." );
      onDone?.call( wxDRAG_RESULT_ERROR );
      return;
    }
    final allowMove = (flags & wxDRAG_ALLOW_MOVE) != 0;
    _window._dropSource = this;
    _isDragging = true;
    _window.captureMouse();
    _createOverlay();

    _window.bindMotionEvent( (event) {
      _isMove = allowMove && event._shiftDown;
      _dragPosition = _window.clientToScreen( event.getPosition() );

      // Target window there to get data?
      _isNoEntry = true;
      final winUnderMouse = wxFindWindowAtPoint( _dragPosition );
      if ((_oldWindowUnterMouse != null) && (_oldWindowUnterMouse != winUnderMouse)) {
        final dropEvent = WxDropEvent( wxGetDropLeaveEventType(), _oldWindowUnterMouse!.getId() );
        dropEvent.setEventObject( _oldWindowUnterMouse! );
        _oldWindowUnterMouse!.processEvent( dropEvent );
        _oldWindowUnterMouse = null;
      }
      if (winUnderMouse != null) {
        if (winUnderMouse._dropTarget != null) {
          final target = winUnderMouse._dropTarget!;
          // for (int i = 0; i < _data.getFormatCount(); i++)
          final format = target._dataObject.getPreferredFormat();
          if (_dataObject.isSupported(format)) {
            if (_oldWindowUnterMouse == null) {
              final dropEvent = WxDropEvent( wxGetDropEnterEventType(), winUnderMouse.getId() );
              dropEvent.setEventObject( winUnderMouse );
              winUnderMouse.processEvent( dropEvent );
              _oldWindowUnterMouse = winUnderMouse;
            }
            final dropEvent = WxDropEvent( wxGetDropDragOverEventType(), winUnderMouse.getId() );
            dropEvent.setEventObject( winUnderMouse );
            winUnderMouse.processEvent( dropEvent );
            if (dropEvent.getResult() != wxDRAG_RESULT_NONE) {
              _isNoEntry = false;
            }
          }
        }
      }

      // Give chance to give hint?
      final devent = WxDragEvent( _window.getId() );
      devent.setEventObject( _window );
      _window.processEvent( devent );
      final oldGiveFeedback = _giveFeedback;
      _giveFeedback = devent.isAllowed();
      if (_giveFeedback || oldGiveFeedback) {
        _window._setState();
      }
    } );

    _window.bindLeftUpEvent( (_) {
      if (!_isDragging) {
        wxLogError( "Not currently dragging." );
        return;
      }

      int result = wxDRAG_RESULT_NONE;
      final winUnderMouse = wxFindWindowAtPoint( _dragPosition );
      if (winUnderMouse != null) {
        if (winUnderMouse._dropTarget != null) {
          final target = winUnderMouse._dropTarget!;
          // for (int i = 0; i < _data.getFormatCount(); i++)
          final format = target._dataObject.getPreferredFormat();
          if (_dataObject.isSupported(format)) {
            final dropEvent = WxDropEvent( wxGetDropDropEventType(), winUnderMouse.getId() );
            dropEvent.setEventObject( winUnderMouse );
            winUnderMouse.processEvent( dropEvent );
            if (dropEvent.isAllowed()) {
              target._receivedDataObject = _dataObject;
              dropEvent.setEventType( wxGetDropDataEventType() );
              /// Target has to request data copy in this event
              winUnderMouse.processEvent(dropEvent);
              target._receivedDataObject = null;
              result = _isMove ? wxDRAG_RESULT_MOVE : wxDRAG_RESULT_COPY;
            }
          }
        }
      }

      _isDragging = false;
      _window.releaseMouse();
      _window.unbindLeftUpEvent();
      _window.unbindMotionEvent();
      _removeOverlay();
      _window._dropSource = null;
      _window._setState();
      onDone?.call( result );
    } );
  }
}
