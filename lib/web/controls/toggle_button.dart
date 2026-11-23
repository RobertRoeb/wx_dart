// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01 (wxDart Web: 2026-11-15)
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- EVT_TOGGLEBUTTON ----------------------

// ------------------------- wxToggleButton ----------------------

/// Allows user to toggle a feature using a button.
/// 
/// Example usage
/// ```dart
///  final myButton = WxToggleButton( parent, -1, "Show it");
///  myButton.bindToggleButtonEvent((event)
///  {
///    if (event.isChecked()) {
///      // actually show something
///    } else {
///      // actually hide something
///    }
///  }, -1);
///```
///
/// Main interface
/// * [setValue]
/// * [getValue]
/// * [setLabel]
/// * [getLabel]
/// 
/// [ToggleButton](/wxdart/wxGetToggleButtonEventType.html) event gets sent when the button is toggled or untoggled. |
/// | ----------------- |
/// | void bindToggleButtonEvent( void function( [WxCommandEvent] event ), int id ) |
/// | void unbindToggleButtonEvent() |
/// 
class WxToggleButton extends WxControl {
  /// Creates toggle button with given [label]
  WxToggleButton( super.parent, super.id, String label, { super.pos, super.size, super.style } ) {
    setLabel( label );
  }

  bool _value = false;

  @override
  String get _jsKind => 'togglebutton';

  @override
  void setLabel( String label ) {
    _label = label;
    _jsSetLabel( _handle, _wxStripMnemonic( label ) );
    _labelOrFontChanged();
  }

  /// Returns true if button is in the toggled state
  bool getValue() {
    return _value;
  }

  /// Sets the button is in the toggled or untoggled state
  void setValue( bool state ) {
    _value = state;
    _jsToggleSet( _handle, state );
  }

  void _onJsToggle( bool on ) {
    _value = on;
    final event = WxCommandEvent( wxGetToggleButtonEventType(), getId() );
    event.setInt( on ? 1 : 0 );
    event.setEventObject( this );
    processEvent( event );
  }
}

// ------------------------- wxBitmapToggleButton ----------------------

/// Allows user to toggle a feature using a bitmap button.
/// 
/// Allows user to toggle a feature using a button.
/// 
/// Example usage
/// ```dart
///  final bitmap = WxBitmapBundle.fromPNGAsset("show.png");
///   
///  final myButton = WxBitmapToggleButton( parent, -1, bitmap );
///  myButton.bindToggleButtonEvent((event)
///  {
///    if (event.isChecked()) {
///      // actually show something
///    } else {
///      // actually hide something
///    }
///  }, -1);
///```
///
/// [ToggleButton](/wxdart/wxGetToggleButtonEventType.html) event gets sent when the button is toggled or untoggled. |
/// | ----------------- |
/// | void bindToggleButtonEvent( void function( [WxCommandEvent] event ), int id ) |
/// | void unbindToggleButtonEvent() |

class WxBitmapToggleButton extends WxAnyButton {
  WxBitmapToggleButton( super.parent, super.id, WxBitmapBundle bitmap, { super.pos, super.size, super.style } )
  {
    setBitmap( bitmap );
  }

  bool _value = false;

  @override
  String get _jsKind => 'togglebutton';

  /// Returns true if button is in the toggled state
  bool getValue() {
    return _value;
  }

  /// Sets the button is in the toggled or untoggled state
  void setValue( bool state ) {
    _value = state;
    _jsToggleSet( _handle, state );
  }

  void _onJsToggle( bool on ) {
    _value = on;
    final event = WxCommandEvent( wxGetToggleButtonEventType(), getId() );
    event.setInt( on ? 1 : 0 );
    event.setEventObject( this );
    processEvent( event );
  }
}
