// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxGraphicsObject ----------------------

/// Base class for all classes around the [WxGraphicsContext] based
/// new drawing API

class WxGraphicsObject extends WxObject {
  WxGraphicsObject();
}

// ------------------------- wxGraphicsBitmap ----------------------

/// Opaque object representing an image or bitmap optimized for GPU based drawing
/// with [WxGraphicsContext.drawBitmap]. These objects should be created
/// outside of a paint event handler.
/// 
/// See [WxGraphicsContext.createBitmap] and [WxGraphicsContext.createBitmapFromImage]
/// 
///```dart
/// final image = WxImage( 80, 120 );
/// image.initAlpha();
/// 
/// // do something with the image here
///
/// // create graphics context to build optimized graphics bitmaps
/// final gc = WxGraphicsContext();
///
/// // build WxGraphicsBitmap from image
///  final bitmap = gc.createBitmapFromImage( image );
///```

class WxGraphicsBitmap extends WxGraphicsObject {
  WxGraphicsBitmap( );

  WxBitmap? _bitmap;
}

// ------------------------- wxGraphicsContext ----------------------

const int wxCOMPOSITION_INVALID = -1;
const int wxCOMPOSITION_CLEAR = 0;
const int wxCOMPOSITION_SOURCE = 1;
const int wxCOMPOSITION_OVER = 2;
const int wxCOMPOSITION_IN = 3;
const int wxCOMPOSITION_OUT = 4;
const int wxCOMPOSITION_ATOP = 5;
const int wxCOMPOSITION_DEST = 6;
const int wxCOMPOSITION_DEST_OVER = 7;
const int wxCOMPOSITION_DEST_IN = 8;
const int wxCOMPOSITION_DEST_OUT = 9;
const int wxCOMPOSITION_DEST_ATOP = 10;
const int wxCOMPOSITION_XOR = 11;
const int wxCOMPOSITION_ADD = 12;
const int wxCOMPOSITION_DIFF = 13;

/// Internally, both wxWidgets and wxDart mostly use the original drawing API from
/// the [WxDC] (device context = drawing API) group of classes.
/// 
/// wxDart also supports a modern path based drawing API from the
/// [WxGraphicsContext] group of classes in both wxDart Native and wxDart Flutter.
/// It uses Direct2D under Windows, CoreGraphics on MacOS, Cairo on Linux and
/// Impeller when using the Flutter backend.
/// 
/// [WxGraphicsContext] uses _double_ values for coordinates, not _int_
/// values like [WxDC]
/// 
/// See [WxDC], [WxPaintDC]
/// 
/// ```dart
/// class MyGraphicsWindow extends WxScrolledWindow {
///   MyGraphicsWindow( WxWindow parent ) : super( parent, -1, pos: wxDefaultPosition, size: WxSize( 200, 200) )
///   {
///     // set virtual size
///     setVirtualSize(WxSize(600,400));
///     // and define scroll steps
///     setScrollRate(10, 10);
/// 
///     // bind to paint event
///     bindPaintEvent( onPaint );
///   }
/// 
///   void onPaint( WxPaintEvent event )
///   {
///     // create WxPaintDC
///     final dc = WxPaintDC( this );
/// 
///     // adapt it to scrolling
///     doPrepareDC(dc);
/// 
///     // create WxGraphicsContext from WxPaintDC
///     final gc = WxGraphicsContext.fromDC(dc);
/// 
///     // draw red rectangle in WxGraphicsContext
///     gc.setPen(wxRED_PEN);
///     gc.drawRectangle(2.0, 2.0, 48.0, 48.0 );
/// 
///     // draw black rectangle in WxPaintDC
///     dc.setPen(wxBLACK_PEN);
///     dc.drawRectangle(4, 4, 44, 4);
/// 
///     // still draws red in WxGraphicsContext
///     gc.drawRectangle(50.0, 2.0, 48.0, 48.0 );
///   }
/// }
/// ```

class WxGraphicsContext extends WxGraphicsObject {

  /// Creates lightweight graphics context for measuring metric (of text) and
  /// for creating a [WxGraphicsBitmap] from a [WxBitmap] or a [WxImage] outside
  /// of a paint event handler.
  WxGraphicsContext()
  {
    _initGC();
  }

  /// Creates a graphics context from a [WxPaintDC] in a paint event handler
  WxGraphicsContext.fromDC( WxPaintDC dc )  
  {
    _canvas = dc._canvas;
    _initGC();
    _owner = dc._window;
  }

  void _initGC()
  {
    _penPaint = Paint();
    _penPaint.style = PaintingStyle.stroke;
    _penPaint.strokeCap = StrokeCap.round;
    _penPaint.strokeJoin = StrokeJoin.miter;
    _brushPaint = Paint();
    _brushPaint.style = PaintingStyle.fill;
    setBrush( wxWHITE_BRUSH );
    if (wxTheApp.isDark()) {
      _textColour = wxWHITE;
    }
  }

  Canvas? _canvas;
  WxWindow? _owner;
  late Paint _penPaint;
  late Paint _brushPaint;
  WxPen _currentPen = wxBLACK_PEN;
  late WxBrush _currentBrush;
  WxFont? _font;
  WxColour _textColour = wxBLACK;

  /// Pushes current state to the stack. You can restore it with [popState].
  void pushState( ) {
    if (_canvas == null) {
      wxLogError("No valid canvas for graphics context" );
      return;
    }
    _canvas!.save();
  }

  /// Restores the current state of the grapics context from the stack
  /// 
  /// See [pushState]
  
  void popState( ) {
    if (_canvas == null) {
      wxLogError("No valid canvas for graphics context" );
      return;
    }
    _canvas!.restore();
  }

  /// Rotates the current matrix by [angle] in radians
  void rotate( double angle ) {
    if (_canvas == null) {
      wxLogError("No valid canvas for graphics context" );
      return;
    }
    _canvas!.rotate(angle);
  }

  /// Rotates the current matrix by [x] and [y]
  void translate( double x, double y ) {
    if (_canvas == null) {
      wxLogError("No valid canvas for graphics context" );
      return;
    }
    _canvas!.translate(x,y);
  }

  /// Scales the current matrix by [xScale] and [yScale]
  void scale( double xScale, double yScale ) {
    if (_canvas == null) {
      wxLogError("No valid canvas for graphics context" );
      return;
    }
    _canvas!.scale(xScale,yScale);
  }

  /// Sets a clipping area to the specified rectangle
  /// 
  /// See [resetClip]
  void clip( double x, double y, double width, double height ) {
    if (_canvas == null) {
      wxLogError("No valid canvas for graphics context" );
      return;
    }
    _canvas!.clipRect( Rect.fromLTWH(x+.5,y+0.5,width+0.5,height+0.5) );
  }

  /// Resets clipping addRectangle. Not supported in wxDart Flutter - use [pushState] and [popState] instead.
  /// 
  /// See [clip]
  void resetClip( ) {
      wxLogError("Not supported in wxDart Flutter" );
  }

  /// Creates a GPU optimized representation of the bitmap for 
  /// drawing with [drawBitmap]
  /// 
  /// See [WxGraphicsBitmap], [createBitmapFromImage]
  WxGraphicsBitmap createBitmap( WxBitmap bitmap ) {
    final gb = WxGraphicsBitmap();
    gb._bitmap = bitmap;
    return gb;
  }

  /// Creates a GPU optimized representation of the image for 
  /// drawing with [drawBitmap]
  /// 
  /// See [WxGraphicsBitmap], [createBitmap]
  WxGraphicsBitmap createBitmapFromImage( WxImage image ) {
    final gb = WxGraphicsBitmap();
    gb._bitmap = WxBitmap.fromImage(image);
    return gb;
  }

  /// Draws [bitmap] at position [x],[y] with given dimensions
  /// 
  /// See [WxGraphicsBitmap]
  void drawBitmap( WxGraphicsBitmap bitmap, double x, double y, double width, double height )
  {
    if (bitmap._bitmap == null) return;
    if (_canvas == null) {
      wxLogError("No valid canvas for graphics context" );
      return;
    }
    if (bitmap._bitmap!.isOk())
    {
      // TODO scale
      _canvas!.drawImage(bitmap._bitmap!._image!, Offset( x, y ), _penPaint );
    } else {
      if (_owner != null) {
        bitmap._bitmap!._addListener(_owner!);
      }
    }
  }

  /// Returns an empty path
  WxGraphicsPath createPath( ) {
    return WxGraphicsPath();
  }

  /// Draws the given [path] with the current pen
  void strokePath( WxGraphicsPath path ) {
    if (_canvas == null) {
      wxLogError("No valid canvas for graphics context" );
      return;
    }
    if (_currentPen.isNonTransparent()) {
      _canvas!.drawPath( path._path, _penPaint );
    }
  }

  /// Fills the given [path] with the current brush
  void fillPath( WxGraphicsPath path ) {
    if (_canvas == null) {
      wxLogError("No valid canvas for graphics context" );
      return;
    }
    _canvas!.drawPath( path._path, _brushPaint );
  }

  /// Fills the given [path] with the current brush and then
  /// stokes it with the current pen
  void drawPath( WxGraphicsPath path ) {
    if (_canvas == null) {
      wxLogError("No valid canvas for graphics context" );
      return;
    }
    _canvas!.drawPath( path._path, _brushPaint );
    if (_currentPen.isNonTransparent()) {
      _canvas!.drawPath( path._path, _penPaint );
    }
  }

  /// Draws a line from [x1],[y1] to [x2],[y2] with the current pen
  void strokeLine( double x1, double y1, double x2, double y2 ) {
    if (_canvas == null) {
      wxLogError("No valid canvas for graphics context" );
      return;
    }
    if (_currentPen.isNonTransparent()) {
      _canvas!.drawLine( 
        Offset( x1+0.5, y1+0.5 ), 
        Offset( x2+0.5, y2+0.5 ), 
        _penPaint);
    }
  }

  /// Draws a rectangle [x],[y] with the [width] and [height] using the
  /// current [WxPen] 
  void drawRectangle( double x, double y, double width, double height )
  {
    if (_canvas == null) {
      wxLogError("No valid canvas for graphics context" );
      return;
    }
    if (_currentPen.isNonTransparent()) {
      _canvas!.drawRect( Rect.fromPoints(
          Offset( x+0.5, y+0.5 ),
          Offset( x+width+0.5, y+height+0.5 ) ),
      _penPaint );
    }
  }

  /// Draws a rounded rectangle from [x],[y] with the dimenssion [width],[height] and [radius] with the current pen
  void drawRoundedRectangle( double x, double y, double width, double height, double radius )
  {
    if (_canvas == null) {
      wxLogError("No valid canvas for graphics context" );
      return;
    }
    if (_currentPen.isNonTransparent())
    {
      final Rect rect = Rect.fromPoints(
          Offset( x+0.5, y+0.5 ),
          Offset( x+width+0.5, y+height+0.5 ) );
      final rrect = RRect.fromRectAndRadius( rect, Radius.circular(radius) );
      _canvas!.drawRRect( rrect, _penPaint );
    }
  }

  /// Sets the font currently and text colour
  void setFont( WxFont? font, WxColour colour ) {
    _font = font;
    _textColour = colour;
  }

  /// Returns the size in pixels of [text] using the current font
  WxSize getTextExtent( String text )
  {
    TextPainter textPainter = TextPainter(
        text: TextSpan(
            text: text, 
            style: _convertTextStyle(null, _font)), 
            maxLines: 1, 
            textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return WxSize( textPainter.size.width.floor(), textPainter.size.height.floor() );
  }

  /// Draws a [text] at [x],[y] with the current pen
  void drawText( String text, double x, double y )
  {
      if (_canvas == null) {
      wxLogError("No valid canvas for graphics context" );
      return;
    }
    TextPainter textPainter = TextPainter(
        text: TextSpan(
            text: text, 
            style: _convertTextStyle(_textColour, _font)), 
            maxLines: 1, 
            textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);


    Offset offset = Offset( x+0.5, y+0.5 );
    textPainter.paint(_canvas!, offset);    
}

/// Sets the composition mode for drawing operations
/// 
/// ## Mode constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxCOMPOSITION_CLEAR | 0 |
/// | wxCOMPOSITION_SOURCE | 1 |
/// | wxCOMPOSITION_OVER | 2 |
/// | wxCOMPOSITION_IN | 3 |
/// | wxCOMPOSITION_OUT | 4 |
/// | wxCOMPOSITION_ATOP | 5 |
/// | wxCOMPOSITION_DEST | 6 |
/// | wxCOMPOSITION_DEST_OVER | 7 |
/// | wxCOMPOSITION_DEST_IN | 8 |
/// | wxCOMPOSITION_DEST_OUT | 9 |
/// | wxCOMPOSITION_DEST_ATOP | 10 |
/// | wxCOMPOSITION_XOR | 11 |
/// | wxCOMPOSITION_ADD | 12 |
/// | wxCOMPOSITION_DIFF | 13 |
  bool setCompositionMode( int mode )
  {
    switch (mode) {
      case wxCOMPOSITION_CLEAR: _penPaint.blendMode = BlendMode.clear; break;
      case wxCOMPOSITION_SOURCE: _penPaint.blendMode = BlendMode.src; break;
      case wxCOMPOSITION_OVER: _penPaint.blendMode = BlendMode.overlay; break;
      case wxCOMPOSITION_IN: _penPaint.blendMode = BlendMode.srcIn; break;
      case wxCOMPOSITION_OUT: _penPaint.blendMode = BlendMode.srcOut; break;
      case wxCOMPOSITION_ATOP: _penPaint.blendMode = BlendMode.srcATop; break;
      case wxCOMPOSITION_DEST: _penPaint.blendMode = BlendMode.dst; break;
      case wxCOMPOSITION_DEST_OVER: _penPaint.blendMode = BlendMode.dstOver; break;
      case wxCOMPOSITION_DEST_IN: _penPaint.blendMode = BlendMode.dstIn; break;
      case wxCOMPOSITION_DEST_ATOP: _penPaint.blendMode = BlendMode.dstATop; break;
      case wxCOMPOSITION_XOR: _penPaint.blendMode = BlendMode.xor; break;
      case wxCOMPOSITION_ADD: _penPaint.blendMode = BlendMode.plus; break;
      case wxCOMPOSITION_DIFF: _penPaint.blendMode = BlendMode.difference; break;
      default: _penPaint.blendMode = BlendMode.srcOver; break;
    }

    return true;
  }

  /// Sets current [WxPen] for all drawing operations. Set it to [wxTRANSPARENT_PEN]
  /// to not draw anything
  /// 
  /// See [WxDC.setPen]
  void setPen( WxPen pen )
  {
    _penPaint.shader = null;
    _currentPen = pen;
    _penPaint.color = Color.fromARGB(pen.colour.alpha, pen.colour.red, 
       pen.colour.green, pen.colour.blue);
    _penPaint.strokeWidth = pen.width.toDouble();
    switch (pen.capStyle) {
      case wxCAP_BUTT: 
        _penPaint.strokeCap = StrokeCap.butt;
        break;
      case wxCAP_PROJECTING: 
        _penPaint.strokeCap = StrokeCap.square;
        break;
      default:
        _penPaint.strokeCap = StrokeCap.round;
    }
    switch (pen.joinStyle) {
      case wxJOIN_MITER: 
        _penPaint.strokeJoin = StrokeJoin.miter;
        break;
      case wxJOIN_BEVEL: 
        _penPaint.strokeJoin = StrokeJoin.bevel;
        break;
      default:
        _penPaint.strokeJoin = StrokeJoin.round;
    }
  }

  /// Sets current pen to given values for all drawing operations. Same as 
  /// [setPen] but using a double for defining the width
  void setPenWithConstantColour( WxColour colour, { double width = 1.0, int style = wxPENSTYLE_SOLID, int cap = wxCAP_ROUND, int join = wxJOIN_MITER } )
  {
    _penPaint.shader = null;
    _penPaint.color = Color.fromARGB(colour.alpha, colour.red, 
       colour.green, colour.blue);
    _penPaint.strokeWidth = width;
    switch (cap) {
      case wxCAP_BUTT: 
        _penPaint.strokeCap = StrokeCap.butt;
        break;
      case wxCAP_PROJECTING: 
        _penPaint.strokeCap = StrokeCap.square;
        break;
      default:
        _penPaint.strokeCap = StrokeCap.round;
    }
    switch (join) {
      case wxJOIN_MITER: 
        _penPaint.strokeJoin = StrokeJoin.miter;
        break;
      case wxJOIN_BEVEL: 
        _penPaint.strokeJoin = StrokeJoin.bevel;
        break;
      default:
        _penPaint.strokeJoin = StrokeJoin.round;
    }
  }

  /// Sets current pen to have a linear colour gradient with the given values for all drawing operations.
  void setPenWithLinearGradient( double x1, double y1, double x2, double y2, WxColour colour1, WxColour colour2, { double width = 1.0, int style = wxPENSTYLE_SOLID, int cap = wxCAP_ROUND, int join = wxJOIN_MITER } )
  {
    _penPaint.shader = ui.Gradient.linear
    (
        Offset(x1, y1),
        Offset(x2, y2),
        [
         Color.fromARGB(colour1.alpha, colour1.red, colour1.green, colour1.blue),
         Color.fromARGB(colour2.alpha, colour2.red, colour2.green, colour2.blue),
        ],
        [0.0, 1.0],
      );
    _penPaint.strokeWidth = width;
    switch (cap) {
      case wxCAP_BUTT: 
        _penPaint.strokeCap = StrokeCap.butt;
        break;
      case wxCAP_PROJECTING: 
        _penPaint.strokeCap = StrokeCap.square;
        break;
      default:
        _penPaint.strokeCap = StrokeCap.round;
    }
    switch (join) {
      case wxJOIN_MITER: 
        _penPaint.strokeJoin = StrokeJoin.miter;
        break;
      case wxJOIN_BEVEL: 
        _penPaint.strokeJoin = StrokeJoin.bevel;
        break;
      default:
        _penPaint.strokeJoin = StrokeJoin.round;
    }
  }

  /// Sets current pen to have a radial colour gradient with the given values for all drawing operations.
  void setPenWithRadialGradient( double startX, double startY, double endX, double endY, double radius, WxColour outerColour, WxColour innerColour, { double width = 1.0, int style = wxPENSTYLE_SOLID, int cap = wxCAP_ROUND, int join = wxJOIN_MITER } )
  {
    _penPaint.shader = ui.Gradient.radial
    (
        Offset((startX+endX)/2, (startY+endY)/2),
        radius,
        [
         Color.fromARGB(innerColour.alpha, innerColour.red, innerColour.green, innerColour.blue),
         Color.fromARGB(outerColour.alpha, outerColour.red, outerColour.green, outerColour.blue),
        ],
        [0.0, 1.0],
      );
    _penPaint.strokeWidth = width;
    switch (cap) {
      case wxCAP_BUTT: 
        _penPaint.strokeCap = StrokeCap.butt;
        break;
      case wxCAP_PROJECTING: 
        _penPaint.strokeCap = StrokeCap.square;
        break;
      default:
        _penPaint.strokeCap = StrokeCap.round;
    }
    switch (join) {
      case wxJOIN_MITER: 
        _penPaint.strokeJoin = StrokeJoin.miter;
        break;
      case wxJOIN_BEVEL: 
        _penPaint.strokeJoin = StrokeJoin.bevel;
        break;
      default:
        _penPaint.strokeJoin = StrokeJoin.round;
    }
  }

  /// Sets current [WxBrush] for all drawing operations. Set it to [wxTRANSPARENT_BRUSH]
  /// to not paint anything
  /// 
  /// See [WxDC.setBrush]
  void setBrush( WxBrush brush ) {
    _currentBrush = brush;
    _brushPaint.color = Color.fromARGB( brush.colour.alpha, brush.colour.red, 
      brush.colour.green, brush.colour.blue );
  }
}

