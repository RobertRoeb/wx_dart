// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxTreebook ----------------------

/// @nodoc

extension TreebookPageChangedEventBinder on WxEvtHandler {
  void bindTreebookPageChangedEvent( OnNotebookEventFunc func, int id ) { 
    _eventTable.add( WxNotebookEventTableEntry(wxGetTreebookPageChangedEventType(), id, func));
  }
  void unbindTreebookPageChangedEvent( OnNotebookEventFunc func, int id ) { 
    _eventTable.removeWhere( (entry) => entry.matches(wxGetTreebookPageChangedEventType(), id));
  }
}

/// @nodoc

extension TreebookPageChangingEventBinder on WxEvtHandler {
  void bindTreebookPageChangingEvent( OnNotebookEventFunc func, int id ) { 
    _eventTable.add( WxNotebookEventTableEntry(wxGetTreebookPageChangingEventType(), id, func));
  }
  void unbindTreebookPageChangingEvent( OnNotebookEventFunc func, int id ) { 
    _eventTable.removeWhere( (entry) => entry.matches(wxGetTreebookPageChangingEventType(), id));
  }
}

/// @nodoc

extension TreebookNodeCollapsedEventBinder on WxEvtHandler {
  void bindTreebookNodeCollapsedEvent( OnNotebookEventFunc func, int id ) { 
    _eventTable.add( WxNotebookEventTableEntry(wxGetTreebookNodeCollapsedEventType(), id, func));
  }
  void unbindTreebookNodeCollapsedEvent( OnNotebookEventFunc func, int id ) { 
    _eventTable.removeWhere( (entry) => entry.matches(wxGetTreebookNodeCollapsedEventType(), id));
  }
}

/// @nodoc

extension TreebookNodeExpandedEventBinder on WxEvtHandler {
  void bindTreebookNodeExpandedEvent( OnNotebookEventFunc func, int id ) { 
    _eventTable.add( WxNotebookEventTableEntry(wxGetTreebookNodeExpandedEventType(), id, func));
  }
  void unbindTreebookNodeExpandedEvent( OnNotebookEventFunc func, int id ) { 
    _eventTable.removeWhere( (entry) => entry.matches(wxGetTreebookNodeExpandedEventType(), id));
  }
}

/// The class uses a tree like structure on the left to handle multiple windows
/// on the right. It maps the page index to an item of the tree so that the 
/// logic from [WxBookCtrlBase] can be used.
/// 
/// [WxDataViewBook] does not derive from [WxBookCtrlBase] but
/// implements a similar interface and logic.
/// 
/// ```dart
/// final tree = WxTreebook(this, -1);
///
/// // create image list
/// List<WxBitmapBundle> images = [];
/// images.add( WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.airplanemode_active, WxSize(20,20), colour: wxGREY ) );
/// images.add( WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.airplanemode_inactive, WxSize(20,20), colour: wxGREY) );
/// tree.setImages(images);
///
/// // create pages and subpages one by one
/// final panel1 = WxPanel( tree, -1 );
/// tree.addPage(panel1, "Chapter 1", image: 0 );
/// final page1_1 = WxPanel( tree, -1 );
/// tree.addSubPage(page1_1, "Subpanel 1.1", image: 1 );
/// final page1_2 = WxPanel( tree, -1 );
/// tree.addSubPage(page1_2, "Subpanel 1.2", image: 1 );
/// final panel2 = WxPanel( tree, -1 );
/// tree.addPage(panel2, "Chapter 2", image: 0 );
///  // etc.
/// ```
/// 
/// Page interface
/// * [addPage]
/// * [addSubPage]
/// * [insertPage]
/// * [insertSubPage]
/// * [findPage]
/// * [getPage]
/// * [deletePage]
/// * [deleteAllPages]
/// * [findPage]
/// 
/// Image interface
/// * [setImages]
/// * [hasImages]
/// * [getImageCount]
/// 
/// Title interface
/// * [setPageText]
/// * [getPageText]
/// 
/// Selection interface
/// * [setSelection]
/// * [getSelection]
/// * [getCurrentPage]
/// 
/// Tree interface
/// * [getPageParent]
/// * [expandNode]
/// * [collapseNode]
/// * [isNodeExpanded]

class WxTreebook extends WxBookCtrlBase {
  WxTreebook( super.parent, super.id, { super.pos, super.size, int flags = 0 } ) 
  : super( style: flags )
  {
    _treeCtrl = WxTreeCtrl( this, -1, style: wxTR_HIDE_ROOT|wxTR_DEFAULT_STYLE );
    _treeCtrl.addRoot( "Invisible root" );

    _treeCtrl.bindTreeSelChangedEvent(_onTreeSelChanged, -1);
    _treeCtrl.bindTreeItemCollapsedEvent(_onTreeItemCollapsed, -1);
    _treeCtrl.bindTreeItemExpandedEvent(_onTreeItemExpanded, -1);
  }

  late WxTreeCtrl _treeCtrl;
  bool _found = false;
  int _counter = -1;

  void _onTreeItemCollapsed( WxTreeEvent event )
  {
    final item = event.getItem();
    if (!item.isOk()) return;
    final index = _getIndexOfItem( item );

    final wxevent = WxNotebookEvent( eventType:  wxGetTreebookNodeCollapsedEventType(), id: getId(),
      sel: index, oldSel: index ); 
    wxevent.setEventObject( this );
    processEvent( wxevent );
  }

  void _onTreeItemExpanded( WxTreeEvent event )
  {
    final item = event.getItem();
    if (!item.isOk()) return;
    final index = _getIndexOfItem( item );

    final wxevent = WxNotebookEvent( eventType:  wxGetTreebookNodeExpandedEventType(), id: getId(),
      sel: index, oldSel: index ); 
    wxevent.setEventObject( this );
    processEvent( wxevent );
  }

  void _onTreeSelChanged( WxTreeEvent event )
  {
    final item = _treeCtrl.getSelection();
    if (!item.isOk()) return;
    final index = _getIndexOfItem( item );
    setSelection(index);

    final event = WxNotebookEvent( eventType:  wxGetTreebookPageChangedEventType(), id: getId(), 
            sel: index, oldSel: _oldSelection ); 
    event.setEventObject( this );
    processEvent( event );
  }

  WxTreeCtrl getTreeCtrl() {
    return _treeCtrl;
  }

  int _getIndexOfItemRecursive( final List<TreeSliverNode<WxTreeItemNode>> current, final WxTreeItemId item, int count )
  {
    for (final node in current)
    {
      if (node == item._node) {
        _found = true;
        return count;
      }
      count ++;
      count = _getIndexOfItemRecursive( node.children, item, count );
      if (_found) return count; 
    }
    return count;
  }

  int _getIndexOfItem( WxTreeItemId item ) 
  {
    _found = false;
    final res = _getIndexOfItemRecursive( _treeCtrl._root, item, 0 );
    if (_found) {
      return res; 
    }
    return wxNOT_FOUND;
  }

  WxTreeItemId _getItemFromIndexRecursive( final List<TreeSliverNode<WxTreeItemNode>> current, int index )
  {
    for (final node in current) 
    {
      if (_counter == index) {
        _found = true;
        return WxTreeItemId( node: node );
      }
      _counter ++;
      final ret = _getItemFromIndexRecursive( node.children, index );
      if (_found) {
        return ret;
      }
    }
    return WxTreeItemId();
  }

  WxTreeItemId _getItemFromIndex( int pos )
  {
    _found = false;
    _counter = 0;  
    final res = _getItemFromIndexRecursive( _treeCtrl._root, pos ); 
    if (_found) {
      return res;
    }
    return WxTreeItemId();
  } 

  @override
  void setImages( List<WxBitmapBundle> images ) {
    super.setImages( images );
    _treeCtrl.setImages( images );
  }

  @override
  bool addPage( WxWindow page, String text, { bool select = false, int image = wxNO_IMAGE } )
  {
    final root = _treeCtrl.getRootItem();
    _treeCtrl.appendItem( root, text, image: image );
    super.addPage( page, text, select: select, image: image );
    return true;
  }

  bool addSubPage( WxWindow page, String text, { bool select = false, int image = wxNO_IMAGE } )
  {
    final root = _treeCtrl.getRootItem();
    final lastChild = _treeCtrl.getLastChild( root );
    _treeCtrl.appendItem( lastChild, text, image: image );
    super.addPage( page, text, select: select, image: image );
    return true;
  }

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
    _found = false;
    final ret = _getParentNodeRecursive( _treeCtrl._root, null, child );
    if (_found) {
      return ret;
    }
    return null;
  }

  @override
  bool insertPage( int pos, WxWindow page, String text, { bool select = false, int image = wxNO_IMAGE }) 
  {
    final item = _getItemFromIndex( pos );

    if (!item.isOk()) return false;

    final itemNode = item._node;
    final parentNode = _getParentNode( itemNode! );
    if (parentNode == null)
    {
      final branchIndex = _treeCtrl._root.indexOf( itemNode );
      final parentItem = WxTreeItemId._asInvisibleRoot();
      _treeCtrl.insertItem( parentItem, branchIndex, text, image: image );
      super.insertPage( pos, page, text, select: select, image: image );
      return true;
    }
    final branchIndex = parentNode.children.indexOf( itemNode );
    final parentItem = WxTreeItemId( node: parentNode );
    _treeCtrl.insertItem( parentItem, branchIndex, text, image: image );
    super.insertPage( pos, page, text, select: select, image: image );
    return true;
  }

  bool insertSubPage( int pos, WxWindow page, String text, { bool select = false, int image = wxNO_IMAGE } )
  {
    final item = _getItemFromIndex( pos );
    if (!item.isOk()) return false;
    final childCount = _treeCtrl.getChildrenCount( item );
    final newPos = pos + childCount;
    _treeCtrl.appendItem( item, text, image: image );
    super.insertPage( newPos, page, text, select: select, image: image );

    return true;
  }

  int getPageParent( int pagePos )
  {
    final item = _getItemFromIndex( pagePos );
    if (!item.isOk()) return wxNOT_FOUND;
    final itemNode = item._node;
    final parentNode = _getParentNode( itemNode! );
    if (parentNode == null) return wxNOT_FOUND;
    final parentItem = WxTreeItemId( node: parentNode );
    return _getIndexOfItem( parentItem );
  }

  bool expandNode( int pagePos, {bool expand=true } )
  {
    final item = _getItemFromIndex( pagePos );
    if (!item.isOk()) return false;
    final oldState = _treeCtrl.isExpanded(item);
    if (expand) {
      _treeCtrl.expand( item );
    } else {
      _treeCtrl.collapse( item );
    }
    return oldState;
  }

  bool collapseNode( int pagePos ) {
    return expandNode( pagePos, expand: false );
  }

  bool isNodeExpanded( int pagePos ) {
    final item = _getItemFromIndex( pagePos );
    if (!item.isOk()) return false;
    return _treeCtrl.isExpanded(item);
  }

  @override
  void setPageText( int page, String text )
  {
    final item = _getItemFromIndex( page );
    if (!item.isOk()) return;
    _treeCtrl.setItemText( item, text );
    super.setPageText( page, text );
  }

  @override
  bool deletePage( int page )
  {
    final item = _getItemFromIndex( page );
    if (!item.isOk()) return false;
    _treeCtrl.delete( item );
    super.deletePage( page );
    return true;
  }

  @override
  bool deleteAllPages()
  {
    _treeCtrl.deleteAllItems();
    super.deleteAllPages();
    return false;
  }

@override
  Widget _build(BuildContext context)
  {
    final page = getCurrentPage();
    late Widget child;
    if (page == null) {
      child = SizedBox( );
    } else {
      child = page._build( context );
    }

    if (wxTheApp.isTouch()) {
      return _buildControl( context, child );
    }

    Widget row = Row(
      children: [
        SizedBox(
          width: 180,  // TODO, calculate size
          child: _treeCtrl._build( context ),
        ),
        Expanded( child: 
          Column(children: [ Expanded( child: child ) ] )
        ),
      ] 

    );
    return _buildControl( context, row );
  }
}
