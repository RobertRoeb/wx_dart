// ---------------------------------------------------------------------------
// Name:        dataview.dart
// Name:        src/generic/datavgen.cpp from wxWidgets
// Purpose:     wxDataViewCtrl generic implementation
// Author:      Robert Roebling
// Modified by: Francesco Montorsi, Guru Kathiresan, Bo Yang
// Copyright:   (c) 1998 Robert Roebling (C++ version)
// Copyright:   (c) 2026 Robert Roebling (Dart version)
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../wx_dart.dart';

// ------------------------- WxDataViewSortOrder ----------------------

const int wxDataViewSortColumnNone = -2;
const int wxDataViewSortColumnDefault = -1;

class WxDataViewSortOrder
{
    WxDataViewSortOrder( { int column = wxDataViewSortColumnNone, bool ascending = true } ) {
      _column = column;
      _ascending = ascending;
    }

    late final int _column;
    late final bool _ascending;

    bool isNone() { 
      return _column == wxDataViewSortColumnNone;
    }

    bool usesColumn() { 
      return _column >= 0;
    }

    int getColumn() {
      return _column;
    }

    bool isAscending() { 
      return _ascending;
    }

    bool isEqualTo ( WxDataViewSortOrder other) {
        return _column == other._column && _ascending == other._ascending;
    }

    bool isNotEqualTo ( WxDataViewSortOrder other) {
        return !isEqualTo(other);
    }
}

// ------------------------- wxDataViewColumn ----------------------

const int wxDVC_DEFAULT_WIDTH = 80;
const int wxDVC_DEFAULT_MINWIDTH = 30;
const int wxDVC_DEFAULT_RENDERER_SIZE = 25; // 20;
const int wxDVC_TOGGLE_DEFAULT_WIDTH = 30;
const int wxDATAVIEW_COL_RESIZABLE = wxCOL_RESIZABLE;
const int wxDATAVIEW_COL_SORTABLE = wxCOL_SORTABLE;
const int wxDATAVIEW_COL_REORDERABLE = wxCOL_REORDERABLE;
const int wxDATAVIEW_COL_HIDDEN = wxCOL_HIDDEN;

class WxDataViewColumn extends WxSettableHeaderColumn {
  WxDataViewColumn( String title, WxDataViewRenderer renderer, int modelColumn, { int width = wxDVC_DEFAULT_WIDTH, int alignment = wxALIGN_CENTER, int flags = wxDATAVIEW_COL_RESIZABLE } ) {
    _title = title;
    _renderer = renderer;
    _renderer.setOwner( this );
    _modelColumn = modelColumn;
    _width = width;
    _minWidth = wxDVC_DEFAULT_MINWIDTH;
    _alignment = alignment;
    _flags = flags;
    _manuallySetWidth = _width;
  }

  late final WxDataViewRenderer _renderer;
  late final int _modelColumn;
  late int _manuallySetWidth;
  WxDataViewCtrl? _owner;

  WxDataViewRenderer getRenderer() {
    return _renderer;
  }

  int getModelColumn() {
    return _modelColumn;
  }

  void setOwner( WxDataViewCtrl owner ) {
    _owner = owner;
  }

  WxDataViewCtrl? getOwner() {
    return _owner;
  }

  // ---------

  @override
  void setTitle( String title ) {
    super.setTitle(title);
    _updateWidth();
  }

  @override
  void setBitmap( WxBitmap bitmap ) {
    super.setBitmap(bitmap);
    _updateWidth();
  }

  @override
  void setWidth( int width ) {
    super.setWidth(width);
    _manuallySetWidth = width;
    _updateWidth();
  }

  @override
  int getWidth() {
    return _doGetEffectiveWidth(_width);
  }

  @override
  void setMinWidth( int minWidth ) {
    super.setMinWidth(minWidth);
    _updateWidth();
  }

  @override
  void setFlags( int flags ) {
    super.setFlags(flags);
    _updateWidth();
  }

  @override
  void setFlag( int flag ) {
    super.setFlag(flag);
    _updateWidth();
  }

  @override
  void clearFlag( int flag ) {
    super.clearFlag(flag);
    _updateWidth();
  }

  @override
  void setAlignment( int alignment ) {
    super.setAlignment(alignment);
    _updateWidth();
  }

  @override
  void setResizeable( bool resizable ) {
    super.setResizeable(resizable);
    _updateWidth();
  }

  @override
  void setSortable( bool sortable ) {
    super.setSortable(sortable);
    _updateWidth();
  }

  @override
  void setHidden( bool hidden ) {
    super.setHidden(hidden);
    _updateWidth();
  }

  @override
  void unsetAsSortKey( ) {
    super.unsetAsSortKey();
    if (_owner != null) {
        _owner!.dontUseColumnForSorting(_owner!.getColumnIndex(this));
    }
    _updateWidth();
  }

  @override
  void setSortOrder( bool ascending ) {
    if (_owner == null) {
        return;
    }

    if (!_owner!.isMultiColumnSortAllowed()) {
      _owner!.resetAllSortColumns();
    }

    final idx = _owner!.getColumnIndex(this);

    if (!_isSortKey) {
        _owner!.useColumnForSorting(idx);
        _isSortKey = true;
    }

   _isSortOrderAscending = ascending;

    _owner!.onColumnChange(idx);
  }

  // ---------

  void _updateWidthInternal(int width)
  {
    if (width == _width) {
      return;
    }

    _width = width;
    _updateWidth();
  }

  void _onResizeFromHeaderCtrl(int width) {
    _width =
    _manuallySetWidth = width;

    if (_owner != null) {
      _owner!.onColumnResized();
    }
  }

  int _getSpecifiedWidth() {
    return _doGetEffectiveWidth(_manuallySetWidth);
  }

  void _updateDisplay() {
    if (_owner != null) {
        int idx = _owner!.getColumnIndex( this );
        _owner!.onColumnChange( idx );
    }
  }
  
  void _updateWidth() {
    if (_owner != null) {
        int idx = _owner!.getColumnIndex( this );
        _owner!.onColumnWidthChange( idx );
    }
  }

  int _doGetEffectiveWidth(int width) {
    if (_owner == null) return wxDVC_DEFAULT_WIDTH;
    switch ( width )
    {
        case wxCOL_WIDTH_DEFAULT:
            return wxDVC_DEFAULT_WIDTH;

        case wxCOL_WIDTH_AUTOSIZE:
            return _owner!.getBestColumnWidth(_owner!.getColumnIndex(this));

    }
    return width;
  }
}

// ---------------------- helper ------------------

/// @nodoc

// Flags for Walker() function defined below.
enum WxDataViewWalkFlags
{
    walkAll,               // Visit all items.
    walkExpandedOnly       // Visit only expanded items.
}

/// @nodoc

enum WxDataViewJobFlags
{
  jobDone,          // Job done, stop traversing and return
  jobSkipSubtree,   // Ignore the current node's subtree and continue
  jobContinue       // Job not done, continue
}

/// @nodoc

abstract class WxDataViewJob
{
    WxDataViewJob();

    WxDataViewJobFlags doJob( WxDataViewTreeNode node );
}

// --------------------------- WxDataViewRowToTreeNodeJob -----------------------------

/// @nodoc

class WxDataViewRowToTreeNodeJob extends WxDataViewJob
{
    // Note that we initialize m_current to -1 because the first node passed to
    // our operator() will be the root node, which doesn't appear in the window
    // and so doesn't count as a real row.
    WxDataViewRowToTreeNodeJob(int row)
    {
      _row = row;
      _current = -1;
      _ret = null;
    }

    @override
    WxDataViewJobFlags doJob( WxDataViewTreeNode node ) 
    {
        if (_current == _row)
        {
            _ret = node;
            return WxDataViewJobFlags.jobDone;
        }

        if (node.getSubTreeCount() + _current < _row)
        {
            _current += node.getSubTreeCount() + 1;
            return WxDataViewJobFlags.jobSkipSubtree;
        }
        else
        {
            // If the current node has only leaf children, we can find the
            // desired node directly. This can speed up finding the node
            // in some cases, and will have a very good effect for list views.
            if ( node.hasChildren() &&
                 node.getChildNodes().length == node.getSubTreeCount() )
            {
                final index = _row - _current - 1;
                _ret = node.getChildNodes()[index];
                return WxDataViewJobFlags.jobDone;
            }

            _current++;

            return WxDataViewJobFlags.jobContinue;
        }
    }

  WxDataViewTreeNode? getResult() { 
    return _ret;
  }

  int _row = -1;
  int _current = -1;
  WxDataViewTreeNode? _ret;
}

// --------------------------- WxDataViewItemToRowJob -----------------------------

/// @nodoc

class WxDataViewItemToRowJob extends WxDataViewJob
{
    // As with RowToTreeNodeJob above, we initialize m_current to -1 because
    // the first node passed to our operator() is the root node which is not
    // visible on screen and so we should return 0 for its first child node and
    // not for the root itself.
    WxDataViewItemToRowJob( WxDataViewItem item, this._parentChain )
    {
      _item = item;
      _current = -1;
      _iter = _parentChain.length-1;
    }

    // Maybe binary search will help to speed up this process
    @override
    WxDataViewJobFlags doJob( WxDataViewTreeNode node ) 
    {
        if( node.getItem() == _item )
        {
            return WxDataViewJobFlags.jobDone;
        }

        // Is this node the next (grand)parent of the item we're looking for?
        if( node.getItem() == _parentChain[_iter])
        {
            // Search for the next (grand)parent now and skip this item itself.
            _iter--;
            ++_current;
            return WxDataViewJobFlags.jobContinue;
        }
        else
        {
            // Skip this node and all its currently visible children.
            _current += node.getSubTreeCount() + 1;
            return WxDataViewJobFlags.jobSkipSubtree;
        }

    }

    int getResult() { 
      return _current; 
    }

    WxDataViewItem _item = WxDataViewItem();
    final List<WxDataViewItem> _parentChain;
    int _iter = -1;

    // The row corresponding to the last node seen in our operator().
    int _current = 1;
}

// --------------------------- wxDataViewTreeNodeWalker -----------------------------

/// @nodoc

bool
wxDataViewTreeNodeWalker( WxDataViewTreeNode node, WxDataViewJob func, { WxDataViewWalkFlags flags = WxDataViewWalkFlags.walkAll } )
{
    switch( func.doJob( node ) )
    {
        case WxDataViewJobFlags.jobDone:
            return true;
        case WxDataViewJobFlags.jobSkipSubtree:
            return false;
        case WxDataViewJobFlags.jobContinue:
            break;
    }

    if ( node.hasChildren() && (flags != WxDataViewWalkFlags.walkExpandedOnly || node.isOpen()) )
    {
        final nodes = node.getChildNodes();
        for (final i in nodes)
        {
          if (wxDataViewTreeNodeWalker( i, func, flags: flags )) {
            return true;
          }
        }
    }

    return false;
}

// ---------------------- wxDataViewHeaderWindow ------------------

class WxDataViewHeaderWindow extends WxHeaderCtrl {
  WxDataViewHeaderWindow( WxDataViewCtrl parent, WxSize size ) : super( parent, -1, size: size ) {
    bindHeaderCtrlClickEvent(onClick, -1);
    bindHeaderCtrlRightClickEvent(onRClickOverridden, -1);
    bindHeaderCtrlResizingEvent(onResize, -1);
    bindHeaderCtrlEndResizeEvent(onResize, -1);
    bindHeaderCtrlEndReorderEvent(onEndReorder, -1);
  }

  @override
  void printName() {
    print( "WxDataViewHeaderWindow");
  }

    WxDataViewCtrl getOwner() {
      return getParent() as WxDataViewCtrl;
    }

    WxWindow getMainWindowOfCompositeControl()
        { return getOwner(); }

    void toggleSortByColumn(int column)
    {
        final owner = getOwner();

        if ( !owner.isMultiColumnSortAllowed() ) {
            return;
        }

        final col = owner.getColumn(column);
        if ( !col!.isSortable() ) {
            return;
        }

        if ( owner.isColumnSorted(column) )
        {
            col.unsetAsSortKey();
            sendEvent( wxGetDataViewColumnSortedEventType(), column);
        }
        else // Do start sortign by it.
        {
            col.setSortOrder(true);
            sendEvent( wxGetDataViewColumnSortedEventType(), column);
        }
    }

    @override
    WxHeaderColumn getColumn( int idx) 
    {
        return getOwner().getColumn(idx)!;
    }

    @override
    bool updateColumnWidthToFit( int idx, int widthTitle)
    {
        final owner = getOwner();
        int widthContents = owner.getBestColumnWidth(idx);
        owner.getColumn(idx)!.setWidth( max(widthTitle, widthContents) );
        owner.onColumnChange(idx);
        return true;
    }

    void finishEditing() {
      final dvCtrl = getOwner();
      final win = dvCtrl.getMainWindow();
      final mainWin = win as WxDataViewMainWindow;
      mainWin.finishEditing();
    }

    bool sendEvent(int type, int n)
    {
        final owner = getOwner();
        final event = WxDataViewEvent (type, owner, owner.getColumn(n), WxDataViewItem() );

        // for events created by wxDataViewHeaderWindow the
        // row / value fields are not valid
        return owner.processEvent(event);
    }

    void onClick( WxHeaderCtrlEvent event)
    {
        finishEditing();

        final idx = event.getColumn();

        if ( sendEvent( wxGetDataViewColumnHeaderClickEventType(), idx) ) return;

        // default handling for the column click is to sort by this column or
        // toggle its sort order
        final owner = getOwner();
        final col = owner.getColumn(idx);
        if ( !col!.isSortable() )
        {
            // no default handling for non-sortable columns
            event.skip();
            return;
        }

        if ( col.isSortKey() )
        {
            // already using this column for sorting, just change the order
            col.toggleSortOrder();
        }
        else // not using this column for sorting yet
        {
            // Sort by this column: note that it can add it to the existing
            // sort columns if multi-column sort is allowed, but by default it
            // will replace the existing sort column (if any).
            col.setSortOrder(true);
        }

        final model = owner.getModel();
        if (model != null ) {
            model.resort();
        }

        owner.onColumnChange(idx);

        sendEvent( wxGetDataViewColumnSortedEventType(), idx);
    }

    void onRClickOverridden( WxHeaderCtrlEvent event)
    {
        // Event wasn't processed somewhere, use default behaviour
        if ( !sendEvent( wxGetDataViewColumnHeaderRightClickEventType(),
                        event.getColumn()) )
        {
            event.skip();
            toggleSortByColumn(event.getColumn());
        }
    }

    void onResize( WxHeaderCtrlEvent event)
    {
        finishEditing();

        final owner = getOwner();
        final col = event.getColumn();
        owner.getColumn(col)!._onResizeFromHeaderCtrl(event.getWidth());
    }

    void onEndReorder( WxHeaderCtrlEvent event )
    {
        finishEditing();

        final owner = getOwner();
        final col = event.getColumn();
        owner.columnMoved( owner.getColumn(col)!,
                           event.getNewOrder());
    }


}

// Comparator used for sorting the tree nodes using the model-defined sort
// order and also for performing binary search in our own code.
class WxDataViewTreeModelNodeCmp
{
    WxDataViewTreeModelNodeCmp( WxDataViewMainWindow  window,
                                this.sortOrder ) {
        model = window.getModel()!;
        if (sortOrder.isNone()) {
          wxLogError( "Sort order needed" );
        }
    }

    late final WxDataViewModel model;
    final WxDataViewSortOrder sortOrder;

    // Return negative, zero or positive value depending on whether the first
    // item is less than, equal to or greater than the second one.
    int compare( WxDataViewTreeNode first, WxDataViewTreeNode second)
    {
        return model.compare( first.getItem(), second.getItem(),
                              sortOrder.getColumn(),
                              sortOrder.isAscending() );
    }

    // Return true if the items are (strictly) in order, i.e. the first item is
    // less than the second one. This is used by std::sort().
    bool itemAreInOrder( WxDataViewTreeNode first, WxDataViewTreeNode second ) {
        return compare(first, second) < 0;
    }

}

/// @nodoc

class WxDataViewBranchData {
  WxDataViewBranchData() {
    sortOrder = WxDataViewSortOrder();
  }

  bool open = false;
  int subTreeCount = 0;
  late WxDataViewSortOrder sortOrder;
  List<WxDataViewTreeNode> children = [];

  void insertChild( WxDataViewTreeNode node, int index ) {
    children.insert( index, node );
  }

  void removeChild( int index ) {
    children.removeAt( index );
  }
}

/// @nodoc

class WxDataViewTreeNode
{
    WxDataViewTreeNode( this._parent, this._item );

    WxDataViewTreeNode? _parent;
    WxDataViewItem _item;
    WxDataViewBranchData? _branchData;


    static WxDataViewTreeNode createRootNode()
    {
        final node = WxDataViewTreeNode(null, WxDataViewItem());
        node._branchData = WxDataViewBranchData();
        node._branchData!.open = true;
        return node;
    }

    WxDataViewTreeNode? getParent() { 
      return _parent;
    }

    List <WxDataViewTreeNode> getChildNodes() {
      if (_branchData == null) return [];
      return _branchData!.children;
    }

    void insertChild( WxDataViewMainWindow window,
                      WxDataViewTreeNode node, int index)
    {
      _branchData ??= WxDataViewBranchData();

      final sortOrder = window.getSortOrder();

      // Flag indicating whether we should retain existing sorted list when
      // inserting the child node.
      bool insertSorted = false;

      if ( sortOrder.isNone() )
      {
          // We should insert assuming an unsorted list. This will cause the
          // child list to lose the current sort order, if any.
          _branchData!.sortOrder = WxDataViewSortOrder();
      }
      else if ( _branchData!.children.isEmpty )
      {
          if ( _branchData!.open )
          {
              // We don't need to search for the right place to insert the first
              // item (there is only one), but we do need to remember the sort
              // order to use for the subsequent ones.
              _branchData!.sortOrder = sortOrder;
          }
          else
          {
              // We're inserting the first child of a closed node. We can choose
              // whether to consider this empty child list sorted or unsorted.
              // By choosing unsorted, we postpone comparisons until the parent
              // node is opened in the view, which may be never.
              _branchData!.sortOrder = WxDataViewSortOrder();
          }
      }
      else if ( _branchData!.open )
      {
        if (_branchData!.sortOrder.isNotEqualTo( sortOrder)) {
          // For open branches, children should be already sorted.
          wxLogError( "Logic error in wxDVC sorting code" );
          return;
        }

        // We can use fast insertion.
        insertSorted = true;
      }
      else if ( _branchData!.sortOrder == sortOrder )
      {
          // The children are already sorted by the correct criteria (because
          // the node must have been opened in the same time in the past). Even
          // though it is closed now, we still insert in sort order to avoid a
          // later resort.
          insertSorted = true;
      }
      else
      {
          // The children of this closed node aren't sorted by the correct
          // criteria, so we just insert unsorted.
          _branchData!.sortOrder = WxDataViewSortOrder();
      }

      if ( insertSorted )
      {
          // Use binary search to find the correct position to insert at.
          final cmp = WxDataViewTreeModelNodeCmp(window, sortOrder);
          int lo = 0, hi = _branchData!.children.length;
          while ( lo < hi )
          {
              int mid = lo + ((hi - lo) / 2).floor();
              int r = cmp.compare(node, _branchData!.children[mid]);
              if ( r < 0 ) {
                  hi = mid;
              } else if ( r > 0 ) {
                  lo = mid + 1;
              } else {
                  lo = hi = mid;
              }
          }
          _branchData!.insertChild(node, lo);
      }
      else
      {
          _branchData!.insertChild(node, index);
      }
    }
                  
    void removeChild(int index)
    {
      if (_branchData == null) {
          wxLogError( "leaf node doesn't have children" );
          return;
      }
      _branchData!.removeChild(index);
    }

    // returns position of child node for given item in children list or wxNOT_FOUND
    int findChildByItem( WxDataViewItem item) 
    {
        if ( _branchData == null ) {
            return wxNOT_FOUND;
        }

        final nodes = _branchData!.children;
        final len = nodes.length;
        for ( int i = 0; i < len; i++ )
        {
            if ( nodes[i]._item == item ) {
                return i;
            }
        }
        return wxNOT_FOUND;
    }

    WxDataViewItem getItem() { 
      return _item;
    }

    void setItem( WxDataViewItem item ) { 
      _item = item;
    }

    int getIndentLevel()  // TODO check if logic matches C++
    {
        int ret = 0;
        WxDataViewTreeNode? parent = getParent();
        if (parent == null) return 0;
        WxDataViewTreeNode node = parent;
        while( node.getParent() != null )
        {
            node = node.getParent()!;
            ret ++;
        }
        return ret;
    }

    bool isOpen() {
        if (_branchData == null) return false;
        return _branchData!.open;
    }

    void toggleOpen( WxDataViewMainWindow window )
    {
        // We do not allow the (invisible) root node to be collapsed because
        // there is no way to expand it again.
        if ( _parent == null ) return;

        if (_branchData == null) {
          wxLogError( "can't open leaf node" );
          return;
        }

        int sum = 0;

        final nodes = _branchData!.children;
        final len = nodes.length;
        for ( int i = 0; i < len; i ++) {
            sum += 1 + nodes[i].getSubTreeCount();
        }

        if (_branchData!.open)
        {
            changeSubTreeCount(-sum);
            _branchData!.open = !_branchData!.open;
        }
        else
        {
            _branchData!.open = !_branchData!.open;
            changeSubTreeCount(sum);
            // Sort the children if needed
            resort(window);
        }
    }

    // "HasChildren" property corresponds to model's IsContainer(). Note that it may be true
    // even if GetChildNodes() is empty; see below.
    bool hasChildren() {
        return _branchData != null;
    }

    void setHasChildren(bool has)
    {
        // The invisible root item always has children, so ignore any attempts
        // to change this.
        if ( _parent == null ) return;

        if ( !has ) {
            _branchData = null;
        } else {
          _branchData ??= WxDataViewBranchData();
        }
    }

    int getSubTreeCount() {
      if (_branchData == null) return 0;
      return _branchData!.subTreeCount;
    }

    void changeSubTreeCount( int num )
    {
        if (_branchData == null) {
          wxLogError( "no branch in subtree" );
          return;
        }

        if( !_branchData!.open ) return;

        _branchData!.subTreeCount += num;

        if( _parent != null ) {
            _parent!.changeSubTreeCount(num);
        }
    }

    void resort( WxDataViewMainWindow  window )
    {
      if (_branchData == null) return;

      // No reason to sort a closed node.
      if ( !_branchData!.open ) return;

      final sortOrder = window.getSortOrder();
      if ( !sortOrder.isNone() )
      {
          final nodes = _branchData!.children;

          // When sorting by column value, we can skip resorting entirely if the
          // same sort order was used previously. However we can't do this when
          // using model-specific sort order, which can change at any time.
          if ( _branchData!.sortOrder.isNotEqualTo( sortOrder ) || !sortOrder.usesColumn() )
          {
              /* TODO actual sorting
              std::sort(m_branchData->children.begin(),
                        m_branchData->children.end(),
                        wxGenericTreeModelNodeCmp(window, sortOrder));
              */
              _branchData!.sortOrder = sortOrder;
          }

          // There may be open child nodes that also need a resort.
          final len = nodes.length;
          for ( int i = 0; i < len; i++ )
          {
              if ( nodes[i].hasChildren() ) {
                  nodes[i].resort(window);
              }
          }
      }
    }

    // Should be called after changing the item value to update its position in
    // the control if necessary.
    void putInSortOrder( WxDataViewMainWindow window )
    {
        if ( _parent != null ) {
            _parent!.putChildInSortOrder(window, this);
        }
    }

    // Called by the child after it has been updated to put it in the right
    // place among its siblings, depending on the sort order.
    //
    // The argument must be non-null, but is passed as a pointer as it's
    // inserted into m_branchData->children.
    void putChildInSortOrder( WxDataViewMainWindow window,
                              WxDataViewTreeNode childNode)
    {
      // The childNode has changed, and may need to be moved to another location
      // in the sorted child list.

      if ( _branchData == null ) return;

      if ( !_branchData!.open ) return;

      if ( _branchData!.sortOrder.isNone() ) return;

      final nodes = _branchData!.children;

      // This is more than an optimization, the code below assumes that 1 is a
      // valid index.
      if ( nodes.length == 1 ) return;

      if (_branchData!.sortOrder.isNotEqualTo( window.getSortOrder())) {
        wxLogError( "data not sorted" );
        return;
      }

      // First find the node in the current child list
      int hi = nodes.length;
      int oldLocation = wxNOT_FOUND;
      for ( int index = 0; index < hi; ++index )
      {
          if ( nodes[index] == childNode )
          {
              oldLocation = index;
              break;
          }
      }

      final cmp = WxDataViewTreeModelNodeCmp(window, _branchData!.sortOrder);

      // Check if we actually need to move the node.
      bool locationChanged = false;

      // Compare with next node
      if ( oldLocation != hi - 1)
      {
          if ( !cmp.itemAreInOrder(childNode, nodes[oldLocation + 1]) ) {
              locationChanged = true;
          }
      }

      // Compare with previous node
      if ( !locationChanged && oldLocation > 0 )
      {
          if ( !cmp.itemAreInOrder(nodes[oldLocation - 1], childNode) ) {
              locationChanged = true;
          }
      }

      if ( !locationChanged )  return;

      // Remove and reinsert the node in the child list
      _branchData!.removeChild(oldLocation);
      hi = nodes.length;
      int lo = 0;
      while ( lo < hi )
      {
          int mid = lo + ((hi - lo) / 2).floor();
          int r = cmp.compare(childNode, _branchData!.children[mid]);
          if ( r < 0 ) {
              hi = mid;
          } else if ( r > 0 ) {
              lo = mid + 1;
          } else {
              lo = hi = mid;
          }
      }
      _branchData!.insertChild(childNode, lo);

      // Make sure the change is actually shown right away
      window._updateDisplay();

    }
}

// ------------------------- wxDataViewItem ----------------------

/// Represents an item in a [WxDataViewCtrl].
/// 
/// The only [WxDataViewItem] you should ever create is an empty one
/// meaning the root item in a tree control
/// ```dart
///  final root = WxDataViewItem();
/// ```

class WxDataViewItem {
  /// Creates an item from an index or an ID
  WxDataViewItem( { this.index = -1, this.id });

  /// Creates a deep copy of an item
  WxDataViewItem.fromItem( WxDataViewItem item ) {
    index = item.getIndex();
    id = item.getID();
  }
  late int index;
  dynamic id;

  /// Returns index of an item if in a list control
  int getIndex() {
    return index;
  }
  /// Returns ID from the item. Internal.
  dynamic getID() {
    return id;
  }

  /// Returns if valid. Otherwise indicates root or invalid item.
  bool isOk() {
    return (index >= 0) || (id != null);
  }

  @override
  bool operator == (Object other) {
    if (other is! WxDataViewItem) return false;
    return hashCode == other.hashCode;
  }

  @override
  int get hashCode {
    if (id != null) {
      return id.hashCode;
    }
    if (index > 0) {
      return index.hashCode;
    }
    return -1;
  }
}


// ------------------- wxFlutterDataViewModelNotifier -------------------

/// @nodoc

class WxFlutterDataViewModelNotifier extends WxDataViewModelNotifier
{
  WxFlutterDataViewModelNotifier( super._owner, this.control );

  WxDataViewMainWindow control;

  @override
  bool cleared() 
    { return control._cleared();  }

  @override
  void resort() 
    { control._resort(); }

  @override
  bool itemAdded( WxDataViewItem parent, WxDataViewItem item )
    { return control._itemAdded(parent, item); }

  @override
  bool itemChanged( WxDataViewItem item ) 
    { return control._itemChanged(item); }

  @override
  bool itemDeleted( WxDataViewItem parent, WxDataViewItem item )
    { return control._itemDeleted(parent, item); }

  @override
  bool valueChanged( WxDataViewItem item, int column )
    { return control._valueChanged(item, column); }
}

// ------------------------- wxDataViewMainWindow ----------------------

/// @nodoc

class WxDataViewMaxWidthCalculator extends WxMaxWidthCalculator
{
    WxDataViewMaxWidthCalculator( this._dvc, this._clientArea, this._renderer, this._model, 
                                  int modelColumn, this._expanderSize) : super( modelColumn )
    {
        int index = _dvc.getModelColumnIndex( modelColumn );
        final column = index == wxNOT_FOUND ? null : _dvc.getColumn(index);
        _isExpanderCol =
            !_clientArea.isList() &&
            (column == null ||
             getExpanderColumnOrFirstOne(_dvc) == column );
    }

    final WxDataViewCtrl _dvc;
    final WxDataViewMainWindow _clientArea;
    final WxDataViewRenderer _renderer;
    final WxDataViewModel _model;
    late bool _isExpanderCol;
    final int _expanderSize;

    @override
    void updateWithRow(int row) 
    {
        int width = 0;
        WxDataViewItem item = WxDataViewItem();

        if ( _isExpanderCol )
        {
            WxDataViewTreeNode? node = _clientArea.getTreeNodeByRow(row);
            if (node != null) {
              item = node.getItem();
              width = _dvc.getIndent() * node.getIndentLevel() + _expanderSize;
            }
        }
        else
        {
            item = _clientArea.getItemByRow(row);
        }

        if ( _model.hasValue(item, getColumn()) )
        {
            if ( _renderer.prepareForItem(_model, item ) ) {
                width += _renderer._getSize().x;
            }
        }

        updateWithWidth(width);
    }
}

/// @nodoc

class WxDataViewRenameTimer extends WxTimer {
  WxDataViewRenameTimer( this.owner ): super.withOwner( owner );

  WxDataViewMainWindow owner;

  @override
  void notify() {
    // owner._onRenameTimer();
  }
}

/// @nodoc
/*
class WxDataViewChevronAnimationTimer extends WxTimer {
  WxDataViewChevronAnimationTimer( this.owner ) : super();

  final WxDataViewMainWindow owner;
  int _counter = 0;

  @override
  void notify() {
    if (_counter >= 10) {
      _counter = 0;
      stop();
      return;
    }
    _counter++;
    owner._chevronAnimationFactor = _counter / 10;
    owner.refresh();
  }
}
*/

/// @nodoc

WxDataViewColumn? getExpanderColumnOrFirstOne( WxDataViewCtrl dataview )
{
    WxDataViewColumn ?expander = dataview.getExpanderColumn();
    if (expander == null)
    {
        // TODO-RTL: last column for RTL support
        expander = dataview.getColumnAt( 0 );
        dataview.setExpanderColumn(expander);
    }

    return expander;
}

/// @nodoc

class WxDataViewFindNodeResult
{
  WxDataViewTreeNode? _node;
  bool                _subtreeRealized = false;
}

/// @nodoc

class WxDataViewMainWindow extends WxWindow {
  WxDataViewMainWindow( WxDataViewCtrl parent ) : super( parent, -1, wxDefaultPosition, wxDefaultSize, wxWANTS_CHARS )
  {
    _owner = parent;
    _selection = WxSelectionStore();
    _selection.selectRange( 2, 4 );
    _lineHeight = getDefaultRowHeight();
    _renameTimer = WxDataViewRenameTimer( this );
    // _chevronAnimationTimer = WxDataViewChevronAnimationTimer( this );
    _chevronAnimation = WxUIAnimation((value) {
      _chevronAnimationFactor = value;
      refresh();
    }, 250 );
    _chevronAnimationItem = WxDataViewItem();

    if (parent.hasFlag(wxDV_VARIABLE_LINE_HEIGHT)) {
        _rowHeightCache = WxHeightCache();
    }

    bindPaintEvent(onPaint);

    bindSizeEvent( (event) {
      updateColumnSizes();
      event.skip();
    } );

    setBackgroundColour( wxGetSystemSettings().getColour( wxSYS_COLOUR_WINDOW ) );
    bindSysColourChangedEvent( onSysColourChanged );

    bindCharEvent(onChar);
    // bindCharHookEvent(onCharHook);

    bindLeftDownEvent(onMouse);
    bindLeftUpEvent(onMouse);
    bindLeftDClickEvent(onMouse);
    bindRightDownEvent(onMouse);
    bindRightUpEvent(onMouse);
    bindRightDClickEvent(onMouse);
    bindMotionEvent(onMouse);
    bindLeaveWindowEvent(onMouse);

    bindSetFocusEvent(onSetFocus);
    bindKillFocusEvent(onKillFocus);

    bindIdleEvent(onIdle);
    bindTimerEvent(onRenameTimer);
  }

  void onSysColourChanged( WxSysColourChangedEvent event )
  {
    setBackgroundColour( wxGetSystemSettings().getColour( wxSYS_COLOUR_WINDOW ) );

    if (getParent()!.hasFlag(wxDV_VARIABLE_LINE_HEIGHT)) {
      _updateDisplay();
    }
  }

  @override
  void printName() {
    print( "WxDataViewMainWindow");
  }

  late WxDataViewCtrl _owner;
  late int _lineHeight;
  bool _dirty = true;
  WxDataViewColumn? _currentCol;
  int _currentRow = -1;
  late WxSelectionStore _selection;
  late WxDataViewRenameTimer _renameTimer;
  WxPoint _lastMouseEventPosition = WxPoint.zero;
  bool _lastOnSame = false;
  bool _hasFocus = false;
  bool _useCellFocus = false;
  bool _currentColSetByKeyboard = false;

  double _chevronAnimationFactor = 1.0;
  // late WxDataViewChevronAnimationTimer _chevronAnimationTimer;
  late WxUIAnimation _chevronAnimation;
  late WxDataViewItem _chevronAnimationItem;

  bool _dirtyRowHeightCache = true;
  WxHeightCache? _rowHeightCache;

  int _lineLastClicked = -1;
  int _lineBeforeLastClicked = -1;
  int _lineSelectSingleOnUp = -1;
  int _virtualHeight = 0;

  WxPen _penRule = wxLIGHT_GREY_PEN;

  WxDataViewTreeNode? _root;
  int _count = -1;

  WxDataViewTreeNode? _underMouse;      // expander
  WxDataViewTreeNode? _underMouseItem;  // the whole thing

  WxWindow? _editorCtrl;
  WxDataViewRenderer? _editorRenderer;

  int getDefaultRowHeight()
  {
      final SMALL_ICON_HEIGHT = fromDIP(16);
      const int EXTRA_MARGIN = 1;

      return max(SMALL_ICON_HEIGHT, wxDATAVIEW_DEFAULT_ROW_HEIGHT) + fromDIP(EXTRA_MARGIN);
  }

  void onSetFocus( WxFocusEvent event )
  {
    _hasFocus = true;

    // Make the control usable from keyboard once it gets focus by ensuring
    // that it has a current row, if at all possible.
    if ( !hasCurrentRow() && !isEmpty() ) {
        changeCurrentRow(0);
    }

    if (hasCurrentRow()) {
        refresh();
    }

    event.skip();
}

  void onKillFocus( WxFocusEvent event )
  {
    _hasFocus = false;

    if (hasCurrentRow()) {
        refresh();
    }

    event.skip();
  }

  void onCharHook( WxKeyEvent event )
  {
    event.skip(); 
  }

  void onChar( WxKeyEvent event )
  {
    if (getModel() == null) {
      return;
    }
    final model = getModel()!;

    // no item -> nothing to do
    if (!hasCurrentRow())
    {
        event.skip();
        return;
    }

    switch (event.getKeyCode())
    {
        case WXK_RETURN:
            if ( event.hasModifiers() )  {
                event.skip();
                return;
            }
            else
            {
                // Enter activates the item, i.e. sends wxEVT_DATAVIEW_ITEM_ACTIVATED to
                // it. Only if that event is not handled do we activate column renderer (which
                // is normally done by Space) or even inline editing.
                final item = getItemByRow(_currentRow);
                final le = WxDataViewEvent( wxGetDataViewItemActivatedEventType(), _owner, null, item );
                if ( _owner.processEvent(le) ) {
                    return;
                }
            }
            break;
        case WXK_SPACE:
            if ( event.hasModifiers() )   {
                event.skip();
                return;
            }
            else
            {
                // Space toggles activatable items or -- if not activatable --
                // starts inline editing (this is normally done using F2 on
                // Windows, but Space is common everywhere else, so use it too
                // for greater cross-platform compatibility).

                final item = getItemByRow(_currentRow);

                // Activate the current activatable column. If not column is focused (typically
                // because the user has full row selected), try to find the first activatable
                // column (this would typically be a checkbox and we don't want to force the user
                // to set focus on the checkbox column).
                final activatableCol = findColumnForEditing(item, wxDATAVIEW_CELL_ACTIVATABLE);

                if ( activatableCol != null)
                {
                    final colIdx = activatableCol.getModelColumn();
                    final cellRect = getOwner().getItemRect(item, activatableCol);

                    final cell = activatableCol.getRenderer();
                    cell.prepareForItem(model, item );
                    cell.activateCell(cellRect, model, item, colIdx );
                    return;
                }
            }
          case WXK_F2:
            if ( event.hasModifiers() )   {
                event.skip();
                return;
            }
            else
            {
                if ( !_selection.isEmpty() )
                {
                    // Mimic Windows 7 behavior: edit the item that has focus
                    // if it is selected and the first selected item if focus
                    // is out of selection.
                    int sel = 0;
                    if ( _selection.isSelected(_currentRow) )
                    {
                        sel = _currentRow;
                    }
                    else // Focused item is not selected.
                    {
                        sel = _selection.getFirstSelectedItem();
                    }

                    final item = getItemByRow(sel);

                    // Edit the current column. If no column is focused
                    // (typically because the user has full row selected), try
                    // to find the first editable column.
                    final editableCol = findColumnForEditing(item, wxDATAVIEW_CELL_EDITABLE);

                    if ( editableCol != null) {
                        getOwner().editItem(item, editableCol);
                    }
                    return;
                }
            }
        case WXK_ADD:
            if (!getOwner().hasFlag( wxDV_NO_TWISTER_BUTTONS)) {
              expand(_currentRow);
            }
            return;

        case WXK_MULTIPLY:
            if (!getOwner().hasFlag( wxDV_NO_TWISTER_BUTTONS)) {
              if ( !isExpanded(_currentRow) )
              {
                  expand( _currentRow, expandChildren: true );
                  return;
              }
              //else: fall through to Collapse()
              // wxFALLTHROUGH;
            }
        case WXK_SUBTRACT:
            if (!getOwner().hasFlag( wxDV_NO_TWISTER_BUTTONS)) {
              collapse(_currentRow);
            }
            return;
        case WXK_END:
            goToRelativeRow(event, getRowCount());
            return;

        case WXK_HOME:
            goToRelativeRow(event, -getRowCount());
            return;
        case WXK_UP:
            goToRelativeRow(event, -1);
            return;

        case WXK_DOWN:
            goToRelativeRow(event, 1);
            return;
    }
    event.skip();
  }

  void goToRelativeRow( WxKeyEvent kbdState, int delta )
  {
    // if there is no selection, we cannot move it anywhere
    if (!hasCurrentRow() || isEmpty()) return;

    int newRow = _currentRow + delta;

    // let's keep the new row inside the allowed range
    if ( newRow < 0 ) {
        newRow = 0;
    }

    final rowCount = getRowCount();
    if ( newRow >= rowCount ) {
        newRow = rowCount - 1;
    }

    goToRow(kbdState, newRow);
  }

void goToRow( WxKeyEvent kbdState,  int newCurrent)
{
    int oldCurrent = _currentRow;

    if ( newCurrent == oldCurrent ) return;

    // in single selection we just ignore Shift as we can't select several
    // items anyhow
    if ( kbdState.shiftDown() && !isSingleSel() )
    {
        refreshRow( oldCurrent );

        changeCurrentRow( newCurrent );

        // select all the items between the old and the new one
        if ( oldCurrent > newCurrent )
        {
            newCurrent = oldCurrent;
            oldCurrent = _currentRow;
        }

        selectRows(oldCurrent, newCurrent);

        final firstSel = _selection.getFirstSelectedItem();
        if ( firstSel != -1 ) {
            sendSelectionChangedEvent( getItemByRow(firstSel) );
        }
    }
    else // !shift
    {
        refreshRow( oldCurrent );

        // all previously selected items are unselected unless ctrl is held
        if ( !kbdState.controlDown() ) {
            unselectAllRows();
        }

        changeCurrentRow( newCurrent );

        if ( !kbdState.controlDown() )
        {
            selectRow( _currentRow, true );
            sendSelectionChangedEvent( getItemByRow( _currentRow ));
        }
        else {
            refreshRow( _currentRow );
        }
    }

    getOwner().ensureVisibleRowCol( _currentRow, -1 );
  }

  WxDataViewColumn? findColumnForEditing( WxDataViewItem item, int mode) 
  {
    // Edit the current column editable in 'mode'. If no column is focused
    // (typically because the user has full row selected), try to find the
    // first editable column (this would typically be a checkbox for
    // wxDATAVIEW_CELL_ACTIVATABLE and we don't want to force the user to set
    // focus on the checkbox column; or on the only editable text column).

    WxDataViewColumn? candidate = _currentCol;

    if ( (candidate != null) && !isCellEditableInMode(item, candidate, mode) )
    {
        if ( _currentColSetByKeyboard )
        {
            // If current column was set by keyboard to something not editable (in
            // 'mode') and the user pressed Space/F2 then do not edit anything
            // because focus is visually on that column and editing
            // something else would be surprising.
            return null;
        }
        else
        {
            // But if the current column was set by mouse to something not editable (in
            // 'mode') and the user pressed Space/F2 to edit it, treat the
            // situation as if there was whole-row focus, because that's what is
            // visually indicated and the mouse click could very well be targeted
            // on the row rather than on an individual cell.
            candidate = null;
        }
    }

    if ( candidate == null)
    {
        final cols = getOwner().getColumnCount();
        for ( int i = 0; i < cols; i++ )
        {
            final c = getOwner().getColumnAt(i);
            if (c == null) continue;
            if ( c.isHidden() ) continue;

            if ( isCellEditableInMode(item, c, mode) )
            {
                candidate = c;
                break;
            }
        }
    }

    // Switch to the first column with value if the current column has no value
    if ( (candidate!=null) && !getModel()!.hasValue(item, candidate.getModelColumn()) ) {
        candidate = findFirstColumnWithValue(item);
    }

    if ( candidate == null ) {
        return null;
    }

    if ( !isCellEditableInMode(item, candidate, mode) ) {
        return null;
    }

    return candidate;
  }

  WxDataViewFindNodeResult findNode( WxDataViewItem item )
  {
    final result = WxDataViewFindNodeResult();
    result._subtreeRealized = true;

    if (getModel() == null) {
      return result;
    }
    final model = getModel()!;

    if (!item.isOk())
    {
        result._node = _root;
        return result;
    }

    // Compose the parent-chain for the item we are looking for
    List<WxDataViewItem> parentChain = [];
    WxDataViewItem it = item;
    while( it.isOk() )
    {
        parentChain.add(it);
        it = model.getParent(it);
    }

    if (_root == null) {
      wxLogError( "no root" );
      return result;
    }

    // Find the item along the parent-chain.
    // This algorithm is designed to speed up the node-finding method
    WxDataViewTreeNode node = _root!;
    for (int iter = parentChain.length-1; iter >= 0; iter--)
    {
        if( node.hasChildren() )
        {
            if( node.getChildNodes().isEmpty )
            {
                // Even though the item is a container, it doesn't have any
                // child nodes in the control's representation yet.
                result._subtreeRealized = false;
                return result;
            }

            final nodes = node.getChildNodes();
            bool found = false;

            for (final currentNode in nodes)
            {
                if (currentNode.getItem() == parentChain[iter])
                {
                    if (currentNode.getItem() == item)
                    {
                        result._node = currentNode;
                        return result;
                    }

                    node = currentNode;
                    found = true;
                    break;
                }
            }
            if (!found) {
                return result;
            }
        }
        else {
            return result;
        }

        if ( iter == 0 ) {
            break;
        }
    }
    return result;
  }

  void onMouse( WxMouseEvent event )
  {
    if (getModel() == null) {
      return;
    }
    final model = getModel()!;

    if (event.getEventType() == wxGetMouseWheelEventType())
    {
        // let the base handle mouse wheel events.
        event.skip();
        return;
    }

    WxPoint pos = _owner.calcUnscrolledPosition( event.getPosition() );
    final x = pos.x;
    final y = pos.y;
    WxDataViewColumn? col;

    int xpos = 0;
    int cols = getOwner().getColumnCount();
    for (int i = 0; i < cols; i++)
    {
        final c = getOwner().getColumnAt( i );
        if (c == null) continue;
        if (c.isHidden()) continue;      // skip it!
        if (x < xpos + c.getWidth())
        {
            col = c;
            break;
        }
        xpos += c.getWidth();
    }

    final current = getLineAt( y );
    final item = getItemByRow(current);

    if (event.buttonDown())
    {
        _lastMouseEventPosition = event.getPosition();

        // Not skipping button down events would prevent the system from
        // setting focus to this window as most (all?) of them do by default,
        // so skip it to enable default handling.
        event.skip();

        // Also stop editing if any mouse button is pressed: this is not really
        // necessary for the left button, as it would result in a focus loss
        // that would make the editor close anyhow, but we do need to do it for
        // the other ones and it does no harm to do it for the left one too.
        finishEditing();
    }

    // Handle right clicking here, before everything else as context menu
    // events should be sent even when we click outside of any item, unlike all
    // the other ones.
    if (event.rightUp())
    {
        final le = WxDataViewEvent( wxGetDataViewContextMenuEventType(), _owner, col, item);
        // TODO figure out right coordinate system
        le.setPosition(event.getX(), event.getY());
        _owner.processEvent(le);
        return;
    }
/*
#if wxUSE_DRAG_AND_DROP
    if (event.Dragging() || ((m_dragCount > 0) && event.Leaving()))
    {
        if (m_dragCount == 0)
        {
            // we have to report the raw, physical coords as we want to be
            // able to call HitTest(event.m_pointDrag) from the user code to
            // get the item being dragged
            m_dragStart = event.GetPosition();
        }

        m_dragCount++;
        if ((m_dragCount < 3) && (event.Leaving()))
            m_dragCount = 3;
        else if (m_dragCount != 3)
            return;

        if (event.LeftIsDown())
        {
            m_owner->CalcUnscrolledPosition( m_dragStart.x, m_dragStart.y,
                                             &m_dragStart.x, &m_dragStart.y );
            unsigned int drag_item_row = GetLineAt( m_dragStart.y );
            if (drag_item_row >= GetRowCount() || m_dragStart.x > GetEndOfLastCol())
                return;

            wxDataViewItem itemDragged = GetItemByRow( drag_item_row );

            // Notify cell about drag
            wxDataViewEvent evt(wxEVT_DATAVIEW_ITEM_BEGIN_DRAG, m_owner, itemDragged);
            if (!m_owner->HandleWindowEvent( evt ))
                return;

            if (!evt.IsAllowed())
                return;

            wxDataObject *obj = evt.GetDataObject();
            if (!obj)
                return;

            wxDataViewDropSource drag( this, drag_item_row );
            drag.SetData( *obj );
            /* wxDragResult res = */ drag.DoDragDrop(evt.GetDragFlags());
            delete obj;
        }
        return;
    }
    else
    {
        m_dragCount = 0;
    }
#endif // wxUSE_DRAG_AND_DROP
*/
    // Check if we clicked or moved outside the item area.
    if ((current >= getRowCount()) || (col == null))
    {
        // Follow Windows convention here: clicking either left or right (but
        // not middle) button clears the existing selection.
        if (/*_owner && */(event.leftDown() || event.rightDown()))
        {
            if (!_selection.isEmpty())
            {
                _owner.unselectAll();
                sendSelectionChangedEvent(WxDataViewItem());
            }
        }

        if (_underMouseItem != null) {
            refreshRow(getRowByItem(_underMouseItem!.getItem()));
            _underMouseItem = null;
        }
        if (_underMouse != null) {
            refreshRow(getRowByItem(_underMouse!.getItem()));
            _underMouse = null;
        }

        event.skip();
        return;
    }


    bool hoverOverItem = false;
    if (!isList() && !event.leaving() && !wxTheApp.isTouch())
    {
        final node = getTreeNodeByRow(current);
        if (node == null) {
          wxLogError("Wrong node");
          return;
        }
        hoverOverItem = true;
        if ((_underMouseItem != null) && (_underMouseItem != node))
        {
          refreshRow(getRowByItem(_underMouseItem!.getItem()));
        }
        if (_underMouseItem != node)
        {
          refreshRow(current);
        }
        _underMouseItem = node;
    }
    if (!hoverOverItem)
    {
        if (_underMouseItem != null)
        {
            // wxLogMessage("Undo the row: %d", GetRowByItem(_underMouseItem->GetItem()));
            refreshRow(getRowByItem(_underMouseItem!.getItem()));
            _underMouseItem = null;
        }
    }

    // Test whether the mouse is hovering over the expander (a.k.a tree "+"
    // button) and also determine the offset of the real cell start, skipping
    // the indentation and the expander itself.
    final expander = getExpanderColumnOrFirstOne(getOwner());
    bool hoverOverExpander = false;
    int itemOffset = 0;
    if ((!isList()) && (expander == col) && (!getOwner().hasFlag(wxDV_NO_TWISTER_BUTTONS) && !event.leaving()))
    {
        final node = getTreeNodeByRow(current);
        if (node == null) {
          wxLogError("Wrong node");
          return;
        }
        final indent = node.getIndentLevel();
        itemOffset = getOwner().getIndent()*indent;
        final expWidth = _getExpanderSize().getWidth();

        if ( node.hasChildren() )
        {
            // we make the rectangle we are looking in a bit bigger than the actual
            // visual expander so the user can hit that little thing reliably
            final rect = WxRect( xpos + itemOffset,
                                 getLineStart( current ) + (getLineHeight(current) - _lineHeight)~/2,
                                 expWidth, _lineHeight);

            if( rect.contains(x, y) )
            {
                // So the mouse is over the expander
                hoverOverExpander = true;
                if ((_underMouse != null) && (_underMouse != node))
                {
                    // wxLogMessage("Undo the row: %d", GetRowByItem(m_underMouse->GetItem()));
                    refreshRow(getRowByItem(_underMouse!.getItem()));
                }
                if (_underMouse != node)
                {
                    // wxLogMessage("Do the row: %d", current);
                    refreshRow(current);
                }
                _underMouse = node;
            }
        }

        // Account for the expander as well, even if this item doesn't have it,
        // its parent does so it still counts for the offset.
        itemOffset += expWidth;
    }
    if (!hoverOverExpander)
    {
        if (_underMouse != null)
        {
            // wxLogMessage("Undo the row: %d", GetRowByItem(m_underMouse->GetItem()));
            refreshRow(getRowByItem(_underMouse!.getItem()));
            _underMouse = null;
        }
    }

    bool simulateClick = false;

    if (event.buttonDClick())
    {
        _renameTimer.stop(); 
        _lastOnSame = false;
    }

    bool ignore_other_columns =
        (expander != col) &&
        (!model.hasValue(item, col.getModelColumn()));

    if (event.leftDClick())
    {
        if ( !hoverOverExpander && (current == _lineLastClicked) )
        {
            final le = WxDataViewEvent( wxGetDataViewItemActivatedEventType(), _owner, col, item);
            if ( _owner.processEvent(le) )
            {
                // Item activation was handled from the user code.
                return;
            }
        }

        // Either it was a double click over the expander, or the second click
        // happened on another item than the first one or it was a bona fide
        // double click which was unhandled. In all these cases we continue
        // processing this event as a simple click, e.g. to select the item or
        // activate the renderer.
        simulateClick = true;
    }

    if (event.leftUp() && !hoverOverExpander)
    {
          if (_lineSelectSingleOnUp != -1)
          {
              // select single line
              if ( unselectAllRows( except: _lineSelectSingleOnUp) )
              {
                  selectRow( _lineSelectSingleOnUp, true );
              }

              sendSelectionChangedEvent( getItemByRow( _lineSelectSingleOnUp) );
          }

          // If the user click the expander, we do not do editing even if the column
          // with expander are editable
          if (_lastOnSame && !ignore_other_columns)
          {
              if ((col == _currentCol) && (current == _currentRow) &&
                  isCellEditableInMode(item, col, wxDATAVIEW_CELL_EDITABLE) )
              {
                _renameTimer.startOnce( milliseconds: 100 );
              }
          }

        _lastOnSame = false;
        _lineSelectSingleOnUp = -1;
        
        if (wxTheApp.isTouch())
        {
          final dx = event.getPosition().x - _lastMouseEventPosition.x;
          final dy = event.getPosition().y - _lastMouseEventPosition.y;
          final squareDistance = dx*dx + dy*dy;
          if (squareDistance < 15*15) // Google determined the touch slop to be 18
          {
            final item = getItemByRow(_currentRow);
            final le = WxDataViewEvent( wxGetDataViewItemActivatedEventType(), _owner, null, item );
            _owner.processEvent(le);
          }
        }

    }
    else if(!event.leftUp())
    {
        // This is necessary, because after a DnD operation in
        // from and to ourself, the up event is swallowed by the
        // DnD code. So on next non-up event (which means here and
        // now) m_lineSelectSingleOnUp should be reset.
        _lineSelectSingleOnUp = -1;
    }

    if (event.rightDown())
    {
        _lineBeforeLastClicked = _lineLastClicked;
        _lineLastClicked = current;

        // If the item is already selected, do not update the selection.
        // Multi-selections should not be cleared if a selected item is clicked.
        if (!isRowSelected(current))
        {
            unselectAllRows();

            final oldCurrent = _currentRow;
            changeCurrentRow(current);
            selectRow(_currentRow,true);
            refreshRow(oldCurrent);
            sendSelectionChangedEvent(getItemByRow( _currentRow ) );
        }
    }
    else if (event.middleDown())
    {
    }

    if((event.leftDown() || simulateClick) && hoverOverExpander)
    {
        final node = getTreeNodeByRow(current);

        // hoverOverExpander being true tells us that our node must be
        // valid and have children.
        // So we don't need any extra checks.
        if ( node!.isOpen() ) {
          collapse(current);
        } else {
          expand(current);
        }
    }
    else if ((event.leftDown() || simulateClick) && !hoverOverExpander)
    {
        _lineBeforeLastClicked = _lineLastClicked;
        _lineLastClicked = current;

        final oldCurrentRow = _currentRow;
        bool oldWasSelected = isRowSelected(_currentRow);

        bool cmdModifierDown = event.cmdDown();
        if ( isSingleSel() || !(cmdModifierDown || event.shiftDown()) )
        {
            if ( isSingleSel() || !isRowSelected(current) )
            {
                changeCurrentRow(current);
                if ( unselectAllRows( except: current) )
                {
                    selectRow(_currentRow,true);
                    sendSelectionChangedEvent(getItemByRow( _currentRow ) );
                }
            }
            else // multi sel & current is highlighted & no mod keys
            {
                _lineSelectSingleOnUp = current;
                changeCurrentRow(current); // change focus
            }
        }
        else // multi sel & either ctrl or shift is down
        {
            if (cmdModifierDown)
            {
                changeCurrentRow(current);
                reverseRowSelection(_currentRow);
                sendSelectionChangedEvent(getItemByRow(_currentRow));
            }
            else if (event.shiftDown())
            {
                changeCurrentRow(current);

                int lineFrom = oldCurrentRow,
                    lineTo = current;

                if ( lineFrom == -1 )
                {
                    // If we hadn't had any current row before, treat this as a
                    // simple click and select the new row only.
                    lineFrom = current;
                }

                if ( lineTo < lineFrom )
                {
                    lineTo = lineFrom;
                    lineFrom = _currentRow;
                }

                selectRows(lineFrom, lineTo);

                final firstSel = _selection.getFirstSelectedItem();
                if ( firstSel != -1 ) {
                    sendSelectionChangedEvent(getItemByRow(firstSel) );
                }
            }
            else // !ctrl, !shift
            {
                // test in the enclosing if should make it impossible
                wxLogError( "how did we get here?" );
            }
        }

        if (_currentRow != oldCurrentRow) {
            refreshRow( oldCurrentRow );
        }

        final oldCurrentCol = _currentCol;

        // Update selection here...
        _currentCol = col;
        _currentColSetByKeyboard = false;

        // This flag is used to decide whether we should start editing the item
        // label. We do it if the user clicks twice (but not double clicks,
        // i.e. simulateClick is false) on the same item but not if the click
        // was used for something else already, e.g. selecting the item (so it
        // must have been already selected) or giving the focus to the control
        // (so it must have had focus already).
        _lastOnSame = !simulateClick && ((col == oldCurrentCol) &&
                        (current == oldCurrentRow)) && oldWasSelected &&
                        hasFocus();

        // Call ActivateCell() after everything else as under GTK+
        if ( isCellEditableInMode(item, col, wxDATAVIEW_CELL_ACTIVATABLE) )
        {
            final cell = col.getRenderer();

            // notify cell about click

            final  cell_rect = WxRect( xpos + itemOffset,
                              getLineStart( current ),
                              col.getWidth() - itemOffset,
                              getLineHeight( current ) );

            // Note that PrepareForItem() should be called after GetLineStart()
            // call in cell_rect initialization above as GetLineStart() calls
            // PrepareForItem() for other items from inside it.
            cell.prepareForItem(model, item);

            // Report position relative to the cell's custom area, i.e.
            // not the entire space as given by the control but the one
            // used by the renderer after calculation of alignment etc.
            //
            // Notice that this results in negative coordinates when clicking
            // in the upper left corner of a centre-aligned cell which doesn't
            // fill its column entirely so this is somewhat surprising, but we
            // do it like this for compatibility with the native GTK+ version,
            // see #12270.

            // adjust the rectangle ourselves to account for the alignment
            final align = cell._getEffectiveAlignment();

            final rectItem = WxRect.fromRect( cell_rect );
            WxSize size = cell._getSize();
            if ( size.x >= 0 && size.x < cell_rect.width )
            {
                if ( align & wxALIGN_CENTER_HORIZONTAL != 0) {
                    rectItem.x += (cell_rect.width - size.x)~/2;
                } else if ( align & wxALIGN_RIGHT !=0 ) {
                    rectItem.x += cell_rect.width - size.x;
                }
                // else: wxALIGN_LEFT is the default
            }

            if ( size.y >= 0 && size.y < cell_rect.height )
            {
                if ( align & wxALIGN_CENTER_VERTICAL != 0 ) {
                    rectItem.y += (cell_rect.height - size.y)~/2;
                } else if ( align & wxALIGN_BOTTOM != 0) {
                    rectItem.y += cell_rect.height - size.y;
                }
                // else: wxALIGN_TOP is the default
            }

            /*
            wxMouseEvent event2(event);
            event2.m_x -= rectItem.x;
            event2.m_y -= rectItem.y;
            m_owner->CalcUnscrolledPosition(event2.m_x, event2.m_y, &event2.m_x, &event2.m_y);
            */
            final scrollPos = WxPoint( event.getX() - rectItem.x, event.getY() - rectItem.y );
            final pos = _owner.calcUnscrolledPosition( scrollPos );

             /* ignore ret */ cell.activateCell
                                    (
                                        cell_rect,
                                        model,
                                        item,
                                        col.getModelColumn(),
                                        fromMouseClick: true,
                                        pos: pos
                                    );
        }
    }

  }

  bool isCellEditableInMode( WxDataViewItem item, WxDataViewColumn col, int mode ) 
  {
      final model = getModel()!;

      if ( col.getRenderer().getMode() != mode ) return false;

      if ( !model.isEnabled(item, col.getModelColumn()) ) return false;

      if ( !model.hasValue(item, col.getModelColumn()) ) return false;

      return true;
  }

  void sendSelectionChangedEvent( WxDataViewItem item ) {
    final le = WxDataViewEvent( wxGetDataViewSelectionChangedEventType(), _owner, null, item);
    _owner.processEvent(le);
  }

  void onRenameTimer(WxTimerEvent event) {
    if (_dirty) {
      _recalculateDisplay();
      _dirty = false;
    }
    final item = getItemByRow( _currentRow );
    if (_currentCol != null) {
      startEditing( item, _currentCol! );
    } else {
      wxLogError( "No column for renaming/editing item" );
    }
  }

  void startEditing( WxDataViewItem item, WxDataViewColumn col)
  {
    if (_editorCtrl != null) {
      wxLogError( "already editing item" );
      return;
    }

    final renderer = col.getRenderer();
    if ( !isCellEditableInMode(item, col, wxDATAVIEW_CELL_EDITABLE) ) {
        return;
    }

    final itemRect = getItemRect(item, col);
    if ( renderer.startEditing(item, itemRect) )
    {
        renderer._notifyEditingStarted(item);

        // Save the renderer to be able to finish/cancel editing it later and
        // save the control to be able to detect if we're still editing it.
        _editorRenderer = renderer;
        _editorCtrl = renderer.getEditorCtrl();
    }
  }

  void finishEditing() {
    if (_editorCtrl != null) {
      if (_editorRenderer != null) {
        _editorRenderer!.finishEditing();
      }
      _editorCtrl = null;
    }
  }

  void cancelEditing() {
    if (_editorCtrl != null) {
      if (_editorRenderer != null) {
        _editorRenderer!.cancelEditing();
      }
      _editorCtrl = null;
    }
  }

  void drawCellBackground( WxDataViewRenderer cell, WxDC dc, WxRect rect )
  {
      WxRect rectBg = WxRect.fromRect( rect );

      // don't overlap the horizontal rules
      if ( _owner.hasFlag(wxDV_HORIZ_RULES) )
      {
          rectBg.y++;
          rectBg.height--;
      }

      // don't overlap the vertical rules
      if ( _owner.hasFlag(wxDV_VERT_RULES) )
      {
          // same note as in OnPaint handler above
          // NB: Vertical rules are drawn in the last pixel of a column so that
          //     they align perfectly with native MSW wxHeaderCtrl as well as for
          //     consistency with MSW native list control. There's no vertical
          //     rule at the most-left side of the control.
          rectBg.width--;
      }

      cell.renderBackground( dc, rectBg);
  }

  bool _isSingleColumn() 
  {
    int count = 0;
    for ( int i = 0; i < getOwner().getColumnCount(); i++)
    {
      final col = getOwner().getColumnAt( i );
      if (col == null) continue;
      if ( col.isHidden() ) continue;       // skip it!
      count++;
    }
    return count == 1;
  }

  WxRect _calculateSelectionRect( WxRect rowRect, int item ) 
  {
    WxRect selectionRect = WxRect.fromRect( rowRect );

    if (getModel() == null) return selectionRect;
    final model = getModel()!;

    if (_isSingleColumn() && (!model.isListModel()) && (!wxTheApp.isTouch()))
    {
                    // Apply margins around selection rectangle when
                    // only a single column is used
                    final col = getOwner().getColumnAt( 0 );
                    if ((col != null) && !col.isHidden())
                    {
                      final node = getTreeNodeByRow(item);
                      if (node == null) {
                        wxLogError( "no node for item" );
                        return selectionRect;
                      }
                      final padding = fromDIP(wxDATAVIEW_CELL_PADDING_RIGHTLEFT);
                      final renderer = col.getRenderer();
                      final dataitem = node.getItem();
                      renderer.prepareForItem( model, dataitem );
                      final itemSize = renderer._getSize();
                      selectionRect.width = itemSize.x + 2*padding;
                      final exp =  _getExpanderSize();
                      selectionRect.x = /* padding + */ getOwner().getIndent() * node.getIndentLevel();
                      if (!getOwner().hasFlag( wxDV_NO_TWISTER_BUTTONS) || (!node.hasChildren())) {
                        selectionRect.x += exp.x;
                      }
                      final margins = renderer._getMargins();
                      selectionRect.deflate( margins.x*3~/4, margins.y*3~/4 );
                    }
    }
    else
    {
      WxSize rowMargins = WxSize(50,50);
      for (int i = 0; i < getOwner().getColumnCount(); i++)
      {
        final col = getOwner().getColumnAt( i );
        if (col == null) continue;
        if ( col.isHidden() ) continue;

        final renderer = col.getRenderer();
        final margins = renderer._getMargins();
        rowMargins = WxSize( min(rowMargins.x, margins.x), min(rowMargins.y, margins.y) );
        if ((rowMargins.x == 0) && (rowMargins.y == 0)) break;
      }
      selectionRect.deflate( rowMargins.x*2~/3, rowMargins.y*2~/3);
    }

    return selectionRect;
  }

  WxSize _getExpanderSize()
  {
    if (_owner.hasFlag(wxDV_NATIVE_EXPANDER)) {
      return wxGetRendererNative().getExpanderSize(this);
    } else {
      return WxSize(20,20);
    }
  }

  void _drawTreeItemButton( WxDC dc, WxRect rect, int flags, WxDataViewItem item )
  {
    if (_owner.hasFlag(wxDV_NATIVE_EXPANDER))
    {
      wxGetRendererNative().drawTreeItemButton( this, dc, rect, flags: flags );
    }
    else 
    {
      if (_owner.hasFlag(wxDV_PLUSMINUS_EXPANDER))
      {
        if (wxTheApp.isDark()) {
          dc.setPen( wxWHITE_PEN );
        } else {
          dc.setPen( wxBLACK_PEN );
        }
        int margin = 4;
        if ((flags & wxCONTROL_EXPANDED) == 0) {
          dc.drawLine(rect.x + rect.width ~/2, 1+rect.y + margin, rect.x + rect.width ~/2, rect.y + rect.height - margin );
          dc.drawLine(1+rect.x + rect.width ~/2, 1+rect.y + margin, 1+rect.x + rect.width ~/2, rect.y + rect.height - margin );
        }
        dc.drawLine(1+rect.x + margin, rect.y + rect.height~/2, rect.x+rect.width- margin, rect.y + rect.height~/2 );
        dc.drawLine(1+rect.x + margin, 1 + rect.y + rect.height~/2, rect.x+rect.width- margin, 1+ rect.y + rect.height~/2 );
      }
      else
      {
        if (flags & wxCONTROL_CURRENT != 0) {
          if (wxTheApp.isDark()) {
            dc.setPen( wxWHITE_PEN );
          } else {
            dc.setPen( wxBLACK_PEN );
          }
        } else {
          if (wxTheApp.isDark()) {
            dc.setPen( WxPen( WxColour(200,200,200) ) );
          } else {
            dc.setPen( WxPen( WxColour(55,55,55) ) );
          }
        }


        int xmargin = 6;
        int ymargin = 6;
  /*
          dc.drawLine(rect.x + rect.width - xmargin, rect.y + rect.height~/2, rect.x + rect.width ~/2, rect.y + ymargin );
          dc.drawLine(1 + rect.x + rect.width - xmargin, rect.y + rect.height~/2, rect.x + rect.width ~/2, rect.y + ymargin );
          
          dc.drawLine(rect.x + rect.width - xmargin, rect.y + rect.height~/2, rect.x + rect.width ~/2, rect.y + rect.height - ymargin );
          dc.drawLine(1 + rect.x + rect.width - xmargin, rect.y + rect.height~/2, rect.x + rect.width ~/2, rect.y + rect.height - ymargin );
  */
        double angle = 0;
        if ((flags & wxCONTROL_EXPANDED) == 0) {
          if (_chevronAnimationItem == item) {
            angle = 90 - (_chevronAnimationFactor*90);
          } else {
            angle = 0;
          }
        } else {
          if (_chevronAnimationItem == item) {
            angle = _chevronAnimationFactor*90;
          } else {
            angle = 90;
          }
        }
        _drawRotatedLine( dc,
            (rect.x + rect.width - xmargin).toDouble(), 
            (rect.y + rect.height~/2).toDouble(), 
            (rect.x + rect.width ~/2).toDouble(), 
            (rect.y + ymargin).toDouble(),
            (rect.x + rect.width ~/2).toDouble(), 
            (rect.y + rect.height~/2).toDouble(), 
            angle );
        _drawRotatedLine( dc,
            (1 + rect.x + rect.width - xmargin).toDouble(), 
            (rect.y + rect.height~/2).toDouble(), 
            (1+rect.x + rect.width ~/2).toDouble(), 
            (rect.y + ymargin).toDouble(),
            (rect.x + rect.width ~/2).toDouble(), 
            (rect.y + rect.height~/2).toDouble(), 
            angle );
        _drawRotatedLine( dc,
            (rect.x + rect.width - xmargin).toDouble(), 
            (rect.y + rect.height~/2).toDouble(), 
            (rect.x + rect.width ~/2).toDouble(), 
            (rect.y + rect.height - ymargin).toDouble(),
            (rect.x + rect.width ~/2).toDouble(), 
            (rect.y + rect.height~/2).toDouble(), 
            angle );
        _drawRotatedLine( dc, 
            (1 + rect.x + rect.width - xmargin).toDouble(), 
            (rect.y + rect.height~/2).toDouble(), 
            (1+rect.x + rect.width ~/2).toDouble(), 
            (rect.y + rect.height - ymargin).toDouble(),
            (rect.x + rect.width ~/2).toDouble(), 
            (rect.y + rect.height~/2).toDouble(), 
            angle );
      }
    }
  }

double _getTargetAngleFromDelta( final double dx, final double dy, final double dist )
{
   double targetAngle = asin(dx / dist);
   if (dy > 0)
   {
         if (targetAngle < 0) {
            targetAngle = -pi - targetAngle;
         } else {
            targetAngle = pi - targetAngle;
         }
   }

   return targetAngle;
}

  void _drawRotatedLine( WxDC dc, double x1, double y1, double x2, double y2, double centerX, double centerY, double angle )
  {
    final double dx1 = x1 - centerX;
    final double dy1 = y1 - centerY;
    final double dist1 = sqrt(dx1 * dx1 + dy1 * dy1);
    double angle1 = _getTargetAngleFromDelta( dx1, dy1, dist1 );
    angle1 += (angle*pi/180);
    x1 = centerX + sin(angle1) * dist1;
    y1 = centerY - cos(angle1) * dist1;

    final double dx2 = x2 - centerX;
    final double dy2 = y2 - centerY;
    final double dist2 = sqrt(dx2 * dx2 + dy2 * dy2);
    double angle2 = _getTargetAngleFromDelta( dx2, dy2, dist2 );
    angle2 += (angle*pi/180);
    x2 = centerX + sin(angle2) * dist2;
    y2 = centerY - cos(angle2) * dist2;

    dc.drawLine( x1.round(), y1.round(), x2.round(), y2.round() );
  }

  void onPaint( WxPaintEvent event )
  {
    final dc = WxPaintDC( this );
    final scrolled = getParent() as WxScrolledWindow;
    scrolled.doPrepareDC(dc);

    // final vsize = getVirtualSize();
    // dc.setBrush(wxLIGHT_GREY_BRUSH);
    // dc.drawRectangle(0, 0, vsize.x, vsize.y);

    if (getModel() == null) return;
    final model = getModel()!;

    final size = getClientSize();

    if ( isEmpty() ) return;

    _penRule = wxTheApp.isDark() ? wxGREY_PEN : wxLIGHT_GREY_PEN;

    final update = getUpdateClientRect();
    update.setPosition( _owner.calcUnscrolledPosition( update.getPosition() ) );
 
    // compute which items needs to be redrawn
    final item_start = getLineAt( max(0,update.y) );
    final item_count =  min( getLineAt( max(0,update.y+update.height) ) - item_start + 1,
                             getRowCount( ) - item_start);
    final item_last = item_start + item_count;

    // Send the event to wxDataViewCtrl itself.
    final cache_event = WxDataViewEvent( wxGetDataViewCacheHintEventType(), _owner, null, WxDataViewItem() );
    cache_event.setCache(item_start, item_last - 1);
    _owner.processEvent(cache_event);

    // compute which columns needs to be redrawn
    final cols = getOwner().getColumnCount();
    if (cols == 0) return;

    int col_start = 0;
    int x_start = 0;
    for (x_start = 0; col_start < cols; col_start++)
    {
        final col = getOwner().getColumnAt(col_start);
        if (col == null) continue;
        if (col.isHidden()) continue;
        final w = col.getWidth();
        if (x_start+w >= update.x) break;
        x_start += w;
    }

    int col_last = col_start;
    int x_last = x_start;
    for (; col_last < cols; col_last++)
    {
        final col = getOwner().getColumnAt(col_last);
        if (col == null) continue;
        if (col.isHidden()) continue;
        if (x_last > update.getRight()) break;
        x_last += col.getWidth();
    }

    // Instead of calling GetLineStart() for each line from the first to the
    // last one, we will compute the starts of the lines as we iterate over
    // them starting from this one, as this is much more efficient when using
    // wxDV_VARIABLE_LINE_HEIGHT (and doesn't really change anything when not
    // using it, so there is no need to use two different approaches).
    final first_line_start = getLineStart(item_start);

    // Draw background of alternate rows specially if required
    if ( _owner.hasFlag(wxDV_ROW_LINES) )
    {
        WxColour altRowColour = _owner.getAlternateRowColour();
        if ( !altRowColour.isOk() )
        {
            // Determine the alternate rows colour automatically from the
            // background colour.
            final bgColour = _owner.getBackgroundColour();

            // Depending on the background, alternate row color
            // will be 3% more dark or 10% brighter -- because 3% brighter
            // would be unnoticeable.
            int alpha = bgColour.getRGB() > 0x808080 ? 97 : 110;
            altRowColour = bgColour.changeLightness(alpha);
        }

        dc.setPen(wxTRANSPARENT_PEN);
        dc.setBrush(WxBrush(altRowColour));

        // We only need to draw the visible part, so limit the rectangle to it.
        final xRect = _owner.calcUnscrolledPosition(WxPoint(0, 0)).x;
        final widthRect = size.x;
        int cur_line_start = first_line_start;
        for (int item = item_start; item < item_last; item++)
        {
            final h = getLineHeight(item);
            if ( item % 2 != 0) {
                dc.drawRectangle(xRect, cur_line_start, widthRect, h);
            }
            cur_line_start += h;
        }
    }

    // Draw horizontal rules if required
    if ( _owner.hasFlag(wxDV_HORIZ_RULES) )
    {
        dc.setPen(_penRule);
        dc.setBrush(wxTRANSPARENT_BRUSH);

        int cur_line_start = first_line_start;
        for ( int i = item_start; i < item_last; i++)  // CHECK this was <= in C++, but why?
        {
            final h = getLineHeight(i);
            dc.drawLine(x_start, cur_line_start, x_last, cur_line_start);
            cur_line_start += h;
        }
        dc.drawLine(x_start, cur_line_start, x_last, cur_line_start);
    }

    // Draw vertical rules if required
    if ( _owner.hasFlag(wxDV_VERT_RULES) )
    {
        dc.setPen(_penRule);
        dc.setBrush(wxTRANSPARENT_BRUSH);

        // NB: Vertical rules are drawn in the last pixel of a column so that
        //     they align perfectly with native MSW wxHeaderCtrl as well as for
        //     consistency with MSW native list control. There's no vertical
        //     rule at the most-left side of the control.

        int x = x_start - 1;
        int line_last = getLineStart(item_last);
        for ( int i = col_start; i < col_last; i++)
        {
            final col = getOwner().getColumnAt(i);
            if (col == null) continue;
            if (col.isHidden()) continue;
            x += col.getWidth();
            dc.drawLine(x, first_line_start, x, line_last);
        }
        dc.drawLine(0, first_line_start, 0, line_last);
    }

    // redraw the background for the items which are selected/current
    int cur_line_start = first_line_start;
    for ( int item = item_start; item < item_last; item++)
    {
        bool selected = _selection.isSelected(item);
        final line_height = getLineHeight(item);

        // test for hover effect
        if (!selected && !model.isListModel() && (_underMouseItem != null))
        {
          final node = getTreeNodeByRow(item);
          if (node == null) {
            wxLogError( "no node for item" );
            return;
          }
          if (node == _underMouseItem)
          {
            final rowRect = WxRect( x_start, cur_line_start, x_last - x_start, line_height );

            WxRect selectionRect = _calculateSelectionRect( rowRect, item );
            if (getOwner().hasFlag(wxDV_HORIZ_RULES)) {
              selectionRect.y++;
              selectionRect.height--;
            }

            if (selectionRect.width < 150) {
              // A little contrast for small highlight
              if (wxTheApp.isDark()) {
                dc.setBrush( WxBrush( WxColour(65,65,65) ) );
              } else {
                dc.setBrush( WxBrush( WxColour(235,235,235) ) );
              }
            } else {
              // Almost no contrast for whole line
              if (wxTheApp.isDark()) {
                dc.setBrush( WxBrush( WxColour(55,55,55) ) );
              } else {
                dc.setBrush( WxBrush( WxColour(245,245,245) ) );
              }
            }
            dc.setPen( wxTRANSPARENT_PEN );
            if (wxIsMac() && !wxUsesFlutter()) {
              dc.drawRoundedRectangleRect( selectionRect, 8 );
            } else {
              dc.drawRectangleRect( selectionRect );
            }
          }
        }

        if (selected || item == _currentRow)
        {
            final rowRect = WxRect( x_start, cur_line_start, x_last - x_start, line_height );

            bool renderColumnFocus = false;

            int flags = wxCONTROL_SELECTED;
            if ( _hasFocus ) {
                flags |= wxCONTROL_FOCUSED;
            }

            // draw keyboard focus rect if applicable
            if ( item == _currentRow && _hasFocus )
            {

                if ( _useCellFocus && (_currentCol!=null) && _currentColSetByKeyboard )
                {
                    renderColumnFocus = true;

                    // If there is just a single value, render full-row focus:
                    if ( !isList() )
                    {
                        final node = getTreeNodeByRow(item);
                        if (node == null) { wxLogError( "node not found"); return; }
                        if ( isItemSingleValued(node!.getItem()) ) {
                            renderColumnFocus = false;
                        }
                    }
                }

                if ( renderColumnFocus )
                {
                    WxRect colRect = WxRect.fromRect(rowRect);

                    for (  int i = col_start; i < col_last; i++ )
                    {
                        final col = getOwner().getColumnAt(i);
                        if (col == null) continue;
                        if ( col.isHidden() ) continue;

                        colRect.width = col.getWidth();

                        if ( col == _currentCol )
                        {
                            // Draw selection rect left of column
                            {
                                WxRect clipRect = WxRect.fromRect(rowRect);
                                clipRect.width = colRect.x;

                                // wxDCClipper clip(dc, clipRect);
                                wxGetRendererNative().drawItemSelectionRect
                                    (
                                    this,
                                    dc,
                                    rowRect,
                                    flags: flags
                                    );
                            }

                            // Draw selection rect right of column
                            {
                                WxRect clipRect = WxRect.fromRect(rowRect);
                                clipRect.x = colRect.x + colRect.width;
                                clipRect.width = rowRect.width - clipRect.x;

                                // wxDCClipper clip(dc, clipRect);
                                wxGetRendererNative().drawItemSelectionRect
                                    (
                                    this,
                                    dc,
                                    rowRect,
                                    flags: flags
                                    );
                            }

                            // Draw column selection rect
                            wxGetRendererNative().drawItemSelectionRect
                                (
                                this,
                                dc,
                                colRect,
                                flags: flags | wxCONTROL_CURRENT | wxCONTROL_CELL
                                );

                            break;
                        }

                        colRect.x += colRect.width;
                    }
                }
                else // Not using column focus.
                {
                    flags |= wxCONTROL_FOCUSED;
                    if (getOwner().hasFlag(wxDV_MULTIPLE)) {
                      flags |= wxCONTROL_CURRENT;
                    }

                    if (!wxIsMac())
                    {
                      // We still need to show the current item if it's not
                      // selected.
                      if ( !selected )
                      {
                          WxRect selectionRect = _calculateSelectionRect(rowRect, item );
                          wxGetRendererNative().drawFocusRect
                                                  (
                                                      this,
                                                      dc,
                                                      selectionRect,
                                                      flags: flags
                                                  );
                      }
                      //else: The current item is selected, will be drawn below.
                    }
                }
            }

            // draw selection and whole-item focus:
            if ( selected && !renderColumnFocus )
            {
                WxRect selectionRect = _calculateSelectionRect(rowRect, item );
                if (!_owner.hasFlag(wxDV_MULTIPLE) || (getRowCount() < 2))
                {
                  flags |= wxCONTROL_SELECTION_GROUP | wxCONTROL_ITEM_FIRST | wxCONTROL_ITEM_LAST;
                } 
                else
                {
                  bool isTop = ((item == 0) || !_selection.isSelected(item-1));
                  bool isBottom = ((item == getRowCount()-1) || (!_selection.isSelected(item+1)));
                  flags |= wxCONTROL_SELECTION_GROUP;
                  if (isTop) {
                    flags |= wxCONTROL_ITEM_FIRST;
                  } 
                  if (isBottom) {
                    flags |= wxCONTROL_ITEM_LAST;
                  }
                }

                wxGetRendererNative().drawItemSelectionRect
                    (
                    this,
                    dc,
                    selectionRect,
                    flags: flags
                    );
            }
        }
        cur_line_start += line_height;
    }

/*#if wxUSE_DRAG_AND_DROP
    wxRect dropItemRect;

    if (m_dropItemInfo.m_hint == DropHint_Inside)
    {
        int rect_y = GetLineStart(m_dropItemInfo.m_row);
        int rect_h = GetLineHeight(m_dropItemInfo.m_row);
        wxRect rect(x_start, rect_y, x_last - x_start,  rect_h);

        wxRendererNative::Get().DrawItemSelectionRect(this, dc, rect, wxCONTROL_SELECTED | wxCONTROL_FOCUSED);
    }
#endif // wxUSE_DRAG_AND_DROP
*/
    final expander = getExpanderColumnOrFirstOne(getOwner());

    // redraw all cells for all rows which must be repainted and all columns
    WxRect cell_rect = WxRect.zero();
    cell_rect.x = x_start;
    for ( int i = col_start; i < col_last; i++)
    {
        final col = getOwner().getColumnAt( i );
        if (col == null) continue;
        if ( col.isHidden() ) continue;       // skip it!

        final cell = col.getRenderer();
        cell_rect.width = col.getWidth();
        if ( cell_rect.width <= 0 ) {
            continue;
        }

        cell_rect.y = first_line_start;
        for ( int item = item_start; item < item_last; item++)
        {
            // get the cell value and set it into the renderer
            WxDataViewTreeNode ?node;
            WxDataViewItem dataitem = WxDataViewItem();
            final line_height = getLineHeight(item);

            if (!isVirtualList())
            {
                node = getTreeNodeByRow(item);
                if (node == null)
                {
                    cell_rect.y += line_height;
                    continue;
                }

                dataitem = node.getItem();
            }
            else
            {
                dataitem = WxDataViewItem( index: item );
            }

            // update cell_rect
            cell_rect.height = line_height;

            bool selected = _selection.isSelected(item);

            int state = 0;
            if (selected) {
                state |= wxDATAVIEW_CELL_SELECTED;
            }
            if (_hasFocus) {
                state |= wxDATAVIEW_CELL_FOCUSED;
            }

            cell._setState(state);
            final hasValue = cell.prepareForItem( model, dataitem );

            // draw the background
            if ( !selected ) {
                drawCellBackground( cell, dc, cell_rect );
            }

            // deal with the expander
            int indent = 0;
            if ((!isList()) && (col == expander))
            {
                // Calculate the indent first
                indent = getOwner().getIndent() * node!.getIndentLevel();

                // Get expander size
                WxSize expSize = _getExpanderSize();

                // draw expander if needed
                if ( node.hasChildren() )
                {
                    WxRect rect = WxRect.fromRect( cell_rect );
                    rect.x += indent;
                    rect.y += (cell_rect.getHeight() - expSize.getHeight()) ~/ 2; // center vertically
                    rect.width = expSize.getWidth();
                    rect.height = expSize.getHeight();

                    int flag = 0;
                    if ( _underMouse == node ) {
                        flag |= wxCONTROL_CURRENT;
                    }
                    if ( node.isOpen() ) {
                        flag |= wxCONTROL_EXPANDED;
                    }

                    // ensure that we don't overflow the cell (which might
                    // happen if the column is very narrow)
                    // wxDCClipper clip(dc, cell_rect);

                    if (!getOwner().hasFlag(wxDV_NO_TWISTER_BUTTONS)) {
                      rect.height = rect.width;
                      _drawTreeItemButton( dc, rect, flag, node.getItem());
                    } else {
                      indent -= expSize.getWidth();
                    }
                }

                indent += expSize.getWidth();

                // force the expander column to left-center align
                cell.setAlignment( wxALIGN_CENTER_VERTICAL );

/*
#if wxUSE_DRAG_AND_DROP
                if (item == m_dropItemInfo.m_row)
                {
                    dropItemRect = cell_rect;
                    dropItemRect.x += expSize.GetWidth();
                    dropItemRect.width -= expSize.GetWidth();
                    if (m_dropItemInfo.m_indentLevel >= 0)
                    {
                        int hintIndent = GetOwner()->GetIndent()*m_dropItemInfo.m_indentLevel;
                        dropItemRect.x += hintIndent;
                        dropItemRect.width -= hintIndent;
                    }
                }
#endif
*/
            }

            WxRect item_rect = WxRect.fromRect( cell_rect );
            item_rect.deflate(fromDIP(wxDATAVIEW_CELL_PADDING_RIGHTLEFT), 0);

            // account for the tree indent (harmless if we're not indented)
            item_rect.x += indent;
            item_rect.width -= indent;

            if ( item_rect.width <= 0 )
            {
                cell_rect.y += line_height;
                continue;
            }

            // TODO: it would be much more efficient to create a clipping
            //       region for the entire column being rendered (in the OnPaint
            //       of wxDataViewMainWindow) instead of a single clip region for
            //       each cell. However it would mean that each renderer should
            //       respect the given wxRect's top & bottom coords, eventually
            //       violating only the left & right coords - however the user can
            //       make its own renderer and thus we cannot be sure of that.
            //wxDCClipper clip(dc, item_rect);

            if (hasValue) {
                cell._render(item_rect, dc, state);
            }

            cell_rect.y += line_height;
        }

        cell_rect.x += cell_rect.width;
    }

/*
#if wxUSE_DRAG_AND_DROP
    if (m_dropItemInfo.m_hint == DropHint_Below || m_dropItemInfo.m_hint == DropHint_Above)
    {
        const int insertLineHeight = 2;     // TODO: setup (should be even)

        int rect_y = dropItemRect.y - insertLineHeight~/2;     // top insert
        if (m_dropItemInfo.m_hint == DropHint_Below)
            rect_y += dropItemRect.height;                    // bottom insert

        wxRect rect(dropItemRect.x, rect_y, dropItemRect.width, insertLineHeight);
        wxRendererNative::Get().DrawItemSelectionRect(this, dc, rect, wxCONTROL_SELECTED);
    }
#endif // wxUSE_DRAG_AND_DROP
*/
  }

  WxDataViewTreeNode? getTreeNodeByRow( int row ) 
  {
    if (isVirtualList()) {
      wxLogError( "No nodes in virtual list" );
      return null;
    }

    if ( row == -1 ) {
        return null;
    }

    if (_root == null) {
      wxLogError( "no root" );
      return null;
    }

    final job = WxDataViewRowToTreeNodeJob( row );
    wxDataViewTreeNodeWalker( _root!, job );
    return job.getResult();
  }

  WxDataViewItem getItemByRow( int row )
  {
    if (isVirtualList())
    {
        if ((row < getRowCount()) && (row >= 0)) {
            return WxDataViewItem( index: row );
        }
    }
    else
    {
        final node = getTreeNodeByRow(row);
        if ( node != null ) {
            return node.getItem();
        }
    }

    return WxDataViewItem();
  }

  bool isItemSingleValued( WxDataViewItem item)
  {
        if (getModel() == null) return false;
        final model = getModel()!;
        bool hadColumnWithValue = false;
        final cols = getOwner().getColumnCount();
        for (  int i = 0; i < cols; i++ )
        {
            if ( model.hasValue(item, i) )
            {
                if ( hadColumnWithValue ) {
                  return false;
                } 
                hadColumnWithValue = true;
            }
        }
        return true;
  }

  WxDataViewColumn? findFirstColumnWithValue( WxDataViewItem item) 
  {
        if (getModel() == null) return null;
        final model = getModel()!;
        final cols = getOwner().getColumnCount();
        for (  int i = 0; i < cols; i++ )
        {
            if ( model.hasValue(item, i) ) {
                return getOwner().getColumnAt(i);
            }
        }
        return null;
  }

  bool isEmpty() {
    return getRowCount() == 0;
  }

  WxRect getLinesRect(  int rowFrom,  int rowTo )
  {
    if (rowFrom > rowTo) {
      final row = rowFrom;
      rowFrom = rowTo;
      rowTo = row;
    }
    final rect = WxRect.zero();
    rect.x = 0;
    rect.y = getLineStart(rowFrom);
    // Don't calculate exact width of the row, because GetEndOfLastCol() is
    // expensive to call, and controls with rows not spanning entire width rare.
    // It is more efficient to e.g. repaint empty parts of the window needlessly.
    rect.width = 100000;
    if (rowFrom == rowTo) {
        rect.height = getLineHeight(rowFrom);
    } else {
        rect.height = getLineStart(rowTo) - rect.y + getLineHeight(rowTo);
    }
    return rect;
  }

  void queryAndCacheLineHeight( int row, WxDataViewItem item )
  {
    if (getModel() == null) return;
    if (_rowHeightCache == null) return;
    final model = getModel()!;

    int height = _lineHeight;
    final cols = getOwner().getColumnCount();
    for (int col = 0; col < cols; col++)
    {
        final column = getOwner().getColumn(col);
        if (column == null) continue;         // skip it!
        if (column.isHidden()) continue;      // skip it!
        if ( !model.hasValue(item, col) ) { 
          continue;      // skip it!
        }
        final renderer = column.getRenderer();
        if ( renderer.prepareForItem(model, item) ) {
            height = max(height, renderer._getSize().y);
            if (wxTheApp.isTouch()) {
              height = max( 45, height);  // kMinInteractiveDimension = 45
            }
        }
    }
    // ... and store the height in the cache
    _rowHeightCache!.put(row, height);
  }

  int getLineStart( int row )
  {
    if ((!getOwner().hasFlag(wxDV_VARIABLE_LINE_HEIGHT)) || (_rowHeightCache==null)) {
      return row * _lineHeight;
    }

    if (row < 0) {
      // wxLogError( "row cannot be < 0" );
      return 0;
    }

    _rebuildRowHeightCache();

    if (_rowHeightCache!.hasLineStart(row)) {
      // print( "cached: getLineStart from row $row is ${_rowHeightCache!.getLineStart(row)}" );
      return _rowHeightCache!.getLineStart(row);
    }

    for (int r = 0; r < row; r++)
    {
        if ( !_rowHeightCache!.hasLineHeight(r) )
        {
            // row height not in cache -> get it from the renderer...
            final item = getItemByRow(r);
            if (!item.isOk()) break;

            queryAndCacheLineHeight(r, item);
        }
    }

    if (!_rowHeightCache!.hasLineStart(row)) {
      wxLogError( "Row: $row is beyond last line in getLineStart()" );
      // _rowHeightCache!.printList();
      return -1;
    } 


    if (_rowHeightCache!.hasLineStart(row)) {
      // print( "new: getLineStart from row $row is ${_rowHeightCache!.getLineStart(row)}" );
      return _rowHeightCache!.getLineStart(row);
    }

    return 0;
  }

  int getLineHeight( int row )
  {
    if ((!getOwner().hasFlag(wxDV_VARIABLE_LINE_HEIGHT)) || (_rowHeightCache==null)) {
      return _lineHeight;
    }

    if (row < 0) {
      // negative might come from mouse leave and mouse drag events
      row = 0;
    }

    _rebuildRowHeightCache();

    if (_rowHeightCache!.hasLineHeight(row)) {
      return _rowHeightCache!.getLineHeight(row);
    }

    for (int r = 0; r <= row; r++)
    {
        if ( !_rowHeightCache!.hasLineHeight(r) )
        {
            // row height not in cache -> get it from the renderer...
            final item = getItemByRow(r);
            if (!item.isOk()) break;

            queryAndCacheLineHeight(r, item);
        }
    }

    if (!_rowHeightCache!.hasLineHeight(row)) {
      wxLogError( "Row: $row is beyond last line in getLineHeight" );
      return _lineHeight;
    } 

    return _rowHeightCache!.getLineHeight( row );
  }
  
  int getLineAt( int y )
  {
    if (y < 0) {
      // negative might come from mouse leave and mouse drag events
      return 0;
    }

    if ((!getOwner().hasFlag(wxDV_VARIABLE_LINE_HEIGHT)) || (_rowHeightCache==null)) {
      return y ~/ _lineHeight;
    }

    _rebuildRowHeightCache();

    return _rowHeightCache!.getLineAt( y );
  }

  void setRowHeight( int lineHeight ) { 
    _lineHeight = lineHeight;
  }

  int getRowHeight() { 
    return _lineHeight;
  }

  WxDataViewSortOrder getSortOrder()
  {
     final col = getOwner().getSortingColumn();
        if ( col != null)
        {
            return WxDataViewSortOrder( column: col.getModelColumn(),
                                        ascending: col.isSortOrderAscending() );
        }
        else
        {
          final model = getModel();
          if (model != null) {
            if (model.hasDefaultCompare()) {
                return WxDataViewSortOrder( column: wxDataViewSortColumnDefault );
            } else {
                return WxDataViewSortOrder();
            }
          }
        }
      return WxDataViewSortOrder();
    }

  WxDataViewCtrl getOwner() { 
    return _owner;
  }

  WxDataViewModel? getModel() { 
    return getOwner().getModel();
  }

  void onIdle( WxIdleEvent event )
  {
      if (_dirty)
      {
        _rebuildRowHeightCache();
        _recalculateDisplay();
        _dirty = false;
      }
      event.skip();
  }

  void _updateDisplay() {
    _dirty = true;
  }

  void _recalculateDisplay()
  {
    if (getModel() == null) {
      refresh();
      return;
    }
    final width = getEndOfLastCol();
    _virtualHeight = getLineStart( getRowCount() );

    setVirtualSize( WxSize( width, _virtualHeight ) );
    getOwner().setScrollRate( fromDIP(10), _lineHeight );
    updateColumnSizes();

    refresh();
    if (_owner._headerArea != null) {
      _owner._headerArea!.refresh();
    }
  }

  void _updateRowHeightCache() {
    _dirtyRowHeightCache = true;
  }

  void _rebuildRowHeightCache()
  {
    if (_rowHeightCache == null) {
      // only rebuild existing cache
      return;
    }
    if (!_dirtyRowHeightCache) {
      // only when dirty
      return;
    }
    _dirtyRowHeightCache = false;
    _rowHeightCache = WxHeightCache();
    if (getModel() == null) return;
    final model = getModel()!;

    for (int row = 0; row < getRowCount(); row++)
    {
      int height = _lineHeight;
      final item = getItemByRow(row);
      final cols = getOwner().getColumnCount();
      for (int col = 0; col < cols; col++)
      {
          final column = getOwner().getColumn(col);
          if (column == null) continue;     // should not happen
          if (column.isHidden()) continue;  // skip it!
          if ( !model.hasValue(item, col) ) continue;  // skip it!
          final renderer = column.getRenderer();
          if ( renderer.prepareForItem( model, item ) ) {
            height = max( height, renderer._getSize().y );
          }
      }

      // ... and store the height in the cache
      _rowHeightCache!.add(height);
    }
  }

WxDataViewItem getTopItem() 
{
    final item = getFirstVisibleRow();
    WxDataViewTreeNode ?node;
    WxDataViewItem dataitem;

    if ( !isVirtualList() )
    {
        node = getTreeNodeByRow(item);
        if( node == null ) return WxDataViewItem();  // null?

        dataitem = node.getItem();
    }
    else
    {
        dataitem = WxDataViewItem( index: item ); // was -1
    }

    return dataitem;
}

  int getEndOfLastCol() 
  {
      int width = 0;
      for (int i = 0; i < getOwner().getColumnCount(); i++)
      {
          final col = getOwner().getColumnAt( i );
          if (col == null) continue; // should never happen
          if (col.isHidden()) continue; 
          width += col.getWidth();
      }
      return width;
  }

int getFirstVisibleRow() 
{
    final res = _owner.calcUnscrolledPosition( WxPoint.zero );
    return getLineAt( res.y );
}

int getLastVisibleRow()
{
    final clientSize = getClientSize();
    // Find row occupying the bottom line of the client area (dimY-1).
    final res = _owner.calcUnscrolledPosition( WxPoint( clientSize.x, clientSize.y-1 ) );
    final row = getLineAt(res.y);
    return min( getRowCount()-1, row );
}

int getLastFullyVisibleRow()
{
    final row = getLastVisibleRow();

    int bottom = getLineStart(row) + getLineHeight(row);
    final res = _owner.calcScrolledPosition( WxPoint(-1, bottom));

    if ( res.y > getClientSize().y ) {
        return max(0, row - 1);
    } else {
        return row;
    }
}

int getColumnStart(int column) 
{
    if (column < 0) return 0;
    int sx = -1;

    final rect = getClientRect();
    int colnum = 0;
    int xStart, w = 0;
    final xx = _owner.calcUnscrolledPosition(rect.getPosition() ).x;
    for (xStart = 0; colnum < column; colnum++)
    {
        final col = getOwner().getColumnAt(colnum);
        if (col == null) continue;
        if (col.isHidden()) continue;   
        w = col.getWidth();
        xStart += w;
    }

    int xEnd = xStart + w;
    int xe = xx + rect.width;
    if (xEnd > xe)
    {
        sx = (xx + xEnd - xe);
    }
    if (xStart < xx)
    {
        sx = xStart;
    }
    return sx;
}

  int getRowByItem( WxDataViewItem item, { WxDataViewWalkFlags flags =  WxDataViewWalkFlags.walkAll } )
  {
    if( getModel() == null ) {
        return -1;
    }
    final model = getModel()!;

    if (isVirtualList())
    {
        return item.getIndex();
    }
    else
    {
        if( !item.isOk() ) {
            return -1;
        }

        // Compose the parent-chain of the item we are looking for
        List<WxDataViewItem> parentChain = [];
        WxDataViewItem it = WxDataViewItem.fromItem( item );
        while( it.isOk() )
        {
            parentChain.add(it);
            it = model.getParent(it);
        }

        // add an 'invalid' item to represent our 'invisible' root node
        parentChain.add(WxDataViewItem());

        // the parent chain was created by adding the deepest parent first.
        // so if we want to start at the root node, we have to iterate backwards through the vector
        final job = WxDataViewItemToRowJob( item, parentChain );
        if ( !wxDataViewTreeNodeWalker( _root!, job, flags: flags ) ) {
            return -1;
        }

        return job.getResult();
    }
  }

  void _invalidateCount() {
    _count = -1;
  }

  int getRowCount()
  {
    if (getModel() == null) {
      return 0;
    }

    if ( _count == -1 )
    {
        _updateCount( _recalculateCount() );
        _updateDisplay();
    }
    return _count;
  }

  WxRect getItemRect( WxDataViewItem item, WxDataViewColumn? column )
  {
    int xpos = 0;
    int width = 0;

    final cols = getOwner().getColumnCount();
    // If column is null the loop will compute the combined width of all columns.
    // Otherwise, it will compute the x position of the column we are looking for.
    for (int i = 0; i < cols; i++)
    {
        final col = getOwner().getColumnAt( i );
        if (col == null) continue;
        if (col == column) break;
        if (col.isHidden()) continue;      // skip it!
        xpos += col.getWidth();
        width += col.getWidth();
    }

    if (column != null)
    {
        // If we have a column, we need can get its width directly.
        if(column.isHidden()) {
            width = 0;
        } else {
            width = column.getWidth();
        }
    }
    else
    {
        // If we have no column, we reset the x position back to zero.
        xpos = 0;
    }

    final row = getRowByItem(item, flags: WxDataViewWalkFlags.walkExpandedOnly );  // TODO
    if ( row == -1 )
    {
        // This means the row is currently not visible at all.
        return WxRect.zero();
    }

    // we have to take an expander column into account and compute its indentation
    // to get the correct x position where the actual text is
    int indent = 0;
    if (!isList() &&
            (column == null || getExpanderColumnOrFirstOne(getOwner()) == column) )
    {
        final node = getTreeNodeByRow(row);
        if (node != null) {
          indent = getOwner().getIndent() * node.getIndentLevel();
          indent += _getExpanderSize().getWidth();
        }
    }

    WxRect itemRect = WxRect( xpos + indent,
                     getLineStart( row ),
                     width - indent,
                     getLineHeight( row ) );

    final newPos = getOwner().calcScrolledPosition( itemRect.getPosition() );
    itemRect = WxRect.fromPositionAndSize( newPos, itemRect.getSize() );

    // Check if the rectangle is completely outside of the currently visible
    // area and, if so, return an empty rectangle to indicate that the item is
    // not visible.
    if ( (itemRect.getBottom() < 0) || (itemRect.getTop() > getClientSize().y)) {
        return WxRect.zero();
    }

    return itemRect;
  }

  void _updateCount(int count)
  {
    _count = count;
    _selection.setItemCount(count);
  }

  int _recalculateCount()
  {
    if (isVirtualList())
    {
      if (getModel() is! WxDataViewVirtualListModel) return 0;
      final listModel = getModel() as WxDataViewVirtualListModel;
      return listModel.getCount();
    }
    else
    {
        if (_root == null) {
          wxLogError( "no root found" );
          return 0;
        }
        return _root!.getSubTreeCount();
    }
  }

  bool isVirtualList() {
    return _root == null;
  }
  bool isList()
  { 
    if (getModel() == null) return false;
    final model = getModel()!;
    return model.isListModel();
  }

  int getCountPerPage( )
  {
    final size = getClientSize();
    return (size.y / _lineHeight).floor();
  }

  void scrollTo( int rows, int column )
  {
      _underMouse = null;
      _underMouseItem = null;

      final x = _owner.getScrollPixelsPerUnitX();
      final y = _owner.getScrollPixelsPerUnitY();

      // Take care to not divide by 0 if we're somehow called before scrolling
      // parameters are initialized.
      final sy = (y!=0) 
        ? (getLineStart( rows )/y).floor()
        : -1;
      int sx = -1;
      if( column != -1 && (x!=0) ) {
          sx = (getColumnStart(column) / x).floor();
      }
      _owner.scroll( sx, sy );
  }

  void _destroyTree()
  {
    if (!isVirtualList())
    {
        _root = null;
        _count = 0;
    }
  }

  void _buildTreeHelper( WxDataViewModel model, WxDataViewItem item, WxDataViewTreeNode node )
  {
    if (!model.isContainer( item )) {
      return;
    }

    final children = model.getChildren( item );

    int index = 0;
    for (final child in children)
    {
        WxDataViewTreeNode childNode = WxDataViewTreeNode(node, child);

        if (model.isContainer(child)) {
            childNode.setHasChildren( true );
        }

        node.insertChild( this, childNode, index );
        index++;
    }

    if (node.isOpen()) {
        node.changeSubTreeCount( children.length );
    }
  }

  void _buildTree()
  {
    _destroyTree();

    if( getModel() == null ) {
        return;
    }
    final model = getModel()!;

    if (model.isVirtualListModel())
    {
        _invalidateCount();
        return;
    }

    _root = WxDataViewTreeNode.createRootNode();

    // First we define a invalid item to fetch the top-level elements
    _buildTreeHelper( model, WxDataViewItem(), _root! );

    _invalidateCount();
  }

  void collapse( int row )
  {
    if (isList()) return;

    final node = getTreeNodeByRow(row);
    if (node == null) return;

    if (!node.hasChildren()) return;

    if (node.isOpen())
    {
        if ( !_sendExpanderEvent( wxGetDataViewItemCollapsingEventType(), node.getItem()) )
        {
            // Vetoed by the event handler.
            return;
        }

        if (_rowHeightCache != null) {
            _rowHeightCache!.clear();
        }

        final countDeletedRows = node.getSubTreeCount();

        if ( _selection.onItemsDeleted(row + 1, countDeletedRows) )
        {
            sendSelectionChangedEvent( getItemByRow(row) );

            // The event handler for wxEVT_DATAVIEW_SELECTION_CHANGED could
            // have called Collapse() itself, in which case the node would be
            // already closed and we shouldn't try to close it again.
            if (!node.isOpen()) return;
        }

        node.toggleOpen(this);

        // Adjust the current row if necessary.
        if ( hasCurrentRow() && (_currentRow > row) )
        {
            // If the current row was among the collapsed items, make the
            // parent itself current.
            if ( _currentRow <= row + countDeletedRows ) {
                changeCurrentRow(row);
            }
            else
            {
              // Otherwise just update the index.
                changeCurrentRow( _currentRow - countDeletedRows);
            }
        }

        if ( _count != -1 ) {
          _count -= countDeletedRows;
        }

        if (_rowHeightCache != null) {
            // _rebuildRowHeightCache();   do this in OnIdle
        }

        getOwner()._invalidateColBestWidths();

        _updateDisplay();

        _sendExpanderEvent( wxGetDataViewItemCollapsedEventType(), node.getItem());
        _chevronAnimationItem = node.getItem();
        _chevronAnimationFactor = 0;
        // _chevronAnimationTimer.start( milliseconds: 15 );
        _chevronAnimation.start();
    }
  }

  bool _sendExpanderEvent( int type, WxDataViewItem item )
  {
    final event = WxDataViewEvent(type, _owner, null, item);
    _owner.processEvent( event );
    return event.isAllowed();
  }

  void _expand( WxDataViewTreeNode node, int row, bool expandChildren)
  {
    if (!node.hasChildren()) return;

    if( getModel() == null ) {
        return;
    }
    final model = getModel()!;

    if (!node.isOpen())
    {
        if ( !_sendExpanderEvent( wxGetDataViewItemExpandingEventType(), node.getItem()) )
        {
            // Vetoed by the event handler.
            return;
        }

        if (_rowHeightCache != null) {
            _rowHeightCache!.clear();
        }

        node.toggleOpen(this);

        // build the children of current node
        if( node.getChildNodes().isEmpty )
        {
            _buildTreeHelper( model, node.getItem(), node );
        }

        final countNewRows = node.getSubTreeCount();

        // Shift all stored indices after this row by the number of newly added
        // rows.
        _selection.onItemsInserted(row + 1, countNewRows);
        if ( hasCurrentRow() && (_currentRow > row) ) {
            changeCurrentRow( _currentRow + countNewRows);
        }

        if ( _count != -1 ) {
            _count += countNewRows;
        }

        if (_rowHeightCache != null) {
            // _rebuildRowHeightCache(); do this in onIdle()
        }

        // Expanding this item means the previously cached column widths could
        // have become invalid as new items are now visible.
        getOwner()._invalidateColBestWidths();

        _updateDisplay();

        // Send the expanded event
        _sendExpanderEvent( wxGetDataViewItemExpandedEventType(), node.getItem() );
        _chevronAnimationItem = node.getItem();
        _chevronAnimationFactor = 0;
        // _chevronAnimationTimer.start( milliseconds: 15 );
        _chevronAnimation.start();
    }

    // Note that we have to expand the children when expanding recursively even
    // when this node itself was already open.
    if ( expandChildren )
    {
        for ( final child in node.getChildNodes() )
        {
            // Row currently corresponds to the previous item, so increment it
            // first to correspond to this child.
            _expand(child, ++row, true);

            // We don't need +1 here because we'll increment the row during the
            // next loop iteration.
            row += child.getSubTreeCount();
        }
    }
}

  void expand( int row, { bool expandChildren=false} )
  {
    if (isList()) return;

    final node = getTreeNodeByRow(row);
    if (node == null) return;

    _expand(node, row, expandChildren);
  }

  bool isExpanded( int row )
  {
    if (isList()) return false;

    final node = getTreeNodeByRow(row);
    if (node == null) return false;

    if (!node.hasChildren()) return false;

    return node.isOpen();
  }

  bool hasChildren( int row )
  {
    if (isList()) return false;

    final node = getTreeNodeByRow(row);
    if (node == null) return false;

    return node.hasChildren();
  }

  void clearCurrentColumn() {
    _currentCol = null;
  }
  WxDataViewColumn? getCurrentColumn() {
    return _currentCol;
  }

  WxSelectionStore getSelections() {
    return _selection;
  }

  void clearSelection() {
    _selection.clear();
    refresh();
  }

  void reverseRowSelection(  int row )
  {
    _selection.selectItem(row, select: !_selection.isSelected(row));
    refreshRow( row );
  }

  void select( List<int> selections ) {
    for (final sel in selections) {
      _selection.selectItem(sel);
    }
    refresh();
  }

  void selectAllRows() {
    _selection.selectRange(0, getRowCount()-1 );
    refresh();
  }

  void changeCurrentRow( int row ) {
    _currentRow = row;
  }

  int getCurrentRow() {
    return _currentRow;
  }

  bool hasCurrentRow() {
    return _currentRow != -1;
  }

  bool isSingleSel() {
    if (getParent() == null) return true;
    return !getParent()!.hasFlag(wxDV_MULTIPLE);
  }

  void selectRow( int row, bool on )
  {
    if ( _selection.selectItem( row, select: on ) ) {
        refreshRow(row);
    }
  }

  void selectRows( int from,  int to )
  {
      if (_selection.selectRange(from, to )) {
        refresh();
      }
  }

bool unselectAllRows( { int except=-1 } )
  {
    if (!_selection.isEmpty())
    {
        if (except != -1)
        {
            final wasSelected = _selection.isSelected(except);
            clearSelection();
            if (wasSelected)
            {
                _selection.selectItem(except);
                refresh();
                // The special item is still selected.
                return false;
            }
        }
        else
        {
            clearSelection();
        }
    }
    refresh();
    // There are no selected items left.
    return true;
  }

  bool isRowSelected( int row ) {
    return _selection.isSelected( row );
  }

  void refreshRow( int row ) {
    refresh();
  }

void onColumnsCountChanged()
{
    int editableCount = 0;
    final cols = getOwner().getColumnCount();
    for ( int i = 0; i < cols; i++ )
    {
        final col = getOwner().getColumnAt(i);
        if (col == null) continue;
        if (col.isHidden()) continue;
        if ( col.getRenderer().getMode() != wxDATAVIEW_CELL_INERT ) {
            editableCount++;
        }
    }
    _useCellFocus = (editableCount > 0);
    _updateDisplay();
}

void updateColumnSizes()
{
    final colsCount = getOwner().getColumnCount();
    if (colsCount == 0) return;

    final owner = getOwner();

    final fullWinWidth = getClientSize().x;

    // Find the last shown column: we shouldn't bother to resize the columns
    // that are hidden anyhow.
    int lastColIndex = -1;
    WxDataViewColumn? lastCol;
    for ( int colIndex = colsCount - 1; colIndex >= 0; --colIndex )
    {
        lastCol = owner.getColumnAt(colIndex);
        if (lastCol == null) continue;
        if (!lastCol.isHidden())
        {
            lastColIndex = colIndex;
            break;
        }
    }

    if ( lastColIndex == -1 )
    {
        // All columns are hidden.
        return;
    }

    int lastColX = 0;
    for ( int colIndex = 0; colIndex < lastColIndex; ++colIndex )
    {
        final col = owner.getColumnAt(colIndex);
        if (col == null) continue;
        if ( !col.isHidden() ) {
            lastColX += col.getWidth();
        }
    }

    int colswidth = lastColX + lastCol!.getWidth();
    if ((lastColX < fullWinWidth ) && (owner.hasFlag(wxDV_NO_HEADER)))
    {
        final availableWidth = fullWinWidth - lastColX;

        // Never make the column automatically smaller than the last width it
        // was explicitly given nor its minimum width (however we do need to
        // reduce it until this size if it's currently wider, so this
        // comparison needs to be strict).
        if ( availableWidth < max(lastCol.getMinWidth(),
                                  lastCol._getSpecifiedWidth()) )
        {
            return;
        }

        lastCol._updateWidthInternal(availableWidth);

        // All columns fit on screen, so we don't need horizontal scrolling.
        // To prevent flickering scrollbar when resizing the window to be
        // narrower, force-set the virtual width to 0 here. It will eventually
        // be corrected at idle time.
        setVirtualSize( WxSize( 0, _virtualHeight) );

        // refreshRect( WxRect(lastColX, 0, availableWidth, getSize().y) );
    }
    else
    {
        // else: don't bother, the columns won't fit anyway
        setVirtualSize( WxSize( colswidth, _virtualHeight ));
    }
  }

  // called from notifier
  bool _cleared()
  { 
    _destroyTree();
    _selection.clear();
    _currentRow = -1;

    _clearRowHeightCache();

    if (getModel() != null) {
        _buildTree();
    } else {
      _count = 0;
    }
    getOwner()._invalidateColBestWidths();
    _updateDisplay();
    return true;
  }

  void _resort()
  { 
    _updateRowHeightCache();
    if (_root != null) {   //   (!isVirtualList()) {
      _root!.resort(this);
    }
    _updateDisplay();
  }

  void _clearRowHeightCache()
  {
    if (_rowHeightCache != null) {
      _rowHeightCache!.clear();
    }
  }

  bool _itemAdded( WxDataViewItem parent, WxDataViewItem item )
  {
    if (isVirtualList())
    {
      final listModel = getModel() as WxDataViewVirtualListModel;
      _count = listModel.getCount();
    } 
    else
    {
        if (getModel() == null) return false;
        final model = getModel()!;

        // specific position (row) is unclear, so clear whole height cache
        _updateRowHeightCache();

        final findResult = findNode(parent);
        final parentNode = findResult._node;

        // If one of parents is not realized yet (has children but was never
        // expanded). Return as nodes will be initialized in Expand().
        if ( !findResult._subtreeRealized ) return true;

        // The parent node was not found.
        if ( parentNode == null) return false;

        // If the parent has not children then just mask it as container and return.
        // Nodes will be initialized in Expand().
        if ( !parentNode.hasChildren() )
        {
            parentNode.setHasChildren(true);
            return true;
        }

        // If the parent has children but child nodes was not initialized and
        // the node is collapsed then just return as nodes will be initialized in
        // Expand().
        if ( !parentNode.isOpen() && parentNode.getChildNodes().isEmpty ) {
            return true;
        }

        parentNode.setHasChildren(true);

        final itemNode = WxDataViewTreeNode(parentNode, item);
        itemNode.setHasChildren(model.isContainer(item));

        if ( getSortOrder().isNone() )
        {
            // There's no sorting, so we need to select an insertion position

            final modelSiblings = model.getChildren(parent);
            final modelSiblingsSize = modelSiblings.length;

            final posInModel = modelSiblings.indexOf(item); // C++ code searched from behind
            if (posInModel == -1) {
              wxLogError( "item not in model" );
              return false;
            }

            final nodeSiblings = parentNode.getChildNodes();
            final nodeSiblingsSize = nodeSiblings.length;

            int nodePos = 0;

            if ( posInModel == modelSiblingsSize - 1 )
            {
                nodePos = nodeSiblingsSize;
            }
            else if ( modelSiblingsSize == nodeSiblingsSize + 1 )
            {
                // This is the simple case when our node tree already matches the
                // model and only this one item is missing.
                nodePos = posInModel;
            }
            else
            {
                // It's possible that a larger discrepancy between the model and
                // our realization exists. This can happen e.g. when adding a bunch
                // of items to the model and then calling ItemsAdded() just once
                // afterwards. In this case, we must find the right position by
                // looking at sibling items.

                // append to the end if we won't find a better position:
                nodePos = nodeSiblingsSize;

                for ( int nextItemPos = posInModel + 1;
                     nextItemPos < modelSiblingsSize;
                     nextItemPos++ )
                {
                    int nextNodePos = parentNode.findChildByItem(modelSiblings[nextItemPos]);
                    if ( nextNodePos != wxNOT_FOUND )
                    {
                        nodePos = nextNodePos;
                        break;
                    }
                }
            }
            parentNode.changeSubTreeCount(1);
            parentNode.insertChild(this, itemNode, nodePos);
        }
        else
        {
            // Node list is or will be sorted, so InsertChild do not need insertion position
            parentNode.changeSubTreeCount(1);
            parentNode.insertChild(this, itemNode, 0);
        }

        _invalidateCount();
    }
    _selection.onItemsInserted(getRowByItem(item), 1);
    getOwner()._invalidateColBestWidths();
    _updateDisplay();
    return true;
  }

  bool _itemDeleted( WxDataViewItem parent, WxDataViewItem item )
  {
    // TODO clear _undermouse and _undermouseItem

    if (isVirtualList())
    {
      final listModel = getModel() as WxDataViewVirtualListModel;
      _count = listModel.getCount();

      _selection.onItemDelete(getRowByItem(item));
    }
    else 
    {
        if (getModel() == null) return false;
        final model = getModel()!;

        final findResult = findNode(parent);
        final parentNode = findResult._node;

        // One of parents of the parent node has children but was never
        // expanded, so the tree was not built and we have nothing to delete.
        if ( !findResult._subtreeRealized ) return true;

        // Notice that it is possible that the item being deleted is not in the
        // tree at all, for example we could be deleting a never shown (because
        // collapsed) item in a tree model. So it's not an error if we don't know
        // about this item, just return without doing anything then.
        if ( parentNode == null ) return true;

        if (!parentNode.hasChildren()) {
          wxLogError( "parent node has no children" );
          return false;
        }

        if (parentNode.getChildNodes().isEmpty) {
          // print( "parent node was not expanded, just leave" );

            // If this was the last child to be removed, it's possible the parent
            // node became a leaf. Let's ask the model about it.
          parentNode.setHasChildren(model.isContainer(parent));

          return true;
        }

        final parentsChildren = parentNode.getChildNodes();

        // We can't use FindNode() to find 'item', because it was already
        // removed from the model by the time ItemDeleted() is called, so we
        // have to do it manually. We keep track of its position as well for
        // later use.
        
        WxDataViewTreeNode itemNode = parentsChildren.firstWhere( (node) => node._item == item );
        int itemPosInNode = parentsChildren.indexOf( itemNode );
        // print( "pos of deleted item was: $itemPosInNode" ); 


        if (_rowHeightCache != null)
        {
          if (itemNode.hasChildren()) {
            // we might be deleting a whole branch, so clear whole height cache
            _updateRowHeightCache();
          } else {
            // print( "just delete a leaf" );

            _rowHeightCache!.remove( getRowByItem(parent) + itemPosInNode);
          }
        }

        /*
        for ( wxDataViewTreeNodes::const_iterator i = parentsChildren.begin();
              i != parentsChildren.end();
              ++i, ++itemPosInNode )
        {
            if( (*i)->GetItem() == item )
            {
                itemNode = *i;
                break;
            }
        }

        // If the parent wasn't expanded, it's possible that we didn't have a
        // node corresponding to 'item' and so there's nothing left to do.
        if ( !itemNode )
        {
            // If this was the last child to be removed, it's possible the parent
            // node became a leaf. Let's ask the model about it.
            if ( parentNode->GetChildNodes().empty() )
                parentNode->SetHasChildren(GetModel()->IsContainer(parent));

            return true;
        }

        if ( m_rowHeightCache )
            m_rowHeightCache->Remove(GetRowByItem(parent) + itemPosInNode);
        */

        // Delete the item from wxDataViewTreeNode representation:
        final itemsDeleted = 1 + itemNode.getSubTreeCount();

        parentNode.removeChild(itemPosInNode);
        parentNode.changeSubTreeCount(-itemsDeleted);

        // Make the row number invalid and get a new valid one when user call GetRowCount
        _invalidateCount();

        // If this was the last child to be removed, it's possible the parent
        // node became a leaf. Let's ask the model about it.
        if ( parentNode.getChildNodes().isEmpty )
        {
            bool isContainer = model.isContainer(parent);
            parentNode.setHasChildren(isContainer);
            if ( isContainer )
            {
                // If it's still a container, make sure we show "+" icon for it
                // and not "-" one as there is nothing to collapse any more.
                if ( parentNode.isOpen() ) {
                    parentNode.toggleOpen(this);
                }
            }
        }

        // Update selection by removing 'item' and its entire children tree from the selection.
        if ( !_selection.isEmpty() )
        {
            // we can't call GetRowByItem() on 'item', as it's already deleted, so compute it from
            // the parent ('parentNode') and position in its list of children
            int itemRow;
            if ( itemPosInNode == 0 )
            {
                // 1st child, row number is that of the parent parentNode + 1
                itemRow = getRowByItem(parentNode.getItem()) + 1;
            }
            else
            {
                // row number is that of the sibling above 'item' + its subtree if any + 1
                final siblingNode = parentNode.getChildNodes()[itemPosInNode - 1];

                itemRow = getRowByItem(siblingNode.getItem()) +
                          siblingNode.getSubTreeCount() +
                          1;
            }

            _selection.onItemsDeleted(itemRow, itemsDeleted);
        }
    }

    // Change the current row to the last row if the current exceed the max row number
    if ( hasCurrentRow() && (_currentRow >= getRowCount())) {
      changeCurrentRow(_count - 1);
    }

    getOwner()._invalidateColBestWidths();
    _updateDisplay();

    return true;
  }

  bool _itemChanged( WxDataViewItem item )
  {
    return doItemChanged(item, wxNOT_FOUND);
  }

  bool _valueChanged( WxDataViewItem item, int modelColumn )
  {
    int viewColumn = _owner.getModelColumnIndex(modelColumn);
    if ( viewColumn == wxNOT_FOUND ) return false;
    return doItemChanged(item, viewColumn);
  }

  bool doItemChanged( WxDataViewItem item, int viewColumn )
  {
    if ( !isVirtualList() )
    {
        if ( _rowHeightCache != null) {
            _rowHeightCache!.remove(getRowByItem(item));
        }

        // Move this node to its new correct place after it was updated.
        //
        // In principle, we could skip the call to PutInSortOrder() if the modified
        // column is not the sort column, but in real-world applications it's fully
        // possible and likely that custom compare uses not only the selected model
        // column but also falls back to other values for comparison. To ensure
        // consistency it is better to treat a value change as if it was an item
        // change.

        /* TODO
        const FindNodeResult findResult = FindNode(item);
        wxDataViewTreeNode* const node = findResult.m_node;
        if ( !findResult.m_subtreeRealized )
            return true;
        wxCHECK_MSG( node, false, "invalid item" );
        node->PutInSortOrder(this);
        */
    }

    WxDataViewColumn? column;
    if ( viewColumn == wxNOT_FOUND )
    {
        column = null;
        getOwner()._invalidateColBestWidths();
    }
    else
    {
        column = _owner.getColumn(viewColumn);
        getOwner()._invalidateColBestWidth(viewColumn);
    }

    // Update the displayed value(s).
    refreshRow(getRowByItem(item));

    // Send event
    final le = WxDataViewEvent( wxGetDataViewItemValueChangedEventType(), _owner, column, item);
    _owner.processEvent(le);

    return true;
  }
}

// ------------------------- wxDataViewCtrl ----------------------

const int wxDV_SINGLE = 0x0000;
const int wxDV_MULTIPLE = 0x0001;
const int wxDV_NO_HEADER = 0x0002;
const int wxDV_HORIZ_RULES = 0x0004;
const int wxDV_VERT_RULES = 0x0008;
const int wxDV_ROW_LINES = 0x0010;
const int wxDV_VARIABLE_LINE_HEIGHT = 0x0020;

const int wxDV_NO_TWISTER_BUTTONS = 0x0040;
const int wxDV_NATIVE_EXPANDER = 0x0080;
const int wxDV_PLUSMINUS_EXPANDER = 0x0100;

class WxDataViewCtrlCachedColWidthInfo {
  WxDataViewCtrlCachedColWidthInfo();
  int width = 0;
  bool dirty = true; 
}


/// A complex control that can display both tabular or tree like data.
/// 
/// A [WxDataViewCtrl] needs to be associated with a [WxDataViewModel] to understand
/// your data and you need to set up [WxDataViewColumn]s with different [WxDataViewRenderer]s 
/// to display the data and to possibly allow it to be editted.
/// 
/// A [WxDataViewModel] is connected via one or several [WxDataViewModelNotifier]s
/// to whatever needs to be notified. This can be the [WxDataViewCtrl] or some other
/// control or interface that displays (a part of) the data or sends it somewhere.
/// 
/// There are several concrete implementations of [WxDataViewCtrl] with a concrete
/// model that actually stores the data for simple cases of a tree and list structure:
/// 
/// * [WxDataViewTreeCtrl] uses a [WxDataViewTreeStore] internally.
/// * [WxDataViewListCtrl] uses a [WxDataViewListStore] internally.
/// * [WxDataViewChapterCtrl] uses a [WxDataViewBookStore] internally.
/// 
/// While the control was initially conceived to display and edit data 
/// on large screens, it has been adapted in wxDart to be used as the
/// main control in mobile devices by using more complex renderers such
/// [WxDataViewTileRenderer] rendering [WxDataViewTileData] items.
/// 
/// In contrast to almost all other controls in the wxDart core library, the
/// WxDataViewCtrl group and hierarchy of classes are not implemented separately
/// in wxDart Flutter and wxDart Native (using Flutter and C++). Instead, the 
/// entire class is written in generic wxDart and is used identically in both
/// wxDart Flutter and wxDart Native. This ensures 100% fidelity in behaviour
/// and performance and was necessary as there is no such control in Flutter.
/// 
/// [WxDataViewBook] uses [WxDataViewChapterCtrl] internally.
/// 
/// Window styles
/// 
/// | constant | value (meaning) |
/// | -------- | -------- |
/// | wxDV_SINGLE | default, single line or item selection | 
/// | wxDV_MULTIPLE | multiple line or item selection | 
/// | wxDV_NO_HEADER | Don't display a header above the columns | 
/// | wxDV_HORIZ_RULES | Show a horizontal ruler (thin line) between line | 
/// | wxDV_VERT_RULES | Show a horizontal ruler (thin line) between columns | 
/// | wxDV_ROW_LINES | Alternate line colour | 
/// | wxDV_VARIABLE_LINE_HEIGHT | Allow lines to have variable height. This can be an expensive option if there are thousands of lines. | 
/// | wxDV_NO_TWISTER_BUTTONS | Don't show any expander buttons which disables tree expansion by the user | 
/// | wxDV_NATIVE_EXPANDER | Use the native platform expander (e.g. plus/minus on Windows | 
/// | wxDV_PLUSMINUS_EXPANDER | Use plus/minus expander and not the default chevron triangle | 

class WxDataViewCtrl extends WxScrolledWindow {
  WxDataViewCtrl( super.parent, super.id, { super.pos = wxDefaultPosition, super.size = wxDefaultSize, super.style = 0 } ) {

    _clientArea = WxDataViewMainWindow(this );
    if (!hasFlag(wxDV_NO_HEADER)) {
      final headerSize = WxSize(200, wxGetRendererNative().getHeaderButtonHeight(this) );
      _headerArea = WxDataViewHeaderWindow(this,headerSize);
    }
    setTargetWindow(_clientArea);

    final sizer = WxBoxSizer( wxVERTICAL );
    if (_headerArea != null) {
      sizer.add( _headerArea!, flag: wxEXPAND );
    }
    sizer.add( _clientArea, proportion: 1, flag: wxEXPAND );
    setSizer(sizer);

    setScrollbars( 20, 20, 40, 80 );

    bindIdleEvent(onIdle);
  }

  @override
  void printName() {
    print( "WxDataViewCtrl");
  }

  int _indent = 8;
  final List <WxDataViewColumn> _cols = [];
  WxDataViewColumn? _expanderColumn;
  WxDataViewModel? _model;
  late WxDataViewModelNotifier _notifier;
  late WxDataViewMainWindow _clientArea;
  WxDataViewHeaderWindow? _headerArea;
  final List<WxDataViewCtrlCachedColWidthInfo> _colsBestWidths = [];
  bool _colsDirty = true;
  final WxColour _alternateRowColour = WxColour(200, 200, 255);
  final List<int> _sortingColumnIdxs = [];
  bool _allowMultiColumnSort = false;

  @override
  bool acceptsFocus() {
    return false;
  }

  WxColour getAlternateRowColour() { 
    return _alternateRowColour;
  }

  bool associateModel( WxDataViewModel? model )
  {
    if (_model != null) {
      _model!.removeNotifier( _notifier );
    } 
    _clientArea._destroyTree();
    _model = model;

    if (_model != null)
    {
      _notifier = WxFlutterDataViewModelNotifier( _model!, _clientArea );
      _model!.addNotifier( _notifier );

      _clientArea._buildTree(); 
    }

    _clientArea._updateDisplay();

    return true;
  }

  WxDataViewModel? getModel() {
    return _model;
  }

  WxDataViewItem getTopItem( ) {
    return _clientArea.getTopItem();
  }

  int getCountPerPage( ) {
    return _clientArea.getCountPerPage();
  }

  void setIndent( int indent ) {
    _indent = indent;
    _doSetIndent();
  }

  int getIndent( ) {
    return _indent;
  }

  void setRowHeight( int height ) {
    _clientArea.setRowHeight(height);
  }

  void collapse( WxDataViewItem item ) {
    final row = _clientArea.getRowByItem( item );
    if (row != -1) {
        _clientArea.collapse(row);
    }
  }

  void expand( WxDataViewItem item ) {
    expandAncestors(item);
    _doExpand(item, false);
  }

  void expandAncestors( WxDataViewItem item )
  {
    if (_model == null) return;
    if (!item.isOk()) return;

    List<WxDataViewItem> parentChain = [];

    // at first we get all the parents of the selected item
    WxDataViewItem parent = _model!.getParent(item);
    while (parent.isOk())
    {
        parentChain.add(parent);
        parent = _model!.getParent(parent);
    }

    // then we expand the parents, starting at the root
    while (parentChain.isNotEmpty)
    {
         _doExpand(parentChain.last, false);
         parentChain.removeLast();
    }
  }

  void expandChildren( WxDataViewItem item ) {
    expandAncestors(item);
    _doExpand(item, true);
  }

  bool isExpanded( WxDataViewItem item ) {
    final row = _clientArea.getRowByItem( item );
    if (row != -1) {
        return _clientArea.isExpanded(row);
    }
    return false;
  }

  bool appendColumn( WxDataViewColumn column ) {
    column.setOwner(this);
    _cols.add( column );
    _colsBestWidths.add( WxDataViewCtrlCachedColWidthInfo() );
    onColumnsCountChanged();
    return true;
  }

  bool prependColumn( WxDataViewColumn column ) {
    column.setOwner(this);
    _cols.insert( 0, column );
    _colsBestWidths.insert( 0, WxDataViewCtrlCachedColWidthInfo() );
    onColumnsCountChanged();
    return true;
  }

  bool insertColumn( int pos, WxDataViewColumn column ) {
    column.setOwner(this);
    _cols.insert( pos, column );
    _colsBestWidths.insert( 0, WxDataViewCtrlCachedColWidthInfo() );
    onColumnsCountChanged();
    return true;
  }

  void setExpanderColumn( WxDataViewColumn? col ) { 
    _expanderColumn = col ; 
    _doSetExpanderColumn(); 
  }

  WxDataViewColumn? getExpanderColumn() { 
    return _expanderColumn; 
  }

  bool clearColumns( ) {
    setExpanderColumn(null);
    _cols.clear();
    _sortingColumnIdxs.clear();
    _colsBestWidths.clear();
    _clientArea.clearCurrentColumn();
    onColumnsCountChanged();
    return true;
  }

  bool deleteColumn( WxDataViewColumn column ) {
    final idx = getColumnIndex(column);
    if ( idx == wxNOT_FOUND ) return false;
    _colsBestWidths.removeAt(idx);
    _cols.removeAt(idx);
    if ( _clientArea.getCurrentColumn() == column ) {
        _clientArea.clearCurrentColumn();
    }
    onColumnsCountChanged();
    return true;
  }

  void ensureVisibleRowCol( int row, int column )
  {
    if( row < 0 ) {
        row = 0;
    }
    if( row > _clientArea.getRowCount() ) {
        row = _clientArea.getRowCount();
    }

    final first = _clientArea.getFirstVisibleRow();
    final last = _clientArea.getLastFullyVisibleRow();
    if( row <= first )
    {
        _clientArea.scrollTo( row, column );
    }
    else if( row > last )
    {
        if ( !hasFlag(wxDV_VARIABLE_LINE_HEIGHT) )
        {
            // Simple case as we can directly find the item to scroll to.
            _clientArea.scrollTo(row - last + first, column);
        }
        else
        {
            // calculate scroll position based on last visible item
            final itemStart = _clientArea.getLineStart(row);
            final itemHeight = _clientArea.getLineHeight(row);
            final clientHeight = _clientArea.getSize().y;
            // GetScrollPixelsPerUnit(&scrollX, &scrollY);
            // below taken from SetScrollRate()
            int scrollX = getScrollPixelsPerUnitX();
            int scrollY = getScrollPixelsPerUnitY();
            int scrollPosY = ((itemStart + itemHeight - clientHeight + scrollY - 1) / scrollY).floor();
            int scrollPosX = -1;
            if (column != -1 && (scrollX != 0)) {
                scrollPosX = (_clientArea.getColumnStart(column) / scrollX).floor();
            }
            scroll(scrollPosX, scrollPosY);
        }
    }
  }

  void ensureVisible( WxDataViewItem item, WxDataViewColumn? column )
  {
    expandAncestors( item );

    _clientArea._recalculateDisplay();

    final row = _clientArea.getRowByItem(item);
    if( row >= 0 )
    {
          if( column == null ) {
              ensureVisibleRowCol(row, -1);
          } else {
              ensureVisibleRowCol( row, getColumnIndex(column) );
          }
    }
  }

  WxDataViewColumn? getColumn( int pos ) {
    return _cols[pos];
  }

  int getColumnCount( ) {
    return _cols.length;
  }

  int getColumnPosition( WxDataViewColumn column ) {
    return _cols.indexOf( column );
  }

  WxDataViewColumn? getSortingColumn() {
    if (_sortingColumnIdxs.isEmpty) return null;
    return getColumn( _sortingColumnIdxs.first );
  }

  List <WxDataViewColumn> getSortingColumns() {
    List <WxDataViewColumn> out = [];
    for (final idx in _sortingColumnIdxs) {
      out.add( getColumn( idx )! );
    }
    return out;
  }

  WxDataViewItem getCurrentItem( ) {
    return hasFlag(wxDV_MULTIPLE) ? _doGetCurrentItem()
                                  : getSelection();
  }

  void setCurrentItem( WxDataViewItem item ) {
    if (!item.isOk()) return;
    if (hasFlag(wxDV_MULTIPLE) ) {
        _doSetCurrentItem(item);
    } else {
        select(item); 
    }
  }

  void editItem( WxDataViewItem item, WxDataViewColumn column) {
    _clientArea.startEditing( item, column );
  }

  bool hasSelection() { 
    return getSelectedItemsCount() != 0;
  }
  
  WxDataViewItem getSelection( ) {
    if ( getSelectedItemsCount() != 1 ) {
        return WxDataViewItem();
    }

    List <WxDataViewItem> selections = [];
    getSelections(selections);
    return selections[0];
  }

  int getSelections( List <WxDataViewItem> sel )
  {
    sel.clear();
    final selections = _clientArea.getSelections(); 
    for (final row in selections.getList())
    {
        final item = _clientArea.getItemByRow(row);
        if ( item.isOk() )
        {
            sel.add(item);
        }
        else
        {
            wxLogError( "invalid item in selection - bad internal state" );
            return -1;
        }
    }
    return sel.length;
  } 

  int getSelectedItemsCount( ) {
    return _clientArea.getSelections().getSelectedCount();
  }

  bool isSelected( WxDataViewItem item )
  {
    final row = _clientArea.getRowByItem( item );
    if (row >= 0) {
        return _clientArea.isRowSelected(row);
    }
    return false;
  }

  void setSelections( List<WxDataViewItem> sel )
  {
    _clientArea.clearSelection();
    final model = getModel();
    if (model == null) return;

    if ( sel.isEmpty )  return;

    WxDataViewItem lastParent = WxDataViewItem();

    for ( int i = 0; i < sel.length; i++ )
    {
        WxDataViewItem item = sel[i];
        WxDataViewItem parent = model.getParent( item );
        if (parent.isOk())
        {
            if (parent != lastParent) {  
                expandAncestors(item);
            }
        }

        lastParent = parent;
        int row = _clientArea.getRowByItem( item );
        if( row >= 0 ) {
            _clientArea.selectRow(row, true);
        }
    }

    // Also make the last item as current item
    _doSetCurrentItem(sel.last);
  }

  void select( WxDataViewItem item )
  {
    expandAncestors( item );
    final row = _clientArea.getRowByItem( item );
    if( row >= 0 )
    {
        // Unselect all rows before select another in the single select mode
        if (_clientArea.isSingleSel()) {
            _clientArea.unselectAllRows();
        }

        _clientArea.selectRow(row, true);

        // Also set focus to the selected item
        _clientArea.changeCurrentRow( row );
    }
  }

  void selectAll( ) {
    _clientArea.selectAllRows();
  }

  void unselect( WxDataViewItem item ) {
    final row = _clientArea.getRowByItem( item );
    if (row >= 0) {
        _clientArea.selectRow(row, false);
    }
  }

  void unselectAll() {
    _clientArea.unselectAllRows();
  }

  void resort() { 
  }

  bool allowMultiColumnSort(bool allow) {
    _allowMultiColumnSort = allow;
    return false; 
  }

  bool isMultiColumnSortAllowed() {
    return _allowMultiColumnSort;
  }

  void toggleSortByColumn(int column) {
  }

  // --------------- not public API ------------------

  WxHeaderCtrl? getHeader() {
    return _headerArea;
  }

  void _doSetExpanderColumn()
  {
    WxDataViewColumn? column = getExpanderColumn();
    if ( column != null)
    {
        final index = getColumnIndex(column);
        if ( index != wxNOT_FOUND ) {
            _invalidateColBestWidth(index);
        }
    }
    _clientArea._updateDisplay();
  }

  void _doSetIndent() {
    _clientArea._updateDisplay();
  }

/* 
  void hitTest( WxPoint point, WxDataViewItem item, WxDataViewColumn column ) {
  }
*/
  WxRect getItemRect( WxDataViewItem item, WxDataViewColumn column )
  {
    WxRect r = _clientArea.getItemRect(item, column);
    if ( (r.width != 0) || (r.height != 0))
    {
        // Convert position from the main window coordinates to the control coordinates.
        // (They can be different due to the presence of the header.).
        // TODO ?
        // final ctrlPos = screenToClient( _clientArea.clientToScreen(r.getPosition()) );
        // r.setPosition(ctrlPos);
    }
    return r;
  }

  WxDataViewItem getItemByRow( int row ) {
    return _clientArea.getItemByRow(row);
  }

  int getRowByItem( WxDataViewItem item ) {
    return _clientArea.getRowByItem(item);
  }

  void useColumnForSorting(int idx) {
    _sortingColumnIdxs.add( idx );
  }

  void dontUseColumnForSorting(int idx) {
    _sortingColumnIdxs.removeWhere((value) => value == idx );
  }

  bool isColumnSorted(int idx) {
    return _sortingColumnIdxs.contains(idx);
  }

  void resetAllSortColumns() {    
    for (final idx in _sortingColumnIdxs) {
      getColumn(idx)!.unsetAsSortKey();
    }
  }

  int getBestColumnWidth(int idx)
  {
    if ( _colsBestWidths[idx].width != 0 ) {
        return _colsBestWidths[idx].width;
    }

    if (getModel() == null) return 140;

    final count = _clientArea.getRowCount();
    final column = getColumn(idx);
    if (column == null) return 140;
    final renderer = column.getRenderer();

    final calculator = WxDataViewMaxWidthCalculator (this, _clientArea, renderer,
                                            getModel()!, column.getModelColumn(),
                                            _clientArea.getRowHeight());

    calculator.updateWithWidth(column.getMinWidth());

    if ( _headerArea != null) {
        calculator.updateWithWidth( _headerArea!.getColumnTitleWidth(column));
    }

    final origin = calcUnscrolledPosition( WxPoint.zero );
    calculator.computeBestColumnWidth(count,
                                      _clientArea.getLineAt(origin.y),
                                      _clientArea.getLineAt(origin.y + getClientSize().y));

    int maxWidth = calculator.getMaxWidth();
    if ( maxWidth > 0 ) {
        maxWidth += 2 * fromDIP(wxDATAVIEW_CELL_PADDING_RIGHTLEFT);
    }

    _colsBestWidths[idx].width = maxWidth;
    return maxWidth;
  }

  void columnMoved( WxDataViewColumn col, int newPos ) {
    _clientArea._updateDisplay();
    final event = WxDataViewEvent( wxGetDataViewColumnReorderedEventType(), this, col, WxDataViewItem() );
    event.setColumn(newPos);
    processEvent(event);
  }

  void onColumnChange( int idx) {
    if (_headerArea != null) {
        _headerArea!.updateColumn(idx);
    }
    _clientArea._updateDisplay();
  }

  void onColumnResized() {
    _clientArea._updateDisplay();
  }

  void onColumnWidthChange( int idx) {
    _invalidateColBestWidth(idx);
    onColumnChange(idx);
  }

  void onColumnsCountChanged() {
    if (_headerArea != null) {
        _headerArea!.setColumnCount(getColumnCount());
    }
    _clientArea.onColumnsCountChanged();
  }

  WxWindow getMainWindow() { 
    return _clientArea;
  }

  int getColumnIndex( WxDataViewColumn column) {
    final count = _cols.length;
    for ( int n = 0; n < count; n++ ) {
        if ( _cols[n] == column ) return n;
    }
    return wxNOT_FOUND;
  }

  // Return the index of the column having the given model index.
  int getModelColumnIndex( int modelColumn) {
    final count = _cols.length;
    for ( int index = 0; index < count; index++ ) {
        final column = getColumn(index);
        if ( column!.getModelColumn() == modelColumn ) return index;
    }
    return wxNOT_FOUND;
  }

  WxDataViewColumn? getColumnAt( int pos) {
    int idx = pos;
    if (_headerArea != null) {
      final order = _headerArea!.getColumnsOrder();
      idx = order[pos];
    }
    return getColumn(idx);
  }

  WxDataViewColumn? getCurrentColumn() {
    return _clientArea.getCurrentColumn();
  }

  void onIdle( WxIdleEvent event )
  {
    if (_colsDirty) {
      _updateColWidths();
    }
    event.skip();
  }

  WxDataViewItem _doGetCurrentItem() {
    return getItemByRow(_clientArea.getCurrentRow());
  }

  void _doSetCurrentItem( WxDataViewItem item )
  {
    final row = _clientArea.getRowByItem(item);
    final oldCurrent = _clientArea.getCurrentRow();
    if ( row != oldCurrent )
    {
        _clientArea.changeCurrentRow(row);
        _clientArea.refreshRow(oldCurrent);
        _clientArea.refreshRow(row);
    }
  } 

  void _doExpand( WxDataViewItem item, bool expandChildren )
  {
    final row = _clientArea.getRowByItem( item );
    if (row != wxNOT_FOUND) {
        _clientArea.expand(row,  expandChildren: expandChildren);
    }
  }

  void _invalidateColBestWidths()
  {
    _colsBestWidths.clear();
    for (int i = 0; i < _cols.length; i++) {
      _colsBestWidths.add( WxDataViewCtrlCachedColWidthInfo() );
    }
    _colsDirty = true;
    refresh();
  }

  void _invalidateColBestWidth(int idx)
  {
    _colsBestWidths[idx].width = 0;
    _colsBestWidths[idx].dirty = true;
    _colsDirty = true;
    refresh();
  }

  void _updateColWidths()
  {
    _colsDirty = false;
    if (_headerArea == null) return;

    final len = _colsBestWidths.length;
    for ( int i = 0; i < len; i++ )
    {
        // Note that we have to have an explicit 'dirty' flag here instead of
        // checking if the width==0, as is done in GetBestColumnWidth().
        //
        // Testing width==0 wouldn't work correctly if some code called
        // GetWidth() after col. width invalidation but before
        // wxDataViewCtrl::UpdateColWidths() was called at idle time. This
        // would result in the header's column width getting out of sync with
        // the control itself.
        if ( _colsBestWidths[i].dirty )
        {
            _headerArea!.updateColumn(i);
            _colsBestWidths[i].dirty = false;
        }
    }
  }
}

