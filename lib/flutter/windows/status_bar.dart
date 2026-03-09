// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxStatusBar ----------------------

const int wxSTB_DEFAULT_STYLE = 100;

class WxStatusBarPane {
  WxStatusBarPane( { this.style = 0, this.width = -1 } );
  int style;
  int width;
  String text = "";
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

  // Creates a status bar. Use [WxFrame.createStatusBar] instead.
  WxStatusBar( this.parent, { this.id = wxID_ANY, this.style = wxSTB_DEFAULT_STYLE } ); 
  
  final WxWindow parent;
  final int id;
  final int style;

  final List<WxStatusBarPane> _fields = [ WxStatusBarPane() ];

    /// Sets the text of a status bar field at position [index]
    void setStatusText( String text, { int index = 0 } ) {
      if (index >= _fields.length) return;
      WxStatusBarPane pane = _fields[index];
      pane.text = text;
      parent._setState();
    }

    /// Returns the number of fields in the status bar
    int getFieldsCount() {
      return _fields.length;
    }

    /// Sets the number of fields in the status bar
    void setFieldsCount( { int count = 1 } ) {
      _fields.clear();
      for (int i = 0; i < count; i++) {
        _fields.add( WxStatusBarPane() );
      }
      parent._setState();
    }

  Widget _build(BuildContext context) {
    Row row = Row( children: [] ); 
    for (WxStatusBarPane field in _fields) {
      row.children.add( Expanded( flex: 1, child: Text(field.text) ) );
    }
    return Padding(padding: EdgeInsets.fromLTRB(5, 2, 5, 2), child: row );
  }
}
