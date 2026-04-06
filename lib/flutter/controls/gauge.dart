// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxGauge ----------------------

const int wxGA_HORIZONTAL = wxHORIZONTAL;
const int wxGA_VERTICAL = wxVERTICAL;
const int wxGA_SMOOTH = 0x0020;
const int wxGA_TEXT = 0x0040;

/// Displays a gauge indicating the status of a task or a value on a meter device.
/// 
/// Call [pulse] to set the control in indeterminate mode.
/// 
/// Example code:
/// ```dart
///  final gauge = WxGauge(parent, -1, 100, size: WxSize(150,-1) );
///  gauge.setValue( 30 );
/// ```
/// 
/// # Window styles
/// | constant | meaning |
/// | -------- | -------- |
/// | wxGA_HORIZONTAL | wxHORIZONTAL (default) |
/// | wxGA_VERTICAL | wxVERTICAL (wxDart Native only) |
/// | wxGA_SMOOTH | 0x0020 |
/// | wxGA_TEXT | 0x0040 |
/// 
/// Main interface
/// * [setValue]
/// * [getValue]
/// * [setRange]
/// * [getRange]
/// * [pulse]

class WxGauge extends WxControl {
  /// Creates the gauge with the given [range]
  WxGauge( super.parent, super.id, int range, { super.pos, super.size, super.style = wxGA_HORIZONTAL } ) 
  {
    _range = range;
  }

  bool _isPulse = false;
  late int _range;
  int _value = 0;

  /// Returns true if the control is vertical 
  bool isVertical( ) {
    return hasFlag( wxGA_VERTICAL );
  }

  /// Returns the current value of the gauge
  int getValue( ) {
    return _value;
  }

  /// Sets the current value 
  void setValue( int value ) {
    _isPulse = false;
    _value = value;
  }

  /// Returns the current range (max value) of the gauge
  int getRange( ) {
    return _range;
  }

  /// Sets the range (max value) of the gauge
  void setRange( int range ) {
    _range = range;
    _setState();
  }

  /// Sets the gauge into pulse mode (indeterminate)
  void pulse( ) {
    _isPulse = true;
    _setState();
  }

  @override
  Widget _build( BuildContext context )
  {
    Widget finalWidget = _buildControl(context, 
      LinearProgressIndicator(
        value: _isPulse ? null : (_value / _range)
      ) );

    return finalWidget;
  }
}
