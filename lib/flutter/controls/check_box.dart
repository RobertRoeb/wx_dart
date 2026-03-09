// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxCheckBox ----------------------

/// @nodoc

extension CheckboxEventBinder on WxEvtHandler {
  void bindCheckboxEvent( OnCommandEventFunc func, int id ) {
    _eventTable.add( WxCommandEventTableEntry(wxGetCheckboxEventType(), id, func));
  }

  void unbindCheckboxEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetCheckboxEventType(), id));
  }
}

const int wxCHK_2STATE = 0x4000;
const int wxCHK_3STATE = 0x1000;
const int wxCHK_ALLOW_3RD_STATE_FOR_USER = 0x2000;
const int wxCHK_UNCHECKED = 0;
const int wxCHK_CHECKED = 1;
const int wxCHK_UNDETERMINED = 2;

/// Lets the user check a box.
/// 
/// # Event emitted
/// [Checkbox](/wxdart/wxGetCheckboxEventType.html) event gets sent when the user checks or unchecks |
/// | ----------------- |
/// | void bindCheckboxEvent( void function( [WxCommandEvent] event ) ) |
/// | void unbindCheckboxEvent() |
/// 
/// # Window style
/// | constant | meaning |
/// | -------- | -------- |
/// | wxCHK_2STATE | 0x4000 (2 state checkbox, the default) |
/// | wxCHK_3STATE | 0x1000 (supports intermediate state, but only programmatically) |
/// | wxCHK_ALLOW_3RD_STATE_FOR_USER | 0x2000 (supports intermediate state by the user) |

class WxCheckBox extends WxControl {
  WxCheckBox( super.parent, super.id, this.label, { super.pos = wxDefaultPosition, super.size = wxDefaultSize, super.style = 0 } );

  String label;
  bool? value = false;

  /// Returns true if controls is checked
  bool isChecked( ) {
    return getValue();
  }

  /// checks for hasFlag(wxCHK_3STATE)
  bool is3State( ) {
    return hasFlag(wxCHK_3STATE);
  }

  /// checks for hasFlag(wxCHK_ALLOW_3RD_STATE_FOR_USER)
  bool is3rdStateAllowedForUser( ) {
    return hasFlag(wxCHK_ALLOW_3RD_STATE_FOR_USER);
  }

/// Returns value of tri-state checkbox
///
/// # Return value
/// | constant | meaning |
/// | -------- | -------- |
/// | wxCHK_UNCHECKED | 0 |
/// | wxCHK_CHECKED | 1 |
/// | wxCHK_UNDETERMINED | 2 |

  int get3StateValue( ) {
    if (value == null) {
      return 2;
    }
    if (value!) {
      return 1;
    }
    return 0;  
  }

  /// Returns true if checked
  bool getValue() {
    if (value == null) {
      return false; // when called in tri state mode...
    } 
    return value!;
  }

  /// Checks or unchecks control according to [state]
  void setValue( bool state ) {
    value = state;
    _setState();
  }

/// Sets value of tri-state checkbox
///
/// # value of [state]
/// | constant | meaning |
/// | -------- | -------- |
/// | wxCHK_UNCHECKED | 0 |
/// | wxCHK_CHECKED | 1 |
/// | wxCHK_UNDETERMINED | 2 |
  void set3StateValue( int state ) {
    if (state == 0) {
      value = false;
    } else if (state == 1) {
      value = true;
    } else {
      value = null;
    }
    _setState();
  }

  @override
  Widget _build(BuildContext context) {
    return 
      _buildControl( context, 
        Row(
          mainAxisSize: MainAxisSize.min, 
          children: [
            wxIsIOS() // no on macOS
            ? Checkbox.adaptive(
              value: value, 
              tristate: hasFlag(wxCHK_3STATE),
              onChanged: isEnabled() ? _onChanged: null )
            : Checkbox(
              value: value, 
              tristate: hasFlag(wxCHK_3STATE),
              onChanged: isEnabled() ? _onChanged: null ),
              Text( label )
          ] ) );
  }

  void _onChanged( bool? selected)
  {
    if ((selected == null) && !hasFlag(wxCHK_ALLOW_3RD_STATE_FOR_USER))
    {
      selected = false;
    }
    value = selected;
    _setState();
    final event = WxCommandEvent( wxGetCheckboxEventType(), getId() );
    event.setInt( get3StateValue() );
    processEvent(event);  }
}
