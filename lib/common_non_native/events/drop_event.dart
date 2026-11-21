// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- WxDropEvent binder ----------------------

/// @nodoc

extension DropDropEventBinder on WxEvtHandler {
  void bindDropDropEvent( OnDropEventFunc func, int id ) {
    _eventTable.add( WxDropEventTableEntry(wxGetDropDropEventType(), id, func));
  }

  void unbindDropDropEvent( int id ) {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetDropDropEventType(), id) ));
  }
}

/// @nodoc

extension DropDragOverEventBinder on WxEvtHandler {
  void bindDropDragOverEvent( OnDropEventFunc func, int id ) {
    _eventTable.add( WxDropEventTableEntry(wxGetDropDragOverEventType(), id, func));
  }

  void unbindDropDragOverEvent( int id ) {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetDropDragOverEventType(), id) ));
  }
}

/// @nodoc

extension DropDataEventBinder on WxEvtHandler {
  void bindDropDataEvent( OnDropEventFunc func, int id ) {
    _eventTable.add( WxDropEventTableEntry(wxGetDropDataEventType(), id, func));
  }

  void unbindDropDataEvent( int id ) {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetDropDataEventType(), id) ));
  }
}

/// @nodoc

extension DropEnterEventBinder on WxEvtHandler {
  void bindDropEnterEvent( OnDropEventFunc func, int id ) {
    _eventTable.add( WxDropEventTableEntry(wxGetDropEnterEventType(), id, func));
  }

  void unbindDropEnterEvent( int id ) {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetDropEnterEventType(), id) ));
  }
}

/// @nodoc

extension DropLeaveEventBinder on WxEvtHandler {
  void bindDropLeaveEvent( OnDropEventFunc func, int id ) {
    _eventTable.add( WxDropEventTableEntry(wxGetDropLeaveEventType(), id, func));
  }

  void unbindDropLeaveEvent( int id ) {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetDropLeaveEventType(), id) ));
  }
}

// ------------------------- WxDropEvent ----------------------

typedef OnDropEventFunc = void Function( WxDropEvent event );

/// @nodoc

class WxDropEventTableEntry extends WxEventTableEntry {
  WxDropEventTableEntry( super.eventType, super.id, this.func );
  final OnDropEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return (eventType == eventTypeTested) && ((id == wxID_ANY) || (id == idTested));
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxDropEvent) {
      func( event );
    }
  }
}

/// [WxDropEvent] holds information about a Drag and Drop operation
/// on your window. The event is sent to the [WxWindow] that has been
/// associated with a [WxDropTarget] using [WxWindow.setDropTarget].
/// 
/// [DropData](/wxdart/wxGetDropDataEventType.html) event gets sent after a Drop event. Call [WxDropTarget.getData] in the handler. |
/// | ----------------- |
/// | void bindDropDataEvent( void function( [WxDropEvent] event ), int id ) |
/// | void unbindDropDataEvent( int id ) |
/// 
/// [DropDrop](/wxdart/wxGetDropDropEventType.html) event gets sent when user dropped. You can [WxDropEvent.veto] the drop. |
/// | ----------------- |
/// | void bindDropDropEvent( void function( [WxDropEvent] event ), int id ) |
/// | void unbindDropDropEvent( int id ) |
///
/// [DropDragOver](/wxdart/wxGetDropDragOverEventType.html) event gets sent when data is being dragged above the window. |
/// | ----------------- |
/// | void bindDropDragOverEvent( void function( [WxDropEvent] event ), int id ) |
/// | void unbindDropDragOverEvent( int id ) |
/// 
/// [DropEnter](/wxdart/wxGetDropEnterEventType.html) event gets sent when mouse enters the drop window. Not supported everywhere. |
/// | ----------------- |
/// | void bindDropEnterEvent( void function( [WxDropEvent] event ), int id ) |
/// | void unbindDropEnterEvent( int id ) |
/// 
/// [DropLeave](/wxdart/wxGetDropLeaveEventType.html) event gets sent when mouse leaves the drop window. Not supported everywhere. |
/// | ----------------- |
/// | void bindDropLeaveEvent( void function( [WxDropEvent] event ), int id ) |
/// | void unbindDropLeaveEvent( int id ) |

class WxDropEvent extends WxNotifyEvent {
  /// Creates a WxDropEvent. Done internally.
  WxDropEvent( super.eventType, super.id );

  WxPoint _pos = WxPoint.zero;
  int _result = wxDRAG_RESULT_ERROR;

  /// Sets the position of the drag. Used internalyl.
  void setPosition( WxPoint pos ) {
    _pos = pos;
  }

  /// Returns the position of the drag.
  WxPoint getPosition( ) {
    return _pos;
  }

/// Sets the result of the drag operation.
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
  void setResult( int result ) {
    _result = result;
  }

/// Returns drag result.
  int getResult( ) {
    return _result;
  }
}
