// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxSpinEvent ----------------------

typedef OnSpinEventFunc = void Function( WxSpinEvent event );

/// @nodoc

class WxSpinEventTableEntry extends WxEventTableEntry {
  WxSpinEventTableEntry( super.eventType, super.id, this.func );
  final OnSpinEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return (eventType == eventTypeTested) && ((id == wxID_ANY) || (id == idTested));
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxSpinEvent) {
      func( event );
    }
  }
}

/// @nodoc

extension SpinCtrlEventBinder on WxEvtHandler {
  void bindSpinCtrlEvent( OnSpinEventFunc func, int id ) {
    _eventTable.add( WxSpinEventTableEntry(wxGetSpinCtrlEventType(), id, func));
  }

  void unbindSpinCtrlEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetSpinCtrlEventType(), id));
  }
}

/// @nodoc

extension SpinEventBinder on WxEvtHandler {
  void bindSpinEvent( OnSpinEventFunc func, int id ) {
    _eventTable.add( WxSpinEventTableEntry(wxGetSpinEventType(), id, func));
  }

  void unbindSpinEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetSpinEventType(), id));
  }
}

/// @nodoc

extension SpinUpEventBinder on WxEvtHandler {
  void bindSpinUpEvent( OnSpinEventFunc func, int id ) {
    _eventTable.add( WxSpinEventTableEntry(wxGetSpinUpEventType(), id, func));
  }

  void unbindSpinUpEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetSpinUpEventType(), id));
  }
}

/// @nodoc

extension SpinDownEventBinder on WxEvtHandler {
  void bindSpinDownEvent( OnSpinEventFunc func, int id ) {
    _eventTable.add( WxSpinEventTableEntry(wxGetSpinDownEventType(), id, func));
  }

  void unbindSpinDownEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetSpinDownEventType(), id));
  }
}

/// Event emitted by [WxSpinCtrl].

class WxSpinEvent extends WxNotifyEvent  {

  /// Creates spin events. Done by [WxSpinCtrl]
  WxSpinEvent( super.eventType, super.id );

  /// Sets value of [WxSpinCtrl] and also done by [WxSpinCtrl].
  void setPosition( int pos ) {
    setInt( pos );
  }

  /// Returns value of [WxSpinCtrl]
  int getPosition( ) {
    return getInt();
  }
}

// ------------------------- wxSpinCtrl ----------------------

const int wxSP_HORIZONTAL = wxHORIZONTAL;
const int wxSP_VERTICAL = wxVERTICAL;
const int wxSP_ARROW_KEYS = 0x4000;
const int wxSP_WRAP = 0x8000;

/// Allows the user to enter an integer number with keyboard or mouse/touch.
/// 
/// This control can have very different lengths (horizontal dimension) on different
/// platforms as it sometimes has two small arrows above each other or two big arrows
/// next to each other, taking much more space. 
///  
///```dart
///  final spin = WxSpinCtrl(parent, -1, '-10', initial: -10, min: -20, max: 20 /*, size: WxSize(150,-1) */);
///  spin.bindSpinCtrlEvent((event) {
///   int value = event.getPos();
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
      _value = initial;
  }

  final TextEditingController _controller = TextEditingController();
  late int _min;
  late int _max;
  late int _value;
  int _increment = 1;

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
    _setState();
  }

  /// Returns the increment (step wise increase). Default is 1.
  int getIncrement( ) {
    return _increment;
  }

  /// Sets the increment (step wise increase)
  void setIncrement( int inc ) {
    _increment = inc;
  }

  /// Returns the number base. Default to 10 for decimal numbers.
  /// 
  /// wxDart Native supports hexadecimal as well (16). 
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
    _value = value;
    _setState();
  }

  /// Returns the value as a String
  String getTextValue( ) {
    return "$_value";
  }

  /// Set text value in text field. Does nothing in wxDart Flutter.
  void setTextValue( String value ) {
  }

  @override
  Widget _build( BuildContext context )
  {
    Widget finalWidget = _buildControl(context, 
      InputQty(
        initVal: _value,
        minVal: _min,
        maxVal: _max,
        decimalPlaces: 0,
        qtyFormProps: QtyFormProps(
          controller: _controller,
        ),
        onQtyChanged: (value) {
          int v = value.floor();
          _value = v;
          _setState();
          final wxevent = WxSpinEvent( wxGetSpinCtrlEventType(), getId() );
          wxevent.setPosition(_value);
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
              if (_value == _max) {
                if (!hasFlag(wxSP_WRAP)) {
                  return KeyEventResult.handled;    
                }
                _value = _min; 
              } else {
                _value++;
              }
            } else 
            if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
              if (_value == _min) {
                if (!hasFlag(wxSP_WRAP)) {
                  return KeyEventResult.handled;    
                }
                _value = _max; 
              } else {
                _value--;
              }
            } else {
              return KeyEventResult.ignored;
            }
            _controller.text = "$_value";
            _setState();
            final wxevent = WxSpinEvent( wxGetSpinCtrlEventType(), getId() );
            wxevent.setEventObject(this);
            wxevent.setPosition(_value);
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
