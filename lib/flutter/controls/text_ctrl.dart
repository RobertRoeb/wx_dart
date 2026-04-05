// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxTextCtrl ----------------------

const int wxTE_READONLY = 0x0010;
const int wxTE_MULTILINE = 0x0020;
const int wxTE_PROCESS_TAB = 0x0040;
const int wxTE_PROCESS_ENTER = 0x0400;
const int wxTE_PASSWORD = 0x0800;

/// @nodoc

extension TextEventBinder on WxEvtHandler {
  void bindTextEvent( OnCommandEventFunc func, int id ) {
    _eventTable.add( WxCommandEventTableEntry(wxGetTextEventType(), id, func));
  }

  void unbindTextEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetTextEventType(), id));
  }
}

/// @nodoc

extension TextEventEnterBinder on WxEvtHandler {
  void bindTextEnterEvent( OnCommandEventFunc func, int id ) {
    _eventTable.add( WxCommandEventTableEntry(wxGetTextEnterEventType(), id, func));
  }

  void unbindTextEnterEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetTextEnterEventType(), id));
  }
}

/// Creates a single-line or multi-line text field.
/// 
/// Example usage for multiline text field
/// ```dart
///  final multi = WxTextCtrl(this, -1, value: 'Initial text', size: WxSize(-1, 100), style: wxTE_MULTILINE|wxTE_PROCESS_ENTER);
///
///  multi.bindTextEnterEvent((event) {
///    // user hit <ENTER>, now do something
///  },-1);
///  multi.bindTextEvent((event) {
///    final text = event.getString();
///    // do something
///  },-1);
/// ```
/// 
/// # Events emitted
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
/// | constant | value (meaning) |
/// | -------- | -------- |
/// | wxTE_READONLY | 0x0010 (Contents cannot be editted) |
/// | wxTE_MULTILINE | 0x0020 (Allow multiple lines) |
/// | wxTE_PROCESS_TAB | 0x0040 (Catch and process TAB) |
/// | wxTE_PROCESS_ENTER | 0x0400 (Catch and process ENTER) |
/// | wxTE_PASSWORD | 0x0800 (Hide content visually) |
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
/// * [isModified]
/// * [markDirty]
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
/// Multiline interface
/// * [isMultiLine]
/// * [getNumberOfLines]
/// * [getLineLength]
/// * [getLineText]
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


class WxTextCtrl extends WxTextEntry {
  /// Creates the control
  WxTextCtrl( WxWindow parent, int id, { String value = "", WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = 0 } ) 
  : super( parent, id, value: value, pos: pos, size: WxSize( size.x == -1 ? 180 : size.x , size.y ), style: style );

  bool _dirty = false;

  /// Returns true if modified by the user after a call to [setValue]
  bool isModified( ) {
    return _dirty;
  }

  /// Marks the content as modified
  /// 
  /// See [isModified]
  void markDirty() {
    _dirty = true;
  }

  /// Set the content of the control and marks it as not modified
  @override
  void setValue( String value ) {
    super.setValue( value );
    _dirty = false;
  }

  /// Returns true if this is multi-lien text control
  bool isMultiLine( ) {
    return hasFlag( wxTE_MULTILINE );
  }

  /// Returns the number of lines of text
  int getNumberOfLines( ) {
    if (!hasFlag( wxTE_MULTILINE )) return 1;
    final text = getValue();
    final parts = text.split( "\n");
    return parts.length;
  }

  /// Returns the line at position [lineNo]
  String getLineText( int lineNo ) {
    if (!hasFlag( wxTE_MULTILINE )) return getValue();
    final text = getValue();
    final parts = text.split( "\n");
    if ((lineNo < 0) || (lineNo >= parts.length)) return ""; 
    return parts[lineNo];
  }

  /// Returns the length of the line at position [lineNo]
  int getLineLength( int lineNo ) {
    final text = getValue();
    final parts = text.split( "\n");
    if ((lineNo < 0) || (lineNo >= parts.length)) return 0; 
    return parts[lineNo].length;
  }

  @override
  void _sendTextEvent( String text ) {
    WxCommandEvent event = WxCommandEvent( wxGetTextEventType(), getId() );
    event.setEventObject( this );
    event.setString( text );
    processEvent(event);
  }

  @override
  Widget _build(BuildContext context)
  {
    if (_focusNode == null)
    {
      _focusNode = FocusNode();
      _focusNode!.addListener( () {
        if (_focusNode!.hasFocus) {
            _hasFocus2 = true;
            final event = WxFocusEvent( wxGetSetFocusEventType(), getId() );
            event.setEventObject( this );
            processEvent(event);
        } else {
            _hasFocus2 = false;
            final event = WxFocusEvent( wxGetKillFocusEventType(), getId() );
            event.setEventObject( this );
            processEvent(event);
        }

      } );
    }

    Widget text = TextField(
      decoration: (hasFlag(wxNO_BORDER) || hasFlag(wxBORDER_SIMPLE) || hasFlag(wxBORDER_DOUBLE) /*|| hasFlag(wxTE_MULTILINE)*/) ? null : 
        InputDecoration(
            hintText: _hint.isEmpty ? null : _hint,
            border: wxTheApp.isTouch() ? OutlineInputBorder( borderRadius: BorderRadius.circular(8.0), ) : null,
          ),
      controller: _textEditingController,
      focusNode: _focusNode,
      textAlignVertical: TextAlignVertical.top,
      readOnly: !_editable,
      maxLines: hasFlag( wxTE_MULTILINE ) ? null : 1,
      maxLength: _maxLength == -1 ? null : _maxLength,
      expands: hasFlag( wxTE_MULTILINE ),
      obscureText: hasFlag(wxTE_PASSWORD),
      onChanged: (text) {
        _dirty = true;
        _sendTextEvent(text);
      },
      onSubmitted: hasFlag(wxTE_PROCESS_ENTER) ? (text) {
        WxCommandEvent event = WxCommandEvent( wxGetTextEnterEventType(), getId() );
        event.setEventObject( this );
        event.setString( text );
        if (!processEvent(event)) {
          WxWindow current = this;
          while (current.getParent() != null) {
            if (current.getParent() is WxDialog) {
              final dialog = current.getParent() as WxDialog;
              final action = dialog.getAffirmativeId();
              dialog._endDialog(action);
              return;
            }
            current = current.getParent()!;
          }
        }
      } : null,
    );

    
    /*final inToolbar = getParent() is WxToolBar;

    // if (!hasFlag(wxNO_BORDER) && !hasFlag(wxBORDER_SIMPLE) && !hasFlag(wxBORDER_DOUBLE) )
    
    if (inToolbar)
    {
      text = InputDecorator(
          decoration: InputDecoration(
            hintText: _hint.isEmpty ? null : _hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          child: text,
        ); 
    } */

    return _buildControl(context, text );
  }
}
