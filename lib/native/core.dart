
// -------------------------------------------------------------
// Purpose:     Dart bindings for wxWidgets
// Author:      Robert Roebling
// Modified by:
// Created:     07/01/2025
// Copyright:   (c) Robert Roebling
// Licence:     wxWindows licence 3.1
// -------------------------------------------------------------

part of '../wx_dart.dart';

// --------------- dynamic type to variantType -----------------

String wxDynamicTypeToVariantType( dynamic value ) {
  if (value is List) {
    return "list"; 
  } else
  if (value is bool) {
    return "bool"; 
  } else
  if (value is int) {
   return "long"; 
  } else
  if (value is String) {
   return "string"; 
  } else
  if (value is double) {
   return "double"; 
  } else
  if (value is WxBitmap) {
   return "bitmap"; 
  }
  return value.runtimeType.toString();
}

// ----------------- List to wxVectorVariant -------------------

WxVectorVariant wxListToVectorVariant( final List values )
{
  final variants = WxVectorVariant();
  for (dynamic value in values) {
      if (value is bool) {
        variants.addBool( value );
      } else 
      if (value is int) {
        variants.addLong( value );
      } else 
      if (value is String) {
        variants.addString( value );
      } else 
      if (value is double) {
        variants.addDouble( value );
      }
  }
  return variants;
}

dynamic wxVariantToDynamic( final WxVariant value )
{
  if (value.isType('bool')) {
    return value.getBool();
  }
  if (value.isType('double')) {
    return value.getDouble();
  }
  if (value.isType('string')) {
    return value.getString();
  }
  if (value.isType('long')) {
    return value.getLong();
  }
  return null;
}

WxVariant wxDynamicToVariant( final dynamic value )
{
  if (value is bool) {
    return WxVariant.fromBool(value); 
  }
  if (value is int) {
   return WxVariant.fromLong(value); 
  }
  if (value is String) {
   return WxVariant.fromString(value); 
  }
  if (value is double) {
   return WxVariant.fromDouble(value); 
  }
  return WxVariant();
}

// ----------------- List to wxVectorBitmapBundle -------------------

WxVectorBitmapBundle wxListBitmapBundleToVectorBitmapBundle( List<WxBitmapBundle>images ) 
{
  final ret = WxVectorBitmapBundle();
  for (final bundle in images) {
    ret.add( bundle );
  }
  return ret;
}

// ----------------- List to wxPointList -------------------

WxPointList wxListToPointList( List<WxPoint> points )
{
  final ret = WxPointList();
  ret.deleteContents(true);
  for (final point in points) {
    ret.add( point );
  }

  return ret;
}

// ----------------- List to wxRealPointList -------------------

WxRealPointList wxListToRealPointList( List<WxRealPoint> points )
{
  final ret = WxRealPointList();
  for (final point in points) {
    ret.add( point );
  }

  return ret;
}

// ------------------------- constants ----------------------

const int wxNO_IMAGE = -1;
const int wxNOT_FOUND = -1;

// ------------------------- wxSize ----------------------

final class WxSizeNative extends Struct {
  @Int32()
  external int x;
  @Int32()
  external int y;
}

// ------------------------- wxPoint ----------------------

final class WxPointNative extends Struct {
  @Int32()
  external int x;
  @Int32()
  external int y;
}

// ------------------------- WxTextExtent ----------------------

class WxTextExtent {
  const WxTextExtent( this.width, this.height, this.descent, this.externalLeading );
  final int width;
  final int height;
  final int descent;
  final int externalLeading;
}

final class WxTextExtentNative extends Struct {
  @Int32()
  external int width;
  @Int32()
  external int height;
  @Int32()
  external int descent;
  @Int32()
  external int externalLeading;
}

// ------------------------- wxRect ----------------------

final class WxRectNative extends Struct {
  @Int32()
  external int x;
  @Int32()
  external int y;
  @Int32()
  external int width;
  @Int32()
  external int height;
}

// ------------------------- wxPen ----------------------

final class WxPenNative extends Struct {
  @Uint32()
  external int rgba;
  @Int32()
  external int width;
  @Int32()
  external int style;
  @Int32()
  external int capStyle;
  @Int32()
  external int joinStyle;
}

// ------------------------- wxBrush ----------------------

final class WxBrushNative extends Struct {
  @Uint32()
  external int rgba;
  @Int32()
  external int style;
}

// ------------------------- wxCursor ----------------------

const int wxCURSOR_NONE = 0;
const int wxCURSOR_ARROW = 1;
const int wxCURSOR_RIGHT_ARROW = 2;
const int wxCURSOR_BULLSEYE = 3;
const int wxCURSOR_CHAR = 4;
const int wxCURSOR_CROSS = 5;
const int wxCURSOR_HAND = 6;
const int wxCURSOR_IBEAM = 7;
const int wxCURSOR_LEFT_BUTTON = 8;
const int wxCURSOR_MAGNIFIER = 9;
const int wxCURSOR_MIDDLE_BUTTON = 10;
const int wxCURSOR_NO_ENTRY = 11;
const int wxCURSOR_PAINT_BRUSH = 12;
const int wxCURSOR_PENCIL = 13;
const int wxCURSOR_POINT_LEFT = 14;
const int wxCURSOR_POINT_RIGHT = 15;
const int wxCURSOR_QUESTION_ARROW = 16;
const int wxCURSOR_RIGHT_BUTTON = 17;
const int wxCURSOR_SIZENESW = 18;
const int wxCURSOR_SIZENS = 19;
const int wxCURSOR_SIZENWSE = 20;
const int wxCURSOR_SIZEWE = 21;
const int wxCURSOR_SIZING = 22;
const int wxCURSOR_SPRAYCAN = 23;
const int wxCURSOR_WAIT = 24;
const int wxCURSOR_WATCH = 25;
const int wxCURSOR_DEFAULT = wxCURSOR_ARROW;


final wxSTANDARD_CURSOR = WxCursor( wxCURSOR_DEFAULT );
final wxHOURGLASS_CURSOR = WxCursor( wxCURSOR_WAIT );
final wxCROSSGLASS_CURSOR = WxCursor( wxCURSOR_CROSS );

// ------------------------- wxFont ----------------------

// ------------------------- wxObject ----------------------

typedef _WxGetNormalFontNative = Pointer Function();
typedef _WxGetNormalFont = Pointer Function();
late _WxGetNormalFont _wxGetNormalFont;

final wxNORMAL_FONT = WxFont.fromHandle( _wxGetNormalFont() );

typedef _WxGetSmallFontNative = Pointer Function();
typedef _WxGetSmallFont = Pointer Function();
late _WxGetSmallFont _wxGetSmallFont;

final wxSMALL_FONT = WxFont.fromHandle( _wxGetSmallFont() );

typedef _WxGetItalicFontNative = Pointer Function();
typedef _WxGetItalicFont = Pointer Function();
late _WxGetItalicFont _wxGetItalicFont;

final wxITALIC_FONT = WxFont.fromHandle( _wxGetItalicFont() );

// ------------------------- wxDataViewItem ----------------------

/*
class WxDataViewItem {
  WxDataViewItem.zero() {
    id = nullptr;
  }
  WxDataViewItem( this.id );
  late Pointer id;

  Pointer getId() {
    return id;
  }

  bool isOk() {
    return id != nullptr;
  }
}

final class WxDataViewItemNative extends Struct {
  external Pointer id;
}

*/

// ------------------------- wxTreeItemId ----------------------

class WxTreeItemId {
  WxTreeItemId.zero() {
    id = nullptr;
  }
  WxTreeItemId( this.id );
  late Pointer id;

  Pointer getId() {
    return id;
  }

  bool isOk() {
    return id != nullptr;
  }

  void unset() {
    id = nullptr;
  }
}

final class WxTreeItemIdNative extends Struct {
  external Pointer id;
}

// ----------- appearance (light/dark mode) ------------

const int wxAPPEARANCE_SYSTEM = 0;
const int wxAPPEARANCE_LIGHT = 1;
const int wxAPPEARANCE_DARK = 2;

const int wxAPPEARANCE_RESULT_FAILURE = 0;
const int wxAPPEARANCE_RESULT_OK = 1;
const int wxAPPEARANCE_RESULT_CANNOT_CHANGE = 2;

// ------------------------- wxPaintDC ---------------------

WxPaintDC? _thePaintDC;
WxGraphicsContext? _theGraphicsContext;

// ------------------------- wxClass ----------------------

abstract class WxClass implements Finalizable {
  WxClass();
  WxClass._defaultConstructor();
  WxClass.fromHandle( Pointer handle ) {
    nativeHandle = handle;
    ownsHandle = false;
  }

  void attachFinalizer() {
  }

  void detachFinalizer() {
  }

  void dispose() {
  } 

  void forceNativeDestroy() {
    if (hasFinalizer) {
      detachFinalizer();
    }

    if (ownsHandle) {
      ownsHandle = false;
      if (nativeHandle == nullptr) {
        wxLogError( "Called native destroy for $runtimeType, but nativeHandle is nullptr" );
      }
      nativeDestroy();
    }
  } 

  void nativeDestroy() {
    print( "Empty nativeDestroy called in $runtimeType" );
  }

  void printName() {
    print( "name: $runtimeType" );
  }
  late Pointer nativeHandle;
  bool ownsHandle = true;
  bool hasFinalizer = false;
}

// ------------------------- wxObject ----------------------

typedef WxObjectConstructorNative = Pointer Function();
typedef WxObjectConstructor = Pointer Function();
late WxObjectConstructor wxObjectConstructor;

typedef WxObjectDestructorNative = Pointer Function( Pointer );
typedef WxObjectDestructor = Pointer Function( Pointer );
late WxObjectDestructor wxObjectDestructor;

typedef WxObjectPrintNameNative = Void Function( Pointer );
typedef WxObjectPrintName = void Function( Pointer );
late WxObjectPrintName wxObjectPrintName;

typedef WxObjectGetNameFromCppClassNative = Pointer<Utf8> Function( Pointer  );
typedef WxObjectGetNameFromCppClass = Pointer<Utf8> Function( Pointer  );
late WxObjectGetNameFromCppClass wxObjectGetNameFromCppClass;

typedef WxObjectFinalizerNative = Void Function( Pointer );
// typedef WxObjectFinalizer = void Function( Pointer );
// late WxObjectFinalizer wxObjectFinalizer;
late NativeFinalizer _wxObjectNativeFinalizer;


class WxObject extends WxClass {
  WxObject();
  WxObject._defaultConstructor();
  WxObject.create() { 
    // should create() be called from the default constructor for
    // Dart classes deriving directly from WxObject? TODO
    nativeHandle = wxObjectConstructor();
  }
  WxObject.fromHandle( Pointer handle ) {
    nativeHandle = handle;
    ownsHandle = false;
  }

  @override
  void attachFinalizer() {
    hasFinalizer = true;
    _wxObjectNativeFinalizer.attach( this, nativeHandle.cast(), detach: this );
  }

  @override
  void detachFinalizer() {
    hasFinalizer = false;
    _wxObjectNativeFinalizer.detach( this );
  }

  @override
  void nativeDestroy() {
      nativeHandle = wxObjectDestructor( nativeHandle );
  }

  @override
  void printName() {
    wxObjectPrintName( nativeHandle );
  }

  String getNameFromCppClass() {
    Pointer<Utf8> ptrReturn = wxObjectGetNameFromCppClass( nativeHandle  );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }
}

// ------------------------- wxEvent ----------------------

typedef _WxEventGetEventTypeNative = Int32 Function( Pointer );
typedef _WxEventGetEventType = int Function( Pointer );
late _WxEventGetEventType _wxEventGetEventType;

typedef _WxEventGetIdNative = Int32 Function( Pointer );
typedef _WxEventGetId = int Function( Pointer );
late _WxEventGetId _wxEventGetId;

typedef _WxEventSkipNative = Void Function( Pointer, Bool );
typedef _WxEventSkip = void Function( Pointer, bool );
late _WxEventSkip _wxEventSkip;

typedef _WxEventGetSkippedNative = Bool Function( Pointer );
typedef _WxEventGetSkipped = bool Function( Pointer );
late _WxEventGetSkipped _wxEventGetSkipped;

typedef _WxEventSetEventObjectNative = Void Function( Pointer, Pointer );
typedef _WxEventSetEventObject = void Function( Pointer, Pointer );
late _WxEventSetEventObject _wxEventSetEventObject;

typedef _WxEventGetEventObjectNative = Pointer Function( Pointer );
typedef _WxEventGetEventObject = Pointer Function( Pointer );
late _WxEventGetEventObject _wxEventGetEventObject;

typedef _WxEventResumePropagationNative = Void Function( Pointer, Int32 );
typedef _WxEventResumePropagation = void Function( Pointer, int );
late _WxEventResumePropagation _wxEventResumePropagation;

typedef _WxEventStopPropagationNative = Int32 Function( Pointer );
typedef _WxEventStopPropagation = int Function( Pointer );
late _WxEventStopPropagation _wxEventStopPropagation;

const int wxEVENT_PROPAGATE_NONE = 0;

class WxEvent extends WxObject {
  WxEvent();
  WxEvent._defaultConstructor();

  int getEventType() {
    return _wxEventGetEventType( nativeHandle );
  }

  int getId() {
    return _wxEventGetId( nativeHandle );
  }

  void skip( { bool skip = true } ) {
    _wxEventSkip( nativeHandle, skip );
  }

  bool getSkipped() {
    return _wxEventGetSkipped( nativeHandle ) ;
  }

  void setEventObject( WxObject object ) {
    _wxEventSetEventObject( nativeHandle, object.nativeHandle );
  }

  WxObject? getEventObject() {
    final ptr = _wxEventGetEventObject( nativeHandle );
    if (ptr == nullptr) return null;
    WxEvtHandler? eh = _evtHandlerList[ptr];
    if (eh != null) {
      // There already is a Dart class associated with this C++ object
      return eh;
    }
    return WxObject.fromHandle( ptr );
  }

  int getPropagationLevel() {
    int result = _wxEventStopPropagation( nativeHandle );
    _wxEventResumePropagation( nativeHandle, result );
    return result;
  }

  int stopPropagation() {
    return _wxEventStopPropagation( nativeHandle );
  }

  void resumePropagation( int level ) {
    _wxEventResumePropagation( nativeHandle, level );
  }
}

// ------------------------- utils ----------------------

WxWindow wxCreateBestMatchingClassFromWxWindowHandle( Pointer handle )
{
  Pointer<Utf8> ptrReturn = wxObjectGetNameFromCppClass( handle  );
  final String name = ptrReturn.toDartString();
  malloc.free( ptrReturn );

  late WxWindow ret;

  if (name == "wxPanel") {
    ret = WxPanel.fromHandle( handle );
  } else {
    if (name != "wxWindow") {
      print( "Classname in MatchingClassFromWxWindowHandle: $name" );
    }
    ret = WxWindow.fromHandle(handle );
  }
  _evtHandlerList[handle] = ret;

  return ret;
}

// ------------------------- wxNewEventType ----------------------

const int wxFIRST_CUSTOM_EVENT_TYPE = 5000;
int wxLastEventType = wxFIRST_CUSTOM_EVENT_TYPE + 1000;

int wxNewEventType() {
  wxLastEventType++;
  return wxLastEventType;
}

// ------------------------- wxClientData ----------------------

Map<Pointer, dynamic> _clientDataList = {};

typedef _WxClientDataConstructorNative = Pointer Function();
typedef _WxClientDataConstructor = Pointer Function();
late _WxClientDataConstructor _wxClientDataConstructor;

// wxDartClientData::destructor

typedef _WxInstallDartClientDataDestructorCallbackNative = Void Function( Pointer );
typedef _WxInstallDartClientDataDestructorCallback = void Function( Pointer );
late _WxInstallDartClientDataDestructorCallback _wxInstallDartClientDataDestructorCallback;

typedef _WxClientDataDestructorCallbackNative = Void Function( Pointer );
void _wxClientDataDestructorCallback( Pointer nativeHandle )
{
  _clientDataList.remove( nativeHandle );
}
late NativeCallable<Void Function( Pointer )> _wxClientDataDestructorNativeCallable;

// ------------------------- wxTreeItemData ----------------------

typedef _WxTreeItemDataConstructorNative = Pointer Function();
typedef _WxTreeItemDataConstructor = Pointer Function();
late _WxTreeItemDataConstructor _wxTreeItemDataConstructor;

// wxTreeItemData::destructor

typedef _WxInstallDartTreeItemDataDestructorCallbackNative = Void Function( Pointer );
typedef _WxInstallDartTreeItemDataDestructorCallback = void Function( Pointer );
late _WxInstallDartTreeItemDataDestructorCallback _wxInstallDartTreeItemDataDestructorCallback;

typedef _WxTreeItemDataDestructorCallbackNative = Void Function( Pointer );
void _wxTreeItemDataDestructorCallback( Pointer nativeHandle )
{
  _clientDataList.remove( nativeHandle );
}
late NativeCallable<Void Function( Pointer )> _wxTreeItemDataDestructorNativeCallable;

// ------------------------- wxEvtHandler ----------------------

typedef _WxEvtHandlerConstructorNative = Pointer Function();
typedef _WxEvtHandlerConstructor = Pointer Function();
late _WxEvtHandlerConstructor _wxEvtHandlerConstructor;

typedef _WxEvtHandlerProcessEventNative = Bool Function( Pointer, Pointer );
typedef _WxEvtHandlerProcessEvent = bool Function( Pointer, Pointer );
late _WxEvtHandlerProcessEvent _wxEvtHandlerProcessEvent;

typedef _WxEvtHandlerAttachClientDataNative = Void Function( Pointer );
typedef _WxEvtHandlerAttachClientData = void Function( Pointer );
late _WxEvtHandlerAttachClientData _wxEvtHandlerAttachClientData;

Map<Pointer, WxEvtHandler> _evtHandlerList = {};

// wxEvtHandler::destructor

typedef _WxInstallDartEvtHandlerDestructorCallbackNative = Void Function( Pointer );
typedef _WxInstallDartEvtHandlerDestructorCallback = void Function( Pointer );
late _WxInstallDartEvtHandlerDestructorCallback _wxInstallDartEvtHandlerDestructorCallback;

typedef _WxEvtHandlerDestructorCallbackNative = Void Function( Pointer );
void _wxEvtHandlerDestructorCallback( Pointer nativeHandle ) {
  WxEvtHandler? eh = _evtHandlerList[nativeHandle];
  if (eh == null) {
    wxLogError( "WxEvtHandler dispose not found" );
  }
  eh!.disposeFromCpp();
}
late NativeCallable<Void Function( Pointer )> _wxEvtHandlerDestructorNativeCallable;

// ------------------------- ---------- ----------------------

abstract class WxEventTableEntry {
  WxEventTableEntry( this.eventType, this.id );
  final int eventType;
  final int id;

  bool matches( int eventTypeTested, int idTested );

  void doCallFunction( WxEvent event );
}

typedef WxEventTable = List<WxEventTableEntry>;


class WxEvtHandler extends WxObject {
  WxEvtHandler._defaultConstructor();
  WxEvtHandler() {
    nativeHandle = _wxEvtHandlerConstructor();
    _postCreation();
  }

  final WxEventTable _eventTable = [];

  WxEventTable getEventTable() {
    return _eventTable;
  }

  void _postCreation() {
    _evtHandlerList[nativeHandle] = this;
    _wxEvtHandlerAttachClientData( nativeHandle );
  }

  void onInternalIdle() {
  }

  bool _propagate( WxEvent event )
  {
    if ((this is WxWindow) && (this is! WxTopLevelWindow)) {
        WxWindow window = this as WxWindow;
        WxWindow? parent = window.getParent();
        if (parent != null) {
          if (parent.processEvent(event)) {
            return true;
          }
        }
    }
    return false;
  }

  bool processEvent( WxEvent event )
  {
    if (event.getEventType() >= wxFIRST_CUSTOM_EVENT_TYPE)
    {
      // go backwards to allow overloading
      for (int i = _eventTable.length-1; i >= 0; i--) {
        final entry = _eventTable[i];
        if (entry.matches(event.getEventType(), event.getId())) {
          event.skip( skip: false );
          entry.doCallFunction(event);
          if (!event.getSkipped()) return true;
        }
      }

      if (_propagate(event)) {
        return true;
      }

      return false;
    }

    return _wxEvtHandlerProcessEvent( nativeHandle, event.nativeHandle );
  }

  void disconnectAll()
  {
    wxGestureEventHandlerList.remove(nativeHandle); // remove later
    wxZoomGestureEventHandlerList.remove(nativeHandle);
    wxPanGestureEventHandlerList.remove(nativeHandle);
    wxActivateEventHandlerList.remove(nativeHandle);
    wxMouseEventHandlerList.remove(nativeHandle);
    wxKeyEventHandlerList.remove(nativeHandle);
    wxFocusEventHandlerList.remove(nativeHandle);
    wxIdleEventHandlerList.remove(nativeHandle);
    wxTimerEventHandlerList.remove(nativeHandle);
    // wxScrollEventHandlerList.remove(nativeHandle);
    wxScrollWinEventHandlerList.remove(nativeHandle);
    wxCloseEventHandlerList.remove(nativeHandle);
    wxWindowCreateEventHandlerList.remove(nativeHandle);
    wxPaintEventHandlerList.remove(nativeHandle);
    wxSizeEventHandlerList.remove(nativeHandle);
    wxMoveEventHandlerList.remove(nativeHandle);
    wxShowEventHandlerList.remove(nativeHandle);
    wxMenuEventHandlerList.remove(nativeHandle);
    wxCommandEventHandlerList.remove(nativeHandle);
    wxSpinEventHandlerList.remove(nativeHandle);
    wxSpinDoubleEventHandlerList.remove(nativeHandle);
    wxNotifyEventHandlerList.remove(nativeHandle);
    wxUpdateUIEventHandlerList.remove(nativeHandle);
    wxInitDialogEventHandlerList.remove(nativeHandle);
    wxDialogValidateEventHandlerList.remove(nativeHandle);
    wxTreeEventHandlerList.remove(nativeHandle);
    wxSplitterEventHandlerList.remove(nativeHandle);
    wxNotebookEventHandlerList.remove(nativeHandle);
    wxHtmlLinkEventHandlerList.remove(nativeHandle);
    wxHyperlinkEventHandlerList.remove(nativeHandle);
    wxDPIChangedEventHandlerList.remove(nativeHandle);
    wxSysColourChangedEventHandlerList.remove(nativeHandle);
    wxCollapsiblePaneEventHandlerList.remove(nativeHandle);
    wxDragEventHandlerList.remove(nativeHandle);
    wxDropEventHandlerList.remove(nativeHandle);
    wxVMEventHandlerList.remove(nativeHandle);

    _evtHandlerList.remove(nativeHandle);
  }

  void disposeFromCpp() {
    // Window or event handler is being destroyed from C++, e.g. using wxWindow::Destroy()
    // Call dispose() now for cleanup
    // print( "disposeFromCpp from $runtimeType, call dispose() now for cleanup" );
    dispose();

    if (hasFinalizer) {
      detachFinalizer();
    }

    disconnectAll();
    ownsHandle = false; 
    // C++ object will get deleted directly afterwards
  } 


  @override
  void dispose() {
    // print( "dispose from $runtimeType" );
    // window or event handler was destroyed from wxDart, e.g. using WxWindow::dispose()

    // this will delete the C++ object which in turn will call disposeFromCpp
    super.dispose(); 
  } 
}

// ------------------------- wxApp ----------------------

// ------------------------- wxSystemAppearance ----------------------

typedef _WxSystemAppearanceGetNameNative = Pointer<Utf8> Function( Pointer  );
typedef _WxSystemAppearanceGetName = Pointer<Utf8> Function( Pointer  );
late _WxSystemAppearanceGetName _wxSystemAppearanceGetName;

typedef _WxSystemAppearanceIsDarkNative = Bool Function( Pointer  );
typedef _WxSystemAppearanceIsDark = bool Function( Pointer  );
late _WxSystemAppearanceIsDark _wxSystemAppearanceIsDark;

typedef _WxSystemAppearanceIsUsingDarkBackgroundNative = Bool Function( Pointer  );
typedef _WxSystemAppearanceIsUsingDarkBackground = bool Function( Pointer  );
late _WxSystemAppearanceIsUsingDarkBackground _wxSystemAppearanceIsUsingDarkBackground;


typedef _WxAppConstructorNative = Pointer Function();
typedef _WxAppConstructor = Pointer Function();
late _WxAppConstructor _wxAppConstructor;

typedef _WxAppDestructorNative = Void Function( Pointer );
typedef _WxAppDestructor = void Function( Pointer );
late _WxAppDestructor _wxAppDestructor;

typedef _WxAppRunNative = Void Function( Pointer );
typedef _WxAppRun = void Function( Pointer );
late _WxAppRun _wxAppRun;

typedef _WxAppSetAppNameNative = Void Function( Pointer, Pointer<Utf8> );
typedef _WxAppSetAppName = void Function( Pointer, Pointer<Utf8> );
late _WxAppSetAppName _wxAppSetAppName;

typedef _WxAppGetAppNameNative = Pointer<Utf8> Function( Pointer  );
typedef _WxAppGetAppName = Pointer<Utf8> Function( Pointer  );
late _WxAppGetAppName _wxAppGetAppName;

typedef _WxAppSetAppDisplayNameNative = Void Function( Pointer, Pointer<Utf8> );
typedef _WxAppSetAppDisplayName = void Function( Pointer, Pointer<Utf8> );
late _WxAppSetAppDisplayName _wxAppSetAppDisplayName;

typedef _WxAppGetAppDisplayNameNative = Pointer<Utf8> Function( Pointer  );
typedef _WxAppGetAppDisplayName = Pointer<Utf8> Function( Pointer  );
late _WxAppGetAppDisplayName _wxAppGetAppDisplayName;

typedef _WxAppSetAppearanceNative = Int32 Function( Pointer, Int32 mode );
typedef _WxAppSetAppearance = int Function( Pointer, int mode );
late _WxAppSetAppearance _wxAppSetAppearance;

typedef _WxAppGetTopWindowNative = Pointer Function( Pointer  );
typedef _WxAppGetTopWindow = Pointer Function( Pointer  );
late _WxAppGetTopWindow _wxAppGetTopWindow;

typedef _WxAppSetTopWindowNative = Void Function( Pointer, Pointer  );
typedef _WxAppSetTopWindow = void Function( Pointer, Pointer  );
late _WxAppSetTopWindow _wxAppSetTopWindow;

late WxApp wxTheApp;

// wxApp::OnInit

typedef _WxInstallDartAppOnInitCallbackNative = Void Function( Pointer );
typedef _WxInstallDartAppOnInitCallback = void Function( Pointer );
late _WxInstallDartAppOnInitCallback _wxInstallDartAppOnInitCallback;

typedef _WxAppOnInitCallbackNative = Bool Function( Pointer );
bool _wxAppOnInitCallback( Pointer app )
{
  wxTheApp.nativeHandle = app;
  wxTheApp.ownsHandle = true;
  return wxTheApp.onInit();
}
late NativeCallable<Bool Function( Pointer )> _wxAppOnInitNativeCallable;

// wxApp::OnExit

typedef _WxInstallDartAppOnExitCallbackNative = Void Function( Pointer );
typedef _WxInstallDartAppOnExitCallback = void Function( Pointer );
late _WxInstallDartAppOnExitCallback _wxInstallDartAppOnExitCallback;

typedef _WxAppOnExitCallbackNative = Int32 Function();
int _wxAppOnExitCallback()
{
  return wxTheApp.onExit();
}

late NativeCallable<Int32 Function()> _wxAppOnExitNativeCallable;

// wxApp

class WxApp extends WxEvtHandler {
  WxApp() : super._defaultConstructor() 
  {
    WidgetsFlutterBinding.ensureInitialized();
    
    loadLibraryOpenGL();
    
    wxTheApp = this;
    String path = './libwxdart.dylib';
    if (Platform.isLinux) {
      path = './libwxdart.so';
    } else
    if (Platform.isWindows) {
      path = './libwxdart.dll';
    }
    final dylib = DynamicLibrary.open( path );
    setupWxUtils( dylib );
    setupWxCore( dylib );
    setupWxMisc( dylib );
    setupWxEvents( dylib );
    setupWxGdi( dylib );
    setupWxWindows( dylib );
    setupWxMenus( dylib );
    setupWxSizer( dylib );
    setupWxControls( dylib );
    setupWxControls2( dylib );
    setupWxGlContext( dylib );
    setupWxBooks( dylib );

    nativeHandle = _wxAppConstructor();

    if (wxIsMac()) {
      _secondaryAccent = wxGetSystemSettings().getColour( wxSYS_COLOUR_HIGHLIGHT );  // wxSYS_COLOUR_LISTBOXHIGHLIGHT
      _primaryAccent = wxGetSystemSettings().getColour( wxSYS_COLOUR_HIGHLIGHT );
    } else {
      _secondaryAccent = wxGetSystemSettings().getColour( wxSYS_COLOUR_HIGHLIGHT );
      _primaryAccent = _secondaryAccent.changeLightness(130);
    }
  }

  void run()
  {
    _wxAppRun( nativeHandle );
  }

  bool onInit() {
    return true;
  }

  int onExit() {
    return 0;
  }

  @override
  void nativeDestroy() {
    // same as wxObjectDestructor and thus not really necessary
    _wxAppDestructor( nativeHandle );
  }

  @override
  void dispose() {
      releaseWxCoreEventHandlers();
      releaseWxEvents();
      releaseWxControls();
      releaseWxControls2();
      releaseWxBooks();
      super.dispose();
      forceNativeDestroy();
  } 

  static WxWindow? getMainTopWindow() {
    return wxTheApp.getTopWindow();
  }

  WxWindow? getTopWindow( ) {
    final returnedNativeHandle = _wxAppGetTopWindow( nativeHandle  );
    if (returnedNativeHandle == nullptr) return null;
    WxEvtHandler? eh = _evtHandlerList[returnedNativeHandle];
    if (eh != null) {
      // There already is a Dart class associated with this C++ object
      return eh as WxWindow;
    }
    return wxCreateBestMatchingClassFromWxWindowHandle( returnedNativeHandle );
  }

  void setTopWindow( WxWindow window ) {
    _wxAppSetTopWindow( nativeHandle, window.nativeHandle );
  }
  
  void setAppName( String name ) {
    final textUtf8 = name.toNativeUtf8();
    _wxAppSetAppName( nativeHandle, textUtf8 );
    malloc.free( textUtf8 );
  } 

  String getAppName() {
    Pointer<Utf8> ptrReturn = _wxAppGetAppName( nativeHandle  );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }

  void setAppDisplayName( String name ) {
    final textUtf8 = name.toNativeUtf8();
    _wxAppSetAppDisplayName( nativeHandle, textUtf8 );
    malloc.free( textUtf8 );
  } 

  String getAppDisplayName() {
    Pointer<Utf8> ptrReturn = _wxAppGetAppDisplayName( nativeHandle  );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }

  String getApearanceName( ) {
    Pointer<Utf8> ptrReturn = _wxSystemAppearanceGetName( nativeHandle  );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }

  bool isTouch() {
    return false;
  }

  bool isDark( ) {
    return _wxSystemAppearanceIsDark( nativeHandle  );
  }

  bool isUsingDarkBackground( ) {
    return _wxSystemAppearanceIsUsingDarkBackground( nativeHandle  );
  }

  int setAppearance( int mode ) {
    final ret = _wxAppSetAppearance( nativeHandle, mode );
    _updateTheme();
    return ret;
  }

  void _updateTheme()
  {
  }

  WxColour getColourOnAccent([WxColour? background]) {
    return (background ?? getAccentColour()).getContrastingColour();
  }

  WxColour _primaryAccent = wxBLUE;
  WxColour _secondaryAccent = wxBLUE;

  void setAccentColour( WxColour accent ) {
    _primaryAccent = accent;
    _secondaryAccent = accent.changeLightness(50);
  }

  WxColour getAccentColour() {
    return _primaryAccent;
  }
  WxColour getPrimaryAccentColour() {
    return (isDark()) ? _secondaryAccent : _primaryAccent;
  }
  WxColour getSecondaryAccentColour() {
    return (!isDark()) ? _secondaryAccent : _primaryAccent;
  }
}


void setupWxCore( DynamicLibrary dylib )
{
// ------------------------- wxFont ----------------------

  final wxGetNormalFontPtr = dylib.lookup <NativeFunction<_WxGetNormalFontNative>>('wxGetNormalFont');
  _wxGetNormalFont = wxGetNormalFontPtr.asFunction<_WxGetNormalFont>();
  final wxGetSmallFontPtr = dylib.lookup <NativeFunction<_WxGetSmallFontNative>>('wxGetSmallFont');
  _wxGetNormalFont = wxGetSmallFontPtr.asFunction<_WxGetSmallFont>();
  final wxGetItalicFontPtr = dylib.lookup <NativeFunction<_WxGetItalicFontNative>>('wxGetItalicFont');
  _wxGetItalicFont = wxGetItalicFontPtr.asFunction<_WxGetItalicFont>();

// ------------------------- wxObject ----------------------

  final wxObjectConstructorPtr = dylib.lookup <NativeFunction<WxObjectConstructorNative>>('WxObjectConstructor');
  wxObjectConstructor = wxObjectConstructorPtr.asFunction<WxObjectConstructor>();

  final wxObjectDestructorPtr = dylib.lookup <NativeFunction<WxObjectDestructorNative>>('WxObjectDestructor');
  wxObjectDestructor = wxObjectDestructorPtr.asFunction<WxObjectDestructor>();

  final wxObjectPrintNamePtr = dylib.lookup <NativeFunction<WxObjectPrintNameNative>>('WxObjectPrintName');
  wxObjectPrintName = wxObjectPrintNamePtr.asFunction<WxObjectPrintName>();

  final wxObjectGetNameFromCppClassPtr = dylib.lookup <NativeFunction<WxObjectGetNameFromCppClassNative>>('WxObjectGetNameFromCppClass');
  wxObjectGetNameFromCppClass = wxObjectGetNameFromCppClassPtr.asFunction<WxObjectGetNameFromCppClass>();

  final wxObjectFinalizerPtr = dylib.lookup <NativeFunction<WxObjectFinalizerNative>>('WxObjectFinalizer');
  _wxObjectNativeFinalizer = NativeFinalizer( wxObjectFinalizerPtr.cast() );  

// ------------------------- wxClientData ----------------------

  final wxClientDataConstructorPtr = dylib.lookup <NativeFunction<_WxClientDataConstructorNative>>('WxClientDataConstructor');
  _wxClientDataConstructor = wxClientDataConstructorPtr.asFunction<_WxClientDataConstructor>();

  // destructor

  final wxInstallDartClientDataDestructorCallbackPtr = dylib.lookup <NativeFunction<_WxInstallDartClientDataDestructorCallbackNative>>('WxInstallDartClientDataDestructorCallback');
  _wxInstallDartClientDataDestructorCallback = wxInstallDartClientDataDestructorCallbackPtr.asFunction<_WxInstallDartClientDataDestructorCallback>();

  _wxClientDataDestructorNativeCallable = NativeCallable<_WxClientDataDestructorCallbackNative>.isolateLocal( _wxClientDataDestructorCallback );
  _wxInstallDartClientDataDestructorCallback( _wxClientDataDestructorNativeCallable.nativeFunction );

// ------------------------- wxTreeItemData ----------------------

  final wxTreeItemDataConstructorPtr = dylib.lookup <NativeFunction<_WxTreeItemDataConstructorNative>>('WxTreeItemDataConstructor');
  _wxTreeItemDataConstructor = wxTreeItemDataConstructorPtr.asFunction<_WxTreeItemDataConstructor>();

  // destructor

  final wxInstallDartTreeItemDataDestructorCallbackPtr = dylib.lookup <NativeFunction<_WxInstallDartTreeItemDataDestructorCallbackNative>>('WxInstallDartTreeItemDataDestructorCallback');
  _wxInstallDartTreeItemDataDestructorCallback = wxInstallDartTreeItemDataDestructorCallbackPtr.asFunction<_WxInstallDartTreeItemDataDestructorCallback>();

  _wxTreeItemDataDestructorNativeCallable = NativeCallable<_WxTreeItemDataDestructorCallbackNative>.isolateLocal( _wxTreeItemDataDestructorCallback );
  _wxInstallDartTreeItemDataDestructorCallback( _wxTreeItemDataDestructorNativeCallable.nativeFunction );

// ------------------------- wxEvtHandler ----------------------

  final wxEvtHandlerConstructorPtr = dylib.lookup <NativeFunction<_WxEvtHandlerConstructorNative>>('WxEvtHandlerConstructor');
  _wxEvtHandlerConstructor = wxEvtHandlerConstructorPtr.asFunction<_WxEvtHandlerConstructor>();

  final wxEvtHandlerProcessEventPtr = dylib.lookup <NativeFunction<_WxEvtHandlerProcessEventNative>>('WxEvtHandlerProcessEvent');
  _wxEvtHandlerProcessEvent = wxEvtHandlerProcessEventPtr.asFunction<_WxEvtHandlerProcessEvent>();

  final wxEvtHandlerAttachClientDataPtr = dylib.lookup <NativeFunction<_WxEvtHandlerAttachClientDataNative>>('WxEvtHandlerAttachClientData');
  _wxEvtHandlerAttachClientData = wxEvtHandlerAttachClientDataPtr.asFunction<_WxEvtHandlerAttachClientData>();

  // destructor

  final wxInstallDartEvtHandlerDestructorCallbackPtr = dylib.lookup <NativeFunction<_WxInstallDartEvtHandlerDestructorCallbackNative>>('WxInstallDartEvtHandlerDestructorCallback');
  _wxInstallDartEvtHandlerDestructorCallback = wxInstallDartEvtHandlerDestructorCallbackPtr.asFunction<_WxInstallDartEvtHandlerDestructorCallback>();

  _wxEvtHandlerDestructorNativeCallable = NativeCallable<_WxEvtHandlerDestructorCallbackNative>.isolateLocal( _wxEvtHandlerDestructorCallback );
  _wxInstallDartEvtHandlerDestructorCallback( _wxEvtHandlerDestructorNativeCallable.nativeFunction );

// ------------------------- wxEvent ----------------------

  final wxEventGetEventTypePtr = dylib.lookup <NativeFunction<_WxEventGetEventTypeNative>>('WxEventGetEventType');
  _wxEventGetEventType = wxEventGetEventTypePtr.asFunction<_WxEventGetEventType>();

  final wxEventGetIdPtr = dylib.lookup <NativeFunction<_WxEventGetIdNative>>('WxEventGetId');
  _wxEventGetId = wxEventGetIdPtr.asFunction<_WxEventGetId>();

  final wxEventSkipPtr = dylib.lookup <NativeFunction<_WxEventSkipNative>>('WxEventSkip');
  _wxEventSkip = wxEventSkipPtr.asFunction<_WxEventSkip>();

  final wxEventGetSkippedPtr = dylib.lookup <NativeFunction<_WxEventGetSkippedNative>>('WxEventGetSkipped');
  _wxEventGetSkipped = wxEventGetSkippedPtr.asFunction<_WxEventGetSkipped>();

  final wxEventSetEventObjectPtr = dylib.lookup <NativeFunction<_WxEventSetEventObjectNative>>('WxEventSetEventObject');
  _wxEventSetEventObject = wxEventSetEventObjectPtr.asFunction<_WxEventSetEventObject>();

  final wxEventGetEventObjectPtr = dylib.lookup <NativeFunction<_WxEventGetEventObjectNative>>('WxEventGetEventObject');
  _wxEventGetEventObject = wxEventGetEventObjectPtr.asFunction<_WxEventGetEventObject>();

  final wxEventResumePropagationPtr = dylib.lookup <NativeFunction<_WxEventResumePropagationNative>>('WxEventResumePropagation');
  _wxEventResumePropagation = wxEventResumePropagationPtr.asFunction<_WxEventResumePropagation>();

  final wxEventStopPropagationPtr = dylib.lookup <NativeFunction<_WxEventStopPropagationNative>>('WxEventStopPropagation');
  _wxEventStopPropagation = wxEventStopPropagationPtr.asFunction<_WxEventStopPropagation>();

// ------------------------- wxApp ----------------------

  final wxAppConstructorPtr = dylib.lookup <NativeFunction<_WxAppConstructorNative>>('WxAppConstructor');
  _wxAppConstructor = wxAppConstructorPtr.asFunction<_WxAppConstructor>();

  final wxAppDestructorPtr = dylib.lookup <NativeFunction<_WxAppDestructorNative>>('WxAppDestructor');
  _wxAppDestructor = wxAppDestructorPtr.asFunction<_WxAppDestructor>();

  final wxAppRunPtr = dylib.lookup <NativeFunction<_WxAppRunNative>>('WxAppRun');
  _wxAppRun = wxAppRunPtr.asFunction<_WxAppRun>();

  final wxAppSetAppNamePtr = dylib.lookup <NativeFunction<_WxAppSetAppNameNative>>('WxAppSetAppName');
  _wxAppSetAppName = wxAppSetAppNamePtr.asFunction<_WxAppSetAppName>();

  final wxAppGetAppNamePtr = dylib.lookup <NativeFunction<_WxAppGetAppNameNative>>('WxAppGetAppName');
  _wxAppGetAppName = wxAppGetAppNamePtr.asFunction<_WxAppGetAppName>();

  final wxAppSetAppDisplayNamePtr = dylib.lookup <NativeFunction<_WxAppSetAppDisplayNameNative>>('WxAppSetAppDisplayName');
  _wxAppSetAppDisplayName = wxAppSetAppDisplayNamePtr.asFunction<_WxAppSetAppDisplayName>();

  final wxAppGetAppDisplayNamePtr = dylib.lookup <NativeFunction<_WxAppGetAppDisplayNameNative>>('WxAppGetAppDisplayName');
  _wxAppGetAppDisplayName = wxAppGetAppDisplayNamePtr.asFunction<_WxAppGetAppDisplayName>();

  final wxAppSetAppearancePtr = dylib.lookup <NativeFunction<_WxAppSetAppearanceNative>>('WxAppSetAppearance');
  _wxAppSetAppearance = wxAppSetAppearancePtr.asFunction<_WxAppSetAppearance>();

  final wxAppGetTopWindowPtr = dylib.lookup <NativeFunction<_WxAppGetTopWindowNative>>('wxAppGetTopWindow');
  _wxAppGetTopWindow = wxAppGetTopWindowPtr.asFunction<_WxAppGetTopWindow>();

  final wxAppSetTopWindowPtr = dylib.lookup <NativeFunction<_WxAppSetTopWindowNative>>('wxAppSetTopWindow');
  _wxAppSetTopWindow = wxAppSetTopWindowPtr.asFunction<_WxAppSetTopWindow>();

  // OnInit

  final wxInstallDartAppOnInitCallbackPtr = dylib.lookup <NativeFunction<_WxInstallDartAppOnInitCallbackNative>>('WxInstallDartAppOnInitCallback');
  _wxInstallDartAppOnInitCallback = wxInstallDartAppOnInitCallbackPtr.asFunction<_WxInstallDartAppOnInitCallback>();

  _wxAppOnInitNativeCallable = NativeCallable<_WxAppOnInitCallbackNative>.isolateLocal( _wxAppOnInitCallback, exceptionalReturn: false );
  _wxInstallDartAppOnInitCallback( _wxAppOnInitNativeCallable.nativeFunction );

  // OnExit
  
  final wxInstallDartAppOnExitCallbackPtr = dylib.lookup <NativeFunction<_WxInstallDartAppOnExitCallbackNative>>('WxInstallDartAppOnExitCallback');
  _wxInstallDartAppOnExitCallback = wxInstallDartAppOnExitCallbackPtr.asFunction<_WxInstallDartAppOnExitCallback>();

  _wxAppOnExitNativeCallable = NativeCallable<_WxAppOnExitCallbackNative>.isolateLocal( _wxAppOnExitCallback, exceptionalReturn: 0 );
  _wxInstallDartAppOnExitCallback( _wxAppOnExitNativeCallable.nativeFunction );
  
  // ------------------------- wxSystemAppearance ----------------------

  final wxSystemAppearanceGetNamePtr = dylib.lookup <NativeFunction<_WxSystemAppearanceGetNameNative>>('wxSystemAppearanceGetName');
  _wxSystemAppearanceGetName = wxSystemAppearanceGetNamePtr.asFunction<_WxSystemAppearanceGetName>();

  final wxSystemAppearanceIsDarkPtr = dylib.lookup <NativeFunction<_WxSystemAppearanceIsDarkNative>>('wxSystemAppearanceIsDark');
  _wxSystemAppearanceIsDark = wxSystemAppearanceIsDarkPtr.asFunction<_WxSystemAppearanceIsDark>();

  final wxSystemAppearanceIsUsingDarkBackgroundPtr = dylib.lookup <NativeFunction<_WxSystemAppearanceIsUsingDarkBackgroundNative>>('wxSystemAppearanceIsUsingDarkBackground');
  _wxSystemAppearanceIsUsingDarkBackground = wxSystemAppearanceIsUsingDarkBackgroundPtr.asFunction<_WxSystemAppearanceIsUsingDarkBackground>();
}

void releaseWxCoreEventHandlers()
{
  _wxAppOnInitNativeCallable.close();
  _wxAppOnExitNativeCallable.close();
  _wxEvtHandlerDestructorNativeCallable.close();
  _wxClientDataDestructorNativeCallable.close();
  _wxTreeItemDataDestructorNativeCallable.close();
}

