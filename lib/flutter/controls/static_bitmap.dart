// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxStaticBitmap ----------------------

const int scaleNone = 0;
const int scaleFill = 1;
const int scaleAspectFit = 2;
const int scaleAspectFill = 3;
const int wxBI_EXPAND = wxEXPAND;

/// Shows a bitmap and optionally scales it.
/// 
/// # Scale mode constants
/// | constant | meaning |
/// | -------- | -------- |
/// | scaleNone | 0 the default, don't scale and place the image in the top left corder |
/// | scaleFill | 1, fill control with image no matter the aspect ratio |
/// | scaleAspectFit | 2, whole image visiable, possibly smaller than control |
/// | scaleAspectFill | 3, whole control filled, image possibly clipped |
/// 
/// # Window style
/// [ constant | meaning |
/// | -------- | -------- |
/// | wxBI_EXPAND | wxEXPAND |
/// 
class WxStaticBitmap extends WxControl {
  WxStaticBitmap( super._parent, super._id, WxBitmapBundle bitmap, { super.pos = wxDefaultPosition, super.size = wxDefaultSize, super.style = 0 } ) {
    _bitmap = bitmap.getBitmapFor( this );
  }

  late WxBitmap _bitmap;
  int _scaleMode = scaleNone;

  @override
  Widget _build( BuildContext context ) {
    BoxFit fit = BoxFit.none;
    if (_scaleMode == scaleFill) {
      fit = BoxFit.fill;
    } else 
    if (_scaleMode == scaleAspectFill) {  
      fit = BoxFit.fitWidth;
    } else 
    if (_scaleMode == scaleAspectFit) {
      fit = BoxFit.contain;
    }

    if (_bitmap.isOk()) {
      return RawImage( image: _bitmap._image!, fit: fit, alignment: Alignment.topLeft );
    } 
    _bitmap._addListener( this );
    return CircularProgressIndicator();
  }

/// Sets the scale mode of the bitmap relative to the size of the control.
/// ## Scale mode constants
/// | constant | meaning |
/// | -------- | -------- |
/// | scaleNone | 0 the default, don't scale and place the image in the top left corder |
/// | scaleFill | 1, fill control with image no matter the aspect ratio |
/// | scaleAspectFit | 2, whole image visiable, possibly smaller than control |
/// | scaleAspectFill | 3, whole control filled, image possibly clipped |
  void setScaleMode( int mode ) {
    _scaleMode = mode;
  }

  /// Returns the scale mode (see [setScaleMode])
  int getScaleMode() {
    return _scaleMode;
  }
}