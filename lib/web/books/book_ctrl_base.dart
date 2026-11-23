// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01 (wxDart Web: 2026-11-15)
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
  int _oldSelection = -1;

  List<WxBitmapBundle> _images = [];

  // event types, different for WxNotebook and WxTreebook
  int get _changingEventType;
  int get _changedEventType;

  /// Associates list of images to be used as icons in the title
  void setImages( List<WxBitmapBundle> images ) {
    _images = images;
    _updateJs();
  }

  /// Returns true if an image list has been associated
  bool hasImages( ) {
    return _images.isNotEmpty;
  }

  /// Returns number of images in associated image list
  int getImageCount( ) {
    return _images.length;
  }

  // ---------------- wxDart Web: DOM and layout

  /// Level and expanded state of a page, only used by WxTreebook
  int _levelOf( int page ) => 0;
  bool _isExpanded( int page ) => false;

  void _updateJs() {
    final list = <Map<String, Object>>[];
    for (int i = 0; i < _pages.length; i++) {
      final item = _pages[i];
      final json = <String, Object>{ "t": item.text, "i": 0, "bw": 0, "bh": 0,
          "l": _levelOf(i), "e": _isExpanded(i) };
      if (item.image >= 0 && item.image < _images.length) {
        final bundle = _images[item.image];
        final bitmap = bundle.getBitmapFor( this );
        final size = bundle._logicalSize();
        json["i"] = bitmap._handle;
        json["bw"] = size.x;
        json["bh"] = size.y;
      }
      list.add( json );
    }
    _jsBookSet( _handle, jsonEncode( list ), _currentSelection );
    _layoutPages();
  }

  @override
  String get _jsKind => 'notebook';

  @override
  WxSize getClientSize() {
    if (!_rectApplied) return getSize();
    final s = _jsClientSize( _handle );
    return WxSize( s.w, s.h );
  }

  @override
  WxSize _doGetBestSize() {
    int w = 0;
    int h = 0;
    for (final item in _pages) {
      final size = item.page.getEffectiveMinSize();
      w = max( w, size.x );
      h = max( h, size.y );
    }
    final chrome = _jsBookChrome( _handle );
    return WxSize( max( w + chrome.w, 60 ), max( h + chrome.h, 40 ) );
  }

  /// Passes the size on to the pages, without the tabs
  @override
  bool informFirstDirection(int direction, int size, int availableOtherDir) {
    if (size < 0) return false;
    final chrome = _jsBookChrome( _handle );
    final available = max( 0, size - (direction == wxHORIZONTAL ? chrome.w : chrome.h) );
    bool used = false;
    for (final item in _pages) {
      used |= item.page.informFirstDirection( direction, available, -1 );
    }
    if (used) _bestSize = null;  // depends on the pages
    return used;
  }

  @override
  WxSize getBestSize() {
    // the pages define the size, a sizer set on a book control is ignored
    _bestSize ??= _doGetBestSize();
    return _bestSize!;
  }

  @override
  void _sendSizeEvent() {
    _layoutPages();
    super._sendSizeEvent();
  }

  @override
  bool _wantsNativeKey( int keyCode ) {
    // arrow keys move through the tabs or the tree
    return keyCode == WXK_LEFT || keyCode == WXK_RIGHT || keyCode == WXK_UP ||
        keyCode == WXK_DOWN || keyCode == WXK_HOME || keyCode == WXK_END;
  }

  /// Sizes the current page to the client area and hides all others
  void _layoutPages() {
    if (!_rectApplied) return;
    final client = getClientSize();
    for (int i = 0; i < _pages.length; i++) {
      final page = _pages[i].page;
      if (i == _currentSelection) {
        page._setActualRect( 0, 0, client.x, client.y );
        if (!page.isShown()) page.show();
      } else if (page.isShown()) {
        page.hide();
      }
    }
  }

  void _pagesChanged() {
    invalidateBestSize();
    _updateJs();
  }

  /// Called from wxc.js when the user clicked a tab or tree item
  void _onJsSelect( int selection ) {
    if (selection < 0 || selection >= _pages.length || selection == _currentSelection) return;
    final old = _currentSelection;
    final changing = WxNotebookEvent( eventType: _changingEventType, id: getId(), sel: selection, oldSel: old );
    changing.setEventObject( this );
    processEvent( changing );
    if (!changing.isAllowed()) {
      _jsBookSelect( _handle, _currentSelection );   // vetoed
      return;
    }
    _doSelect( selection );
    final changed = WxNotebookEvent( eventType: _changedEventType, id: getId(), sel: selection, oldSel: old );
    changed.setEventObject( this );
    processEvent( changed );
  }

  void _doSelect( int selection ) {
    _oldSelection = _currentSelection;
    _currentSelection = selection;
    _jsBookSelect( _handle, selection );
    _layoutPages();
  }

  // ---------------- wxBookCtrlBase API

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
    return insertPage( _pages.length, page, text, select: select, image: image );
  }

  /// Inserts [page] at position [pos] with the title [text] to the control
  ///
  /// Selects this page initially if [select] is true. Uses image
  /// at index [image] in the image list next to the title, or no
  /// image if [image] is -1
  bool insertPage( int pos, WxWindow page, String text, { bool select = false, int image = wxNO_IMAGE }) {
    if (pos < 0 || pos > _pages.length) return false;
    if (page._parent != this) {
      wxLogError( "The pages of a book control must be created with the book control as parent." );
    }
    _pages.insert( pos, WxPageItem( page, text, image ) );
    if (_currentSelection >= pos) _currentSelection++;
    if (select || _currentSelection < 0) {
      _currentSelection = pos;
    } else {
      page.hide();
    }
    _pagesChanged();
    return true;
  }

  /// Returns index of [page] or -1 if not found 
  int findPage( WxWindow page ) {
    for (int i = 0; i < _pages.length; i++) {
      if (_pages[i].page == page) return i;
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
  }

  /// Selects page at index [selection]
  int changeSelection( int selection ) {
    final old = _currentSelection;
    if (selection < 0 || selection >= _pages.length || selection == old) return old;
    _doSelect( selection );
    return old;
  }

  /// Selects the next page (or the previous one if [forward] is false),
  /// wrapping around at the end.
  ///
  /// Different from [setSelection], this sends a PageChanging event (which
  /// can be vetoed) and a PageChanged event, as if the user had selected
  /// the page.
  void advanceSelection( { bool forward = true } ) {
    if (_pages.isEmpty) return;
    final n = _pages.length;
    final next = forward ? (_currentSelection + 1) % n : (_currentSelection - 1 + n) % n;
    _onJsSelect( next );
  }

  /// Returns window at index [page], or null
  WxWindow? getPage( int page )
  {
    if (page < 0 || page >= _pages.length) return null;
    return _pages[page].page;
  }

  /// Returns currently selected page, or null
  WxWindow? getCurrentPage() {
    return getPage(_currentSelection);
  }

  /// Returns title of page at index [page]
  String getPageText( int page )  {
    final item = _pages.elementAtOrNull(page);
    return item?.text ?? "";
  }

  /// Sets title of page at index [page] to [text]
  void setPageText( int page, String text ) {
    final item = _pages.elementAtOrNull(page);
    if (item != null) {
      item.text = text;
      _pagesChanged();
    }
  }

  /// Returns the index of the image of the given [page]
  int getPageImage( int page ) {
    final item = _pages.elementAtOrNull(page);
    return item?.image ?? -1;
  }

  /// Sets image of page at index [page] to [image]
  /// 
  /// Returns true on success
  bool setPageImage( int page, int image ) {
    final item = _pages.elementAtOrNull(page);
    if (item == null) return false;
    item.image = image;
    _updateJs();
    return true;
  }

  /// Removes [count] pages starting at [page] without destroying them
  void _removePages( int page, int count, bool destroy ) {
    for (int i = 0; i < count; i++) {
      final window = _pages[page].page;
      _pages.removeAt( page );
      if (destroy) {
        window.destroy();
      } else {
        window.hide();
      }
    }
    if (_currentSelection >= page + count) {
      _currentSelection -= count;
    } else if (_currentSelection >= page) {
      // the selected page is gone: select its neighbour
      _currentSelection = min( page, _pages.length - 1 );
    }
    _pagesChanged();
  }

  /// Removes the page at index [page] from the control without
  /// destroying it (as opposed to [deletePage]). The window remains
  /// a child of the control, but is no longer shown.
  ///
  /// Returns true on success
  bool removePage( int page ) {
    if (page < 0 || page >= _pages.length) return false;
    _removePages( page, 1, false );
    return true;
  }

  /// Delete page at index [page]
  ///
  /// Returns true on success
  bool deletePage( int page ) {
    if (page < 0 || page >= _pages.length) return false;
    _removePages( page, 1, true );
    return true;
  }

  /// Delete all pages
  bool deleteAllPages() {
    _removePages( 0, _pages.length, true );
    _currentSelection = -1;
    _updateJs();
    return true;
  }
}
