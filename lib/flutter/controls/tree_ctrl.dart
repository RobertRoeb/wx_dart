// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxTreeEvent ----------------------

typedef OnTreeEventFunc = void Function( WxTreeEvent event );

/// @nodoc

class WxTreeEventTableEntry extends WxEventTableEntry {
  WxTreeEventTableEntry( super.eventType, super.id, this.func );
  final OnTreeEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return (eventType == eventTypeTested) && ((id == wxID_ANY) || (id == idTested));
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxTreeEvent) {
      func( event );
    }
  }
}

/// @nodoc

extension TreeItemActivatedEventBinder on WxEvtHandler {
  void bindTreeItemActivatedEvent( OnTreeEventFunc func, int id ) {
    _eventTable.add( WxTreeEventTableEntry(wxGetTreeItemActivatedEventType(), id, func));
  }

  void unbindTreeItemActivatedEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetTreeItemActivatedEventType(), id));
  }
}

/// @nodoc

extension TreeSelChangedEventBinder on WxEvtHandler {
  void bindTreeSelChangedEvent( OnTreeEventFunc func, int id ) {
    _eventTable.add( WxTreeEventTableEntry(wxGetTreeSelChangedEventType(), id, func));
  }

  void unbindTreeSelChangedEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetTreeSelChangedEventType(), id));
  }
}

/// @nodoc

extension TreeItemExpandedEventBinder on WxEvtHandler {
  void bindTreeItemExpandedEvent( OnTreeEventFunc func, int id ) {
    _eventTable.add( WxTreeEventTableEntry(wxGetTreeItemExpandedEventType(), id, func));
  }

  void unbindTreeItemExpandedEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetTreeItemExpandedEventType(), id));
  }
}

/// @nodoc

extension TreeItemCollapsedEventBinder on WxEvtHandler {
  void bindTreeItemCollapsedEvent( OnTreeEventFunc func, int id ) {
    _eventTable.add( WxTreeEventTableEntry(wxGetTreeItemCollapsedEventType(), id, func));
  }

  void unbindTreeItemCollapsedEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetTreeItemCollapsedEventType(), id));
  }
}

/// @nodoc

extension TreeDeleteItemEventBinder on WxEvtHandler {
  void bindTreeDeleteItemEvent( OnTreeEventFunc func, int id ) {
    _eventTable.add( WxTreeEventTableEntry(wxGetTreeDeleteItemEventType(), id, func));
  }

  void unbindTreeDeleteItemEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetTreeDeleteItemEventType(), id));
  }
}

/// Event emitted by [WxTreeCtrl]

class WxTreeEvent extends WxNotifyEvent {
  WxTreeEvent( int eventType, WxTreeCtrl tree, WxTreeItemId item ) : super( eventType, tree.getId() ) {
    setClientData( tree.getItemData( item ) );
    _item = item;
  }
  
  // late final WxTreeCtrl _treectrl;
  late final WxTreeItemId _item;
  String _label = '';

  WxTreeItemId getItem( ) {
    return _item;
  }

  String getLabel( ) {
    return _label;
  }

  void setLabel( String label ) {
    _label = label;
  }

  WxPoint getPoint( ) {
    return wxDefaultPosition;
  }

  bool isEditCancelled( ) {
    return true;
  }
}

// ------------------------ wxTreeCtrl -----------------------

/// @nodoc

class WxTreeItemNode {
  WxTreeItemNode( this.label, this.image, this.selImage, this.data );
  String label;
  int image;
  int selImage;
  bool selected = false;
  dynamic data;
}

/// Opaque item representing an item in a [WxTreeCtrl]
class WxTreeItemId {
  WxTreeItemId( { TreeSliverNode<WxTreeItemNode>? node } ) {
    _node = node;
  }

  WxTreeItemId._asInvisibleRoot() {
    _node = null;
    _invisibleRoot = true;
  }

  TreeSliverNode<WxTreeItemNode>? _getNode() {
    return _node;
  }

  bool isOk() {
    return (_node != null) || _invisibleRoot;
  }

  bool _isInvisibleRoot() {
    return _invisibleRoot;
  }

  TreeSliverNode<WxTreeItemNode>? _node;
  bool _invisibleRoot = false;
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
class WxTreeCtrl extends WxControl {
  WxTreeCtrl( super.parent, super.id, { super.pos = wxDefaultPosition, super.size = wxDefaultSize, super.style = wxTR_DEFAULT_STYLE } );

  final TreeSliverController _controller = TreeSliverController();
  final ScrollController _scrollController = ScrollController();
  final List<TreeSliverNode<WxTreeItemNode>> _root = [];
  TreeSliverNode<WxTreeItemNode>? _selected;
  DateTime? _lastTap;
  int _indent = 10;
  int _spacing = 10;
  bool _found = false; 

  List<WxBitmapBundle>_images = [];
  final List<WxBitmap>_bitmaps = [];

  TreeSliverNode<WxTreeItemNode>? _getParentNodeRecursive( 
      final List<TreeSliverNode<WxTreeItemNode>> current,
      final TreeSliverNode<WxTreeItemNode>? parent,
      final TreeSliverNode<WxTreeItemNode> child )
  {
    if (current.contains(child)) {
      _found = true;
      return parent;
    }
    for (final item in current)
    {
      final ret = _getParentNodeRecursive( item.children, item, child );
      if (_found) {
        return ret;
      }
    }
    return null;
  }

  TreeSliverNode<WxTreeItemNode>? _getParentNode( TreeSliverNode<WxTreeItemNode> child )
  {
    // returns null for children of the invisble root item
    _found = false;
    final ret = _getParentNodeRecursive( _root, null, child );
    if (_found) {
      return ret;
    }
    return null;
  }

  /// Sets image list to be used by the control
  void setImages( List<WxBitmapBundle> images ) {
    _images = images;
    _rebuildBitmaps();
  }

  /// Returns true of there are images in the image list
  bool hasImages( ) {
    return _images.isNotEmpty;
  }

  /// Returns number of images in the image list
  int getImageCount( ) {
    return _images.length;
  }

  void _rebuildBitmaps() {
    _bitmaps.clear();
    for (final bundle in _images) {
      _bitmaps.add( bundle.getBitmapFor(this) );
    }
    _setState();
  }
  @override
  void _updateTheme() {
    _rebuildBitmaps();
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
    _indent = indent;
  }

  /// Returns current indentation 
  int getIndent( ) {
    return _indent;
  }

  /// Creates the root node and returns it
  WxTreeItemId addRoot( String text, { int image = -1, int selImage = -1, dynamic data } )
  {
    if (hasFlag( wxTR_HIDE_ROOT )) {
      return WxTreeItemId._asInvisibleRoot();
    }
    final node = TreeSliverNode<WxTreeItemNode>( 
      WxTreeItemNode(text, image, selImage, data ) );
    _root.add( node );
    _setState();
    return WxTreeItemId( node: node );
  }

  /// Appends a new item with text and optional image to [parent]
  WxTreeItemId appendItem( WxTreeItemId parent, String text, { int image = -1, int selImage = -1, dynamic data } )
  {
    if (!parent.isOk()) {
      wxLogError( "invalid parent tree item in appendItem" );
      return WxTreeItemId();
    }
    final node = TreeSliverNode<WxTreeItemNode>( 
      WxTreeItemNode(text, image, selImage, data) );
    if (parent._isInvisibleRoot()) {
      _root.add( node );
    } else {
      parent._getNode()!.children.add( node );
    }
    _setState();
    return WxTreeItemId( node: node );
  }

  /// Prepends a new item with text and optional image to [parent]
  WxTreeItemId prependItem( WxTreeItemId parent, String text, { int image = -1, int selImage = -1, dynamic data } )
  {
    return insertItem( parent, 0, text, image: image, selImage: selImage, data: data );
  }

  /// Inserts a new item with text and optional image to [parent]
  WxTreeItemId insertItem( WxTreeItemId parent, int pos, String text, { int image = -1, int selImage = -1, dynamic data } )
  {
    if (!parent.isOk()) {
      wxLogError( "invalid parent tree item in insertItem" );
      return WxTreeItemId();
    }
    final node = TreeSliverNode<WxTreeItemNode>( 
      WxTreeItemNode(text, image, selImage, data) );

    if (parent._isInvisibleRoot()) {
      _root.insert( pos, node );
    } else {
      parent._getNode()!.children.insert( pos, node );
    }
    _setState();
    return WxTreeItemId( node: node );
  }

  /// Inserts a new item with text and optional image to [parent] after child item [previous]
  WxTreeItemId insertItemAfter( WxTreeItemId parent, WxTreeItemId previous, String text, { int image = -1, int selImage = -1, dynamic data } )
  {
    if (!parent.isOk()) {
      wxLogError( "invalid parent tree item in insertItemAfter" );
      return WxTreeItemId();
    }
    if (!previous.isOk() || previous._isInvisibleRoot()) {
      wxLogError( "invalid previous tree item" );
      return WxTreeItemId();
    }
    int pos = wxNOT_FOUND;
    bool isLast = false;
    if (parent._isInvisibleRoot()) {
      pos = _root.indexOf( previous._node! );
      isLast = _root.last == previous._node!;
    } else {
      pos = parent._getNode()!.children.indexOf( previous._node! );
      isLast = parent._getNode()!.children.last == previous._node!;
    }
    if (pos < 0) {
      wxLogError( "previous not child of parent item" );
      return WxTreeItemId();
    }
    if (isLast) {
      prependItem( parent, text, image: image, selImage: selImage, data: data );  
    } else {
      insertItem( parent, pos, text, image: image, selImage: selImage, data: data );    
    }
    return WxTreeItemId();
  }

  /// Deletes [item]
  void delete( WxTreeItemId item )
  {
    if (!item.isOk()) {
      wxLogError( "invalid tree item" );
      return;
    }
    if (item._isInvisibleRoot()) {
      wxLogError( "cannot delete invisible root item" );
      return;
    }

      if (isSelected( item )) {
        final prev = getPrevSibling(item);
        if (prev.isOk()) {
          selectItem(prev);
        } else {
          final parent = getItemParent(item);
          if (parent.isOk()) {
            selectItem(parent);
          } else {
            _selected = null;
          }
        }
      }

    final node = item._getNode();
    if (node == null) return;
    final parent = _getParentNode( node );
    if (parent != null)
    {
      final event = WxTreeEvent( wxGetTreeDeleteItemEventType(), this, item );
      event.setEventObject( this );
      processEvent(event);
      parent.children.remove( node );
    }
    else
    {
      if (hasFlag(wxTR_HIDE_ROOT)) 
      {
        final event = WxTreeEvent( wxGetTreeDeleteItemEventType(), this, item );
        event.setEventObject( this );
        processEvent(event);
        _root.remove( node );
      }
    }
    _setState();
  }

  /// Deletes all child items of [item]
  void deleteChildren( WxTreeItemId item )
  {
    final node = item._getNode();
    if (node == null) return;
    if (node.children.isEmpty) return;
    _controller.collapseNode(node);
    for (final child in node.children) {
      final event = WxTreeEvent( wxGetTreeDeleteItemEventType(), this, WxTreeItemId( node: child ) );
      event.setEventObject( this );
      processEvent(event);
    }
    node.children.clear();
    _setState();
  }

  void _sendDeleteEvents( List<TreeSliverNode<WxTreeItemNode>> current )
  {
    for (final child in current) {
      _sendDeleteEvents( child.children );
      final event = WxTreeEvent( wxGetTreeDeleteItemEventType(), this, WxTreeItemId( node: child ) );
      event.setEventObject( this );
      processEvent(event);
    }
  }

  /// Deletes all items
  void deleteAllItems( )
  {
    _selected = null;
    _sendDeleteEvents( _root );
    _root.clear();
    _setState();
  }

  int _getChildrenCount( List<TreeSliverNode<WxTreeItemNode>> current )
  {
    int count = 0;
    for (final child in current) {
      count += _getChildrenCount( child.children );
    }
    return count + 1;
  }

  /// Returns number of all items
  int getCount( ) {
    return _getChildrenCount( _root );
  }

  /// Returns number of child items of [item]
  /// 
  /// Counts recursively into tree branches depending on [recursively]
  int getChildrenCount( WxTreeItemId item, {bool recursively=true} ) {
    final node = item._getNode();
    if (node == null) return 0;
    if (recursively) {
      return _getChildrenCount( node.children );
    }
    return node.children.length;
  }

  /// Ensures the [item] is visible (scrolls if necessary)
  void ensureVisible( WxTreeItemId item )
  {
    if (item._isInvisibleRoot()) {
      wxLogError( "make invisible root item visible" );
      return;
    }
    final node = item._getNode();
    if (node == null) return;
    final index = _controller.getActiveIndexFor(node);
    if (index == null) return;
    // _controller.scrollToItem( node );
  }

  /// Returns the root item
  WxTreeItemId getRootItem( )
  {
    if (hasFlag(wxTR_HIDE_ROOT)) {
      return WxTreeItemId._asInvisibleRoot();
    }
    if (_root.isEmpty) {
      wxLogError( "no root item yet" );
      return WxTreeItemId();
    }
    return WxTreeItemId( node: _root.first );
  }

  /// Returns the parent item or an invalid [WxTreeItemId]
  WxTreeItemId getItemParent( WxTreeItemId item )
  {
    if (!item.isOk()) {
      wxLogError( "invalid tree item" );
      return WxTreeItemId();
    }
    if (item._isInvisibleRoot()) {
      return WxTreeItemId();
    }
    final parentNode = _getParentNode( item._node! );
    if (parentNode == null)
    {
      if (hasFlag(wxTR_HIDE_ROOT)) {
        // assume children of invisible root
        return WxTreeItemId._asInvisibleRoot();
      } else {
        // something went wrong
        // wxLogError( "no parent found" );
        return WxTreeItemId();
      }
    }
    return WxTreeItemId( node: parentNode );
  }

  /// Returns the first child of [parent] or an invalid [WxTreeItemId]
  WxTreeItemId getFirstChild( WxTreeItemId parent )
  {
    if (!parent.isOk()) {
      wxLogError( "invalid tree item" );
      return WxTreeItemId();
    }
    if (parent._isInvisibleRoot()) {
      if (_root.isEmpty) return WxTreeItemId();  
      final firstChildNode = _root.first;
      return WxTreeItemId( node: firstChildNode );
    } else {
      if (parent._node!.children.isEmpty) return WxTreeItemId();  
      final firstChildNode = parent._node!.children.first;
      return WxTreeItemId( node: firstChildNode );
    }
  }

  /// Returns the last child of [parent] or an invalid [WxTreeItemId]
  WxTreeItemId getLastChild( WxTreeItemId parent )
  {
    if (!parent.isOk()) {
      wxLogError( "invalid tree item" );
      return WxTreeItemId();
    }
    if (parent._isInvisibleRoot()) {
      if (_root.isEmpty) return WxTreeItemId();  
      final firstChildNode = _root.last;
      return WxTreeItemId( node: firstChildNode );
    } else {
      if (parent._node!.children.isEmpty) return WxTreeItemId();  
      final firstChildNode = parent._node!.children.last;
      return WxTreeItemId( node: firstChildNode );
    }
  }

  /// Returns the next sibling of [item] or an invalid [WxTreeItemId]
  WxTreeItemId getNextSibling( WxTreeItemId item )
  {
    if (!item.isOk()) {
      wxLogError( "invalid tree item" );
      return WxTreeItemId();
    }
    if (item._isInvisibleRoot()) {
      wxLogError( "invisble root has no siblings" );
      return WxTreeItemId();
    }

    final parentNode = _getParentNode( item._node! );
    if (parentNode == null) {
      if (hasFlag(wxTR_HIDE_ROOT))
      {
        // assume child of _root
        final pos = _root.indexOf( item._node! );
        if (pos == -1) {
          return WxTreeItemId();
        }
        if (pos == _root.length-1) {
          return WxTreeItemId();
        }
        final siblingNode = _root[pos+1];
        return WxTreeItemId( node: siblingNode );
      } else {
        // something went wrong
        return WxTreeItemId();  
      }
    }
    final pos = parentNode.children.indexOf( item._node! );
    if (pos == parentNode.children.length-1) {
      return WxTreeItemId();
    }
    final siblingNode = parentNode.children[pos+1];
    return WxTreeItemId( node: siblingNode );
  }

  /// Returns the previous sibling of [item] or an invalid [WxTreeItemId]
  WxTreeItemId getPrevSibling( WxTreeItemId item )
  {
    if (!item.isOk()) {
      wxLogError( "invalid tree item" );
      return WxTreeItemId();
    }
    if (item._isInvisibleRoot()) {
      wxLogError( "invisble root has no siblings" );
      return WxTreeItemId();
    }

    final parentNode = _getParentNode( item._node! );
    if (parentNode == null) {
      if (hasFlag(wxTR_HIDE_ROOT))
      {
        // assume child of _root
        final pos = _root.indexOf( item._node! );
        if (pos == -1) {
          return WxTreeItemId();
        }
        if (pos == 0) {
          return WxTreeItemId();
        }
        final siblingNode = _root[pos-1];
        return WxTreeItemId( node: siblingNode );
      } else {
        // something went wrong
        return WxTreeItemId();  
      }
    }
    final pos = parentNode.children.indexOf( item._node! );
    if (pos == 0) {
      return WxTreeItemId();
    }
    final siblingNode = parentNode.children[pos-1];
    return WxTreeItemId( node: siblingNode );
  }

  WxTreeItemId getFocusedItem( ) {
    return getSelection();
  }

  /// Sets the focus to [item]
  /// 
  /// Not available in wxDart Flutter
  void setFocusedItem( WxTreeItemId item ) {
  }

  /// Clears the focus to [item]
  /// 
  /// Not available in wxDart Flutter
  void clearFocusedItem( ) {
  }

  /// Returns the currently selected item, or an invalid item
  WxTreeItemId getSelection( ) {
    return WxTreeItemId( node: _selected );
  }

  /// Returns true if [item] is currently selected
  bool isSelected( WxTreeItemId item )
  {
    if (!item.isOk()) {
      wxLogError( "invalid tree item" );
      return false;
    }
    if (item._isInvisibleRoot()) {
      wxLogError( "invisible root cannot be selected" );
      return false;
    }
    return (item._node == _selected) && (_selected != null);
  }

  /// Selects [item]
  /// 
  /// If [select] is true, then this will unselect the previously selected item
  /// in single selection mode - and not do anything in if [select] is false.
  /// 
  /// Multiple selection mode is not available in wxDart Flutter
  void selectItem( WxTreeItemId item, { bool select = true } )
  {
    if (!item.isOk()) {
      wxLogError( "invalid tree item" );
      return;
    }
    if (item._isInvisibleRoot()) {
      wxLogError( "invisible root cannot be selected" );
      return;
    }
    final node = item._getNode();
    if (node != null) {
      if (select) {
        _selected = node;
        _setState();
      }
    }
  }

  /// Unselect [item] in multiple selection mode
  /// 
  /// Not available in wxDart Flutter
  void unselectItem( WxTreeItemId item ) {
  }

  /// Select all child item of [item] in multiple selection mode
  /// 
  /// Not available in wxDart Flutter
  void selectChildren( WxTreeItemId item ) {
  }

  /// See [selectItem]
  void toggleItemSelection( WxTreeItemId item ) {
    selectItem( item, select: !isSelected(item) );
  }

  /// Returns true if [item] has children and is expanded
  bool isExpanded( WxTreeItemId item )
  {
    if (item._isInvisibleRoot()) {
      return true;
    }
    final node = item._getNode();
    if (node != null) {
      return node.isExpanded;
    }
    return false;
  }

  /// Returns true if the [item] has any children
  bool itemHasChildren( WxTreeItemId item )
  {
    if (item._isInvisibleRoot()) {
      return _root.isNotEmpty;
    }
    final node = item._getNode();
    if (node != null) {
      return node.children.isNotEmpty;
    }
    return false;
  }

  /// Expands tree branch
  void expand( WxTreeItemId item )
  {
    final node = item._getNode();
    if (node != null) {
      if (node.children.isEmpty) return;
      _controller.expandNode(node );
    }
  }

  /// Expands all branches of the tree control
  void expandAll()
  {
    if (_focusNode == null) 
    {
      // not yet _build and controller not yet associated
      WidgetsBinding.instance.addPostFrameCallback((_) {
        expandAll();
      });
      return;
    }

    _controller.expandAll();
  }

  /// Expands all branches of the tree control
  void expandAllChildren( WxTreeItemId item )
  {
    if (_focusNode == null) 
    {
      // not yet _build and controller not yet associated
      WidgetsBinding.instance.addPostFrameCallback((_) {
        expandAllChildren( item );
      });
      return;
    }

    if (item._isInvisibleRoot()) {
      _controller.expandAll();
      return;
    }

    final node = item._getNode();
    if (node != null) {
      _controller.expandNode( node );
    }
  }

  /// Expands or collapses [item] depending on what it was before
  void toggle( WxTreeItemId item )
  {
    if (_focusNode == null) 
    {
      // not yet _build and controller not yet associated
      WidgetsBinding.instance.addPostFrameCallback((_) {
        toggle( item );
      });
      return;
    }

    final node = item._getNode();
    if (node != null) {
      if (node.children.isEmpty) return;
      if (node.isExpanded) {
        collapse( item );
      } else {
        expand( item );
      }
    }
  }

  /// Collapses [item]
  void collapse( WxTreeItemId item )
  {
    if (_focusNode == null) 
    {
      // not yet _build and controller not yet associated
      WidgetsBinding.instance.addPostFrameCallback((_) {
        collapse( item );
      });
      return;
    }
    
    final node = item._getNode();
    if (node != null) {
      if (node.children.isEmpty) return;
      _controller.collapseNode( node );
    }
  }

  /// Collapses [item] and deletes the child items
  void collapseAndReset( WxTreeItemId item )
  {
    final node = item._getNode();
    if (node != null) {
      if (node.children.isEmpty) return;
      _controller.collapseNode( node );
      node.children.clear();
      _setState();
    }
  }

  /// Collapses all items
  void collapseAll( )
  {
    if (_focusNode == null) 
    {
      // not yet _build and controller not yet associated
      WidgetsBinding.instance.addPostFrameCallback((_) {
        collapseAll();
      });
      return;
    }
    _controller.collapseAll();
  }

  /// Collapses all child items of [item]
  void collapseAllChildren( WxTreeItemId item )
  {
    if (_focusNode == null) 
    {
      // not yet _build and controller not yet associated
      WidgetsBinding.instance.addPostFrameCallback((_) {
        collapseAllChildren( item );
      });
      return;
    }
    
    if (item._isInvisibleRoot()) {
      _controller.collapseAll();
      return;
    }

    final node = item._getNode();
    if (node != null)
    {
      _controller.collapseNode( node );
      // TODO: iterate later
    }
  }

  /// Sets the text of an item
  void setItemText( WxTreeItemId item, String text ) {
    final node = item._getNode();
    if (node != null) {
      node.content.label = text;
      _setState();
    }
  }

  /// Returns the text of an item
  String getItemText( WxTreeItemId item ) {
    final node = item._getNode();
    if (node != null) {
      return node.content.label;
    }
    return '';
  }

  /// Attaches user defined data (client data to an item)
  void setItemData( WxTreeItemId item, dynamic data ) {
    final node = item._getNode();
    if (node != null) {
      node.content.data = data;
      _setState();
    }
  }

  /// Returns user defined data (client data to an item) or null
  dynamic getItemData( WxTreeItemId item ) {
    final node = item._getNode();
    if (node != null) {
      return node.content.data;
    }
    return null;
  }

  @override
  Widget _build(BuildContext context)
  {
    _focusNode ??= FocusNode();

    final finalWidget = 
    Focus(
      // autofocus: true,
      focusNode: _focusNode,
      onFocusChange: (enter) => _sendFocusEvents(enter),
      onKeyEvent: (node, event) { 
        final keyboard = HardwareKeyboard.instance;
        if ((keyboard.isAltPressed) || (keyboard.isControlPressed) || (keyboard.isMetaPressed)) return KeyEventResult.ignored;
        if (event is KeyDownEvent) {
          switch (event.logicalKey) {
            case LogicalKeyboardKey.add:
              expand( getSelection() );
              return KeyEventResult.handled;
            case LogicalKeyboardKey.minus:
              collapse( getSelection() );
              return KeyEventResult.handled;
            case LogicalKeyboardKey.enter:
              final item = getSelection();
              if (item.isOk()) {
                final item = getSelection();
                final event = WxTreeEvent( wxGetTreeItemActivatedEventType(), this, item );
                event.setEventObject( this );
                processEvent(event);
              } 
               return KeyEventResult.handled;
            case LogicalKeyboardKey.space:
              final item = getSelection();
              if (item.isOk()) {
                /*if (itemHasChildren(item)) {
                  toggle(item);
                } else */ {
                  final event = WxTreeEvent( wxGetTreeItemActivatedEventType(), this, item );
                  event.setEventObject( this );
                  processEvent(event);
                }
              } 
              return KeyEventResult.handled;
            case LogicalKeyboardKey.arrowUp:
              final item = getSelection();
              if (!item.isOk()) return KeyEventResult.ignored;  // root
              final prev = getPrevSibling(item);
              if (prev.isOk())
              {
                if (isExpanded(prev))
                {
                  final nephew = getLastChild(prev);
                  selectItem( nephew );
                  _sendSelectionEvent();
                  return KeyEventResult.handled;
                }
                selectItem( prev );
                _sendSelectionEvent();
                return KeyEventResult.handled;
              }
              final parent = getItemParent( item );
              if (!parent.isOk()) {
                // wxLogError( "No parent item" );
                return KeyEventResult.ignored;
              }
              selectItem( parent );
              _sendSelectionEvent();
              return KeyEventResult.handled;
            case LogicalKeyboardKey.arrowLeft:
              final item = getSelection();
              if (isExpanded(item)) {
                collapse(item);
                return KeyEventResult.handled;
              }
              final parent = getItemParent(item);
              selectItem(parent);
              _sendSelectionEvent();
              return KeyEventResult.handled;
            case LogicalKeyboardKey.arrowRight:
              final item = getSelection();
              if (itemHasChildren(item)) {
                if (!isExpanded(item)) {
                  expand( item );
                  return KeyEventResult.handled;
                }
                final child = getFirstChild(item);
                selectItem(child);
                _sendSelectionEvent();
                return KeyEventResult.handled;
              }
              return KeyEventResult.ignored;
            case LogicalKeyboardKey.arrowDown:
              final item = getSelection();
              if (isExpanded(item)) {
                final child = getFirstChild(item);
                if (!child.isOk()) return KeyEventResult.handled;
                selectItem(child);
                _sendSelectionEvent();
                return KeyEventResult.handled;
              }
              final next = getNextSibling(item);
              if (next.isOk()) {
                selectItem(next);
                _sendSelectionEvent();
                return KeyEventResult.handled;
              }
              final parent = getItemParent(item);
              final uncle = getNextSibling(parent);
              if (uncle.isOk()) {
                selectItem(uncle);
                _sendSelectionEvent();
                return KeyEventResult.handled;
              }
              return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      },
      child:  CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[

      TreeSliver<WxTreeItemNode>(
      tree:  _root,
      // indentation:  TreeSliverIndentationType.none,   use this for custom indentation
      controller: _controller,
      treeRowExtentBuilder: wxTheApp.isTouch() ? TreeSliver.defaultTreeRowExtentBuilder : (node, dimensions) {
        return min( fromDIP(16), getTextExtent( "H" ).y ).toDouble() + 6;
      },
      onNodeToggle: (objectNode)
      {
        if (objectNode.content == null) {
           return;
        }
        final node = objectNode as TreeSliverNode<WxTreeItemNode>;
        if (node.isExpanded) {
          final event = WxTreeEvent( wxGetTreeItemExpandedEventType(), this, WxTreeItemId( node: node ) );
          event.setEventObject( this );
          processEvent(event);
        } else {
          final event = WxTreeEvent( wxGetTreeItemCollapsedEventType(), this, WxTreeItemId( node: node ) );
          event.setEventObject( this );
          processEvent(event);
        }
      },
      treeNodeBuilder: (context, objectNode, animationstyle )
      {
        if (objectNode.content == null) {
           return Text( " empty data " );
        }
        final node = objectNode as TreeSliverNode<WxTreeItemNode>;
        Widget child = GestureDetector( 
          behavior: HitTestBehavior.translucent,
          onTap: () {
            setFocus();
            if (_lastTap != null) {
              if (node == _selected) {
                final diff = _lastTap!.difference(DateTime.now());
                if (diff.inMilliseconds > -300) {
                  final event = WxTreeEvent( wxGetTreeItemActivatedEventType(), this, WxTreeItemId( node: node ) );
                  event.setEventObject( this );
                  processEvent(event);
                _lastTap = DateTime.now();
                  return;
                }
              }
            }
            _selected = node;
            _setState();
            _sendSelectionEvent();
            _lastTap = DateTime.now();
          },
          child: myTreeNodeBuilder(context, node, animationstyle ) 
        );

        if ((_selected == node) && (hasFlag(wxTR_FULL_ROW_HIGHLIGHT))) {
          final p = wxTheApp.getPrimaryAccentColour();
          final activatedColor = Color.fromARGB( p.alpha, p.red, p.green, p.blue );
          final grey = wxTheApp.isDark() ? Colors.grey[600]! : Colors.grey[400]!;
          child = ColoredBox( color: hasFocus() ? activatedColor : grey, child: child );
        }
        return child;
      },
     )
        ] )  
    );

    return _buildControl(context, finalWidget );
  }

  Widget myTreeNodeBuilder(
    BuildContext context,
    TreeSliverNode<WxTreeItemNode> node,
    AnimationStyle toggleAnimationStyle,
  ) {
    final Duration animationDuration =
        toggleAnimationStyle.duration ?? TreeSliver.defaultAnimationDuration;
    final Curve animationCurve = toggleAnimationStyle.curve ?? TreeSliver.defaultAnimationCurve;
    final int index = _controller.getActiveIndexFor(node)!;

        int image = node.content.image;
        if (node == _selected) {
          if (node.content.selImage != -1) {
            image = node.content.selImage;
          }
        }
        WxBitmap? bitmap;
        if (image !=-1) {
          if (image >= _bitmaps.length) {
            wxLogError( "bitmap is missing in WxTreeCtrl" );
          } else {
            bitmap = _bitmaps[image];
            if (!bitmap.isOk()) {
              bitmap._addListener(this);
              bitmap = null;
            }
          }
        }
        late Widget child;
        if (bitmap == null) {
            child = Text( node.content.label );
        } else {
          child = Row( 
                spacing: 4,
                children: [
                  RawImage( image: bitmap._image! ),
                  Text( node.content.label ) 
                ] );
        }

        child = Padding(
          padding: const EdgeInsets.symmetric( vertical: 2, horizontal: 4),
          child: child );

        if ((_selected == node) && (!hasFlag(wxTR_FULL_ROW_HIGHLIGHT))) {
          final p = wxTheApp.getPrimaryAccentColour();
          final activatedColor = Color.fromARGB( p.alpha, p.red, p.green, p.blue );
          final grey = wxTheApp.isDark() ? Colors.grey[600]! : Colors.grey[400]!;
          child = ColoredBox( color: hasFocus() ? activatedColor : grey, child: child );
        }

    return  Row(
        children: <Widget>[
          TreeSliver.wrapChildToToggleNode(
            node: node,
            child: SizedBox(
              height: 24.0,
              width: node.children.isEmpty ? 0 : 24.0,
              child: node.children.isNotEmpty
                  ? AnimatedRotation(
                      key: ValueKey<int>(index),
                      turns: node.isExpanded ? 0.25 : 0.0,
                      duration: animationDuration,
                      curve: animationCurve,
                      child: const Icon(IconData(0x276F), size: 14),
                    )
                  : null,
            ),
          ),
          // Spacer
          SizedBox( width: max(_spacing-10,0).toDouble() ), 
          // Content
          child
        ],
    );
  }

  void _sendSelectionEvent() 
  {
    final item = getSelection();
    final event = WxTreeEvent( wxGetTreeSelChangedEventType(), this, item );
    event.setEventObject( this );
    processEvent(event);
  }
}
