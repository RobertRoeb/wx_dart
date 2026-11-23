// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- EVT_MENU ----------------------

// this is a command event type

// ------------------------- wxMenuEvent ----------------------

// ------------------------- wxMenu ----------------------

/// A menu, shown as an HTML/CSS drop-down from a [WxMenuBar].
///
/// Before a menu is opened (and before a keyboard accelerator of one of
/// its items is executed), every item receives a [WxUpdateUIEvent] which
/// can be used to enable/disable or check/uncheck the item.
///
/// Selecting an item sends a menu event (a [WxCommandEvent]) that travels
/// to the [WxFrame] owning the menu bar.
class WxMenu extends WxEvtHandler {
  /// Creates menu with the given style
  ///
  /// [style] may be wxMENU_TEAROFF
  ///
  WxMenu({int style = 0});

  final List<WxMenuItem> _items = [];
  String _title = "";
  String _rawTitle = "";
  WxMenuBar? _owner;
  WxMenu? _parentMenu;
  WxWindow? _invokingWindow;

  /// Internal idle system
  void onInternalIdle() {
    _updateUI();
  }

  void _updateUI() {
    for (final item in _items) {
      if (item.isSeparator()) continue;
      if (item.isSubMenu()) {
        item.getSubMenu()!._updateUI();
      }
      final event = WxUpdateUIEvent(id: item.getId());
      event._isCheckable = item.isCheckable();
      event._isChecked = item.isChecked();
      event._isEnabled = item.isEnabled();
      event.setEventObject(this);
      processEvent(event);
      if (item.isCheckable() && event.getSetChecked()) {
        item.check(event.getChecked());
      }
      if (event.getSetEnabled()) {
        item.enable(event.getEnabled());
      }
      if (event.getSetText()) {
        item.setItemLabel(event.getText());
      }
    }
  }

  /// If used from [WxWindow.popupMenu] this gets called to contain the
  /// invoking window
  void setInvokingWindow(WxWindow window) {
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
  void attach(WxMenuBar bar) {
    _owner = bar;
  }

  /// Detaches the menu. Usually called internally.
  void detach() {
    _owner = null;
  }

  WxMenuBar? getMenuBar() {
    return _owner ?? _parentMenu?.getMenuBar();
  }

  WxMenu? getParent() {
    return _parentMenu;
  }

  /// Returns the title of the menu as set by [WxMenuBar.append]
  String getTitle() {
    return _title;
  }

  /// Gets called by [WxMenuBar.append]
  void setTitle(String newTitle) {
    _rawTitle = newTitle;
    _title = _wxStripMnemonic(newTitle);
    _structureChanged();
  }

  void _structureChanged() {
    getMenuBar()?._markDirty();
  }

  /// Returns [WxMenuItem] with the given [id] or null
  WxMenuItem? findItem(int id) {
    for (final item in _items) {
      if (item.getId() == id && !item.isSeparator()) {
        return item;
      }
      if (item.isSubMenu()) {
        final subitem = item.getSubMenu()!.findItem(id);
        if (subitem != null) {
          return subitem;
        }
      }
    }
    return null;
  }

  /// Returns the number of items in the menu
  int getMenuItemCount() {
    return _items.length;
  }

  List<WxMenuItem> getMenuItems() {
    return List<WxMenuItem>.unmodifiable(_items);
  }

  /// Returns the [WxMenuItem] at the given [position] or null
  WxMenuItem? findItemByPosition(int position) {
    return _items.elementAtOrNull(position);
  }

  WxMenuItem _add(int pos, WxMenuItem menuItem) {
    if (pos < 0 || pos > _items.length) pos = _items.length;
    _items.insert(pos, menuItem);
    menuItem.setMenu(this);
    final sub = menuItem.getSubMenu();
    if (sub != null) sub._parentMenu = this;
    _structureChanged();
    return menuItem;
  }

  /// Appends a menu item defined by the [WxMenuItem] helper class.
  /// You should not re-use that [menuItem].
  WxMenuItem append(WxMenuItem menuItem) {
    return _add(-1, menuItem);
  }

  /// Inserts a menu item defined by the [WxMenuItem] helper class at [pos]
  /// You should not re-use that [menuItem].
  WxMenuItem insert(int pos, WxMenuItem menuItem) {
    return _add(pos, menuItem);
  }

  WxMenuItem prepend(WxMenuItem menuItem) {
    return _add(0, menuItem);
  }

  /// Appends a menu item with the [id] and text [item]
  WxMenuItem appendItem(int id, String item, {String help = ""}) {
    return _add(-1, WxMenuItem(this, id: id, text: item, help: help));
  }

  /// Inserts a menu item with the [id] and text [item] at [pos]
  WxMenuItem insertItem(int pos, int id, String item, {String help = ""}) {
    return _add(pos, WxMenuItem(this, id: id, text: item, help: help));
  }

  /// Appends a checkable menu item with the [id] and text [item]
  ///
  /// Like for checkable toolbar tools (see [WxToolBar.addCheckTool]),
  /// use [WxUpdateUIEvent] to set the state of the tool.
  WxMenuItem appendCheckItem(int id, String item, {String help = ""}) {
    return _add(-1, WxMenuItem(this, id: id, text: item, help: help, kind: wxITEM_CHECK));
  }

  /// Inserts a checkable menu item with the [id] and text [item] at [pos]
  ///
  /// Like for checkable toolbar tools (see [WxToolBar.addCheckTool]),
  /// use [WxUpdateUIEvent] to set the state of the tool.
  WxMenuItem insertCheckItem(int pos, int id, String item, {String help = ""}) {
    return _add(pos, WxMenuItem(this, id: id, text: item, help: help, kind: wxITEM_CHECK));
  }

  /// Appends a radio button menu item with the [id] and text [item]
  ///
  /// Like for radio toolbar tools (see [WxToolBar.addCheckTool]),
  /// use [WxUpdateUIEvent] to set the state of the tool.
  WxMenuItem appendRadioItem(int id, String item, {String help = ""}) {
    final menuItem = WxMenuItem(this, id: id, text: item, help: help, kind: wxITEM_RADIO);
    if (_items.isEmpty || !_items.last.isRadio()) {
      menuItem._isChecked = true; // first item of a new group
    }
    return _add(-1, menuItem);
  }

  /// Inserts a radio button menu item with the [id] and text [item] at [pos]
  ///
  /// Like for radio toolbar tools (see [WxToolBar.addCheckTool]),
  /// use [WxUpdateUIEvent] to set the state of the tool.
  WxMenuItem insertRadioItem(int pos, int id, String item, {String help = ""}) {
    return _add(pos, WxMenuItem(this, id: id, text: item, help: help, kind: wxITEM_RADIO));
  }

  /// Appends the [submenu] item with the text [item]
  WxMenuItem appendSubMenu(WxMenu submenu, String item, {String help = ""}) {
    return _add(-1, WxMenuItem(this, text: item, help: help, subMenu: submenu));
  }

  /// Inserts the [submenu] menu item with the [id] and text [item] at [pos]
  WxMenuItem insertSubMenu(int pos, int id, String item, WxMenu submenu, {String help = ""}) {
    return _add(pos, WxMenuItem(this, id: id, text: item, help: help, subMenu: submenu));
  }

  /// Appends a separator line
  WxMenuItem appendSeparator() {
    return _add(-1, WxMenuItem(this, kind: wxITEM_SEPARATOR));
  }

  /// Inserts a separator line at [pos]
  WxMenuItem insertSeparator(int pos) {
    return _add(pos, WxMenuItem(this, kind: wxITEM_SEPARATOR));
  }

  /// Deletes and removes the item with the [id]
  ///
  /// This will also delete the C++ menu item in and any
  /// attached submenu wxDart Native.
  ///
  /// Returns true if found
  bool deleteItem(int id) {
    final index = _items.indexWhere((item) => item.getId() == id);
    if (index < 0) return false;
    _items.removeAt(index);
    _structureChanged();
    return true;
  }

  /// Deletes and removes the [item]
  ///
  /// This will also delete the C++ menu item in and any
  /// attached submenu wxDart Native.
  ///
  /// Returns true if found
  bool delete(WxMenuItem item) {
    final ok = _items.remove(item);
    if (ok) _structureChanged();
    return ok;
  }

  WxMenuItem? remove(WxMenuItem item) {
    return delete(item) ? item : null;
  }

  /// Enable or disable the menu item with the [id]
  void enableItem(int id, {bool enable = true}) {
    findItem(id)?.enable(enable);
  }

  void enable(int id, bool enable) {
    enableItem(id, enable: enable);
  }

  bool isEnabled(int id) {
    return findItem(id)?.isEnabled() ?? false;
  }

  void check(int id, bool check) {
    findItem(id)?.check(check);
  }

  bool isChecked(int id) {
    return findItem(id)?.isChecked() ?? false;
  }

  void setLabel(int id, String label) {
    findItem(id)?.setItemLabel(label);
  }

  String getLabel(int id) {
    return findItem(id)?.getItemLabel() ?? "";
  }

  /// Checks [item] and unchecks the other items of its radio group
  void _checkRadio(WxMenuItem item) {
    final index = _items.indexOf(item);
    if (index < 0) return;
    int start = index;
    while (start > 0 && _items[start - 1].isRadio()) {
      start--;
    }
    int end = index;
    while (end < _items.length - 1 && _items[end + 1].isRadio()) {
      end++;
    }
    for (int i = start; i <= end; i++) {
      _items[i]._setChecked(i == index);
    }
  }

  WxMenuItem? _findAccelerator(int keyCode, bool ctrl, bool alt, bool shift) {
    for (final item in _items) {
      if (item.isSubMenu()) {
        final found = item.getSubMenu()!._findAccelerator(keyCode, ctrl, alt, shift);
        if (found != null) return found;
      } else if (item._matchesAccelerator(keyCode, ctrl, alt, shift)) {
        return item;
      }
    }
    return null;
  }

  List<Object> _toJson() {
    return _items.map((item) => item._toJson()).toList();
  }

  @override
  bool processEvent(WxEvent event) {
    if (super.processEvent(event)) return true;
    if (_owner != null) {
      return _owner!.processEvent(event);
    }
    if (_parentMenu != null) {
      return _parentMenu!.processEvent(event);
    }
    if (_invokingWindow != null) {
      return _invokingWindow!.processEvent(event);
    }
    return false;
  }
}
