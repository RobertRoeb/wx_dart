// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-11-15
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxBitmapBundle ----------------------

/// A bitmap in (possibly) several resolutions, used by [WxToolBar].
///
/// In wxDart Web, the browser does the scaling: an SVG bundle is
/// rendered sharply at any size and device pixel ratio, a PNG bundle is
/// drawn at its default size. Disabled tools are greyed out with CSS, so
/// [makeDisabled] returns the bundle itself.
class WxBitmapBundle extends WxClass {
  /// Creates a bitmap bundle from a single bitmap.
  WxBitmapBundle(WxBitmap bitmap) {
    _bitmap = bitmap;
  }

  /// Creates a bitmap bundle from a single [WxBitmap]
  WxBitmapBundle.fromBitmap(WxBitmap bitmap) {
    _bitmap = bitmap;
  }

  /// Creates a bitmap bundle from two bitmaps. A control or some
  /// other code would later pick the right one based on DPI.
  ///
  /// The browser picks the best one, so only the first bitmap is used
  WxBitmapBundle.fromBitmaps(WxBitmap bitmap1, WxBitmap bitmap2) {
    _bitmap = bitmap1;
  }

  /// Creates a bitmap bundle from a single [WxImage]
  WxBitmapBundle.fromImage(WxImage image) {
    _bitmap = WxBitmap.fromImage(image);
  }

  /// Creates a bitmap bundle from a PNG.
  ///
  /// [path] is relative to [WxStandardPaths.getResourcesDir]
  ///
  /// Example:
  /// ```dart
  /// // create bitmap bundle from lib/assets/images/MyImage.png
  /// final bitmap = WxBitmapBundle.fromPNGAsset( "images/MyImage.png" );
  /// ```
  WxBitmapBundle.fromPNGAsset(String path) {
    _bitmap = WxBitmap.fromAsset(path, wxBITMAP_TYPE_PNG);
  }

  /// Creates a bitmap bundle from a JPEG image.
  ///
  /// [path] is relative to [WxStandardPaths.getResourcesDir]
  ///
  /// Example:
  /// ```dart
  /// // create bitmap bundle from lib/assets/images/MyImage.jpg
  /// final bitmap = WxBitmapBundle.fromJPEGAsset( "images/MyImage.jpg" );
  /// ```
  WxBitmapBundle.fromJPEGAsset(String path) {
    _bitmap = WxBitmap.fromAsset(path, wxBITMAP_TYPE_JPEG);
  }

  /// Creates a bitmap bundle from an SVG image with the
  /// size given in [sizeDef].
  ///
  /// [path] is relative to [WxStandardPaths.getResourcesDir]
  ///
  /// Example:
  /// ```dart
  /// // create bitmap bundle from lib/assets/images/MyImage.svg
  /// final bitmap = WxBitmapBundle.fromSVGAsset( "images/MyImage.svg", WxSize(20,20) );
  /// ```
  WxBitmapBundle.fromSVGAsset(String path, WxSize sizeDef) {
    _bitmap = WxBitmap.fromAsset(path, wxBITMAP_TYPE_ANY);
    _defaultSize = sizeDef;
  }

  /// Creates a bitmap bundle from an SVG string
  WxBitmapBundle.fromSVG(String svg, WxSize sizeDef) {
    _bitmap = WxBitmap.fromUrl("data:image/svg+xml;charset=utf-8,${Uri.encodeComponent(svg)}");
    _defaultSize = sizeDef;
  }

  /// Creates a bitmap bundle from one of more than 2000 included Material icons. If
  /// no colour is given, the icon will have the accent colour of the app in
  /// wxDart Flutter and will be grey in wxDart Native. Some platforms enforce
  /// colours in bitmaps in [WxToolBar] or e.g. in [WxNavigationCtrl].
  WxBitmapBundle.fromMaterialIcon(WxMaterialIcon icon, WxSize size, {WxColour? colour}) {
    _bitmap = WxBitmap.fromMaterialIcon(icon, size, colour);
    _defaultSize = size;
  }

  late WxBitmap _bitmap;
  WxSize? _defaultSize;

  /// For a material icon following the accent colour: the same icon in a
  /// colour readable on the accent colour, otherwise null
  WxBitmapBundle? _themedOnAccent() {
    final b = _bitmap;
    if (b._materialIcon == null || b._materialIconColour != null) return null;
    final bundle = WxBitmapBundle(b._onAccentCopy());
    bundle._defaultSize = _defaultSize;
    return bundle;
  }

  /// This methods is called by controls to pick the right
  /// bitmap if two (or more) are bitmaps are available.
  ///
  /// Picks bitmap based on [WxWindow.getDPIScaleFactor] from [window]
  ///
  /// The bitmap (the browser scales it as needed)
  WxBitmap getBitmapFor(WxWindow window) {
    return _bitmap;
  }

  // the last scaled copy (getBitmapForSize, getBitmap)
  WxBitmap? _scaledBitmap;
  WxSize _scaledPixels = WxSize.zero;
  double? _scaledScale;

  WxBitmap _scaledCopy(int width, int height, double? scale) {
    final cached = _scaledBitmap;
    if (cached != null && _scaledPixels.x == width && _scaledPixels.y == height && _scaledScale == scale) {
      return cached;
    }
    final copy = WxBitmap._scaled(_bitmap, width, height, scale);
    _scaledBitmap = copy;
    _scaledPixels = WxSize(width, height);
    _scaledScale = scale;
    return copy;
  }

  /// Returns bitmap for given size taking the window's DPI into
  /// account. While [getBitmap] is essentially an internal
  /// method needed when the DPI changes, this will create a
  /// bitmap with a smaller size on screen. [dipSize] is the
  /// logical size, not the size in pixels
  WxBitmap getBitmapForSize(WxWindow window, WxSize dipSize) {
    // like wxDart Flutter and Native: really scaled to the logical size,
    // with the scale factor of the window
    final scale = window.getDPIScaleFactor();
    final width = max(1, (dipSize.x * scale).round());
    final height = max(1, (dipSize.y * scale).round());
    if (_bitmap.isOk() && _bitmap.getWidth() == width && _bitmap.getHeight() == height &&
        _bitmap.getScaleFactor() == scale) {
    return _bitmap;
  }
    return _scaledCopy(width, height, scale);
  }

  /// Returns bitmap of the specified size, creating a new bitmap if necessary.
  /// It also calculates the scaling factor of the new bitmap based on the
  /// height ratio.
  WxBitmap getBitmap(WxSize size) {
    if (size.x <= 0 || size.y <= 0) return _bitmap;    // wxDefaultSize
    if (_bitmap.isOk() && _bitmap.getWidth() == size.x && _bitmap.getHeight() == size.y) {
    return _bitmap;
  }
    return _scaledCopy(size.x, size.y, null);
  }

  /// Returns the size of the unscaled smallest bitmap (at 100% DPI)
  WxSize getDefaultSize() {
    return _defaultSize ?? WxSize(_bitmap.getWidth(), _bitmap.getHeight());
  }

  /// Size on screen in logical pixels: the default size if given, otherwise
  /// the size of the bitmap divided by its scale factor. The default size
  /// must not be divided by the scale factor, it is a logical size already.
  WxSize _logicalSize() {
    final def = _defaultSize;
    if (def != null && def.x > 0 && def.y > 0) return def;
    return WxSize(_bitmap.getLogicalWidth().round(), _bitmap.getLogicalHeight().round());
  }

  bool isOk() {
    return !_bitmap.hasFailed();
  }

  /// Create a new bitmap bundle with greyed out bitmaps
  ///
  /// Disabled tools are greyed out with CSS
  WxBitmapBundle makeDisabled() {
    return this;
  }
}
