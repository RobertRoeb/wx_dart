// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxStaticText ----------------------

const int wxST_NO_AUTORESIZE = 0x0001;
const int wxST_WRAP = 0x0002;
const int wxST_ELLIPSIZE_START = 0x0004;
const int wxST_ELLIPSIZE_MIDDLE = 0x0008;
const int wxST_ELLIPSIZE_END = 0x0010;

/// Represents static text on screen.
///
/// # Window syle
/// 
/// | constant | meaning |
/// | -------- | -------- |
/// | wxST_NO_AUTORESIZE | 0x0001 |
/// | wxST_WRAP | 0x0002 |
/// | wxST_ELLIPSIZE_START | 0x0004 |
/// | wxST_ELLIPSIZE_MIDDLE | 0x0008 |
/// | wxST_ELLIPSIZE_END | 0x0010 |

class WxStaticText extends WxControl {
  WxStaticText( super.parent, super.id, String label, { super.pos = wxDefaultPosition, super.size = wxDefaultSize, super.style = wxST_WRAP } ) 
  {
    _label = label;
  }

  String _label = "";

  @override
  Widget _build( BuildContext context ) {
    return _buildControl( context, Text( _label, style: _convertTextStyle( _foregroundColour, _font) ) );
  }
 
  void setLabel( String label ) {
    _label = label;
    _setState();
  }
}
