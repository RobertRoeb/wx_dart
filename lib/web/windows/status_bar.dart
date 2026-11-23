// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01 (wxDart Web: 2026-11-15)
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
  WxStatusBarPane( { this.style = 0, this.width = -1 } );

  int style;

  /// Width in pixels, or a negative number for a proportional width
  int width;
  String text = "";
  final List<String> _stack = [];

  int getStyle() {
    return style;
  }

  int getWidth() {
    return width;
  }

  String getText() {
    return text;
  }
}

/// Represents the status bar at the bottom of a [WxFrame].
/// 
/// Usually created using [WxFrame.createStatusBar]
/// 
/// ```Dart
///    // Create status bar at the bottom of the frame
///    createStatusBar();
///    setStatusText( "Welcome to super app" );
///```

class WxStatusBar extends WxEvtHandler {
  /// Creates a status bar. Use [WxFrame.createStatusBar] instead.
  WxStatusBar( this.parent, { this.id = wxID_ANY, this.style = wxSTB_DEFAULT_STYLE } ); 

  final WxWindow parent;
  final int id;
  final int style;
  String _helpText = "";
  final List<WxStatusBarPane> _fields = [ WxStatusBarPane() ];
  bool _shown = true;

  void _update() {
    if (!_shown || parent._isDestroyed) {
      _jsStatusBarSet( parent._handle, "" );
      return;
    }
    _jsStatusBarSet( parent._handle, jsonEncode( {
      "fields": _fields.map( (f) => { "t": f.text, "w": f.width } ).toList(),
      "help": _helpText } ) );
  }

  /// Shows the help text of a menu item instead of the first field
  void _setHelpText( String help ) {
    if (_helpText == help) return;
    _helpText = help;
    _update();
  }

  /// Sets the text of a status bar field at position [index]
  void setStatusText( String text, { int index = 0 } ) {
    if (index < 0 || index >= _fields.length) return;
    _fields[index].text = text;
    _update();
  }

  /// Returns the text of the status bar. [number] indicates the field if
  /// more than one field has been created.
  String getStatusText( { int index = 0 } ) {
    if (index < 0 || index >= _fields.length) return "";
    return _fields[index].text;
  }

  /// Saves the current text of the field at [index] and shows [text].
  /// Restore the previous text with [popStatusText].
  void pushStatusText( String text, { int index = 0 } ) {
    if (index < 0 || index >= _fields.length) return;
    _fields[index]._stack.add( _fields[index].text );
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
    _update();
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
      _fields[i].width = widths[i];
    }
    _update();
  }

  /// Returns the field at [index]
  WxStatusBarPane getField( int index ) {
    return _fields[index];
  }

  /// Shows or hides the status bar
  void show( { bool show = true } ) {
    _shown = show;
    _update();
  }

  void hide() {
    show( show: false );
  }

  bool isShown() {
    return _shown;
  }
}
