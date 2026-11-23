// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01 (wxDart Web: 2026-11-15)
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
/// Without a size, the control takes the size of the bitmap. Bitmaps from
/// assets or URLs are loaded asynchronously: until then the control is
/// empty, afterwards it gets the size of the bitmap and the sizers lay
/// out the window again.
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
/// | wxBI_EXPAND | wxEXPAND (this does nothing) |
///
/// Example:
/// ```dart
///    // create WxStaticBitmap from lib/assets/images/MyImage.png
///    final statbitmap = WxStaticBitmap( this, -1, WxBitmapBundle.fromPNGAsset("images/MyImage.png") );
///    statbitmap.setScaleMode( scaleAspectFit );
/// ```
class WxStaticBitmap extends WxControl {
  // _bundle is set in the initializer list: the WxWindow constructor
  // already asks for the best size
  WxStaticBitmap( super._parent, super._id, WxBitmapBundle bitmap, { super.pos = wxDefaultPosition, super.size = wxDefaultSize, super.style = 0 } )
  : _bundle = bitmap {
    setBitmap( bitmap );
  }

  WxBitmapBundle _bundle;
  int _scaleMode = scaleNone;

  @override
  String get _jsKind => 'staticbitmap';

  /// Sets the bitmap
  void setBitmap( WxBitmapBundle bitmap ) {
    _bundle = bitmap;
    _update();
    invalidateBestSize();
    // the size is only known when the bitmap has been loaded
    _updateWhenLoaded( bitmap.getBitmapFor( this ), () {
      if (identical( _bundle, bitmap )) _update();
    } );
  }

  /// Returns the bitmap
  WxBitmap getBitmap() {
    return _bundle.getBitmapFor( this );
  }

  void _update() {
    final bitmap = _bundle.getBitmapFor( this );
    final size = _logicalSize();
    _jsStaticBitmapSet( _handle, bitmap._handle, size.x, size.y, _scaleMode );
  }

  WxSize _logicalSize() {
    return _bundle._logicalSize();
  }

  @override
  WxSize _doGetBestSize() {
    final size = _logicalSize();
    return WxSize( max( size.x, 1 ), max( size.y, 1 ) );
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
    _update();
  }

  /// Returns the scale mode (see [setScaleMode])
  int getScaleMode() {
    return _scaleMode;
  }
}
