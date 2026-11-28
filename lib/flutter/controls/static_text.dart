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
/// Proposed for wxWidgets: the text can be selected with the mouse and
/// copied (and translated by the browser in wxDart Web)
const int wxST_SELECTABLE = 0x0020;

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

  int _headingLevel = 0;

  /// Marks the text as a heading of the given [level] (1 to 6), or as normal
  /// text with 0: a heading for screen readers (and an <h1> to <h6> when
  /// running in a browser), an <h1> to <h6> element in wxDart Web, no effect
  /// in wxDart Native so far. The look doesn't change, see [WxFont.heading].
  void setHeadingLevel( int level ) {
    _headingLevel = (level >= 1 && level <= 6) ? level : 0;
    _setState();
  }

  /// Returns the level set with [setHeadingLevel], 0 if not a heading
  int getHeadingLevel() => _headingLevel;

  @override
  Widget _build( BuildContext context ) {
    final TextStyle? textStyle = _convertTextStyle( _foregroundColour, _font);
    final Widget text = hasFlag(wxST_SELECTABLE)
      // the text can be selected with the mouse and copied; an ellipsis
      // makes no sense here, as one would copy the whole text anyway
      ? SelectableText( _labelText,
          maxLines: hasFlag(wxST_WRAP) ? null : 1,
          style: textStyle )
      : Text( _labelText, 
      maxLines: hasFlag(wxST_WRAP) ? null : 1,
      overflow: ((wxST_ELLIPSIZE_START|wxST_ELLIPSIZE_MIDDLE|wxST_ELLIPSIZE_END) & _style != 0) ? TextOverflow.ellipsis : null,
          style: textStyle );
    Widget result = hasFlag(wxST_WRAP) ? _WrapIntrinsics( child: text ) : text;
    if (_headingLevel > 0) {
      // headingLevel needs Flutter 3.24 or later
      result = Semantics( header: true, headingLevel: _headingLevel, child: result );
    }
    return _buildControl( context, result );
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
