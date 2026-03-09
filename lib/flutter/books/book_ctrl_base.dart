// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxBookCtrlBase ----------------------

const int NO_IMAGE = -1;

class WxPageItem {
  WxPageItem( this.page, this.text, this.image );

  WxWindow page;
  String text;
  int image;
} 

const int wxBK_DEFAULT = 0x0000;
const int wxBK_TOP = 0x0010;
const int wxBK_BOTTOM = 0x0020;
const int wxBK_LEFT = 0x0040;
const int wxBK_RIGHT = 0x0080;
const int wxBK_ALIGN_MASK = (wxBK_TOP | wxBK_BOTTOM | wxBK_LEFT | wxBK_RIGHT);

/// Defines the interface for different controls [WxNotebook], [WxTreebook], 
/// [WxNavigationCtrl] handling a number of subwindows of which the user can
/// only see one.
/// 
/// [WxDataViewBook] does not derive from [WxBookCtrlBase] but
/// implements a similar interface and logic.
/// 
/// Each panel usually can have a bitmap and/or a title. The bitmaps
/// are passed via bitmap list and an index in it.
/// 
/// Page interface
/// * [addPage]
/// * [insertPage]
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


abstract class WxBookCtrlBase extends WxControl {
  WxBookCtrlBase( super.parent, super.id, { super.pos = wxDefaultPosition, super.size = wxDefaultSize, super.style = 0 } );

  final List<WxPageItem> _pages = [];
  int _currentSelection = 0;
  bool _blockEvents = false;
  int _oldSelection = 0;

  List<WxBitmapBundle>_images = [];
  final List<WxBitmap>_bitmaps = [];

  /// Associates list of images to be used as icons in the title
  void setImages( List<WxBitmapBundle> images ) {
    _images = images;
    _rebuildBitmaps();
  }

  /// Returns true if an image list has been associated
  bool hasImages( ) {
    return _images.isNotEmpty;
  }

  /// Returns number of images in associated image list
  int getImageCount( ) {
    return _images.length;
  }

  void _rebuildBitmaps()
  {
    _bitmaps.clear();
    for (final bundle in _images) {
      _bitmaps.add( bundle.getBitmapFor(this) );
    }
    _setState();
  }
  @override
  void _updateTheme()
  {
    for (final bitmap in _bitmaps) {
        bitmap._updateTheme();
        bitmap._addListener(this);
    }
    // _rebuildBitmaps();
  }

  void _recreateController() {}

  /// Returns number of pages
  int getPageCount() {
    return _pages.length;
  }

  /// Adds [page] with the title [text] to the control
  /// 
  /// Selects this page initially if [select] is true. Uses image
  /// at index [image] in the image list next to the title, or no
  /// image if [image] is -1
  bool addPage( WxWindow page, String text, { bool select = false, int image = wxNO_IMAGE }) {
    _pages.add( WxPageItem(page, text, image));
    if (select) {
      _currentSelection = _pages.length - 1;
    }
    _recreateController;
    _setState();
    return true;
  }
  /// Inserts [page] at position [pos] with the title [text] to the control
  /// 
  /// Selects this page initially if [select] is true. Uses image
  /// at index [image] in the image list next to the title, or no
  /// image if [image] is -1
  bool insertPage( int pos, WxWindow page, String text, { bool select = false, int image = wxNO_IMAGE }) {
    _pages.insert( pos, WxPageItem(page, text, image));
    if (select) {
      _currentSelection = pos;
    }
    _recreateController;
    _setState();
    return true;
  }

  /// Returns index of [page] or -1 if not found 
  int findPage( WxWindow page ) {
    int i = 0;
    for (WxPageItem item in _pages) {
      if (item.page == page) {
        return i;
      } 
      i++;
    }
    return -1;
  }

  /// Returns currently selected page index
  int getSelection() {
    return _currentSelection;
  }

  /// Selects page at index [selection] 
  int setSelection( int selection ) {
    return changeSelection( selection );
/*
    // we change this in wxDart
    _oldSelection = _currentSelection;
    _currentSelection = selection;
    _setState();
    return _oldSelection;
*/
  }
  /// Selects page at index [selection] 
  int changeSelection( int selection ) {
    // block events
    int oldSel = _currentSelection;
    _currentSelection = selection;
    _blockEvents = true;
    _setState();
    return oldSel;
  }

  /// Returns window at index [page], or null
  WxWindow? getPage( int page )
  {
    if (page < 0) return null;
    WxPageItem? item = _pages.elementAtOrNull(page);
    if (item == null) {
      return null;
    }
    return item.page;
  }

  /// Returns currently selected page, or null
  WxWindow? getCurrentPage() {
    return getPage(_currentSelection);
  }

  /// Returns title of page at index [page]
  String getPageText( int page )  {
    WxPageItem? item = _pages.elementAtOrNull(page);
    if (item == null) {
      return "";
    }
    return item.text;
  }

  /// Sets title of page at index [page] to [text]
  void setPageText( int page, String text ) {
    WxPageItem? item = _pages.elementAtOrNull(page);
    if (item != null) {
      item.text = text;
      _setState();
    }
  }

  /// Delete page at index [page]
  bool deletePage( int page ) {
    WxWindow? window = getPage(page);
    if (window == null) {
      return false;
    }
    _pages.removeAt(page);
    if (page >= _currentSelection) {
      _currentSelection--;
    }
    removeChild(window);  // TODO destroy?
    _recreateController;
    _setState();
    return true;
  }

  /// Delete all pages
  bool deleteAllPages() {
    _currentSelection = -1;
    _pages.clear();
    destroyChildren();
    _recreateController;
    _setState();
    return false;
  }
}

