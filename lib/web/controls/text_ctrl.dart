// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-11-15
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- EVT_TEXT ----------------------

// ------------------------- wxTextEntry ----------------------

/// Common base of text entry controls. The text lives in the HTML
/// element; [getValue] reads it from there.
///
/// Positions are character indices; `to` is exclusive as in wxWidgets.
abstract class WxTextEntry extends WxControl {
  WxTextEntry(super.parent, super.id,
      {String value = "", super.pos = wxDefaultPosition, super.size = wxDefaultSize, super.style = 0}) {
    _editable = !hasFlag(wxTE_READONLY);
    _jsTextSet(_handle, value);
    _updateOptions();
  }

  bool _editable = true;
  int _maxLength = -1;
  String _hint = "";
  bool _modified = false;

  void _updateOptions() {
    String align = "left";
    if ((_style & wxTE_CENTRE) != 0) align = "center";
    if ((_style & wxTE_RIGHT) != 0) align = "right";
    _jsTextSetOptions(_handle, _editable, _maxLength, _hint, align, (_style & wxTE_DONTWRAP) == 0);
  }

  // ------------------------- value ----------------------

  /// Returns value of the text field
  String getValue() {
    return _jsTextGet(_handle);
  }

  /// Set the value of the test field to [value]
  void setValue(String value) {
    _jsTextSet(_handle, value);
    _modified = false;
    _sendTextEvent(value);
  }

  /// Same as [setValue]
  void changeValue(String text) {
    _jsTextSet(_handle, text);
    _modified = false;
  }

  /// Returns true if control is empty.
  bool isEmpty() {
    return getValue().isEmpty;
  }

  /// Clears the control
  void clear() {
    setValue("");
  }

  /// Append text to end of current text
  void appendText(String text) {
    final len = getLastPosition();
    _jsTextReplace(_handle, len, len, text);
    _sendTextEvent(getValue());
  }

  /// Add text at current insertion point
  void writeText(String text) {
    _jsTextReplace(_handle, -1, -1, text);
    _sendTextEvent(getValue());
  }

  /// Removes specified text
  void remove(int from, int to) {
    replace(from, to, "");
  }

  /// Replaces specified text with [value]
  void replace(int from, int to, String value) {
    _jsTextReplace(_handle, from, to, value);
    _sendTextEvent(getValue());
  }

  // ------------------------- selection ----------------------

  /// Set selection as specified
  void setSelection(int from, int to) {
    _jsTextSetSelection(_handle, from, to);
  }

  /// Selects all text
  void selectAll() {
    setSelection(-1, -1);
  }

  /// Resets selection (stop selecting anything)
  void selectNone() {
    final pos = getInsertionPoint();
    setSelection(pos, pos);
  }

  /// Returns the selection as WxPoint(from, to)
  WxPoint getSelection() {
    final r = _jsTextSelection(_handle);
    return WxPoint(r.from, r.to);
  }

  /// Returns current selection
  String getStringSelection() {
    final r = _jsTextSelection(_handle);
    final value = getValue();
    if (r.from >= r.to || r.to > value.length) return "";
    return value.substring(r.from, r.to);
  }

  /// Returns position of insertion point (cursor)
  int getInsertionPoint() {
    return _jsTextSelection(_handle).to;
  }

  /// Sets position of insertion point (cursor)
  void setInsertionPoint(int pos) {
    setSelection(pos, pos);
  }

  /// Moves position of insertion point (cursor) to the end of the text
  void setInsertionPointEnd() {
    final len = getLastPosition();
    setSelection(len, len);
  }

  int getLastPosition() {
    return getValue().length;
  }

  // ------------------------- options ----------------------

  /// Makes the control editable
  void setEditable(bool editable) {
    _editable = editable;
    _updateOptions();
  }

  /// Returns true if control is currently editable
  bool isEditable() {
    return _editable;
  }

  /// Set maximum length to [len]. Default is infinite.
  void setMaxLength(int len) {
    _maxLength = len;
    _updateOptions();
  }

  /// Set hint of the text control, of supported
  void setHint(String hint) {
    _hint = hint;
    _updateOptions();
  }

  /// Returns current hint of the control
  String getHint() {
    return _hint;
  }

  // ------------------------- clipboard and undo ----------------------

  /// Copies the selection to the clipboard
  void copy() {
    _jsTextCommand(_handle, "copy");
  }

  /// Cuts the selection and copies it to the clipboard
  void cut() {
    if (_editable) _jsTextCommand(_handle, "cut");
  }

  /// Paste from clipboard and replaces the current selection with it
  ///
  /// Pastes asynchronously (the browser may ask the user for permission)
  void paste() {
    if (_editable) _jsTextCommand(_handle, "paste");
  }

  /// Undo a change (if supported)
  void undo() {
    _jsTextCommand(_handle, "undo");
  }

  /// Redo a change that was previously undone (if supported)
  void redo() {
    _jsTextCommand(_handle, "redo");
  }

  /// Returns true if text can be copied to the clipboard.
  bool canCopy() {
    return getStringSelection().isNotEmpty;
  }

  /// Returns true if text can be copied to the clipboard and the cut.
  bool canCut() {
    return _editable && canCopy();
  }

  /// Returns true if text can be pasted from the clipboard.
  ///
  /// May incorrectly report false when the clipboard can only
  /// be queried asynchronously
  bool canPaste() {
    return _editable;
  }

  /// Returns true if undo operation is currently available
  bool canUndo() {
    return _editable;
  }

  /// Returns true if re-do operation is currently available
  bool canRedo() {
    return _editable;
  }

  // ------------------------- events ----------------------

  void _sendTextEvent(String text) {
    final event = WxCommandEvent(wxGetTextEventType(), getId());
    event.setString(text);
    event.setEventObject(this);
    processEvent(event);
  }

  /// Called when the user changed the text
  void _onJsText(String text) {
    _modified = true;
    _sendTextEvent(text);
  }

  @override
  void _applyUpdateUI(WxUpdateUIEvent event) {
    if (event.getSetEnabled() && (event.getEnabled() != isThisEnabled())) {
      enable(enable: event.getEnabled());
    }
    if (event.getSetShown() && (event.getShown() != isShown())) {
      show(show: event.getShown());
    }
    if (event.getSetText() && (event.getText() != getValue())) {
      changeValue(event.getText());
    }
  }
}

// ------------------------- wxTextCtrl ----------------------

/// A single line (HTML <input>) or multi-line (HTML <textarea>, style
/// wxTE_MULTILINE) text control.
///
/// # Styles
/// | constant | meaning |
/// | -------- | -------- |
/// | wxTE_MULTILINE | multi-line control |
/// | wxTE_PASSWORD | hides the text |
/// | wxTE_READONLY | text cannot be edited |
/// | wxTE_PROCESS_ENTER | Enter sends a text enter event (instead of pressing the default button of a dialog) |
/// | wxTE_CENTRE, wxTE_RIGHT | text alignment |
/// | wxTE_DONTWRAP | no line wrapping (multi-line only) |
///
/// # Events emitted
/// [Text](/wxdart/wxGetTextEventType.html) event gets sent when the text changes
/// | ----------------- |
/// | void bindTextEvent( OnCommandEventFunc, int id ) |
/// | void unbindTextEvent( int id ) |
/// [TextEnter](/wxdart/wxGetTextEnterEventType.html) event gets sent when Enter is pressed (with wxTE_PROCESS_ENTER)
/// | ----------------- |
/// | void bindTextEnterEvent( OnCommandEventFunc, int id ) |
/// | void unbindTextEnterEvent( int id ) |
class WxTextCtrl extends WxTextEntry {
  /// Creates the control
  WxTextCtrl(super.parent, super.id,
      {super.value = "", super.pos = wxDefaultPosition, super.size = wxDefaultSize, super.style = 0});

  @override
  String get _jsKind {
    if ((_style & wxTE_MULTILINE) != 0) return 'textarea';
    if ((_style & wxTE_PASSWORD) != 0) return 'password';
    return 'text';
  }

  /// Returns true if this is multi-lien text control
  bool isMultiLine() {
    return hasFlag(wxTE_MULTILINE);
  }

  bool isSingleLine() {
    return !isMultiLine();
  }

  /// Returns true if modified by the user after a call to [setValue]
  bool isModified() {
    return _modified;
  }

  /// Marks the content as modified
  ///
  /// See [isModified]
  void markDirty() {
    _modified = true;
  }

  void setModified(bool modified) {
    _modified = modified;
  }

  void discardEdits() {
    _modified = false;
  }

  /// Returns the number of lines of text
  int getNumberOfLines() {
    return getValue().split("\n").length;
  }

  /// Returns the line at position [lineNo]
  String getLineText(int lineNo) {
    final lines = getValue().split("\n");
    if (lineNo < 0 || lineNo >= lines.length) return "";
    return lines[lineNo];
  }

  /// Returns the length of the line at position [lineNo]
  int getLineLength(int lineNo) {
    final lines = getValue().split("\n");
    if (lineNo < 0 || lineNo >= lines.length) return -1;
    return lines[lineNo].length;
  }

  /// Returns WxPoint(column, line) of a position
  WxPoint positionToXY(int pos) {
    final value = getValue();
    if (pos < 0 || pos > value.length) return wxDefaultPosition;
    final before = value.substring(0, pos);
    final line = "\n".allMatches(before).length;
    final column = pos - (before.lastIndexOf("\n") + 1);
    return WxPoint(column, line);
  }

  int xyToPosition(int x, int y) {
    final lines = getValue().split("\n");
    if (y < 0 || y >= lines.length || x < 0 || x > lines[y].length) return -1;
    int pos = 0;
    for (int i = 0; i < y; i++) {
      pos += lines[i].length + 1;
    }
    return pos + x;
  }

  /// Sends the text enter event; returns true if it was handled
  bool _sendTextEnter() {
    final event = WxCommandEvent(wxGetTextEnterEventType(), getId());
    event.setString(getValue());
    event.setEventObject(this);
    return processEvent(event);
  }

  @override
  bool _wantsNativeKey(int keyCode) {
    // Enter inserts a new line in multi-line controls
    return isMultiLine() && ((keyCode == WXK_RETURN) || (keyCode == WXK_NUMPAD_ENTER));
  }
}
