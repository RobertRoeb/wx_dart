// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxBitmapToggleButton ----------------------

/// Allows user to toggle a feature using a bitmap button.
/// 
/// [ToggleButton](/wxdart/wxGetToggleButtonEventType.html) event gets sent when the button is toggled or untoggled. |
/// | ----------------- |
/// | void bindToggleButtonEvent( void function( [WxCommandEvent] event ) ) |
/// | void unbindToggleButtonEvent() |

class WxBitmapToggleButton extends WxAnyButton {
  WxBitmapToggleButton( super.parent, super.id, WxBitmapBundle bitmap, { super.pos, super.size, super.style } )
  {
    setBitmap( bitmap );
  }

  bool _value = false;

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
    late Widget child;
    if (_bitmapLabel!.isOk()) {
      child = RawImage( image: _bitmapLabel!._image!  );
    } else {
      _bitmapLabel!._addListener( this );
      child = CircularProgressIndicator();
    }

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
              children: [
              child 
              ]
          ) );
  }
}
