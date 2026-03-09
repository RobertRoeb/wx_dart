// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxPanel ----------------------

/// Simple container window that typically manages child windows.

class WxPanel extends WxWindow {
  WxPanel( WxWindow parent, int id, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = wxTAB_TRAVERSAL } ) 
    : super( parent, id, pos, size, style );

  /// Sets focus to this window/panel, not redirecting to its child windows as
  /// it would normally do. Not implemented in wxDart Flutter.
  void setFocusIgnoringChildren( ) {
  }

  /// Not implemented in wxDart yet
  @override
  bool acceptsFocus() {
    return false;
  }
}
