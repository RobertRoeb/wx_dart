// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxDC ----------------------

const int wxODDEVEN_RULE = 1;
const int wxWINDING_RULE = 2;

/// Base class for [WxPaintDC] and [WxMemoryDC]. It defines the
/// standard 2D drawing interface.
/// 
/// wxDart currently uses the original drawing API from the wxDC
/// group of classes.
/// 
/// wxWidgets has support for a modern path based drawing API from the
/// wxGraphicsContext group of classes. These are not available in wxDart
/// yet. Once done, it will use the Direct2D backend under Windows,
/// CoreGraphics on MacOS, Cairo on Linux and Impeller when using the
/// Flutter backends.

class WxDC extends WxReadOnlyDC {
  WxDC() {
    _penPaint = Paint();
    _penPaint.style = PaintingStyle.stroke;
    _penPaint.strokeCap = StrokeCap.round;
    _penPaint.strokeJoin = StrokeJoin.miter;
    _brushPaint = Paint();
    _brushPaint.style = PaintingStyle.fill;
    setBrush( wxWHITE_BRUSH );
    if (wxTheApp.isDark()) 
    {
      _currentTextForeground = wxWHITE;
      _currentTextBackground = wxGREY;
    }
  }

  late Canvas _canvas;
  late Paint _penPaint;
  late Paint _brushPaint;
  WxPen _currentPen = wxBLACK_PEN;
  late WxBrush _currentBrush;
  WxColour _currentTextForeground = wxBLACK;
  WxColour _currentTextBackground = wxWHITE;
  int _backgroundMode = wxBRUSHSTYLE_TRANSPARENT;

  @override
  void _recalcMatrix()
  {
    super._recalcMatrix();
    _canvas.restore();
    _canvas.save();
    _canvas.translate( (_deviceOriginX + _deviceLocalOriginX).toDouble(), (_deviceOriginY + _deviceLocalOriginY).toDouble());
    _canvas.scale(_scaleX*_signX, _scaleY*_signY );
  }

  /// Draws a line form [x1],[y1] to [x2],[y2] using the current [WxPen]
  void drawLine( int x1, int y1, int x2, int y2 )
  {
    if (_currentPen.isNonTransparent()) {
      _canvas.drawLine( 
        Offset( x1+0.5, y1+0.5 ), 
        Offset( x2+0.5, y2+0.5 ), 
        _penPaint);
    }
  }

  /// Draws a line form [p1] to [p2] using the current [WxPen]
  void drawLinePts( WxPoint p1, WxPoint p2 ) {
    drawLine( p1.x, p1.y, p2.x, p2.y );
  }

  /// Draws lines connecting the [points] using the current [WxPen]
  void drawLines( List<WxPoint> points )
  {
    if (_currentPen.isNonTransparent()) {
      for (int i = 0; i < points.length-1; i++)
      {
        final x1 = points[i].x;
        final y1 = points[i].y;
        final x2 = points[i+1].x;
        final y2 = points[i+1].y;
        _canvas.drawLine( 
          Offset( x1+0.5, y1+0.5 ), 
          Offset( x2+0.5, y2+0.5 ), 
          _penPaint);
      }
    }
  }

  /// Draws a polygon
  /// 
  /// ## Constants
  /// | constant | meaning |
  /// | -------- | -------- |
  /// | wxODDEVEN_RULE | 1 |
  /// | wxWINDING_RULE | 2 |
  void drawPolygon( List<WxPoint> points, { int xOffset = 0, int yOffset = 0, int fillStyle = wxODDEVEN_RULE } )
  {
    if (points.length < 2) return;

    final path = Path();
    path.moveTo( (points[0].x + xOffset)+0.5, (points[0].y + yOffset)+0.5 ); 
    for (int i = 1; i < points.length; i++) {
      path.lineTo( (points[i].x + xOffset)+0.5, (points[i].y + yOffset)+0.5 ); 
    }
    path.close();

    if (_currentBrush.isNonTransparent()) {
      _canvas.drawPath(path, _brushPaint);
    }
    if (_currentPen.isNonTransparent()) {
      _canvas.drawPath(path, _penPaint);
    }
  }

  /// Draws a spline connecting the [points] using the current [WxPen]
  void drawSpline( List<WxPoint> points )
  {
    if (points.length < 2) return;
    if (_currentPen.isNonTransparent())
    {
      Path bezierPath = Path();
      bezierPath.moveTo( points[0].x+0.5, points[0].y+0.5 );

      double x1 = points[0].x +0.5;
      double y1 = points[0].y +0.5;
      double x2 = points[1].x +0.5;
      double y2 = points[1].y +0.5;

      double cx1 = ((x1 + x2) / 2);
      double cy1 = ((y1 + y2) / 2);
      double cx2 = ((cx1 + x2) / 2);
      double cy2 = ((cy1 + y2) / 2);

      for (int i = 0; i < points.length-2; i++)
      {
        x1 = x2;
        y1 = y2;
        x2 = points[i+2].x +0.5;
        y2 = points[i+2].y +0.5;
        double cx4 = (x1 + x2) / 2;
        double cy4 = (y1 + y2) / 2;
        double cx3 = (x1 + cx4) / 2;
        double cy3 = (y1 + cy4) / 2;

        bezierPath.cubicTo( cx2, cy2, cx3, cy3, cx4, cy4  );

        cx1 = cx4;
        cy1 = cy4;
        cx2 = (cx1 + x2) / 2;
        cy2 = (cy1 + y2) / 2;
      }
      bezierPath.lineTo( x2, y2 );
      _canvas.drawPath( bezierPath, _penPaint );
    }
  }

  /// Draws a rectangle with a concentric colour gradient starting from the center of the rectangle 
  void gradientFillConcentric( WxRect rect, WxColour initialColour, WxColour destColour )
  {
    gradientFillConcentricWithCenter( rect, initialColour, destColour, WxPoint( rect.x+(rect.width~/2), rect.y+(rect.height~/2 ) ));
  }

  /// Draws a rectangle with a concentric colour gradient starting from the [center]
  void gradientFillConcentricWithCenter( WxRect rect, WxColour initialColour, 
                        WxColour destColour, WxPoint center  )
  {
    final x1 = rect.x.toDouble();
    final y1 = rect.y.toDouble();
    final x2 = (rect.x+rect.width).toDouble();
    final y2 = (rect.y+rect.height).toDouble();
    _brushPaint.shader = ui.Gradient.radial
    (
        Offset( center.x.toDouble(), center.y.toDouble()),
        max(rect.width,rect.height) / 2,
        [
         Color.fromARGB(initialColour.alpha, initialColour.red, initialColour.green, initialColour.blue),
         Color.fromARGB(destColour.alpha, destColour.red, destColour.green, destColour.blue),
        ],
      );
      _canvas.drawRect( Rect.fromPoints(
          Offset( x1, y1 ),
          Offset( x2, y2 ) ),
        _brushPaint );      

    _brushPaint.shader = null;
  }

  /// Draws a rectangle with a linear colour gradient 
  void gradientFillLinear( WxRect rect, WxColour initialColour, WxColour destColour,
                            { int nDirection = wxRIGHT } )
  {
    final x1 = rect.x.toDouble();
    final y1 = rect.y.toDouble();
    final x2 = (rect.x+rect.width).toDouble();
    final y2 = (rect.y+rect.height).toDouble();
    _brushPaint.shader = ui.Gradient.linear
    (
        (nDirection == wxRIGHT) || (nDirection == wxDOWN) 
         ? Offset(x1, y1)
         : Offset(x2, y2),
        (nDirection == wxRIGHT) || (nDirection == wxDOWN) 
         ? Offset( (nDirection == wxRIGHT) ? x2 : x1, (nDirection == wxDOWN) ? y2 : y1 )
         : Offset( (nDirection == wxLEFT) ? x1 : x2, (nDirection == wxUP) ? y1 : y2 ),
        [
         Color.fromARGB(initialColour.alpha, initialColour.red, initialColour.green, initialColour.blue),
         Color.fromARGB(destColour.alpha, destColour.red, destColour.green, destColour.blue),
        ],
        [0.0, 1.0],
      );
      _canvas.drawRect( Rect.fromPoints(
          Offset( x1, y1 ),
          Offset( x2, y2 ) ),
        _brushPaint );      

    _brushPaint.shader = null;
  }

  /// Draws a rectangle [x],[y] with the [width] and [height] using the
  /// current [WxPen] and filled out using the current [WxBrush]
  /// 
  /// Use [wxTRANSPARENT_PEN] to not draw the outline or
  /// [wxTRANSPARENT_BRUSH] to not fill the interior.
  
  void drawRectangle( int x, int y, int width, int height ) {
    if (_currentBrush.isNonTransparent()) {
      _canvas.drawRect( Rect.fromPoints(
          Offset( x.toDouble(), y.toDouble() ),
          Offset( (x+width).toDouble(), (y+height).toDouble() ) ),
        _brushPaint );      
    }
    if (_currentPen.isNonTransparent()) {
      _canvas.drawRect( Rect.fromPoints(
          Offset( x+0.5, y+0.5 ),
          Offset( (x+width-1)+0.5, (y+height-1)+0.5 ) ),
      _penPaint );
    }
  }

  /// Same as [drawRectangle] using a [WxRect]
  void drawRectangleRect( WxRect rect )
  {
    drawRectangle( rect.x, rect.y, rect.width, rect.height );
  }

  /// Draws a [WxBitmap] at [x],[y].
  /// 
  /// Position and image will be scaled according to [WxReadOnlyDC.setUserScale].
  void drawBitmap( WxBitmap bitmap, int x, int y )
  {
    if (bitmap.isOk()) {
      _canvas.drawImage(bitmap._image!, Offset( x.toDouble(), y.toDouble() ), _penPaint );
    } else {
      if ((this) is WxPaintDC) {
        final paintdc = this as WxPaintDC;
        bitmap._addListener(paintdc._window);
      }
    }
  }

  /// Draws a rectangle [x],[y] with the [width] and [height] using the
  /// current [WxPen] and filled out using the current [WxBrush].
  /// 
  /// The corners will be rounded with the given [radius].
  /// 
  /// Use [wxTRANSPARENT_PEN] to not draw the outline or
  /// [wxTRANSPARENT_BRUSH] to not fill the interior.
  void drawRoundedRectangle( int x, int y, int width, int height, double radius )
  {
    if (_currentBrush.isNonTransparent())
    {
      final Rect rect = Rect.fromPoints(
          Offset( x.toDouble(), y.toDouble() ),
          Offset( (x+width-1).toDouble(), (y+height-1).toDouble() ) );
      final rrect = RRect.fromRectAndRadius( rect, Radius.circular(radius*_scaleX) );
      _canvas.drawRRect( rrect, _brushPaint );      
    }
    if (_currentPen.isNonTransparent())
    {
      final Rect rect = Rect.fromPoints(
          Offset( x+0.5, y+0.5 ),
          Offset( (x+width-1)+0.5, (y+height-1)+0.5 ) );
      final rrect = RRect.fromRectAndRadius( rect, Radius.circular(radius*_scaleX) );
      _canvas.drawRRect( rrect, _penPaint );
    }
  }

  /// Same as [drawRoundedRectangle] using a [WxRect] 
  void drawRoundedRectangleRect( WxRect rect, double radius ) {
    drawRoundedRectangle( rect.x, rect.y, rect.width, rect.height, radius );
  }

  /// Draws [text] at [x],[y] using the current [WxFont] and text
  /// foreground colour
  /// 
  /// Draws a solid background with the current text background colour
  /// if background mode is [wxBRUSHSTYLE_SOLID]
  /// 
  /// See [setTextForeground], [setTextBackground] and [setBackgroundMode]

  void drawText( String text, int x, int y )
  {
    TextPainter textPainter = TextPainter(
        text: TextSpan(
            text: text, 
            style: _convertTextStyle(_currentTextForeground, _font)), 
            maxLines: 1, 
            textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);

    if (_backgroundMode == wxBRUSHSTYLE_SOLID) {
      final width = textPainter.size.width;
      final height = textPainter.size.height;
      final oldColor = _brushPaint.color;
      _brushPaint.color = Color.fromARGB( _currentTextBackground.alpha, 
        _currentTextBackground.red, _currentTextBackground.green, _currentTextBackground.blue );
      _canvas.drawRect( Rect.fromPoints(
          Offset( x.toDouble(), y.toDouble() ),
          Offset( x+width, y+height ) ),  /// TODO 1+1?
        _brushPaint );  
      _brushPaint.color = oldColor;
    }

    Offset offset = Offset( x+0.5, y+0.5 );
    textPainter.paint(_canvas, offset);    
  }

  /// Draws an elliptic arc centered around [x],[y] with [width] and [height] and
  /// with [start] and [end] angles in degrees using the
  /// current [WxPen] and filled out using the current [WxBrush].
  /// 
  /// Use [wxTRANSPARENT_PEN] to not draw the outline or
  /// [wxTRANSPARENT_BRUSH] to not fill the interior.
  void drawEllipticArc( int x, int y, int width, int height, double start, double end )
  {
    final rect = Rect.fromPoints(
          Offset( x+0.5, y+0.5 ),
          Offset( (x+width-1)+0.5, (y+height-1)+0.5 ) );
    if (_currentBrush.isNonTransparent())
    {
      _canvas.drawArc( rect, start /-180*pi, (end-start) /-180*pi, true, _brushPaint );
    }
    if (_currentPen.isNonTransparent())
    {
      _canvas.drawArc( rect, start /-180*pi, (end-start) /-180*pi, false, _penPaint );
    }
  }

  /// Draws an arc from [x1],[y1] to [x2],[y2] where [cx],[cy] is the center.
  /// 
  /// Crazy. Use [drawEllipticArc] instead.
  void drawArc( int x1, int y1, int x2, int y2, int cx, int cy )
  {
    int xx1 = x1;
    int yy1 = y1;
    int xx2 = x2;
    int yy2 = y2;
    int xxc = cx;
    int yyc = cy;
    int dx = xx1 - xxc;
    int dy = yy1 - yyc;
    double radius = sqrt((dx*dx+dy*dy).toDouble());
    int radiusInt = radius.floor();
    double radius1, radius2;

    if (xx1 == xx2 && yy1 == yy2)
    {
        radius1 = 0.0;
        radius2 = 2*pi;
    }
    else if ( radius < 0.01 )
    {
        radius1 =
        radius2 = 0.0;
    }
    else
    {
        radius1 = (xx1 - xxc == 0) ?
            (yy1 - yyc < 0) ? pi/2 : pi/-2 :
            -atan2((yy1-yyc), (xx1-xxc));
        radius2 = (xx2 - xxc == 0) ?
            (yy2 - yyc < 0) ? pi/2 : pi/-2 :
            -atan2((yy2-yyc), (xx2-xxc));
    }
    final start = -radius1;
    final end = -radius2;

    final rect = Rect.fromPoints(
          Offset( (xxc-radiusInt)+0.5, (yyc-radiusInt)+0.5 ),
          Offset( (xxc+radiusInt)+0.5, (yyc+radiusInt)+0.5 ) );
    if (_currentBrush.isNonTransparent())
    {
      _canvas.drawArc( rect, start, (end-start), true, _brushPaint );
    }
    if (_currentPen.isNonTransparent())
    {
      _canvas.drawArc( rect, start, (end-start), _currentBrush.isNonTransparent(), _penPaint );
    }

  }

  /// Same as [drawArc]
  void drawArcPts( WxPoint p1, WxPoint p2, WxPoint center ) {
    drawArc( p1.x, p1.y, p2.x, p2.y, center.x, center.y );
  }

  /// Draws circle with given [radius] around [x],[y] using the
  /// current [WxPen] and filled out using the current [WxBrush].
  /// 
  /// Use [wxTRANSPARENT_PEN] to not draw the outline or
  /// [wxTRANSPARENT_BRUSH] to not fill the interior.
  void drawCircle( int x, int y, int radius ) {
    if (_currentBrush.isNonTransparent())
    {
      final Offset centre = Offset( x+0.5, y+0.5 );
      _canvas.drawCircle( centre, radius*_scaleX, _brushPaint );
    }
    if (_currentPen.isNonTransparent())
    {
      final Offset centre = Offset( x+0.5, y+0.5 );
      _canvas.drawCircle( centre, radius*_scaleX, _penPaint );
    }
  }

  /// Same as [drawCircle] using [pt] as the center.
  void drawCirclePt( WxPoint pt, int radius ) {
    drawCircle( pt.x, pt.y, radius );
  }

  void drawPoint( int x, int y ) {
    if (_currentPen.isNonTransparent()) {
      _canvas.drawLine( 
        Offset( x+0.5, y+0.5 ), 
        Offset( x+0.5, y+0.5 ), 
        _penPaint);
    }
  }

  void drawPointPt( WxPoint pt ) {
    drawPoint( pt.x, pt.y );
  }

  /// Sets the colour of text to be drawn with [drawText]
  void setTextForeground( WxColour colour ) {
    _currentTextForeground = colour;
  }

  /// Returns text foreground colour
  WxColour getTextForeground( ) {
    return _currentTextForeground;
  }

  /// Sets text foreground colour. Call [setBackgroundMode] to actually
  /// make use if of the text background when calling [drawText].
  void setTextBackground( WxColour colour ) {
    _currentTextBackground = colour;
  }

  /// Returns current text background
  WxColour getTextBackground( ) {
    return _currentTextBackground; 
  }

  /// Sets the text background mode. If the background mode is
  /// wxBRUSHSTYLE_SOLID, [drawText] will use the colour set with
  /// [setTextBackground] to draw background. 
  /// 
  /// The default is wxBRUSHSTYLE_TRANSPARENT (drawing no background behind text)
  /// 
  /// ## List of brush styles
  /// | Style | value |
  /// | -------- | -------- |
  /// |   wxBRUSHSTYLE_INVALID      |  -1 | 
  /// |   wxBRUSHSTYLE_SOLID        |  100 | 
  /// |   wxBRUSHSTYLE_TRANSPARENT  |  106 | 
  void setBackgroundMode( int mode ) {
    _backgroundMode = mode; 
  }

  /// Returns the current background mode. See [setBackgroundMode]
  int getBackgroundMode() {
    return _backgroundMode;
  }

  /// Sets current [WxPen] for all drawing operations. Set it to [wxTRANSPARENT_PEN]
  /// to not draw any outlines when drawing shapes.
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

  /// Returns currently used [WxPen]
  WxPen getPen( ) {
    return _currentPen;
  }

  /// Sets current [WxBrush] for all drawing operations. Set it to [wxTRANSPARENT_BRUSH]
  /// to not paint any interior when drawing shapes.
  void setBrush( WxBrush brush ) {
    _currentBrush = brush;
    _brushPaint.color = Color.fromARGB( brush.colour.alpha, brush.colour.red, 
      brush.colour.green, brush.colour.blue );
  }

  /// Returs currently used [WxBrush]
  WxBrush getBrush( ) {
    return _currentBrush;
  }
}
