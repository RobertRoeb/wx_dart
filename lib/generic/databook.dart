// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../wx_dart.dart';

/// A book control similar to [WxNotebook] or [WxTreebook] that allows the
/// user to switch between different pages. WxDataViewBook uses 
/// [WxDataViewChapterCtrl] internally for displaying chapters and pages
/// like a table of contents.
/// ```dart
///    final book = WxDataViewBook( this, -1 );
///    final page1 = WxPanel(this,-1);
///    final chapter1 = book.appendChapter( null, "Chapter 1", page1 );
///
///    final page1_1 = WxPanel(this,-1);
///    book.appendPage( chapter1, null, "Page 1.1", page1_1 );
///    final page1_2 = WxPanel(this,-1);
///    book.appendPage( chapter1, null, "Page 1.2", page1_2 );
///
/// ```
/// 
/// Different from [WxNotebook] changing the selection to a new page
/// cannot be vetoed as the underlying [WxDataViewCtrl] does not support
/// vetoing a selection change.

class WxDataViewBook extends WxWindow {
  WxDataViewBook( WxWindow parent, int id, { WxPoint pos=wxDefaultPosition, WxSize size=wxDefaultSize, int style=0 }) :
    super( parent, id, pos, size, style )
  {
    _isTouch = wxTheApp.isTouch();

    _mainSizer = WxBoxSizer( wxHORIZONTAL );
    setSizer( _mainSizer );

    _drawerPanel = WxPanel( this, -1, size: WxSize( 250,100), style: wxTRANSLUCENT_WINDOW  );
    _mainSizer.add( _drawerPanel, flag: wxEXPAND );
    _drawerPanel.show( show: !_isTouch );

    final panelSizer = WxBoxSizer( wxVERTICAL );
    _drawerPanel.setSizer( panelSizer );
    _chapterCtrl = WxDataViewChapterCtrl( _drawerPanel, -1 );
    panelSizer.add( _chapterCtrl, flag: wxEXPAND, proportion: 1 );

    bindSizeEvent( _onSize );
    _chapterCtrl.bindDataViewSelectionChangedEvent( _onSelectionChanged, -1 );
  }

  /// Show the page without changing the selection
  void showPage( WxWindow page ) {
    if (page == _currentPage) return;
    if (_currentPage != null)
    {
      _currentPage!.hide();
      _mainSizer.remove(1);
    }
    _currentPage = page;
    if (_currentPage != null)
    {
      _currentPage!.show();
      _mainSizer.add( _currentPage!, flag: wxEXPAND, proportion: 1 );
    }
    layout();
  }

  void _onSelectionChanged( WxDataViewEvent event )
  {
    final selection = _chapterCtrl.getSelection();
    if (!selection.isOk()) return;
    WxWindow page = _chapterCtrl.getItemData( selection );
    showPage( page );
  }

  /// Returns current page 
  WxWindow? getCurrentPage() {
    return _currentPage;
  }

  /// Returns page of given [item]
  WxWindow? findPage( WxDataViewItem item ) {
    WxWindow? page = _chapterCtrl.getItemData( item );
    return page;
  }

  /// Sets selection to the given [item] and shows its page
  void setSelection( WxDataViewItem item ) {
    _chapterCtrl.select( item );
    WxWindow? page = _chapterCtrl.getItemData( item );
    if (page != null) {
      showPage( page );
    }
  }

  /// Returns the underlying WxDataViewChapterCtrl
  WxDataViewChapterCtrl getDataViewChapterCtrl() {
    return _chapterCtrl;
  }

  /// Appends new chapter to root
  WxDataViewItem appendChapter( WxBitmap? icon, String title, WxWindow page )
  {
    if (_currentPage == null)
    {
      _currentPage = page;
      _mainSizer.add( page, flag: wxEXPAND, proportion: 1 );
    }
    else
    {
      page.hide();
    }
    return _chapterCtrl.appendItem( WxDataViewItem(), icon, title, data: page );
  }

  /// Appends new chapter to given [parent] chapter
  WxDataViewItem appendPage( WxDataViewItem parent, WxBitmap? icon, String title, WxWindow page )
  {
    page.hide();
    return _chapterCtrl.appendItem( parent, icon, title, data: page );
  }

  /// Set the width of the left panel containing the tree view of the
  /// chapters and pages
  void setTreeWidth( int width )
  {
    _drawerPanel.setSize( WxSize(width, -1) );
  }

  bool _isTouch = false;
  late WxPanel _drawerPanel;
  late WxBoxSizer _mainSizer;
  WxWindow? _currentPage;
  late WxDataViewChapterCtrl _chapterCtrl;

  void _onSize( WxSizeEvent event )
  {
    if (_isTouch != wxTheApp.isTouch())
    {
      _isTouch = wxTheApp.isTouch();
      _drawerPanel.show( show: !_isTouch );
    }
    event.skip();
  }
}