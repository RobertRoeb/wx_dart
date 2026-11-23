// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01 (wxDart Web: 2026-11-15)
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxSpinDoubleEvent ----------------------

// ------------------------- wxSpinCtrlDouble ----------------------

// ------------------------- wxSpinCtrlDouble ----------------------

/// Allows the user to enter an double number with keyboard or mouse/touch.
/// 
/// In wxDart Native, the change proposed by the control can be vetoed
/// using [WxSpinDoubleEvent.veto]. This is not yet implemented in wxDart Flutter.
/// 
/// Example usage:
///```dart
///  final spin = WxSpinCtrlDouble(parent, -1, '-10.0', initial: -10, min: -20, max: 20 /*, size: WxSize(150,-1) */);
///  spin.bindSpinCtrlDoubleEvent((event) {
///   double value = event.getValue();
/// } ,-1);
///```
///
/// # Event emitted
/// [SpinCtrlDouble](/wxdart/wxGetSpinCtrlDoubleEventType.html) event gets sent when the user has entered a new number. |
/// | ----------------- |
/// | void bindSpinCtrlDoubleEvent( void function( [WxSpinDoubleEvent] event ) ) |
/// | void unbindSpinCtrlDoubleEvent() |
/// 
/// # Window styles
/// | constant | meaning |
/// | -------- | -------- |
/// | wxSP_HORIZONTAL | wxHORIZONTAL |
/// | wxSP_VERTICAL | wxVERTICAL |
/// | wxSP_ARROW_KEYS | 0x4000 |
/// | wxSP_WRAP | 0x8000 |

class WxSpinCtrlDouble extends WxControl {

  /// Creates the control with text [value] and double [min], [max] and [initial] values
  WxSpinCtrlDouble( super.parent, super.id, String value, { super.pos, super.size, 
                    super.style = wxSP_ARROW_KEYS, double min = 0, double max = 100, double initial = 0, double inc = 0} ) {
    _min = min;
    _max = max;
    _value = initial.clamp( min, max );
    _increment = inc > 0 ? inc : 1;
    if (value.isNotEmpty) {
      final v = double.tryParse( value );
      if (v != null) _value = v.clamp( min, max );
    }
    // digits from the increment, as in wxWidgets
    final incText = _increment.toString();
    _decimals = incText.contains('.') && !incText.endsWith('.0') ? incText.length - incText.indexOf('.') - 1 : 0;
    _update();
  }

  late double _min;
  late double _max;
  late double _value;
  late double _increment;
  int _decimals = 0;

  @override
  String get _jsKind => 'spin';

  void _update() {
    _jsSpinSet( _handle, _min, _max, _decimals > 0 ? 1 / pow( 10, _decimals ) : _increment, getTextValue() );
  }

  @override
  WxSize _doGetBestSize() {
    return const WxSize( 100, 28 );
  }

  @override
  bool _wantsNativeKey( int keyCode ) {
    return keyCode == WXK_UP || keyCode == WXK_DOWN;
  }

  /// Returns the min value from the range
  double getMin( ) {
    return _min;
  }

  /// Returns the max value from the range
  double getMax( ) {
    return _max;
  }

  /// Sets min and max values (the range)
  void setRange( double min, double max ) {
    _min = min;
    _max = max;
    _value = _value.clamp(min,max);
    _update();
  }

  /// Returns the number of decimals for rounding
  int getDigits( ) {
    return _decimals;
  }

  /// Sets the number of decimals for rounding
  void setDigits( int decimals ) {
    _decimals = decimals;
    _update();
  }

  /// Returns the increment (step wise increase). Default is 1.
  double getIncrement( ) {
    return _increment;
  }

  /// Sets the increment (step wise increase)
  void setIncrement( double inc ) {
    _increment = inc;
    _update();
  }

  /// Returns current value
  double getValue( ) {
    return _value;
  }

  /// Sets the value
  void setValue( double value ) {
    _value = value.clamp( _min, _max );
    _update();
  }

  /// Returns the current value as a String, formatted with
  /// the number digits set by [setDigits].
  String getTextValue( ) {
    return _value.toStringAsFixed( _decimals );
  }

  void _onJsSpin( String text, bool committed ) {
    final v = double.tryParse( text );
    if (v == null) {
      if (committed) _update();
      return;
    }
    double value = v;
    if (value < _min || value > _max) {
      if (hasFlag( wxSP_WRAP )) {
        value = value > _max ? _min : _max;
      } else {
        value = value.clamp( _min, _max );
      }
    }
    if (committed) {
      _value = value;
      _update();
    }
    if (value == _value && !committed) return;
    final changed = value != _value || committed;
    _value = value;
    if (!changed) return;
    final event = WxSpinDoubleEvent( wxGetSpinCtrlDoubleEventType(), getId(), value: value );
    event.setEventObject( this );
    processEvent( event );
  }
}
