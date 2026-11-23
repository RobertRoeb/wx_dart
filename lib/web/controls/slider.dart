// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-11-15
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- EVT_SLIDER ----------------------

// ------------------------- wxSlider ----------------------

/// A slider (HTML <input type="range">).
///
/// # Styles
/// | constant | meaning |
/// | -------- | -------- |
/// | wxSL_HORIZONTAL | horizontal slider (default) |
/// | wxSL_VERTICAL | vertical slider |
/// | wxSL_MIN_MAX_LABELS | shows minimum and maximum |
/// | wxSL_VALUE_LABEL | shows the current value |
/// | wxSL_LABELS | both of the above |
/// | wxSL_INVERSE | maximum on the left (or top) |
///
/// # Events emitted
/// [Slider](/wxdart/wxGetSliderEventType.html) event gets sent while the user moves the slider
/// | ----------------- |
/// | void bindSliderEvent( OnCommandEventFunc, int id ) |
/// | void unbindSliderEvent( int id ) |
class WxSlider extends WxControl {
  WxSlider(super.parent, super.id, int value, int min, int max,
      {super.pos = wxDefaultPosition, super.size = wxDefaultSize, super.style = wxSL_HORIZONTAL}) {
    _min = min;
    _max = max;
    _value = value.clamp(min, max).toInt();
    _update();
    _labelOrFontChanged();
  }

  late int _value;
  late int _min;
  late int _max;
  int _lineSize = 1;
  int _pageSize = 10;
  int _tickFreq = 0;

  @override
  String get _jsKind => 'slider';

  void _update() {
    int flags = 0;
    if (hasFlag(wxSL_VERTICAL)) flags |= 1;
    if (hasFlag(wxSL_MIN_MAX_LABELS)) flags |= 2;
    if (hasFlag(wxSL_VALUE_LABEL)) flags |= 4;
    if (hasFlag(wxSL_INVERSE)) flags |= 8;
    _jsSliderSet(_handle, _value, _min, _max, flags);
  }

  /// Returns the current value
  int getValue() {
    return _value;
  }

  /// Sets the value of the slider
  void setValue(int value) {
    _value = value.clamp(_min, _max).toInt();
    _update();
  }

  /// Returns the max value of the slider
  int getMin() {
    return _min;
  }

  /// Sets the [min] value of the slider
  void setMin(int min) {
    setRange(min, _max);
  }

  /// Returns the max value of the slider
  int getMax() {
    return _max;
  }

  /// Sets the [max] value of the slider
  void setMax(int max) {
    setRange(_min, max);
  }

  /// Sets the [min] and [max] values of the slider
  void setRange(int min, int max) {
    _min = min;
    _max = max;
    _value = _value.clamp(min, max).toInt();
    _update();
  }

  /// Scrollbar like interface in wxDart Native
  int getLineSize() {
    return _lineSize;
  }

  /// Scrollbar like interface in wxDart Native
  void setLineSize(int lineSize) {
    _lineSize = lineSize;
  }

  /// Scrollbar like interface in wxDart Native
  int getPageSize() {
    return _pageSize;
  }

  /// Scrollbar like interface in wxDart Native
  void setPageSize(int pageSize) {
    _pageSize = pageSize;
  }

  /// Returns the tick frequency (wxDart Native only)
  ///
  /// Ticks are not drawn in wxDart Web
  int getTickFreq() {
    return _tickFreq;
  }

  void setTickFreq(int freq) {
    _tickFreq = freq;
  }

  /// Sets the tick frequency (wxDart Native only)
  void setTick(int tickPos) {}

  /// Clears the tick frequency (wxDart Native only)
  void clearTicks() {}

  void _onJsSlider(int value) {
    _value = value;
    final event = WxCommandEvent(wxGetSliderEventType(), getId());
    event.setInt(value);
    event.setEventObject(this);
    processEvent(event);
  }
}
