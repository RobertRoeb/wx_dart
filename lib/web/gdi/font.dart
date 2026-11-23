// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-11-15
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- standard fonts ----------------------

final wxNORMAL_FONT = WxFont(13);

/// Factor for the size of all fonts on screen, larger than 1 on devices
/// operated with fingers (see [WxApp.isTouch]); fixed at start-up
final double _wxFontScale = _jsFontScale();
final wxSMALL_FONT = WxFont(12);
final wxITALIC_FONT = WxFont(13, style: wxFONTSTYLE_ITALIC);

// ------------------------- wxFont ----------------------

/// A font. As in wxDart Flutter, the point size is used as the font
/// size in logical (CSS) pixels so that both variants look alike.
class WxFont extends WxObject {
  /// Creates a font with a given size in points.
  ///
  /// This constructor will look for the best matching standard font.
  WxFont(double pointSize,
      {int family = wxFONTFAMILY_DEFAULT,
      int style = wxFONTSTYLE_NORMAL,
      int weight = wxFONTWEIGHT_NORMAL,
      bool underline = false}) {
    _pointSize = pointSize;
    _family = family;
    _style = style;
    _weight = weight;
    _underline = underline;
  }

  /// Creates a font with a given size in pixels, not points
  WxFont.fromPixelSize(WxSize pixelSize,
      {int family = wxFONTFAMILY_DEFAULT,
      int style = wxFONTSTYLE_NORMAL,
      int weight = wxFONTWEIGHT_NORMAL,
      bool underline = false}) {
    _pointSize = pixelSize.y.toDouble();
    _family = family;
    _style = style;
    _weight = weight;
    _underline = underline;
  }

  late double _pointSize;
  late int _family;
  late int _style;
  late int _weight;
  late bool _underline;
  bool _strikethrough = false;
  String? _cssCache;

  /// Returns true if the font is defined
  bool isOk() {
    return true;
  }

  /// Returns size in points
  double getPointSize() {
    return _pointSize;
  }

  void setPointSize(double size) {
    _pointSize = size;
    _cssCache = null;
  }

  /// Returns font family
  int getFamily() {
    return _family;
  }

  /// Returns font style
  int getStyle() {
    return _style;
  }

  /// Returns font weight
  int getWeight() {
    return _weight;
  }

  /// Returns true if font is underlined
  bool getUnderlined() {
    return _underline;
  }

  /// Returns true if font is underlined
  bool getStrikethrough() {
    return _strikethrough;
  }

  /// Make font a little larger
  void makeLarger() {
    _pointSize *= 1.2;
    _cssCache = null;
  }

  /// Make font a little smaller
  void makeSmaller() {
    _pointSize /= 1.2;
    _cssCache = null;
  }

  /// Returns a bold version of the current font
  WxFont bold() {
    final font = WxFont(_pointSize, family: _family, style: _style, weight: wxFONTWEIGHT_BOLD);
    font._underline = _underline;
    font._strikethrough = _strikethrough;
    return font;
  }

  /// Returns an italic version of the current font
  WxFont italic() {
    final font = WxFont(_pointSize, family: _family, style: wxFONTSTYLE_ITALIC, weight: _weight);
    font._underline = _underline;
    font._strikethrough = _strikethrough;
    return font;
  }

  /// Returns a scaled version of the current font
  WxFont scaled(double scale) {
    final font = WxFont(_pointSize * scale, family: _family, style: _style, weight: _weight);
    font._underline = _underline;
    font._strikethrough = _strikethrough;
    return font;
  }

  /// CSS font shorthand, used for DOM elements and the canvas
  String _css() {
    final cached = _cssCache;
    if (cached != null) return cached;
    String families;
    switch (_family) {
      case wxFONTFAMILY_ROMAN:
      case wxFONTFAMILY_SCRIPT:
        families = '"Times New Roman", Times, "Liberation Serif", serif';
        break;
      case wxFONTFAMILY_TELETYPE:
        families = '"SF Mono", Consolas, "Ubuntu Mono", "Courier New", monospace';
        break;
      case wxFONTFAMILY_SWISS:
      case wxFONTFAMILY_MODERN:
        families = 'Arial, Helvetica, "Liberation Sans", sans-serif';
        break;
      default:
        families = 'system-ui, -apple-system, "Segoe UI", Roboto, Ubuntu, sans-serif';
    }
    final italic = (_style == wxFONTSTYLE_ITALIC || _style == wxFONTSTYLE_SLANT) ? "italic " : "";
    final weight = (_weight <= 0) ? 400 : min(_weight, 900);
    // on devices operated with fingers, all fonts are a bit larger
    final size = (_pointSize * _wxFontScale).toStringAsFixed(1);
    final css = "$italic$weight ${size}px $families";
    _cssCache = css;
    return css;
  }
}
