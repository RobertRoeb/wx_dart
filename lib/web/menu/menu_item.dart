// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-11-15
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxMenuItem ----------------------

/// An entry in a [WxMenu].
///
/// The text can contain a mnemonic ("&Open") and an accelerator after a
/// tab character ("&Open...\tCtrl-O"). Supported modifiers are Ctrl, Alt,
/// Shift and Meta, separated by "-" or "+". On the web, Ctrl also matches
/// the Cmd key. Note that browsers reserve some shortcuts (e.g. Ctrl-N,
/// Ctrl-T, Ctrl-W) which never reach the page.
class WxMenuItem extends WxObject {
  WxMenuItem(WxMenu? parent,
      {int id = wxID_SEPARATOR, String text = "", this.help = "", int kind = wxITEM_NORMAL, WxMenu? subMenu}) {
    _id = id;
    _parent = parent;
    _kind = kind;
    _subMenu = subMenu;
    if (_subMenu != null) {
      _subMenu!._parentMenu = parent;
      if ((_id == wxID_SEPARATOR) || (_id == wxID_ANY)) _id = _wxNewControlId();
    } else if (_id == wxID_ANY) {
      _id = _wxNewControlId();
    } else if (_id == wxID_SEPARATOR) {
      _kind = wxITEM_SEPARATOR;
    }
    _parseText(text);
  }

  late int _id;
  late int _kind;
  WxMenu? _parent;
  WxMenu? _subMenu;
  String _label = "";
  String _text = "";
  String _shortcutText = "";
  int _accelKeyCode = WXK_NONE;
  bool _enabled = true;
  bool _isChecked = false;

  /// Accelerator modifiers and key as parsed from the text
  bool hasAlt = false;
  bool hasCtrl = false;
  bool hasShift = false;
  bool hasMeta = false;
  String key = "";

  /// Help string
  String help;

  void _parseText(String text) {
    _label = text;
    _shortcutText = "";
    key = "";
    hasAlt = hasCtrl = hasShift = hasMeta = false;
    _accelKeyCode = WXK_NONE;

    String label = text;
    final tab = label.indexOf("\t");
    String accel = "";
    if (tab >= 0) {
      accel = label.substring(tab + 1).trim();
      label = label.substring(0, tab);
    }
    _text = _wxStripMnemonic(label);
    if (accel.isEmpty) return;

    // split "Ctrl-Shift-S" or "Ctrl+-" into modifiers and key
    int sep = -1;
    for (int i = accel.length - 2; i >= 0; i--) {
      if (accel[i] == '-' || accel[i] == '+') {
        sep = i;
        break;
      }
    }
    String modifiers = "";
    key = accel;
    if (sep >= 0) {
      modifiers = accel.substring(0, sep);
      key = accel.substring(sep + 1);
    }
    final mods = modifiers.toLowerCase();
    hasCtrl = mods.contains("ctrl") || mods.contains("cmd");
    hasAlt = mods.contains("alt");
    hasShift = mods.contains("shift");
    hasMeta = mods.contains("meta");
    _accelKeyCode = _keyNameToCode(key);

    final parts = <String>[];
    if (hasCtrl) parts.add("Ctrl");
    if (hasAlt) parts.add("Alt");
    if (hasShift) parts.add("Shift");
    if (hasMeta) parts.add("Meta");
    parts.add(key.length == 1 ? key.toUpperCase() : key);
    _shortcutText = parts.join("+");
  }

  static int _keyNameToCode(String name) {
    if (name.length == 1) return name.toUpperCase().codeUnitAt(0);
    final n = name.toLowerCase();
    if (n.length > 1 && n.startsWith("f")) {
      final f = int.tryParse(n.substring(1));
      if (f != null && f >= 1 && f <= 24) return WXK_F1 + f - 1;
    }
    switch (n) {
      case "del":
      case "delete": return WXK_DELETE;
      case "ins":
      case "insert": return WXK_INSERT;
      case "back":
      case "backspace": return WXK_BACK;
      case "enter":
      case "return": return WXK_RETURN;
      case "esc":
      case "escape": return WXK_ESCAPE;
      case "tab": return WXK_TAB;
      case "space": return WXK_SPACE;
      case "home": return WXK_HOME;
      case "end": return WXK_END;
      case "pgup":
      case "pageup": return WXK_PAGEUP;
      case "pgdn":
      case "pagedown": return WXK_PAGEDOWN;
      case "left": return WXK_LEFT;
      case "right": return WXK_RIGHT;
      case "up": return WXK_UP;
      case "down": return WXK_DOWN;
      default: return WXK_NONE;
    }
  }

  bool _matchesAccelerator(int keyCode, bool ctrl, bool alt, bool shift) {
    if (_accelKeyCode == WXK_NONE || isSeparator()) return false;
    if (keyCode != _accelKeyCode) return false;
    if ((hasCtrl || hasMeta) != ctrl) return false;
    if (hasAlt != alt) return false;
    // shift is part of the key for many symbols, so only require it if asked
    if (hasShift && !shift) return false;
    return true;
  }

  /// Returns the ID
  int getId() {
    return _id;
  }

  /// Returns the item's text
  String getText() {
    return _text;
  }

  /// Returns the kind of the item
  ///
  /// ## Menu item kind constants
  /// [ constant | value |
  /// | -------- | -------- |
  /// | wxITEM_SEPARATOR | -1 |
  /// | wxITEM_NORMAL | 0 |
  /// | wxITEM_CHECK | 1 |
  /// | wxITEM_RADIO | 2 |
  int getKind() {
    return _kind;
  }

  /// Returns true if item is a sub menu
  bool isSubMenu() {
    return _subMenu != null;
  }

  /// Returns true if item is a radio item
  bool isRadio() {
    return _kind == wxITEM_RADIO;
  }

  /// Returns true if item is a check item
  bool isCheck() {
    return _kind == wxITEM_CHECK;
  }

  /// Returns true if item is a check or radio item
  bool isCheckable() {
    return (_kind == wxITEM_CHECK) || (_kind == wxITEM_RADIO);
  }

  /// Returns true if item is a menu separator (line)
  bool isSeparator() {
    return _kind == wxITEM_SEPARATOR;
  }

  /// Enable or disble menu item depending on [enable]
  void enable(bool enable) {
    if (_enabled == enable) return;
    _enabled = enable;
    _pushState();
  }

  /// Returns true if item is currently enabled
  bool isEnabled() {
    return _enabled;
  }

  /// Checks item if it is checkable (either check or radio item)
  void check(bool check) {
    if (isRadio() && check) {
      _parent?._checkRadio(this);
      return;
    }
    _setChecked(check);
  }

  void _setChecked(bool check) {
    if (_isChecked == check) return;
    _isChecked = check;
    _pushState();
  }

  /// Returns true if item has been checked (either check or radio item)
  bool isChecked() {
    return _isChecked;
  }

  /// Returns the currently associated submenu, or null, if no
  /// submenu has been associated
  WxMenu? getSubMenu() {
    return _subMenu;
  }

  /// Associated [menu] as a submenu of this item
  void setSubMenu(WxMenu menu) {
    _subMenu = menu;
    menu._parentMenu = _parent;
    _parent?._structureChanged();
  }

  /// Returns the owning menu, if already known
  WxMenu? getMenu() {
    return _parent;
  }

  /// Sets the owning menu
  void setMenu(WxMenu menu) {
    _parent = menu;
  }

  /// return the help part of the item
  String getHelp() {
    return help;
  }

  void setHelp(String text) {
    help = text;
    _parent?._structureChanged();
  }

  /// Returns entire label (with key short cuts)
  String getItemLabel() {
    return _label;
  }

  /// Returns the pure text part of the label (without key short cuts)
  String getItemLabelText() {
    return _text;
  }

  void setItemLabel(String label) {
    if (label == _label) return;
    final oldShortcut = _shortcutText;
    _parseText(label);
    if (oldShortcut != _shortcutText) {
      _parent?._structureChanged();
    } else {
      _pushState();
    }
  }

  /// Sends the current state to wxc.js if the menu is visible on the page
  void _pushState() {
    final bar = _parent?.getMenuBar();
    if (bar == null || !bar._realized || bar._dirty) return;
    _jsUpdateMenuItem(_id, _enabled, _isChecked, _text);
  }

  /// Called when the user selects the item (or presses its accelerator)
  bool _activate() {
    if (!_enabled || isSeparator() || isSubMenu()) return false;
    if (isCheck()) {
      check(!_isChecked);
    } else if (isRadio()) {
      check(true);
    }
    final event = WxCommandEvent(wxGetMenuEventType(), _id);
    event.setInt(_isChecked ? 1 : 0);
    final menu = _parent;
    if (menu == null) return false;
    event.setEventObject(menu);
    return menu.processEvent(event);
  }

  Map<String, Object> _toJson() {
    String kind;
    if (isSeparator()) {
      kind = "separator";
    } else if (isSubMenu()) {
      kind = "submenu";
    } else if (isCheck()) {
      kind = "check";
    } else if (isRadio()) {
      kind = "radio";
    } else {
      kind = "normal";
    }
    final json = <String, Object>{
      "id": _id,
      "kind": kind,
      "text": _text,
      "shortcut": _shortcutText,
      "help": help,
      "enabled": _enabled,
      "checked": _isChecked,
    };
    if (_subMenu != null) {
      json["items"] = _subMenu!._toJson();
    }
    return json;
  }
}
