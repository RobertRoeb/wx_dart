// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxPen ----------------------

final wxBLACK_DASHED_PEN = WxPen( wxBLACK, style: wxPENSTYLE_DOT );
final wxBLACK_PEN = WxPen( wxBLACK );
final wxBLUE_PEN = WxPen( wxBLUE );
final wxCYAN_PEN = WxPen( wxCYAN );
final wxGREEN_PEN = WxPen( wxGREEN );
final wxYELLOW_PEN = WxPen( wxYELLOW );
final wxGREY_PEN = WxPen( wxGREY );
final wxLIGHT_GREY_PEN = WxPen( wxLIGHT_GREY );
final wxMEDIUM_GREY_PEN = WxPen( wxMEDIUM_GREY );
final wxRED_PEN = WxPen( wxRED );
final wxTRANSPARENT_PEN = WxPen( wxBLACK, style: wxPENSTYLE_TRANSPARENT );
final wxWHITE_PEN = WxPen( wxWHITE );

// enum wxPenStyle
const int  wxPENSTYLE_INVALID     = -1;
const int  wxPENSTYLE_SOLID       = 100;
const int  wxPENSTYLE_DOT         = 101;
const int  wxPENSTYLE_LONG_DASH   = 102;
const int  wxPENSTYLE_SHORT_DASH  = 103;
const int  wxPENSTYLE_DOT_DASH    = 104;
const int  wxPENSTYLE_USER_DASH   = 105;
const int  wxPENSTYLE_TRANSPARENT = 106;

// enum wxPenJoin
const int  wxJOIN_INVALID         = -1;
const int  wxJOIN_BEVEL           = 120;
const int  wxJOIN_MITER           = 121;
const int  wxJOIN_ROUND           = 122;

// enum wxPenCap
const int  wxCAP_INVALID          = -1;
const int  wxCAP_ROUND            = 130;
const int  wxCAP_PROJECTING       = 131;
const int  wxCAP_BUTT             = 132;

/// Represents the drawing style for lines in a [WxDC] (device context = drawing interface).
/// 
/// A wxTRANSPARENT_PEN indicates no line drawing at all
/// (in cases, where a [WxBrush] might be drawing a filled
/// surface such as a circle).
/// 
/// [WxPen] is fully implemented in pure Dart in both wxDart Flutter
/// and wxDart Native and gets converted to its native representation
/// in the call to [WxDC.setPen]. This is different from [WxFont]
/// which has a native representation directly after it is created. 
/// 
/// # List of pen styles
/// | Style | value |
/// | -------- | -------- |
///  |   wxPENSTYLE_INVALID      |  -1 | 
///  |   wxPENSTYLE_SOLID        |  100 | 
///  |   wxPENSTYLE_DOT          |  101 | 
///  |   wxPENSTYLE_LONG_DASH    |  102 | 
///  |   wxPENSTYLE_SHORT_DASH   |  103 | 
///  |   wxPENSTYLE_DOT_DASH     |  104 | 
///  |   wxPENSTYLE_USER_DASH    |  105 | 
///  |   wxPENSTYLE_TRANSPARENT  |  106 | 
/// 
/// A small number of pens are predefined global objects:
/// # Global objects 
/// | Object | 
/// | -------- |
/// |  wxTRANSPARENT_PEN  |  
/// |  wxBLACK_DASHED_PEN  |  
/// |  wxBLACK_PEN  |  
/// |  wxBLUE_PEN  |  
/// |  wxCYAN_PEN  | 
/// |  wxGREEN_PEN  |  
/// |  wxYELLOW_PEN  |  
/// |  wxGREY_PEN  |  
/// |  wxLIGHT_GREY_PEN  |  
/// |  wxMEDIUM_GREY_PEN  |  
/// |  wxRED_PEN  |  
/// |  wxWHITE_PEN  |  
/// 
/// ```dart
/// // Derive new class from WxWindow
/// class MyWindow extends WxWindow {
/// 
///   MyWindow( WxWindow parent, int id ) : super( parent, id, wxDefaultPosition, wxDefaultSize, 0 )
///   {
///     bindPaintEvent(onPaint);
///   }
/// 
///   // define new paint event handler
///   void onPaint( WxPaintEvent event )
///   {
///     final dc = WxPaintDC( this );
///     final pen = WxPen( wxBLACK, width: 2 );
///     dc.setPen( pen );
///     dc.drawLine( 10, 10, 100, 10 );
///   }
/// }
/// ```

class WxPen {

  /// Creates the pen with the given styles
  WxPen( this.colour, { this.width = 1, this.style = wxPENSTYLE_SOLID, this.capStyle=wxCAP_ROUND, this.joinStyle=wxJOIN_MITER } );

  /// Set the width
  void setWidth( int width ) {
    this.width = width;
  }
  /// Returns current width
  int getWidth() {
    return width;
  }
  /// Set colour of the pen
  void setColour( WxColour colour ) {
    this.colour = colour; 
  }
  /// Return current colour
  WxColour getColour() {
    return colour;
  }
  /// Set style of the pen
  /// 
  /// ## List of pen styles
  /// | style | value |
  /// | -------- | -------- |
  ///  |   wxPENSTYLE_SOLID        |  100 | 
  ///  |   wxPENSTYLE_DOT          |  101 | 
  ///  |   wxPENSTYLE_LONG_DASH    |  102 | 
  ///  |   wxPENSTYLE_SHORT_DASH   |  103 | 
  ///  |   wxPENSTYLE_DOT_DASH     |  104 | 
  ///  |   wxPENSTYLE_USER_DASH    |  105 | 
  ///  |   wxPENSTYLE_TRANSPARENT  |  106 | 
  void setStyle( int style ) {
    this.style = style;
  }
  /// Returns current pen style
  int getStyle() {
    return style;
  }
  /// Sets pen's cap style
  /// 
  /// ## List of cap styles
  /// | style | value |
  /// | -------- | -------- |
  /// | wxCAP_ROUND | 130 |
  /// | wxCAP_PROJECTING | 131 |
  /// | wxCAP_BUTT | 132 |
  void setCapStyle( int style ) {
    capStyle = style;
  }
  /// Returns current cap style
  int getCapStyle() {
    return capStyle;
  }
  /// Sets pen's join style
  /// 
  /// ## List of join styles
  /// | style | value |
  /// | -------- | -------- |
  /// | wxJOIN_BEVEL | 120 |
  /// | wxJOIN_MITER | 121 |
  /// | wxJOIN_ROUND | 122 |
  void setJoinStyle( int style ) {
    joinStyle = style;
  }
  /// Returns current join style
  int getJoinStyle() {
    return joinStyle;
  }

  /// Returns true if the pen is transparent
  bool isTransparent() {
    return (style == wxPENSTYLE_TRANSPARENT);
  }
  /// Returns true if the pen is not transparent
  bool isNonTransparent() {
    return (style != wxPENSTYLE_TRANSPARENT);
  }
  /// Returns true if the pen is fully qualified
  bool isOk() {
    return true;
  }
  
  WxColour colour;
  int width;
  int style;
  int capStyle;
  int joinStyle;
}
