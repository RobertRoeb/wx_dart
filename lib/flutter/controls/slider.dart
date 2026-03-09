// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxSlider ----------------------

/// @nodoc

extension SliderEventBinder on WxEvtHandler {
  void bindSliderEvent( OnCommandEventFunc func, int id ) {
    _eventTable.add( WxCommandEventTableEntry(wxGetSliderEventType(), id, func));
  }

  void unbindSliderEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetSliderEventType(), id));
  }
}

const int wxSL_HORIZONTAL = wxHORIZONTAL;
const int wxSL_VERTICAL = wxVERTICAL;
const int wxSL_LEFT = 0x0040;
const int wxSL_RIGHT = 0x0100;
const int wxSL_TOP = 0x0080;
const int wxSL_BOTTOM = 0x0200;
const int wxSL_AUTOTICKS = 0x0010;
const int wxSL_MIN_MAX_LABELS = 0x2000;
const int wxSL_VALUE_LABEL = 0x4000;
const int wxSL_LABELS = (wxSL_MIN_MAX_LABELS|wxSL_VALUE_LABEL);
const int wxSL_INVERSE = 0x1000;

/// A slider is a control with a handle which can be pulled back and forth to change the value.
///
///```dart
///  // Create the slider with a range from 0 to 100
///  final slider = WxSlider(parent, -1, 0, 0, 100, size: WxSize(150,-1) );
///
///  slider.bindSliderEvent((event) {
///  final value = event.getInt();
///  // do something with it
/// }, -1);
///```
///
/// [Slider](/wxdart/wxGetSliderEventType.html) event gets sent when user dragged the slider. |
/// | ----------------- |
/// | void bindSliderEvent( OnCommandEventFunc ) |
/// | void unbindSliderEvent() |
/// 
/// # Window style constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxSL_HORIZONTAL | wxHORIZONTAL |
/// | wxSL_VERTICAL | wxVERTICAL (wxDart Native only) |
/// | wxSL_LEFT | 0x0040 (Position of tick marks) |
/// | wxSL_RIGHT | 0x0100 (Position of tick marks) |
/// | wxSL_TOP | 0x0080 (Position of tick marks) |
/// | wxSL_BOTTOM | 0x0200 (Position of tick marks) |
/// | wxSL_AUTOTICKS | 0x0010 (Displays tick marks (Windows, GTK+))|
/// | wxSL_MIN_MAX_LABELS | 0x2000 |
/// | wxSL_VALUE_LABEL | 0x4000 |
/// | wxSL_LABELS | (wxSL_MIN_MAX_LABELS\|wxSL_VALUE_LABEL) |
/// | wxSL_INVERSE | 0x1000 (wxDart Native only) |

class WxSlider extends WxControl {
  WxSlider( super.parent, super.id, int value, int min, int max, { super.pos, super.size, super.style = wxSL_HORIZONTAL } ) 
  {
    _value = value;
    _min = min;
    _max = max;
  }

  late int _value;
  late int _min;
  late int _max;

  /// Scrollbar like interface in wxDart Native
  int getLineSize( ) {
    return 1;
  }

  /// Scrollbar like interface in wxDart Native
  void setLineSize( int lineSize ) {
  }

  /// Scrollbar like interface in wxDart Native
  int getPageSize( ) {
    return -1;
  }

  /// Scrollbar like interface in wxDart Native
  void setPageSize( int pageSize ) {
  }

  /// Returns the current value
  int getValue( ) {
    return _value;
  }

  /// Sets the value of the slider
  void setValue( int value ) {
    _value = value;
    _setState();
  }

  /// Returns the tick frequency (wxDart Native only)
  int getTickFreq( ) {
    return -1;
  }

  /// Sets the tick frequency (wxDart Native only)
  void setTick( int tickPos ) {
  }

  /// Clears the tick frequency (wxDart Native only)
  void clearTicks( ) {
  }

  /// Sets the [min] and [max] values of the slider
  void setRange( int min, int max ) {
    _min = min;
    _max = max;
    _setState();
  }

  /// Returns the max value of the slider
  int getMin( ) {
    return _min.floor();
  }

  /// Sets the [min] value of the slider
  void setMin( int min ) {
    _min = min;
    _setState();
  }

  /// Returns the max value of the slider
  int getMax( ) {
    return _max.floor();
  }

  /// Sets the [max] value of the slider
  void setMax( int max ) {
    _max = max;
    _setState();
  }

  @override
  Widget _build( BuildContext context )
  {
    Widget finalWidget = Slider.adaptive(
        value: _value.toDouble(),
        min: _min.toDouble(),
        max: _max.toDouble(),
        divisions: _max-_min+1,
        label: hasFlag(wxSL_VALUE_LABEL) ? "$_value" : null,
        showValueIndicator: hasFlag(wxSL_VALUE_LABEL) ? ShowValueIndicator.onlyForDiscrete : ShowValueIndicator.never,
        onChanged: (value) {
          _value = value.floor();
          _setState();
          final event = WxCommandEvent( wxGetSliderEventType(), getId() );
          event.setEventObject(this);
          event.setInt(value.floor());
          processEvent(event);
        },
      );

    if (hasFlag(wxSL_MIN_MAX_LABELS) && !hasFlag(wxSL_VALUE_LABEL)) {
      finalWidget = Column(
        children: [
          finalWidget,
          Row(
            children: [
              Text( "$_min"),
              Expanded( child: SizedBox( width: 10 )),
              Text( "$_max"),
            ],
          )
        ]
      );
    } else
    if (hasFlag(wxSL_MIN_MAX_LABELS) && hasFlag(wxSL_VALUE_LABEL)) {
      finalWidget = Column(
        children: [
          finalWidget,
          Row(
            children: [
              Text( "$_min"),
              Expanded( child: SizedBox( width: 10 )),
              Text( "$_value"),
              Expanded( child: SizedBox( width: 10 )),
              Text( "$_max"),
            ],
          )
        ]
      );
    } else
    if (!hasFlag(wxSL_MIN_MAX_LABELS) && hasFlag(wxSL_VALUE_LABEL)) {
      finalWidget = Column(
        children: [
          finalWidget,
          Row(
            children: [
              Expanded( child: SizedBox( width: 10 )),
              Text( "$_value"),
              Expanded( child: SizedBox( width: 10 )),
            ],
          )
        ]
      );
    }

    return _buildControl( context, finalWidget );
  }

}
