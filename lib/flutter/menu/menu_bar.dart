// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxMenuBar ----------------------

/// @nodoc
class WxMenubarAnimationTimer extends WxTimer {
  WxMenubarAnimationTimer( this.owner ) : super.withOwner( owner );

  final WxRealMenuBar owner;
  int _counter = 0;

  @override
  void notify() {
    if (_counter >= 10) {
      _counter = 0;
      stop();
      return;
    }
    _counter++;
    owner._factor = _counter / 10;
    owner.refresh();
  }
}

/// @nodoc
/// 
class WxRealMenuBar extends WxWindow {
  WxRealMenuBar( WxWindow parent, this._owner ) : super( null, -1, wxDefaultPosition, WxSize(200,34), 0 ) 
  {
    bindPaintEvent(onPaint);
    bindLeaveWindowEvent( (event) {
      _hover = -1;
      refresh();
    });
    bindLeftDownEvent((event) {
      int x = _padding;
      for (final item in _owner._menus) {
        final width = getTextExtent(item.getTitle()).x;
        if ((event.getX() >= x) && (event.getX() <= x+width)) {
          final frame = _owner.getFrame();
          if (frame != null) {
            frame.popupMenu(item);
          }
          break;
        }
        x += 2*_padding + width;
      }

    });
    bindMotionEvent((event) {
      final oldhover = _hover;
      _hover = -1;
      int x = _padding;
      int count = 0;
      for (final item in _owner._menus) {
        final width = getTextExtent(item.getTitle()).x;
        if ((event.getX() >= x) && (event.getX() <= x+width)) {
          _hover = count;
          break;
        }
        x += 2*_padding + width;
        count++;
      }
      if (oldhover != _hover) {
        _factor = 0;
        if (_hover != -1) {
          _animation.start( milliseconds: 10 );
        } else {
          _animation.stop();
          _animation._counter = 0;
          refresh();
        }
      }
    });
    _animation = WxMenubarAnimationTimer( this );
  }

  void onPaint( WxPaintEvent event ) 
  {
    final size = getClientSize();
    final dc = WxPaintDC(this);
    int x = 0;
    int y = (size.y-getTextExtent("H").y) ~/2 -3;
    int count = 0;
    for (final item in _owner._menus) {
      dc.drawText(item.getTitle(), x+_padding, y );
      final width = dc.getTextExtent(item.getTitle()).x;
      dc.setPen(wxTRANSPARENT_PEN);
      if (count == _hover) {
        dc.setBrush(WxBrush( wxTheApp.getAccentColour() ));
        int animationPadding = _extraPadding*3 - (_extraPadding*4*_factor).floor();
        dc.drawRectangle(x+_padding+animationPadding, size.y-7, width-2*animationPadding, _thickness);
      } else {
        dc.setBrush(wxLIGHT_GREY_BRUSH);
        dc.drawRectangle(x+_padding+_extraPadding*3, size.y-7, width-_extraPadding*6, _thickness);
      }
      x += 2*_padding + width;
      count ++;
    }
  }

  final _padding = 12;
  final _extraPadding = 2;
  final _thickness = 3;
  int _hover = -1; 
  final WxMenuBar _owner;
  double _factor = 0.0;
  late WxMenubarAnimationTimer _animation;
}

const int wxMB_DOCKABLE = 0x0001;
const int wxMB_UNDERLINE = 0x0002;

/// Represents a menu bar. On macOS, this is usually attached
/// to the top of the screen and therefore this class is not
/// a window.
///
/// ```dart
/// // create menubar, usually in your frame's constructor
/// final menubar = WxMenuBar();
/// 
/// // create menu and add items
/// final filemenu = WxMenu();
/// filemenu.appendItem( idAbout, "About...\tAlt-A", help: "Info about wxDart 1.0" );
/// filemenu.appendSeparator();
/// filemenu.appendItem( idFileDialog, "Open file...", help: "Open file" );
/// filemenu.appendSeparator();
/// filemenu.appendItem( wxID_EXIT, "Quit app\tCtrl-Q", help: "Run, baby, run!" );
/// 
/// // attach menu to menubar
/// menubar.append(filemenu, "&File");
/// 
/// // attach to the frame
/// setMenuBar(menubar);
/// 
/// ```
/// 
/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxMB_DOCKABLE | 0x0001 (the menu bar is dockable on platforms that allow that) |
/// | wxMB_UNDERLINE | 0x0002 (use underlined menu bar in wxDart Flutter) |
/// 
/// # Event emitted
/// 
/// [Menu](/wxdart/wxGetMenuEventType.html) event gets sent when user selects a menu item |
/// | ----------------- |
/// | void bindMenuEvent( OnCommandEventFunc ) |
/// | void unbindMenuEvent() |


class WxMenuBar extends WxEvtHandler {
/// Creates a menubar with the given style
/// ## Style constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxMB_DOCKABLE | 0x0001 (the menu bar is dockable on platforms that allow that) |
/// | wxMB_UNDERLINE | 0x0002 (Default: use underlined menu bar in wxDart Flutter) |
  WxMenuBar( { int style = wxMB_UNDERLINE } ) {
    _style = style;
  }

  final List<WxMenu> _menus = [];
  late int _style;
  WxFrame? _owner;
  WxRealMenuBar ?_realMenuBar;

  /// Returns the [WxFrame] the menu is attached to, if any.
  WxFrame? getFrame() {
    return _owner;
  }

  /// Returns true if menu bar is attached to a [WxFrame]
  bool isAttached() {
    return _owner != null;
  }

  /// Attaches menubar to a frame. Usually done by [WxFrame.setMenuBar].
  void attach( WxFrame frame ) {
    _owner = frame;
    _realMenuBar = WxRealMenuBar(frame, this );
  }

  /// Detaches menubar from the frame
  void detach() {
    _owner = null;
  }

  /// Appends the [menu] to the menubar with the given [title]
  bool append( WxMenu menu, String title ) {
    _menus.add( menu );
    menu.setTitle( title );
    menu.attach( this );
    if (_owner != null) {
      _owner!._setState();
    }
    return true;
  }

  /// Inserts the [menu] to the menubar with the given [title] at position [pos]
  bool insert( int pos, WxMenu menu, String title ) {
    _menus.insert( pos, menu );
    menu.setTitle( title );
    menu.attach( this );
    if (_owner != null) {
      _owner!._setState();
    }
    return true;
  }

  /// Removes the [WxMenu] at position [pos] from the menubar and returns it, if found
  WxMenu? remove( int pos ) {
    final menu = getMenu( pos );
    if (menu != null) {
      _menus.remove(menu);
      if (_owner != null) {
        _owner!._setState();
      }
    }
    return menu;
  }

  /// Returns the [WxMenuItem] with the given [id] from any
  /// menu or sub-menu.
  WxMenuItem? findItem( int id ) {
    for (WxMenu menu in _menus) {
      for (WxMenuItem item in menu._items)
      {
        if (item.isSubMenu())
        {
          final submenu = item.getSubMenu()!;
          final subitem = submenu.findItem( id );
          if (subitem != null) {
            return subitem;
          }
        }
        if (item.id == id) {
          return item;
        }
      }
    }
    return null;
  }

  /// Gets the menu at position [index]
  WxMenu? getMenu( int index ) {
    if (index < 0) return null;
    if (index >= _menus.length) return null;
    return _menus[index];
  }

  /// Returns the number of menus
  int getMenuCount( ) {    
    return _menus.length;
  }

  /// Internal idle mechanism
  void onInternalIdle() {
    for (WxMenu menu in _menus) {
      menu.onInternalIdle();
    }
  }

  /// Checks the checkable menu item with given [id] in any submenu or
  /// uncheck if [check] is false.
  /// 
  /// Works for both radio menu items and check menu items
  void checkItem( int id, { bool check = true } ) {
    final item = findItem( id );
    if (item != null) {
      item.check( check );
    }
  }

  /// Enables the menu item with given [id] in any submenu or
  /// disables it if [enable] is false.
  void enableItem( int id, { bool enable = true } ) {
    final item = findItem( id );
    if (item != null) {
      item.enable( enable );
    }
  }

  /// Returns true if a [WxMenuItem] with the [id] is found in any submenu and is checked
  /// 
  /// Works for both radio menu items and check menu items
  bool isItemChecked( int id )
  {
    final item = findItem( id );
    if (item != null) {
      return item.isChecked();
    }
    return false;
  }

  /// Returns true if a [WxMenuItem] with the [id] is found in any submenu and is checked
  /// 
  /// Works for both radio menu items and check menu items
  bool isItemEnabled( int id )
  {
    final item = findItem( id );
    if (item != null) {
      return item.isEnabled();
    }
    return false;
  }

  void _addShortcuts( Map<ShortcutActivator, Intent> shortcuts )
  {
      final count = getMenuCount();
      for (int i = 0; i < count; i++) {
        final menu = getMenu( i );
        if (menu != null)
        {
          if (menu._accelerator != null)
          { 
            shortcuts[ SingleActivator( menu._accelerator!, alt: true)] 
              = VoidCallbackIntent(() {
                final pos = WxPoint.zero;
                theTLW!.popupMenu( menu, pos: WxPoint( pos.x+10 + i*40, pos.y+30 ) );
              });
          }
          for (final item in menu._items)
          {
            if (item._shortcut != null)
            {
              shortcuts[ SingleActivator( item._shortcut!, alt: item.hasAlt, control: item.hasCtrl )] 
                = VoidCallbackIntent(() {
                  WxCommandEvent event = WxCommandEvent( wxGetMenuEventType(), item.id );
                  if (item.isCheckable()) {
                    event.setInt( item.isChecked() ? 0 : 1 );
                  }
                  event.setEventObject( menu );
                  if (menu.processEvent( event )) {
                    if (theTLW != null) {
                      theTLW!._callRecursiveOnInternalIdle( theTLW! );
                    }
                  }
                });
            }
          }
        }
      }
  }

  Widget _build( BuildContext context, WxWindow owner ) {
      // return Text( "Where is the menu bar??" );

    if (wxTheApp.isTouch())
    {
      MenuBar bar = MenuBar(children: [] );
      for (WxMenu menu in _menus) {
        bar.children.add( SubmenuButton(menuChildren: menu._build(context, owner), child: Text(menu.getTitle())));
      }
      return bar;
    }

    if (_realMenuBar == null) {
      return Text( "Where is the menu bar??" );
    }
    return _realMenuBar!._build(context);
    /*
    fluent.MenuBar bar = fluent.MenuBar(items: [] );
    for (WxMenu menu in _menus) {
      bar.items.add( fluent.MenuBarItem( title: menu.getTitle(), items: menu.buildMenu( context, owner) ));
    }
    return bar;
    */
  }

  @override
  bool processEvent( WxEvent event  ) {
    if (_owner != null) {
      return _owner!.processEvent( event );
    }
    return false;
  }
}
