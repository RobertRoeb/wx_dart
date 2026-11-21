// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ----------------------- WxInitDialogEvent binder --------------------

/// @nodoc

extension InitDialogEventBinder on WxEvtHandler {
  void bindInitDialogEvent( OnInitDialogEventFunc func ) {
    _eventTable.add( WxInitDialogEventTableEntry(wxGetInitDialogEventType(), -1, func));
  }

  void unbindInitDialogEvent() {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetInitDialogEventType(), -1) ));
  }
}

// ----------------------- WxDialogValidateEvent binder --------------------

/// @nodoc

extension DialogValidateEventBinder on WxEvtHandler {
  void bindDialogValidateEvent( OnDialogValidateEventFunc func, int id ) {
    _eventTable.add( WxDialogValidateEventTableEntry(wxGetDialogValidateEventType(), id, func));
  }

  void unbindDialogValidateEvent( int id ) {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetDialogValidateEventType(), id) ));
  }
}

// ------------------------- WxInitDialogEvent ----------------------

typedef OnInitDialogEventFunc = void Function( WxInitDialogEvent event );

/// @nodoc

class WxInitDialogEventTableEntry extends WxEventTableEntry {
  WxInitDialogEventTableEntry( super.eventType, super.id, this.func );
  final OnInitDialogEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return (eventType == eventTypeTested);
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxInitDialogEvent) {
      func( event );
    }
  }
}

/// [InitDialog](/docs/wxdart/wxGetInitDialogEventType.html) event gets sent when the dialog is ready and data can be transferred to it. |
/// | ----------------- |
/// | void bindInitDialogEvent( void function( [WxInitDialogEvent] event  ) ) |
/// | void unbindInitDialogEvent() |
/// 
/// See also [WxDialogValidateEvent].

class WxInitDialogEvent extends WxEvent {
  WxInitDialogEvent( { int id = 0 } ) : super( wxGetInitDialogEventType(), id );
}

// ------------------------- WxDialogValidateEvent ----------------------

typedef OnDialogValidateEventFunc = void Function( WxDialogValidateEvent event );

/// @nodoc

class WxDialogValidateEventTableEntry extends WxEventTableEntry {
  WxDialogValidateEventTableEntry( super.eventType, super.id, this.func );
  final OnDialogValidateEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return (eventType == eventTypeTested) && ((id == wxID_ANY) || (id == idTested));
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxDialogValidateEvent) {
      func( event );
    }
  }
}
/// Sent when you should validate data entered in a dialog. This event can be vetoed if the input in the dialog is invalid.
/// 
/// This event is not present in C++ wxWidgets where the same effect is achieved by
/// overriding wxWindow::Validate().
/// 
/// Call [WxNotifyEvent.veto] to inform the dialog not to close itself
/// since the entered data was in some way wrong.
///
/// [DialogValidate](/docs/wxdart/wxGetDialogValidateEventType.html) event gets sent when user presses OK and data should be validated and transferred. |
/// | ----------------- |
/// | void bindDialogValidateEvent( void function( [WxDialogValidateEvent] event ), int id ) |
/// | void unbindDialogValidateEvent( int id ) |
/// 
/// See also [WxInitDialogEvent].
/// 
///```dart
///     // Validate entered data and transfer it somewhere if OK
///     bindDialogValidateEvent( (event) {
///       final newdata = text.getValue();
///       // do some test on newdata
///       if (newdata.length > 17) {
///         // text too long! veto event (don't allow to close the dialog)
///         event.veto();
///         return;
///       } else {
///         // data looks good, transfer data back
///         data = newdata;
///       }
///     }, -1); 
///   }
/// }
///``` 

class WxDialogValidateEvent extends WxNotifyEvent {
  WxDialogValidateEvent( { int id = 0 } ) : super( wxGetDialogValidateEventType(), id );
}
