// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-11-15
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxStaticText ----------------------

/// Displays a (multi-line) text, implemented as an HTML <div>.
///
/// # Styles
/// | constant | meaning |
/// | -------- | -------- |
/// | wxALIGN_LEFT | left aligned (default) |
/// | wxALIGN_CENTRE_HORIZONTAL | centred |
/// | wxALIGN_RIGHT | right aligned |
/// | wxST_WRAP | wrap text at the window width |
///
/// Without wxST_WRAP (the default), the text is never wrapped (only at
/// "\n") and the control is as wide as its longest line, as in wxDart
/// Flutter and wxDart Native.
///
/// With wxST_WRAP and no fixed width, the text wraps at the
/// width that the sizer gives it, like a paragraph in a HTML page: in a
/// [WxColumn] (with wxEXPAND or not) the whole width of the column, in a
/// [WxRow] its share if it has a proportion > 0, and in a [WxScrolledWindow]
/// that scrolls only vertically (wxVSCROLL) the visible width. See
/// [WxWindow.informFirstDirection].
class WxStaticText extends WxControl {
  WxStaticText(super.parent, super.id, String label,
      {super.pos = wxDefaultPosition, super.size = wxDefaultSize, super.style = 0}) {
    _updateAlignment();
    setLabel(label);
  }

  @override
  String get _jsKind => 'statictext';

  /// Sets the label. "&" is shown literally unless it is "&&".
  @override
  void setLabel(String label) {
    _label = label;
    _jsSetLabel(_handle, label.replaceAll("&&", "&"));
    _labelOrFontChanged();
  }

  /// Wraps the text at [width] pixels
  void wrap(int width) {
    _style |= wxST_WRAP;
    _size = WxSize(width, -1);
    _updateAlignment();
    _labelOrFontChanged();
  }

  /// The width given by the sizer (see [informFirstDirection]), or -1
  int _availableWidth = -1;
  bool _wrapped = false;

  bool get _fixedWrap => ((_style & wxST_WRAP) != 0) && (_size.x != -1);

  String _align() {
    if ((_style & wxALIGN_CENTRE_HORIZONTAL) != 0) return "center";
    if ((_style & wxALIGN_RIGHT) != 0) return "right";
    return "left";
  }

  void _updateAlignment() {
    _jsSetTextAlign(_handle, _align(), _fixedWrap || _wrapped);
  }

  @override
  bool informFirstDirection(int direction, int size, int availableOtherDir) {
    if (direction != wxHORIZONTAL || (_style & wxST_WRAP) == 0 || _size.x != -1) return false;
    if (size == _availableWidth) return true;
    _availableWidth = size;
    // the best size depends on the width now
    _bestSize = null;
    return true;
  }

  @override
  WxSize _doGetBestSize() {
    if (_fixedWrap) {
      final s = _jsMeasure(_handle, _size.x);
      return WxSize(s.w, s.h);
    }
    // the natural size, without wrapping
    _wrapped = false;
    _updateAlignment();
    final natural = _jsMeasure(_handle, -1);
    if (_availableWidth <= 0 || natural.w <= _availableWidth) {
      return WxSize(natural.w, natural.h);
    }
    // too wide: wrap at the available width
    _wrapped = true;
    _updateAlignment();
    final s = _jsMeasure(_handle, _availableWidth);
    return WxSize(_availableWidth, s.h);
  }
}
