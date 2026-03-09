// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxBrush ----------------------

// enum wxBrushStyle
const int  wxBRUSHSTYLE_INVALID     = -1;
const int  wxBRUSHSTYLE_SOLID       = 100;
const int  wxBRUSHSTYLE_TRANSPARENT = 106;

final wxBLACK_BRUSH = WxBrush( wxBLACK );
final wxBLUE_BRUSH = WxBrush( wxBLUE );
final wxCYAN_BRUSH = WxBrush( wxCYAN );
final wxGREEN_BRUSH = WxBrush( wxGREEN );
final wxYELLOW_BRUSH = WxBrush( wxYELLOW );
final wxGREY_BRUSH = WxBrush( wxGREY );
final wxLIGHT_GREY_BRUSH = WxBrush( wxLIGHT_GREY );
final wxMEDIUM_GREY_BRUSH = WxBrush( wxMEDIUM_GREY );
final wxRED_BRUSH = WxBrush( wxRED );
final wxTRANSPARENT_BRUSH = WxBrush( wxBLACK, style: wxBRUSHSTYLE_TRANSPARENT );
final wxWHITE_BRUSH = WxBrush( wxWHITE );

/// Represents the paint style for surfaces in a [WxDC] (device context = drawing interface).
/// 
/// A wxTRANSPARENT_BRUSH indicates no surface painting at all
/// (in cases, where a [WxPen] might be drawing the outline
/// of a shape such as a circle).
/// 
/// [WxBrush] is fully implemented in pure Dart in both wxDart Flutter
/// and wxDart Native and gets converted to its native representation
/// in the call to [WxDC.setBrush]. This is different from [WxFont]
/// which has a native representation directly after it is created. 
/// 
/// # List of brush styles
/// | Style | value |
/// | -------- | -------- |
///  |   wxBRUSHSTYLE_INVALID      |  -1 | 
///  |   wxBRUSHSTYLE_SOLID        |  100 | 
///  |   wxBRUSHSTYLE_TRANSPARENT  |  106 | 
/// 
/// A small number of brushs are predefined global objects:
/// # Global objects 
/// | Object | 
/// | -------- |
/// |  wxTRANSPARENT_BRUSH  |  
/// |  wxBLACK_BRUSH  |  
/// |  wxBLUE_BRUSH  |  
/// |  wxCYAN_BRUSH  | 
/// |  wxGREEN_BRUSH  |  
/// |  wxYELLOW_BRUSH  |  
/// |  wxGREY_BRUSH  |  
/// |  wxLIGHT_GREY_BRUSH  |  
/// |  wxMEDIUM_GREY_BRUSH  |  
/// |  wxRED_BRUSH  |  
/// |  wxWHITE_BRUSH  |  
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
///     dc.setPen( wxTRANSPARENT_PEN );
///     final brush = WxBrush( wxBLUE );
///     dc.setBrush( brush );
///     dc.drawRectangle( 10, 10, 100, 100 );  // blue filled rectangle, no outline/border
///   }
/// }
/// ```

class WxBrush {
/// Creates a brush with the given colour and style
/// ## List of brush styles
/// | Style | value |
/// | -------- | -------- |
///  |   wxBRUSHSTYLE_SOLID        |  100 | 
///  |   wxBRUSHSTYLE_TRANSPARENT  |  106 | 
  WxBrush( this.colour, { this.style = wxBRUSHSTYLE_SOLID } );
  WxColour colour;
  int style;

  /// Returns true of the brush is transparent
  bool isTransparent() {
    return (style == wxBRUSHSTYLE_TRANSPARENT);
  }
  /// Returns true of the brush is not transparent
  bool isNonTransparent() {
    return (style != wxBRUSHSTYLE_TRANSPARENT);
  }
  /// Returns true of the brush is fully qualified
  bool isOk() {
    return true;
  }
}

