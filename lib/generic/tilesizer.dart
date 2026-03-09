// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../wx_dart.dart';

// ----------------------- WxTileSizer --------------------

/// This sizer lays out its child items in the form of a tile, a frequently used
/// layout for information on mobile devices. The main contents is the 
/// title at the top (usually using a [WxStaticText] control), optionally followed
/// by a subtitle and a third row. To the left is a leading window, the may be an
/// icon, and optionally a trailing window to the right.

class WxTileSizer extends WxBoxSizer {
  WxTileSizer( WxWindow? leading, WxWindow title, WxWindow? subtitle,
    {
       WxWindow? third,
       WxWindow? trailing,
       int margin = 2
    }
  ) : super( wxHORIZONTAL )
  {
    if (leading != null) {
      add( leading, flag: wxLEFT|wxTOP|wxBOTTOM|wxALIGN_CENTRE_VERTICAL, border: margin );
    }
    final mid = WxBoxSizer( wxVERTICAL );
    addSizer( mid, proportion: 1, flag: wxALL/*|wxEXPAND*/, border: margin );
    mid.addStretchSpacer();
    mid.add( title, flag: wxALIGN_LEFT );
    mid.addStretchSpacer();
    if (subtitle != null) {
      mid.add( subtitle, flag: wxALIGN_LEFT|wxTOP, border: margin );
    }
    if (third != null) {
      mid.addStretchSpacer();
      mid.add( third, flag: wxALIGN_LEFT|wxTOP, border: margin );
    }
    mid.addStretchSpacer();
    if (trailing != null) {
      add( trailing, flag: wxRIGHT|wxTOP|wxBOTTOM|wxALIGN_CENTRE_VERTICAL, border: margin );
    }
  }
}

// ----------------------- WxColumn --------------------

/// Constant to be used with [WxSizerFlags]
enum WxHAlignment { left, right, center, expand }

/// Constant to be used with [WxSizerFlags]
enum WxVAlignment { top, bottom, center, expand }

/// Helper class that constructs the _flag_ parameter for 
/// all [WxSizer.add], [WxSizer.insert], [WxSizer.prepend] functions.
/// It helps avoid typing errors. 
/// 
/// See [WxBoxSizer] for meaning of the indivdual flags.
class WxSizerFlags {
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
}

/// Synonym to a vertical [WxBoxSizer]

class WxColumn extends WxBoxSizer {
  WxColumn() : super( wxVERTICAL );
}

/// Synonym to a horizontal [WxBoxSizer]

class WxRow extends WxBoxSizer {
  WxRow() : super( wxHORIZONTAL );
}