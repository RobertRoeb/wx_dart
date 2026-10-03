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
/// WxDataViewModel provides a [WxDataViewModel.compare] method which the [WxDataViewCtrl]
/// may use to sort the data either in conjunction with a column header or without
/// (see [WxDataViewModel.hasDefaultCompare]).
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

  /// Adds a notifier to the model
  void addNotifier( WxDataViewModelNotifier notifier ) {
    _notifiers.add( notifier );
  }

  /// Removes the [notifier] from the model
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

  /// Returns true of model uses the defaul compare method
  bool hasDefaultCompare() {
    return false;
  }

  /// Compare the two items
  int compare( WxDataViewItem item1, WxDataViewItem item2, int column, bool ascending )
  {
    final hasValue1 = hasValue( item1, column );
    final hasValue2 = hasValue( item2, column );
    if (!hasValue1 && !hasValue2) return 0;
    if (!hasValue1) return ascending ? 1 : -1;
    if (!hasValue2) return ascending ? -1 : 1;

    dynamic value1 = getValue( item1, column );
    dynamic value2 = getValue( item2, column );

    if (!ascending) {
      final temp = value1;
      value1 = value2;
      value2 = temp;
    }

    if (value1 is int)
    {
      int l1 = value1;
      int l2 = value2 as int;
        if (l1 < l2) {
            return -1;
        }
        else if (l1 > l2) {
            return 1;
        } else {
          return 0;
        }
    }

    if (value1 is double)
    {
      double l1 = value1;
      double l2 = value2 as double;
        if (l1 < l2) {
            return -1;
        }
        else if (l1 > l2) {
            return 1;
        } else {
          return 0;
        }
    }

    if (value1 is bool)
    {
      bool b1 = value1;
      bool b2 = value2 as bool;

      if (b1 != b2) {        
        return b1 ? 1 : -1;
      }
      return 0;
    }

    if (value1 is String)
    {
      String l2 = value2 as String;
      return value1.compareTo( l2 );
    }

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

  /// Change the value of the given item and update the control to reflect it
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

// ------------------- wxDataViewIndexListModel -------------------

/// Base class for non-virtual [WxDataViewListModel] in which a [WxDataViewItem]
/// is persistent. Therefore, a [WxDataViewCtrl] can sort the items in such a model.
/// 
/// See [WxDataViewListStore] for a concrete implementation, used by [WxDataViewListCtrl].
/// 
/// Need to override
/// * [getValueByRow]
/// * [setValueByRow]
/// * [setValue]
/// * [getValue]

abstract class WxDataViewIndexListModel extends WxDataViewListModel {
  WxDataViewIndexListModel( int initialSize )
  {
    for (int i = 0; i < initialSize; i++) {
      _hash.add( WxDataViewItem( id: i ) );
    }
    _nextFreeID = initialSize;
  }  

  final List<WxDataViewItem> _hash = [];
  bool _ordered = true;
  int _nextFreeID = 0;

  void reset( int newSize )
  {
      // wxDataViewModel::  BeforeReset();

      _hash.clear();

      // IDs are ordered until an item gets deleted or inserted
      _ordered = true;

      // build initial index
      for (int i = 0; i < newSize; i++) {
        _hash.add( WxDataViewItem( id: i ) );
      }

      _nextFreeID = newSize;

      // wxDataViewModel:: AfterReset();
  }

  /// Returns the number of items in the list
  @override
  int getCount() {
    return _hash.length;
  }

  /// Informs model that an item has been prepended (before the first item)
  void rowPrepended()
  {
      _ordered = false;

      final id = _nextFreeID;
      _nextFreeID++;

      final item = WxDataViewItem( id: id );
      _hash.insert( 0, item );
      itemAdded( WxDataViewItem(), item );
  }

  /// Informs model that an item has been insert before the item in row [before]
  void rowInserted( int before )
  {
      _ordered = false;

      final id = _nextFreeID;
      _nextFreeID++;

      final item = WxDataViewItem( id: id );
      _hash.insert( before, item );
      itemAdded( WxDataViewItem(), item );
  }

  /// Informs model that an item has been appended (to the end)
  void rowAppended()
  {
    final id = _nextFreeID;
    _nextFreeID++;

    final item = WxDataViewItem( id: id );
    _hash.add( item );
    itemAdded( WxDataViewItem(), item );
  }

  /// Informs model that the item given in [row] has been deleted
  void rowDeleted( int row )
  {
    _ordered = false;

    final item = _hash[row];
    _hash.removeAt( row );
      /* wxDataViewModel:: */ itemDeleted( WxDataViewItem(), item );
  }

  /// Informs model that the items given in [rows] have been deleted
  void rowsDeleted( List<int> rows )
  {
    _ordered = false;

    final List<WxDataViewItem> array = [];
    for (int i = 0; i < rows.length; i++)
    {
      final item = _hash[rows[i]];
      array.add( item );
    }

    //  wxArrayInt sorted = rows;
    //  sorted.Sort( my_sort );
    for (int i = 0; i < rows.length; i++) {
      _hash.removeAt( rows[i] );
    }

    /* wxDataViewModel:: */ itemsDeleted( WxDataViewItem(), array );
  }

  /// Informs model that the item given in [row] has changed (new data)
  void rowChanged( int row )
  {
      /* wxDataViewModel:: */ itemChanged( getItem(row) );
  }

  /// Informs model that the field given in [row] and [col] has changed (new data)
  void rowValueChanged( int row, int col )
  {
      /* wxDataViewModel:: */ valueChanged( getItem(row), col );
  }

  /// Clears the index hash and informs model that all data has been removed
  @override
  bool cleared() {
    _hash.clear();
    _ordered = true;
    _nextFreeID = 0;
    return super.cleared();
  }

  /// Returns the row of the given [item]
  @override
  int getRow( WxDataViewItem item ) 
  {
      if (_ordered) {
          return item.getID();
      }

      return _hash.indexOf( item );
  }

  /// Returns the [WxDataViewItem] representing [row] 
  WxDataViewItem getItem( int row )
  {
      if ((row < 0) || (row >= _hash.length)) {
        wxLogError( "invalid row index in WxDataViewIndexListModel.getItem()" );
        return WxDataViewItem();
      }
      return _hash[row];
  }

  /// Returns all items in the list model if [item] is the invalid
  /// root item, otherwise returns an empty list.

  @override
  List<WxDataViewItem> getChildren( WxDataViewItem item )
  {
    if (item.isOk()) return [];

    return _hash;
  }
}

// ------------------- wxDataViewVirtualListModel -------------------

/// Abstract model of virtual tabular data (based on rows) deriving from [WxDataViewListModel]
/// 
/// Use this model if you need to show hundreds of thousands of items. A limitation
/// of a virtual model is that the [WxDataViewCtrl] that displays it cannot sort the
/// items in the model. 
/// 
/// The key difference to [WxDataViewIndexListModel] is that the [WxDataViewItem]
/// values are not persistent, they refer to a given row. If a row above is deleted,
/// the the [WxDataViewItem] will point to different row than before.

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
  void rowsDeleted( List<int> rows )
  {
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

  /// Comparison function for the two items in a virtual list. Compares exclusively
  /// based on the row index, not based on values (because this is a virtual list model).
  /// 
  /// For a list that can be sorted based on data, see [WxDataViewIndexListModel].
  @override
  int compare(  WxDataViewItem item1, WxDataViewItem item2, int column, bool ascending )
  {
    final pos1 = item1.index;  
    final pos2 = item2.index;  

    if (ascending) {
       return pos1 - pos2;
    } else { 
       return pos2 - pos1;
    }
  }

  /// Returns true, although sorting is not based on content of items
  @override
  bool hasDefaultCompare() {
    return true;
  }

  /// Not needed in a virtual list model
  @override
  List<WxDataViewItem> getChildren( WxDataViewItem item ) {
    return [];
  }

  /// Returns the size of the virtual list
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
