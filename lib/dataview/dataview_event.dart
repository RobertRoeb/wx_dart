// ---------------------------------------------------------------------------
// Name:        dataviewevent.dart
// Name:        src/generic/datavgen.cpp from wxWidgets
// Purpose:     WxDataViewEvent definitions for WxDataViewCtrl for both 
//              wxDart Native and wxDart Flutter
// Author:      Robert Roebling
// Modified by: Francesco Montorsi, Guru Kathiresan, Bo Yang
// Copyright:   (c) 1998 Robert Roebling (C++ version)
// Copyright:   (c) 2026 Robert Roebling (Dart version)
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../wx_dart.dart';

// ------------------------- event types ----------------------

final _wxDataViewSelectionChangedEventType = wxNewEventType();
int wxGetDataViewSelectionChangedEventType()        { return _wxDataViewSelectionChangedEventType; }

final _wxDataViewItemActivatedEventType = wxNewEventType();
int wxGetDataViewItemActivatedEventType()           { return _wxDataViewItemActivatedEventType; }

final _wxDataViewItemCollapsingEventType = wxNewEventType();
int wxGetDataViewItemCollapsingEventType()          { return _wxDataViewItemCollapsingEventType; }

final _wxDataViewItemCollapsedEventType = wxNewEventType();
int wxGetDataViewItemCollapsedEventType()           { return _wxDataViewItemCollapsedEventType; }

final _wxDataViewItemExpandingEventType = wxNewEventType();
int wxGetDataViewItemExpandingEventType()           { return _wxDataViewItemExpandingEventType; }

final _wxDataViewItemExpandedEventType = wxNewEventType();
int wxGetDataViewItemExpandedEventType()            { return _wxDataViewItemExpandedEventType; }

final _wxDataViewItemValueChangedEventType = wxNewEventType();
int wxGetDataViewItemValueChangedEventType()        { return _wxDataViewItemValueChangedEventType; }

final _wxDataViewItemContextMenuEventType = wxNewEventType();
int wxGetDataViewItemContextMenuEventType()         { return _wxDataViewItemContextMenuEventType; }

final _wxDataViewColumnHeaderClickEventType = wxNewEventType();
int wxGetDataViewColumnHeaderClickEventType()       { return _wxDataViewColumnHeaderClickEventType; }

final _wxDataViewColumnHeaderRightClickEventType = wxNewEventType();
int wxGetDataViewColumnHeaderRightClickEventType()  { return _wxDataViewColumnHeaderRightClickEventType; }

final _wxDataViewColumnSortedEventType = wxNewEventType();
int wxGetDataViewColumnSortedEventType()            { return _wxDataViewColumnSortedEventType; }

final _wxDataViewColumnReorderedEventType = wxNewEventType();
int wxGetDataViewColumnReorderedEventType()         { return _wxDataViewColumnReorderedEventType; }

final _wxDataViewCacheHintEventType = wxNewEventType();
int wxGetDataViewCacheHintEventType()               { return _wxDataViewCacheHintEventType; }

final _wxDataViewContextMenuEventType = wxNewEventType();
int wxGetDataViewContextMenuEventType()             { return _wxDataViewContextMenuEventType; }

final _wxDataViewItemStartEditingEventType = wxNewEventType();
int wxGetDataViewItemStartEditingEventType()        { return _wxDataViewItemStartEditingEventType; }

final _wxDataViewItemEditingStartedEventType = wxNewEventType();
int wxGetDataViewItemEditingStartedEventType()      { return _wxDataViewItemEditingStartedEventType; }

final _wxDataViewItemEditingDoneEventType = wxNewEventType();
int wxGetDataViewItemEditingDoneEventType()         { return _wxDataViewItemEditingDoneEventType; }

// ------------------------- wxDataViewEvent ----------------------

/// Function type for function handling [WxDataViewEvent]s from [WxDataViewCtrl]
typedef OnDataViewEventFunc = void Function( WxDataViewEvent event );

/// Event table entry for [WxDataViewEvent]s.
/// 
/// This gets added to an [WxEvtHandler]'s event table with a call to 
/// e.g. [DataViewSelectionChangedEventBinder.bindDataViewSelectionChangedEvent].
class WxDataViewEventTableEntry extends WxEventTableEntry {
  WxDataViewEventTableEntry( super.eventType, super.id, this.func );
  final OnDataViewEventFunc func;

  /// Returns true if the handler matches the event
  @override
  bool matches( int eventTypeTested, int idTested ) {
    return (eventType == eventTypeTested) && ((id == wxID_ANY) || (id == idTested));
  }

  /// Gets called if event handler was found for given event
  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxDataViewEvent) {
      func( event );
    }
  }
}

/// @nodoc

extension DataViewCacheHintEventBinder on WxEvtHandler {
  void bindDataViewCacheHintEvent( OnDataViewEventFunc func, int id ) {
    _eventTable.add( WxDataViewEventTableEntry(wxGetDataViewCacheHintEventType(), id, func));
  }

  void unbindDataViewCacheHintEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetDataViewCacheHintEventType(), id));
  }
}

/// @nodoc

extension DataViewSelectionChangedEventBinder on WxEvtHandler {
  /// Binds an DataViewSelectionChanged event to [func]
  void bindDataViewSelectionChangedEvent( OnDataViewEventFunc func, int id ) {
    _eventTable.add( WxDataViewEventTableEntry(wxGetDataViewSelectionChangedEventType(), id, func));
  }

  void unbindDataViewSelectionChangedEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetDataViewSelectionChangedEventType(), id));
  }
}

/// @nodoc

extension DataViewItemActivatedEventBinder on WxEvtHandler {
  void bindDataViewItemActivatedEvent( OnDataViewEventFunc func, int id ) {
    _eventTable.add( WxDataViewEventTableEntry(wxGetDataViewItemActivatedEventType(), id, func));
  }

  void unbindDataViewItemActivatedEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetDataViewItemActivatedEventType(), id));
  }
}

/// @nodoc

extension DataViewItemCollapsingEventBinder on WxEvtHandler {
  void bindDataViewItemCollapsingEvent( OnDataViewEventFunc func, int id ) {
    _eventTable.add( WxDataViewEventTableEntry(wxGetDataViewItemCollapsingEventType(), id, func));
  }

  void unbindDataViewItemCollapsingEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetDataViewItemCollapsingEventType(), id));
  }
}

/// @nodoc

extension DataViewItemCollapsedEventBinder on WxEvtHandler {
  void bindDataViewItemCollapsedEvent( OnDataViewEventFunc func, int id ) {
    _eventTable.add( WxDataViewEventTableEntry(wxGetDataViewItemCollapsedEventType(), id, func));
  }

  void unbindDataViewItemCollapsedEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetDataViewItemCollapsedEventType(), id));
  }
}

/// @nodoc

extension DataViewItemExpandingEventBinder on WxEvtHandler {
  void bindDataViewItemExpandingEvent( OnDataViewEventFunc func, int id ) {
    _eventTable.add( WxDataViewEventTableEntry(wxGetDataViewItemExpandingEventType(), id, func));
  }

  void unbindDataViewItemExpandingEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetDataViewItemExpandingEventType(), id));
  }
}

/// @nodoc

extension DataViewItemExpandedEventBinder on WxEvtHandler {
  void bindDataViewItemExpandedEvent( OnDataViewEventFunc func, int id ) {
    _eventTable.add( WxDataViewEventTableEntry(wxGetDataViewItemExpandedEventType(), id, func));
  }

  void unbindDataViewItemExpandedEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetDataViewItemExpandedEventType(), id));
  }
}

/// @nodoc

extension DataViewItemValueChangedEventBinder on WxEvtHandler {
  void bindDataViewItemValueChangedEvent( OnDataViewEventFunc func, int id ) {
    _eventTable.add( WxDataViewEventTableEntry(wxGetDataViewItemValueChangedEventType(), id, func));
  }

  void unbindDataViewItemValueChangedEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetDataViewItemValueChangedEventType(), id));
  }
}

/// @nodoc

extension DataViewItemStartEditingEventBinder on WxEvtHandler {
  void bindDataViewItemStartEditingEvent( OnDataViewEventFunc func, int id ) {
    _eventTable.add( WxDataViewEventTableEntry(wxGetDataViewItemStartEditingEventType(), id, func));
  }

  void unbindDataViewItemStartEditingEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetDataViewItemStartEditingEventType(), id));
  }
}

/// @nodoc

extension DataViewItemEditingStartedEventBinder on WxEvtHandler {
  void bindDataViewItemEditingStartedEvent( OnDataViewEventFunc func, int id ) {
    _eventTable.add( WxDataViewEventTableEntry(wxGetDataViewItemEditingStartedEventType(), id, func));
  }

  void unbindDataViewItemEditingStartedEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetDataViewItemEditingStartedEventType(), id));
  }
}

/// @nodoc

extension DataViewItemEditingDoneEventBinder on WxEvtHandler {
  void bindDataViewItemEditingDoneEvent( OnDataViewEventFunc func, int id ) {
    _eventTable.add( WxDataViewEventTableEntry(wxGetDataViewItemEditingDoneEventType(), id, func));
  }

  void unbindDataViewItemEditingDoneEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetDataViewItemEditingDoneEventType(), id));
  }
}

/// @nodoc

extension DataViewItemContextMenuEventBinder on WxEvtHandler {
  void bindDataViewItemContextMenuEvent( OnDataViewEventFunc func, int id ) {
    _eventTable.add( WxDataViewEventTableEntry(wxGetDataViewItemContextMenuEventType(), id, func));
  }

  void unbindDataViewItemContextMenuEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetDataViewItemContextMenuEventType(), id));
  }
}

/// @nodoc

extension DataViewColumnHeaderClickEventBinder on WxEvtHandler {
  void bindDataViewColumnHeaderClickEvent( OnDataViewEventFunc func, int id ) {
    _eventTable.add( WxDataViewEventTableEntry(wxGetDataViewColumnHeaderClickEventType(), id, func));
  }

  void unbindDataViewColumnHeaderClickEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetDataViewColumnHeaderClickEventType(), id));
  }
}

/// @nodoc

extension DataViewColumnHeaderRightClickEventBinder on WxEvtHandler {
  void bindDataViewColumnHeaderRightClickEvent( OnDataViewEventFunc func, int id ) {
    _eventTable.add( WxDataViewEventTableEntry(wxGetDataViewColumnHeaderRightClickEventType(), id, func));
  }

  void unbindDataViewColumnHeaderRightClickEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetDataViewColumnHeaderRightClickEventType(), id));
  }
}

/// @nodoc

extension DataViewColumnSortedEventBinder on WxEvtHandler {
  void bindDataViewColumnSortedEvent( OnDataViewEventFunc func, int id ) {
    _eventTable.add( WxDataViewEventTableEntry(wxGetDataViewColumnSortedEventType(), id, func));
  }

  void unbindDataViewColumnSortedEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetDataViewColumnSortedEventType(), id));
  }
}

/// @nodoc

extension DataViewColumnReorderedEventBinder on WxEvtHandler {
  void bindDataViewColumnReorderedEvent( OnDataViewEventFunc func, int id ) {
    _eventTable.add( WxDataViewEventTableEntry(wxGetDataViewColumnReorderedEventType(), id, func));
  }

  void unbindDataViewColumnReorderedEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetDataViewColumnReorderedEventType(), id));
  }
}

/// @nodoc

/// Event sent from [WxDataViewCtrl]
/// 
/// This is an example of an event written in generic wxDart, so this event and 
/// [WxDataViewCtrl] as a whole can be used in wxDart Flutter and wxDart Native.

class WxDataViewEvent extends WxNotifyEvent {
  /// Creates the event. Done in [WxDataViewCtrl]
  WxDataViewEvent(  int eventType, WxDataViewCtrl dvc, WxDataViewColumn? column, WxDataViewItem item ) : 
    super( eventType, dvc.getId() ) 
  {
    _column = column;
    _modelColumn = (column != null) ? column.getModelColumn() : -1;
    _item = item;
    _model = dvc.getModel();
    setEventObject(dvc);
  }

  late final int _modelColumn;
  late final WxDataViewColumn? _column;
  late final WxDataViewItem _item;
  late final dynamic _value;
  WxDataViewModel? _model;
  int _cacheFrom = 0;
  int _cacheTo = 0;
  bool _editCancelled = false;
  WxPoint _pos = WxPoint(0,0);

  /// Returns the model column, not [WxDataViewColumn], associated this event, or -1
  int getColumn() {
    return _modelColumn;
  }
  /// Sets the model column (done by the control)
  void setColumn( int col ) {
    _modelColumn = col;
  }

  /// Returns the [WxDataViewColumn] associated this event, or null  
  WxDataViewColumn? getDataViewColumn( ) {
    return _column;
  }

  /// Returns the [WxDataViewModel] associated with the [WxDataViewCtrl] that send this event  
  WxDataViewModel? getModel() {
    return _model;
  }

  /// Returns the value if one is associated with the event
  dynamic getValue( ) {
    return _value;
  }
  /// Set the value (done by the control)
  void setValue( dynamic value ) {
    _value = value;
  }

  /// Returns the item
  WxDataViewItem getItem( ) {
    return _item;
  }
  /// Returns the item (done by the control)
  void setItem( WxDataViewItem item ) {
    _item = item;
  }

  void setEditCancelled( { bool cancelled = true } ) {
    _editCancelled = cancelled;
  }
  /// Returns true if an editting activity was cancelled
  bool getEditCancelled() {
    return _editCancelled;
  }

  void setCache( int from, int to ) {
    _cacheFrom = from;
    _cacheTo = to;
  }
  int getCacheFrom() {
    return _cacheFrom;
  }
  int getCacheTo() {
    return _cacheTo;
  }

  /// Sets the position in events related to mouse action
  void setPosition( int x, int y ) {
    _pos = WxPoint(x, y);
  }
  /// Returns the position in events related to mouse action
  WxPoint getPosition() {
    return _pos;
  }
}

