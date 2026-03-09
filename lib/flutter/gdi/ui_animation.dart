// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- WxUIAnimation ----------------------

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
  /// 
  /// The callback parameter [value] start with 0 and ends with 1.0 if the animation
  /// has completed.
  WxUIAnimation( void Function( double value ) callback, int millisecs, { void Function ()? callbackCompleted } )
  {
    _callback = callback;
    _callbackCompleted = callbackCompleted;
    _millisecs = millisecs;
    if (!_init()) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _init();
      });      
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
      _callback( _controller!.value );
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
}
