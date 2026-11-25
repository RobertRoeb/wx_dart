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

  // Needed for overriding WxGraphicsClasses in native and non-native ports
  WxGraphicsPath._defaultConstructor();

  /// Don't call this: use [WxGraphicsContext.createPath] to create a path.
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
  void addRectangle( double x, double y, double width, double height ) {
    _path.addRect( Rect.fromLTWH(x+0.5,y+0.5,width,height) );
  }

  /// Adds closed subpath with rounded rectangle specified by [x],[y],[width],[height] and [radius]
  void addRoundedRectangle( double x, double y, double width, double height, double radius ) {
    _path.addRRect( RRect.fromRectAndRadius( Rect.fromLTWH(x+0.5,y+0.5,width,height), Radius.circular( radius ) ) );
  }

  /// Adds closed subpath with circle specified by [x],[y] and [radius]
  void addCircle( double x, double y, double radius ) {
    _path.addOval( Rect.fromLTWH(x+0.5-radius,y+0.5-radius,2*radius,2*radius) );
  }

  /// Adds closed subpath with ellipse specified by [x],[y],[width],[height]
  void addEllipse( double x, double y, double width, double height ) {
    _path.addOval( Rect.fromLTWH(x+0.5,y+0.5,width,height) );
  }

  /// Adds an arc of a circle around [x],[y] with [radius] from [startAngle]
  /// to [endAngle] (in radians, 0 is the 3 o'clock position). A line is added
  /// from the current point to the start of the arc.
  void addArc( double x, double y, double radius, double startAngle, double endAngle, bool clockwise ) {
    // the y axis points down, so positive sweep angles go clockwise on screen
    double sweep = endAngle - startAngle;
    if (clockwise) {
      while (sweep < 0) {
        sweep += 2*pi;
      }
    } else {
      while (sweep > 0) {
        sweep -= 2*pi;
      }
    }
    final rect = Rect.fromLTWH( x+0.5-radius, y+0.5-radius, 2*radius, 2*radius );
    if (sweep.abs() >= 2*pi - 1e-9) {
      // Flutter does not draw an arc of a full circle in one step
      _path.arcTo( rect, startAngle, sweep/2, false );
      _path.arcTo( rect, startAngle + sweep/2, sweep/2, false );
    } else {
      _path.arcTo( rect, startAngle, sweep, false );
    }
  }
}
