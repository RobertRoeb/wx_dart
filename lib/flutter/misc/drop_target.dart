// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxDropTarget ----------------------

/// A [WxDropTarget] can be associated with a [WxWindow] by calling
/// [WxWindow.setDropTarget] so that data can be dropped on the
/// window using Drag and Drop operations.
/// 
/// A [WxDataObject] needs to associated with the window and it
/// will receive the data in end when you decide to call [getData].
/// 
/// Not implemented in wxDart Native yet.
/// 
/// While the wxWidgets C++ library uses overloaded functions,
/// wxDart uses events as the main interface for [WxDropTarget]. 
/// 
/// Example usage:
/// ```Dart
/// class MyDropWindow extends WxWindow {
///   MyDropWindow( WxWindow parent, WxSize size ) : super( parent, -1, wxDefaultPosition, size, 0)
///   {  
///     _data = WxTextDataObject( "" );
///     _target = WxDropTarget( _data );
///     setDropTarget( _target );
/// 
///     bindDropEnterEvent( (_) { 
///       // Show some highlight
///     }, -1 );
///     bindDropLeaveEvent( (_) {
///       // Remove some highlight
///     }, -1 );
///     bindDropDragOverEvent( (event) {
///       // Show insertion hint
///       final pos = event.getPosition();
///     }, -1 );
///     bindDropDropEvent( onDrop, -1);
///     bindDropDataEvent( onData, -1);
///   }
/// 
///   late WxTextDataObject _data;
///   late WxDropTarget _target;
///   String _dropText = "";
/// 
///   void onDrop( WxDropEvent event )
///   {
///     // You can reject the drop using 
///     // event.veto();
///   }
///   void onData( WxDropEvent event )
///   {
///     // The data has arrived. Now transfer it
///     // from [WxDropTarget] to the [WxDataObject]
///     _target.getData();
/// 
///     // We got it!
///     _dropText = _data.getText();
/// 
///     // Update window (or something else)
///     refresh();
///   }
/// }
///```
/// 
/// Events emitted (to associated window):
/// [DropDrop](/wxdart/wxGetDropDropEventType.html) event gets sent when user dropped the data. You can [WxDropEvent.veto] the drop. |
/// | ----------------- |
/// | void bindDropDropEvent( void function( [WxDropEvent] event ) ) |
/// | void unbindDropDropEvent() |
///
/// [DropData](/wxdart/wxGetDropDataEventType.html) event gets sent after a DropDrop event. Call [WxDropTarget.getData] in the handler. |
/// | ----------------- |
/// | void bindDropDataEvent( void function( [WxDropEvent] event ) ) |
/// | void unbindDropDataEvent() |
///
/// [DropDragOver](/wxdart/wxGetDropDragOverEventType.html) event gets sent when data is being dragged above the window. |
/// | ----------------- |
/// | void bindDropDragOverEvent( void function( [WxDropEvent] event ) ) |
/// | void unbindDropDragOverEvent() |
/// 
/// [DropEnter](/wxdart/wxGetDropEnterEventType.html) event gets sent when mouse enters the drop window. Not supported everywhere. |
/// | ----------------- |
/// | void bindDropEnterEvent( void function( [WxDropEvent] event ) ) |
/// | void unbindDropEnterEvent() |
/// 
/// [DropLeave](/wxdart/wxGetDropLeaveEventType.html) event gets sent when mouse leaves the drop window. Not supported everywhere. |
/// | ----------------- |
/// | void bindDropLeaveEvent( void function( [WxDropEvent] event ) ) |
/// | void unbindDropLeaveEvent() |

class WxDropTarget extends WxClass {

/// Creates a drop target with given [data]. A [WxDropTarget] needs
/// to be associated with a [WxWindow] by calling [WxWindow.setDropTarget].
  WxDropTarget( WxDataObject data ) {
    _data = data;
  }

  late WxDataObject _data;

  /// Tells the drop target to acquire the data. This needs to be
  /// called from with bindDragDrop(). See example.
  bool getData( ) {
    return false;
  }

/// Sets the default drop action, defaults to wxDRAG_COPY_ONLY.
/// 
/// # Drag operation constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxDRAG_COPY_ONLY | 0 |
/// | wxDRAG_ALLOW_MOVE | 1 |
/// | wxDRAG_DEFAULT_MOVE | 3 |
  void setDefaultAction( int action ) {
  }
}


// ------------------------- wxDropEvent ----------------------

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
/// | void bindDropDataEvent( void function( [WxDropEvent] event ) ) |
/// | void unbindDropDataEvent() |
/// 
/// [DropDrop](/wxdart/wxGetDropDropEventType.html) event gets sent when user dropped. You can [WxDropEvent.veto] the drop. |
/// | ----------------- |
/// | void bindDropDropEvent( void function( [WxDropEvent] event ) ) |
/// | void unbindDropDropEvent() |
///
/// [DropDragOver](/wxdart/wxGetDropDragOverEventType.html) event gets sent when data is being dragged above the window. |
/// | ----------------- |
/// | void bindDropDragOverEvent( void function( [WxDropEvent] event ) ) |
/// | void unbindDropDragOverEvent() |
/// 
/// [DropEnter](/wxdart/wxGetDropEnterEventType.html) event gets sent when mouse enters the drop window. Not supported everywhere. |
/// | ----------------- |
/// | void bindDropEnterEvent( void function( [WxDropEvent] event ) ) |
/// | void unbindDropEnterEvent() |
/// 
/// [DropLeave](/wxdart/wxGetDropLeaveEventType.html) event gets sent when mouse leaves the drop window. Not supported everywhere. |
/// | ----------------- |
/// | void bindDropLeaveEvent( void function( [WxDropEvent] event ) ) |
/// | void unbindDropLeaveEvent() |

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

/// @nodoc

extension DropDropEventBinder on WxEvtHandler {
  void bindDropDropEvent( OnDropEventFunc func, int id ) {
    _eventTable.add( WxDropEventTableEntry(wxGetDropDropEventType(), id, func));
  }

  void unbindDropDropEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetDropDropEventType(), id));
  }
}

/// @nodoc

extension DropDragOverEventBinder on WxEvtHandler {
  void bindDropDragOverEvent( OnDropEventFunc func, int id ) {
    _eventTable.add( WxDropEventTableEntry(wxGetDropDragOverEventType(), id, func));
  }

  void unbindDropDragOverEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetDropDragOverEventType(), id));
  }
}

/// @nodoc

extension DropDataEventBinder on WxEvtHandler {
  void bindDropDataEvent( OnDropEventFunc func, int id ) {
    _eventTable.add( WxDropEventTableEntry(wxGetDropDataEventType(), id, func));
  }

  void unbindDropDataEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetDropDataEventType(), id));
  }
}

/// @nodoc

extension DropEnterEventBinder on WxEvtHandler {
  void bindDropEnterEvent( OnDropEventFunc func, int id ) {
    _eventTable.add( WxDropEventTableEntry(wxGetDropEnterEventType(), id, func));
  }

  void unbindDropEnterEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetDropEnterEventType(), id));
  }
}

/// @nodoc

extension DropLeaveEventBinder on WxEvtHandler {
  void bindDropLeaveEvent( OnDropEventFunc func, int id ) {
    _eventTable.add( WxDropEventTableEntry(wxGetDropLeaveEventType(), id, func));
  }

  void unbindDropLeaveEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetDropLeaveEventType(), id));
  }
}
