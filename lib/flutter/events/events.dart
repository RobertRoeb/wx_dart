// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ----------------------- event types  ----------------------

int wxGetMenuEventType()            { return 101; }
int wxGetMenuOpenEventType()        { return 103; }
int wxGetMenuCloseEventType()       { return 104; }
int wxGetMenuHighlightEventType()   { return 105; }

int wxGetSetFocusEventType()        { return 106; }
int wxGetKillFocusEventType()       { return 107; }
int wxGetShowEventType()            { return 108; }

int wxGetCloseWindowEventType()     { return 109; }
int wxGetSizeEventType()            { return 110; }
int wxGetPaintEventType()           { return 111; }

int wxGetMoveEventType()            { return 112; }
int wxGetMoveStartEventType()       { return 113; }
int wxGetMoveEndEventType()         { return 114; }

int wxGetQueryEndSessionEventType() { return 115; }
int wxGetEndSessionEventType()      { return 116; }

int wxGetTimerEventType()           { return 117; }
int wxGetIdleEventType()            { return 118; }
int wxGetUpdateUIEventType()        { return 119; }

int wxGetScrollEventType()          { return 120; }
int wxGetScrollWinEventType()       { return 121; }
int wxGetScrollWinThumbTrackEventType()  { return wxGetScrollWinEventType(); } // simplify as same

int wxGetToolEventType()            { return wxGetMenuEventType(); }
int wxGetToolEnterEventType()       { return 125; }
int wxGetToolDropDownEventType()    { return 126; }

int wxGetLeftDownEventType()        { return 130; }
int wxGetRightDownEventType()       { return 131; }
int wxGetMiddleDownEventType()      { return 132; }
int wxGetLeftUpEventType()          { return 133; }
int wxGetRightUpEventType()         { return 134; }
int wxGetMiddleUpEventType()        { return 135; }
int wxGetLeftDClickEventType()      { return 136; }
int wxGetRightDClickEventType()     { return 137; }
int wxGetMiddleDClickEventType()    { return 138; }
int wxGetMotionEventType()          { return 139; }
int wxGetEnterWindowEventType()     { return 140; }
int wxGetLeaveWindowEventType()     { return 141; }
int wxGetMouseWheelEventType()      { return 142; }
int wxGetMagnifyEventType()         { return 143; }

int wxGetKeyDownEventType()         { return 150; }
int wxGetKeyUpEventType()           { return 151; }
int wxGetCharEventType()            { return 152; }
int wxGetCharHookEventType()        { return 153; }

int wxGetActivateEventType()        { return 161; }
int wxGetHibernateEventType()       { return 160; }
int wxGetActivateAppEventType()     { return 161; }

int wxGetDPIChangedEventType()         { return 162; }
int wxGetSysColourChangedEventType()   { return 163; }

int wxGetInitDialogEventType()         { return 170; }
int wxGetDialogValidateEventType()     { return 171; }
int wxGetWindowCreateEventType()       { return 172; }
int wxGetPopupWindowDismissEventType() { return 173; }

int wxGetButtonEventType()          { return 200; }
int wxGetCheckboxEventType()        { return 201; }
int wxGetChoiceEventType()          { return 202; }
int wxGetRadioboxEventType()        { return 203; }
int wxGetListboxEventType()         { return 204; }
int wxGetListboxDClickEventType()   { return 205; }
int wxGetComboboxEventType()        { return 206; }
int wxGetSliderEventType()          { return 207; }
int wxGetRadioButtonEventType()     { return 208; }
int wxGetToggleButtonEventType()    { return 209; }

int wxGetTextEventType()            { return 210; }
int wxGetTextEnterEventType()       { return 211; }
int wxGetTextUrlEventType()         { return 212; }
int wxGetTextMaxLenEventType()      { return 213; }

int wxGetSpinEventType()            { return 215; }
int wxGetSpinUpEventType()          { return 216; }
int wxGetSpinDownEventType()        { return 217; }
int wxGetSpinCtrlEventType()        { return 218; }
int wxGetSpinCtrlDoubleEventType()  { return 219; }

int wxGetNotebookPageChangingEventType()        { return 220; }
int wxGetNotebookPageChangedEventType()         { return 221; }

int wxGetNavCtrlPageChangedEventType()          { return 222; }
int wxGetNavCtrlPageChangingEventType()         { return 223; }

int wxGetSplitterSashPosChangedEventType()      { return 225; }
int wxGetSplitterSashPosChangingEventType()     { return 226; }
int wxGetSplitterUnsplitEventType()             { return 227; }
int wxGetSplitterDoubleClickEventType()         { return 228; }

int wxGetTreeItemActivatedEventType()           { return 230; }
int wxGetTreeSelChangedEventType()              { return 231; }
int wxGetTreeItemExpandedEventType()            { return 232; }
int wxGetTreeItemCollapsedEventType()           { return 233; }
int wxGetTreeDeleteItemEventType()              { return 234; }

int wxGetHyperlinkEventType()                   { return 240; }
int wxGetHtmlLinkClickEventType()               { return 241; }
int wxGetCollapsiblePaneChangedEventType()      { return 242; }
int wxGetSearchEventType()                      { return 243; }
int wxGetSearchCancelEventType()                { return 244; }

int wxGetTreebookPageChangedEventType()         { return 250; }
int wxGetTreebookPageChangingEventType()        { return 251; }
int wxGetTreebookNodeCollapsedEventType()       { return 252; }
int wxGetTreebookNodeExpandedEventType()        { return 253; }

int wxGetGesturePanEventType()                  { return 260; }
int wxGetGestureZoomEventType()                 { return 261; }

int wxGetDropDataEventType()                    { return 270; }
int wxGetDropDropEventType()                    { return 271; }
int wxGetDropEnterEventType()                   { return 272; }
int wxGetDropLeaveEventType()                   { return 273; }
int wxGetDropDragOverEventType()                { return 274; }

int wxGetDragFeedbackEventType()                { return 275; }

// ------------------------- wxGestureEvent ----------------------

/// Base class for gesture events on touch interfaces

class WxGestureEvent extends WxEvent {
  WxGestureEvent( int id, int type ) : super( type, id );

  WxPoint _pos = WxPoint.zero;
  bool _isStart = false;
  bool _isEnd = false;

  void setPosition( WxPoint pos ) {
    _pos = pos; 
  }

  /// Returns position of the last touch, if available
  WxPoint getPosition( ) {
    return _pos;
  }

  /// Indicate that this is the start of a gesture. Done by the system.
  void setGestureStart( { bool isStart = true } ) {
    _isStart = isStart;
  }

  /// Returns true if this is the start of a gesture.
  bool isGestureStart( ) {
    return _isStart;
  }

  /// Indicate that this is the end of a gesture. Done by the system.
  void setGestureEnd( { bool isEnd = true } ) {
    _isEnd = isEnd;
  }

  /// Returns true if this is the end of a gesture.
  bool isGestureEnd( ) {
    return _isEnd;
  }
}

// ------------------------- wxPanGestureEvent ----------------------

typedef OnPanGestureEventFunc = void Function( WxPanGestureEvent event );

/// @nodoc

class WxPanGestureEventTableEntry extends WxEventTableEntry {
  WxPanGestureEventTableEntry( super.eventType, super.id, this.func );
  final OnPanGestureEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return eventType == eventTypeTested;
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxPanGestureEvent) {
      func( event );
    }
  }
}

/// @nodoc

extension PanGestureEventBinder on WxEvtHandler {
  void bindGesturePanEvent( OnPanGestureEventFunc func ) {
    _eventTable.add( WxPanGestureEventTableEntry(wxGetGesturePanEventType(), -1, func));
  }

  void unbindGesturePanEvent() {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetGesturePanEventType(), -1) ));
  }
}

/// Gesture event indicating that the user is moving (something on) the screen around
/// 
/// [getDelta] refers to the distance from the start of the pan.
/// 
/// This event needs to be enabled with [WxWindow.enableTouchEvents].
/// 
/// [GesturePan](/wxdart/wxGetGesturePanEventType.html) event gets sent when the user pans on a touch screen. |
/// | ----------------- |
/// | void bindGesturePanEvent( OnPanGestureEventFunc ) |
/// | void unbindGesturePanEvent() |

class WxPanGestureEvent extends WxGestureEvent {
  WxPanGestureEvent( int id ) : super( id, wxGetGesturePanEventType() );

  WxPoint _delta = WxPoint.zero;

  /// Sets the delta. Done by the system.
  void setDelta( WxPoint delta ) {
    _delta = delta;
  }

  /// Returns the distance moved since the last event. Not from the start.
  WxPoint getDelta( ) {
    return _delta;
  }
}

// ------------------------- wxZoomGestureEvent ----------------------

typedef OnZoomGestureEventFunc = void Function( WxZoomGestureEvent event );

/// @nodoc

class WxZoomGestureEventTableEntry extends WxEventTableEntry {
  WxZoomGestureEventTableEntry( super.eventType, super.id, this.func );
  final OnZoomGestureEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return eventType == eventTypeTested;
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxZoomGestureEvent) {
      func( event );
    }
  }
}

/// @nodoc

extension ZoomGestureEventBinder on WxEvtHandler {
  void bindGestureZoomEvent( OnZoomGestureEventFunc func ) {
    _eventTable.add( WxZoomGestureEventTableEntry(wxGetGestureZoomEventType(), -1, func));
  }

  void unbindGestureZoomEvent() {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetGestureZoomEventType(), -1) ));
  }
}

/// Gesture event indicating that the user is zooming something on screen
/// 
/// [getZoomFactor] refers to the zoomfactor from the start of the gesture and starts with 1.0
/// 
/// This event needs to be enabled with [WxWindow.enableTouchEvents].
/// 
/// [GestureZoom](/wxdart/wxGetGestureZoomEventType.html) event gets sent when user zooms with two fingers. |
/// | ----------------- |
/// | void bindGestureZoomEvent( OnZoomGestureEventFunc ) |
/// | void unbindGestureZoomEvent() |

class WxZoomGestureEvent extends WxGestureEvent {
  WxZoomGestureEvent( int id ) : super( id, wxGetGestureZoomEventType() );

  double _zoom = 1.0;

  /// Sets zoom factor. Done by the system.
  void setZoomFactor( double factor ) {
    _zoom = factor;
  }

  /// Returns zoom factor relative to the beginning of the zoom gesture.
  double getZoomFactor( ) {
    return _zoom;
  }
}

// ------------------------- WxWindowCreateEvent ----------------------

typedef OnWindowCreateEventFunc = void Function( WxWindowCreateEvent event );

/// @nodoc

class WxWindowCreateEventTableEntry extends WxEventTableEntry {
  WxWindowCreateEventTableEntry( super.eventType, super.id, this.func );
  final OnWindowCreateEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return (eventType == eventTypeTested) && ((id == wxID_ANY) || (id == idTested));
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxWindowCreateEvent) {
      func( event );
    }
  }
}

/// Indicated that the window has been created (and not just the class
/// representing it). Certain actions require a window to be created
/// before they can be done. 
/// 
/// The is a [WxCommandEvent] and such gets sent to parent windows if
/// not consumed.
///
/// [WindowCreate](/wxdart/wxGetWindowCreateEventType.html) event gets sent when a window was created by or in the system |
/// | ----------------- |
/// | void bindWindowCreateEvent( void function( [WxWindowCreateEvent] event, int id ) |
/// | void unbindWindowCreateEvent( int id ) |
/// 
class WxWindowCreateEvent extends WxCommandEvent {
  WxWindowCreateEvent( WxWindow? win ) : super( wxGetWindowCreateEventType(), win != null ? win.getId() : 0 ) {
    _window = win;
  }

  /// Returns the window that was created
  WxWindow? getWindow( ) {
    return _window;
  }
  WxWindow? _window;
}

/// @nodoc

extension WindowCreateEventBinder on WxEvtHandler {
  void bindWindowCreateEvent( OnWindowCreateEventFunc func, int id ) {
    _eventTable.add( WxWindowCreateEventTableEntry(wxGetWindowCreateEventType(), id, func));
  }

  void unbindWindowCreateEvent(int id) {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetWindowCreateEventType(), -1) ));
  }
}

// ------------------------- wxActivateEvent ----------------------

typedef OnActivateEventFunc = void Function( WxActivateEvent event );

/// @nodoc

class WxActivateEventTableEntry extends WxEventTableEntry {
  WxActivateEventTableEntry( super.eventType, super.id, this.func );
  final OnActivateEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return eventType == eventTypeTested;
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxActivateEvent) {
      func( event );
    }
  }
}

const int wxACTIVATE_REASON_MOUSE = 0;
const int wxACTIVATE_REASON_UNKNOWN = 1;

/// Gets sent to the the app if the it gets activated or hibernated.
///
/// [ActivateApp](/wxdart/wxGetActivateAppEventType.html) event gets sent when the app gets activated or deactived. |
/// | ----------------- |
/// | void bindActivateAppEvent( OnActivateEventFunc ) |
/// | void unbindActivateAppEvent() |
/// 
/// [Activate](/wxdart/wxGetActivateEventType.html) event gets sent when the app gets activated (TBD clarify difference). |
/// | ----------------- |
/// | void bindActivateEvent( OnActivateEventFunc ) |
/// | void unbindActivateEvent() |
/// 
/// [Hibernate](/wxdart/wxGetHibernateEventType.html) event gets sent when app gets hibernated by the system. |
/// | ----------------- |
/// | void bindHibernateEvent( OnActivateEventFunc ) |
/// | void unbindHibernateEvent() |
/// # Constants
/// [ constant | meaning |
/// | -------- | -------- |
/// | wxACTIVATE_REASON_MOUSE | 0 (activation was caused by mouse) |
/// | wxACTIVATE_REASON_UNKNOWN | 1 (any other reason) |

class WxActivateEvent extends WxEvent {
  WxActivateEvent( int type, { bool active = true, int id = 0, int reason = wxACTIVATE_REASON_UNKNOWN } ) 
    : super( type, id ) {
    _active = active;
    _activationReason = reason;
  }

  late bool _active;
  late int _activationReason;

  /// Returns true if the app got activated, false otherwise
  bool getActive( ) {
    return _active;
  }

/// Returns reason for activation, if known
/// ## Constants
/// [ constant | meaning |
/// | -------- | -------- |
/// | wxACTIVATE_REASON_MOUSE | 0 (activation was caused by mouse) |
/// | wxACTIVATE_REASON_UNKNOWN | 1 (any other reason) |
  int getActivationReason( ) {
    return _activationReason;
  }
}

// ------------------------- WxDPIChangedEvent ----------------------

typedef OnDPIChangedEventFunc = void Function( WxDPIChangedEvent event );

/// @nodoc

class WxDPIChangedEventTableEntry extends WxEventTableEntry {
  WxDPIChangedEventTableEntry( super.eventType, super.id, this.func );
  final OnDPIChangedEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return eventType == eventTypeTested;
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxDPIChangedEvent) {
      func( event );
    }
  }
}

/// [DPIChanged](/docs/wxdart/wxGetDPIChangedEventType.html) event gets sent when the screen resolution changes. Also when a window gets dragged between different monitors. |
/// | ----------------- |
/// | void bindDPIChangedEvent( void function( [WxDPIChangedEvent] event ) |
/// | void unbindDPIChangedEvent() |

class WxDPIChangedEvent extends WxEvent {
  WxDPIChangedEvent( { int id = 0 } ) : super( wxGetDPIChangedEventType(), id ) {
    _newDPI = WxSize( 96, 96 );
    _oldDPI = WxSize( 96, 96 );
  }

  WxSize getOldDPI( ) {
    return _oldDPI;
  }

  WxSize getNewDPI( ) {
    return _newDPI;
  }

  late WxSize _oldDPI;
  late WxSize _newDPI;
}

// ------------------------- WxSysColourChangedEvent ----------------------

typedef OnSysColourChangedEventFunc = void Function( WxSysColourChangedEvent event );

/// @nodoc

class WxSysColourChangedEventTableEntry extends WxEventTableEntry {
  WxSysColourChangedEventTableEntry( super.eventType, super.id, this.func );
  final OnSysColourChangedEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return eventType == eventTypeTested;
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxSysColourChangedEvent) {
      func( event );
    }
  }
}

/// [SysColourChanged](/docs/wxdart/wxGetSysColourChangedEventType.html) event gets sent when themes or light/dark modes have changed. |
/// | ----------------- |
/// | void bindSysColourChangedEvent( void function( [WxSysColourChangedEvent] event ) ) |
/// | void unbindSysColourChangedEvent() |

class WxSysColourChangedEvent extends WxEvent {
  WxSysColourChangedEvent( { int id = 0 } ) : super( wxGetSysColourChangedEventType(), id );
}

// ------------------------- wxInitDialogEvent ----------------------

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

// ------------------------- wxDialogValidateEvent ----------------------

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

// ------------------------- wxScrollWinEvent ----------------------

typedef OnScrollWinEventFunc = void Function( WxScrollWinEvent event );

/// @nodoc

class WxScrollWinEventTableEntry extends WxEventTableEntry {
  WxScrollWinEventTableEntry( super.eventType, super.id, this.func );
  final OnScrollWinEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return (eventType == eventTypeTested) && (idTested == id);
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxScrollWinEvent) {
      func( event );
    }
  }
}

/// System event that gets emitted if scrolling has occured.
/// 
/// The is the main event emitted by [WxScrolledWindow] after some user action
/// (like clicking on a scrollbar or typing the PageDn key). 
///  
/// [ScrollWin](/wxdart/wxGetScrollWinEventType.html) event gets sent when any scrolling has occured |
/// | ----------------- |
/// | void bindScrollWinEvent( void function( [WxScrollWinEvent] event ) |
/// | void unbindScrollWinEvent() |

class WxScrollWinEvent extends WxEvent {
  /// Creates the event. Done by [WxScrolledWindow].
  WxScrollWinEvent( int eventType, { int orientation = 0, int position = 0 } ) : super( eventType, -1 )
  {
    _orientation = orientation;
    _position = position;
  }

  late int _orientation;
  late int _position;
  int _pixelOffset = 0;

  /// Sets the orientation to either [wxHORIZONTAL] or [wxVERTICAL]
  void setOrientation( int orient ) {
    _orientation = orient;
  }
  /// Returns either [wxHORIZONTAL] or [wxVERTICAL]
  int getOrientation() {
    return _orientation;
  }
  void setPosition( int pos ) {
    _position = pos;
  }
  /// Returns the position _in scroll units_, not pixels.
  int getPosition() {
    return _position;
  }

  /// Sets the offset from the scroll position in pixels.
  void setPixelOffset( int pos ) {
    _pixelOffset = pos;
  }

  /// Returns the pixel offset (in addition to the value returned by [getPosition]).
  /// 
  /// [getPosition] returns the position in scroll units (often 10 pixels), but scrolling
  /// may occur in smaller steps for smooth scrolling. This function returns the additional
  /// precision (0-9 if scroll units are 10 pixels).
  int getPixelOffset() {
    return _pixelOffset;
  }
}

// ------------------------- wxShowEvent ----------------------

typedef OnShowEventFunc = void Function( WxShowEvent event );

/// @nodoc

class WxShowEventTableEntry extends WxEventTableEntry {
  WxShowEventTableEntry( super.eventType, super.id, this.func );
  final OnShowEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return eventType == eventTypeTested;
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxShowEvent) {
      func( event );
    }
  }
}

class WxShowEvent extends WxEvent {
  WxShowEvent( int id, { show = true } ) : super( wxGetShowEventType(), id ) {  
    _show = show;
  }

  bool _show = true;

  bool isShown( ) {
    return _show;
  }

  void setShow( bool show ) {
    _show = show;
  }
}

// ------------------------- wxFocusEvent ----------------------

typedef OnFocusEventFunc = void Function( WxFocusEvent event );

/// @nodoc

class WxFocusEventTableEntry extends WxEventTableEntry {
  WxFocusEventTableEntry( super.eventType, super.id, this.func );
  final OnFocusEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return eventType == eventTypeTested;
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxFocusEvent) {
      func( event );
    }
  }
}

/// [WxFocusEvent] gets sent when a control or window receives or loses the focus.
/// 
/// [SetFocus](/docs/wxdart/wxGetSetFocusEventType.html) event gets sent when window has received focus. |
/// | ----------------- |
/// | void bindSetFocusEvent( void function( [WxFocusEvent] event ) |
/// | void unbindSetFocusEvent() |
/// 
/// [KillFocus](/docs/wxdart/wxGetKillFocusEventType.html) event gets sent when window has lost the focus. |
/// | ----------------- |
/// | void bindKillFocusEvent( void function( [WxFocusEvent] event ) |
/// | void unbindKillFocusEvent() |

class WxFocusEvent extends WxEvent {
  WxFocusEvent( super.type, super.id ); 

  WxWindow? _window;

  WxWindow? getWindow( ) {
    return _window;
  }

  void setWindow( WxWindow window ) {
    _window = window;
  }
}

// ------------------------- wxMoveEvent ----------------------

typedef OnMoveEventFunc = void Function( WxMoveEvent event );

/// @nodoc

class WxMoveEventTableEntry extends WxEventTableEntry {
  WxMoveEventTableEntry( super.eventType, super.id, this.func );
  final OnMoveEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return eventType == eventTypeTested;
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxMoveEvent) {
      func( event );
    }
  }
}

/// [WxMoveEvent] gets sent when a window moves position.
/// 
/// This event it not reliably sent by all ports.
///
/// [Move](/docs/wxdart/wxGetMoveEventType.html) event gets sent when a window was moved. |
/// | ----------------- |
/// | void bindMoveEvent( void function( [WxMoveEvent] event ) |
/// | void unbindMoveEvent() |

class WxMoveEvent extends WxEvent {
  WxMoveEvent( this._position, int id ) : super( wxGetMoveEventType(), id ) {
    _rect = WxRect.zero();
  }

  WxPoint _position;
  late WxRect _rect; 

  WxPoint getPosition( ) {
    return _position;
  }

  void setPosition( WxPoint pt ) {
    _position = pt;
  }

  WxRect getRect( ) {
    return _rect;
  }

  void setRect( WxRect rect ) {
    _rect = rect;
  }
}

// ------------------------- wxCloseEvent ----------------------

typedef OnCloseEventFunc = void Function( WxCloseEvent event );

/// @nodoc

class WxCloseEventTableEntry extends WxEventTableEntry {
  WxCloseEventTableEntry( super.eventType, super.id, this.func );
  final OnCloseEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return eventType == eventTypeTested;
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxCloseEvent) {
      func( event );
    }
  }
}

/// [WxCloseEvent] event gets sent when a top level window gets closed, e.g. after the x
/// button was pressed.
/// 
/// Main interface
/// * [veto]
/// 
/// Example usage:
/// ```Dart
/// class MyFrame extends WxFrame {
///   MyFrame( WxFrame? parent) : super( parent, -1, "Hello World", size: WxSize(900, 700) ) 
///   {
///     // Create a menu bar
///     final menubar = WxMenuBar();
/// 
///     // Create a menu 
///     final filemenu = WxMenu();
/// 
///     // Append menu item for Quit
///     filemenu.appendItem( wxID_EXIT, "Quit app\tCtrl-Q", help: "Run, baby, run!" );
///     // Attach menu to menu bar
///     menubar.append(filemenu, "File");
/// 
///     // Attach menu bar to this frame
///     setMenuBar(menubar);
/// 
///     // Bind this function to wxID_EXIT (which is a pre-defined ID) used
///     // in the 'Quit' menu item. In the handler, request to close the WxFrame
///     bindMenuEvent( (_) => close(false), wxID_EXIT );
/// 
///     // Someone requested to close. This could also come from the user clicking
///     // on the X button at the top of a window, or from a menu, or programmatically
///     // by calling WxFrame.close() as above.
///     bindCloseWindowEvent( (event) { 
///       // You could try to veto
///       // event.veto( true ); 
///       // return
/// 
///       // otherwise, go ahead and quit by destroying the WxFrame
///       destroy();
///     } );
///   }
/// }
/// ```
/// 
/// [CloseWindow](/wxdart/wxGetCloseWindowEventType.html) event gets sent when a [WxFrame] got a request to close. |
/// | ----------------- |
/// | void bindCloseWindowEvent( void function( [WxCloseEvent] event ) |
/// | void unbindCloseWindowEvent() |
/// 
/// This event can be vetoed, e.g. when data needs to be saved. The veto
/// is not always respected.

class WxCloseEvent extends WxEvent {
  WxCloseEvent( int type, { int id = 0 } ) : super( type, id );

  bool _canVeto = false;
  bool _loggingOff = false;
  bool _veto = false;

  /// Set by the system to indicate if the event can be vetoed
  void setCanVeto( bool can ) {
    _canVeto = can;
  }

  /// Returns true if the close event can be vetoed
  bool canVeto( ) {
    return _canVeto;
  }

  /// Set by the system if the user is logging off
  void setLoggingOff( bool loggingOff ) {
    _loggingOff = loggingOff;
  }

  /// Returns true of the user is logging off (not supported everywhere)
  bool getLoggingOff( ) {
    return _loggingOff;
  }

  /// Returns true if the event was vetoed 
  bool getVeto( ) {
    return _veto;
  }

  /// Instructs the system to not close the window - which may be ignored
  void veto( bool veto ) {
    _veto = veto;
  }
}

// ------------------------- wxNotifyEvent ----------------------

typedef OnNotifyEventFunc = void Function( WxNotifyEvent event );

/// @nodoc

class WxNotifyEventTableEntry extends WxEventTableEntry {
  WxNotifyEventTableEntry( super.eventType, super.id, this.func );
  final OnNotifyEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return (eventType == eventTypeTested) && ((id == wxID_ANY) || (id == idTested));
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxNotifyEvent) {
      func( event );
    }
  }
}

/// Base event class for all events that allow some kind of veto
class WxNotifyEvent extends WxCommandEvent {
  WxNotifyEvent( super.eventType, super.id );

  bool _isAllowed = true;

  /// Allow the proposed action to be done. Usually, this is the default.
  void allow( ) {
    _isAllowed = true;
  }

  /// Vetos the proposed action.
  void veto( ) {
    _isAllowed = false;
  }

  /// Returns true if the event was not vetoed.
  bool isAllowed( ) {
    return _isAllowed;
  }
}

// ----------------------- wxInitDialogEvent --------------------

/// @nodoc

extension InitDialogEventBinder on WxEvtHandler {
  void bindInitDialogEvent( OnInitDialogEventFunc func ) {
    _eventTable.add( WxInitDialogEventTableEntry(wxGetInitDialogEventType(), -1, func));
  }

  void unbindInitDialogEvent() {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetInitDialogEventType(), -1) ));
  }
}

// ----------------------- wxDialogValidateEvent --------------------

/// @nodoc

extension DialogValidateEventBinder on WxEvtHandler {
  void bindDialogValidateEvent( OnDialogValidateEventFunc func, int id ) {
    _eventTable.add( WxDialogValidateEventTableEntry(wxGetDialogValidateEventType(), id, func));
  }

  void unbindDialogValidateEvent( int id ) {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetDialogValidateEventType(), id) ));
  }
}

// ----------------------- wxDPIChangedEvent --------------------

/// @nodoc

extension DPIChangedEventBinder on WxEvtHandler {
  void bindDPIChangedEvent( OnDPIChangedEventFunc func ) {
    _eventTable.add( WxDPIChangedEventTableEntry(wxGetDPIChangedEventType(), -1, func));
  }

  void unbindDPIChangedEvent() {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetDPIChangedEventType(), -1) ));
  }
}

// ----------------------- wxSysColourChangedEvent --------------------

/// @nodoc

extension SysColourChangedEventBinder on WxEvtHandler {
  void bindSysColourChangedEvent( OnSysColourChangedEventFunc func ) {
    _eventTable.add( WxSysColourChangedEventTableEntry(wxGetSysColourChangedEventType(), -1, func));
  }

  void unbindSysColourChangedEvent() {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetSysColourChangedEventType(), -1) ));
  }
}

// ----------------------- wxActivateEvent --------------------

/// @nodoc

extension ActivateAppEventBinder on WxEvtHandler {
  void bindActivateAppEvent( OnActivateEventFunc func ) {
    _eventTable.add( WxActivateEventTableEntry(wxGetActivateAppEventType(), -1, func));
  }

  void unbindActivateAppEvent() {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetActivateAppEventType(), -1) ));
  }
}

/// @nodoc

extension ActivateEventBinder on WxEvtHandler {
  void bindActivateAppEvent( OnActivateEventFunc func ) {
    _eventTable.add( WxActivateEventTableEntry(wxGetActivateEventType(), -1, func));
  }

  void unbindActivateEvent() {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetActivateEventType(), -1) ));
  }
}

/// @nodoc

extension HibernateEventBinder on WxEvtHandler {
  void bindHibernateEvent( OnActivateEventFunc func ) {
    _eventTable.add( WxActivateEventTableEntry(wxGetHibernateEventType(), -1, func));
  }

  void unbindHibernateEvent() {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetHibernateEventType(), -1) ));
  }
}

// ------------------------- wxFocusEvent ----------------------

/// @nodoc

extension SetFocusEventBinder on WxEvtHandler {
  void bindSetFocusEvent( OnFocusEventFunc func ) {
    _eventTable.add( WxFocusEventTableEntry(wxGetSetFocusEventType(), -1, func));
  }

  void unbindSetFocusEvent() {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetSetFocusEventType(), -1) ));
  }
}

/// @nodoc

extension KillFocusEventBinder on WxEvtHandler {
  void bindKillFocusEvent( OnFocusEventFunc func ) {
    _eventTable.add( WxFocusEventTableEntry(wxGetKillFocusEventType(), -1, func));
  }

  void unbindKillFocusEvent() {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetKillFocusEventType(), -1) ));
  }
}

// ------------------------- wxScrollWinEvent ----------------------

/// @nodoc

extension ScrollWinEventBinder on WxEvtHandler {
  void bindScrollWinEvent( OnScrollWinEventFunc func ) {
    _eventTable.add( WxScrollWinEventTableEntry(wxGetScrollWinThumbTrackEventType(), -1, func));
  }

  void unbindScrollWinEvent() {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetScrollWinThumbTrackEventType(), -1) ));
  }
}

// ------------------------- wxMoveEvent ----------------------

/// @nodoc

extension MoveEventBinder on WxEvtHandler {
  void bindMoveEvent( OnMoveEventFunc func ) {
    _eventTable.add( WxMoveEventTableEntry(wxGetMoveEventType(), -1, func));
  }

  void unbindMoveEvent() {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetMoveEventType(), -1) ) );
  }
}

// ------------------------- wxShowEvent ----------------------

/// @nodoc

extension ShowEventBinder on WxEvtHandler {
  void bindShowEvent( OnShowEventFunc func ) {
    _eventTable.add( WxShowEventTableEntry(wxGetShowEventType(), -1, func));
  }

  void unbindShowEvent() {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetShowEventType(), -1) ));
  }
}

// ------------------------- wxCloseEvent ----------------------

/// @nodoc

extension CloseWindowEventBinder on WxEvtHandler {
  void bindCloseWindowEvent( OnCloseEventFunc func ) {
    _eventTable.add( WxCloseEventTableEntry(wxGetCloseWindowEventType(), -1, func));
  }

  void unbindCloseWindowEvent() {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetCloseWindowEventType(), -1) ));
  }
}
