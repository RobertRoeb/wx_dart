// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01 (wxDart Web: 2026-11-15)
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- EVT_COMBOBOX ----------------------

// ------------------------- wxComboBox ----------------------

/// Offers the user a choice of items and an addtional text field.
/// 
/// Example usage:
///```dart
///    // Create the control
///    final combo = WxComboBox( parent, -1, choices: ['Choice #1','Choice #2','Choice #3'], size: WxSize(200, -1) );
/// 
///    // bind to event when user selects an item from the drop down menu
///    combo.bindComboboxEvent((event) {
///      final index = event.getInt();
///      final text = event.getString();
///    }, -1 );
/// 
///    // bind to event when user types in the text field
///    combo.bindTextEvent((event) {
///      final text = event.getString();
///    }, -1 );
///```
/// 
/// # Events emitted
/// [Combobox](/wxdart/wxGetComboboxEventType.html) event gets sent when the user selects an item from the drop down. |
/// | ----------------- |
/// | void bindComboboxEvent( void function( [WxCommandEvent] event ), int id ) |
/// | void unbindComboboxEvent() |
/// [Text](/wxdart/wxGetTextEventType.html) event gets sent when the user enters text. |
/// | ----------------- |
/// | void bindTextEvent( void function( [WxCommandEvent] event ), int id ) |
/// | void unbindTextEvent() |
/// [TextEnter](/wxdart/wxGetTextEnterEventType.html) event gets sent when hits enter and the wxTE_PROCESS_ENTER style is used. |
/// | ----------------- |
/// | void bindTextEnterEvent( void function( [WxCommandEvent] event ), int id ) |
/// | void unbindTextEnterEvent() |
/// 
/// # Window styles
/// [ constant | meaning |
/// | -------- | -------- |
/// | wxCB_SIMPLE | 0x0004 |
/// | wxCB_SORT | 0x0008 |
/// | wxCB_READONLY | 0x0010 |
/// | wxCB_DROPDOWN | 0x0020 |
/// | wxTE_PROCESS_ENTER | 0x0400 |
///
/// Main iten list interface
/// * [getCount]
/// * [isEmpty]
/// * [setString]
/// * [getString]
/// * [getStrings]
/// * [findString]
/// 
/// Item selection interface
/// * [setSelection]
/// * [getCurrentSelection]
/// * [select] same as [setSelection]
/// * [setStringSelection]
/// 
/// Items interface
/// * [clear]
/// * [delete]
/// * [set]
/// * [append]
/// * [appendList]
/// * [insert]
/// * [insertList]
/// 
/// Item client data interface
/// * [setClientData]
/// * [getClientData]
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
/// Getting text field value interface
/// * [getValue]
/// * [isTextEmpty]
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
/// Text field selection interface
/// * [selectAll]
/// * [selectNone]
/// * [setTextSelection]
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

class WxComboBox extends WxItemContainer {

  /// Creates a combobox control with an initial [value] in the text field and [choices] as a drop down list
  WxComboBox( super.parent, super.id, { String value = '', super.pos, super.size, List<String>? choices, super.style } ) 
  {
    _editable = !hasFlag(wxCB_READONLY);
    if (choices != null) {
      for (final str in choices) {
        _items.add( _WxItem( str ) );
      }
    }
    _resort();
    _selection = _items.indexWhere( (item) => item.text == value );
    _jsTextSet( _handle, value );
    _itemsChanged();
    _updateOptions();
  }

  int _maxLength = -1;
  String _hint = "";
  bool _editable = true;

  @override
  String get _jsKind => 'combobox';

  @override
  bool _isSorted() {
    return hasFlag(wxCB_SORT);
  }

  @override
  WxSize _doGetBestSize() {
    // wide enough for the longest item
    int width = 60;
    final font = getFont()._css();
    for (final item in _items) {
      width = max( width, _jsMeasureText( font, item.text ).w.ceil() );
    }
    return WxSize( width + (_hasBitmaps() ? 70 : 46), 28 );
  }

  bool _hasBitmaps() => _items.any( (item) => item.bitmap != null );

  @override
  void _itemsChanged() {
    final list = <Map<String, Object>>[];
    for (final item in _items) {
      final bitmap = item.bitmap;
      list.add( { "t": item.text, "i": bitmap?._handle ?? 0,
        "bw": bitmap == null ? 0 : (bitmap.getWidth() / bitmap.getScaleFactor()).round(),
        "bh": bitmap == null ? 0 : (bitmap.getHeight() / bitmap.getScaleFactor()).round() } );
    }
    _jsComboSetItems( _handle, jsonEncode( list ), _selection, !_editable );
    _labelOrFontChanged();
  }

  @override
  void _selectionChanged() {
    if (_selection >= 0) _jsTextSet( _handle, _items[_selection].text );
    _jsComboSelect( _handle, _selection );
  }

  @override
  bool _wantsNativeKey( int keyCode ) {
    return keyCode == WXK_UP || keyCode == WXK_DOWN || keyCode == WXK_LEFT || keyCode == WXK_RIGHT;
  }

  void _onJsCombo( int index ) {
    _selection = index;
    _jsTextSet( _handle, _items[index].text );
    _jsComboSelect( _handle, index );
    final event = WxCommandEvent( wxGetComboboxEventType(), getId() );
    event.setEventObject( this );
    event.setInt( index );
    event.setString( _items[index].text );
    event.setClientData( getClientData( index ) );
    processEvent( event );
  }

  void _onJsText( String text ) {
    // typing deselects unless the text matches an item
    _selection = _items.indexWhere( (item) => item.text == text );
    _jsComboSelect( _handle, _selection );
    _sendTextEvent( text );
  }

  // distinction between the two base classes
  /// Returns true if list is empty
  bool isListEmpty( ) {
    return super.isEmpty();
  }

  /// Returns true if textfield is empty
  bool isTextEmpty( ) {
    return getValue().isEmpty;
  }

  /// Returns current selection in list, or -1
  int getCurrentSelection() {
    return super.getSelection();
  }

  // the text entry interface
  void _sendTextEvent( String text ) {
    WxCommandEvent event = WxCommandEvent( wxGetTextEventType(), getId() );
    event.setEventObject( this );
    event.setString( text );
    processEvent(event);
  }

  void _updateOptions() {
    _jsTextSetOptions( _handle, _editable, _maxLength, _hint, "left", true );
  }

  /// Appends [text] to text field
  void appendText( String text ) {
    final len = getValue().length;
    _jsTextReplace( _handle, len, len, text );
    _sendTextEvent( getValue() );
  }

  /// Overwrites selection with [text]
  void writeText( String text ) {
    _jsTextReplace( _handle, -1, -1, text );
    _sendTextEvent( getValue() );
  }

  /// Set value of text field
  ///
  /// same as [setValue]
  void changeValue( String text ) {
    _jsTextSet( _handle, text );
  }

  void selectAll( ) {
    _jsTextSetSelection( _handle, -1, -1 );
  }

  void selectNone( ) {
    final pos = getInsertionPoint();
    _jsTextSetSelection( _handle, pos, pos );
  }

  /// Sets selection in text field
  void setTextSelection( int from, int to ) {
    _jsTextSetSelection( _handle, from, to );
  }

  /// Returns the selected text in the text field
  @override
  String getStringSelection( ) {
    final r = _jsTextSelection( _handle );
    final value = getValue();
    if (r.from >= r.to || r.to > value.length) return "";
    return value.substring( r.from, r.to );
  }

  /// Removes text in given range
  void remove( int from, int to ) {
    replace( from, to, "" );
  }

  /// Removes text in given range with [value]
  void replace( int from, int to, String value ) {
    _jsTextReplace( _handle, from, to, value );
    _sendTextEvent( getValue() );
  }

  /// Sets control to being editable or not, depending on [editable]
  void setEditable( bool editable ) {
    _editable = editable;
    _updateOptions();
    _itemsChanged();
  }

  /// Sets max length of text field
  void setMaxLength( int len ) {
    _maxLength = len;
    _updateOptions();
  }

  /// Returns insertion point
  int getInsertionPoint() {
    return _jsTextSelection( _handle ).to;
  }

  /// Sets insertion point to [pos]
  void setInsertionPoint( int pos ) {
    _jsTextSetSelection( _handle, pos, pos );
  }

  /// Sets insertion point to the end of the text field
  void setInsertionPointEnd( ) {
    final len = getValue().length;
    _jsTextSetSelection( _handle, len, len );
  }

  int getLastPosition() {
    return getValue().length;
  }

  /// Clears control and list
  @override
  void clear( ) {
    super.clear();
    _jsTextSet( _handle, "" );
    _sendTextEvent( "" );
  }

  /// Copies selected string to clipboard
  void copy( ) {
    _jsTextCommand( _handle, "copy" );
  }

  /// Copies selected string to clipboard and cuts it out
  void cut( ) {
    if (_editable) _jsTextCommand( _handle, "cut" );
  }

  void paste( ) {
    if (_editable) _jsTextCommand( _handle, "paste" );
  }

  void redo( ) {
    _jsTextCommand( _handle, "redo" );
  }

  void undo( ) {
    _jsTextCommand( _handle, "undo" );
  }

  bool canCopy( ) {
    return getStringSelection().isNotEmpty;
  }

  bool canCut( ) {
    return _editable && canCopy();
  }

  bool canPaste( ) {
    return _editable;
  }

  bool canRedo( ) {
    return _editable;
  }

  bool canUndo( ) {
    return _editable;
  }

  /// Set value of text field
  void setValue( String value ) {
    _jsTextSet( _handle, value );
    _selection = _items.indexWhere( (item) => item.text == value );
    _jsComboSelect( _handle, _selection );
    _sendTextEvent( value );
  }

  /// Returns the value of the text field
  String getValue( ) {
    return _jsTextGet( _handle );
  }

  /// Sets the hint of the text field
  void setHint( String hint ) {
    _hint = hint;
    _updateOptions();
  }

  /// Returns hint of the text field
  String getHint( ) {
    return _hint;
  }

  /// Returns true if text field is empty
  @override
  bool isEmpty( ) {
    return getValue().isEmpty;
  }

  /// Returns true if text field is editable
  bool isEditable( ) {
    return _editable;
  }

  /// Opens the list
  void popup( ) {
    setFocus();
    _jsComboOpen( _handle );
  }

  /// Closes the list
  void dismiss( ) {
    _jsComboClose( _handle );
  }
}
