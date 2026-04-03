// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxImage ----------------------

/// This class encapsulates a platform-independent image.
///
/// An image can be created directly from data or from a file in a
/// variety of formats. Functions are available to set and get image
/// bits, so it can be used for basic image manipulation.
/// 
/// The various image manipulation functions of the wxWidgets C++
/// library like _blur_ and _resize_ are not yet available in wxDart. 
///
/// A WxImage cannot be drawn directly to a [WxDC]. Instead, a platform-specific
/// [WxBitmap] object must be created from it using [WxBitmap.fromImage]. This
/// is an expensive operation and should not be done in the paint event handler.
/// This bitmap can then be drawn in a device context, using [WxDC.drawBitmap].
/// 
/// Here is how you create an image and set pixels and alpha channel values:
/// ```dart
///    final image = WxImage( 100, 200 );
///    image.initAlpha();
///    for (int y = 5; y < 195; y++) {
///        for (int x = 5; x < 95; x++) {
///          image.setRGB(x, y, 50+y, 100, 100 );
///          image.setAlpha(x, y, 50+y );
///        }
///    }
/// ```
/// 
/// You can also get raw access to the RGB and alpha data and write
/// to that directly:
/// ```dart
///    // make top 20 rows white
///    final data = image.getData();
///    for (int i = 0; i < 100*20*3; i++) {
///        data.setUint8(i, 255);
///    }
/// ```

class WxImage extends WxObject {
/// Creates an image with given [width] and [height] and clears it to black
/// depending on the [clear] parameter. 
/// 
/// If [clear] is false, then the initial state is undefined.
/// 
/// The image is created with no alpha channel. Call [initAlpha] to create one.
  WxImage( int width, int height, { bool clear=true } ) {
    _width = width;
    _height = height;
    if (clear) {
      _rgb = Uint8List.fromList( List.filled(width * height * 3, 0) );
    } else {
      // cannot find a way not to initiaĺize it
      _rgb = Uint8List.fromList( List.filled(width * height * 3, 0) );
    }
  }

  /// Returns width of the image
  int getWidth() {
    return _width;
  }

  /// Returns height of the image
  int getHeight() {
    return _height; 
  }

  /// Creates an alpha channel for the image and initialize it to
  /// be opaque (alpha value of 255)
  void initAlpha() {
    if (_hasMask) {
      _alpha = Uint8List.fromList( List.filled(_width * _height, 0) );
    } else {
      _alpha = Uint8List.fromList( List.filled(_width * _height, 255) );
    }
  }

/// Returns reference to image data allowing you to write to the 
/// RGB data directly. This is supported on all platforms 
/// including the web.
/// 
/// ```dart
///    // make top 20 rows white
///    final data = image.getData();
///    for (int i = 0; i < image.getWidth()*20*3; i++) {
///        data.setUint8(i, 255);
///    }
/// ```
  ByteData getData() {
    return _rgb.buffer.asByteData();
  }

/// Returns reference to alpha channel allowing you to write to the 
/// data directly. This is supported on all platforms 
/// including the web.
/// 
/// ```dart
///    // make top 20 rows transparent
///    final data = image.getAlphaData();
///    for (int i = 0; i < image.getWidth()*20; i++) {
///        data.setUint8(i, 0);
///    }
/// ```
  ByteData? getAlphaData() {
    if (_alpha == null) return null;
    return _alpha!.buffer.asByteData();
  }

/// Set colour of pixel at [x],[y] to given RGB. Checks before
/// if [x],[y] are on the image.
  void setRGB( int x, int y, int r, int g, int b ) {
    if ((x < 0) || (x >= _width) || (y < 0) || (y >= _height)) return;
    _rgb.buffer.asByteData().setUint8( 3*(x + y*_width), r );
    _rgb.buffer.asByteData().setUint8( 1 + 3*(x + y*_width), g );
    _rgb.buffer.asByteData().setUint8( 2 + 3*(x + y*_width), b );
  }

/// Set alpha value of pixel at [x],[y] to given value. Checks before
/// if [x],[y] are on the image. 0 indicates full transparancy. 255 is opaque.
  void setAlpha( int x, int y, int alpha ) {
    if (_alpha == null) return;
    if ((x < 0) || (x >= _width) || (y < 0) || (y >= _height)) return;
    _alpha!.buffer.asByteData().setUint8( (x + y*_width), alpha );
  }

/// Returns red channel component of pixel at [x],[y]. Checks before
/// if [x],[y] are on the image and returns 0 otherwise.
  int getRed( int x, int y ) {
    if ((x < 0) || (x >= _width) || (y < 0) || (y >= _height)) return 0;
    return _rgb.buffer.asByteData().getUint8( 3*(x + y*_width) );
  }

/// Returns green channel component of pixel at [x],[y]. Checks before
/// if [x],[y] are on the image and returns 0 otherwise.
  int getGreen( int x, int y ) {
    if ((x < 0) || (x >= _width) || (y < 0) || (y >= _height)) return 0;
    return _rgb.buffer.asByteData().getUint8( 1 + 3*(x + y*_width) );
  }

/// Returns blue channel component of pixel at [x],[y]. Checks before
/// if [x],[y] are on the image and returns 0 otherwise.
  int getBlue( int x, int y ) {
    if ((x < 0) || (x >= _width) || (y < 0) || (y >= _height)) return 0;
    return _rgb.buffer.asByteData().getUint8( 2 + 3*(x + y*_width) );
  }

/// Returns alpha channel component of pixel at [x],[y]. Checks before
/// if image has an alpha channel and if [x],[y] are on the image and
/// returns 0 otherwise.
  int getAlpha( int x, int y ) {
    if (_alpha == null) return 0;
    if ((x < 0) || (x >= _width) || (y < 0) || (y >= _height)) return 0;
    return _alpha!.buffer.asByteData().getUint8( 2 + (x + y*_width) );
  }

  late int _width;
  late int _height;
  late Uint8List _rgb;
  Uint8List? _alpha;
  final bool _hasMask = false;
}
