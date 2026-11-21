// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- WxNotebookEvent binders ----------------------

/// @nodoc

extension NotebookPageChangedEventBinder on WxEvtHandler {
  void bindNotebookPageChangedEvent( OnNotebookEventFunc func, int id ) { 
    _eventTable.add( WxNotebookEventTableEntry(wxGetNotebookPageChangedEventType(), id, func));
  }
  void unbindNotebookPageChangedEvent( OnNotebookEventFunc func, int id ) { 
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetNotebookPageChangedEventType(), id) ));
  }
}

/// @nodoc

extension NotebookPageChangingEventBinder on WxEvtHandler {
  void bindNotebookPageChangingEvent( OnNotebookEventFunc func, int id ) { 
    _eventTable.add( WxNotebookEventTableEntry(wxGetNotebookPageChangingEventType(), id, func));
  }
  void unbindNotebookPageChangingEvent( OnNotebookEventFunc func, int id ) { 
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetNotebookPageChangingEventType(), id) ));
  }
}

// ------------------------- WxNotebookEvent binders for WxTreebook ----------------------

/// @nodoc

extension TreebookPageChangedEventBinder on WxEvtHandler {
  void bindTreebookPageChangedEvent( OnNotebookEventFunc func, int id ) { 
    _eventTable.add( WxNotebookEventTableEntry(wxGetTreebookPageChangedEventType(), id, func));
  }
  void unbindTreebookPageChangedEvent( OnNotebookEventFunc func, int id ) { 
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetTreebookPageChangedEventType(), id) ));
  }
}

/// @nodoc

extension TreebookPageChangingEventBinder on WxEvtHandler {
  void bindTreebookPageChangingEvent( OnNotebookEventFunc func, int id ) { 
    _eventTable.add( WxNotebookEventTableEntry(wxGetTreebookPageChangingEventType(), id, func));
  }
  void unbindTreebookPageChangingEvent( OnNotebookEventFunc func, int id ) { 
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetTreebookPageChangingEventType(), id) ));
  }
}

/// @nodoc

extension TreebookNodeCollapsedEventBinder on WxEvtHandler {
  void bindTreebookNodeCollapsedEvent( OnNotebookEventFunc func, int id ) { 
    _eventTable.add( WxNotebookEventTableEntry(wxGetTreebookNodeCollapsedEventType(), id, func));
  }
  void unbindTreebookNodeCollapsedEvent( OnNotebookEventFunc func, int id ) { 
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetTreebookNodeCollapsedEventType(), id) ));
  }
}

/// @nodoc

extension TreebookNodeExpandedEventBinder on WxEvtHandler {
  void bindTreebookNodeExpandedEvent( OnNotebookEventFunc func, int id ) { 
    _eventTable.add( WxNotebookEventTableEntry(wxGetTreebookNodeExpandedEventType(), id, func));
  }
  void unbindTreebookNodeExpandedEvent( OnNotebookEventFunc func, int id ) { 
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetTreebookNodeExpandedEventType(), id) ));
  }
}

// ------------------------- WxNotebookEvent binders for WxNavigationCtrl ----------------------

/// @nodoc

extension NavCtrlPageChangedEventBinder on WxEvtHandler {
  void bindNavCtrlPageChangedEvent( OnNotebookEventFunc func, int id ) { 
    _eventTable.add( WxNotebookEventTableEntry(wxGetNavCtrlPageChangedEventType(), id, func));
  }
  void unbindNavCtrlPageChangedEvent( OnNotebookEventFunc func, int id ) { 
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetNavCtrlPageChangedEventType(), id) ));
  }
}

/// @nodoc

extension NavCtrlPageChangingEventBinder on WxEvtHandler {
  void bindNavCtrlPageChangingEvent( OnNotebookEventFunc func, int id ) { 
    _eventTable.add( WxNotebookEventTableEntry(wxGetNavCtrlPageChangingEventType(), id, func));
  }
  void unbindNavCtrlPageChangingEvent( OnNotebookEventFunc func, int id ) { 
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetNavCtrlPageChangingEventType(), id) ));
  }
}

// ------------------------- WxNotebookEvent ----------------------

typedef OnNotebookEventFunc = void Function( WxNotebookEvent event );

class WxNotebookEventTableEntry extends WxEventTableEntry {
  WxNotebookEventTableEntry( super.eventType, super.id, this.func );
  final OnNotebookEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return (eventType == eventTypeTested) && ((id == wxID_ANY) || (id == idTested));
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxNotebookEvent) {
      func( event );
    }
  }
}

/// Event sent when the user selects a page in a [WxNotebook] or other control derived from [WxBookCtrlBase]
class WxNotebookEvent extends WxNotifyEvent {
  WxNotebookEvent( { int eventType = 0, int id = 0, sel = 0, oldSel = 0 } ) : super( eventType, id )
  {
    _sel = sel;
    _oldSel = oldSel;
  }

  int _sel = 0; // use commandint instead
  int _oldSel = 0;

  @override
  int getSelection( ) {
    return _sel;
  }

  int getOldSelection( ) {
    return _oldSel;
  }
}

