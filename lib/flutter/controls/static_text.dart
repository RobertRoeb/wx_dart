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
///
/// Example usage
/// ```dart
///   final label = WxStaticText( this, -1, "Information" );
/// ```
///
/// Main interface
/// * [setLabel]
/// * [getLabel]
/// 
/// # Window syle
/// 
/// | constant | meaning |
/// | -------- | -------- |
/// | wxST_NO_AUTORESIZE | 0x0001 (not implemented in wxDart Flutter|
/// | wxST_WRAP | 0x0002 |
/// | wxST_ELLIPSIZE_START | 0x0004 |
/// | wxST_ELLIPSIZE_MIDDLE | 0x0008 |
/// | wxST_ELLIPSIZE_END | 0x0010 |

class WxStaticText extends WxControl {
  WxStaticText( super.parent, super.id, String label, { super.pos = wxDefaultPosition, super.size = wxDefaultSize, super.style = 0 } ) 
  {
    setLabel( label );
  }

  @override
  Widget _build( BuildContext context ) {
    final Widget text = Text( _labelText, 
      maxLines: hasFlag(wxST_WRAP) ? null : 1,
      overflow: ((wxST_ELLIPSIZE_START|wxST_ELLIPSIZE_MIDDLE|wxST_ELLIPSIZE_END) & _style != 0) ? TextOverflow.ellipsis : null,
      style: _convertTextStyle( _foregroundColour, _font) );
    return _buildControl( context, hasFlag(wxST_WRAP) ? _WrapIntrinsics( child: text ) : text );
  }
}

/// A wrapping text adapts to the width it gets, as in wxWidgets, so it
/// does not ask for the width of its unwrapped text: otherwise the longest
/// paragraph would make an [IntrinsicWidth] (used by [WxColumn] with
/// wxEXPAND items) as wide as the text in one line.
class _WrapIntrinsics extends SingleChildRenderObjectWidget {
  const _WrapIntrinsics({ required super.child });

  @override
  RenderObject createRenderObject( BuildContext context ) => _RenderWrapIntrinsics();
}

class _RenderWrapIntrinsics extends RenderProxyBox {
  // the longest word instead of the whole text in one line
  @override
  double computeMaxIntrinsicWidth( double height ) =>
      child?.getMinIntrinsicWidth( height ) ?? 0.0;
}
