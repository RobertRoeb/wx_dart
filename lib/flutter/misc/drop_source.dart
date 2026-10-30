// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
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
/// In wxDart Flutter only implemented for Drag and Drop within
/// the application.
/// 
/// By default, [WxDropSource] gives visual feedback if a copy
/// or a move operation is intended. You can override this by
/// catching a the [WxDragEvent] and call [WxDragEvent.veto].
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
  WxPoint _dragPosition = WxPoint.zero;
  OverlayPortalController? _controller;
  bool _isMove = false;
  bool _giveFeedback = true;
  bool _isNoEntry = false;

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
  int doDragDrop( { int flags = 0 } )
  {
    _window._dropSource = this;
    _isDragging = true;
    _window.captureMouse();
    _createOverlay();

    _window.bindMotionEvent( (event) {
      _isMove = event._shiftDown;
      _dragPosition = _window.clientToScreen( event.getPosition() );

      // Target window there to get data?
      _isNoEntry = true;
      final winUnderMouse = wxFindWindowAtPoint( _dragPosition );
      if (winUnderMouse != null) {
        if (winUnderMouse._dropTarget != null) {
          final target = winUnderMouse._dropTarget!;
          // for (int i = 0; i < _data.getFormatCount(); i++)
          final format = target._dataObject.getPreferredFormat();
          if (_dataObject.isSupported(format)) {
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
              /// Targget has to request data copy in this event
              winUnderMouse.processEvent(dropEvent);
              target._receivedDataObject = null;
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
    } );

    return wxDRAG_RESULT_ERROR;
  }
}

// ------------------------- wxDragEvent ----------------------

typedef OnDragEventFunc = void Function( WxDragEvent event );

/// @nodoc

class WxDragEventTableEntry extends WxEventTableEntry {
  WxDragEventTableEntry( super.eventType, super.id, this.func );
  final OnDragEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return (eventType == eventTypeTested) && ((id == wxID_ANY) || (id == idTested));
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxDragEvent) {
      func( event );
    }
  }
}

/// Event sent out by [WxDropTarget]
/// # Drag operation constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxDRAG_COPY_ONLY | 0 |
/// | wxDRAG_ALLOW_MOVE | 1 |
/// | wxDRAG_DEFAULT_MOVE | 3 |

class WxDragEvent extends WxNotifyEvent {
  WxDragEvent( int id ) : super( wxGetDragFeedbackEventType(), id );

  int _feedback= wxDRAG_COPY_ONLY;

  /// Sets which operation to give feedback for, called internally
  void setFeedback( int feedback ) {
    _feedback = feedback;
  }

  /// Returns the operaiton to give feedback for
  /// 
  /// # Drag operation constants
  /// | constant | meaning |
  /// | -------- | -------- |
  /// | wxDRAG_COPY_ONLY | 0 |
  /// | wxDRAG_ALLOW_MOVE | 1 |
  /// | wxDRAG_DEFAULT_MOVE | 3 |
  int getFeedback() {
    return _feedback;
  }
}

/// @nodoc

extension DragFeedbackEventBinder on WxEvtHandler {
  void bindDragFeedbackEvent( OnDragEventFunc func, int id ) {
    _eventTable.add( WxDragEventTableEntry(wxGetDragFeedbackEventType(), id, func));
  }

  void unbindDragFeedbackEvent( int id ) {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetDragFeedbackEventType(), id) ));
  }
}


