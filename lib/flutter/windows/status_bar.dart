// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxStatusBar ----------------------

const int wxSTB_DEFAULT_STYLE = 100;

/// Helper class for a field in a [WxStatusBar]
/// 
/// Not yet wrapped in wxDart Native
/// 
class WxStatusBarPane {
  WxStatusBarPane( { int style = 0, int width = -1 } ) {
    _style = style;
    _width = width;
  }
  late final int _style;
  late int _width;
  String _text = "";
  final List<String> _stack = [];
  int getStyle() {
    return _style;
  }
  int getWidth() {
    return _width;
  }
  String getText() {
    return _text;
  }
}

/// Represents the status bar at the bottom of a [WxFrame].
/// 
/// Usually created using [WxFrame.createStatusBar]. Use
/// [setStatusWidths] to control the width if the fields.
/// 
/// In wxDart Flutter it currently does derive from [WxControl]
///
///Example usage: 
/// ```Dart
///    // Create status bar at the bottom of the frame
///    createStatusBar();
///    setStatusText( "Welcome to super app" );
///```
///
/// Main interface
/// * [setStatusText]
/// * [getStatusText]
/// * [getFieldsCount]
/// * [pushStatusText]
/// * [popStatusText]
/// * [setStatusWidths]

class WxStatusBar extends WxEvtHandler {

  // Creates a status bar. Use [WxFrame.createStatusBar] instead.
  WxStatusBar( WxWindow parent, { int id = wxID_ANY, int style = wxSTB_DEFAULT_STYLE } ) {
    _parent = parent;
    _id = id;
    _style = style;
  }
  
  late final WxWindow _parent;
  late final int _id;
  late final int _style;
  String _helpText = "";

  final List<WxStatusBarPane> _fields = [ WxStatusBarPane() ];

  void _setHelpText( String help ) {
    _helpText = help;
    _parent._setState();
  }

  /// Sets the text of a status bar field at position [index]
  void setStatusText( String text, { int index = 0 } ) {
    if ((index >= _fields.length) || (index < 0)) return;
    WxStatusBarPane pane = _fields[index];
    pane._text = text;
    _parent._setState();
  }

  /// Returns the text of the status bar. [number] indicates the field if
  /// more than one field has been created.
  String getStatusText( { int index = 0 } ) {
    if ((index >= _fields.length) || (index < 0)) return "";
    WxStatusBarPane pane = _fields[index];
    return pane._text;
  }

  /// Saves the current text of the field at [index] and shows [text].
  /// Restore the previous text with [popStatusText].
  void pushStatusText( String text, { int index = 0 } ) {
    if (index < 0 || index >= _fields.length) return;
    _fields[index]._stack.add( _fields[index]._text );
    setStatusText( text, index: index );
  }

  /// Restores the text saved by [pushStatusText]
  void popStatusText( { int index = 0 } ) {
    if (index < 0 || index >= _fields.length || _fields[index]._stack.isEmpty) return;
    setStatusText( _fields[index]._stack.removeLast(), index: index );
  }

  /// Returns the number of fields in the status bar
  int getFieldsCount() {
    return _fields.length;
  }

  /// Sets the number of fields in the status bar, optionally with their
  /// [widths] (see [setStatusWidths])
  void setFieldsCount( { int count = 1, List<int>? widths } ) {
    _fields.clear();
    for (int i = 0; i < count; i++) {
      _fields.add( WxStatusBarPane( width: (widths != null && i < widths.length) ? widths[i] : -1 ) );
    }
    _parent._setState();
  }

  /// Sets the widths of the fields: a positive number is a width in
  /// pixels, a negative one a proportion of the remaining space.
  ///
  /// ```dart
  ///   // three fields: the first gets two thirds of the remaining space,
  ///   // the second 100 pixels and the third one third
  ///   statusBar.setStatusWidths( [-2, 100, -1] );
  /// ```
  void setStatusWidths( List<int> widths ) {
    for (int i = 0; i < _fields.length && i < widths.length; i++) {
      _fields[i]._width = widths[i];
    }
    _parent._setState();
  }

  /// Returns the field at [index]
  WxStatusBarPane getField( int index ) {
    return _fields[index];
  }

  Widget _build(BuildContext context) {
    final children = <Widget>[];
    for (int i = 0; i < _fields.length; i++) {
      final field = _fields[i];
      // menu help replaces the text of the first field
      final text = (i == 0 && _helpText.isNotEmpty) ? _helpText : field._text;
      final label = Text( text, maxLines: 1, softWrap: false, overflow: TextOverflow.ellipsis );
      if (i > 0) {
        children.add( const SizedBox( width: 8 ) );
      }
      if (field._width >= 0) {
        children.add( SizedBox( width: field._width.toDouble(), child: label ) );
      } else {
        children.add( Expanded( flex: -field._width, child: label ) );
      }
    }
    return Padding(padding: EdgeInsets.fromLTRB(5, 2, 5, 2), child: Row( children: children ) );
  }
}
