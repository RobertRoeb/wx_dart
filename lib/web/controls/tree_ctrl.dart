// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01 (wxDart Web: 2026-11-15)
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxTreeEvent ----------------------

// ------------------------ wxTreeCtrl -----------------------

class _WxTreeNode {
  _WxTreeNode( this.label, this.image, this.selImage, this.data, this.parent );
  String label;
  int image;
  int selImage;
  dynamic data;
  _WxTreeNode? parent;
  final List<_WxTreeNode> children = [];
  bool hasButton = false;   // see WxTreeCtrl.setItemHasChildren
  bool bold = false;
  WxColour? textColour;
  WxColour? backgroundColour;
}

/// Opaque item representing an item in a [WxTreeCtrl]
class WxTreeItemId {
  /// Creates an invalid item id
  WxTreeItemId( );

  WxTreeItemId._( this._node );

  WxTreeItemId._asInvisibleRoot() : _isInvisibleRoot = true;

  _WxTreeNode? _node;
  bool _isInvisibleRoot = false;

  /// Returns true if the id refers to an item
  bool isOk() {
    return (_node != null) || _isInvisibleRoot;
  }

  /// Makes the id invalid
  void unset() {
    _node = null;
    _isInvisibleRoot = false;
  }

  @override
  bool operator == (Object other) {
    if (other is! WxTreeItemId) return false;
    return identical( _node, other._node ) && _isInvisibleRoot == other._isInvisibleRoot;
  }

  @override
  int get hashCode => _node == null ? (_isInvisibleRoot ? 1 : 0) : identityHashCode( _node );
}

const int wxTreeItemIcon_Normal = 0;
const int wxTreeItemIcon_Selected = 1;
const int wxTreeItemIcon_Expanded = 2;
const int wxTreeItemIcon_SelectedExpanded = 3;
const int wxTreeItemIcon_Max = 4;
const int wxTREE_ITEMSTATE_NONE = -1;
const int wxTREE_ITEMSTATE_NEXT = -2;
const int wxTREE_ITEMSTATE_PREV  = -3;
const int wxTR_NO_BUTTONS = 0x0000;
const int wxTR_HAS_BUTTONS = 0x0001;
const int wxTR_NO_LINES = 0x0004;
const int wxTR_LINES_AT_ROOT = 0x0008;
const int wxTR_TWIST_BUTTONS = 0x0010;
const int wxTR_SINGLE = 0x0000;
const int wxTR_MULTIPLE  = 0x0020;
const int wxTR_HAS_VARIABLE_ROW_HEIGHT = 0x0080;
const int wxTR_EDIT_LABELS = 0x0200;
const int wxTR_ROW_LINES = 0x0400;
const int wxTR_HIDE_ROOT = 0x0800;
const int wxTR_FULL_ROW_HIGHLIGHT = 0x2000;
const int wxTR_DEFAULT_STYLE  = (wxTR_HAS_BUTTONS | wxTR_NO_LINES | wxTR_FULL_ROW_HIGHLIGHT);

/// The data model behind the tree, read by the generic WxDataViewCtrl
class _WxTreeModel extends WxDataViewModel {
  _WxTreeModel( this._tree );

  final WxTreeCtrl _tree;

  @override
  List<WxDataViewItem> getChildren( WxDataViewItem item ) {
    final node = item.isOk() ? item.getID() as _WxTreeNode : null;
    if (node == null) {
      final root = _tree._root;
      if (root == null) return [];
      if (_tree.hasFlag( wxTR_HIDE_ROOT )) {
        return root.children.map( _WxTreeModel._item ).toList();
      }
      return [ _item( root ) ];
    }
    return node.children.map( _WxTreeModel._item ).toList();
  }

  @override
  WxDataViewItem getParent( WxDataViewItem item ) {
    if (!item.isOk()) return WxDataViewItem();
    final parent = (item.getID() as _WxTreeNode).parent;
    if (parent == null) return WxDataViewItem();
    if (parent == _tree._root && _tree.hasFlag( wxTR_HIDE_ROOT )) return WxDataViewItem();
    return _item( parent );
  }

  @override
  bool isContainer( WxDataViewItem item ) {
    if (!item.isOk()) return true;
    final node = item.getID() as _WxTreeNode;
    return node.children.isNotEmpty || node.hasButton;
  }

  @override
  dynamic getValue( WxDataViewItem item, int column ) {
    final node = item.getID() as _WxTreeNode;
    return WxDataViewIconTextData( _tree._bitmapFor( node ), node.label );
  }

  @override
  WxDataViewItemAttr? getAttr( WxDataViewItem item, int col ) {
    final node = item.getID() as _WxTreeNode;
    if (!node.bold && node.textColour == null && node.backgroundColour == null) return null;
    WxFont? font;
    if (node.bold) font = WxFont( _tree._effectiveFont.getPointSize(), weight: wxFONTWEIGHT_BOLD );
    return WxDataViewItemAttr( node.textColour, font, node.backgroundColour );
  }

  static WxDataViewItem _item( _WxTreeNode node ) => WxDataViewItem( id: node );
}

/// Control that displays entries in a tree
/// 
/// [WxTreeCtrl] can operate with either a single visible root (the default) or with
/// an invisible root when using the [wxTR_HIDE_ROOT] window style.
/// 
/// [WxTreeCtrl] uses the opaque [WxTreeItemId] class to identify an item. An empty
/// [WxTreeItemId] can indicate either the root item or an invalid return value depending
/// on the context. An empty [WxTreeItemId.isOk] returns false in both cases.
/// 
/// You can attach any data (client data) to an item using [setItemData].
///  
/// Adding items:
/// * [addRoot]
/// * [appendItem]
/// * [insertItem]
/// * [prependItem]
/// * [insertItemAfter]
/// 
/// Images interface
/// * [setImages]
/// * [hasImages]
/// * [getImageCount]
/// 
/// Label and client data
/// * [setItemText]
/// * [getItemText]
/// * [setItemData]
/// * [getItemData]
/// 
/// Deletion
/// * [delete]
/// * [deleteChildren]
/// * [deleteAllItems]
/// 
/// Information
/// * [getCount]
/// * [getChildrenCount]
/// * [getRootItem]
/// * [getItemParent]
/// * [getFirstChild]
/// * [getLastChild]
/// * [getNextSibling]
/// * [getPrevSibling]
/// 
/// Selection interface
/// * [isSelected]
/// * [getSelection]
/// * [selectItem]
/// 
/// Mulitple selection (wxDart Native only)
/// * [unselectItem]
/// * [selectChildren]
/// * [toggleItemSelection]
///
/// Tree interface
/// * [itemHasChildren]
/// * [isExpanded]
/// * [expand]
/// * [expandAll]
/// * [toggle]
/// * [collapse]
/// * [collapseAll]
/// * [collapseAndReset]
/// * [collapseAllChildren]
/// 
/// Example usage:
/// ```dart
/// // create tree control
/// final treectrl = WxTreeCtrl(this, -1, style: wxTR_DEFAULT_STYLE );
/// 
/// // create image list
///  List<WxBitmapBundle> images = [];
///  images.add( WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.airplanemode_active, WxSize(20,20), colour: wxGREY ) );
///  images.add( WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.airplanemode_inactive, WxSize(20,20), colour: wxGREY) );
///  images.add( WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.airplane_ticket, WxSize(20,20), colour: wxGREY) );
///  images.add( WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.car_rental, WxSize(20,20), colour: wxGREY) );
/// 
///  // assign image list to tree control
///  treectrl.setImages(images);
/// 
///  // create root
///  final root = treectrl.addRoot("Super Root", image: 2, selImage: 3);
/// 
///  // create two branches
///  final branch1 = treectrl.appendItem(root, "Branch 1", image: 0, selImage: 1 );
///  final branch2 = treectrl.appendItem(root, "Branch 2", image: 0, selImage: 1 );
/// 
///  // bind to item selection change
///  treectrl.bindTreeSelChangedEvent( (event) {
///    final item = event.getItem();
///    final text = treectrl.getItemText(item);
///    // do something
///  }, -1 );
///
///  // bind to item activation (ENTER or double click)
///  treectrl.bindTreeItemActivatedEvent( (event) {
///    final item = event.getItem();
///    final text = treectrl.getItemText(item);
///    // do something
///  }, -1 );
/// ```
/// 
/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxTreeItemIcon_Normal | 0 |
/// | wxTreeItemIcon_Selected | 1 |
/// | wxTreeItemIcon_Expanded | 2 |
/// | wxTreeItemIcon_SelectedExpanded | 3 |
/// | wxTreeItemIcon_Max | 4 |
/// | wxTREE_ITEMSTATE_NONE | -1 |
/// | wxTREE_ITEMSTATE_NEXT | -2 |
/// | wxTREE_ITEMSTATE_PREV  | -3 |
/// 
/// # Window style constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxTR_NO_BUTTONS | 0x0000 |
/// | wxTR_HAS_BUTTONS | 0x0001 (the default) |
/// | wxTR_NO_LINES | 0x0004 |
/// | wxTR_LINES_AT_ROOT | 0x0008 |
/// | wxTR_TWIST_BUTTONS | 0x0010 (don't use plus/minus) |
/// | wxTR_SINGLE | 0x0000 (the default) |
/// | wxTR_MULTIPLE  | 0x0020 (not supported in wxDart Flutter) |
/// | wxTR_HAS_VARIABLE_ROW_HEIGHT | 0x0080 |
/// | wxTR_EDIT_LABELS | 0x0200 (not supported in wxDart Flutter) |
/// | wxTR_ROW_LINES | 0x0400 |
/// | wxTR_HIDE_ROOT | 0x0800 |
/// | wxTR_FULL_ROW_HIGHLIGHT | 0x2000 |
/// | wxTR_DEFAULT_STYLE  | (wxTR_HAS_BUTTONS \| wxTR_NO_LINES \| wxTR_FULL_ROW_HIGHLIGHT) |
/// 
/// In wxDart Native, many of the tree events can be veto by calling [WxTreeEvent.veto]. This
/// is not yet implemented in wxDart Flutter.
///
/// Events emitted:
/// [TreeSelChanged](/wxdart/wxGetTreeSelChangedEventType.html) event gets sent when the selection has changed. |
/// | ----------------- |
/// | void bindTreeSelChangedEvent( void Function( WxTreeEvent event ), int id |
/// | void unbindTreeSelChangedEvent() |
/// 
/// [TreeSelChanging](/wxdart/wxGetTreeSelChangingEventType.html) event gets sent when the selection is about to change. |
/// | ----------------- |
/// | void bindTreeSelChangingEvent( void Function( WxTreeEvent event ), int id  ) |
/// | void unbindTreeSelChangingEvent() |
///
/// [TreeDeleteItem](/wxdart/wxGetTreeDeleteItemEventType.html) event gets sent when an item has been deleted. |
/// | ----------------- |
/// | void bindTreeDeleteItemEvent( void Function( WxTreeEvent event ), int id  ) |
/// | void unbindTreeDeleteItemEvent() |
/// 
/// [TreeItemActivated](/wxdart/wxGetTreeItemActivatedEventType.html) event gets sent when an item was activated (ENTER or double click) |
/// | ----------------- |
/// | void bindTreeItemActivatedEvent( void Function( WxTreeEvent event ), int id  ) |
/// | void unbindTreeItemActivatedEvent() |
/// 
/// [TreeItemExpanded](/wxdart/wxGetTreeItemExpandedEventType.html) event gets sent when a tree item was expanded |
/// | ----------------- |
/// | void bindTreeItemExpandedEvent( void Function( WxTreeEvent event ), int id  ) |
/// | void unbindTreeItemExpandedEvent() |
/// 
/// [TreeItemExpanding](/wxdart/wxGetTreeItemExpandingEventType.html) event gets sent when a tree item is about to be expanded |
/// | ----------------- |
/// | void bindTreeItemExpandingEvent( void Function( WxTreeEvent event ), int id  ) |
/// | void unbindTreeItemExpandingEvent() |
/// 
/// [TreeItemCollapsed](/wxdart/wxGetTreeItemCollapsedEventType.html) event gets sent when a tree item was collapsed|
/// | ----------------- |
/// | void bindTreeItemCollapsedEvent( void Function( WxTreeEvent event ), int id  ) |
/// | void unbindTreeItemCollapsedEvent() |
/// 
/// [TreeItemCollapsing](/wxdart/wxGetTreeItemCollapsingEventType.html) event gets sent when a tree item is about to be collapsed |
/// | ----------------- |
/// | void bindTreeItemCollapsingEvent( void Function( WxTreeEvent event ), int id  ) |
/// | void unbindTreeItemCollapsingEvent() |
///
/// [TreeItemMenu](/wxdart/wxGetTreeItemMenuEventType.html) event gets sent when a menu should be shown. |
/// | ----------------- |
/// | void bindTreeItemMenuEvent( void Function( WxTreeEvent event ), int id  ) |
/// | void unbindTreeItemMenuEvent() |
/// 
/// [TreeItemRightClick](/wxdart/wxGetTreeItemRightClickEventType.html) event gets sent when a right click occured on an item. |
/// | ----------------- |
/// | void bindTreeItemRightClickEvent( void Function( WxTreeEvent event ), int id  ) |
/// | void unbindTreeItemRightClickEvent() |
/// 
/// [TreeBeginDrag](/wxdart/wxGetTreeBeginDragEventType.html) event gets sent when a drag begins. |
/// | ----------------- |
/// | void bindTreeBeginDragEvent( void Function( WxTreeEvent event ), int id  ) |
/// | void unbindTreeBeginDragEvent() |
/// 
/// [TreeBeginRDrag](/wxdart/wxGetTreeBeginRDragEventType.html) event gets sent when a right mouse drag begins. |
/// | ----------------- |
/// | void bindTreeBeginRDragEvent( void Function( WxTreeEvent event ), int id  ) |
/// | void unbindTreeBeginRDragEvent() |
/// 
/// [TreeEndDrag](/wxdart/wxGetTreeEndDragEventType.html) event gets sent when a drag ends.  |
/// | ----------------- |
/// | void bindTreeEndDragEvent( void Function( WxTreeEvent event ), int id  ) |
/// | void unbindTreeEndDragEvent() |
/// 
/// [TreeBeginLabelEdit](/wxdart/wxGetTreeBeginLabelEditEventType.html) event gets sent when in-place editing being. |
/// | ----------------- |
/// | void bindTreeBeginLabelEditEvent( void Function( WxTreeEvent event ), int id  ) |
/// | void unbindTreeBeginLabelEditEvent() |
/// 
/// [TreeEndLabelEdit](/wxdart/wxGetTreeEndLabelEditEventType.html) event gets sent when in-place editing ended. |
/// | ----------------- |
/// | void bindTreeEndLabelEditEvent( void Function( WxTreeEvent event ), int id  ) |
/// | void unbindTreeEndLabelEditEvent() |

class WxTreeCtrl extends WxControl {
  /// Creates the tree. In wxDart Web, it is drawn by the generic
  /// [WxDataViewCtrl] (with one column and no header).
  WxTreeCtrl( super.parent, super.id, { super.pos = wxDefaultPosition, super.size = wxDefaultSize, super.style = wxTR_DEFAULT_STYLE } ) {
    int dvStyle = wxDV_NO_HEADER;
    if (hasFlag( wxTR_MULTIPLE )) dvStyle |= wxDV_MULTIPLE;
    if (hasFlag( wxTR_ROW_LINES )) dvStyle |= wxDV_HORIZ_RULES;
    _viewOrNull = WxDataViewCtrl( this, -1, style: dvStyle );
    _model = _WxTreeModel( this );
    _view.associateModel( _model );
    _view.appendColumn( WxDataViewColumn( "", WxDataViewIconTextRenderer(), 0, width: 100, flags: 0 ) );

    _view.bindDataViewSelectionChangedEvent( (event) {
      _send( wxGetTreeSelChangedEventType(), getSelection() );
    }, -1 );
    _view.bindDataViewItemActivatedEvent( (event) {
      _send( wxGetTreeItemActivatedEventType(), _toTree( event.getItem() ) );
    }, -1 );
    _view.bindDataViewItemExpandedEvent( (event) {
      _send( wxGetTreeItemExpandedEventType(), _toTree( event.getItem() ) );
    }, -1 );
    _view.bindDataViewItemCollapsedEvent( (event) {
      _send( wxGetTreeItemCollapsedEventType(), _toTree( event.getItem() ) );
    }, -1 );
    final size = getSize();
    _view._setActualRect( 0, 0, size.x, size.y );
  }

  // null while the WxWindow constructor runs (it already sends a size event)
  WxDataViewCtrl? _viewOrNull;
  WxDataViewCtrl get _view => _viewOrNull!;
  late _WxTreeModel _model;
  _WxTreeNode? _root;
  List<WxBitmapBundle> _images = [];
  final List<WxBitmap> _bitmaps = [];
  int _spacing = 10;

  // ---------------- internals

  @override
  WxSize _doGetBestSize() {
    return const WxSize( 50, 50 );
  }

  @override
  void _sendSizeEvent() {
    final size = getSize();
    _viewOrNull?._setActualRect( 0, 0, size.x, size.y );
    super._sendSizeEvent();
  }

  @override
  void setFocus() {
    _viewOrNull?.setFocus();
  }

  void _send( int type, WxTreeItemId item ) {
    final event = WxTreeEvent( type, this, item );
    // the label of the item (the event class is shared with wxDart Flutter)
    event._label = item.isOk() && !item._isInvisibleRoot ? item._node!.label : '';
    processEvent( event );
  }

  WxTreeItemId _toTree( WxDataViewItem item ) {
    if (!item.isOk()) return WxTreeItemId();
    return WxTreeItemId._( item.getID() as _WxTreeNode );
  }

  WxDataViewItem _toView( WxTreeItemId item ) {
    final node = item._node;
    if (node == null) return WxDataViewItem();
    if (node == _root && hasFlag( wxTR_HIDE_ROOT )) return WxDataViewItem();
    return WxDataViewItem( id: node );
  }

  /// The item that the view knows as the parent of [node]
  WxDataViewItem _viewParent( _WxTreeNode node ) {
    final parent = node.parent;
    if (parent == null) return WxDataViewItem();
    return _toView( WxTreeItemId._( parent ) );
  }

  bool _isShownInView( _WxTreeNode node ) {
    return !(node == _root && hasFlag( wxTR_HIDE_ROOT ));
  }

  WxBitmap? _bitmapFor( _WxTreeNode node ) {
    int index = node.image;
    if (node.selImage >= 0 && isSelected( WxTreeItemId._( node ) )) index = node.selImage;
    if (index < 0 || index >= _bitmaps.length) return null;
    return _bitmaps[index];
  }

  _WxTreeNode? _nodeOf( WxTreeItemId item ) {
    if (!item.isOk()) {
      wxLogError( "invalid tree item" );
      return null;
    }
    if (item._isInvisibleRoot) return _root;
    return item._node;
  }

  void _changed( _WxTreeNode node ) {
    if (_isShownInView( node )) _model.itemChanged( WxDataViewItem( id: node ) );
  }

  // ---------------- images, indentation

  /// Sets image list to be used by the control
  void setImages( List<WxBitmapBundle> images ) {
    _images = images;
    _bitmaps.clear();
    for (final bundle in images) {
      _bitmaps.add( bundle.getBitmapFor( this ) );
    }
    _view.refresh();
  }

  /// Returns true of there are images in the image list
  bool hasImages( ) {
    return _images.isNotEmpty;
  }

  /// Returns number of images in the image list
  int getImageCount( ) {
    return _images.length;
  }

  /// Sets the space between the buttons (+/-) and the images
  void setSpacing( int spacing ) {
    _spacing = spacing;
  }

  /// Retrns the space between the buttons (+/-) and the images
  int getSpacing( ) {
    return _spacing;
  }

  /// Sets indentation per tree branch depth
  void setIndent( int indent ) {
    _view.setIndent( indent );
  }

  /// Returns current indentation
  int getIndent( ) {
    return _view.getIndent();
  }

  // ---------------- adding and deleting

  /// Creates the root node and returns it
  WxTreeItemId addRoot( String text, { int image = -1, int selImage = -1, dynamic data } )
  {
    if (_root != null) {
      wxLogError( "WxTreeCtrl can only have one root item" );
      return WxTreeItemId._( _root );
    }
    _root = _WxTreeNode( text, image, selImage, data, null );
    if (_isShownInView( _root! )) {
      _model.itemAdded( WxDataViewItem(), WxDataViewItem( id: _root ) );
    }
    return WxTreeItemId._( _root );
  }

  /// Appends a new item with text and optional image to [parent]
  WxTreeItemId appendItem( WxTreeItemId parent, String text, { int image = -1, int selImage = -1, dynamic data } )
  {
    final p = _nodeOf( parent );
    if (p == null) return WxTreeItemId();
    return _insert( p, p.children.length, text, image, selImage, data );
  }

  /// Prepends a new item with text and optional image to [parent]
  WxTreeItemId prependItem( WxTreeItemId parent, String text, { int image = -1, int selImage = -1, dynamic data } )
  {
    return insertItem( parent, 0, text, image: image, selImage: selImage, data: data );
  }

  /// Inserts a new item with text and optional image to [parent]
  WxTreeItemId insertItem( WxTreeItemId parent, int pos, String text, { int image = -1, int selImage = -1, dynamic data } )
  {
    final p = _nodeOf( parent );
    if (p == null) return WxTreeItemId();
    return _insert( p, pos.clamp( 0, p.children.length ), text, image, selImage, data );
  }

  /// Inserts a new item with text and optional image to [parent] after child item [previous]
  WxTreeItemId insertItemAfter( WxTreeItemId parent, WxTreeItemId previous, String text, { int image = -1, int selImage = -1, dynamic data } )
  {
    final p = _nodeOf( parent );
    if (p == null) return WxTreeItemId();
    final pos = previous._node == null ? 0 : p.children.indexOf( previous._node! ) + 1;
    return _insert( p, pos, text, image, selImage, data );
  }

  WxTreeItemId _insert( _WxTreeNode parent, int pos, String text, int image, int selImage, dynamic data ) {
    final node = _WxTreeNode( text, image, selImage, data, parent );
    final wasContainer = parent.children.isNotEmpty || parent.hasButton;
    parent.children.insert( pos, node );
    if (!wasContainer && _isShownInView( parent )) {
      // the parent gets an expander
      _model.itemChanged( WxDataViewItem( id: parent ) );
    }
    _model.itemAdded( _viewParent( node ), WxDataViewItem( id: node ) );
    return WxTreeItemId._( node );
  }

  void _sendDeleteEvents( _WxTreeNode node ) {
    for (final child in node.children) {
      _sendDeleteEvents( child );
    }
    _send( wxGetTreeDeleteItemEventType(), WxTreeItemId._( node ) );
  }

  /// Deletes [item]
  void delete( WxTreeItemId item )
  {
    final node = _nodeOf( item );
    if (node == null) return;
    _sendDeleteEvents( node );
    if (node == _root) {
      _root = null;
      _model.cleared();
      return;
    }
    final parent = node.parent!;
    final viewParent = _viewParent( node );
    parent.children.remove( node );
    node.parent = null;
    _model.itemDeleted( viewParent, WxDataViewItem( id: node ) );
    if (parent.children.isEmpty && !parent.hasButton) _changed( parent );
  }

  /// Deletes all child items of [item]
  void deleteChildren( WxTreeItemId item )
  {
    final node = _nodeOf( item );
    if (node == null) return;
    for (final child in List.of( node.children )) {
      delete( WxTreeItemId._( child ) );
    }
  }

  /// Deletes all items
  void deleteAllItems( )
  {
    if (_root != null) delete( WxTreeItemId._( _root ) );
  }

  // ---------------- navigation

  /// Returns number of all items
  int getCount( ) {
    if (_root == null) return 0;
    return 1 + _countRecursive( _root! );
  }

  int _countRecursive( _WxTreeNode node ) {
    int count = node.children.length;
    for (final child in node.children) {
      count += _countRecursive( child );
    }
    return count;
  }

  /// Returns number of child items of [item]
  ///
  /// Counts recursively into tree branches depending on [recursively]
  int getChildrenCount( WxTreeItemId item, {bool recursively=true} ) {
    final node = _nodeOf( item );
    if (node == null) return 0;
    return recursively ? _countRecursive( node ) : node.children.length;
  }

  /// Ensures the [item] is visible (scrolls if necessary)
  void ensureVisible( WxTreeItemId item )
  {
    final view = _toView( item );
    if (view.isOk()) _view.ensureVisible( view, null );
  }

  /// Scrolls [item] into view
  void scrollTo( WxTreeItemId item )
  {
    ensureVisible( item );
  }

  /// Returns the root item
  WxTreeItemId getRootItem( )
  {
    return _root == null ? WxTreeItemId() : WxTreeItemId._( _root );
  }

  /// Returns the parent item or an invalid [WxTreeItemId]
  WxTreeItemId getItemParent( WxTreeItemId item )
  {
    final node = _nodeOf( item );
    if (node == null || node.parent == null) return WxTreeItemId();
    return WxTreeItemId._( node.parent );
  }

  /// Returns the first child of [parent] or an invalid [WxTreeItemId]
  WxTreeItemId getFirstChild( WxTreeItemId parent )
  {
    final node = _nodeOf( parent );
    if (node == null || node.children.isEmpty) return WxTreeItemId();
    return WxTreeItemId._( node.children.first );
  }

  /// Returns the last child of [parent] or an invalid [WxTreeItemId]
  WxTreeItemId getLastChild( WxTreeItemId parent )
  {
    final node = _nodeOf( parent );
    if (node == null || node.children.isEmpty) return WxTreeItemId();
    return WxTreeItemId._( node.children.last );
  }

  /// Returns the next sibling of [item] or an invalid [WxTreeItemId]
  WxTreeItemId getNextSibling( WxTreeItemId item )
  {
    final node = _nodeOf( item );
    final parent = node?.parent;
    if (node == null || parent == null) return WxTreeItemId();
    final i = parent.children.indexOf( node );
    return i + 1 < parent.children.length ? WxTreeItemId._( parent.children[i + 1] ) : WxTreeItemId();
  }

  /// Returns the previous sibling of [item] or an invalid [WxTreeItemId]
  WxTreeItemId getPrevSibling( WxTreeItemId item )
  {
    final node = _nodeOf( item );
    final parent = node?.parent;
    if (node == null || parent == null) return WxTreeItemId();
    final i = parent.children.indexOf( node );
    return i > 0 ? WxTreeItemId._( parent.children[i - 1] ) : WxTreeItemId();
  }

  // ---------------- focus and selection

  WxTreeItemId getFocusedItem( ) {
    return _toTree( _view.getCurrentItem() );
  }

  /// Sets the focus to [item]
  ///
  /// Not available in wxDart Flutter
  void setFocusedItem( WxTreeItemId item ) {
    _view.setCurrentItem( _toView( item ) );
  }

  /// Clears the focus to [item]
  ///
  /// Not available in wxDart Flutter
  void clearFocusedItem( ) {
    _view.setCurrentItem( WxDataViewItem() );
  }

  /// Returns the currently selected item, or an invalid item
  WxTreeItemId getSelection( ) {
    return _toTree( _view.getSelection() );
  }

  /// Returns the selected items (multiple selection mode)
  List<WxTreeItemId> getSelections( ) {
    final List<WxDataViewItem> list = [];
    _view.getSelections( list );
    return list.map( _toTree ).toList();
  }

  /// Returns true if [item] is currently selected
  bool isSelected( WxTreeItemId item )
  {
    final view = _toView( item );
    return view.isOk() && _view.isSelected( view );
  }

  /// Selects [item]
  ///
  /// If [select] is true, then this will unselect the previously selected item
  /// in single selection mode - and not do anything in if [select] is false.
  ///
  /// Multiple selection mode is not available in wxDart Flutter
  void selectItem( WxTreeItemId item, { bool select = true } )
  {
    final view = _toView( item );
    if (!view.isOk()) return;
    if (!select) {
      _view.unselect( view );
      return;
    }
    if (!hasFlag( wxTR_MULTIPLE )) _view.unselectAll();
    _view.select( view );
    _view.setCurrentItem( view );
  }

  /// Unselect [item] in multiple selection mode
  ///
  /// Not available in wxDart Flutter
  void unselectItem( WxTreeItemId item ) {
    selectItem( item, select: false );
  }

  void unselectAll( ) {
    _view.unselectAll();
  }

  /// Select all child item of [item] in multiple selection mode
  ///
  /// Not available in wxDart Flutter
  void selectChildren( WxTreeItemId item ) {
    final node = _nodeOf( item );
    if (node == null || !hasFlag( wxTR_MULTIPLE )) return;
    _view.unselectAll();
    for (final child in node.children) {
      _view.select( WxDataViewItem( id: child ) );
    }
  }

  /// See [selectItem]
  void toggleItemSelection( WxTreeItemId item ) {
    selectItem( item, select: !isSelected( item ) );
  }

  // ---------------- expanding and collapsing

  /// Returns true if [item] has children and is expanded
  bool isExpanded( WxTreeItemId item )
  {
    final view = _toView( item );
    if (!view.isOk()) return item.isOk();   // the hidden root is always expanded
    return _view.isExpanded( view );
  }

  /// Returns true if the [item] has any children
  bool itemHasChildren( WxTreeItemId item )
  {
    final node = _nodeOf( item );
    return node != null && (node.children.isNotEmpty || node.hasButton);
  }

  /// Shows an expander even if [item] has no children yet, e.g. to add
  /// them when the item gets expanded
  void setItemHasChildren( WxTreeItemId item, { bool has = true } ) {
    final node = _nodeOf( item );
    if (node == null) return;
    node.hasButton = has;
    _changed( node );
  }

  /// Expands tree branch
  void expand( WxTreeItemId item )
  {
    final view = _toView( item );
    if (view.isOk()) _view.expand( view );
  }

  /// Expands all branches of the tree control
  void expandAll()
  {
    if (_root != null) expandAllChildren( WxTreeItemId._( _root ) );
  }

  /// Expands all branches of the tree control
  void expandAllChildren( WxTreeItemId item )
  {
    final node = _nodeOf( item );
    if (node == null) return;
    expand( item );
    for (final child in node.children) {
      if (child.children.isNotEmpty) expandAllChildren( WxTreeItemId._( child ) );
    }
  }

  /// Expands or collapses [item] depending on what it was before
  void toggle( WxTreeItemId item )
  {
    if (isExpanded( item )) {
      collapse( item );
    } else {
      expand( item );
    }
  }

  /// Collapses [item]
  void collapse( WxTreeItemId item )
  {
    final view = _toView( item );
    if (view.isOk()) _view.collapse( view );
  }

  /// Collapses [item] and deletes the child items
  void collapseAndReset( WxTreeItemId item )
  {
    collapse( item );
    deleteChildren( item );
  }

  /// Collapses all items
  void collapseAll( )
  {
    if (_root != null) collapseAllChildren( WxTreeItemId._( _root ) );
  }

  /// Collapses all child items of [item]
  void collapseAllChildren( WxTreeItemId item )
  {
    final node = _nodeOf( item );
    if (node == null) return;
    for (final child in node.children) {
      if (child.children.isNotEmpty) collapseAllChildren( WxTreeItemId._( child ) );
    }
    collapse( item );
  }

  // ---------------- item properties

  /// Sets the text of an item
  void setItemText( WxTreeItemId item, String text ) {
    final node = _nodeOf( item );
    if (node == null) return;
    node.label = text;
    _changed( node );
  }

  /// Returns the text of an item
  String getItemText( WxTreeItemId item ) {
    final node = _nodeOf( item );
    return node?.label ?? "";
  }

  /// Attaches user defined data (client data to an item)
  void setItemData( WxTreeItemId item, dynamic data ) {
    final node = _nodeOf( item );
    if (node != null) node.data = data;
  }

  /// Returns user defined data (client data to an item) or null
  dynamic getItemData( WxTreeItemId item ) {
    if (!item.isOk()) return null;
    return _nodeOf( item )?.data;
  }

  /// Sets the image of [item]; [which] is wxTreeItemIcon_Normal or
  /// wxTreeItemIcon_Selected
  void setItemImage( WxTreeItemId item, int image, { int which = wxTreeItemIcon_Normal } ) {
    final node = _nodeOf( item );
    if (node == null) return;
    if (which == wxTreeItemIcon_Selected) {
      node.selImage = image;
    } else {
      node.image = image;
    }
    _changed( node );
  }

  int getItemImage( WxTreeItemId item, { int which = wxTreeItemIcon_Normal } ) {
    final node = _nodeOf( item );
    if (node == null) return -1;
    return which == wxTreeItemIcon_Selected ? node.selImage : node.image;
  }

  void setItemBold( WxTreeItemId item, { bool bold = true } ) {
    final node = _nodeOf( item );
    if (node == null) return;
    node.bold = bold;
    _changed( node );
  }

  bool isBold( WxTreeItemId item ) {
    return _nodeOf( item )?.bold ?? false;
  }

  void setItemTextColour( WxTreeItemId item, WxColour colour ) {
    final node = _nodeOf( item );
    if (node == null) return;
    node.textColour = colour;
    _changed( node );
  }

  void setItemBackgroundColour( WxTreeItemId item, WxColour colour ) {
    final node = _nodeOf( item );
    if (node == null) return;
    node.backgroundColour = colour;
    _changed( node );
  }
}
