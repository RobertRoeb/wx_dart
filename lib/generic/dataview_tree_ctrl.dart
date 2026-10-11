// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../wx_dart.dart';

// ------------------------- WxDataViewTreeStore ----------------------

/// Internal helper class used by [WxDataViewTreeStore]
class WxDataViewTreeStoreNode {
  WxDataViewTreeStoreNode( WxBitmap? bitmap, String text, dynamic clientdata ) {
    data = WxDataViewIconTextData( bitmap, text );
    clientData = clientdata;
  }
  late WxDataViewIconTextData data ;
  late dynamic clientData; 
  final List <WxDataViewTreeStoreNode> children = [];
  WxDataViewTreeStoreNode? parent;
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
    for (final child in node.children) {
      children.add( WxDataViewItem( id: child ) );
    }
    return children;
  }

  @override
  WxDataViewItem getParent( WxDataViewItem item )
  {
    if (!item.isOk()) return WxDataViewItem();
    WxDataViewTreeStoreNode node = item.getID();
    if (node.parent == _root) return WxDataViewItem();
    return WxDataViewItem( id: node.parent );
  }

  @override
  bool isContainer( WxDataViewItem item )
  {
    if (!item.isOk()) {
      return true;
    }
    WxDataViewTreeStoreNode node = item.getID();
    return node.children.isNotEmpty;
  }

  /// Override this to give an [WxDataViewItemAttr] to a certain [item]
  @override
  WxDataViewItemAttr? getAttr( WxDataViewItem item, int col) {
    return null;
  }

  /// Gets the value of [item] in the given [column]
  @override
  dynamic getValue( WxDataViewItem item, int column )
  {
    if (!item.isOk()) return null;
    WxDataViewTreeStoreNode node = item.getID();
    return node.data;
  }

  /// Gets the text of an [item]
  String getItemText( WxDataViewItem item )
  {
    if (!item.isOk()) return "";
    WxDataViewTreeStoreNode node = item.getID();
    return node.data.text;
  }

  /// Sets the [text] of an [item] and informs the owner(s) of the model
  void setItemText( WxDataViewItem item, String text )
  {
    if (!item.isOk()) return;
    WxDataViewTreeStoreNode node = item.getID();
    node.data = WxDataViewIconTextData( node.data.icon, text );
    itemChanged(item);
  }

  /// Gets the (client) data of [item]
  dynamic getItemData( WxDataViewItem item )
  {
    if (!item.isOk()) return null;
    WxDataViewTreeStoreNode node = item.getID();
    return node.clientData;
  }

  /// Sets the (client) data of an [item]
  void setItemData( WxDataViewItem item, dynamic clientData )
  {
    if (!item.isOk()) return;
    WxDataViewTreeStoreNode node = item.getID();
    node.clientData = clientData;
  }

  /// Appends an item to [parent] and informs the owner(s) of the model
  WxDataViewItem appendItem( WxDataViewItem parent, WxBitmap? icon, String text, { dynamic clientData } )
  {
    final node = WxDataViewTreeStoreNode( icon, text, clientData );
    if (!parent.isOk()) {
      _root.children.add( node );
      node.parent = _root; // children of root must report no parent
    } else {
      final WxDataViewTreeStoreNode parentNode = parent.getID();
      parentNode.children.add( node );
      node.parent = parentNode;
    }
    final childItem = WxDataViewItem( id: node );
    itemAdded( parent, childItem );
    return childItem;
  }

  /// Delete the [item] from the model and informs the owner(s)
  void deleteItem( WxDataViewItem item )
  {
    if (!item.isOk()) {
      deleteAllItems();
      return;
    }
    WxDataViewTreeStoreNode node = item.getID();
    if (node.parent == null) {
      wxLogError( "parent is null" );
      return;
    }
    if (node.parent!.children.remove(node)) {
      // TODO: notify about child items??
      itemDeleted( WxDataViewItem( id: node.parent == _root ? null : node.parent ), item );
    } else {
      wxLogError( "item not found in parent list" );
    }
  }

  /// Deletes all data from the model and informs the owner(s)
  void deleteAllItems()
  {
    _root.children.clear();
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
  /// with optional [clientData] associated with the item
  WxDataViewItem appendItem( WxDataViewItem parent, WxBitmap? icon, String text, { dynamic clientData } ) {
    return _store.appendItem( parent, icon, text, clientData: clientData );
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
