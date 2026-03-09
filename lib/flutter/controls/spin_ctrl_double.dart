// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxSpinDoubleEvent ----------------------

typedef OnSpinDoubleEventFunc = void Function( WxSpinDoubleEvent event );

/// @nodoc

class WxSpinDoubleEventTableEntry extends WxEventTableEntry {
  WxSpinDoubleEventTableEntry( super.eventType, super.id, this.func );
  final OnSpinDoubleEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return (eventType == eventTypeTested) && ((id == wxID_ANY) || (id == idTested));
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxSpinDoubleEvent) {
      func( event );
    }
  }
}

/// @nodoc

extension SpinCtrlDoubleEventBinder on WxEvtHandler {
  void bindSpinCtrlDoubleEvent( OnSpinDoubleEventFunc func, int id ) {
    _eventTable.add( WxSpinDoubleEventTableEntry(wxGetSpinCtrlDoubleEventType(), id, func));
  }

  void unbindSpinCtrlDoubleEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetSpinCtrlDoubleEventType(), id));
  }
}

/// Event emitted by [WxSpinCtrlDouble].

class WxSpinDoubleEvent extends WxNotifyEvent  {
  WxSpinDoubleEvent( int eventType, int id, { double value = 0 } ) : super( eventType, id ) {
    _value = value;
  }

  late double _value;

  /// Sets the value of the [WxSpinCtrlDouble], done by it.
  void setValue( double value ) {
    _value = value;
  }

  /// Returns the value of the [WxSpinCtrlDouble]
  double getValue( ) {
    return _value;
  }
}

// ------------------------- wxSpinCtrlDouble ----------------------

/// Allows the user to enter an double number with keyboard or mouse/touch.
/// 
///```dart
///  final spin = WxSpinCtrlDouble(parent, -1, '-10.0', initial: -10, min: -20, max: 20 /*, size: WxSize(150,-1) */);
///  spin.bindSpinCtrlDoubleEvent((event) {
///   double value = event.getValue;
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
      _value = initial;
      _increment= inc;
  }

  final TextEditingController _controller = TextEditingController();
  late double _min;
  late double _max;
  late double _value;
  late double _increment;
  int _decimals = 18;

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
    _setState();
  }

  /// Returns the number of decimals for rounding
  int getDigits( ) {
    return _decimals;
  }

  /// Sets the number of decimals for rounding
  void setDigits( int decimals ) {
    _decimals = decimals;
  }

  /// Returns the increment (step wise increase). Default is 1.
  double getIncrement( ) {
    return _increment;
  }

  /// Sets the increment (step wise increase)
  void setIncrement( double inc ) {
    _increment = inc;
  }

  /// Returns current value
  double getValue( ) {
    return _value;
  }

  /// Sets the value
  void setValue( double value ) {
    _value = value;
    _setState();
  }

  /// Returns the current value as a String, formatted with
  /// the number digits set by [setDigits].
  String getTextValue( ) {
    return _value.toStringAsFixed(_decimals);
  }

  @override
  Widget _build( BuildContext context )
  {
    Widget finalWidget = _buildControl(context, 
      InputQty(
        initVal: _value,
        minVal: _min,
        maxVal: _max,
        decimalPlaces: _decimals,
        qtyFormProps: QtyFormProps(
          controller: _controller,
        ),
        onQtyChanged: (value) {
          if (value is int) {
            _value = value.toDouble();
          } else 
          if (value is double) {
            _value = value;
          } else {
            wxLogError( "wrong type" );
            _value = _min;
          }
          _setState();
          final wxevent = WxSpinDoubleEvent( wxGetSpinCtrlDoubleEventType(), getId(), value: _value );
          wxevent.setEventObject(this);
          processEvent(wxevent);
        },
        decoration: QtyDecorationProps(
          // isDense: true,
          // fillColor: Colors.grey,
          qtyStyle: wxTheApp.isTouch() ? QtyStyle.classic : QtyStyle.btnOnRight,
          border: (hasFlag( wxBORDER_NONE ) || hasFlag( wxBORDER_SIMPLE )) 
            ? InputBorder.none 
            : UnderlineInputBorder(),
            /*
            : OutlineInputBorder( 
              borderRadius: BorderRadius.circular(3.0),
              borderSide: BorderSide(
                width: 0.5,
                color: wxTheApp.isDark() ? Colors.grey : Colors.black                
              )
              ), */
          contentPadding: EdgeInsets.all((hasFlag( wxBORDER_NONE ) || hasFlag( wxBORDER_SIMPLE )) ? 0 : 10),
          isBordered: true,
          plusBtn: Padding(
            padding: EdgeInsetsGeometry.only(right:5),
            child: CustomPaint(
              size: wxTheApp.isTouch() ? const Size(26, 20) : const Size(13, 10),
              painter: TrianglePainter( true ),
            )
          ),
          minusBtn: Padding(
            padding: EdgeInsetsGeometry.only(right:5),
            child: CustomPaint(
              size: wxTheApp.isTouch() ? const Size(26, 20) : const Size(13, 10),
              painter: TrianglePainter( false ),
            )
          ),
        ),
      ) );

      _focusNode ??= FocusNode();
      finalWidget = Focus (
        focusNode: _focusNode,
        autofocus: true,
        onFocusChange: (enter) => _sendFocusEvents(enter),
        onKeyEvent: (node, event)
        {
          if ((event is KeyDownEvent) || (event is KeyRepeatEvent)) 
          {
            if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
              if (_value >= _max) {
                if (!hasFlag(wxSP_WRAP)) {
                  return KeyEventResult.handled;    
                }
                _value = _min; 
              } else {
                _value += _increment;
                if (_value > _max) {
                  _value = _max;
                }
              }
            } else 
            if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
              if (_value <= _min) {
                if (!hasFlag(wxSP_WRAP)) {
                  return KeyEventResult.handled;    
                }
                _value = _min; 
              } else {
                _value -= _increment;
                if (_value < _min) {
                  _value = _min;
                }
              }
            } else {
              return KeyEventResult.ignored;
            }
            _controller.text = "$_value";
            _setState();
            final wxevent = WxSpinDoubleEvent( wxGetSpinCtrlDoubleEventType(), getId(), value: _value );
            wxevent.setEventObject(this);
            processEvent(wxevent);
            return KeyEventResult.handled;      
          }
          return KeyEventResult.ignored;
        },
        child: finalWidget
      );

    return finalWidget;
  }
}