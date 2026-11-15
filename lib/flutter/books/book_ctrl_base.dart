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
  int _currentSelection = -1;
  bool _blockEvents = false;
  int _oldSelection = -1;

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
    if (_currentSelection == -1) {
      _currentSelection = 0;
    }
    _pages.add( WxPageItem(page, text, image));
    if (select) {
      _currentSelection = _pages.length - 1;
    }
    _recreateController();
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
    if ((_pages.length > 1) && (pos <= _currentSelection)) {
      _currentSelection++;
    }
    if (select) {
      _currentSelection = pos;
    }
    _recreateController();
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

  /// Returns the index of the image of the given [page]
  int getPageImage( int page ) {
    WxPageItem? item = _pages.elementAtOrNull(page);
    if (item != null) {
      return item.image;
    }
    return -1;
  }

  /// Sets image of page at index [page] to [image]
  /// 
  /// Returns true on success
  bool setPageImage( int page, int image ) {
    WxPageItem? item = _pages.elementAtOrNull(page);
    if (item != null) {
      item.image = image;
      _setState();
      return true;
    }
    return false;
  }

  /// Delete page at index [page]
  /// 
  /// Returns true on success
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
    _recreateController();
    _setState();
    return true;
  }

  // Event types sent by [advanceSelection], overridden by [WxTreebook]
  int get _pageChangingEventType => wxGetNotebookPageChangingEventType();
  int get _pageChangedEventType => wxGetNotebookPageChangedEventType();

  /// Selects the next page (or the previous one if [forward] is false),
  /// wrapping around at the end.
  /// 
  /// Different from [setSelection], this sends a PageChanging event (which
  /// can be vetoed) and a PageChanged event, as if the user had selected
  /// the page.
  void advanceSelection( { bool forward = true } ) {
    final count = _pages.length;
    if (count == 0) return;
    final oldSel = _currentSelection;
    final newSel = (oldSel < 0) ? 0 : (forward ? (oldSel + 1) % count : (oldSel - 1 + count) % count);
    if (newSel == oldSel) return;

    final changing = WxNotebookEvent( eventType: _pageChangingEventType, id: getId(), sel: newSel, oldSel: oldSel );
    changing.setEventObject( this );
    processEvent( changing );
    if (!changing.isAllowed()) return;

    changeSelection( newSel );
    _oldSelection = newSel;

    final changed = WxNotebookEvent( eventType: _pageChangedEventType, id: getId(), sel: newSel, oldSel: oldSel );
    changed.setEventObject( this );
    processEvent( changed );
  }

  // Removes [count] pages starting at [page] from the control without
  // destroying the windows and adjusts the selection.
  void _removePageRange( int page, int count ) {
    _pages.removeRange( page, page + count );
    if (_currentSelection >= page + count) {
      // a page before the selected one was removed
      _currentSelection -= count;
    } else if (_currentSelection >= page) {
      // the selected page was removed: select its neighbour
      _currentSelection = _pages.isEmpty ? -1 : min( page, _pages.length - 1 );
    }
    _recreateController();
    _setState();
  }

  /// Removes the page at index [page] from the control without
  /// destroying it (as opposed to [deletePage]). The window remains
  /// a child of the control, but is no longer shown.
  /// 
  /// Returns true on success
  bool removePage( int page ) {
    if (page < 0 || page >= _pages.length) {
      return false;
    }
    _removePageRange( page, 1 );
    return true;
  }

  /// Delete all pages
  bool deleteAllPages() {
    _currentSelection = -1;
    _pages.clear();
    destroyChildren();
    _recreateController();
    _setState();
    return true;
  }
}

