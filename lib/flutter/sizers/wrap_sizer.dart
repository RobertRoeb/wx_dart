// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxWrapSizer ----------------------

const int wxREMOVE_LEADING_SPACES = 2;

/// This sizer wraps the child items when there is not 
/// enough space horizontally. Typically used on small
/// devices when only scrolling vertically is the norm.

class WxWrapSizer extends WxBoxSizer {
  WxWrapSizer( { int orient = wxHORIZONTAL, int flags = wxREMOVE_LEADING_SPACES } ) : super( orient ) {
    _flags = flags;
  }

  late int _flags; 

  @override
  Widget _build(BuildContext context, WxWindow owner) {

    final wrap = Wrap( 
      // runAlignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      direction: _orientation == wxVERTICAL ? Axis.vertical : Axis.horizontal,
      children: [],
    );

    for (WxSizerItem item in _items) {

        late Widget finalWidget;

          if (item._kind == WxSizerKind.window) {
            if (!item._window!.isShown()) continue;
            finalWidget = item._window!._build( context );
            WxSize size = item._window!.getMinSize();
            if ((size.x != -1) || (size.y != -1)) {
              finalWidget = SizedBox(
                width: (size.x != -1) ? size.x.toDouble() : null,
                height: (size.y != -1) ? size.y.toDouble() : null,
                child: finalWidget
              );
            }
          } else 
          if (item._kind == WxSizerKind.sizer) {
            finalWidget = item._sizer!._build(context, owner);
          } else {
            item._spacerParentWindow = owner;
            finalWidget = ReportSize( 
                key: item._spacerWidgetKey,
              child: SizedBox(height: item._height.toDouble()), 
              onSizeChange: (size) {
                item.spacerSize = WxSize(size.width.floor(),size.height.floor());
              }
            );
          }

          if (((item._flag & wxALL) != 0) && (item._border != 0)) {
            final double b = item._border.toDouble();
            Padding padding = Padding(padding: 
              EdgeInsetsGeometry.fromLTRB(
                (item._flag & wxLEFT) == 0 ? 0 : b, 
                (item._flag & wxTOP) == 0 ? 0 : b, 
                (item._flag & wxRIGHT) == 0 ? 0 : b, 
                (item._flag & wxBOTTOM) == 0 ? 0 : b), 
              child: finalWidget);
            finalWidget = padding;
          }

        wrap.children.add( finalWidget );
    }

    return ReportSize( child: wrap, 
          onSizeChange: (size) {
            _setSizeInternal( WxSize(size.width.floor(),size.height.floor()) );
          } 
        );
  }
}
