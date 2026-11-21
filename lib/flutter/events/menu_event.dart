// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- WxMenuEvent binders ----------------------

/// @nodoc

extension MenuOpenEventBinder on WxEvtHandler {
  void bindMenuOpenEvent( OnMenuEventFunc func ) {
    _eventTable.add( WxMenuEventTableEntry(wxGetMenuOpenEventType(), -1, func));
  }
  void unbindMenuOpenEvent() {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetMenuOpenEventType(), -1) ));
  }
}

/// @nodoc

extension MenuCloseEventBinder on WxEvtHandler {
  void bindMenuCloseEvent( OnMenuEventFunc func ) {
    _eventTable.add( WxMenuEventTableEntry(wxGetMenuCloseEventType(), -1, func));
  }
  void unbindMenuCloseEvent() {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetMenuCloseEventType(), -1) ));
  }
}

/// @nodoc

extension MenuHighlightEventBinder on WxEvtHandler {
  void bindMenuHighlightEvent( OnMenuEventFunc func ) {
    _eventTable.add( WxMenuEventTableEntry(wxGetMenuHighlightEventType(), -1, func));
  }
  void unbindMenuHighlightEvent() {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetMenuHighlightEventType(), -1) ));
  }
}

// ------------------------- WxMenuEvent ----------------------

typedef OnMenuEventFunc = void Function( WxMenuEvent event );

/// @nodoc

class WxMenuEventTableEntry extends WxEventTableEntry {
  WxMenuEventTableEntry( super.eventType, super.id, this.func );
  final OnMenuEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return (eventType == eventTypeTested) && ((id == wxID_ANY) || (id == idTested));
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxMenuEvent) {
      func( event );
    }
  }
}

/// Event sent when a menu appears or is closed. This is _not_ the event class
/// when a user selects a menu item - that is a [WxCommandEvent].

class WxMenuEvent extends WxEvent {
  WxMenuEvent( int type, this.menuId, { this.menu }) : super( type, 0 );

  int menuId;
  WxMenu? menu;

  /// Returns the menu that appeared or disappeard
  WxMenu? getMenu( ) {
    return menu;
  }

  /// Returns the id of the menu
  int getMenuId( ) {
    return menuId;
  }

  /// Returns true if event was sent from a popup menu
  bool isPopup( ) {
    return false;
  }
}
