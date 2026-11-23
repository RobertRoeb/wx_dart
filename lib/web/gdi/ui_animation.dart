// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-11-15
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

const int wxCURVE_LINEAR = 1;
const int wxCURVE_EASE_IN_EASE_OUT = 2;
const int wxCURVE_EASE_IN = 3;
const int wxCURVE_EASE_OUT = 4;
const int wxCURVE_BOUNCE = 5;

/// A simple animation: calls [callback] with a value from 0.0 to 1.0
/// (shaped by the curve) about 60 times a second for the given duration.
/// Same API as in wxDart Flutter.
class WxUIAnimation extends WxObject {
  /// Creates an animation object with a callback to update the UI and optionally
  /// a callback indicating completion.
  ///
  /// [millisecs] indicates the duration.
  /// [curve] indicate the curve
  ///
  /// The callback parameter _value_ start with 0 and ends with 1.0 if the animation
  /// has completed.
  ///
  /// Currently, supported values for [curve] are
  /// * wxCURVE_LINEAR
  /// * wxCURVE_EASE_IN_EASE_OUT
  /// * wxCURVE_EASE_IN
  /// * wxCURVE_EASE_OUT
  /// * wxCURVE_BOUNCE
  WxUIAnimation(void Function(double value) callback, int millisecs,
      {void Function()? callbackCompleted, int curve = wxCURVE_LINEAR}) {
    _callback = callback;
    _curve = curve;
    _callbackCompleted = callbackCompleted;
    _millisecs = millisecs;
  }

  late void Function(double value) _callback;
  void Function()? _callbackCompleted;
  int _millisecs = 1000;
  int _curve = wxCURVE_LINEAR;
  Timer? _timer;
  final Stopwatch _stopwatch = Stopwatch();

  double _easeInEaseOut(double source) {
    final square = source * source;
    return square / (2.0 * (square - source) + 1.0);
  }

  double _easeIn(double source) {
    return source * source;
  }

  double _easeOut(double source) {
    return source * (2 - source);
  }

  double _bounce(double source) {
    const n1 = 7.5625;
    const d1 = 2.75;
    if (source < 1 / d1) {
      return n1 * source * source;
    } else if (source < 2 / d1) {
      source -= 1.5 / d1;
      return n1 * source * source + 0.75;
    } else if (source < 2.5 / d1) {
      source -= 2.25 / d1;
      return n1 * source * source + 0.9375;
    } else {
      source -= 2.625 / d1;
      return n1 * source * source + 0.984375;
    }
  }

  double _shape(double value) {
    switch (_curve) {
      case wxCURVE_EASE_IN_EASE_OUT:
        return _easeInEaseOut(value);
      case wxCURVE_EASE_IN:
        return _easeIn(value);
      case wxCURVE_EASE_OUT:
        return _easeOut(value);
      case wxCURVE_BOUNCE:
        return _bounce(value);
      default:
        return value;
    }
  }

  void _tick() {
    final t = _millisecs <= 0 ? 1.0 : min(1.0, _stopwatch.elapsedMilliseconds / _millisecs);
    _callback(_shape(t));
    if (t >= 1.0) {
      stop();
      _callbackCompleted?.call();
    }
    _scheduleIdle();
  }

  /// Disposes the animation controller in wxDart Flutter
  @override
  void dispose() {
    stop();
    super.dispose();
  }

  /// Sets duration of the animation
  void setDuration(int millisecs) {
    _millisecs = millisecs;
  }

  /// Starts animation
  void start() {
    stop();
    _stopwatch
      ..reset()
      ..start();
    _callback(_shape(0.0));
    _timer = Timer.periodic(const Duration(milliseconds: 16), (_) => _tick());
  }

  /// Stops animation
  void stop() {
    _timer?.cancel();
    _timer = null;
    _stopwatch.stop();
  }

  /// Returns true if animation is running
  bool isRunning() {
    return _timer != null;
  }
}
