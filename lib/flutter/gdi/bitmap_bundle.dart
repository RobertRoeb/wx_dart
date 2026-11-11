// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxBitmapBundle ----------------------

/// Contains representations of the same bitmap in different resolutions.
/// 
/// You can create a bitmap bundle from several, typically two, bitmaps
/// with different sizes/resolutions.
/// 
/// More easily, it can also be constructed from an SVG which then gets scaled 
/// to the required bitmap size.
/// 
/// Notably, a [WxBitmapBundle] can be passed to many controls in wxDart to allow them
/// to select the best available bitmap to be shown depending on the display
/// resolution of the current monitor.
/// 
/// Example with single bitmap:
/// ```dart
///  // create bitmap bundle from lib/assets/images/MyImage.png
///  final bitmap = WxBitmapBundle.fromPNGAsset( "images/MyImage.png" ); 
/// 
///  final myButton = WxBitmapButton( parent, -1, bitmap );
///  myButton.bindButtonEvent((_)
///  {
///    // actually start something!
///  }, -1);
/// ```
/// 
/// Example with Material icon:
/// ```dart
///  // create bitmap bundle from Material icon
///  final bitmap = WxBitmapBundle.fromMaterialIcon( WxMaterialIcon.home, WxSize(32,32), colour: wxRED );
/// 
///  final myButton = WxBitmapButton( parent, -1, bitmap );
///  myButton.bindButtonEvent((_)
///  {
///    // actually start something!
///  }, -1);
/// ```

class WxBitmapBundle extends WxClass {

  /// Creates a bitmap bundle from a single bitmap.
  WxBitmapBundle( WxBitmap bitmap )  {
    _bitmap = bitmap;
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
  WxBitmapBundle.fromPNGAsset( String path )  {
    // this will automatically look for scaled images like /2.0x/image.png
    _bitmap = WxBitmap.fromAsset(path, wxBITMAP_TYPE_PNG );
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
  WxBitmapBundle.fromJPEGAsset( String path )  {
    // this will automatically look for scaled images like /2.0x/image.jpg, ???
    _bitmap = WxBitmap.fromAsset(path, wxBITMAP_TYPE_JPEG );
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
  WxBitmapBundle.fromSVGAsset( String path, WxSize sizeDef )  {
    _defaultSize = sizeDef;
    // create default bitmap
    _bitmap = WxBitmap.fromSVGAsset( path, sizeDef.x, sizeDef.y );

    // Load SVG string and make this bundle and SVG bundle
    rootBundle.loadString(path).then( (svg) {
      _isSVG = true;
      _svg = svg;
    } );
  }

  /// Creates a bitmap bundle from one of more than 2000 included Material icons. If
  /// no colour is given, the icon will have the accent colour of the app in 
  /// wxDart Flutter and will be grey in wxDart Native. Some platforms enforce
  /// colours in bitmaps in [WxToolBar] or e.g. in [WxNavigationCtrl].
  WxBitmapBundle.fromMaterialIcon( WxMaterialIcon icon, WxSize size, { WxColour? colour } )
  {
    _bitmap = WxBitmap.fromMaterialIcon(icon, size, colour );
  }

  /// Creates a bitmap bundle from an SVG string
  WxBitmapBundle.fromSVG( String svg, WxSize sizeDef )  {
    _isSVG = true;
    _svg = svg;
    _defaultSize = sizeDef;
    _bitmap = WxBitmap.fromSVG( svg, sizeDef.x, sizeDef.y );
  }

  /// Creates a bitmap bundle from a single [WxBitmap]
  WxBitmapBundle.fromBitmap( WxBitmap bitmap ) {
    _bitmap = bitmap;
  }

  /// Creates a bitmap bundle from two bitmaps. A control or some
  /// other code would later pick the right one based on DPI.
  WxBitmapBundle.fromBitmaps( WxBitmap bitmap1, WxBitmap bitmap2 )  {
    _bitmap = bitmap1;
    _bigBitmap = bitmap2;
  }

  /// Creates a bitmap bundle from a single [WxImage]
  WxBitmapBundle.fromImage( WxImage image ) {
    _bitmap = WxBitmap.fromImage( image );
  }

  /// This methods is called by controls to pick the right
  /// bitmap if two (or more) are bitmaps are available.
  /// 
  /// Picks bitmap based on [WxWindow.getDPIScaleFactor] from [window]
  WxBitmap getBitmapFor( WxWindow window )
  {
    final scale = window.getDPIScaleFactor();
    if (_isSVG && (scale > 1.25)) {
      final size = WxSize( (_defaultSize.x*scale).round(), (_defaultSize.y*scale).round() );
      if (_bigBitmap != null) {
        // Did we already create the right one?
        if ((_bigBitmap!.getWidth() == size.x) && (_bigBitmap!.getHeight() == size.y)) {
          return _bigBitmap!;
        }
        _bigBitmap = WxBitmap.fromSVG( _svg, size.x, size.y );
        return _bigBitmap!;
      }
    }
    if ((scale > 1.25) && (_bigBitmap != null)) {
      return _bigBitmap!;
    }
    return _bitmap;
  }

  /// Returns the size of the unscaled bitmap (at 100% DPI)
  WxSize getDefaultSize( ) {
    return WxSize( _bitmap.getWidth(), _bitmap.getHeight() );
  }

  /// Create a new bitmap bundle with greyed out bitmaps
  WxBitmapBundle makeDisabled( ) {
    return this;
  }

  late WxBitmap _bitmap;
  WxBitmap? _bigBitmap;
  bool _isSVG = false;
  String _svg = "";
  WxSize _defaultSize = WxSize.zero;
}
