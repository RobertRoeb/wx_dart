// ---------------------------------------------------------------------------
// Name:        datamodel.dart
// Name:        src/generic/datavgen.cpp (wxWidgets C++)
// Purpose:     wxDataViewCtrl generic implementation
// Author:      Robert Roebling
// Modified by: Francesco Montorsi, Guru Kathiresan, Bo Yang
// Copyright:   (c) 1998 Robert Roebling (C++ version)
// Copyright:   (c) 2026 Robert Roebling (Dart version)
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../wx_dart.dart';

// ------------------- wxDataViewModelNotifier -------------------

/// One or more instances of this class need to be added to a  
/// [WxDataViewModel] using [WxDataViewModel.addNotifier]. The
/// model then informs all notifiers about changes in the model
/// so that e.g. a specific display of the data can be updated.

abstract class WxDataViewModelNotifier
{
  WxDataViewModelNotifier( this._owner );

  WxDataViewModel _owner;

  /// Returns owning model
  WxDataViewModel getOwner() {
    return _owner;
  }

  /// Set owning model
  void setOwner( WxDataViewModel owner ) {
    _owner = owner;
  }

  /// Gets called when all data is cleared and should be re-read
  bool cleared();

  /// Gets called when an item has been added 
  bool itemAdded( WxDataViewItem parent, WxDataViewItem item );

  /// Gets called when an item has been changed
  bool itemChanged( WxDataViewItem item );

  /// Gets called when an item has been deleted 
  bool itemDeleted( WxDataViewItem parent, WxDataViewItem item );
  
  /// Gets called when an item's value has been changed
  bool valueChanged( WxDataViewItem item, int column );

  /// Gets called when data is being resorted (TBD)
  void resort() { 
  }

  /// Plural form of [itemAdded]. By default iterates over child items.
  bool itemsAdded( WxDataViewItem parent, List<WxDataViewItem> items ) {
    final count = items.length;
    for (int i = 0; i < count; i++) {
        if (!itemAdded( parent, items[i] )) return false;
    }
    return true;
  }

  /// Plural form of [itemChanged]. By default iterates over items.
  bool itemsChanged( List<WxDataViewItem> items ) {
    final count = items.length;
    for (int i = 0; i < count; i++) {
        if (!itemChanged( items[i] )) return false;
    }
    return true;
  }

  /// Plural form of [itemDeleted]. By default iterates over items.
  bool itemsDeleted( WxDataViewItem parent, List<WxDataViewItem> items ) {
    final count = items.length;
    for (int i = 0; i < count; i++) {
        if (!itemDeleted( parent, items[i] )) return false;
    }
    return true;
  }
}

// ------------------- wxDataViewModel -------------------

/// Helper class that allows adding attributes to a [WxDataViewModel] item
/// by overriding [WxDataViewModel.getAttr].

class WxDataViewItemAttr
{
  const WxDataViewItemAttr( this._colour, this._font, this._backgroundColour, { this.hMargin=0, this.vMargin=0} );
  final WxColour? _colour;
  final WxFont? _font;
  final WxColour? _backgroundColour;
  final int vMargin;
  final int hMargin;

  /// Returns font if one has been set, or null
  WxFont? getFont() {
    return _font;
  }
  /// Returns true if font has been set
  bool hasFont() {
    return _font != null;
  }

  /// Returns colour if one has been set, or null
  WxColour? getColour() {
    return _colour;
  }

  /// Returns true if colour has been set
  bool hasColour() {
    return _colour != null;
  }

  /// Returns background colour if one has been set, or null
  WxColour? getBackgroundColour() {
    return _backgroundColour;
  }

  /// Return true if background colour has been set
  bool hasBackgroundColour() {
    return _backgroundColour != null;
  }

  /// Return margins around item
  WxSize getMargins() {
    return WxSize( hMargin, vMargin );
  }
}

/// wxDataViewModel is the base class for all data models to be displayed by a [WxDataViewCtrl].
/// All other models derive from it and must implement its pure virtual functions in order 
/// to define a complete data model. In detail, you need to override 
/// * [WxDataViewModel.isContainer]
/// * [WxDataViewModel.getParent]
/// * [WxDataViewModel.getChildren] and
/// * [WxDataViewModel.getValue]
/// 
/// in order to define the data model which acts as an interface
/// between your actual data and the [WxDataViewCtrl].
/// 
/// Note that WxDataViewModel does not define the position or index of any item in the control
/// because different controls might display the same data differently. 
/// 
/// (Note: sorting in wxDart is work in progress) WxDataViewModel does/will
/// provide a [WxDataViewModel.compare] method which the [WxDataViewCtrl] may use to sort the
/// data either in conjunction with a column header or without (see [WxDataViewModel.hasDefaultCompare]).
/// 
/// WxDataViewModel (as indeed the entire WxDataViewCtrl code) is using _dynamic_ to store data and
/// its type in a generic way. 
/// 
/// Since you will usually allow the [WxDataViewCtrl] to change your data through its graphical
/// interface, you will also have to override [WxDataViewModel.setValue] which the wxDataViewCtrl
/// will call when a change to some data has been committed.
/// 
/// If the data represented by the model is changed by something else than its associated
/// [WxDataViewCtrl], the control has to be notified about the change. Depending on what happened
/// you need to call one of the following methods:
/// 
/// * [WxDataViewModel.valueChanged]
/// * [WxDataViewModel.itemAdded]
/// * [WxDataViewModel.itemDeleted]
/// * [WxDataViewModel.itemChanged]
/// * [WxDataViewModel.cleared]
/// 
/// There are plural forms for notification of addition, change or removal of several item at once. See:
/// 
/// * [WxDataViewModel.itemsAdded],
/// * [WxDataViewModel.itemsDeleted],
/// * [WxDataViewModel.itemsChanged].
/// 
/// Note that [WxDataViewModel.cleared] can be called for all changes involving many, or all, of the model
/// items and not only for deleting all of them (i.e. clearing the model).
/// 
/// This class maintains a list of [WxDataViewModelNotifier] which link this class to the specific
/// implementations on the supported platforms so that e.g. calling [WxDataViewModel.valueChanged]
/// on this model will just call [WxDataViewModelNotifier.valueChanged] for each notifier that has
/// been added. You can also add your own notifier in order to get informed about any changes to
/// the data in the list model.
/// 
/// WxDataViewModel can define both tree like data as well as list of items. For the case
/// of lists, a specialized abstract class [WxDataViewListModel] lets you define an interface
/// between rows in your data and an [WxDataViewItem] and the still abstract [WxDataViewVirtualListModel]
/// does that using the index of the row.
/// 
/// wxDart provides the following concrete models apart from the abstract base models: 
/// [WxDataViewTreeStore], [WxDataViewListStore] and [WxDataViewBookStore].

abstract class WxDataViewModel
{
  final List<WxDataViewModelNotifier> _notifiers = [];

  // main interface describing the model

  /// Override this so the control can query the child items of [item].
  List<WxDataViewItem> getChildren( WxDataViewItem item );

  /// Override this to indicate which [WxDataViewItem] representing the parent of
  /// [item] or an invalid [WxDataViewItem] if the root item is the parent item.
  WxDataViewItem getParent( WxDataViewItem item );

  /// Override this to indicate if [item] is a container, i.e. if it can have child items.
  bool isContainer( WxDataViewItem item ); 

  /// Override this to return the value to be shown for the specified [item] in the given [column]. The value
  /// returned must have the appropriate type, e.g. String for the text columns.
  /// 
  /// May return null indicating that there is not data.
  dynamic getValue( WxDataViewItem item, int column );

  // the rest

  /// Override to give a [WxDataViewItemAttr] to a specific [item] or
  /// return null for default font attributes
  WxDataViewItemAttr? getAttr( WxDataViewItem item, int col) {
    return null;
  }

  void addNotifier( WxDataViewModelNotifier notifier ) {
    _notifiers.add( notifier );
  }

  void removeNotifier( WxDataViewModelNotifier notifier ) {
    _notifiers.remove( notifier );
  }

  /// override in case class if this is a index based list model
  bool isListModel() {
    return false;
  }

  /// override in case class if this is a index based virtual list model
  bool isVirtualListModel() {
    return false;
  }

  /// TBD
  bool hasDefaultCompare() {
    return false;
  }

  /// TBD
  int compare( WxDataViewItem item1, WxDataViewItem item2, int column, bool ascending ) {
    return 0;
  }

  /// Override to return false if an item is disabled
  bool isEnabled( WxDataViewItem item, int column ) {
    return true;
  }

  /// Returns true if specified field (item and colunmn) contains data
  bool hasValue( WxDataViewItem item, int column ) {
    return column == 0 || !isContainer(item) || hasContainerColumns(item);
  }

  /// Override this method to indicate if a container item merely acts as a headline 
  bool hasContainerColumns( WxDataViewItem item ) {
    return false;
  }

  /// Called by the [WxDataViewCtrl] or your own code to commit new
  /// data to the model
  bool setValue( dynamic value, WxDataViewItem item, int column ) {
    return false;
  }

  // Change the value of the given item and update the control to reflect it
  bool changeValue( dynamic value, WxDataViewItem item, int column ) {
    if (setValue(value, item, column)) {
      valueChanged(item, column);
    }
    return false;
  }

  /// Called to inform the model that all of its data has been changed.
  bool cleared() { 
    for (WxDataViewModelNotifier notifier in _notifiers) {
      notifier.cleared();
    }
    return true;
  }

  /// Resorts data (TBD)
  void resort() { 
    for (WxDataViewModelNotifier notifier in _notifiers) {
      notifier.resort();
    }
  }

  /// Inform all notifiers that an item has been added to the model
  /// and allow an the associated [WxDataViewCtrl] to update the display 
  bool itemAdded( WxDataViewItem parent, WxDataViewItem item ) {
    bool ret = true;
    for (WxDataViewModelNotifier notifier in _notifiers) {
      if (!notifier.itemAdded(parent,item)) ret = false;
    }
    return ret;
  }

  /// Inform all notifiers that items have been added to the model
  /// and allow an the associated [WxDataViewCtrl] to update the display 
  bool itemsAdded( WxDataViewItem parent, List<WxDataViewItem> items ) {
    bool ret = true;
    for (WxDataViewModelNotifier notifier in _notifiers) {
      if (!notifier.itemsAdded(parent,items)) ret = false;
    }
    return ret;
  }

  /// Inform all notifiers that an item has been changed
  /// and allow an the associated [WxDataViewCtrl] to update the display 
  bool itemChanged( WxDataViewItem item ) {
    bool ret = true;
    for (WxDataViewModelNotifier notifier in _notifiers) {
      if (!notifier.itemChanged(item)) ret = false;
    }
    return ret;
  }

  /// Inform all notifiers that items have been changed
  /// and allow an the associated [WxDataViewCtrl] to update the display 
  bool itemsChanged( List<WxDataViewItem> items ) {
    bool ret = true;
    for (WxDataViewModelNotifier notifier in _notifiers) {
      if (!notifier.itemsChanged(items)) ret = false;
    }
    return ret;
  }

  /// Inform all notifiers that an item has been deleted
  /// and allow an the associated [WxDataViewCtrl] to update the display 
  bool itemDeleted( WxDataViewItem parent, WxDataViewItem item ) {
    bool ret = true;
    for (WxDataViewModelNotifier notifier in _notifiers) {
      if (!notifier.itemDeleted(parent,item)) ret = false;
    }
    return ret;
  }

  /// Inform all notifiers that an items have been deleted
  /// and allow an the associated [WxDataViewCtrl] to update the display 
  bool itemsDeleted( WxDataViewItem parent, List<WxDataViewItem> items ) {
    bool ret = true;
    for (WxDataViewModelNotifier notifier in _notifiers) {
      if (!notifier.itemsDeleted(parent,items)) ret = false;
    }
    return ret;
  }

  /// Inform all notifiers that the value of an item has been changed
  /// and allow an the associated [WxDataViewCtrl] to update the display 
  bool valueChanged( WxDataViewItem item, int column ) {
    bool ret = true;
    for (WxDataViewModelNotifier notifier in _notifiers) {
      if (!notifier.valueChanged(item,column)) ret = false;
    }
    return ret;
  }
}

// ------------------- wxDataViewListModel -------------------

/// Abstract [WxDataViewModel] simplified for tabular data.
/// 
/// Need to override
/// * [getValueByRow]
/// * [setValueByRow]
/// * [getRow]
/// * [getCount]

abstract class WxDataViewListModel extends WxDataViewModel {
  WxDataViewListModel();

  /// Needs to be overridden to return the value of [row],[col]
  dynamic getValueByRow( int row, int col );

  /// Needs to be overridden to set the value in [row],[col]
  bool setValueByRow( dynamic value, int row, int col);

    /*virtual bool
    GetAttrByRow(unsigned WXUNUSED(row), unsigned WXUNUSED(col),
                 wxDataViewItemAttr &WXUNUSED(attr)) const
    {
        return false;
    } */

  /// Needs to be overridden to return false if [row],[col] is disabled
  bool isEnabledByRow( int row, int col ) {
    return true;
  }

  /// Needs to be overridden to return the row [item]
  int getRow( WxDataViewItem item );
  
  /// Needs to be overridden to return the number of rows
  int getCount();

  /// Always returns invalid (root) itemsDeleted
  @override
  WxDataViewItem getParent( WxDataViewItem item ) {
    return WxDataViewItem();
  }

  /// Always returns false for list model
  @override
  bool isContainer( WxDataViewItem item ) {
    return false;
  }

  /// Overrides base function converting to call [getValueByRow]
  @override
  dynamic getValue( WxDataViewItem item, int column ) {
    return getValueByRow( getRow(item), column );
  }

  /// Overrides base function converting to call [setValueByRow]
  @override
  bool setValue( dynamic value, WxDataViewItem item, int column ) {
    return setValueByRow( value, getRow(item), column );
  }

  /// Override this to give row an attribute
  WxDataViewItemAttr? getAttrByRow( int row , int col) {
    return null;
  }

  /// Overrides base function converting to call [getAttrByRow]
  @override
  WxDataViewItemAttr? getAttr( WxDataViewItem item, int col) {
    return getAttrByRow( getRow(item), col );
  }

  /// Overrides base function converting to call [isEnabledByRow]
  @override
  bool isEnabled( WxDataViewItem item, int column ) {
    return isEnabledByRow( getRow(item), column );
  }

  /// Always returns true for list model
  @override
  bool isListModel() {
    return true;
  }
}

// ------------------- wxDataViewVirtualListModel -------------------

/// Abstract model of virtual tabular data (based on rows).

abstract class WxDataViewVirtualListModel extends WxDataViewListModel {
  WxDataViewVirtualListModel( { int initalSize = 0 } ) {
    _size = initalSize;
  }

  late int _size; 

  /// Informs model that an item has been prepended (before the first item)
  void rowPrepended() {
    _size++;
    itemAdded( WxDataViewItem(), WxDataViewItem( index: 0 ) );
  }

  /// Informs model that an item has been insert before the item in row [before]
  void rowInserted( int before ) {
    _size++;
    itemAdded( WxDataViewItem(), WxDataViewItem( index: before ) );
  }

  /// Informs model that an item has been appended (to the end)
  void rowAppended() {
    _size++;
    itemAdded( WxDataViewItem(), WxDataViewItem( index: _size-1 ) );
  }

  /// Informs model that the item given in [row] has been deleted
  void rowDeleted( int row ) {
    _size--;
    itemDeleted( WxDataViewItem(), WxDataViewItem( index: row ) );
  }

  /// Informs model that the items given in [rows] have been deleted
  void rowsDeleted( List<int> rows ) {
    _size -= rows.length;

    final sorted = List<int>.from(rows);
    sorted.sort( (a,b) => a.compareTo(b) );

    List<WxDataViewItem> array = [];
    for (int i = 0; i < sorted.length; i++) {
        array.add( WxDataViewItem( index:sorted[i]) );
    }
    /* wxDataViewModel:: */ itemsDeleted( WxDataViewItem(), array );
  }

  /// Informs model that the item given in [row] has changed (new data)
  void rowChanged( int row ) {
    /* wxDataViewModel:: */ itemChanged( getItem(row) );
  }

  /// Informs model that the field given in [row] and [col] has changed (new data)
  void rowValueChanged( int row, int col ) {
    /* wxDataViewModel:: */ valueChanged( getItem(row), col );
  }

  /// Resets the model to have [newSize] number of rows
  void reset( int newSize ) {
    _size = newSize;
  }

  /// Returns the row of the given [item]
  @override
  int getRow( WxDataViewItem item ) {
    return item.index;
  }

  /// Returns the [WxDataViewItem] representing [row] 
  WxDataViewItem getItem( int row ) {
    return WxDataViewItem( index: row );
  }

  @override
  int compare(  WxDataViewItem item1, WxDataViewItem item2, int column, bool ascending ) {
    final pos1 = item1.index;  
    final pos2 = item2.index;  

    if (ascending) {
       return pos1 - pos2;
    } else { 
       return pos2 - pos1;
    }
  }

  @override
  bool hasDefaultCompare() {
    return true;
  }

  /// Not needed in a virtual list model
  @override
  List<WxDataViewItem> getChildren( WxDataViewItem item ) {
    return [];
  }

  @override
  int getCount()  { 
    return _size;
   }

  /// Returns true since this is a virtual list model
  @override
  bool isVirtualListModel() {
    return true;
  }
}

// ------------------------- WxDataViewListStore ----------------------

/// Concrete implementation of a [WxDataViewModel] that stores tabular data.
/// 
/// Used internally by [WxDataViewListCtrl].

class WxDataViewListStore extends WxDataViewVirtualListModel
{
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
    final List rowData = _modelData[item.index];
    rowData[column] = value;
    return true;
  }

  @override
  dynamic getValue( WxDataViewItem item, int column ) {
    final List rowData = _modelData[item.index];
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
/// * [deleteAllItem]
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
    return WxDataViewItem( index: row );
  }

  /// Returns the row index of [item]
  int itemToRow( WxDataViewItem item ) {
    return item.index;
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

  /// Deletes all items
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

// ------------------------- wxDataViewTileListCtrl ----------------------

/// Specialized variant of a [WxDataViewListCtrl] showing tiles constructed from
/// [WxDataViewTileData] rendered by a [WxDataViewTileRenderer].
/// 
/// This is an example case of how [WxDataViewCtrl] can be used on mobile devices
/// showing one large vertical list of similar objects, in this case a tile.
/// A tile is a typical user interface element showing a leading icon, some
/// text in up to three rows in the middle and optionally a trailing icons again.
/// 
/// ```dart
///    dataview = WxDataViewTileListCtrl( this, 
///    -1,  // No ID used in this case 
///    80,  // height of the tile in pixels
///    4,   // margin between elements
///    style: wxDV_NO_HEADER|wxVSCROLL ); // no header and only vertical scrolling on mobile
///
///    final leading = WxBitmap.fromMaterialIcon( WxMaterialIcon.account_balance, WxSize(48,48), wxGREY );
///    final trailing = WxBitmap.fromMaterialIcon( WxMaterialIcon.delete, WxSize(48,48), wxRED );
///    for (int i = 0; i < 200; i++) {
///      dataview.appendTile( leading, "Title in row #$i", "Medium text", small: "Small text at the bottom", trailing: trailing );
///    }
/// ```
/// 
/// Adding tiles:
/// * [appendTile]
/// * [prependTile]
/// * [insertTile]

class WxDataViewTileListCtrl extends WxDataViewListCtrl {
  WxDataViewTileListCtrl( super.parent, super.id, int height, int margins,
         { super.pos = wxDefaultPosition, super.size = wxDefaultSize, super.style = 0 } )
  {
    _store._columns.add( (WxDataViewTileData).toString() );
    _tileRenderer = WxDataViewTileRenderer( height, margins );  
    final dvc = WxDataViewColumn("", _tileRenderer, 0, width: wxDVC_DEFAULT_WIDTH,
                             flags: wxDATAVIEW_COL_RESIZABLE );
    appendColumn( dvc );
    setRowHeight( height );
  }

  late WxDataViewTileRenderer _tileRenderer;

  /// Append a tile
  void appendTile( WxBitmap? leading, String big, String medium, { String small="", WxBitmap? trailing } )
  {
    // append list with a single item
    appendItem( [WxDataViewTileData( leading, big, medium, small: small, trailing: trailing )] );
  }

  /// Prepend a tile
  void prependTile( WxBitmap? leading, String big, String medium, { String small="", WxBitmap? trailing } )
  {
    // prepend list with a single item
    prependItem( [WxDataViewTileData( leading, big, medium, small: small, trailing: trailing )] );
  }

  /// Insert a tile at [pos]
  void insertTile( int pos, WxBitmap? leading, String big, String medium, { String small="", WxBitmap? trailing } )
  {
    // insert list with a single item
    insertItem( pos, [WxDataViewTileData( leading, big, medium, small: small, trailing: trailing )] );
  }
}

// ------------------------- WxDataViewTreeStore ----------------------

class WxDataViewTreeStoreNode {
  WxDataViewTreeStoreNode( WxBitmap? bitmap, String text, dynamic data ) {
    _data = WxDataViewIconTextData( bitmap, text );
    _clientData = data;
  }
  late WxDataViewIconTextData _data ;
  late dynamic _clientData; 
  final List <WxDataViewTreeStoreNode> _children = [];
  WxDataViewTreeStoreNode? _parent;
}

/// Specialized [WxDataViewModel] that actually stores data for a tree like model.
/// 
/// Used internally by [WxDataViewTreeCtrl].

class WxDataViewTreeStore extends WxDataViewModel
{
  final _root = WxDataViewTreeStoreNode(null,"", null);

  @override
  List<WxDataViewItem> getChildren( WxDataViewItem item )
  {
    List<WxDataViewItem> children = [];
    late WxDataViewTreeStoreNode node;
    if (!item.isOk()) {
      node = _root;
    } else {
      node = item.getID();
    }
    for (final child in node._children) {
      children.add( WxDataViewItem( id: child ) );
    }
    return children;
  }

  @override
  WxDataViewItem getParent( WxDataViewItem item )
  {
    if (!item.isOk()) return WxDataViewItem();
    WxDataViewTreeStoreNode node = item.getID();
    if (node._parent == _root) return WxDataViewItem();
    return WxDataViewItem( id: node._parent );
  }

  @override
  bool isContainer( WxDataViewItem item )
  {
    if (!item.isOk()) {
      return true;
    }
    WxDataViewTreeStoreNode node = item.getID();
    return node._children.isNotEmpty;
  }

  @override
  WxDataViewItemAttr? getAttr( WxDataViewItem item, int col) {
    return null;
  }

  @override
  dynamic getValue( WxDataViewItem item, int column )
  {
    if (!item.isOk()) return null;
    WxDataViewTreeStoreNode node = item.getID();
    return node._data;
  }

  String getItemText( WxDataViewItem item )
  {
    if (!item.isOk()) return "";
    WxDataViewTreeStoreNode node = item.getID();
    return node._data.text;
  }

  void setItemText( WxDataViewItem item, String text )
  {
    if (!item.isOk()) return;
    WxDataViewTreeStoreNode node = item.getID();
    node._data = WxDataViewIconTextData( node._data.icon, text );
    itemChanged(item);
  }

  dynamic getItemData( WxDataViewItem item )
  {
    if (!item.isOk()) return null;
    WxDataViewTreeStoreNode node = item.getID();
    return node._clientData;
  }

  void setItemData( WxDataViewItem item, dynamic data )
  {
    if (!item.isOk()) return;
    WxDataViewTreeStoreNode node = item.getID();
    node._clientData = data;
  }

  WxDataViewItem appendItem( WxDataViewItem parent, WxBitmap? icon, String text, { dynamic data } )
  {
    final node = WxDataViewTreeStoreNode( icon, text, data );
    if (!parent.isOk()) {
      _root._children.add( node );
      node._parent = _root; // children of root must report no parent
    } else {
      final WxDataViewTreeStoreNode parentNode = parent.getID();
      parentNode._children.add( node );
      node._parent = parentNode;
    }
    final childItem = WxDataViewItem( id: node );
    itemAdded( parent, childItem );
    return childItem;
  }

  void deleteItem( WxDataViewItem item )
  {
    if (!item.isOk()) {
      deleteAllItems();
      return;
    }
    WxDataViewTreeStoreNode node = item.getID();
    if (node._parent == null) {
      wxLogError( "parent is null" );
      return;
    }
    if (node._parent!._children.remove(node)) {
      // TODO: notify about child items??
      itemDeleted( WxDataViewItem( id: node._parent == _root ? null : node._parent ), item );
    } else {
      wxLogError( "item not found in parent list" );
    }
  }

  void deleteAllItems()
  {
    _root._children.clear();
    cleared();
  }
}

// ------------------------- wxDataViewTreeCtrl ----------------------

/// Implementation of a [WxDataViewCtrl] using a [WxDataViewTreeStore].
/// 
/// This control (or rather its model) store the actual data itself and it provides
/// a simplified interface for a tree like control. Its usage and appearance are
/// similar to [WxTreeCtrl]. As for [WxTreeCtrl], you can set a bitmap, text and
/// any user data (client data) for an item.
/// 
/// ```dart
/// final tree = WxDataViewTreeCtrl( this, -1 );
/// final root = tree.appendItem( WxDataViewItem(), null, "Root" ); // there can be several roots
/// tree.appendItem( root, null, "Branch 1" ); 
/// tree.appendItem( root, null, "Branch 2" ); 
/// tree.appendItem( root, null, "Branch 3" ); 
/// ```
/// 
/// Adding/removing items:
/// * [appendItem]
/// * [deleteItem]
/// * [deleteAllItems]
/// 
/// Changing an item:
/// * [setValue]
/// * [getItemText]
/// * [setItemText]
/// * [getItemText]
/// * [setItemData]
/// * [getItemData]

class WxDataViewTreeCtrl extends WxDataViewCtrl {
  WxDataViewTreeCtrl( super.parent, super.id, { super.pos = wxDefaultPosition, super.size = wxDefaultSize, super.style = wxDV_NO_HEADER } ) {
    _store = WxDataViewTreeStore();
    associateModel( _store );

    final renderer = WxDataViewIconTextRenderer();  
    final dvc = WxDataViewColumn("", renderer, 0, width: wxDVC_DEFAULT_WIDTH,
                             flags: wxDATAVIEW_COL_RESIZABLE );
    appendColumn( dvc );
  }

  late WxDataViewTreeStore _store;

  /// Associates the [store] with the control.
  void setStore( WxDataViewTreeStore store ) {
    _store = store;
    associateModel( _store );
  }

  /// Appends a new child item to [parent] 
  WxDataViewItem appendItem( WxDataViewItem parent, WxBitmap? icon, String text, { dynamic data } ) {
    return _store.appendItem( parent, icon, text, data: data );
  }

  /// Deletes the [item] 
  void deleteItem( WxDataViewItem item ) {
    _store.deleteItem( item );
  }

  /// Deletes all items
  void deleteAllItems( ) {
    _store.deleteAllItems();
  }

  /// Sets the [icon] and [text] values of [item]
  void setValue( WxDataViewItem item, WxBitmap? icon, String text  ) {
    _store.setValue( WxDataViewIconTextData(icon,text), item, 0 );
  }

  /// Returns the text value of [item]
  String getItemText( WxDataViewItem item )
  {
    return _store.getItemText( item );
  }

  /// Returns the user data (client data) of [item], or null
  dynamic getItemData( WxDataViewItem item )
  {
    return _store.getItemData( item );
  }
  /// Sets the [text] value of [item]
  void setItemText( WxDataViewItem item, String text )
  {
    _store.setItemText( item, text );
  }

  /// Sets the user data (client data) of [item]
  void setItemData( WxDataViewItem item, dynamic data )
  {
    _store.setItemData( item, data );
  }
}

// ------------------------- WxDataViewBookStore ----------------------

/// A specialized [WxDataViewTreeStore] that adds font attributes to the
/// tree model in order to create a table of contents like tree structure.
/// 
/// Uses reasonable defaults font sizes, getting smaller according to branch
/// depth.
/// 
/// Used internally by [WxDataViewChapterCtrl].

class WxDataViewBookStore extends WxDataViewTreeStore {
  WxDataViewBookStore() 
  {
    double pointSize = wxNORMAL_FONT.getPointSize();
    _header1 = WxDataViewItemAttr( null, WxFont(pointSize*1.4, weight: wxFONTWEIGHT_BOLD), null, hMargin: 2, vMargin: 2 );
    _header2 = WxDataViewItemAttr( null, WxFont(pointSize*1.2, weight: wxFONTWEIGHT_BOLD, style: wxFONTSTYLE_ITALIC), null, hMargin: 2, vMargin: 2 );
    _header3 = WxDataViewItemAttr( null, WxFont(pointSize, weight: wxFONTWEIGHT_BOLD ), null, hMargin: 2, vMargin: 2 );
  }

  WxDataViewItemAttr? _header1;
  WxDataViewItemAttr? _header2;
  WxDataViewItemAttr? _header3;

  /// Sets the attributes of the top level header
  void setHeaderOneAttr( WxDataViewItemAttr? attr ) {
    _header1 = attr;
  }
  /// Sets the attributes of the second level header
  void setHeaderTwoAttr( WxDataViewItemAttr? attr ) {
    _header2 = attr;
  }
  /// Sets the attributes of the third level header
  void setHeaderThreeAttr( WxDataViewItemAttr? attr ) {
    _header3 = attr;
  }

  /// Overridden to return header attributes based on branch depth
  @override
  WxDataViewItemAttr? getAttr( WxDataViewItem item, int col)
  {
    if (!item.isOk()) return null;
    WxDataViewTreeStoreNode node = item.getID();
    final haschildren = node._children.isNotEmpty;

    WxDataViewItem parentItem = getParent( item );
    if (!parentItem.isOk()) return _header1;  // even if no children

    parentItem = getParent( parentItem );
    if (!parentItem.isOk()) return haschildren ? _header2 : null;  

    parentItem = getParent( parentItem );
    if (!parentItem.isOk()) return haschildren ? _header3 : null;  

    return null;
  }
}

/// Specialized renderer that renders the chapter title of a 
/// [WxDataViewChapterCtrl] with reasonable spacing.

class WxDataViewChapterRenderer extends WxDataViewIconTextRenderer {
  WxDataViewChapterRenderer() : super( mode: wxDATAVIEW_CELL_INERT );

  @override
  WxSize getSize() {
    WxSize size = super.getSize();
    return WxSize( size.x+2, size.y+6 );
  }
}

// ------------------------- WxDataViewChapterCtrl ----------------------

/// Specialized [WxDataViewTreeCtrl] that can be used as a table of contents.
/// 
/// It uses [WxDataViewBookStore] internally to store the data and styling and
/// it is - in turn - used internally by [WxDataViewBook] to implement a book
/// control (letting the user choose a chapter or page). 
/// 
/// Adding/removing items:
/// * [appendItem]
/// * [deleteItem]
/// * [deleteAllItems]
/// 
/// Changing an item:
/// * [setValue]
/// * [getItemText]
/// * [setItemText]
/// * [getItemText]
/// * [setItemData]
/// * [getItemData]
/// 
/// Changing formatting of headers:
/// * [setHeaderOneAttr]
/// * [setHeaderTwoAttr]
/// * [setHeaderThreeAttr]

class WxDataViewChapterCtrl extends WxDataViewCtrl {
  WxDataViewChapterCtrl( super.parent, super.id, { super.pos = wxDefaultPosition, super.size = wxDefaultSize, 
    super.style = wxDV_NO_HEADER|wxDV_VARIABLE_LINE_HEIGHT } ) {
    _store = WxDataViewBookStore();
    associateModel( _store );

    final renderer = WxDataViewChapterRenderer();  
    final dvc = WxDataViewColumn("", renderer, 0, width: wxDVC_DEFAULT_WIDTH,
                             flags: wxDATAVIEW_COL_RESIZABLE );
    appendColumn( dvc );
  }

  // Below is copy and paste from WxDataViewTreeCtrl - that can be improved

  late WxDataViewBookStore _store;

  void setStore( WxDataViewBookStore store ) {
    _store = store;
    associateModel( _store );
  }

  /// Calls [WxDataViewBookStore.setHeaderOneAttr]
  void setHeaderOneAttr( WxDataViewItemAttr? attr ) {
    _store.setHeaderOneAttr( attr );
  }
  /// Calls [WxDataViewBookStore.setHeaderTwoAttr]
  void setHeaderTwoAttr( WxDataViewItemAttr? attr ) {
    _store.setHeaderTwoAttr( attr );
  }
  /// Calls [WxDataViewBookStore.setHeaderThreeAttr]
  void setHeaderThreeAttr( WxDataViewItemAttr? attr ) {
    _store.setHeaderThreeAttr( attr );
  }

  WxDataViewItem appendItem( WxDataViewItem parent, WxBitmap? icon, String text, { dynamic data } ) {
    return _store.appendItem( parent, icon, text, data: data );
  }

  void deleteItem( WxDataViewItem item ) {
    _store.deleteItem( item );
  }

  void deleteAllItems( ) {
    _store.deleteAllItems();
  }

  void setValue( WxDataViewItem item, WxBitmap? icon, String text  ) {
    _store.setValue( WxDataViewIconTextData(icon,text), item, 0 );
  }

  String getItemText( WxDataViewItem item )
  {
    return _store.getItemText( item );
  }
  dynamic getItemData( WxDataViewItem item )
  {
    return _store.getItemData( item );
  }
  void setItemText( WxDataViewItem item, String text )
  {
    _store.setItemText( item, text );
  }
  void setItemData( WxDataViewItem item, dynamic data )
  {
    _store.setItemData( item, data );
  }
}


