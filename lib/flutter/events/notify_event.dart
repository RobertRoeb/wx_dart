// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- WxNotifyEvent binders for WxPopupTransientWindow ----------------------

/// @nodoc

extension PopupWindowDismissEventBinder on WxEvtHandler {
  void bindPopupWindowDismissEvent( OnNotifyEventFunc func, int id ) {
    _eventTable.add( WxNotifyEventTableEntry(wxGetPopupWindowDismissEventType(), id, func));
  }

  void unbindPopupWindowDismissEvent( int id ) {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetPopupWindowDismissEventType(), id) ));
  }
}

// ------------------------- WxNotifyEvent ----------------------

typedef OnNotifyEventFunc = void Function( WxNotifyEvent event );

/// @nodoc

class WxNotifyEventTableEntry extends WxEventTableEntry {
  WxNotifyEventTableEntry( super.eventType, super.id, this.func );
  final OnNotifyEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return (eventType == eventTypeTested) && ((id == wxID_ANY) || (id == idTested));
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxNotifyEvent) {
      func( event );
    }
  }
}

/// Base event class for all events that allow some kind of veto
class WxNotifyEvent extends WxCommandEvent {
  WxNotifyEvent( super.eventType, super.id );

  bool _isAllowed = true;

  /// Allow the proposed action to be done. Usually, this is the default.
  void allow( ) {
    _isAllowed = true;
  }

  /// Vetos the proposed action.
  void veto( ) {
    _isAllowed = false;
  }

  /// Returns true if the event was not vetoed.
  bool isAllowed( ) {
    return _isAllowed;
  }
}

