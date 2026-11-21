// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- WxTreeEvent binders ----------------------

typedef OnTreeEventFunc = void Function( WxTreeEvent event );

/// @nodoc

class WxTreeEventTableEntry extends WxEventTableEntry {
  WxTreeEventTableEntry( super.eventType, super.id, this.func );
  final OnTreeEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return (eventType == eventTypeTested) && ((id == wxID_ANY) || (id == idTested));
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxTreeEvent) {
      func( event );
    }
  }
}

/// @nodoc

extension TreeItemActivatedEventBinder on WxEvtHandler {
  void bindTreeItemActivatedEvent( OnTreeEventFunc func, int id ) {
    _eventTable.add( WxTreeEventTableEntry(wxGetTreeItemActivatedEventType(), id, func));
  }

  void unbindTreeItemActivatedEvent( int id ) {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetTreeItemActivatedEventType(), id) ));
  }
}

/// @nodoc

extension TreeSelChangedEventBinder on WxEvtHandler {
  void bindTreeSelChangedEvent( OnTreeEventFunc func, int id ) {
    _eventTable.add( WxTreeEventTableEntry(wxGetTreeSelChangedEventType(), id, func));
  }

  void unbindTreeSelChangedEvent( int id ) {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetTreeSelChangedEventType(), id) ));
  }
}

/// @nodoc

extension TreeItemExpandedEventBinder on WxEvtHandler {
  void bindTreeItemExpandedEvent( OnTreeEventFunc func, int id ) {
    _eventTable.add( WxTreeEventTableEntry(wxGetTreeItemExpandedEventType(), id, func));
  }

  void unbindTreeItemExpandedEvent( int id ) {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetTreeItemExpandedEventType(), id) ));
  }
}

/// @nodoc

extension TreeItemCollapsedEventBinder on WxEvtHandler {
  void bindTreeItemCollapsedEvent( OnTreeEventFunc func, int id ) {
    _eventTable.add( WxTreeEventTableEntry(wxGetTreeItemCollapsedEventType(), id, func));
  }

  void unbindTreeItemCollapsedEvent( int id ) {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetTreeItemCollapsedEventType(), id) ));
  }
}

/// @nodoc

extension TreeDeleteItemEventBinder on WxEvtHandler {
  void bindTreeDeleteItemEvent( OnTreeEventFunc func, int id ) {
    _eventTable.add( WxTreeEventTableEntry(wxGetTreeDeleteItemEventType(), id, func));
  }

  void unbindTreeDeleteItemEvent( int id ) {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetTreeDeleteItemEventType(), id) ));
  }
}

// ------------------------- WxTreeEvent ----------------------

/// Event emitted by [WxTreeCtrl]
/// 
/// Main interface:
/// * [getItem]
/// * [getLabel]

class WxTreeEvent extends WxNotifyEvent {
  WxTreeEvent( int eventType, WxTreeCtrl tree, WxTreeItemId item ) : super( eventType, tree.getId() ) {
    setEventObject( tree );
    setClientData( tree.getItemData( item ) );
    _item = item;
    // _label = item.isOk() && !item._isInvisibleRoot ? item._node!.label : '';
  }
  
  // late final WxTreeCtrl _treectrl;
  late final WxTreeItemId _item;
  String _label = '';
  WxPoint _point = wxDefaultPosition;

  /// Returns the item the event refers to
  WxTreeItemId getItem( ) {
    return _item;
  }

  /// Returns the lable of the item the event refers to
  String getLabel( ) {
    return _label;
  }

  void setLabel( String label ) {
    _label = label;
  }

  /// Returns position of mouse event.
  /// Not implemented in wxDart Flutter.
  WxPoint getPoint( ) {
    return _point;
  }

  bool isEditCancelled( ) {
    return true;
  }
}
