// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxPanel ----------------------

/// Simple container window that typically manages child windows
/// and organizes the TAB order etc.
/// 
/// Example usage: 
/// ```Dart
/// const idAbout = 100;
/// 
/// class MyPanel extends WxPanel {
///   MyPanel( super.parent, super.id ) : super( parent, id ) {
///      // Create main vertical sizer = column
///      final mainSizer = WxColumn();
///      setSizer( mainSizer );
/// 
///      // Add windows to main sizer ...
///      mainSizer.add( WxStaticText( this, -1, "This is text"), flag: wxALL, border: 5 );
///      mainSizer.add( WxStaticText( this, -1, "This is more text"), flag: wxALL, border: 5 );
///      
///      // ... and a button
///      final button = WxButton( this, -1, "Start!" );
///      mainSizer.add( button, flag: wxALL|wxALIGN_RIGHT, border 5 );
///      button.bindButtonEvent( (_) {
///        // start something
///      } );
///   }
/// }
/// 
/// // Every app needs a WxFrame as a main window.
/// class MyFrame extends WxFrame {
///   MyFrame( WxFrame? parent) : super( parent, -1, "Hello World", size: WxSize(900, 700) ) 
///   {
///     // Create a menu bar
///     final menubar = WxMenuBar();
/// 
///     // Create a menu 
///     final filemenu = WxMenu();
///     // Create a menu item with short cuts and help text
///     filemenu.appendItem( idAbout, "About\tAlt-A", help: "About Hello World" );
///     filemenu.appendSeparator();
///     filemenu.appendItem( wxID_EXIT, "Quit app\tCtrl-Q", help: "Run, baby, run!" );
///     // Attach menu to menu bar
///     menubar.append(filemenu, "File");
/// 
///     // Attach menu bar to this frame
///     setMenuBar(menubar);
/// 
///     // Create status bar at the bottom
///     createStatusBar();
///     setStatusText( "Welcome to wxDart" );
/// 
///     // Now insert our panel. As the only child of
///     // WxFrame, it will fill the entire client area
///     MyPanel( this, -1 );
/// 
///     // Bind to wxID_EXIT (which is a pre-defined ID) 
///     bindMenuEvent( (_) => close(false), wxID_EXIT );
/// 
///     // Someone requested to close.
///     bindCloseWindowEvent( (_) =>  destroy() } );
///   }
/// }
/// ```

class WxPanel extends WxWindow {
  /// Creates the panel
  WxPanel( WxWindow parent, int id, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = wxTAB_TRAVERSAL } ) 
    : super( parent, id, pos, size, style );

  /// Sets focus to this window/panel, not redirecting to its child windows as
  /// it would normally do. Not implemented in wxDart Flutter.
  void setFocusIgnoringChildren( ) {
  }

  /// Not implemented in wxDart yet
  @override
  bool acceptsFocus() {
    return false;
  }
}
