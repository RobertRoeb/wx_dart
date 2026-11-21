// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- WxMouseEvent binders ----------------------

/// @nodoc

extension LeftDownEventBinder on WxEvtHandler {
  void bindLeftDownEvent( OnMouseEventFunc func ) {
    _eventTable.add( WxMouseEventTableEntry(wxGetLeftDownEventType(), -1, func));
  }

  void unbindLeftDownEvent() {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetLeftDownEventType(), -1) ));
  }
}

/// @nodoc

extension RightDownEventBinder on WxEvtHandler {
  void bindRightDownEvent( OnMouseEventFunc func ) {
    _eventTable.add( WxMouseEventTableEntry(wxGetRightDownEventType(), -1, func));
  }

  void unbindRightDownEvent() {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetRightDownEventType(), -1) ));
  }
}

/// @nodoc

extension MiddleDownEventBinder on WxEvtHandler {
  void bindMiddleDownEvent( OnMouseEventFunc func ) {
    _eventTable.add( WxMouseEventTableEntry(wxGetMiddleDownEventType(), -1, func));
  }

  void unbindMiddleDownEvent() {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetMiddleDownEventType(), -1) ));
  }
}

/// @nodoc

extension LeftUpEventBinder on WxEvtHandler {
  void bindLeftUpEvent( OnMouseEventFunc func ) {
    _eventTable.add( WxMouseEventTableEntry(wxGetLeftUpEventType(), -1, func));
  }

  void unbindLeftUpEvent() {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetLeftUpEventType(), -1) ) );
  }
}

/// @nodoc

extension RightUpEventBinder on WxEvtHandler {
  void bindRightUpEvent( OnMouseEventFunc func ) {
    _eventTable.add( WxMouseEventTableEntry(wxGetRightUpEventType(), -1, func));
  }

  void unbindRightUpEvent() {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetRightUpEventType(), -1) ));
  }
}

/// @nodoc

extension MiddleUpEventBinder on WxEvtHandler {
  void bindMiddleUpEvent( OnMouseEventFunc func ) {
    _eventTable.add( WxMouseEventTableEntry(wxGetMiddleUpEventType(), -1, func));
  }

  void unbindMiddleUpEvent() {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetMiddleUpEventType(), -1) ));
  }
}

/// @nodoc

extension LeftDClickEventBinder on WxEvtHandler {
  void bindLeftDClickEvent( OnMouseEventFunc func ) {
    _eventTable.add( WxMouseEventTableEntry(wxGetLeftDClickEventType(), -1, func));
  }

  void unbindLeftDClickEvent() {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetLeftDClickEventType(), -1) ));
  }
}

/// @nodoc

extension RightDClickEventBinder on WxEvtHandler {
  void bindRightDClickEvent( OnMouseEventFunc func ) {
    _eventTable.add( WxMouseEventTableEntry(wxGetRightDClickEventType(), -1, func));
  }

  void unbindRightDClickEvent() {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetRightDClickEventType(), -1) ));
  }
}

/// @nodoc

extension MiddleDClickEventBinder on WxEvtHandler {
  void bindMiddleDClickEvent( OnMouseEventFunc func ) {
    _eventTable.add( WxMouseEventTableEntry(wxGetMiddleDClickEventType(), -1, func));
  }

  void unbindMiddleDClickEvent() {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetMiddleDClickEventType(), -1) ));
  }
}

/// @nodoc

extension MotionEventBinder on WxEvtHandler {
  void bindMotionEvent( OnMouseEventFunc func ) {
    _eventTable.add( WxMouseEventTableEntry(wxGetMotionEventType(), -1, func));
  }

  void unbindMotionEvent() {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetMotionEventType(), -1) ) );
  }
}

/// @nodoc

extension EnterWindowEventBinder on WxEvtHandler {
  void bindEnterWindowEvent( OnMouseEventFunc func ) {
    _eventTable.add( WxMouseEventTableEntry(wxGetEnterWindowEventType(), -1, func));
  }

  void unbindEnterWindowEvent() {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetEnterWindowEventType(), -1) ));
  }
}

/// @nodoc

extension LeaveWindowEventBinder on WxEvtHandler {
  void bindLeaveWindowEvent( OnMouseEventFunc func ) {
    _eventTable.add( WxMouseEventTableEntry(wxGetLeaveWindowEventType(), -1, func));
  }

  void unbindLeaveWindowEvent() {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetLeaveWindowEventType(), -1) ));
  }
}

/// @nodoc

extension MouseWheelEventBinder on WxEvtHandler {
  void bindMouseWheelEvent( OnMouseEventFunc func ) {
    _eventTable.add( WxMouseEventTableEntry(wxGetMouseWheelEventType(), -1, func));
  }

  void unbindMouseWheelEvent() {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetMouseWheelEventType(), -1) ));
  }
}

/// @nodoc

extension MagnifyEventBinder on WxEvtHandler {
  void bindMagnifyEvent( OnMouseEventFunc func ) {
    _eventTable.add( WxMouseEventTableEntry(wxGetMagnifyEventType(), -1, func));
  }

  void unbindMagnifyEvent() {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetMagnifyEventType(), -1) ));
  }
}

// ------------------------- WxMouseEvent ----------------------

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
  WxMouseEvent( int eventType ) : super( eventType, -1 ) {
    _wxInitMouseEventModifiers( this );
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
