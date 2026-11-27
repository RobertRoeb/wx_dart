// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-11-15
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxBitmap ----------------------

int _nextBitmapHandle = 1;
final Map<int, WxBitmap> _bitmapsByHandle = {};

/// A bitmap, either downloaded from the server (asynchronously, like
/// assets in Flutter web; decoding is done by the browser) or created
/// from a [WxImage] (synchronously).
///
/// A [WxBitmap] can be used immediately: drawing it before it has been
/// loaded draws nothing, and every window that tried to draw it is
/// refreshed once it has arrived. Alternatively, wait for [ready]:
///
/// ```dart
///   // downloads assets/images/logo.png
///   final logo = WxBitmap.fromAsset("images/logo.png", wxBITMAP_TYPE_PNG);
///
///   // in a paint handler
///   dc.drawBitmap(logo, 10, 10);
///
///   // or, explicitly
///   final bitmap = await WxBitmap.load("images/logo.png");
///   if (bitmap.isOk()) { ... }
/// ```
class WxBitmap extends WxObject {
  /// Loads in image from a resource with the given format.
  ///
  /// [path] is relative to [WxStandardPaths.getResourcesDir]
  ///
  /// # Image file format constants
  /// * wxBITMAP_TYPE_BMP
  /// * wxBITMAP_TYPE_GIF
  /// * wxBITMAP_TYPE_PNG
  /// * wxBITMAP_TYPE_JPEG
  /// * wxBITMAP_TYPE_WEBP
  /// * wxBITMAP_TYPE_ANY
  ///
  /// Example:
  /// ```dart
  ///    // create bitmap from lib/assets/images/MyImage.png
  ///    final bitmap = WxBitmap.fromAsset( "images/MyImage.png", wxBITMAP_TYPE_PNG );
  /// ```
  WxBitmap.fromAsset(String path, int format)
      : this.fromUrl("${wxGetStandardPaths().getResourcesDir()}/$path");

  /// Loads an image from any URL the browser can fetch
  WxBitmap.fromUrl(String url) {
    _handle = _nextBitmapHandle++;
    _bitmapsByHandle[_handle] = this;
    _jsLoadImage(_handle, url);
  }

  /// A bitmap whose image is a canvas that wxc.js already created
  /// (used by WxMemoryDC)
  WxBitmap._fromCanvas(int handle, int width, int height) {
    _handle = handle;
    _bitmapsByHandle[_handle] = this;
    _loaded = true;
    _width = width;
    _height = height;
    _completer.complete(this);
  }

  /// Creates a bitmap with a given size. This is actually
  /// not supported on all platforms.
  WxBitmap(int width, int height, {int depth = 24}) {
    final rgba = Uint8List(width * height * 4);
    for (int i = 3; i < rgba.length; i += 4) {
      rgba[i] = 255;
    }
    _initFromRGBA(width, height, rgba);
  }

  /// Creates a bitmap from an [WxImage]
  ///
  /// Creates a bitmap from a [WxImage] (including its alpha channel).
  /// This copies the pixels into an HTML canvas; do not do this in a
  /// paint handler. The bitmap is available immediately.
  WxBitmap.fromImage(WxImage image) {
    _initFromRGBA(image.getWidth(), image.getHeight(), image.getRGBA());
  }

  /// Creates a bitmap from one of more than 2000 included Material icons. If
  /// no colour is given, the icon will have the accent colour of the app in
  /// wxDart Flutter and will be grey in wxDart Native.
  WxBitmap.fromMaterialIcon(WxMaterialIcon icon, WxSize size, WxColour? colour) {
    _handle = _nextBitmapHandle++;
    _bitmapsByHandle[_handle] = this;
    _materialIcon = icon;
    _materialIconSize = size;
    _materialIconColour = colour;
    if (colour == null) _themedIcons.add(this);
    _renderMaterialIcon();
    _completer.complete(this);
  }

  /// Waits until the bitmap has been loaded, at most [maxMillis]
  /// milliseconds. Returns [isOk] afterwards.
  ///
  /// Bitmaps are loaded or built asynchronously in wxDart Web (assets,
  /// URLs) and wxDart Flutter (also bitmaps from a WxMemoryDC); in
  /// wxDart Native this returns immediately. 
  Future<bool> waitUntilOk({int maxMillis = 2000}) async {
    if (!_loaded && !_failed) {
      await ready.timeout(Duration(milliseconds: maxMillis), onTimeout: () => this);
    }
    return _loaded;
  }
  
  WxMaterialIcon? _materialIcon;
  WxSize _materialIconSize = WxSize.zero;
  WxColour? _materialIconColour;
  bool _onAccent = false;   // drawn on the accent colour (button of the FAB)
  WxSize? _materialPixelSize;   // scaled copies: size in pixels
  double? _materialScale;       // scaled copies: scale factor

  /// A copy of [source] with [width] x [height] pixels, see
  /// [WxBitmapBundle.getBitmapForSize] and [WxBitmapBundle.getBitmap].
  /// [scale] is the scale factor of the copy; if null, it is the ratio of
  /// the heights, like in wxDart Flutter. Material icons are drawn again at
  /// the new size (and keep following the accent colour), other bitmaps
  /// are scaled once [source] has been loaded.
  WxBitmap._scaled(WxBitmap source, int width, int height, double? scale) {
    _handle = _nextBitmapHandle++;
    _bitmapsByHandle[_handle] = this;
    final icon = source._materialIcon;
    if (icon != null) {
      _materialIcon = icon;
      _materialIconSize = source._materialIconSize;
      _materialIconColour = source._materialIconColour;
      _onAccent = source._onAccent;
      _materialPixelSize = WxSize(width, height);
      _materialScale = scale ?? height / max(1, source.getHeight());
      if (_materialIconColour == null) _themedIcons.add(this);
      _renderMaterialIcon();
      _completer.complete(this);
      return;
    }
    void build() {
      if (source.hasFailed() || !_bitmapsByHandle.containsKey(source._handle)) {
        _failed = true;
      } else {
        _jsScaleImage(_handle, source._handle, width, height);
        _loaded = true;
        _width = width;
        _height = height;
        _scaleFactor = scale ?? height / max(1, source.getHeight());
      }
      if (!_completer.isCompleted) _completer.complete(this);
    }
    if (source.isOk() || source.hasFailed()) {
      build();
    } else {
      // repaint windows waiting for this copy, like for a loading bitmap
      source.ready.then((_) {
        build();
        for (final window in _listeners) {
          if (!window._isDestroyed) window.refresh();
        }
        _listeners.clear();
      });
    }
  }

  /// The same themed icon, but readable on the accent colour
  WxBitmap _onAccentCopy() {
    final copy = WxBitmap.fromMaterialIcon(_materialIcon!, _materialIconSize, null);
    copy._onAccent = true;
    copy._renderMaterialIcon();
    return copy;
  }

  void _renderMaterialIcon() {
    final icon = _materialIcon!;
    if (!icon.hasOutline && !_warnedAboutMaterialIcons) {
      _warnedAboutMaterialIcons = true;
      wxLogWarning("Material icons have no outlines yet: run tool/generate_material_icons.py");
    }
    final pixels = _materialPixelSize;
    final dpr = _materialScale ?? _jsDevicePixelRatio();
    final width = max(1, pixels?.x ?? (_materialIconSize.x * dpr).round());
    final height = max(1, pixels?.y ?? (_materialIconSize.y * dpr).round());
    final colour = _materialIconColour ?? _defaultIconColour(onAccent: _onAccent);
    _jsIconFromPaths(_handle, icon._paths, width, height, _cssColour(colour));
    _loaded = true;
    _failed = false;
    _width = width;
    _height = height;
    _scaleFactor = dpr;
  }

  /// wxDart Web only: creates a bitmap from RGBA data
  WxBitmap.fromRGBA(int width, int height, Uint8List rgba) {
    _initFromRGBA(width, height, rgba);
  }

  void _initFromRGBA(int width, int height, Uint8List rgba) {
    _handle = _nextBitmapHandle++;
    _bitmapsByHandle[_handle] = this;
    if (rgba.length < width * height * 4) {
      wxLogError("WxBitmap: not enough RGBA data for ${width}x$height");
      _failed = true;
    } else {
      _jsImageFromRGBA(_handle, width, height, rgba.toJS);
      _loaded = true;
      _width = width;
      _height = height;
    }
    _completer.complete(this);
  }

  /// Loads an asset and completes when it has been loaded (or failed).
  static Future<WxBitmap> load(String path) {
    return WxBitmap.fromAsset(path, wxBITMAP_TYPE_ANY).ready;
  }

  /// Converts the bitmap to a [WxImage] (including its alpha channel)
  ///
  /// This is asynchronous in all ports of wxDart. Since [WxBitmap] in
  /// wxDart Flutter may not have been fully built yet, the conversion
  /// may not be possible and the function will return null.
  ///
  /// ```dart
  /// final image = await bitmap.convertToImage();
  /// ```
  ///
  /// In wxDart Web, a bitmap that is still downloading is waited for (see
  /// [ready]). The conversion fails if the bitmap could not be loaded, is
  /// empty, or if the browser does not allow reading its pixels (images
  /// from other servers without CORS headers).
  Future<WxImage?> convertToImage() async {
    if (!_loaded && !_failed) {
      await ready;
    }
    if (!_loaded || _width == 0 || _height == 0) {
      return null;
    }
    final rgba = _jsImageToRGBA(_handle, _width, _height).toDart;
    if (rgba.length != _width * _height * 4) {
      return null;
    }
    return WxImage.fromRGBA(_width, _height, rgba);
  }

  late final int _handle;
  final Completer<WxBitmap> _completer = Completer<WxBitmap>();
  final List<WxWindow> _listeners = [];
  bool _loaded = false;
  bool _failed = false;
  int _width = 0;
  int _height = 0;
  double _scaleFactor = 1.0;

  /// Completes when the bitmap has been loaded or loading failed;
  /// check [isOk] afterwards.
  Future<WxBitmap> get ready => _completer.future;

  static void _onLoaded(int handle, int width, int height, bool ok) {
    final bitmap = _bitmapsByHandle[handle];
    if (bitmap == null) return;
    bitmap._loaded = ok;
    bitmap._failed = !ok;
    bitmap._width = width;
    bitmap._height = height;
    if (!ok) wxLogError("Could not load bitmap $handle");
    for (final window in bitmap._listeners) {
      if (!window._isDestroyed) window.refresh();
    }
    bitmap._listeners.clear();
    if (!bitmap._completer.isCompleted) bitmap._completer.complete(bitmap);
  }

  void _addListener(WxWindow window) {
    if (!_listeners.contains(window)) {
      _listeners.add(window);
    }
  }

  JSObject? _image() {
    if (!_loaded) return null;
    return _jsGetImage(_handle);
  }

  /// Returns true if the bitmap is valid.
  ///
  /// Note that bitmaps are created or loaded asynchronously in
  /// wxDart Flutter and [isOk] will return false until
  /// the bitmap is complete
  bool isOk() {
    return _loaded;
  }

  /// True if the image could not be loaded
  bool hasFailed() {
    return _failed;
  }

  /// Returns the width of the bitmap if known already
  ///
  /// return -1 if width is (not yet) known
  int getWidth() {
    return _width;
  }

  /// Returns the height of the bitmap if known already
  ///
  /// return -1 if height is (not yet) known
  int getHeight() {
    return _height;
  }

  WxSize getSize() {
    return WxSize(_width, _height);
  }

  /// Returns the scale factor of this bitmap.
  ///
  /// Scale factor is 1 by default, but can be greater to indicate that
  /// the size of bitmap in logical, DPI-independent pixels is smaller
  /// than its actual size in physical pixels. Bitmaps with scale factor
  /// greater than 1 must be used in high DPI to appear sharp on the screen.
  double getScaleFactor() {
    return _scaleFactor;
  }

  /// Sets the scale factor. This is very, very rarely needed.
  void setScaleFactor(double scale) {
    _scaleFactor = scale;
  }

  /// Returns the width of the bitmap in logical pixels.
  ///
  /// For the platforms using DPI-independent pixels (such as wxOSX or wxGTK 3)
  /// this function returns the physical size of the bitmap, as returned by [getWidth],
  /// divided by its scale factor.
  ///
  /// see [getScaleFactor]
  double getLogicalWidth() {
    return _width / _scaleFactor;
  }

  /// Returns the height of the bitmap in logical pixels.
  ///
  /// For the platforms using DPI-independent pixels (such as wxOSX or wxGTK 3)
  /// this function returns the physical size of the bitmap, as returned by [getHeight],
  /// divided by its scale factor.
  ///
  /// see [getScaleFactor]
  double getLogicalHeight() {
    return _height / _scaleFactor;
  }

  @override
  void dispose() {
    _bitmapsByHandle.remove(_handle);
    _jsFreeImage(_handle);
    _loaded = false;
  }
}

// ------------------------- loading images ----------------------

/// Downloads [filename] from the resources directory (default "assets")
/// and returns it as a [WxImage]. Same API as in wxDart Flutter.
void wxLoadImageFromResource(String filename, void Function(WxImage image) returnImage,
    {int format = wxBITMAP_TYPE_PNG, String subdir = ""}) {
  final path = subdir.isEmpty ? filename : "$subdir/$filename";
  final bitmap = WxBitmap.fromAsset(path, format);
  bitmap.ready.then((b) async {
    final image = b.isOk() ? await b.convertToImage() : null;
    if (image != null) {
      returnImage(image);
      _scheduleIdle();
    } else {
      wxLogError(b.isOk() ? "Cannot read the pixels of asset file $path" : "Asset file $path not found");
    }
    b.dispose();
  });
}

/// Downloads [filename] from the resources directory and returns its
/// pixels as RGBA data. Same API as in wxDart Flutter.
void wxLoadRGBAFromResource(String filename, void Function(Uint8List rgba, int width, int height) returnRGBA,
    {int format = wxBITMAP_TYPE_PNG, String subdir = ""}) {
  wxLoadImageFromResource(filename, (image) {
    returnRGBA(image.getRGBA(), image.getWidth(), image.getHeight());
  }, format: format, subdir: subdir);
}

// ------------------------- material icons and appearance ----------------------

bool _warnedAboutMaterialIcons = false;

/// Icons without an explicit colour, recoloured when the accent colour or
/// the appearance changes
final List<WxBitmap> _themedIcons = [];

/// Like in wxDart Flutter, icons without an explicit colour use the accent
/// colour: unchanged in dark mode, darkened in light mode (that is
/// [WxApp.getSecondaryAccentColour]). Icons on an accent coloured surface
/// (filled with [WxApp.getPrimaryAccentColour]) use black or white,
/// whichever is readable on it.
WxColour _defaultIconColour({bool onAccent = false}) {
  if (onAccent) return wxTheApp.getColourOnAccent(wxTheApp.getPrimaryAccentColour());
  return wxTheApp.getSecondaryAccentColour();
}

/// Re-renders icons that follow the accent colour and the appearance, and
/// updates the controls showing them
void _updateThemedIcons() {
  _themedIcons.removeWhere((bitmap) => !_bitmapsByHandle.containsKey(bitmap._handle));
  if (_themedIcons.isEmpty) return;
  for (final bitmap in _themedIcons) {
    bitmap._renderMaterialIcon();
  }
  // controls that copy a bitmap into the page; windows painting it with a
  // DC are refreshed by the caller
  for (final window in List<WxWindow>.of(_windowsByHandle.values)) {
    if (window._isDestroyed) continue;
    if (window is WxToolBar) {
      window._changed();
    } else if (window is WxStaticBitmap) {
      window._update();
    } else if (window is WxAnyButton) {
      window._updateJsBitmap();
    } else if (window is WxBookCtrlBase) {
      window._updateJs();
    }
  }
}
