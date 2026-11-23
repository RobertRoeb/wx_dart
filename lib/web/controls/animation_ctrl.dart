// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01 (wxDart Web: 2026-11-15)
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxAnimationCtrl ----------------------

const int wxAC_NO_AUTORESIZE = 0x0010;
const int wxAC_DEFAULT_STYLE = wxBORDER_NONE;

/// Control to allow playing a simple image animation defined by the
/// [WxAnimation] class - currently only GIFs are supported. 
/// 
/// Not to be mixed up the the [WxUIAnimation] class used to time
/// any animation on screen.
/// 
/// Example usage:
/// ```dart
///  // Create animation control from lib/assets/JumpingBird.gif
///  final ani = WxAnimationCtrl(parent, -1, WxAnimation("JumpingBird.gif") );
///
///  // Somewhere else in your code
///  if (ani.isPlaying()) {
///    ani.stop();
///  } else {
///    ani.play();
///  }
/// ```
/// 
/// Main interface
/// * [play]
/// * [stop]
/// * [isPlaying]
/// * [setInactiveBitmap]

class WxAnimationCtrl extends WxControl {
  // _animation is set in the initializer list: the WxWindow constructor
  // already asks for the best size
  WxAnimationCtrl( super.parent, super.id, WxAnimation animation, {  super.pos = wxDefaultPosition, super.size = wxDefaultSize, super.style = wxAC_DEFAULT_STYLE } )
  : _animation = animation {
    _attach();
  }

  WxAnimation _animation;
  bool _isPlaying = false;

  @override
  String get _jsKind => 'animation';

  void _attach() {
    final animation = _animation;
    animation.load().then( (_) {
      if (_isDestroyed || animation != _animation || !animation.isOk()) return;
      _jsAnimCtrlSet( _handle, animation._handle );
      if (!hasFlag( wxAC_NO_AUTORESIZE )) invalidateBestSize();
    } );
  }

  @override
  WxSize _doGetBestSize() {
    return _animation.isOk() ? _animation.getSize() : const WxSize( 32, 32 );
  }

  /// Sets a new animation (stops playing the old one)
  void setAnimation( WxAnimation animation ) {
    stop();
    _animation = animation;
    _attach();
  }

  /// Returns the animation
  WxAnimation getAnimation( ) {
    return _animation;
  }

  /// Starts or continues to play the animation
  /// 
  /// In wxDart Web, an animation that is still downloading starts
  /// playing as soon as it has arrived.
  void play( ) {
    _isPlaying = true;
    _jsAnimPlay( _handle, true );
  }

  /// Returns true if currently playing
  bool isPlaying( ) {
    return _isPlaying;
  }

  /// Stops the animation
  void stop( ) {
    _isPlaying = false;
    _jsAnimPlay( _handle, false );
  }

  /// Bitmap shown when animation is not playing
  void setInactiveBitmap( WxBitmapBundle bitmap ) {
    _jsAnimSetInactive( _handle, bitmap.getBitmapFor( this )._handle );
  }
}
