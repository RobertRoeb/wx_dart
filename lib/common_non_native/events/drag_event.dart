// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- WxDragEvent binder ----------------------


/// @nodoc

extension DragFeedbackEventBinder on WxEvtHandler {
  void bindDragFeedbackEvent( OnDragEventFunc func, int id ) {
    _eventTable.add( WxDragEventTableEntry(wxGetDragFeedbackEventType(), id, func));
  }

  void unbindDragFeedbackEvent( int id ) {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetDragFeedbackEventType(), id) ));
  }
}

// ------------------------- WxDragEvent ----------------------

typedef OnDragEventFunc = void Function( WxDragEvent event );

/// @nodoc

class WxDragEventTableEntry extends WxEventTableEntry {
  WxDragEventTableEntry( super.eventType, super.id, this.func );
  final OnDragEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return (eventType == eventTypeTested) && ((id == wxID_ANY) || (id == idTested));
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxDragEvent) {
      func( event );
    }
  }
}

/// Event sent out by [WxDropTarget]
/// # Drag operation constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxDRAG_COPY_ONLY | 0 |
/// | wxDRAG_ALLOW_MOVE | 1 |
/// | wxDRAG_DEFAULT_MOVE | 3 |

class WxDragEvent extends WxNotifyEvent {
  WxDragEvent( int id ) : super( wxGetDragFeedbackEventType(), id );

  int _feedback= wxDRAG_COPY_ONLY;

  /// Sets which operation to give feedback for, called internally
  void setFeedback( int feedback ) {
    _feedback = feedback;
  }

  /// Returns the operaiton to give feedback for
  /// 
  /// # Drag operation constants
  /// | constant | meaning |
  /// | -------- | -------- |
  /// | wxDRAG_COPY_ONLY | 0 |
  /// | wxDRAG_ALLOW_MOVE | 1 |
  /// | wxDRAG_DEFAULT_MOVE | 3 |
  int getFeedback() {
    return _feedback;
  }
}
