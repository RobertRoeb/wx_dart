// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxMenuItem ----------------------

/// Small helper class when creating menus
/// 
/// Instances of this class get returned when adding items to a menu
/// ([WxMenu.append]), but you don't usually need to keep them. 
/// However, you can keep them to enable or disable or otherwise
/// change a menu item after its initial creation.
/// 
/// You create a [WxMenuItem] directly and use [WxMenu.appendItem] but
/// you must not re-use the item instance for the next menu item. There
/// is no copy-on-write.

class WxMenuItem extends WxObject {
  WxMenuItem( WxMenu? parent, { int id = wxID_SEPARATOR, String text="", this.help = "", int kind = wxITEM_NORMAL, WxMenu? subMenu } )
  {
    _id = id;
    if (_id == wxID_ANY) {
      _id = _wxNewControlId();
    }
    _text = text;
    _label = _text;
    _subMenu = subMenu;
    _parent = parent;
    _kind = kind;
    int indexOfAnd = text.indexOf("&");
    if (indexOfAnd >= 0) {
      text = "${text.substring(0,indexOfAnd)}${text.substring(indexOfAnd+1,text.length)}";
    }
    int indexOfT = text.indexOf("\t");
    if (indexOfT >= 0) {
      _shortcutText = text.substring(indexOfT+1,text.length);
      text = text.substring( 0, indexOfT );
    }
    if (_shortcutText.isEmpty) return;

    key = _shortcutText;
    String modifier = "";
    if (_shortcutText.isNotEmpty) {
      int indexOfDash = _shortcutText.indexOf("-");
      if (indexOfDash < 0) {
        indexOfDash = _shortcutText.indexOf("+");
      }
      if (indexOfDash >= 0) {
        modifier = _shortcutText.substring(0,indexOfDash);
        key = _shortcutText.substring(indexOfDash+1,_shortcutText.length);
      }
    }
    if (_parent != null) {
      _shortcut = _parent!._translateKeyToKey(key);
    }
    hasAlt = modifier.contains("Alt");
    hasCtrl = modifier.contains("Ctrl");
    hasMeta = modifier.contains("Meta");
    hasShift = modifier.contains("Shift");
  }
 
  late int _kind;
  WxMenu? _parent;
  WxMenu? _subMenu;
  late int _id;
  late String _text;
  String _label = "";
  bool hasAlt = false;
  bool hasCtrl = false;
  bool hasShift = false;
  bool hasMeta = false;
  String key = "";
  String help;
  bool _enabled = true;
  WxBitmapBundle? _bundle;
  WxBitmap? _bitmap;
  bool _isChecked = false;
  LogicalKeyboardKey? _shortcut;
  String _shortcutText = "";

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
    return isRadio() || isCheck();
  }

  /// Returns true if item is a menu separator (line)
  bool isSeparator() {
    return _kind == wxITEM_SEPARATOR;
  }

  /// Enable or disble menu item depending on [enable]
  void enable( bool enable ) {
    _enabled = enable;
  }

  /// Returns true if item is currently enabled
  bool isEnabled() {
    return _enabled;
  }

  /// Checks item if it is checkable (either check or radio item)
  void check( bool check ) {
    _isChecked = check;
  }
  /// Returns true if item has been checked (either check or radio item)
  bool isChecked() {
    return _isChecked;
  }

  /// Sets the bitmap for this item
  void setBitmap( WxBitmapBundle bitmap ) {
    _bundle = bitmap;
    if (theTLW != null) {
      _bitmap = _bundle!.getBitmapFor(theTLW!);
    }
  }

  /// Returns the currently associated submenu, or null, if no
  /// submenu has been associated
  WxMenu? getSubMenu() {
    return _subMenu;
  }

  /// Associated [menu] as a submenu of this item
  void setSubMenu( WxMenu menu ) {
    _subMenu = menu;
  }
  /// Returns the owning menu, if already known
  WxMenu? getMenu() {
    return _parent;
  }

  /// Sets the owning menu
  void setMenu( WxMenu menu ) {
    _parent = menu;
  }

  /// return the help part of the item
  String getHelp() {
    return help;
  }

  /// Returns entire label (with key short cuts)
  String getItemLabel() {
    return _label;
  }

  /// Returns the pure text part of the label (without key short cuts)
  String getItemLabelText() {
    return _text;
  }
}
