// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- WxCollapsiblePaneEvent binders ----------------------

typedef OnCollapsiblePaneEventFunc = void Function( WxCollapsiblePaneEvent event );

/// @nodoc

class WxCollapsiblePaneEventTableEntry extends WxEventTableEntry {
  WxCollapsiblePaneEventTableEntry( super.eventType, super.id, this.func );
  final OnCollapsiblePaneEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return (eventType == eventTypeTested) && ((id == wxID_ANY) || (id == idTested));
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxCollapsiblePaneEvent) {
      func( event );
    }
  }
}

/// @nodoc

extension CollapsiblePaneEventBinder on WxEvtHandler {
  void bindCollapsiblePaneChangedEvent( OnCollapsiblePaneEventFunc func, int id ) {
    _eventTable.add( WxCollapsiblePaneEventTableEntry(wxGetCollapsiblePaneChangedEventType(), id, func));
  }

  void unbindCollapsiblePaneChangedEvent( int id ) {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetCollapsiblePaneChangedEventType(), id) ));
  }
}

// ------------------------- WxCollapsiblePaneEvent ----------------------

/// [WxCollapsiblePaneEvent] gets sent from [WxCollapsiblePane]
/// 
/// [CollapsiblePaneChanged](/wxdart/wxGetCollapsiblePaneChangedEventType.html) event gets sent when the user collapses or expands the pane. |
/// | ----------------- |
/// | void bindCollapsiblePaneChangedEvent( void function( WxCollapsiblePaneEvent event ) ) |
/// | void unbindCollapsiblePaneChangedEvent() |
class WxCollapsiblePaneEvent extends WxCommandEvent {
  /// Creates the event.
  WxCollapsiblePaneEvent( WxWindow generator, int id, bool collapse ) : super( wxGetCollapsiblePaneChangedEventType(), id)
  {
      _collapsed = collapse;
      setEventObject( generator );
  }

  /// Sets if the pane was collapsed or expanded. Used internally.
  void setCollapsed( bool collapsed ) {
    _collapsed = collapsed;
  }

  /// Returns true of the pane got collapsed, false when it expanded.
  bool getCollapsed( ) {
    return _collapsed;
  }
  bool _collapsed = false;
}
