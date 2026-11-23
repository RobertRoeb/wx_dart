// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-11-15
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- EVT_CHECKBOX ----------------------

// ------------------------- wxCheckBox ----------------------

/// A check box with a label (HTML <input type="checkbox"> in a <label>).
///
/// With wxCHK_3STATE, the box can also be undetermined; with
/// wxCHK_ALLOW_3RD_STATE_FOR_USER the user can set that state, too.
///
/// # Events emitted
/// [Checkbox](/wxdart/wxGetCheckboxEventType.html) event gets sent when the user changes the state
/// | ----------------- |
/// | void bindCheckboxEvent( OnCommandEventFunc, int id ) |
/// | void unbindCheckboxEvent( int id ) |
class WxCheckBox extends WxControl {
  WxCheckBox(super.parent, super.id, String label,
      {super.pos = wxDefaultPosition, super.size = wxDefaultSize, super.style = 0}) {
    setLabel(label);
  }

  int _state = wxCHK_UNCHECKED;

  @override
  String get _jsKind => 'checkbox';

  /// Sets the label. A "&" marks the mnemonic and is not shown.
  @override
  void setLabel(String label) {
    _label = label;
    _jsSetLabel(_handle, _wxStripMnemonic(label));
    _labelOrFontChanged();
  }

  /// Returns true if controls is checked
  bool isChecked() {
    return _state == wxCHK_CHECKED;
  }

  /// checks for hasFlag(wxCHK_3STATE)
  bool is3State() {
    return hasFlag(wxCHK_3STATE);
  }

  /// checks for hasFlag(wxCHK_ALLOW_3RD_STATE_FOR_USER)
  bool is3rdStateAllowedForUser() {
    return hasFlag(wxCHK_ALLOW_3RD_STATE_FOR_USER);
  }

  int get3StateValue() {
    return _state;
  }

  /// Returns true if checked
  bool getValue() {
    return isChecked();
  }

  /// Checks or unchecks control according to [state]
  void setValue(bool state) {
    set3StateValue(state ? wxCHK_CHECKED : wxCHK_UNCHECKED);
  }

  /// Sets value of tri-state checkbox
  ///
  /// # value of [state]
  /// | constant | meaning |
  /// | -------- | -------- |
  /// | wxCHK_UNCHECKED | 0 |
  /// | wxCHK_CHECKED | 1 |
  /// | wxCHK_UNDETERMINED | 2 |
  void set3StateValue(int state) {
    if (state == wxCHK_UNDETERMINED && !is3State()) state = wxCHK_UNCHECKED;
    _state = state;
    _jsCheckSet(_handle, state);
  }

  void _onJsChange(bool checked) {
    if (is3State() && is3rdStateAllowedForUser()) {
      // unchecked -> checked -> undetermined -> unchecked
      _state = (_state + 1) % 3;
    } else {
      _state = checked ? wxCHK_CHECKED : wxCHK_UNCHECKED;
    }
    _jsCheckSet(_handle, _state);
    final event = WxCommandEvent(wxGetCheckboxEventType(), getId());
    event.setInt(_state);
    event.setEventObject(this);
    processEvent(event);
  }

  @override
  void _applyUpdateUI(WxUpdateUIEvent event) {
    super._applyUpdateUI(event);
    if (event.getSetChecked()) {
      final state = event.is3State() ? event.get3StateValue() : (event.getChecked() ? wxCHK_CHECKED : wxCHK_UNCHECKED);
      if (state != _state) set3StateValue(state);
    }
  }
}
