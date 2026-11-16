// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../wx_dart.dart';

// ------------------------- wxColour ----------------------

final wxBLACK = WxColour( 0, 0, 0 );
final wxWHITE = WxColour( 255, 255, 255 );
final wxRED = WxColour( 255, 0, 0 );
final wxCYAN = WxColour( 0, 255, 255 );
final wxGREEN = WxColour( 0, 255, 0 );
final wxBLUE = WxColour( 0, 0, 255 );
final wxYELLOW = WxColour( 255, 255, 0 );
final wxGREY = WxColour( 80, 80, 80 );
final wxMEDIUM_GREY = WxColour( 130, 130, 130 );
final wxLIGHT_GREY = WxColour( 192, 192, 192 );


/// Flags for [WxColour.getAsString]: the name of the colour, if it has one
const int wxC2S_NAME = 1;
/// Flags for [WxColour.getAsString]: "rgb(r, g, b)" or "rgba(r, g, b, a)"
const int wxC2S_CSS_SYNTAX = 2;
/// Flags for [WxColour.getAsString]: "#RRGGBB"
const int wxC2S_HTML_SYNTAX = 4;

/// Represents a colour in RGB space with an optional alpha channel.
/// 
/// This class is implemented in pure Dart on all platforms.
/// 
/// Main interface:
/// * [WxColour.new]
/// * [WxColour.fromRGB]
/// * [WxColour.fromRGBA]
/// * [WxColour.fromString]
/// * [getRed]
/// * [getGreen]
/// * [getBlue]
/// * [getAlpha]
/// * [getLuminance]
/// * [getRelativeLuminance]
/// * [getContrastRatio]
/// * [getContrastingColour]
/// * [getAsString]
/// * [changeLightness]
/// 
/// A small number of colours are predefined global objects:
/// # Global objects 
/// | Colour | value |
/// | -------- | -------- |
///  |  wxBLACK  |  WxColour( 0, 0, 0 ) | 
///  |  wxWHITE  |  WxColour( 255, 255, 255 ) | 
///  |  wxRED  |  WxColour( 255, 0, 0 ) | 
///  |  wxCYAN  |  WxColour( 0, 255, 255 ) | 
///  |  wxGREEN  |  WxColour( 0, 255, 0 ) | 
///  |  wxBLUE  |  WxColour( 0, 0, 255 ) | 
///  |  wxYELLOW  |  WxColour( 255, 255, 0 ) | 
///  |  wxGREY  |  WxColour( 80, 80, 80 ) | 
///  |  wxMEDIUM_GREY  |  WxColour( 130, 130, 130 ) | 
///  |  wxLIGHT_GREY  |  WxColour( 192, 192, 192 ) |
/// 
/// Additionally, [WxHtmlColours] defines all standard HTML colours:
/// ```dart
///   dc.setBrush( WxBrush( WxHtmlColours.skyBlue ) );
/// ```
/// 
/// Example:
///```dart
/// // Derive new class from WxWindow
/// class MyWindow extends WxWindow {
///   MyWindow( WxWindow parent, int id ) : super( parent, id, wxDefaultPosition, wxDefaultSize, 0 )
///   {
///     // Bind paint handler to the paint event
///     bindPaintEvent(onPaint);
///   }
/// 
///   // define a new paint event handler
///   void onPaint( WxPaintEvent event )
///   {
///     // create paint device context during paint event
///     final dc = WxPaintDC( this );
/// 
///     // draw lie with wxBLACK
///     dc.setPen( WxPen( wxBLACK, width: 2) ); 
///     dc.drawLine( 10, 10, 100, 100 );
/// 
///     // draw lie with newly defined colour using RGB and alpha channel
///     dc.setPen( WxPen( WxColour(123,123,123,alpha:100), width: 2) );
///     dc.drawLine( 10, 10, 100, 100 );
///   }
/// }
/// ```

class WxColour {
  /// Creates a colour from the RGB components and an optional [alpha] indicating transparency
  /// 
  /// All values are bytes ranging from 0 to 255
  WxColour( this.red, this.green, this.blue, { this.alpha = 255 } );
  /// Creates a colour from an int containing the RGB values and an optional [alpha] indicating transparency
  /// 
  /// All values are bytes ranging from 0 to 255
  WxColour.fromRGB( int rgb, { this.alpha = 255 } ) {
    red =   (0xFF & rgb);
    green = (0xFF & (rgb >> 8));
    blue =  (0xFF & (rgb >> 16));
  }
  /// Creates a colour from an int containing the RGB and the alpha transparency
  /// 
  /// All values are bytes ranging from 0 to 255
  WxColour.fromRGBA( int rgba ) {
    red =    (0xFF & rgba);
    green =  (0xFF & (rgba >> 8));
    blue =   (0xFF & (rgba >> 16));
    alpha =  (0xFF & (rgba >> 24));
  }
  /// Creates a colour from a string, as wxColour(const wxString&) in wxWidgets.
  ///
  /// Accepted are (case and spaces don't matter):
  /// * one of the names in [WxHtmlColours] ("skyblue", "Sky Blue", "SKY BLUE")
  ///   and "transparent"
  /// * "#RGB", "#RGBA", "#RRGGBB" and "#RRGGBBAA"
  /// * "rgb(135, 206, 235)", "rgba(135, 206, 235, 0.5)", also with
  ///   percentages and in the newer form "rgb(135 206 235 / 50%)"
  ///
  /// Throws a [FormatException] for anything else. See [tryParse].
  factory WxColour.fromString( String text ) {
    final colour = tryParse( text );
    if (colour == null) {
      throw FormatException( "WxColour.fromString: not a colour", text );
    }
    return colour;
  }

  /// Like [WxColour.fromString], but returns null for invalid strings
  static WxColour? tryParse( String text ) {
    final s = text.trim().toLowerCase();
    if (s.isEmpty) return null;
    if (s.startsWith('#')) return _parseHex( s.substring(1) );
    final match = RegExp(r'^rgba?\((.*)\)$').firstMatch( s );
    if (match != null) return _parseRgb( match.group(1)! );
    if (s == 'transparent') return WxColour( 0, 0, 0, alpha: 0 );
    final rgb = _wxHtmlColourTable[ s.replaceAll(' ', '') ];
    return rgb == null ? null : _wxHexColour( rgb );
  }

  static WxColour? _parseHex( String hex ) {
    if (!RegExp(r'^[0-9a-f]+$').hasMatch( hex )) return null;
    if (hex.length == 3 || hex.length == 4) {
      // #RGB(A): each digit is doubled
      hex = hex.split('').map((digit) => digit + digit).join();
    }
    if (hex.length != 6 && hex.length != 8) return null;
    int component(int index) => int.parse( hex.substring(index * 2, index * 2 + 2), radix: 16 );
    return WxColour( component(0), component(1), component(2), alpha: hex.length == 8 ? component(3) : 255 );
  }

  static WxColour? _parseRgb( String arguments ) {
    List<String> parts;
    String? alphaPart;
    if (arguments.contains(',')) {
      parts = arguments.split(',').map((part) => part.trim()).toList();
      if (parts.length == 4) alphaPart = parts.removeLast();
    } else {
      final slash = arguments.split('/');
      if (slash.length > 2) return null;
      parts = slash[0].trim().split(RegExp(r'\s+'));
      if (slash.length == 2) alphaPart = slash[1].trim();
    }
    if (parts.length != 3) return null;
    final rgb = <int>[];
    for (final part in parts) {
      final value = _parseNumber( part, 255 );
      if (value == null) return null;
      rgb.add( value );
    }
    int alpha = 255;
    if (alphaPart != null) {
      // alpha is 0..1 or a percentage
      final value = _parseNumber( alphaPart, 1 );
      if (value == null) return null;
      alpha = value;
    }
    return WxColour( rgb[0], rgb[1], rgb[2], alpha: alpha );
  }

  /// Parses "128" or "50%" (of 255). With [scale] 1, "0.5" becomes 128.
  static int? _parseNumber( String text, int scale ) {
    double? value;
    if (text.endsWith('%')) {
      final percent = double.tryParse( text.substring(0, text.length - 1) );
      if (percent == null) return null;
      value = percent * 255 / 100;
    } else {
      value = double.tryParse( text );
      if (value == null) return null;
      if (scale == 1) value *= 255;
    }
    if (value.isNaN) return null;
    return value.round().clamp(0, 255);
  }

  int red = 0;
  int green = 0;
  int blue = 0;
  int alpha = 0;

  /// Returns the transparency (or alpha) compoment. 255 indicated fully opaque. 0 indicates fully transparent.
  int getAlpha() {
    return alpha;
  }
  /// Returns the red compoment from 0 to 255
  int getRed() {
    return red;
  }
  /// Returns the blue compoment from 0 to 255
  int getBlue() {
    return blue;
  }
  /// Returns the green compoment from 0 to 255
  int getGreen() {
    return green;
  }
  /// Returns the luminance (perceived brightness) between 0 and 1.
  double getLuminance() {
    return 0.299*red/255 + 0.587*green/255 + 0.114*blue/255;
  } 
  /// Returns the relative luminance between 0 (black) and 1 (white) as
  /// defined by WCAG, with the sRGB gamma removed. Unlike [getLuminance],
  /// it is suitable for computing contrast ratios (see [getContrastRatio]).
  double getRelativeLuminance() {
    double channel(int value) {
      final s = value / 255.0;
      return s <= 0.04045 ? s / 12.92 : pow((s + 0.055) / 1.055, 2.4).toDouble();
    }
    return 0.2126 * channel(red) + 0.7152 * channel(green) + 0.0722 * channel(blue);
  }

  /// Returns the contrast ratio between this colour and [other] as defined
  /// by WCAG, from 1 (no contrast) to 21 (black on white). 4.5 is the
  /// minimum recommended for normal text.
  double getContrastRatio( WxColour other ) {
    final l1 = getRelativeLuminance();
    final l2 = other.getRelativeLuminance();
    return (max(l1, l2) + 0.05) / (min(l1, l2) + 0.05);
  }

  /// Returns black or white, whichever is easier to read on this colour,
  /// e.g. for text on a background in the accent colour. Alpha is ignored.
  ///
  /// White is chosen for colours with a relative luminance below 0.18:
  /// from there on, white text has a contrast of at least 4.5. For
  /// brighter colours, black has the higher contrast.
  ///
  /// Always returns a new instance.
  WxColour getContrastingColour() {
    return getRelativeLuminance() < 0.18 ? WxColour( 255, 255, 255 ) : WxColour( 0, 0, 0 );
  }

  /// Returns the RGB compoments as a single int
  int getRGB() {
    return red | (green << 8) | (blue << 16);
  }
  /// Returns the RGBA compoments as a single int
  int getRGBA() {
    return red | (green << 8) | (blue << 16) | (alpha << 24) ;
  }
  /// Returns true if [other] is a [WxColour] with the same red, green,
  /// blue and alpha components (as wxColour::operator== in wxWidgets)
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WxColour &&
        other.red == red &&
        other.green == green &&
        other.blue == blue &&
        other.alpha == alpha;
  }

  /// Consistent with [operator ==]. Don't change the components of a colour
  /// while it is used as a key in a [Map] or [Set].
  @override
  int get hashCode => Object.hash(red, green, blue, alpha);

  /// Returns the colour as a string that [WxColour.fromString] can read,
  /// as wxColour::GetAsString() in wxWidgets.
  ///
  /// [flags] is a combination of the following. The first that applies
  /// is used:
  /// | constant | result |
  /// | -------- | -------- |
  /// | wxC2S_NAME | the CSS name in lower case, e.g. "skyblue" (opaque colours from [WxHtmlColours] only) |
  /// | wxC2S_CSS_SYNTAX | "rgb(135, 206, 235)" or with alpha "rgba(135, 206, 235, 0.502)" |
  /// | wxC2S_HTML_SYNTAX | "#87CEEB" (opaque colours only) |
  ///
  /// For colours with two names, the first in alphabetical order is
  /// returned ("aqua", not "cyan"; "darkgray", not "darkgrey"). If none of
  /// the flags applies, e.g. wxC2S_HTML_SYNTAX for a transparent colour,
  /// the CSS syntax is used.
  String getAsString( { int flags = wxC2S_NAME | wxC2S_CSS_SYNTAX } ) {
    final rgb = (red << 16) | (green << 8) | blue;
    if ((flags & wxC2S_NAME) != 0 && alpha == 255) {
      for (final entry in _wxHtmlColourTable.entries) {
        if (entry.value == rgb) return entry.key;
      }
    }
    if ((flags & wxC2S_CSS_SYNTAX) == 0 && (flags & wxC2S_HTML_SYNTAX) != 0 && alpha == 255) {
      return "#${rgb.toRadixString(16).padLeft(6, '0').toUpperCase()}";
    }
    if (alpha == 255) {
      return "rgb($red, $green, $blue)";
    }
    // like wxWidgets: alpha as 0..1 with three decimals
    return "rgba($red, $green, $blue, ${(alpha / 255).toStringAsFixed(3)})";
  }

  /// Returns true if the colour is fully qualified
  /// 
  /// Always returns true in wxDart Flutter
  bool isOk() {
    return true;
  }
  /// Change the lightness of the colour, 100 indicating not change, 120 indicating 20% lighter and
  /// 80 indicated 20% less bright. [percent] can be between 0 and 200.
  /// 
  /// Always returns a new instance, even if percent is 100 indicating no change.
  WxColour changeLightness( int percent )
  {
    if (percent == 100) {
      // copy, don't return this
      return WxColour(red, green, blue, alpha: alpha );
    }
    percent = percent.clamp(0, 200);  // the wx function only accepts 0-200%
    double dalpha = (percent.toDouble() - 100.0)/100.0; // convert to -1 to +1
    int bg = 255;
    if (percent > 100) {
        dalpha = 1.0 - dalpha;
    } else {
        bg = 0;
        dalpha = 1.0 + dalpha;
    }
    double newRed = bg + (dalpha * (red - bg));
    newRed = newRed.clamp( 0.0, 255.0);
    double newGreen = bg + (dalpha * (green - bg));
    newGreen = newGreen.clamp( 0.0, 255.0);
    double newBlue = bg + (dalpha * (blue - bg));
    newBlue = newBlue.clamp( 0.0, 255.0);
    return WxColour( newRed.floor(), newGreen.floor(), newBlue.floor(), alpha: alpha );
  }
}

// ------------------------- HTML colours ----------------------

WxColour _wxHexColour( int rgb ) {
  return WxColour( (rgb >> 16) & 0xFF, (rgb >> 8) & 0xFF, rgb & 0xFF );
}

/// The 148 named colours of HTML and CSS (CSS Color Module Level 4),
/// including the spellings with "grey" and "gray".
///
/// Each getter returns a new [WxColour], so changing it has no effect
/// elsewhere.
///
/// Note that some CSS names mean other colours than the wxWidgets
/// constants: [green] is (0,128,0), whereas [wxGREEN] is (0,255,0)
/// which is [lime] in CSS.
///
/// See [WxColour.fromString] for creating a colour from a name given as a string.
///
/// ```dart
///   dc.setBrush( WxBrush( WxHtmlColours.skyBlue ) );
/// ```
abstract final class WxHtmlColours {
  static WxColour get aliceBlue => _wxHexColour(0xF0F8FF);
  static WxColour get antiqueWhite => _wxHexColour(0xFAEBD7);
  static WxColour get aqua => _wxHexColour(0x00FFFF);
  static WxColour get aquamarine => _wxHexColour(0x7FFFD4);
  static WxColour get azure => _wxHexColour(0xF0FFFF);
  static WxColour get beige => _wxHexColour(0xF5F5DC);
  static WxColour get bisque => _wxHexColour(0xFFE4C4);
  static WxColour get black => _wxHexColour(0x000000);
  static WxColour get blanchedAlmond => _wxHexColour(0xFFEBCD);
  static WxColour get blue => _wxHexColour(0x0000FF);
  static WxColour get blueViolet => _wxHexColour(0x8A2BE2);
  static WxColour get brown => _wxHexColour(0xA52A2A);
  static WxColour get burlyWood => _wxHexColour(0xDEB887);
  static WxColour get cadetBlue => _wxHexColour(0x5F9EA0);
  static WxColour get chartreuse => _wxHexColour(0x7FFF00);
  static WxColour get chocolate => _wxHexColour(0xD2691E);
  static WxColour get coral => _wxHexColour(0xFF7F50);
  static WxColour get cornflowerBlue => _wxHexColour(0x6495ED);
  static WxColour get cornsilk => _wxHexColour(0xFFF8DC);
  static WxColour get crimson => _wxHexColour(0xDC143C);
  static WxColour get cyan => _wxHexColour(0x00FFFF);
  static WxColour get darkBlue => _wxHexColour(0x00008B);
  static WxColour get darkCyan => _wxHexColour(0x008B8B);
  static WxColour get darkGoldenrod => _wxHexColour(0xB8860B);
  static WxColour get darkGray => _wxHexColour(0xA9A9A9);
  static WxColour get darkGreen => _wxHexColour(0x006400);
  static WxColour get darkGrey => _wxHexColour(0xA9A9A9);
  static WxColour get darkKhaki => _wxHexColour(0xBDB76B);
  static WxColour get darkMagenta => _wxHexColour(0x8B008B);
  static WxColour get darkOliveGreen => _wxHexColour(0x556B2F);
  static WxColour get darkOrange => _wxHexColour(0xFF8C00);
  static WxColour get darkOrchid => _wxHexColour(0x9932CC);
  static WxColour get darkRed => _wxHexColour(0x8B0000);
  static WxColour get darkSalmon => _wxHexColour(0xE9967A);
  static WxColour get darkSeaGreen => _wxHexColour(0x8FBC8F);
  static WxColour get darkSlateBlue => _wxHexColour(0x483D8B);
  static WxColour get darkSlateGray => _wxHexColour(0x2F4F4F);
  static WxColour get darkSlateGrey => _wxHexColour(0x2F4F4F);
  static WxColour get darkTurquoise => _wxHexColour(0x00CED1);
  static WxColour get darkViolet => _wxHexColour(0x9400D3);
  static WxColour get deepPink => _wxHexColour(0xFF1493);
  static WxColour get deepSkyBlue => _wxHexColour(0x00BFFF);
  static WxColour get dimGray => _wxHexColour(0x696969);
  static WxColour get dimGrey => _wxHexColour(0x696969);
  static WxColour get dodgerBlue => _wxHexColour(0x1E90FF);
  static WxColour get fireBrick => _wxHexColour(0xB22222);
  static WxColour get floralWhite => _wxHexColour(0xFFFAF0);
  static WxColour get forestGreen => _wxHexColour(0x228B22);
  static WxColour get fuchsia => _wxHexColour(0xFF00FF);
  static WxColour get gainsboro => _wxHexColour(0xDCDCDC);
  static WxColour get ghostWhite => _wxHexColour(0xF8F8FF);
  static WxColour get gold => _wxHexColour(0xFFD700);
  static WxColour get goldenrod => _wxHexColour(0xDAA520);
  static WxColour get gray => _wxHexColour(0x808080);
  static WxColour get green => _wxHexColour(0x008000);
  static WxColour get greenYellow => _wxHexColour(0xADFF2F);
  static WxColour get grey => _wxHexColour(0x808080);
  static WxColour get honeydew => _wxHexColour(0xF0FFF0);
  static WxColour get hotPink => _wxHexColour(0xFF69B4);
  static WxColour get indianRed => _wxHexColour(0xCD5C5C);
  static WxColour get indigo => _wxHexColour(0x4B0082);
  static WxColour get ivory => _wxHexColour(0xFFFFF0);
  static WxColour get khaki => _wxHexColour(0xF0E68C);
  static WxColour get lavender => _wxHexColour(0xE6E6FA);
  static WxColour get lavenderBlush => _wxHexColour(0xFFF0F5);
  static WxColour get lawnGreen => _wxHexColour(0x7CFC00);
  static WxColour get lemonChiffon => _wxHexColour(0xFFFACD);
  static WxColour get lightBlue => _wxHexColour(0xADD8E6);
  static WxColour get lightCoral => _wxHexColour(0xF08080);
  static WxColour get lightCyan => _wxHexColour(0xE0FFFF);
  static WxColour get lightGoldenrodYellow => _wxHexColour(0xFAFAD2);
  static WxColour get lightGray => _wxHexColour(0xD3D3D3);
  static WxColour get lightGreen => _wxHexColour(0x90EE90);
  static WxColour get lightGrey => _wxHexColour(0xD3D3D3);
  static WxColour get lightPink => _wxHexColour(0xFFB6C1);
  static WxColour get lightSalmon => _wxHexColour(0xFFA07A);
  static WxColour get lightSeaGreen => _wxHexColour(0x20B2AA);
  static WxColour get lightSkyBlue => _wxHexColour(0x87CEFA);
  static WxColour get lightSlateGray => _wxHexColour(0x778899);
  static WxColour get lightSlateGrey => _wxHexColour(0x778899);
  static WxColour get lightSteelBlue => _wxHexColour(0xB0C4DE);
  static WxColour get lightYellow => _wxHexColour(0xFFFFE0);
  static WxColour get lime => _wxHexColour(0x00FF00);
  static WxColour get limeGreen => _wxHexColour(0x32CD32);
  static WxColour get linen => _wxHexColour(0xFAF0E6);
  static WxColour get magenta => _wxHexColour(0xFF00FF);
  static WxColour get maroon => _wxHexColour(0x800000);
  static WxColour get mediumAquamarine => _wxHexColour(0x66CDAA);
  static WxColour get mediumBlue => _wxHexColour(0x0000CD);
  static WxColour get mediumOrchid => _wxHexColour(0xBA55D3);
  static WxColour get mediumPurple => _wxHexColour(0x9370DB);
  static WxColour get mediumSeaGreen => _wxHexColour(0x3CB371);
  static WxColour get mediumSlateBlue => _wxHexColour(0x7B68EE);
  static WxColour get mediumSpringGreen => _wxHexColour(0x00FA9A);
  static WxColour get mediumTurquoise => _wxHexColour(0x48D1CC);
  static WxColour get mediumVioletRed => _wxHexColour(0xC71585);
  static WxColour get midnightBlue => _wxHexColour(0x191970);
  static WxColour get mintCream => _wxHexColour(0xF5FFFA);
  static WxColour get mistyRose => _wxHexColour(0xFFE4E1);
  static WxColour get moccasin => _wxHexColour(0xFFE4B5);
  static WxColour get navajoWhite => _wxHexColour(0xFFDEAD);
  static WxColour get navy => _wxHexColour(0x000080);
  static WxColour get oldLace => _wxHexColour(0xFDF5E6);
  static WxColour get olive => _wxHexColour(0x808000);
  static WxColour get oliveDrab => _wxHexColour(0x6B8E23);
  static WxColour get orange => _wxHexColour(0xFFA500);
  static WxColour get orangeRed => _wxHexColour(0xFF4500);
  static WxColour get orchid => _wxHexColour(0xDA70D6);
  static WxColour get paleGoldenrod => _wxHexColour(0xEEE8AA);
  static WxColour get paleGreen => _wxHexColour(0x98FB98);
  static WxColour get paleTurquoise => _wxHexColour(0xAFEEEE);
  static WxColour get paleVioletRed => _wxHexColour(0xDB7093);
  static WxColour get papayaWhip => _wxHexColour(0xFFEFD5);
  static WxColour get peachPuff => _wxHexColour(0xFFDAB9);
  static WxColour get peru => _wxHexColour(0xCD853F);
  static WxColour get pink => _wxHexColour(0xFFC0CB);
  static WxColour get plum => _wxHexColour(0xDDA0DD);
  static WxColour get powderBlue => _wxHexColour(0xB0E0E6);
  static WxColour get purple => _wxHexColour(0x800080);
  static WxColour get rebeccaPurple => _wxHexColour(0x663399);
  static WxColour get red => _wxHexColour(0xFF0000);
  static WxColour get rosyBrown => _wxHexColour(0xBC8F8F);
  static WxColour get royalBlue => _wxHexColour(0x4169E1);
  static WxColour get saddleBrown => _wxHexColour(0x8B4513);
  static WxColour get salmon => _wxHexColour(0xFA8072);
  static WxColour get sandyBrown => _wxHexColour(0xF4A460);
  static WxColour get seaGreen => _wxHexColour(0x2E8B57);
  static WxColour get seashell => _wxHexColour(0xFFF5EE);
  static WxColour get sienna => _wxHexColour(0xA0522D);
  static WxColour get silver => _wxHexColour(0xC0C0C0);
  static WxColour get skyBlue => _wxHexColour(0x87CEEB);
  static WxColour get slateBlue => _wxHexColour(0x6A5ACD);
  static WxColour get slateGray => _wxHexColour(0x708090);
  static WxColour get slateGrey => _wxHexColour(0x708090);
  static WxColour get snow => _wxHexColour(0xFFFAFA);
  static WxColour get springGreen => _wxHexColour(0x00FF7F);
  static WxColour get steelBlue => _wxHexColour(0x4682B4);
  static WxColour get tan => _wxHexColour(0xD2B48C);
  static WxColour get teal => _wxHexColour(0x008080);
  static WxColour get thistle => _wxHexColour(0xD8BFD8);
  static WxColour get tomato => _wxHexColour(0xFF6347);
  static WxColour get turquoise => _wxHexColour(0x40E0D0);
  static WxColour get violet => _wxHexColour(0xEE82EE);
  static WxColour get wheat => _wxHexColour(0xF5DEB3);
  static WxColour get white => _wxHexColour(0xFFFFFF);
  static WxColour get whiteSmoke => _wxHexColour(0xF5F5F5);
  static WxColour get yellow => _wxHexColour(0xFFFF00);
  static WxColour get yellowGreen => _wxHexColour(0x9ACD32);
}

/// Lower case names without spaces and their RGB value as 0xRRGGBB
const Map<String, int> _wxHtmlColourTable = {
  'aliceblue': 0xF0F8FF,
  'antiquewhite': 0xFAEBD7,
  'aqua': 0x00FFFF,
  'aquamarine': 0x7FFFD4,
  'azure': 0xF0FFFF,
  'beige': 0xF5F5DC,
  'bisque': 0xFFE4C4,
  'black': 0x000000,
  'blanchedalmond': 0xFFEBCD,
  'blue': 0x0000FF,
  'blueviolet': 0x8A2BE2,
  'brown': 0xA52A2A,
  'burlywood': 0xDEB887,
  'cadetblue': 0x5F9EA0,
  'chartreuse': 0x7FFF00,
  'chocolate': 0xD2691E,
  'coral': 0xFF7F50,
  'cornflowerblue': 0x6495ED,
  'cornsilk': 0xFFF8DC,
  'crimson': 0xDC143C,
  'cyan': 0x00FFFF,
  'darkblue': 0x00008B,
  'darkcyan': 0x008B8B,
  'darkgoldenrod': 0xB8860B,
  'darkgray': 0xA9A9A9,
  'darkgreen': 0x006400,
  'darkgrey': 0xA9A9A9,
  'darkkhaki': 0xBDB76B,
  'darkmagenta': 0x8B008B,
  'darkolivegreen': 0x556B2F,
  'darkorange': 0xFF8C00,
  'darkorchid': 0x9932CC,
  'darkred': 0x8B0000,
  'darksalmon': 0xE9967A,
  'darkseagreen': 0x8FBC8F,
  'darkslateblue': 0x483D8B,
  'darkslategray': 0x2F4F4F,
  'darkslategrey': 0x2F4F4F,
  'darkturquoise': 0x00CED1,
  'darkviolet': 0x9400D3,
  'deeppink': 0xFF1493,
  'deepskyblue': 0x00BFFF,
  'dimgray': 0x696969,
  'dimgrey': 0x696969,
  'dodgerblue': 0x1E90FF,
  'firebrick': 0xB22222,
  'floralwhite': 0xFFFAF0,
  'forestgreen': 0x228B22,
  'fuchsia': 0xFF00FF,
  'gainsboro': 0xDCDCDC,
  'ghostwhite': 0xF8F8FF,
  'gold': 0xFFD700,
  'goldenrod': 0xDAA520,
  'gray': 0x808080,
  'green': 0x008000,
  'greenyellow': 0xADFF2F,
  'grey': 0x808080,
  'honeydew': 0xF0FFF0,
  'hotpink': 0xFF69B4,
  'indianred': 0xCD5C5C,
  'indigo': 0x4B0082,
  'ivory': 0xFFFFF0,
  'khaki': 0xF0E68C,
  'lavender': 0xE6E6FA,
  'lavenderblush': 0xFFF0F5,
  'lawngreen': 0x7CFC00,
  'lemonchiffon': 0xFFFACD,
  'lightblue': 0xADD8E6,
  'lightcoral': 0xF08080,
  'lightcyan': 0xE0FFFF,
  'lightgoldenrodyellow': 0xFAFAD2,
  'lightgray': 0xD3D3D3,
  'lightgreen': 0x90EE90,
  'lightgrey': 0xD3D3D3,
  'lightpink': 0xFFB6C1,
  'lightsalmon': 0xFFA07A,
  'lightseagreen': 0x20B2AA,
  'lightskyblue': 0x87CEFA,
  'lightslategray': 0x778899,
  'lightslategrey': 0x778899,
  'lightsteelblue': 0xB0C4DE,
  'lightyellow': 0xFFFFE0,
  'lime': 0x00FF00,
  'limegreen': 0x32CD32,
  'linen': 0xFAF0E6,
  'magenta': 0xFF00FF,
  'maroon': 0x800000,
  'mediumaquamarine': 0x66CDAA,
  'mediumblue': 0x0000CD,
  'mediumorchid': 0xBA55D3,
  'mediumpurple': 0x9370DB,
  'mediumseagreen': 0x3CB371,
  'mediumslateblue': 0x7B68EE,
  'mediumspringgreen': 0x00FA9A,
  'mediumturquoise': 0x48D1CC,
  'mediumvioletred': 0xC71585,
  'midnightblue': 0x191970,
  'mintcream': 0xF5FFFA,
  'mistyrose': 0xFFE4E1,
  'moccasin': 0xFFE4B5,
  'navajowhite': 0xFFDEAD,
  'navy': 0x000080,
  'oldlace': 0xFDF5E6,
  'olive': 0x808000,
  'olivedrab': 0x6B8E23,
  'orange': 0xFFA500,
  'orangered': 0xFF4500,
  'orchid': 0xDA70D6,
  'palegoldenrod': 0xEEE8AA,
  'palegreen': 0x98FB98,
  'paleturquoise': 0xAFEEEE,
  'palevioletred': 0xDB7093,
  'papayawhip': 0xFFEFD5,
  'peachpuff': 0xFFDAB9,
  'peru': 0xCD853F,
  'pink': 0xFFC0CB,
  'plum': 0xDDA0DD,
  'powderblue': 0xB0E0E6,
  'purple': 0x800080,
  'rebeccapurple': 0x663399,
  'red': 0xFF0000,
  'rosybrown': 0xBC8F8F,
  'royalblue': 0x4169E1,
  'saddlebrown': 0x8B4513,
  'salmon': 0xFA8072,
  'sandybrown': 0xF4A460,
  'seagreen': 0x2E8B57,
  'seashell': 0xFFF5EE,
  'sienna': 0xA0522D,
  'silver': 0xC0C0C0,
  'skyblue': 0x87CEEB,
  'slateblue': 0x6A5ACD,
  'slategray': 0x708090,
  'slategrey': 0x708090,
  'snow': 0xFFFAFA,
  'springgreen': 0x00FF7F,
  'steelblue': 0x4682B4,
  'tan': 0xD2B48C,
  'teal': 0x008080,
  'thistle': 0xD8BFD8,
  'tomato': 0xFF6347,
  'turquoise': 0x40E0D0,
  'violet': 0xEE82EE,
  'wheat': 0xF5DEB3,
  'white': 0xFFFFFF,
  'whitesmoke': 0xF5F5F5,
  'yellow': 0xFFFF00,
  'yellowgreen': 0x9ACD32,
};
