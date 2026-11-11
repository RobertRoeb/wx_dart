// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxImage ----------------------

/// Resize quality for [WxImage.scale]: simplest and fastest algorithm
const int wxIMAGE_QUALITY_NEAREST = 5;

/// Resize quality: compromise between nearest and bicubic
const int wxIMAGE_QUALITY_BILINEAR = 1;

/// Resize quality: highest quality of the interpolating methods, but slowest
const int wxIMAGE_QUALITY_BICUBIC = 2;

/// Resize quality: averages the surrounding pixels, typically used when
/// reducing the size of an image
const int wxIMAGE_QUALITY_BOX_AVERAGE = 3;

/// Resize quality: default, currently the same as [wxIMAGE_QUALITY_NEAREST]
const int wxIMAGE_QUALITY_NORMAL = 0;

/// Resize quality: best algorithm. Box average if both new width and height
/// are smaller than the original size, otherwise bicubic.
const int wxIMAGE_QUALITY_HIGH = 4;

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
/// Example:
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
///   } );
/// ```
/// 
/// Constructors
/// * [WxImage]
/// * [WxImage.fromFile] (wxDart Native only)
/// * [WxImage.fromRGB]
/// * [WxImage.fromRGBA]
/// 
/// Get access to raw data
/// * [getData]
/// * [getAlphaData]
/// 
/// Convert to RGBA
/// * [getRGBA]
/// 
/// Basic checks
/// * [isOk]
/// * [getWidth]
/// * [getHeight]
/// 
/// Alpha channel
/// * [initAlpha]
/// * [hasAlpha]
/// * [clearAlpha]
/// 
/// Setting and getting values with range checks
/// * [setRGB]
/// * [setAlpha]
/// * [getRed]
/// * [getGreen]
/// * [getBlue]
/// * [getAlpha]
/// 
/// Scaling and cropping
/// * [scale]
/// * [getSubImage]

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

/// Creates an image with given [width] and [height] and copies
/// the data from an [rgb] buffer. 
/// 
/// The image is created with no alpha channel.
  WxImage.fromRGB( int width, int height, Uint8List rgb ) {
    _width = width;
    _height = height;

    _rgb = Uint8List(width * height * 3);
    for (int i = 0; i < width * height * 3; i++) {
      _rgb[i] = rgb[i];
    }
  }

/// Creates an image with given [width] and [height] and copies
/// the data from an [rgba] buffer. 
  WxImage.fromRGBA( int width, int height, Uint8List rgba ) {
    _width = width;
    _height = height;

    _rgb = Uint8List(width * height * 3);
    _alpha = Uint8List(width * height);
    int rgbaIndex = 0;
    int rgbIndex = 0;
    int alphaIndex = 0;
    for (int y = 0; y < _height; y++) {
      for (int x = 0; x < _width; x++) {
          _rgb[rgbIndex] = rgba[rgbaIndex];
          rgbaIndex++;
          rgbIndex++;
          _rgb[rgbIndex] = rgba[rgbaIndex];
          rgbaIndex++;
          rgbIndex++;
          _rgb[rgbIndex] = rgba[rgbaIndex];
          rgbaIndex++;
          rgbIndex++;
          _alpha![alphaIndex] = rgba[rgbaIndex];
          rgbaIndex++;
          alphaIndex++;
      }
    }
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

  /// Returns true if the image has an alpha channel
  bool hasAlpha() {
    return _alpha != null;
  }

  /// Clears the alpha channel if any is present
  void clearAlpha() {
    _alpha = null;
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
    return _alpha!.buffer.asByteData().getUint8( x + y*_width );
  }

  /// Replaces the colour specified by [r1],[g1],[b1] with [r2],[g2],[b2]
  void replace( int r1, int g1, int b1, int r2, int g2, int b2 ) {
    final rgb = getData();
    int rgbIndex = 0;
    for (int y = 0; y < getHeight(); y++) {
      for (int x = 0; x < getWidth(); x++) {
        if ((rgb[rgbIndex] == r1) && (rgb[rgbIndex+1] == g1) && (rgb[rgbIndex+2] == b1)) {
          rgb[rgbIndex] = r2;
          rgb[rgbIndex+1] = g2;
          rgb[rgbIndex+2] = b2;
        }
        rgbIndex += 3; 
      }
    }
  }

  /// Returns a deep copy of the image, or null if this
  /// image is not valid
  WxImage? copy( ) {
    if ((getWidth() < 1) || (getHeight() < 1)) {
      return null;
    }
    final image = WxImage( getWidth(), getHeight() );
    final data = image.getData();
    data.setAll(0, _rgb);
    if (_alpha != null) {
      image.initAlpha();
      final alpha = image.getAlphaData();
      alpha!.setAll(0,_alpha!);
    }
    return image;
  }

  /// Returns a subimage if [rect] fits completely in this image
  /// or null. The alpha channel is copied if present.
  WxImage? getSubImage( WxRect rect )
  {
    if (!isOk()) return null;
    if (rect.width <= 0 || rect.height <= 0) return null;
    if (rect.x < 0 || rect.y < 0 ||
        rect.x + rect.width > _width || rect.y + rect.height > _height) {
      return null;
    }

    final image = WxImage( rect.width, rect.height, clear: false );
    final dstRgb = image._rgb;
    final rowBytes = rect.width * 3;
    for (int row = 0; row < rect.height; row++) {
      final src = 3 * (rect.x + (rect.y + row) * _width);
      dstRgb.setRange( row * rowBytes, (row + 1) * rowBytes, _rgb, src );
    }

    final srcAlpha = _alpha;
    if (srcAlpha != null) {
      image.initAlpha();
      final dstAlpha = image._alpha!;
      for (int row = 0; row < rect.height; row++) {
        final src = rect.x + (rect.y + row) * _width;
        dstAlpha.setRange( row * rect.width, (row + 1) * rect.width, srcAlpha, src );
      }
    }
    return image;
  }

  /// Returns a scaled version of the image, or null if this
  /// image is not valid or the conversion failed.
  /// 
  /// # quality
  /// | constant | meaning |
  /// | -------- | -------- |
  /// | wxIMAGE_QUALITY_NORMAL | 0|
  /// | wxIMAGE_QUALITY_BILINEAR | 1 |
  /// | wxIMAGE_QUALITY_BICUBIC | 2 |
  /// | wxIMAGE_QUALITY_BOX_AVERAGE | 3 |
  /// | wxIMAGE_QUALITY_HIGH | 4 |
  /// | wxIMAGE_QUALITY_NEAREST | 5 |

  WxImage? scale( int width, int height, { int quality = wxIMAGE_QUALITY_NORMAL } )
  {
    if (!isOk() || width <= 0 || height <= 0 || _width <= 0 || _height <= 0) {
      return null;
    }

    if (width == _width && height == _height) return copy();

    switch (quality) {
      case wxIMAGE_QUALITY_HIGH:
        if (width < _width && height < _height) {
          return _resampleBox( width, height );
        }
        return _resampleBicubic( width, height );
      case wxIMAGE_QUALITY_BICUBIC:
        return _resampleBicubic( width, height );
      case wxIMAGE_QUALITY_BILINEAR:
        return _resampleBilinear( width, height );
      case wxIMAGE_QUALITY_BOX_AVERAGE:
        return _resampleBox( width, height );
      default:
        // NEAREST and NORMAL
        if (_width % width == 0 && _width >= width &&
            _height % height == 0 && _height >= height) {
          return _shrinkBy( _width ~/ width, _height ~/ height );
        }
        return _resampleNearest( width, height );
    }
  }

  late int _width;
  late int _height;
  late Uint8List _rgb;
  Uint8List? _alpha;
  final bool _hasMask = false;

  // Shrinks the image by integer factors, averaging each block of pixels
  // (C++: wxImage::ShrinkBy)
  WxImage _shrinkBy( int xFactor, int yFactor ) {
    final width = _width ~/ xFactor;
    final height = _height ~/ yFactor;
    final image = WxImage( width, height, clear: false );
    final dst = image._rgb;
    final srcAlpha = _alpha;
    Uint8List? dstAlpha;
    if (srcAlpha != null) {
      image.initAlpha();
      dstAlpha = image._alpha;
    }

    final count = xFactor * yFactor;
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        int r = 0, g = 0, b = 0, a = 0;
        for (int j = 0; j < yFactor; j++) {
          for (int i = 0; i < xFactor; i++) {
            final sx = x * xFactor + i;
            final sy = y * yFactor + j;
            final si = 3 * (sx + sy * _width);
            r += _rgb[si];
            g += _rgb[si + 1];
            b += _rgb[si + 2];
            if (srcAlpha != null) a += srcAlpha[sx + sy * _width];
          }
        }
        final di = 3 * (x + y * width);
        dst[di] = r ~/ count;
        dst[di + 1] = g ~/ count;
        dst[di + 2] = b ~/ count;
        if (dstAlpha != null) dstAlpha[x + y * width] = a ~/ count;
      }
    }
    return image;
  }

  // Nearest neighbour sampling with 16.16 fixed point arithmetic
  // (C++: the default branch of wxImage::Scale)
  WxImage _resampleNearest( int width, int height ) {
    final image = WxImage( width, height, clear: false );
    final dst = image._rgb;
    final srcAlpha = _alpha;
    Uint8List? dstAlpha;
    if (srcAlpha != null) {
      image.initAlpha();
      dstAlpha = image._alpha;
    }

    final xDelta = (_width << 16) ~/ width;
    final yDelta = (_height << 16) ~/ height;

    int di = 0;
    int da = 0;
    int y = 0;
    for (int j = 0; j < height; j++) {
      final srcRow = (y >> 16) * _width;
      int x = 0;
      for (int i = 0; i < width; i++) {
        final sp = srcRow + (x >> 16);
        dst[di] = _rgb[3 * sp];
        dst[di + 1] = _rgb[3 * sp + 1];
        dst[di + 2] = _rgb[3 * sp + 2];
        di += 3;
        if (dstAlpha != null) dstAlpha[da++] = srcAlpha![sp];
        x += xDelta;
      }
      y += yDelta;
    }
    return image;
  }

  // Box averaging, meant for shrinking (C++: wxImage::ResampleBox).
  //
  // With an alpha channel the colours are weighted by alpha, so transparent
  // pixels (often black) don't darken the edges of the result.
  WxImage _resampleBox( int width, int height ) {
    final image = WxImage( width, height, clear: false );
    final dst = image._rgb;
    final srcAlpha = _alpha;
    Uint8List? dstAlpha;
    if (srcAlpha != null) {
      image.initAlpha();
      dstAlpha = image._alpha;
    }

    final scaleX = _width / width;
    final scaleY = _height / height;

    for (int y = 0; y < height; y++) {
      int y0 = (y * scaleY).floor();
      int y1 = ((y + 1) * scaleY).ceil();
      if (y1 <= y0) y1 = y0 + 1;
      if (y1 > _height) y1 = _height;
      if (y0 >= y1) y0 = y1 - 1;

      for (int x = 0; x < width; x++) {
        int x0 = (x * scaleX).floor();
        int x1 = ((x + 1) * scaleX).ceil();
        if (x1 <= x0) x1 = x0 + 1;
        if (x1 > _width) x1 = _width;
        if (x0 >= x1) x0 = x1 - 1;

        double r = 0, g = 0, b = 0, a = 0, wsum = 0;
        for (int j = y0; j < y1; j++) {
          for (int i = x0; i < x1; i++) {
            final si = 3 * (i + j * _width);
            final w = srcAlpha != null ? srcAlpha[i + j * _width].toDouble() : 1.0;
            r += w * _rgb[si];
            g += w * _rgb[si + 1];
            b += w * _rgb[si + 2];
            a += srcAlpha != null ? w : 0.0;
            wsum += w;
          }
        }
        final count = (x1 - x0) * (y1 - y0);
        final di = 3 * (x + y * width);
        _storePixel( dst, di, dstAlpha, x + y * width, r, g, b, a, wsum, count );
      }
    }
    return image;
  }

  // Writes one resampled pixel. [r], [g], [b] are sums of weight*colour,
  // [a] the sum of weight*alpha (only with alpha channel), [wsum] the sum of
  // the colour weights (weight is alpha with alpha channel, otherwise 1)
  // and [count] the number of source pixels (alpha channel average).
  static void _storePixel( Uint8List dst, int di, Uint8List? dstAlpha, int ai,
      double r, double g, double b, double a, double wsum, int count ) {
    if (wsum > 0) {
      dst[di] = (r / wsum).round().clamp( 0, 255 );
      dst[di + 1] = (g / wsum).round().clamp( 0, 255 );
      dst[di + 2] = (b / wsum).round().clamp( 0, 255 );
    } else {
      dst[di] = 0;
      dst[di + 1] = 0;
      dst[di + 2] = 0;
    }
    if (dstAlpha != null) {
      dstAlpha[ai] = (a / count).round().clamp( 0, 255 );
    }
  }

  // Bilinear interpolation (C++: wxImage::ResampleBilinear)
  WxImage _resampleBilinear( int width, int height ) =>
      _resampleSeparable( width, height, 0, 1, _bilinearWeight );

  // Bicubic interpolation with the cubic B-spline kernel
  // (C++: wxImage::ResampleBicubic)
  WxImage _resampleBicubic( int width, int height ) =>
      _resampleSeparable( width, height, -1, 2, _splineWeight );

  static double _bilinearWeight( double offset ) {
    final d = offset.abs();
    return d < 1.0 ? 1.0 - d : 0.0;
  }

  static double _splineCube( double value ) => value <= 0.0 ? 0.0 : value * value * value;

  // Weight of the cubic B-spline for the distance [value]
  static double _splineWeight( double value ) =>
      (_splineCube( value + 2 ) - 4 * _splineCube( value + 1 ) +
          6 * _splineCube( value ) - 4 * _splineCube( value - 1 )) / 6;

  // Calculates for every pixel of one target axis the source indices
  // ([first]..[last] taps relative to the left source pixel) and their
  // weights. Indices are clamped to the image, weights are normalised.
  static ( Int32List, Float64List ) _axisTaps( int srcSize, int dstSize,
      int first, int last, double Function( double ) weight ) {
    final taps = last - first + 1;
    final idx = Int32List( dstSize * taps );
    final w = Float64List( dstSize * taps );
    final scale = srcSize / dstSize;
    for (int d = 0; d < dstSize; d++) {
      // pixel centres are at +0.5
      final src = (d + 0.5) * scale - 0.5;
      final base = src.floor();
      final frac = src - base;
      double sum = 0;
      for (int k = 0; k < taps; k++) {
        final tap = first + k;
        final wk = weight( tap - frac );
        w[d * taps + k] = wk;
        sum += wk;
        idx[d * taps + k] = (base + tap).clamp( 0, srcSize - 1 );
      }
      if (sum != 0) {
        for (int k = 0; k < taps; k++) {
          w[d * taps + k] /= sum;
        }
      }
    }
    return ( idx, w );
  }

  // Common code of bilinear and bicubic. The kernel covers the taps
  // [first]..[last] around the left source pixel.
  //
  // With an alpha channel the colours are weighted by alpha, see [_resampleBox].
  WxImage _resampleSeparable( int width, int height, int first, int last,
      double Function( double ) weight )
  {
    final image = WxImage( width, height, clear: false );
    final dst = image._rgb;
    final srcAlpha = _alpha;
    Uint8List? dstAlpha;
    if (srcAlpha != null) {
      image.initAlpha();
      dstAlpha = image._alpha;
    }

    final taps = last - first + 1;
    final (xIdx, xW) = _axisTaps( _width, width, first, last, weight );
    final (yIdx, yW) = _axisTaps( _height, height, first, last, weight );

    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        double r = 0, g = 0, b = 0, a = 0, wsum = 0;
        for (int ky = 0; ky < taps; ky++) {
          final sy = yIdx[y * taps + ky];
          final wy = yW[y * taps + ky];
          for (int kx = 0; kx < taps; kx++) {
            final sx = xIdx[x * taps + kx];
            final wgt = wy * xW[x * taps + kx];
            final si = 3 * (sx + sy * _width);
            final alpha = srcAlpha != null ? srcAlpha[sx + sy * _width] : 255;
            final wc = srcAlpha != null ? wgt * alpha : wgt;
            r += wc * _rgb[si];
            g += wc * _rgb[si + 1];
            b += wc * _rgb[si + 2];
            wsum += wc;
            a += wgt * alpha;
          }
        }
        // alpha is the weighted sum itself (weights sum to 1), so count is 1
        _storePixel( dst, 3 * (x + y * width), dstAlpha, x + y * width, r, g, b, a, wsum, 1 );
      }
    }
    return image;
  }
}
