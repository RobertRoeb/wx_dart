// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------ wxTextEntry ----------------------

/// Base class for controls allowing text entry, mostly [WxTextCtrl] and [WxComboBox]
/// 
/// Setting text interface
/// * [setValue]
/// * [changeValue] (same as [setValue] in wxDart)
/// * [appendText]
/// * [writeText] (at insertion point, overwriting selection)
/// * [clear]
/// * [remove]
/// * [replace]
/// 
/// Getting value interface
/// * [getValue]
/// * [isEmpty]
/// 
/// Insertion point interface
/// * [setInsertionPoint]
/// * [getInsertionPoint]
/// * [setInsertionPointEnd]
/// 
/// Configuration
/// * [setEditable]
/// * [isEditable]
/// * [setMaxLength]
/// 
/// Hint interface
/// * [setHint]
/// * [getHint]
/// 
/// Selection interface
/// * [selectAll]
/// * [selectNone]
/// * [setSelection]
/// * [getStringSelection]
/// 
/// Clipboard/undo/redo interface
/// * [copy]
/// * [cut]
/// * [paste]
/// * [undo]
/// * [redo]
/// * [canCopy]
/// * [canCut]
/// * [canPaste]
/// * [canUndo]
/// * [canRedo]



abstract class WxTextEntry extends WxControl {

  WxTextEntry( super._parent, super._id, { String value = "", super.pos = wxDefaultPosition, super.size = wxDefaultSize, super.style = 0 } ) {
    _textEditingController = TextEditingController();
    _textEditingController.text = value;
    _editable = !hasFlag(wxTE_READONLY);
  }

  late TextEditingController _textEditingController;
  bool _editable = true;
  int _maxLength = -1;
  String _hint = "";

  /// Append text to end of current text
  void appendText( String text ) {
    String value = _textEditingController.text;
    value += text;
    _textEditingController.text = value;
  }

  /// Add text at current insertion point
  void writeText( String text ) {
    int pos = _textEditingController.selection.baseOffset;
    _textEditingController.text.replaceRange(pos, pos, text );
    _textEditingController.selection = TextSelection(baseOffset: pos+text.length, extentOffset: pos+text.length );
    _setState();
    _sendTextEvent( _textEditingController.text );
  }

  /// Same as [setValue]
  void changeValue( String text ) {
    TextEditingValue value = TextEditingValue( text: text );
    _textEditingController.value = value;
    // don't send event
  }

  /// Selects all text
  void selectAll( ) {
    _textEditingController.selection = TextSelection(baseOffset: 0, extentOffset: _textEditingController.value.text.length);
    _setState();
  }

  /// Resets selection (stop selecting anything)
  void selectNone( ) {
    _textEditingController.selection = TextSelection(baseOffset: 0, extentOffset: 0);
    _setState();
  }

  /// Set selection as specified
  void setSelection( int from, int to ) {
    _textEditingController.selection = TextSelection(baseOffset: from, extentOffset: to+1 );
    _setState();
  }

  /// Returns current selection
  String getStringSelection( ) {
    int from = _textEditingController.selection.start;
    int to = _textEditingController.selection.end;
    return _textEditingController.text.substring( from, to );
  }

  /// Removes specified text
  void remove( int from, int to ) {
    _textEditingController.text.replaceRange(from, to, "" );
    _setState();
    _sendTextEvent( _textEditingController.text );
  }

  /// Replaces specified text with [value]
  void replace( int from, int to, String value ) {
    _textEditingController.text.replaceRange(from, to, value );
    _setState();
    _sendTextEvent( _textEditingController.text );
  }

  /// Makes the control editable
  void setEditable( bool editable ) {
    _editable = editable;
    _setState();
  }

  /// Set maximum length to [len]. Default is infinite.
  void setMaxLength( int len ) {
    _maxLength = len;
    _setState();
  }

  /// Returns position of insertion point (cursor)
  int getInsertionPoint() {
    return _textEditingController.selection.base.offset;
  }

  /// Sets position of insertion point (cursor)
  void setInsertionPoint( int pos ) {
    _textEditingController.selection =
      TextSelection.collapsed(offset: pos );
  }

  /// Moves position of insertion point (cursor) to the end of the text
  void setInsertionPointEnd( ) {
    _textEditingController.selection =
      TextSelection.collapsed(offset: _textEditingController.text.length);
  }

  /// Clears the control
  void clear( ) {
    _textEditingController.clear();
    // _sendTextEvent( "" );
  }

  /// Copies the selection to the clipboard
  void copy( ) {
    final text = getStringSelection();
    if (text.isEmpty) return;
    Clipboard.setData(ClipboardData(text: text ));
  }

  /// Cuts the selection and copies it to the clipboard
  void cut( ) {
    final text = getStringSelection();
    if (text.isEmpty) return;
    Clipboard.setData(ClipboardData(text: text ));
    final from = _textEditingController.selection.start;
    final to = _textEditingController.selection.end;
    _textEditingController.text.replaceRange(from, to, "" );
  }

  /// Paste from clipboard and replaces the current selection with it
  void paste( ) {
  }

  /// Redo a change that was previously undone (if supported)
  void redo( ) {
    // TODO, add UndoHistoryController.
  }

  /// Undo a change (if supported)
  void undo( ) {
  }

  /// Returns true if text can be copied to the clipboard.
  bool canCopy( ) {
    return getStringSelection().isNotEmpty;
  }

  /// Returns true if text can be copied to the clipboard and the cut.
  bool canCut( ) {
    return getStringSelection().isNotEmpty;
  }

  /// Returns true if text can be pasted from the clipboard.
  /// 
  /// May incorrectly report false when the clipboard can only
  /// be queried asynchronously
  bool canPaste( ) {
    return false;
  }

  /// Returns true if re-do operation is currently available
  bool canRedo( ) {
    return false;
  }

  /// Returns true if undo operation is currently available
  bool canUndo( ) {
    return false;
  }

  /// Set the value of the test field to [value]
  void setValue( String value ) {
    _textEditingController.text = value;
    // _sendTextEvent( value );, no we change this in wxDart
  }

  /// Returns value of the text field
  String getValue( ) {
    return _textEditingController.text;
  }

  /// Set hint of the text control, of supported
  void setHint( String hint ) {
    _hint = hint;
    _setState();
  }

  /// Returns current hint of the control
  String getHint( ) {
    return _hint;
  }

  /// Returns true if control is empty.
  bool isEmpty( ) {
    return _textEditingController.text.isEmpty;
  }

  /// Returns true if control is currently editable
  bool isEditable( ) {
    return _editable;
  }

  void _sendTextEvent( String text ) {
  }
}
