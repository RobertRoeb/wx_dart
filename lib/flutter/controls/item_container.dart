// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------------- _WxItem -----------------------------

class _WxItem {
  _WxItem( this.text, { this.data } );
  String text = "";
  dynamic data;
  WxBitmap? bitmap; 
}

// ------------------------- wxItemContainerImmutable ----------------------

/// Base class for controls with several items

class WxItemContainerImmutable extends WxControl {
  WxItemContainerImmutable( super.parent, super.id, { super.pos = wxDefaultPosition, super.size = wxDefaultSize, super.style = 0 } );

  final List<_WxItem> _items = [];
  int _selection = -1;

  /// Returns the number of items in the control
  int getCount( ) {
    return _items.length;
  }

  /// Returns true of there are no items in the control
  bool isEmpty( ) {
    return _items.isEmpty;
  }

  /// Set text at position [index] to [str]
  void setString( int index, String str ) {
    _items[index].text = str;
    _setState();
  }

  /// Returns text at position [index]
  String getString( int index ) {
    return _items[index].text;
  }

  /// Returns all elements
  List<String> getStrings( ) {
    final List<String> ret = [];
    for (final item in _items) {
      ret.add( item.text );
    }
    return ret;
  }

  /// Returns position of [str] in control or -1 if not found
  int findString( String str ) {
    int count = 0; 
    for (final item in _items) {
      if (item.text == str) return count;
      count++;
    }
    return -1;
  }

  /// Set selection to item at position [index]
  /// 
  /// Same as [select]
  void setSelection( int index ) {
    _selection = index;
    _setState();
  }

  /// Set selection to [str]. May clear selection if not found.
  void setStringSelection( String sel ) {
    _selection = findString( sel );
    _setState();
  }

  /// Set selection to item at position [index], 
  /// 
  /// Same as [setSelection]
  void select( int index ) {
    _selection = index;
    _setState();
  }

  /// Returns index of current selection or -1
  int getSelection( ) {
    return _selection;
  }

  /// Returns text of current selection
  String getStringSelection( ) {
    if (_selection == -1) {
      return "";
    }
    return _items[_selection].text;
  }
}

// ------------------------- wxItemContainer ----------------------

/// Base class for controls with several items that can be changed

class WxItemContainer extends WxItemContainerImmutable {
  WxItemContainer( super.parent, super.id, { super.pos = wxDefaultPosition, super.size = wxDefaultSize, super.style = 0 } );

  /// Clears the list items in the control
  void clear( ) {
    _items.clear();
    _setState();
  }

  /// Delete item at [index]
  void delete( int index ) {
    _items.removeAt(index);
    _setState();
  }

  /// Returns client data associated with the [index] or null
  dynamic getClientData( int index ) {
    return _items[index].data;
  }

  /// Associates arbitrary client data with the item at [index]
  void setClientData( int index, dynamic data ) {
    _items[index].data = data;
  }

  void _resort()
  {
    if ((this is WxListBox) && hasFlag(wxLB_SORT)) {
      _items.sort(  (a,b)=>a.text.compareTo(b.text) ); 
    } else
    if ((this is WxComboBox) && hasFlag(wxCB_SORT)) {
      _items.sort(  (a,b)=>a.text.compareTo(b.text) ); 
    } else
    if ((this is WxChoice) && hasFlag(wxCB_SORT)) {
      _items.sort(  (a,b)=>a.text.compareTo(b.text) ); 
    }
  }

  /// Set text at position [index] to [str]
  @override
  void setString( int index, String str ) {
    _items[index].text = str;
    _resort();
    _setState();
  }

  /// Clears the list of elements and replaces it with a new list.
  /// Optionally, adds a list of client data to the items. The number
  /// of elements in [data] must be the same as in [items].
  void set( List<String> items, { List? data } ) {
    if (data != null) {
      if (items.length != data.length) {
        wxLogError( "item and client data have different count" );
      }
    }
    int count = 0;
    _items.clear();
    for (final str in items) {
      _items.add( _WxItem( str, data: data == null ? null : data[count]  ) );
      count++;
    }
    _resort();
    _setState();
  }

  /// Appends the element [item] to the list and optionally associated
  /// the client [data] to it.
  void append( String item, { dynamic data } ) {
    _items.add( _WxItem( item, data: data ) );
    _resort();
    _setState();
  }

  /// Appends a list of items to the control-
  /// Optionally, adds a list of client data to the items. The number
  /// of elements in [data] must be the same as in [items].
  void appendList( List<String> items, { List? data } ) {
    if (data != null) {
      if (items.length != data.length) {
        wxLogError( "item and client data have different count" );
      }
    }
    int count = 0;
    for (final str in items) {
      _items.add( _WxItem( str, data: data == null ? null : data[count] ) );
      count++;
    }
    _resort();
    _setState();
  }

  /// Inserts an element at position [pos] with optional client [data].
  void insert( String item, int pos, { dynamic data } ) {
    _items.insert( pos, _WxItem( item, data: data ) );
    _resort();
    _setState();
  }

  /// Inserts a list of elements at position [pos] with optional client data.
  void insertList( List<String> items, int pos, { List? data } ) {
    if (data != null) {
      if (items.length != data.length) {
        wxLogError( "item and client data have different count" );
      }
    }
    int count = 0;
    for (final str in items) {
      _items.insert( pos+count, _WxItem( str, data: data == null ? null : data[count] ) );
      count++;
    }
    _resort();
    _setState();
  }
}
