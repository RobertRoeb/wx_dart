// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- WxTimerEvent binders ----------------------

/// @nodoc

extension TimerEventBinder on WxEvtHandler {
  void bindTimerEvent( OnTimerEventFunc func ) {
    _eventTable.add( WxTimerEventTableEntry(wxGetTimerEventType(), -1, func));
  }

  void unbindTimerEvent() {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetTimerEventType(), -1) ));
  }
}

// ------------------------- WxTimerEvent ----------------------

typedef OnTimerEventFunc = void Function( WxTimerEvent event );

/// @nodoc

class WxTimerEventTableEntry extends WxEventTableEntry {
  WxTimerEventTableEntry( super.eventType, super.id, this.func );
  final OnTimerEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return (eventType == eventTypeTested) && (idTested == id);
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxTimerEvent) {
      func( event );
    }
  }
}

/// This event is emitted by [WxTimer].
/// 
/// Bind to this event or override [WxTimer.notify]
/// 
/// [Timer](/wxdart/wxGetTimerEventType.html) event gets sent from [WxTimer] |
/// | ----------------- |
/// | void bindTimerEvent( void function( [WxTimerEvent] event ) ) |
/// | void unbindTimerEvent() |

class WxTimerEvent extends WxEvent {
  WxTimerEvent( WxTimer timer ) : super(wxGetTimerEventType(), timer.getId()) {
    _timer = timer;
  }

  late WxTimer _timer; 

  /// Returns the timer from which this event originates.
  WxTimer getTimer() {
    return _timer;
  }

  /// Returns the time interval in milliseconds.
  int getInterval() {
    return _timer.getInterval();
  }
}
