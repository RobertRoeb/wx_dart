// -------------------------------------------------------------
// Purpose:     PDF output for wxDart - text with the standard 14 fonts
// Author:      Robert Roebling
// Created:     25/11/2026
// Copyright:   (c) Robert Roebling
// Licence:     wxWindows licence 3.1
// -------------------------------------------------------------
//
// First stage: only the 12 text fonts every PDF viewer has built in
// (Helvetica, Times, Courier with bold/italic). Nothing is embedded,
// text is encoded in WinAnsiEncoding (Windows-1252, i.e. Western European).
// Characters outside of it are written as '?'.
//
// All metrics come from Dart tables (pdf_std_fonts.dart), so text
// measurement gives bit-identical results on every platform.

part of '../../wx_dart.dart';

/// Unicode -> WinAnsi code for the range 0x80..0x9F
const Map<int, int> _wxPDFWinAnsiExtra = {
  0x20AC: 0x80, 0x201A: 0x82, 0x0192: 0x83, 0x201E: 0x84, 0x2026: 0x85,
  0x2020: 0x86, 0x2021: 0x87, 0x02C6: 0x88, 0x2030: 0x89, 0x0160: 0x8A,
  0x2039: 0x8B, 0x0152: 0x8C, 0x017D: 0x8E, 0x2018: 0x91, 0x2019: 0x92,
  0x201C: 0x93, 0x201D: 0x94, 0x2022: 0x95, 0x2013: 0x96, 0x2014: 0x97,
  0x02DC: 0x98, 0x2122: 0x99, 0x0161: 0x9A, 0x203A: 0x9B, 0x0153: 0x9C,
  0x017E: 0x9E, 0x0178: 0x9F,
};

int _wxPDFWinAnsiCode(int codePoint) {
  if (codePoint >= 0x20 && codePoint < 0x7F) return codePoint;
  if (codePoint >= 0xA0 && codePoint <= 0xFF) return codePoint;
  return _wxPDFWinAnsiExtra[codePoint] ?? 0x3F; // '?'
}

/// Picks one of the standard fonts for a WxFont. Family TELETYPE/MODERN
/// -> Courier, ROMAN -> Times, everything else -> Helvetica.
String _wxPDFStdFontNameFor(WxFont font) {
  final family = font.getFamily();
  final bold = font.getWeight() >= wxFONTWEIGHT_SEMIBOLD;
  final italic = font.getStyle() != wxFONTSTYLE_NORMAL;
  return _wxPDFStdFontName(family, bold, italic);
}

String _wxPDFStdFontName(int family, bool bold, bool italic) {
  if (family == wxFONTFAMILY_ROMAN) {
    if (bold && italic) return 'Times-BoldItalic';
    if (bold) return 'Times-Bold';
    if (italic) return 'Times-Italic';
    return 'Times-Roman';
  }
  final base = (family == wxFONTFAMILY_TELETYPE || family == wxFONTFAMILY_MODERN)
      ? 'Courier'
      : 'Helvetica';
  if (bold && italic) return '$base-BoldOblique';
  if (bold) return '$base-Bold';
  if (italic) return '$base-Oblique';
  return base;
}

/// A font as used by the PDF context: one of the standard fonts plus a size
/// in user units (points unless you scale the context).
class WxPDFFont {
  WxPDFFont(this.name, this.size) : _metrics = _wxPDFStdFonts[name] ?? _wxPDFHelvetica;

  factory WxPDFFont.fromWxFont(WxFont font) =>
      WxPDFFont(_wxPDFStdFontNameFor(font), font.getPointSize().toDouble());

  factory WxPDFFont.std({int family = wxFONTFAMILY_SWISS, double size = 10, bool bold = false, bool italic = false}) =>
      WxPDFFont(_wxPDFStdFontName(family, bold, italic), size);

  /// PDF base font name, e.g. "Helvetica-Bold"
  final String name;
  final double size;
  final _WxPDFStdFontMetrics _metrics;

  double get ascent => _metrics.ascender * size / 1000.0;
  /// positive value
  double get descent => -_metrics.descender * size / 1000.0;
  double get lineHeight => ascent + descent;

  /// Width of a single line (no line breaks) in user units.
  double lineWidth(String text) {
    int units = 0;
    for (final cp in text.runes) {
      final code = _wxPDFWinAnsiCode(cp);
      units += _metrics.widths[code - 32];
    }
    return units * size / 1000.0;
  }

  /// Text is encoded into a PDF literal string, e.g. "(Hello \(world\))".
  String encodeLiteral(String text) {
    final sb = StringBuffer('(');
    for (final cp in text.runes) {
      final code = _wxPDFWinAnsiCode(cp);
      if (code == 0x28 || code == 0x29 || code == 0x5C) {
        sb.write('\\');
        sb.writeCharCode(code);
      } else if (code < 0x20 || code > 0x7E) {
        sb.write('\\${code.toRadixString(8).padLeft(3, '0')}');
      } else {
        sb.writeCharCode(code);
      }
    }
    sb.write(')');
    return sb.toString();
  }
}
