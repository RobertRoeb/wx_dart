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


/// Base class for the layout system in wxDart. You can add windows, other sizers or
/// just empty space to a sizer and they will then get layed out in a specific
/// order by the sizer. Please go to [WxBoxSizer] for a discussion of the parameters
/// and flags used.
/// 
/// All sizer handle their child items (windows, spacers or further sizers) 
/// through a list of [WxSizerItem]s in both wxDart Flutter and wxDart Native.
/// 
/// Note that all windows are owned by their parent windows (not the sizers)
/// so when you choose to remove a window from a sizer using e.g. [remove]
/// you still need to call [WxWindow.destroy] to actually delete the window
/// from the parent window.
/// 
/// Handling of child items
/// * [getItemCount]
/// * [getItem]
/// * [getSizerItem]
/// * [getWindowItem]
/// 
/// Removing (but not deleting) items
/// * [remove]
/// * [removeWindow]
/// * [removeSizer]
/// 
/// Size and position
/// * [getSize]
/// * [getPosition]
/// 
/// Adding items
/// * [add]
/// * [addSizer]
/// * [addSpacer]
/// * [addStretchSpacer]
/// * [insert]
/// * [insertSizer]
/// * [insertSpacer]
/// * [insertStretchSpacer]
/// * [prepend]
/// * [prependSizer]
/// * [prependSpacer]
/// * [prependStretchSpacer]

class WxSizer extends WxObject {
  /// This class is abstract. Do not create it directly.
  WxSizer();

  final List<WxSizerItem> _items = [];
  WxWindow? _owningWindow;

  WxPoint _position = wxDefaultPosition;
  WxSize _size = wxDefaultSize;


  /// Returns the number of sizer items (either windows,
  /// child sizers or spaces).
  int getItemCount() {
    return _items.length;
  }

  /// Returns the [WxSizerItem] at the position given by [index] or
  /// null if the index is our of bounds. 
  WxSizerItem? getItem( int index )
  {
    if ((index < 0) || (index >= _items.length)) {
      return null;
    }
    return _items[index];
  }

  /// Returns the [WxSizerItem] that holds the [window] or
  /// null if not found.
  WxSizerItem? getWindowItem( WxWindow window )
  {
    for (final item in _items) {
      if (item._kind == WxSizerKind.window) {
        if (item._window == window) {
          return item;
        }
      }
    }
    return null;
  }

  /// Returns the [WxSizerItem] that holds the [sizer] or
  /// null if not found.
  WxSizerItem? getSizerItem( WxSizer sizer )
  {
    for (final item in _items) {
      if (item._kind == WxSizerKind.sizer) {
        if (item._sizer == sizer) {
          return item;
        }
      }
    }
    return null;
  }

  /// Removes the item at the position given by [index] from the sizer. 
  /// This does not actually destroy the window if the item is a window
  /// of if the item is a sizer containing windows.
  /// Call [WxWindow.destroy] to delete the windows and
  /// remove them from the parent window.
  /// 
  /// Returns true on success.
  bool remove( int index ) {
    if ((index < 0) || (index >= _items.length)) return false;
    _items.removeAt( index );
    return true;
  }

  /// Removes the [sizer] from the sizer and deletes [sizer]
  /// This does not actually destroy the windows handled by that
  /// sizer (if any) as they are owned by the parent window and they
  /// remain child windows of that parent window until they are
  /// deleted. Call [WxWindow.destroy] to delete the windows and
  /// remove them from the parent window.
  /// 
  /// Returns true if [sizer] was found and removed.
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

  /// Removes the [window] from the sizer. This does not actually
  /// destroy the window as it is owned by the parent window and it
  /// remains a child window of that parent window until it is
  /// deleted. Call [WxWindow.destroy] to delete the window and
  /// remove it from the parent window.
  /// 
  /// Returns true if [window] was found and removed.
  bool removeWindow( WxWindow window )
  {
    WxSizerItem? found;
    for (final item in _items) {
      if (item._kind == WxSizerKind.window) {
        if (item._window == window) {
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

  /// Tells the sizer to layout its children and update the 
  /// screen.
  void layout() {
    if (_owningWindow != null) {
      _owningWindow!._setState();
    } else {
      wxTheApp._setState();
    }
  }

  void _setPositionInternal( WxPoint pos ) {
    _position = pos;
  }

  void _setSizeInternal( WxSize size ) {
    _size = size;
  }

  /// Returns the current position of this sizer on the owning
  /// window, if known already.
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

  /// Returns the current size of this sizer, if known already.
  WxSize getSize() {
    return _size;
  }

  void _testParentWindow()
  {
    if (_owningWindow == null) return;
    for (final item in _items) {
      if (item._kind == WxSizerKind.window) {
        if (item._window!.getParent() != _owningWindow) {
          wxLogError( "sizer has ${item._window!.runtimeType} owned by wrong parent window" );
          return;
        }
        else if (item._kind == WxSizerKind.sizer)
        {
          for (final subitem in item._sizer!._items) {
            if (subitem._kind == WxSizerKind.window) 
            {
              if (subitem._window!.getParent() != _owningWindow) {
                wxLogError( "sizer has ${subitem._window!.runtimeType} owned by wrong parent window" );
                return;
              }
            }
          }
        }
      }
    }
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

  /// Adds a [window] with the 
  /// given parameters that control aligment, stretch behaviour and borders.
  /// 
  /// Returns the newly created [WxSizerItem]
  WxSizerItem add( WxWindow window, { int proportion = 0, int flag = 0, int border = 0 } )
  {
    _testIfWindowAlreadyInList( window );
    WxSizerItem item = WxSizerItem._asWindow(window, proportion, flag, border);
    _items.add( item );
    _testParentWindow();
    return item;
  }

  /// Prepends a [window] with the 
  /// given parameters that control aligment, stretch behaviour and borders.
  /// 
  /// Returns the newly created [WxSizerItem]
  WxSizerItem prepend( WxWindow window, { int proportion = 0, int flag = 0, int border = 0 } )
  {
    _testIfWindowAlreadyInList( window );
    WxSizerItem item = WxSizerItem._asWindow(window, proportion, flag, border);
    _items.insert( 0, item );
    return item;
  }

  /// Inserts a [window] at the position given by [index] with the 
  /// given parameters that control aligment, stretch behaviour and borders.
  /// 
  /// Returns the newly created [WxSizerItem]
  WxSizerItem insert( int index, WxWindow window, { int proportion = 0, int flag = 0, int border = 0 } )
  {
    _testIfWindowAlreadyInList( window );
    WxSizerItem item = WxSizerItem._asWindow(window, proportion, flag, border);
    _items.insert( index, item );
    return item;
  }

  /// Adds a sizer with the given parameters that control aligment,
  /// stretch behaviour and borders.
  /// 
  /// Returns the newly created [WxSizerItem]
  WxSizerItem addSizer( WxSizer sizer, { int proportion = 0, int flag = 0, int border = 0 } )
  {
    _testIfSizerAlreadyInList( sizer );
    WxSizerItem item = WxSizerItem._asSizer(sizer, proportion, flag, border);
    _items.add( item );
    return item;
  }

  /// Adds a spacer with the given [size] 
  /// 
  /// Returns the newly created [WxSizerItem]
  WxSizerItem addSpacer( int size )
  {
    WxSizerItem item = WxSizerItem._asSpacer(size);
    _items.add( item );
    return item;
  }

  /// Adds a stretchable spacer with the given relative proportion
  /// 
  /// Returns the newly created [WxSizerItem]
  WxSizerItem addStretchSpacer( { int prop = 1 } )
  {
    WxSizerItem item = WxSizerItem._asSpacer(1);
    item._proportion = prop;
    _items.add( item );
    return item;
  }

  /// Prepends a sizer with the given parameters that control aligment,
  /// stretch behaviour and borders.
  /// 
  /// Returns the newly created [WxSizerItem]
  WxSizerItem prependSizer( WxSizer sizer, { int proportion = 0, int flag = 0, int border = 0 } )
  {
    _testIfSizerAlreadyInList( sizer );
    WxSizerItem item = WxSizerItem._asSizer(sizer, proportion, flag, border);
    _items.insert( 0, item );
    return item;
  }

  /// Prepends a spacer with the given [size] 
  /// 
  /// Returns the newly created [WxSizerItem]
  WxSizerItem prependSpacer( int size )
  {
    WxSizerItem item = WxSizerItem._asSpacer(size);
    _items.insert( 0, item );
    return item;
  }

  /// Prepends a stretchable spacer with the given relative proportion
  /// 
  /// Returns the newly created [WxSizerItem]
  WxSizerItem prependStretchSpacer( { int prop = 1 } )
  {
    WxSizerItem item = WxSizerItem._asSpacer(1);
    item._proportion = prop;
    _items.insert( 0, item );
    return item;
  }

  /// Inserts a [sizer] at the position given by [index] with the 
  /// given parameters that control aligment, stretch behaviour and borders.
  /// 
  /// Returns the newly created [WxSizerItem]
  WxSizerItem insertSizer( int index, WxSizer sizer, { int proportion = 0, int flag = 0, int border = 0 } )
  {
    _testIfSizerAlreadyInList( sizer );
    WxSizerItem item = WxSizerItem._asSizer(sizer, proportion, flag, border);
    _items.insert( index, item );
    return item;
  }

  /// Inserts a spacer with the given [size] at the position given by [index]
  /// 
  /// Returns the newly created [WxSizerItem]
  WxSizerItem insertSpacer( int index, int size )
  {
    WxSizerItem item = WxSizerItem._asSpacer(size);
    _items.insert( index, item );
    return item;
  }

  /// Inserts a stretchable spacer with the given relative proportion at [index]
  /// 
  /// Returns the newly created [WxSizerItem]
  WxSizerItem insertStretchSpacer( int index, { int prop = 1 } )
  {
    WxSizerItem item = WxSizerItem._asSpacer(1);
    item._proportion = prop;
    _items.insert( index, item );
    return item;
  }

  Widget _build( BuildContext context, WxWindow owner ) {
    return Text( 'empty WxSizer created');
  }
}
