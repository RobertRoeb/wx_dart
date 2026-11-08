
part of '../wx_dart.dart';

// ----------------------- wxStopWatch --------------------

/// Represents a stop watch to measure time.
/// 
/// ```dart
/// final watch = WxStopWatch();
/// watch.start();
/// 
/// // do something interesting
/// 
/// if (watch.time() > 200) {
///   print( "You lost!" )
/// }
/// ```
/// 
/// This class is actually implementated in pure Dart and 
/// has only been added to make porting code from C++ easier.

class WxStopWatch {
  WxStopWatch() {
    _stopWatch = Stopwatch();
  }

  /// Start stop watch, optionally with a start time in milliseconds
  void start( { int milliseconds = 0 } ) {
    _startValue = milliseconds;
    _stopWatch.reset();
    _stopWatch.start();
  }

  /// Returns elapsed time in milliseconds
  int time() {
    return _stopWatch.elapsedMilliseconds + _startValue;
  }

  /// Returns elapsed time in microseconds
  int timeInMicro() {
    return _stopWatch.elapsedMicroseconds + _startValue*1000;
  }

  /// Stops the stop watch and resets it
  void stop() {
    _stopWatch.reset();
  }

  /// Resumes the stop watch
  void resume() {
    _stopWatch.start();
  }

  /// Pauses
  void pause() {
    _stopWatch.stop();
  }

  /// Returns true if stop watch is currently running
  bool isRunning() {
    return _stopWatch.isRunning;
  }

  late final Stopwatch _stopWatch;
  int _startValue = 0;
}
