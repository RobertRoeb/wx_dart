// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../wx_dart.dart';

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
