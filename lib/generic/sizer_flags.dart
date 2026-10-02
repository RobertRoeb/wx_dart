// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../wx_dart.dart';

// ----------------------- WxSizerFlags --------------------

/// Constant to be used with [WxSizerFlags]
enum WxHAlignment { left, right, center, expand }

/// Constant to be used with [WxSizerFlags]
enum WxVAlignment { top, bottom, center, expand }

/// Helper class that constructs the _flag_ parameter for 
/// all [WxSizer.add], [WxSizer.insert], [WxSizer.prepend] functions.
/// It helps avoid typing errors. 
/// 
/// See [WxBoxSizer] for meaning of the indivdual flags.
/// 
/// Examples:
/// 
/// ```dart
/// // create vertical WxBoxSizer = WxColmun
/// final col = WxColumn();
/// 
/// // old style to specify flags
/// col.add( WxTextCtrl( this,-1), flag: wxALL|wxEXPAND, border: 5 );
/// 
/// // old style to specify flags
/// col.add( WxTextCtrl( this,-1), flag: WxSizerFlags.expandAndBorderAll(), border: 5 );
/// 
/// 
/// // old style to specify flags
/// col.add( WxTextCtrl( this,-1), flag: wxLEFT, border: 5 );
/// 
/// // old style to specify flags
/// col.add( WxTextCtrl( this,-1), flag: WxSizerFlags.border( left: true ), border: 5 );
/// 
/// ```
class WxSizerFlags {
  /// Speficies all border and alignments individually
  static int border(  {
    bool left=false, 
    bool right=false, 
    bool top=false, 
    bool bottom=false,
    WxVAlignment valign = WxVAlignment.top, 
    WxHAlignment halign = WxHAlignment.left, 
    bool shaped = false,
    bool fixedMinSize = false } )
  {
    return 
      (left ? wxLEFT : 0) |
      (right ? wxRIGHT : 0) |
      (top ? wxTOP : 0) |
      (bottom ? wxBOTTOM : 0) |
      (shaped ? wxSHAPED : 0) |
      (fixedMinSize ? wxFIXED_MINSIZE : 0) |
      (valign == WxVAlignment.top ? wxALIGN_TOP : 0) |
      (valign == WxVAlignment.bottom ? wxALIGN_BOTTOM : 0) |
      (valign == WxVAlignment.center ? wxALIGN_CENTER_VERTICAL : 0) |
      (valign == WxVAlignment.expand ? wxEXPAND : 0) |
      (halign == WxHAlignment.left ? wxALIGN_LEFT : 0) |
      (halign == WxHAlignment.right ? wxALIGN_RIGHT : 0) |
      (halign == WxHAlignment.center ? wxALIGN_CENTER_HORIZONTAL : 0) |
      (halign == WxHAlignment.expand ? wxEXPAND : 0);
  }

  /// Centres the item (in any WxSizer) and specifies borders indivdually
  static int alignCentre(  {
    bool left=false, 
    bool right=false, 
    bool top=false, 
    bool bottom=false  } )
  {
    return 
      wxALIGN_CENTRE |
      (left ? wxLEFT : 0) |
      (right ? wxRIGHT : 0) |
      (top ? wxTOP : 0) |
      (bottom ? wxBOTTOM : 0);
  }

  /// Aligns the item to the right (in a [WxColumn] = vertical [WxBoxSizer]) and specifies borders indivdually
  static int alignRight(  {
    bool left=false, 
    bool right=false, 
    bool top=false, 
    bool bottom=false  } )
  {
    return 
      wxALIGN_RIGHT |
      (left ? wxLEFT : 0) |
      (right ? wxRIGHT : 0) |
      (top ? wxTOP : 0) |
      (bottom ? wxBOTTOM : 0);
  }

  /// Aligns the item at the bottom (in a [WxRow] = horizontal [WxBoxSizer]) and specifies borders indivdually
  static int alignBottom(  {
    bool left=false, 
    bool right=false, 
    bool top=false, 
    bool bottom=false  } )
  {
    return 
      wxALIGN_LEFT |
      (left ? wxLEFT : 0) |
      (right ? wxRIGHT : 0) |
      (top ? wxTOP : 0) |
      (bottom ? wxBOTTOM : 0);
  }

  /// Expands the item maximally (in any [WxSizer]) and specifies borders indivdually
  static int expand(  {
    bool left=false, 
    bool right=false, 
    bool top=false, 
    bool bottom=false  } )
  {
    return 
      wxEXPAND |
      (left ? wxLEFT : 0) |
      (right ? wxRIGHT : 0) |
      (top ? wxTOP : 0) |
      (bottom ? wxBOTTOM : 0);
  }

  /// Uses shaped dimensions (only wxDart Native)
  static int shaped(  {
    bool left=false, 
    bool right=false, 
    bool top=false, 
    bool bottom=false } )
  {
    return 
      wxSHAPED |
      (left ? wxLEFT : 0) |
      (right ? wxRIGHT : 0) |
      (top ? wxTOP : 0) |
      (bottom ? wxBOTTOM : 0);
  }

  /// Uses fixed minimum size (only wxDart Native)
  static int fixedMinSize(  {
    bool left=false, 
    bool right=false, 
    bool top=false, 
    bool bottom=false,
    bool fixedMinSize = false } )
  {
    return 
      wxFIXED_MINSIZE |
      (left ? wxLEFT : 0) |
      (right ? wxRIGHT : 0) |
      (top ? wxTOP : 0) |
      (bottom ? wxBOTTOM : 0);
  }

  /// Applies border left and right of an item and allows to specifiy alignment individually
  static int borderHorizontal( {
    WxVAlignment valign = WxVAlignment.top, 
    WxHAlignment halign = WxHAlignment.left, 
    bool shaped = false,
    bool fixedMinSize = false } ) 
  {
    return wxLEFT|wxRIGHT |
      (shaped ? wxSHAPED : 0) |
      (fixedMinSize ? wxFIXED_MINSIZE : 0) |
      (valign == WxVAlignment.top ? wxALIGN_TOP : 0) |
      (valign == WxVAlignment.bottom ? wxALIGN_BOTTOM : 0) |
      (valign == WxVAlignment.center ? wxALIGN_CENTER_VERTICAL : 0) |
      (valign == WxVAlignment.expand ? wxEXPAND : 0) |
      (halign == WxHAlignment.left ? wxALIGN_LEFT : 0) |
      (halign == WxHAlignment.right ? wxALIGN_RIGHT : 0) |
      (halign == WxHAlignment.center ? wxALIGN_CENTER_HORIZONTAL : 0) |
      (halign == WxHAlignment.expand ? wxEXPAND : 0);
  }

  /// Applies border above and below an item and allows to specifiy alignment individually
  static int borderVertical( {
    WxVAlignment valign = WxVAlignment.top, 
    WxHAlignment halign = WxHAlignment.left, 
    bool shaped = false,
    bool fixedMinSize = false } )
  {
    return wxTOP|wxBOTTOM |
      (shaped ? wxSHAPED : 0) |
      (fixedMinSize ? wxFIXED_MINSIZE : 0) |
      (valign == WxVAlignment.top ? wxALIGN_TOP : 0) |
      (valign == WxVAlignment.bottom ? wxALIGN_BOTTOM : 0) |
      (valign == WxVAlignment.center ? wxALIGN_CENTER_VERTICAL : 0) |
      (valign == WxVAlignment.expand ? wxEXPAND : 0) |
      (halign == WxHAlignment.left ? wxALIGN_LEFT : 0) |
      (halign == WxHAlignment.right ? wxALIGN_RIGHT : 0) |
      (halign == WxHAlignment.center ? wxALIGN_CENTER_HORIZONTAL : 0) |
      (halign == WxHAlignment.expand ? wxEXPAND : 0);
  }

  /// Applies border all around item and allows to specifiy alignment individually
  static int borderAll( {
    WxVAlignment valign = WxVAlignment.top, 
    WxHAlignment halign = WxHAlignment.left, 
    bool shaped = false,
    bool fixedMinSize = false } ) {
    return wxALL |
      (shaped ? wxSHAPED : 0) |
      (fixedMinSize ? wxFIXED_MINSIZE : 0) |
      (valign == WxVAlignment.top ? wxALIGN_TOP : 0) |
      (valign == WxVAlignment.bottom ? wxALIGN_BOTTOM : 0) |
      (valign == WxVAlignment.center ? wxALIGN_CENTER_VERTICAL : 0) |
      (valign == WxVAlignment.expand ? wxEXPAND : 0) |
      (halign == WxHAlignment.left ? wxALIGN_LEFT : 0) |
      (halign == WxHAlignment.right ? wxALIGN_RIGHT : 0) |
      (halign == WxHAlignment.center ? wxALIGN_CENTER_HORIZONTAL : 0) |
      (halign == WxHAlignment.expand ? wxEXPAND : 0);
  }

  /// Applies border all around item and always expands
  static int expandAndBorderAll( {
    bool shaped = false,
    bool fixedMinSize = false } ) {
    return wxEXPAND | wxALL |
      (shaped ? wxSHAPED : 0) |
      (fixedMinSize ? wxFIXED_MINSIZE : 0);
  }
}

/// Synonym to a vertical [WxBoxSizer]

class WxColumn extends WxBoxSizer {
  /// Creates the vertical [WxBoxSizer]
  WxColumn() : super( wxVERTICAL );
}

/// Synonym to a horizontal [WxBoxSizer]

class WxRow extends WxBoxSizer {
  /// Creates the horizontal [WxBoxSizer]
  WxRow() : super( wxHORIZONTAL );
}