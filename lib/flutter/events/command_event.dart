// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxCommandEvent ----------------------

typedef OnCommandEventFunc = void Function( WxCommandEvent event );

/// Events that are usually sent after some user actions.
/// 
/// Different from classes deriving directly from [WxEvent], command
/// event get propagated up the window hierarchy until they are handled
/// or until a toplevel window ([WxDialog] or [WxFrame]) is reached. 
/// 
/// This event is used by numerous controls as their event class
/// holding the relevant event information. This includes [WxButton],
/// [WxCheckBox], [WxListBox], [WxTextCtrl], [WxChoice], [WxComboBox]
/// and [WxMenu] and [WxToolBar].
/// 
/// Other controls have their specilized event classes deriving from
/// [WxCommandEvent] like [WxNotebookEvent] for [WxNotebook],
/// [WxTreeEvent] for [WxTreeCtrl], [WxSpinEvent] for [WxSpinCtrl]
/// and [WxDataViewEvent] for [WxDataViewCtrl]-

class WxCommandEvent extends WxEvent {
  WxCommandEvent( super._eventType, super._id );

  int _int = 0;
  int _extraLong = 0;
  String _text = "";
  dynamic _data;

  /// Sets string content, usually by the system.
  void setString( String text ) {
    _text = text; 
  }

  /// Get sting content. Could be the text of a [WxTextCtrl] or the
  /// selected entry in a [WxListBox]
  String getString() {
    return _text;
  }

  /// Sets integer content, usually by the system.
  int getInt( ) {
    return _int;
  }

  /// Returns an integer value. Could be selection index.
  void setInt( int intCommand ) {
    _int = intCommand;
  }

  /// Some other integer value,
  int getExtraLong( ) {
    return _extraLong;
  }

  /// Some other integer value,
  void setExtraLong( int extraLong ) {
    _extraLong = extraLong;
  }

  /// Returns index of selected item, e.g. from a [WxChoice]
  int getSelection( ) {
    return _int;
  }

  /// Returns true if item was checked, e.g. from a [WxCheckBox] 
  bool isChecked( ) {
    return _int == 1;
  }

  /// If this is a selection event not deselection, from controls
  /// allow multiple item to be selected and unselected 
  bool isSelection( ) {
    return _extraLong == 1;
  }

  /// Set client data associated with the event
  void setClientData( dynamic data ) {
    _data = data;
  }

  /// Retrieves client data, typically associated with an item
  /// using [WxItemContainer.setClientData] inherited by [WxListBox]
  /// [WxChoice], [WxComboBox] and [WxRadioBox]
  dynamic getClientData() {
    return _data;
  }
}
