// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxComboBox ----------------------

/// @nodoc

extension ComboboxEventBinder on WxEvtHandler {
  void bindComboboxEvent( OnCommandEventFunc func, int id ) {
    _eventTable.add( WxCommandEventTableEntry(wxGetComboboxEventType(), id, func));
  }

  void unbindComboboxEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetComboboxEventType(), id));
  }
}

const int wxCB_SIMPLE = 0x0004;
const int wxCB_SORT = 0x0008;
const int wxCB_READONLY = 0x0010;
const int wxCB_DROPDOWN = 0x0020;

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
/// | void bindComboboxEvent( void function( [WxCommandEvent] event ) ) |
/// | void unbindComboboxEvent() |
/// [Text](/wxdart/wxGetTextEventType.html) event gets sent when the user enters text. |
/// | ----------------- |
/// | void bindTextEvent( void function( [WxCommandEvent] event ) ) |
/// | void unbindTextEvent() |
/// [TextEnter](/wxdart/wxGetTextEnterEventType.html) event gets sent when hits enter and the wxTE_PROCESS_ENTER style is used. |
/// | ----------------- |
/// | void bindTextEnterEvent( void function( [WxCommandEvent] event ) ) |
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


class WxComboBox extends WxItemContainer {
  WxComboBox( super.parent, super.id, { String value = '', super.pos, super.size, List<String>? choices, super.style } ) 
  {
    _textEditingController = TextEditingController();
    _textEditingController.text = value;
    _lastValue = value;
    _editable = !hasFlag(wxCB_READONLY);
    _textEditingController.addListener( ()
    {
      final text = _textEditingController.text;
      if (text != _lastValue) {
          _lastValue = text;
          _sendTextEvent(text);
      }
    });

    if (choices != null) {
      for (final str in choices) {
        _items.add( _WxItem( str ) );
      }
    }
    _selection = 0;
    _resort();
  }

  late TextEditingController _textEditingController;
  int _maxLength = -1;
  String _hint = "";
  bool _editable = true;
  String _lastValue = "";


  @override
  Widget _build(BuildContext context)
  {
    final  List<DropdownMenuEntry<String>> entries = [];
    for (final item in _items) {
      entries.add( DropdownMenuEntry(value: item.text, label: item.text) );
    }

    final inToolbar = getParent() is WxToolBar;

    Widget combo = 
      DropdownMenu<String>(
        controller: _textEditingController,
        enableSearch: false,
        menuStyle: wxTheApp.isTouch() ? null : MenuStyle( 
          visualDensity: VisualDensity.compact,
          padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(EdgeInsetsGeometry.all(0)),
        ),
        trailingIcon: CustomPaint(
            size: const Size(13, 8), 
            painter: TrianglePainter( false, border: 2),
          ),
        selectedTrailingIcon: CustomPaint(
            size: const Size(13, 8), 
            painter: TrianglePainter( true, border: 2 ),
          ),
        
        inputDecorationTheme: inToolbar ? null : InputDecorationTheme( 
            isDense: !wxTheApp.isTouch(),
            filled: true,
            border: (hasFlag(wxNO_BORDER) || hasFlag(wxBORDER_SIMPLE) || hasFlag(wxBORDER_DOUBLE)) 
              ? InputBorder.none
              : UnderlineInputBorder(),
            suffixIconConstraints: BoxConstraints( minHeight: 8, minWidth: 13 ),
          ),
        onSelected: (value) {
          WxCommandEvent event = WxCommandEvent( wxGetComboboxEventType(), getId() );
          event.setEventObject( this );
          if (value != null) {
            event.setString( value );
            event.setClientData( getClientData(findString(value)) );
          }
          processEvent(event);
          
        },
        requestFocusOnTap: true,
        dropdownMenuEntries: entries
      );

      _focusNode ??= FocusNode();
      combo = Focus (
        focusNode: _focusNode,
        // autofocus: true,
        onFocusChange: (enter) => _sendFocusEvents(enter),
        onKeyEvent: hasFlag(wxTE_PROCESS_ENTER) ? (node, event)
        {
          if (event is KeyDownEvent)
          {
            if (event.logicalKey == LogicalKeyboardKey.enter) {
              WxCommandEvent event = WxCommandEvent( wxGetTextEnterEventType(), getId() );
              event.setEventObject( this );
              event.setString( _textEditingController.text );
              if (processEvent(event)) {
                return KeyEventResult.handled;      
              }
            }
          }
          return KeyEventResult.ignored;
        } : null,
        child: combo
      );

    return _buildControl( context, combo );
  }


  // distinction between the two base classes

  /// Returns true if list is empty
  bool isListEmpty( ) {
    return super.isEmpty();
  }

  /// Returns true if textfield is empty
  bool isTextEmpty( ) {
    return _textEditingController.text.isEmpty;
  }

  /// Returns current selection in list, or -1
  int getCurrentSelection() {
    return super.getSelection();
  }

  // we copy the whole damn TextEntry interface here.

  void _sendTextEvent( String text ) {
    WxCommandEvent event = WxCommandEvent( wxGetTextEventType(), getId() );
    event.setEventObject( this );
    event.setString( text );
    processEvent(event);
  }

  /// Appends [text] to text field
  void appendText( String text ) {
    String value = _textEditingController.text;
    value += text;
    _textEditingController.text = value;
  }

  /// Overwrites selection with [text]
  void writeText( String text ) {
    int pos = _textEditingController.selection.baseOffset;
    _textEditingController.text.replaceRange(pos, pos, text );
    _textEditingController.selection = TextSelection(baseOffset: pos+text.length, extentOffset: pos+text.length );
    _setState();
    _sendTextEvent( _textEditingController.text );
  }

  /// Set value of text field
  /// 
  /// same as [setValue]
  void changeValue( String text ) {
    TextEditingValue value = TextEditingValue( text: text );
    _textEditingController.value = value;
    // don't send event
  }

  void selectAll( ) {
    _textEditingController.selection = TextSelection(baseOffset: 0, extentOffset: _textEditingController.value.text.length);
    _setState();
  }

  void selectNone( ) {
    _textEditingController.selection = TextSelection(baseOffset: 0, extentOffset: 0);
    _setState();
  }

  void setTextSelection( int from, int to ) {
    _textEditingController.selection = TextSelection(baseOffset: from, extentOffset: to+1 );
    _setState();
  }

  @override
  String getStringSelection( ) {
    int from = _textEditingController.selection.start;
    int to = _textEditingController.selection.end;
    return _textEditingController.text.substring( from, to );
  }

  /// Remove text in given range
  void remove( int from, int to ) {
    _textEditingController.text.replaceRange(from, to, "" );
    _setState();
    _sendTextEvent( _textEditingController.text );
  }

  /// Remove text in given range with [value]
  void replace( int from, int to, String value ) {
    _textEditingController.text.replaceRange(from, to, value );
    _setState();
    _sendTextEvent( _textEditingController.text );
  }

  /// Sets control to being editable or not, depending on [editable]
  void setEditable( bool editable ) {
    _editable = editable;
    _setState();
  }

  /// Sets max length of text field
  void setMaxLength( int len ) {
    _maxLength = len;
    _setState();
  }

  /// Returns insertion point
  int getInsertionPoint() {
    return _textEditingController.selection.base.offset;
  }

  /// Sets insertion point to [pos]
  void setInsertionPoint( int pos ) {
    _textEditingController.selection =
      TextSelection.collapsed(offset: pos );
  }

  /// Sets insertion point to the end of the text field
  void setInsertionPointEnd( ) {
    _textEditingController.selection =
      TextSelection.collapsed(offset: _textEditingController.text.length);
  }

  /// Clears control and list
  @override
  void clear( ) {
    super.clear();
    _textEditingController.clear();
    _sendTextEvent( "" );
  }

  /// Copies selected string to clipboard
  void copy( ) {
    final text = getStringSelection();
    if (text.isEmpty) return;
    Clipboard.setData(ClipboardData(text: text ));
  }

  /// Copies selected string to clipboard and cuts it out
  void cut( ) {
    final text = getStringSelection();
    if (text.isEmpty) return;
    Clipboard.setData(ClipboardData(text: text ));
    final from = _textEditingController.selection.start;
    final to = _textEditingController.selection.end;
    _textEditingController.text.replaceRange(from, to, "" );
  }

  void paste( ) {
  }

  void redo( ) {
  }

  void undo( ) {
  }

  bool canCopy( ) {
    return getStringSelection().isNotEmpty;
  }

  bool canCut( ) {
    return getStringSelection().isNotEmpty;
  }

  bool canPaste( ) {
    return false;
  }

  bool canRedo( ) {
    return false;
  }

  bool canUndo( ) {
    return false;
  }

  /// Set value of text field
  void setValue( String value ) {
    _textEditingController.text = value;
    // _sendTextEvent( value );
  }

  /// Returns the value of the text field
  String getValue( ) {
    return _textEditingController.text;
  }

  /// Sets the hint of the text field
  void setHint( String hint ) {
    _hint = hint;
    _setState();
  }

  /// Returns hint of the text field
  String getHint( ) {
    return _hint;
  }

  /// Returns true if text field is empty
  @override  
  bool isEmpty( ) {
    return _textEditingController.text.isEmpty;
  }

  /// Returns true if text field is editable
  bool isEditable( ) {
    return _editable;
  }
}
