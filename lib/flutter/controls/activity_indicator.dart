// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxActivityIndicator ----------------------

/// A simple control indicating that some work is currently being done. Typically by
/// showing a turning graphic.

class WxActivityIndicator extends WxControl {

  /// Creates the control
  WxActivityIndicator( super.parent, super.id, {  super.pos = wxDefaultPosition, super.size = wxDefaultSize, super.style = 0 } );

  /// Starts or restarts the animation
  void start( ) {
    _isRunning = true;
    _setState();
  }

  /// Returns true if the animation is currently running.
  bool isRunning( ) {
    return _isRunning;
  }

  /// Stops the animation
  void stop( ) {
    _isRunning = false;
    _setState();
  }

  @override
  Widget _build( BuildContext context )
  {
        return _buildControl( context, CircularProgressIndicator( value: _isRunning ? null : 0 ) );
  }

  bool _isRunning = false;
}
