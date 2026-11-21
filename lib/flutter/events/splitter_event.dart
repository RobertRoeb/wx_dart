// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- WxSplitterEvent binders ----------------------

/// @nodoc

extension SplitterSashPosChangingEventBinder on WxEvtHandler {
  void bindSplitterSashPosChangingEvent( OnSplitterEventFunc func, int id ) {
    _eventTable.add( WxSplitterEventTableEntry(wxGetSplitterSashPosChangingEventType(), id, func));
  }

  void unbindSplitterSashPosChangingEvent( int id ) {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetSplitterSashPosChangingEventType(), id) ));
  }
}

/// @nodoc

extension SplitterSashPosChangedEventBinder on WxEvtHandler {
  void bindSplitterSashPosChangedEvent( OnSplitterEventFunc func, int id ) {
    _eventTable.add( WxSplitterEventTableEntry(wxGetSplitterSashPosChangedEventType(), id, func));
  }

  void unbindSplitterSashPosChangedEvent( int id ) {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetSplitterSashPosChangedEventType(), id) ));
  }
}

/// @nodoc

extension SplitterUnsplitEventBinder on WxEvtHandler {
  void bindSplitterUnsplitEvent( OnSplitterEventFunc func, int id ) {
    _eventTable.add( WxSplitterEventTableEntry(wxGetSplitterUnsplitEventType(), id, func));
  }

  void unbindSplitterUnsplitEvent( int id ) {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetSplitterUnsplitEventType(), id) ));
  }
}

/// @nodoc

extension SplitterDoubleClickEventBinder on WxEvtHandler {
  void bindSplitterDoubleClickEvent( OnSplitterEventFunc func, int id ) {
    _eventTable.add( WxSplitterEventTableEntry(wxGetSplitterDoubleClickEventType(), id, func));
  }

  void unbindSplitterDoubleClickEvent( int id ) {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetSplitterDoubleClickEventType(), id) ));
  }
}

// ------------------------- WxSplitterEvent ----------------------

typedef OnSplitterEventFunc = void Function( WxSplitterEvent event );

/// @nodoc

class WxSplitterEventTableEntry extends WxEventTableEntry {
  WxSplitterEventTableEntry( super.eventType, super.id, this.func );
  final OnSplitterEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return (eventType == eventTypeTested) && ((id == wxID_ANY) || (id == idTested));
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxSplitterEvent) {
      func( event );
    }
  }
}

/// Event sent out for [WxSplitterWindow] 
class WxSplitterEvent extends WxNotifyEvent {
  WxSplitterEvent( super.eventType, super.id );

  WxWindow? _windowBeingRemoved;
  int _x = 0;
  int _y = 0;
  int _pos = 0;

  /// Returns the new sash position
  int getSashPosition( ) {
    return _pos;
  }

  /// Returns the x coordinate of the double-click point
  int getX( ) {
    return _x;
  }

  /// Returns the y coordinate of the double-click point
  int getY( ) {
    return _y; 
  }

  WxWindow? getWindowBeingRemoved( ) {
    return _windowBeingRemoved;
  }
}
