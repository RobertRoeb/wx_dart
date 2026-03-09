// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- EVT_MENU ----------------------

// this is a command event type

/// @nodoc

extension MenuEventBinder on WxEvtHandler {
  void bindMenuEvent( OnCommandEventFunc func, int id ) {
    _eventTable.add( WxCommandEventTableEntry(wxGetMenuEventType(), id, func));
  }

  void unbindMenuEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetMenuEventType(), id));
  }
}

// ------------------------- wxMenuEvent ----------------------

typedef OnMenuEventFunc = void Function( WxMenuEvent event );

/// @nodoc

class WxMenuEventTableEntry extends WxEventTableEntry {
  WxMenuEventTableEntry( super.eventType, super.id, this.func );
  final OnMenuEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return (eventType == eventTypeTested) && ((id == wxID_ANY) || (id == idTested));
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxMenuEvent) {
      func( event );
    }
  }
}

/// @nodoc

extension MenuOpenEventBinder on WxEvtHandler {
  void bindMenuOpenEvent( OnMenuEventFunc func ) {
    _eventTable.add( WxMenuEventTableEntry(wxGetMenuOpenEventType(), -1, func));
  }
  void unbindMenuOpenEvent() {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetMenuOpenEventType(), -1));
  }
}

/// @nodoc

extension MenuCloseEventBinder on WxEvtHandler {
  void bindMenuCloseEvent( OnMenuEventFunc func ) {
    _eventTable.add( WxMenuEventTableEntry(wxGetMenuCloseEventType(), -1, func));
  }
  void unbindMenuCloseEvent() {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetMenuCloseEventType(), -1));
  }
}

/// @nodoc

extension MenuHighlightEventBinder on WxEvtHandler {
  void bindMenuHighlightEvent( OnMenuEventFunc func ) {
    _eventTable.add( WxMenuEventTableEntry(wxGetMenuHighlightEventType(), -1, func));
  }
  void unbindMenuHighlightEvent() {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetMenuHighlightEventType(), -1));
  }
}


/// Event sent when a menu appears or is closed. This is _not_ the event class
/// when a user selects a menu item - that is a [WxCommandEvent].

class WxMenuEvent extends WxEvent {
  WxMenuEvent( int type, this.menuId, { this.menu }) : super( type, 0 );

  int menuId;
  WxMenu? menu;

  /// Returns the menu that appeared or disappeard
  WxMenu? getMenu( ) {
    return menu;
  }

  /// Returns the id of the menu
  int getMenuId( ) {
    return menuId;
  }

  /// Returns true if event was sent from a popup menu
  bool isPopup( ) {
    return false;
  }
}

// ------------------------- wxMenu ----------------------

const int wxMENU_TEAROFF = 0x0001;

/// Represents a menu either attached to a [WxMenuBar] or used
/// shown as a popup menu using [WxWindow.popupMenu].
/// 
/// Please note that wxID_ABOUT and wxID_EXIT are predefined and have a special meaning. 
/// Entries using these IDs will be taken out of the normal menus under macOS and will
/// be inserted into the system menu (currently wxDart Native onle).
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
/// ```
/// 
/// # Command event emitted
/// 
/// [Menu](/wxdart/wxGetMenuEventType.html) event gets sent when user selects a menu item |
/// | ----------------- |
/// | void bindMenuEvent( OnCommandEventFunc ) |
/// | void unbindMenuEvent() |
/// 
/// # System event emitted
/// [MenuOpen](/wxdart/wxGetMenuOpenEventType.html) event gets sent when the menu opens |
/// | ----------------- |
/// | void bindMenuOpenEvent( OnMenuEventFunc ) |
/// | void unbindMenuOpenEvent() |
/// 
/// [MenuClose](/wxdart/wxGetMenuCloseEventType.html) event gets sent when the menu is closed |
/// | ----------------- |
/// | void bindMenuCloseEvent( OnMenuEventFunc ) |
/// | void unbindMenuCloseEvent() |
/// 
/// [MenuHighlight](/wxdart/wxGetMenuHighlightEventType.html) event gets sent when an item gets highlighted |
/// | ----------------- |
/// | void bindMenuHighlightEvent( OnMenuEventFunc ) |
/// | void unbindMenuHighlightEvent() |

class WxMenu extends WxEvtHandler {

/// Creates menu with the given style
/// 
/// [style] may be wxMENU_TEAROFF
/// 
  WxMenu( { int style = 0 } );

  final List<WxMenuItem> _items = [];
  String _title = "";
  WxMenuBar? _owner;
  WxWindow? _invokingWindow;
  LogicalKeyboardKey? _accelerator;

  /// Internal idle system
  void onInternalIdle() {
    for (final tool in _items) {
      final event = WxUpdateUIEvent( id: tool.getId() );
      event._isCheckable = (tool.getKind() == wxITEM_CHECK) || (tool.getKind() == wxITEM_RADIO);
      event.setEventObject( this );
      processEvent(event);
      if ((tool.getKind() == wxITEM_CHECK) || (tool.getKind() == wxITEM_RADIO)) {
        if (event.getSetChecked()) {
          if (tool.isChecked() != event.getChecked()) {
            tool.check( event.getChecked() );
          }
        }
      }
    }
  }

  /// If used from [WxWindow.popupMenu] this gets called to contain the
  /// invoking window
  void setInvokingWindow( WxWindow window ) {
    _invokingWindow = window;
  }

  /// Returns the invoking window if used with [WxWindow.popupMenu]
  WxWindow? getInvokingWindow() {
    return _invokingWindow;
  }

  /// Returns true if attached to a [WxMenuBar]
  bool isAttached() {
    return _owner != null;
  }

  /// Called from [WxMenuBar.append]
  void attach( WxMenuBar bar ) {
    _owner = bar;
  }

  /// Detaches the menu. Usually called internally.
  void detach() {
    _owner = null;
  }

  /// Returns the title of the menu as set by [WxMenuBar.append]
  String getTitle() {
    return _title;
  }

  /// Gets called by [WxMenuBar.append]
  void setTitle( String newTitle ) {
    _title = newTitle;
    final index = newTitle.indexOf("&");
    if (index != -1) {
      final accel = newTitle.substring( index+1, index+2 ).toUpperCase();
      if (index == 0) {
        _title = newTitle.substring( index+1 );
      } else {
        _title = newTitle.substring( 0, index ) + newTitle.substring( index+1 );
      }
      switch (accel) {
        // there has to be a smarter way than this
        case 'A': _accelerator = LogicalKeyboardKey.keyA; break;
        case 'B': _accelerator = LogicalKeyboardKey.keyB; break;
        case 'C': _accelerator = LogicalKeyboardKey.keyC; break;
        case 'D': _accelerator = LogicalKeyboardKey.keyD; break;
        case 'E': _accelerator = LogicalKeyboardKey.keyE; break;
        case 'F': _accelerator = LogicalKeyboardKey.keyF; break;
        case 'G': _accelerator = LogicalKeyboardKey.keyG; break;
        case 'H': _accelerator = LogicalKeyboardKey.keyH; break;
        case 'I': _accelerator = LogicalKeyboardKey.keyI; break;
        case 'J': _accelerator = LogicalKeyboardKey.keyJ; break;
        case 'K': _accelerator = LogicalKeyboardKey.keyK; break;
        case 'L': _accelerator = LogicalKeyboardKey.keyL; break;
        case 'M': _accelerator = LogicalKeyboardKey.keyM; break;
        case 'N': _accelerator = LogicalKeyboardKey.keyN; break;
        case 'O': _accelerator = LogicalKeyboardKey.keyO; break;
        case 'P': _accelerator = LogicalKeyboardKey.keyP; break;
        case 'Q': _accelerator = LogicalKeyboardKey.keyQ; break;
        case 'R': _accelerator = LogicalKeyboardKey.keyR; break;
        case 'S': _accelerator = LogicalKeyboardKey.keyS; break;
        case 'T': _accelerator = LogicalKeyboardKey.keyT; break;
        case 'U': _accelerator = LogicalKeyboardKey.keyU; break;
        case 'V': _accelerator = LogicalKeyboardKey.keyV; break;
        case 'W': _accelerator = LogicalKeyboardKey.keyW; break;
        case 'X': _accelerator = LogicalKeyboardKey.keyX; break;
        case 'Y': _accelerator = LogicalKeyboardKey.keyY; break;
        case 'Z': _accelerator = LogicalKeyboardKey.keyZ; break;
        default: _accelerator = null;
      }
    } 
  }

  /// Returns [WxMenuItem] with the given [id] or null
  WxMenuItem? findItem( int id ) {
      for (WxMenuItem item in _items)
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
    return null;
  }

  /// Returns the number of items in the menu
  int getMenuItemCount() {
    return _items.length;
  }

  /// Returns the [WxMenuItem] at the given [position] or null
  WxMenuItem? findItemByPosition( int position ) {
    return _items.elementAtOrNull(position );
  }

  /// Appends a menu item defined by the [WxMenuItem] helper class.
  /// You should not re-use that [menuItem].
  WxMenuItem append( WxMenuItem menuItem ) {
    _items.add( menuItem );
    menuItem.setMenu( this );
    return menuItem;
  }

  /// Inserts a menu item defined by the [WxMenuItem] helper class at [pos]
  /// You should not re-use that [menuItem].
  WxMenuItem insert( int pos, WxMenuItem menuItem ) {
    _items.insert( pos, menuItem );
    menuItem.setMenu( this );
    return menuItem;
  }

  /// Appends a menu item with the [id] and text [item]
  WxMenuItem appendItem( int id, String item, { String help = "" } ) {
    WxMenuItem menuItem = WxMenuItem( this, id: id, text: item, help: help );
    menuItem.setMenu( this );
    _items.add( menuItem );
    return menuItem;
  }

  /// Inserts a menu item with the [id] and text [item] at [pos]
  WxMenuItem insertItem( int pos, int id, String item, { String help = "" } ) {
    WxMenuItem menuItem = WxMenuItem( this, id: id, text: item, help: help );
    menuItem.setMenu( this );
    _items.insert( 0, menuItem );
    return menuItem;
  }

/// Appends a checkable menu item with the [id] and text [item]
/// 
/// Like for checkable toolbar tools (see [WxToolBar.addCheckTool]),
/// use [WxUpdateUIEvent] to set the state of the tool.
  WxMenuItem appendCheckItem( int id, String item, { String help = "" } ) {
    WxMenuItem menuItem = WxMenuItem( this, id: id, text: item, help: help, kind: wxITEM_CHECK );
    _items.add( menuItem );
    menuItem.setMenu( this );
    return menuItem;
  }

/// Inserts a checkable menu item with the [id] and text [item] at [pos]
/// 
/// Like for checkable toolbar tools (see [WxToolBar.addCheckTool]),
/// use [WxUpdateUIEvent] to set the state of the tool.
  WxMenuItem insertCheckItem( int id, String item, { String help = "" } ) {
    WxMenuItem menuItem = WxMenuItem( this, id: id, text: item, help: help, kind: wxITEM_CHECK );
    _items.insert( 0, menuItem );
    menuItem.setMenu( this );
    return menuItem;
  }

/// Appends a radio button menu item with the [id] and text [item]
/// 
/// Like for radio toolbar tools (see [WxToolBar.addCheckTool]),
/// use [WxUpdateUIEvent] to set the state of the tool.
  WxMenuItem appendRadioItem( int id, String item, { String help = "" } ) {
    WxMenuItem menuItem = WxMenuItem( this, id: id, text: item, help: help, kind: wxITEM_RADIO );
    _items.add( menuItem );
    menuItem.setMenu( this );
    return menuItem;
  }

/// Inserts a radio button menu item with the [id] and text [item] at [pos]
/// 
/// Like for radio toolbar tools (see [WxToolBar.addCheckTool]),
/// use [WxUpdateUIEvent] to set the state of the tool.
  WxMenuItem insertRadioItem( int pos, int id, String item, { String help = "" } ) {
    WxMenuItem menuItem = WxMenuItem( this, id: id, text: item, help: help, kind: wxITEM_RADIO );
    _items.insert( pos, menuItem );
    menuItem.setMenu( this );
    return menuItem;
  }

  /// Appends the [submenu] item with the text [item]
  WxMenuItem appendSubMenu( WxMenu submenu, String item, { String help = "" } ) {
    WxMenuItem menuItem = WxMenuItem( this, text: item, help: help, subMenu: submenu );
    _items.add( menuItem );
    menuItem.setMenu( this );
    return menuItem;
  }

  /// Inserts the [submenu] menu item with the [id] and text [item] at [pos]
  WxMenuItem insertSubMenu( int pos, int id, String item, WxMenu submenu, { String help = "" } ) {
    WxMenuItem menuItem = WxMenuItem( this, id: id, text: item, help: help, subMenu: submenu );
    _items.insert( pos, menuItem );
    menuItem.setMenu( this );
    return menuItem;
  }

  /// Appends a separator line
  WxMenuItem appendSeparator( ) {
    WxMenuItem menuItem = WxMenuItem( this, kind: wxITEM_SEPARATOR );
    _items.add( menuItem );
    menuItem.setMenu( this );
    return menuItem;
  }

  /// Inserts a separator line at [pos]
  WxMenuItem insertSeparator( int pos ) {
    WxMenuItem menuItem = WxMenuItem( this, kind: wxITEM_SEPARATOR );
    _items.insert( pos, menuItem );
    menuItem.setMenu( this );
    return menuItem;
  }

  /// Deletes and removes the item with the [id]
  /// 
  /// This will also delete the C++ menu item in and any
  /// attached submenu wxDart Native.
  /// 
  /// Returns true if found
  bool deleteItem( int id ) {
    int index = _items.indexWhere( (item) => item.id == id );
    if (index >= 0) {
      _items.removeAt(index);
      return true;
    }
    return false;
  }

  /// Deletes and removes the [item]
  /// 
  /// This will also delete the C++ menu item in and any
  /// attached submenu wxDart Native.
  /// 
  /// Returns true if found
  bool delete( WxMenuItem item ) {
    return _items.remove(item);
  }

  /// Enable or disable the menu item with the [id]
  void enableItem( int id, { bool enable = true } ) {
    int index = _items.indexWhere( (item) => item.id == id );
    if (index < 0) return;
    WxMenuItem item = _items[index];
    item._enabled = enable;
  }

  /* 
  List<fluent.MenuFlyoutItemBase> buildMenu( BuildContext context, WxWindow owner ) {
    List<fluent.MenuFlyoutItemBase> items = [];
    for (WxMenuItem item in _items) {
      if (item.kind == wxITEM_SEPARATOR) {
        items.add( fluent.MenuFlyoutSeparator() );
      } else 
      if (item.subMenu == null) {
      items.add( fluent.MenuFlyoutItem(
        text: Text( item.text ), 
        onPressed: () {
          WxCommandEvent event = WxCommandEvent( wxGetMenuItemEventType(), item.id );
          processEvent( event );
        }
        ));
      }
    }
    return items;
  }
  */

  List<PopupMenuEntry> _buildPopMenu( BuildContext context, WxWindow owner )
  {
    final List<PopupMenuEntry> flutterItems = [];

    for (final item in _items)
    {

      if (item.isSubMenu()) 
      {
        final label = SizedBox( 
          width: double.infinity,
          child: Row( 
            children: [
              SizedBox( width: 175, child: Text( item.text ) ),
              Text( ">" ),
            ])
        );

        final submenu = item.getSubMenu();
        flutterItems.add(
          PopupMenuItem(
            enabled: item.isEnabled(),
            height: wxTheApp.isTouch()
              ? kMinInteractiveDimension
              : owner.getTextExtent(item.text).y + 10.0,
            child: PopupMenuButton(
              popUpAnimationStyle: 
                wxTheApp.isTouch()
                ? null
                : AnimationStyle( duration: Duration() ),
              child: label,
              itemBuilder: (_) {
                return submenu!._buildPopMenu( context, owner ); 
              }
        ) ) );
        continue;
      }

      late Widget label;
      if (item._shortcutText.isNotEmpty)
      {
        label = SizedBox( 
          width: 150,
          child: Row( 
            children: [
              SizedBox( width: 150, child: Text( item.text ) ),
              Text( item._shortcutText ),
            ])
        );

      } else {
        label = Text( item.text );
      }
      if ((item.kind == wxITEM_NORMAL) || (item.kind == wxITEM_CHECK) || (item.kind == wxITEM_RADIO))
      {
        late Widget widget;
        if (item.kind == wxITEM_NORMAL)
        {
          if (item._bitmap != null) {
            widget = Row(
              children: [
                item._bitmap!.isOk() 
                  ? RawImage( image: item._bitmap!._image )
                  : SizedBox( width: 16 ),
                SizedBox( width: 14 ),
                label
              ]
            );
          } else {
            widget = label;
          }
        } 
        else if (item.kind == wxITEM_CHECK)
        {
          widget = Row(
            children: [
              Icon( 
                item.isChecked()
                ?  Icons.check_box
                :  Icons.check_box_outline_blank, 
              size: 16 ),
              SizedBox( width: 14 ),
              label
            ]
          );
        }
        else if (item.kind == wxITEM_RADIO)
        {
          widget = Row(
            children: [
              Icon( 
                item.isChecked()
                ? Icons.radio_button_checked
                : Icons.radio_button_unchecked, 
              size: 16 ),
              SizedBox( width: 14 ),
              label
            ]
          );
        }

        flutterItems.add(
           PopupMenuItem(
          enabled: item.isEnabled(),
          height: wxTheApp.isTouch()
             ? kMinInteractiveDimension
             : owner.getTextExtent(item.text).y + 10.0,
          onTap: () {
            final event = WxCommandEvent( wxGetMenuEventType(), item.id );
            event.setInt( item.isChecked() ? 0 : 1 );
            event.setEventObject( this ); 
            owner.processEvent(event); // or send to menu directly?
          },
          child: 
          MouseRegion(
            onEnter: (_) {
              final event = WxMenuEvent( wxGetMenuHighlightEventType(), item.id, menu: this );
              event.setEventObject( this ); 
              processEvent(event);
            },
            child: widget,
           ) ) );
      } 
      else if (item.kind == wxITEM_SEPARATOR)
      {
        flutterItems.add( PopupMenuDivider() );
      } 

    }
    return flutterItems;
  }

  List<Widget> _build( BuildContext context, WxWindow owner )
  {
    List<Widget> items = [];
    for (WxMenuItem item in _items)
    {
      if (item.isSubMenu()) 
      {
        final menu = item.getSubMenu();
        items.add( SubmenuButton(
          menuChildren: menu!._build( context, owner ),
          child: Text( item.text ),
          onOpen: () {
                final event = WxMenuEvent( wxGetMenuOpenEventType(), item.id, menu: menu );
                event.setEventObject( this ); 
                menu.processEvent(event);
          },
          onClose: () {
                final event = WxMenuEvent( wxGetMenuCloseEventType(), item.id, menu: menu );
                event.setEventObject( this ); 
                menu.processEvent(event);
          },
          onFocusChange: (value) {
            if (value) {
                final event = WxMenuEvent( wxGetMenuHighlightEventType(), item.id, menu: this );
                event.setEventObject( this ); 
                processEvent(event);
            }
          },
        ) );
        continue;
      }
      Widget? leading;
      if (item.isCheckable()) 
      {
        if (item.isChecked()) 
        {
          if (item.isRadio()) {
            leading = Icon( 
              Icons.radio_button_checked,
              size: 16
            );
          } else {
            leading = Icon( 
              Icons.check_box,
              size: 16
            );
          }
        }
        else
        {
          if (item.isRadio()) {
            leading = Icon( 
              Icons.radio_button_unchecked,
              size: 16
            );
          } else {
            leading = Icon( 
              Icons.check_box_outline_blank,
              size: 16
            );
          }
        }
      } 
      else
      if (item._bitmap != null) {
        if (item._bitmap!.isOk()) {
          leading = RawImage( image: item._bitmap!._image! );
        }
      }
      items.add( MenuItemButton(
        shortcut: item.key.isEmpty ? null : SingleActivator(_translateKeyToKey(item.key), 
           control: item.hasCtrl, meta: item.hasMeta, alt: item.hasAlt, shift: item.hasShift ),
        leadingIcon: leading,
        child: Text( item.text ),
        onFocusChange: (value) {
          if (value) {
              final event = WxMenuEvent( wxGetMenuHighlightEventType(), item.id, menu: this );
              event.setEventObject( this ); 
              processEvent(event);
          }
        },
        onPressed: () {
          WxCommandEvent event = WxCommandEvent( wxGetMenuEventType(), item.id );
          event.setInt( item.isChecked() ? 0 : 1 );
          event.setEventObject( this );
          processEvent( event );
        },
      ) );
    }
    return items;
  }

  LogicalKeyboardKey _translateKeyToKey( String key ) {
    if (key == "F1") return LogicalKeyboardKey.f1;
    if (key == "F2") return LogicalKeyboardKey.f2;
    if (key == "F3") return LogicalKeyboardKey.f3;
    if (key == "F4") return LogicalKeyboardKey.f4;
    if (key == "F5") return LogicalKeyboardKey.f5;
    if (key == "F6") return LogicalKeyboardKey.f6;
    if (key == "F7") return LogicalKeyboardKey.f7;
    if (key == "F8") return LogicalKeyboardKey.f8;
    if (key == "F9") return LogicalKeyboardKey.f9;
    if (key == "F10") return LogicalKeyboardKey.f10;
    if (key == "F11") return LogicalKeyboardKey.f11;
    if (key == "F12") return LogicalKeyboardKey.f12;
    if (key == "A") return LogicalKeyboardKey.keyA;
    if (key == "B") return LogicalKeyboardKey.keyB;
    if (key == "C") return LogicalKeyboardKey.keyC;
    if (key == "D") return LogicalKeyboardKey.keyD;
    if (key == "F") return LogicalKeyboardKey.keyE;
    if (key == "G") return LogicalKeyboardKey.keyG;
    if (key == "H") return LogicalKeyboardKey.keyH;
    if (key == "I") return LogicalKeyboardKey.keyI;
    if (key == "J") return LogicalKeyboardKey.keyJ;
    if (key == "K") return LogicalKeyboardKey.keyK;
    if (key == "L") return LogicalKeyboardKey.keyL;
    if (key == "M") return LogicalKeyboardKey.keyM;
    if (key == "N") return LogicalKeyboardKey.keyN;
    if (key == "O") return LogicalKeyboardKey.keyO;
    if (key == "P") return LogicalKeyboardKey.keyP;
    if (key == "Q") return LogicalKeyboardKey.keyQ;
    if (key == "R") return LogicalKeyboardKey.keyR;
    if (key == "S") return LogicalKeyboardKey.keyS;
    if (key == "T") return LogicalKeyboardKey.keyT;
    if (key == "U") return LogicalKeyboardKey.keyU;
    if (key == "V") return LogicalKeyboardKey.keyV;
    if (key == "W") return LogicalKeyboardKey.keyW;
    if (key == "X") return LogicalKeyboardKey.keyX;
    if (key == "Y") return LogicalKeyboardKey.keyY;
    if (key == "Z") return LogicalKeyboardKey.keyZ;

    if (key == "Del") return LogicalKeyboardKey.delete;
    if (key == "Delete") return LogicalKeyboardKey.delete;
    if (key == "Back") return LogicalKeyboardKey.backspace;
    if (key == "Enter") return LogicalKeyboardKey.enter;
    if (key == "Return") return LogicalKeyboardKey.delete;
    if (key == "Cancel") return LogicalKeyboardKey.cancel;
    if (key == "Left") return LogicalKeyboardKey.arrowLeft;
    if (key == "Right") return LogicalKeyboardKey.arrowRight;
    if (key == "Up") return LogicalKeyboardKey.arrowUp;
    if (key == "Down") return LogicalKeyboardKey.arrowDown;
    // more to come

    return LogicalKeyboardKey.f1;
  }

  @override
  bool processEvent( WxEvent event  ) {
    if (_owner != null) {
      return _owner!.processEvent( event );
    }
    return false;
  }

}
