// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../wx_dart.dart';

// ------------------------- WxDataViewListStore ----------------------

/// Concrete implementation of a [WxDataViewModel] that stores tabular data.
/// 
/// Used internally by [WxDataViewListCtrl].

class WxDataViewListStore extends WxDataViewIndexListModel {
  WxDataViewListStore() : super( 0 );

  final List<List> _modelData = [];
  final List<String> _columns = [];

  @override
  dynamic getValueByRow( int row, int col ) {
    final List rowData = _modelData[row];
    return rowData[col];
  }

  @override
  bool setValueByRow( dynamic value, int row, int col) {
    final List rowData = _modelData[row];
    rowData[col] = value;
    return true;
  }

  @override
  bool setValue( dynamic value, WxDataViewItem item, int column ) {
    final List rowData = _modelData[ getRow( item ) ];
    rowData[column] = value;
    return true;
  }

  @override
  dynamic getValue( WxDataViewItem item, int column ) {
    final List rowData = _modelData[ getRow( item ) ];
    return rowData[column];
  }
}

// ------------------------- wxDataViewListCtrl ----------------------

/// Implementation of a [WxDataViewCtrl] using a [WxDataViewListStore].
/// 
/// This control (or rather its model) store the actual data itself and it provides
/// a simplified interface based on rows.
/// 
/// Here is an example of a [WxDataViewListCtrl] with three column. One with editable
/// text, one with a bitmap and one with a choice of three words text.
/// ```dart
///     // create control
///     final listctrl = WxDataViewListCtrl(this, -1, style: wxDV_MULTIPLE /*|wxDV_HORIZ_RULES|wxDV_VERT_RULES*/ );
/// 
///     // add columns
///     listctrl.appendTextColumn("Text", width: 120, mode: wxDATAVIEW_CELL_EDITABLE );
///     listctrl.appendBitmapColumn("Bitmap", width: 30);
///     listctrl.appendChoiceColumn("Choice", ["Hallo", "Ola", "Ciao"], width: 120);
/// 
///     // create 2 bitmaps for the second column
///     final b1 = WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.cloud_sync, WxSize(21,21), colour: wxGREY );
///     final b2 = WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.cloud_off, WxSize(21,21), colour: wxGREY );
///     final bitmap1 = b1.getBitmapFor(listctrl);
///     final bitmap2 = b2.getBitmapFor(listctrl);
/// 
///     // fill control with 20 items
///     for (int i = 0; i < 20; i++) {
///       listctrl.appendItem( [ "Row $i", i % 2 == 0 ? bitmap1 : bitmap2, "Ola"] );
///     }
/// 
///     // select the 10th item
///     listctrl.selectRow( 9 );
/// 
///     // delete the first
///     listctrl.deleteItem( 0 );
/// ```
///
/// Adding columns
/// * [appendTextColumn]
/// * [appendBitmapColumn]
/// * [appendToggleColumn]
/// * [appendProgressColumn]
/// * [appendChoiceColumn]
/// * [appendIconTextColumn]
/// * [appendColumnWithType]
/// * [prependColumnWithType]
/// * [insertColumnWithType]
///
/// Adding and removing rows
/// * [appendItem]
/// * [prependItem]
/// * [insertItem]
/// * [deleteItem]
/// * [deleteAllItems]
/// * [getItemCount]
///
/// Conversion between rows and items
/// * [rowToItem]
/// * [itemToRow]
///
/// Selection
/// * [selectRow]
/// * [unselectRow]
/// * [getSelectedRow]
/// * [isRowSelected]

class WxDataViewListCtrl extends WxDataViewCtrl {
  WxDataViewListCtrl( super.parent, super.id, { super.pos = wxDefaultPosition, super.size = wxDefaultSize, super.style = 0 } ) {
    _store = WxDataViewListStore();
    associateModel( _store );
  }

  late final WxDataViewListStore _store;

  /// Returns the [WxDataViewItem] for the [row]
  WxDataViewItem rowToItem( int row ) {
    return _store.getItem( row );
  }

  /// Returns the row index of [item]
  int itemToRow( WxDataViewItem item ) {
    return _store.getRow( item );
  }

  /// Selects the item in [row]
  void selectRow( int row ) {
    setCurrentItem( rowToItem(row) );
  }

  /// Unselects the item in [row]
  void unselectRow( int row ) {
    unselect( rowToItem(row) );
  }

  /// Returns the row index of the selected row
  int getSelectedRow() {
    return itemToRow( getSelection() );
  }

  /// Returns true if the row is selected
  bool isRowSelected( int row ) {
    return isSelected( rowToItem(row) );
  }

  /// Appends a new row with the data given in [values]
  void appendItem( List values ) {
    _store._modelData.add(values);
    _store.rowAppended();
  }

  /// Prepends a new row with the data given in [values]
  void prependItem( List values ) {
    _store._modelData.insert(0, values);
    _store.rowPrepended();
  }

  /// Inserts a new row with the data given in [values] at [pos]
  void insertItem( int pos, List values ) {
    _store._modelData.insert(pos, values);
    _store.rowInserted( pos );
  }

  /// Deletes the [row]
  void deleteItem( int row ) {
    _store._modelData.removeAt( row );
    _store.rowDeleted( row );
  }

  /// Deletes all items (= all rows)
  void deleteAllItems( ) {
    _store._modelData.clear();
    _store.cleared();
  }

  /// Returns the number of rows in the control (and its model)
  int getItemCount( ) {
    return _store._modelData.length;
  }

  /// Sets the value in [row],[col]
  void setValue( dynamic value, int row, int col ) {
    final dataRow = _store._modelData[ row ];
    dataRow[col] = value;
    _store.rowChanged(row);
  }

  /// Returns the value in [row],[col]
  dynamic getValue( int row, int col ) {
    return _store.getValueByRow( row, col);
  }

  /// Appends a [column] to contain data of type [variantType]
  void appendColumnWithType( WxDataViewColumn column, { String variantType = 'string' } ) {
    _store._columns.add( variantType );
    appendColumn(column);
  }

  /// Prepends a [column] to contain data of type [variantType]
  void prependColumnWithType( WxDataViewColumn column, { String variantType = 'string' } ) {
    _store._columns.insert( 0, variantType );
    prependColumn(column);
  }

  /// Inserts a [column] to contain data of type [variantType] at [pos]
  void insertColumnWithType( int pos, WxDataViewColumn column, { String variantType = 'string' } ) {
    _store._columns.insert( 0, variantType );
    insertColumn(pos, column);
  }

  /// Appends text column
  void appendTextColumn( String label, { int mode = wxDATAVIEW_CELL_EDITABLE, int width = wxCOL_WIDTH_DEFAULT, int align = wxALIGN_LEFT, int flags = wxDATAVIEW_COL_RESIZABLE } ) {
    _store._columns.add( "string" );
    final renderer = WxDataViewTextRenderer( mode: mode );
    final dvc = WxDataViewColumn(label, renderer, getColumnCount(), width: width, alignment: align, flags: flags );
    appendColumn( dvc );
  }

  /// Appends bitmap column
  void appendBitmapColumn( String label, { int mode = wxDATAVIEW_CELL_INERT, int width = wxCOL_WIDTH_DEFAULT, int align = wxALIGN_LEFT, int flags = wxDATAVIEW_COL_RESIZABLE } ) {
    _store._columns.add( "bitmap" );
    final renderer = WxDataViewBitmapRenderer( mode: mode );
    final dvc = WxDataViewColumn(label, renderer, getColumnCount(), width: width, alignment: align, flags: flags );
    appendColumn( dvc );
  }

  /// Appends toggle column
  void appendToggleColumn( String label, { int mode = wxDATAVIEW_CELL_ACTIVATABLE, int width = wxCOL_WIDTH_DEFAULT, int align = wxALIGN_LEFT, int flags = wxDATAVIEW_COL_RESIZABLE } ) {
    _store._columns.add( "bool" );
    final renderer = WxDataViewToggleRenderer( mode: mode );
    final dvc = WxDataViewColumn(label, renderer, getColumnCount(), width: width, alignment: align, flags: flags );
    appendColumn( dvc );
  }

  /// Appends progress column
  void appendProgressColumn( String label, { int mode = wxDATAVIEW_CELL_INERT, int width = wxCOL_WIDTH_DEFAULT, int align = wxALIGN_LEFT, int flags = wxDATAVIEW_COL_RESIZABLE } ) {
    _store._columns.add( "long" );
    final renderer = WxDataViewProgressRenderer( mode: mode );  
    final dvc = WxDataViewColumn(label, renderer, getColumnCount(), width: width, alignment: align, flags: flags );
    appendColumn( dvc );
  }

  /// Appends choice column
  void appendChoiceColumn( String label, List<String> choices,{ int mode = wxDATAVIEW_CELL_EDITABLE, int width = wxCOL_WIDTH_DEFAULT, int align = wxALIGN_LEFT, int flags = wxDATAVIEW_COL_RESIZABLE } ) {
    _store._columns.add( "long" );
    final renderer = WxDataViewChoiceRenderer( choices, mode: mode );  
    final dvc = WxDataViewColumn(label, renderer, getColumnCount(), width: width, alignment: align, flags: flags );
    appendColumn( dvc );
  }

  /// Appends icon+text column
  void appendIconTextColumn( String label, { int mode = wxDATAVIEW_CELL_INERT, int width = wxCOL_WIDTH_DEFAULT, int align = wxALIGN_LEFT, int flags = wxDATAVIEW_COL_RESIZABLE } ) {
    _store._columns.add( (WxDataViewIconTextData).toString() );
    final renderer = WxDataViewIconTextRenderer();  
    final dvc = WxDataViewColumn(label, renderer, getColumnCount(), width: width, alignment: align, flags: flags );
    appendColumn( dvc );
  }
}
