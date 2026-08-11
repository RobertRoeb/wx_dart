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
/// WxImage stores the image data as pure RGB with a separate
/// data block containing the alpha data (if any). If you need the
/// RGBA data as a single block, call [getRGBA].
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
///    final rgb = image.getData();
///    for (int i = 0; i < 100*20*3; i++) {
///        data[i] = 255;
///    }
/// ```
/// 
/// See [wxLoadImageFromResource] loading a [WxImage] directly from
/// resources/assets:
/// 
/// ```dart
///   wxLoadImageFromResource( "myimage.png", (image) {
///     // do something with image ...
///   }
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

    // There is no way not to initiaĺize the memory
    // if (clear)
    _rgb = Uint8List(width * height * 3);
  }

  /// Returns true of the image has been built correctly
  bool isOk() {
    return _width * _height * 3 == _rgb.lengthInBytes;
  }

  /// Only implemented in wxDart Native. Load an image directly from a file.
  /// 
  /// Use [wxLoadImageFromResource] for the same effect in wxDart Flutter and
  /// wxDart Native.
  WxImage.fromFile( String file, int format, { int index = -1 } ) {
    wxLogError( "Not implemented in wxDart Flutter. Use wxLoadImageFromResource()." );
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
      _alpha = Uint8List( _width * _height );  // gets zeroed
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
///    final rgb = image.getData();
///    final data = rgb.buffer.asByteData();
///    for (int i = 0; i < image.getWidth()*20*3; i++) {
///        data.setUint8(i, 255);
///    }
/// ```
  Uint8List getData() {
    return _rgb;
  }

/// Returns reference to alpha channel allowing you to write to the 
/// data directly. This is supported on all platforms 
/// including the web.
/// 
/// ```dart
///    // make top 20 rows transparent
///    final alpha = image.getAlphaData();
///    final data = alpha.buffer.asByteData();
///    for (int i = 0; i < image.getWidth()*20; i++) {
///        data.setUint8(i, 0);
///    }
/// ```
  Uint8List? getAlphaData() {
    return _alpha;
  }

/// Creates a pure RGBA data from an [WxImage]. This is an expansive
/// operation as the entire data needs to be copied in both wxDart
/// Flutter and wxDart Native.
Uint8List getRGBA()
{
  final rgba = Uint8List( getWidth() * getHeight() * 4 );
  final rgb = getData();
  final alpha = getAlphaData();
  int rgbIndex = 0;
  int rgbaIndex = 0;
  int alphaIndex = 0;
  for (int y = 0; y < getHeight(); y++) {
    for (int x = 0; x < getWidth(); x++) {
      rgba[rgbaIndex] = rgb[rgbIndex];
      rgbaIndex++;
      rgbIndex++;
      rgba[rgbaIndex] = rgb[rgbIndex];
      rgbaIndex++;
      rgbIndex++;
      rgba[rgbaIndex] = rgb[rgbIndex];
      rgbaIndex++;
      rgbIndex++;
      if (alpha != null) {
        rgba[rgbaIndex] = alpha[alphaIndex];
        alphaIndex++;
      } else {
        rgba[rgbaIndex] = 255;
      }
      rgbaIndex++;
      }
    }
  return rgba;
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
