// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-11-15
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- EVT_CHOICE ----------------------

// ------------------------- wxChoice ----------------------

/// A drop-down list to choose one of several strings (HTML <select>).
/// With wxCB_SORT, the items are kept sorted.
///
/// # Events emitted
/// [Choice](/wxdart/wxGetChoiceEventType.html) event gets sent when the user selects an item
/// | ----------------- |
/// | void bindChoiceEvent( OnCommandEventFunc, int id ) |
/// | void unbindChoiceEvent( int id ) |
class WxChoice extends WxItemContainer {
  WxChoice(super.parent, super.id,
      {super.pos = wxDefaultPosition, super.size = wxDefaultSize, List<String>? choices, super.style = 0}) {
    if (choices != null) {
      for (final str in choices) {
        _items.add(_WxItem(str));
      }
    }
    _selection = _items.isEmpty ? -1 : 0;
    _resort();
    _itemsChanged();
  }

  @override
  String get _jsKind => 'choice';

  @override
  bool _isSorted() {
    return hasFlag(wxCB_SORT);
  }

  /// returns true if items are sorted by the control
  bool isSorted() {
    return _isSorted();
  }

  /// Set number of columns on platforms supporting it
  void setColumns(int cols) {}

  /// Returns number of columns
  int getColumns() {
    return 1;
  }

  @override
  void _itemsChanged() {
    _jsChoiceSetItems(_handle, jsonEncode(getStrings()), _selection);
    _labelOrFontChanged(); // the best width depends on the items
  }

  @override
  void _selectionChanged() {
    _jsChoiceSelect(_handle, _selection);
  }

  void _onJsChoice(int index) {
    _selection = index;
    final event = WxCommandEvent(wxGetChoiceEventType(), getId());
    event.setInt(index);
    event.setString(getStringSelection());
    event.setClientData(getClientData(index));
    event.setEventObject(this);
    processEvent(event);
  }
}
