// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxFlexGridSizer ----------------------

/// Lays out child controls in a grid of columns and rows. You can specify which
/// columns can grow. Only wxDart Native also lets you specify which rows can grow.

class WxFlexGridSizer extends WxGridSizer {
  WxFlexGridSizer( super.cols, { super.vgap = 0, super.hgap = 0 } );

  final List<int> _growableColumns = [];
  final List<int> _growableRows = [];
  int _growableHeight = -1;
  int _totalVerticalProportion = 0;  // TODO assume all have proportion 1 for now


/*
          if ((item.flag & wxEXPAND) != 0) {
            if (item.kind == WxSizerKind.window) {
              if (item.window!._initialSize.x != -1) {
                item.window!._initialSize = WxSize( -1, item.window!._initialSize.y );
                wxTheApp._setState();
              }
            }

*/

  @override
  WxSizerItem add( WxWindow window, { int proportion = 0, int flag = 0, int border = 0 } ) {
    if ((flag & wxEXPAND) != 0) {
      window._initialSize = WxSize( -1, window._initialSize.y );
    }
    return super.add( window, proportion: proportion, flag: flag, border: border );
  }

  @override
  WxSizerItem prepend( WxWindow window, { int proportion = 0, int flag = 0, int border = 0 } ) {
    if ((flag & wxEXPAND) != 0) {
      window._initialSize = WxSize( -1, window._initialSize.y );
    }
    return super.prepend( window, proportion: proportion, flag: flag, border: border );
  }

  @override
  WxSizerItem insert( int index, WxWindow window, { int proportion = 0, int flag = 0, int border = 0 } ) {
    if ((flag & wxEXPAND) != 0) {
      window._initialSize = WxSize( -1, window._initialSize.y );
    }
    return super.insert( index, window, proportion: proportion, flag: flag, border: border );
  }

  void distributeHeightAmongGrowableRows( int totalHeight ) {
    for (int i = 0; i < getEffectiveRowsCount(); i++) {
      if (isRowGrowable(i)) continue;
      final item = _items[i*getEffectiveColsCount()];
      final size = item.getSize();
      totalHeight -= size.y;
    }
    if (_growableHeight != totalHeight) {
      _growableHeight = totalHeight;      
      wxTheApp._setState();  // this doesn't currently work if the frame is growing
    }
  }

  void addGrowableCol( int index, { int proportion = 0 } ) {
    _growableColumns.add( index );
  }

  void addGrowableRow( int index, { int proportion = 0 } ) {
    _growableRows.add( index );
    _totalVerticalProportion = _growableRows.length; // assume all have proportion 1 fo rnow
  }

  void removeGrowableCol( int index ) {
    _growableColumns.removeWhere( (item) => item == index );
  }

  void removeGrowableRow( int index ) {
    _growableRows.removeWhere( (item) => item == index );
    _totalVerticalProportion = _growableRows.length; // assume all have proportion 1 fo rnow
  }

  int getFlexibleDirection( ) {
    return wxVERTICAL;
  }

  void setNonFlexibleGrowMode( int mode ) {
  }

  bool isColGrowable( int index ) {
    return _growableColumns.contains(index);
  }

  bool isRowGrowable( int index ) {
    return _growableRows.contains(index);
  }

  @override
  Widget _build(BuildContext context, WxWindow owner) {
    
    Map<int, TableColumnWidth> columnWidths = {};
    for (int col = 0; col < getEffectiveColsCount(); col++) {
      if (isColGrowable(col)) {
        columnWidths[col] = FlexColumnWidth();
      } else {
        columnWidths[col] = IntrinsicColumnWidth();
      }
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
          if ((item._flag & wxEXPAND) != 0) {
            halignment = 0.0; // probably doesn't matter as it fills out anyways
          } else {
            if ((item._flag & wxALIGN_CENTER_HORIZONTAL) != 0) {
              halignment = 0.0;
            } else 
            if ((item._flag & wxALIGN_RIGHT) != 0) {
              halignment = 1.0;
            }
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

          // test here again like at add/prepend/insert just in case
          // the initialSize was set again.
          if ((item._flag & wxEXPAND) != 0) {
            if (item._kind == WxSizerKind.window) {
              if (item._window!._initialSize.x != -1) {
                item._window!._initialSize = WxSize( -1, item._window!._initialSize.y );
                wxTheApp._setState();
              }
            }
          }

          if ((getHGap() != 0) || (getVGap() != 0)) {
              finalWidget = Padding(
                padding: EdgeInsetsGeometry.symmetric( vertical: getVGap() / 2, horizontal: getHGap() / 2 ),
                child: finalWidget);
          }
        }

        /*if (isRowGrowable(i)) {
          if ((_totalVerticalProportion == 0) || (_growableHeight <= 0)) {
            finalWidget = SizedBox( 
              height: 80,
              child: finalWidget,
            );
          } else {
            double proportion = _totalVerticalProportion / _growableRows.length;
            print( "new height ${(_growableHeight * proportion).floor()}" );
            finalWidget = SizedBox( 
              height: _growableHeight * proportion,
              child: finalWidget,
            );
          }
        } */

        finalWidget = TableCell( verticalAlignment: TableCellVerticalAlignment.intrinsicHeight, child: finalWidget);

        row.children.add( finalWidget );
        
      }
      rows.add(row);
    }

    Table table = Table(
      columnWidths: _growableColumns.isEmpty ? null : columnWidths,
      children: rows,
    );

    return ReportSize( child: table, 
          onSizeChange: (size) {
            _setSizeInternal( WxSize(size.width.floor(),size.height.floor()) );
          } 
        );
  }
}

