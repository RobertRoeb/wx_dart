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
/// Growable row interface
/// * [addGrowableRow]
/// * [removeGrowableRow]
/// * [isRowGrowable]
///
/// Flexible direction
/// * [setFlexibleDirection]
/// * [getFlexibleDirection]
/// * [setNonFlexibleGrowMode]
/// * [getNonFlexibleGrowMode]
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

  /// index -> proportion
  final Map<int, int> _growableCols = {};
  /// index -> proportion
  final Map<int, int> _growableRows = {};
  int _flexibleDirection = wxBOTH;
  int _nonFlexibleGrowMode = wxFLEX_GROWMODE_SPECIFIED;

  /// Makes the column at [index] growable: if the sizer gets more space
  /// than it needs, growable columns share the extra width according to
  /// their [proportion] (all equally if all proportions are 0).
  void addGrowableCol( int index, { int proportion = 0 } ) {
    _growableCols[index] = proportion;
  }

  /// Makes the row at [index] growable: if the sizer gets more space
  /// than it needs, growable rows share the extra height according to
  /// their [proportion] (all equally if all proportions are 0).
  ///
  /// In wxDart Flutter, the sizer only gets more height than it needs if
  /// it is in a sizer with a proportion > 0 (or wxEXPAND in a [WxRow]),
  /// otherwise Flutter gives it an unbounded height.
  void addGrowableRow( int index, { int proportion = 0 } ) {
    _growableRows[index] = proportion;
  }

  /// Remove the column from the flexible columns.
  void removeGrowableCol( int index ) {
    _growableCols.remove( index );
  }

  /// Remove the row from the flexible rows.
  void removeGrowableRow( int index ) {
    _growableRows.remove( index );
  }

  /// Returns true of column at [index] is growable
  bool isColGrowable( int index ) {
    return _growableCols.containsKey( index );
  }

  /// Returns true of row at [index] is growable
  bool isRowGrowable( int index ) {
    return _growableRows.containsKey( index );
  }

  /// Sets in which direction the growable rows and columns grow according
  /// to their proportion: wxVERTICAL (rows), wxHORIZONTAL (columns) or
  /// wxBOTH (default). In the other direction, [setNonFlexibleGrowMode]
  /// decides.
  void setFlexibleDirection( int direction ) {
    _flexibleDirection = direction;
  }

  /// Returns the flexible direction, see [setFlexibleDirection]
  int getFlexibleDirection( ) {
    return _flexibleDirection;
  }

  /// Sets how rows or columns grow in the non-flexible direction (see
  /// [setFlexibleDirection]):
  ///
  /// | constant | meaning |
  /// | -------- | -------- |
  /// | wxFLEX_GROWMODE_NONE | they don't grow |
  /// | wxFLEX_GROWMODE_SPECIFIED | growable ones grow equally (default) |
  /// | wxFLEX_GROWMODE_ALL | all grow equally |
  void setNonFlexibleGrowMode( int mode ) {
    _nonFlexibleGrowMode = mode;
  }

  /// Returns the grow mode in the non-flexible direction, see [setNonFlexibleGrowMode]
  int getNonFlexibleGrowMode( ) {
    return _nonFlexibleGrowMode;
  }

  @override
  Widget _build(BuildContext context, WxWindow owner)
  {
    _newItems.clear(); // only used in WxGridSizer

    final cols = getEffectiveColsCount();
    final cellCount = getEffectiveRowsCount() * cols;
    final children = <Widget>[];
    final flags = <int>[];
    for (int index = 0; index < cellCount; index++) {
      if (index < _items.length) {
        children.add( _wxBuildGridCell( context, owner, _items[index] ) );
        flags.add( _items[index]._flag );
      } else {
        children.add( const SizedBox.shrink() );
        flags.add( 0 );
      }
    }

    final grid = _WxGridLayout(
      cols: cols,
      flags: flags,
      hgap: getHGap().toDouble(),
      vgap: getVGap().toDouble(),
      growableCols: Map.of( _growableCols ),
      growableRows: Map.of( _growableRows ),
      flexibleDirection: _flexibleDirection,
      nonFlexibleGrowMode: _nonFlexibleGrowMode,
      children: children,
    );

    return ReportSize( child: grid,
          onSizeChange: (size) {
            _setSizeInternal( WxSize(size.width.floor(),size.height.floor()) );
          }
        );
  }
}
