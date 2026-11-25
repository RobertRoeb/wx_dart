// -------------------------------------------------------------
// Purpose:     PDF output for wxDart - WxPDFGraphicsPath
// Author:      Robert Roebling
// Created:     25/11/2026
// Copyright:   (c) Robert Roebling
// Licence:     wxWindows licence 3.1
// -------------------------------------------------------------

part of '../../wx_dart.dart';

/// Pure Dart path. Records PDF path construction operators in user
/// coordinates (wx convention: y axis pointing down). They are interpreted
/// with the transformation that is current when the path is drawn - the
/// same semantics as wxGraphicsPath.
///
/// Never touches nativeHandle. All private members carry a _pdf prefix
/// to avoid accidentally overriding private members of WxObject & co,
/// since this file is part of the same library.
class WxPDFGraphicsPath extends WxGraphicsPath {
  WxPDFGraphicsPath() : super._defaultConstructor() {
    ownsHandle = false;
  }

  final StringBuffer _pdfOps = StringBuffer();
  bool _pdfHasCurrentPoint = false;
  double _pdfCurrentX = 0, _pdfCurrentY = 0;
  double _pdfSubpathX = 0, _pdfSubpathY = 0;

  bool get isEmpty => _pdfOps.isEmpty;

  /// The recorded path construction operators.
  String get pdfOperators => _pdfOps.toString();

  bool get hasCurrentPoint => _pdfHasCurrentPoint;
  WxRealPoint get currentPoint => WxRealPoint(_pdfCurrentX, _pdfCurrentY);

  void _pdfSetCurrent(double x, double y) {
    _pdfHasCurrentPoint = true;
    _pdfCurrentX = x;
    _pdfCurrentY = y;
  }

  @override
  void moveTo(double x, double y) {
    _pdfOps.write('${_pdfNum(x)} ${_pdfNum(y)} m\n');
    _pdfSetCurrent(x, y);
    _pdfSubpathX = x;
    _pdfSubpathY = y;
  }

  @override
  void closeSubpath() {
    if (!_pdfHasCurrentPoint) return;
    _pdfOps.write('h\n');
    _pdfSetCurrent(_pdfSubpathX, _pdfSubpathY);
  }

  @override
  void addLineTo(double x, double y) {
    if (!_pdfHasCurrentPoint) {
      moveTo(x, y);
      return;
    }
    _pdfOps.write('${_pdfNum(x)} ${_pdfNum(y)} l\n');
    _pdfSetCurrent(x, y);
  }

  /// Cubic Bézier, as wxGraphicsPath::AddCurveToPoint.
  /// TODO: add this (and addQuadCurveToPoint) to the native WxGraphicsPath binding too.
  void addCurveToPoint(double cx1, double cy1, double cx2, double cy2, double x, double y) {
    if (!_pdfHasCurrentPoint) moveTo(cx1, cy1);
    _pdfOps.write('${_pdfNum(cx1)} ${_pdfNum(cy1)} ${_pdfNum(cx2)} ${_pdfNum(cy2)} ${_pdfNum(x)} ${_pdfNum(y)} c\n');
    _pdfSetCurrent(x, y);
  }

  /// Quadratic Bézier, as wxGraphicsPath::AddQuadCurveToPoint.
  void addQuadCurveToPoint(double cx, double cy, double x, double y) {
    if (!_pdfHasCurrentPoint) moveTo(cx, cy);
    final x0 = _pdfCurrentX, y0 = _pdfCurrentY;
    addCurveToPoint(
      x0 + 2.0 / 3.0 * (cx - x0), y0 + 2.0 / 3.0 * (cy - y0),
      x + 2.0 / 3.0 * (cx - x), y + 2.0 / 3.0 * (cy - y),
      x, y);
  }

  @override
  void addPath(WxGraphicsPath path) {
    if (path is! WxPDFGraphicsPath) {
      wxLogError('WxPDFGraphicsPath.addPath: path was not created by a WxPDFGraphicsContext');
      return;
    }
    if (path.isEmpty) return;
    _pdfOps.write(path._pdfOps.toString());
    if (path._pdfHasCurrentPoint) {
      _pdfSetCurrent(path._pdfCurrentX, path._pdfCurrentY);
      _pdfSubpathX = path._pdfSubpathX;
      _pdfSubpathY = path._pdfSubpathY;
    }
  }

  @override
  void addRectangle(double x, double y, double width, double height) {
    _pdfOps.write('${_pdfNum(x)} ${_pdfNum(y)} ${_pdfNum(width)} ${_pdfNum(height)} re\n');
    _pdfSetCurrent(x, y);
    _pdfSubpathX = x;
    _pdfSubpathY = y;
  }

  @override
  void addRoundedRectangle(double x, double y, double width, double height, double radius) {
    final r = min(radius, min(width.abs(), height.abs()) / 2);
    if (r <= 0) {
      addRectangle(x, y, width, height);
      return;
    }
    moveTo(x + r, y);
    addArc(x + width - r, y + r, r, -pi / 2, 0, true);
    addArc(x + width - r, y + height - r, r, 0, pi / 2, true);
    addArc(x + r, y + height - r, r, pi / 2, pi, true);
    addArc(x + r, y + r, r, pi, 3 * pi / 2, true);
    closeSubpath();
  }

  @override
  void addCircle(double x, double y, double radius) {
    addEllipse(x - radius, y - radius, 2 * radius, 2 * radius);
  }

  @override
  void addEllipse(double x, double y, double width, double height) {
    const kappa = 0.5522847498307936; // 4/3 * (sqrt(2) - 1)
    final rx = width / 2, ry = height / 2;
    final cx = x + rx, cy = y + ry;
    final kx = kappa * rx, ky = kappa * ry;
    moveTo(cx + rx, cy);
    addCurveToPoint(cx + rx, cy + ky, cx + kx, cy + ry, cx, cy + ry);
    addCurveToPoint(cx - kx, cy + ry, cx - rx, cy + ky, cx - rx, cy);
    addCurveToPoint(cx - rx, cy - ky, cx - kx, cy - ry, cx, cy - ry);
    addCurveToPoint(cx + kx, cy - ry, cx + rx, cy - ky, cx + rx, cy);
    closeSubpath();
  }

  /// Angles in radians. As in wx (y axis down), "clockwise" means increasing angles.
  /// Like wx, a line is added from the current point to the start of the arc.
  @override
  void addArc(double x, double y, double radius, double startAngle, double endAngle, bool clockwise) {
    var sweep = endAngle - startAngle;
    if (clockwise) {
      while (sweep < 0) {
        sweep += 2 * pi;
      }
    } else {
      while (sweep > 0) {
        sweep -= 2 * pi;
      }
    }
    if (sweep.abs() > 2 * pi) sweep = sweep.sign * 2 * pi;

    final sx = x + radius * cos(startAngle);
    final sy = y + radius * sin(startAngle);
    if (_pdfHasCurrentPoint) {
      addLineTo(sx, sy);
    } else {
      moveTo(sx, sy);
    }
    if (sweep == 0) return;

    // one Bézier segment per (at most) quarter circle
    final segments = max(1, (sweep.abs() / (pi / 2) - 1e-9).ceil());
    final step = sweep / segments;
    final k = 4.0 / 3.0 * tan(step / 4);
    var a = startAngle;
    for (int i = 0; i < segments; i++) {
      final a2 = a + step;
      final cosA = cos(a), sinA = sin(a), cosA2 = cos(a2), sinA2 = sin(a2);
      addCurveToPoint(
        x + radius * (cosA - k * sinA), y + radius * (sinA + k * cosA),
        x + radius * (cosA2 + k * sinA2), y + radius * (sinA2 - k * cosA2),
        x + radius * cosA2, y + radius * sinA2);
      a = a2;
    }
  }
}
