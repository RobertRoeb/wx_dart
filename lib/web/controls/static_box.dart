// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01 (wxDart Web: 2026-11-15)
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxStaticBox ----------------------

/// Draws a frame around a group of child controls, optionally with 
/// a title/label. used to logically group controls.
/// 
/// Often used with [WxStaticBoxSizer].
/// 
/// Main interface
/// * [setLabel]
/// * [getLabel]

class WxStaticBox extends WxControl {
  WxStaticBox( super._parent, super._id, String label, { super.pos = wxDefaultPosition, super.size = wxDefaultSize, super.style = 0 } ) {
    setLabel( label );
  }

  @override
  String get _jsKind => 'staticbox';

  @override
  void setLabel( String label ) {
    _label = label;
    _jsSetLabel( _handle, _wxStripMnemonic( label ) );
    _labelOrFontChanged();
  }

  /// Space taken by the frame and the label (left, top, right, bottom)
  _JsChrome _chrome() => _jsStaticBoxChrome( _handle );

  @override
  WxSize _doGetBestSize() {
    final c = _chrome();
    return WxSize( c.l + c.r + 40, c.t + c.b + 20 );
  }
}
