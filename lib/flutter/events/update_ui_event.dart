// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- WxUpdateUIEvent binders ----------------------

/// @nodoc

extension UpdateUIEventBinder on WxEvtHandler {
  void bindUpdateUIEvent( OnUpdateUIEventFunc func, int id ) {
    _eventTable.add( WxUpdateUIEventTableEntry(wxGetUpdateUIEventType(), id, func));
  }

  void unbindUpdateUIEvent( int id ) {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetUpdateUIEventType(), id) ));
  }
}

// ------------------------- WxUpdateUIEvent ----------------------

typedef OnUpdateUIEventFunc = void Function( WxUpdateUIEvent event );

/// @nodoc

class WxUpdateUIEventTableEntry extends WxEventTableEntry {
  WxUpdateUIEventTableEntry( super.eventType, super.id, this.func );
  final OnUpdateUIEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return (eventType == eventTypeTested) && ((id == wxID_ANY) || (id == idTested));
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxUpdateUIEvent) {
      func( event );
    }
  }
}
/// [UpdateUI](/docs/wxdart/wxGetUpdateUIEventType.html) event is sent in idle time to update menus and toolbars.|
/// | ----------------- |
/// | void bindUpdateUIEvent( void function( WxUpdateUIEvent event ), int id  ) |
/// | void unbindUpdateUIEvent( int id ) |
///
/// Intercept this event and call [check] if a e.g. toolbar item needs to be checked.
///
/// Main interface:
/// * [check]
/// * [enable]
/// * [show]
/// * [setText]
/// * [set3StateValue]
///
/// Example usage:
/// ```dart
///  // Somewhere in your frame 
///  final colormenu = WxMenu();
///  colormenu.appendRadioItem( idLightMode, "Light mode\tCtrl-D", help: "Can you see the light today?" );
///  colormenu.appendRadioItem( idDarkMode, "Dark mode\tCtrl-D", help: "See you on the dark side!" );
///
///  // Somewhere else in your frame 
///  final toolbar = createToolBar( style: wxTB_FLAT|wxTB_TEXT );
///  toolbar.addRadioTool( idLightMode, "Light", WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.light_mode, WxSize(32,32) ), null, shortHelp: "Light mode" );
///  toolbar.addRadioTool( idDarkMode, "Dark", WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.dark_mode, WxSize(32,32) ), null, shortHelp: "Dark mode" );
///
///   // catch the event and update toolbar and menu
///   bindUpdateUIEvent( (event) {
///      switch (event.getId()) {
///        case idDarkMode:   event.check( wxTheApp.isDark() ); return;
///        case idLightMode:  event.check( !wxTheApp.isDark() ); return;
///      } 
///    }, -1 );
///```

class WxUpdateUIEvent extends WxCommandEvent {
  WxUpdateUIEvent( { int id = 0 } ) : super( wxGetUpdateUIEventType(), id );
  
  bool _isChecked = false;
  bool _isEnabled = true;
  bool _isCheckable = false;
  bool _is3State = false;
  int _threeStateValue = 0;
  bool _isShown = true;

  bool _isSetChecked = false;
  bool _isSetEnabled = false;
  bool _setText = false;
  bool _setShown = false;

  /// Used internally. Returns true if item should be checked.
  bool getChecked( ) {
    return _isChecked;
  }

  /// Used internally. Returns true if item should be enabled.
  bool getEnabled( ) {
    return _isEnabled;
  }

  /// Returns true if item is a checkable item.
  bool isCheckable( ) {
    return _isCheckable;
  }

  /// Returns true if item is a checkable item with 3 states (on/off/indeterminate).
  bool is3State( ) {
    return _is3State;
  }

  /// Used internally. Returns the text for the item.
  String getText( ) {
    return _text;
  }

  /// Used internally. Returns true if item should be shown.
  bool getShown( ) {
    return _isShown;
  }

  /// Used internally. Returns true if [check] has been called.
  bool getSetChecked( ) {
    return _isSetChecked;
  }

  /// Used internally. Returns true if [enable] has been called.
  bool getSetEnabled( ) {
    return _isSetEnabled;
  }

  /// Used internally. Returns true if [setText] has been set.
  bool getSetShown( ) {
    return _setShown;
  }

  /// Used internally.
  bool getSetText( ) {
    return _setText;
  }

  int get3StateValue( ) {
    return _threeStateValue;
  }

  /// Call this to indicate that the UI element should be enabled
  void enable( bool enable ) {
    _isSetEnabled = true;
    _isEnabled = enable;
  }

  /// Call this to indicate that the UI element should be checked
  void check( bool check ) {
    _isSetChecked = true;
    _isChecked = check;
  }

  /// Call this to indicate that the UI element should be shown
  void show( bool show ) {
    _setShown = true;
    _isShown = show;
  }

  /// Call this to indicate that the UI element should have this text
  void setText( String text ) {
    _setText = true;
    _text = text;
  }

  /// Call this to indicate that the UI element should have this 3-state checkbox state
  void set3StateValue( int check ) {
    _threeStateValue = check;
    _is3State = true;
    _isSetChecked = true;
  }
}

