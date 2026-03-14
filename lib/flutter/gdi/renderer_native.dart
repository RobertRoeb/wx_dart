// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// -------------------- wxRendererNative -----------------------

WxRendererNative? theRendererNative;

WxRendererNative wxGetRendererNative() {
  if (theRendererNative != null) {
    return theRendererNative!;
  }

  theRendererNative = WxRendererNative();
  return theRendererNative!;
}

// ------------------------- wxRendererNative ----------------------

const int wxHDR_SORT_ICON_NONE = 0;
const int wxHDR_SORT_ICON_UP = 1;
const int wxHDR_SORT_ICON_DOWN = 2;

const int wxCONTROL_NONE       = 0x00000000;
const int wxCONTROL_DISABLED   = 0x00000001;
const int wxCONTROL_FOCUSED    = 0x00000002;
const int wxCONTROL_PRESSED    = 0x00000004;
const int wxCONTROL_SPECIAL    = 0x00000008;
const int wxCONTROL_ISDEFAULT  = wxCONTROL_SPECIAL;
const int wxCONTROL_ISSUBMENU  = wxCONTROL_SPECIAL;
const int wxCONTROL_EXPANDED   = wxCONTROL_SPECIAL;
const int wxCONTROL_SIZEGRIP   = wxCONTROL_SPECIAL;
const int wxCONTROL_FLAT       = wxCONTROL_SPECIAL;
const int wxCONTROL_CELL       = wxCONTROL_SPECIAL;
const int wxCONTROL_CURRENT    = 0x00000010;
const int wxCONTROL_SELECTED   = 0x00000020;
const int wxCONTROL_CHECKED    = 0x00000040;
const int wxCONTROL_CHECKABLE  = 0x00000080;
const int wxCONTROL_UNDETERMINED = wxCONTROL_CHECKABLE;
const int wxCONTROL_FLAGS_MASK = 0x000000ff;
const int wxCONTROL_DIRTY      = 0x80000000;

const int wxCONTROL_SELECTION_GROUP  = 0x20000000;
const int wxCONTROL_ITEM_FIRST       = 0x40000000;
const int wxCONTROL_ITEM_LAST        = wxCONTROL_DIRTY;


/// A class for rendering elements of th UI using the underlying systems
/// functions of colour choices. 
/// 
/// A reference to this class is acquired through the global function [wxGetRendererNative].
/// 
/// The most commonly used function of this class is [drawItemSelectionRect].
/// 
/// ```dart
/// // in an onPaint handler
///      wxGetRendererNative().drawItemSelectionRect
///            (
///               this,    // my window
///               dc,      // my WxPaintDC
///               rowRect, // size of the selection area
///               flags: wxCONTROL_SELECTED | wxCONTROL_FOCUSED
///            );
/// ```
class WxRendererNative extends WxClass {
  WxRendererNative();

  static WxBitmap? _checkboxChecked;
  static WxBitmap? _checkboxUnchecked;
  static int _checkBoxHeight = -1;

  static void _updateTheme() {
    _checkboxChecked = null;
    _checkboxUnchecked = null;
    _checkBoxHeight = -1;
  }
 
  void drawItemText( WxWindow win, WxDC dc, String text, WxRect rect, { int align = wxALIGN_LEFT|wxALIGN_TOP, int flags = 0, int ellipsizeMode = wxELLIPSIZE_END } ) {
  }

/// Draws a check box
/// 
/// ## Flag styles
/// | constant | meaning |
/// | -------- | -------- |
/// | wxCONTROL_CHECKED | draw in checked state |
  void drawCheckBox( WxWindow win, WxDC dc, WxRect rect, { int flags = 0 } ) {
    final newHeight = max( 12, min( rect.height-2, win.fromDIP( 22 ) ) );
    final y = 1 + (rect.height - newHeight) ~/ 2;
    if (_checkBoxHeight == newHeight) {
      if (_checkboxChecked == null) return;
      if (_checkboxUnchecked == null) return;
    } else {
      final col = wxTheApp.getSecondaryAccentColour();
      _checkboxChecked = WxBitmap.fromMaterialIcon(WxMaterialIcon.check_box, WxSize(newHeight,newHeight), col );
      _checkboxUnchecked = WxBitmap.fromMaterialIcon(WxMaterialIcon.check_box_outline_blank, WxSize(newHeight,newHeight), col );
      _checkBoxHeight = newHeight;
    }
    if (flags & wxCONTROL_CHECKED != 0) {
      dc.drawBitmap( _checkboxChecked!, rect.x + 3, rect.y + y );
    } else {
      dc.drawBitmap( _checkboxUnchecked!, rect.x + 3, rect.y + y );
    }
  }

  void drawCheckMark( WxWindow win, WxDC dc, WxRect rect, { int flags = 0 } ) {
  }

  void drawRadioBitmap( WxWindow win, WxDC dc, WxRect rect, { int flags = 0 } ) {
  }

  /// Draws a progress bar indicating the value [value] out of [max]
  void drawGauge( WxWindow win, WxDC dc, WxRect rect, int value, int max, { int flags = 0 } ) {
    dc.setPen( wxTRANSPARENT_PEN );
//    dc.setBrush( WxBrush( wxTheApp.getPrimaryAccentColour()) );
    if (wxTheApp.isDark()) {
      dc.setBrush( wxGREY_BRUSH );
    } else {
      dc.setBrush( wxLIGHT_GREY_BRUSH );
    }
    final totalWidth = rect.width-6;
    dc.drawRectangle( rect.x+3, rect.y + rect.height - 12, totalWidth, 6 );
    final partialWidth = (totalWidth * value / max).floor();
    dc.setBrush( WxBrush( wxTheApp.getSecondaryAccentColour()) );
    dc.drawRectangle( rect.x+3, rect.y + rect.height - 12, partialWidth, 6 );
  }

/// Draws the tree item expander usually (chevron or plus/minus)
/// 
/// ## Flag styles
/// | constant | meaning |
/// | -------- | -------- |
/// | wxCONTROL_EXPANDED | draw in expanded state |
  void drawTreeItemButton( WxWindow win, WxDC dc, WxRect rect, { int flags = 0 } )
  {
    int margin = 4;
    if (wxTheApp.isDark()) {
      dc.setPen( wxWHITE_PEN );
    } else {
      dc.setPen( wxBLACK_PEN );
    }

    if ((flags & wxCONTROL_EXPANDED) == 0) {
      dc.drawLine(rect.x + rect.width ~/2, 1+rect.y + margin, rect.x + rect.width ~/2, rect.y + rect.height - margin );
      dc.drawLine(1+rect.x + rect.width ~/2, 1+rect.y + margin, 1+rect.x + rect.width ~/2, rect.y + rect.height - margin );
    }
    dc.drawLine(1+rect.x + margin, rect.y + rect.height~/2, rect.x+rect.width- margin, rect.y + rect.height~/2 );
    dc.drawLine(1+rect.x + margin, 1 + rect.y + rect.height~/2, rect.x+rect.width- margin, 1+ rect.y + rect.height~/2 );
  }

  WxSize getExpanderSize( WxWindow win ) {
    return WxSize(20, 20);
  }

  /// Draws the focus rectangle around an element on screen 
  void drawFocusRect( WxWindow win, WxDC dc, WxRect rect, { int flags = 0 } )
  {
      if (wxTheApp.isTouch()) return;
      dc.setBrush( wxTRANSPARENT_BRUSH );
      dc.setPen( WxPen( wxTheApp.getSecondaryAccentColour() ) );
      dc.drawRectangle(rect.x, rect.y+1, rect.width, rect.height-1 );
  }

/// Draws a selection rectangle of dimensions [rect] underneath an element in 
/// the window/control [win] using the [dc] to draw with. Flags further specify the
/// state of the window/control and or element.
/// 
/// ## Flag styles
/// | constant | meaning |
/// | -------- | -------- |
/// | wxCONTROL_FOCUSED | the controlled is currently focussed |
/// | wxCONTROL_CURRENT | the mouse is currently over the element |
/// | wxCONTROL_SELECTED | the element is currently selected (draw nothing, then) |
/// | wxCONTROL_DISABLED | the control or item is disabled |
/// 
/// macOS shows group selection as combined round rectangle
/// ## Use group selection
/// | constant | meaning |
/// | -------- | -------- |
/// | wxCONTROL_SELECTION_GROUP | Apply the group selection logic |
/// 
/// ## Position in group
/// | constant | meaning |
/// | -------- | -------- |
/// | wxCONTROL_ITEM_FIRST | Top item with rounded corners in top |
/// | wxCONTROL_ITEM_LAST | Bottom item with rounded corners at the bottom|
/// | wxCONTROL_ITEM_FIRST\|wxCONTROL_ITEM_LAST | All four corners rounded |
/// | 0 | Middle element, no corners rounded |

  void drawItemSelectionRect( WxWindow win, WxDC dc, WxRect rect, { int flags = 0 } )
  {
    dc.setPen( wxTRANSPARENT_PEN );

    if (flags & wxCONTROL_FOCUSED != 0)
    {
      dc.setBrush( WxBrush( wxTheApp.getPrimaryAccentColour() ) );
      dc.drawRectangle(rect.x, rect.y+1, rect.width, rect.height-1 );
    } else {
      Color color = wxTheApp.isDark() ? Colors.grey[600]! : Colors.grey[400]!;
      dc.setBrush( WxBrush( WxColour( (color.r*255).floor(), (color.g*255).floor(), (color.b*255).floor()) ) );
      dc.drawRectangle(rect.x, rect.y+1, rect.width, rect.height-1 );
    } 

    if (flags & wxCONTROL_CURRENT != 0)
    {
      drawFocusRect(win, dc, rect, flags: flags );
    }
 }

/// Draw the header of a list control of dimensions [rect] in 
/// the window/control [win] using the [dc] to draw with.
/// 
/// Flags further specify the
/// state of the window/control and or element.
/// 
/// ## Flag styles
/// | constant | meaning |
/// | -------- | -------- |
/// | wxCONTROL_CURRENT | the mouse is currently over the element |
/// | wxCONTROL_SELECTED | the element is currently selected (for sorting, e.g.) |
/// | wxCONTROL_DISABLED | the control or item is disabled |
/// | wxCONTROL_SPECIAL | the fist element in the header |
/// | wxCONTROL_DIRTY | the last element in the header |
/// 
/// [sortArrow] flag
/// | constant | meaning |
/// | -------- | -------- |
/// | wxHDR_SORT_ICON_NONE | No sort arrow |
/// | wxHDR_SORT_ICON_UP | Sort arrow pointing up |
/// | wxHDR_SORT_ICON_DOWN | Sort arrow pointing down |
  int drawHeaderButton( WxWindow win, WxDC dc, WxRect rect, { int flags = 0, int sortArrow = 0 } )
  {
    dc.setPen( wxTheApp.isDark() ? wxGREY_PEN : wxLIGHT_GREY_PEN ); 
    dc.drawLine( rect.x+rect.width-1, 0, rect.x+rect.width-1, rect.height );

    dc.setPen( wxTRANSPARENT_PEN );
    if (sortArrow != 0) {
      dc.setBrush( WxBrush( wxTheApp.getAccentColour() ) );
      dc.drawRectangle(rect.x, rect.height-5, rect.width, 5);
    } else 
    if ((flags & wxCONTROL_CURRENT) != 0) {
      Color color = Colors.grey[400]!;
      dc.setBrush( WxBrush( WxColour( (color.r*255).floor(), (color.g*255).floor(), (color.b*255).floor()) ) );
      dc.drawRectangle(rect.x, rect.height-5, rect.width, 5);
    } 

    if (sortArrow != 0)
    {
      final bool up = (sortArrow == wxHDR_SORT_ICON_UP);
      final int rightBorder = 5;
      int border = 8;
      dc.setPen( wxTRANSPARENT_PEN );
      dc.setBrush( WxBrush( wxTheApp.getSecondaryAccentColour() ) );


      final List<WxPoint> points = [];
      int width = rect.height - 2 * border;
      if (up) {
        final int otherBorder = 8;
        border = 14;
        points.add( WxPoint( rect.x+rect.width - width ~/ 2 - rightBorder, rect.y+otherBorder) );
        points.add( WxPoint( rect.x+rect.width - rightBorder, rect.y+rect.height - border ) );
        points.add( WxPoint( rect.x+rect.width-width - rightBorder, rect.y+rect.height - border ) );
      } else {
        final int otherBorder = 12;
        border = 10;
        points.add( WxPoint( rect.x+rect.width - width ~/ 2 - rightBorder, rect.y+rect.height-otherBorder) );
        points.add( WxPoint( rect.x+rect.width - rightBorder, rect.y + border ) );
        points.add( WxPoint( rect.x+rect.width-width - rightBorder, rect.y + border ) );
      }
      dc.drawPolygon(points);
    }


    return 32;  // ??
  }

  int getHeaderButtonHeight( WxWindow win ) {
    return win.fromDIP( 28 );
  }

  int getHeaderButtonMargin( WxWindow win ) {
    return 0;
  }
}


