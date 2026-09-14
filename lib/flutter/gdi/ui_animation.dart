// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- WxUIAnimation ----------------------

const int wxCURVE_LINEAR = 1;
const int wxCURVE_EASE_IN_EASE_OUT = 2;
const int wxCURVE_EASE_IN = 3;
const int wxCURVE_EASE_OUT = 4;
const int wxCURVE_BOUNCE = 5;

/// Used to drive animations on screen. Currently implemented using a timer
/// in wxDart Native and using a ticker (synchronized with refresh rate)
/// in wxDart Flutter.
/// 
/// ```dart
/// // create animation that will last 250 milliseconds to turn a chevron 90°
/// _chevronAnimation = WxUIAnimation((value) {
/// 
///    // tell the window where we are from 0.0 to 1.0
///    _chevronAnimationFactor = value;
/// 
///   // update the window
///   refresh();
///  }, 250 );
/// 
///  // somewhere in your code, after a button press on the chevron
///  _chevronAnimation.start()
/// ```

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
  WxUIAnimation( void Function( double value ) callback, int millisecs, { void Function ()? callbackCompleted, 
    int curve = wxCURVE_LINEAR } )
  {
    _callback = callback;
    _curve = curve;
    _callbackCompleted = callbackCompleted;
    _millisecs = millisecs;
    if (!_init()) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _init();
      });      
    }
  }

  double _easeInEaseOut(double source)
  {
      final square = source * source;
      return square / (2.0 * (square - source) + 1.0);
  }

  double _easeIn(double source)
  {
      return source * source;
  }

  double _easeOut(double source)
  {
      return source * (2 - source);
  }

  double _bounce(double source)
  {
    const n1 = 7.5625;
    const d1 = 2.75;

    if (source < 1 / d1) {
        return n1 * source * source;
    } else if (source < 2 / d1) {
        return n1 * (source -= 1.5 / d1) * source + 0.75;
    } else if (source < 2.5 / d1) {
        return n1 * (source -= 2.25 / d1) * source + 0.9375;
    } else {
        return n1 * (source -= 2.625 / d1) * source + 0.984375;
    }
  }

  bool _init()
  {
    if (_controller != null) {
      return true;
    }
    if (_theWxDartAppState == null) 
    {
      // wxLogError( "No ticker provider available for UIAnimation" );
      return false;
    }
    _controller = AnimationController( 
      duration: Duration(milliseconds: _millisecs ),
      vsync: _theWxDartAppState!
    );
    _controller!.addListener( () {
      double value = _controller!.value;
      switch (_curve) {
        case wxCURVE_EASE_IN_EASE_OUT:  value = _easeInEaseOut(value);
        case wxCURVE_EASE_IN:           value = _easeIn(value);
        case wxCURVE_EASE_OUT:          value = _easeOut(value);
        case wxCURVE_BOUNCE:            value = _bounce(value);
      }
      _callback( value );
    });
    _controller!.addStatusListener( (AnimationStatus status) {
      if (status.isCompleted) {
        if (_callbackCompleted != null) {
          _callbackCompleted!();
        }
      }
    });
    _theWxDartAppState!._animationControllers.add( this );
    if (_hasStarted) {
      _controller!.forward();
    }
    return true;
  }


  /// Disposes the animation controller in wxDart Flutter
  @override
  void dispose()
  {
    if (_controller != null)
    {
      _theWxDartAppState!._animationControllers.remove( this );
      _controller!.dispose();
    }
    super.dispose();
  }

  /// Sets duration of the animation
  void setDuration( int millisecs ) {
    _millisecs = millisecs;
    if (_init()) {
      _controller!.duration = Duration(milliseconds: millisecs );
    }
  }

  /// Starts animation
  void start()
  {
    _hasStarted = true;
    if (_init()) {
      _controller!.reset();
      _controller!.forward();
    } 
  }

  /// Stops animation
  void stop() 
  {
    _hasStarted = false;
    if (_init()) {
      if (_controller!.isAnimating) {
        _controller!.stop(canceled: true);
      }
    }
  }

  /// Returns true if animation is running
  bool isRunning() {
    if (_init()) {
      return _controller!.isAnimating;
    } else {
      return false;
    }
  }

  AnimationController? _controller;
  late void Function( double value ) _callback;
  void Function()? _callbackCompleted;
  int _millisecs = 1000;
  bool _hasStarted = false;
  int _curve = wxCURVE_LINEAR;
}
