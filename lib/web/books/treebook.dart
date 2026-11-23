// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01 (wxDart Web: 2026-11-15)
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxTreebook ----------------------

/// The class uses a tree like structure on the left to handle multiple windows
/// on the right. It maps the page index to an item of the tree so that the 
/// logic from [WxBookCtrlBase] can be used.
/// 
/// [WxDataViewBook] does not derive from [WxBookCtrlBase] but
/// implements a similar interface and logic.
/// 
/// Example usage:
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
/// 
/// tree.bindTreebookPageChangedEvent( (event) {
///    // page has changed
/// }, -1 );
/// 
/// tree.bindTreebookNodeCollapsedEvent( (event) {
///    // Node has collpased
/// }, -1 );
/// 
/// tree.bindTreebookNodeExpandedEvent( (event) {
///    // page has changed
/// }, -1 );
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
  /// Creates the tree book. In wxDart Web, the tree is drawn by the
  /// browser (there is no [WxTreeCtrl] and hence no getTreeCtrl()).
  WxTreebook( super.parent, super.id, { super.pos, super.size, int flags = 0 } )
  : super( style: flags );

  // depth of each page in the tree and expanded state, parallel to _pages
  final List<int> _levels = [];
  final List<bool> _expanded = [];

  @override
  String get _jsKind => 'treebook';

  @override
  int get _changingEventType => wxGetTreebookPageChangingEventType();
  @override
  int get _changedEventType => wxGetTreebookPageChangedEventType();

  @override
  int _levelOf( int page ) => _levels[page];
  @override
  bool _isExpanded( int page ) => _expanded[page];

  /// Number of pages below [pos] in the tree
  int _subtreeSize( int pos ) {
    int count = 0;
    for (int i = pos + 1; i < _levels.length && _levels[i] > _levels[pos]; i++) {
      count++;
    }
    return count;
  }

  void _insert( int pos, int level, WxWindow page, String text, bool select, int image ) {
    _levels.insert( pos, level );
    _expanded.insert( pos, false );
    super.insertPage( pos, page, text, select: select, image: image );
  }

  /// Adds a top-level page
  @override
  bool addPage( WxWindow page, String text, { bool select = false, int image = wxNO_IMAGE } )
  {
    _insert( _pages.length, 0, page, text, select, image );
    return true;
  }

  /// Adds a sub-page to the last top-level page
  bool addSubPage( WxWindow page, String text, { bool select = false, int image = wxNO_IMAGE } )
  {
    final last = _levels.lastIndexOf( 0 );
    if (last < 0) return false;
    _insert( _pages.length, 1, page, text, select, image );
    return true;
  }

  /// Inserts a page before the page at [pos], on the same level
  @override
  bool insertPage( int pos, WxWindow page, String text, { bool select = false, int image = wxNO_IMAGE } )
  {
    if (pos < 0 || pos > _pages.length) return false;
    final level = pos < _pages.length ? _levels[pos] : 0;
    _insert( pos, level, page, text, select, image );
    return true;
  }

  /// Adds a sub-page as the last child of the page at [pos]
  bool insertSubPage( int pos, WxWindow page, String text, { bool select = false, int image = wxNO_IMAGE } )
  {
    if (pos < 0 || pos >= _pages.length) return false;
    _insert( pos + 1 + _subtreeSize( pos ), _levels[pos] + 1, page, text, select, image );
    return true;
  }

  /// Returns the index of the parent page of the page at [pagePos],
  /// or wxNOT_FOUND for a top-level page
  int getPageParent( int pagePos )
  {
    if (pagePos < 0 || pagePos >= _pages.length) return wxNOT_FOUND;
    for (int i = pagePos - 1; i >= 0; i--) {
      if (_levels[i] < _levels[pagePos]) return i;
    }
    return wxNOT_FOUND;
  }

  /// Expands (or collapses) the page node at [pagePos], returns the old state
  bool expandNode( int pagePos, {bool expand=true } )
  {
    if (pagePos < 0 || pagePos >= _pages.length) return false;
    final old = _expanded[pagePos];
    if (old == expand) return old;
    _expanded[pagePos] = expand;
    _jsBookExpand( _handle, pagePos, expand );
    return old;
  }

  /// Collapses the page node at [pagePos], returns the old state
  bool collapseNode( int pagePos ) {
    return expandNode( pagePos, expand: false );
  }

  /// Returns true if the page node at [pagePos] is expanded
  bool isNodeExpanded( int pagePos ) {
    if (pagePos < 0 || pagePos >= _pages.length) return false;
    return _expanded[pagePos];
  }

  /// Called from wxc.js when the user expanded or collapsed a node
  void _onJsExpand( int pagePos, bool expand ) {
    if (pagePos < 0 || pagePos >= _pages.length) return;
    _expanded[pagePos] = expand;
    final event = WxNotebookEvent( eventType: expand ? wxGetTreebookNodeExpandedEventType() : wxGetTreebookNodeCollapsedEventType(),
        id: getId(), sel: pagePos, oldSel: pagePos );
    event.setEventObject( this );
    processEvent( event );
  }

  /// Deletes the page at [page] together with its sub-pages
  @override
  bool deletePage( int page )
  {
    if (page < 0 || page >= _pages.length) return false;
    final count = 1 + _subtreeSize( page );
    _levels.removeRange( page, page + count );
    _expanded.removeRange( page, page + count );
    _removePages( page, count, true );
    return true;
  }

  /// Removes the page at [page] together with its sub-pages without
  /// destroying them
  ///
  /// Returns true on success
  @override
  bool removePage( int page )
  {
    if (page < 0 || page >= _pages.length) return false;
    final count = 1 + _subtreeSize( page );
    _levels.removeRange( page, page + count );
    _expanded.removeRange( page, page + count );
    _removePages( page, count, false );
    return true;
  }

  @override
  bool deleteAllPages()
  {
    _levels.clear();
    _expanded.clear();
    return super.deleteAllPages();
  }
}
