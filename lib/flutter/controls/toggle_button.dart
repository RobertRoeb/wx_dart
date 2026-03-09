// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxToggleButton ----------------------

/// @nodoc

extension ToggleButtonEventBinder on WxEvtHandler {
  void bindToggleButtonEvent( OnCommandEventFunc func, int id ) {
    _eventTable.add( WxCommandEventTableEntry(wxGetToggleButtonEventType(), id, func));
  }

  void unbindToggleButtonEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetToggleButtonEventType(), id));
  }
}
/// Allows user to toggle a feature using a button.
/// 
/// [ToggleButton](/wxdart/wxGetToggleButtonEventType.html) event gets sent when the button is toggled or untoggled. |
/// | ----------------- |
/// | void bindToggleButtonEvent( void function( [WxCommandEvent] event ) ) |
/// | void unbindToggleButtonEvent() |
/// 
class WxToggleButton extends WxControl {

  /// Creates toggle button with given [label]
  WxToggleButton( super.parent, super.id, String label, { super.pos, super.size, super.style } )
  {
    _label = label;
  }

  String _label = "";
  bool _value = false;

/*
  WxColour ?_buttonColour;

  @override 
  void setBackgroundColour( WxColour col ) {
    _buttonColour = col;
  }
  
  @override 
  WxColour getBackgroundColour() {
    if (_buttonColour == null) {
      return super.getBackgroundColour();
    }
    return _buttonColour!;
  }
*/
  /// Returns true if button is in the toggled state
  bool getValue() {
    return _value;
  }

  /// Sets the button is in the toggled or untoggled state 
  void setValue( bool state ) {
    _value = state;
    _setState();
  }

  @override
  Widget _build(BuildContext context)
  {
    return 
      _buildControl( context, 
            ToggleButtons(
              isSelected: [ _value ],
              onPressed: isEnabled() ? (_) {
                  _value = !_value;
                  _setState();
                  final event = WxCommandEvent( wxGetToggleButtonEventType(), getId() );
                  event.setInt( _value ? 1 : 0 );
                  processEvent(event);
              } : null,
    /*
              fillColor: (_buttonColour == null) ? null : Color.fromARGB( 
                _buttonColour!.getAlpha(),
                _buttonColour!.getRed(),
                _buttonColour!.getGreen(),
                _buttonColour!.getBlue() ), */
              children: [
              Padding( 
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Text( _label )
              )
              ]
          ) );
  }
}
