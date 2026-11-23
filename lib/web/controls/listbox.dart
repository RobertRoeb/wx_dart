// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-11-15
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- EVT_LISTBOX ----------------------

const int wxLB_SORT = 0x0010;
const int wxLB_SINGLE = 0x0020;
const int wxLB_MULTIPLE = 0x0040;
const int wxLB_EXTENDED = 0x0080;
const int wxLB_ALWAYS_SB = 0x0200;
const int wxLB_NO_SB = 0x0400;
const int wxLB_HSCROLL = wxHSCROLL;

// ------------------------- wxListBox ----------------------

/// A list of strings from which the user can select one or several.
///
/// # Styles
/// | constant | meaning |
/// | -------- | -------- |
/// | wxLB_SINGLE | one item can be selected (default) |
/// | wxLB_MULTIPLE | a click toggles an item; Space toggles the focused item |
/// | wxLB_EXTENDED | Shift and Ctrl (Cmd) clicks extend the selection, as in file managers |
/// | wxLB_SORT | the items are kept sorted |
/// | wxLB_HSCROLL | long items can be scrolled horizontally instead of being cut |
/// | wxLB_ALWAYS_SB, wxLB_NO_SB | always or never show the vertical scroll bar |
///
/// # Events emitted
/// [Listbox](/wxdart/wxGetListboxEventType.html) event gets sent when the selection changes
/// (getInt(): the item clicked, isSelection(): if it is now selected)
/// | ----------------- |
/// | void bindListboxEvent( OnCommandEventFunc, int id ) |
/// | void unbindListboxEvent( int id ) |
/// [ListboxDClick](/wxdart/wxGetListboxDClickEventType.html) event gets sent when an item is double-clicked or Enter is pressed
/// | ----------------- |
/// | void bindListboxDClickEvent( OnCommandEventFunc, int id ) |
/// | void unbindListboxDClickEvent( int id ) |
class WxListBox extends WxItemContainer {
  WxListBox(super.parent, super.id,
      {super.pos = wxDefaultPosition, super.size = wxDefaultSize, List<String>? choices, super.style = 0}) {
    if (choices != null) {
      for (final str in choices) {
        _items.add(_WxItem(str));
      }
    }
    _selection = -1;
    _resort();
    _itemsChanged();
  }

  /// selected items in multiple and extended mode
  final Set<int> _selected = {};

  @override
  String get _jsKind => 'listbox';

  bool get _isMulti => hasFlag(wxLB_MULTIPLE) || hasFlag(wxLB_EXTENDED);

  int get _mode {
    int mode = 0;
    if (hasFlag(wxLB_MULTIPLE)) {
      mode |= 1;
    } else if (hasFlag(wxLB_EXTENDED)) {
      mode |= 2;
    }
    if (hasFlag(wxLB_HSCROLL)) mode |= 4;
    if (hasFlag(wxLB_ALWAYS_SB)) mode |= 8;
    if (hasFlag(wxLB_NO_SB)) mode |= 16;
    return mode;
  }

  @override
  bool _isSorted() {
    return hasFlag(wxLB_SORT);
  }

  /// Returns true if sorted
  bool isSorted() {
    return _isSorted();
  }

  // ------------------------- browser ----------------------

  List<int> _selectedList() {
    if (_isMulti) return _selected.toList()..sort();
    return _selection >= 0 ? [_selection] : [];
  }

  @override
  void _itemsChanged() {
    _jsListboxSet(_handle, jsonEncode(getStrings()), jsonEncode(_selectedList()), _selection, _mode);
    _labelOrFontChanged(); // the best width depends on the items
  }

  @override
  void _selectionChanged() {
    _jsListboxSelect(_handle, jsonEncode(_selectedList()), _selection);
  }

  /// Keeps the selection of multiple items when sorting
  @override
  void _resort() {
    if (!_isSorted()) return;
    final selectedItems = _selected.where((i) => i >= 0 && i < _items.length).map((i) => _items[i]).toList();
    super._resort();
    _selected
      ..clear()
      ..addAll(selectedItems.map((item) => _items.indexOf(item)));
  }

  // ------------------------- selection ----------------------

  /// Returns the list of selected items
  List<int> getSelections() {
    return _selectedList();
  }

  /// In a single selection list box, selects [index] (-1 deselects).
  /// In a multiple selection list box, adds [index] to the selection
  /// (-1 deselects all), as in wxWidgets.
  @override
  void setSelection(int index) {
    if (_isMulti) {
      if (index < 0) {
        _selected.clear();
      } else if (index < _items.length) {
        _selected.add(index);
      }
    }
    super.setSelection(index);
  }

  @override
  void select(int index) {
    setSelection(index);
  }

  /// Returns true if the [n]th item is selected
  bool isSelected(int n) {
    if ((n < 0) || (n >= _items.length)) return false;
    if (_isMulti) return _selected.contains(n);
    return _selection == n;
  }

  /// Deselects the [n]th item (if it was selected)
  void deselect(int n) {
    if ((n < 0) || (n >= _items.length)) return;
    if (_isMulti) {
      _selected.remove(n);
    } else if (_selection == n) {
      _selection = -1;
    }
    _selectionChanged();
  }

  void deselectAll() {
    _selected.clear();
    _selection = -1;
    _selectionChanged();
  }

  /// Returns the selected item (single selection) or the focused one
  @override
  int getSelection() {
    if (_isMulti && _selection >= 0 && !_selected.contains(_selection)) {
      return _selected.isEmpty ? -1 : (_selected.toList()..sort()).first;
    }
    return _selection;
  }

  // ------------------------- items ----------------------

  @override
  void clear() {
    _selected.clear();
    super.clear();
  }

  @override
  void delete(int index) {
    if (index < 0 || index >= _items.length) return;
    final shifted = _selected.where((i) => i != index).map((i) => i > index ? i - 1 : i).toList();
    _selected
      ..clear()
      ..addAll(shifted);
    super.delete(index);
  }

  @override
  void set(List<String> items, {List? data}) {
    _selected.clear();
    super.set(items, data: data);
  }

  @override
  void insert(String item, int pos, {dynamic data}) {
    _shiftSelection(pos, 1);
    super.insert(item, pos, data: data);
  }

  @override
  void insertList(List<String> items, int pos, {List? data}) {
    _shiftSelection(pos, items.length);
    super.insertList(items, pos, data: data);
  }

  void _shiftSelection(int pos, int count) {
    final shifted = _selected.map((i) => i >= pos ? i + count : i).toList();
    _selected
      ..clear()
      ..addAll(shifted);
  }

  // ------------------------- scrolling ----------------------

  /// Make the [n]th item the first visible item
  void setFirstItem(int n) {
    if ((n < 0) || (n >= _items.length)) return;
    _jsListboxScroll(_handle, n, true);
  }

  /// Scroll the list so that the [n]th item is visible
  void ensureVisible(int n) {
    if ((n < 0) || (n >= _items.length)) return;
    _jsListboxScroll(_handle, n, false);
  }

  /// Returns the number of items visible
  int getCountPerPage() {
    return _jsListboxPerPage(_handle);
  }

  /// Returns the top visible item. If that includes a potentially partially
  /// visible top item is implementation dependent.
  int getTopItem() {
    return _jsListboxTopItem(_handle);
  }

  // ------------------------- events ----------------------

  void _onJsListbox(int index, int current, String selectedJson) {
    final selected = (jsonDecode(selectedJson) as List).cast<int>();
    _selected
      ..clear()
      ..addAll(selected);
    _selection = _isMulti ? current : (selected.isEmpty ? -1 : selected.first);
    final event = WxCommandEvent(wxGetListboxEventType(), getId());
    event.setEventObject(this);
    event.setInt(index);
    event.setExtraLong(isSelected(index) ? 1 : 0);
    if (index >= 0 && index < _items.length) {
      event.setString(_items[index].text);
      event.setClientData(getClientData(index));
    }
    processEvent(event);
  }

  void _onJsDClick(int index) {
    if (index < 0 || index >= _items.length) return;
    final event = WxCommandEvent(wxGetListboxDClickEventType(), getId());
    event.setEventObject(this);
    event.setInt(index);
    event.setString(_items[index].text);
    event.setClientData(getClientData(index));
    processEvent(event);
  }

  @override
  bool _wantsNativeKey(int keyCode) {
    switch (keyCode) {
      case WXK_UP:
      case WXK_DOWN:
      case WXK_HOME:
      case WXK_END:
      case WXK_PAGEUP:
      case WXK_PAGEDOWN:
      case WXK_SPACE:
      case WXK_RETURN:
      case WXK_NUMPAD_ENTER:
        return true;
      default:
        return false;
    }
  }
}
