// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- WxKeyEvent bindings ------------------------

/// @nodoc

extension KeyDownEventBinder on WxEvtHandler {
  void bindKeyDownEvent( OnKeyEventFunc func ) {
    _eventTable.add( WxKeyEventTableEntry(wxGetKeyDownEventType(), -1, func));
  }

  void unbindKeyDownEvent() {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetKeyDownEventType(), -1) ));
  }
}

/// @nodoc

extension KeyUpEventBinder on WxEvtHandler {
  void bindKeyUpEvent( OnKeyEventFunc func ) {
    _eventTable.add( WxKeyEventTableEntry(wxGetKeyUpEventType(), -1, func));
  }

  void unbindKeyUpEvent() {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetKeyUpEventType(), -1) ));
  }
}

/// @nodoc

extension CharEventBinder on WxEvtHandler {
  void bindCharEvent( OnKeyEventFunc func ) {
    _eventTable.add( WxKeyEventTableEntry(wxGetCharEventType(), -1, func));
  }

  void unbindCharEvent() {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetCharEventType(), -1) ));
  }
}

/// @nodoc

extension CharHookEventBinder on WxEvtHandler {
  void bindCharHookEvent( OnKeyEventFunc func ) {
    _eventTable.add( WxKeyEventTableEntry(wxGetCharHookEventType(), -1, func));
  }

  void unbindCharHookEvent() {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetCharHookEventType(), -1) ));
  }
}

// ------------------------- wxKeyEvent ----------------------

typedef OnKeyEventFunc = void Function( WxKeyEvent event );

/// @nodoc

class WxKeyEventTableEntry extends WxEventTableEntry {
  WxKeyEventTableEntry( super.eventType, super.id, this.func );
  final OnKeyEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return eventType == eventTypeTested;
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxKeyEvent) {
      func( event );
    }
  }
}

/// Event sent out for keyboard key events.
/// 
/// Example usage:
/// ```dart
/// // Derive new class from WxWindow
/// class MyWindow extends WxWindow {
/// 
///   MyWindow( WxWindow parent, int id ) : super( parent, id, wxDefaultPosition, wxDefaultSize, 0 )
///   {
///     // Bind to key down event
///     bindKeyDownEvent( onKeyDown );
/// 
///     // Bind to key up event
///     bindKeyUpEvent( onKeyUp );
///   }
/// 
///   // define key down event handler
///   void onKeyDown( WxKeyEvent event )
///   {
///     switch (event.getKeyode()) {
///       case WXK_ENTER: doSomething(); break;
///       default: break;
///     }
///   }
/// 
///   // define key up event handler
///   void onKeyUp( WxKeyEvent event )
///   {
///     switch (event.getKeyode()) {
///       case WXK_ENTER: doSomethingElse(); break;
///       default: break;
///     }
///   }
/// }
/// ```
/// 
/// Events:
/// [KeyDown](/wxdart/wxGetKeyDownEventType.html) event gets sent when the user hits a key. |
/// | ----------------- |
/// | void bindKeyDownEvent( void function( [WxKeyEvent] event ) ) |
/// | void unbindKeyDownEvent() |
/// 
/// [KeyUp](/wxdart/wxGetKeyUpEventType.html) event gets sent when the user releases a key. |
/// | ----------------- |
/// | void bindKeyUpEvent( void function( [WxKeyEvent] event ) ) |
/// | void unbindKeyUpEvent() |
/// 
/// [Char](/wxdart/wxGetCharEventType.html) event gets sent when a full character has been entered. |
/// | ----------------- |
/// | void bindCharEvent( void function( [WxKeyEvent] event ) ) |
/// | void unbindCharEvent() |
/// 
///
/// # Supported key code constants in wxDart Flutter and wxDart Native
/// | key | constant |
/// | -------- | -------- |
/// | arrowUp | WXK_UP |
/// | arrowDown | WXK_DOWN |
/// | arrowRight | WXK_RIGHT |
/// | arrowLeft: | WXK_LEFT |
/// | space | WXK_SPACE |
/// | enter | WXK_RETURN |
/// | numpadEnter | WXK_RETURN |
/// | home | WXK_HOME |
/// | end | WXK_END |
/// | pageUp | WXK_PAGEUP |
/// | pageDown | WXK_PAGEDOWN |
/// | add | WXK_ADD |
/// | minus | WXK_SUBTRACT |
/// | escape | WXK_ESCAPE |
/// | backspace | WXK_BACK |
/// | f1 | WXK_F1 |
/// | ... | ... |
/// | f12 | WXK_F12 |
/// | tab | WXK_TAB |
/// | delete | WXK_DELETE |
/// | insert | WXK_INSERT |
/// | alt | WXK_ALT |
/// | shift | WXK_SHIFT |
/// | control | WXK_CONTROL |
/// | exclamation | WXK_EXCLAMATION |
/// | numberSign | WXK_NUMBER_SIGN |
/// | dollar | WXK_DOLLAR |
/// | percent | WXK_PERCENT |
/// | quoteSingle | WXK_SINGLE_QUOTE |
/// | backslash | 92 |
/// | braceLeft | 123 |
/// | braceRight | 125 |
/// | tilde | WXK_TILDE |
/// | bracketLeft | 91 |
/// | bracketRight | 93 |
/// | comma | WXK_COMMA |
/// | minus | WXK_MINUS |
/// | quote | WXK_DOUBLE_QUOTE |
/// | period | WXK_PERIOD |
/// | slash | WXK_SLASH |
/// | digit0 | 48 | 
/// | ... | ... | 
/// | digit9 | 57 | 
/// | colon | WXK_COLON |
/// | semicolon | WXK_SEMICOLON |
/// | less | WXK_LESS |
/// | equal | WXK_EQUAL |
/// | greater | WXK_GREATER |
/// | question | WXK_QUESTION |
/// | at | WXK_AT |
/// | keyA | WXK_A |
/// | ... | ... |
/// | keyZ | WXK_Z |

class WxKeyEvent extends WxEvent {
  WxKeyEvent( int eventType ) : super (eventType,-1) {
    _wxInitKeyEventModifiers( this );
  }

  /// Returns the key code (that often is not the actual character). E.g. when pressing the a key,
  /// it will return WXK_A which is the ascii code of the capitalized a. If this will
  /// result in the character a or A depends on shift being pressed.
  /// 
  /// See [getUnicodeKey]
  int getKeyCode( ) {
    return _keyCode;
  }
  /// Used internally
  void setKeyCode( int keyCode ) {
    _keyCode = keyCode;
  }

  /// Returns the Unicode key (currently wxDart Native only)
  int getUnicodeKey( ) {
    return _unicode;
  }

  /// Return true of the control key is currently pressed
  bool controlDown() {
    return _controlDown;
  }
  /// Return true of the command key is currently pressed
  bool cmdDown() {
    return controlDown();
  }
  /// Used internally
  void setControlDown( bool down ) {
    _controlDown = down;
  }
  /// Return true of the meta key is currently pressed
  bool metaDown() {
    return _metaDown;
  }
  /// Used internally
  void setMetaDown( bool down ) {
    _metaDown = down;
  }
  /// Return true of the alt key is currently pressed
  bool altDown() {
    return _altDown;
  }
  /// Used internally
  void setAltDown( bool down ) {
    _altDown = down;
  }
  /// Return true of the shift key is currently pressed
  bool shiftDown() {
    return _shiftDown;
  }
  /// Used internally
  void setShiftDown( bool down ) {
    _shiftDown = down;
  }
  /// Return true of the control key or the alt key is currently pressed
  bool hasModifiers( ) {
    return _controlDown || _altDown;
  }
  /// Return true of the any modifier currently pressed
  bool hasAnyModifiers( ) {
    return _controlDown || _altDown || _shiftDown || _metaDown;
  }

  int _keyCode = 0;
  int _unicode = 0;
  late bool _controlDown;
  late bool _metaDown;
  late bool _altDown;
  late bool _shiftDown;
}
