// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01 (wxDart Web: 2026-11-15)
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- EVT_RADIOBUTTON ----------------------

const int wxRB_GROUP = 0x0004;
const int wxRB_SINGLE = 0x0008;

// ------------------------- wxRadioButton ----------------------

/// Lets users choose one of several items. Selecting one automatically
/// deselects the others. 
/// 
/// The first item of a group has to use the [wxRB_GROUP] flag. 
/// 
/// As in wxWidgets, a group consists of consecutive radio buttons with the
/// same parent; a button with [wxRB_GROUP] starts a new group and one with
/// [wxRB_SINGLE] is not part of any group. The first button of a group is
/// selected initially.
/// 
/// Example usage:
/// ```dart
///  // Create fist control
///  final radio1 = WxRadioButton( this, -1, "First choice", style: wxRB_GROUP );
///  final radio2 = WxRadioButton( this, -1, "Second choice" );
/// 
///  radio1.bindRadioButtonEvent( (event) {
///    if (event.isChecked()) {
///      // radio1 was checked
///    } else {
///      // radio1 was unchecked because
///      // radio2 was checked
///    }
///  }, -1 );
/// ```
/// 
/// Main interface
/// * [setValue]
/// * [getValue]
/// * [setLabel]
/// * [getLabel]
/// 
/// # Event emitted
/// [RadioButton](/wxdart/wxGetRadioButtonEventType.html) event gets sent when the user selects this item. |
/// | ----------------- |
/// | void bindRadioButtonEvent( void function( [WxCommandEvent] event ), int id ) |
/// | void unbindRadioButtonEvent() |
/// 
/// # Window style
/// | constant | meaning |
/// | -------- | -------- |
/// | wxRB_GROUP | 0x0004 |
/// | wxRB_SINGLE | 0x0008 (TBD)|
/// 
/// see also [WxRadioBox].

class WxRadioButton extends WxControl {

  /// Creates a radio button with the given [id] and [label]. Use wxRB_GROUP to indicate
  /// that this control is the beginning of a group of controls
  WxRadioButton( super.parent, super.id, String label, { super.pos, super.size, super.style } )
  {
    setLabel( label );
    final leader = _groupLeader();
    _jsRadioSetGroup( _handle, leader._handle );
    if (leader == this && !hasFlag( wxRB_SINGLE )) {
      // the first button of a group is selected initially
      _value = true;
      _jsCheckSet( _handle, 1 );
    }
  }

  bool _value = false;

  @override
  String get _jsKind => 'radio';

  @override
  void setLabel( String label ) {
    _label = label;
    _jsSetLabel( _handle, _wxStripMnemonic( label ) );
    _labelOrFontChanged();
  }

  /// The first button of the group this button belongs to: the closest
  /// preceding sibling with wxRB_GROUP, or the first radio button in a row
  WxRadioButton _groupLeader() {
    if (hasFlag( wxRB_GROUP ) || hasFlag( wxRB_SINGLE )) return this;
    final parent = getParent();
    if (parent == null) return this;
    final siblings = parent._children;
    WxRadioButton leader = this;
    for (int i = siblings.indexOf( this ) - 1; i >= 0; i--) {
      final child = siblings[i];
      if (child is! WxRadioButton) break;
      leader = child;
      if (child.hasFlag( wxRB_GROUP ) || child.hasFlag( wxRB_SINGLE )) break;
    }
    return leader;
  }

  /// All buttons of the group
  List<WxRadioButton> _group() {
    final leader = _groupLeader();
    if (leader.hasFlag( wxRB_SINGLE )) return [leader];
    final parent = leader.getParent();
    if (parent == null) return [this];
    final siblings = parent._children;
    final group = <WxRadioButton>[leader];
    for (int i = siblings.indexOf( leader ) + 1; i < siblings.length; i++) {
      final child = siblings[i];
      if (child is! WxRadioButton || child.hasFlag( wxRB_GROUP ) || child.hasFlag( wxRB_SINGLE )) break;
      group.add( child );
    }
    return group;
  }

  /// Selects this control and automatically deselects the currently selected radio button
  ///
  /// Does nothing if the [value] is false
  void setValue( bool value ) {
    if (value) {
      for (final button in _group()) {
        button._value = button == this;
      }
    } else {
      _value = false;
    }
    _jsCheckSet( _handle, value ? 1 : 0 );
  }

  /// Returns true if this radio button is currently selected, false otherwise
  bool getValue( ) {
    return _value;
  }

  void _onJsRadio() {
    for (final button in _group()) {
      button._value = button == this;
    }
    final event = WxCommandEvent( wxGetRadioButtonEventType(), getId() );
    event.setInt( 1 );
    event.setEventObject( this );
    processEvent( event );
  }
}
