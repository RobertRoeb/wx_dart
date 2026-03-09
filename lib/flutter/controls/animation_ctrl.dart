// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
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

class WxAnimationCtrl extends WxControl {
  WxAnimationCtrl( super.parent, super.id, WxAnimation animation, {  super.pos = wxDefaultPosition, super.size = wxDefaultSize, super.style = wxAC_DEFAULT_STYLE } ) {
    _animation = animation;
    _controller = GifController();
  }

  late WxAnimation _animation;
  late GifController _controller;
  WxBitmap? _inactiveBitmap;

  /// Starts or continues to play the animation
  void play( ) {
    _controller.play();
    _setState();
  }

  /// Returns true if currently playing
  bool isPlaying( ) {
    return _controller.status == GifStatus.playing;
  }

  /// Stops the animation
  void stop( ) {
    _controller.stop();
    _setState();
  }

  /// Bitmap shown when animation is not playing
  void setInactiveBitmap( WxBitmapBundle bitmap ) {
    _inactiveBitmap = bitmap.getBitmapFor( this );
  }

  @override
  Widget _build( BuildContext context )
  {
    if ((_inactiveBitmap != null) && !isPlaying()) {
      if (_inactiveBitmap!.isOk()) {
        return _buildControl( context,
          RawImage( image: _inactiveBitmap!._image! ) );
      } 
      _inactiveBitmap!._addListener( this );
      return CircularProgressIndicator();
    }

    return _buildControl( context, 
      GifView.asset(
         _animation._path,
         controller: _controller,
         autoPlay: false,
       ) 
    );
  }
}