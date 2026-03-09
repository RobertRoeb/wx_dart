// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxTimer ----------------------

/// Represents a timer that calls [notify] or sends a [WxTimerEvent] after some time
/// 
/// The class can either fire just once or repeatedly.
/// 
/// When overriding [notify] extend the class like this:
/// ```dart
///class MyTimer extends WxTimer {
///  MyTimer();
///
///  @override
///  void notify() {
///    // do something
///  }
///}
///
/// // somewhere in your code class
/// _timer = MyTimer();
///
/// // somewhere else in your code
/// _timer.startOnce( milliseconds: 150 );
/// ```
/// 
/// If you want to send a [WxTimerEvent] to a window, do it like this
/// ```dart
/// class MyWindow extends WxWindow {
///   MyWindow( WxWindow parent, int id ) : super( parent, id, wxDefaultPosition, wxDefaultSize, 0 )
///   {
///     _timer = WxTimer.withOwner( this );
/// 
///     // Bind to timer event
///     bindTimerEvent(onTimer);
///   }
/// 
///   // define new timer event handler
///   void onTimer( WxTimerEvent event )
///   {
///     // do something
///   }
/// 
///   late WxTimer _timer;
/// }
/// ```
/// or in short form
/// ```dart
/// class MyWindow extends WxWindow {
///   MyWindow( WxWindow parent, int id ) : super( parent, id, wxDefaultPosition, wxDefaultSize, 0 )
///   {
///     _timer = WxTimer.withOwner( this );
/// 
///     // Bind to timer event
///     bindTimerEvent((_) {
///       // do something
///     });
///   }
///   late WxTimer _timer;
/// }
/// ```

class WxTimer extends WxEvtHandler {
  /// Creates the timer and sets owner to _self_ and _ID_ to -1. When using
  /// this constructor you will usually need to override [notify].
  WxTimer() {
    _owner = this;
    _id = -1;
  }
  /// Use this constuctor if you use the event based timer notification.
  WxTimer.withOwner( WxEvtHandler owner, { int id = -1 } ) {
    _owner = owner;
    _id = id;
  }
  WxEvtHandler? _owner;
  late int _id;
  bool _oneShot = true;
  int _interval = -1;
  Timer? _timer;

  /// Sets the [WxEvtHandler] to which the timer event will get sent.
  /// 
  /// This is usually a [WxWindow] or [WxApp]
  void setOwner( WxEvtHandler? owner ) {
    _owner = owner;
  }

  /// Returns [WxEvtHandler] to which the timer event will get sent.
  /// 
  /// This is usually a [WxWindow] or [WxApp]. Defaults to _self_.
  WxEvtHandler? getOwner() {
    return _owner;
  }

  /// Returns the ID (only relevant when using events)
  void setId( int id ) {
    _id = id;
  }
  /// Returns the ID (only relevant when using events)
  int getId() {
    return _id;
  }

  /// Returns the interval in milliseconds
  int getInterval() {
    return _interval;
  }

  /// Returns true if single shot timer
  bool isOneShot() {
    return _oneShot;
  }

  /// Returns true if timer is currently running
  bool isRunning() {
    if (_timer == null) {
      return false;
    }
    return _timer!.isActive;
  }

  /// Starts the timer once, getting notified after [milliseconds]
  /// 
  /// If [oneShot], the timer will fire just once. That is the same as [startOnce].
  bool start( { int milliseconds = -1, bool oneShot = false } )
  {
    stop();
    if (milliseconds != -1) {
      _interval = milliseconds;
    }
    if (_interval == -1) return false;
    _oneShot = oneShot;
    if (_oneShot) {
      _timer = Timer( Duration( milliseconds: _interval ), ()=>_notify() );
    } else {
      _timer = Timer.periodic( Duration( milliseconds: _interval ), (timer)=>_notify() );
    }
    return true;
  }

  /// Starts the timer once, getting notified after [milliseconds]
  bool startOnce( { int milliseconds = -1 } ) {
    return start( milliseconds: milliseconds, oneShot: true );
  }

  /// Stops the timer
  void stop() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  /// Override this if you use the [notify] variant
  void notify() {
  }

  void _notify() {
    notify();
    if (_owner != null) {
      final event = WxTimerEvent( this );
      _owner!.processEvent(event);
    }
  }
}
