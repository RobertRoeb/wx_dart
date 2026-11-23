// -------------------------------------------------------------
// Purpose:     Dart bindings for wxWidgets
// Author:      Robert Roebling
// Modified by: The magic C++ to Dart code generator
// Created:     07/01/2025
// Copyright:   (c) Robert Roebling
// Licence:     wxWindows licence 3.1
// -------------------------------------------------------------

part of '../wx_dart.dart';

// ------------------------- wxGestureEvent ----------------------

typedef _WxGestureEventConstructorNative = Pointer Function( Int32, Int32  );
typedef _WxGestureEventConstructor = Pointer Function( int, int  );
late _WxGestureEventConstructor _wxGestureEventConstructor;

typedef _WxGestureEventSetPositionNative = Void Function( Pointer, Int32, Int32  );
typedef _WxGestureEventSetPosition = void Function( Pointer, int, int  );
late _WxGestureEventSetPosition _wxGestureEventSetPosition;

typedef _WxGestureEventGetPositionNative = WxPointNative Function( Pointer  );
typedef _WxGestureEventGetPosition = WxPointNative Function( Pointer  );
late _WxGestureEventGetPosition _wxGestureEventGetPosition;

typedef _WxGestureEventSetGestureStartNative = Void Function( Pointer, Bool  );
typedef _WxGestureEventSetGestureStart = void Function( Pointer, bool  );
late _WxGestureEventSetGestureStart _wxGestureEventSetGestureStart;

typedef _WxGestureEventIsGestureStartNative = Bool Function( Pointer  );
typedef _WxGestureEventIsGestureStart = bool Function( Pointer  );
late _WxGestureEventIsGestureStart _wxGestureEventIsGestureStart;

typedef _WxGestureEventSetGestureEndNative = Void Function( Pointer, Bool  );
typedef _WxGestureEventSetGestureEnd = void Function( Pointer, bool  );
late _WxGestureEventSetGestureEnd _wxGestureEventSetGestureEnd;

typedef _WxGestureEventIsGestureEndNative = Bool Function( Pointer  );
typedef _WxGestureEventIsGestureEnd = bool Function( Pointer  );
late _WxGestureEventIsGestureEnd _wxGestureEventIsGestureEnd;

class WxGestureEvent extends WxEvent {
  WxGestureEvent._defaultConstructor() : super._defaultConstructor();
  WxGestureEvent( int id, int type ) : super._defaultConstructor() {
    nativeHandle = _wxGestureEventConstructor( id, type );
    attachFinalizer();
  }
  WxGestureEvent.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  void setPosition( WxPoint pos ) {
    _wxGestureEventSetPosition( nativeHandle, pos.x, pos.y );
  }

  WxPoint getPosition( ) {
    final WxPointNative pointReturn = _wxGestureEventGetPosition( nativeHandle  );
    return WxPoint(pointReturn.x, pointReturn.y);
  }

  void setGestureStart( { bool isStart = true } ) {
    _wxGestureEventSetGestureStart( nativeHandle, isStart );
  }

  bool isGestureStart( ) {
    return _wxGestureEventIsGestureStart( nativeHandle  );
  }

  void setGestureEnd( { bool isEnd = true } ) {
    _wxGestureEventSetGestureEnd( nativeHandle, isEnd );
  }

  bool isGestureEnd( ) {
    return _wxGestureEventIsGestureEnd( nativeHandle  );
  }
}

typedef _WxInstallDartGestureEventCallbackNative = Void Function( Pointer );
typedef _WxInstallDartGestureEventCallback = void Function( Pointer );
late _WxInstallDartGestureEventCallback _wxInstallDartGestureEventCallback;

typedef OnGestureEventFunc = void Function( WxGestureEvent event );
class WxGestureEventListItems {
  WxGestureEventListItems( this.func, this.eventType );
  final OnGestureEventFunc func;
  final int eventType;
}
Map<Pointer, List<WxGestureEventListItems>> wxGestureEventHandlerList = {};

void wxGestureEventCallback( Pointer handle, Pointer eventHandle ) {
    WxGestureEvent event = WxGestureEvent.fromHandle( eventHandle );

    final List<WxGestureEventListItems>? list = wxGestureEventHandlerList[handle];
    if (list == null) {
      wxLogError('Handle does not exist in wxGestureEventHandlerList');
      return;
    } else {
      for (int i = list.length-1; i >= 0; i--) { // go backwards to allow overloading
        final items = list[i];
        if (items.eventType != event.getEventType()) continue;
        event.skip( skip: false );
        items.func( event );
        if (!event.getSkipped()) return;
      }
    }
}

typedef WxGestureEventCallbackNative = Void Function( Pointer, Pointer );
late NativeCallable<Void Function(Pointer<NativeType>, Pointer<NativeType>)> wxGestureEventNativeCallable;

// ------------------------- wxPanGestureEvent ----------------------

typedef _WxPanGestureEventConstructorNative = Pointer Function( Int32  );
typedef _WxPanGestureEventConstructor = Pointer Function( int  );
late _WxPanGestureEventConstructor _wxPanGestureEventConstructor;

typedef _WxPanGestureEventSetDeltaNative = Void Function( Pointer, Int32, Int32  );
typedef _WxPanGestureEventSetDelta = void Function( Pointer, int, int  );
late _WxPanGestureEventSetDelta _wxPanGestureEventSetDelta;

typedef _WxPanGestureEventGetDeltaNative = WxPointNative Function( Pointer  );
typedef _WxPanGestureEventGetDelta = WxPointNative Function( Pointer  );
late _WxPanGestureEventGetDelta _wxPanGestureEventGetDelta;

class WxPanGestureEvent extends WxGestureEvent {
  WxPanGestureEvent._defaultConstructor() : super._defaultConstructor();
  WxPanGestureEvent( int id ) : super._defaultConstructor() {
    nativeHandle = _wxPanGestureEventConstructor( id );
    attachFinalizer();
  }
  WxPanGestureEvent.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  void setDelta( WxPoint delta ) {
    _wxPanGestureEventSetDelta( nativeHandle, delta.x, delta.y );
  }

  WxPoint getDelta( ) {
    final WxPointNative pointReturn = _wxPanGestureEventGetDelta( nativeHandle  );
    return WxPoint(pointReturn.x, pointReturn.y);
  }
}

typedef _WxInstallDartPanGestureEventCallbackNative = Void Function( Pointer );
typedef _WxInstallDartPanGestureEventCallback = void Function( Pointer );
late _WxInstallDartPanGestureEventCallback _wxInstallDartPanGestureEventCallback;

typedef OnPanGestureEventFunc = void Function( WxPanGestureEvent event );
class WxPanGestureEventListItems {
  WxPanGestureEventListItems( this.func, this.eventType );
  final OnPanGestureEventFunc func;
  final int eventType;
}
Map<Pointer, List<WxPanGestureEventListItems>> wxPanGestureEventHandlerList = {};

void wxPanGestureEventCallback( Pointer handle, Pointer eventHandle ) {
    WxPanGestureEvent event = WxPanGestureEvent.fromHandle( eventHandle );

    final List<WxPanGestureEventListItems>? list = wxPanGestureEventHandlerList[handle];
    if (list == null) {
      wxLogError('Handle does not exist in wxPanGestureEventHandlerList');
      return;
    } else {
      for (int i = list.length-1; i >= 0; i--) { // go backwards to allow overloading
        final items = list[i];
        if (items.eventType != event.getEventType()) continue;
        event.skip( skip: false );
        items.func( event );
        if (!event.getSkipped()) return;
      }
    }
}

typedef WxPanGestureEventCallbackNative = Void Function( Pointer, Pointer );
late NativeCallable<Void Function(Pointer<NativeType>, Pointer<NativeType>)> wxPanGestureEventNativeCallable;

// ------------------------- wxZoomGestureEvent ----------------------

typedef _WxZoomGestureEventConstructorNative = Pointer Function( Int32  );
typedef _WxZoomGestureEventConstructor = Pointer Function( int  );
late _WxZoomGestureEventConstructor _wxZoomGestureEventConstructor;

typedef _WxZoomGestureEventSetZoomFactorNative = Void Function( Pointer, Double  );
typedef _WxZoomGestureEventSetZoomFactor = void Function( Pointer, double  );
late _WxZoomGestureEventSetZoomFactor _wxZoomGestureEventSetZoomFactor;

typedef _WxZoomGestureEventGetZoomFactorNative = Double Function( Pointer  );
typedef _WxZoomGestureEventGetZoomFactor = double Function( Pointer  );
late _WxZoomGestureEventGetZoomFactor _wxZoomGestureEventGetZoomFactor;

class WxZoomGestureEvent extends WxGestureEvent {
  WxZoomGestureEvent._defaultConstructor() : super._defaultConstructor();
  WxZoomGestureEvent( int id ) : super._defaultConstructor() {
    nativeHandle = _wxZoomGestureEventConstructor( id );
    attachFinalizer();
  }
  WxZoomGestureEvent.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  void setZoomFactor( double factor ) {
    _wxZoomGestureEventSetZoomFactor( nativeHandle, factor );
  }

  double getZoomFactor( ) {
    return _wxZoomGestureEventGetZoomFactor( nativeHandle  );
  }
}

typedef _WxInstallDartZoomGestureEventCallbackNative = Void Function( Pointer );
typedef _WxInstallDartZoomGestureEventCallback = void Function( Pointer );
late _WxInstallDartZoomGestureEventCallback _wxInstallDartZoomGestureEventCallback;

typedef OnZoomGestureEventFunc = void Function( WxZoomGestureEvent event );
class WxZoomGestureEventListItems {
  WxZoomGestureEventListItems( this.func, this.eventType );
  final OnZoomGestureEventFunc func;
  final int eventType;
}
Map<Pointer, List<WxZoomGestureEventListItems>> wxZoomGestureEventHandlerList = {};

void wxZoomGestureEventCallback( Pointer handle, Pointer eventHandle ) {
    WxZoomGestureEvent event = WxZoomGestureEvent.fromHandle( eventHandle );

    final List<WxZoomGestureEventListItems>? list = wxZoomGestureEventHandlerList[handle];
    if (list == null) {
      wxLogError('Handle does not exist in wxZoomGestureEventHandlerList');
      return;
    } else {
      for (int i = list.length-1; i >= 0; i--) { // go backwards to allow overloading
        final items = list[i];
        if (items.eventType != event.getEventType()) continue;
        event.skip( skip: false );
        items.func( event );
        if (!event.getSkipped()) return;
      }
    }
}

typedef WxZoomGestureEventCallbackNative = Void Function( Pointer, Pointer );
late NativeCallable<Void Function(Pointer<NativeType>, Pointer<NativeType>)> wxZoomGestureEventNativeCallable;

// ------------------------- wxMenuEvent ----------------------

typedef _WxMenuEventConstructorNative = Pointer Function( Int32, Int32  );
typedef _WxMenuEventConstructor = Pointer Function( int, int  );
late _WxMenuEventConstructor _wxMenuEventConstructor;

typedef _WxMenuEventGetMenuNative = Pointer Function( Pointer  );
typedef _WxMenuEventGetMenu = Pointer Function( Pointer  );
late _WxMenuEventGetMenu _wxMenuEventGetMenu;

typedef _WxMenuEventGetMenuIdNative = Int32 Function( Pointer  );
typedef _WxMenuEventGetMenuId = int Function( Pointer  );
late _WxMenuEventGetMenuId _wxMenuEventGetMenuId;

typedef _WxMenuEventIsPopupNative = Bool Function( Pointer  );
typedef _WxMenuEventIsPopup = bool Function( Pointer  );
late _WxMenuEventIsPopup _wxMenuEventIsPopup;

class WxMenuEvent extends WxEvent {
  WxMenuEvent._defaultConstructor() : super._defaultConstructor();
  WxMenuEvent( int type, int id ) : super._defaultConstructor() {
    nativeHandle = _wxMenuEventConstructor( type, id );
    attachFinalizer();
  }
  WxMenuEvent.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  WxMenu getMenu( ) {
    final returnedNativeHandle = _wxMenuEventGetMenu( nativeHandle  );
    return WxMenu.fromHandle( returnedNativeHandle );
  }

  int getMenuId( ) {
    return _wxMenuEventGetMenuId( nativeHandle  );
  }

  bool isPopup( ) {
    return _wxMenuEventIsPopup( nativeHandle  );
  }
}

typedef _WxInstallDartMenuEventCallbackNative = Void Function( Pointer );
typedef _WxInstallDartMenuEventCallback = void Function( Pointer );
late _WxInstallDartMenuEventCallback _wxInstallDartMenuEventCallback;

typedef OnMenuEventFunc = void Function( WxMenuEvent event );
class WxMenuEventListItems {
  WxMenuEventListItems( this.func, this.eventType );
  final OnMenuEventFunc func;
  final int eventType;
}
Map<Pointer, List<WxMenuEventListItems>> wxMenuEventHandlerList = {};

void wxMenuEventCallback( Pointer handle, Pointer eventHandle ) {
    WxMenuEvent event = WxMenuEvent.fromHandle( eventHandle );

    final List<WxMenuEventListItems>? list = wxMenuEventHandlerList[handle];
    if (list == null) {
      wxLogError('Handle does not exist in wxMenuEventHandlerList');
      return;
    } else {
      for (int i = list.length-1; i >= 0; i--) { // go backwards to allow overloading
        final items = list[i];
        if (items.eventType != event.getEventType()) continue;
        event.skip( skip: false );
        items.func( event );
        if (!event.getSkipped()) return;
      }
    }
}

typedef WxMenuEventCallbackNative = Void Function( Pointer, Pointer );
late NativeCallable<Void Function(Pointer<NativeType>, Pointer<NativeType>)> wxMenuEventNativeCallable;

// ------------------------- wxSizeEvent ----------------------

typedef _WxSizeEventConstructorNative = Pointer Function( Int32, Int32  );
typedef _WxSizeEventConstructor = Pointer Function( int, int  );
late _WxSizeEventConstructor _wxSizeEventConstructor;

typedef _WxSizeEventGetSizeNative = WxSizeNative Function( Pointer  );
typedef _WxSizeEventGetSize = WxSizeNative Function( Pointer  );
late _WxSizeEventGetSize _wxSizeEventGetSize;

typedef _WxSizeEventSetSizeNative = Void Function( Pointer, Int32, Int32  );
typedef _WxSizeEventSetSize = void Function( Pointer, int, int  );
late _WxSizeEventSetSize _wxSizeEventSetSize;

typedef _WxSizeEventGetRectNative = WxRectNative Function( Pointer  );
typedef _WxSizeEventGetRect = WxRectNative Function( Pointer  );
late _WxSizeEventGetRect _wxSizeEventGetRect;

typedef _WxSizeEventSetRectNative = Void Function( Pointer, Int32, Int32, Int32, Int32  );
typedef _WxSizeEventSetRect = void Function( Pointer, int, int, int, int  );
late _WxSizeEventSetRect _wxSizeEventSetRect;

class WxSizeEvent extends WxEvent {
  WxSizeEvent._defaultConstructor() : super._defaultConstructor();
  WxSizeEvent( WxSize size ) : super._defaultConstructor() {
    nativeHandle = _wxSizeEventConstructor( size.x, size.y );
    attachFinalizer();
  }
  WxSizeEvent.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  WxSize getSize( ) {
    final WxSizeNative sizeReturn = _wxSizeEventGetSize( nativeHandle  );
    return WxSize(sizeReturn.x, sizeReturn.y);
  }

  void setSize( WxSize size ) {
    _wxSizeEventSetSize( nativeHandle, size.x, size.y );
  }

  WxRect getRect( ) {
    final WxRectNative rectReturn = _wxSizeEventGetRect( nativeHandle  );
    return WxRect(rectReturn.x, rectReturn.y, rectReturn.width, rectReturn.height);
  }

  void setRect( WxRect rect ) {
    _wxSizeEventSetRect( nativeHandle, rect.x, rect.y, rect.width, rect.height );
  }
}

typedef _WxInstallDartSizeEventCallbackNative = Void Function( Pointer );
typedef _WxInstallDartSizeEventCallback = void Function( Pointer );
late _WxInstallDartSizeEventCallback _wxInstallDartSizeEventCallback;

typedef OnSizeEventFunc = void Function( WxSizeEvent event );
Map<Pointer, OnSizeEventFunc> wxSizeEventHandlerList = {};

void wxSizeEventCallback( Pointer handle, Pointer eventHandle ) {
    OnSizeEventFunc ?func = wxSizeEventHandlerList[handle];
    if (func != null) {
      func( WxSizeEvent.fromHandle( eventHandle ));
    }
}

typedef WxSizeEventCallbackNative = Void Function( Pointer, Pointer );
late NativeCallable<Void Function(Pointer<NativeType>, Pointer<NativeType>)> wxSizeEventNativeCallable;

// ------------------------- wxVMEvent ----------------------

typedef _WxVMEventConstructorNative = Pointer Function( Int32, Int32  );
typedef _WxVMEventConstructor = Pointer Function( int, int  );
late _WxVMEventConstructor _wxVMEventConstructor;

typedef _WxVMEventGetSizeNative = WxSizeNative Function( Pointer  );
typedef _WxVMEventGetSize = WxSizeNative Function( Pointer  );
late _WxVMEventGetSize _wxVMEventGetSize;

typedef _WxVMEventSetSizeNative = Void Function( Pointer, Int32, Int32  );
typedef _WxVMEventSetSize = void Function( Pointer, int, int  );
late _WxVMEventSetSize _wxVMEventSetSize;

class WxVMEvent extends WxEvent {
  WxVMEvent._defaultConstructor() : super._defaultConstructor();
  WxVMEvent( int type, int id ) : super._defaultConstructor() {
    nativeHandle = _wxVMEventConstructor( type, id );
    attachFinalizer();
  }
  WxVMEvent.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  WxSize getSize( ) {
    final WxSizeNative sizeReturn = _wxVMEventGetSize( nativeHandle  );
    return WxSize(sizeReturn.x, sizeReturn.y);
  }

  void setSize( WxSize size ) {
    _wxVMEventSetSize( nativeHandle, size.x, size.y );
  }
}

typedef _WxInstallDartVMEventCallbackNative = Void Function( Pointer );
typedef _WxInstallDartVMEventCallback = void Function( Pointer );
late _WxInstallDartVMEventCallback _wxInstallDartVMEventCallback;

typedef OnVMEventFunc = void Function( WxVMEvent event );
class WxVMEventListItems {
  WxVMEventListItems( this.func, this.eventType );
  final OnVMEventFunc func;
  final int eventType;
}
Map<Pointer, List<WxVMEventListItems>> wxVMEventHandlerList = {};

void wxVMEventCallback( Pointer handle, Pointer eventHandle ) {
    WxVMEvent event = WxVMEvent.fromHandle( eventHandle );

    final List<WxVMEventListItems>? list = wxVMEventHandlerList[handle];
    if (list == null) {
      wxLogError('Handle does not exist in wxVMEventHandlerList');
      return;
    } else {
      for (int i = list.length-1; i >= 0; i--) { // go backwards to allow overloading
        final items = list[i];
        if (items.eventType != event.getEventType()) continue;
        if (event.getEventType() == wxGetVMGetMinSizeEventType()) {
          final handler = _evtHandlerList[handle];
          if (handler is WxWindow) {
            event.setSize( handler.getMinSize() );
            return;
          }
        }
      }
    }
}

typedef WxVMEventCallbackNative = Void Function( Pointer, Pointer );
late NativeCallable<Void Function(Pointer<NativeType>, Pointer<NativeType>)> wxVMEventNativeCallable;

// ------------------------- wxShowEvent ----------------------

typedef _WxShowEventConstructorNative = Pointer Function( Int32, Bool  );
typedef _WxShowEventConstructor = Pointer Function( int, bool  );
late _WxShowEventConstructor _wxShowEventConstructor;

typedef _WxShowEventIsShownNative = Bool Function( Pointer  );
typedef _WxShowEventIsShown = bool Function( Pointer  );
late _WxShowEventIsShown _wxShowEventIsShown;

typedef _WxShowEventSetShowNative = Void Function( Pointer, Bool  );
typedef _WxShowEventSetShow = void Function( Pointer, bool  );
late _WxShowEventSetShow _wxShowEventSetShow;

class WxShowEvent extends WxEvent {
  WxShowEvent._defaultConstructor() : super._defaultConstructor();
  WxShowEvent( int id, { bool show = true } ) : super._defaultConstructor() {
    nativeHandle = _wxShowEventConstructor( id, show );
    attachFinalizer();
  }
  WxShowEvent.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  bool isShown( ) {
    return _wxShowEventIsShown( nativeHandle  );
  }

  void setShow( bool show ) {
    _wxShowEventSetShow( nativeHandle, show );
  }
}

typedef _WxInstallDartShowEventCallbackNative = Void Function( Pointer );
typedef _WxInstallDartShowEventCallback = void Function( Pointer );
late _WxInstallDartShowEventCallback _wxInstallDartShowEventCallback;

typedef OnShowEventFunc = void Function( WxShowEvent event );
Map<Pointer, OnShowEventFunc> wxShowEventHandlerList = {};

void wxShowEventCallback( Pointer handle, Pointer eventHandle ) {
    OnShowEventFunc ?func = wxShowEventHandlerList[handle];
    if (func != null) {
      func( WxShowEvent.fromHandle( eventHandle ));
    }
}

typedef WxShowEventCallbackNative = Void Function( Pointer, Pointer );
late NativeCallable<Void Function(Pointer<NativeType>, Pointer<NativeType>)> wxShowEventNativeCallable;

// ------------------------- wxWindowCreateEvent ----------------------

typedef _WxWindowCreateEventConstructorNative = Pointer Function( Pointer  );
typedef _WxWindowCreateEventConstructor = Pointer Function( Pointer  );
late _WxWindowCreateEventConstructor _wxWindowCreateEventConstructor;

typedef _WxWindowCreateEventGetWindowNative = Pointer Function( Pointer  );
typedef _WxWindowCreateEventGetWindow = Pointer Function( Pointer  );
late _WxWindowCreateEventGetWindow _wxWindowCreateEventGetWindow;

class WxWindowCreateEvent extends WxCommandEvent {
  WxWindowCreateEvent._defaultConstructor() : super._defaultConstructor();
  WxWindowCreateEvent( WxWindow? win ) : super._defaultConstructor() {
    nativeHandle = _wxWindowCreateEventConstructor( (win == null) ? nullptr : win.nativeHandle );
    attachFinalizer();
  }
  WxWindowCreateEvent.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  WxWindow? getWindow( ) {
    final returnedNativeHandle = _wxWindowCreateEventGetWindow( nativeHandle  );
    if (returnedNativeHandle == nullptr) return null;
    WxEvtHandler? eh = _evtHandlerList[returnedNativeHandle];
    if (eh != null) {
      // There already is a Dart class associated with this C++ object
      return eh as WxWindow;
    }
    return wxCreateBestMatchingClassFromWxWindowHandle( returnedNativeHandle );
  }
}

typedef _WxInstallDartWindowCreateEventCallbackNative = Void Function( Pointer );
typedef _WxInstallDartWindowCreateEventCallback = void Function( Pointer );
late _WxInstallDartWindowCreateEventCallback _wxInstallDartWindowCreateEventCallback;

typedef OnWindowCreateEventFunc = void Function( WxWindowCreateEvent event );
class WxWindowCreateEventListItems {
  WxWindowCreateEventListItems( this.func, this.eventType, this.eventId );
  final OnWindowCreateEventFunc func;
  final int eventType;
  final int eventId;
}
Map<Pointer, List<WxWindowCreateEventListItems>> wxWindowCreateEventHandlerList = {};

void wxWindowCreateEventCallback( Pointer handle, Pointer eventHandle ) {
    WxWindowCreateEvent event = WxWindowCreateEvent.fromHandle( eventHandle );

    final List<WxWindowCreateEventListItems>? list = wxWindowCreateEventHandlerList[handle];
    if (list == null) {
      wxLogError('Handle does not exist in wxWindowCreateEventHandlerList');
      return;
    } else {
      for (int i = list.length-1; i >= 0; i--) { // go backwards to allow overloading
        final items = list[i];
        if (items.eventType != event.getEventType()) continue;
        if ((items.eventId != -1) && (items.eventId != event.getId())) continue;
        event.skip( skip: false );
        items.func( event );
        if (!event.getSkipped()) return;
      }
    }
}

typedef WxWindowCreateEventCallbackNative = Void Function( Pointer, Pointer );
late NativeCallable<Void Function(Pointer<NativeType>, Pointer<NativeType>)> wxWindowCreateEventNativeCallable;

// ------------------------- wxActivateEvent ----------------------

typedef _WxActivateEventConstructorNative = Pointer Function( Int32, Bool, Int32, Int32  );
typedef _WxActivateEventConstructor = Pointer Function( int, bool, int, int  );
late _WxActivateEventConstructor _wxActivateEventConstructor;

typedef _WxActivateEventGetActiveNative = Bool Function( Pointer  );
typedef _WxActivateEventGetActive = bool Function( Pointer  );
late _WxActivateEventGetActive _wxActivateEventGetActive;

typedef _WxActivateEventGetActivationReasonNative = Int32 Function( Pointer  );
typedef _WxActivateEventGetActivationReason = int Function( Pointer  );
late _WxActivateEventGetActivationReason _wxActivateEventGetActivationReason;

/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxACTIVATE_REASON_MOUSE | 0 |
/// | wxACTIVATE_REASON_UNKNOWN | 1 |

const int wxACTIVATE_REASON_MOUSE = 0;
const int wxACTIVATE_REASON_UNKNOWN = 1;

class WxActivateEvent extends WxEvent {
  WxActivateEvent._defaultConstructor() : super._defaultConstructor();
  WxActivateEvent( int type, { bool active = true, int id = 0, int reason = wxACTIVATE_REASON_UNKNOWN } ) : super._defaultConstructor() {
    nativeHandle = _wxActivateEventConstructor( type, active, id, reason );
    attachFinalizer();
  }
  WxActivateEvent.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  bool getActive( ) {
    return _wxActivateEventGetActive( nativeHandle  );
  }

  int getActivationReason( ) {
    return _wxActivateEventGetActivationReason( nativeHandle  );
  }
}

typedef _WxInstallDartActivateEventCallbackNative = Void Function( Pointer );
typedef _WxInstallDartActivateEventCallback = void Function( Pointer );
late _WxInstallDartActivateEventCallback _wxInstallDartActivateEventCallback;

typedef OnActivateEventFunc = void Function( WxActivateEvent event );
class WxActivateEventListItems {
  WxActivateEventListItems( this.func, this.eventType );
  final OnActivateEventFunc func;
  final int eventType;
}
Map<Pointer, List<WxActivateEventListItems>> wxActivateEventHandlerList = {};

void wxActivateEventCallback( Pointer handle, Pointer eventHandle ) {
    WxActivateEvent event = WxActivateEvent.fromHandle( eventHandle );

    final List<WxActivateEventListItems>? list = wxActivateEventHandlerList[handle];
    if (list == null) {
      wxLogError('Handle does not exist in wxActivateEventHandlerList');
      return;
    } else {
      for (int i = list.length-1; i >= 0; i--) { // go backwards to allow overloading
        final items = list[i];
        if (items.eventType != event.getEventType()) continue;
        event.skip( skip: false );
        items.func( event );
        if (!event.getSkipped()) return;
      }
    }
}

typedef WxActivateEventCallbackNative = Void Function( Pointer, Pointer );
late NativeCallable<Void Function(Pointer<NativeType>, Pointer<NativeType>)> wxActivateEventNativeCallable;

// ------------------------- wxIdleEvent ----------------------

typedef _WxIdleEventConstructorNative = Pointer Function(  );
typedef _WxIdleEventConstructor = Pointer Function(  );
late _WxIdleEventConstructor _wxIdleEventConstructor;

typedef _WxIdleEventMoreRequestedNative = Bool Function( Pointer  );
typedef _WxIdleEventMoreRequested = bool Function( Pointer  );
late _WxIdleEventMoreRequested _wxIdleEventMoreRequested;

typedef _WxIdleEventRequestMoreNative = Void Function( Pointer, Bool  );
typedef _WxIdleEventRequestMore = void Function( Pointer, bool  );
late _WxIdleEventRequestMore _wxIdleEventRequestMore;

class WxIdleEvent extends WxEvent {
  WxIdleEvent._defaultConstructor() : super._defaultConstructor();
  WxIdleEvent( ) : super._defaultConstructor() {
    nativeHandle = _wxIdleEventConstructor(  );
    attachFinalizer();
  }
  WxIdleEvent.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  bool moreRequested( ) {
    return _wxIdleEventMoreRequested( nativeHandle  );
  }

  void requestMore( { bool needMore = true } ) {
    _wxIdleEventRequestMore( nativeHandle, needMore );
  }
}

typedef _WxInstallDartIdleEventCallbackNative = Void Function( Pointer );
typedef _WxInstallDartIdleEventCallback = void Function( Pointer );
late _WxInstallDartIdleEventCallback _wxInstallDartIdleEventCallback;

typedef OnIdleEventFunc = void Function( WxIdleEvent event );
Map<Pointer, OnIdleEventFunc> wxIdleEventHandlerList = {};

void wxIdleEventCallback( Pointer handle, Pointer eventHandle ) {
    OnIdleEventFunc ?func = wxIdleEventHandlerList[handle];
    if (func != null) {
      func( WxIdleEvent.fromHandle( eventHandle ));
    }
}

typedef WxIdleEventCallbackNative = Void Function( Pointer, Pointer );
late NativeCallable<Void Function(Pointer<NativeType>, Pointer<NativeType>)> wxIdleEventNativeCallable;

// ------------------------- wxSysColourChangedEvent ----------------------

typedef _WxSysColourChangedEventConstructorNative = Pointer Function(  );
typedef _WxSysColourChangedEventConstructor = Pointer Function(  );
late _WxSysColourChangedEventConstructor _wxSysColourChangedEventConstructor;

class WxSysColourChangedEvent extends WxEvent {
  WxSysColourChangedEvent._defaultConstructor() : super._defaultConstructor();
  WxSysColourChangedEvent( ) : super._defaultConstructor() {
    nativeHandle = _wxSysColourChangedEventConstructor(  );
    attachFinalizer();
  }
  WxSysColourChangedEvent.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }
}

typedef _WxInstallDartSysColourChangedEventCallbackNative = Void Function( Pointer );
typedef _WxInstallDartSysColourChangedEventCallback = void Function( Pointer );
late _WxInstallDartSysColourChangedEventCallback _wxInstallDartSysColourChangedEventCallback;

typedef OnSysColourChangedEventFunc = void Function( WxSysColourChangedEvent event );
class WxSysColourChangedEventListItems {
  WxSysColourChangedEventListItems( this.func, this.eventType );
  final OnSysColourChangedEventFunc func;
  final int eventType;
}
Map<Pointer, List<WxSysColourChangedEventListItems>> wxSysColourChangedEventHandlerList = {};

void wxSysColourChangedEventCallback( Pointer handle, Pointer eventHandle ) {
    WxSysColourChangedEvent event = WxSysColourChangedEvent.fromHandle( eventHandle );

    final List<WxSysColourChangedEventListItems>? list = wxSysColourChangedEventHandlerList[handle];
    if (list == null) {
      wxLogError('Handle does not exist in wxSysColourChangedEventHandlerList');
      return;
    } else {
      for (int i = list.length-1; i >= 0; i--) { // go backwards to allow overloading
        final items = list[i];
        if (items.eventType != event.getEventType()) continue;
        event.skip( skip: false );
        items.func( event );
        if (!event.getSkipped()) return;
      }
    }
}

typedef WxSysColourChangedEventCallbackNative = Void Function( Pointer, Pointer );
late NativeCallable<Void Function(Pointer<NativeType>, Pointer<NativeType>)> wxSysColourChangedEventNativeCallable;

// ------------------------- wxDPIChangedEvent ----------------------

typedef _WxDPIChangedEventConstructorNative = Pointer Function(  );
typedef _WxDPIChangedEventConstructor = Pointer Function(  );
late _WxDPIChangedEventConstructor _wxDPIChangedEventConstructor;

typedef _WxDPIChangedEventGetOldDPINative = WxSizeNative Function( Pointer  );
typedef _WxDPIChangedEventGetOldDPI = WxSizeNative Function( Pointer  );
late _WxDPIChangedEventGetOldDPI _wxDPIChangedEventGetOldDPI;

typedef _WxDPIChangedEventGetNewDPINative = WxSizeNative Function( Pointer  );
typedef _WxDPIChangedEventGetNewDPI = WxSizeNative Function( Pointer  );
late _WxDPIChangedEventGetNewDPI _wxDPIChangedEventGetNewDPI;

class WxDPIChangedEvent extends WxEvent {
  WxDPIChangedEvent._defaultConstructor() : super._defaultConstructor();
  WxDPIChangedEvent( ) : super._defaultConstructor() {
    nativeHandle = _wxDPIChangedEventConstructor(  );
    attachFinalizer();
  }
  WxDPIChangedEvent.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  WxSize getOldDPI( ) {
    final WxSizeNative sizeReturn = _wxDPIChangedEventGetOldDPI( nativeHandle  );
    return WxSize(sizeReturn.x, sizeReturn.y);
  }

  WxSize getNewDPI( ) {
    final WxSizeNative sizeReturn = _wxDPIChangedEventGetNewDPI( nativeHandle  );
    return WxSize(sizeReturn.x, sizeReturn.y);
  }
}

typedef _WxInstallDartDPIChangedEventCallbackNative = Void Function( Pointer );
typedef _WxInstallDartDPIChangedEventCallback = void Function( Pointer );
late _WxInstallDartDPIChangedEventCallback _wxInstallDartDPIChangedEventCallback;

typedef OnDPIChangedEventFunc = void Function( WxDPIChangedEvent event );
class WxDPIChangedEventListItems {
  WxDPIChangedEventListItems( this.func, this.eventType );
  final OnDPIChangedEventFunc func;
  final int eventType;
}
Map<Pointer, List<WxDPIChangedEventListItems>> wxDPIChangedEventHandlerList = {};

void wxDPIChangedEventCallback( Pointer handle, Pointer eventHandle ) {
    WxDPIChangedEvent event = WxDPIChangedEvent.fromHandle( eventHandle );

    final List<WxDPIChangedEventListItems>? list = wxDPIChangedEventHandlerList[handle];
    if (list == null) {
      wxLogError('Handle does not exist in wxDPIChangedEventHandlerList');
      return;
    } else {
      for (int i = list.length-1; i >= 0; i--) { // go backwards to allow overloading
        final items = list[i];
        if (items.eventType != event.getEventType()) continue;
        event.skip( skip: false );
        items.func( event );
        if (!event.getSkipped()) return;
      }
    }
}

typedef WxDPIChangedEventCallbackNative = Void Function( Pointer, Pointer );
late NativeCallable<Void Function(Pointer<NativeType>, Pointer<NativeType>)> wxDPIChangedEventNativeCallable;

// ------------------------- wxUpdateUIEvent ----------------------

typedef _WxUpdateUIEventConstructorNative = Pointer Function( Int32  );
typedef _WxUpdateUIEventConstructor = Pointer Function( int  );
late _WxUpdateUIEventConstructor _wxUpdateUIEventConstructor;

typedef _WxUpdateUIEventGetCheckedNative = Bool Function( Pointer  );
typedef _WxUpdateUIEventGetChecked = bool Function( Pointer  );
late _WxUpdateUIEventGetChecked _wxUpdateUIEventGetChecked;

typedef _WxUpdateUIEventGetEnabledNative = Bool Function( Pointer  );
typedef _WxUpdateUIEventGetEnabled = bool Function( Pointer  );
late _WxUpdateUIEventGetEnabled _wxUpdateUIEventGetEnabled;

typedef _WxUpdateUIEventIsCheckableNative = Bool Function( Pointer  );
typedef _WxUpdateUIEventIsCheckable = bool Function( Pointer  );
late _WxUpdateUIEventIsCheckable _wxUpdateUIEventIsCheckable;

typedef _WxUpdateUIEventIs3StateNative = Bool Function( Pointer  );
typedef _WxUpdateUIEventIs3State = bool Function( Pointer  );
late _WxUpdateUIEventIs3State _wxUpdateUIEventIs3State;

typedef _WxUpdateUIEventGetTextNative = Pointer<Utf8> Function( Pointer  );
typedef _WxUpdateUIEventGetText = Pointer<Utf8> Function( Pointer  );
late _WxUpdateUIEventGetText _wxUpdateUIEventGetText;

typedef _WxUpdateUIEventGetSetCheckedNative = Bool Function( Pointer  );
typedef _WxUpdateUIEventGetSetChecked = bool Function( Pointer  );
late _WxUpdateUIEventGetSetChecked _wxUpdateUIEventGetSetChecked;

typedef _WxUpdateUIEventGetSetEnabledNative = Bool Function( Pointer  );
typedef _WxUpdateUIEventGetSetEnabled = bool Function( Pointer  );
late _WxUpdateUIEventGetSetEnabled _wxUpdateUIEventGetSetEnabled;

typedef _WxUpdateUIEventGetSetShownNative = Bool Function( Pointer  );
typedef _WxUpdateUIEventGetSetShown = bool Function( Pointer  );
late _WxUpdateUIEventGetSetShown _wxUpdateUIEventGetSetShown;

typedef _WxUpdateUIEventGetSetTextNative = Bool Function( Pointer  );
typedef _WxUpdateUIEventGetSetText = bool Function( Pointer  );
late _WxUpdateUIEventGetSetText _wxUpdateUIEventGetSetText;

typedef _WxUpdateUIEventGetShownNative = Bool Function( Pointer  );
typedef _WxUpdateUIEventGetShown = bool Function( Pointer  );
late _WxUpdateUIEventGetShown _wxUpdateUIEventGetShown;

typedef _WxUpdateUIEventGet3StateValueNative = Int32 Function( Pointer  );
typedef _WxUpdateUIEventGet3StateValue = int Function( Pointer  );
late _WxUpdateUIEventGet3StateValue _wxUpdateUIEventGet3StateValue;

typedef _WxUpdateUIEventEnableNative = Void Function( Pointer, Bool  );
typedef _WxUpdateUIEventEnable = void Function( Pointer, bool  );
late _WxUpdateUIEventEnable _wxUpdateUIEventEnable;

typedef _WxUpdateUIEventCheckNative = Void Function( Pointer, Bool  );
typedef _WxUpdateUIEventCheck = void Function( Pointer, bool  );
late _WxUpdateUIEventCheck _wxUpdateUIEventCheck;

typedef _WxUpdateUIEventShowNative = Void Function( Pointer, Bool  );
typedef _WxUpdateUIEventShow = void Function( Pointer, bool  );
late _WxUpdateUIEventShow _wxUpdateUIEventShow;

typedef _WxUpdateUIEventSetTextNative = Void Function( Pointer, Pointer<Utf8>  );
typedef _WxUpdateUIEventSetText = void Function( Pointer, Pointer<Utf8>  );
late _WxUpdateUIEventSetText _wxUpdateUIEventSetText;

typedef _WxUpdateUIEventSet3StateValueNative = Void Function( Pointer, Int32  );
typedef _WxUpdateUIEventSet3StateValue = void Function( Pointer, int  );
late _WxUpdateUIEventSet3StateValue _wxUpdateUIEventSet3StateValue;

class WxUpdateUIEvent extends WxCommandEvent {
  WxUpdateUIEvent._defaultConstructor() : super._defaultConstructor();
  WxUpdateUIEvent( { int id = 0 } ) : super._defaultConstructor() {
    nativeHandle = _wxUpdateUIEventConstructor( id );
    attachFinalizer();
  }
  WxUpdateUIEvent.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  bool getChecked( ) {
    return _wxUpdateUIEventGetChecked( nativeHandle  );
  }

  bool getEnabled( ) {
    return _wxUpdateUIEventGetEnabled( nativeHandle  );
  }

  bool isCheckable( ) {
    return _wxUpdateUIEventIsCheckable( nativeHandle  );
  }

  bool is3State( ) {
    return _wxUpdateUIEventIs3State( nativeHandle  );
  }

  String getText( ) {
    Pointer<Utf8> ptrReturn = _wxUpdateUIEventGetText( nativeHandle  );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }

  bool getSetChecked( ) {
    return _wxUpdateUIEventGetSetChecked( nativeHandle  );
  }

  bool getSetEnabled( ) {
    return _wxUpdateUIEventGetSetEnabled( nativeHandle  );
  }

  bool getSetShown( ) {
    return _wxUpdateUIEventGetSetShown( nativeHandle  );
  }

  bool getSetText( ) {
    return _wxUpdateUIEventGetSetText( nativeHandle  );
  }

  bool getShown( ) {
    return _wxUpdateUIEventGetShown( nativeHandle  );
  }

  int get3StateValue( ) {
    return _wxUpdateUIEventGet3StateValue( nativeHandle  );
  }

  void enable( bool enable ) {
    _wxUpdateUIEventEnable( nativeHandle, enable );
  }

  void check( bool check ) {
    _wxUpdateUIEventCheck( nativeHandle, check );
  }

  void show( bool show ) {
    _wxUpdateUIEventShow( nativeHandle, show );
  }

  void setText( String text ) {
    final textUtf8 = text.toNativeUtf8();
    _wxUpdateUIEventSetText( nativeHandle, textUtf8 );
    malloc.free( textUtf8 );
  }

  void set3StateValue( int check ) {
    _wxUpdateUIEventSet3StateValue( nativeHandle, check );
  }
}

typedef _WxInstallDartUpdateUIEventCallbackNative = Void Function( Pointer );
typedef _WxInstallDartUpdateUIEventCallback = void Function( Pointer );
late _WxInstallDartUpdateUIEventCallback _wxInstallDartUpdateUIEventCallback;

typedef OnUpdateUIEventFunc = void Function( WxUpdateUIEvent event );
class WxUpdateUIEventListItems {
  WxUpdateUIEventListItems( this.func, this.eventType, this.eventId );
  final OnUpdateUIEventFunc func;
  final int eventType;
  final int eventId;
}
Map<Pointer, List<WxUpdateUIEventListItems>> wxUpdateUIEventHandlerList = {};

void wxUpdateUIEventCallback( Pointer handle, Pointer eventHandle ) {
    WxUpdateUIEvent event = WxUpdateUIEvent.fromHandle( eventHandle );

    final List<WxUpdateUIEventListItems>? list = wxUpdateUIEventHandlerList[handle];
    if (list == null) {
      wxLogError('Handle does not exist in wxUpdateUIEventHandlerList');
      return;
    } else {
      for (int i = list.length-1; i >= 0; i--) { // go backwards to allow overloading
        final items = list[i];
        if (items.eventType != event.getEventType()) continue;
        if ((items.eventId != -1) && (items.eventId != event.getId())) continue;
        event.skip( skip: false );
        items.func( event );
        if (!event.getSkipped()) return;
      }
    }
}

typedef WxUpdateUIEventCallbackNative = Void Function( Pointer, Pointer );
late NativeCallable<Void Function(Pointer<NativeType>, Pointer<NativeType>)> wxUpdateUIEventNativeCallable;

// ------------------------- wxTimerEvent ----------------------

typedef _WxTimerEventGetIntervalNative = Int32 Function( Pointer  );
typedef _WxTimerEventGetInterval = int Function( Pointer  );
late _WxTimerEventGetInterval _wxTimerEventGetInterval;

class WxTimerEvent extends WxEvent {
  WxTimerEvent._defaultConstructor() : super._defaultConstructor();
  WxTimerEvent.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  int getInterval( ) {
    return _wxTimerEventGetInterval( nativeHandle  );
  }
}

typedef _WxInstallDartTimerEventCallbackNative = Void Function( Pointer );
typedef _WxInstallDartTimerEventCallback = void Function( Pointer );
late _WxInstallDartTimerEventCallback _wxInstallDartTimerEventCallback;

typedef OnTimerEventFunc = void Function( WxTimerEvent event );
Map<Pointer, OnTimerEventFunc> wxTimerEventHandlerList = {};

void wxTimerEventCallback( Pointer handle, Pointer eventHandle ) {
    OnTimerEventFunc ?func = wxTimerEventHandlerList[handle];
    if (func != null) {
      func( WxTimerEvent.fromHandle( eventHandle ));
    }
}

typedef WxTimerEventCallbackNative = Void Function( Pointer, Pointer );
late NativeCallable<Void Function(Pointer<NativeType>, Pointer<NativeType>)> wxTimerEventNativeCallable;

// ------------------------- wxFocusEvent ----------------------

typedef _WxFocusEventConstructorNative = Pointer Function( Int32, Int32  );
typedef _WxFocusEventConstructor = Pointer Function( int, int  );
late _WxFocusEventConstructor _wxFocusEventConstructor;

typedef _WxFocusEventGetWindowNative = Pointer Function( Pointer  );
typedef _WxFocusEventGetWindow = Pointer Function( Pointer  );
late _WxFocusEventGetWindow _wxFocusEventGetWindow;

typedef _WxFocusEventSetWindowNative = Void Function( Pointer, Pointer  );
typedef _WxFocusEventSetWindow = void Function( Pointer, Pointer  );
late _WxFocusEventSetWindow _wxFocusEventSetWindow;

class WxFocusEvent extends WxEvent {
  WxFocusEvent._defaultConstructor() : super._defaultConstructor();
  WxFocusEvent( int type, int id ) : super._defaultConstructor() {
    nativeHandle = _wxFocusEventConstructor( type, id );
    attachFinalizer();
  }
  WxFocusEvent.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  WxWindow? getWindow( ) {
    final returnedNativeHandle = _wxFocusEventGetWindow( nativeHandle  );
    if (returnedNativeHandle == nullptr) return null;
    WxEvtHandler? eh = _evtHandlerList[returnedNativeHandle];
    if (eh != null) {
      // There already is a Dart class associated with this C++ object
      return eh as WxWindow;
    }
    return wxCreateBestMatchingClassFromWxWindowHandle( returnedNativeHandle );
  }

  void setWindow( WxWindow window ) {
    _wxFocusEventSetWindow( nativeHandle, window.nativeHandle );
  }
}

typedef _WxInstallDartFocusEventCallbackNative = Void Function( Pointer );
typedef _WxInstallDartFocusEventCallback = void Function( Pointer );
late _WxInstallDartFocusEventCallback _wxInstallDartFocusEventCallback;

typedef OnFocusEventFunc = void Function( WxFocusEvent event );
class WxFocusEventListItems {
  WxFocusEventListItems( this.func, this.eventType );
  final OnFocusEventFunc func;
  final int eventType;
}
Map<Pointer, List<WxFocusEventListItems>> wxFocusEventHandlerList = {};

void wxFocusEventCallback( Pointer handle, Pointer eventHandle ) {
    WxFocusEvent event = WxFocusEvent.fromHandle( eventHandle );

    final List<WxFocusEventListItems>? list = wxFocusEventHandlerList[handle];
    if (list == null) {
      wxLogError('Handle does not exist in wxFocusEventHandlerList');
      return;
    } else {
      for (int i = list.length-1; i >= 0; i--) { // go backwards to allow overloading
        final items = list[i];
        if (items.eventType != event.getEventType()) continue;
        event.skip( skip: false );
        items.func( event );
        if (!event.getSkipped()) return;
      }
    }
}

typedef WxFocusEventCallbackNative = Void Function( Pointer, Pointer );
late NativeCallable<Void Function(Pointer<NativeType>, Pointer<NativeType>)> wxFocusEventNativeCallable;

// ------------------------- wxMoveEvent ----------------------

typedef _WxMoveEventConstructorNative = Pointer Function( Int32, Int32, Int32  );
typedef _WxMoveEventConstructor = Pointer Function( int, int, int  );
late _WxMoveEventConstructor _wxMoveEventConstructor;

typedef _WxMoveEventGetPositionNative = WxPointNative Function( Pointer  );
typedef _WxMoveEventGetPosition = WxPointNative Function( Pointer  );
late _WxMoveEventGetPosition _wxMoveEventGetPosition;

typedef _WxMoveEventSetPositionNative = Void Function( Pointer, Int32, Int32  );
typedef _WxMoveEventSetPosition = void Function( Pointer, int, int  );
late _WxMoveEventSetPosition _wxMoveEventSetPosition;

typedef _WxMoveEventGetRectNative = WxRectNative Function( Pointer  );
typedef _WxMoveEventGetRect = WxRectNative Function( Pointer  );
late _WxMoveEventGetRect _wxMoveEventGetRect;

typedef _WxMoveEventSetRectNative = Void Function( Pointer, Int32, Int32, Int32, Int32  );
typedef _WxMoveEventSetRect = void Function( Pointer, int, int, int, int  );
late _WxMoveEventSetRect _wxMoveEventSetRect;

class WxMoveEvent extends WxEvent {
  WxMoveEvent._defaultConstructor() : super._defaultConstructor();
  WxMoveEvent( WxPoint pt, int id ) : super._defaultConstructor() {
    nativeHandle = _wxMoveEventConstructor( pt.x, pt.y, id );
    attachFinalizer();
  }
  WxMoveEvent.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  WxPoint getPosition( ) {
    final WxPointNative pointReturn = _wxMoveEventGetPosition( nativeHandle  );
    return WxPoint(pointReturn.x, pointReturn.y);
  }

  void setPosition( WxPoint pt ) {
    _wxMoveEventSetPosition( nativeHandle, pt.x, pt.y );
  }

  WxRect getRect( ) {
    final WxRectNative rectReturn = _wxMoveEventGetRect( nativeHandle  );
    return WxRect(rectReturn.x, rectReturn.y, rectReturn.width, rectReturn.height);
  }

  void setRect( WxRect rect ) {
    _wxMoveEventSetRect( nativeHandle, rect.x, rect.y, rect.width, rect.height );
  }
}

typedef _WxInstallDartMoveEventCallbackNative = Void Function( Pointer );
typedef _WxInstallDartMoveEventCallback = void Function( Pointer );
late _WxInstallDartMoveEventCallback _wxInstallDartMoveEventCallback;

typedef OnMoveEventFunc = void Function( WxMoveEvent event );
class WxMoveEventListItems {
  WxMoveEventListItems( this.func, this.eventType );
  final OnMoveEventFunc func;
  final int eventType;
}
Map<Pointer, List<WxMoveEventListItems>> wxMoveEventHandlerList = {};

void wxMoveEventCallback( Pointer handle, Pointer eventHandle ) {
    WxMoveEvent event = WxMoveEvent.fromHandle( eventHandle );

    final List<WxMoveEventListItems>? list = wxMoveEventHandlerList[handle];
    if (list == null) {
      wxLogError('Handle does not exist in wxMoveEventHandlerList');
      return;
    } else {
      for (int i = list.length-1; i >= 0; i--) { // go backwards to allow overloading
        final items = list[i];
        if (items.eventType != event.getEventType()) continue;
        event.skip( skip: false );
        items.func( event );
        if (!event.getSkipped()) return;
      }
    }
}

typedef WxMoveEventCallbackNative = Void Function( Pointer, Pointer );
late NativeCallable<Void Function(Pointer<NativeType>, Pointer<NativeType>)> wxMoveEventNativeCallable;

// ------------------------- wxCloseEvent ----------------------

typedef _WxCloseEventConstructorNative = Pointer Function( Int32  );
typedef _WxCloseEventConstructor = Pointer Function( int  );
late _WxCloseEventConstructor _wxCloseEventConstructor;

typedef _WxCloseEventCanVetoNative = Bool Function( Pointer  );
typedef _WxCloseEventCanVeto = bool Function( Pointer  );
late _WxCloseEventCanVeto _wxCloseEventCanVeto;

typedef _WxCloseEventGetLoggingOffNative = Bool Function( Pointer  );
typedef _WxCloseEventGetLoggingOff = bool Function( Pointer  );
late _WxCloseEventGetLoggingOff _wxCloseEventGetLoggingOff;

typedef _WxCloseEventGetVetoNative = Bool Function( Pointer  );
typedef _WxCloseEventGetVeto = bool Function( Pointer  );
late _WxCloseEventGetVeto _wxCloseEventGetVeto;

typedef _WxCloseEventVetoNative = Void Function( Pointer, Bool  );
typedef _WxCloseEventVeto = void Function( Pointer, bool  );
late _WxCloseEventVeto _wxCloseEventVeto;

class WxCloseEvent extends WxEvent {
  WxCloseEvent._defaultConstructor() : super._defaultConstructor();
  WxCloseEvent( int id ) : super._defaultConstructor() {
    nativeHandle = _wxCloseEventConstructor( id );
    attachFinalizer();
  }
  WxCloseEvent.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  bool canVeto( ) {
    return _wxCloseEventCanVeto( nativeHandle  );
  }

  bool getLoggingOff( ) {
    return _wxCloseEventGetLoggingOff( nativeHandle  );
  }

  bool getVeto( ) {
    return _wxCloseEventGetVeto( nativeHandle  );
  }

  void veto( bool veto ) {
    _wxCloseEventVeto( nativeHandle, veto );
  }
}

typedef _WxInstallDartCloseEventCallbackNative = Void Function( Pointer );
typedef _WxInstallDartCloseEventCallback = void Function( Pointer );
late _WxInstallDartCloseEventCallback _wxInstallDartCloseEventCallback;

typedef OnCloseEventFunc = void Function( WxCloseEvent event );
class WxCloseEventListItems {
  WxCloseEventListItems( this.func, this.eventType );
  final OnCloseEventFunc func;
  final int eventType;
}
Map<Pointer, List<WxCloseEventListItems>> wxCloseEventHandlerList = {};

void wxCloseEventCallback( Pointer handle, Pointer eventHandle ) {
    WxCloseEvent event = WxCloseEvent.fromHandle( eventHandle );

    final List<WxCloseEventListItems>? list = wxCloseEventHandlerList[handle];
    if (list == null) {
      wxLogError('Handle does not exist in wxCloseEventHandlerList');
      return;
    } else {
      for (int i = list.length-1; i >= 0; i--) { // go backwards to allow overloading
        final items = list[i];
        if (items.eventType != event.getEventType()) continue;
        event.skip( skip: false );
        items.func( event );
        if (!event.getSkipped()) return;
      }
    }
}

typedef WxCloseEventCallbackNative = Void Function( Pointer, Pointer );
late NativeCallable<Void Function(Pointer<NativeType>, Pointer<NativeType>)> wxCloseEventNativeCallable;

// ------------------------- wxKeyEvent ----------------------

typedef _WxKeyEventConstructorNative = Pointer Function( Int32  );
typedef _WxKeyEventConstructor = Pointer Function( int  );
late _WxKeyEventConstructor _wxKeyEventConstructor;

typedef _WxKeyEventGetKeyCodeNative = Int32 Function( Pointer  );
typedef _WxKeyEventGetKeyCode = int Function( Pointer  );
late _WxKeyEventGetKeyCode _wxKeyEventGetKeyCode;

typedef _WxKeyEventGetUnicodeKeyNative = Int32 Function( Pointer  );
typedef _WxKeyEventGetUnicodeKey = int Function( Pointer  );
late _WxKeyEventGetUnicodeKey _wxKeyEventGetUnicodeKey;

typedef _WxKeyEventControlDownNative = Bool Function( Pointer  );
typedef _WxKeyEventControlDown = bool Function( Pointer  );
late _WxKeyEventControlDown _wxKeyEventControlDown;

typedef _WxKeyEventMetaDownNative = Bool Function( Pointer  );
typedef _WxKeyEventMetaDown = bool Function( Pointer  );
late _WxKeyEventMetaDown _wxKeyEventMetaDown;

typedef _WxKeyEventShiftDownNative = Bool Function( Pointer  );
typedef _WxKeyEventShiftDown = bool Function( Pointer  );
late _WxKeyEventShiftDown _wxKeyEventShiftDown;

typedef _WxKeyEventCmdDownNative = Bool Function( Pointer  );
typedef _WxKeyEventCmdDown = bool Function( Pointer  );
late _WxKeyEventCmdDown _wxKeyEventCmdDown;

typedef _WxKeyEventHasModifiersNative = Bool Function( Pointer  );
typedef _WxKeyEventHasModifiers = bool Function( Pointer  );
late _WxKeyEventHasModifiers _wxKeyEventHasModifiers;

typedef _WxKeyEventHasAnyModifiersNative = Bool Function( Pointer  );
typedef _WxKeyEventHasAnyModifiers = bool Function( Pointer  );
late _WxKeyEventHasAnyModifiers _wxKeyEventHasAnyModifiers;

typedef _WxKeyEventAltDownNative = Bool Function( Pointer  );
typedef _WxKeyEventAltDown = bool Function( Pointer  );
late _WxKeyEventAltDown _wxKeyEventAltDown;

class WxKeyEvent extends WxEvent {
  WxKeyEvent._defaultConstructor() : super._defaultConstructor();
  WxKeyEvent( int eventType ) : super._defaultConstructor() {
    nativeHandle = _wxKeyEventConstructor( eventType );
    attachFinalizer();
  }
  WxKeyEvent.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  int getKeyCode( ) {
    return _wxKeyEventGetKeyCode( nativeHandle  );
  }

  int getUnicodeKey( ) {
    return _wxKeyEventGetUnicodeKey( nativeHandle  );
  }

  bool controlDown( ) {
    return _wxKeyEventControlDown( nativeHandle  );
  }

  bool metaDown( ) {
    return _wxKeyEventMetaDown( nativeHandle  );
  }

  bool shiftDown( ) {
    return _wxKeyEventShiftDown( nativeHandle  );
  }

  bool cmdDown( ) {
    return _wxKeyEventCmdDown( nativeHandle  );
  }

  bool hasModifiers( ) {
    return _wxKeyEventHasModifiers( nativeHandle  );
  }

  bool hasAnyModifiers( ) {
    return _wxKeyEventHasAnyModifiers( nativeHandle  );
  }

  bool altDown( ) {
    return _wxKeyEventAltDown( nativeHandle  );
  }
}

typedef _WxInstallDartKeyEventCallbackNative = Void Function( Pointer );
typedef _WxInstallDartKeyEventCallback = void Function( Pointer );
late _WxInstallDartKeyEventCallback _wxInstallDartKeyEventCallback;

typedef OnKeyEventFunc = void Function( WxKeyEvent event );
class WxKeyEventListItems {
  WxKeyEventListItems( this.func, this.eventType );
  final OnKeyEventFunc func;
  final int eventType;
}
Map<Pointer, List<WxKeyEventListItems>> wxKeyEventHandlerList = {};

void wxKeyEventCallback( Pointer handle, Pointer eventHandle ) {
    WxKeyEvent event = WxKeyEvent.fromHandle( eventHandle );

    final List<WxKeyEventListItems>? list = wxKeyEventHandlerList[handle];
    if (list == null) {
      wxLogError('Handle does not exist in wxKeyEventHandlerList');
      return;
    } else {
      for (int i = list.length-1; i >= 0; i--) { // go backwards to allow overloading
        final items = list[i];
        if (items.eventType != event.getEventType()) continue;
        event.skip( skip: false );
        items.func( event );
        if (!event.getSkipped()) return;
      }
    }
}

typedef WxKeyEventCallbackNative = Void Function( Pointer, Pointer );
late NativeCallable<Void Function(Pointer<NativeType>, Pointer<NativeType>)> wxKeyEventNativeCallable;

// ------------------------- wxMouseEvent ----------------------

typedef _WxMouseEventConstructorNative = Pointer Function( Int32  );
typedef _WxMouseEventConstructor = Pointer Function( int  );
late _WxMouseEventConstructor _wxMouseEventConstructor;

typedef _WxMouseEventGetButtonNative = Int32 Function( Pointer  );
typedef _WxMouseEventGetButton = int Function( Pointer  );
late _WxMouseEventGetButton _wxMouseEventGetButton;

typedef _WxMouseEventGetClickCountNative = Int32 Function( Pointer  );
typedef _WxMouseEventGetClickCount = int Function( Pointer  );
late _WxMouseEventGetClickCount _wxMouseEventGetClickCount;

typedef _WxMouseEventButtonDownNative = Bool Function( Pointer, Int32  );
typedef _WxMouseEventButtonDown = bool Function( Pointer, int  );
late _WxMouseEventButtonDown _wxMouseEventButtonDown;

typedef _WxMouseEventButtonUpNative = Bool Function( Pointer, Int32  );
typedef _WxMouseEventButtonUp = bool Function( Pointer, int  );
late _WxMouseEventButtonUp _wxMouseEventButtonUp;

typedef _WxMouseEventButtonDClickNative = Bool Function( Pointer, Int32  );
typedef _WxMouseEventButtonDClick = bool Function( Pointer, int  );
late _WxMouseEventButtonDClick _wxMouseEventButtonDClick;

typedef _WxMouseEventLeftDownNative = Bool Function( Pointer  );
typedef _WxMouseEventLeftDown = bool Function( Pointer  );
late _WxMouseEventLeftDown _wxMouseEventLeftDown;

typedef _WxMouseEventRightDownNative = Bool Function( Pointer  );
typedef _WxMouseEventRightDown = bool Function( Pointer  );
late _WxMouseEventRightDown _wxMouseEventRightDown;

typedef _WxMouseEventMiddleDownNative = Bool Function( Pointer  );
typedef _WxMouseEventMiddleDown = bool Function( Pointer  );
late _WxMouseEventMiddleDown _wxMouseEventMiddleDown;

typedef _WxMouseEventLeftDClickNative = Bool Function( Pointer  );
typedef _WxMouseEventLeftDClick = bool Function( Pointer  );
late _WxMouseEventLeftDClick _wxMouseEventLeftDClick;

typedef _WxMouseEventRightDClickNative = Bool Function( Pointer  );
typedef _WxMouseEventRightDClick = bool Function( Pointer  );
late _WxMouseEventRightDClick _wxMouseEventRightDClick;

typedef _WxMouseEventMiddleDClickNative = Bool Function( Pointer  );
typedef _WxMouseEventMiddleDClick = bool Function( Pointer  );
late _WxMouseEventMiddleDClick _wxMouseEventMiddleDClick;

typedef _WxMouseEventLeftUpNative = Bool Function( Pointer  );
typedef _WxMouseEventLeftUp = bool Function( Pointer  );
late _WxMouseEventLeftUp _wxMouseEventLeftUp;

typedef _WxMouseEventRightUpNative = Bool Function( Pointer  );
typedef _WxMouseEventRightUp = bool Function( Pointer  );
late _WxMouseEventRightUp _wxMouseEventRightUp;

typedef _WxMouseEventMiddleUpNative = Bool Function( Pointer  );
typedef _WxMouseEventMiddleUp = bool Function( Pointer  );
late _WxMouseEventMiddleUp _wxMouseEventMiddleUp;

typedef _WxMouseEventDraggingNative = Bool Function( Pointer  );
typedef _WxMouseEventDragging = bool Function( Pointer  );
late _WxMouseEventDragging _wxMouseEventDragging;

typedef _WxMouseEventEnteringNative = Bool Function( Pointer  );
typedef _WxMouseEventEntering = bool Function( Pointer  );
late _WxMouseEventEntering _wxMouseEventEntering;

typedef _WxMouseEventLeavingNative = Bool Function( Pointer  );
typedef _WxMouseEventLeaving = bool Function( Pointer  );
late _WxMouseEventLeaving _wxMouseEventLeaving;

typedef _WxMouseEventMovingNative = Bool Function( Pointer  );
typedef _WxMouseEventMoving = bool Function( Pointer  );
late _WxMouseEventMoving _wxMouseEventMoving;

typedef _WxMouseEventMagnifyNative = Bool Function( Pointer  );
typedef _WxMouseEventMagnify = bool Function( Pointer  );
late _WxMouseEventMagnify _wxMouseEventMagnify;

typedef _WxMouseEventGetXNative = Int32 Function( Pointer  );
typedef _WxMouseEventGetX = int Function( Pointer  );
late _WxMouseEventGetX _wxMouseEventGetX;

typedef _WxMouseEventGetYNative = Int32 Function( Pointer  );
typedef _WxMouseEventGetY = int Function( Pointer  );
late _WxMouseEventGetY _wxMouseEventGetY;

typedef _WxMouseEventGetPositionNative = WxPointNative Function( Pointer  );
typedef _WxMouseEventGetPosition = WxPointNative Function( Pointer  );
late _WxMouseEventGetPosition _wxMouseEventGetPosition;

typedef _WxMouseEventSetXNative = Void Function( Pointer, Int32  );
typedef _WxMouseEventSetX = void Function( Pointer, int  );
late _WxMouseEventSetX _wxMouseEventSetX;

typedef _WxMouseEventSetYNative = Void Function( Pointer, Int32  );
typedef _WxMouseEventSetY = void Function( Pointer, int  );
late _WxMouseEventSetY _wxMouseEventSetY;

typedef _WxMouseEventSetPositionNative = Void Function( Pointer, Int32, Int32  );
typedef _WxMouseEventSetPosition = void Function( Pointer, int, int  );
late _WxMouseEventSetPosition _wxMouseEventSetPosition;

typedef _WxMouseEventGetWheelAxisNative = Int32 Function( Pointer  );
typedef _WxMouseEventGetWheelAxis = int Function( Pointer  );
late _WxMouseEventGetWheelAxis _wxMouseEventGetWheelAxis;

typedef _WxMouseEventGetWheelDeltaNative = Int32 Function( Pointer  );
typedef _WxMouseEventGetWheelDelta = int Function( Pointer  );
late _WxMouseEventGetWheelDelta _wxMouseEventGetWheelDelta;

typedef _WxMouseEventGetWheelRotationNative = Int32 Function( Pointer  );
typedef _WxMouseEventGetWheelRotation = int Function( Pointer  );
late _WxMouseEventGetWheelRotation _wxMouseEventGetWheelRotation;

typedef _WxMouseEventIsWheelInvertedNative = Bool Function( Pointer  );
typedef _WxMouseEventIsWheelInverted = bool Function( Pointer  );
late _WxMouseEventIsWheelInverted _wxMouseEventIsWheelInverted;

typedef _WxMouseEventLeftIsDownNative = Bool Function( Pointer  );
typedef _WxMouseEventLeftIsDown = bool Function( Pointer  );
late _WxMouseEventLeftIsDown _wxMouseEventLeftIsDown;

typedef _WxMouseEventRightIsDownNative = Bool Function( Pointer  );
typedef _WxMouseEventRightIsDown = bool Function( Pointer  );
late _WxMouseEventRightIsDown _wxMouseEventRightIsDown;

typedef _WxMouseEventMiddleIsDownNative = Bool Function( Pointer  );
typedef _WxMouseEventMiddleIsDown = bool Function( Pointer  );
late _WxMouseEventMiddleIsDown _wxMouseEventMiddleIsDown;

typedef _WxMouseEventSetLeftDownNative = Void Function( Pointer, Bool  );
typedef _WxMouseEventSetLeftDown = void Function( Pointer, bool  );
late _WxMouseEventSetLeftDown _wxMouseEventSetLeftDown;

typedef _WxMouseEventSetRightDownNative = Void Function( Pointer, Bool  );
typedef _WxMouseEventSetRightDown = void Function( Pointer, bool  );
late _WxMouseEventSetRightDown _wxMouseEventSetRightDown;

typedef _WxMouseEventSetMiddleDownNative = Void Function( Pointer, Bool  );
typedef _WxMouseEventSetMiddleDown = void Function( Pointer, bool  );
late _WxMouseEventSetMiddleDown _wxMouseEventSetMiddleDown;

typedef _WxMouseEventControlDownNative = Bool Function( Pointer  );
typedef _WxMouseEventControlDown = bool Function( Pointer  );
late _WxMouseEventControlDown _wxMouseEventControlDown;

typedef _WxMouseEventMetaDownNative = Bool Function( Pointer  );
typedef _WxMouseEventMetaDown = bool Function( Pointer  );
late _WxMouseEventMetaDown _wxMouseEventMetaDown;

typedef _WxMouseEventShiftDownNative = Bool Function( Pointer  );
typedef _WxMouseEventShiftDown = bool Function( Pointer  );
late _WxMouseEventShiftDown _wxMouseEventShiftDown;

typedef _WxMouseEventCmdDownNative = Bool Function( Pointer  );
typedef _WxMouseEventCmdDown = bool Function( Pointer  );
late _WxMouseEventCmdDown _wxMouseEventCmdDown;

typedef _WxMouseEventAltDownNative = Bool Function( Pointer  );
typedef _WxMouseEventAltDown = bool Function( Pointer  );
late _WxMouseEventAltDown _wxMouseEventAltDown;

typedef _WxMouseEventHasModifiersNative = Bool Function( Pointer  );
typedef _WxMouseEventHasModifiers = bool Function( Pointer  );
late _WxMouseEventHasModifiers _wxMouseEventHasModifiers;

typedef _WxMouseEventHasAnyModifiersNative = Bool Function( Pointer  );
typedef _WxMouseEventHasAnyModifiers = bool Function( Pointer  );
late _WxMouseEventHasAnyModifiers _wxMouseEventHasAnyModifiers;

/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxMOUSE_BTN_ANY | -1 |
/// | wxMOUSE_BTN_NONE | 0 |
/// | wxMOUSE_BTN_LEFT | 1 |
/// | wxMOUSE_BTN_MIDDLE | 2 |
/// | wxMOUSE_BTN_RIGHT | 3 |
/// | wxMOUSE_BTN_AUX1 | 4 |
/// | wxMOUSE_BTN_AUX2 | 5 |
/// | wxMOUSE_BTN_MAX | 6 |
/// | wxMOUSE_WHEEL_VERTICAL | 0 |
/// | wxMOUSE_WHEEL_HORIZONTAL | 1 |

const int wxMOUSE_BTN_ANY = -1;
const int wxMOUSE_BTN_NONE = 0;
const int wxMOUSE_BTN_LEFT = 1;
const int wxMOUSE_BTN_MIDDLE = 2;
const int wxMOUSE_BTN_RIGHT = 3;
const int wxMOUSE_BTN_AUX1 = 4;
const int wxMOUSE_BTN_AUX2 = 5;
const int wxMOUSE_BTN_MAX = 6;
const int wxMOUSE_WHEEL_VERTICAL = 0;
const int wxMOUSE_WHEEL_HORIZONTAL = 1;

class WxMouseEvent extends WxEvent {
  WxMouseEvent._defaultConstructor() : super._defaultConstructor();
  WxMouseEvent( int eventType ) : super._defaultConstructor() {
    nativeHandle = _wxMouseEventConstructor( eventType );
    attachFinalizer();
  }
  WxMouseEvent.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  int getButton( ) {
    return _wxMouseEventGetButton( nativeHandle  );
  }

  int getClickCount( ) {
    return _wxMouseEventGetClickCount( nativeHandle  );
  }

  bool buttonDown( { int but = wxMOUSE_BTN_ANY } ) {
    return _wxMouseEventButtonDown( nativeHandle, but );
  }

  bool buttonUp( { int but = wxMOUSE_BTN_ANY } ) {
    return _wxMouseEventButtonUp( nativeHandle, but );
  }

  bool buttonDClick( { int but = wxMOUSE_BTN_ANY } ) {
    return _wxMouseEventButtonDClick( nativeHandle, but );
  }

  bool leftDown( ) {
    return _wxMouseEventLeftDown( nativeHandle  );
  }

  bool rightDown( ) {
    return _wxMouseEventRightDown( nativeHandle  );
  }

  bool middleDown( ) {
    return _wxMouseEventMiddleDown( nativeHandle  );
  }

  bool leftDClick( ) {
    return _wxMouseEventLeftDClick( nativeHandle  );
  }

  bool rightDClick( ) {
    return _wxMouseEventRightDClick( nativeHandle  );
  }

  bool middleDClick( ) {
    return _wxMouseEventMiddleDClick( nativeHandle  );
  }

  bool leftUp( ) {
    return _wxMouseEventLeftUp( nativeHandle  );
  }

  bool rightUp( ) {
    return _wxMouseEventRightUp( nativeHandle  );
  }

  bool middleUp( ) {
    return _wxMouseEventMiddleUp( nativeHandle  );
  }

  bool dragging( ) {
    return _wxMouseEventDragging( nativeHandle  );
  }

  bool entering( ) {
    return _wxMouseEventEntering( nativeHandle  );
  }

  bool leaving( ) {
    return _wxMouseEventLeaving( nativeHandle  );
  }

  bool moving( ) {
    return _wxMouseEventMoving( nativeHandle  );
  }

  bool magnify( ) {
    return _wxMouseEventMagnify( nativeHandle  );
  }

  int getX( ) {
    return _wxMouseEventGetX( nativeHandle  );
  }

  int getY( ) {
    return _wxMouseEventGetY( nativeHandle  );
  }

  WxPoint getPosition( ) {
    final WxPointNative pointReturn = _wxMouseEventGetPosition( nativeHandle  );
    return WxPoint(pointReturn.x, pointReturn.y);
  }

  void setX( int x ) {
    _wxMouseEventSetX( nativeHandle, x );
  }

  void setY( int y ) {
    _wxMouseEventSetY( nativeHandle, y );
  }

  void setPosition( WxPoint pos ) {
    _wxMouseEventSetPosition( nativeHandle, pos.x, pos.y );
  }

  int getWheelAxis( ) {
    return _wxMouseEventGetWheelAxis( nativeHandle  );
  }

  int getWheelDelta( ) {
    return _wxMouseEventGetWheelDelta( nativeHandle  );
  }

  int getWheelRotation( ) {
    return _wxMouseEventGetWheelRotation( nativeHandle  );
  }

  bool isWheelInverted( ) {
    return _wxMouseEventIsWheelInverted( nativeHandle  );
  }

  bool leftIsDown( ) {
    return _wxMouseEventLeftIsDown( nativeHandle  );
  }

  bool rightIsDown( ) {
    return _wxMouseEventRightIsDown( nativeHandle  );
  }

  bool middleIsDown( ) {
    return _wxMouseEventMiddleIsDown( nativeHandle  );
  }

  void setLeftDown( bool down ) {
    _wxMouseEventSetLeftDown( nativeHandle, down );
  }

  void setRightDown( bool down ) {
    _wxMouseEventSetRightDown( nativeHandle, down );
  }

  void setMiddleDown( bool down ) {
    _wxMouseEventSetMiddleDown( nativeHandle, down );
  }

  bool controlDown( ) {
    return _wxMouseEventControlDown( nativeHandle  );
  }

  bool metaDown( ) {
    return _wxMouseEventMetaDown( nativeHandle  );
  }

  bool shiftDown( ) {
    return _wxMouseEventShiftDown( nativeHandle  );
  }

  bool cmdDown( ) {
    return _wxMouseEventCmdDown( nativeHandle  );
  }

  bool altDown( ) {
    return _wxMouseEventAltDown( nativeHandle  );
  }

  bool hasModifiers( ) {
    return _wxMouseEventHasModifiers( nativeHandle  );
  }

  bool hasAnyModifiers( ) {
    return _wxMouseEventHasAnyModifiers( nativeHandle  );
  }
}

typedef _WxInstallDartMouseEventCallbackNative = Void Function( Pointer );
typedef _WxInstallDartMouseEventCallback = void Function( Pointer );
late _WxInstallDartMouseEventCallback _wxInstallDartMouseEventCallback;

typedef OnMouseEventFunc = void Function( WxMouseEvent event );
class WxMouseEventListItems {
  WxMouseEventListItems( this.func, this.eventType );
  final OnMouseEventFunc func;
  final int eventType;
}
Map<Pointer, List<WxMouseEventListItems>> wxMouseEventHandlerList = {};

void wxMouseEventCallback( Pointer handle, Pointer eventHandle ) {
    WxMouseEvent event = WxMouseEvent.fromHandle( eventHandle );

    final List<WxMouseEventListItems>? list = wxMouseEventHandlerList[handle];
    if (list == null) {
      wxLogError('Handle does not exist in wxMouseEventHandlerList');
      return;
    } else {
      for (int i = list.length-1; i >= 0; i--) { // go backwards to allow overloading
        final items = list[i];
        if (items.eventType != event.getEventType()) continue;
        event.skip( skip: false );
        items.func( event );
        if (!event.getSkipped()) return;
      }
    }
}

typedef WxMouseEventCallbackNative = Void Function( Pointer, Pointer );
late NativeCallable<Void Function(Pointer<NativeType>, Pointer<NativeType>)> wxMouseEventNativeCallable;

// ------------------------- wxPaintEvent ----------------------

class WxPaintEvent extends WxEvent {
  WxPaintEvent._defaultConstructor() : super._defaultConstructor();
  WxPaintEvent.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }
}

typedef _WxInstallDartPaintEventCallbackNative = Void Function( Pointer );
typedef _WxInstallDartPaintEventCallback = void Function( Pointer );
late _WxInstallDartPaintEventCallback _wxInstallDartPaintEventCallback;

typedef OnPaintEventFunc = void Function( WxPaintEvent event );
Map<Pointer, OnPaintEventFunc> wxPaintEventHandlerList = {};

void wxPaintEventCallback( Pointer handle, Pointer eventHandle ) {
    OnPaintEventFunc ?func = wxPaintEventHandlerList[handle];
    if (func != null) {
      func( WxPaintEvent.fromHandle( eventHandle ));
      if (_theGraphicsContext != null) {
        _theGraphicsContext!.forceNativeDestroy();
        _theGraphicsContext = null;
      }
      if (_thePaintDC != null) {
        _thePaintDC!.forceNativeDestroy();
        _thePaintDC = null;
      }
    }
}

typedef WxPaintEventCallbackNative = Void Function( Pointer, Pointer );
late NativeCallable<Void Function(Pointer<NativeType>, Pointer<NativeType>)> wxPaintEventNativeCallable;

// ------------------------- wxCommandEvent ----------------------

typedef _WxCommandEventConstructorNative = Pointer Function( Int32, Int32  );
typedef _WxCommandEventConstructor = Pointer Function( int, int  );
late _WxCommandEventConstructor _wxCommandEventConstructor;

typedef _WxCommandEventGetIntNative = Int32 Function( Pointer  );
typedef _WxCommandEventGetInt = int Function( Pointer  );
late _WxCommandEventGetInt _wxCommandEventGetInt;

typedef _WxCommandEventSetIntNative = Void Function( Pointer, Int32  );
typedef _WxCommandEventSetInt = void Function( Pointer, int  );
late _WxCommandEventSetInt _wxCommandEventSetInt;

typedef _WxCommandEventGetExtraLongNative = Int32 Function( Pointer  );
typedef _WxCommandEventGetExtraLong = int Function( Pointer  );
late _WxCommandEventGetExtraLong _wxCommandEventGetExtraLong;

typedef _WxCommandEventSetExtraLongNative = Void Function( Pointer, Int32  );
typedef _WxCommandEventSetExtraLong = void Function( Pointer, int  );
late _WxCommandEventSetExtraLong _wxCommandEventSetExtraLong;

typedef _WxCommandEventGetSelectionNative = Int32 Function( Pointer  );
typedef _WxCommandEventGetSelection = int Function( Pointer  );
late _WxCommandEventGetSelection _wxCommandEventGetSelection;

typedef _WxCommandEventIsCheckedNative = Bool Function( Pointer  );
typedef _WxCommandEventIsChecked = bool Function( Pointer  );
late _WxCommandEventIsChecked _wxCommandEventIsChecked;

typedef _WxCommandEventIsSelectionNative = Bool Function( Pointer  );
typedef _WxCommandEventIsSelection = bool Function( Pointer  );
late _WxCommandEventIsSelection _wxCommandEventIsSelection;

typedef _WxCommandEventGetStringNative = Pointer<Utf8> Function( Pointer  );
typedef _WxCommandEventGetString = Pointer<Utf8> Function( Pointer  );
late _WxCommandEventGetString _wxCommandEventGetString;

typedef _WxCommandEventSetStringNative = Void Function( Pointer, Pointer<Utf8>  );
typedef _WxCommandEventSetString = void Function( Pointer, Pointer<Utf8>  );
late _WxCommandEventSetString _wxCommandEventSetString;

typedef _WxCommandEventSetClientDataNative = Void Function( Pointer, Pointer  );
typedef _WxCommandEventSetClientData = void Function( Pointer, Pointer  );
late _WxCommandEventSetClientData _wxCommandEventSetClientData;

typedef _WxCommandEventGetClientDataNative = Pointer Function( Pointer  );
typedef _WxCommandEventGetClientData = Pointer Function( Pointer  );
late _WxCommandEventGetClientData _wxCommandEventGetClientData;

class WxCommandEvent extends WxEvent {
  WxCommandEvent._defaultConstructor() : super._defaultConstructor();
  WxCommandEvent( int eventType, int id ) : super._defaultConstructor() {
    nativeHandle = _wxCommandEventConstructor( eventType, id );
    attachFinalizer();
  }
  WxCommandEvent.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  int getInt( ) {
    return _wxCommandEventGetInt( nativeHandle  );
  }

  void setInt( int intCommand ) {
    _wxCommandEventSetInt( nativeHandle, intCommand );
  }

  int getExtraLong( ) {
    return _wxCommandEventGetExtraLong( nativeHandle  );
  }

  void setExtraLong( int extraLong ) {
    _wxCommandEventSetExtraLong( nativeHandle, extraLong );
  }

  int getSelection( ) {
    return _wxCommandEventGetSelection( nativeHandle  );
  }

  bool isChecked( ) {
    return _wxCommandEventIsChecked( nativeHandle  );
  }

  bool isSelection( ) {
    return _wxCommandEventIsSelection( nativeHandle  );
  }

  String getString( ) {
    Pointer<Utf8> ptrReturn = _wxCommandEventGetString( nativeHandle  );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }

  void setString( String string ) {
    final stringUtf8 = string.toNativeUtf8();
    _wxCommandEventSetString( nativeHandle, stringUtf8 );
    malloc.free( stringUtf8 );
  }

  void setClientData( dynamic data ) {
    final dataClientDataNativeHandle = _wxClientDataConstructor();
    _clientDataList[ dataClientDataNativeHandle ] = data;
    _wxCommandEventSetClientData( nativeHandle, dataClientDataNativeHandle );
  }

  dynamic getClientData( ) {
    final returnedNativeHandle = _wxCommandEventGetClientData( nativeHandle  );
    if (returnedNativeHandle == nullptr) return null;
    return _clientDataList[ returnedNativeHandle ] ;
  }
}

typedef _WxInstallDartCommandEventCallbackNative = Void Function( Pointer );
typedef _WxInstallDartCommandEventCallback = void Function( Pointer );
late _WxInstallDartCommandEventCallback _wxInstallDartCommandEventCallback;

typedef OnCommandEventFunc = void Function( WxCommandEvent event );
class WxCommandEventListItems {
  WxCommandEventListItems( this.func, this.eventType, this.eventId );
  final OnCommandEventFunc func;
  final int eventType;
  final int eventId;
}
Map<Pointer, List<WxCommandEventListItems>> wxCommandEventHandlerList = {};

void wxCommandEventCallback( Pointer handle, Pointer eventHandle ) {
    WxCommandEvent event = WxCommandEvent.fromHandle( eventHandle );

    final List<WxCommandEventListItems>? list = wxCommandEventHandlerList[handle];
    if (list == null) {
      wxLogError('Handle does not exist in wxCommandEventHandlerList');
      return;
    } else {
      for (int i = list.length-1; i >= 0; i--) { // go backwards to allow overloading
        final items = list[i];
        if (items.eventType != event.getEventType()) continue;
        if ((items.eventId != -1) && (items.eventId != event.getId())) continue;
        event.skip( skip: false );
        items.func( event );
        if (!event.getSkipped()) return;
      }
    }
}

typedef WxCommandEventCallbackNative = Void Function( Pointer, Pointer );
late NativeCallable<Void Function(Pointer<NativeType>, Pointer<NativeType>)> wxCommandEventNativeCallable;

// ------------------------- wxNotifyEvent ----------------------

typedef _WxNotifyEventConstructorNative = Pointer Function( Int32, Int32  );
typedef _WxNotifyEventConstructor = Pointer Function( int, int  );
late _WxNotifyEventConstructor _wxNotifyEventConstructor;

typedef _WxNotifyEventAllowNative = Void Function( Pointer  );
typedef _WxNotifyEventAllow = void Function( Pointer  );
late _WxNotifyEventAllow _wxNotifyEventAllow;

typedef _WxNotifyEventVetoNative = Void Function( Pointer  );
typedef _WxNotifyEventVeto = void Function( Pointer  );
late _WxNotifyEventVeto _wxNotifyEventVeto;

typedef _WxNotifyEventIsAllowedNative = Bool Function( Pointer  );
typedef _WxNotifyEventIsAllowed = bool Function( Pointer  );
late _WxNotifyEventIsAllowed _wxNotifyEventIsAllowed;

class WxNotifyEvent extends WxCommandEvent {
  WxNotifyEvent._defaultConstructor() : super._defaultConstructor();
  WxNotifyEvent( int eventType, int id ) : super._defaultConstructor() {
    nativeHandle = _wxNotifyEventConstructor( eventType, id );
    attachFinalizer();
  }
  WxNotifyEvent.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  void allow( ) {
    _wxNotifyEventAllow( nativeHandle  );
  }

  void veto( ) {
    _wxNotifyEventVeto( nativeHandle  );
  }

  bool isAllowed( ) {
    return _wxNotifyEventIsAllowed( nativeHandle  );
  }
}

typedef _WxInstallDartNotifyEventCallbackNative = Void Function( Pointer );
typedef _WxInstallDartNotifyEventCallback = void Function( Pointer );
late _WxInstallDartNotifyEventCallback _wxInstallDartNotifyEventCallback;

typedef OnNotifyEventFunc = void Function( WxNotifyEvent event );
class WxNotifyEventListItems {
  WxNotifyEventListItems( this.func, this.eventType, this.eventId );
  final OnNotifyEventFunc func;
  final int eventType;
  final int eventId;
}
Map<Pointer, List<WxNotifyEventListItems>> wxNotifyEventHandlerList = {};

void wxNotifyEventCallback( Pointer handle, Pointer eventHandle ) {
    WxNotifyEvent event = WxNotifyEvent.fromHandle( eventHandle );

    final List<WxNotifyEventListItems>? list = wxNotifyEventHandlerList[handle];
    if (list == null) {
      wxLogError('Handle does not exist in wxNotifyEventHandlerList');
      return;
    } else {
      for (int i = list.length-1; i >= 0; i--) { // go backwards to allow overloading
        final items = list[i];
        if (items.eventType != event.getEventType()) continue;
        if ((items.eventId != -1) && (items.eventId != event.getId())) continue;
        event.skip( skip: false );
        items.func( event );
        if (!event.getSkipped()) return;
      }
    }
}

typedef WxNotifyEventCallbackNative = Void Function( Pointer, Pointer );
late NativeCallable<Void Function(Pointer<NativeType>, Pointer<NativeType>)> wxNotifyEventNativeCallable;

// ------------------------- wxInitDialogEvent ----------------------

typedef _WxInitDialogEventConstructorNative = Pointer Function( Int32  );
typedef _WxInitDialogEventConstructor = Pointer Function( int  );
late _WxInitDialogEventConstructor _wxInitDialogEventConstructor;

class WxInitDialogEvent extends WxEvent {
  WxInitDialogEvent._defaultConstructor() : super._defaultConstructor();
  WxInitDialogEvent( { int id = 0 } ) : super._defaultConstructor() {
    nativeHandle = _wxInitDialogEventConstructor( id );
    attachFinalizer();
  }
  WxInitDialogEvent.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }
}

typedef _WxInstallDartInitDialogEventCallbackNative = Void Function( Pointer );
typedef _WxInstallDartInitDialogEventCallback = void Function( Pointer );
late _WxInstallDartInitDialogEventCallback _wxInstallDartInitDialogEventCallback;

typedef OnInitDialogEventFunc = void Function( WxInitDialogEvent event );
class WxInitDialogEventListItems {
  WxInitDialogEventListItems( this.func, this.eventType );
  final OnInitDialogEventFunc func;
  final int eventType;
}
Map<Pointer, List<WxInitDialogEventListItems>> wxInitDialogEventHandlerList = {};

void wxInitDialogEventCallback( Pointer handle, Pointer eventHandle ) {
    WxInitDialogEvent event = WxInitDialogEvent.fromHandle( eventHandle );

    final List<WxInitDialogEventListItems>? list = wxInitDialogEventHandlerList[handle];
    if (list == null) {
      wxLogError('Handle does not exist in wxInitDialogEventHandlerList');
      return;
    } else {
      for (int i = list.length-1; i >= 0; i--) { // go backwards to allow overloading
        final items = list[i];
        if (items.eventType != event.getEventType()) continue;
        event.skip( skip: false );
        items.func( event );
        if (!event.getSkipped()) return;
      }
    }
}

typedef WxInitDialogEventCallbackNative = Void Function( Pointer, Pointer );
late NativeCallable<Void Function(Pointer<NativeType>, Pointer<NativeType>)> wxInitDialogEventNativeCallable;

// ------------------------- wxDialogValidateEvent ----------------------

typedef _WxDialogValidateEventConstructorNative = Pointer Function( Int32  );
typedef _WxDialogValidateEventConstructor = Pointer Function( int  );
late _WxDialogValidateEventConstructor _wxDialogValidateEventConstructor;

class WxDialogValidateEvent extends WxNotifyEvent {
  WxDialogValidateEvent._defaultConstructor() : super._defaultConstructor();
  WxDialogValidateEvent( { int id = 0 } ) : super._defaultConstructor() {
    nativeHandle = _wxDialogValidateEventConstructor( id );
    attachFinalizer();
  }
  WxDialogValidateEvent.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }
}

typedef _WxInstallDartDialogValidateEventCallbackNative = Void Function( Pointer );
typedef _WxInstallDartDialogValidateEventCallback = void Function( Pointer );
late _WxInstallDartDialogValidateEventCallback _wxInstallDartDialogValidateEventCallback;

typedef OnDialogValidateEventFunc = void Function( WxDialogValidateEvent event );
class WxDialogValidateEventListItems {
  WxDialogValidateEventListItems( this.func, this.eventType, this.eventId );
  final OnDialogValidateEventFunc func;
  final int eventType;
  final int eventId;
}
Map<Pointer, List<WxDialogValidateEventListItems>> wxDialogValidateEventHandlerList = {};

void wxDialogValidateEventCallback( Pointer handle, Pointer eventHandle ) {
    WxDialogValidateEvent event = WxDialogValidateEvent.fromHandle( eventHandle );

    final List<WxDialogValidateEventListItems>? list = wxDialogValidateEventHandlerList[handle];
    if (list == null) {
      wxLogError('Handle does not exist in wxDialogValidateEventHandlerList');
      return;
    } else {
      for (int i = list.length-1; i >= 0; i--) { // go backwards to allow overloading
        final items = list[i];
        if (items.eventType != event.getEventType()) continue;
        if ((items.eventId != -1) && (items.eventId != event.getId())) continue;
        event.skip( skip: false );
        items.func( event );
        if (!event.getSkipped()) return;
      }
    }
}

typedef WxDialogValidateEventCallbackNative = Void Function( Pointer, Pointer );
late NativeCallable<Void Function(Pointer<NativeType>, Pointer<NativeType>)> wxDialogValidateEventNativeCallable;

// ------------------------- wxScrollWinEvent ----------------------

typedef _WxScrollWinEventConstructorNative = Pointer Function( Int32, Int32, Int32  );
typedef _WxScrollWinEventConstructor = Pointer Function( int, int, int  );
late _WxScrollWinEventConstructor _wxScrollWinEventConstructor;

typedef _WxScrollWinEventGetOrientationNative = Int32 Function( Pointer  );
typedef _WxScrollWinEventGetOrientation = int Function( Pointer  );
late _WxScrollWinEventGetOrientation _wxScrollWinEventGetOrientation;

typedef _WxScrollWinEventSetOrientationNative = Void Function( Pointer, Int32  );
typedef _WxScrollWinEventSetOrientation = void Function( Pointer, int  );
late _WxScrollWinEventSetOrientation _wxScrollWinEventSetOrientation;

typedef _WxScrollWinEventGetPositionNative = Int32 Function( Pointer  );
typedef _WxScrollWinEventGetPosition = int Function( Pointer  );
late _WxScrollWinEventGetPosition _wxScrollWinEventGetPosition;

typedef _WxScrollWinEventSetPositionNative = Void Function( Pointer, Int32  );
typedef _WxScrollWinEventSetPosition = void Function( Pointer, int  );
late _WxScrollWinEventSetPosition _wxScrollWinEventSetPosition;

typedef _WxScrollWinEventGetPixelOffsetNative = Int32 Function( Pointer  );
typedef _WxScrollWinEventGetPixelOffset = int Function( Pointer  );
late _WxScrollWinEventGetPixelOffset _wxScrollWinEventGetPixelOffset;

typedef _WxScrollWinEventSetPixelOffsetNative = Void Function( Pointer, Int32  );
typedef _WxScrollWinEventSetPixelOffset = void Function( Pointer, int  );
late _WxScrollWinEventSetPixelOffset _wxScrollWinEventSetPixelOffset;

class WxScrollWinEvent extends WxEvent {
  WxScrollWinEvent._defaultConstructor() : super._defaultConstructor();
  WxScrollWinEvent( int eventType, { int pos = 0, int orientation = 0 } ) : super._defaultConstructor() {
    nativeHandle = _wxScrollWinEventConstructor( eventType, pos, orientation );
    attachFinalizer();
  }
  WxScrollWinEvent.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  int getOrientation( ) {
    return _wxScrollWinEventGetOrientation( nativeHandle  );
  }

  void setOrientation( int orientation ) {
    _wxScrollWinEventSetOrientation( nativeHandle, orientation );
  }

  int getPosition( ) {
    return _wxScrollWinEventGetPosition( nativeHandle  );
  }

  void setPosition( int position ) {
    _wxScrollWinEventSetPosition( nativeHandle, position );
  }

  int getPixelOffset( ) {
    return _wxScrollWinEventGetPixelOffset( nativeHandle  );
  }

  void setPixelOffset( int pixelOffset ) {
    _wxScrollWinEventSetPixelOffset( nativeHandle, pixelOffset );
  }
}

typedef _WxInstallDartScrollWinEventCallbackNative = Void Function( Pointer );
typedef _WxInstallDartScrollWinEventCallback = void Function( Pointer );
late _WxInstallDartScrollWinEventCallback _wxInstallDartScrollWinEventCallback;

typedef OnScrollWinEventFunc = void Function( WxScrollWinEvent event );
class WxScrollWinEventListItems {
  WxScrollWinEventListItems( this.func, this.eventType );
  final OnScrollWinEventFunc func;
  final int eventType;
}
Map<Pointer, List<WxScrollWinEventListItems>> wxScrollWinEventHandlerList = {};

void wxScrollWinEventCallback( Pointer handle, Pointer eventHandle ) {
    WxScrollWinEvent event = WxScrollWinEvent.fromHandle( eventHandle );

    final List<WxScrollWinEventListItems>? list = wxScrollWinEventHandlerList[handle];
    if (list == null) {
      wxLogError('Handle does not exist in wxScrollWinEventHandlerList');
      return;
    } else {
      for (int i = list.length-1; i >= 0; i--) { // go backwards to allow overloading
        final items = list[i];
        if (items.eventType != event.getEventType()) continue;
        event.skip( skip: false );
        items.func( event );
        if (!event.getSkipped()) return;
      }
    }
}

typedef WxScrollWinEventCallbackNative = Void Function( Pointer, Pointer );
late NativeCallable<Void Function(Pointer<NativeType>, Pointer<NativeType>)> wxScrollWinEventNativeCallable;

// ------------------------- wxDragEvent ----------------------

typedef _WxDragEventConstructorNative = Pointer Function( Int32  );
typedef _WxDragEventConstructor = Pointer Function( int  );
late _WxDragEventConstructor _wxDragEventConstructor;

typedef _WxDragEventSetFeedbackNative = Void Function( Pointer, Int32  );
typedef _WxDragEventSetFeedback = void Function( Pointer, int  );
late _WxDragEventSetFeedback _wxDragEventSetFeedback;

class WxDragEvent extends WxNotifyEvent {
  WxDragEvent._defaultConstructor() : super._defaultConstructor();
  WxDragEvent( int id ) : super._defaultConstructor() {
    nativeHandle = _wxDragEventConstructor( id );
    attachFinalizer();
  }
  WxDragEvent.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  void setFeedback( int feedback ) {
    _wxDragEventSetFeedback( nativeHandle, feedback );
  }
}

typedef _WxInstallDartDragEventCallbackNative = Void Function( Pointer );
typedef _WxInstallDartDragEventCallback = void Function( Pointer );
late _WxInstallDartDragEventCallback _wxInstallDartDragEventCallback;

typedef OnDragEventFunc = void Function( WxDragEvent event );
class WxDragEventListItems {
  WxDragEventListItems( this.func, this.eventType, this.eventId );
  final OnDragEventFunc func;
  final int eventType;
  final int eventId;
}
Map<Pointer, List<WxDragEventListItems>> wxDragEventHandlerList = {};

void wxDragEventCallback( Pointer handle, Pointer eventHandle ) {
    WxDragEvent event = WxDragEvent.fromHandle( eventHandle );

    final List<WxDragEventListItems>? list = wxDragEventHandlerList[handle];
    if (list == null) {
      wxLogError('Handle does not exist in wxDragEventHandlerList');
      return;
    } else {
      for (int i = list.length-1; i >= 0; i--) { // go backwards to allow overloading
        final items = list[i];
        if (items.eventType != event.getEventType()) continue;
        if ((items.eventId != -1) && (items.eventId != event.getId())) continue;
        event.skip( skip: false );
        items.func( event );
        if (!event.getSkipped()) return;
      }
    }
}

typedef WxDragEventCallbackNative = Void Function( Pointer, Pointer );
late NativeCallable<Void Function(Pointer<NativeType>, Pointer<NativeType>)> wxDragEventNativeCallable;

// ------------------------- wxDropEvent ----------------------

typedef _WxDropEventConstructorNative = Pointer Function( Int32, Int32  );
typedef _WxDropEventConstructor = Pointer Function( int, int  );
late _WxDropEventConstructor _wxDropEventConstructor;

typedef _WxDropEventSetPositionNative = Void Function( Pointer, Int32, Int32  );
typedef _WxDropEventSetPosition = void Function( Pointer, int, int  );
late _WxDropEventSetPosition _wxDropEventSetPosition;

typedef _WxDropEventGetPositionNative = WxPointNative Function( Pointer  );
typedef _WxDropEventGetPosition = WxPointNative Function( Pointer  );
late _WxDropEventGetPosition _wxDropEventGetPosition;

typedef _WxDropEventSetResultNative = Void Function( Pointer, Int32  );
typedef _WxDropEventSetResult = void Function( Pointer, int  );
late _WxDropEventSetResult _wxDropEventSetResult;

typedef _WxDropEventGetResultNative = Int32 Function( Pointer  );
typedef _WxDropEventGetResult = int Function( Pointer  );
late _WxDropEventGetResult _wxDropEventGetResult;

class WxDropEvent extends WxNotifyEvent {
  WxDropEvent._defaultConstructor() : super._defaultConstructor();
  WxDropEvent( int eventType, int id ) : super._defaultConstructor() {
    nativeHandle = _wxDropEventConstructor( eventType, id );
    attachFinalizer();
  }
  WxDropEvent.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  void setPosition( WxPoint pos ) {
    _wxDropEventSetPosition( nativeHandle, pos.x, pos.y );
  }

  WxPoint getPosition( ) {
    final WxPointNative pointReturn = _wxDropEventGetPosition( nativeHandle  );
    return WxPoint(pointReturn.x, pointReturn.y);
  }

  void setResult( int pos ) {
    _wxDropEventSetResult( nativeHandle, pos );
  }

  int getResult( ) {
    return _wxDropEventGetResult( nativeHandle  );
  }
}

typedef _WxInstallDartDropEventCallbackNative = Void Function( Pointer );
typedef _WxInstallDartDropEventCallback = void Function( Pointer );
late _WxInstallDartDropEventCallback _wxInstallDartDropEventCallback;

typedef OnDropEventFunc = void Function( WxDropEvent event );
class WxDropEventListItems {
  WxDropEventListItems( this.func, this.eventType, this.eventId );
  final OnDropEventFunc func;
  final int eventType;
  final int eventId;
}
Map<Pointer, List<WxDropEventListItems>> wxDropEventHandlerList = {};

void wxDropEventCallback( Pointer handle, Pointer eventHandle ) {
    WxDropEvent event = WxDropEvent.fromHandle( eventHandle );

    final List<WxDropEventListItems>? list = wxDropEventHandlerList[handle];
    if (list == null) {
      wxLogError('Handle does not exist in wxDropEventHandlerList');
      return;
    } else {
      for (int i = list.length-1; i >= 0; i--) { // go backwards to allow overloading
        final items = list[i];
        if (items.eventType != event.getEventType()) continue;
        if ((items.eventId != -1) && (items.eventId != event.getId())) continue;
        event.skip( skip: false );
        items.func( event );
        if (!event.getSkipped()) return;
      }
    }
}

typedef WxDropEventCallbackNative = Void Function( Pointer, Pointer );
late NativeCallable<Void Function(Pointer<NativeType>, Pointer<NativeType>)> wxDropEventNativeCallable;

// ------------------------- EVT_MENU_OPEN ----------------------
///
/// [MenuOpen](/wxdart/wxGetMenuOpenEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindMenuOpenEvent( OnMenuEventFunc ) |
/// | void unbindMenuOpenEvent() |

typedef _WxGetMenuOpenEventTypeNative = Int32 Function();
typedef WxGetMenuOpenEventType = int Function();
late WxGetMenuOpenEventType wxGetMenuOpenEventType;

typedef _WxEvtHandlerBindMenuOpenEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerBindMenuOpenEventCallback = void Function( Pointer );
late WxEvtHandlerBindMenuOpenEventCallback wxEvtHandlerBindMenuOpenEventCallback;

typedef _WxEvtHandlerUnbindMenuOpenEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerUnbindMenuOpenEventCallback = void Function( Pointer );
late WxEvtHandlerUnbindMenuOpenEventCallback wxEvtHandlerUnbindMenuOpenEventCallback;

extension MenuOpenEventBinder on WxEvtHandler {
  void bindMenuOpenEvent( OnMenuEventFunc func ) {
    List<WxMenuEventListItems>? list = wxMenuEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxMenuEventHandlerList[nativeHandle] = list;
    }
    list.add( WxMenuEventListItems( func, wxGetMenuOpenEventType() ) );
    wxEvtHandlerBindMenuOpenEventCallback( nativeHandle );
  }

  void unbindMenuOpenEvent()
  {
    final list = wxMenuEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => items.eventType == wxGetMenuOpenEventType() ) );
    wxEvtHandlerUnbindMenuOpenEventCallback( nativeHandle );
  }
}

// ------------------------- EVT_MENU_CLOSE ----------------------
///
/// [MenuClose](/wxdart/wxGetMenuCloseEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindMenuCloseEvent( OnMenuEventFunc ) |
/// | void unbindMenuCloseEvent() |

typedef _WxGetMenuCloseEventTypeNative = Int32 Function();
typedef WxGetMenuCloseEventType = int Function();
late WxGetMenuCloseEventType wxGetMenuCloseEventType;

typedef _WxEvtHandlerBindMenuCloseEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerBindMenuCloseEventCallback = void Function( Pointer );
late WxEvtHandlerBindMenuCloseEventCallback wxEvtHandlerBindMenuCloseEventCallback;

typedef _WxEvtHandlerUnbindMenuCloseEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerUnbindMenuCloseEventCallback = void Function( Pointer );
late WxEvtHandlerUnbindMenuCloseEventCallback wxEvtHandlerUnbindMenuCloseEventCallback;

extension MenuCloseEventBinder on WxEvtHandler {
  void bindMenuCloseEvent( OnMenuEventFunc func ) {
    List<WxMenuEventListItems>? list = wxMenuEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxMenuEventHandlerList[nativeHandle] = list;
    }
    list.add( WxMenuEventListItems( func, wxGetMenuCloseEventType() ) );
    wxEvtHandlerBindMenuCloseEventCallback( nativeHandle );
  }

  void unbindMenuCloseEvent()
  {
    final list = wxMenuEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => items.eventType == wxGetMenuCloseEventType() ) );
    wxEvtHandlerUnbindMenuCloseEventCallback( nativeHandle );
  }
}

// ------------------------- EVT_MENU_HIGHLIGHT ----------------------
///
/// [MenuHighlight](/wxdart/wxGetMenuHighlightEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindMenuHighlightEvent( OnMenuEventFunc ) |
/// | void unbindMenuHighlightEvent() |

typedef _WxGetMenuHighlightEventTypeNative = Int32 Function();
typedef WxGetMenuHighlightEventType = int Function();
late WxGetMenuHighlightEventType wxGetMenuHighlightEventType;

typedef _WxEvtHandlerBindMenuHighlightEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerBindMenuHighlightEventCallback = void Function( Pointer );
late WxEvtHandlerBindMenuHighlightEventCallback wxEvtHandlerBindMenuHighlightEventCallback;

typedef _WxEvtHandlerUnbindMenuHighlightEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerUnbindMenuHighlightEventCallback = void Function( Pointer );
late WxEvtHandlerUnbindMenuHighlightEventCallback wxEvtHandlerUnbindMenuHighlightEventCallback;

extension MenuHighlightEventBinder on WxEvtHandler {
  void bindMenuHighlightEvent( OnMenuEventFunc func ) {
    List<WxMenuEventListItems>? list = wxMenuEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxMenuEventHandlerList[nativeHandle] = list;
    }
    list.add( WxMenuEventListItems( func, wxGetMenuHighlightEventType() ) );
    wxEvtHandlerBindMenuHighlightEventCallback( nativeHandle );
  }

  void unbindMenuHighlightEvent()
  {
    final list = wxMenuEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => items.eventType == wxGetMenuHighlightEventType() ) );
    wxEvtHandlerUnbindMenuHighlightEventCallback( nativeHandle );
  }
}

// ------------------------- EVT_MENU ----------------------
///
/// [Menu](/wxdart/wxGetMenuEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindMenuEvent( OnCommandEventFunc ) |
/// | void unbindMenuEvent() |

typedef _WxGetMenuEventTypeNative = Int32 Function();
typedef WxGetMenuEventType = int Function();
late WxGetMenuEventType wxGetMenuEventType;

typedef _WxEvtHandlerBindMenuEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindMenuEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindMenuEventCallback wxEvtHandlerBindMenuEventCallback;

typedef _WxEvtHandlerUnbindMenuEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindMenuEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindMenuEventCallback wxEvtHandlerUnbindMenuEventCallback;

extension MenuEventBinder on WxEvtHandler {
  void bindMenuEvent( OnCommandEventFunc func, int id ) {
    List<WxCommandEventListItems>? list = wxCommandEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxCommandEventHandlerList[nativeHandle] = list;
    }
    list.add( WxCommandEventListItems( func, wxGetMenuEventType(), id ) );
    wxEvtHandlerBindMenuEventCallback( nativeHandle, id );
  }

  void unbindMenuEvent( int id )
  {
    final list = wxCommandEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetMenuEventType() ) ) );
    wxEvtHandlerUnbindMenuEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_TOOL ----------------------
///
/// [Tool](/wxdart/wxGetToolEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindToolEvent( OnCommandEventFunc ) |
/// | void unbindToolEvent() |

typedef _WxGetToolEventTypeNative = Int32 Function();
typedef WxGetToolEventType = int Function();
late WxGetToolEventType wxGetToolEventType;

typedef _WxEvtHandlerBindToolEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindToolEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindToolEventCallback wxEvtHandlerBindToolEventCallback;

typedef _WxEvtHandlerUnbindToolEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindToolEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindToolEventCallback wxEvtHandlerUnbindToolEventCallback;

extension ToolEventBinder on WxEvtHandler {
  void bindToolEvent( OnCommandEventFunc func, int id ) {
    List<WxCommandEventListItems>? list = wxCommandEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxCommandEventHandlerList[nativeHandle] = list;
    }
    list.add( WxCommandEventListItems( func, wxGetToolEventType(), id ) );
    wxEvtHandlerBindToolEventCallback( nativeHandle, id );
  }

  void unbindToolEvent( int id )
  {
    final list = wxCommandEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetToolEventType() ) ) );
    wxEvtHandlerUnbindToolEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_TOOL_ENTER ----------------------
///
/// [ToolEnter](/wxdart/wxGetToolEnterEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindToolEnterEvent( OnCommandEventFunc ) |
/// | void unbindToolEnterEvent() |

typedef _WxGetToolEnterEventTypeNative = Int32 Function();
typedef WxGetToolEnterEventType = int Function();
late WxGetToolEnterEventType wxGetToolEnterEventType;

typedef _WxEvtHandlerBindToolEnterEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindToolEnterEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindToolEnterEventCallback wxEvtHandlerBindToolEnterEventCallback;

typedef _WxEvtHandlerUnbindToolEnterEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindToolEnterEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindToolEnterEventCallback wxEvtHandlerUnbindToolEnterEventCallback;

extension ToolEnterEventBinder on WxEvtHandler {
  void bindToolEnterEvent( OnCommandEventFunc func, int id ) {
    List<WxCommandEventListItems>? list = wxCommandEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxCommandEventHandlerList[nativeHandle] = list;
    }
    list.add( WxCommandEventListItems( func, wxGetToolEnterEventType(), id ) );
    wxEvtHandlerBindToolEnterEventCallback( nativeHandle, id );
  }

  void unbindToolEnterEvent( int id )
  {
    final list = wxCommandEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetToolEnterEventType() ) ) );
    wxEvtHandlerUnbindToolEnterEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_TOOL_DROPDOWN ----------------------
///
/// [ToolDropDown](/wxdart/wxGetToolDropDownEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindToolDropDownEvent( OnCommandEventFunc ) |
/// | void unbindToolDropDownEvent() |

typedef _WxGetToolDropDownEventTypeNative = Int32 Function();
typedef WxGetToolDropDownEventType = int Function();
late WxGetToolDropDownEventType wxGetToolDropDownEventType;

typedef _WxEvtHandlerBindToolDropDownEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindToolDropDownEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindToolDropDownEventCallback wxEvtHandlerBindToolDropDownEventCallback;

typedef _WxEvtHandlerUnbindToolDropDownEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindToolDropDownEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindToolDropDownEventCallback wxEvtHandlerUnbindToolDropDownEventCallback;

extension ToolDropDownEventBinder on WxEvtHandler {
  void bindToolDropDownEvent( OnCommandEventFunc func, int id ) {
    List<WxCommandEventListItems>? list = wxCommandEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxCommandEventHandlerList[nativeHandle] = list;
    }
    list.add( WxCommandEventListItems( func, wxGetToolDropDownEventType(), id ) );
    wxEvtHandlerBindToolDropDownEventCallback( nativeHandle, id );
  }

  void unbindToolDropDownEvent( int id )
  {
    final list = wxCommandEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetToolDropDownEventType() ) ) );
    wxEvtHandlerUnbindToolDropDownEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_SYS_COLOUR_CHANGED ----------------------
///
/// [SysColourChanged](/wxdart/wxGetSysColourChangedEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindSysColourChangedEvent( OnSysColourChangedEventFunc ) |
/// | void unbindSysColourChangedEvent() |

typedef _WxGetSysColourChangedEventTypeNative = Int32 Function();
typedef WxGetSysColourChangedEventType = int Function();
late WxGetSysColourChangedEventType wxGetSysColourChangedEventType;

typedef _WxEvtHandlerBindSysColourChangedEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerBindSysColourChangedEventCallback = void Function( Pointer );
late WxEvtHandlerBindSysColourChangedEventCallback wxEvtHandlerBindSysColourChangedEventCallback;

typedef _WxEvtHandlerUnbindSysColourChangedEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerUnbindSysColourChangedEventCallback = void Function( Pointer );
late WxEvtHandlerUnbindSysColourChangedEventCallback wxEvtHandlerUnbindSysColourChangedEventCallback;

extension SysColourChangedEventBinder on WxEvtHandler {
  void bindSysColourChangedEvent( OnSysColourChangedEventFunc func ) {
    List<WxSysColourChangedEventListItems>? list = wxSysColourChangedEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxSysColourChangedEventHandlerList[nativeHandle] = list;
    }
    list.add( WxSysColourChangedEventListItems( func, wxGetSysColourChangedEventType() ) );
    wxEvtHandlerBindSysColourChangedEventCallback( nativeHandle );
  }

  void unbindSysColourChangedEvent()
  {
    final list = wxSysColourChangedEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => items.eventType == wxGetSysColourChangedEventType() ) );
    wxEvtHandlerUnbindSysColourChangedEventCallback( nativeHandle );
  }
}

// ------------------------- EVT_DPI_CHANGED ----------------------
///
/// [DPIChanged](/wxdart/wxGetDPIChangedEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindDPIChangedEvent( OnDPIChangedEventFunc ) |
/// | void unbindDPIChangedEvent() |

typedef _WxGetDPIChangedEventTypeNative = Int32 Function();
typedef WxGetDPIChangedEventType = int Function();
late WxGetDPIChangedEventType wxGetDPIChangedEventType;

typedef _WxEvtHandlerBindDPIChangedEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerBindDPIChangedEventCallback = void Function( Pointer );
late WxEvtHandlerBindDPIChangedEventCallback wxEvtHandlerBindDPIChangedEventCallback;

typedef _WxEvtHandlerUnbindDPIChangedEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerUnbindDPIChangedEventCallback = void Function( Pointer );
late WxEvtHandlerUnbindDPIChangedEventCallback wxEvtHandlerUnbindDPIChangedEventCallback;

extension DPIChangedEventBinder on WxEvtHandler {
  void bindDPIChangedEvent( OnDPIChangedEventFunc func ) {
    List<WxDPIChangedEventListItems>? list = wxDPIChangedEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxDPIChangedEventHandlerList[nativeHandle] = list;
    }
    list.add( WxDPIChangedEventListItems( func, wxGetDPIChangedEventType() ) );
    wxEvtHandlerBindDPIChangedEventCallback( nativeHandle );
  }

  void unbindDPIChangedEvent()
  {
    final list = wxDPIChangedEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => items.eventType == wxGetDPIChangedEventType() ) );
    wxEvtHandlerUnbindDPIChangedEventCallback( nativeHandle );
  }
}

// ------------------------- EVT_IDLE ----------------------
///
/// [Idle](/wxdart/wxGetIdleEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindIdleEvent( OnIdleEventFunc ) |
/// | void unbindIdleEvent() |

typedef _WxGetIdleEventTypeNative = Int32 Function();
typedef WxGetIdleEventType = int Function();
late WxGetIdleEventType wxGetIdleEventType;

typedef _WxEvtHandlerBindIdleEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerBindIdleEventCallback = void Function( Pointer );
late WxEvtHandlerBindIdleEventCallback wxEvtHandlerBindIdleEventCallback;

typedef _WxEvtHandlerUnbindIdleEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerUnbindIdleEventCallback = void Function( Pointer );
late WxEvtHandlerUnbindIdleEventCallback wxEvtHandlerUnbindIdleEventCallback;

extension IdleEventBinder on WxEvtHandler {
  void bindIdleEvent( OnIdleEventFunc func )
  {
    wxIdleEventHandlerList[nativeHandle] = func;
    wxEvtHandlerBindIdleEventCallback( nativeHandle );
  }

  void unbindIdleEvent( OnIdleEventFunc func )
  {
    wxIdleEventHandlerList.remove(nativeHandle);
    wxEvtHandlerUnbindIdleEventCallback( nativeHandle );
  }
}

// ------------------------- EVT_TIMER ----------------------
///
/// [Timer](/wxdart/wxGetTimerEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindTimerEvent( OnTimerEventFunc ) |
/// | void unbindTimerEvent() |

typedef _WxGetTimerEventTypeNative = Int32 Function();
typedef WxGetTimerEventType = int Function();
late WxGetTimerEventType wxGetTimerEventType;

typedef _WxEvtHandlerBindTimerEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerBindTimerEventCallback = void Function( Pointer );
late WxEvtHandlerBindTimerEventCallback wxEvtHandlerBindTimerEventCallback;

typedef _WxEvtHandlerUnbindTimerEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerUnbindTimerEventCallback = void Function( Pointer );
late WxEvtHandlerUnbindTimerEventCallback wxEvtHandlerUnbindTimerEventCallback;

extension TimerEventBinder on WxEvtHandler {
  void bindTimerEvent( OnTimerEventFunc func )
  {
    wxTimerEventHandlerList[nativeHandle] = func;
    wxEvtHandlerBindTimerEventCallback( nativeHandle );
  }

  void unbindTimerEvent( OnTimerEventFunc func )
  {
    wxTimerEventHandlerList.remove(nativeHandle);
    wxEvtHandlerUnbindTimerEventCallback( nativeHandle );
  }
}

// ------------------------- EVT_VM_GET_MIN_SIZE ----------------------
///
/// [VMGetMinSize](/wxdart/wxGetVMGetMinSizeEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindVMGetMinSizeEvent( OnVMEventFunc ) |
/// | void unbindVMGetMinSizeEvent() |

typedef _WxGetVMGetMinSizeEventTypeNative = Int32 Function();
typedef WxGetVMGetMinSizeEventType = int Function();
late WxGetVMGetMinSizeEventType wxGetVMGetMinSizeEventType;

typedef _WxEvtHandlerBindVMGetMinSizeEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerBindVMGetMinSizeEventCallback = void Function( Pointer );
late WxEvtHandlerBindVMGetMinSizeEventCallback wxEvtHandlerBindVMGetMinSizeEventCallback;

typedef _WxEvtHandlerUnbindVMGetMinSizeEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerUnbindVMGetMinSizeEventCallback = void Function( Pointer );
late WxEvtHandlerUnbindVMGetMinSizeEventCallback wxEvtHandlerUnbindVMGetMinSizeEventCallback;

extension VMGetMinSizeEventBinder on WxEvtHandler {
  void bindVMGetMinSizeEvent( OnVMEventFunc func ) {
    List<WxVMEventListItems>? list = wxVMEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxVMEventHandlerList[nativeHandle] = list;
    }
    list.add( WxVMEventListItems( func, wxGetVMGetMinSizeEventType() ) );
    wxEvtHandlerBindVMGetMinSizeEventCallback( nativeHandle );
  }

  void unbindVMGetMinSizeEvent()
  {
    final list = wxVMEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => items.eventType == wxGetVMGetMinSizeEventType() ) );
    wxEvtHandlerUnbindVMGetMinSizeEventCallback( nativeHandle );
  }
}

// ------------------------- EVT_SET_FOCUS ----------------------
///
/// [SetFocus](/wxdart/wxGetSetFocusEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindSetFocusEvent( OnFocusEventFunc ) |
/// | void unbindSetFocusEvent() |

typedef _WxGetSetFocusEventTypeNative = Int32 Function();
typedef WxGetSetFocusEventType = int Function();
late WxGetSetFocusEventType wxGetSetFocusEventType;

typedef _WxEvtHandlerBindSetFocusEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerBindSetFocusEventCallback = void Function( Pointer );
late WxEvtHandlerBindSetFocusEventCallback wxEvtHandlerBindSetFocusEventCallback;

typedef _WxEvtHandlerUnbindSetFocusEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerUnbindSetFocusEventCallback = void Function( Pointer );
late WxEvtHandlerUnbindSetFocusEventCallback wxEvtHandlerUnbindSetFocusEventCallback;

extension SetFocusEventBinder on WxEvtHandler {
  void bindSetFocusEvent( OnFocusEventFunc func ) {
    List<WxFocusEventListItems>? list = wxFocusEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxFocusEventHandlerList[nativeHandle] = list;
    }
    list.add( WxFocusEventListItems( func, wxGetSetFocusEventType() ) );
    wxEvtHandlerBindSetFocusEventCallback( nativeHandle );
  }

  void unbindSetFocusEvent()
  {
    final list = wxFocusEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => items.eventType == wxGetSetFocusEventType() ) );
    wxEvtHandlerUnbindSetFocusEventCallback( nativeHandle );
  }
}

// ------------------------- EVT_KILL_FOCUS ----------------------
///
/// [KillFocus](/wxdart/wxGetKillFocusEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindKillFocusEvent( OnFocusEventFunc ) |
/// | void unbindKillFocusEvent() |

typedef _WxGetKillFocusEventTypeNative = Int32 Function();
typedef WxGetKillFocusEventType = int Function();
late WxGetKillFocusEventType wxGetKillFocusEventType;

typedef _WxEvtHandlerBindKillFocusEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerBindKillFocusEventCallback = void Function( Pointer );
late WxEvtHandlerBindKillFocusEventCallback wxEvtHandlerBindKillFocusEventCallback;

typedef _WxEvtHandlerUnbindKillFocusEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerUnbindKillFocusEventCallback = void Function( Pointer );
late WxEvtHandlerUnbindKillFocusEventCallback wxEvtHandlerUnbindKillFocusEventCallback;

extension KillFocusEventBinder on WxEvtHandler {
  void bindKillFocusEvent( OnFocusEventFunc func ) {
    List<WxFocusEventListItems>? list = wxFocusEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxFocusEventHandlerList[nativeHandle] = list;
    }
    list.add( WxFocusEventListItems( func, wxGetKillFocusEventType() ) );
    wxEvtHandlerBindKillFocusEventCallback( nativeHandle );
  }

  void unbindKillFocusEvent()
  {
    final list = wxFocusEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => items.eventType == wxGetKillFocusEventType() ) );
    wxEvtHandlerUnbindKillFocusEventCallback( nativeHandle );
  }
}

// ------------------------- EVT_SIZE ----------------------
///
/// [Size](/wxdart/wxGetSizeEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindSizeEvent( OnSizeEventFunc ) |
/// | void unbindSizeEvent() |

typedef _WxGetSizeEventTypeNative = Int32 Function();
typedef WxGetSizeEventType = int Function();
late WxGetSizeEventType wxGetSizeEventType;

typedef _WxEvtHandlerBindSizeEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerBindSizeEventCallback = void Function( Pointer );
late WxEvtHandlerBindSizeEventCallback wxEvtHandlerBindSizeEventCallback;

typedef _WxEvtHandlerUnbindSizeEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerUnbindSizeEventCallback = void Function( Pointer );
late WxEvtHandlerUnbindSizeEventCallback wxEvtHandlerUnbindSizeEventCallback;

extension SizeEventBinder on WxEvtHandler {
  void bindSizeEvent( OnSizeEventFunc func )
  {
    wxSizeEventHandlerList[nativeHandle] = func;
    wxEvtHandlerBindSizeEventCallback( nativeHandle );
  }

  void unbindSizeEvent( OnSizeEventFunc func )
  {
    wxSizeEventHandlerList.remove(nativeHandle);
    wxEvtHandlerUnbindSizeEventCallback( nativeHandle );
  }
}

// ------------------------- EVT_PAINT ----------------------
///
/// [Paint](/wxdart/wxGetPaintEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindPaintEvent( OnPaintEventFunc ) |
/// | void unbindPaintEvent() |

typedef _WxGetPaintEventTypeNative = Int32 Function();
typedef WxGetPaintEventType = int Function();
late WxGetPaintEventType wxGetPaintEventType;

typedef _WxEvtHandlerBindPaintEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerBindPaintEventCallback = void Function( Pointer );
late WxEvtHandlerBindPaintEventCallback wxEvtHandlerBindPaintEventCallback;

typedef _WxEvtHandlerUnbindPaintEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerUnbindPaintEventCallback = void Function( Pointer );
late WxEvtHandlerUnbindPaintEventCallback wxEvtHandlerUnbindPaintEventCallback;

extension PaintEventBinder on WxWindow {
  void bindPaintEvent( OnPaintEventFunc func )
  {
    wxPaintEventHandlerList[nativeHandle] = func;
    wxEvtHandlerBindPaintEventCallback( nativeHandle );
    if (getBackgroundStyle() != wxBG_STYLE_TRANSPARENT)
       { setBackgroundStyle( wxBG_STYLE_PAINT ); }
  }

  void unbindPaintEvent( OnPaintEventFunc func )
  {
    wxPaintEventHandlerList.remove(nativeHandle);
    wxEvtHandlerUnbindPaintEventCallback( nativeHandle );
  }
}

// ------------------------- EVT_MOVE ----------------------
///
/// [Move](/wxdart/wxGetMoveEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindMoveEvent( OnMoveEventFunc ) |
/// | void unbindMoveEvent() |

typedef _WxGetMoveEventTypeNative = Int32 Function();
typedef WxGetMoveEventType = int Function();
late WxGetMoveEventType wxGetMoveEventType;

typedef _WxEvtHandlerBindMoveEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerBindMoveEventCallback = void Function( Pointer );
late WxEvtHandlerBindMoveEventCallback wxEvtHandlerBindMoveEventCallback;

typedef _WxEvtHandlerUnbindMoveEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerUnbindMoveEventCallback = void Function( Pointer );
late WxEvtHandlerUnbindMoveEventCallback wxEvtHandlerUnbindMoveEventCallback;

extension MoveEventBinder on WxEvtHandler {
  void bindMoveEvent( OnMoveEventFunc func ) {
    List<WxMoveEventListItems>? list = wxMoveEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxMoveEventHandlerList[nativeHandle] = list;
    }
    list.add( WxMoveEventListItems( func, wxGetMoveEventType() ) );
    wxEvtHandlerBindMoveEventCallback( nativeHandle );
  }

  void unbindMoveEvent()
  {
    final list = wxMoveEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => items.eventType == wxGetMoveEventType() ) );
    wxEvtHandlerUnbindMoveEventCallback( nativeHandle );
  }
}

// ------------------------- EVT_MOVE_START ----------------------
///
/// [MoveStart](/wxdart/wxGetMoveStartEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindMoveStartEvent( OnMoveEventFunc ) |
/// | void unbindMoveStartEvent() |

typedef _WxGetMoveStartEventTypeNative = Int32 Function();
typedef WxGetMoveStartEventType = int Function();
late WxGetMoveStartEventType wxGetMoveStartEventType;

typedef _WxEvtHandlerBindMoveStartEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerBindMoveStartEventCallback = void Function( Pointer );
late WxEvtHandlerBindMoveStartEventCallback wxEvtHandlerBindMoveStartEventCallback;

typedef _WxEvtHandlerUnbindMoveStartEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerUnbindMoveStartEventCallback = void Function( Pointer );
late WxEvtHandlerUnbindMoveStartEventCallback wxEvtHandlerUnbindMoveStartEventCallback;

extension MoveStartEventBinder on WxEvtHandler {
  void bindMoveStartEvent( OnMoveEventFunc func ) {
    List<WxMoveEventListItems>? list = wxMoveEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxMoveEventHandlerList[nativeHandle] = list;
    }
    list.add( WxMoveEventListItems( func, wxGetMoveStartEventType() ) );
    wxEvtHandlerBindMoveStartEventCallback( nativeHandle );
  }

  void unbindMoveStartEvent()
  {
    final list = wxMoveEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => items.eventType == wxGetMoveStartEventType() ) );
    wxEvtHandlerUnbindMoveStartEventCallback( nativeHandle );
  }
}

// ------------------------- EVT_MOVE_END ----------------------
///
/// [MoveEnd](/wxdart/wxGetMoveEndEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindMoveEndEvent( OnMoveEventFunc ) |
/// | void unbindMoveEndEvent() |

typedef _WxGetMoveEndEventTypeNative = Int32 Function();
typedef WxGetMoveEndEventType = int Function();
late WxGetMoveEndEventType wxGetMoveEndEventType;

typedef _WxEvtHandlerBindMoveEndEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerBindMoveEndEventCallback = void Function( Pointer );
late WxEvtHandlerBindMoveEndEventCallback wxEvtHandlerBindMoveEndEventCallback;

typedef _WxEvtHandlerUnbindMoveEndEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerUnbindMoveEndEventCallback = void Function( Pointer );
late WxEvtHandlerUnbindMoveEndEventCallback wxEvtHandlerUnbindMoveEndEventCallback;

extension MoveEndEventBinder on WxEvtHandler {
  void bindMoveEndEvent( OnMoveEventFunc func ) {
    List<WxMoveEventListItems>? list = wxMoveEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxMoveEventHandlerList[nativeHandle] = list;
    }
    list.add( WxMoveEventListItems( func, wxGetMoveEndEventType() ) );
    wxEvtHandlerBindMoveEndEventCallback( nativeHandle );
  }

  void unbindMoveEndEvent()
  {
    final list = wxMoveEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => items.eventType == wxGetMoveEndEventType() ) );
    wxEvtHandlerUnbindMoveEndEventCallback( nativeHandle );
  }
}

// ------------------------- EVT_CLOSE_WINDOW ----------------------
///
/// [CloseWindow](/wxdart/wxGetCloseWindowEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindCloseWindowEvent( OnCloseEventFunc ) |
/// | void unbindCloseWindowEvent() |

typedef _WxGetCloseWindowEventTypeNative = Int32 Function();
typedef WxGetCloseWindowEventType = int Function();
late WxGetCloseWindowEventType wxGetCloseWindowEventType;

typedef _WxEvtHandlerBindCloseWindowEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerBindCloseWindowEventCallback = void Function( Pointer );
late WxEvtHandlerBindCloseWindowEventCallback wxEvtHandlerBindCloseWindowEventCallback;

typedef _WxEvtHandlerUnbindCloseWindowEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerUnbindCloseWindowEventCallback = void Function( Pointer );
late WxEvtHandlerUnbindCloseWindowEventCallback wxEvtHandlerUnbindCloseWindowEventCallback;

extension CloseWindowEventBinder on WxEvtHandler {
  void bindCloseWindowEvent( OnCloseEventFunc func ) {
    List<WxCloseEventListItems>? list = wxCloseEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxCloseEventHandlerList[nativeHandle] = list;
    }
    list.add( WxCloseEventListItems( func, wxGetCloseWindowEventType() ) );
    wxEvtHandlerBindCloseWindowEventCallback( nativeHandle );
  }

  void unbindCloseWindowEvent()
  {
    final list = wxCloseEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => items.eventType == wxGetCloseWindowEventType() ) );
    wxEvtHandlerUnbindCloseWindowEventCallback( nativeHandle );
  }
}

// ------------------------- EVT_QUERY_END_SESSION ----------------------
///
/// [QueryEndSession](/wxdart/wxGetQueryEndSessionEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindQueryEndSessionEvent( OnCloseEventFunc ) |
/// | void unbindQueryEndSessionEvent() |

typedef _WxGetQueryEndSessionEventTypeNative = Int32 Function();
typedef WxGetQueryEndSessionEventType = int Function();
late WxGetQueryEndSessionEventType wxGetQueryEndSessionEventType;

typedef _WxEvtHandlerBindQueryEndSessionEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerBindQueryEndSessionEventCallback = void Function( Pointer );
late WxEvtHandlerBindQueryEndSessionEventCallback wxEvtHandlerBindQueryEndSessionEventCallback;

typedef _WxEvtHandlerUnbindQueryEndSessionEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerUnbindQueryEndSessionEventCallback = void Function( Pointer );
late WxEvtHandlerUnbindQueryEndSessionEventCallback wxEvtHandlerUnbindQueryEndSessionEventCallback;

extension QueryEndSessionEventBinder on WxEvtHandler {
  void bindQueryEndSessionEvent( OnCloseEventFunc func ) {
    List<WxCloseEventListItems>? list = wxCloseEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxCloseEventHandlerList[nativeHandle] = list;
    }
    list.add( WxCloseEventListItems( func, wxGetQueryEndSessionEventType() ) );
    wxEvtHandlerBindQueryEndSessionEventCallback( nativeHandle );
  }

  void unbindQueryEndSessionEvent()
  {
    final list = wxCloseEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => items.eventType == wxGetQueryEndSessionEventType() ) );
    wxEvtHandlerUnbindQueryEndSessionEventCallback( nativeHandle );
  }
}

// ------------------------- EVT_END_SESSION ----------------------
///
/// [EndSession](/wxdart/wxGetEndSessionEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindEndSessionEvent( OnCloseEventFunc ) |
/// | void unbindEndSessionEvent() |

typedef _WxGetEndSessionEventTypeNative = Int32 Function();
typedef WxGetEndSessionEventType = int Function();
late WxGetEndSessionEventType wxGetEndSessionEventType;

typedef _WxEvtHandlerBindEndSessionEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerBindEndSessionEventCallback = void Function( Pointer );
late WxEvtHandlerBindEndSessionEventCallback wxEvtHandlerBindEndSessionEventCallback;

typedef _WxEvtHandlerUnbindEndSessionEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerUnbindEndSessionEventCallback = void Function( Pointer );
late WxEvtHandlerUnbindEndSessionEventCallback wxEvtHandlerUnbindEndSessionEventCallback;

extension EndSessionEventBinder on WxEvtHandler {
  void bindEndSessionEvent( OnCloseEventFunc func ) {
    List<WxCloseEventListItems>? list = wxCloseEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxCloseEventHandlerList[nativeHandle] = list;
    }
    list.add( WxCloseEventListItems( func, wxGetEndSessionEventType() ) );
    wxEvtHandlerBindEndSessionEventCallback( nativeHandle );
  }

  void unbindEndSessionEvent()
  {
    final list = wxCloseEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => items.eventType == wxGetEndSessionEventType() ) );
    wxEvtHandlerUnbindEndSessionEventCallback( nativeHandle );
  }
}

// ------------------------- EVT_SHOW ----------------------
///
/// [Show](/wxdart/wxGetShowEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindShowEvent( OnShowEventFunc ) |
/// | void unbindShowEvent() |

typedef _WxGetShowEventTypeNative = Int32 Function();
typedef WxGetShowEventType = int Function();
late WxGetShowEventType wxGetShowEventType;

typedef _WxEvtHandlerBindShowEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerBindShowEventCallback = void Function( Pointer );
late WxEvtHandlerBindShowEventCallback wxEvtHandlerBindShowEventCallback;

typedef _WxEvtHandlerUnbindShowEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerUnbindShowEventCallback = void Function( Pointer );
late WxEvtHandlerUnbindShowEventCallback wxEvtHandlerUnbindShowEventCallback;

extension ShowEventBinder on WxEvtHandler {
  void bindShowEvent( OnShowEventFunc func )
  {
    wxShowEventHandlerList[nativeHandle] = func;
    wxEvtHandlerBindShowEventCallback( nativeHandle );
  }

  void unbindShowEvent( OnShowEventFunc func )
  {
    wxShowEventHandlerList.remove(nativeHandle);
    wxEvtHandlerUnbindShowEventCallback( nativeHandle );
  }
}

// ------------------------- EVT_CREATE ----------------------
///
/// [WindowCreate](/wxdart/wxGetWindowCreateEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindWindowCreateEvent( OnWindowCreateEventFunc ) |
/// | void unbindWindowCreateEvent() |

typedef _WxGetWindowCreateEventTypeNative = Int32 Function();
typedef WxGetWindowCreateEventType = int Function();
late WxGetWindowCreateEventType wxGetWindowCreateEventType;

typedef _WxEvtHandlerBindWindowCreateEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindWindowCreateEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindWindowCreateEventCallback wxEvtHandlerBindWindowCreateEventCallback;

typedef _WxEvtHandlerUnbindWindowCreateEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindWindowCreateEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindWindowCreateEventCallback wxEvtHandlerUnbindWindowCreateEventCallback;

extension WindowCreateEventBinder on WxEvtHandler {
  void bindWindowCreateEvent( OnWindowCreateEventFunc func, int id ) {
    List<WxWindowCreateEventListItems>? list = wxWindowCreateEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxWindowCreateEventHandlerList[nativeHandle] = list;
    }
    list.add( WxWindowCreateEventListItems( func, wxGetWindowCreateEventType(), id ) );
    wxEvtHandlerBindWindowCreateEventCallback( nativeHandle, id );
  }

  void unbindWindowCreateEvent( int id )
  {
    final list = wxWindowCreateEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetWindowCreateEventType() ) ) );
    wxEvtHandlerUnbindWindowCreateEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_ACTIVATE_APP ----------------------
///
/// [ActivateApp](/wxdart/wxGetActivateAppEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindActivateAppEvent( OnActivateEventFunc ) |
/// | void unbindActivateAppEvent() |

typedef _WxGetActivateAppEventTypeNative = Int32 Function();
typedef WxGetActivateAppEventType = int Function();
late WxGetActivateAppEventType wxGetActivateAppEventType;

typedef _WxEvtHandlerBindActivateAppEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerBindActivateAppEventCallback = void Function( Pointer );
late WxEvtHandlerBindActivateAppEventCallback wxEvtHandlerBindActivateAppEventCallback;

typedef _WxEvtHandlerUnbindActivateAppEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerUnbindActivateAppEventCallback = void Function( Pointer );
late WxEvtHandlerUnbindActivateAppEventCallback wxEvtHandlerUnbindActivateAppEventCallback;

extension ActivateAppEventBinder on WxEvtHandler {
  void bindActivateAppEvent( OnActivateEventFunc func ) {
    List<WxActivateEventListItems>? list = wxActivateEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxActivateEventHandlerList[nativeHandle] = list;
    }
    list.add( WxActivateEventListItems( func, wxGetActivateAppEventType() ) );
    wxEvtHandlerBindActivateAppEventCallback( nativeHandle );
  }

  void unbindActivateAppEvent()
  {
    final list = wxActivateEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => items.eventType == wxGetActivateAppEventType() ) );
    wxEvtHandlerUnbindActivateAppEventCallback( nativeHandle );
  }
}

// ------------------------- EVT_ACTIVATE ----------------------
///
/// [Activate](/wxdart/wxGetActivateEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindActivateEvent( OnActivateEventFunc ) |
/// | void unbindActivateEvent() |

typedef _WxGetActivateEventTypeNative = Int32 Function();
typedef WxGetActivateEventType = int Function();
late WxGetActivateEventType wxGetActivateEventType;

typedef _WxEvtHandlerBindActivateEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerBindActivateEventCallback = void Function( Pointer );
late WxEvtHandlerBindActivateEventCallback wxEvtHandlerBindActivateEventCallback;

typedef _WxEvtHandlerUnbindActivateEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerUnbindActivateEventCallback = void Function( Pointer );
late WxEvtHandlerUnbindActivateEventCallback wxEvtHandlerUnbindActivateEventCallback;

extension ActivateEventBinder on WxEvtHandler {
  void bindActivateEvent( OnActivateEventFunc func ) {
    List<WxActivateEventListItems>? list = wxActivateEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxActivateEventHandlerList[nativeHandle] = list;
    }
    list.add( WxActivateEventListItems( func, wxGetActivateEventType() ) );
    wxEvtHandlerBindActivateEventCallback( nativeHandle );
  }

  void unbindActivateEvent()
  {
    final list = wxActivateEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => items.eventType == wxGetActivateEventType() ) );
    wxEvtHandlerUnbindActivateEventCallback( nativeHandle );
  }
}

// ------------------------- EVT_HIBERNATE ----------------------
///
/// [Hibernate](/wxdart/wxGetHibernateEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindHibernateEvent( OnActivateEventFunc ) |
/// | void unbindHibernateEvent() |

typedef _WxGetHibernateEventTypeNative = Int32 Function();
typedef WxGetHibernateEventType = int Function();
late WxGetHibernateEventType wxGetHibernateEventType;

typedef _WxEvtHandlerBindHibernateEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerBindHibernateEventCallback = void Function( Pointer );
late WxEvtHandlerBindHibernateEventCallback wxEvtHandlerBindHibernateEventCallback;

typedef _WxEvtHandlerUnbindHibernateEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerUnbindHibernateEventCallback = void Function( Pointer );
late WxEvtHandlerUnbindHibernateEventCallback wxEvtHandlerUnbindHibernateEventCallback;

extension HibernateEventBinder on WxEvtHandler {
  void bindHibernateEvent( OnActivateEventFunc func ) {
    List<WxActivateEventListItems>? list = wxActivateEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxActivateEventHandlerList[nativeHandle] = list;
    }
    list.add( WxActivateEventListItems( func, wxGetHibernateEventType() ) );
    wxEvtHandlerBindHibernateEventCallback( nativeHandle );
  }

  void unbindHibernateEvent()
  {
    final list = wxActivateEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => items.eventType == wxGetHibernateEventType() ) );
    wxEvtHandlerUnbindHibernateEventCallback( nativeHandle );
  }
}

// ------------------------- EVT_LEFT_DOWN ----------------------
///
/// [LeftDown](/wxdart/wxGetLeftDownEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindLeftDownEvent( OnMouseEventFunc ) |
/// | void unbindLeftDownEvent() |

typedef _WxGetLeftDownEventTypeNative = Int32 Function();
typedef WxGetLeftDownEventType = int Function();
late WxGetLeftDownEventType wxGetLeftDownEventType;

typedef _WxEvtHandlerBindLeftDownEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerBindLeftDownEventCallback = void Function( Pointer );
late WxEvtHandlerBindLeftDownEventCallback wxEvtHandlerBindLeftDownEventCallback;

typedef _WxEvtHandlerUnbindLeftDownEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerUnbindLeftDownEventCallback = void Function( Pointer );
late WxEvtHandlerUnbindLeftDownEventCallback wxEvtHandlerUnbindLeftDownEventCallback;

extension LeftDownEventBinder on WxEvtHandler {
  void bindLeftDownEvent( OnMouseEventFunc func ) {
    List<WxMouseEventListItems>? list = wxMouseEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxMouseEventHandlerList[nativeHandle] = list;
    }
    list.add( WxMouseEventListItems( func, wxGetLeftDownEventType() ) );
    wxEvtHandlerBindLeftDownEventCallback( nativeHandle );
  }

  void unbindLeftDownEvent()
  {
    final list = wxMouseEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => items.eventType == wxGetLeftDownEventType() ) );
    wxEvtHandlerUnbindLeftDownEventCallback( nativeHandle );
  }
}

// ------------------------- EVT_RIGHT_DOWN ----------------------
///
/// [RightDown](/wxdart/wxGetRightDownEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindRightDownEvent( OnMouseEventFunc ) |
/// | void unbindRightDownEvent() |

typedef _WxGetRightDownEventTypeNative = Int32 Function();
typedef WxGetRightDownEventType = int Function();
late WxGetRightDownEventType wxGetRightDownEventType;

typedef _WxEvtHandlerBindRightDownEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerBindRightDownEventCallback = void Function( Pointer );
late WxEvtHandlerBindRightDownEventCallback wxEvtHandlerBindRightDownEventCallback;

typedef _WxEvtHandlerUnbindRightDownEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerUnbindRightDownEventCallback = void Function( Pointer );
late WxEvtHandlerUnbindRightDownEventCallback wxEvtHandlerUnbindRightDownEventCallback;

extension RightDownEventBinder on WxEvtHandler {
  void bindRightDownEvent( OnMouseEventFunc func ) {
    List<WxMouseEventListItems>? list = wxMouseEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxMouseEventHandlerList[nativeHandle] = list;
    }
    list.add( WxMouseEventListItems( func, wxGetRightDownEventType() ) );
    wxEvtHandlerBindRightDownEventCallback( nativeHandle );
  }

  void unbindRightDownEvent()
  {
    final list = wxMouseEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => items.eventType == wxGetRightDownEventType() ) );
    wxEvtHandlerUnbindRightDownEventCallback( nativeHandle );
  }
}

// ------------------------- EVT_MIDDLE_DOWN ----------------------
///
/// [MiddleDown](/wxdart/wxGetMiddleDownEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindMiddleDownEvent( OnMouseEventFunc ) |
/// | void unbindMiddleDownEvent() |

typedef _WxGetMiddleDownEventTypeNative = Int32 Function();
typedef WxGetMiddleDownEventType = int Function();
late WxGetMiddleDownEventType wxGetMiddleDownEventType;

typedef _WxEvtHandlerBindMiddleDownEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerBindMiddleDownEventCallback = void Function( Pointer );
late WxEvtHandlerBindMiddleDownEventCallback wxEvtHandlerBindMiddleDownEventCallback;

typedef _WxEvtHandlerUnbindMiddleDownEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerUnbindMiddleDownEventCallback = void Function( Pointer );
late WxEvtHandlerUnbindMiddleDownEventCallback wxEvtHandlerUnbindMiddleDownEventCallback;

extension MiddleDownEventBinder on WxEvtHandler {
  void bindMiddleDownEvent( OnMouseEventFunc func ) {
    List<WxMouseEventListItems>? list = wxMouseEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxMouseEventHandlerList[nativeHandle] = list;
    }
    list.add( WxMouseEventListItems( func, wxGetMiddleDownEventType() ) );
    wxEvtHandlerBindMiddleDownEventCallback( nativeHandle );
  }

  void unbindMiddleDownEvent()
  {
    final list = wxMouseEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => items.eventType == wxGetMiddleDownEventType() ) );
    wxEvtHandlerUnbindMiddleDownEventCallback( nativeHandle );
  }
}

// ------------------------- EVT_LEFT_DCLICK ----------------------
///
/// [LeftDClick](/wxdart/wxGetLeftDClickEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindLeftDClickEvent( OnMouseEventFunc ) |
/// | void unbindLeftDClickEvent() |

typedef _WxGetLeftDClickEventTypeNative = Int32 Function();
typedef WxGetLeftDClickEventType = int Function();
late WxGetLeftDClickEventType wxGetLeftDClickEventType;

typedef _WxEvtHandlerBindLeftDClickEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerBindLeftDClickEventCallback = void Function( Pointer );
late WxEvtHandlerBindLeftDClickEventCallback wxEvtHandlerBindLeftDClickEventCallback;

typedef _WxEvtHandlerUnbindLeftDClickEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerUnbindLeftDClickEventCallback = void Function( Pointer );
late WxEvtHandlerUnbindLeftDClickEventCallback wxEvtHandlerUnbindLeftDClickEventCallback;

extension LeftDClickEventBinder on WxEvtHandler {
  void bindLeftDClickEvent( OnMouseEventFunc func ) {
    List<WxMouseEventListItems>? list = wxMouseEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxMouseEventHandlerList[nativeHandle] = list;
    }
    list.add( WxMouseEventListItems( func, wxGetLeftDClickEventType() ) );
    wxEvtHandlerBindLeftDClickEventCallback( nativeHandle );
  }

  void unbindLeftDClickEvent()
  {
    final list = wxMouseEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => items.eventType == wxGetLeftDClickEventType() ) );
    wxEvtHandlerUnbindLeftDClickEventCallback( nativeHandle );
  }
}

// ------------------------- EVT_RIGHT_DCLICK ----------------------
///
/// [RightDClick](/wxdart/wxGetRightDClickEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindRightDClickEvent( OnMouseEventFunc ) |
/// | void unbindRightDClickEvent() |

typedef _WxGetRightDClickEventTypeNative = Int32 Function();
typedef WxGetRightDClickEventType = int Function();
late WxGetRightDClickEventType wxGetRightDClickEventType;

typedef _WxEvtHandlerBindRightDClickEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerBindRightDClickEventCallback = void Function( Pointer );
late WxEvtHandlerBindRightDClickEventCallback wxEvtHandlerBindRightDClickEventCallback;

typedef _WxEvtHandlerUnbindRightDClickEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerUnbindRightDClickEventCallback = void Function( Pointer );
late WxEvtHandlerUnbindRightDClickEventCallback wxEvtHandlerUnbindRightDClickEventCallback;

extension RightDClickEventBinder on WxEvtHandler {
  void bindRightDClickEvent( OnMouseEventFunc func ) {
    List<WxMouseEventListItems>? list = wxMouseEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxMouseEventHandlerList[nativeHandle] = list;
    }
    list.add( WxMouseEventListItems( func, wxGetRightDClickEventType() ) );
    wxEvtHandlerBindRightDClickEventCallback( nativeHandle );
  }

  void unbindRightDClickEvent()
  {
    final list = wxMouseEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => items.eventType == wxGetRightDClickEventType() ) );
    wxEvtHandlerUnbindRightDClickEventCallback( nativeHandle );
  }
}

// ------------------------- EVT_MIDDLE_DCLICK ----------------------
///
/// [MiddleDClick](/wxdart/wxGetMiddleDClickEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindMiddleDClickEvent( OnMouseEventFunc ) |
/// | void unbindMiddleDClickEvent() |

typedef _WxGetMiddleDClickEventTypeNative = Int32 Function();
typedef WxGetMiddleDClickEventType = int Function();
late WxGetMiddleDClickEventType wxGetMiddleDClickEventType;

typedef _WxEvtHandlerBindMiddleDClickEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerBindMiddleDClickEventCallback = void Function( Pointer );
late WxEvtHandlerBindMiddleDClickEventCallback wxEvtHandlerBindMiddleDClickEventCallback;

typedef _WxEvtHandlerUnbindMiddleDClickEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerUnbindMiddleDClickEventCallback = void Function( Pointer );
late WxEvtHandlerUnbindMiddleDClickEventCallback wxEvtHandlerUnbindMiddleDClickEventCallback;

extension MiddleDClickEventBinder on WxEvtHandler {
  void bindMiddleDClickEvent( OnMouseEventFunc func ) {
    List<WxMouseEventListItems>? list = wxMouseEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxMouseEventHandlerList[nativeHandle] = list;
    }
    list.add( WxMouseEventListItems( func, wxGetMiddleDClickEventType() ) );
    wxEvtHandlerBindMiddleDClickEventCallback( nativeHandle );
  }

  void unbindMiddleDClickEvent()
  {
    final list = wxMouseEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => items.eventType == wxGetMiddleDClickEventType() ) );
    wxEvtHandlerUnbindMiddleDClickEventCallback( nativeHandle );
  }
}

// ------------------------- EVT_LEFT_UP ----------------------
///
/// [LeftUp](/wxdart/wxGetLeftUpEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindLeftUpEvent( OnMouseEventFunc ) |
/// | void unbindLeftUpEvent() |

typedef _WxGetLeftUpEventTypeNative = Int32 Function();
typedef WxGetLeftUpEventType = int Function();
late WxGetLeftUpEventType wxGetLeftUpEventType;

typedef _WxEvtHandlerBindLeftUpEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerBindLeftUpEventCallback = void Function( Pointer );
late WxEvtHandlerBindLeftUpEventCallback wxEvtHandlerBindLeftUpEventCallback;

typedef _WxEvtHandlerUnbindLeftUpEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerUnbindLeftUpEventCallback = void Function( Pointer );
late WxEvtHandlerUnbindLeftUpEventCallback wxEvtHandlerUnbindLeftUpEventCallback;

extension LeftUpEventBinder on WxEvtHandler {
  void bindLeftUpEvent( OnMouseEventFunc func ) {
    List<WxMouseEventListItems>? list = wxMouseEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxMouseEventHandlerList[nativeHandle] = list;
    }
    list.add( WxMouseEventListItems( func, wxGetLeftUpEventType() ) );
    wxEvtHandlerBindLeftUpEventCallback( nativeHandle );
  }

  void unbindLeftUpEvent()
  {
    final list = wxMouseEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => items.eventType == wxGetLeftUpEventType() ) );
    wxEvtHandlerUnbindLeftUpEventCallback( nativeHandle );
  }
}

// ------------------------- EVT_RIGHT_UP ----------------------
///
/// [RightUp](/wxdart/wxGetRightUpEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindRightUpEvent( OnMouseEventFunc ) |
/// | void unbindRightUpEvent() |

typedef _WxGetRightUpEventTypeNative = Int32 Function();
typedef WxGetRightUpEventType = int Function();
late WxGetRightUpEventType wxGetRightUpEventType;

typedef _WxEvtHandlerBindRightUpEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerBindRightUpEventCallback = void Function( Pointer );
late WxEvtHandlerBindRightUpEventCallback wxEvtHandlerBindRightUpEventCallback;

typedef _WxEvtHandlerUnbindRightUpEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerUnbindRightUpEventCallback = void Function( Pointer );
late WxEvtHandlerUnbindRightUpEventCallback wxEvtHandlerUnbindRightUpEventCallback;

extension RightUpEventBinder on WxEvtHandler {
  void bindRightUpEvent( OnMouseEventFunc func ) {
    List<WxMouseEventListItems>? list = wxMouseEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxMouseEventHandlerList[nativeHandle] = list;
    }
    list.add( WxMouseEventListItems( func, wxGetRightUpEventType() ) );
    wxEvtHandlerBindRightUpEventCallback( nativeHandle );
  }

  void unbindRightUpEvent()
  {
    final list = wxMouseEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => items.eventType == wxGetRightUpEventType() ) );
    wxEvtHandlerUnbindRightUpEventCallback( nativeHandle );
  }
}

// ------------------------- EVT_MIDDLE_UP ----------------------
///
/// [MiddleUp](/wxdart/wxGetMiddleUpEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindMiddleUpEvent( OnMouseEventFunc ) |
/// | void unbindMiddleUpEvent() |

typedef _WxGetMiddleUpEventTypeNative = Int32 Function();
typedef WxGetMiddleUpEventType = int Function();
late WxGetMiddleUpEventType wxGetMiddleUpEventType;

typedef _WxEvtHandlerBindMiddleUpEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerBindMiddleUpEventCallback = void Function( Pointer );
late WxEvtHandlerBindMiddleUpEventCallback wxEvtHandlerBindMiddleUpEventCallback;

typedef _WxEvtHandlerUnbindMiddleUpEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerUnbindMiddleUpEventCallback = void Function( Pointer );
late WxEvtHandlerUnbindMiddleUpEventCallback wxEvtHandlerUnbindMiddleUpEventCallback;

extension MiddleUpEventBinder on WxEvtHandler {
  void bindMiddleUpEvent( OnMouseEventFunc func ) {
    List<WxMouseEventListItems>? list = wxMouseEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxMouseEventHandlerList[nativeHandle] = list;
    }
    list.add( WxMouseEventListItems( func, wxGetMiddleUpEventType() ) );
    wxEvtHandlerBindMiddleUpEventCallback( nativeHandle );
  }

  void unbindMiddleUpEvent()
  {
    final list = wxMouseEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => items.eventType == wxGetMiddleUpEventType() ) );
    wxEvtHandlerUnbindMiddleUpEventCallback( nativeHandle );
  }
}

// ------------------------- EVT_MOTION ----------------------
///
/// [Motion](/wxdart/wxGetMotionEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindMotionEvent( OnMouseEventFunc ) |
/// | void unbindMotionEvent() |

typedef _WxGetMotionEventTypeNative = Int32 Function();
typedef WxGetMotionEventType = int Function();
late WxGetMotionEventType wxGetMotionEventType;

typedef _WxEvtHandlerBindMotionEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerBindMotionEventCallback = void Function( Pointer );
late WxEvtHandlerBindMotionEventCallback wxEvtHandlerBindMotionEventCallback;

typedef _WxEvtHandlerUnbindMotionEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerUnbindMotionEventCallback = void Function( Pointer );
late WxEvtHandlerUnbindMotionEventCallback wxEvtHandlerUnbindMotionEventCallback;

extension MotionEventBinder on WxEvtHandler {
  void bindMotionEvent( OnMouseEventFunc func ) {
    List<WxMouseEventListItems>? list = wxMouseEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxMouseEventHandlerList[nativeHandle] = list;
    }
    list.add( WxMouseEventListItems( func, wxGetMotionEventType() ) );
    wxEvtHandlerBindMotionEventCallback( nativeHandle );
  }

  void unbindMotionEvent()
  {
    final list = wxMouseEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => items.eventType == wxGetMotionEventType() ) );
    wxEvtHandlerUnbindMotionEventCallback( nativeHandle );
  }
}

// ------------------------- EVT_ENTER_WINDOW ----------------------
///
/// [EnterWindow](/wxdart/wxGetEnterWindowEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindEnterWindowEvent( OnMouseEventFunc ) |
/// | void unbindEnterWindowEvent() |

typedef _WxGetEnterWindowEventTypeNative = Int32 Function();
typedef WxGetEnterWindowEventType = int Function();
late WxGetEnterWindowEventType wxGetEnterWindowEventType;

typedef _WxEvtHandlerBindEnterWindowEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerBindEnterWindowEventCallback = void Function( Pointer );
late WxEvtHandlerBindEnterWindowEventCallback wxEvtHandlerBindEnterWindowEventCallback;

typedef _WxEvtHandlerUnbindEnterWindowEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerUnbindEnterWindowEventCallback = void Function( Pointer );
late WxEvtHandlerUnbindEnterWindowEventCallback wxEvtHandlerUnbindEnterWindowEventCallback;

extension EnterWindowEventBinder on WxEvtHandler {
  void bindEnterWindowEvent( OnMouseEventFunc func ) {
    List<WxMouseEventListItems>? list = wxMouseEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxMouseEventHandlerList[nativeHandle] = list;
    }
    list.add( WxMouseEventListItems( func, wxGetEnterWindowEventType() ) );
    wxEvtHandlerBindEnterWindowEventCallback( nativeHandle );
  }

  void unbindEnterWindowEvent()
  {
    final list = wxMouseEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => items.eventType == wxGetEnterWindowEventType() ) );
    wxEvtHandlerUnbindEnterWindowEventCallback( nativeHandle );
  }
}

// ------------------------- EVT_LEAVE_WINDOW ----------------------
///
/// [LeaveWindow](/wxdart/wxGetLeaveWindowEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindLeaveWindowEvent( OnMouseEventFunc ) |
/// | void unbindLeaveWindowEvent() |

typedef _WxGetLeaveWindowEventTypeNative = Int32 Function();
typedef WxGetLeaveWindowEventType = int Function();
late WxGetLeaveWindowEventType wxGetLeaveWindowEventType;

typedef _WxEvtHandlerBindLeaveWindowEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerBindLeaveWindowEventCallback = void Function( Pointer );
late WxEvtHandlerBindLeaveWindowEventCallback wxEvtHandlerBindLeaveWindowEventCallback;

typedef _WxEvtHandlerUnbindLeaveWindowEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerUnbindLeaveWindowEventCallback = void Function( Pointer );
late WxEvtHandlerUnbindLeaveWindowEventCallback wxEvtHandlerUnbindLeaveWindowEventCallback;

extension LeaveWindowEventBinder on WxEvtHandler {
  void bindLeaveWindowEvent( OnMouseEventFunc func ) {
    List<WxMouseEventListItems>? list = wxMouseEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxMouseEventHandlerList[nativeHandle] = list;
    }
    list.add( WxMouseEventListItems( func, wxGetLeaveWindowEventType() ) );
    wxEvtHandlerBindLeaveWindowEventCallback( nativeHandle );
  }

  void unbindLeaveWindowEvent()
  {
    final list = wxMouseEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => items.eventType == wxGetLeaveWindowEventType() ) );
    wxEvtHandlerUnbindLeaveWindowEventCallback( nativeHandle );
  }
}

// ------------------------- EVT_MOUSEWHEEL ----------------------
///
/// [MouseWheel](/wxdart/wxGetMouseWheelEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindMouseWheelEvent( OnMouseEventFunc ) |
/// | void unbindMouseWheelEvent() |

typedef _WxGetMouseWheelEventTypeNative = Int32 Function();
typedef WxGetMouseWheelEventType = int Function();
late WxGetMouseWheelEventType wxGetMouseWheelEventType;

typedef _WxEvtHandlerBindMouseWheelEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerBindMouseWheelEventCallback = void Function( Pointer );
late WxEvtHandlerBindMouseWheelEventCallback wxEvtHandlerBindMouseWheelEventCallback;

typedef _WxEvtHandlerUnbindMouseWheelEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerUnbindMouseWheelEventCallback = void Function( Pointer );
late WxEvtHandlerUnbindMouseWheelEventCallback wxEvtHandlerUnbindMouseWheelEventCallback;

extension MouseWheelEventBinder on WxEvtHandler {
  void bindMouseWheelEvent( OnMouseEventFunc func ) {
    List<WxMouseEventListItems>? list = wxMouseEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxMouseEventHandlerList[nativeHandle] = list;
    }
    list.add( WxMouseEventListItems( func, wxGetMouseWheelEventType() ) );
    wxEvtHandlerBindMouseWheelEventCallback( nativeHandle );
  }

  void unbindMouseWheelEvent()
  {
    final list = wxMouseEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => items.eventType == wxGetMouseWheelEventType() ) );
    wxEvtHandlerUnbindMouseWheelEventCallback( nativeHandle );
  }
}

// ------------------------- EVT_MAGNIFY ----------------------
///
/// [Magnify](/wxdart/wxGetMagnifyEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindMagnifyEvent( OnMouseEventFunc ) |
/// | void unbindMagnifyEvent() |

typedef _WxGetMagnifyEventTypeNative = Int32 Function();
typedef WxGetMagnifyEventType = int Function();
late WxGetMagnifyEventType wxGetMagnifyEventType;

typedef _WxEvtHandlerBindMagnifyEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerBindMagnifyEventCallback = void Function( Pointer );
late WxEvtHandlerBindMagnifyEventCallback wxEvtHandlerBindMagnifyEventCallback;

typedef _WxEvtHandlerUnbindMagnifyEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerUnbindMagnifyEventCallback = void Function( Pointer );
late WxEvtHandlerUnbindMagnifyEventCallback wxEvtHandlerUnbindMagnifyEventCallback;

extension MagnifyEventBinder on WxEvtHandler {
  void bindMagnifyEvent( OnMouseEventFunc func ) {
    List<WxMouseEventListItems>? list = wxMouseEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxMouseEventHandlerList[nativeHandle] = list;
    }
    list.add( WxMouseEventListItems( func, wxGetMagnifyEventType() ) );
    wxEvtHandlerBindMagnifyEventCallback( nativeHandle );
  }

  void unbindMagnifyEvent()
  {
    final list = wxMouseEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => items.eventType == wxGetMagnifyEventType() ) );
    wxEvtHandlerUnbindMagnifyEventCallback( nativeHandle );
  }
}

// ------------------------- EVT_KEY_DOWN ----------------------
///
/// [KeyDown](/wxdart/wxGetKeyDownEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindKeyDownEvent( OnKeyEventFunc ) |
/// | void unbindKeyDownEvent() |

typedef _WxGetKeyDownEventTypeNative = Int32 Function();
typedef WxGetKeyDownEventType = int Function();
late WxGetKeyDownEventType wxGetKeyDownEventType;

typedef _WxEvtHandlerBindKeyDownEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerBindKeyDownEventCallback = void Function( Pointer );
late WxEvtHandlerBindKeyDownEventCallback wxEvtHandlerBindKeyDownEventCallback;

typedef _WxEvtHandlerUnbindKeyDownEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerUnbindKeyDownEventCallback = void Function( Pointer );
late WxEvtHandlerUnbindKeyDownEventCallback wxEvtHandlerUnbindKeyDownEventCallback;

extension KeyDownEventBinder on WxEvtHandler {
  void bindKeyDownEvent( OnKeyEventFunc func ) {
    List<WxKeyEventListItems>? list = wxKeyEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxKeyEventHandlerList[nativeHandle] = list;
    }
    list.add( WxKeyEventListItems( func, wxGetKeyDownEventType() ) );
    wxEvtHandlerBindKeyDownEventCallback( nativeHandle );
  }

  void unbindKeyDownEvent()
  {
    final list = wxKeyEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => items.eventType == wxGetKeyDownEventType() ) );
    wxEvtHandlerUnbindKeyDownEventCallback( nativeHandle );
  }
}

// ------------------------- EVT_KEY_UP ----------------------
///
/// [KeyUp](/wxdart/wxGetKeyUpEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindKeyUpEvent( OnKeyEventFunc ) |
/// | void unbindKeyUpEvent() |

typedef _WxGetKeyUpEventTypeNative = Int32 Function();
typedef WxGetKeyUpEventType = int Function();
late WxGetKeyUpEventType wxGetKeyUpEventType;

typedef _WxEvtHandlerBindKeyUpEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerBindKeyUpEventCallback = void Function( Pointer );
late WxEvtHandlerBindKeyUpEventCallback wxEvtHandlerBindKeyUpEventCallback;

typedef _WxEvtHandlerUnbindKeyUpEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerUnbindKeyUpEventCallback = void Function( Pointer );
late WxEvtHandlerUnbindKeyUpEventCallback wxEvtHandlerUnbindKeyUpEventCallback;

extension KeyUpEventBinder on WxEvtHandler {
  void bindKeyUpEvent( OnKeyEventFunc func ) {
    List<WxKeyEventListItems>? list = wxKeyEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxKeyEventHandlerList[nativeHandle] = list;
    }
    list.add( WxKeyEventListItems( func, wxGetKeyUpEventType() ) );
    wxEvtHandlerBindKeyUpEventCallback( nativeHandle );
  }

  void unbindKeyUpEvent()
  {
    final list = wxKeyEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => items.eventType == wxGetKeyUpEventType() ) );
    wxEvtHandlerUnbindKeyUpEventCallback( nativeHandle );
  }
}

// ------------------------- EVT_CHAR ----------------------
///
/// [Char](/wxdart/wxGetCharEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindCharEvent( OnKeyEventFunc ) |
/// | void unbindCharEvent() |

typedef _WxGetCharEventTypeNative = Int32 Function();
typedef WxGetCharEventType = int Function();
late WxGetCharEventType wxGetCharEventType;

typedef _WxEvtHandlerBindCharEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerBindCharEventCallback = void Function( Pointer );
late WxEvtHandlerBindCharEventCallback wxEvtHandlerBindCharEventCallback;

typedef _WxEvtHandlerUnbindCharEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerUnbindCharEventCallback = void Function( Pointer );
late WxEvtHandlerUnbindCharEventCallback wxEvtHandlerUnbindCharEventCallback;

extension CharEventBinder on WxEvtHandler {
  void bindCharEvent( OnKeyEventFunc func ) {
    List<WxKeyEventListItems>? list = wxKeyEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxKeyEventHandlerList[nativeHandle] = list;
    }
    list.add( WxKeyEventListItems( func, wxGetCharEventType() ) );
    wxEvtHandlerBindCharEventCallback( nativeHandle );
  }

  void unbindCharEvent()
  {
    final list = wxKeyEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => items.eventType == wxGetCharEventType() ) );
    wxEvtHandlerUnbindCharEventCallback( nativeHandle );
  }
}

// ------------------------- EVT_CHAR_HOOK ----------------------
///
/// [CharHook](/wxdart/wxGetCharHookEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindCharHookEvent( OnKeyEventFunc ) |
/// | void unbindCharHookEvent() |

typedef _WxGetCharHookEventTypeNative = Int32 Function();
typedef WxGetCharHookEventType = int Function();
late WxGetCharHookEventType wxGetCharHookEventType;

typedef _WxEvtHandlerBindCharHookEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerBindCharHookEventCallback = void Function( Pointer );
late WxEvtHandlerBindCharHookEventCallback wxEvtHandlerBindCharHookEventCallback;

typedef _WxEvtHandlerUnbindCharHookEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerUnbindCharHookEventCallback = void Function( Pointer );
late WxEvtHandlerUnbindCharHookEventCallback wxEvtHandlerUnbindCharHookEventCallback;

extension CharHookEventBinder on WxEvtHandler {
  void bindCharHookEvent( OnKeyEventFunc func ) {
    List<WxKeyEventListItems>? list = wxKeyEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxKeyEventHandlerList[nativeHandle] = list;
    }
    list.add( WxKeyEventListItems( func, wxGetCharHookEventType() ) );
    wxEvtHandlerBindCharHookEventCallback( nativeHandle );
  }

  void unbindCharHookEvent()
  {
    final list = wxKeyEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => items.eventType == wxGetCharHookEventType() ) );
    wxEvtHandlerUnbindCharHookEventCallback( nativeHandle );
  }
}

// ------------------------- EVT_INIT_DIALOG ----------------------
///
/// [InitDialog](/wxdart/wxGetInitDialogEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindInitDialogEvent( OnInitDialogEventFunc ) |
/// | void unbindInitDialogEvent() |

typedef _WxGetInitDialogEventTypeNative = Int32 Function();
typedef WxGetInitDialogEventType = int Function();
late WxGetInitDialogEventType wxGetInitDialogEventType;

typedef _WxEvtHandlerBindInitDialogEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerBindInitDialogEventCallback = void Function( Pointer );
late WxEvtHandlerBindInitDialogEventCallback wxEvtHandlerBindInitDialogEventCallback;

typedef _WxEvtHandlerUnbindInitDialogEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerUnbindInitDialogEventCallback = void Function( Pointer );
late WxEvtHandlerUnbindInitDialogEventCallback wxEvtHandlerUnbindInitDialogEventCallback;

extension InitDialogEventBinder on WxEvtHandler {
  void bindInitDialogEvent( OnInitDialogEventFunc func ) {
    List<WxInitDialogEventListItems>? list = wxInitDialogEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxInitDialogEventHandlerList[nativeHandle] = list;
    }
    list.add( WxInitDialogEventListItems( func, wxGetInitDialogEventType() ) );
    wxEvtHandlerBindInitDialogEventCallback( nativeHandle );
  }

  void unbindInitDialogEvent()
  {
    final list = wxInitDialogEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => items.eventType == wxGetInitDialogEventType() ) );
    wxEvtHandlerUnbindInitDialogEventCallback( nativeHandle );
  }
}

// ------------------------- EVT_DIALOG_VALIDATE ----------------------
///
/// [DialogValidate](/wxdart/wxGetDialogValidateEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindDialogValidateEvent( OnDialogValidateEventFunc ) |
/// | void unbindDialogValidateEvent() |

typedef _WxGetDialogValidateEventTypeNative = Int32 Function();
typedef WxGetDialogValidateEventType = int Function();
late WxGetDialogValidateEventType wxGetDialogValidateEventType;

typedef _WxEvtHandlerBindDialogValidateEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindDialogValidateEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindDialogValidateEventCallback wxEvtHandlerBindDialogValidateEventCallback;

typedef _WxEvtHandlerUnbindDialogValidateEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindDialogValidateEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindDialogValidateEventCallback wxEvtHandlerUnbindDialogValidateEventCallback;

extension DialogValidateEventBinder on WxEvtHandler {
  void bindDialogValidateEvent( OnDialogValidateEventFunc func, int id ) {
    List<WxDialogValidateEventListItems>? list = wxDialogValidateEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxDialogValidateEventHandlerList[nativeHandle] = list;
    }
    list.add( WxDialogValidateEventListItems( func, wxGetDialogValidateEventType(), id ) );
    wxEvtHandlerBindDialogValidateEventCallback( nativeHandle, id );
  }

  void unbindDialogValidateEvent( int id )
  {
    final list = wxDialogValidateEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetDialogValidateEventType() ) ) );
    wxEvtHandlerUnbindDialogValidateEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_UPDATE_UI ----------------------
///
/// [UpdateUI](/wxdart/wxGetUpdateUIEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindUpdateUIEvent( OnUpdateUIEventFunc ) |
/// | void unbindUpdateUIEvent() |

typedef _WxGetUpdateUIEventTypeNative = Int32 Function();
typedef WxGetUpdateUIEventType = int Function();
late WxGetUpdateUIEventType wxGetUpdateUIEventType;

typedef _WxEvtHandlerBindUpdateUIEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindUpdateUIEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindUpdateUIEventCallback wxEvtHandlerBindUpdateUIEventCallback;

typedef _WxEvtHandlerUnbindUpdateUIEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindUpdateUIEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindUpdateUIEventCallback wxEvtHandlerUnbindUpdateUIEventCallback;

extension UpdateUIEventBinder on WxEvtHandler {
  void bindUpdateUIEvent( OnUpdateUIEventFunc func, int id ) {
    List<WxUpdateUIEventListItems>? list = wxUpdateUIEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxUpdateUIEventHandlerList[nativeHandle] = list;
    }
    list.add( WxUpdateUIEventListItems( func, wxGetUpdateUIEventType(), id ) );
    wxEvtHandlerBindUpdateUIEventCallback( nativeHandle, id );
  }

  void unbindUpdateUIEvent( int id )
  {
    final list = wxUpdateUIEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetUpdateUIEventType() ) ) );
    wxEvtHandlerUnbindUpdateUIEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_POPUP_WINDOW_DISMISS ----------------------
///
/// [PopupWindowDismiss](/wxdart/wxGetPopupWindowDismissEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindPopupWindowDismissEvent( OnNotifyEventFunc ) |
/// | void unbindPopupWindowDismissEvent() |

typedef _WxGetPopupWindowDismissEventTypeNative = Int32 Function();
typedef WxGetPopupWindowDismissEventType = int Function();
late WxGetPopupWindowDismissEventType wxGetPopupWindowDismissEventType;

typedef _WxEvtHandlerBindPopupWindowDismissEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindPopupWindowDismissEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindPopupWindowDismissEventCallback wxEvtHandlerBindPopupWindowDismissEventCallback;

typedef _WxEvtHandlerUnbindPopupWindowDismissEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindPopupWindowDismissEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindPopupWindowDismissEventCallback wxEvtHandlerUnbindPopupWindowDismissEventCallback;

extension PopupWindowDismissEventBinder on WxEvtHandler {
  void bindPopupWindowDismissEvent( OnNotifyEventFunc func, int id ) {
    List<WxNotifyEventListItems>? list = wxNotifyEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxNotifyEventHandlerList[nativeHandle] = list;
    }
    list.add( WxNotifyEventListItems( func, wxGetPopupWindowDismissEventType(), id ) );
    wxEvtHandlerBindPopupWindowDismissEventCallback( nativeHandle, id );
  }

  void unbindPopupWindowDismissEvent( int id )
  {
    final list = wxNotifyEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetPopupWindowDismissEventType() ) ) );
    wxEvtHandlerUnbindPopupWindowDismissEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_GESTURE_PAN ----------------------
///
/// [GesturePan](/wxdart/wxGetGesturePanEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindGesturePanEvent( OnPanGestureEventFunc ) |
/// | void unbindGesturePanEvent() |

typedef _WxGetGesturePanEventTypeNative = Int32 Function();
typedef WxGetGesturePanEventType = int Function();
late WxGetGesturePanEventType wxGetGesturePanEventType;

typedef _WxEvtHandlerBindGesturePanEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerBindGesturePanEventCallback = void Function( Pointer );
late WxEvtHandlerBindGesturePanEventCallback wxEvtHandlerBindGesturePanEventCallback;

typedef _WxEvtHandlerUnbindGesturePanEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerUnbindGesturePanEventCallback = void Function( Pointer );
late WxEvtHandlerUnbindGesturePanEventCallback wxEvtHandlerUnbindGesturePanEventCallback;

extension GesturePanEventBinder on WxEvtHandler {
  void bindGesturePanEvent( OnPanGestureEventFunc func ) {
    List<WxPanGestureEventListItems>? list = wxPanGestureEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxPanGestureEventHandlerList[nativeHandle] = list;
    }
    list.add( WxPanGestureEventListItems( func, wxGetGesturePanEventType() ) );
    wxEvtHandlerBindGesturePanEventCallback( nativeHandle );
  }

  void unbindGesturePanEvent()
  {
    final list = wxPanGestureEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => items.eventType == wxGetGesturePanEventType() ) );
    wxEvtHandlerUnbindGesturePanEventCallback( nativeHandle );
  }
}

// ------------------------- EVT_GESTURE_ZOOM ----------------------
///
/// [GestureZoom](/wxdart/wxGetGestureZoomEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindGestureZoomEvent( OnZoomGestureEventFunc ) |
/// | void unbindGestureZoomEvent() |

typedef _WxGetGestureZoomEventTypeNative = Int32 Function();
typedef WxGetGestureZoomEventType = int Function();
late WxGetGestureZoomEventType wxGetGestureZoomEventType;

typedef _WxEvtHandlerBindGestureZoomEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerBindGestureZoomEventCallback = void Function( Pointer );
late WxEvtHandlerBindGestureZoomEventCallback wxEvtHandlerBindGestureZoomEventCallback;

typedef _WxEvtHandlerUnbindGestureZoomEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerUnbindGestureZoomEventCallback = void Function( Pointer );
late WxEvtHandlerUnbindGestureZoomEventCallback wxEvtHandlerUnbindGestureZoomEventCallback;

extension GestureZoomEventBinder on WxEvtHandler {
  void bindGestureZoomEvent( OnZoomGestureEventFunc func ) {
    List<WxZoomGestureEventListItems>? list = wxZoomGestureEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxZoomGestureEventHandlerList[nativeHandle] = list;
    }
    list.add( WxZoomGestureEventListItems( func, wxGetGestureZoomEventType() ) );
    wxEvtHandlerBindGestureZoomEventCallback( nativeHandle );
  }

  void unbindGestureZoomEvent()
  {
    final list = wxZoomGestureEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => items.eventType == wxGetGestureZoomEventType() ) );
    wxEvtHandlerUnbindGestureZoomEventCallback( nativeHandle );
  }
}

// ------------------------- EVT_SCROLLWIN_THUMBTRACK ----------------------
///
/// [ScrollWin](/wxdart/wxGetScrollWinEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindScrollWinEvent( OnScrollWinEventFunc ) |
/// | void unbindScrollWinEvent() |

typedef _WxGetScrollWinEventTypeNative = Int32 Function();
typedef WxGetScrollWinEventType = int Function();
late WxGetScrollWinEventType wxGetScrollWinEventType;

typedef _WxEvtHandlerBindScrollWinEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerBindScrollWinEventCallback = void Function( Pointer );
late WxEvtHandlerBindScrollWinEventCallback wxEvtHandlerBindScrollWinEventCallback;

typedef _WxEvtHandlerUnbindScrollWinEventCallbackNative = Void Function( Pointer );
typedef WxEvtHandlerUnbindScrollWinEventCallback = void Function( Pointer );
late WxEvtHandlerUnbindScrollWinEventCallback wxEvtHandlerUnbindScrollWinEventCallback;

extension ScrollWinEventBinder on WxEvtHandler {
  void bindScrollWinEvent( OnScrollWinEventFunc func ) {
    List<WxScrollWinEventListItems>? list = wxScrollWinEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxScrollWinEventHandlerList[nativeHandle] = list;
    }
    list.add( WxScrollWinEventListItems( func, wxGetScrollWinEventType() ) );
    wxEvtHandlerBindScrollWinEventCallback( nativeHandle );
  }

  void unbindScrollWinEvent()
  {
    final list = wxScrollWinEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => items.eventType == wxGetScrollWinEventType() ) );
    wxEvtHandlerUnbindScrollWinEventCallback( nativeHandle );
  }
}

// ------------------------- EVT_DRAG_FEEDBACK ----------------------
///
/// [DragFeedback](/wxdart/wxGetDragFeedbackEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindDragFeedbackEvent( OnDragEventFunc ) |
/// | void unbindDragFeedbackEvent() |

typedef _WxGetDragFeedbackEventTypeNative = Int32 Function();
typedef WxGetDragFeedbackEventType = int Function();
late WxGetDragFeedbackEventType wxGetDragFeedbackEventType;

typedef _WxEvtHandlerBindDragFeedbackEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindDragFeedbackEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindDragFeedbackEventCallback wxEvtHandlerBindDragFeedbackEventCallback;

typedef _WxEvtHandlerUnbindDragFeedbackEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindDragFeedbackEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindDragFeedbackEventCallback wxEvtHandlerUnbindDragFeedbackEventCallback;

extension DragFeedbackEventBinder on WxEvtHandler {
  void bindDragFeedbackEvent( OnDragEventFunc func, int id ) {
    List<WxDragEventListItems>? list = wxDragEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxDragEventHandlerList[nativeHandle] = list;
    }
    list.add( WxDragEventListItems( func, wxGetDragFeedbackEventType(), id ) );
    wxEvtHandlerBindDragFeedbackEventCallback( nativeHandle, id );
  }

  void unbindDragFeedbackEvent( int id )
  {
    final list = wxDragEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetDragFeedbackEventType() ) ) );
    wxEvtHandlerUnbindDragFeedbackEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_DROP_DATA ----------------------
///
/// [DropData](/wxdart/wxGetDropDataEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindDropDataEvent( OnDropEventFunc ) |
/// | void unbindDropDataEvent() |

typedef _WxGetDropDataEventTypeNative = Int32 Function();
typedef WxGetDropDataEventType = int Function();
late WxGetDropDataEventType wxGetDropDataEventType;

typedef _WxEvtHandlerBindDropDataEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindDropDataEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindDropDataEventCallback wxEvtHandlerBindDropDataEventCallback;

typedef _WxEvtHandlerUnbindDropDataEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindDropDataEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindDropDataEventCallback wxEvtHandlerUnbindDropDataEventCallback;

extension DropDataEventBinder on WxEvtHandler {
  void bindDropDataEvent( OnDropEventFunc func, int id ) {
    List<WxDropEventListItems>? list = wxDropEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxDropEventHandlerList[nativeHandle] = list;
    }
    list.add( WxDropEventListItems( func, wxGetDropDataEventType(), id ) );
    wxEvtHandlerBindDropDataEventCallback( nativeHandle, id );
  }

  void unbindDropDataEvent( int id )
  {
    final list = wxDropEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetDropDataEventType() ) ) );
    wxEvtHandlerUnbindDropDataEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_DROP_DROP ----------------------
///
/// [DropDrop](/wxdart/wxGetDropDropEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindDropDropEvent( OnDropEventFunc ) |
/// | void unbindDropDropEvent() |

typedef _WxGetDropDropEventTypeNative = Int32 Function();
typedef WxGetDropDropEventType = int Function();
late WxGetDropDropEventType wxGetDropDropEventType;

typedef _WxEvtHandlerBindDropDropEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindDropDropEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindDropDropEventCallback wxEvtHandlerBindDropDropEventCallback;

typedef _WxEvtHandlerUnbindDropDropEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindDropDropEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindDropDropEventCallback wxEvtHandlerUnbindDropDropEventCallback;

extension DropDropEventBinder on WxEvtHandler {
  void bindDropDropEvent( OnDropEventFunc func, int id ) {
    List<WxDropEventListItems>? list = wxDropEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxDropEventHandlerList[nativeHandle] = list;
    }
    list.add( WxDropEventListItems( func, wxGetDropDropEventType(), id ) );
    wxEvtHandlerBindDropDropEventCallback( nativeHandle, id );
  }

  void unbindDropDropEvent( int id )
  {
    final list = wxDropEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetDropDropEventType() ) ) );
    wxEvtHandlerUnbindDropDropEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_DROP_ENTER ----------------------
///
/// [DropEnter](/wxdart/wxGetDropEnterEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindDropEnterEvent( OnDropEventFunc ) |
/// | void unbindDropEnterEvent() |

typedef _WxGetDropEnterEventTypeNative = Int32 Function();
typedef WxGetDropEnterEventType = int Function();
late WxGetDropEnterEventType wxGetDropEnterEventType;

typedef _WxEvtHandlerBindDropEnterEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindDropEnterEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindDropEnterEventCallback wxEvtHandlerBindDropEnterEventCallback;

typedef _WxEvtHandlerUnbindDropEnterEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindDropEnterEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindDropEnterEventCallback wxEvtHandlerUnbindDropEnterEventCallback;

extension DropEnterEventBinder on WxEvtHandler {
  void bindDropEnterEvent( OnDropEventFunc func, int id ) {
    List<WxDropEventListItems>? list = wxDropEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxDropEventHandlerList[nativeHandle] = list;
    }
    list.add( WxDropEventListItems( func, wxGetDropEnterEventType(), id ) );
    wxEvtHandlerBindDropEnterEventCallback( nativeHandle, id );
  }

  void unbindDropEnterEvent( int id )
  {
    final list = wxDropEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetDropEnterEventType() ) ) );
    wxEvtHandlerUnbindDropEnterEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_DROP_LEAVE ----------------------
///
/// [DropLeave](/wxdart/wxGetDropLeaveEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindDropLeaveEvent( OnDropEventFunc ) |
/// | void unbindDropLeaveEvent() |

typedef _WxGetDropLeaveEventTypeNative = Int32 Function();
typedef WxGetDropLeaveEventType = int Function();
late WxGetDropLeaveEventType wxGetDropLeaveEventType;

typedef _WxEvtHandlerBindDropLeaveEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindDropLeaveEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindDropLeaveEventCallback wxEvtHandlerBindDropLeaveEventCallback;

typedef _WxEvtHandlerUnbindDropLeaveEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindDropLeaveEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindDropLeaveEventCallback wxEvtHandlerUnbindDropLeaveEventCallback;

extension DropLeaveEventBinder on WxEvtHandler {
  void bindDropLeaveEvent( OnDropEventFunc func, int id ) {
    List<WxDropEventListItems>? list = wxDropEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxDropEventHandlerList[nativeHandle] = list;
    }
    list.add( WxDropEventListItems( func, wxGetDropLeaveEventType(), id ) );
    wxEvtHandlerBindDropLeaveEventCallback( nativeHandle, id );
  }

  void unbindDropLeaveEvent( int id )
  {
    final list = wxDropEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetDropLeaveEventType() ) ) );
    wxEvtHandlerUnbindDropLeaveEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_DROP_DRAG_OVER ----------------------
///
/// [DropDragOver](/wxdart/wxGetDropDragOverEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindDropDragOverEvent( OnDropEventFunc ) |
/// | void unbindDropDragOverEvent() |

typedef _WxGetDropDragOverEventTypeNative = Int32 Function();
typedef WxGetDropDragOverEventType = int Function();
late WxGetDropDragOverEventType wxGetDropDragOverEventType;

typedef _WxEvtHandlerBindDropDragOverEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindDropDragOverEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindDropDragOverEventCallback wxEvtHandlerBindDropDragOverEventCallback;

typedef _WxEvtHandlerUnbindDropDragOverEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindDropDragOverEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindDropDragOverEventCallback wxEvtHandlerUnbindDropDragOverEventCallback;

extension DropDragOverEventBinder on WxEvtHandler {
  void bindDropDragOverEvent( OnDropEventFunc func, int id ) {
    List<WxDropEventListItems>? list = wxDropEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxDropEventHandlerList[nativeHandle] = list;
    }
    list.add( WxDropEventListItems( func, wxGetDropDragOverEventType(), id ) );
    wxEvtHandlerBindDropDragOverEventCallback( nativeHandle, id );
  }

  void unbindDropDragOverEvent( int id )
  {
    final list = wxDropEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetDropDragOverEventType() ) ) );
    wxEvtHandlerUnbindDropDragOverEventCallback( nativeHandle, id );
  }
}


void setupWxEvents( DynamicLibrary dylib )
{
  // ------------------------- wxGestureEvent ----------------------

  final wxGestureEventConstructorPtr = dylib.lookup <NativeFunction<_WxGestureEventConstructorNative>>('wxGestureEventConstructor');
  _wxGestureEventConstructor = wxGestureEventConstructorPtr.asFunction<_WxGestureEventConstructor>();

  final wxGestureEventSetPositionPtr = dylib.lookup <NativeFunction<_WxGestureEventSetPositionNative>>('wxGestureEventSetPosition');
  _wxGestureEventSetPosition = wxGestureEventSetPositionPtr.asFunction<_WxGestureEventSetPosition>();

  final wxGestureEventGetPositionPtr = dylib.lookup <NativeFunction<_WxGestureEventGetPositionNative>>('wxGestureEventGetPosition');
  _wxGestureEventGetPosition = wxGestureEventGetPositionPtr.asFunction<_WxGestureEventGetPosition>();

  final wxGestureEventSetGestureStartPtr = dylib.lookup <NativeFunction<_WxGestureEventSetGestureStartNative>>('wxGestureEventSetGestureStart');
  _wxGestureEventSetGestureStart = wxGestureEventSetGestureStartPtr.asFunction<_WxGestureEventSetGestureStart>();

  final wxGestureEventIsGestureStartPtr = dylib.lookup <NativeFunction<_WxGestureEventIsGestureStartNative>>('wxGestureEventIsGestureStart');
  _wxGestureEventIsGestureStart = wxGestureEventIsGestureStartPtr.asFunction<_WxGestureEventIsGestureStart>();

  final wxGestureEventSetGestureEndPtr = dylib.lookup <NativeFunction<_WxGestureEventSetGestureEndNative>>('wxGestureEventSetGestureEnd');
  _wxGestureEventSetGestureEnd = wxGestureEventSetGestureEndPtr.asFunction<_WxGestureEventSetGestureEnd>();

  final wxGestureEventIsGestureEndPtr = dylib.lookup <NativeFunction<_WxGestureEventIsGestureEndNative>>('wxGestureEventIsGestureEnd');
  _wxGestureEventIsGestureEnd = wxGestureEventIsGestureEndPtr.asFunction<_WxGestureEventIsGestureEnd>();

  final wxInstallDartGestureEventCallbackPtr = dylib.lookup <NativeFunction<_WxInstallDartGestureEventCallbackNative>>('wxInstallDartGestureEventCallback');
  _wxInstallDartGestureEventCallback = wxInstallDartGestureEventCallbackPtr.asFunction<_WxInstallDartGestureEventCallback>();

  wxGestureEventNativeCallable = NativeCallable<WxGestureEventCallbackNative>.isolateLocal( wxGestureEventCallback );
  _wxInstallDartGestureEventCallback( wxGestureEventNativeCallable.nativeFunction );

  // ------------------------- wxPanGestureEvent ----------------------

  final wxPanGestureEventConstructorPtr = dylib.lookup <NativeFunction<_WxPanGestureEventConstructorNative>>('wxPanGestureEventConstructor');
  _wxPanGestureEventConstructor = wxPanGestureEventConstructorPtr.asFunction<_WxPanGestureEventConstructor>();

  final wxPanGestureEventSetDeltaPtr = dylib.lookup <NativeFunction<_WxPanGestureEventSetDeltaNative>>('wxPanGestureEventSetDelta');
  _wxPanGestureEventSetDelta = wxPanGestureEventSetDeltaPtr.asFunction<_WxPanGestureEventSetDelta>();

  final wxPanGestureEventGetDeltaPtr = dylib.lookup <NativeFunction<_WxPanGestureEventGetDeltaNative>>('wxPanGestureEventGetDelta');
  _wxPanGestureEventGetDelta = wxPanGestureEventGetDeltaPtr.asFunction<_WxPanGestureEventGetDelta>();

  final wxInstallDartPanGestureEventCallbackPtr = dylib.lookup <NativeFunction<_WxInstallDartPanGestureEventCallbackNative>>('wxInstallDartPanGestureEventCallback');
  _wxInstallDartPanGestureEventCallback = wxInstallDartPanGestureEventCallbackPtr.asFunction<_WxInstallDartPanGestureEventCallback>();

  wxPanGestureEventNativeCallable = NativeCallable<WxPanGestureEventCallbackNative>.isolateLocal( wxPanGestureEventCallback );
  _wxInstallDartPanGestureEventCallback( wxPanGestureEventNativeCallable.nativeFunction );

  // ------------------------- wxZoomGestureEvent ----------------------

  final wxZoomGestureEventConstructorPtr = dylib.lookup <NativeFunction<_WxZoomGestureEventConstructorNative>>('wxZoomGestureEventConstructor');
  _wxZoomGestureEventConstructor = wxZoomGestureEventConstructorPtr.asFunction<_WxZoomGestureEventConstructor>();

  final wxZoomGestureEventSetZoomFactorPtr = dylib.lookup <NativeFunction<_WxZoomGestureEventSetZoomFactorNative>>('wxZoomGestureEventSetZoomFactor');
  _wxZoomGestureEventSetZoomFactor = wxZoomGestureEventSetZoomFactorPtr.asFunction<_WxZoomGestureEventSetZoomFactor>();

  final wxZoomGestureEventGetZoomFactorPtr = dylib.lookup <NativeFunction<_WxZoomGestureEventGetZoomFactorNative>>('wxZoomGestureEventGetZoomFactor');
  _wxZoomGestureEventGetZoomFactor = wxZoomGestureEventGetZoomFactorPtr.asFunction<_WxZoomGestureEventGetZoomFactor>();

  final wxInstallDartZoomGestureEventCallbackPtr = dylib.lookup <NativeFunction<_WxInstallDartZoomGestureEventCallbackNative>>('wxInstallDartZoomGestureEventCallback');
  _wxInstallDartZoomGestureEventCallback = wxInstallDartZoomGestureEventCallbackPtr.asFunction<_WxInstallDartZoomGestureEventCallback>();

  wxZoomGestureEventNativeCallable = NativeCallable<WxZoomGestureEventCallbackNative>.isolateLocal( wxZoomGestureEventCallback );
  _wxInstallDartZoomGestureEventCallback( wxZoomGestureEventNativeCallable.nativeFunction );

  // ------------------------- wxMenuEvent ----------------------

  final wxMenuEventConstructorPtr = dylib.lookup <NativeFunction<_WxMenuEventConstructorNative>>('wxMenuEventConstructor');
  _wxMenuEventConstructor = wxMenuEventConstructorPtr.asFunction<_WxMenuEventConstructor>();

  final wxMenuEventGetMenuPtr = dylib.lookup <NativeFunction<_WxMenuEventGetMenuNative>>('wxMenuEventGetMenu');
  _wxMenuEventGetMenu = wxMenuEventGetMenuPtr.asFunction<_WxMenuEventGetMenu>();

  final wxMenuEventGetMenuIdPtr = dylib.lookup <NativeFunction<_WxMenuEventGetMenuIdNative>>('wxMenuEventGetMenuId');
  _wxMenuEventGetMenuId = wxMenuEventGetMenuIdPtr.asFunction<_WxMenuEventGetMenuId>();

  final wxMenuEventIsPopupPtr = dylib.lookup <NativeFunction<_WxMenuEventIsPopupNative>>('wxMenuEventIsPopup');
  _wxMenuEventIsPopup = wxMenuEventIsPopupPtr.asFunction<_WxMenuEventIsPopup>();

  final wxInstallDartMenuEventCallbackPtr = dylib.lookup <NativeFunction<_WxInstallDartMenuEventCallbackNative>>('wxInstallDartMenuEventCallback');
  _wxInstallDartMenuEventCallback = wxInstallDartMenuEventCallbackPtr.asFunction<_WxInstallDartMenuEventCallback>();

  wxMenuEventNativeCallable = NativeCallable<WxMenuEventCallbackNative>.isolateLocal( wxMenuEventCallback );
  _wxInstallDartMenuEventCallback( wxMenuEventNativeCallable.nativeFunction );

  // ------------------------- wxSizeEvent ----------------------

  final wxSizeEventConstructorPtr = dylib.lookup <NativeFunction<_WxSizeEventConstructorNative>>('wxSizeEventConstructor');
  _wxSizeEventConstructor = wxSizeEventConstructorPtr.asFunction<_WxSizeEventConstructor>();

  final wxSizeEventGetSizePtr = dylib.lookup <NativeFunction<_WxSizeEventGetSizeNative>>('wxSizeEventGetSize');
  _wxSizeEventGetSize = wxSizeEventGetSizePtr.asFunction<_WxSizeEventGetSize>();

  final wxSizeEventSetSizePtr = dylib.lookup <NativeFunction<_WxSizeEventSetSizeNative>>('wxSizeEventSetSize');
  _wxSizeEventSetSize = wxSizeEventSetSizePtr.asFunction<_WxSizeEventSetSize>();

  final wxSizeEventGetRectPtr = dylib.lookup <NativeFunction<_WxSizeEventGetRectNative>>('wxSizeEventGetRect');
  _wxSizeEventGetRect = wxSizeEventGetRectPtr.asFunction<_WxSizeEventGetRect>();

  final wxSizeEventSetRectPtr = dylib.lookup <NativeFunction<_WxSizeEventSetRectNative>>('wxSizeEventSetRect');
  _wxSizeEventSetRect = wxSizeEventSetRectPtr.asFunction<_WxSizeEventSetRect>();

  final wxInstallDartSizeEventCallbackPtr = dylib.lookup <NativeFunction<_WxInstallDartSizeEventCallbackNative>>('wxInstallDartSizeEventCallback');
  _wxInstallDartSizeEventCallback = wxInstallDartSizeEventCallbackPtr.asFunction<_WxInstallDartSizeEventCallback>();

  wxSizeEventNativeCallable = NativeCallable<WxSizeEventCallbackNative>.isolateLocal( wxSizeEventCallback );
  _wxInstallDartSizeEventCallback( wxSizeEventNativeCallable.nativeFunction );

  // ------------------------- wxVMEvent ----------------------

  final wxVMEventConstructorPtr = dylib.lookup <NativeFunction<_WxVMEventConstructorNative>>('wxVMEventConstructor');
  _wxVMEventConstructor = wxVMEventConstructorPtr.asFunction<_WxVMEventConstructor>();

  final wxVMEventGetSizePtr = dylib.lookup <NativeFunction<_WxVMEventGetSizeNative>>('wxVMEventGetSize');
  _wxVMEventGetSize = wxVMEventGetSizePtr.asFunction<_WxVMEventGetSize>();

  final wxVMEventSetSizePtr = dylib.lookup <NativeFunction<_WxVMEventSetSizeNative>>('wxVMEventSetSize');
  _wxVMEventSetSize = wxVMEventSetSizePtr.asFunction<_WxVMEventSetSize>();

  final wxInstallDartVMEventCallbackPtr = dylib.lookup <NativeFunction<_WxInstallDartVMEventCallbackNative>>('wxInstallDartVMEventCallback');
  _wxInstallDartVMEventCallback = wxInstallDartVMEventCallbackPtr.asFunction<_WxInstallDartVMEventCallback>();

  wxVMEventNativeCallable = NativeCallable<WxVMEventCallbackNative>.isolateLocal( wxVMEventCallback );
  _wxInstallDartVMEventCallback( wxVMEventNativeCallable.nativeFunction );

  // ------------------------- wxShowEvent ----------------------

  final wxShowEventConstructorPtr = dylib.lookup <NativeFunction<_WxShowEventConstructorNative>>('wxShowEventConstructor');
  _wxShowEventConstructor = wxShowEventConstructorPtr.asFunction<_WxShowEventConstructor>();

  final wxShowEventIsShownPtr = dylib.lookup <NativeFunction<_WxShowEventIsShownNative>>('wxShowEventIsShown');
  _wxShowEventIsShown = wxShowEventIsShownPtr.asFunction<_WxShowEventIsShown>();

  final wxShowEventSetShowPtr = dylib.lookup <NativeFunction<_WxShowEventSetShowNative>>('wxShowEventSetShow');
  _wxShowEventSetShow = wxShowEventSetShowPtr.asFunction<_WxShowEventSetShow>();

  final wxInstallDartShowEventCallbackPtr = dylib.lookup <NativeFunction<_WxInstallDartShowEventCallbackNative>>('wxInstallDartShowEventCallback');
  _wxInstallDartShowEventCallback = wxInstallDartShowEventCallbackPtr.asFunction<_WxInstallDartShowEventCallback>();

  wxShowEventNativeCallable = NativeCallable<WxShowEventCallbackNative>.isolateLocal( wxShowEventCallback );
  _wxInstallDartShowEventCallback( wxShowEventNativeCallable.nativeFunction );

  // ------------------------- wxWindowCreateEvent ----------------------

  final wxWindowCreateEventConstructorPtr = dylib.lookup <NativeFunction<_WxWindowCreateEventConstructorNative>>('wxWindowCreateEventConstructor');
  _wxWindowCreateEventConstructor = wxWindowCreateEventConstructorPtr.asFunction<_WxWindowCreateEventConstructor>();

  final wxWindowCreateEventGetWindowPtr = dylib.lookup <NativeFunction<_WxWindowCreateEventGetWindowNative>>('wxWindowCreateEventGetWindow');
  _wxWindowCreateEventGetWindow = wxWindowCreateEventGetWindowPtr.asFunction<_WxWindowCreateEventGetWindow>();

  final wxInstallDartWindowCreateEventCallbackPtr = dylib.lookup <NativeFunction<_WxInstallDartWindowCreateEventCallbackNative>>('wxInstallDartWindowCreateEventCallback');
  _wxInstallDartWindowCreateEventCallback = wxInstallDartWindowCreateEventCallbackPtr.asFunction<_WxInstallDartWindowCreateEventCallback>();

  wxWindowCreateEventNativeCallable = NativeCallable<WxWindowCreateEventCallbackNative>.isolateLocal( wxWindowCreateEventCallback );
  _wxInstallDartWindowCreateEventCallback( wxWindowCreateEventNativeCallable.nativeFunction );

  // ------------------------- wxActivateEvent ----------------------

  final wxActivateEventConstructorPtr = dylib.lookup <NativeFunction<_WxActivateEventConstructorNative>>('wxActivateEventConstructor');
  _wxActivateEventConstructor = wxActivateEventConstructorPtr.asFunction<_WxActivateEventConstructor>();

  final wxActivateEventGetActivePtr = dylib.lookup <NativeFunction<_WxActivateEventGetActiveNative>>('wxActivateEventGetActive');
  _wxActivateEventGetActive = wxActivateEventGetActivePtr.asFunction<_WxActivateEventGetActive>();

  final wxActivateEventGetActivationReasonPtr = dylib.lookup <NativeFunction<_WxActivateEventGetActivationReasonNative>>('wxActivateEventGetActivationReason');
  _wxActivateEventGetActivationReason = wxActivateEventGetActivationReasonPtr.asFunction<_WxActivateEventGetActivationReason>();

  final wxInstallDartActivateEventCallbackPtr = dylib.lookup <NativeFunction<_WxInstallDartActivateEventCallbackNative>>('wxInstallDartActivateEventCallback');
  _wxInstallDartActivateEventCallback = wxInstallDartActivateEventCallbackPtr.asFunction<_WxInstallDartActivateEventCallback>();

  wxActivateEventNativeCallable = NativeCallable<WxActivateEventCallbackNative>.isolateLocal( wxActivateEventCallback );
  _wxInstallDartActivateEventCallback( wxActivateEventNativeCallable.nativeFunction );

  // ------------------------- wxIdleEvent ----------------------

  final wxIdleEventConstructorPtr = dylib.lookup <NativeFunction<_WxIdleEventConstructorNative>>('wxIdleEventConstructor');
  _wxIdleEventConstructor = wxIdleEventConstructorPtr.asFunction<_WxIdleEventConstructor>();

  final wxIdleEventMoreRequestedPtr = dylib.lookup <NativeFunction<_WxIdleEventMoreRequestedNative>>('wxIdleEventMoreRequested');
  _wxIdleEventMoreRequested = wxIdleEventMoreRequestedPtr.asFunction<_WxIdleEventMoreRequested>();

  final wxIdleEventRequestMorePtr = dylib.lookup <NativeFunction<_WxIdleEventRequestMoreNative>>('wxIdleEventRequestMore');
  _wxIdleEventRequestMore = wxIdleEventRequestMorePtr.asFunction<_WxIdleEventRequestMore>();

  final wxInstallDartIdleEventCallbackPtr = dylib.lookup <NativeFunction<_WxInstallDartIdleEventCallbackNative>>('wxInstallDartIdleEventCallback');
  _wxInstallDartIdleEventCallback = wxInstallDartIdleEventCallbackPtr.asFunction<_WxInstallDartIdleEventCallback>();

  wxIdleEventNativeCallable = NativeCallable<WxIdleEventCallbackNative>.isolateLocal( wxIdleEventCallback );
  _wxInstallDartIdleEventCallback( wxIdleEventNativeCallable.nativeFunction );

  // ------------------------- wxSysColourChangedEvent ----------------------

  final wxSysColourChangedEventConstructorPtr = dylib.lookup <NativeFunction<_WxSysColourChangedEventConstructorNative>>('wxSysColourChangedEventConstructor');
  _wxSysColourChangedEventConstructor = wxSysColourChangedEventConstructorPtr.asFunction<_WxSysColourChangedEventConstructor>();

  final wxInstallDartSysColourChangedEventCallbackPtr = dylib.lookup <NativeFunction<_WxInstallDartSysColourChangedEventCallbackNative>>('wxInstallDartSysColourChangedEventCallback');
  _wxInstallDartSysColourChangedEventCallback = wxInstallDartSysColourChangedEventCallbackPtr.asFunction<_WxInstallDartSysColourChangedEventCallback>();

  wxSysColourChangedEventNativeCallable = NativeCallable<WxSysColourChangedEventCallbackNative>.isolateLocal( wxSysColourChangedEventCallback );
  _wxInstallDartSysColourChangedEventCallback( wxSysColourChangedEventNativeCallable.nativeFunction );

  // ------------------------- wxDPIChangedEvent ----------------------

  final wxDPIChangedEventConstructorPtr = dylib.lookup <NativeFunction<_WxDPIChangedEventConstructorNative>>('wxDPIChangedEventConstructor');
  _wxDPIChangedEventConstructor = wxDPIChangedEventConstructorPtr.asFunction<_WxDPIChangedEventConstructor>();

  final wxDPIChangedEventGetOldDPIPtr = dylib.lookup <NativeFunction<_WxDPIChangedEventGetOldDPINative>>('wxDPIChangedEventGetOldDPI');
  _wxDPIChangedEventGetOldDPI = wxDPIChangedEventGetOldDPIPtr.asFunction<_WxDPIChangedEventGetOldDPI>();

  final wxDPIChangedEventGetNewDPIPtr = dylib.lookup <NativeFunction<_WxDPIChangedEventGetNewDPINative>>('wxDPIChangedEventGetNewDPI');
  _wxDPIChangedEventGetNewDPI = wxDPIChangedEventGetNewDPIPtr.asFunction<_WxDPIChangedEventGetNewDPI>();

  final wxInstallDartDPIChangedEventCallbackPtr = dylib.lookup <NativeFunction<_WxInstallDartDPIChangedEventCallbackNative>>('wxInstallDartDPIChangedEventCallback');
  _wxInstallDartDPIChangedEventCallback = wxInstallDartDPIChangedEventCallbackPtr.asFunction<_WxInstallDartDPIChangedEventCallback>();

  wxDPIChangedEventNativeCallable = NativeCallable<WxDPIChangedEventCallbackNative>.isolateLocal( wxDPIChangedEventCallback );
  _wxInstallDartDPIChangedEventCallback( wxDPIChangedEventNativeCallable.nativeFunction );

  // ------------------------- wxUpdateUIEvent ----------------------

  final wxUpdateUIEventConstructorPtr = dylib.lookup <NativeFunction<_WxUpdateUIEventConstructorNative>>('wxUpdateUIEventConstructor');
  _wxUpdateUIEventConstructor = wxUpdateUIEventConstructorPtr.asFunction<_WxUpdateUIEventConstructor>();

  final wxUpdateUIEventGetCheckedPtr = dylib.lookup <NativeFunction<_WxUpdateUIEventGetCheckedNative>>('wxUpdateUIEventGetChecked');
  _wxUpdateUIEventGetChecked = wxUpdateUIEventGetCheckedPtr.asFunction<_WxUpdateUIEventGetChecked>();

  final wxUpdateUIEventGetEnabledPtr = dylib.lookup <NativeFunction<_WxUpdateUIEventGetEnabledNative>>('wxUpdateUIEventGetEnabled');
  _wxUpdateUIEventGetEnabled = wxUpdateUIEventGetEnabledPtr.asFunction<_WxUpdateUIEventGetEnabled>();

  final wxUpdateUIEventIsCheckablePtr = dylib.lookup <NativeFunction<_WxUpdateUIEventIsCheckableNative>>('wxUpdateUIEventIsCheckable');
  _wxUpdateUIEventIsCheckable = wxUpdateUIEventIsCheckablePtr.asFunction<_WxUpdateUIEventIsCheckable>();

  final wxUpdateUIEventIs3StatePtr = dylib.lookup <NativeFunction<_WxUpdateUIEventIs3StateNative>>('wxUpdateUIEventIs3State');
  _wxUpdateUIEventIs3State = wxUpdateUIEventIs3StatePtr.asFunction<_WxUpdateUIEventIs3State>();

  final wxUpdateUIEventGetTextPtr = dylib.lookup <NativeFunction<_WxUpdateUIEventGetTextNative>>('wxUpdateUIEventGetText');
  _wxUpdateUIEventGetText = wxUpdateUIEventGetTextPtr.asFunction<_WxUpdateUIEventGetText>();

  final wxUpdateUIEventGetSetCheckedPtr = dylib.lookup <NativeFunction<_WxUpdateUIEventGetSetCheckedNative>>('wxUpdateUIEventGetSetChecked');
  _wxUpdateUIEventGetSetChecked = wxUpdateUIEventGetSetCheckedPtr.asFunction<_WxUpdateUIEventGetSetChecked>();

  final wxUpdateUIEventGetSetEnabledPtr = dylib.lookup <NativeFunction<_WxUpdateUIEventGetSetEnabledNative>>('wxUpdateUIEventGetSetEnabled');
  _wxUpdateUIEventGetSetEnabled = wxUpdateUIEventGetSetEnabledPtr.asFunction<_WxUpdateUIEventGetSetEnabled>();

  final wxUpdateUIEventGetSetShownPtr = dylib.lookup <NativeFunction<_WxUpdateUIEventGetSetShownNative>>('wxUpdateUIEventGetSetShown');
  _wxUpdateUIEventGetSetShown = wxUpdateUIEventGetSetShownPtr.asFunction<_WxUpdateUIEventGetSetShown>();

  final wxUpdateUIEventGetSetTextPtr = dylib.lookup <NativeFunction<_WxUpdateUIEventGetSetTextNative>>('wxUpdateUIEventGetSetText');
  _wxUpdateUIEventGetSetText = wxUpdateUIEventGetSetTextPtr.asFunction<_WxUpdateUIEventGetSetText>();

  final wxUpdateUIEventGetShownPtr = dylib.lookup <NativeFunction<_WxUpdateUIEventGetShownNative>>('wxUpdateUIEventGetShown');
  _wxUpdateUIEventGetShown = wxUpdateUIEventGetShownPtr.asFunction<_WxUpdateUIEventGetShown>();

  final wxUpdateUIEventGet3StateValuePtr = dylib.lookup <NativeFunction<_WxUpdateUIEventGet3StateValueNative>>('wxUpdateUIEventGet3StateValue');
  _wxUpdateUIEventGet3StateValue = wxUpdateUIEventGet3StateValuePtr.asFunction<_WxUpdateUIEventGet3StateValue>();

  final wxUpdateUIEventEnablePtr = dylib.lookup <NativeFunction<_WxUpdateUIEventEnableNative>>('wxUpdateUIEventEnable');
  _wxUpdateUIEventEnable = wxUpdateUIEventEnablePtr.asFunction<_WxUpdateUIEventEnable>();

  final wxUpdateUIEventCheckPtr = dylib.lookup <NativeFunction<_WxUpdateUIEventCheckNative>>('wxUpdateUIEventCheck');
  _wxUpdateUIEventCheck = wxUpdateUIEventCheckPtr.asFunction<_WxUpdateUIEventCheck>();

  final wxUpdateUIEventShowPtr = dylib.lookup <NativeFunction<_WxUpdateUIEventShowNative>>('wxUpdateUIEventShow');
  _wxUpdateUIEventShow = wxUpdateUIEventShowPtr.asFunction<_WxUpdateUIEventShow>();

  final wxUpdateUIEventSetTextPtr = dylib.lookup <NativeFunction<_WxUpdateUIEventSetTextNative>>('wxUpdateUIEventSetText');
  _wxUpdateUIEventSetText = wxUpdateUIEventSetTextPtr.asFunction<_WxUpdateUIEventSetText>();

  final wxUpdateUIEventSet3StateValuePtr = dylib.lookup <NativeFunction<_WxUpdateUIEventSet3StateValueNative>>('wxUpdateUIEventSet3StateValue');
  _wxUpdateUIEventSet3StateValue = wxUpdateUIEventSet3StateValuePtr.asFunction<_WxUpdateUIEventSet3StateValue>();

  final wxInstallDartUpdateUIEventCallbackPtr = dylib.lookup <NativeFunction<_WxInstallDartUpdateUIEventCallbackNative>>('wxInstallDartUpdateUIEventCallback');
  _wxInstallDartUpdateUIEventCallback = wxInstallDartUpdateUIEventCallbackPtr.asFunction<_WxInstallDartUpdateUIEventCallback>();

  wxUpdateUIEventNativeCallable = NativeCallable<WxUpdateUIEventCallbackNative>.isolateLocal( wxUpdateUIEventCallback );
  _wxInstallDartUpdateUIEventCallback( wxUpdateUIEventNativeCallable.nativeFunction );

  // ------------------------- wxTimerEvent ----------------------

  final wxTimerEventGetIntervalPtr = dylib.lookup <NativeFunction<_WxTimerEventGetIntervalNative>>('wxTimerEventGetInterval');
  _wxTimerEventGetInterval = wxTimerEventGetIntervalPtr.asFunction<_WxTimerEventGetInterval>();

  final wxInstallDartTimerEventCallbackPtr = dylib.lookup <NativeFunction<_WxInstallDartTimerEventCallbackNative>>('wxInstallDartTimerEventCallback');
  _wxInstallDartTimerEventCallback = wxInstallDartTimerEventCallbackPtr.asFunction<_WxInstallDartTimerEventCallback>();

  wxTimerEventNativeCallable = NativeCallable<WxTimerEventCallbackNative>.isolateLocal( wxTimerEventCallback );
  _wxInstallDartTimerEventCallback( wxTimerEventNativeCallable.nativeFunction );

  // ------------------------- wxFocusEvent ----------------------

  final wxFocusEventConstructorPtr = dylib.lookup <NativeFunction<_WxFocusEventConstructorNative>>('wxFocusEventConstructor');
  _wxFocusEventConstructor = wxFocusEventConstructorPtr.asFunction<_WxFocusEventConstructor>();

  final wxFocusEventGetWindowPtr = dylib.lookup <NativeFunction<_WxFocusEventGetWindowNative>>('wxFocusEventGetWindow');
  _wxFocusEventGetWindow = wxFocusEventGetWindowPtr.asFunction<_WxFocusEventGetWindow>();

  final wxFocusEventSetWindowPtr = dylib.lookup <NativeFunction<_WxFocusEventSetWindowNative>>('wxFocusEventSetWindow');
  _wxFocusEventSetWindow = wxFocusEventSetWindowPtr.asFunction<_WxFocusEventSetWindow>();

  final wxInstallDartFocusEventCallbackPtr = dylib.lookup <NativeFunction<_WxInstallDartFocusEventCallbackNative>>('wxInstallDartFocusEventCallback');
  _wxInstallDartFocusEventCallback = wxInstallDartFocusEventCallbackPtr.asFunction<_WxInstallDartFocusEventCallback>();

  wxFocusEventNativeCallable = NativeCallable<WxFocusEventCallbackNative>.isolateLocal( wxFocusEventCallback );
  _wxInstallDartFocusEventCallback( wxFocusEventNativeCallable.nativeFunction );

  // ------------------------- wxMoveEvent ----------------------

  final wxMoveEventConstructorPtr = dylib.lookup <NativeFunction<_WxMoveEventConstructorNative>>('wxMoveEventConstructor');
  _wxMoveEventConstructor = wxMoveEventConstructorPtr.asFunction<_WxMoveEventConstructor>();

  final wxMoveEventGetPositionPtr = dylib.lookup <NativeFunction<_WxMoveEventGetPositionNative>>('wxMoveEventGetPosition');
  _wxMoveEventGetPosition = wxMoveEventGetPositionPtr.asFunction<_WxMoveEventGetPosition>();

  final wxMoveEventSetPositionPtr = dylib.lookup <NativeFunction<_WxMoveEventSetPositionNative>>('wxMoveEventSetPosition');
  _wxMoveEventSetPosition = wxMoveEventSetPositionPtr.asFunction<_WxMoveEventSetPosition>();

  final wxMoveEventGetRectPtr = dylib.lookup <NativeFunction<_WxMoveEventGetRectNative>>('wxMoveEventGetRect');
  _wxMoveEventGetRect = wxMoveEventGetRectPtr.asFunction<_WxMoveEventGetRect>();

  final wxMoveEventSetRectPtr = dylib.lookup <NativeFunction<_WxMoveEventSetRectNative>>('wxMoveEventSetRect');
  _wxMoveEventSetRect = wxMoveEventSetRectPtr.asFunction<_WxMoveEventSetRect>();

  final wxInstallDartMoveEventCallbackPtr = dylib.lookup <NativeFunction<_WxInstallDartMoveEventCallbackNative>>('wxInstallDartMoveEventCallback');
  _wxInstallDartMoveEventCallback = wxInstallDartMoveEventCallbackPtr.asFunction<_WxInstallDartMoveEventCallback>();

  wxMoveEventNativeCallable = NativeCallable<WxMoveEventCallbackNative>.isolateLocal( wxMoveEventCallback );
  _wxInstallDartMoveEventCallback( wxMoveEventNativeCallable.nativeFunction );

  // ------------------------- wxCloseEvent ----------------------

  final wxCloseEventConstructorPtr = dylib.lookup <NativeFunction<_WxCloseEventConstructorNative>>('wxCloseEventConstructor');
  _wxCloseEventConstructor = wxCloseEventConstructorPtr.asFunction<_WxCloseEventConstructor>();

  final wxCloseEventCanVetoPtr = dylib.lookup <NativeFunction<_WxCloseEventCanVetoNative>>('wxCloseEventCanVeto');
  _wxCloseEventCanVeto = wxCloseEventCanVetoPtr.asFunction<_WxCloseEventCanVeto>();

  final wxCloseEventGetLoggingOffPtr = dylib.lookup <NativeFunction<_WxCloseEventGetLoggingOffNative>>('wxCloseEventGetLoggingOff');
  _wxCloseEventGetLoggingOff = wxCloseEventGetLoggingOffPtr.asFunction<_WxCloseEventGetLoggingOff>();

  final wxCloseEventGetVetoPtr = dylib.lookup <NativeFunction<_WxCloseEventGetVetoNative>>('wxCloseEventGetVeto');
  _wxCloseEventGetVeto = wxCloseEventGetVetoPtr.asFunction<_WxCloseEventGetVeto>();

  final wxCloseEventVetoPtr = dylib.lookup <NativeFunction<_WxCloseEventVetoNative>>('wxCloseEventVeto');
  _wxCloseEventVeto = wxCloseEventVetoPtr.asFunction<_WxCloseEventVeto>();

  final wxInstallDartCloseEventCallbackPtr = dylib.lookup <NativeFunction<_WxInstallDartCloseEventCallbackNative>>('wxInstallDartCloseEventCallback');
  _wxInstallDartCloseEventCallback = wxInstallDartCloseEventCallbackPtr.asFunction<_WxInstallDartCloseEventCallback>();

  wxCloseEventNativeCallable = NativeCallable<WxCloseEventCallbackNative>.isolateLocal( wxCloseEventCallback );
  _wxInstallDartCloseEventCallback( wxCloseEventNativeCallable.nativeFunction );

  // ------------------------- wxKeyEvent ----------------------

  final wxKeyEventConstructorPtr = dylib.lookup <NativeFunction<_WxKeyEventConstructorNative>>('wxKeyEventConstructor');
  _wxKeyEventConstructor = wxKeyEventConstructorPtr.asFunction<_WxKeyEventConstructor>();

  final wxKeyEventGetKeyCodePtr = dylib.lookup <NativeFunction<_WxKeyEventGetKeyCodeNative>>('wxKeyEventGetKeyCode');
  _wxKeyEventGetKeyCode = wxKeyEventGetKeyCodePtr.asFunction<_WxKeyEventGetKeyCode>();

  final wxKeyEventGetUnicodeKeyPtr = dylib.lookup <NativeFunction<_WxKeyEventGetUnicodeKeyNative>>('wxKeyEventGetUnicodeKey');
  _wxKeyEventGetUnicodeKey = wxKeyEventGetUnicodeKeyPtr.asFunction<_WxKeyEventGetUnicodeKey>();

  final wxKeyEventControlDownPtr = dylib.lookup <NativeFunction<_WxKeyEventControlDownNative>>('wxKeyEventControlDown');
  _wxKeyEventControlDown = wxKeyEventControlDownPtr.asFunction<_WxKeyEventControlDown>();

  final wxKeyEventMetaDownPtr = dylib.lookup <NativeFunction<_WxKeyEventMetaDownNative>>('wxKeyEventMetaDown');
  _wxKeyEventMetaDown = wxKeyEventMetaDownPtr.asFunction<_WxKeyEventMetaDown>();

  final wxKeyEventShiftDownPtr = dylib.lookup <NativeFunction<_WxKeyEventShiftDownNative>>('wxKeyEventShiftDown');
  _wxKeyEventShiftDown = wxKeyEventShiftDownPtr.asFunction<_WxKeyEventShiftDown>();

  final wxKeyEventCmdDownPtr = dylib.lookup <NativeFunction<_WxKeyEventCmdDownNative>>('wxKeyEventCmdDown');
  _wxKeyEventCmdDown = wxKeyEventCmdDownPtr.asFunction<_WxKeyEventCmdDown>();

  final wxKeyEventHasModifiersPtr = dylib.lookup <NativeFunction<_WxKeyEventHasModifiersNative>>('wxKeyEventHasModifiers');
  _wxKeyEventHasModifiers = wxKeyEventHasModifiersPtr.asFunction<_WxKeyEventHasModifiers>();

  final wxKeyEventHasAnyModifiersPtr = dylib.lookup <NativeFunction<_WxKeyEventHasAnyModifiersNative>>('wxKeyEventHasAnyModifiers');
  _wxKeyEventHasAnyModifiers = wxKeyEventHasAnyModifiersPtr.asFunction<_WxKeyEventHasAnyModifiers>();

  final wxKeyEventAltDownPtr = dylib.lookup <NativeFunction<_WxKeyEventAltDownNative>>('wxKeyEventAltDown');
  _wxKeyEventAltDown = wxKeyEventAltDownPtr.asFunction<_WxKeyEventAltDown>();

  final wxInstallDartKeyEventCallbackPtr = dylib.lookup <NativeFunction<_WxInstallDartKeyEventCallbackNative>>('wxInstallDartKeyEventCallback');
  _wxInstallDartKeyEventCallback = wxInstallDartKeyEventCallbackPtr.asFunction<_WxInstallDartKeyEventCallback>();

  wxKeyEventNativeCallable = NativeCallable<WxKeyEventCallbackNative>.isolateLocal( wxKeyEventCallback );
  _wxInstallDartKeyEventCallback( wxKeyEventNativeCallable.nativeFunction );

  // ------------------------- wxMouseEvent ----------------------

  final wxMouseEventConstructorPtr = dylib.lookup <NativeFunction<_WxMouseEventConstructorNative>>('wxMouseEventConstructor');
  _wxMouseEventConstructor = wxMouseEventConstructorPtr.asFunction<_WxMouseEventConstructor>();

  final wxMouseEventGetButtonPtr = dylib.lookup <NativeFunction<_WxMouseEventGetButtonNative>>('wxMouseEventGetButton');
  _wxMouseEventGetButton = wxMouseEventGetButtonPtr.asFunction<_WxMouseEventGetButton>();

  final wxMouseEventGetClickCountPtr = dylib.lookup <NativeFunction<_WxMouseEventGetClickCountNative>>('wxMouseEventGetClickCount');
  _wxMouseEventGetClickCount = wxMouseEventGetClickCountPtr.asFunction<_WxMouseEventGetClickCount>();

  final wxMouseEventButtonDownPtr = dylib.lookup <NativeFunction<_WxMouseEventButtonDownNative>>('wxMouseEventButtonDown');
  _wxMouseEventButtonDown = wxMouseEventButtonDownPtr.asFunction<_WxMouseEventButtonDown>();

  final wxMouseEventButtonUpPtr = dylib.lookup <NativeFunction<_WxMouseEventButtonUpNative>>('wxMouseEventButtonUp');
  _wxMouseEventButtonUp = wxMouseEventButtonUpPtr.asFunction<_WxMouseEventButtonUp>();

  final wxMouseEventButtonDClickPtr = dylib.lookup <NativeFunction<_WxMouseEventButtonDClickNative>>('wxMouseEventButtonDClick');
  _wxMouseEventButtonDClick = wxMouseEventButtonDClickPtr.asFunction<_WxMouseEventButtonDClick>();

  final wxMouseEventLeftDownPtr = dylib.lookup <NativeFunction<_WxMouseEventLeftDownNative>>('wxMouseEventLeftDown');
  _wxMouseEventLeftDown = wxMouseEventLeftDownPtr.asFunction<_WxMouseEventLeftDown>();

  final wxMouseEventRightDownPtr = dylib.lookup <NativeFunction<_WxMouseEventRightDownNative>>('wxMouseEventRightDown');
  _wxMouseEventRightDown = wxMouseEventRightDownPtr.asFunction<_WxMouseEventRightDown>();

  final wxMouseEventMiddleDownPtr = dylib.lookup <NativeFunction<_WxMouseEventMiddleDownNative>>('wxMouseEventMiddleDown');
  _wxMouseEventMiddleDown = wxMouseEventMiddleDownPtr.asFunction<_WxMouseEventMiddleDown>();

  final wxMouseEventLeftDClickPtr = dylib.lookup <NativeFunction<_WxMouseEventLeftDClickNative>>('wxMouseEventLeftDClick');
  _wxMouseEventLeftDClick = wxMouseEventLeftDClickPtr.asFunction<_WxMouseEventLeftDClick>();

  final wxMouseEventRightDClickPtr = dylib.lookup <NativeFunction<_WxMouseEventRightDClickNative>>('wxMouseEventRightDClick');
  _wxMouseEventRightDClick = wxMouseEventRightDClickPtr.asFunction<_WxMouseEventRightDClick>();

  final wxMouseEventMiddleDClickPtr = dylib.lookup <NativeFunction<_WxMouseEventMiddleDClickNative>>('wxMouseEventMiddleDClick');
  _wxMouseEventMiddleDClick = wxMouseEventMiddleDClickPtr.asFunction<_WxMouseEventMiddleDClick>();

  final wxMouseEventLeftUpPtr = dylib.lookup <NativeFunction<_WxMouseEventLeftUpNative>>('wxMouseEventLeftUp');
  _wxMouseEventLeftUp = wxMouseEventLeftUpPtr.asFunction<_WxMouseEventLeftUp>();

  final wxMouseEventRightUpPtr = dylib.lookup <NativeFunction<_WxMouseEventRightUpNative>>('wxMouseEventRightUp');
  _wxMouseEventRightUp = wxMouseEventRightUpPtr.asFunction<_WxMouseEventRightUp>();

  final wxMouseEventMiddleUpPtr = dylib.lookup <NativeFunction<_WxMouseEventMiddleUpNative>>('wxMouseEventMiddleUp');
  _wxMouseEventMiddleUp = wxMouseEventMiddleUpPtr.asFunction<_WxMouseEventMiddleUp>();

  final wxMouseEventDraggingPtr = dylib.lookup <NativeFunction<_WxMouseEventDraggingNative>>('wxMouseEventDragging');
  _wxMouseEventDragging = wxMouseEventDraggingPtr.asFunction<_WxMouseEventDragging>();

  final wxMouseEventEnteringPtr = dylib.lookup <NativeFunction<_WxMouseEventEnteringNative>>('wxMouseEventEntering');
  _wxMouseEventEntering = wxMouseEventEnteringPtr.asFunction<_WxMouseEventEntering>();

  final wxMouseEventLeavingPtr = dylib.lookup <NativeFunction<_WxMouseEventLeavingNative>>('wxMouseEventLeaving');
  _wxMouseEventLeaving = wxMouseEventLeavingPtr.asFunction<_WxMouseEventLeaving>();

  final wxMouseEventMovingPtr = dylib.lookup <NativeFunction<_WxMouseEventMovingNative>>('wxMouseEventMoving');
  _wxMouseEventMoving = wxMouseEventMovingPtr.asFunction<_WxMouseEventMoving>();

  final wxMouseEventMagnifyPtr = dylib.lookup <NativeFunction<_WxMouseEventMagnifyNative>>('wxMouseEventMagnify');
  _wxMouseEventMagnify = wxMouseEventMagnifyPtr.asFunction<_WxMouseEventMagnify>();

  final wxMouseEventGetXPtr = dylib.lookup <NativeFunction<_WxMouseEventGetXNative>>('wxMouseEventGetX');
  _wxMouseEventGetX = wxMouseEventGetXPtr.asFunction<_WxMouseEventGetX>();

  final wxMouseEventGetYPtr = dylib.lookup <NativeFunction<_WxMouseEventGetYNative>>('wxMouseEventGetY');
  _wxMouseEventGetY = wxMouseEventGetYPtr.asFunction<_WxMouseEventGetY>();

  final wxMouseEventGetPositionPtr = dylib.lookup <NativeFunction<_WxMouseEventGetPositionNative>>('wxMouseEventGetPosition');
  _wxMouseEventGetPosition = wxMouseEventGetPositionPtr.asFunction<_WxMouseEventGetPosition>();

  final wxMouseEventSetXPtr = dylib.lookup <NativeFunction<_WxMouseEventSetXNative>>('wxMouseEventSetX');
  _wxMouseEventSetX = wxMouseEventSetXPtr.asFunction<_WxMouseEventSetX>();

  final wxMouseEventSetYPtr = dylib.lookup <NativeFunction<_WxMouseEventSetYNative>>('wxMouseEventSetY');
  _wxMouseEventSetY = wxMouseEventSetYPtr.asFunction<_WxMouseEventSetY>();

  final wxMouseEventSetPositionPtr = dylib.lookup <NativeFunction<_WxMouseEventSetPositionNative>>('wxMouseEventSetPosition');
  _wxMouseEventSetPosition = wxMouseEventSetPositionPtr.asFunction<_WxMouseEventSetPosition>();

  final wxMouseEventGetWheelAxisPtr = dylib.lookup <NativeFunction<_WxMouseEventGetWheelAxisNative>>('wxMouseEventGetWheelAxis');
  _wxMouseEventGetWheelAxis = wxMouseEventGetWheelAxisPtr.asFunction<_WxMouseEventGetWheelAxis>();

  final wxMouseEventGetWheelDeltaPtr = dylib.lookup <NativeFunction<_WxMouseEventGetWheelDeltaNative>>('wxMouseEventGetWheelDelta');
  _wxMouseEventGetWheelDelta = wxMouseEventGetWheelDeltaPtr.asFunction<_WxMouseEventGetWheelDelta>();

  final wxMouseEventGetWheelRotationPtr = dylib.lookup <NativeFunction<_WxMouseEventGetWheelRotationNative>>('wxMouseEventGetWheelRotation');
  _wxMouseEventGetWheelRotation = wxMouseEventGetWheelRotationPtr.asFunction<_WxMouseEventGetWheelRotation>();

  final wxMouseEventIsWheelInvertedPtr = dylib.lookup <NativeFunction<_WxMouseEventIsWheelInvertedNative>>('wxMouseEventIsWheelInverted');
  _wxMouseEventIsWheelInverted = wxMouseEventIsWheelInvertedPtr.asFunction<_WxMouseEventIsWheelInverted>();

  final wxMouseEventLeftIsDownPtr = dylib.lookup <NativeFunction<_WxMouseEventLeftIsDownNative>>('wxMouseEventLeftIsDown');
  _wxMouseEventLeftIsDown = wxMouseEventLeftIsDownPtr.asFunction<_WxMouseEventLeftIsDown>();

  final wxMouseEventRightIsDownPtr = dylib.lookup <NativeFunction<_WxMouseEventRightIsDownNative>>('wxMouseEventRightIsDown');
  _wxMouseEventRightIsDown = wxMouseEventRightIsDownPtr.asFunction<_WxMouseEventRightIsDown>();

  final wxMouseEventMiddleIsDownPtr = dylib.lookup <NativeFunction<_WxMouseEventMiddleIsDownNative>>('wxMouseEventMiddleIsDown');
  _wxMouseEventMiddleIsDown = wxMouseEventMiddleIsDownPtr.asFunction<_WxMouseEventMiddleIsDown>();

  final wxMouseEventSetLeftDownPtr = dylib.lookup <NativeFunction<_WxMouseEventSetLeftDownNative>>('wxMouseEventSetLeftDown');
  _wxMouseEventSetLeftDown = wxMouseEventSetLeftDownPtr.asFunction<_WxMouseEventSetLeftDown>();

  final wxMouseEventSetRightDownPtr = dylib.lookup <NativeFunction<_WxMouseEventSetRightDownNative>>('wxMouseEventSetRightDown');
  _wxMouseEventSetRightDown = wxMouseEventSetRightDownPtr.asFunction<_WxMouseEventSetRightDown>();

  final wxMouseEventSetMiddleDownPtr = dylib.lookup <NativeFunction<_WxMouseEventSetMiddleDownNative>>('wxMouseEventSetMiddleDown');
  _wxMouseEventSetMiddleDown = wxMouseEventSetMiddleDownPtr.asFunction<_WxMouseEventSetMiddleDown>();

  final wxMouseEventControlDownPtr = dylib.lookup <NativeFunction<_WxMouseEventControlDownNative>>('wxMouseEventControlDown');
  _wxMouseEventControlDown = wxMouseEventControlDownPtr.asFunction<_WxMouseEventControlDown>();

  final wxMouseEventMetaDownPtr = dylib.lookup <NativeFunction<_WxMouseEventMetaDownNative>>('wxMouseEventMetaDown');
  _wxMouseEventMetaDown = wxMouseEventMetaDownPtr.asFunction<_WxMouseEventMetaDown>();

  final wxMouseEventShiftDownPtr = dylib.lookup <NativeFunction<_WxMouseEventShiftDownNative>>('wxMouseEventShiftDown');
  _wxMouseEventShiftDown = wxMouseEventShiftDownPtr.asFunction<_WxMouseEventShiftDown>();

  final wxMouseEventCmdDownPtr = dylib.lookup <NativeFunction<_WxMouseEventCmdDownNative>>('wxMouseEventCmdDown');
  _wxMouseEventCmdDown = wxMouseEventCmdDownPtr.asFunction<_WxMouseEventCmdDown>();

  final wxMouseEventAltDownPtr = dylib.lookup <NativeFunction<_WxMouseEventAltDownNative>>('wxMouseEventAltDown');
  _wxMouseEventAltDown = wxMouseEventAltDownPtr.asFunction<_WxMouseEventAltDown>();

  final wxMouseEventHasModifiersPtr = dylib.lookup <NativeFunction<_WxMouseEventHasModifiersNative>>('wxMouseEventHasModifiers');
  _wxMouseEventHasModifiers = wxMouseEventHasModifiersPtr.asFunction<_WxMouseEventHasModifiers>();

  final wxMouseEventHasAnyModifiersPtr = dylib.lookup <NativeFunction<_WxMouseEventHasAnyModifiersNative>>('wxMouseEventHasAnyModifiers');
  _wxMouseEventHasAnyModifiers = wxMouseEventHasAnyModifiersPtr.asFunction<_WxMouseEventHasAnyModifiers>();

  final wxInstallDartMouseEventCallbackPtr = dylib.lookup <NativeFunction<_WxInstallDartMouseEventCallbackNative>>('wxInstallDartMouseEventCallback');
  _wxInstallDartMouseEventCallback = wxInstallDartMouseEventCallbackPtr.asFunction<_WxInstallDartMouseEventCallback>();

  wxMouseEventNativeCallable = NativeCallable<WxMouseEventCallbackNative>.isolateLocal( wxMouseEventCallback );
  _wxInstallDartMouseEventCallback( wxMouseEventNativeCallable.nativeFunction );

  // ------------------------- wxPaintEvent ----------------------

  final wxInstallDartPaintEventCallbackPtr = dylib.lookup <NativeFunction<_WxInstallDartPaintEventCallbackNative>>('wxInstallDartPaintEventCallback');
  _wxInstallDartPaintEventCallback = wxInstallDartPaintEventCallbackPtr.asFunction<_WxInstallDartPaintEventCallback>();

  wxPaintEventNativeCallable = NativeCallable<WxPaintEventCallbackNative>.isolateLocal( wxPaintEventCallback );
  _wxInstallDartPaintEventCallback( wxPaintEventNativeCallable.nativeFunction );

  // ------------------------- wxCommandEvent ----------------------

  final wxCommandEventConstructorPtr = dylib.lookup <NativeFunction<_WxCommandEventConstructorNative>>('wxCommandEventConstructor');
  _wxCommandEventConstructor = wxCommandEventConstructorPtr.asFunction<_WxCommandEventConstructor>();

  final wxCommandEventGetIntPtr = dylib.lookup <NativeFunction<_WxCommandEventGetIntNative>>('wxCommandEventGetInt');
  _wxCommandEventGetInt = wxCommandEventGetIntPtr.asFunction<_WxCommandEventGetInt>();

  final wxCommandEventSetIntPtr = dylib.lookup <NativeFunction<_WxCommandEventSetIntNative>>('wxCommandEventSetInt');
  _wxCommandEventSetInt = wxCommandEventSetIntPtr.asFunction<_WxCommandEventSetInt>();

  final wxCommandEventGetExtraLongPtr = dylib.lookup <NativeFunction<_WxCommandEventGetExtraLongNative>>('wxCommandEventGetExtraLong');
  _wxCommandEventGetExtraLong = wxCommandEventGetExtraLongPtr.asFunction<_WxCommandEventGetExtraLong>();

  final wxCommandEventSetExtraLongPtr = dylib.lookup <NativeFunction<_WxCommandEventSetExtraLongNative>>('wxCommandEventSetExtraLong');
  _wxCommandEventSetExtraLong = wxCommandEventSetExtraLongPtr.asFunction<_WxCommandEventSetExtraLong>();

  final wxCommandEventGetSelectionPtr = dylib.lookup <NativeFunction<_WxCommandEventGetSelectionNative>>('wxCommandEventGetSelection');
  _wxCommandEventGetSelection = wxCommandEventGetSelectionPtr.asFunction<_WxCommandEventGetSelection>();

  final wxCommandEventIsCheckedPtr = dylib.lookup <NativeFunction<_WxCommandEventIsCheckedNative>>('wxCommandEventIsChecked');
  _wxCommandEventIsChecked = wxCommandEventIsCheckedPtr.asFunction<_WxCommandEventIsChecked>();

  final wxCommandEventIsSelectionPtr = dylib.lookup <NativeFunction<_WxCommandEventIsSelectionNative>>('wxCommandEventIsSelection');
  _wxCommandEventIsSelection = wxCommandEventIsSelectionPtr.asFunction<_WxCommandEventIsSelection>();

  final wxCommandEventGetStringPtr = dylib.lookup <NativeFunction<_WxCommandEventGetStringNative>>('wxCommandEventGetString');
  _wxCommandEventGetString = wxCommandEventGetStringPtr.asFunction<_WxCommandEventGetString>();

  final wxCommandEventSetStringPtr = dylib.lookup <NativeFunction<_WxCommandEventSetStringNative>>('wxCommandEventSetString');
  _wxCommandEventSetString = wxCommandEventSetStringPtr.asFunction<_WxCommandEventSetString>();

  final wxCommandEventSetClientDataPtr = dylib.lookup <NativeFunction<_WxCommandEventSetClientDataNative>>('wxCommandEventSetClientData');
  _wxCommandEventSetClientData = wxCommandEventSetClientDataPtr.asFunction<_WxCommandEventSetClientData>();

  final wxCommandEventGetClientDataPtr = dylib.lookup <NativeFunction<_WxCommandEventGetClientDataNative>>('wxCommandEventGetClientData');
  _wxCommandEventGetClientData = wxCommandEventGetClientDataPtr.asFunction<_WxCommandEventGetClientData>();

  final wxInstallDartCommandEventCallbackPtr = dylib.lookup <NativeFunction<_WxInstallDartCommandEventCallbackNative>>('wxInstallDartCommandEventCallback');
  _wxInstallDartCommandEventCallback = wxInstallDartCommandEventCallbackPtr.asFunction<_WxInstallDartCommandEventCallback>();

  wxCommandEventNativeCallable = NativeCallable<WxCommandEventCallbackNative>.isolateLocal( wxCommandEventCallback );
  _wxInstallDartCommandEventCallback( wxCommandEventNativeCallable.nativeFunction );

  // ------------------------- wxNotifyEvent ----------------------

  final wxNotifyEventConstructorPtr = dylib.lookup <NativeFunction<_WxNotifyEventConstructorNative>>('wxNotifyEventConstructor');
  _wxNotifyEventConstructor = wxNotifyEventConstructorPtr.asFunction<_WxNotifyEventConstructor>();

  final wxNotifyEventAllowPtr = dylib.lookup <NativeFunction<_WxNotifyEventAllowNative>>('wxNotifyEventAllow');
  _wxNotifyEventAllow = wxNotifyEventAllowPtr.asFunction<_WxNotifyEventAllow>();

  final wxNotifyEventVetoPtr = dylib.lookup <NativeFunction<_WxNotifyEventVetoNative>>('wxNotifyEventVeto');
  _wxNotifyEventVeto = wxNotifyEventVetoPtr.asFunction<_WxNotifyEventVeto>();

  final wxNotifyEventIsAllowedPtr = dylib.lookup <NativeFunction<_WxNotifyEventIsAllowedNative>>('wxNotifyEventIsAllowed');
  _wxNotifyEventIsAllowed = wxNotifyEventIsAllowedPtr.asFunction<_WxNotifyEventIsAllowed>();

  final wxInstallDartNotifyEventCallbackPtr = dylib.lookup <NativeFunction<_WxInstallDartNotifyEventCallbackNative>>('wxInstallDartNotifyEventCallback');
  _wxInstallDartNotifyEventCallback = wxInstallDartNotifyEventCallbackPtr.asFunction<_WxInstallDartNotifyEventCallback>();

  wxNotifyEventNativeCallable = NativeCallable<WxNotifyEventCallbackNative>.isolateLocal( wxNotifyEventCallback );
  _wxInstallDartNotifyEventCallback( wxNotifyEventNativeCallable.nativeFunction );

  // ------------------------- wxInitDialogEvent ----------------------

  final wxInitDialogEventConstructorPtr = dylib.lookup <NativeFunction<_WxInitDialogEventConstructorNative>>('wxInitDialogEventConstructor');
  _wxInitDialogEventConstructor = wxInitDialogEventConstructorPtr.asFunction<_WxInitDialogEventConstructor>();

  final wxInstallDartInitDialogEventCallbackPtr = dylib.lookup <NativeFunction<_WxInstallDartInitDialogEventCallbackNative>>('wxInstallDartInitDialogEventCallback');
  _wxInstallDartInitDialogEventCallback = wxInstallDartInitDialogEventCallbackPtr.asFunction<_WxInstallDartInitDialogEventCallback>();

  wxInitDialogEventNativeCallable = NativeCallable<WxInitDialogEventCallbackNative>.isolateLocal( wxInitDialogEventCallback );
  _wxInstallDartInitDialogEventCallback( wxInitDialogEventNativeCallable.nativeFunction );

  // ------------------------- wxDialogValidateEvent ----------------------

  final wxDialogValidateEventConstructorPtr = dylib.lookup <NativeFunction<_WxDialogValidateEventConstructorNative>>('wxDialogValidateEventConstructor');
  _wxDialogValidateEventConstructor = wxDialogValidateEventConstructorPtr.asFunction<_WxDialogValidateEventConstructor>();

  final wxInstallDartDialogValidateEventCallbackPtr = dylib.lookup <NativeFunction<_WxInstallDartDialogValidateEventCallbackNative>>('wxInstallDartDialogValidateEventCallback');
  _wxInstallDartDialogValidateEventCallback = wxInstallDartDialogValidateEventCallbackPtr.asFunction<_WxInstallDartDialogValidateEventCallback>();

  wxDialogValidateEventNativeCallable = NativeCallable<WxDialogValidateEventCallbackNative>.isolateLocal( wxDialogValidateEventCallback );
  _wxInstallDartDialogValidateEventCallback( wxDialogValidateEventNativeCallable.nativeFunction );

  // ------------------------- wxScrollWinEvent ----------------------

  final wxScrollWinEventConstructorPtr = dylib.lookup <NativeFunction<_WxScrollWinEventConstructorNative>>('wxScrollWinEventConstructor');
  _wxScrollWinEventConstructor = wxScrollWinEventConstructorPtr.asFunction<_WxScrollWinEventConstructor>();

  final wxScrollWinEventGetOrientationPtr = dylib.lookup <NativeFunction<_WxScrollWinEventGetOrientationNative>>('wxScrollWinEventGetOrientation');
  _wxScrollWinEventGetOrientation = wxScrollWinEventGetOrientationPtr.asFunction<_WxScrollWinEventGetOrientation>();

  final wxScrollWinEventSetOrientationPtr = dylib.lookup <NativeFunction<_WxScrollWinEventSetOrientationNative>>('wxScrollWinEventSetOrientation');
  _wxScrollWinEventSetOrientation = wxScrollWinEventSetOrientationPtr.asFunction<_WxScrollWinEventSetOrientation>();

  final wxScrollWinEventGetPositionPtr = dylib.lookup <NativeFunction<_WxScrollWinEventGetPositionNative>>('wxScrollWinEventGetPosition');
  _wxScrollWinEventGetPosition = wxScrollWinEventGetPositionPtr.asFunction<_WxScrollWinEventGetPosition>();

  final wxScrollWinEventSetPositionPtr = dylib.lookup <NativeFunction<_WxScrollWinEventSetPositionNative>>('wxScrollWinEventSetPosition');
  _wxScrollWinEventSetPosition = wxScrollWinEventSetPositionPtr.asFunction<_WxScrollWinEventSetPosition>();

  final wxScrollWinEventGetPixelOffsetPtr = dylib.lookup <NativeFunction<_WxScrollWinEventGetPixelOffsetNative>>('wxScrollWinEventGetPixelOffset');
  _wxScrollWinEventGetPixelOffset = wxScrollWinEventGetPixelOffsetPtr.asFunction<_WxScrollWinEventGetPixelOffset>();

  final wxScrollWinEventSetPixelOffsetPtr = dylib.lookup <NativeFunction<_WxScrollWinEventSetPixelOffsetNative>>('wxScrollWinEventSetPixelOffset');
  _wxScrollWinEventSetPixelOffset = wxScrollWinEventSetPixelOffsetPtr.asFunction<_WxScrollWinEventSetPixelOffset>();

  final wxInstallDartScrollWinEventCallbackPtr = dylib.lookup <NativeFunction<_WxInstallDartScrollWinEventCallbackNative>>('wxInstallDartScrollWinEventCallback');
  _wxInstallDartScrollWinEventCallback = wxInstallDartScrollWinEventCallbackPtr.asFunction<_WxInstallDartScrollWinEventCallback>();

  wxScrollWinEventNativeCallable = NativeCallable<WxScrollWinEventCallbackNative>.isolateLocal( wxScrollWinEventCallback );
  _wxInstallDartScrollWinEventCallback( wxScrollWinEventNativeCallable.nativeFunction );

  // ------------------------- wxDragEvent ----------------------

  final wxDragEventConstructorPtr = dylib.lookup <NativeFunction<_WxDragEventConstructorNative>>('wxDragEventConstructor');
  _wxDragEventConstructor = wxDragEventConstructorPtr.asFunction<_WxDragEventConstructor>();

  final wxDragEventSetFeedbackPtr = dylib.lookup <NativeFunction<_WxDragEventSetFeedbackNative>>('wxDragEventSetFeedback');
  _wxDragEventSetFeedback = wxDragEventSetFeedbackPtr.asFunction<_WxDragEventSetFeedback>();

  final wxInstallDartDragEventCallbackPtr = dylib.lookup <NativeFunction<_WxInstallDartDragEventCallbackNative>>('wxInstallDartDragEventCallback');
  _wxInstallDartDragEventCallback = wxInstallDartDragEventCallbackPtr.asFunction<_WxInstallDartDragEventCallback>();

  wxDragEventNativeCallable = NativeCallable<WxDragEventCallbackNative>.isolateLocal( wxDragEventCallback );
  _wxInstallDartDragEventCallback( wxDragEventNativeCallable.nativeFunction );

  // ------------------------- wxDropEvent ----------------------

  final wxDropEventConstructorPtr = dylib.lookup <NativeFunction<_WxDropEventConstructorNative>>('wxDropEventConstructor');
  _wxDropEventConstructor = wxDropEventConstructorPtr.asFunction<_WxDropEventConstructor>();

  final wxDropEventSetPositionPtr = dylib.lookup <NativeFunction<_WxDropEventSetPositionNative>>('wxDropEventSetPosition');
  _wxDropEventSetPosition = wxDropEventSetPositionPtr.asFunction<_WxDropEventSetPosition>();

  final wxDropEventGetPositionPtr = dylib.lookup <NativeFunction<_WxDropEventGetPositionNative>>('wxDropEventGetPosition');
  _wxDropEventGetPosition = wxDropEventGetPositionPtr.asFunction<_WxDropEventGetPosition>();

  final wxDropEventSetResultPtr = dylib.lookup <NativeFunction<_WxDropEventSetResultNative>>('wxDropEventSetResult');
  _wxDropEventSetResult = wxDropEventSetResultPtr.asFunction<_WxDropEventSetResult>();

  final wxDropEventGetResultPtr = dylib.lookup <NativeFunction<_WxDropEventGetResultNative>>('wxDropEventGetResult');
  _wxDropEventGetResult = wxDropEventGetResultPtr.asFunction<_WxDropEventGetResult>();

  final wxInstallDartDropEventCallbackPtr = dylib.lookup <NativeFunction<_WxInstallDartDropEventCallbackNative>>('wxInstallDartDropEventCallback');
  _wxInstallDartDropEventCallback = wxInstallDartDropEventCallbackPtr.asFunction<_WxInstallDartDropEventCallback>();

  wxDropEventNativeCallable = NativeCallable<WxDropEventCallbackNative>.isolateLocal( wxDropEventCallback );
  _wxInstallDartDropEventCallback( wxDropEventNativeCallable.nativeFunction );

  // ------------------------- EVT_MENU_OPEN ----------------------

  final wxGetMenuOpenEventTypePtr = dylib.lookup <NativeFunction<_WxGetMenuOpenEventTypeNative>>('wxGetMenuOpenEventType');
  wxGetMenuOpenEventType = wxGetMenuOpenEventTypePtr.asFunction<WxGetMenuOpenEventType>();

  final wxEvtHandlerBindMenuOpenEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindMenuOpenEventCallbackNative>>('wxEvtHandlerBindMenuOpenEventCallback');
  wxEvtHandlerBindMenuOpenEventCallback = wxEvtHandlerBindMenuOpenEventCallbackPtr.asFunction<WxEvtHandlerBindMenuOpenEventCallback>();

  final wxEvtHandlerUnbindMenuOpenEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindMenuOpenEventCallbackNative>>('wxEvtHandlerUnbindMenuOpenEventCallback');
  wxEvtHandlerUnbindMenuOpenEventCallback = wxEvtHandlerUnbindMenuOpenEventCallbackPtr.asFunction<WxEvtHandlerUnbindMenuOpenEventCallback>();

  // ------------------------- EVT_MENU_CLOSE ----------------------

  final wxGetMenuCloseEventTypePtr = dylib.lookup <NativeFunction<_WxGetMenuCloseEventTypeNative>>('wxGetMenuCloseEventType');
  wxGetMenuCloseEventType = wxGetMenuCloseEventTypePtr.asFunction<WxGetMenuCloseEventType>();

  final wxEvtHandlerBindMenuCloseEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindMenuCloseEventCallbackNative>>('wxEvtHandlerBindMenuCloseEventCallback');
  wxEvtHandlerBindMenuCloseEventCallback = wxEvtHandlerBindMenuCloseEventCallbackPtr.asFunction<WxEvtHandlerBindMenuCloseEventCallback>();

  final wxEvtHandlerUnbindMenuCloseEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindMenuCloseEventCallbackNative>>('wxEvtHandlerUnbindMenuCloseEventCallback');
  wxEvtHandlerUnbindMenuCloseEventCallback = wxEvtHandlerUnbindMenuCloseEventCallbackPtr.asFunction<WxEvtHandlerUnbindMenuCloseEventCallback>();

  // ------------------------- EVT_MENU_HIGHLIGHT ----------------------

  final wxGetMenuHighlightEventTypePtr = dylib.lookup <NativeFunction<_WxGetMenuHighlightEventTypeNative>>('wxGetMenuHighlightEventType');
  wxGetMenuHighlightEventType = wxGetMenuHighlightEventTypePtr.asFunction<WxGetMenuHighlightEventType>();

  final wxEvtHandlerBindMenuHighlightEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindMenuHighlightEventCallbackNative>>('wxEvtHandlerBindMenuHighlightEventCallback');
  wxEvtHandlerBindMenuHighlightEventCallback = wxEvtHandlerBindMenuHighlightEventCallbackPtr.asFunction<WxEvtHandlerBindMenuHighlightEventCallback>();

  final wxEvtHandlerUnbindMenuHighlightEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindMenuHighlightEventCallbackNative>>('wxEvtHandlerUnbindMenuHighlightEventCallback');
  wxEvtHandlerUnbindMenuHighlightEventCallback = wxEvtHandlerUnbindMenuHighlightEventCallbackPtr.asFunction<WxEvtHandlerUnbindMenuHighlightEventCallback>();

  // ------------------------- EVT_MENU ----------------------

  final wxGetMenuEventTypePtr = dylib.lookup <NativeFunction<_WxGetMenuEventTypeNative>>('wxGetMenuEventType');
  wxGetMenuEventType = wxGetMenuEventTypePtr.asFunction<WxGetMenuEventType>();

  final wxEvtHandlerBindMenuEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindMenuEventCallbackNative>>('wxEvtHandlerBindMenuEventCallback');
  wxEvtHandlerBindMenuEventCallback = wxEvtHandlerBindMenuEventCallbackPtr.asFunction<WxEvtHandlerBindMenuEventCallback>();

  final wxEvtHandlerUnbindMenuEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindMenuEventCallbackNative>>('wxEvtHandlerUnbindMenuEventCallback');
  wxEvtHandlerUnbindMenuEventCallback = wxEvtHandlerUnbindMenuEventCallbackPtr.asFunction<WxEvtHandlerUnbindMenuEventCallback>();

  // ------------------------- EVT_TOOL ----------------------

  final wxGetToolEventTypePtr = dylib.lookup <NativeFunction<_WxGetToolEventTypeNative>>('wxGetToolEventType');
  wxGetToolEventType = wxGetToolEventTypePtr.asFunction<WxGetToolEventType>();

  final wxEvtHandlerBindToolEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindToolEventCallbackNative>>('wxEvtHandlerBindToolEventCallback');
  wxEvtHandlerBindToolEventCallback = wxEvtHandlerBindToolEventCallbackPtr.asFunction<WxEvtHandlerBindToolEventCallback>();

  final wxEvtHandlerUnbindToolEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindToolEventCallbackNative>>('wxEvtHandlerUnbindToolEventCallback');
  wxEvtHandlerUnbindToolEventCallback = wxEvtHandlerUnbindToolEventCallbackPtr.asFunction<WxEvtHandlerUnbindToolEventCallback>();

  // ------------------------- EVT_TOOL_ENTER ----------------------

  final wxGetToolEnterEventTypePtr = dylib.lookup <NativeFunction<_WxGetToolEnterEventTypeNative>>('wxGetToolEnterEventType');
  wxGetToolEnterEventType = wxGetToolEnterEventTypePtr.asFunction<WxGetToolEnterEventType>();

  final wxEvtHandlerBindToolEnterEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindToolEnterEventCallbackNative>>('wxEvtHandlerBindToolEnterEventCallback');
  wxEvtHandlerBindToolEnterEventCallback = wxEvtHandlerBindToolEnterEventCallbackPtr.asFunction<WxEvtHandlerBindToolEnterEventCallback>();

  final wxEvtHandlerUnbindToolEnterEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindToolEnterEventCallbackNative>>('wxEvtHandlerUnbindToolEnterEventCallback');
  wxEvtHandlerUnbindToolEnterEventCallback = wxEvtHandlerUnbindToolEnterEventCallbackPtr.asFunction<WxEvtHandlerUnbindToolEnterEventCallback>();

  // ------------------------- EVT_TOOL_DROPDOWN ----------------------

  final wxGetToolDropDownEventTypePtr = dylib.lookup <NativeFunction<_WxGetToolDropDownEventTypeNative>>('wxGetToolDropDownEventType');
  wxGetToolDropDownEventType = wxGetToolDropDownEventTypePtr.asFunction<WxGetToolDropDownEventType>();

  final wxEvtHandlerBindToolDropDownEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindToolDropDownEventCallbackNative>>('wxEvtHandlerBindToolDropDownEventCallback');
  wxEvtHandlerBindToolDropDownEventCallback = wxEvtHandlerBindToolDropDownEventCallbackPtr.asFunction<WxEvtHandlerBindToolDropDownEventCallback>();

  final wxEvtHandlerUnbindToolDropDownEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindToolDropDownEventCallbackNative>>('wxEvtHandlerUnbindToolDropDownEventCallback');
  wxEvtHandlerUnbindToolDropDownEventCallback = wxEvtHandlerUnbindToolDropDownEventCallbackPtr.asFunction<WxEvtHandlerUnbindToolDropDownEventCallback>();

  // ------------------------- EVT_SYS_COLOUR_CHANGED ----------------------

  final wxGetSysColourChangedEventTypePtr = dylib.lookup <NativeFunction<_WxGetSysColourChangedEventTypeNative>>('wxGetSysColourChangedEventType');
  wxGetSysColourChangedEventType = wxGetSysColourChangedEventTypePtr.asFunction<WxGetSysColourChangedEventType>();

  final wxEvtHandlerBindSysColourChangedEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindSysColourChangedEventCallbackNative>>('wxEvtHandlerBindSysColourChangedEventCallback');
  wxEvtHandlerBindSysColourChangedEventCallback = wxEvtHandlerBindSysColourChangedEventCallbackPtr.asFunction<WxEvtHandlerBindSysColourChangedEventCallback>();

  final wxEvtHandlerUnbindSysColourChangedEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindSysColourChangedEventCallbackNative>>('wxEvtHandlerUnbindSysColourChangedEventCallback');
  wxEvtHandlerUnbindSysColourChangedEventCallback = wxEvtHandlerUnbindSysColourChangedEventCallbackPtr.asFunction<WxEvtHandlerUnbindSysColourChangedEventCallback>();

  // ------------------------- EVT_DPI_CHANGED ----------------------

  final wxGetDPIChangedEventTypePtr = dylib.lookup <NativeFunction<_WxGetDPIChangedEventTypeNative>>('wxGetDPIChangedEventType');
  wxGetDPIChangedEventType = wxGetDPIChangedEventTypePtr.asFunction<WxGetDPIChangedEventType>();

  final wxEvtHandlerBindDPIChangedEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindDPIChangedEventCallbackNative>>('wxEvtHandlerBindDPIChangedEventCallback');
  wxEvtHandlerBindDPIChangedEventCallback = wxEvtHandlerBindDPIChangedEventCallbackPtr.asFunction<WxEvtHandlerBindDPIChangedEventCallback>();

  final wxEvtHandlerUnbindDPIChangedEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindDPIChangedEventCallbackNative>>('wxEvtHandlerUnbindDPIChangedEventCallback');
  wxEvtHandlerUnbindDPIChangedEventCallback = wxEvtHandlerUnbindDPIChangedEventCallbackPtr.asFunction<WxEvtHandlerUnbindDPIChangedEventCallback>();

  // ------------------------- EVT_IDLE ----------------------

  final wxGetIdleEventTypePtr = dylib.lookup <NativeFunction<_WxGetIdleEventTypeNative>>('wxGetIdleEventType');
  wxGetIdleEventType = wxGetIdleEventTypePtr.asFunction<WxGetIdleEventType>();

  final wxEvtHandlerBindIdleEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindIdleEventCallbackNative>>('wxEvtHandlerBindIdleEventCallback');
  wxEvtHandlerBindIdleEventCallback = wxEvtHandlerBindIdleEventCallbackPtr.asFunction<WxEvtHandlerBindIdleEventCallback>();

  final wxEvtHandlerUnbindIdleEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindIdleEventCallbackNative>>('wxEvtHandlerUnbindIdleEventCallback');
  wxEvtHandlerUnbindIdleEventCallback = wxEvtHandlerUnbindIdleEventCallbackPtr.asFunction<WxEvtHandlerUnbindIdleEventCallback>();

  // ------------------------- EVT_TIMER ----------------------

  final wxGetTimerEventTypePtr = dylib.lookup <NativeFunction<_WxGetTimerEventTypeNative>>('wxGetTimerEventType');
  wxGetTimerEventType = wxGetTimerEventTypePtr.asFunction<WxGetTimerEventType>();

  final wxEvtHandlerBindTimerEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindTimerEventCallbackNative>>('wxEvtHandlerBindTimerEventCallback');
  wxEvtHandlerBindTimerEventCallback = wxEvtHandlerBindTimerEventCallbackPtr.asFunction<WxEvtHandlerBindTimerEventCallback>();

  final wxEvtHandlerUnbindTimerEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindTimerEventCallbackNative>>('wxEvtHandlerUnbindTimerEventCallback');
  wxEvtHandlerUnbindTimerEventCallback = wxEvtHandlerUnbindTimerEventCallbackPtr.asFunction<WxEvtHandlerUnbindTimerEventCallback>();

  // ------------------------- EVT_VM_GET_MIN_SIZE ----------------------

  final wxGetVMGetMinSizeEventTypePtr = dylib.lookup <NativeFunction<_WxGetVMGetMinSizeEventTypeNative>>('wxGetVMGetMinSizeEventType');
  wxGetVMGetMinSizeEventType = wxGetVMGetMinSizeEventTypePtr.asFunction<WxGetVMGetMinSizeEventType>();

  final wxEvtHandlerBindVMGetMinSizeEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindVMGetMinSizeEventCallbackNative>>('wxEvtHandlerBindVMGetMinSizeEventCallback');
  wxEvtHandlerBindVMGetMinSizeEventCallback = wxEvtHandlerBindVMGetMinSizeEventCallbackPtr.asFunction<WxEvtHandlerBindVMGetMinSizeEventCallback>();

  final wxEvtHandlerUnbindVMGetMinSizeEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindVMGetMinSizeEventCallbackNative>>('wxEvtHandlerUnbindVMGetMinSizeEventCallback');
  wxEvtHandlerUnbindVMGetMinSizeEventCallback = wxEvtHandlerUnbindVMGetMinSizeEventCallbackPtr.asFunction<WxEvtHandlerUnbindVMGetMinSizeEventCallback>();

  // ------------------------- EVT_SET_FOCUS ----------------------

  final wxGetSetFocusEventTypePtr = dylib.lookup <NativeFunction<_WxGetSetFocusEventTypeNative>>('wxGetSetFocusEventType');
  wxGetSetFocusEventType = wxGetSetFocusEventTypePtr.asFunction<WxGetSetFocusEventType>();

  final wxEvtHandlerBindSetFocusEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindSetFocusEventCallbackNative>>('wxEvtHandlerBindSetFocusEventCallback');
  wxEvtHandlerBindSetFocusEventCallback = wxEvtHandlerBindSetFocusEventCallbackPtr.asFunction<WxEvtHandlerBindSetFocusEventCallback>();

  final wxEvtHandlerUnbindSetFocusEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindSetFocusEventCallbackNative>>('wxEvtHandlerUnbindSetFocusEventCallback');
  wxEvtHandlerUnbindSetFocusEventCallback = wxEvtHandlerUnbindSetFocusEventCallbackPtr.asFunction<WxEvtHandlerUnbindSetFocusEventCallback>();

  // ------------------------- EVT_KILL_FOCUS ----------------------

  final wxGetKillFocusEventTypePtr = dylib.lookup <NativeFunction<_WxGetKillFocusEventTypeNative>>('wxGetKillFocusEventType');
  wxGetKillFocusEventType = wxGetKillFocusEventTypePtr.asFunction<WxGetKillFocusEventType>();

  final wxEvtHandlerBindKillFocusEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindKillFocusEventCallbackNative>>('wxEvtHandlerBindKillFocusEventCallback');
  wxEvtHandlerBindKillFocusEventCallback = wxEvtHandlerBindKillFocusEventCallbackPtr.asFunction<WxEvtHandlerBindKillFocusEventCallback>();

  final wxEvtHandlerUnbindKillFocusEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindKillFocusEventCallbackNative>>('wxEvtHandlerUnbindKillFocusEventCallback');
  wxEvtHandlerUnbindKillFocusEventCallback = wxEvtHandlerUnbindKillFocusEventCallbackPtr.asFunction<WxEvtHandlerUnbindKillFocusEventCallback>();

  // ------------------------- EVT_SIZE ----------------------

  final wxGetSizeEventTypePtr = dylib.lookup <NativeFunction<_WxGetSizeEventTypeNative>>('wxGetSizeEventType');
  wxGetSizeEventType = wxGetSizeEventTypePtr.asFunction<WxGetSizeEventType>();

  final wxEvtHandlerBindSizeEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindSizeEventCallbackNative>>('wxEvtHandlerBindSizeEventCallback');
  wxEvtHandlerBindSizeEventCallback = wxEvtHandlerBindSizeEventCallbackPtr.asFunction<WxEvtHandlerBindSizeEventCallback>();

  final wxEvtHandlerUnbindSizeEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindSizeEventCallbackNative>>('wxEvtHandlerUnbindSizeEventCallback');
  wxEvtHandlerUnbindSizeEventCallback = wxEvtHandlerUnbindSizeEventCallbackPtr.asFunction<WxEvtHandlerUnbindSizeEventCallback>();

  // ------------------------- EVT_PAINT ----------------------

  final wxGetPaintEventTypePtr = dylib.lookup <NativeFunction<_WxGetPaintEventTypeNative>>('wxGetPaintEventType');
  wxGetPaintEventType = wxGetPaintEventTypePtr.asFunction<WxGetPaintEventType>();

  final wxEvtHandlerBindPaintEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindPaintEventCallbackNative>>('wxEvtHandlerBindPaintEventCallback');
  wxEvtHandlerBindPaintEventCallback = wxEvtHandlerBindPaintEventCallbackPtr.asFunction<WxEvtHandlerBindPaintEventCallback>();

  final wxEvtHandlerUnbindPaintEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindPaintEventCallbackNative>>('wxEvtHandlerUnbindPaintEventCallback');
  wxEvtHandlerUnbindPaintEventCallback = wxEvtHandlerUnbindPaintEventCallbackPtr.asFunction<WxEvtHandlerUnbindPaintEventCallback>();

  // ------------------------- EVT_MOVE ----------------------

  final wxGetMoveEventTypePtr = dylib.lookup <NativeFunction<_WxGetMoveEventTypeNative>>('wxGetMoveEventType');
  wxGetMoveEventType = wxGetMoveEventTypePtr.asFunction<WxGetMoveEventType>();

  final wxEvtHandlerBindMoveEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindMoveEventCallbackNative>>('wxEvtHandlerBindMoveEventCallback');
  wxEvtHandlerBindMoveEventCallback = wxEvtHandlerBindMoveEventCallbackPtr.asFunction<WxEvtHandlerBindMoveEventCallback>();

  final wxEvtHandlerUnbindMoveEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindMoveEventCallbackNative>>('wxEvtHandlerUnbindMoveEventCallback');
  wxEvtHandlerUnbindMoveEventCallback = wxEvtHandlerUnbindMoveEventCallbackPtr.asFunction<WxEvtHandlerUnbindMoveEventCallback>();

  // ------------------------- EVT_MOVE_START ----------------------

  final wxGetMoveStartEventTypePtr = dylib.lookup <NativeFunction<_WxGetMoveStartEventTypeNative>>('wxGetMoveStartEventType');
  wxGetMoveStartEventType = wxGetMoveStartEventTypePtr.asFunction<WxGetMoveStartEventType>();

  final wxEvtHandlerBindMoveStartEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindMoveStartEventCallbackNative>>('wxEvtHandlerBindMoveStartEventCallback');
  wxEvtHandlerBindMoveStartEventCallback = wxEvtHandlerBindMoveStartEventCallbackPtr.asFunction<WxEvtHandlerBindMoveStartEventCallback>();

  final wxEvtHandlerUnbindMoveStartEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindMoveStartEventCallbackNative>>('wxEvtHandlerUnbindMoveStartEventCallback');
  wxEvtHandlerUnbindMoveStartEventCallback = wxEvtHandlerUnbindMoveStartEventCallbackPtr.asFunction<WxEvtHandlerUnbindMoveStartEventCallback>();

  // ------------------------- EVT_MOVE_END ----------------------

  final wxGetMoveEndEventTypePtr = dylib.lookup <NativeFunction<_WxGetMoveEndEventTypeNative>>('wxGetMoveEndEventType');
  wxGetMoveEndEventType = wxGetMoveEndEventTypePtr.asFunction<WxGetMoveEndEventType>();

  final wxEvtHandlerBindMoveEndEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindMoveEndEventCallbackNative>>('wxEvtHandlerBindMoveEndEventCallback');
  wxEvtHandlerBindMoveEndEventCallback = wxEvtHandlerBindMoveEndEventCallbackPtr.asFunction<WxEvtHandlerBindMoveEndEventCallback>();

  final wxEvtHandlerUnbindMoveEndEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindMoveEndEventCallbackNative>>('wxEvtHandlerUnbindMoveEndEventCallback');
  wxEvtHandlerUnbindMoveEndEventCallback = wxEvtHandlerUnbindMoveEndEventCallbackPtr.asFunction<WxEvtHandlerUnbindMoveEndEventCallback>();

  // ------------------------- EVT_CLOSE_WINDOW ----------------------

  final wxGetCloseWindowEventTypePtr = dylib.lookup <NativeFunction<_WxGetCloseWindowEventTypeNative>>('wxGetCloseWindowEventType');
  wxGetCloseWindowEventType = wxGetCloseWindowEventTypePtr.asFunction<WxGetCloseWindowEventType>();

  final wxEvtHandlerBindCloseWindowEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindCloseWindowEventCallbackNative>>('wxEvtHandlerBindCloseWindowEventCallback');
  wxEvtHandlerBindCloseWindowEventCallback = wxEvtHandlerBindCloseWindowEventCallbackPtr.asFunction<WxEvtHandlerBindCloseWindowEventCallback>();

  final wxEvtHandlerUnbindCloseWindowEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindCloseWindowEventCallbackNative>>('wxEvtHandlerUnbindCloseWindowEventCallback');
  wxEvtHandlerUnbindCloseWindowEventCallback = wxEvtHandlerUnbindCloseWindowEventCallbackPtr.asFunction<WxEvtHandlerUnbindCloseWindowEventCallback>();

  // ------------------------- EVT_QUERY_END_SESSION ----------------------

  final wxGetQueryEndSessionEventTypePtr = dylib.lookup <NativeFunction<_WxGetQueryEndSessionEventTypeNative>>('wxGetQueryEndSessionEventType');
  wxGetQueryEndSessionEventType = wxGetQueryEndSessionEventTypePtr.asFunction<WxGetQueryEndSessionEventType>();

  final wxEvtHandlerBindQueryEndSessionEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindQueryEndSessionEventCallbackNative>>('wxEvtHandlerBindQueryEndSessionEventCallback');
  wxEvtHandlerBindQueryEndSessionEventCallback = wxEvtHandlerBindQueryEndSessionEventCallbackPtr.asFunction<WxEvtHandlerBindQueryEndSessionEventCallback>();

  final wxEvtHandlerUnbindQueryEndSessionEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindQueryEndSessionEventCallbackNative>>('wxEvtHandlerUnbindQueryEndSessionEventCallback');
  wxEvtHandlerUnbindQueryEndSessionEventCallback = wxEvtHandlerUnbindQueryEndSessionEventCallbackPtr.asFunction<WxEvtHandlerUnbindQueryEndSessionEventCallback>();

  // ------------------------- EVT_END_SESSION ----------------------

  final wxGetEndSessionEventTypePtr = dylib.lookup <NativeFunction<_WxGetEndSessionEventTypeNative>>('wxGetEndSessionEventType');
  wxGetEndSessionEventType = wxGetEndSessionEventTypePtr.asFunction<WxGetEndSessionEventType>();

  final wxEvtHandlerBindEndSessionEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindEndSessionEventCallbackNative>>('wxEvtHandlerBindEndSessionEventCallback');
  wxEvtHandlerBindEndSessionEventCallback = wxEvtHandlerBindEndSessionEventCallbackPtr.asFunction<WxEvtHandlerBindEndSessionEventCallback>();

  final wxEvtHandlerUnbindEndSessionEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindEndSessionEventCallbackNative>>('wxEvtHandlerUnbindEndSessionEventCallback');
  wxEvtHandlerUnbindEndSessionEventCallback = wxEvtHandlerUnbindEndSessionEventCallbackPtr.asFunction<WxEvtHandlerUnbindEndSessionEventCallback>();

  // ------------------------- EVT_SHOW ----------------------

  final wxGetShowEventTypePtr = dylib.lookup <NativeFunction<_WxGetShowEventTypeNative>>('wxGetShowEventType');
  wxGetShowEventType = wxGetShowEventTypePtr.asFunction<WxGetShowEventType>();

  final wxEvtHandlerBindShowEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindShowEventCallbackNative>>('wxEvtHandlerBindShowEventCallback');
  wxEvtHandlerBindShowEventCallback = wxEvtHandlerBindShowEventCallbackPtr.asFunction<WxEvtHandlerBindShowEventCallback>();

  final wxEvtHandlerUnbindShowEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindShowEventCallbackNative>>('wxEvtHandlerUnbindShowEventCallback');
  wxEvtHandlerUnbindShowEventCallback = wxEvtHandlerUnbindShowEventCallbackPtr.asFunction<WxEvtHandlerUnbindShowEventCallback>();

  // ------------------------- EVT_CREATE ----------------------

  final wxGetWindowCreateEventTypePtr = dylib.lookup <NativeFunction<_WxGetWindowCreateEventTypeNative>>('wxGetWindowCreateEventType');
  wxGetWindowCreateEventType = wxGetWindowCreateEventTypePtr.asFunction<WxGetWindowCreateEventType>();

  final wxEvtHandlerBindWindowCreateEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindWindowCreateEventCallbackNative>>('wxEvtHandlerBindWindowCreateEventCallback');
  wxEvtHandlerBindWindowCreateEventCallback = wxEvtHandlerBindWindowCreateEventCallbackPtr.asFunction<WxEvtHandlerBindWindowCreateEventCallback>();

  final wxEvtHandlerUnbindWindowCreateEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindWindowCreateEventCallbackNative>>('wxEvtHandlerUnbindWindowCreateEventCallback');
  wxEvtHandlerUnbindWindowCreateEventCallback = wxEvtHandlerUnbindWindowCreateEventCallbackPtr.asFunction<WxEvtHandlerUnbindWindowCreateEventCallback>();

  // ------------------------- EVT_ACTIVATE_APP ----------------------

  final wxGetActivateAppEventTypePtr = dylib.lookup <NativeFunction<_WxGetActivateAppEventTypeNative>>('wxGetActivateAppEventType');
  wxGetActivateAppEventType = wxGetActivateAppEventTypePtr.asFunction<WxGetActivateAppEventType>();

  final wxEvtHandlerBindActivateAppEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindActivateAppEventCallbackNative>>('wxEvtHandlerBindActivateAppEventCallback');
  wxEvtHandlerBindActivateAppEventCallback = wxEvtHandlerBindActivateAppEventCallbackPtr.asFunction<WxEvtHandlerBindActivateAppEventCallback>();

  final wxEvtHandlerUnbindActivateAppEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindActivateAppEventCallbackNative>>('wxEvtHandlerUnbindActivateAppEventCallback');
  wxEvtHandlerUnbindActivateAppEventCallback = wxEvtHandlerUnbindActivateAppEventCallbackPtr.asFunction<WxEvtHandlerUnbindActivateAppEventCallback>();

  // ------------------------- EVT_ACTIVATE ----------------------

  final wxGetActivateEventTypePtr = dylib.lookup <NativeFunction<_WxGetActivateEventTypeNative>>('wxGetActivateEventType');
  wxGetActivateEventType = wxGetActivateEventTypePtr.asFunction<WxGetActivateEventType>();

  final wxEvtHandlerBindActivateEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindActivateEventCallbackNative>>('wxEvtHandlerBindActivateEventCallback');
  wxEvtHandlerBindActivateEventCallback = wxEvtHandlerBindActivateEventCallbackPtr.asFunction<WxEvtHandlerBindActivateEventCallback>();

  final wxEvtHandlerUnbindActivateEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindActivateEventCallbackNative>>('wxEvtHandlerUnbindActivateEventCallback');
  wxEvtHandlerUnbindActivateEventCallback = wxEvtHandlerUnbindActivateEventCallbackPtr.asFunction<WxEvtHandlerUnbindActivateEventCallback>();

  // ------------------------- EVT_HIBERNATE ----------------------

  final wxGetHibernateEventTypePtr = dylib.lookup <NativeFunction<_WxGetHibernateEventTypeNative>>('wxGetHibernateEventType');
  wxGetHibernateEventType = wxGetHibernateEventTypePtr.asFunction<WxGetHibernateEventType>();

  final wxEvtHandlerBindHibernateEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindHibernateEventCallbackNative>>('wxEvtHandlerBindHibernateEventCallback');
  wxEvtHandlerBindHibernateEventCallback = wxEvtHandlerBindHibernateEventCallbackPtr.asFunction<WxEvtHandlerBindHibernateEventCallback>();

  final wxEvtHandlerUnbindHibernateEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindHibernateEventCallbackNative>>('wxEvtHandlerUnbindHibernateEventCallback');
  wxEvtHandlerUnbindHibernateEventCallback = wxEvtHandlerUnbindHibernateEventCallbackPtr.asFunction<WxEvtHandlerUnbindHibernateEventCallback>();

  // ------------------------- EVT_LEFT_DOWN ----------------------

  final wxGetLeftDownEventTypePtr = dylib.lookup <NativeFunction<_WxGetLeftDownEventTypeNative>>('wxGetLeftDownEventType');
  wxGetLeftDownEventType = wxGetLeftDownEventTypePtr.asFunction<WxGetLeftDownEventType>();

  final wxEvtHandlerBindLeftDownEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindLeftDownEventCallbackNative>>('wxEvtHandlerBindLeftDownEventCallback');
  wxEvtHandlerBindLeftDownEventCallback = wxEvtHandlerBindLeftDownEventCallbackPtr.asFunction<WxEvtHandlerBindLeftDownEventCallback>();

  final wxEvtHandlerUnbindLeftDownEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindLeftDownEventCallbackNative>>('wxEvtHandlerUnbindLeftDownEventCallback');
  wxEvtHandlerUnbindLeftDownEventCallback = wxEvtHandlerUnbindLeftDownEventCallbackPtr.asFunction<WxEvtHandlerUnbindLeftDownEventCallback>();

  // ------------------------- EVT_RIGHT_DOWN ----------------------

  final wxGetRightDownEventTypePtr = dylib.lookup <NativeFunction<_WxGetRightDownEventTypeNative>>('wxGetRightDownEventType');
  wxGetRightDownEventType = wxGetRightDownEventTypePtr.asFunction<WxGetRightDownEventType>();

  final wxEvtHandlerBindRightDownEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindRightDownEventCallbackNative>>('wxEvtHandlerBindRightDownEventCallback');
  wxEvtHandlerBindRightDownEventCallback = wxEvtHandlerBindRightDownEventCallbackPtr.asFunction<WxEvtHandlerBindRightDownEventCallback>();

  final wxEvtHandlerUnbindRightDownEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindRightDownEventCallbackNative>>('wxEvtHandlerUnbindRightDownEventCallback');
  wxEvtHandlerUnbindRightDownEventCallback = wxEvtHandlerUnbindRightDownEventCallbackPtr.asFunction<WxEvtHandlerUnbindRightDownEventCallback>();

  // ------------------------- EVT_MIDDLE_DOWN ----------------------

  final wxGetMiddleDownEventTypePtr = dylib.lookup <NativeFunction<_WxGetMiddleDownEventTypeNative>>('wxGetMiddleDownEventType');
  wxGetMiddleDownEventType = wxGetMiddleDownEventTypePtr.asFunction<WxGetMiddleDownEventType>();

  final wxEvtHandlerBindMiddleDownEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindMiddleDownEventCallbackNative>>('wxEvtHandlerBindMiddleDownEventCallback');
  wxEvtHandlerBindMiddleDownEventCallback = wxEvtHandlerBindMiddleDownEventCallbackPtr.asFunction<WxEvtHandlerBindMiddleDownEventCallback>();

  final wxEvtHandlerUnbindMiddleDownEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindMiddleDownEventCallbackNative>>('wxEvtHandlerUnbindMiddleDownEventCallback');
  wxEvtHandlerUnbindMiddleDownEventCallback = wxEvtHandlerUnbindMiddleDownEventCallbackPtr.asFunction<WxEvtHandlerUnbindMiddleDownEventCallback>();

  // ------------------------- EVT_LEFT_DCLICK ----------------------

  final wxGetLeftDClickEventTypePtr = dylib.lookup <NativeFunction<_WxGetLeftDClickEventTypeNative>>('wxGetLeftDClickEventType');
  wxGetLeftDClickEventType = wxGetLeftDClickEventTypePtr.asFunction<WxGetLeftDClickEventType>();

  final wxEvtHandlerBindLeftDClickEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindLeftDClickEventCallbackNative>>('wxEvtHandlerBindLeftDClickEventCallback');
  wxEvtHandlerBindLeftDClickEventCallback = wxEvtHandlerBindLeftDClickEventCallbackPtr.asFunction<WxEvtHandlerBindLeftDClickEventCallback>();

  final wxEvtHandlerUnbindLeftDClickEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindLeftDClickEventCallbackNative>>('wxEvtHandlerUnbindLeftDClickEventCallback');
  wxEvtHandlerUnbindLeftDClickEventCallback = wxEvtHandlerUnbindLeftDClickEventCallbackPtr.asFunction<WxEvtHandlerUnbindLeftDClickEventCallback>();

  // ------------------------- EVT_RIGHT_DCLICK ----------------------

  final wxGetRightDClickEventTypePtr = dylib.lookup <NativeFunction<_WxGetRightDClickEventTypeNative>>('wxGetRightDClickEventType');
  wxGetRightDClickEventType = wxGetRightDClickEventTypePtr.asFunction<WxGetRightDClickEventType>();

  final wxEvtHandlerBindRightDClickEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindRightDClickEventCallbackNative>>('wxEvtHandlerBindRightDClickEventCallback');
  wxEvtHandlerBindRightDClickEventCallback = wxEvtHandlerBindRightDClickEventCallbackPtr.asFunction<WxEvtHandlerBindRightDClickEventCallback>();

  final wxEvtHandlerUnbindRightDClickEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindRightDClickEventCallbackNative>>('wxEvtHandlerUnbindRightDClickEventCallback');
  wxEvtHandlerUnbindRightDClickEventCallback = wxEvtHandlerUnbindRightDClickEventCallbackPtr.asFunction<WxEvtHandlerUnbindRightDClickEventCallback>();

  // ------------------------- EVT_MIDDLE_DCLICK ----------------------

  final wxGetMiddleDClickEventTypePtr = dylib.lookup <NativeFunction<_WxGetMiddleDClickEventTypeNative>>('wxGetMiddleDClickEventType');
  wxGetMiddleDClickEventType = wxGetMiddleDClickEventTypePtr.asFunction<WxGetMiddleDClickEventType>();

  final wxEvtHandlerBindMiddleDClickEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindMiddleDClickEventCallbackNative>>('wxEvtHandlerBindMiddleDClickEventCallback');
  wxEvtHandlerBindMiddleDClickEventCallback = wxEvtHandlerBindMiddleDClickEventCallbackPtr.asFunction<WxEvtHandlerBindMiddleDClickEventCallback>();

  final wxEvtHandlerUnbindMiddleDClickEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindMiddleDClickEventCallbackNative>>('wxEvtHandlerUnbindMiddleDClickEventCallback');
  wxEvtHandlerUnbindMiddleDClickEventCallback = wxEvtHandlerUnbindMiddleDClickEventCallbackPtr.asFunction<WxEvtHandlerUnbindMiddleDClickEventCallback>();

  // ------------------------- EVT_LEFT_UP ----------------------

  final wxGetLeftUpEventTypePtr = dylib.lookup <NativeFunction<_WxGetLeftUpEventTypeNative>>('wxGetLeftUpEventType');
  wxGetLeftUpEventType = wxGetLeftUpEventTypePtr.asFunction<WxGetLeftUpEventType>();

  final wxEvtHandlerBindLeftUpEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindLeftUpEventCallbackNative>>('wxEvtHandlerBindLeftUpEventCallback');
  wxEvtHandlerBindLeftUpEventCallback = wxEvtHandlerBindLeftUpEventCallbackPtr.asFunction<WxEvtHandlerBindLeftUpEventCallback>();

  final wxEvtHandlerUnbindLeftUpEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindLeftUpEventCallbackNative>>('wxEvtHandlerUnbindLeftUpEventCallback');
  wxEvtHandlerUnbindLeftUpEventCallback = wxEvtHandlerUnbindLeftUpEventCallbackPtr.asFunction<WxEvtHandlerUnbindLeftUpEventCallback>();

  // ------------------------- EVT_RIGHT_UP ----------------------

  final wxGetRightUpEventTypePtr = dylib.lookup <NativeFunction<_WxGetRightUpEventTypeNative>>('wxGetRightUpEventType');
  wxGetRightUpEventType = wxGetRightUpEventTypePtr.asFunction<WxGetRightUpEventType>();

  final wxEvtHandlerBindRightUpEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindRightUpEventCallbackNative>>('wxEvtHandlerBindRightUpEventCallback');
  wxEvtHandlerBindRightUpEventCallback = wxEvtHandlerBindRightUpEventCallbackPtr.asFunction<WxEvtHandlerBindRightUpEventCallback>();

  final wxEvtHandlerUnbindRightUpEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindRightUpEventCallbackNative>>('wxEvtHandlerUnbindRightUpEventCallback');
  wxEvtHandlerUnbindRightUpEventCallback = wxEvtHandlerUnbindRightUpEventCallbackPtr.asFunction<WxEvtHandlerUnbindRightUpEventCallback>();

  // ------------------------- EVT_MIDDLE_UP ----------------------

  final wxGetMiddleUpEventTypePtr = dylib.lookup <NativeFunction<_WxGetMiddleUpEventTypeNative>>('wxGetMiddleUpEventType');
  wxGetMiddleUpEventType = wxGetMiddleUpEventTypePtr.asFunction<WxGetMiddleUpEventType>();

  final wxEvtHandlerBindMiddleUpEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindMiddleUpEventCallbackNative>>('wxEvtHandlerBindMiddleUpEventCallback');
  wxEvtHandlerBindMiddleUpEventCallback = wxEvtHandlerBindMiddleUpEventCallbackPtr.asFunction<WxEvtHandlerBindMiddleUpEventCallback>();

  final wxEvtHandlerUnbindMiddleUpEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindMiddleUpEventCallbackNative>>('wxEvtHandlerUnbindMiddleUpEventCallback');
  wxEvtHandlerUnbindMiddleUpEventCallback = wxEvtHandlerUnbindMiddleUpEventCallbackPtr.asFunction<WxEvtHandlerUnbindMiddleUpEventCallback>();

  // ------------------------- EVT_MOTION ----------------------

  final wxGetMotionEventTypePtr = dylib.lookup <NativeFunction<_WxGetMotionEventTypeNative>>('wxGetMotionEventType');
  wxGetMotionEventType = wxGetMotionEventTypePtr.asFunction<WxGetMotionEventType>();

  final wxEvtHandlerBindMotionEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindMotionEventCallbackNative>>('wxEvtHandlerBindMotionEventCallback');
  wxEvtHandlerBindMotionEventCallback = wxEvtHandlerBindMotionEventCallbackPtr.asFunction<WxEvtHandlerBindMotionEventCallback>();

  final wxEvtHandlerUnbindMotionEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindMotionEventCallbackNative>>('wxEvtHandlerUnbindMotionEventCallback');
  wxEvtHandlerUnbindMotionEventCallback = wxEvtHandlerUnbindMotionEventCallbackPtr.asFunction<WxEvtHandlerUnbindMotionEventCallback>();

  // ------------------------- EVT_ENTER_WINDOW ----------------------

  final wxGetEnterWindowEventTypePtr = dylib.lookup <NativeFunction<_WxGetEnterWindowEventTypeNative>>('wxGetEnterWindowEventType');
  wxGetEnterWindowEventType = wxGetEnterWindowEventTypePtr.asFunction<WxGetEnterWindowEventType>();

  final wxEvtHandlerBindEnterWindowEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindEnterWindowEventCallbackNative>>('wxEvtHandlerBindEnterWindowEventCallback');
  wxEvtHandlerBindEnterWindowEventCallback = wxEvtHandlerBindEnterWindowEventCallbackPtr.asFunction<WxEvtHandlerBindEnterWindowEventCallback>();

  final wxEvtHandlerUnbindEnterWindowEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindEnterWindowEventCallbackNative>>('wxEvtHandlerUnbindEnterWindowEventCallback');
  wxEvtHandlerUnbindEnterWindowEventCallback = wxEvtHandlerUnbindEnterWindowEventCallbackPtr.asFunction<WxEvtHandlerUnbindEnterWindowEventCallback>();

  // ------------------------- EVT_LEAVE_WINDOW ----------------------

  final wxGetLeaveWindowEventTypePtr = dylib.lookup <NativeFunction<_WxGetLeaveWindowEventTypeNative>>('wxGetLeaveWindowEventType');
  wxGetLeaveWindowEventType = wxGetLeaveWindowEventTypePtr.asFunction<WxGetLeaveWindowEventType>();

  final wxEvtHandlerBindLeaveWindowEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindLeaveWindowEventCallbackNative>>('wxEvtHandlerBindLeaveWindowEventCallback');
  wxEvtHandlerBindLeaveWindowEventCallback = wxEvtHandlerBindLeaveWindowEventCallbackPtr.asFunction<WxEvtHandlerBindLeaveWindowEventCallback>();

  final wxEvtHandlerUnbindLeaveWindowEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindLeaveWindowEventCallbackNative>>('wxEvtHandlerUnbindLeaveWindowEventCallback');
  wxEvtHandlerUnbindLeaveWindowEventCallback = wxEvtHandlerUnbindLeaveWindowEventCallbackPtr.asFunction<WxEvtHandlerUnbindLeaveWindowEventCallback>();

  // ------------------------- EVT_MOUSEWHEEL ----------------------

  final wxGetMouseWheelEventTypePtr = dylib.lookup <NativeFunction<_WxGetMouseWheelEventTypeNative>>('wxGetMouseWheelEventType');
  wxGetMouseWheelEventType = wxGetMouseWheelEventTypePtr.asFunction<WxGetMouseWheelEventType>();

  final wxEvtHandlerBindMouseWheelEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindMouseWheelEventCallbackNative>>('wxEvtHandlerBindMouseWheelEventCallback');
  wxEvtHandlerBindMouseWheelEventCallback = wxEvtHandlerBindMouseWheelEventCallbackPtr.asFunction<WxEvtHandlerBindMouseWheelEventCallback>();

  final wxEvtHandlerUnbindMouseWheelEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindMouseWheelEventCallbackNative>>('wxEvtHandlerUnbindMouseWheelEventCallback');
  wxEvtHandlerUnbindMouseWheelEventCallback = wxEvtHandlerUnbindMouseWheelEventCallbackPtr.asFunction<WxEvtHandlerUnbindMouseWheelEventCallback>();

  // ------------------------- EVT_MAGNIFY ----------------------

  final wxGetMagnifyEventTypePtr = dylib.lookup <NativeFunction<_WxGetMagnifyEventTypeNative>>('wxGetMagnifyEventType');
  wxGetMagnifyEventType = wxGetMagnifyEventTypePtr.asFunction<WxGetMagnifyEventType>();

  final wxEvtHandlerBindMagnifyEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindMagnifyEventCallbackNative>>('wxEvtHandlerBindMagnifyEventCallback');
  wxEvtHandlerBindMagnifyEventCallback = wxEvtHandlerBindMagnifyEventCallbackPtr.asFunction<WxEvtHandlerBindMagnifyEventCallback>();

  final wxEvtHandlerUnbindMagnifyEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindMagnifyEventCallbackNative>>('wxEvtHandlerUnbindMagnifyEventCallback');
  wxEvtHandlerUnbindMagnifyEventCallback = wxEvtHandlerUnbindMagnifyEventCallbackPtr.asFunction<WxEvtHandlerUnbindMagnifyEventCallback>();

  // ------------------------- EVT_KEY_DOWN ----------------------

  final wxGetKeyDownEventTypePtr = dylib.lookup <NativeFunction<_WxGetKeyDownEventTypeNative>>('wxGetKeyDownEventType');
  wxGetKeyDownEventType = wxGetKeyDownEventTypePtr.asFunction<WxGetKeyDownEventType>();

  final wxEvtHandlerBindKeyDownEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindKeyDownEventCallbackNative>>('wxEvtHandlerBindKeyDownEventCallback');
  wxEvtHandlerBindKeyDownEventCallback = wxEvtHandlerBindKeyDownEventCallbackPtr.asFunction<WxEvtHandlerBindKeyDownEventCallback>();

  final wxEvtHandlerUnbindKeyDownEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindKeyDownEventCallbackNative>>('wxEvtHandlerUnbindKeyDownEventCallback');
  wxEvtHandlerUnbindKeyDownEventCallback = wxEvtHandlerUnbindKeyDownEventCallbackPtr.asFunction<WxEvtHandlerUnbindKeyDownEventCallback>();

  // ------------------------- EVT_KEY_UP ----------------------

  final wxGetKeyUpEventTypePtr = dylib.lookup <NativeFunction<_WxGetKeyUpEventTypeNative>>('wxGetKeyUpEventType');
  wxGetKeyUpEventType = wxGetKeyUpEventTypePtr.asFunction<WxGetKeyUpEventType>();

  final wxEvtHandlerBindKeyUpEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindKeyUpEventCallbackNative>>('wxEvtHandlerBindKeyUpEventCallback');
  wxEvtHandlerBindKeyUpEventCallback = wxEvtHandlerBindKeyUpEventCallbackPtr.asFunction<WxEvtHandlerBindKeyUpEventCallback>();

  final wxEvtHandlerUnbindKeyUpEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindKeyUpEventCallbackNative>>('wxEvtHandlerUnbindKeyUpEventCallback');
  wxEvtHandlerUnbindKeyUpEventCallback = wxEvtHandlerUnbindKeyUpEventCallbackPtr.asFunction<WxEvtHandlerUnbindKeyUpEventCallback>();

  // ------------------------- EVT_CHAR ----------------------

  final wxGetCharEventTypePtr = dylib.lookup <NativeFunction<_WxGetCharEventTypeNative>>('wxGetCharEventType');
  wxGetCharEventType = wxGetCharEventTypePtr.asFunction<WxGetCharEventType>();

  final wxEvtHandlerBindCharEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindCharEventCallbackNative>>('wxEvtHandlerBindCharEventCallback');
  wxEvtHandlerBindCharEventCallback = wxEvtHandlerBindCharEventCallbackPtr.asFunction<WxEvtHandlerBindCharEventCallback>();

  final wxEvtHandlerUnbindCharEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindCharEventCallbackNative>>('wxEvtHandlerUnbindCharEventCallback');
  wxEvtHandlerUnbindCharEventCallback = wxEvtHandlerUnbindCharEventCallbackPtr.asFunction<WxEvtHandlerUnbindCharEventCallback>();

  // ------------------------- EVT_CHAR_HOOK ----------------------

  final wxGetCharHookEventTypePtr = dylib.lookup <NativeFunction<_WxGetCharHookEventTypeNative>>('wxGetCharHookEventType');
  wxGetCharHookEventType = wxGetCharHookEventTypePtr.asFunction<WxGetCharHookEventType>();

  final wxEvtHandlerBindCharHookEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindCharHookEventCallbackNative>>('wxEvtHandlerBindCharHookEventCallback');
  wxEvtHandlerBindCharHookEventCallback = wxEvtHandlerBindCharHookEventCallbackPtr.asFunction<WxEvtHandlerBindCharHookEventCallback>();

  final wxEvtHandlerUnbindCharHookEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindCharHookEventCallbackNative>>('wxEvtHandlerUnbindCharHookEventCallback');
  wxEvtHandlerUnbindCharHookEventCallback = wxEvtHandlerUnbindCharHookEventCallbackPtr.asFunction<WxEvtHandlerUnbindCharHookEventCallback>();

  // ------------------------- EVT_INIT_DIALOG ----------------------

  final wxGetInitDialogEventTypePtr = dylib.lookup <NativeFunction<_WxGetInitDialogEventTypeNative>>('wxGetInitDialogEventType');
  wxGetInitDialogEventType = wxGetInitDialogEventTypePtr.asFunction<WxGetInitDialogEventType>();

  final wxEvtHandlerBindInitDialogEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindInitDialogEventCallbackNative>>('wxEvtHandlerBindInitDialogEventCallback');
  wxEvtHandlerBindInitDialogEventCallback = wxEvtHandlerBindInitDialogEventCallbackPtr.asFunction<WxEvtHandlerBindInitDialogEventCallback>();

  final wxEvtHandlerUnbindInitDialogEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindInitDialogEventCallbackNative>>('wxEvtHandlerUnbindInitDialogEventCallback');
  wxEvtHandlerUnbindInitDialogEventCallback = wxEvtHandlerUnbindInitDialogEventCallbackPtr.asFunction<WxEvtHandlerUnbindInitDialogEventCallback>();

  // ------------------------- EVT_DIALOG_VALIDATE ----------------------

  final wxGetDialogValidateEventTypePtr = dylib.lookup <NativeFunction<_WxGetDialogValidateEventTypeNative>>('wxGetDialogValidateEventType');
  wxGetDialogValidateEventType = wxGetDialogValidateEventTypePtr.asFunction<WxGetDialogValidateEventType>();

  final wxEvtHandlerBindDialogValidateEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindDialogValidateEventCallbackNative>>('wxEvtHandlerBindDialogValidateEventCallback');
  wxEvtHandlerBindDialogValidateEventCallback = wxEvtHandlerBindDialogValidateEventCallbackPtr.asFunction<WxEvtHandlerBindDialogValidateEventCallback>();

  final wxEvtHandlerUnbindDialogValidateEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindDialogValidateEventCallbackNative>>('wxEvtHandlerUnbindDialogValidateEventCallback');
  wxEvtHandlerUnbindDialogValidateEventCallback = wxEvtHandlerUnbindDialogValidateEventCallbackPtr.asFunction<WxEvtHandlerUnbindDialogValidateEventCallback>();

  // ------------------------- EVT_UPDATE_UI ----------------------

  final wxGetUpdateUIEventTypePtr = dylib.lookup <NativeFunction<_WxGetUpdateUIEventTypeNative>>('wxGetUpdateUIEventType');
  wxGetUpdateUIEventType = wxGetUpdateUIEventTypePtr.asFunction<WxGetUpdateUIEventType>();

  final wxEvtHandlerBindUpdateUIEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindUpdateUIEventCallbackNative>>('wxEvtHandlerBindUpdateUIEventCallback');
  wxEvtHandlerBindUpdateUIEventCallback = wxEvtHandlerBindUpdateUIEventCallbackPtr.asFunction<WxEvtHandlerBindUpdateUIEventCallback>();

  final wxEvtHandlerUnbindUpdateUIEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindUpdateUIEventCallbackNative>>('wxEvtHandlerUnbindUpdateUIEventCallback');
  wxEvtHandlerUnbindUpdateUIEventCallback = wxEvtHandlerUnbindUpdateUIEventCallbackPtr.asFunction<WxEvtHandlerUnbindUpdateUIEventCallback>();

  // ------------------------- EVT_POPUP_WINDOW_DISMISS ----------------------

  final wxGetPopupWindowDismissEventTypePtr = dylib.lookup <NativeFunction<_WxGetPopupWindowDismissEventTypeNative>>('wxGetPopupWindowDismissEventType');
  wxGetPopupWindowDismissEventType = wxGetPopupWindowDismissEventTypePtr.asFunction<WxGetPopupWindowDismissEventType>();

  final wxEvtHandlerBindPopupWindowDismissEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindPopupWindowDismissEventCallbackNative>>('wxEvtHandlerBindPopupWindowDismissEventCallback');
  wxEvtHandlerBindPopupWindowDismissEventCallback = wxEvtHandlerBindPopupWindowDismissEventCallbackPtr.asFunction<WxEvtHandlerBindPopupWindowDismissEventCallback>();

  final wxEvtHandlerUnbindPopupWindowDismissEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindPopupWindowDismissEventCallbackNative>>('wxEvtHandlerUnbindPopupWindowDismissEventCallback');
  wxEvtHandlerUnbindPopupWindowDismissEventCallback = wxEvtHandlerUnbindPopupWindowDismissEventCallbackPtr.asFunction<WxEvtHandlerUnbindPopupWindowDismissEventCallback>();

  // ------------------------- EVT_GESTURE_PAN ----------------------

  final wxGetGesturePanEventTypePtr = dylib.lookup <NativeFunction<_WxGetGesturePanEventTypeNative>>('wxGetGesturePanEventType');
  wxGetGesturePanEventType = wxGetGesturePanEventTypePtr.asFunction<WxGetGesturePanEventType>();

  final wxEvtHandlerBindGesturePanEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindGesturePanEventCallbackNative>>('wxEvtHandlerBindGesturePanEventCallback');
  wxEvtHandlerBindGesturePanEventCallback = wxEvtHandlerBindGesturePanEventCallbackPtr.asFunction<WxEvtHandlerBindGesturePanEventCallback>();

  final wxEvtHandlerUnbindGesturePanEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindGesturePanEventCallbackNative>>('wxEvtHandlerUnbindGesturePanEventCallback');
  wxEvtHandlerUnbindGesturePanEventCallback = wxEvtHandlerUnbindGesturePanEventCallbackPtr.asFunction<WxEvtHandlerUnbindGesturePanEventCallback>();

  // ------------------------- EVT_GESTURE_ZOOM ----------------------

  final wxGetGestureZoomEventTypePtr = dylib.lookup <NativeFunction<_WxGetGestureZoomEventTypeNative>>('wxGetGestureZoomEventType');
  wxGetGestureZoomEventType = wxGetGestureZoomEventTypePtr.asFunction<WxGetGestureZoomEventType>();

  final wxEvtHandlerBindGestureZoomEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindGestureZoomEventCallbackNative>>('wxEvtHandlerBindGestureZoomEventCallback');
  wxEvtHandlerBindGestureZoomEventCallback = wxEvtHandlerBindGestureZoomEventCallbackPtr.asFunction<WxEvtHandlerBindGestureZoomEventCallback>();

  final wxEvtHandlerUnbindGestureZoomEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindGestureZoomEventCallbackNative>>('wxEvtHandlerUnbindGestureZoomEventCallback');
  wxEvtHandlerUnbindGestureZoomEventCallback = wxEvtHandlerUnbindGestureZoomEventCallbackPtr.asFunction<WxEvtHandlerUnbindGestureZoomEventCallback>();

  // ------------------------- EVT_SCROLLWIN_THUMBTRACK ----------------------

  final wxGetScrollWinEventTypePtr = dylib.lookup <NativeFunction<_WxGetScrollWinEventTypeNative>>('wxGetScrollWinEventType');
  wxGetScrollWinEventType = wxGetScrollWinEventTypePtr.asFunction<WxGetScrollWinEventType>();

  final wxEvtHandlerBindScrollWinEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindScrollWinEventCallbackNative>>('wxEvtHandlerBindScrollWinEventCallback');
  wxEvtHandlerBindScrollWinEventCallback = wxEvtHandlerBindScrollWinEventCallbackPtr.asFunction<WxEvtHandlerBindScrollWinEventCallback>();

  final wxEvtHandlerUnbindScrollWinEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindScrollWinEventCallbackNative>>('wxEvtHandlerUnbindScrollWinEventCallback');
  wxEvtHandlerUnbindScrollWinEventCallback = wxEvtHandlerUnbindScrollWinEventCallbackPtr.asFunction<WxEvtHandlerUnbindScrollWinEventCallback>();

  // ------------------------- EVT_DRAG_FEEDBACK ----------------------

  final wxGetDragFeedbackEventTypePtr = dylib.lookup <NativeFunction<_WxGetDragFeedbackEventTypeNative>>('wxGetDragFeedbackEventType');
  wxGetDragFeedbackEventType = wxGetDragFeedbackEventTypePtr.asFunction<WxGetDragFeedbackEventType>();

  final wxEvtHandlerBindDragFeedbackEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindDragFeedbackEventCallbackNative>>('wxEvtHandlerBindDragFeedbackEventCallback');
  wxEvtHandlerBindDragFeedbackEventCallback = wxEvtHandlerBindDragFeedbackEventCallbackPtr.asFunction<WxEvtHandlerBindDragFeedbackEventCallback>();

  final wxEvtHandlerUnbindDragFeedbackEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindDragFeedbackEventCallbackNative>>('wxEvtHandlerUnbindDragFeedbackEventCallback');
  wxEvtHandlerUnbindDragFeedbackEventCallback = wxEvtHandlerUnbindDragFeedbackEventCallbackPtr.asFunction<WxEvtHandlerUnbindDragFeedbackEventCallback>();

  // ------------------------- EVT_DROP_DATA ----------------------

  final wxGetDropDataEventTypePtr = dylib.lookup <NativeFunction<_WxGetDropDataEventTypeNative>>('wxGetDropDataEventType');
  wxGetDropDataEventType = wxGetDropDataEventTypePtr.asFunction<WxGetDropDataEventType>();

  final wxEvtHandlerBindDropDataEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindDropDataEventCallbackNative>>('wxEvtHandlerBindDropDataEventCallback');
  wxEvtHandlerBindDropDataEventCallback = wxEvtHandlerBindDropDataEventCallbackPtr.asFunction<WxEvtHandlerBindDropDataEventCallback>();

  final wxEvtHandlerUnbindDropDataEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindDropDataEventCallbackNative>>('wxEvtHandlerUnbindDropDataEventCallback');
  wxEvtHandlerUnbindDropDataEventCallback = wxEvtHandlerUnbindDropDataEventCallbackPtr.asFunction<WxEvtHandlerUnbindDropDataEventCallback>();

  // ------------------------- EVT_DROP_DROP ----------------------

  final wxGetDropDropEventTypePtr = dylib.lookup <NativeFunction<_WxGetDropDropEventTypeNative>>('wxGetDropDropEventType');
  wxGetDropDropEventType = wxGetDropDropEventTypePtr.asFunction<WxGetDropDropEventType>();

  final wxEvtHandlerBindDropDropEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindDropDropEventCallbackNative>>('wxEvtHandlerBindDropDropEventCallback');
  wxEvtHandlerBindDropDropEventCallback = wxEvtHandlerBindDropDropEventCallbackPtr.asFunction<WxEvtHandlerBindDropDropEventCallback>();

  final wxEvtHandlerUnbindDropDropEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindDropDropEventCallbackNative>>('wxEvtHandlerUnbindDropDropEventCallback');
  wxEvtHandlerUnbindDropDropEventCallback = wxEvtHandlerUnbindDropDropEventCallbackPtr.asFunction<WxEvtHandlerUnbindDropDropEventCallback>();

  // ------------------------- EVT_DROP_ENTER ----------------------

  final wxGetDropEnterEventTypePtr = dylib.lookup <NativeFunction<_WxGetDropEnterEventTypeNative>>('wxGetDropEnterEventType');
  wxGetDropEnterEventType = wxGetDropEnterEventTypePtr.asFunction<WxGetDropEnterEventType>();

  final wxEvtHandlerBindDropEnterEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindDropEnterEventCallbackNative>>('wxEvtHandlerBindDropEnterEventCallback');
  wxEvtHandlerBindDropEnterEventCallback = wxEvtHandlerBindDropEnterEventCallbackPtr.asFunction<WxEvtHandlerBindDropEnterEventCallback>();

  final wxEvtHandlerUnbindDropEnterEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindDropEnterEventCallbackNative>>('wxEvtHandlerUnbindDropEnterEventCallback');
  wxEvtHandlerUnbindDropEnterEventCallback = wxEvtHandlerUnbindDropEnterEventCallbackPtr.asFunction<WxEvtHandlerUnbindDropEnterEventCallback>();

  // ------------------------- EVT_DROP_LEAVE ----------------------

  final wxGetDropLeaveEventTypePtr = dylib.lookup <NativeFunction<_WxGetDropLeaveEventTypeNative>>('wxGetDropLeaveEventType');
  wxGetDropLeaveEventType = wxGetDropLeaveEventTypePtr.asFunction<WxGetDropLeaveEventType>();

  final wxEvtHandlerBindDropLeaveEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindDropLeaveEventCallbackNative>>('wxEvtHandlerBindDropLeaveEventCallback');
  wxEvtHandlerBindDropLeaveEventCallback = wxEvtHandlerBindDropLeaveEventCallbackPtr.asFunction<WxEvtHandlerBindDropLeaveEventCallback>();

  final wxEvtHandlerUnbindDropLeaveEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindDropLeaveEventCallbackNative>>('wxEvtHandlerUnbindDropLeaveEventCallback');
  wxEvtHandlerUnbindDropLeaveEventCallback = wxEvtHandlerUnbindDropLeaveEventCallbackPtr.asFunction<WxEvtHandlerUnbindDropLeaveEventCallback>();

  // ------------------------- EVT_DROP_DRAG_OVER ----------------------

  final wxGetDropDragOverEventTypePtr = dylib.lookup <NativeFunction<_WxGetDropDragOverEventTypeNative>>('wxGetDropDragOverEventType');
  wxGetDropDragOverEventType = wxGetDropDragOverEventTypePtr.asFunction<WxGetDropDragOverEventType>();

  final wxEvtHandlerBindDropDragOverEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindDropDragOverEventCallbackNative>>('wxEvtHandlerBindDropDragOverEventCallback');
  wxEvtHandlerBindDropDragOverEventCallback = wxEvtHandlerBindDropDragOverEventCallbackPtr.asFunction<WxEvtHandlerBindDropDragOverEventCallback>();

  final wxEvtHandlerUnbindDropDragOverEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindDropDragOverEventCallbackNative>>('wxEvtHandlerUnbindDropDragOverEventCallback');
  wxEvtHandlerUnbindDropDragOverEventCallback = wxEvtHandlerUnbindDropDragOverEventCallbackPtr.asFunction<WxEvtHandlerUnbindDropDragOverEventCallback>();

}

void releaseWxEvents()
{
  wxGestureEventNativeCallable.close();
  wxPanGestureEventNativeCallable.close();
  wxZoomGestureEventNativeCallable.close();
  wxMenuEventNativeCallable.close();
  wxSizeEventNativeCallable.close();
  wxVMEventNativeCallable.close();
  wxShowEventNativeCallable.close();
  wxWindowCreateEventNativeCallable.close();
  wxActivateEventNativeCallable.close();
  wxIdleEventNativeCallable.close();
  wxSysColourChangedEventNativeCallable.close();
  wxDPIChangedEventNativeCallable.close();
  wxUpdateUIEventNativeCallable.close();
  wxTimerEventNativeCallable.close();
  wxFocusEventNativeCallable.close();
  wxMoveEventNativeCallable.close();
  wxCloseEventNativeCallable.close();
  wxKeyEventNativeCallable.close();
  wxMouseEventNativeCallable.close();
  wxPaintEventNativeCallable.close();
  wxCommandEventNativeCallable.close();
  wxNotifyEventNativeCallable.close();
  wxInitDialogEventNativeCallable.close();
  wxDialogValidateEventNativeCallable.close();
  wxScrollWinEventNativeCallable.close();
  wxDragEventNativeCallable.close();
  wxDropEventNativeCallable.close();
}
