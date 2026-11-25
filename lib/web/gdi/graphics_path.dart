// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01 (wxDart Web: 2026-11-16)
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
///
/// In wxDart Web, the path is an HTML canvas Path2D. As in wxDart Flutter,
/// all coordinates are moved by half a pixel so that one pixel wide lines
/// at integer coordinates are drawn sharply.
class WxGraphicsPath extends WxGraphicsObject {

  // Needed for overriding WxGraphicsClasses in native and non-native ports
  WxGraphicsPath._defaultConstructor();

  /// Don't call this: use [WxGraphicsContext.createPath] to create a path.
  WxGraphicsPath( );

  final _Path2D _path = _Path2D();

  /// Moves to position specified by [x],[y]
  void moveTo( double x, double y ) {
    _path.moveTo( x+0.5, y+0.5 );
  }

  /// Closes sub path
  void closeSubpath( ) {
    _path.closePath();
  }

  /// Adds line from current position to position specified by [x],[y]
  void addLineTo( double x, double y ) {
    _path.lineTo( x+0.5, y+0.5 );
  }

  /// Adds [path] to this path
  void addPath( WxGraphicsPath path ) {
    _path.addPath( path._path );
  }

  /// Adds closed subpath with rectangle specified by [x],[y],[width],[height]
  void addRectangle( double x, double y, double width, double height ) {
    _path.rect( x+0.5, y+0.5, width, height );
  }

  /// Adds closed subpath with rounded rectangle specified by [x],[y],[width],[height] and [radius]
  void addRoundedRectangle( double x, double y, double width, double height, double radius ) {
    if (radius <= 0) {
      addRectangle( x, y, width, height );
      return;
    }
    final r = min( radius, min( width, height ) / 2 );
    final x0 = x+0.5, y0 = y+0.5;
    _path.moveTo( x0 + r, y0 );
    _path.lineTo( x0 + width - r, y0 );
    _path.arc( x0 + width - r, y0 + r, r, -pi / 2, 0, false );
    _path.lineTo( x0 + width, y0 + height - r );
    _path.arc( x0 + width - r, y0 + height - r, r, 0, pi / 2, false );
    _path.lineTo( x0 + r, y0 + height );
    _path.arc( x0 + r, y0 + height - r, r, pi / 2, pi, false );
    _path.lineTo( x0, y0 + r );
    _path.arc( x0 + r, y0 + r, r, pi, pi * 1.5, false );
    _path.closePath();
  }

  /// Adds closed subpath with circle specified by [x],[y] and [radius]
  void addCircle( double x, double y, double radius ) {
    _path.moveTo( x+0.5+radius, y+0.5 );
    _path.arc( x+0.5, y+0.5, radius, 0, 2*pi, false );
    _path.closePath();
  }

  /// Adds closed subpath with ellipse specified by [x],[y],[width],[height]
  void addEllipse( double x, double y, double width, double height ) {
    _path.moveTo( x+0.5+width, y+0.5+height/2 );
    _path.ellipse( x+0.5+width/2, y+0.5+height/2, width/2, height/2, 0, 0, 2*pi );
    _path.closePath();
  }

  /// Adds an arc of a circle around [x],[y] with [radius] from [startAngle]
  /// to [endAngle] (in radians, 0 is the 3 o'clock position). A line is added
  /// from the current point to the start of the arc.
  void addArc( double x, double y, double radius, double startAngle, double endAngle, bool clockwise ) {
    // the y axis points down, so "clockwise" on screen is the canvas default
    _path.arc( x+0.5, y+0.5, radius, startAngle, endAngle, !clockwise );
  }
}
