// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-11-15
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxTextExtent ----------------------

/// Extended information about the extent of a text
class WxTextExtent {
  const WxTextExtent(this.width, this.height, this.descent, this.externalLeading);
  final int width;
  final int height;
  final int descent;
  final int externalLeading;
}

// ------------------------- wxReadOnlyDC ----------------------

/// Base class for device contexts: coordinate transformations and text
/// measuring.
///
/// wx semantics: device = logical * scale + device origin
class WxReadOnlyDC extends WxObject {
  WxReadOnlyDC();

  WxFont? _font;
  double _userScaleX = 1.0;
  double _userScaleY = 1.0;
  double _logicalScaleX = 1.0;
  double _logicalScaleY = 1.0;
  double _signX = 1.0;
  double _signY = 1.0;
  int _deviceOriginX = 0;
  int _deviceOriginY = 0;
  int _logicalOriginX = 0;
  int _logicalOriginY = 0;
  double _contentScaleFactor = 1.0;

  double get _scaleX => _userScaleX * _logicalScaleX * _signX;
  double get _scaleY => _userScaleY * _logicalScaleY * _signY;

  /// Returns the content scale factor relevant for producing high
  /// resolution bitmaps (e.g. 64x64) even if the logical scale on
  /// screen is 32x32.
  ///
  /// see [WxWindow.getDPIScaleFactor] and [WxWindow.getContentScaleFactor]
  double getContentScaleFactor() {
    return _contentScaleFactor;
  }

  /// Returns the current font
  WxFont getFont() {
    return _font ?? wxNORMAL_FONT;
  }

  /// Sets the font currently used in the device context
  void setFont(WxFont? font) {
    _font = font;
  }

  /// Returns the size in pixels of [text] using the current font
  ///
  /// See also [getTextExtentEx], [getPartialTextExtents]
  WxSize getTextExtent(String text) {
    final e = getTextExtentEx(text);
    return WxSize(e.width, e.height);
  }

  /// Returns the full metrics of [text] using the current font
  ///
  /// See also [getTextExtent], [getPartialTextExtents]
  WxTextExtent getTextExtentEx(String text) {
    final css = getFont()._css();
    final lines = text.split("\n");
    double width = 0;
    double ascent = 0, descent = 0;
    for (final line in lines) {
      final m = _jsMeasureText(css, line);
      width = max(width, m.w);
      ascent = m.ascent;
      descent = m.descent;
    }
    final lineHeight = (ascent + descent).ceil();
    return WxTextExtent(width.ceil(), lineHeight * lines.length, descent.ceil(), 0);
  }

  /// Returns for every character of [text] the width of the text up
  /// to the end and including that character
  ///
  /// See also [getTextExtent], [getTextExtentEx]
  List<int> getPartialTextExtents(String text) {
    final css = getFont()._css();
    final result = <int>[];
    for (int i = 1; i <= text.length; i++) {
      result.add(_jsMeasureText(css, text.substring(0, i)).w.round());
    }
    return result;
  }

  int getCharHeight() {
    return getTextExtent("Xg").y;
  }

  int getCharWidth() {
    return getTextExtent("x").x;
  }

  void _transformChanged() {}

  /// Set the orientation of the axis.
  ///
  /// The default in wxDart is the origin in the top left corner
  /// of a window.
  void setAxisOrientation(bool xLeftRight, bool yBottomUp) {
    _signX = xLeftRight ? 1.0 : -1.0;
    _signY = yBottomUp ? -1.0 : 1.0;
    _transformChanged();
  }

  void setDeviceOrigin(int x, int y) {
    _deviceOriginX = x;
    _deviceOriginY = y;
    _transformChanged();
  }

  /// Gets the device context origin.
  ///
  /// This is used internally by [WxScrolledWindow] to account
  /// for scrolling offsets.
  WxPoint getDeviceOrigin() {
    return WxPoint(_deviceOriginX, _deviceOriginY);
  }

  void setLogicalOrigin(int x, int y) {
    _logicalOriginX = x;
    _logicalOriginY = y;
    _transformChanged();
  }

  WxPoint getLogicalOrigin() {
    return WxPoint(_logicalOriginX, _logicalOriginY);
  }

  /// Scale the output of the device context. On most platforms
  /// the scaling is done by the GPU and as such very efficient.
  void setUserScale(double xScale, double yScale) {
    _userScaleX = xScale;
    _userScaleY = yScale;
    _transformChanged();
  }

  WxRealPoint getUserScale() {
    return WxRealPoint(_userScaleX, _userScaleY);
  }

  /// @nodoc
  void setLogicalScale(double x, double y) {
    _logicalScaleX = x;
    _logicalScaleY = y;
    _transformChanged();
  }

  /// Conversion between logical and device. Used internally.
  int deviceToLogicalX(int x) {
    return ((x - _deviceOriginX) / _scaleX).round() + _logicalOriginX;
  }

  /// Conversion between logical and device. Used internally.
  int deviceToLogicalXRel(int x) {
    return (x / _scaleX).round();
  }

  /// Conversion between logical and device. Used internally.
  int deviceToLogicalY(int y) {
    return ((y - _deviceOriginY) / _scaleY).round() + _logicalOriginY;
  }

  /// Conversion between logical and device. Used internally.
  int deviceToLogicalYRel(int y) {
    return (y / _scaleY).round();
  }

  /// Conversion between logical and device. Used internally.
  int logicalToDeviceX(int x) {
    return ((x - _logicalOriginX) * _scaleX).round() + _deviceOriginX;
  }

  /// Conversion between logical and device. Used internally.
  int logicalToDeviceXRel(int x) {
    return (x * _scaleX).round();
  }

  /// Conversion between logical and device. Used internally.
  int logicalToDeviceY(int y) {
    return ((y - _logicalOriginY) * _scaleY).round() + _deviceOriginY;
  }

  /// Conversion between logical and device. Used internally.
  int logicalToDeviceYRel(int y) {
    return (y * _scaleY).round();
  }

  /// Converts from logical to device dependent pixels. This leaves
  /// the values unchanged everywhere except for wxDart Native on
  /// Windows where it gets scaled.
  int fromDIP(int x) {
    return x;
  }
}

// ------------------------- wxDC ----------------------

const double _kDegToRad = pi / 180.0;

/// Device context drawing on an HTML canvas (CanvasRenderingContext2D).
///
/// Supports pens (width, colour, dash styles, caps, joins), brushes
/// (solid, transparent), fonts, text foreground/background, clipping,
/// device origin, user scale, axis orientation and bitmaps.
class WxDC extends WxReadOnlyDC {
  WxDC();

  _Ctx2D? _ctx;
  WxWindow? _window;
  WxPen _pen = wxBLACK_PEN;
  WxBrush _brush = wxWHITE_BRUSH;
  WxBrush? _background;
  WxColour _textForeground = wxBLACK;
  WxColour _textBackground = wxWHITE;
  int _backgroundMode = wxBRUSHSTYLE_TRANSPARENT;
  WxRect? _clip;
  int _clipDepth = 0;
  double _dpr = 1.0;

  // cache to avoid re-parsing colours and fonts in the browser
  String? _lastFill;
  String? _lastStroke;
  String? _lastFont;
  double _lastLineWidth = -1;
  int _lastDashStyle = -100;
  int _lastCap = -100;
  int _lastJoin = -100;

  void _init(_Ctx2D? ctx, WxWindow? window) {
    _ctx = ctx;
    _window = window;
    _dpr = _jsDevicePixelRatio();
    _contentScaleFactor = _dpr;
    if (ctx != null) {
      ctx.textBaseline = 'alphabetic';
      _applyTransform();
    }
  }

  @override
  void _transformChanged() {
    _applyTransform();
  }

  void _applyTransform() {
    final c = _ctx;
    if (c == null) return;
    final sx = _scaleX * _dpr;
    final sy = _scaleY * _dpr;
    c.setTransform(sx, 0, 0, sy, (_deviceOriginX - _logicalOriginX * _scaleX) * _dpr,
        (_deviceOriginY - _logicalOriginY * _scaleY) * _dpr);
  }

  bool _isUnitScale() {
    return _scaleX == 1.0 && _scaleY == 1.0;
  }

  // ------------------------- state ----------------------

  /// Sets current [WxPen] for all drawing operations. Set it to [wxTRANSPARENT_PEN]
  /// to not draw any outlines when drawing shapes.
  void setPen(WxPen pen) {
    _pen = pen;
  }

  /// Returns currently used [WxPen]
  WxPen getPen() {
    return _pen;
  }

  /// Sets current [WxBrush] for all drawing operations. Set it to [wxTRANSPARENT_BRUSH]
  /// to not paint any interior when drawing shapes.
  void setBrush(WxBrush brush) {
    _brush = brush;
  }

  /// Returs currently used [WxBrush]
  WxBrush getBrush() {
    return _brush;
  }

  void setBackground(WxBrush brush) {
    _background = brush;
  }

  WxBrush getBackground() {
    return _background ?? wxTRANSPARENT_BRUSH;
  }

  /// Sets the colour of text to be drawn with [drawText]
  void setTextForeground(WxColour colour) {
    _textForeground = colour;
  }

  /// Returns text foreground colour
  WxColour getTextForeground() {
    return _textForeground;
  }

  /// Sets text foreground colour. Call [setBackgroundMode] to actually
  /// make use if of the text background when calling [drawText].
  void setTextBackground(WxColour colour) {
    _textBackground = colour;
  }

  /// Returns current text background
  WxColour getTextBackground() {
    return _textBackground;
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
  void setBackgroundMode(int mode) {
    _backgroundMode = mode;
  }

  /// Returns the current background mode. See [setBackgroundMode]
  int getBackgroundMode() {
    return _backgroundMode;
  }

  /// Size of the drawing area in device (CSS) pixels
  WxSize getSize() {
    return _window?.getClientSize() ?? WxSize.zero;
  }

  bool isOk() {
    return _ctx != null;
  }

  // ------------------------- applying state ----------------------

  void _setFill(_Ctx2D c, WxColour colour) {
    final css = _cssColour(colour);
    if (css != _lastFill) {
      c.fillStyle = css;
      _lastFill = css;
    }
  }

  bool _applyBrush(_Ctx2D c) {
    if (_brush.isTransparent()) return false;
    _setFill(c, _brush.getColour());
    return true;
  }

  bool _applyPen(_Ctx2D c) {
    final pen = _pen;
    if (pen.isTransparent()) return false;
    final css = _cssColour(pen.getColour());
    if (css != _lastStroke) {
      c.strokeStyle = css;
      _lastStroke = css;
    }
    final width = pen.getWidth() <= 0 ? 1.0 : pen.getWidth().toDouble();
    if (width != _lastLineWidth) {
      c.lineWidth = width;
      _lastLineWidth = width;
    }
    if (pen.getCapStyle() != _lastCap) {
      _lastCap = pen.getCapStyle();
      c.lineCap = _lastCap == wxCAP_BUTT ? 'butt' : (_lastCap == wxCAP_PROJECTING ? 'square' : 'round');
    }
    if (pen.getJoinStyle() != _lastJoin) {
      _lastJoin = pen.getJoinStyle();
      c.lineJoin = _lastJoin == wxJOIN_BEVEL ? 'bevel' : (_lastJoin == wxJOIN_ROUND ? 'round' : 'miter');
    }
    if (pen.getStyle() != _lastDashStyle) {
      _lastDashStyle = pen.getStyle();
      List<double> dashes;
      switch (_lastDashStyle) {
        case wxPENSTYLE_DOT:
          dashes = [1, 2];
          break;
        case wxPENSTYLE_LONG_DASH:
          dashes = [8, 4];
          break;
        case wxPENSTYLE_SHORT_DASH:
          dashes = [4, 4];
          break;
        case wxPENSTYLE_DOT_DASH:
          dashes = [6, 3, 1, 3];
          break;
        default:
          dashes = [];
      }
      c.setLineDash(dashes.map((d) => (d * width).toJS).toList().toJS);
    }
    return true;
  }

  /// Offset for crisp lines: odd line widths are drawn on pixel centres
  double _penOffset() {
    if (!_isUnitScale()) return 0.0;
    final w = _pen.getWidth() <= 0 ? 1 : _pen.getWidth();
    return w.isOdd ? 0.5 : 0.0;
  }

  void _applyFont(_Ctx2D c) {
    final css = getFont()._css();
    if (css != _lastFont) {
      c.font = css;
      _lastFont = css;
    }
  }

  // ------------------------- clipping ----------------------

  /// Sets the clipping region for this device context to the intersection of the given region described
  /// by the parameters of this method and the previously set clipping region.
  ///
  /// Clipping region should be given in logical coordinates.
  void setClippingRegion(int x, int y, int width, int height) {
    final c = _ctx;
    if (c == null) return;
    var rect = WxRect(x, y, width, height);
    final old = _clip;
    if (old != null) {
      // wx intersects with the existing clipping region
      final l = max(old.x, x), t = max(old.y, y);
      final r = min(old.x + old.width, x + width), b = min(old.y + old.height, y + height);
      rect = WxRect(l, t, max(0, r - l), max(0, b - t));
    }
    c.save();
    _clipDepth++;
    c.beginPath();
    c.rect(rect.x.toDouble(), rect.y.toDouble(), rect.width.toDouble(), rect.height.toDouble());
    c.clip();
    _clip = rect;
  }

  /// Same as setClippingRegion, but with [WxRect] as the parameter
  void setClippingRegionRect(WxRect rect) {
    setClippingRegion(rect.x, rect.y, rect.width, rect.height);
  }

  /// Destroys the current clipping region so that none of the DC is clipped.
  void destroyClippingRegion() {
    final c = _ctx;
    if (c == null) return;
    while (_clipDepth > 0) {
      c.restore();
      _clipDepth--;
    }
    _clip = null;
    // restore() also reset styles and the transformation
    _lastFill = _lastStroke = _lastFont = null;
    _lastLineWidth = -1;
    _lastDashStyle = _lastCap = _lastJoin = -100;
    _applyTransform();
  }

  /// Returns the current clipping box in logical coordiantes, or null
  WxRect? getClippingBox() {
    return _clip;
  }

  // ------------------------- drawing ----------------------

  /// Fills the whole area with the background brush (or clears it)
  void clear() {
    final c = _ctx;
    if (c == null) return;
    final size = getSize();
    c.save();
    c.setTransform(1, 0, 0, 1, 0, 0);
    final bg = _background;
    if (bg == null || bg.isTransparent()) {
      c.clearRect(0, 0, size.x * _dpr, size.y * _dpr);
    } else {
      c.fillStyle = _cssColour(bg.getColour());
      c.fillRect(0, 0, size.x * _dpr, size.y * _dpr);
    }
    c.restore();
    _lastFill = null;
  }

  /// Draws a line form [x1],[y1] to [x2],[y2] using the current [WxPen]
  void drawLine(int x1, int y1, int x2, int y2) {
    final c = _ctx;
    if (c == null || !_applyPen(c)) return;
    final o = _penOffset();
    c.beginPath();
    c.moveTo(x1 + o, y1 + o);
    c.lineTo(x2 + o, y2 + o);
    c.stroke();
  }

  /// Draws a line form [p1] to [p2] using the current [WxPen]
  void drawLinePts(WxPoint p1, WxPoint p2) {
    drawLine(p1.x, p1.y, p2.x, p2.y);
  }

  /// Draws lines connecting the [points] using the current [WxPen]
  void drawLines(List<WxPoint> points, {int xOffset = 0, int yOffset = 0}) {
    final c = _ctx;
    if (c == null || points.length < 2 || !_applyPen(c)) return;
    final o = _penOffset();
    c.beginPath();
    c.moveTo(points[0].x + xOffset + o, points[0].y + yOffset + o);
    for (int i = 1; i < points.length; i++) {
      c.lineTo(points[i].x + xOffset + o, points[i].y + yOffset + o);
    }
    c.stroke();
  }

  /// Draws a polygon
  ///
  /// ## Constants
  /// | constant | meaning |
  /// | -------- | -------- |
  /// | wxODDEVEN_RULE | 1 |
  /// | wxWINDING_RULE | 2 |
  void drawPolygon(List<WxPoint> points, {int xOffset = 0, int yOffset = 0, int fillStyle = wxODDEVEN_RULE}) {
    final c = _ctx;
    if (c == null || points.length < 2) return;
    c.beginPath();
    c.moveTo((points[0].x + xOffset).toDouble(), (points[0].y + yOffset).toDouble());
    for (int i = 1; i < points.length; i++) {
      c.lineTo((points[i].x + xOffset).toDouble(), (points[i].y + yOffset).toDouble());
    }
    c.closePath();
    if (_applyBrush(c)) c.fill(fillStyle == wxWINDING_RULE ? 'nonzero' : 'evenodd');
    if (_applyPen(c)) c.stroke();
  }

  /// Draws a spline connecting the [points] using the current [WxPen]
  void drawSpline(List<WxPoint> points) {
    final c = _ctx;
    if (c == null || points.length < 2 || !_applyPen(c)) return;
    c.beginPath();
    c.moveTo(points[0].x.toDouble(), points[0].y.toDouble());
    if (points.length == 2) {
      c.lineTo(points[1].x.toDouble(), points[1].y.toDouble());
    } else {
      for (int i = 1; i < points.length - 2; i++) {
        final mx = (points[i].x + points[i + 1].x) / 2;
        final my = (points[i].y + points[i + 1].y) / 2;
        c.quadraticCurveTo(points[i].x.toDouble(), points[i].y.toDouble(), mx, my);
      }
      final n = points.length;
      c.quadraticCurveTo(points[n - 2].x.toDouble(), points[n - 2].y.toDouble(),
          points[n - 1].x.toDouble(), points[n - 1].y.toDouble());
    }
    c.stroke();
  }

  void drawRectangle(int x, int y, int width, int height) {
    final c = _ctx;
    if (c == null) return;
    if (_applyBrush(c)) {
      c.fillRect(x.toDouble(), y.toDouble(), width.toDouble(), height.toDouble());
    }
    if (_applyPen(c)) {
      final pw = _pen.getWidth() <= 0 ? 1.0 : _pen.getWidth().toDouble();
      c.strokeRect(x + pw / 2, y + pw / 2, max(0.0, width - pw), max(0.0, height - pw));
    }
  }

  /// Same as [drawRectangle] using a [WxRect]
  void drawRectangleRect(WxRect rect) {
    drawRectangle(rect.x, rect.y, rect.width, rect.height);
  }

  /// Draws a rectangle [x],[y] with the [width] and [height] using the
  /// current [WxPen] and filled out using the current [WxBrush].
  ///
  /// The corners will be rounded with the given [radius].
  ///
  /// Use [wxTRANSPARENT_PEN] to not draw the outline or
  /// [wxTRANSPARENT_BRUSH] to not fill the interior.
  void drawRoundedRectangle(int x, int y, int width, int height, double radius) {
    final c = _ctx;
    if (c == null) return;
    double r = radius < 0 ? -radius * min(width, height) : radius;
    r = min(r, min(width, height) / 2);
    final hasPen = !_pen.isTransparent();
    final pw = hasPen ? (_pen.getWidth() <= 0 ? 1.0 : _pen.getWidth().toDouble()) : 0.0;
    final x0 = x + pw / 2, y0 = y + pw / 2;
    final w = width - pw, h = height - pw;
    c.beginPath();
    c.moveTo(x0 + r, y0);
    c.lineTo(x0 + w - r, y0);
    c.arc(x0 + w - r, y0 + r, r, -pi / 2, 0);
    c.lineTo(x0 + w, y0 + h - r);
    c.arc(x0 + w - r, y0 + h - r, r, 0, pi / 2);
    c.lineTo(x0 + r, y0 + h);
    c.arc(x0 + r, y0 + h - r, r, pi / 2, pi);
    c.lineTo(x0, y0 + r);
    c.arc(x0 + r, y0 + r, r, pi, pi * 1.5);
    c.closePath();
    if (_applyBrush(c)) c.fill();
    if (_applyPen(c)) c.stroke();
  }

  /// Same as [drawRoundedRectangle] using a [WxRect]
  void drawRoundedRectangleRect(WxRect rect, double radius) {
    drawRoundedRectangle(rect.x, rect.y, rect.width, rect.height, radius);
  }

  /// Draws an ellipse with the given dimensions using the
  /// current [WxPen] and filled out using the current [WxBrush]
  ///
  /// Use [wxTRANSPARENT_PEN] to not draw the outline or
  /// [wxTRANSPARENT_BRUSH] to not fill the interior.
  void drawEllipse(int x, int y, int width, int height) {
    final c = _ctx;
    if (c == null) return;
    c.beginPath();
    c.ellipse(x + width / 2, y + height / 2, width / 2, height / 2, 0, 0, 2 * pi);
    if (_applyBrush(c)) c.fill();
    if (_applyPen(c)) c.stroke();
  }

  /// Draws an ellipse specified by [rect]
  ///
  /// See [drawEllipse]
  void drawEllipseRect(WxRect rect) {
    drawEllipse(rect.x, rect.y, rect.width, rect.height);
  }

  /// Draws circle with given [radius] around [x],[y] using the
  /// current [WxPen] and filled out using the current [WxBrush].
  ///
  /// Use [wxTRANSPARENT_PEN] to not draw the outline or
  /// [wxTRANSPARENT_BRUSH] to not fill the interior.
  void drawCircle(int x, int y, int radius) {
    final c = _ctx;
    if (c == null) return;
    c.beginPath();
    c.arc(x.toDouble(), y.toDouble(), radius.toDouble(), 0, 2 * pi);
    if (_applyBrush(c)) c.fill();
    if (_applyPen(c)) c.stroke();
  }

  /// Same as [drawCircle] using [pt] as the center.
  void drawCirclePt(WxPoint pt, int radius) {
    drawCircle(pt.x, pt.y, radius);
  }

  /// Draws an elliptic arc centered around [x],[y] with [width] and [height] and
  /// with [start] and [end] angles in degrees using the
  /// current [WxPen] and filled out using the current [WxBrush].
  ///
  /// Use [wxTRANSPARENT_PEN] to not draw the outline or
  /// [wxTRANSPARENT_BRUSH] to not fill the interior.
  void drawEllipticArc(int x, int y, int width, int height, double start, double end) {
    final c = _ctx;
    if (c == null) return;
    final cx = x + width / 2, cy = y + height / 2;
    final a0 = -start * _kDegToRad, a1 = -end * _kDegToRad;
    if (_applyBrush(c)) {
      c.beginPath();
      c.moveTo(cx, cy);
      c.ellipseDir(cx, cy, width / 2, height / 2, 0, a0, a1, true);
      c.closePath();
      c.fill();
    }
    if (_applyPen(c)) {
      c.beginPath();
      c.ellipseDir(cx, cy, width / 2, height / 2, 0, a0, a1, true);
      c.stroke();
    }
  }

  /// Draws an arc from [x1],[y1] to [x2],[y2] where [cx],[cy] is the center.
  ///
  /// Crazy. Use [drawEllipticArc] instead.
  void drawArc(int x1, int y1, int x2, int y2, int cx, int cy) {
    final c = _ctx;
    if (c == null) return;
    final dx = (x1 - cx).toDouble(), dy = (y1 - cy).toDouble();
    final r = sqrt(dx * dx + dy * dy);
    final a0 = atan2(dy, dx);
    final a1 = atan2((y2 - cy).toDouble(), (x2 - cx).toDouble());
    c.beginPath();
    c.moveTo(cx.toDouble(), cy.toDouble());
    if (x1 == x2 && y1 == y2) {
      c.arc(cx.toDouble(), cy.toDouble(), r, 0, 2 * pi);
    } else {
      c.arcDir(cx.toDouble(), cy.toDouble(), r, a0, a1, true);
    }
    c.closePath();
    if (_applyBrush(c)) c.fill();
    if (_applyPen(c)) c.stroke();
  }

  /// Same as [drawArc]
  void drawArcPts(WxPoint p1, WxPoint p2, WxPoint center) {
    drawArc(p1.x, p1.y, p2.x, p2.y, center.x, center.y);
  }

  void drawPoint(int x, int y) {
    final c = _ctx;
    if (c == null || _pen.isTransparent()) return;
    _setFill(c, _pen.getColour());
    c.fillRect(x.toDouble(), y.toDouble(), 1, 1);
  }

  void drawPointPt(WxPoint pt) {
    drawPoint(pt.x, pt.y);
  }

  /// Draws [text] with its top left corner at (x,y). "\n" starts a new line.
  void drawText(String text, int x, int y) {
    final c = _ctx;
    if (c == null) return;
    _applyFont(c);
    final css = getFont()._css();
    final lines = text.split("\n");
    double ty = y.toDouble();
    for (final line in lines) {
      final m = _jsMeasureText(css, line);
      final lineHeight = m.ascent + m.descent;
      if (_backgroundMode == wxBRUSHSTYLE_SOLID) {
        _setFill(c, _textBackground);
        c.fillRect(x.toDouble(), ty, m.w, lineHeight);
      }
      _setFill(c, _textForeground);
      c.fillText(line, x.toDouble(), ty + m.ascent);
      ty += lineHeight;
    }
  }

  /// Draws [text] at [x],[y] rotated by [angle] degrees counter-clockwise
  /// around [x],[y] (the top left corner of the text) using the current
  /// [WxFont] and text foreground colour, as in wxWidgets.
  ///
  /// Draws a solid background with the current text background colour
  /// if background mode is [wxBRUSHSTYLE_SOLID]
  void drawRotatedText(String text, int x, int y, double angle) {
    final c = _ctx;
    if (c == null) return;
    c.save();
    c.translate(x.toDouble(), y.toDouble());
    c.rotate(-angle * _kDegToRad);
    _lastFill = null;
    _lastFont = null;
    drawText(text, 0, 0);
    c.restore();
    _lastFill = _lastStroke = _lastFont = null;
    _lastLineWidth = -1;
    _lastDashStyle = _lastCap = _lastJoin = -100;
  }

  /// Draws a [WxBitmap] at [x],[y].
  ///
  /// Position and image will be scaled according to [WxReadOnlyDC.setUserScale].
  void drawBitmap(WxBitmap bitmap, int x, int y, {bool useMask = false}) {
    final c = _ctx;
    if (c == null) return;
    final image = bitmap._image();
    if (image == null) {
      if (!bitmap.hasFailed() && _window != null) bitmap._addListener(_window!);
      return;
    }
    if (bitmap.getScaleFactor() == 1.0) {
      c.drawImage(image, x.toDouble(), y.toDouble());
    } else {
      c.drawImageScaled(image, x.toDouble(), y.toDouble(), bitmap.getLogicalWidth(), bitmap.getLogicalHeight());
    }
  }

  /// Draws a bitmap scaled to the given size
  void drawBitmapScaled(WxBitmap bitmap, int x, int y, int width, int height) {
    final c = _ctx;
    if (c == null) return;
    final image = bitmap._image();
    if (image == null) {
      if (!bitmap.hasFailed() && _window != null) bitmap._addListener(_window!);
      return;
    }
    c.drawImageScaled(image, x.toDouble(), y.toDouble(), width.toDouble(), height.toDouble());
  }

  /// Draws a rectangle with a linear colour gradient
  void gradientFillLinear(WxRect rect, WxColour initialColour, WxColour destColour,
      {int nDirection = wxRIGHT}) {
    final c = _ctx;
    if (c == null) return;
    final x1 = rect.x.toDouble(), y1 = rect.y.toDouble();
    final x2 = (rect.x + rect.width).toDouble(), y2 = (rect.y + rect.height).toDouble();
    _CanvasGradient g;
    switch (nDirection) {
      case wxLEFT:
        g = c.createLinearGradient(x2, y1, x1, y1);
        break;
      case wxUP:
        g = c.createLinearGradient(x1, y2, x1, y1);
        break;
      case wxDOWN:
        g = c.createLinearGradient(x1, y1, x1, y2);
        break;
      default:
        g = c.createLinearGradient(x1, y1, x2, y1);
    }
    g.addColorStop(0, _cssColour(initialColour));
    g.addColorStop(1, _cssColour(destColour));
    c.fillStyleGradient = g;
    _lastFill = null;
    c.fillRect(x1, y1, rect.width.toDouble(), rect.height.toDouble());
  }

  /// Draws a rectangle with a concentric colour gradient starting from the center of the rectangle
  void gradientFillConcentric(WxRect rect, WxColour initialColour, WxColour destColour) {
    gradientFillConcentricWithCenter(rect, initialColour, destColour,
        WxPoint(rect.x + (rect.width ~/ 2), rect.y + (rect.height ~/ 2)));
  }

  /// Draws a rectangle with a concentric colour gradient starting from the [center]
  void gradientFillConcentricWithCenter(WxRect rect, WxColour initialColour, WxColour destColour, WxPoint center) {
    final c = _ctx;
    if (c == null) return;
    final cx = center.x.toDouble(), cy = center.y.toDouble();
    final g = c.createRadialGradient(cx, cy, 0, cx, cy, max(rect.width, rect.height) / 2);
    g.addColorStop(0, _cssColour(initialColour));
    g.addColorStop(1, _cssColour(destColour));
    c.fillStyleGradient = g;
    _lastFill = null;
    c.fillRect(rect.x.toDouble(), rect.y.toDouble(), rect.width.toDouble(), rect.height.toDouble());
  }
}

// ------------------------- wxPaintDC ----------------------

/// Device context for drawing in a paint event handler:
///
/// ```dart
/// class MyWindow extends WxWindow {
///   MyWindow(WxWindow parent) : super(parent, -1, wxDefaultPosition, wxDefaultSize, 0) {
///     bindPaintEvent(onPaint);
///   }
///
///   void onPaint(WxPaintEvent event) {
///     final dc = WxPaintDC(this);
///     dc.setPen(WxPen(wxBLUE, width: 2));
///     dc.drawLine(10, 10, 100, 100);
///   }
/// }
/// ```
///
/// The canvas has already been cleared (the window's background colour
/// shows through) and is scaled for high DPI screens.
class WxPaintDC extends WxDC {
  WxPaintDC(WxWindow window) {
    final ctx = window._paintCtx;
    if (ctx == null) {
      wxLogError("WxPaintDC can only be created in a paint event handler.");
    }
    _init(ctx, window);
    _textForeground = window.getForegroundColour();
    _textBackground = window.getBackgroundColour();
    _font = window._font;
  }
}
