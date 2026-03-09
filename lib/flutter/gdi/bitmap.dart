// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxBitmap ----------------------

const int wxBITMAP_TYPE_BMP = 1;
const int wxBITMAP_TYPE_GIF = 16;
const int wxBITMAP_TYPE_PNG = 18;
const int wxBITMAP_TYPE_JPEG = 20;
const int wxBITMAP_TYPE_WEBP = 35;

/// Represents a platform-dependent bitmap which is optimized for 
/// drawing directly into a window.
/// 
/// Creation of a [WxBitmap] is an asychronous operation
/// in wxDart Flutter. That means that the internal representation of
/// the bitmap will be build in the background and this will not interrupt
/// program flow. Indeed, if the bitmap is loaded from the web and
/// the connection goes down, the internal representation will never
/// be created. You can ignore that in you code: controls using
/// bitmaps and [WxDC.drawBitmap] know about asynchronous bitmap
/// creation and will get notified once the bitmap is fully build
/// and will then redraw themselves. 
/// 
/// You cannot currently manipulate objects of this class directly.
/// Rather, you create a [WxBitmap] from an [WxImage] or directly
/// from a file or an SVG string. 
/// 
/// ```dart
///    final image = WxImage( 100, 100 );
///    for (int y = 0; y < 100; y++) {
///        for (int x = 0; x <100; x++) {
///          // set pixel in image
///          image.setRGB(x, y, 20, 100, 100 );
///        }
///    }
///
///    // access image data directly
///    final data = image.getData();
///    for (int i = 0; i < 100*20*3; i++) {
///        data.setUint8(i, 255);
///    }
///
///    // create bitmap from WxImage
///    bitmap = WxBitmap.fromImage( image ); 
/// ```
/// 
/// Alternatively, you can use a [WxMemoryDC] to create a [WxBitmap]
/// and draw into it.
/// 
/// ```dart
///  final dc = WxMemoryDC(100, 100);
///  dc.setPen( wxTRANSPARENT_PEN );
///  dc.setPen( wxRED_PEN );
///  dc.drawCircle( 50, 50, 20 ); 
/// 
///  // create bitmap from WxMemoryDC
///  final bitmap = dc.getBitmap();
/// ```
/// 
/// Once created, you draw the bitmap in a paint event handler: 
/// 
/// ```dart
///  class MyImageWindow extends WxWindow {
///  MyImageWindow( WxWindow parent, int style ) : super( parent, -1, wxDefaultPosition, WxSize( 200, 300), style )
///  {
///     // create image
///     final image = WxImage( 100, 200 );
///     image.initAlpha();
///     // draw something into the image..
///
///     // create bitmap from image
///     _bitmap = WxBitmap.fromImage( image ); 
///
///     bindPaintEvent( onPaint );
///   }
///
///   late WxBitmap _bitmap;
///
///   void onPaint( WxPaintEvent event )
///   {
///     final dc = WxPaintDC( this );
///     dc.drawBitmap( _bitmap, 10, 10 );
///   }
/// }
/// ```
/// 
/// When dealing with controls in wxDart, you usually will not
/// use [WxBitmap] objects, but [WxBitmapBundle] objects, which
/// can handle multiple resolutions using multple bitmaps.
/// 
/// # Image file format constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxBITMAP_TYPE_BMP | 1 |
/// | wxBITMAP_TYPE_GIF | 16 |
/// | wxBITMAP_TYPE_PNG | 18 |
/// | wxBITMAP_TYPE_JPEG | 20 |
/// | wxBITMAP_TYPE_WEBP | 35 |

class WxBitmap extends WxObject {

/// Loads in image from a resource. with the given format.
/// 
/// [path] is relative to [WxStandardPaths.getResourcesDir]
/// 
/// # Image file format constants
/// | constant | meaning/value |
/// | -------- | -------- |
/// | wxBITMAP_TYPE_BMP | 1 |
/// | wxBITMAP_TYPE_GIF | 16 |
/// | wxBITMAP_TYPE_PNG | 18 |
/// | wxBITMAP_TYPE_JPEG | 20 |
/// | wxBITMAP_TYPE_WEBP | 35 |
  WxBitmap( String path, int format )
  {
    _buildAsset(path,-1,-1).then( (image ) {
      _image = image;
      // notify owning classes
      for (final listener in _listeners) {
        listener._setState();
      }
    } );
}

Future<ui.Image> _buildAsset(String path, int height, int width) async
{
  final ByteData assetImageByteData = await rootBundle.load( path );
  final codec = await ui.instantiateImageCodec(
    assetImageByteData.buffer.asUint8List(),
    targetHeight: height == -1 ? null : height,
    targetWidth: width == -1 ? null : width,
  );
  return (await codec.getNextFrame()).image;
}


  ui.Image? _image;
  final List <WxWindow> _listeners = [];
  // needed ro rebuilding with new colour
  bool _isMaterialIcon = false;
  int _materialIconWidth = -1;
  int _materialIconHeight = -1;
  WxMaterialIcon _materialIcon = WxMaterialIcon.access_alarm;
  WxColour? _materialIconColour;

  /// Creates a bitmap from an [WxImage]
  WxBitmap.fromImage( WxImage image )
  {
    final width = image.getWidth();
    final height = image.getHeight();
    final rgba = Uint8List.fromList( List.filled(width * height * 4, 255) );
    final bitmapByteData = rgba.buffer.asByteData();
    final imageByteData = image.getData();
    int bitmapOffset = 0;
    int imageOffset = 0;
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        bitmapByteData.setUint8( bitmapOffset, imageByteData.getUint8( imageOffset ));
        bitmapOffset++;
        imageOffset++;
        bitmapByteData.setUint8( bitmapOffset, imageByteData.getUint8( imageOffset ));
        bitmapOffset++;
        imageOffset++;
        bitmapByteData.setUint8( bitmapOffset, imageByteData.getUint8( imageOffset ));
        bitmapOffset++;
        imageOffset++;
        // jump over alpha
        bitmapOffset++;
      }
    }
    final alphaByteData = image.getAlphaData();
    if (alphaByteData != null) {
      int bitmapOffset = 3;
      int alphaOffset = 0;
      for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
          bitmapByteData.setUint8( bitmapOffset, alphaByteData.getUint8( alphaOffset ));
          bitmapOffset += 4;
          alphaOffset++;
        }
      }
    }

    _buildImage(rgba,width,height).then( (image ) {
      _image = image;
      // notify owning classes
      for (final listener in _listeners) {
        listener._setState();
      }
    } );
  }

  /// Creates a bitmap with a given size. This is actually
  /// not supported on all platforms.
  WxBitmap.fromSize( int width, int height, { int depth = 24 } )
  {
    final rgba = Uint8List.fromList( List.filled(width * height * 4, 0) );
    final ByteData byteData = rgba.buffer.asByteData();
    for (int i = 0; i < width*height; i++) {
      byteData.setUint8(  i*4 + 3, 255 ); // fully opaque
    }
    _buildImage(rgba,width,height).then( (image ) {
      _image = image;
      // notify owning classes
      for (final listener in _listeners) {
        listener._setState();
      }
    } );
  }

  void _addListener( WxWindow window ) {
    if (!_listeners.contains(window)) {
      _listeners.add( window );
    }
  }

  /// Creates a bitmap from an SVG image with the 
  /// size given in [width] and [height].
  /// 
  /// [path] is relative to [WxStandardPaths.getResourcesDir]
  WxBitmap.fromSVGAsset( String path, int width, int height )
  {
    _buildSVGAsset(path,width,height).then( (image ) {
      _image = image;
      // notify owning classes
      for (final listener in _listeners) {
        listener._setState();
      }
    } );
  }

  Future<ui.Image> _buildSVGAsset( String path, int width, int height ) async
  {
    final svg = await rootBundle.loadString(path);

    final PictureInfo pictureInfo = await vg.loadPicture(
       SvgStringLoader(svg),
      null,
    );
    final ui.Image image = await pictureInfo.picture.toImage(width,height);
    pictureInfo.picture.dispose();
    return image;
  }

  /// Creates a bitmap from one of more than 2000 included Material icons. If
  /// no colour is given, the icon will have the accent colour of the app in 
  /// wxDart Flutter and will be grey in wxDart Native. 
  WxBitmap.fromMaterialIcon( WxMaterialIcon icon, WxSize size, WxColour? colour  )
  {
    // needed to recreate when updating theme
    _isMaterialIcon = true;
    _materialIconWidth = size.x;
    _materialIconHeight = size.y;
    _materialIcon = icon;
    _materialIconColour = colour;
    _buildFromMaterialIcon();
  }

  void _updateTheme() {
    if (!_isMaterialIcon) return;
    if (_materialIconColour != null) return; // doesn't use theme colour
    _buildFromMaterialIcon();
  }

  void _buildFromMaterialIcon()
  {
    final icondata = wxMaterialArtIdFromId( _materialIcon );

    final recorder = ui.PictureRecorder();
    Canvas canvas = Canvas( recorder );

    final paint = Paint();
    paint.style = PaintingStyle.fill;
    // This non-sense code was required to trigger
    // the recorder as otherwise the image will remain 
    // blank on Linux.
    /*
    if (wxTheApp.isDark()) {
      paint.color = Colors.black;
    } else {
      paint.color = Colors.white;
    }
    canvas.drawRect(Rect.fromPoints(Offset(5,5), Offset(6,6)), paint );
    */

    // this code is based on an explanation from Dan Field
    canvas.save();
    // final dpr = MediaQueryData.fromView(WidgetsBinding.instance.platformDispatcher.views.first).devicePixelRatio;
    double dpr = 1.0;
    canvas.scale( dpr );
    // print( "DPR ${(dpr*100).floor()}" );
    
    TextPainter textPainter = TextPainter(textDirection: TextDirection.rtl);
    textPainter.text = TextSpan(  
      text: String.fromCharCode(icondata.codePoint),
            style: TextStyle(
              fontSize: _materialIconHeight.toDouble(),
              color: ( _materialIconColour == null) 
                     ? wxTheApp._getSeedColor() 
                     : Color.fromARGB( _materialIconColour!.alpha, _materialIconColour!.red, _materialIconColour!.green, _materialIconColour!.blue ),
              fontFamily: icondata.fontFamily)
              );
    textPainter.layout();
    textPainter.paint(canvas, Offset(0.0,0.0));
    canvas.restore();
    final picture = recorder.endRecording();

    _image = null;
    _buildPicture(picture, (_materialIconWidth*dpr).floor(), (_materialIconHeight*dpr).floor() ).then( (image ) {
      _image = image;
      for (final listener in _listeners) {
        listener._setState();
      }
    } );  
  } 

  WxBitmap._fromPicture( ui.Picture picture, int width, int height )
  {
    _buildPicture(picture, width, height ).then( (image ) {
      _image = image;
      for (final listener in _listeners) {
        listener._setState();
      }
    } );
  }

  Future<ui.Image> _buildPicture( ui.Picture picture, int width, int height ) async
  {
    final image = await picture.toImage(width, height);
    return image;
  }

  /// Creates a bitmap from an SVG string with the 
  /// size given in [width] and [height].
  WxBitmap.fromSVG( String svg, int width, int height )
  {
    _buildSVG(svg,width,height).then( (image ) {
      _image = image;
      // notify owning classes
      for (final listener in _listeners) {
        listener._setState();
      }
    } );
  }

  Future<ui.Image> _buildSVG( String svg, int width, int height ) async
  {
    final PictureInfo pictureInfo = await vg.loadPicture(
      SvgStringLoader(svg),
      null,
      clipViewbox: false, 
    );

    /*
    // simple way with no scaling
    final ui.Image image = await pictureInfo.picture.toImage(width,height);
    */

    // with scaling to desired size
    final recorder = ui.PictureRecorder(); 
    final canvas = Canvas(recorder); 
    // TODO: read original width and height from SVG
    canvas.scale(width/24, height/24 ); 
    canvas.drawPicture(pictureInfo.picture); 
    final image = await recorder.endRecording().toImage( 
      width, 
      height, 
    ); 

    pictureInfo.picture.dispose();
    return image;
  }

  Future<ui.Image> _buildImage( Uint8List rgba, int width, int height ) async
  {
    final Completer<ui.Image> imageCompleter = Completer();

    final imageDataSize = 122 + (width * height * 4);
    final Uint8List imageData = Uint8List( imageDataSize );
    final ByteData byteData = imageData.buffer.asByteData();
    byteData.setUint8(  0x0,  0x42 );
    byteData.setUint8(  0x1,  0x4d );
    byteData.setInt32(  0x2,  imageDataSize, Endian.little );
    byteData.setInt32(  0xa,  122, Endian.little );
    byteData.setUint32( 0xe,  108, Endian.little );
    byteData.setUint32( 0x12, width, Endian.little );
    byteData.setUint32( 0x16, -height, Endian.little );
    byteData.setUint16( 0x1a, 1, Endian.little );
    byteData.setUint32( 0x1c, 32, Endian.little );
    byteData.setUint32( 0x1e, 3, Endian.little );
    byteData.setUint32( 0x22, (width * height * 4), Endian.little );
    byteData.setUint32( 0x36, 0x000000ff, Endian.little );
    byteData.setUint32( 0x3a, 0x0000ff00, Endian.little );
    byteData.setUint32( 0x3e, 0x00ff0000, Endian.little );
    byteData.setUint32( 0x42, 0xff000000, Endian.little );
    imageData.setRange( 122, imageDataSize, rgba );

    ui.decodeImageFromList(imageData, (ui.Image img) {
      imageCompleter.complete(img);
    });
    return imageCompleter.future;
  }

  /// Returns true if the bitmap is valid.
  /// 
  /// Note that bitmaps are created or loaded asynchronously in
  /// wxDart Flutter and [isOk] will return false until
  /// the bitmap is complete
  bool isOk() { 
    return _image != null;
  }

  /// Returns the width of the bitmap if known already
  /// 
  /// return -1 if width is (not yet) known
  int getWidth() {
    if (!isOk()) {
      return -1;
    }
    return _image!.width;
  }

  /// Returns the height of the bitmap if known already
  /// 
  /// return -1 if height is (not yet) known
  int getHeight() {
    if (!isOk()) {
      return -1;
    }
    return _image!.height;
  }
} 
