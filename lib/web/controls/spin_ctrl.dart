// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01 (wxDart Web: 2026-11-15)
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

const int wxSP_HORIZONTAL = wxHORIZONTAL;
const int wxSP_VERTICAL = wxVERTICAL;
const int wxSP_ARROW_KEYS = 0x4000;
const int wxSP_WRAP = 0x8000;

// ------------------------- wxSpinCtrl ----------------------

/// Allows the user to enter an integer number with keyboard or mouse/touch.
/// 
/// This control can have very different lengths (horizontal dimension) on different
/// platforms as it sometimes has two small arrows above each other or two big arrows
/// next to each other, taking much more space. 
///  
/// Main interface:
/// * [setValue]
/// * [getValue]
/// * [setRange]
/// * [getMin]
/// * [getMax]
/// * [setIncrement]
/// * [getIncrement]
/// 
/// Example usage:
///```dart
///  final spin = WxSpinCtrl(parent, -1, '-10', initial: -10, min: -20, max: 20 /*, size: WxSize(150,-1) */);
///  spin.bindSpinCtrlEvent((event) {
///   int value = event.getPosition();
///    // same as: int value = event.getInt();
/// } ,-1);
///```
///
/// # Event emitted
/// [SpinCtrl](/wxdart/wxGetSpinCtrlEventType.html) event gets sent when the user has entered a new number. |
/// | ----------------- |
/// | void bindSpinCtrlEvent( void function( [WxSpinEvent] event ) ) |
/// | void unbindSpinCtrlEvent() |
/// 
/// # Window styles
/// | constant | meaning |
/// | -------- | -------- |
/// | wxSP_HORIZONTAL | wxHORIZONTAL (the default) |
/// | wxSP_VERTICAL | wxVERTICAL (not supported everywhere) |
/// | wxSP_ARROW_KEYS | 0x4000 (allow keyboard use) |
/// | wxSP_WRAP | 0x8000 (wraps number when reaching min or max) |

class WxSpinCtrl extends WxControl {

  /// Creates the control with text [value] and integer [min], [max] and [initial] values
  WxSpinCtrl( super.parent, super.id, String value, { super.pos, super.size, super.style = wxSP_ARROW_KEYS, int min = 0, int max = 100, int initial = 0 } ) {
    _min = min;
    _max = max;
    _value = initial.clamp( min, max );
    if (value.isNotEmpty) {
      final v = int.tryParse( value );
      if (v != null) _value = v.clamp( min, max );
    }
    _update();
  }

  late int _min;
  late int _max;
  late int _value;
  int _increment = 1;

  @override
  String get _jsKind => 'spin';

  void _update() {
    _jsSpinSet( _handle, _min.toDouble(), _max.toDouble(), _increment.toDouble(), "$_value" );
  }

  @override
  WxSize _doGetBestSize() {
    return const WxSize( 90, 28 );
  }

  @override
  bool _wantsNativeKey( int keyCode ) {
    return keyCode == WXK_UP || keyCode == WXK_DOWN;
  }

  /// Returns the min value from the range
  int getMin( ) {
    return _min;
  }

  /// Returns the max value from the range
  int getMax( ) {
    return _max;
  }

  /// Sets min and max values (the range)
  void setRange( int min, int max ) {
    _min = min;
    _max = max;
    _value = _value.clamp(min,max);
    _update();
  }

  /// Returns the increment (step wise increase). Default is 1.
  int getIncrement( ) {
    return _increment;
  }

  /// Sets the increment (step wise increase)
  void setIncrement( int inc ) {
    _increment = inc;
    _update();
  }

  /// Returns the number base. Default to 10 for decimal numbers.
  ///
  /// wxDart Native supports hexadecimal as well (16).
  ///
  /// Only base 10 is supported in wxDart Web
  int getBase( ) {
    return 10;
  }

  /// Sets the number base. wxDart Flutter only supports decimal numbers.
  ///
  /// wxDart Native supports hexadecimal as well (16)
  void setBase( int max ) {
  }

  /// Returns current value
  int getValue( ) {
    return _value;
  }

  /// Sets the value
  void setValue( int value ) {
    _value = value.clamp( _min, _max );
    _update();
  }

  /// Returns the value as a String
  String getTextValue( ) {
    return _jsTextGet( _handle );
  }

  /// Set text value in text field. Does nothing in wxDart Flutter.
  void setTextValue( String value ) {
    final v = int.tryParse( value );
    if (v != null) setValue( v );
  }

  /// [text] is the text in the field; [committed] is true when the user
  /// left the field or pressed Enter (the value is then clamped)
  void _onJsSpin( String text, bool committed ) {
    final v = int.tryParse( text ) ?? double.tryParse( text )?.round();
    if (v == null) {
      if (committed) _update();  // invalid text: show the old value
      return;
    }
    int value = v;
    if (value < _min || value > _max) {
      if (hasFlag( wxSP_WRAP )) {
        value = value > _max ? _min : _max;
      } else {
        value = value.clamp( _min, _max );
      }
      if (committed) _update();
    }
    if (committed && value != v) {
      _value = value;
      _update();
    }
    if (value == _value) return;
    _value = value;
    final event = WxSpinEvent( wxGetSpinCtrlEventType(), getId() );
    event.setPosition( value );
    event.setEventObject( this );
    processEvent( event );
  }
}
