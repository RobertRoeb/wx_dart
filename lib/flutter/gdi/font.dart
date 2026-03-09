// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxFont ----------------------

final wxNORMAL_FONT = WxFont( 13 );
final wxSMALL_FONT = WxFont( 12 );
final wxITALIC_FONT = WxFont( 13, style: wxFONTSTYLE_ITALIC );

// ------------------------- font conversion ----------------------

  FontWeight _convertFontWeight( int weight ) {
    switch (weight) {
      case 100: return FontWeight.w100;
      case 200: return FontWeight.w200;
      case 300: return FontWeight.w300;
      case 400: return FontWeight.normal;
      case 500: return FontWeight.w500;
      case 600: return FontWeight.w600;
      case 700: return FontWeight.bold;
      case 800: return FontWeight.w800;
      case 900: return FontWeight.w900;
      default:
    }
    return FontWeight.normal;
  }

  List<String> _convertFontFamily( int family ) {
    List<String> ret = [];

    if (wxIsMac())
    {
      switch (family) {
        case wxFONTFAMILY_ROMAN:
        case wxFONTFAMILY_SCRIPT:
          ret.add( "Times" );
          ret.add( "Palatino" );
          ret.add( "Times New Roman" );
          ret.add( "Liberation Serif" );
          break;

        case wxFONTFAMILY_SWISS:
        case wxFONTFAMILY_MODERN:
          ret.add( "SF Pro" );
          ret.add( "Arial" );
          ret.add( "Calibri" );
          ret.add( "Verdana" );
          ret.add( "Helvetica" );
          ret.add( "Noto Sans CJK" );
          break;

        case wxFONTFAMILY_TELETYPE:
          ret.add( "SF Mono" );
          ret.add( "Courier New" );
        default:
      }
    }
    else if (wxIsMSW())
    {
      switch (family) {
        case wxFONTFAMILY_ROMAN:
        case wxFONTFAMILY_SCRIPT:
          ret.add( "Times" );
          ret.add( "Palatino" );
          ret.add( "Times New Roman" );
          ret.add( "Liberation Serif" );
          break;

        case wxFONTFAMILY_SWISS:
        case wxFONTFAMILY_MODERN:
          ret.add( "Segoe UI" );
          ret.add( "Arial" );
          ret.add( "Calibri" );
          ret.add( "Verdana" );
          ret.add( "Helvetica" );
          ret.add( "Noto Sans CJK" );
          break;

        case wxFONTFAMILY_TELETYPE:
          ret.add( "Courier New" );
        default:
      }
    } else if (wxIsLinux())
    {
      switch (family) {
        case wxFONTFAMILY_ROMAN:
        case wxFONTFAMILY_SCRIPT:
          ret.add( "Liberation Serif" );
          ret.add( "Nimbus Roman No9 L" );
          ret.add( "Times" );
          ret.add( "Palatino" );
          ret.add( "Times New Roman" );
          break;

        case wxFONTFAMILY_SWISS:
        case wxFONTFAMILY_MODERN:
          ret.add( "Roboto" );
          ret.add( "Ubuntu Sans" );
          ret.add( "Arial" );
          ret.add( "Calibri" );
          ret.add( "Verdana" );
          ret.add( "Helvetica" );
          ret.add( "Noto Sans CJK" );
          break;

        case wxFONTFAMILY_TELETYPE:
          ret.add( "Ubuntu Mono" );
          ret.add( "Courier New" );
        default:
      }
    }

    return ret;
  }

  TextStyle? _convertTextStyle( WxColour? colour, WxFont? font )
  {
    if ((font == null) && (colour == null)) {
      return null;
    }
    if (font == null) {
      return TextStyle( 
        color:  Color.fromARGB( colour!.alpha, colour.red, colour.green, colour.blue ) );
    }
    if (colour == null) {
      return TextStyle( 
          fontSize: font.getPointSize(),
          fontStyle: (font.getStyle() == wxFONTSTYLE_ITALIC) ? FontStyle.italic : FontStyle.normal,
          fontWeight: _convertFontWeight(font.getWeight()),
          fontFamily: null,
          fontFamilyFallback: _convertFontFamily( font.getFamily() )
      );
    }
    return TextStyle( 
        color:  Color.fromARGB( colour.alpha, colour.red, colour.green, colour.blue ),
        fontSize: font.getPointSize(),
        fontStyle: (font.getStyle() == wxFONTSTYLE_ITALIC) ? FontStyle.italic : FontStyle.normal,
        fontWeight: _convertFontWeight(font.getWeight()),
        fontFamily: null,
        fontFamilyFallback: _convertFontFamily( font.getFamily() )
    );
  }
  
// ------------------------- wxFont ----------------------

const int wxFONTFAMILY_DEFAULT = 70;
const int wxFONTFAMILY_DECORATIVE = 71;
const int wxFONTFAMILY_ROMAN = 72;
const int wxFONTFAMILY_SCRIPT = 73;
const int wxFONTFAMILY_SWISS = 74;
const int wxFONTFAMILY_MODERN = 75;
const int wxFONTFAMILY_TELETYPE = 76;
const int wxFONTSTYLE_NORMAL = 90;
const int wxFONTSTYLE_ITALIC = 93;
const int wxFONTSTYLE_SLANT = 94;
const int wxFONTWEIGHT_INVALID = 0;
const int wxFONTWEIGHT_THIN = 100;
const int wxFONTWEIGHT_EXTRALIGHT = 200;
const int wxFONTWEIGHT_LIGHT = 300;
const int wxFONTWEIGHT_NORMAL = 400;
const int wxFONTWEIGHT_MEDIUM = 500;
const int wxFONTWEIGHT_SEMIBOLD = 600;
const int wxFONTWEIGHT_BOLD = 700;
const int wxFONTWEIGHT_EXTRABOLD = 800;
const int wxFONTWEIGHT_HEAVY = 900;
const int wxFONTWEIGHT_EXTRAHEAVY = 1000;


/// Represents a font style.
/// 
/// Creating a font can be an expensive operation on certain platforms.
/// Keep and reuse a font, once it is created, rather than destroying and
/// creating new ones. Also, you cannot create hundres of fonts.
/// 
/// The respective backend code on all platforms tries to find the
/// most suitable font for the given font style.
/// 
/// There is no standard font size across all platforms. Indeed, this can
/// depend on user settings. [wxNORMAL_FONT] represents the current standard
/// system font and should be identical to the font returned by 
/// ```dart
///   final font = wxGetSystemSettings.getFont( wxSYS_DEFAULT_GUI_FONT );
/// ```
/// 
/// If you want to create a font somewhat bigger than the system font, you
/// need to query its pointSize first:
/// 
/// ```dart
///    final pointSize = wxNORMAL_FONT.getPointSize();
///    final font = WxFont( pointSize*1.3 );
/// ```
/// If you want to query the height of text with the font a certain
/// window is currently using as its default font, you can do that
/// with [WxWindow.getTextExtent] without creating any device
/// context or any font:
/// 
/// ```dart
///  final height = getTextExtent("H").y;
/// ```
/// 
/// If you want to draw text with a given font, set the font in
/// the respective device context (DC) in an paint event handler:
///```dart
/// // Derive new class from WxWindow
/// class MyWindow extends WxWindow {
/// 
///   MyWindow( WxWindow parent, int id ) : super( parent, id, wxDefaultPosition, wxDefaultSize, 0 )
///   {
///     // Bind to paint event
///     bindPaintEvent(onPaint);
///   }
/// 
///   // define new paint event handler
///   void onPaint( WxPaintEvent event )
///   {
///     // create paint device context during paint event
///     final dc = WxPaintDC( this );
///     dc.setFont( wxSMALL_FONT );
///     dc.setTextForeground( wxYELLOW );
///     dc.drawText( "Hello", 10, 10 );
///   }
/// }
/// ```
/// 
/// # Global objects 
/// | Object | value |
/// | -------- | -------- |
/// | wxNORMAL_FONT | current standard system font |
/// | wxSMALL_FONT | font smaller than system font |
/// | wxIALTIC_FONT | standard size font in italics |
/// 
/// 
/// # Font family constants 
/// | constant | value |
/// | -------- | -------- |
/// | wxFONTFAMILY_DEFAULT | 70 |
/// | wxFONTFAMILY_DECORATIVE | 71 |
/// | wxFONTFAMILY_ROMAN | 72 |
/// | wxFONTFAMILY_SCRIPT | 73 |
/// | wxFONTFAMILY_SWISS | 74 |
/// | wxFONTFAMILY_MODERN | 75 |
/// | wxFONTFAMILY_TELETYPE | 76 |
/// 
/// # Font style constants
/// | constant | value |
/// | -------- | -------- |
/// | wxFONTSTYLE_NORMAL | 90 |
/// | wxFONTSTYLE_ITALIC | 93 |
/// | wxFONTSTYLE_SLANT | 94 |
/// 
/// # Font weight constants
/// | constant | value |
/// | -------- | -------- |
/// | wxFONTWEIGHT_INVALID | 0 |
/// | wxFONTWEIGHT_THIN | 100 |
/// | wxFONTWEIGHT_EXTRALIGHT | 200 |
/// | wxFONTWEIGHT_LIGHT | 300 |
/// | wxFONTWEIGHT_NORMAL | 400 |
/// | wxFONTWEIGHT_MEDIUM | 500 |
/// | wxFONTWEIGHT_SEMIBOLD | 600 |
/// | wxFONTWEIGHT_BOLD | 700 |
/// | wxFONTWEIGHT_EXTRABOLD | 800 |
/// | wxFONTWEIGHT_HEAVY | 900 |
/// | wxFONTWEIGHT_EXTRAHEAVY | 1000 |


class WxFont extends WxObject {
  /// Creates a font with a given size in points. 
  /// 
  /// This constructor will look for the best matching standard font.
  WxFont( double pointSize, { int family = wxFONTFAMILY_DEFAULT, int style = wxFONTSTYLE_NORMAL, int weight = wxFONTWEIGHT_NORMAL, bool underline = false } ) 
  {
    _pointSize = pointSize;
    _family = family;
    _style = style;
    _weight = weight;
    _underline = underline;
  }

  /// Creates a font with a given size in pixels, not points
  WxFont.fromPixelSize( WxSize pixelSize, { int family = wxFONTFAMILY_DEFAULT, int style = wxFONTSTYLE_NORMAL, int weight = wxFONTWEIGHT_NORMAL, bool underline = false } ) 
  {
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

  /// Returns true if the font is defined
  bool isOk( ) {
    return true;
  }

  /// Returns size in points
  double getPointSize() {
    return _pointSize;
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
  void makeLarger( ) {
    _pointSize *= 1.2;
  }
  /// Make font a little smaller
  void makeSmaller( ) {
    _pointSize /= 1.2;
  }
}

