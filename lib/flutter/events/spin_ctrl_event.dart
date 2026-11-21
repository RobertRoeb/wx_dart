// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- WxSpinDoubleEvent ----------------------

typedef OnSpinDoubleEventFunc = void Function( WxSpinDoubleEvent event );

/// @nodoc

class WxSpinDoubleEventTableEntry extends WxEventTableEntry {
  WxSpinDoubleEventTableEntry( super.eventType, super.id, this.func );
  final OnSpinDoubleEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return (eventType == eventTypeTested) && ((id == wxID_ANY) || (id == idTested));
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxSpinDoubleEvent) {
      func( event );
    }
  }
}

/// @nodoc

extension SpinCtrlDoubleEventBinder on WxEvtHandler {
  void bindSpinCtrlDoubleEvent( OnSpinDoubleEventFunc func, int id ) {
    _eventTable.add( WxSpinDoubleEventTableEntry(wxGetSpinCtrlDoubleEventType(), id, func));
  }

  void unbindSpinCtrlDoubleEvent( int id ) {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetSpinCtrlDoubleEventType(), id) ));
  }
}

/// Event emitted by [WxSpinCtrlDouble].
/// 
/// Main interface:
/// * [getValue]
/// 
/// [SpinCtrlDouble](/wxdart/wxGetSpinCtrlDoubleEventType.html) event gets sent when the user has entered a new number. |
/// | ----------------- |
/// | void bindSpinCtrlDoubleEvent( void function( [WxSpinDoubleEvent] event ), int id ) |
/// | void unbindSpinCtrlDoubleEvent( int id ) |

class WxSpinDoubleEvent extends WxNotifyEvent  {
  WxSpinDoubleEvent( int eventType, int id, { double value = 0 } ) : super( eventType, id ) {
    _value = value;
  }

  late double _value;

  /// Sets the value of the [WxSpinCtrlDouble], done by it.
  void setValue( double value ) {
    _value = value;
  }

  /// Returns the value of the [WxSpinCtrlDouble]
  double getValue( ) {
    return _value;
  }
}

// ------------------------- WxSpinEvent ----------------------

typedef OnSpinEventFunc = void Function( WxSpinEvent event );

/// @nodoc

class WxSpinEventTableEntry extends WxEventTableEntry {
  WxSpinEventTableEntry( super.eventType, super.id, this.func );
  final OnSpinEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return (eventType == eventTypeTested) && ((id == wxID_ANY) || (id == idTested));
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxSpinEvent) {
      func( event );
    }
  }
}

/// @nodoc

extension SpinCtrlEventBinder on WxEvtHandler {
  void bindSpinCtrlEvent( OnSpinEventFunc func, int id ) {
    _eventTable.add( WxSpinEventTableEntry(wxGetSpinCtrlEventType(), id, func));
  }

  void unbindSpinCtrlEvent( int id ) {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetSpinCtrlEventType(), id) ));
  }
}

/// @nodoc

extension SpinEventBinder on WxEvtHandler {
  void bindSpinEvent( OnSpinEventFunc func, int id ) {
    _eventTable.add( WxSpinEventTableEntry(wxGetSpinEventType(), id, func));
  }

  void unbindSpinEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetSpinEventType(), id));
  }
}

/// @nodoc

extension SpinUpEventBinder on WxEvtHandler {
  void bindSpinUpEvent( OnSpinEventFunc func, int id ) {
    _eventTable.add( WxSpinEventTableEntry(wxGetSpinUpEventType(), id, func));
  }

  void unbindSpinUpEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetSpinUpEventType(), id));
  }
}

/// @nodoc

extension SpinDownEventBinder on WxEvtHandler {
  void bindSpinDownEvent( OnSpinEventFunc func, int id ) {
    _eventTable.add( WxSpinEventTableEntry(wxGetSpinDownEventType(), id, func));
  }

  void unbindSpinDownEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetSpinDownEventType(), id));
  }
}
