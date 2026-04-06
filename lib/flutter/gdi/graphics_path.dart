// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxGraphicsPath ----------------------

/// Represents a path to be drawn by a [WxGraphicsContext]
/// 
/// Example usage in a paint event handler of a [WxScrolledWindow]:
/// ```dart
///  void onPaint( WxPaintEvent event )
///  {
///    // create paint dc
///    final dc = WxPaintDC( this );
///
///    // adapt to scrolling
///    doPrepareDC(dc);
///
///    // create graphics context from paint dc
///    final gc = WxGraphicsContext.fromDC(dc);
///
///    // use red pen
///    gc.setPen(wxRED_PEN);
///
///    // create path
///    final path = gc.createPath();
///        path.addCircle( 50.0, 50.0, 50.0 );
///        path.moveTo(0.0, 50.0);
///        path.addLineTo(100.0, 50.0);
///        path.moveTo(50.0, 0.0);
///        path.addLineTo(50.0, 100.0 );
///        path.closeSubpath();
///        path.addRectangle(25.0, 25.0, 50.0, 50.0); 
///
///    // draw path
///    gc.strokePath(path);    
///  }
/// ```
class WxGraphicsPath extends WxGraphicsObject {

  /// Creates a [WxGraphicsPath]. Called internally by [WxGraphicsContext.createPath]
  WxGraphicsPath( ) {
    _path = Path();
  }

  late Path _path;

  /// Moves to position specified by [x],[y]
  void moveTo( double x, double y ) {
    _path.moveTo( x+0.5, y+0.5 );
  }

  /// Closes sub path
  void closeSubpath( ) {
    _path.close();
  }

  /// Adds line from current position to position specified by [x],[y]
  void addLineTo( double x, double y ) {
    _path.lineTo( x+0.5, y+0.5 );
  }

  /// Adds [path] to this path
  void addPath( WxGraphicsPath path ) {
    _path.addPath( path._path, Offset.zero );
  }

  /// Adds closed subpath with rectangle specified by [x],[y],[width],[height]
  void addRectangle( double x, double y, double height, double width ) {
    _path.addRect( Rect.fromLTWH(x+0.5,y+0.5,width,height) );
  }

  /// Adds closed subpath with rounded rectangle specified by [x],[y],[width],[height] and [radius]
  void addRoundedRectangle( double x, double y, double height, double width, double radius ) {
    _path.addRRect( RRect.fromRectAndRadius( Rect.fromLTWH(x+0.5,y+0.5,width,height), Radius.circular( radius ) ) );
  }

  /// Adds closed subpath with circle specified by [x],[y] and [radius]
  void addCircle( double x, double y, double radius ) {
    _path.addOval( Rect.fromLTWH(x+0.5-radius,y+0.5-radius,x+0.5+radius,y+0.5+radius) );
  }

  /// Adds closed subpath with ellipse specified by [x],[y],[width],[height]
  void addEllipse( double x, double y, double height, double width ) {
    _path.addOval( Rect.fromLTWH(x+0.5,y+0.5,width,height) );
  }

  /// Adds arcspecified by [x],[y],[radius] with [startAngle] and [endAngle]
  void addArc( double x, double y, double radius, double startAngle, double endAngle, bool clockwise ) {
    if (clockwise) {
      _path.addArc( Rect.fromLTWH(x+0.5-radius,y+0.5-radius,x+0.5+radius,y+0.5+radius), startAngle, endAngle );
    } else {
      _path.addArc( Rect.fromLTWH(x+0.5-radius,y+0.5-radius,x+0.5+radius,y+0.5+radius), endAngle, startAngle );
    }
  }
}
