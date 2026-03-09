// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxRadioButton ----------------------

/// @nodoc

extension RadioButtonEventBinder on WxEvtHandler {
  void bindRadioButtonEvent( OnCommandEventFunc func, int id ) {
    _eventTable.add( WxCommandEventTableEntry(wxGetRadioButtonEventType(), id, func));
  }

  void unbindRadioButtonEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetRadioButtonEventType(), id));
  }
}

const int wxRB_GROUP = 0x0004;
const int wxRB_SINGLE = 0x0008;

/// Lets users choose one of several items. Selecting one automatically
/// deselects the others. 
/// 
/// The first item of a group has to use the [wxRB_GROUP] flag. 
/// 
/// In wxDart Flutter, there can be only one group of radiobutton controls
/// per parent window (the first of which needs to have the [wxRB_GROUP] flag).
/// 
/// # Event emitted
/// [RadioButton](/wxdart/wxGetRadioButtonEventType.html) event gets sent when the user selects this item. |
/// | ----------------- |
/// | void bindRadioButtonEvent( void function( [WxCommandEvent] event ) ) |
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
    _label = label;
    if (hasFlag(wxRB_GROUP)) _selection = 0;
  }

  int _selection = -1; // only set in wxRB_GROUP
  String _label = "";

  int _getIndexOfThisRadioButton()
  {
    if (hasFlag(wxRB_GROUP)) return 0;
    final parent = getParent();
    if (parent == null) return 0;
    final pos = parent._children.indexOf( this );
    if (pos < 1) return 0;
    int count = 0;
    for (int i = pos-1; i >= 0; i--) {
      final child = parent._children[i];
      if (child is WxRadioButton) count++;
      if (child.hasFlag(wxRB_GROUP)) return count;
    }
    wxLogError( "Initial radiobutton not found" );
    return 0;
  }

  WxRadioButton ?_getNthRadioButton( int n ) {
    // start in wxRB_GROUP
    if (n == 0) return this;
    final parent = getParent();
    if (parent == null) return null;
    final pos = parent._children.indexOf( this );
    if (pos == -1) return null;
    if (pos == parent._children.length-1) return null;
    int count = 0;
    for (int i = pos+1; i < parent._children.length; i++) {
      final child = parent._children[i];
      if (child is! WxRadioButton) continue;
      count++; 
      if (child.hasFlag(wxRB_GROUP)) return null; // already next group
      if (count == n) return child;
    }
    wxLogError( "Nth radiobutton not found" );
    return null;
  }

  int _getSelectionFromLeadButton() {
    if (hasFlag(wxRB_GROUP)) return _selection;
    final parent = getParent();
    if (parent == null) return 0;
    final pos = parent._children.indexOf( this );
    if (pos < 1) return 0;
    for (int i = pos-1; i >= 0; i--) {
      final child = parent._children[i];
      if (child.hasFlag(wxRB_GROUP)) {
        if (child is WxRadioButton) return child._selection;
      } 
    }
    wxLogError( "Initial radiobutton not found" );
    return 0;
  }

  void _setSelectionInLeadButton( int selection )
  {
    if (hasFlag(wxRB_GROUP)) {
      _selection = selection;
      _setState();
      return;
    }
    final parent = getParent();
    if (parent == null) return;
    final pos = parent._children.indexOf( this );
    if (pos < 1) return;
    for (int i = pos-1; i >= 0; i--) {
      final child = parent._children[i];
      if (child.hasFlag(wxRB_GROUP)) {
        if (child is WxRadioButton) {
          child._selection = selection;
          _setState();
          return;
        }
      } 
    }
    wxLogError( "Initial radiobutton not found" );
  }

  /// Selects this control and automatically deselects the currently selected radio button
  /// 
  /// Does nothing if the [value] is false
  void setValue( bool value ) {
    if (value) {
      final index = _getIndexOfThisRadioButton();
      _setSelectionInLeadButton( index );
    }
  }

  /// Returns true if this radio button is currently selected, false otherwise
  bool getValue( ) {
    return _getIndexOfThisRadioButton() == _getSelectionFromLeadButton();
  }

  @override
  Widget _build(BuildContext context)
  {
    Widget line = 
      Row( 
        mainAxisSize: MainAxisSize.min,
        children: [
            wxIsIOS() // not on macOS
            ? Radio<int>.adaptive( value: _getIndexOfThisRadioButton() )
            : Radio<int>( value: _getIndexOfThisRadioButton() )
        ,
        Text( _label )
        ] );
    return _buildControl(context, line );
  }
}
