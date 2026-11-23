// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01 (wxDart Web: 2026-11-15)
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxActivityIndicator ----------------------

/// A simple control indicating that some work is currently being done. Typically by
/// showing a turning graphic.
/// 
/// Main interface
/// * [start]
/// * [stop]
/// * [isRunning]
/// 
/// Example usage
/// ```dart
///  final indicator = WxActivityIndicator( parent, -1 );
///  indicator.start();
///```

class WxActivityIndicator extends WxControl {
  /// Creates the control
  WxActivityIndicator( super.parent, super.id, {  super.pos = wxDefaultPosition, super.size = wxDefaultSize, super.style = 0 } );

  bool _isRunning = false;

  @override
  String get _jsKind => 'activity';

  @override
  WxSize _doGetBestSize() {
    return const WxSize( 32, 32 );
  }

  /// Starts or restarts the animation
  void start( ) {
    _isRunning = true;
    _jsActivitySet( _handle, true );
  }

  /// Returns true if the animation is currently running.
  bool isRunning( ) {
    return _isRunning;
  }

  /// Stops the animation
  void stop( ) {
    _isRunning = false;
    _jsActivitySet( _handle, false );
  }
}
