// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxSizer ----------------------

const int wxLEFT = 0x0010;
const int wxRIGHT = 0x0020;
const int wxUP = 0x0040;
const int wxDOWN = 0x0080;
const int wxTOP = wxUP;
const int wxBOTTOM = wxDOWN;
const int wxNORTH = wxUP;
const int wxSOUTH = wxDOWN;
const int wxWEST = wxLEFT;
const int wxEAST = wxRIGHT;
const int wxALL = (wxUP | wxDOWN | wxRIGHT | wxLEFT);
const int wxDIRECTION_MASK = wxALL;

const int wxALIGN_INVALID = -1;
const int wxALIGN_NOT = 0x0000;
const int wxALIGN_CENTER_HORIZONTAL = 0x0100;
const int wxALIGN_CENTRE_HORIZONTAL = wxALIGN_CENTER_HORIZONTAL;
const int wxALIGN_LEFT = wxALIGN_NOT;
const int wxALIGN_TOP = wxALIGN_NOT;
const int wxALIGN_RIGHT = 0x0200;
const int wxALIGN_BOTTOM = 0x0400;
const int wxALIGN_CENTER_VERTICAL = 0x0800;
const int wxALIGN_CENTRE_VERTICAL = wxALIGN_CENTER_VERTICAL;
const int wxALIGN_CENTER = (wxALIGN_CENTER_HORIZONTAL | wxALIGN_CENTER_VERTICAL);
const int wxALIGN_CENTRE = wxALIGN_CENTER;
const int wxALIGN_MASK = 0x0f00;

const int wxSTRETCH_NOT = 0x0000;
const int wxSHRINK = 0x1000;
const int wxGROW = 0x2000;
const int wxEXPAND = wxGROW;
const int wxSHAPED = 0x4000;
const int wxTILE = 0xc000;
const int wxSTRETCH_MASK = 0x7000;


/// Base class for layout system in wxDart. You can add windows, other sizers or
/// just empty space to a sizer and they will then get layed out in a specific
/// order by the sizer. Please go to [WxBoxSizer] for a discussion of the parameters
/// and flags used.

class WxSizer extends WxObject {
  WxSizer();

  final List<WxSizerItem> _items = [];

  WxPoint _position = wxDefaultPosition;
  WxSize _size = wxDefaultSize;

  List<WxSizerItem> getChildren() {
    return _items;
  }

  int getItemCount() {
    return _items.length;
  }

  void layout() {
    // Do nothing. Flutter always lays out the windows directly.
  }

  void _setPositionInternal( WxPoint pos ) {
    _position = pos;
  }

  void _setSizeInternal( WxSize size ) {
    _size = size;
  }

  WxPoint getPosition() {
    if (_items.isEmpty) {
      return _position;
    }
    WxPoint pos = _items[0].getPosition();
    for (final item in _items) {
      final itemPos = item.getPosition();
      if (itemPos.x < pos.x) pos = WxPoint( itemPos.x, pos.y );
      if (itemPos.y < pos.y) pos = WxPoint( pos.x, itemPos.y );
    }
    return pos;
  }

  WxSize getSize() {
    return _size;
  }

  void _testIfSizerAlreadyInList( WxSizer sizer )
  {
    for (final item in _items) {
      if (item._kind == WxSizerKind.sizer) {
        if (item._sizer == sizer) {
          wxLogError( "sizer aleady added" );
          return;
        }
      }
    }
  }

  void _testIfWindowAlreadyInList( WxWindow window )
  {
    for (final item in _items) {
      if (item._kind == WxSizerKind.window) {
        if (item._window == window) {
          wxLogError( "window aleady added" );
          return;
        }
      }
    }
  }

  WxSizerItem add( WxWindow window, { int proportion = 0, int flag = 0, int border = 0 } )
  {
    _testIfWindowAlreadyInList( window );
    WxSizerItem item = WxSizerItem.asWindow(window, proportion, flag, border);
    _items.add( item );
    return item;
  }

  WxSizerItem prepend( WxWindow window, { int proportion = 0, int flag = 0, int border = 0 } )
  {
    _testIfWindowAlreadyInList( window );
    WxSizerItem item = WxSizerItem.asWindow(window, proportion, flag, border);
    _items.insert( 0, item );
    return item;
  }

  WxSizerItem insert( int index, WxWindow window, { int proportion = 0, int flag = 0, int border = 0 } )
  {
    _testIfWindowAlreadyInList( window );
    WxSizerItem item = WxSizerItem.asWindow(window, proportion, flag, border);
    _items.insert( index, item );
    return item;
  }

  WxSizerItem addSizer( WxSizer sizer, { int proportion = 0, int flag = 0, int border = 0 } )
  {
    _testIfSizerAlreadyInList( sizer );
    WxSizerItem item = WxSizerItem.asSizer(sizer, proportion, flag, border);
    _items.add( item );
    return item;
  }

  WxSizerItem addSpacer( int size )
  {
    WxSizerItem item = WxSizerItem.asSpacer(size);
    _items.add( item );
    return item;
  }

  WxSizerItem addStretchSpacer( { int prop = 1 } )
  {
    WxSizerItem item = WxSizerItem.asSpacer(1);
    item._proportion = prop;
    _items.add( item );
    return item;
  }

  WxSizerItem prependSizer( WxSizer sizer, { int proportion = 0, int flag = 0, int border = 0 } )
  {
    _testIfSizerAlreadyInList( sizer );
    WxSizerItem item = WxSizerItem.asSizer(sizer, proportion, flag, border);
    _items.insert( 0, item );
    return item;
  }

  WxSizerItem prependSpacer( int size )
  {
    WxSizerItem item = WxSizerItem.asSpacer(size);
    _items.insert( 0, item );
    return item;
  }

  WxSizerItem prependStretchSpacer( { int prop = 1 } )
  {
    WxSizerItem item = WxSizerItem.asSpacer(1);
    item._proportion = prop;
    _items.insert( 0, item );
    return item;
  }

  WxSizerItem insertSizer( int index, WxSizer sizer, { int proportion = 0, int flag = 0, int border = 0 } )
  {
    _testIfSizerAlreadyInList( sizer );
    WxSizerItem item = WxSizerItem.asSizer(sizer, proportion, flag, border);
    _items.insert( index, item );
    return item;
  }

  WxSizerItem insertSpacer( int index, int size )
  {
    WxSizerItem item = WxSizerItem.asSpacer(size);
    _items.insert( index, item );
    return item;
  }

  WxSizerItem insertStretchSpacer( int index, { int prop = 1 } )
  {
    WxSizerItem item = WxSizerItem.asSpacer(1);
    item._proportion = prop;
    _items.insert( index, item );
    return item;
  }

  bool remove( int index ) {
    if ((index < 0) || (index >= _items.length)) return false;
    _items.removeAt( index );
    return true;
  }

  bool removeSizer( WxSizer sizer )
  {
    WxSizerItem? found;
    for (final item in _items) {
      if (item._kind == WxSizerKind.sizer) {
        if (item._sizer == sizer) {
          found = item;
          break;
        }
      }
    }
    if (found != null) {
      _items.remove( found );
      return true;
    }
    return false;
  }

  Widget _build( BuildContext context, WxWindow owner ) {
    return Text( 'empty WxSizer created');
  }
}
