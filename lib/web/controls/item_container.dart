// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-11-15
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------------- _WxItem -----------------------------

class _WxItem {
  _WxItem(this.text, {this.data, this.bitmap});
  String text = "";
  dynamic data;
  WxBitmap? bitmap;
}

// ------------------------- wxItemContainerImmutable ----------------------

/// Base class for controls with a fixed list of string items
/// (same API as in wxDart Flutter).
class WxItemContainerImmutable extends WxControl {
  WxItemContainerImmutable(super.parent, super.id,
      {super.pos = wxDefaultPosition, super.size = wxDefaultSize, super.style = 0});

  final List<_WxItem> _items = [];
  int _selection = -1;

  /// Called after the items changed; pushes them to the browser
  void _itemsChanged() {}

  /// Called after the selection changed
  void _selectionChanged() {}

  /// Returns the number of items in the control
  int getCount() {
    return _items.length;
  }

  /// Returns true of there are no items in the control
  bool isEmpty() {
    return _items.isEmpty;
  }

  /// Set text at position [index] to [str]
  void setString(int index, String str) {
    _items[index].text = str;
    _itemsChanged();
  }

  /// Returns text at position [index]
  String getString(int index) {
    return _items[index].text;
  }

  /// Returns all elements
  List<String> getStrings() {
    return _items.map((item) => item.text).toList();
  }

  /// Returns position of [str] in control or -1 if not found
  int findString(String str) {
    return _items.indexWhere((item) => item.text == str);
  }

  /// Set selection to item at position [index]
  ///
  /// Same as [select]
  void setSelection(int index) {
    _selection = (index >= 0 && index < _items.length) ? index : -1;
    _selectionChanged();
  }

  /// Set selection to [str]. May clear selection if not found.
  void setStringSelection(String sel) {
    setSelection(findString(sel));
  }

  /// Set selection to item at position [index],
  ///
  /// Same as [setSelection]
  void select(int index) {
    setSelection(index);
  }

  /// Returns index of current selection or -1
  int getSelection() {
    return _selection;
  }

  /// Returns text of current selection
  String getStringSelection() {
    if (_selection < 0 || _selection >= _items.length) {
      return "";
    }
    return _items[_selection].text;
  }
}

// ------------------------- wxItemContainer ----------------------

/// Base class for controls with a list of string items with optional
/// client data (same API as in wxDart Flutter).
class WxItemContainer extends WxItemContainerImmutable {
  WxItemContainer(super.parent, super.id,
      {super.pos = wxDefaultPosition, super.size = wxDefaultSize, super.style = 0});

  /// Clears the list items in the control
  void clear() {
    _items.clear();
    _selection = -1;
    _itemsChanged();
  }

  /// Delete item at [index]
  void delete(int index) {
    _items.removeAt(index);
    if (index == _selection) {
      _selection = -1;
    } else if (index < _selection) {
      _selection--;
    }
    _itemsChanged();
  }

  /// Returns client data associated with the [index] or null
  dynamic getClientData(int index) {
    if (index < 0 || index >= _items.length) return null;
    return _items[index].data;
  }

  /// Associates arbitrary client data with the item at [index]
  void setClientData(int index, dynamic data) {
    _items[index].data = data;
  }

  bool _isSorted() {
    return false;
  }

  void _resort() {
    if (!_isSorted()) return;
    final selected = (_selection >= 0 && _selection < _items.length) ? _items[_selection] : null;
    _items.sort((a, b) => a.text.compareTo(b.text));
    _selection = selected == null ? -1 : _items.indexOf(selected);
  }

  /// Set text at position [index] to [str]
  @override
  void setString(int index, String str) {
    _items[index].text = str;
    _resort();
    _itemsChanged();
  }

  /// Clears the list of elements and replaces it with a new list.
  /// Optionally, adds a list of client data to the items. The number
  /// of elements in [data] must be the same as in [items].
  void set(List<String> items, {List? data}) {
    if (data != null && items.length != data.length) {
      wxLogError("item and client data have different count");
    }
    _items.clear();
    for (int i = 0; i < items.length; i++) {
      _items.add(_WxItem(items[i], data: (data == null || i >= data.length) ? null : data[i]));
    }
    _selection = -1;
    _resort();
    _itemsChanged();
  }

  /// Appends the element [item] to the list and optionally associated
  /// the client [data] to it.
  void append(String item, {dynamic data}) {
    _items.add(_WxItem(item, data: data));
    _resort();
    _itemsChanged();
  }

  /// Appends a list of items to the control-
  /// Optionally, adds a list of client data to the items. The number
  /// of elements in [data] must be the same as in [items].
  void appendList(List<String> items, {List? data}) {
    if (data != null && items.length != data.length) {
      wxLogError("item and client data have different count");
    }
    for (int i = 0; i < items.length; i++) {
      _items.add(_WxItem(items[i], data: (data == null || i >= data.length) ? null : data[i]));
    }
    _resort();
    _itemsChanged();
  }

  /// Inserts an element at position [pos] with optional client [data].
  void insert(String item, int pos, {dynamic data}) {
    _items.insert(pos, _WxItem(item, data: data));
    if (pos <= _selection) _selection++;
    _resort();
    _itemsChanged();
  }

  /// Inserts a list of elements at position [pos] with optional client data.
  void insertList(List<String> items, int pos, {List? data}) {
    if (data != null && items.length != data.length) {
      wxLogError("item and client data have different count");
    }
    for (int i = 0; i < items.length; i++) {
      _items.insert(pos + i, _WxItem(items[i], data: (data == null || i >= data.length) ? null : data[i]));
    }
    if (pos <= _selection) _selection += items.length;
    _resort();
    _itemsChanged();
  }
}
