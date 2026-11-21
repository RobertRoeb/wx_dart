// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- WxCommandEvent binders for WxToolbar ----------------------

// EVT_TOOL_ENTER

/// @nodoc

extension ToolEventBinder on WxEvtHandler {
  void bindToolEvent( OnCommandEventFunc func, int id ) {
    _eventTable.add( WxCommandEventTableEntry(wxGetToolEventType(), id, func));
  }

  void unbindToolEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetToolEventType(), id));
  }
}

// EVT_TOOL_ENTER

/// @nodoc

extension ToolEnterEventBinder on WxEvtHandler {
  void bindToolEnterEvent( OnCommandEventFunc func, int id ) {
    _eventTable.add( WxCommandEventTableEntry(wxGetToolEnterEventType(), id, func));
  }

  void unbindToolEnterEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetToolEnterEventType(), id));
  }
}

// EVT_TOOL_DROPDOWN 

/// @nodoc

extension ToolDropDownEventBinder on WxEvtHandler {
  void bindToolDropDownEvent( OnCommandEventFunc func, int id ) {
    _eventTable.add( WxCommandEventTableEntry(wxGetToolDropDownEventType(), id, func));
  }

  void unbindToolDropDownEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetToolDropDownEventType(), id));
  }
}
// ------------------------- WxCommandEvent binders for WxMenu ----------------------

// EVT_MENU

/// @nodoc

extension MenuEventBinder on WxEvtHandler {
  void bindMenuEvent( OnCommandEventFunc func, int id ) {
    _eventTable.add( WxCommandEventTableEntry(wxGetMenuEventType(), id, func));
  }

  void unbindMenuEvent( int id ) {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetMenuEventType(), id) ));
  }
}

// ------------------------- WxCommandEvent binders for WxRadioButton ----------------------

/// @nodoc

extension RadioButtonEventBinder on WxEvtHandler {
  void bindRadioButtonEvent( OnCommandEventFunc func, int id ) {
    _eventTable.add( WxCommandEventTableEntry(wxGetRadioButtonEventType(), id, func));
  }

  void unbindRadioButtonEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetRadioButtonEventType(), id));
  }
}

// ------------------------- WxCommandEvent binders for wxRadioBox ----------------------

/// @nodoc

extension RadioboxEventBinder on WxEvtHandler {
  void bindRadioboxEvent( OnCommandEventFunc func, int id ) {
    _eventTable.add( WxCommandEventTableEntry(wxGetRadioboxEventType(), id, func));
  }

  void unbindRadioboxEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetRadioboxEventType(), id));
  }
}

// ------------------------- WxCommandEvent binders for WxButton ----------------------

/// @nodoc

extension ButtonEventBinder on WxEvtHandler {
  void bindButtonEvent( OnCommandEventFunc func, int id ) {
    _eventTable.add( WxCommandEventTableEntry(wxGetButtonEventType(), id, func));
  }

  void unbindButtonEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetButtonEventType(), id));
  }
}

// ------------------------- WxCommandEvent binders for WxCheckBox ----------------------

/// @nodoc

extension CheckboxEventBinder on WxEvtHandler {
  void bindCheckboxEvent( OnCommandEventFunc func, int id ) {
    _eventTable.add( WxCommandEventTableEntry(wxGetCheckboxEventType(), id, func));
  }

  void unbindCheckboxEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetCheckboxEventType(), id));
  }
}

// ------------------------- WxCommandEvent binders for WxToggleButton ----------------------

/// @nodoc

extension ToggleButtonEventBinder on WxEvtHandler {
  void bindToggleButtonEvent( OnCommandEventFunc func, int id ) {
    _eventTable.add( WxCommandEventTableEntry(wxGetToggleButtonEventType(), id, func));
  }

  void unbindToggleButtonEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetToggleButtonEventType(), id));
  }
}

// ------------------------- WxCommandEvent binders for WxComboBox ----------------------

/// @nodoc

extension ComboboxEventBinder on WxEvtHandler {
  void bindComboboxEvent( OnCommandEventFunc func, int id ) {
    _eventTable.add( WxCommandEventTableEntry(wxGetComboboxEventType(), id, func));
  }

  void unbindComboboxEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetComboboxEventType(), id));
  }
}

// ------------------------- WxCommandEvent binders for WxChoice ----------------------

/// @nodoc

extension ChoiceEventBinder on WxEvtHandler {
  void bindChoiceEvent( OnCommandEventFunc func, int id ) {
    _eventTable.add( WxCommandEventTableEntry(wxGetChoiceEventType(), id, func));
  }

  void unbindChoiceEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetChoiceEventType(), id));
  }
}

// ------------------------- WxCommandEvent binders for WxListbox ----------------------

/// @nodoc

extension ListboxEventBinder on WxEvtHandler {
  void bindListboxEvent( OnCommandEventFunc func, int id ) {
    _eventTable.add( WxCommandEventTableEntry(wxGetListboxEventType(), id, func));
  }

  void unbindListboxEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetListboxEventType(), id));
  }
}

/// @nodoc

extension ListboxDClickEventBinder on WxEvtHandler {
  void bindListboxDClickEvent( OnCommandEventFunc func, int id ) {
    _eventTable.add( WxCommandEventTableEntry(wxGetListboxDClickEventType(), id, func));
  }

  void unbindListboxDClickEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetListboxDClickEventType(), id));
  }
}

// ------------------------- WxCommandEvent binders for WxSearchCtrl ----------------------

/// @nodoc

extension SearchEventBinder on WxEvtHandler {
  void bindSearchEvent( OnCommandEventFunc func, int id ) {
    _eventTable.add( WxCommandEventTableEntry(wxGetSearchEventType(), id, func));
  }

  void unbindSearchEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetSearchEventType(), id));
  }
}

/// @nodoc

extension SearchCancelEventBinder on WxEvtHandler {
  void bindSearchCancelEvent( OnCommandEventFunc func, int id ) {
    _eventTable.add( WxCommandEventTableEntry(wxGetSearchCancelEventType(), id, func));
  }

  void unbindSearchCancelEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetSearchCancelEventType(), id));
  }
}

// ------------------------- WxCommandEvent binders for WxSlider ----------------------

/// @nodoc

extension SliderEventBinder on WxEvtHandler {
  void bindSliderEvent( OnCommandEventFunc func, int id ) {
    _eventTable.add( WxCommandEventTableEntry(wxGetSliderEventType(), id, func));
  }

  void unbindSliderEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetSliderEventType(), id));
  }
}

// ------------------------- WxCommandEvent binders for WxTextCtrl ----------------------

/// @nodoc

extension TextEventBinder on WxEvtHandler {
  void bindTextEvent( OnCommandEventFunc func, int id ) {
    _eventTable.add( WxCommandEventTableEntry(wxGetTextEventType(), id, func));
  }

  void unbindTextEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetTextEventType(), id));
  }
}

/// @nodoc

extension TextEventEnterBinder on WxEvtHandler {
  void bindTextEnterEvent( OnCommandEventFunc func, int id ) {
    _eventTable.add( WxCommandEventTableEntry(wxGetTextEnterEventType(), id, func));
  }

  void unbindTextEnterEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetTextEnterEventType(), id));
  }
}

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
/// Other controls have their specialized event classes deriving from
/// [WxCommandEvent] like [WxNotebookEvent] for [WxNotebook],
/// [WxTreeEvent] for [WxTreeCtrl], [WxSpinEvent] for [WxSpinCtrl]
/// and [WxDataViewEvent] for [WxDataViewCtrl].
/// 
/// You can also define your own custom event in pure wxDart. See
/// [WxEvent] for an example of a user defined event.

class WxCommandEvent extends WxEvent {

  /// Creates the command event with the gicen event type and (window) id.
  WxCommandEvent( super.eventType, super.id ) {
    _propagationLevel = 65000;
  }

  int _int = 0;
  int _extraLong = 0;
  String _text = "";
  dynamic _clientData;

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
    _clientData = data;
  }

  /// Retrieves client data, typically associated with an item
  /// using [WxItemContainer.setClientData] inherited by [WxListBox]
  /// [WxChoice], [WxComboBox] and [WxRadioBox]
  dynamic getClientData() {
    return _clientData;
  }
}
