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

int wxGetActivateEventType()     { return 161; }
int wxGetHibernateEventType()       { return 160; }
int wxGetActivateAppEventType()     { return 161; }

int wxGetDPIChangedEventType()        { return 162; }
int wxGetSysColourChangedEventType()  { return 163; }

int wxGetInitDialogEventType()      { return 170; }
int wxGetDialogValidateEventType()  { return 171; }

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

int wxGetTreebookPageChangedEventType()         { return 250; }
int wxGetTreebookPageChangingEventType()        { return 251; }
int wxGetTreebookNodeCollapsedEventType()       { return 252; }
int wxGetTreebookNodeExpandedEventType()        { return 253; }

int wxGetGesturePanEventType()                  { return 260; }
int wxGetGestureZoomEventType()                 { return 261; }

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
    _eventTable.removeWhere( (entry) => entry.matches(wxGetGesturePanEventType(), -1));
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
    _eventTable.removeWhere( (entry) => entry.matches(wxGetGestureZoomEventType(), -1));
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
/// | void bindDPIChangedEvent( OnDPIChangedEventFunc ) |
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
/// | void bindSysColourChangedEvent( OnSysColourChangedEventFunc ) |
/// | void unbindSysColourChangedEvent() |

class WxSysColourChangedEvent extends WxEvent {
  WxSysColourChangedEvent( { int id = 0 } ) : super( wxGetSysColourChangedEventType(), id );
}

// ------------------------- wxPaintEvent ----------------------

typedef OnPaintEventFunc = void Function( WxPaintEvent event );

/// @nodoc

class WxPaintEventTableEntry extends WxEventTableEntry {
  WxPaintEventTableEntry( super.eventType, super.id, this.func );
  final OnPaintEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return eventType == eventTypeTested;
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxPaintEvent) {
      func( event );
    }
  }
}

/// [Paint](/docs/wxdart/wxGetPaintEventType.html) event gets sent when a part of the window needs to be redrawn |
/// | ----------------- |
/// | void bindPaintEvent( OnPaintEventFunc ) |
/// | void unbindPaintEvent() |
/// 
/// Here is an example of how paint event are usually processed.
/// 
///```dart
/// // Derive new class from WxWindow
/// class MyWindow extends WxWindow {
/// 
///   MyWindow( WxWindow parent, int id ) : super( parent, id, wxDefaultPosition, wxDefaultSize, 0 )
///   {
///     // Bind to paint event
///     bindPaintEvent(onPaint);
///   }
/// 
///   // define new paint event handler
///   void onPaint( WxPaintEvent event )
///   {
///     // create paint device context during paint event
///     final dc = WxPaintDC( this );
///     dc.drawLine( 10, 10, 100, 100 );
///   }
/// }
/// ```
/// Sometimes, only a part of the window needs to be redrawn. In this
/// case, you can query the update rectangle using [WxWindow.getUpdateClientRect].
/// However, this is actually not supported on all platforms and may not
/// be required or useful with modern hardware.
/// 
///```dart
/// // Derive new class from WxWindow
/// class MyWindow extends WxWindow {
/// 
///   MyWindow( WxWindow parent, int id ) : super( parent, id, wxDefaultPosition, wxDefaultSize, 0 )
///   {
///     // Bind to paint event
///     bindPaintEvent(onPaint);
///   }
/// 
///   // define new paint event handler
///   void onPaint( WxPaintEvent event )
///   {
///     // create paint device context during paint event
///     final dc = WxPaintDC( this );
/// 
///     final updateRect = getUpdateClientRect();
///     final rect = WxRect(10,10,100,100);
///     if (updateRect.intersects( rect ) )
///     {
///       // draw a line
///       dc.drawLinePts( rect.getTopLeft(), rect.getBottomRight() );
///     }
///   }
/// }
/// ```

class WxPaintEvent extends WxEvent {
  WxPaintEvent( WxWindow window ) : super( wxGetPaintEventType(), window.getId() );
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
/// | void bindInitDialogEvent( OnInitDialogEventFunc ) |
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
/// | void bindDialogValidateEvent( OnDialogValidateEventFunc ) |
/// | void unbindDialogValidateEvent() |
/// 
/// See also [WxInitDialogEvent].
/// 
/// dart``` 
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
/// ``` 

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
/// | void bindScrollWinEvent( OnScrollWinEventFunc ) |
/// | void unbindScrollWinEvent() |

class WxScrollWinEvent extends WxEvent {
  /// Creates a the event. Done by [WxScrolledWindow].
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

// ------------------------- wxTimerEvent ----------------------

typedef OnTimerEventFunc = void Function( WxTimerEvent event );

/// @nodoc

class WxTimerEventTableEntry extends WxEventTableEntry {
  WxTimerEventTableEntry( super.eventType, super.id, this.func );
  final OnTimerEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return (eventType == eventTypeTested) && (idTested == id);
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxTimerEvent) {
      func( event );
    }
  }
}

/// This event is emitted by [WxTimer].
/// 
/// Bind to this event or override [WxTimer.notify]
/// 
/// [Timer](/wxdart/wxGetTimerEventType.html) event gets sent from [WxTimer] |
/// | ----------------- |
/// | void bindTimerEvent( OnTimerEventFunc ) |
/// | void unbindTimerEvent() |

class WxTimerEvent extends WxEvent {
  WxTimerEvent( WxTimer timer ) : super(wxGetTimerEventType(), timer.getId()) {
    _timer = timer;
  }

  late WxTimer _timer; 

  /// Returns the timer from which this event originates.
  WxTimer getTimer() {
    return _timer;
  }

  /// Returns the time interval in milliseconds.
  int getInterval() {
    return _timer.getInterval();
  }
}

// ------------------------- wxIdleEvent ----------------------

typedef OnIdleEventFunc = void Function( WxIdleEvent event );

/// @nodoc

class WxIdleEventTableEntry extends WxEventTableEntry {
  WxIdleEventTableEntry( super.eventType, super.id, this.func );
  final OnIdleEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return eventType == eventTypeTested;
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxIdleEvent) {
      func( event );
    }
  }
}

/// Idle events get sent when the user does not give any input anymore
/// and the system is waiting.
/// 
/// [Idle](/wxdart/wxGetIdleEventType.html) event gets sent when the system is idle. Good moment to update your UI. |
/// | ----------------- |
/// | void bindIdleEvent( OnIdleEventFunc ) |
/// | void unbindIdleEvent() |

class WxIdleEvent extends WxEvent {
  WxIdleEvent(  { int id = 0 } ) : super( wxGetIdleEventType(), id );

  bool _moreRequested = false;

  bool moreRequested() {
    return _moreRequested;
  }

  /// Requests nore idle events to be sent. Will not work infinitely.
  void requestMore( { bool needMore = true }) {
    _moreRequested = needMore;
  }
}

// ------------------------- wxUpdateUIEvent ----------------------

typedef OnUpdateUIEventFunc = void Function( WxUpdateUIEvent event );

/// @nodoc

class WxUpdateUIEventTableEntry extends WxEventTableEntry {
  WxUpdateUIEventTableEntry( super.eventType, super.id, this.func );
  final OnUpdateUIEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return (eventType == eventTypeTested) && ((id == wxID_ANY) || (id == idTested));
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxUpdateUIEvent) {
      func( event );
    }
  }
}
/// [UpdateUI](/docs/wxdart/wxGetUpdateUIEventType.html) event is sent in idle time to update menus and toolbars.|
/// | ----------------- |
/// | void bindUpdateUIEvent( OnUpdateUIEventFunc ) |
/// | void unbindUpdateUIEvent() |
///
/// Intercept this event and call [check] if a e.g. toolbar item needs to be checked.
///
/// ```dart
///  // Somewhere in your frame 
///  final colormenu = WxMenu();
///  colormenu.appendRadioItem( idLightMode, "Light mode\tCtrl-D", help: "Can you see the light today?" );
///  colormenu.appendRadioItem( idDarkMode, "Dark mode\tCtrl-D", help: "See you on the dark side!" );
///
///  // Somewhere else in your frame 
///  final toolbar = createToolBar( style: wxTB_FLAT|wxTB_TEXT );
///  toolbar.addRadioTool( idLightMode, "Light", WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.light_mode, WxSize(32,32) ), null, shortHelp: "Light mode" );
///  toolbar.addRadioTool( idDarkMode, "Dark", WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.dark_mode, WxSize(32,32) ), null, shortHelp: "Dark mode" );
///
///   // catch the event and update toolbar and menu
///   bindUpdateUIEvent( (event) {
///      switch (event.getId()) {
///        case idDarkMode:   event.check( wxTheApp.isDark() ); return;
///        case idLightMode:  event.check( !wxTheApp.isDark() ); return;
///      } 
///    }, -1 );
///```

class WxUpdateUIEvent extends WxCommandEvent {
  WxUpdateUIEvent( { int id = 0 } ) : super( wxGetUpdateUIEventType(), id );
  
  bool _isChecked = false;
  bool _isEnabled = true;
  bool _isCheckable = false;
  bool _is3State = false;
  int _threeStateValue = 0;
  bool _isShown = true;

  bool _isSetChecked = false;
  bool _isSetEnabled = false;
  bool _setText = false;
  bool _setShown = false;

  bool getChecked( ) {
    return _isChecked;
  }

  bool getEnabled( ) {
    return _isEnabled;
  }

  bool isCheckable( ) {
    return _isCheckable;
  }

  bool is3State( ) {
    return _is3State;
  }

  String getText( ) {
    return _text;
  }

  bool getShown( ) {
    return _isShown;
  }

  bool getSetChecked( ) {
    return _isSetChecked;
  }

  bool getSetEnabled( ) {
    return _isSetEnabled;
  }

  bool getSetShown( ) {
    return _setShown;
  }

  bool getSetText( ) {
    return _setText;
  }

  int get3StateValue( ) {
    return _threeStateValue;
  }

  /// Call this to indicate that the UI element should be enabled
  void enable( bool enable ) {
    _isSetEnabled = true;
    _isEnabled = enable;
  }

  /// Call this to indicate that the UI element should be checked
  void check( bool check ) {
    _isSetChecked = true;
    _isChecked = check;
  }

  /// Call this to indicate that the UI element should be shown
  void show( bool show ) {
    _setShown = true;
    _isShown = show;
  }

  /// Call this to indicate that the UI element should have this text
  void setText( String text ) {
    _setText = true;
    _text = text;
  }

  /// Call this to indicate that the UI element should have this 3-state checkbox state
  void set3StateValue( int check ) {
    _threeStateValue = check;
    _is3State = true;
    _isSetChecked = true;
  }
}


// ------------------------- wxSizeEvent ----------------------

typedef OnSizeEventFunc = void Function( WxSizeEvent event );

/// @nodoc

class WxSizeEventTableEntry extends WxEventTableEntry {
  WxSizeEventTableEntry( super.eventType, super.id, this.func );
  final OnSizeEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return eventType == eventTypeTested;
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxSizeEvent) {
      func( event );
    }
  }
}

/// [Size](/docs/wxdart/wxGetSizeEventType.html) event gets sent when the size of a window changes. |
/// | ----------------- |
/// | void bindSizeEvent( OnSizeEventFunc ) |
/// | void unbindSizeEvent() |
/// 
/// Make sure to call [WxSizeEvent.skip] so that ancestor windows can handle the
/// event as well.

class WxSizeEvent extends WxEvent {
  WxSizeEvent(  this._size, { int id = 0 } ) : super( wxGetSizeEventType(), id );

  WxSize _size;
  WxRect _rect = WxRect(0, 0, 0, 0);

  WxSize getSize( ) {
    return _size;
  }

  void setSize( WxSize size ) {
    _size = size;
  }

  WxRect getRect( ) {
    return _rect;
  }

  void setRect( WxRect rect ) {
    _rect = rect;
  }

}

// ------------------------- wxMouseEvent ----------------------

typedef OnMouseEventFunc = void Function( WxMouseEvent event );

/// @nodoc

class WxMouseEventTableEntry extends WxEventTableEntry {
  WxMouseEventTableEntry( super.eventType, super.id, this.func );
  final OnMouseEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return eventType == eventTypeTested;
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxMouseEvent) {
      func( event );
    }
  }
}

const int wxMOUSE_BTN_ANY = -1;
const int wxMOUSE_BTN_NONE = 0;
const int wxMOUSE_BTN_LEFT = 1;
const int wxMOUSE_BTN_MIDDLE = 2;
const int wxMOUSE_BTN_RIGHT = 3;
const int wxMOUSE_BTN_AUX1 = 4;
const int wxMOUSE_BTN_AUX2 = 5;
const int wxMOUSE_BTN_MAX = 6;

const int  wxMOUSE_WHEEL_VERTICAL = 0;
const int  wxMOUSE_WHEEL_HORIZONTAL = 1;

/// Event sent out for all mouse events.
/// 
/// Example ussage:
/// ```dart
/// // Derive new class from WxWindow
/// class MyWindow extends WxWindow {
/// 
///   MyWindow( WxWindow parent, int id ) : super( parent, id, wxDefaultPosition, wxDefaultSize, 0 )
///   {
///     // Bind to mouse motion event
///     bindMotionEvent( onMotion );
/// 
///     // Other mouse events
///     // bindLeftDownEvent(onMouse);
///     // bindLeftUpEvent(onMouse);
///     // bindLeftDClickEvent(onMouse);
///     // bindRightDownEvent(onMouse);
///     // bindRightUpEvent(onMouse);
///     // bindRightDClickEvent(onMouse);
///     // bindMotionEvent(onMouse);
///     // bindLeaveWindowEvent(onMouse);
///   }
/// 
///   // define new mouse motion event handler
///   void onMotion( WxMouseEvent event )
///   {
///    final pos = event.getPosition();
///    // in a scrolled window, this would need to be adapted
///    // final pos = calcUnscrolledPosition(event.getPosition());
///    
///    if (( pos.x > 10) && (pos.y > 50) &&
///        ( pos.x < 210) && (pos.y < 250)) {
///      setCursor( WxCursor(wxCURSOR_CROSS) );
///    } else {
///      setCursor( null );  // reset to standard mouse cursor
///    }
///   }
/// }
/// ```
///
/// # Mouse button constants
/// | constant | value |
/// | -------- | -------- |
/// | wxMOUSE_BTN_ANY | -1 |
/// | wxMOUSE_BTN_NONE | 0 |
/// | wxMOUSE_BTN_LEFT | 1 |
/// | wxMOUSE_BTN_MIDDLE | 2 |
/// | wxMOUSE_BTN_RIGHT | 3 |
/// | wxMOUSE_BTN_AUX1 | 4 |
/// | wxMOUSE_BTN_AUX2 | 5 |
/// | wxMOUSE_BTN_MAX | 6 |
///
/// # Mouse wheel axis constants
/// | constant | value |
/// | -------- | -------- |
/// |    wxMOUSE_WHEEL_VERTICAL | 0 |
/// |    wxMOUSE_WHEEL_HORIZONTAL | 1 |

class WxMouseEvent extends WxEvent {
  /// Creates a mouse event. Done by the system.
    WxMouseEvent( int eventType ) : super( eventType, -1 )
    {
      final keyboard = HardwareKeyboard.instance;
      _altDown = keyboard.isAltPressed;
      _controlDown = keyboard.isControlPressed;
      _metaDown = keyboard.isMetaPressed;
      _shiftDown = keyboard.isShiftPressed;
    }

/// Returns button constants depending which button
/// caused the event
/// 
/// ## Mouse button constants
/// | constant | value |
/// | -------- | -------- |
/// | wxMOUSE_BTN_NONE | 0 |
/// | wxMOUSE_BTN_LEFT | 1 |
/// | wxMOUSE_BTN_MIDDLE | 2 |
/// | wxMOUSE_BTN_RIGHT | 3 |
  int getButton( ) {
    final type = getEventType();
    if ((type == wxGetLeftDownEventType()) ||
        (type == wxGetLeftUpEventType()) ||
        (type == wxGetLeftDClickEventType())) {
        return wxMOUSE_BTN_LEFT;
    }
    if ((type == wxGetRightDownEventType()) ||
        (type == wxGetRightUpEventType()) ||
        (type == wxGetRightDClickEventType())) {
        return wxMOUSE_BTN_RIGHT;
    }
    if ((type == wxGetMiddleDownEventType()) ||
        (type == wxGetMiddleUpEventType()) ||
        (type == wxGetMiddleDClickEventType())) {
        return wxMOUSE_BTN_MIDDLE;
    }
    return wxMOUSE_BTN_NONE;
  }

/// Returns 0, 1 or 2 depending on if this was
/// not a button down event, a button down event
/// or a double click event 
  int getClickCount( ) {
    final type = getEventType();
    if ((type == wxGetLeftDownEventType()) ||
        (type == wxGetRightDownEventType()) ||
        (type == wxGetMiddleDownEventType())) {
        return 1;
    }
    if ((type == wxGetLeftDClickEventType()) ||
        (type == wxGetRightDClickEventType()) ||
        (type == wxGetMiddleDClickEventType())) {
        return 2;
    }
    return 0;
  }

  /// Returns true if this is a buttop up event
  bool buttonUp( { int but = wxMOUSE_BTN_ANY } ) {
    if (but == wxMOUSE_BTN_ANY) {
      return (leftUp() || rightUp() || middleUp());
    }
    if (((but & wxMOUSE_BTN_LEFT) != 0) && leftUp()) return true;
    if (((but & wxMOUSE_BTN_RIGHT) != 0) && rightUp()) return true;
    if (((but & wxMOUSE_BTN_MIDDLE) != 0) && middleUp()) return true;
    return false;    
  }

  /// Returns true if this is a buttop down event
  bool buttonDown( { int but = wxMOUSE_BTN_ANY } ) {
    if (but == wxMOUSE_BTN_ANY) {
      return (leftDown() || rightDown() || middleDown());
    }
    if (((but & wxMOUSE_BTN_LEFT) != 0) && leftDown()) return true;
    if (((but & wxMOUSE_BTN_RIGHT) != 0) && rightDown()) return true;
    if (((but & wxMOUSE_BTN_MIDDLE) != 0) && middleDown()) return true;
    return false;    
  }

  /// Returns true if this is a double click event
  bool buttonDClick( { int but = wxMOUSE_BTN_ANY } ) {
    if (but == wxMOUSE_BTN_ANY) {
      return (leftDClick() || rightDClick() || middleDClick());
    }
    if (((but & wxMOUSE_BTN_LEFT) != 0) && leftDClick()) return true;
    if (((but & wxMOUSE_BTN_RIGHT) != 0) && rightDClick()) return true;
    if (((but & wxMOUSE_BTN_MIDDLE) != 0) && middleDClick()) return true;
    return false;    
  }

  /// Returns true if a left down event
  bool leftDown( ) {
    return (getEventType() == wxGetLeftDownEventType());
  }

  /// Returns true if a right down event
  bool rightDown( ) {
    return (getEventType() == wxGetRightDownEventType());
  }

  /// Returns true if a middle down event
  bool middleDown( ) {
    return (getEventType() == wxGetMiddleDownEventType());
  }

  /// Returns true if a left double click event
  bool leftDClick( ) {
    return (getEventType() == wxGetLeftDClickEventType());
  }

  /// Returns true if a right double click event
  bool rightDClick( ) {
    return (getEventType() == wxGetRightDClickEventType());
  }

  /// Returns true if a middle double click event
  bool middleDClick( ) {
    return (getEventType() == wxGetMiddleDClickEventType());
  }

  /// Returns true if a left up event
  bool leftUp( ) {
    return (getEventType() == wxGetLeftUpEventType());
  }

  /// Returns true if a right up event
  bool rightUp( ) {
    return (getEventType() == wxGetRightUpEventType());
  }

  /// Returns true if a middle up event
  bool middleUp( ) {
    return (getEventType() == wxGetMiddleUpEventType());
  }

  /// Returns true if any button is currently down and mouse moved
  bool dragging( ) {
    return (moving() && (_leftIsDown || _rightIsDown || _middleIsDown));
  }

  /// Returns true if a mouse entered the window
  bool entering( ) {
    return (getEventType() == wxGetEnterWindowEventType());
  }

  /// Returns true if a mouse left the window
  bool leaving( ) {
    return (getEventType() == wxGetLeaveWindowEventType());
  }

  /// Returns true if a mouse moved
  bool moving( ) {
    return (getEventType() == wxGetMotionEventType());
  }

  /// Returns true if a this is a magnify event
  bool magnify( ) {
    return (getEventType() == wxGetMagnifyEventType());
  }

  /// Returns x coordinate of mouse event
  int getX( ) {
    return _x;
  }

  /// Returns y coordinate of mouse event
  int getY( ) {
    return _y;
  }

  /// Returns coordinates of mouse event
  WxPoint getPosition( ) {
    return WxPoint(_x, _y);
  }

  /// Used internally
  void setX( int x ) {
    _x = x;
  }

  /// Used internally
  void setY( int y ) {
    _y = y;
  }

  /// Used internally
  void setPosition( WxPoint pos ) {
    _x = pos.x;
    _y = pos.y;
  }

  /// Returns wheel delty, currently 120 on all platforms
  int getWheelDelta( ) {
    return 120;
  }

  /// Returns rotation. Divide this by [getWheelDelta]
  int getWheelRotation( ) {
    return _wheelRotation;
  }

/// Returns wheel axis
/// 
/// ## Mouse wheel axis constants
/// | constant | value |
/// | -------- | -------- |
/// |    wxMOUSE_WHEEL_VERTICAL | 0 |
/// |    wxMOUSE_WHEEL_HORIZONTAL | 1 |
  int getWheelAxis() {
    return _wheelAxis;
  }


/// Returns true if wheel is inverted
  bool isWheelInverted( ) {
    return false;
  }

/// Returns true if left mouse button is currently down
  bool leftIsDown( ) {
    return _leftIsDown;
  }

/// Returns true if right mouse button is currently down
  bool rightIsDown( ) {
    return _rightIsDown;
  }

/// Returns true if middle mouse button is currently down
  bool middleIsDown( ) {
    return _middleIsDown;
  }

  /// Used internally
  void setLeftDown( bool down ) {
    _leftIsDown = down;
  }

  /// Used internally
  void setRightDown( bool down ) {
    _rightIsDown = down;
  }

  /// Used internally
  void setMiddleDown( bool down ) {
    _middleIsDown = down;
  }

/// Returns true if CTRL key is currently down
  bool controlDown() {
    return _controlDown;
  }
/// Returns true if CMD key is currently down
  bool cmdDown() {
    return controlDown();
  }
  void setControlDown( bool down ) {
    _controlDown = down;
  }
/// Returns true if META key is currently down
  bool metaDown() {
    return _metaDown;
  }
  /// Used internally
  void setMetaDown( bool down ) {
    _metaDown = down;
  }
/// Returns true if ALT key is currently down
  bool altDown() {
    return _altDown;
  }
  /// Used internally
  void setAltDown( bool down ) {
    _altDown = down;
  }
/// Returns true if SHIFT key is currently down
  bool shiftDown() {
    return _shiftDown;
  }
  /// Used internally
  void setShiftDown( bool down ) {
    _shiftDown = down;
  }
/// Returns true if CTRL or ALT key is currently down
  bool hasModifiers( ) {
    return _controlDown || _altDown;
  }
/// Returns true if any modifier is currently down
  bool hasAnyModifiers( ) {
    return _controlDown || _altDown || _shiftDown || _metaDown;
  }


  int _x = 0;
  int _y = 0;
  bool _leftIsDown = false;
  bool _rightIsDown = false;
  bool _middleIsDown = false;
  late bool _controlDown;
  late bool _metaDown;
  late bool _altDown;
  late bool _shiftDown;
  int _wheelAxis = 0;
  int _wheelRotation = 0;
}

// ------------------------- wxKeyEvent ----------------------

typedef OnKeyEventFunc = void Function( WxKeyEvent event );

/// @nodoc

class WxKeyEventTableEntry extends WxEventTableEntry {
  WxKeyEventTableEntry( super.eventType, super.id, this.func );
  final OnKeyEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return eventType == eventTypeTested;
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxKeyEvent) {
      func( event );
    }
  }
}

class WxKeyEvent extends WxEvent {
  WxKeyEvent( int eventType ) : super (eventType,-1) {
      final keyboard = HardwareKeyboard.instance;
      _altDown = keyboard.isAltPressed;
      _controlDown = keyboard.isControlPressed;
      _metaDown = keyboard.isMetaPressed;
      _shiftDown = keyboard.isShiftPressed;
  }

  int getKeyCode( ) {
    return _keyCode;
  }
  void setKeyCode( int keyCode ) {
    _keyCode = keyCode;
  }

  int getUnicodeKey( ) {
    return _unicode;
  }

  bool controlDown() {
    return _controlDown;
  }
  bool cmdDown() {
    return controlDown();
  }
  void setControlDown( bool down ) {
    _controlDown = down;
  }
  bool metaDown() {
    return _metaDown;
  }
  void setMetaDown( bool down ) {
    _metaDown = down;
  }
  bool altDown() {
    return _altDown;
  }
  void setAltDown( bool down ) {
    _altDown = down;
  }
  bool shiftDown() {
    return _shiftDown;
  }
  void setShiftDown( bool down ) {
    _shiftDown = down;
  }
  bool hasModifiers( ) {
    return _controlDown || _altDown;
  }
  bool hasAnyModifiers( ) {
    return _controlDown || _altDown || _shiftDown || _metaDown;
  }

  int _keyCode = 0;
  int _unicode = 0;
  late bool _controlDown;
  late bool _metaDown;
  late bool _altDown;
  late bool _shiftDown;
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

/// [SetFocus](/docs/wxdart/wxGetSetFocusEventType.html) event gets sent when window has received focus. |
/// | ----------------- |
/// | void bindSetFocusEvent( OnFocusEventFunc ) |
/// | void unbindSetFocusEvent() |
/// 
/// [KillFocus](/docs/wxdart/wxGetKillFocusEventType.html) event gets sent when window has lost the focus. |
/// | ----------------- |
/// | void bindKillFocusEvent( OnFocusEventFunc ) |
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

/// [Move](/docs/wxdart/wxGetMoveEventType.html) event gets sent when windows was moved. |
/// | ----------------- |
/// | void bindMoveEvent( OnMoveEventFunc ) |
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

/// [CloseWindow](/wxdart/wxGetCloseWindowEventType.html) event gets sent when a top level window gets closed, e.g. after the x button was pressed. |
/// | ----------------- |
/// | void bindCloseWindowEvent( OnCloseEventFunc ) |
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
    _eventTable.removeWhere( (entry) => entry.matches(wxGetInitDialogEventType(), -1));
  }
}

// ----------------------- wxDialogValidateEvent --------------------

/// @nodoc

extension DialogValidateEventBinder on WxEvtHandler {
  void bindDialogValidateEvent( OnDialogValidateEventFunc func, int id ) {
    _eventTable.add( WxDialogValidateEventTableEntry(wxGetDialogValidateEventType(), id, func));
  }

  void unbindDialogValidateEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetDialogValidateEventType(), id));
  }
}

// ----------------------- wxUpdateUIEvent --------------------

/// @nodoc

extension UpdateUIEventBinder on WxEvtHandler {
  void bindUpdateUIEvent( OnUpdateUIEventFunc func, int id ) {
    _eventTable.add( WxUpdateUIEventTableEntry(wxGetUpdateUIEventType(), id, func));
  }

  void unbindUpdateUIEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetUpdateUIEventType(), id));
  }
}

// ----------------------- wxDPIChangedEvent --------------------

/// @nodoc

extension DPIChangedEventBinder on WxEvtHandler {
  void bindDPIChangedEvent( OnDPIChangedEventFunc func ) {
    _eventTable.add( WxDPIChangedEventTableEntry(wxGetDPIChangedEventType(), -1, func));
  }

  void unbindDPIChangedEvent() {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetDPIChangedEventType(), -1));
  }
}

// ----------------------- wxSysColourChangedEvent --------------------

/// @nodoc

extension SysColourChangedEventBinder on WxEvtHandler {
  void bindSysColourChangedEvent( OnSysColourChangedEventFunc func ) {
    _eventTable.add( WxSysColourChangedEventTableEntry(wxGetSysColourChangedEventType(), -1, func));
  }

  void unbindSysColourChangedEvent() {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetSysColourChangedEventType(), -1));
  }
}

// ----------------------- wxActivateEvent --------------------

/// @nodoc

extension ActivateAppEventBinder on WxEvtHandler {
  void bindActivateAppEvent( OnActivateEventFunc func ) {
    _eventTable.add( WxActivateEventTableEntry(wxGetActivateAppEventType(), -1, func));
  }

  void unbindActivateAppEvent() {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetActivateAppEventType(), -1));
  }
}

/// @nodoc

extension ActivateEventBinder on WxEvtHandler {
  void bindActivateAppEvent( OnActivateEventFunc func ) {
    _eventTable.add( WxActivateEventTableEntry(wxGetActivateEventType(), -1, func));
  }

  void unbindActivateEvent() {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetActivateEventType(), -1));
  }
}

/// @nodoc

extension HibernateEventBinder on WxEvtHandler {
  void bindHibernateEvent( OnActivateEventFunc func ) {
    _eventTable.add( WxActivateEventTableEntry(wxGetHibernateEventType(), -1, func));
  }

  void unbindHibernateEvent() {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetHibernateEventType(), -1));
  }
}

// ------------------------- wxKeyEvent ----------------------

/// @nodoc

extension KeyDownEventBinder on WxEvtHandler {
  void bindKeyDownEvent( OnKeyEventFunc func ) {
    _eventTable.add( WxKeyEventTableEntry(wxGetKeyDownEventType(), -1, func));
  }

  void unbindKeyDownEvent() {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetKeyDownEventType(), -1));
  }
}

/// @nodoc

extension KeyUpEventBinder on WxEvtHandler {
  void bindKeyUpEvent( OnKeyEventFunc func ) {
    _eventTable.add( WxKeyEventTableEntry(wxGetKeyUpEventType(), -1, func));
  }

  void unbindKeyUpEvent() {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetKeyUpEventType(), -1));
  }
}

/// @nodoc

extension CharEventBinder on WxEvtHandler {
  void bindCharEvent( OnKeyEventFunc func ) {
    _eventTable.add( WxKeyEventTableEntry(wxGetCharEventType(), -1, func));
  }

  void unbindCharEvent() {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetCharEventType(), -1));
  }
}

/// @nodoc

extension CharHookEventBinder on WxEvtHandler {
  void bindCharHookEvent( OnKeyEventFunc func ) {
    _eventTable.add( WxKeyEventTableEntry(wxGetCharHookEventType(), -1, func));
  }

  void unbindCharHookEvent() {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetCharHookEventType(), -1));
  }
}

// ------------------------- wxFocusEvent ----------------------

/// @nodoc

extension SetFocusEventBinder on WxEvtHandler {
  void bindSetFocusEvent( OnFocusEventFunc func ) {
    _eventTable.add( WxFocusEventTableEntry(wxGetSetFocusEventType(), -1, func));
  }

  void unbindSetFocusEvent() {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetSetFocusEventType(), -1));
  }
}

/// @nodoc

extension KillFocusEventBinder on WxEvtHandler {
  void bindKillFocusEvent( OnFocusEventFunc func ) {
    _eventTable.add( WxFocusEventTableEntry(wxGetKillFocusEventType(), -1, func));
  }

  void unbindKillFocusEvent() {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetKillFocusEventType(), -1));
  }
}

// ------------------------- wxScrollWinEvent ----------------------

/// @nodoc

extension ScrollWinEventBinder on WxEvtHandler {
  void bindScrollWinEvent( OnScrollWinEventFunc func ) {
    _eventTable.add( WxScrollWinEventTableEntry(wxGetScrollWinThumbTrackEventType(), -1, func));
  }

  void unbindScrollWinEvent() {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetScrollWinThumbTrackEventType(), -1));
  }
}

// ------------------------- wxMoveEvent ----------------------

/// @nodoc

extension MoveEventBinder on WxEvtHandler {
  void bindMoveEvent( OnMoveEventFunc func ) {
    _eventTable.add( WxMoveEventTableEntry(wxGetMoveEventType(), -1, func));
  }

  void unbindMoveEvent() {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetMoveEventType(), -1));
  }
}

// ------------------------- wxShowEvent ----------------------

/// @nodoc

extension ShowEventBinder on WxEvtHandler {
  void bindShowEvent( OnShowEventFunc func ) {
    _eventTable.add( WxShowEventTableEntry(wxGetShowEventType(), -1, func));
  }

  void unbindShowEvent() {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetShowEventType(), -1));
  }
}

// ------------------------- wxCloseEvent ----------------------

/// @nodoc

extension CloseWindowEventBinder on WxEvtHandler {
  void bindCloseWindowEvent( OnCloseEventFunc func ) {
    _eventTable.add( WxCloseEventTableEntry(wxGetCloseWindowEventType(), -1, func));
  }

  void unbindCloseWindowEvent() {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetCloseWindowEventType(), -1));
  }
}

// ------------------------- wxIdleEvent ----------------------

/// @nodoc

extension IdleEventBinder on WxEvtHandler {
  void bindIdleEvent( OnIdleEventFunc func ) {
    _eventTable.add( WxIdleEventTableEntry(wxGetIdleEventType(), -1, func));
  }

  void unbindIdleEvent() {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetIdleEventType(), -1));
  }
}

// ------------------------- wxTimerEvent ----------------------

/// @nodoc

extension TimerEventBinder on WxEvtHandler {
  void bindTimerEvent( OnTimerEventFunc func ) {
    _eventTable.add( WxTimerEventTableEntry(wxGetTimerEventType(), -1, func));
  }

  void unbindTimerEvent() {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetTimerEventType(), -1));
  }
}

// ------------------------- wxMouseEvent ----------------------

/// @nodoc

extension LeftDownEventBinder on WxEvtHandler {
  void bindLeftDownEvent( OnMouseEventFunc func ) {
    _eventTable.add( WxMouseEventTableEntry(wxGetLeftDownEventType(), -1, func));
  }

  void unbindLeftDownEvent() {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetLeftDownEventType(), -1));
  }
}

/// @nodoc

extension RightDownEventBinder on WxEvtHandler {
  void bindRightDownEvent( OnMouseEventFunc func ) {
    _eventTable.add( WxMouseEventTableEntry(wxGetRightDownEventType(), -1, func));
  }

  void unbindRightDownEvent() {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetRightDownEventType(), -1));
  }
}

/// @nodoc

extension MiddleDownEventBinder on WxEvtHandler {
  void bindMiddleDownEvent( OnMouseEventFunc func ) {
    _eventTable.add( WxMouseEventTableEntry(wxGetMiddleDownEventType(), -1, func));
  }

  void unbindMiddleDownEvent() {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetMiddleDownEventType(), -1));
  }
}

/// @nodoc

extension LeftUpEventBinder on WxEvtHandler {
  void bindLeftUpEvent( OnMouseEventFunc func ) {
    _eventTable.add( WxMouseEventTableEntry(wxGetLeftUpEventType(), -1, func));
  }

  void unbindLeftUpEvent() {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetLeftUpEventType(), -1));
  }
}

/// @nodoc

extension RightUpEventBinder on WxEvtHandler {
  void bindRightUpEvent( OnMouseEventFunc func ) {
    _eventTable.add( WxMouseEventTableEntry(wxGetRightUpEventType(), -1, func));
  }

  void unbindRightUpEvent() {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetRightUpEventType(), -1));
  }
}

/// @nodoc

extension MiddleUpEventBinder on WxEvtHandler {
  void bindMiddleUpEvent( OnMouseEventFunc func ) {
    _eventTable.add( WxMouseEventTableEntry(wxGetMiddleUpEventType(), -1, func));
  }

  void unbindMiddleUpEvent() {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetMiddleUpEventType(), -1));
  }
}

/// @nodoc

extension LeftDClickEventBinder on WxEvtHandler {
  void bindLeftDClickEvent( OnMouseEventFunc func ) {
    _eventTable.add( WxMouseEventTableEntry(wxGetLeftDClickEventType(), -1, func));
  }

  void unbindLeftDClickEvent() {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetLeftDClickEventType(), -1));
  }
}

/// @nodoc

extension RightDClickEventBinder on WxEvtHandler {
  void bindRightDClickEvent( OnMouseEventFunc func ) {
    _eventTable.add( WxMouseEventTableEntry(wxGetRightDClickEventType(), -1, func));
  }

  void unbindRightDClickEvent() {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetRightDClickEventType(), -1));
  }
}

/// @nodoc

extension MiddleDClickEventBinder on WxEvtHandler {
  void bindMiddleDClickEvent( OnMouseEventFunc func ) {
    _eventTable.add( WxMouseEventTableEntry(wxGetMiddleDClickEventType(), -1, func));
  }

  void unbindMiddleDClickEvent() {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetMiddleDClickEventType(), -1));
  }
}

/// @nodoc

extension MotionEventBinder on WxEvtHandler {
  void bindMotionEvent( OnMouseEventFunc func ) {
    _eventTable.add( WxMouseEventTableEntry(wxGetMotionEventType(), -1, func));
  }

  void unbindMotionEvent() {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetMotionEventType(), -1));
  }
}

/// @nodoc

extension EnterWindowEventBinder on WxEvtHandler {
  void bindEnterWindowEvent( OnMouseEventFunc func ) {
    _eventTable.add( WxMouseEventTableEntry(wxGetEnterWindowEventType(), -1, func));
  }

  void unbindEnterWindowEvent() {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetEnterWindowEventType(), -1));
  }
}

/// @nodoc

extension LeaveWindowEventBinder on WxEvtHandler {
  void bindLeaveWindowEvent( OnMouseEventFunc func ) {
    _eventTable.add( WxMouseEventTableEntry(wxGetLeaveWindowEventType(), -1, func));
  }

  void unbindLeaveWindowEvent() {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetLeaveWindowEventType(), -1));
  }
}

/// @nodoc

extension MouseWheelEventBinder on WxEvtHandler {
  void bindMouseWheelEvent( OnMouseEventFunc func ) {
    _eventTable.add( WxMouseEventTableEntry(wxGetMouseWheelEventType(), -1, func));
  }

  void unbindMouseWheelEvent() {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetMouseWheelEventType(), -1));
  }
}

/// @nodoc

extension MagnifyEventBinder on WxEvtHandler {
  void bindMagnifyEvent( OnMouseEventFunc func ) {
    _eventTable.add( WxMouseEventTableEntry(wxGetMagnifyEventType(), -1, func));
  }

  void unbindMagnifyEvent() {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetMagnifyEventType(), -1));
  }
}
