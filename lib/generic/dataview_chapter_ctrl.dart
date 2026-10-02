// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../wx_dart.dart';

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


