// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxStaticLine ----------------------

const int wxLI_HORIZONTAL = wxHORIZONTAL;
const int wxLI_VERTICAL = wxVERTICAL;

/// Shows a static line
/// 
/// # Window styles
/// | constant | meaning |
/// | -------- | -------- |
/// | wxLI_HORIZONTAL | wxHORIZONTAL |
/// | wxLI_VERTICAL | wxVERTICAL |
class WxStaticLine extends WxControl {
  WxStaticLine( super.parent, super.id, { super.pos, super.size, super.style = wxLI_HORIZONTAL } );

  @override
  Widget _build(BuildContext context)
  {
    Widget line = SizedBox(
      width: _initialSize.x > 0 ? _initialSize.x.toDouble() : null,
      height: _initialSize.y > 0 ? _initialSize.y.toDouble() : null,
    );
    return _buildControl(context, line );
  }
}
