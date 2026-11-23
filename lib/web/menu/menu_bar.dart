// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-11-15
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxMenuBar ----------------------

/// The menu bar of a [WxFrame], rendered by wxc.js with HTML and CSS.
///
/// The structure is sent to the browser as JSON whenever it changes
/// (coalesced during idle time); changes of enabled/checked state and
/// labels are sent item by item.
///
/// Keyboard: Alt+mnemonic opens a menu, the arrow keys navigate, Enter
/// selects and Escape closes. Accelerators ("\tCtrl-S") work while the
/// menu is closed.
class WxMenuBar extends WxEvtHandler {
  /// Creates a menubar with the given style
  /// ## Style constants
  /// | constant | meaning |
  /// | -------- | -------- |
  /// | wxMB_DOCKABLE | 0x0001 (the menu bar is dockable on platforms that allow that) |
  /// | wxMB_UNDERLINE | 0x0002 (Default: use underlined menu bar in wxDart Flutter) |
  WxMenuBar({int style = wxMB_UNDERLINE}) {
    _style = style;
  }

  final List<WxMenu> _menus = [];
  late int _style;
  WxFrame? _owner;
  bool _dirty = false;
  bool _realized = false;

  int getStyle() {
    return _style;
  }

  /// Returns the [WxFrame] the menu is attached to, if any.
  WxFrame? getFrame() {
    return _owner;
  }

  /// Returns true if menu bar is attached to a [WxFrame]
  bool isAttached() {
    return _owner != null;
  }

  /// Attaches menubar to a frame. Usually done by [WxFrame.setMenuBar].
  void attach(WxFrame frame) {
    _owner = frame;
  }

  /// Detaches menubar from the frame
  void detach() {
    _owner = null;
    _realized = false;
  }

  /// Appends the [menu] to the menubar with the given [title]
  bool append(WxMenu menu, String title) {
    _menus.add(menu);
    menu.attach(this);
    menu.setTitle(title);
    _markDirty();
    return true;
  }

  /// Inserts the [menu] to the menubar with the given [title] at position [pos]
  bool insert(int pos, WxMenu menu, String title) {
    if (pos < 0 || pos > _menus.length) pos = _menus.length;
    _menus.insert(pos, menu);
    menu.attach(this);
    menu.setTitle(title);
    _markDirty();
    return true;
  }

  /// Removes the [WxMenu] at position [pos] from the menubar and returns it, if found
  WxMenu? remove(int pos) {
    if (pos < 0 || pos >= _menus.length) return null;
    final menu = _menus.removeAt(pos);
    menu.detach();
    _markDirty();
    return menu;
  }

  WxMenu? replace(int pos, WxMenu menu, String title) {
    final old = remove(pos);
    insert(pos, menu, title);
    return old;
  }

  /// Returns the [WxMenuItem] with the given [id] from any
  /// menu or sub-menu.
  WxMenuItem? findItem(int id) {
    for (final menu in _menus) {
      final item = menu.findItem(id);
      if (item != null) return item;
    }
    return null;
  }

  /// Returns the index of the menu with the given title (without "&")
  int findMenu(String title) {
    final stripped = _wxStripMnemonic(title);
    return _menus.indexWhere((m) => m.getTitle() == stripped);
  }

  /// Gets the menu at position [index]
  WxMenu? getMenu(int index) {
    return _menus.elementAtOrNull(index);
  }

  /// Returns the number of menus
  int getMenuCount() {
    return _menus.length;
  }

  String getMenuLabel(int pos) {
    return _menus.elementAtOrNull(pos)?._rawTitle ?? "";
  }

  void setMenuLabel(int pos, String label) {
    _menus.elementAtOrNull(pos)?.setTitle(label);
  }

  /// Internal idle mechanism
  void onInternalIdle() {
    for (final menu in _menus) {
      menu._updateUI();
    }
  }

  /// Checks the checkable menu item with given [id] in any submenu or
  /// uncheck if [check] is false.
  ///
  /// Works for both radio menu items and check menu items
  void checkItem(int id, {bool check = true}) {
    findItem(id)?.check(check);
  }

  /// Enables the menu item with given [id] in any submenu or
  /// disables it if [enable] is false.
  void enableItem(int id, {bool enable = true}) {
    findItem(id)?.enable(enable);
  }

  /// Returns true if a [WxMenuItem] with the [id] is found in any submenu and is checked
  ///
  /// Works for both radio menu items and check menu items
  bool isItemChecked(int id) {
    return findItem(id)?.isChecked() ?? false;
  }

  /// Returns true if a [WxMenuItem] with the [id] is found in any submenu and is checked
  ///
  /// Works for both radio menu items and check menu items
  bool isItemEnabled(int id) {
    return findItem(id)?.isEnabled() ?? false;
  }

  void _markDirty() {
    _dirty = true;
    if (_owner != null) _scheduleIdle();
  }

  /// Sends the complete menu structure to wxc.js
  void _realize() {
    final frame = _owner;
    if (frame == null) return;
    final json = <String, Object>{
      "menus": _menus
          .map((m) => <String, Object>{"title": m._rawTitle, "items": m._toJson()})
          .toList(),
    };
    _jsSetMenuBar(frame._handle, jsonEncode(json));
    _dirty = false;
    _realized = true;
  }

  WxMenuItem? _findAccelerator(int keyCode, bool ctrl, bool alt, bool shift) {
    for (final menu in _menus) {
      final item = menu._findAccelerator(keyCode, ctrl, alt, shift);
      if (item != null) return item;
    }
    return null;
  }

  @override
  bool processEvent(WxEvent event) {
    if (super.processEvent(event)) return true;
    if (_owner != null) {
      return _owner!.processEvent(event);
    }
    return false;
  }
}
