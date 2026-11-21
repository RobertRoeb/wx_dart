// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- WxIdleEvent binders ----------------------

/// @nodoc

extension IdleEventBinder on WxEvtHandler {
  void bindIdleEvent( OnIdleEventFunc func ) {
    _eventTable.add( WxIdleEventTableEntry(wxGetIdleEventType(), -1, func));
  }

  void unbindIdleEvent() {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetIdleEventType(), -1) ));
  }
}

// ------------------------- wxIdleEvent ----------------------

typedef OnIdleEventFunc = void Function( WxIdleEvent event );

/// @nodoc

class WxIdleEventTableEntry extends WxEventTableEntry {
  WxIdleEventTableEntry( super.eventType, super.id, this.func );
  final OnIdleEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return eventType == eventTypeTested;
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxIdleEvent) {
      func( event );
    }
  }
}

/// Idle events get sent when the user does not give any input anymore
/// and the system is waiting.
/// 
/// [Idle](/wxdart/wxGetIdleEventType.html) event gets sent when the system is idle. Good moment to update your UI. |
/// | ----------------- |
/// | void bindIdleEvent( void function( [WxIdleEvent] event ) ) |
/// | void unbindIdleEvent() |

class WxIdleEvent extends WxEvent {
  WxIdleEvent(  { int id = 0 } ) : super( wxGetIdleEventType(), id );

  bool _moreRequested = false;

  bool moreRequested() {
    return _moreRequested;
  }

  /// Requests nore idle events to be sent. Will not work infinitely.
  void requestMore( { bool needMore = true }) {
    _moreRequested = needMore;
  }
}
