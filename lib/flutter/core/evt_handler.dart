// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxEvtHandler ----------------------

/// Defines an entry in an event table. Derive a new class from 
/// this abstract class if you need to define a new event class.
/// 
/// This class is used by wxDart Flutter and it can be used by all of
/// wxDart for user defined events. wxDart Native handles events
/// from the C++ differently without using this class.

abstract class WxEventTableEntry {
  WxEventTableEntry( this.eventType, this.id );
  final int eventType;
  final int id;

  /// Override to return true if this entry matches  
  bool matches( int eventTypeTested, int idTested );

  /// Override to return true if this entry matches  
  void doCallFunction( WxEvent event );
}

typedef WxEventTable = List<WxEventTableEntry>;

class WxCommandEventTableEntry extends WxEventTableEntry {
  /// Represent event table entry and holds the callback _func_
  
  WxCommandEventTableEntry( super.eventType, super.id, this.func );

  /// @nodoc
  final OnCommandEventFunc func;

  /// Returns true if this entry matches _eventTypeTested_ and _idTested_
  /// If the entry's own is -1 or wxID_ANY, then idTested is ignored.
  @override
  bool matches( int eventTypeTested, int idTested ) {
    return (eventType == eventTypeTested) && ((id == wxID_ANY) || (id == idTested));
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxCommandEvent) {
      func( event );
    }
  }
}

/// Base class for all event handling in wxDart. All event matching and
/// callback calling occurs in [processEvent].
class WxEvtHandler extends WxObject {
  WxEvtHandler();

  final WxEventTable _eventTable = [];

  /// Central place for all event processing. Once an event has been created
  /// by the system or a user event from any new code, it needs to be processed
  /// by this function in the respective window (or other class deriving from
  /// [WxEvtHandler].
  /// 
  /// [processEvent] tries to find a handler for the respective event based on
  /// the event type (in the case of system events deriving directly from [WxEvent])
  /// or the event type and the window ID (in the case of command events deriving
  /// from [WxCommandEvent]).
  /// 
  /// If no handler is found and the event is a [WxCommandEvent] then this function
  /// will go to the parent window's [processEvent] and looks for an event handler
  /// until either a handler is found or a top level window ([WxDialog] or
  /// [WxFrame]) is reached.
  /// 
  /// You can define a new event type with [wxNewEventType] (typically with a new class
  /// deriving from [WxCommandEvent]) in your code and send it for processing here.
  bool processEvent( WxEvent event )
  {
    // special case for size and paint events

    if (event.getEventType() == wxGetPaintEventType()) {
      if (_onPaintFunc != null) {
        _onPaintFunc!( event as WxPaintEvent );
        return true;
      }
      return false;
    }
    if (event.getEventType() == wxGetSizeEventType()) {
      if (_onSizeFunc != null) {
        _onSizeFunc!( event as WxSizeEvent );
        return true;
      }
      return false;
    }

    //  for (final entry in _eventTable) { 
    // go backwards to allow overloading
    for (int i = _eventTable.length-1; i >= 0; i--) {
      final entry = _eventTable[i];
      if (entry.matches(event.getEventType(), event.getId())) {
        entry.doCallFunction(event);
        if (!event.getSkipped()) {
          return true;
        } else {
          // unset skip flag again
          event.skip( skip: false );
        }
      }
    }

    if (event is! WxCommandEvent) {
      return false;
    }

    // command events

    if ((this is WxWindow) && (this is! WxTopLevelWindow)) {
        WxWindow window = this as WxWindow;
        WxWindow? parent = window.getParent();
        if (parent != null) {
          if (parent.processEvent(event)) {
            return true;
          }
        }
    }

    return false;
  }

  /// @nodoc
  void bindSizeEvent( OnSizeEventFunc func )      { _onSizeFunc = func; }
  /// @nodoc
  void unbindSizeEvent()                          { _onSizeFunc = null; }
  OnSizeEventFunc? _onSizeFunc;

  /// @nodoc
  void bindPaintEvent( OnPaintEventFunc func )    { _onPaintFunc = func; }
  /// @nodoc
  void unbindPaintEvent()                         { _onPaintFunc = null; }
  OnPaintEventFunc? _onPaintFunc;
}

