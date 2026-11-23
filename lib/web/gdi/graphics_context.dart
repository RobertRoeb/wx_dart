// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01 (wxDart Web: 2026-11-16)
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

/// Opaque object representing an image or bitmap optimized for drawing
/// with [WxGraphicsContext.drawBitmap]. These objects should be created
/// outside of a paint event handler.
///
/// See [WxGraphicsContext.createBitmap] and [WxGraphicsContext.createBitmapFromImage]
///
/// See also [WxGraphicsAnimation]
///
/// Example:
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

/// 2D affine matrix (a b c d e f as in the HTML canvas)
class _GcMatrix {
  _GcMatrix(this.a, this.b, this.c, this.d, this.e, this.f);
  _GcMatrix.identity() : a = 1, b = 0, c = 0, d = 1, e = 0, f = 0;

  double a, b, c, d, e, f;

  _GcMatrix copy() => _GcMatrix(a, b, c, d, e, f);

  /// this * m
  _GcMatrix times(_GcMatrix m) {
    return _GcMatrix(
      a * m.a + c * m.b, b * m.a + d * m.b,
      a * m.c + c * m.d, b * m.c + d * m.d,
      a * m.e + c * m.f + e, b * m.e + d * m.f + f);
  }

  void translate(double x, double y) {
    e += a * x + c * y;
    f += b * x + d * y;
  }

  void scale(double sx, double sy) {
    a *= sx; b *= sx;
    c *= sy; d *= sy;
  }

  void rotate(double angle) {
    final cs = cos(angle), sn = sin(angle);
    final na = a * cs + c * sn, nb = b * cs + d * sn;
    final nc = c * cs - a * sn, nd = d * cs - b * sn;
    a = na; b = nb; c = nc; d = nd;
  }
}

/// The pen of a graphics context: colour or gradient, width, caps, joins
class _GcPen {
  _GcPen();

  bool transparent = false;
  String colour = 'rgba(0,0,0,1)';
  int style = wxPENSTYLE_SOLID;
  double width = 1.0;
  int cap = wxCAP_ROUND;
  int join = wxJOIN_MITER;
  // gradient: 1 linear (x1,y1,x2,y2), 2 radial (cx,cy,r)
  int gradient = 0;
  List<double> geometry = const [];
  String colour1 = '';
  String colour2 = '';
}

/// State saved by [WxGraphicsContext.pushState]
class _GcState {
  _GcState(this.matrix, this.clips, this.pen, this.brush, this.font, this.textColour, this.composition);

  final _GcMatrix matrix;
  final List<(_GcMatrix, double, double, double, double)> clips;
  final _GcPen pen;
  final WxBrush brush;
  final WxFont? font;
  final WxColour textColour;
  final String composition;
}

/// Internally, both wxWidgets and wxDart mostly use the original drawing API from
/// the [WxDC] (device context = drawing API) group of classes.
///
/// wxDart also supports a modern path based drawing API from the
/// [WxGraphicsContext] group of classes in all ports. It uses Direct2D under
/// Windows, CoreGraphics on MacOS, Cairo on Linux, Impeller when using the
/// Flutter backend and the HTML canvas in wxDart Web.
///
/// [WxGraphicsContext] uses _double_ values for coordinates, not _int_
/// values like [WxDC]
///
/// See [WxGraphicsBitmap], [WxGraphicsPath] and [WxGraphicsAnimation]
///
/// See also [WxDC], [WxPaintDC], [WxMemoryDC]
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
///
/// In wxDart Web, the graphics context draws on the canvas of the DC it
/// was created from: a [WxPaintDC] in a paint event handler or a
/// [WxMemoryDC]. The transformation of the DC at that moment (scrolling,
/// user scale, high DPI) applies to everything drawn. The graphics
/// context keeps its own state (pen, brush, font, transformation and
/// clipping) and does not change the state of the DC, so both can be
/// used alternately.

class WxGraphicsContext extends WxGraphicsObject {

  /// Creates lightweight graphics context for measuring metric (of text) and
  /// for creating a [WxGraphicsBitmap] from a [WxBitmap] or a [WxImage] outside
  /// of a paint event handler.
  WxGraphicsContext() {
    _initGC();
  }

  /// Creates a graphics context from a [WxPaintDC] in a paint event handler
  ///
  /// Creates a graphics context from a [WxPaintDC] in a paint event handler,
  /// or (wxDart Web) from a [WxMemoryDC]
  WxGraphicsContext.fromDC( WxDC dc ) {
    _ctx = dc._ctx;
    _owner = dc._window;
    final m = _ctx?.getTransform();
    if (m != null) {
      _base = _GcMatrix( m.a, m.b, m.c, m.d, m.e, m.f );
    }
    _initGC();
  }

  void _initGC() {
    if (wxTheApp.isDark()) {
      _textColour = wxWHITE;
    }
  }

  _Ctx2D? _ctx;
  WxWindow? _owner;
  _GcMatrix _base = _GcMatrix.identity();
  _GcMatrix _matrix = _GcMatrix.identity();
  List<(_GcMatrix, double, double, double, double)> _clips = [];
  _GcPen _pen = _GcPen();
  WxBrush _brush = wxTRANSPARENT_BRUSH;
  WxFont? _font;
  WxColour _textColour = wxBLACK;
  String _composition = 'source-over';
  bool _drawNothing = false; // wxCOMPOSITION_DEST
  final List<_GcState> _stack = [];

  // ------------------------- running drawing operations ----------------------

  /// Runs [draw] with the state of this graphics context. The state of the
  /// canvas (and thus of the DC) is restored afterwards.
  void _run( void Function(_Ctx2D c) draw ) {
    final c = _ctx;
    if (c == null) {
      wxLogError( "No valid canvas for graphics context" );
      return;
    }
    if (_drawNothing) return;
    c.save();
    for (final (m, x, y, w, h) in _clips) {
      _setTransform( c, m );
      c.beginPath();
      c.rect( x, y, w, h );
      c.clip();
    }
    _setTransform( c, _matrix );
    c.globalCompositeOperation = _composition;
    draw( c );
    c.restore();
  }

  void _setTransform( _Ctx2D c, _GcMatrix m ) {
    final t = _base.times( m );
    c.setTransform( t.a, t.b, t.c, t.d, t.e, t.f );
  }

  bool _applyPen( _Ctx2D c ) {
    final pen = _pen;
    if (pen.transparent) return false;
    if (pen.gradient == 0) {
      c.strokeStyle = pen.colour;
    } else {
      final g = pen.geometry;
      final gradient = pen.gradient == 1
          ? c.createLinearGradient( g[0], g[1], g[2], g[3] )
          : c.createRadialGradient( g[0], g[1], 0, g[0], g[1], g[2] );
      gradient.addColorStop( 0, pen.colour1 );
      gradient.addColorStop( 1, pen.colour2 );
      c.strokeStyleGradient = gradient;
    }
    final width = pen.width <= 0 ? 1.0 : pen.width;
    c.lineWidth = width;
    c.lineCap = pen.cap == wxCAP_BUTT ? 'butt' : (pen.cap == wxCAP_PROJECTING ? 'square' : 'round');
    c.lineJoin = pen.join == wxJOIN_BEVEL ? 'bevel' : (pen.join == wxJOIN_ROUND ? 'round' : 'miter');
    List<double> dashes;
    switch (pen.style) {
      case wxPENSTYLE_DOT: dashes = [1, 2]; break;
      case wxPENSTYLE_LONG_DASH: dashes = [8, 4]; break;
      case wxPENSTYLE_SHORT_DASH: dashes = [4, 4]; break;
      case wxPENSTYLE_DOT_DASH: dashes = [6, 3, 1, 3]; break;
      default: dashes = [];
    }
    if (dashes.isNotEmpty) {
      c.setLineDash( dashes.map((d) => (d * width).toJS).toList().toJS );
    }
    return true;
  }

  bool _applyBrush( _Ctx2D c ) {
    if (_brush.isTransparent()) return false;
    c.fillStyle = _cssColour( _brush.getColour() );
    return true;
  }

  // ------------------------- state ----------------------

  /// Pushes current state to the stack. You can restore it with [popState].
  void pushState( ) {
    _stack.add( _GcState( _matrix.copy(), List.of(_clips), _pen, _brush, _font, _textColour, _composition ) );
  }

  /// Restores the current state of the grapics context from the stack
  ///
  /// See [pushState]
  void popState( ) {
    if (_stack.isEmpty) {
      wxLogError( "WxGraphicsContext.popState() without pushState()" );
      return;
    }
    final state = _stack.removeLast();
    _matrix = state.matrix;
    _clips = state.clips;
    _pen = state.pen;
    _brush = state.brush;
    _font = state.font;
    _textColour = state.textColour;
    _composition = state.composition;
    _drawNothing = false;
  }

  /// Rotates the current matrix by [angle] in radians
  void rotate( double angle ) {
    _matrix.rotate( angle );
  }

  /// Rotates the current matrix by [x] and [y]
  void translate( double x, double y ) {
    _matrix.translate( x, y );
  }

  /// Scales the current matrix by [xScale] and [yScale]
  void scale( double xScale, double yScale ) {
    _matrix.scale( xScale, yScale );
  }

  /// Sets a clipping area to the specified rectangle
  ///
  /// See [resetClip]
  void clip( double x, double y, double width, double height ) {
    _clips = [..._clips, ( _matrix.copy(), x+0.5, y+0.5, width+0.5, height+0.5 )];
  }

  /// Resets clipping addRectangle. Not supported in wxDart Flutter - use [pushState] and [popState] instead.
  ///
  /// See [clip]
  void resetClip( ) {
    _clips = [];
  }

  // ------------------------- bitmaps ----------------------

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
  void drawBitmap( WxGraphicsBitmap bitmap, double x, double y, double width, double height ) {
    final bmp = bitmap._bitmap;
    if (bmp == null) return;
    final image = bmp._image();
    if (image == null) {
      if (!bmp.hasFailed() && _owner != null) bmp._addListener(_owner!);
      return;
    }
    _run( (c) => c.drawImageScaled( image, x, y, width, height ) );
  }

  // ------------------------- paths and shapes ----------------------

  /// Returns an empty path
  WxGraphicsPath createPath( ) {
    return WxGraphicsPath();
  }

  /// Draws the given [path] with the current pen
  void strokePath( WxGraphicsPath path ) {
    _run( (c) {
      if (_applyPen(c)) c.strokePath2D( path._path );
    } );
  }

  /// Fills the given [path] with the current brush
  void fillPath( WxGraphicsPath path, { int fillStyle = wxODDEVEN_RULE } ) {
    _run( (c) {
      if (_applyBrush(c)) c.fillPath2D( path._path, fillStyle == wxWINDING_RULE ? 'nonzero' : 'evenodd' );
    } );
  }

  /// Fills the given [path] with the current brush and then
  /// stokes it with the current pen
  void drawPath( WxGraphicsPath path, { int fillStyle = wxODDEVEN_RULE } ) {
    _run( (c) {
      if (_applyBrush(c)) c.fillPath2D( path._path, fillStyle == wxWINDING_RULE ? 'nonzero' : 'evenodd' );
      if (_applyPen(c)) c.strokePath2D( path._path );
    } );
  }

  /// Draws a line from [x1],[y1] to [x2],[y2] with the current pen
  void strokeLine( double x1, double y1, double x2, double y2 ) {
    _run( (c) {
      if (!_applyPen(c)) return;
      c.beginPath();
      c.moveTo( x1+0.5, y1+0.5 );
      c.lineTo( x2+0.5, y2+0.5 );
      c.stroke();
    } );
  }

  /// Draws a polyline through [points] with the current pen
  void strokeLines( List<WxRealPoint> points ) {
    if (points.length < 2) return;
    _run( (c) {
      if (!_applyPen(c)) return;
      c.beginPath();
      c.moveTo( points[0].x+0.5, points[0].y+0.5 );
      for (int i = 1; i < points.length; i++) {
        c.lineTo( points[i].x+0.5, points[i].y+0.5 );
      }
      c.stroke();
    } );
  }

  /// Draws a rectangle [x],[y] with the [width] and [height] using the
  /// current [WxPen]
  void drawRectangle( double x, double y, double width, double height ) {
    final path = WxGraphicsPath();
    path.addRectangle( x, y, width, height );
    drawPath( path );
  }

  /// Draws a rounded rectangle from [x],[y] with the dimenssion [width],[height] and [radius] with the current pen
  void drawRoundedRectangle( double x, double y, double width, double height, double radius ) {
    final path = WxGraphicsPath();
    path.addRoundedRectangle( x, y, width, height, radius );
    drawPath( path );
  }

  /// Draws an ellipse in the rectangle [x],[y],[width],[height], filled with
  /// the current brush and outlined with the current pen
  void drawEllipse( double x, double y, double width, double height ) {
    final path = WxGraphicsPath();
    path.addEllipse( x, y, width, height );
    drawPath( path );
  }

  // ------------------------- text ----------------------

  /// Sets the font currently and text colour
  void setFont( WxFont? font, WxColour colour ) {
    _font = font;
    _textColour = colour;
  }

  /// Returns the size in pixels of [text] using the current font
  WxSize getTextExtent( String text ) {
    final css = (_font ?? wxNORMAL_FONT)._css();
    double width = 0, height = 0;
    for (final line in text.split("\n")) {
      final m = _jsMeasureText( css, line );
      width = max( width, m.w );
      height += m.ascent + m.descent;
    }
    return WxSize( width.floor(), height.floor() );
  }

  /// Draws a [text] at [x],[y] with the current pen
  void drawText( String text, double x, double y ) {
    final css = (_font ?? wxNORMAL_FONT)._css();
    _run( (c) {
      c.font = css;
      c.textBaseline = 'alphabetic';
      c.fillStyle = _cssColour( _textColour );
      double ty = y+0.5;
      for (final line in text.split("\n")) {
        final m = _jsMeasureText( css, line );
        c.fillText( line, x+0.5, ty + m.ascent );
        ty += m.ascent + m.descent;
      }
    } );
  }

  // ------------------------- composition ----------------------

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
///
/// In wxDart Web, wxCOMPOSITION_CLEAR erases what is drawn over
/// (the HTML canvas has no exact equivalent).
  bool setCompositionMode( int mode ) {
    String? op;
    switch (mode) {
      case wxCOMPOSITION_CLEAR: op = 'destination-out'; break;
      case wxCOMPOSITION_SOURCE: op = 'copy'; break;
      case wxCOMPOSITION_OVER: op = 'source-over'; break;
      case wxCOMPOSITION_IN: op = 'source-in'; break;
      case wxCOMPOSITION_OUT: op = 'source-out'; break;
      case wxCOMPOSITION_ATOP: op = 'source-atop'; break;
      case wxCOMPOSITION_DEST: op = 'source-over'; break;
      case wxCOMPOSITION_DEST_OVER: op = 'destination-over'; break;
      case wxCOMPOSITION_DEST_IN: op = 'destination-in'; break;
      case wxCOMPOSITION_DEST_OUT: op = 'destination-out'; break;
      case wxCOMPOSITION_DEST_ATOP: op = 'destination-atop'; break;
      case wxCOMPOSITION_XOR: op = 'xor'; break;
      case wxCOMPOSITION_ADD: op = 'lighter'; break;
      case wxCOMPOSITION_DIFF: op = 'difference'; break;
    }
    if (op == null) return false;
    _composition = op;
    _drawNothing = mode == wxCOMPOSITION_DEST;
    return true;
  }

  // ------------------------- pens and brushes ----------------------

  /// Sets current [WxPen] for all drawing operations. Set it to [wxTRANSPARENT_PEN]
  /// to not draw anything
  ///
  /// See [WxDC.setPen]
  void setPen( WxPen pen ) {
    final p = _GcPen();
    p.transparent = pen.isTransparent();
    p.colour = _cssColour( pen.getColour() );
    p.style = pen.getStyle();
    p.width = pen.getWidth().toDouble();
    p.cap = pen.getCapStyle();
    p.join = pen.getJoinStyle();
    _pen = p;
  }

  /// Sets current pen to given values for all drawing operations. Same as
  /// [setPen] but using a double for defining the width
  void setPenWithConstantColour( WxColour colour, { double width = 1.0, int style = wxPENSTYLE_SOLID, int cap = wxCAP_ROUND, int join = wxJOIN_MITER } ) {
    final p = _GcPen();
    p.transparent = style == wxPENSTYLE_TRANSPARENT;
    p.colour = _cssColour( colour );
    p.style = style;
    p.width = width;
    p.cap = cap;
    p.join = join;
    _pen = p;
  }

  /// Sets current pen to have a linear colour gradient with the given values for all drawing operations.
  void setPenWithLinearGradient( double x1, double y1, double x2, double y2, WxColour colour1, WxColour colour2, { double width = 1.0, int style = wxPENSTYLE_SOLID, int cap = wxCAP_ROUND, int join = wxJOIN_MITER } ) {
    setPenWithConstantColour( colour1, width: width, style: style, cap: cap, join: join );
    _pen.gradient = 1;
    _pen.geometry = [x1, y1, x2, y2];
    _pen.colour1 = _cssColour( colour1 );
    _pen.colour2 = _cssColour( colour2 );
  }

  /// Sets current pen to have a radial colour gradient with the given values for all drawing operations.
  void setPenWithRadialGradient( double startX, double startY, double endX, double endY, double radius, WxColour outerColour, WxColour innerColour, { double width = 1.0, int style = wxPENSTYLE_SOLID, int cap = wxCAP_ROUND, int join = wxJOIN_MITER } ) {
    setPenWithConstantColour( innerColour, width: width, style: style, cap: cap, join: join );
    _pen.gradient = 2;
    _pen.geometry = [(startX+endX)/2, (startY+endY)/2, radius];
    _pen.colour1 = _cssColour( innerColour );
    _pen.colour2 = _cssColour( outerColour );
  }

  /// Sets current [WxBrush] for all drawing operations. Set it to [wxTRANSPARENT_BRUSH]
  /// to not paint anything
  ///
  /// See [WxDC.setBrush]
  void setBrush( WxBrush brush ) {
    _brush = brush;
  }
}
