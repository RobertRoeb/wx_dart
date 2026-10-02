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

