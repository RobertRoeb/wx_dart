// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxFlexGridSizer ----------------------

/// Lays out child controls in a grid of columns and rows. You can specify
/// which columns can grow (if the parent is resizable).
/// 
/// If the sizer is in a resizeable parent (such as a [WxFrame] on most
/// desktops screens) then you want to specify which of the columns may
/// grow in response to the parent growing using [addGrowableCol].
/// 
/// Only wxDart Native also lets you specify which rows can grow
/// using [addGrowableRow].
/// 
/// Adding items
/// * [add]
/// * [addSizer]
/// * [addSpacer]
/// * [addStretchSpacer]
/// * [insert]
/// * [insertSizer]
/// * [insertSpacer]
/// * [insertStretchSpacer]
/// * [prepend]
/// * [prependSizer]
/// * [prependSpacer]
/// * [prependStretchSpacer]
/// 
/// Handling of child items
/// * [getItemCount]
/// * [getItem]
/// * [getSizerItem]
/// * [getWindowItem]
/// 
/// Removing (but not deleting) items
/// * [remove]
/// * [removeWindow]
/// * [removeSizer]
/// 
/// Growable column interface
/// * [addGrowableCol]
/// * [removeGrowableCol]
/// * [isColGrowable]
/// 
/// Growable row interface (wxDart Native only)
/// * [addGrowableRow]
/// * [removeGrowableRow]
/// * [isRowGrowable]
/// 
/// Gaps and layout
/// * [getEffectiveColsCount]
/// * [getEffectiveRowsCount]
/// * [setVGap]
/// * [getVGap]
/// * [setHGap]
/// * [getHGap]
/// 
/// Size and position
/// * [getSize]
/// * [getPosition]
/// * [layout]
/// 
/// Example:
///```dart
/// class MyDialog extends WxDialog {
///   MyDialog( super.parent, super.id, super.title ) 
///   {
///     // create main sizer 
///     final mainSizer = WxColumn();
///
///     /// create flex grid sizer with 3 columns
///     final grid = WxFlexGridSizer(3 /*,vgap: 5, hgap: 5*/);
///     mainSizer.addSizer(grid, flag: wxEXPAND );
/// 
///     // add controls, first row
///     grid.add( WxStaticText(parent, -1, "Short label:"), flag: wxALL|wxALIGN_RIGHT, border: 5 );
///     grid.addSpacer( 20);
///     grid.add( WxTextCtrl(parent, -1, size: WxSize(250,-1)), flag: wxALL, border: 5 );
/// 
///     // add controls, second row
///     grid.add( WxStaticText(parent, -1, "Very very long label:"), flag: wxALL|wxALIGN_RIGHT, border: 5 );
///     grid.addSpacer( 20);
///     grid.add( WxTextCtrl(parent, -1, size: WxSize(250,-1)), flag: wxALL, border: 5 );
/// 
///     // create OK and Cancel buttons
///     final buttons = createStdDialogButtonSizer( wxOK|wxCANCEL );
/// 
///     // add button sizer to main sizer
///     mainSizer.addSizer( buttons, flag: wxALL|wxALIGN_RIGHT );
/// 
///     // Tell dialog to actually use the main sizer and to use it
///     // to determine the initial size
///     setSizerAndFit( mainSizer );
/// 
///     // Centre the dialog on the parent window 
///     centreOnParent();
///   }
/// }
/// dart````

class WxFlexGridSizer extends WxGridSizer {
  /// Creates a [WxFlexGridSizer] with the given number of column and optional gap between items.
  WxFlexGridSizer( super.cols, { super.vgap = 0, super.hgap = 0 } );

  final List<int> _growableColumns = [];
/*
  final List<int> _growableRows = [];
  int _growableHeight = -1;
  int _totalVerticalProportion = 0;  // TODO assume all have proportion 1 for now
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

/*
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
*/

  /// Adds the col at [index] to the growable columns.
  void addGrowableCol( int index, { int proportion = 0 } ) {
    _growableColumns.add( index );
  }

  /// Adds the row at [index] to the growable rows.
  /// 
  /// Currently wxDart Native only.
  void addGrowableRow( int index, { int proportion = 0 } ) {
  /*
    _growableRows.add( index );
    _totalVerticalProportion = _growableRows.length; // assume all have proportion 1 for now
  */
  }

  /// Remove the column from the flexible columns.
  void removeGrowableCol( int index ) {
    _growableColumns.removeWhere( (item) => item == index );
  }

  /// Remove the row from the flexible rows.
  /// 
  /// Currently wxDart Native only.
  void removeGrowableRow( int index ) {
  /*
    _growableRows.removeWhere( (item) => item == index );
    _totalVerticalProportion = _growableRows.length; // assume all have proportion 1 for now
  */
  }

  /// Returns the flexible direction. 
  /// 
  /// Currently wxDart Native only.
  int getFlexibleDirection( ) {
    return wxVERTICAL;
  }

  /// Sets the non-flexibel grow mode.
  /// 
  /// Currently wxDart Native only.
  void setNonFlexibleGrowMode( int mode ) {
  }

  /// Returns true of column at [index] is growable
  bool isColGrowable( int index ) {
    return _growableColumns.contains(index);
  }

  /// Returns true of row is growable. Currently always returns false
  /// in wxDart Flutter.
  bool isRowGrowable( int index ) {
    return false;
  /*
    return _growableRows.contains(index);
  */
  }

  @override
  Widget _build(BuildContext context, WxWindow owner)
  {
    _newItems.clear(); // only used in WxGridSizer

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
                item._spacerSize = WxSize(size.width.floor(),size.height.floor());
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
      defaultColumnWidth: IntrinsicColumnWidth(),
      children: rows,
    );

    return ReportSize( child: table, 
          onSizeChange: (size) {
            _setSizeInternal( WxSize(size.width.floor(),size.height.floor()) );
          } 
        );
  }
}

