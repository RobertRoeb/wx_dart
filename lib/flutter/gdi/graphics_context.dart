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

// ------------------------- wxGraphicsContext ----------------------

/// wxDart currently uses the original drawing API from the [WxDC]
/// (device context = drawing API) group of classes.
/// 
/// wxWidgets has support for a modern path based drawing API from the
/// [WxGraphicsContext] group of classes. These are currently being 
/// implemented in wxDart Native and wxDart Flutter.
/// Once done, it will use the Direct2D backend under Windows,
/// CoreGraphics on MacOS, Cairo on Linux and Impeller when using the
/// Flutter backend.
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

  /// Creates lightweigt graphics context for measuring metric (of text) and
  /// for creating a WxGraphicsBitmap from a WxBitmap (TODO) outside of a 
  /// paint event handler.
  WxGraphicsContext()
  {
    _initGC();
  }

  /// Creates a graphics context from a [WxPaintDC] in a paint event handler
  WxGraphicsContext.fromDC( WxPaintDC dc )  
  {
    _canvas = dc._canvas;
    _initGC();
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
      _currentTextForeground = wxWHITE;
    }
  }

  Canvas? _canvas;
  late Paint _penPaint;
  late Paint _brushPaint;
  WxPen _currentPen = wxBLACK_PEN;
  late WxBrush _currentBrush;
  WxColour _currentTextForeground = wxBLACK;


  /// Sets current [WxPen] for all drawing operations. Set it to [wxTRANSPARENT_PEN]
  /// to not draw anything
  /// 
  /// See [WxDC.setPen]
  void setPen( WxPen pen ) {
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

  /// Sets current [WxBrush] for all drawing operations. Set it to [wxTRANSPARENT_BRUSH]
  /// to not paint anything
  /// 
  /// See [WxDC.setBrush]
  void setBrush( WxBrush brush ) {
    _currentBrush = brush;
    _brushPaint.color = Color.fromARGB( brush.colour.alpha, brush.colour.red, 
      brush.colour.green, brush.colour.blue );
  }

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
}

