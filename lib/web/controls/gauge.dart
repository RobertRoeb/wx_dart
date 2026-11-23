// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-11-15
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxGauge ----------------------

/// A progress bar. [pulse] switches to an animated "busy" display until
/// the next [setValue].
///
/// # Styles
/// | constant | meaning |
/// | -------- | -------- |
/// | wxGA_HORIZONTAL | horizontal bar (default) |
/// | wxGA_VERTICAL | vertical bar, filling from the bottom |
class WxGauge extends WxControl {
  /// Creates the gauge with the given [range]
  WxGauge(super.parent, super.id, int range,
      {super.pos = wxDefaultPosition, super.size = wxDefaultSize, super.style = wxGA_HORIZONTAL}) {
    _range = range;
    _update();
    _labelOrFontChanged();
  }

  late int _range;
  int _value = 0;
  bool _pulsing = false;

  @override
  String get _jsKind => 'gauge';

  void _update() {
    _jsGaugeSet(_handle, _value, _range, isVertical(), _pulsing);
  }

  /// Returns true if the control is vertical
  bool isVertical() {
    return hasFlag(wxGA_VERTICAL);
  }

  /// Returns the current value of the gauge
  int getValue() {
    return _value;
  }

  /// Sets the current value
  void setValue(int value) {
    _value = value.clamp(0, max(0, _range)).toInt();
    _pulsing = false;
    _update();
  }

  /// Returns the current range (max value) of the gauge
  int getRange() {
    return _range;
  }

  /// Sets the range (max value) of the gauge
  void setRange(int range) {
    _range = range;
    _value = _value.clamp(0, max(0, range)).toInt();
    _update();
  }

  /// Sets the gauge into pulse mode (indeterminate)
  void pulse() {
    if (_pulsing) return;
    _pulsing = true;
    _update();
  }
}
