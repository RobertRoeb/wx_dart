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

class WxBitmapBundle extends WxClass {

  /// Creates a bitmap bundle from a single bitmap.
  WxBitmapBundle( WxBitmap bitmap )  {
    _bitmap = bitmap;
  }

  /// Creates a bitmap bundle from a PNG.
  /// 
  /// [path] is relative to [WxStandardPaths.getResourcesDir]
  WxBitmapBundle.fromPNGAsset( String path )  {
    // this will automatically look for scaled images like /2.0x/image.png
    _bitmap = WxBitmap(path, wxBITMAP_TYPE_PNG );
  }

  /// Creates a bitmap bundle from a JPEG image.
  /// 
  /// [path] is relative to [WxStandardPaths.getResourcesDir]
  WxBitmapBundle.fromJPEGAsset( String path )  {
    // this will automatically look for scaled images like /2.0x/image.jpg, ???
    _bitmap = WxBitmap(path, wxBITMAP_TYPE_JPEG );
  }

  /// Creates a bitmap bundle from an SVG image with the 
  /// size given in [sizeDef].
  /// 
  /// [path] is relative to [WxStandardPaths.getResourcesDir]
  WxBitmapBundle.fromSVGAsset( String path, WxSize sizeDef )  {
    _bitmap = WxBitmap.fromSVGAsset( path, sizeDef.x, sizeDef.y );
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
  WxBitmap getBitmapFor( WxWindow window ) {
    if ((window.getDPIScaleFactor() > 1.25) && (_bigBitmap != null)) {
      return _bigBitmap!;
    }
    return _bitmap;
  }

  late WxBitmap _bitmap;
  WxBitmap? _bigBitmap;
}
