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
/// | void bindPaintEvent( void function( [WxPaintEvent] event ) |
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
/// | void bindTimerEvent( void function( [WxTimerEvent] event ) ) |
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
/// | void bindIdleEvent( void function( [WxIdleEvent] event ) ) |
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
/// | void bindUpdateUIEvent( void function( WxUpdateUIEvent event ), int id  ) |
/// | void unbindUpdateUIEvent( int id ) |
///
/// Intercept this event and call [check] if a e.g. toolbar item needs to be checked.
///
/// Main interface:
/// * [check]
/// * [enable]
/// * [show]
/// * [setText]
/// * [set3StateValue]
///
/// Example usage:
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

  /// Used internally. Returns true if item should be checked.
  bool getChecked( ) {
    return _isChecked;
  }

  /// Used internally. Returns true if item should be enabled.
  bool getEnabled( ) {
    return _isEnabled;
  }

  /// Returns true if item is a checkable item.
  bool isCheckable( ) {
    return _isCheckable;
  }

  /// Returns true if item is a checkable item with 3 states (on/off/indeterminate).
  bool is3State( ) {
    return _is3State;
  }

  /// Used internally. Returns the text for the item.
  String getText( ) {
    return _text;
  }

  /// Used internally. Returns true if item should be shown.
  bool getShown( ) {
    return _isShown;
  }

  /// Used internally. Returns true if [check] has been called.
  bool getSetChecked( ) {
    return _isSetChecked;
  }

  /// Used internally. Returns true if [enable] has been called.
  bool getSetEnabled( ) {
    return _isSetEnabled;
  }

  /// Used internally. Returns true if [setText] has been set.
  bool getSetShown( ) {
    return _setShown;
  }

  /// Used internally.
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
/// | void bindSizeEvent( void function( [WxSizeEvent] event ) ) |
/// | void unbindSizeEvent() |
/// 
/// Make sure to call [WxSizeEvent.skip] so that ancestor windows can handle the
/// event as well.

class WxSizeEvent extends WxEvent {
  WxSizeEvent(  WxSize size, { id = 0 } ) : super( wxGetSizeEventType(), id ) {
    _size = size;
  }

  late WxSize _size;
  WxRect _rect = WxRect(0, 0, 0, 0);

  /// Returns the new size of the window
  WxSize getSize( ) {
    return _size;
  }

  /// Used internally. Sets the size of the window.
  void setSize( WxSize size ) {
    _size = size;
  }

  /// Returns the new full dimensions of the window
  WxRect getRect( ) {
    return _rect;
  }

  /// Used internally. Sets the dimension of the window.
  void setRect( WxRect rect ) {
    _rect = rect;
  }

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

/// Event sent out for keyboard key events.
/// 
/// Example usage:
/// ```dart
/// // Derive new class from WxWindow
/// class MyWindow extends WxWindow {
/// 
///   MyWindow( WxWindow parent, int id ) : super( parent, id, wxDefaultPosition, wxDefaultSize, 0 )
///   {
///     // Bind to key down event
///     bindKeyDownEvent( onKeyDown );
/// 
///     // Bind to key up event
///     bindKeyUpEvent( onKeyUp );
///   }
/// 
///   // define key down event handler
///   void onKeyDown( WxKeyEvent event )
///   {
///     switch (event.getKeyode()) {
///       case WXK_ENTER: doSomething(); break;
///       default: break;
///     }
///   }
/// 
///   // define key up event handler
///   void onKeyUp( WxKeyEvent event )
///   {
///     switch (event.getKeyode()) {
///       case WXK_ENTER: doSomethingElse(); break;
///       default: break;
///     }
///   }
/// }
/// ```
/// 
/// Events:
/// [KeyDown](/wxdart/wxGetKeyDownEventType.html) event gets sent when the user hits a key. |
/// | ----------------- |
/// | void bindKeyDownEvent( void function( [WxKeyEvent] event ) ) |
/// | void unbindKeyDownEvent() |
/// 
/// [KeyUp](/wxdart/wxGetKeyUpEventType.html) event gets sent when the user releases a key. |
/// | ----------------- |
/// | void bindKeyUpEvent( void function( [WxKeyEvent] event ) ) |
/// | void unbindKeyUpEvent() |
/// 
/// [Char](/wxdart/wxGetCharEventType.html) event gets sent when a full character has been entered. |
/// | ----------------- |
/// | void bindCharEvent( void function( [WxKeyEvent] event ) ) |
/// | void unbindCharEvent() |
/// 
///
/// # Supported key code constants in wxDart Flutter and wxDart Native
/// | key | constant |
/// | -------- | -------- |
/// | arrowUp | WXK_UP |
/// | arrowDown | WXK_DOWN |
/// | arrowRight | WXK_RIGHT |
/// | arrowLeft: | WXK_LEFT |
/// | space | WXK_SPACE |
/// | enter | WXK_RETURN |
/// | numpadEnter | WXK_RETURN |
/// | home | WXK_HOME |
/// | end | WXK_END |
/// | pageUp | WXK_PAGEUP |
/// | pageDown | WXK_PAGEDOWN |
/// | add | WXK_ADD |
/// | minus | WXK_SUBTRACT |
/// | escape | WXK_ESCAPE |
/// | backspace | WXK_BACK |
/// | f1 | WXK_F1 |
/// | ... | ... |
/// | f12 | WXK_F12 |
/// | tab | WXK_TAB |
/// | delete | WXK_DELETE |
/// | insert | WXK_INSERT |
/// | alt | WXK_ALT |
/// | shift | WXK_SHIFT |
/// | control | WXK_CONTROL |
/// | exclamation | WXK_EXCLAMATION |
/// | numberSign | WXK_NUMBER_SIGN |
/// | dollar | WXK_DOLLAR |
/// | percent | WXK_PERCENT |
/// | quoteSingle | WXK_SINGLE_QUOTE |
/// | backslash | 92 |
/// | braceLeft | 123 |
/// | braceRight | 125 |
/// | tilde | WXK_TILDE |
/// | bracketLeft | 91 |
/// | bracketRight | 93 |
/// | comma | WXK_COMMA |
/// | minus | WXK_MINUS |
/// | quote | WXK_DOUBLE_QUOTE |
/// | period | WXK_PERIOD |
/// | slash | WXK_SLASH |
/// | digit0 | 48 | 
/// | ... | ... | 
/// | digit9 | 57 | 
/// | colon | WXK_COLON |
/// | semicolon | WXK_SEMICOLON |
/// | less | WXK_LESS |
/// | equal | WXK_EQUAL |
/// | greater | WXK_GREATER |
/// | question | WXK_QUESTION |
/// | at | WXK_AT |
/// | keyA | WXK_A |
/// | ... | ... |
/// | keyZ | WXK_Z |

class WxKeyEvent extends WxEvent {
  WxKeyEvent( int eventType ) : super (eventType,-1) {
    _wxInitKeyEventModifiers( this );
  }

  /// Returns the key code (that often is not the actual character). E.g. when pressing the a key,
  /// it will return WXK_A which is the ascii code of the capitalized a. If this will
  /// result in the character a or A depends on shift being pressed.
  /// 
  /// See [getUnicodeKey]
  int getKeyCode( ) {
    return _keyCode;
  }
  /// Used internally
  void setKeyCode( int keyCode ) {
    _keyCode = keyCode;
  }

  /// Returns the Unicode key (currently wxDart Native only)
  int getUnicodeKey( ) {
    return _unicode;
  }

  /// Return true of the control key is currently pressed
  bool controlDown() {
    return _controlDown;
  }
  /// Return true of the command key is currently pressed
  bool cmdDown() {
    return controlDown();
  }
  /// Used internally
  void setControlDown( bool down ) {
    _controlDown = down;
  }
  /// Return true of the meta key is currently pressed
  bool metaDown() {
    return _metaDown;
  }
  /// Used internally
  void setMetaDown( bool down ) {
    _metaDown = down;
  }
  /// Return true of the alt key is currently pressed
  bool altDown() {
    return _altDown;
  }
  /// Used internally
  void setAltDown( bool down ) {
    _altDown = down;
  }
  /// Return true of the shift key is currently pressed
  bool shiftDown() {
    return _shiftDown;
  }
  /// Used internally
  void setShiftDown( bool down ) {
    _shiftDown = down;
  }
  /// Return true of the control key or the alt key is currently pressed
  bool hasModifiers( ) {
    return _controlDown || _altDown;
  }
  /// Return true of the any modifier currently pressed
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

// ----------------------- wxUpdateUIEvent --------------------

/// @nodoc

extension UpdateUIEventBinder on WxEvtHandler {
  void bindUpdateUIEvent( OnUpdateUIEventFunc func, int id ) {
    _eventTable.add( WxUpdateUIEventTableEntry(wxGetUpdateUIEventType(), id, func));
  }

  void unbindUpdateUIEvent( int id ) {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetUpdateUIEventType(), id) ));
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

// ------------------------- wxKeyEvent ----------------------

/// @nodoc

extension KeyDownEventBinder on WxEvtHandler {
  void bindKeyDownEvent( OnKeyEventFunc func ) {
    _eventTable.add( WxKeyEventTableEntry(wxGetKeyDownEventType(), -1, func));
  }

  void unbindKeyDownEvent() {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetKeyDownEventType(), -1) ));
  }
}

/// @nodoc

extension KeyUpEventBinder on WxEvtHandler {
  void bindKeyUpEvent( OnKeyEventFunc func ) {
    _eventTable.add( WxKeyEventTableEntry(wxGetKeyUpEventType(), -1, func));
  }

  void unbindKeyUpEvent() {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetKeyUpEventType(), -1) ));
  }
}

/// @nodoc

extension CharEventBinder on WxEvtHandler {
  void bindCharEvent( OnKeyEventFunc func ) {
    _eventTable.add( WxKeyEventTableEntry(wxGetCharEventType(), -1, func));
  }

  void unbindCharEvent() {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetCharEventType(), -1) ));
  }
}

/// @nodoc

extension CharHookEventBinder on WxEvtHandler {
  void bindCharHookEvent( OnKeyEventFunc func ) {
    _eventTable.add( WxKeyEventTableEntry(wxGetCharHookEventType(), -1, func));
  }

  void unbindCharHookEvent() {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetCharHookEventType(), -1) ));
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

// ------------------------- wxIdleEvent ----------------------

/// @nodoc

extension IdleEventBinder on WxEvtHandler {
  void bindIdleEvent( OnIdleEventFunc func ) {
    _eventTable.add( WxIdleEventTableEntry(wxGetIdleEventType(), -1, func));
  }

  void unbindIdleEvent() {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetIdleEventType(), -1) ));
  }
}

// ------------------------- wxTimerEvent ----------------------

/// @nodoc

extension TimerEventBinder on WxEvtHandler {
  void bindTimerEvent( OnTimerEventFunc func ) {
    _eventTable.add( WxTimerEventTableEntry(wxGetTimerEventType(), -1, func));
  }

  void unbindTimerEvent() {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetTimerEventType(), -1) ));
  }
}

