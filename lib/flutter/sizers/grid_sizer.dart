// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxGridSizer ----------------------

/// This sizer puts the child items into cells of equal size. This
/// is only supported in wxDart Native. In wxDart Flutter this behaves
/// like a [WxFlexGridSizer].

class WxGridSizer extends WxSizer {
  WxGridSizer( int cols, { int vgap = 0, int hgap = 0 } ) {
    _cols = cols;
    _vgap = vgap;
    _hgap = hgap;
  }

  late int _cols;
  late int _vgap;
  late int _hgap;

  int getEffectiveColsCount( ) {
    return _cols;
  }

  int getEffectiveRowsCount( ) {
    int count = (_items.length / _cols).floor();
    if (_items.length % _cols != 0) {
      count ++;
    }
    return count;
  }

  void setVGap( int vgap) {
    _vgap = vgap;
  }

  int getVGap() {
    return _vgap;
  }

  void setHGap( int hgap) {
    _hgap = hgap;
  }

  int getHGap() {
    return _hgap;
  }

  @override
  Widget _build(BuildContext context, WxWindow owner) {
    Map<int, TableColumnWidth> columnWidths = {};
    for (int col = 0; col < getEffectiveColsCount(); col++) {
        columnWidths[col] = FlexColumnWidth();
    }

    List<TableRow> rows = [];
    for (int i = 0; i < getEffectiveRowsCount(); i++) {
      TableRow row = TableRow( children: [] );
      for (int j = 0; j < getEffectiveColsCount(); j++) {
        int index = i * getEffectiveColsCount() + j;

        late Widget finalWidget;

        if (index >= _items.length) {
          finalWidget = SizedBox();
        } else {
          WxSizerItem item = _items[index];
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

          double halignment = -1.0;
          if ((item._flag & wxALIGN_CENTER_HORIZONTAL) != 0) {
            halignment = 0.0;
          } else 
          if ((item._flag & wxALIGN_RIGHT) != 0) {
            halignment = 1.0;
          }

          double valignment = -1.0;
          if ((item._flag & wxALIGN_CENTER_VERTICAL) != 0) {
            valignment = 0.0;
          } else 
          if ((item._flag & wxALIGN_BOTTOM) != 0) {
            valignment = 1.0;
          }

          finalWidget = Align( 
              alignment: Alignment(halignment, valignment),
              child: finalWidget
            );

          if ((getHGap() != 0) || (getVGap() != 0)) {
              finalWidget = Padding(
                padding: EdgeInsetsGeometry.symmetric( vertical: getVGap() / 2, horizontal: getHGap() / 2 ),
                child: finalWidget);
          }
        }

        finalWidget = TableCell( verticalAlignment: TableCellVerticalAlignment.intrinsicHeight, child: finalWidget);

        row.children.add( finalWidget );
        
      }
      rows.add(row);
    }

    Table table = Table(
      columnWidths: columnWidths,
      children: rows,
    );

    return ReportSize( child: table, 
          onSizeChange: (size) {
            _setSizeInternal( WxSize(size.width.floor(),size.height.floor()) );
          } 
        );
  }
}
