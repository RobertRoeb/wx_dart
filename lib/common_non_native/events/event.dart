// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxNewEventType ----------------------

/// Starting number of user defined event types. An event of a typer higher
/// or equal to this number will be treated by wxDart Native completely in
/// Dart and will not be processed by the C++ library.
const int wxFIRST_CUSTOM_EVENT_TYPE = 5000;

/// Last event type given to an event
int wxLastEventType = wxFIRST_CUSTOM_EVENT_TYPE;

/// Use this to register a new event types for user defined events. See
/// [WxEvent] for an example of a user defined event.
/// 
/// The function returns a unique event ID above [wxFIRST_CUSTOM_EVENT_TYPE].
int wxNewEventType() {
  wxLastEventType++;
  return wxLastEventType;
}

// ------------------------- wxEvent ----------------------

/// Constant indicating no event propagation up the window hierarchy
const int wxEVENT_PROPAGATE_NONE = 0;

/// Base class for all events in wxDart.
/// 
/// Requires a unique event type. If you define a new custom event type
/// then you need to get a unique event type by calling [wxNewEventType].
/// 
/// If the event was sent from a window, the event will usually contain
/// the ID from that window. This defaults to [wxID_ANY] which is -1.
/// 
/// The event will also usually contain the event object (window or
/// something else) from which the event originates.
/// 
/// Example code showing how to define a new custom event in wxDart:
///```dart
///
/// // Define unique id for new event type
/// final _myCoolEventType = wxNewEventType();
/// int getMyCoolEventType()         { return _myCoolEventType; }
/// 
/// // Function type for function handling MyCoolEvent events
/// typedef OnMyCoolEventFunc = void Function( MyCoolEvent event );
/// 
/// // Event table entry for MyCoolEvent events
/// class MyCoolEventTableEntry extends WxEventTableEntry {
///   MyCoolEventTableEntry( super.eventType, super.id, this.func );
///   final OnMyCoolEventFunc func;
/// 
///   // Returns true if the handler matches the event
///   @override
///   bool matches( int eventTypeTested, int idTested ) {
///     return (eventType == eventTypeTested) && ((id == wxID_ANY) || (id == idTested));
///   }
/// 
///   // Gets called if event handler was found for given event
///   @override
///   void doCallFunction( WxEvent event ) {
///     if (event is MyCoolEvent) {
///       func( event );
///     }
///   }
/// }
/// 
/// // define WxEvtHandler extension for binding and unbinding
/// 
/// extension MyCoolEventBinder on WxEvtHandler {
/// 
///   // bind method
///   void bindMyCoolEvent( OnMyCoolEventFunc func, int id ) {
///     getEventTable().add( MyCoolEventTableEntry(getMyCoolEventType(), id, func));
///   }
/// 
///   // unbind method
///   void unbindMyCoolEvent( int id ) {
///     getEventTable().remove( getEventTable().lastWhere( (entry) => entry.matches(getMyCoolEventType(), id) ));
///   }
/// }
/// 
/// // Your new event
/// class MyCoolEvent extends WxNotifyEvent {
///   MyCoolEvent( super.eventType, super.id, String data ) {
///       _data = data;
///   }
/// 
///   String _data = "";
/// 
///   // Gets your data
///   String getData() {
///     return _data;
///   }
///   /// Sets your data
///   void setData( String data ) {
///     _data = data;
///   }
/// }
///```

class WxEvent extends WxObject {
  /// Creates the event. Pay attention to the order of [eventType] and [id] should
  /// you need to define your own derived event class.
  WxEvent( int eventType, int id ) { 
    _eventType = eventType;
    _id = id;
  }

  /// Returns the event type
  int getEventType() {
    return _eventType;
  }

  /// Sets the event type. Rarely used by user code to reinterpret
  /// an event on the fly.
  void setEventType( int type ) {
    _eventType = type;
  }

  /// Gets ID from the window from which the event orignates
  int getId() {
    return _id;
  }

  /// Sets ID from the window from which the event orignates
  void setId( int id ) {
    _id = id;
  }

  /// Marks the event as unread so that other event handler can
  /// handle this event again
  void skip( { bool skip = true } ) {
    _skipped = skip;
  }

  /// True if event should be handled as not yet handled
  bool getSkipped() {
    return _skipped;
  }

  /// Sets the object from which the event originates
  void setEventObject( WxObject object ) {
    _eventObject = object;
  }

  /// Returns the object from which the event originates
  WxObject? getEventObject() {
    return _eventObject;
  }

  /// Returns the propagation level, zero indicating no propagation
  /// up the window hierarchy
  int getPropagationLevel() {
    return _propagationLevel;
  }

  /// Sets the propagation level to zero indicating no propagation
  /// up the window hierarchy, and returns the previous level
  int stopPropagation() {
    final result = _propagationLevel;
    _propagationLevel = 0;
    return result;
  }

  /// Sets the propagation level, zero indicating no propagation
  /// up the window hierarchy
  void resumePropagation( int level ) {
    _propagationLevel = level;
  }

  late int     _id;
  late int     _eventType;
  bool        _skipped = false;
  WxObject ?  _eventObject;
  int         _propagationLevel = wxEVENT_PROPAGATE_NONE;
}
