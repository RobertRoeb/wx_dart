// -------------------------------------------------------------
// Purpose:     Dart bindings for wxWidgets
// Author:      Robert Roebling
// Modified by: The magic C++ to Dart code generator
// Created:     07/01/2025
// Copyright:   (c) Robert Roebling
// Licence:     wxWindows licence 3.1
// -------------------------------------------------------------

part of '../wx_dart.dart';

// ------------------------- wxVectorVariant ----------------------

typedef _WxVectorVariantConstructorNative = Pointer Function(  );
typedef _WxVectorVariantConstructor = Pointer Function(  );
late _WxVectorVariantConstructor _wxVectorVariantConstructor;

typedef _WxVectorVariantDestructorNative = Pointer Function( Pointer );
typedef _WxVectorVariantDestructor = Pointer Function( Pointer );
late _WxVectorVariantDestructor _wxVectorVariantDestructor;

typedef _WxVectorVariantAddNative = Void Function( Pointer, Pointer  );
typedef _WxVectorVariantAdd = void Function( Pointer, Pointer  );
late _WxVectorVariantAdd _wxVectorVariantAdd;

typedef _WxVectorVariantAddBoolNative = Void Function( Pointer, Bool  );
typedef _WxVectorVariantAddBool = void Function( Pointer, bool  );
late _WxVectorVariantAddBool _wxVectorVariantAddBool;

typedef _WxVectorVariantAddLongNative = Void Function( Pointer, Int32  );
typedef _WxVectorVariantAddLong = void Function( Pointer, int  );
late _WxVectorVariantAddLong _wxVectorVariantAddLong;

typedef _WxVectorVariantAddDoubleNative = Void Function( Pointer, Double  );
typedef _WxVectorVariantAddDouble = void Function( Pointer, double  );
late _WxVectorVariantAddDouble _wxVectorVariantAddDouble;

typedef _WxVectorVariantAddStringNative = Void Function( Pointer, Pointer<Utf8>  );
typedef _WxVectorVariantAddString = void Function( Pointer, Pointer<Utf8>  );
late _WxVectorVariantAddString _wxVectorVariantAddString;

class WxVectorVariant extends WxClass {
  WxVectorVariant._defaultConstructor() : super._defaultConstructor();
  WxVectorVariant( ) {
    nativeHandle = _wxVectorVariantConstructor(  );
  }
  WxVectorVariant.fromHandle( Pointer handle ) {
    nativeHandle = handle;
    ownsHandle = false;
  }
  @override
  void nativeDestroy() {
    nativeHandle = _wxVectorVariantDestructor( nativeHandle );
  }


  void add( dynamic data ) {
    final dataVariant = wxDynamicToVariant( data );
    _wxVectorVariantAdd( nativeHandle, dataVariant.nativeHandle );
    // dataVariant.dispose();
  }

  void addBool( bool data ) {
    _wxVectorVariantAddBool( nativeHandle, data );
  }

  void addLong( int data ) {
    _wxVectorVariantAddLong( nativeHandle, data );
  }

  void addDouble( double data ) {
    _wxVectorVariantAddDouble( nativeHandle, data );
  }

  void addString( String data ) {
    final dataUtf8 = data.toNativeUtf8();
    _wxVectorVariantAddString( nativeHandle, dataUtf8 );
    malloc.free( dataUtf8 );
  }
}

// ------------------------- wxVariant ----------------------

typedef _WxVariantConstructorNative = Pointer Function(  );
typedef _WxVariantConstructor = Pointer Function(  );
late _WxVariantConstructor _wxVariantConstructor;

typedef _WxVariantConstructorFromBoolNative = Pointer Function( Bool  );
typedef _WxVariantConstructorFromBool = Pointer Function( bool  );
late _WxVariantConstructorFromBool _wxVariantConstructorFromBool;
typedef _WxVariantConstructorFromLongNative = Pointer Function( Int32  );
typedef _WxVariantConstructorFromLong = Pointer Function( int  );
late _WxVariantConstructorFromLong _wxVariantConstructorFromLong;
typedef _WxVariantConstructorFromDoubleNative = Pointer Function( Double  );
typedef _WxVariantConstructorFromDouble = Pointer Function( double  );
late _WxVariantConstructorFromDouble _wxVariantConstructorFromDouble;
typedef _WxVariantConstructorFromStringNative = Pointer Function( Pointer<Utf8>  );
typedef _WxVariantConstructorFromString = Pointer Function( Pointer<Utf8>  );
late _WxVariantConstructorFromString _wxVariantConstructorFromString;
typedef _WxVariantGetTypeNative = Pointer<Utf8> Function( Pointer  );
typedef _WxVariantGetType = Pointer<Utf8> Function( Pointer  );
late _WxVariantGetType _wxVariantGetType;

typedef _WxVariantIsTypeNative = Bool Function( Pointer, Pointer<Utf8>  );
typedef _WxVariantIsType = bool Function( Pointer, Pointer<Utf8>  );
late _WxVariantIsType _wxVariantIsType;

typedef _WxVariantIsNullNative = Bool Function( Pointer  );
typedef _WxVariantIsNull = bool Function( Pointer  );
late _WxVariantIsNull _wxVariantIsNull;

typedef _WxVariantMakeNullNative = Void Function( Pointer  );
typedef _WxVariantMakeNull = void Function( Pointer  );
late _WxVariantMakeNull _wxVariantMakeNull;

typedef _WxVariantGetBoolNative = Bool Function( Pointer  );
typedef _WxVariantGetBool = bool Function( Pointer  );
late _WxVariantGetBool _wxVariantGetBool;

typedef _WxVariantGetLongNative = Int32 Function( Pointer  );
typedef _WxVariantGetLong = int Function( Pointer  );
late _WxVariantGetLong _wxVariantGetLong;

typedef _WxVariantGetDoubleNative = Double Function( Pointer  );
typedef _WxVariantGetDouble = double Function( Pointer  );
late _WxVariantGetDouble _wxVariantGetDouble;

typedef _WxVariantGetStringNative = Pointer<Utf8> Function( Pointer  );
typedef _WxVariantGetString = Pointer<Utf8> Function( Pointer  );
late _WxVariantGetString _wxVariantGetString;

class WxVariant extends WxObject {
  WxVariant._defaultConstructor() : super._defaultConstructor();
  WxVariant( ) : super._defaultConstructor() {
    nativeHandle = _wxVariantConstructor(  );
  }
  WxVariant.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }
  WxVariant.fromBool( bool data ) : super._defaultConstructor() {
    nativeHandle = _wxVariantConstructorFromBool( data );
  }
  WxVariant.fromLong( int data ) : super._defaultConstructor() {
    nativeHandle = _wxVariantConstructorFromLong( data );
  }
  WxVariant.fromDouble( double data ) : super._defaultConstructor() {
    nativeHandle = _wxVariantConstructorFromDouble( data );
  }
  WxVariant.fromString( String data ) : super._defaultConstructor() {
    final dataUtf8 = data.toNativeUtf8();
    nativeHandle = _wxVariantConstructorFromString( dataUtf8 );
    malloc.free( dataUtf8 );
  }

  String getType( ) {
    Pointer<Utf8> ptrReturn = _wxVariantGetType( nativeHandle  );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }

  bool isType( String type ) {
    final typeUtf8 = type.toNativeUtf8();
    return _wxVariantIsType( nativeHandle, typeUtf8 );
  }

  bool isNull( ) {
    return _wxVariantIsNull( nativeHandle  );
  }

  void makeNull( ) {
    _wxVariantMakeNull( nativeHandle  );
  }

  bool getBool( ) {
    return _wxVariantGetBool( nativeHandle  );
  }

  int getLong( ) {
    return _wxVariantGetLong( nativeHandle  );
  }

  double getDouble( ) {
    return _wxVariantGetDouble( nativeHandle  );
  }

  String getString( ) {
    Pointer<Utf8> ptrReturn = _wxVariantGetString( nativeHandle  );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }
}

// ------------------------- wxControl ----------------------

typedef _WxControlGetLabelTextNative = Pointer<Utf8> Function( Pointer  );
typedef _WxControlGetLabelText = Pointer<Utf8> Function( Pointer  );
late _WxControlGetLabelText _wxControlGetLabelText;

class WxControl extends WxWindow {
  WxControl._defaultConstructor() : super._defaultConstructor();
  WxControl.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  String getLabelText( ) {
    Pointer<Utf8> ptrReturn = _wxControlGetLabelText( nativeHandle  );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }
}

// ------------------------- wxAnyButton ----------------------

typedef _WxAnyButtonSetBitmapNative = Void Function( Pointer, Pointer, Int32  );
typedef _WxAnyButtonSetBitmap = void Function( Pointer, Pointer, int  );
late _WxAnyButtonSetBitmap _wxAnyButtonSetBitmap;

typedef _WxAnyButtonSetBitmapCurrentNative = Void Function( Pointer, Pointer  );
typedef _WxAnyButtonSetBitmapCurrent = void Function( Pointer, Pointer  );
late _WxAnyButtonSetBitmapCurrent _wxAnyButtonSetBitmapCurrent;

typedef _WxAnyButtonSetBitmapDisabledNative = Void Function( Pointer, Pointer  );
typedef _WxAnyButtonSetBitmapDisabled = void Function( Pointer, Pointer  );
late _WxAnyButtonSetBitmapDisabled _wxAnyButtonSetBitmapDisabled;

typedef _WxAnyButtonSetBitmapFocusNative = Void Function( Pointer, Pointer  );
typedef _WxAnyButtonSetBitmapFocus = void Function( Pointer, Pointer  );
late _WxAnyButtonSetBitmapFocus _wxAnyButtonSetBitmapFocus;

typedef _WxAnyButtonSetBitmapPressedNative = Void Function( Pointer, Pointer  );
typedef _WxAnyButtonSetBitmapPressed = void Function( Pointer, Pointer  );
late _WxAnyButtonSetBitmapPressed _wxAnyButtonSetBitmapPressed;

typedef _WxAnyButtonSetBitmapLabelNative = Void Function( Pointer, Pointer  );
typedef _WxAnyButtonSetBitmapLabel = void Function( Pointer, Pointer  );
late _WxAnyButtonSetBitmapLabel _wxAnyButtonSetBitmapLabel;

typedef _WxAnyButtonSetBitmapMarginsNative = Void Function( Pointer, Int32, Int32  );
typedef _WxAnyButtonSetBitmapMargins = void Function( Pointer, int, int  );
late _WxAnyButtonSetBitmapMargins _wxAnyButtonSetBitmapMargins;

typedef _WxAnyButtonSetBitmapPositionNative = Void Function( Pointer, Int32  );
typedef _WxAnyButtonSetBitmapPosition = void Function( Pointer, int  );
late _WxAnyButtonSetBitmapPosition _wxAnyButtonSetBitmapPosition;

/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxBU_LEFT | 0x0040 |
/// | wxBU_TOP | 0x0080 |
/// | wxBU_RIGHT | 0x0100 |
/// | wxBU_BOTTOM | 0x0200 |
/// | wxBU_ALIGN_MASK | ( wxBU_LEFT | wxBU_TOP | wxBU_RIGHT | wxBU_BOTTOM ) |
/// | wxBU_EXACTFIT | 0x0001 |
/// | wxBU_NOTEXT | 0x0002 |

const int wxBU_LEFT = 0x0040;
const int wxBU_TOP = 0x0080;
const int wxBU_RIGHT = 0x0100;
const int wxBU_BOTTOM = 0x0200;
const int wxBU_ALIGN_MASK = ( wxBU_LEFT | wxBU_TOP | wxBU_RIGHT | wxBU_BOTTOM );
const int wxBU_EXACTFIT = 0x0001;
const int wxBU_NOTEXT = 0x0002;

class WxAnyButton extends WxControl {
  WxAnyButton._defaultConstructor() : super._defaultConstructor();
  WxAnyButton.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  void setBitmap( WxBitmapBundle bitmap, { int direction = wxLEFT } ) {
    _wxAnyButtonSetBitmap( nativeHandle, bitmap.nativeHandle, direction );
  }

  void setBitmapCurrent( WxBitmapBundle bitmap ) {
    _wxAnyButtonSetBitmapCurrent( nativeHandle, bitmap.nativeHandle );
  }

  void setBitmapDisabled( WxBitmapBundle bitmap ) {
    _wxAnyButtonSetBitmapDisabled( nativeHandle, bitmap.nativeHandle );
  }

  void setBitmapFocus( WxBitmapBundle bitmap ) {
    _wxAnyButtonSetBitmapFocus( nativeHandle, bitmap.nativeHandle );
  }

  void setBitmapPressed( WxBitmapBundle bitmap ) {
    _wxAnyButtonSetBitmapPressed( nativeHandle, bitmap.nativeHandle );
  }

  void setBitmapLabel( WxBitmapBundle bitmap ) {
    _wxAnyButtonSetBitmapLabel( nativeHandle, bitmap.nativeHandle );
  }

  void setBitmapMargins( int x, int y ) {
    _wxAnyButtonSetBitmapMargins( nativeHandle, x, y );
  }

  void setBitmapPosition( int dir ) {
    _wxAnyButtonSetBitmapPosition( nativeHandle, dir );
  }
}

// ------------------------- wxButton ----------------------

typedef _WxButtonConstructorNative = Pointer Function( Pointer, Int32, Pointer<Utf8>, Int32, Int32, Int32, Int32, Int32  );
typedef _WxButtonConstructor = Pointer Function( Pointer, int, Pointer<Utf8>, int, int, int, int, int  );
late _WxButtonConstructor _wxButtonConstructor;

typedef _WxButtonSetAuthNeededNative = Void Function( Pointer, Bool  );
typedef _WxButtonSetAuthNeeded = void Function( Pointer, bool  );
late _WxButtonSetAuthNeeded _wxButtonSetAuthNeeded;

typedef _WxButtonSetDefaultNative = Void Function( Pointer  );
typedef _WxButtonSetDefault = void Function( Pointer  );
late _WxButtonSetDefault _wxButtonSetDefault;

class WxButton extends WxAnyButton {
  WxButton._defaultConstructor() : super._defaultConstructor();
  WxButton( WxWindow parent, int id, String label, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = 0 } ) : super._defaultConstructor() {
    final labelUtf8 = label.toNativeUtf8();
    nativeHandle = _wxButtonConstructor( parent.nativeHandle, id, labelUtf8, pos.x, pos.y, size.x, size.y, style );
    malloc.free( labelUtf8 );
    _postCreation();
  }
  WxButton.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  void setAuthNeeded( { bool needed = true } ) {
    _wxButtonSetAuthNeeded( nativeHandle, needed );
  }

  void setDefault( ) {
    _wxButtonSetDefault( nativeHandle  );
  }
}

// ------------------------- wxBitmapButton ----------------------

typedef _WxBitmapButtonConstructorNative = Pointer Function( Pointer, Int32, Pointer, Int32, Int32, Int32, Int32, Int32  );
typedef _WxBitmapButtonConstructor = Pointer Function( Pointer, int, Pointer, int, int, int, int, int  );
late _WxBitmapButtonConstructor _wxBitmapButtonConstructor;

class WxBitmapButton extends WxButton {
  WxBitmapButton._defaultConstructor() : super._defaultConstructor();
  WxBitmapButton( WxWindow parent, int id, WxBitmapBundle bitmap, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = 0 } ) : super._defaultConstructor() {
    nativeHandle = _wxBitmapButtonConstructor( parent.nativeHandle, id, bitmap.nativeHandle, pos.x, pos.y, size.x, size.y, style );
    _postCreation();
  }
  WxBitmapButton.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }
}

// ------------------------- wxHyperlinkCtrl ----------------------

typedef _WxHyperlinkCtrlConstructorNative = Pointer Function( Pointer, Int32, Pointer<Utf8>, Pointer<Utf8>, Int32, Int32, Int32, Int32, Int32  );
typedef _WxHyperlinkCtrlConstructor = Pointer Function( Pointer, int, Pointer<Utf8>, Pointer<Utf8>, int, int, int, int, int  );
late _WxHyperlinkCtrlConstructor _wxHyperlinkCtrlConstructor;

typedef _WxHyperlinkCtrlSetHoverColourNative = Void Function( Pointer, Uint32  );
typedef _WxHyperlinkCtrlSetHoverColour = void Function( Pointer, int  );
late _WxHyperlinkCtrlSetHoverColour _wxHyperlinkCtrlSetHoverColour;

typedef _WxHyperlinkCtrlSetNormalColourNative = Void Function( Pointer, Uint32  );
typedef _WxHyperlinkCtrlSetNormalColour = void Function( Pointer, int  );
late _WxHyperlinkCtrlSetNormalColour _wxHyperlinkCtrlSetNormalColour;

typedef _WxHyperlinkCtrlSetVisitedColourNative = Void Function( Pointer, Uint32  );
typedef _WxHyperlinkCtrlSetVisitedColour = void Function( Pointer, int  );
late _WxHyperlinkCtrlSetVisitedColour _wxHyperlinkCtrlSetVisitedColour;

typedef _WxHyperlinkCtrlGetHoverColourNative = Uint32 Function( Pointer  );
typedef _WxHyperlinkCtrlGetHoverColour = int Function( Pointer  );
late _WxHyperlinkCtrlGetHoverColour _wxHyperlinkCtrlGetHoverColour;

typedef _WxHyperlinkCtrlGetNormalColourNative = Uint32 Function( Pointer  );
typedef _WxHyperlinkCtrlGetNormalColour = int Function( Pointer  );
late _WxHyperlinkCtrlGetNormalColour _wxHyperlinkCtrlGetNormalColour;

typedef _WxHyperlinkCtrlGetVisitedColourNative = Uint32 Function( Pointer  );
typedef _WxHyperlinkCtrlGetVisitedColour = int Function( Pointer  );
late _WxHyperlinkCtrlGetVisitedColour _wxHyperlinkCtrlGetVisitedColour;

typedef _WxHyperlinkCtrlSetVisitedNative = Void Function( Pointer, Bool  );
typedef _WxHyperlinkCtrlSetVisited = void Function( Pointer, bool  );
late _WxHyperlinkCtrlSetVisited _wxHyperlinkCtrlSetVisited;

typedef _WxHyperlinkCtrlGetVisitedNative = Bool Function( Pointer  );
typedef _WxHyperlinkCtrlGetVisited = bool Function( Pointer  );
late _WxHyperlinkCtrlGetVisited _wxHyperlinkCtrlGetVisited;

typedef _WxHyperlinkCtrlSetURLNative = Void Function( Pointer, Pointer<Utf8>  );
typedef _WxHyperlinkCtrlSetURL = void Function( Pointer, Pointer<Utf8>  );
late _WxHyperlinkCtrlSetURL _wxHyperlinkCtrlSetURL;

typedef _WxHyperlinkCtrlGetURLNative = Pointer<Utf8> Function( Pointer  );
typedef _WxHyperlinkCtrlGetURL = Pointer<Utf8> Function( Pointer  );
late _WxHyperlinkCtrlGetURL _wxHyperlinkCtrlGetURL;

/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxHL_CONTEXTMENU | 0x0001 |
/// | wxHL_ALIGN_LEFT | 0x0002 |
/// | wxHL_ALIGN_RIGHT | 0x0004 |
/// | wxHL_ALIGN_CENTRE | 0x0008 |
/// | wxHL_DEFAULT_STYLE | (wxHL_CONTEXTMENU|wxNO_BORDER|wxHL_ALIGN_CENTRE) |

const int wxHL_CONTEXTMENU = 0x0001;
const int wxHL_ALIGN_LEFT = 0x0002;
const int wxHL_ALIGN_RIGHT = 0x0004;
const int wxHL_ALIGN_CENTRE = 0x0008;
const int wxHL_DEFAULT_STYLE = (wxHL_CONTEXTMENU|wxNO_BORDER|wxHL_ALIGN_CENTRE);

class WxHyperlinkCtrl extends WxControl {
  WxHyperlinkCtrl._defaultConstructor() : super._defaultConstructor();
  WxHyperlinkCtrl( WxWindow parent, int id, String label, String url, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = wxHL_DEFAULT_STYLE } ) : super._defaultConstructor() {
    final labelUtf8 = label.toNativeUtf8();
    final urlUtf8 = url.toNativeUtf8();
    nativeHandle = _wxHyperlinkCtrlConstructor( parent.nativeHandle, id, labelUtf8, urlUtf8, pos.x, pos.y, size.x, size.y, style );
    malloc.free( labelUtf8 );
    malloc.free( urlUtf8 );
    _postCreation();
  }
  WxHyperlinkCtrl.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  void setHoverColour( WxColour colour ) {
    _wxHyperlinkCtrlSetHoverColour( nativeHandle, colour.getRGBA() );
  }

  void setNormalColour( WxColour colour ) {
    _wxHyperlinkCtrlSetNormalColour( nativeHandle, colour.getRGBA() );
  }

  void setVisitedColour( WxColour colour ) {
    _wxHyperlinkCtrlSetVisitedColour( nativeHandle, colour.getRGBA() );
  }

  WxColour getHoverColour( ) {
    final int rgba = _wxHyperlinkCtrlGetHoverColour( nativeHandle  );
    return WxColour.fromRGBA( rgba );
  }

  WxColour getNormalColour( ) {
    final int rgba = _wxHyperlinkCtrlGetNormalColour( nativeHandle  );
    return WxColour.fromRGBA( rgba );
  }

  WxColour getVisitedColour( ) {
    final int rgba = _wxHyperlinkCtrlGetVisitedColour( nativeHandle  );
    return WxColour.fromRGBA( rgba );
  }

  void setVisited( { bool visited = true } ) {
    _wxHyperlinkCtrlSetVisited( nativeHandle, visited );
  }

  bool getVisited( ) {
    return _wxHyperlinkCtrlGetVisited( nativeHandle  );
  }

  void setURL( String url ) {
    final urlUtf8 = url.toNativeUtf8();
    _wxHyperlinkCtrlSetURL( nativeHandle, urlUtf8 );
    malloc.free( urlUtf8 );
  }

  String getURL( ) {
    Pointer<Utf8> ptrReturn = _wxHyperlinkCtrlGetURL( nativeHandle  );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }
}

// ------------------------- wxHyperlinkEvent ----------------------

typedef _WxHyperlinkEventConstructorNative = Pointer Function( Pointer, Int32, Pointer<Utf8>  );
typedef _WxHyperlinkEventConstructor = Pointer Function( Pointer, int, Pointer<Utf8>  );
late _WxHyperlinkEventConstructor _wxHyperlinkEventConstructor;

typedef _WxHyperlinkEventSetURLNative = Void Function( Pointer, Pointer<Utf8>  );
typedef _WxHyperlinkEventSetURL = void Function( Pointer, Pointer<Utf8>  );
late _WxHyperlinkEventSetURL _wxHyperlinkEventSetURL;

typedef _WxHyperlinkEventGetURLNative = Pointer<Utf8> Function( Pointer  );
typedef _WxHyperlinkEventGetURL = Pointer<Utf8> Function( Pointer  );
late _WxHyperlinkEventGetURL _wxHyperlinkEventGetURL;

class WxHyperlinkEvent extends WxCommandEvent {
  WxHyperlinkEvent._defaultConstructor() : super._defaultConstructor();
  WxHyperlinkEvent( WxObject originator, int id, String url ) : super._defaultConstructor() {
    final urlUtf8 = url.toNativeUtf8();
    nativeHandle = _wxHyperlinkEventConstructor( originator.nativeHandle, id, urlUtf8 );
    malloc.free( urlUtf8 );
    attachFinalizer();
  }
  WxHyperlinkEvent.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  void setURL( String url ) {
    final urlUtf8 = url.toNativeUtf8();
    _wxHyperlinkEventSetURL( nativeHandle, urlUtf8 );
    malloc.free( urlUtf8 );
  }

  String getURL( ) {
    Pointer<Utf8> ptrReturn = _wxHyperlinkEventGetURL( nativeHandle  );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }
}

typedef _WxInstallDartHyperlinkEventCallbackNative = Void Function( Pointer );
typedef _WxInstallDartHyperlinkEventCallback = void Function( Pointer );
late _WxInstallDartHyperlinkEventCallback _wxInstallDartHyperlinkEventCallback;

typedef OnHyperlinkEventFunc = void Function( WxHyperlinkEvent event );
class WxHyperlinkEventListItems {
  WxHyperlinkEventListItems( this.func, this.eventType, this.eventId );
  final OnHyperlinkEventFunc func;
  final int eventType;
  final int eventId;
}
Map<Pointer, List<WxHyperlinkEventListItems>> wxHyperlinkEventHandlerList = {};

void wxHyperlinkEventCallback( Pointer handle, Pointer eventHandle ) {
    WxHyperlinkEvent event = WxHyperlinkEvent.fromHandle( eventHandle );

    final List<WxHyperlinkEventListItems>? list = wxHyperlinkEventHandlerList[handle];
    if (list == null) {
      wxLogError('Handle does not exist in wxHyperlinkEventHandlerList');
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

typedef WxHyperlinkEventCallbackNative = Void Function( Pointer, Pointer );
late NativeCallable<Void Function(Pointer<NativeType>, Pointer<NativeType>)> wxHyperlinkEventNativeCallable;

// ------------------------- wxStaticText ----------------------

typedef _WxStaticTextConstructorNative = Pointer Function( Pointer, Int32, Pointer<Utf8>, Int32, Int32, Int32, Int32, Int32  );
typedef _WxStaticTextConstructor = Pointer Function( Pointer, int, Pointer<Utf8>, int, int, int, int, int  );
late _WxStaticTextConstructor _wxStaticTextConstructor;

typedef _WxStaticTextWrapNative = Void Function( Pointer, Int32  );
typedef _WxStaticTextWrap = void Function( Pointer, int  );
late _WxStaticTextWrap _wxStaticTextWrap;

typedef _WxStaticTextIsEllipsizedNative = Bool Function( Pointer  );
typedef _WxStaticTextIsEllipsized = bool Function( Pointer  );
late _WxStaticTextIsEllipsized _wxStaticTextIsEllipsized;

/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxST_NO_AUTORESIZE | 0x0001 |
/// | wxST_WRAP | 0x0002 |
/// | wxST_ELLIPSIZE_START | 0x0004 |
/// | wxST_ELLIPSIZE_MIDDLE | 0x0008 |
/// | wxST_ELLIPSIZE_END | 0x0010 |
/// | wxST_SELECTABLE | 0x0020 |

const int wxST_NO_AUTORESIZE = 0x0001;
const int wxST_WRAP = 0x0002;
const int wxST_ELLIPSIZE_START = 0x0004;
const int wxST_ELLIPSIZE_MIDDLE = 0x0008;
const int wxST_ELLIPSIZE_END = 0x0010;
const int wxST_SELECTABLE = 0x0020;

class WxStaticText extends WxControl {
  WxStaticText._defaultConstructor() : super._defaultConstructor();
  WxStaticText( WxWindow parent, int id, String label, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = 0 } ) : super._defaultConstructor() {
    final labelUtf8 = label.toNativeUtf8();
    nativeHandle = _wxStaticTextConstructor( parent.nativeHandle, id, labelUtf8, pos.x, pos.y, size.x, size.y, style );
    malloc.free( labelUtf8 );
    _postCreation();
  }
  WxStaticText.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }
  int _headingLevel = 0;
  void setHeadingLevel( int level ) {
    _headingLevel = (level >= 1 && level <= 6) ? level : 0;
  }
  int getHeadingLevel() => _headingLevel;

  void wrap( int width ) {
    _wxStaticTextWrap( nativeHandle, width );
  }

  bool isEllipsized( ) {
    return _wxStaticTextIsEllipsized( nativeHandle  );
  }
}

// ------------------------- wxStaticBitmap ----------------------

typedef _WxStaticBitmapConstructorNative = Pointer Function( Pointer, Int32, Pointer, Int32, Int32, Int32, Int32, Int32  );
typedef _WxStaticBitmapConstructor = Pointer Function( Pointer, int, Pointer, int, int, int, int, int  );
late _WxStaticBitmapConstructor _wxStaticBitmapConstructor;

typedef _WxStaticBitmapSetScaleModeNative = Void Function( Pointer, Int32  );
typedef _WxStaticBitmapSetScaleMode = void Function( Pointer, int  );
late _WxStaticBitmapSetScaleMode _wxStaticBitmapSetScaleMode;

typedef _WxStaticBitmapGetScaleModeNative = Int32 Function( Pointer  );
typedef _WxStaticBitmapGetScaleMode = int Function( Pointer  );
late _WxStaticBitmapGetScaleMode _wxStaticBitmapGetScaleMode;

/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | scaleNone | 0 |
/// | scaleFill | 1 |
/// | scaleAspectFit | 2 |
/// | scaleAspectFill | 3 |
/// | wxBI_EXPAND | wxEXPAND |

const int scaleNone = 0;
const int scaleFill = 1;
const int scaleAspectFit = 2;
const int scaleAspectFill = 3;
const int wxBI_EXPAND = wxEXPAND;

class WxStaticBitmap extends WxControl {
  WxStaticBitmap._defaultConstructor() : super._defaultConstructor();
  WxStaticBitmap( WxWindow parent, int id, WxBitmapBundle bitmap, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = 0 } ) : super._defaultConstructor() {
    nativeHandle = _wxStaticBitmapConstructor( parent.nativeHandle, id, bitmap.nativeHandle, pos.x, pos.y, size.x, size.y, style );
    _postCreation();
  }
  WxStaticBitmap.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  void setScaleMode( int mode ) {
    _wxStaticBitmapSetScaleMode( nativeHandle, mode );
  }

  int getScaleMode( ) {
    return _wxStaticBitmapGetScaleMode( nativeHandle  );
  }
}

// ------------------------- wxAnimationCtrl ----------------------

typedef _WxAnimationCtrlConstructorNative = Pointer Function( Pointer, Int32, Pointer, Int32, Int32, Int32, Int32, Int32  );
typedef _WxAnimationCtrlConstructor = Pointer Function( Pointer, int, Pointer, int, int, int, int, int  );
late _WxAnimationCtrlConstructor _wxAnimationCtrlConstructor;

typedef _WxAnimationCtrlPlayNative = Void Function( Pointer  );
typedef _WxAnimationCtrlPlay = void Function( Pointer  );
late _WxAnimationCtrlPlay _wxAnimationCtrlPlay;

typedef _WxAnimationCtrlIsPlayingNative = Bool Function( Pointer  );
typedef _WxAnimationCtrlIsPlaying = bool Function( Pointer  );
late _WxAnimationCtrlIsPlaying _wxAnimationCtrlIsPlaying;

typedef _WxAnimationCtrlStopNative = Void Function( Pointer  );
typedef _WxAnimationCtrlStop = void Function( Pointer  );
late _WxAnimationCtrlStop _wxAnimationCtrlStop;

typedef _WxAnimationCtrlSetInactiveBitmapNative = Void Function( Pointer, Pointer  );
typedef _WxAnimationCtrlSetInactiveBitmap = void Function( Pointer, Pointer  );
late _WxAnimationCtrlSetInactiveBitmap _wxAnimationCtrlSetInactiveBitmap;

/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxAC_NO_AUTORESIZE | 0x0010 |
/// | wxAC_DEFAULT_STYLE | wxBORDER_NONE |

const int wxAC_NO_AUTORESIZE = 0x0010;
const int wxAC_DEFAULT_STYLE = wxBORDER_NONE;

class WxAnimationCtrl extends WxControl {
  WxAnimationCtrl._defaultConstructor() : super._defaultConstructor();
  WxAnimationCtrl( WxWindow parent, int id, WxAnimation animation, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = wxAC_DEFAULT_STYLE } ) : super._defaultConstructor() {
    nativeHandle = _wxAnimationCtrlConstructor( parent.nativeHandle, id, animation.nativeHandle, pos.x, pos.y, size.x, size.y, style );
    _postCreation();
  }
  WxAnimationCtrl.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  void play( ) {
    _wxAnimationCtrlPlay( nativeHandle  );
  }

  bool isPlaying( ) {
    return _wxAnimationCtrlIsPlaying( nativeHandle  );
  }

  void stop( ) {
    _wxAnimationCtrlStop( nativeHandle  );
  }

  void setInactiveBitmap( WxBitmapBundle bitmap ) {
    _wxAnimationCtrlSetInactiveBitmap( nativeHandle, bitmap.nativeHandle );
  }
}

// ------------------------- wxActivityIndicator ----------------------

typedef _WxActivityIndicatorConstructorNative = Pointer Function( Pointer, Int32, Int32, Int32, Int32, Int32, Int32  );
typedef _WxActivityIndicatorConstructor = Pointer Function( Pointer, int, int, int, int, int, int  );
late _WxActivityIndicatorConstructor _wxActivityIndicatorConstructor;

typedef _WxActivityIndicatorStartNative = Void Function( Pointer  );
typedef _WxActivityIndicatorStart = void Function( Pointer  );
late _WxActivityIndicatorStart _wxActivityIndicatorStart;

typedef _WxActivityIndicatorIsRunningNative = Bool Function( Pointer  );
typedef _WxActivityIndicatorIsRunning = bool Function( Pointer  );
late _WxActivityIndicatorIsRunning _wxActivityIndicatorIsRunning;

typedef _WxActivityIndicatorStopNative = Void Function( Pointer  );
typedef _WxActivityIndicatorStop = void Function( Pointer  );
late _WxActivityIndicatorStop _wxActivityIndicatorStop;

class WxActivityIndicator extends WxControl {
  WxActivityIndicator._defaultConstructor() : super._defaultConstructor();
  WxActivityIndicator( WxWindow parent, int id, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = 0 } ) : super._defaultConstructor() {
    nativeHandle = _wxActivityIndicatorConstructor( parent.nativeHandle, id, pos.x, pos.y, size.x, size.y, style );
    _postCreation();
  }
  WxActivityIndicator.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  void start( ) {
    _wxActivityIndicatorStart( nativeHandle  );
  }

  bool isRunning( ) {
    return _wxActivityIndicatorIsRunning( nativeHandle  );
  }

  void stop( ) {
    _wxActivityIndicatorStop( nativeHandle  );
  }
}

// ------------------------- wxStaticBox ----------------------

typedef _WxStaticBoxConstructorNative = Pointer Function( Pointer, Int32, Pointer<Utf8>, Int32, Int32, Int32, Int32, Int32  );
typedef _WxStaticBoxConstructor = Pointer Function( Pointer, int, Pointer<Utf8>, int, int, int, int, int  );
late _WxStaticBoxConstructor _wxStaticBoxConstructor;

class WxStaticBox extends WxControl {
  WxStaticBox._defaultConstructor() : super._defaultConstructor();
  WxStaticBox( WxWindow parent, int id, String label, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = 0 } ) : super._defaultConstructor() {
    final labelUtf8 = label.toNativeUtf8();
    nativeHandle = _wxStaticBoxConstructor( parent.nativeHandle, id, labelUtf8, pos.x, pos.y, size.x, size.y, style );
    malloc.free( labelUtf8 );
    _postCreation();
  }
  WxStaticBox.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }
}

// ------------------------- wxStaticLine ----------------------

typedef _WxStaticLineConstructorNative = Pointer Function( Pointer, Int32, Int32, Int32, Int32, Int32, Int32  );
typedef _WxStaticLineConstructor = Pointer Function( Pointer, int, int, int, int, int, int  );
late _WxStaticLineConstructor _wxStaticLineConstructor;

/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxLI_HORIZONTAL | wxHORIZONTAL |
/// | wxLI_VERTICAL | wxVERTICAL |

const int wxLI_HORIZONTAL = wxHORIZONTAL;
const int wxLI_VERTICAL = wxVERTICAL;

class WxStaticLine extends WxControl {
  WxStaticLine._defaultConstructor() : super._defaultConstructor();
  WxStaticLine( WxWindow parent, int id, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = wxLI_HORIZONTAL } ) : super._defaultConstructor() {
    nativeHandle = _wxStaticLineConstructor( parent.nativeHandle, id, pos.x, pos.y, size.x, size.y, style );
    _postCreation();
  }
  WxStaticLine.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }
}

// ------------------------- wxCheckBox ----------------------

typedef _WxCheckBoxConstructorNative = Pointer Function( Pointer, Int32, Pointer<Utf8>, Int32, Int32, Int32, Int32, Int32  );
typedef _WxCheckBoxConstructor = Pointer Function( Pointer, int, Pointer<Utf8>, int, int, int, int, int  );
late _WxCheckBoxConstructor _wxCheckBoxConstructor;

typedef _WxCheckBoxIsCheckedNative = Bool Function( Pointer  );
typedef _WxCheckBoxIsChecked = bool Function( Pointer  );
late _WxCheckBoxIsChecked _wxCheckBoxIsChecked;

typedef _WxCheckBoxIs3StateNative = Bool Function( Pointer  );
typedef _WxCheckBoxIs3State = bool Function( Pointer  );
late _WxCheckBoxIs3State _wxCheckBoxIs3State;

typedef _WxCheckBoxIs3rdStateAllowedForUserNative = Bool Function( Pointer  );
typedef _WxCheckBoxIs3rdStateAllowedForUser = bool Function( Pointer  );
late _WxCheckBoxIs3rdStateAllowedForUser _wxCheckBoxIs3rdStateAllowedForUser;

typedef _WxCheckBoxGet3StateValueNative = Int32 Function( Pointer  );
typedef _WxCheckBoxGet3StateValue = int Function( Pointer  );
late _WxCheckBoxGet3StateValue _wxCheckBoxGet3StateValue;

typedef _WxCheckBoxGetValueNative = Bool Function( Pointer  );
typedef _WxCheckBoxGetValue = bool Function( Pointer  );
late _WxCheckBoxGetValue _wxCheckBoxGetValue;

typedef _WxCheckBoxSetValueNative = Void Function( Pointer, Bool  );
typedef _WxCheckBoxSetValue = void Function( Pointer, bool  );
late _WxCheckBoxSetValue _wxCheckBoxSetValue;

typedef _WxCheckBoxSet3StateValueNative = Void Function( Pointer, Int32  );
typedef _WxCheckBoxSet3StateValue = void Function( Pointer, int  );
late _WxCheckBoxSet3StateValue _wxCheckBoxSet3StateValue;

/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxCHK_2STATE | 0x4000 |
/// | wxCHK_3STATE | 0x1000 |
/// | wxCHK_ALLOW_3RD_STATE_FOR_USER | 0x2000 |
/// | wxCHK_UNCHECKED | 0 |
/// | wxCHK_CHECKED | 1 |
/// | wxCHK_UNDETERMINED | 2 |

const int wxCHK_2STATE = 0x4000;
const int wxCHK_3STATE = 0x1000;
const int wxCHK_ALLOW_3RD_STATE_FOR_USER = 0x2000;
const int wxCHK_UNCHECKED = 0;
const int wxCHK_CHECKED = 1;
const int wxCHK_UNDETERMINED = 2;

class WxCheckBox extends WxControl {
  WxCheckBox._defaultConstructor() : super._defaultConstructor();
  WxCheckBox( WxWindow parent, int id, String label, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = 0 } ) : super._defaultConstructor() {
    final labelUtf8 = label.toNativeUtf8();
    nativeHandle = _wxCheckBoxConstructor( parent.nativeHandle, id, labelUtf8, pos.x, pos.y, size.x, size.y, style );
    malloc.free( labelUtf8 );
    _postCreation();
  }
  WxCheckBox.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  bool isChecked( ) {
    return _wxCheckBoxIsChecked( nativeHandle  );
  }

  bool is3State( ) {
    return _wxCheckBoxIs3State( nativeHandle  );
  }

  bool is3rdStateAllowedForUser( ) {
    return _wxCheckBoxIs3rdStateAllowedForUser( nativeHandle  );
  }

  int get3StateValue( ) {
    return _wxCheckBoxGet3StateValue( nativeHandle  );
  }

  bool getValue( ) {
    return _wxCheckBoxGetValue( nativeHandle  );
  }

  void setValue( bool state ) {
    _wxCheckBoxSetValue( nativeHandle, state );
  }

  void set3StateValue( int state ) {
    _wxCheckBoxSet3StateValue( nativeHandle, state );
  }
}

// ------------------------- wxToggleButton ----------------------

typedef _WxToggleButtonConstructorNative = Pointer Function( Pointer, Int32, Pointer<Utf8>, Int32, Int32, Int32, Int32, Int32  );
typedef _WxToggleButtonConstructor = Pointer Function( Pointer, int, Pointer<Utf8>, int, int, int, int, int  );
late _WxToggleButtonConstructor _wxToggleButtonConstructor;

typedef _WxToggleButtonGetValueNative = Bool Function( Pointer  );
typedef _WxToggleButtonGetValue = bool Function( Pointer  );
late _WxToggleButtonGetValue _wxToggleButtonGetValue;

typedef _WxToggleButtonSetValueNative = Void Function( Pointer, Bool  );
typedef _WxToggleButtonSetValue = void Function( Pointer, bool  );
late _WxToggleButtonSetValue _wxToggleButtonSetValue;

class WxToggleButton extends WxAnyButton {
  WxToggleButton._defaultConstructor() : super._defaultConstructor();
  WxToggleButton( WxWindow parent, int id, String label, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = 0 } ) : super._defaultConstructor() {
    final labelUtf8 = label.toNativeUtf8();
    nativeHandle = _wxToggleButtonConstructor( parent.nativeHandle, id, labelUtf8, pos.x, pos.y, size.x, size.y, style );
    malloc.free( labelUtf8 );
    _postCreation();
  }
  WxToggleButton.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  bool getValue( ) {
    return _wxToggleButtonGetValue( nativeHandle  );
  }

  void setValue( bool state ) {
    _wxToggleButtonSetValue( nativeHandle, state );
  }
}

// ------------------------- wxBitmapToggleButton ----------------------

typedef _WxBitmapToggleButtonConstructorNative = Pointer Function( Pointer, Int32, Pointer, Int32, Int32, Int32, Int32, Int32  );
typedef _WxBitmapToggleButtonConstructor = Pointer Function( Pointer, int, Pointer, int, int, int, int, int  );
late _WxBitmapToggleButtonConstructor _wxBitmapToggleButtonConstructor;

class WxBitmapToggleButton extends WxToggleButton {
  WxBitmapToggleButton._defaultConstructor() : super._defaultConstructor();
  WxBitmapToggleButton( WxWindow parent, int id, WxBitmapBundle bundle, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = 0 } ) : super._defaultConstructor() {
    nativeHandle = _wxBitmapToggleButtonConstructor( parent.nativeHandle, id, bundle.nativeHandle, pos.x, pos.y, size.x, size.y, style );
    _postCreation();
  }
  WxBitmapToggleButton.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }
}

// ------------------------- wxItemContainerImmutable ----------------------

class WxItemContainerImmutable extends WxControl {
  WxItemContainerImmutable._defaultConstructor() : super._defaultConstructor();
  WxItemContainerImmutable.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }
}

// ------------------------- wxItemContainer ----------------------

class WxItemContainer extends WxItemContainerImmutable {
  WxItemContainer._defaultConstructor() : super._defaultConstructor();
  WxItemContainer.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }
}

// ------------------------- wxRadioButton ----------------------

typedef _WxRadioButtonConstructorNative = Pointer Function( Pointer, Int32, Pointer<Utf8>, Int32, Int32, Int32, Int32, Int32  );
typedef _WxRadioButtonConstructor = Pointer Function( Pointer, int, Pointer<Utf8>, int, int, int, int, int  );
late _WxRadioButtonConstructor _wxRadioButtonConstructor;

typedef _WxRadioButtonSetValueNative = Void Function( Pointer, Bool  );
typedef _WxRadioButtonSetValue = void Function( Pointer, bool  );
late _WxRadioButtonSetValue _wxRadioButtonSetValue;

typedef _WxRadioButtonGetValueNative = Bool Function( Pointer  );
typedef _WxRadioButtonGetValue = bool Function( Pointer  );
late _WxRadioButtonGetValue _wxRadioButtonGetValue;

/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxRB_GROUP | 0x0004 |
/// | wxRB_SINGLE | 0x0008 |

const int wxRB_GROUP = 0x0004;
const int wxRB_SINGLE = 0x0008;

class WxRadioButton extends WxControl {
  WxRadioButton._defaultConstructor() : super._defaultConstructor();
  WxRadioButton( WxWindow parent, int id, String label, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = 0 } ) : super._defaultConstructor() {
    final labelUtf8 = label.toNativeUtf8();
    nativeHandle = _wxRadioButtonConstructor( parent.nativeHandle, id, labelUtf8, pos.x, pos.y, size.x, size.y, style );
    malloc.free( labelUtf8 );
    _postCreation();
  }
  WxRadioButton.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  void setValue( bool value ) {
    _wxRadioButtonSetValue( nativeHandle, value );
  }

  bool getValue( ) {
    return _wxRadioButtonGetValue( nativeHandle  );
  }
}

// ------------------------- wxRadioBox ----------------------

typedef _WxRadioBoxConstructorNative = Pointer Function( Pointer, Int32, Pointer<Utf8>, Int32, Int32, Int32, Int32, Int32, Pointer<Pointer<Utf8>>, Int32, Int32  );
typedef _WxRadioBoxConstructor = Pointer Function( Pointer, int, Pointer<Utf8>, int, int, int, int, int, Pointer<Pointer<Utf8>>, int, int  );
late _WxRadioBoxConstructor _wxRadioBoxConstructor;

typedef _WxRadioBoxGetCountNative = Int32 Function( Pointer  );
typedef _WxRadioBoxGetCount = int Function( Pointer  );
late _WxRadioBoxGetCount _wxRadioBoxGetCount;

typedef _WxRadioBoxIsEmptyNative = Bool Function( Pointer  );
typedef _WxRadioBoxIsEmpty = bool Function( Pointer  );
late _WxRadioBoxIsEmpty _wxRadioBoxIsEmpty;

typedef _WxRadioBoxSetStringNative = Void Function( Pointer, Int32, Pointer<Utf8>  );
typedef _WxRadioBoxSetString = void Function( Pointer, int, Pointer<Utf8>  );
late _WxRadioBoxSetString _wxRadioBoxSetString;

typedef _WxRadioBoxGetStringNative = Pointer<Utf8> Function( Pointer, Int32  );
typedef _WxRadioBoxGetString = Pointer<Utf8> Function( Pointer, int  );
late _WxRadioBoxGetString _wxRadioBoxGetString;

typedef _WxRadioBoxGetStringsNative = Pointer<Utf8> Function( Pointer  );
typedef _WxRadioBoxGetStrings = Pointer<Utf8> Function( Pointer  );
late _WxRadioBoxGetStrings _wxRadioBoxGetStrings;

typedef _WxRadioBoxFindStringNative = Int32 Function( Pointer, Pointer<Utf8>, Bool  );
typedef _WxRadioBoxFindString = int Function( Pointer, Pointer<Utf8>, bool  );
late _WxRadioBoxFindString _wxRadioBoxFindString;

typedef _WxRadioBoxSetSelectionNative = Void Function( Pointer, Int32  );
typedef _WxRadioBoxSetSelection = void Function( Pointer, int  );
late _WxRadioBoxSetSelection _wxRadioBoxSetSelection;

typedef _WxRadioBoxSetStringSelectionNative = Void Function( Pointer, Pointer<Utf8>  );
typedef _WxRadioBoxSetStringSelection = void Function( Pointer, Pointer<Utf8>  );
late _WxRadioBoxSetStringSelection _wxRadioBoxSetStringSelection;

typedef _WxRadioBoxSelectNative = Void Function( Pointer, Int32  );
typedef _WxRadioBoxSelect = void Function( Pointer, int  );
late _WxRadioBoxSelect _wxRadioBoxSelect;

typedef _WxRadioBoxGetSelectionNative = Int32 Function( Pointer  );
typedef _WxRadioBoxGetSelection = int Function( Pointer  );
late _WxRadioBoxGetSelection _wxRadioBoxGetSelection;

typedef _WxRadioBoxGetStringSelectionNative = Pointer<Utf8> Function( Pointer  );
typedef _WxRadioBoxGetStringSelection = Pointer<Utf8> Function( Pointer  );
late _WxRadioBoxGetStringSelection _wxRadioBoxGetStringSelection;

typedef _WxRadioBoxEnableItemNative = Void Function( Pointer, Int32, Bool  );
typedef _WxRadioBoxEnableItem = void Function( Pointer, int, bool  );
late _WxRadioBoxEnableItem _wxRadioBoxEnableItem;

/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxRA_LEFTTORIGHT | 0x0001 |
/// | wxRA_TOPTOBOTTOM | 0x0002 |
/// | wxRA_SPECIFY_COLS | wxHORIZONTAL |
/// | wxRA_SPECIFY_ROWS | wxVERTICAL |
/// | wxRA_HORIZONTAL | wxHORIZONTAL |
/// | wxRA_VERTICAL | wxVERTICAL |

const int wxRA_LEFTTORIGHT = 0x0001;
const int wxRA_TOPTOBOTTOM = 0x0002;
const int wxRA_SPECIFY_COLS = wxHORIZONTAL;
const int wxRA_SPECIFY_ROWS = wxVERTICAL;
const int wxRA_HORIZONTAL = wxHORIZONTAL;
const int wxRA_VERTICAL = wxVERTICAL;

class WxRadioBox extends WxItemContainerImmutable {
  WxRadioBox._defaultConstructor() : super._defaultConstructor();
  WxRadioBox( WxWindow parent, int id, String label, WxPoint pos, WxSize size, List<String> choices, { int majorDimension = 0, int style = wxRA_SPECIFY_COLS } ) : super._defaultConstructor() {
    final labelUtf8 = label.toNativeUtf8();
    Pointer<Pointer<Utf8>> choicesptrPtr = nullptr;
    List<Pointer<Utf8>> choicesUtf8PointerList = [];
    int choicesLength = 0;
    if (choices.isNotEmpty) {
      choicesUtf8PointerList = choices.map((str) => str.toNativeUtf8()).toList();
      choicesptrPtr = malloc.allocate(choicesUtf8PointerList.length * sizeOf<Pointer<Utf8>>());
      choices.asMap().forEach((index, utf) { choicesptrPtr[index] = choicesUtf8PointerList[index]; });
      choicesLength = choices.length;
    }
    nativeHandle = _wxRadioBoxConstructor( parent.nativeHandle, id, labelUtf8, pos.x, pos.y, size.x, size.y, choicesLength, choicesptrPtr, majorDimension, style );
    malloc.free( labelUtf8 );
    if (choices.isNotEmpty) {
      malloc.free( choicesptrPtr );
      for (final utf8 in choicesUtf8PointerList) { malloc.free( utf8 ); }
    }
    _postCreation();
  }
  WxRadioBox.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  int getCount( ) {
    return _wxRadioBoxGetCount( nativeHandle  );
  }

  bool isEmpty( ) {
    return _wxRadioBoxIsEmpty( nativeHandle  );
  }

  void setString( int index, String str ) {
    final strUtf8 = str.toNativeUtf8();
    _wxRadioBoxSetString( nativeHandle, index, strUtf8 );
    malloc.free( strUtf8 );
  }

  String getString( int index ) {
    Pointer<Utf8> ptrReturn = _wxRadioBoxGetString( nativeHandle, index );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }

  List<String> getStrings( ) {
    Pointer<Utf8> ptrReturn = _wxRadioBoxGetStrings( nativeHandle  );
    final List dynValues = jsonDecode(ptrReturn.toDartString());
    malloc.free( ptrReturn );
    final List<String> values = [];
    for ( final value in dynValues) { values.add( value as String ); }
    return values;
  }

  int findString( String string, { bool caseSensitive = false } ) {
    final stringUtf8 = string.toNativeUtf8();
    return _wxRadioBoxFindString( nativeHandle, stringUtf8, caseSensitive );
  }

  void setSelection( int index ) {
    _wxRadioBoxSetSelection( nativeHandle, index );
  }

  void setStringSelection( String sel ) {
    final selUtf8 = sel.toNativeUtf8();
    _wxRadioBoxSetStringSelection( nativeHandle, selUtf8 );
    malloc.free( selUtf8 );
  }

  void select( int index ) {
    _wxRadioBoxSelect( nativeHandle, index );
  }

  int getSelection( ) {
    return _wxRadioBoxGetSelection( nativeHandle  );
  }

  String getStringSelection( ) {
    Pointer<Utf8> ptrReturn = _wxRadioBoxGetStringSelection( nativeHandle  );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }

  void enableItem( int index, { bool enable = false } ) {
    _wxRadioBoxEnableItem( nativeHandle, index, enable );
  }
}

// ------------------------- wxChoice ----------------------

typedef _WxChoiceConstructorNative = Pointer Function( Pointer, Int32, Int32, Int32, Int32, Int32, Int32, Pointer<Pointer<Utf8>>, Int32  );
typedef _WxChoiceConstructor = Pointer Function( Pointer, int, int, int, int, int, int, Pointer<Pointer<Utf8>>, int  );
late _WxChoiceConstructor _wxChoiceConstructor;

typedef _WxChoiceSetColumnsNative = Void Function( Pointer, Int32  );
typedef _WxChoiceSetColumns = void Function( Pointer, int  );
late _WxChoiceSetColumns _wxChoiceSetColumns;

typedef _WxChoiceGetColumnsNative = Int32 Function( Pointer  );
typedef _WxChoiceGetColumns = int Function( Pointer  );
late _WxChoiceGetColumns _wxChoiceGetColumns;

typedef _WxChoiceIsSortedNative = Bool Function( Pointer  );
typedef _WxChoiceIsSorted = bool Function( Pointer  );
late _WxChoiceIsSorted _wxChoiceIsSorted;

typedef _WxChoiceGetCountNative = Int32 Function( Pointer  );
typedef _WxChoiceGetCount = int Function( Pointer  );
late _WxChoiceGetCount _wxChoiceGetCount;

typedef _WxChoiceIsEmptyNative = Bool Function( Pointer  );
typedef _WxChoiceIsEmpty = bool Function( Pointer  );
late _WxChoiceIsEmpty _wxChoiceIsEmpty;

typedef _WxChoiceSetStringNative = Void Function( Pointer, Int32, Pointer<Utf8>  );
typedef _WxChoiceSetString = void Function( Pointer, int, Pointer<Utf8>  );
late _WxChoiceSetString _wxChoiceSetString;

typedef _WxChoiceGetStringNative = Pointer<Utf8> Function( Pointer, Int32  );
typedef _WxChoiceGetString = Pointer<Utf8> Function( Pointer, int  );
late _WxChoiceGetString _wxChoiceGetString;

typedef _WxChoiceGetStringsNative = Pointer<Utf8> Function( Pointer  );
typedef _WxChoiceGetStrings = Pointer<Utf8> Function( Pointer  );
late _WxChoiceGetStrings _wxChoiceGetStrings;

typedef _WxChoiceFindStringNative = Int32 Function( Pointer, Pointer<Utf8>, Bool  );
typedef _WxChoiceFindString = int Function( Pointer, Pointer<Utf8>, bool  );
late _WxChoiceFindString _wxChoiceFindString;

typedef _WxChoiceSetSelectionNative = Void Function( Pointer, Int32  );
typedef _WxChoiceSetSelection = void Function( Pointer, int  );
late _WxChoiceSetSelection _wxChoiceSetSelection;

typedef _WxChoiceSetStringSelectionNative = Void Function( Pointer, Pointer<Utf8>  );
typedef _WxChoiceSetStringSelection = void Function( Pointer, Pointer<Utf8>  );
late _WxChoiceSetStringSelection _wxChoiceSetStringSelection;

typedef _WxChoiceSelectNative = Void Function( Pointer, Int32  );
typedef _WxChoiceSelect = void Function( Pointer, int  );
late _WxChoiceSelect _wxChoiceSelect;

typedef _WxChoiceGetSelectionNative = Int32 Function( Pointer  );
typedef _WxChoiceGetSelection = int Function( Pointer  );
late _WxChoiceGetSelection _wxChoiceGetSelection;

typedef _WxChoiceGetStringSelectionNative = Pointer<Utf8> Function( Pointer  );
typedef _WxChoiceGetStringSelection = Pointer<Utf8> Function( Pointer  );
late _WxChoiceGetStringSelection _wxChoiceGetStringSelection;

typedef _WxChoiceClearNative = Void Function( Pointer  );
typedef _WxChoiceClear = void Function( Pointer  );
late _WxChoiceClear _wxChoiceClear;

typedef _WxChoiceDeleteNative = Void Function( Pointer, Int32  );
typedef _WxChoiceDelete = void Function( Pointer, int  );
late _WxChoiceDelete _wxChoiceDelete;

typedef _WxChoiceSetNative = Void Function( Pointer, Int32, Pointer<Pointer<Utf8>>  );
typedef _WxChoiceSet = void Function( Pointer, int, Pointer<Pointer<Utf8>>  );
late _WxChoiceSet _wxChoiceSet;

typedef _WxChoiceAppendNative = Void Function( Pointer, Pointer<Utf8>, Pointer  );
typedef _WxChoiceAppend = void Function( Pointer, Pointer<Utf8>, Pointer  );
late _WxChoiceAppend _wxChoiceAppend;

typedef _WxChoiceAppendListNative = Void Function( Pointer, Int32, Pointer<Pointer<Utf8>>  );
typedef _WxChoiceAppendList = void Function( Pointer, int, Pointer<Pointer<Utf8>>  );
late _WxChoiceAppendList _wxChoiceAppendList;

typedef _WxChoiceInsertNative = Void Function( Pointer, Pointer<Utf8>, Int32, Pointer  );
typedef _WxChoiceInsert = void Function( Pointer, Pointer<Utf8>, int, Pointer  );
late _WxChoiceInsert _wxChoiceInsert;

typedef _WxChoiceInsertListNative = Void Function( Pointer, Int32, Pointer<Pointer<Utf8>>, Int32  );
typedef _WxChoiceInsertList = void Function( Pointer, int, Pointer<Pointer<Utf8>>, int  );
late _WxChoiceInsertList _wxChoiceInsertList;

typedef _WxChoiceSetClientDataNative = Void Function( Pointer, Int32, Pointer  );
typedef _WxChoiceSetClientData = void Function( Pointer, int, Pointer  );
late _WxChoiceSetClientData _wxChoiceSetClientData;

typedef _WxChoiceGetClientDataNative = Pointer Function( Pointer, Int32  );
typedef _WxChoiceGetClientData = Pointer Function( Pointer, int  );
late _WxChoiceGetClientData _wxChoiceGetClientData;

class WxChoice extends WxItemContainer {
  WxChoice._defaultConstructor() : super._defaultConstructor();
  WxChoice( WxWindow parent, int id, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, List<String>? choices, int style = 0 } ) : super._defaultConstructor() {
    Pointer<Pointer<Utf8>> choicesptrPtr = nullptr;
    List<Pointer<Utf8>> choicesUtf8PointerList = [];
    int choicesLength = 0;
    if ((choices != null) && (choices.isNotEmpty)) {
      choicesUtf8PointerList = choices.map((str) => str.toNativeUtf8()).toList();
      choicesptrPtr = malloc.allocate(choicesUtf8PointerList.length * sizeOf<Pointer<Utf8>>());
      choices.asMap().forEach((index, utf) { choicesptrPtr[index] = choicesUtf8PointerList[index]; });
      choicesLength = choices.length;
    }
    nativeHandle = _wxChoiceConstructor( parent.nativeHandle, id, pos.x, pos.y, size.x, size.y, choicesLength, choicesptrPtr, style );
    if ((choices != null) && (choices.isNotEmpty)) {
      malloc.free( choicesptrPtr );
      for (final utf8 in choicesUtf8PointerList) { malloc.free( utf8 ); }
    }
    _postCreation();
  }
  WxChoice.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  void setColumns( int cols ) {
    _wxChoiceSetColumns( nativeHandle, cols );
  }

  int getColumns( ) {
    return _wxChoiceGetColumns( nativeHandle  );
  }

  bool isSorted( ) {
    return _wxChoiceIsSorted( nativeHandle  );
  }

  int getCount( ) {
    return _wxChoiceGetCount( nativeHandle  );
  }

  bool isEmpty( ) {
    return _wxChoiceIsEmpty( nativeHandle  );
  }

  void setString( int index, String str ) {
    final strUtf8 = str.toNativeUtf8();
    _wxChoiceSetString( nativeHandle, index, strUtf8 );
    malloc.free( strUtf8 );
  }

  String getString( int index ) {
    Pointer<Utf8> ptrReturn = _wxChoiceGetString( nativeHandle, index );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }

  List<String> getStrings( ) {
    Pointer<Utf8> ptrReturn = _wxChoiceGetStrings( nativeHandle  );
    final List dynValues = jsonDecode(ptrReturn.toDartString());
    malloc.free( ptrReturn );
    final List<String> values = [];
    for ( final value in dynValues) { values.add( value as String ); }
    return values;
  }

  int findString( String string, { bool caseSensitive = false } ) {
    final stringUtf8 = string.toNativeUtf8();
    return _wxChoiceFindString( nativeHandle, stringUtf8, caseSensitive );
  }

  void setSelection( int index ) {
    _wxChoiceSetSelection( nativeHandle, index );
  }

  void setStringSelection( String sel ) {
    final selUtf8 = sel.toNativeUtf8();
    _wxChoiceSetStringSelection( nativeHandle, selUtf8 );
    malloc.free( selUtf8 );
  }

  void select( int index ) {
    _wxChoiceSelect( nativeHandle, index );
  }

  int getSelection( ) {
    return _wxChoiceGetSelection( nativeHandle  );
  }

  String getStringSelection( ) {
    Pointer<Utf8> ptrReturn = _wxChoiceGetStringSelection( nativeHandle  );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }

  void clear( ) {
    _wxChoiceClear( nativeHandle  );
  }

  void delete( int index ) {
    _wxChoiceDelete( nativeHandle, index );
  }

  void set( List<String> items ) {
    Pointer<Pointer<Utf8>> itemsptrPtr = nullptr;
    List<Pointer<Utf8>> itemsUtf8PointerList = [];
    int itemsLength = 0;
    if (items.isNotEmpty) {
      itemsUtf8PointerList = items.map((str) => str.toNativeUtf8()).toList();
      itemsptrPtr = malloc.allocate(itemsUtf8PointerList.length * sizeOf<Pointer<Utf8>>());
      items.asMap().forEach((index, utf) { itemsptrPtr[index] = itemsUtf8PointerList[index]; });
      itemsLength = items.length;
    }
    _wxChoiceSet( nativeHandle, itemsLength, itemsptrPtr );
    if (items.isNotEmpty) {
      malloc.free( itemsptrPtr );
      for (final utf8 in itemsUtf8PointerList) { malloc.free( utf8 ); }
    }
  }

  void append( String item, { dynamic data } ) {
    final itemUtf8 = item.toNativeUtf8();
    final dataClientDataNativeHandle = _wxClientDataConstructor();
    _clientDataList[ dataClientDataNativeHandle ] = data;
    _wxChoiceAppend( nativeHandle, itemUtf8, dataClientDataNativeHandle );
    malloc.free( itemUtf8 );
  }

  void appendList( List<String> items ) {
    Pointer<Pointer<Utf8>> itemsptrPtr = nullptr;
    List<Pointer<Utf8>> itemsUtf8PointerList = [];
    int itemsLength = 0;
    if (items.isNotEmpty) {
      itemsUtf8PointerList = items.map((str) => str.toNativeUtf8()).toList();
      itemsptrPtr = malloc.allocate(itemsUtf8PointerList.length * sizeOf<Pointer<Utf8>>());
      items.asMap().forEach((index, utf) { itemsptrPtr[index] = itemsUtf8PointerList[index]; });
      itemsLength = items.length;
    }
    _wxChoiceAppendList( nativeHandle, itemsLength, itemsptrPtr );
    if (items.isNotEmpty) {
      malloc.free( itemsptrPtr );
      for (final utf8 in itemsUtf8PointerList) { malloc.free( utf8 ); }
    }
  }

  void insert( String item, int pos, { dynamic data } ) {
    final itemUtf8 = item.toNativeUtf8();
    final dataClientDataNativeHandle = _wxClientDataConstructor();
    _clientDataList[ dataClientDataNativeHandle ] = data;
    _wxChoiceInsert( nativeHandle, itemUtf8, pos, dataClientDataNativeHandle );
    malloc.free( itemUtf8 );
  }

  void insertList( List<String> items, int pos ) {
    Pointer<Pointer<Utf8>> itemsptrPtr = nullptr;
    List<Pointer<Utf8>> itemsUtf8PointerList = [];
    int itemsLength = 0;
    if (items.isNotEmpty) {
      itemsUtf8PointerList = items.map((str) => str.toNativeUtf8()).toList();
      itemsptrPtr = malloc.allocate(itemsUtf8PointerList.length * sizeOf<Pointer<Utf8>>());
      items.asMap().forEach((index, utf) { itemsptrPtr[index] = itemsUtf8PointerList[index]; });
      itemsLength = items.length;
    }
    _wxChoiceInsertList( nativeHandle, itemsLength, itemsptrPtr, pos );
    if (items.isNotEmpty) {
      malloc.free( itemsptrPtr );
      for (final utf8 in itemsUtf8PointerList) { malloc.free( utf8 ); }
    }
  }

  void setClientData( int index, dynamic data ) {
    final dataClientDataNativeHandle = _wxClientDataConstructor();
    _clientDataList[ dataClientDataNativeHandle ] = data;
    _wxChoiceSetClientData( nativeHandle, index, dataClientDataNativeHandle );
  }

  dynamic getClientData( int index ) {
    final returnedNativeHandle = _wxChoiceGetClientData( nativeHandle, index );
    if (returnedNativeHandle == nullptr) return null;
    return _clientDataList[ returnedNativeHandle ] ;
  }
}

// ------------------------- wxListBox ----------------------

typedef _WxListBoxConstructorNative = Pointer Function( Pointer, Int32, Int32, Int32, Int32, Int32, Int32, Pointer<Pointer<Utf8>>, Int32  );
typedef _WxListBoxConstructor = Pointer Function( Pointer, int, int, int, int, int, int, Pointer<Pointer<Utf8>>, int  );
late _WxListBoxConstructor _wxListBoxConstructor;

typedef _WxListBoxIsSortedNative = Bool Function( Pointer  );
typedef _WxListBoxIsSorted = bool Function( Pointer  );
late _WxListBoxIsSorted _wxListBoxIsSorted;

typedef _WxListBoxIsSelectedNative = Bool Function( Pointer, Int32  );
typedef _WxListBoxIsSelected = bool Function( Pointer, int  );
late _WxListBoxIsSelected _wxListBoxIsSelected;

typedef _WxListBoxDeselectNative = Void Function( Pointer, Int32  );
typedef _WxListBoxDeselect = void Function( Pointer, int  );
late _WxListBoxDeselect _wxListBoxDeselect;

typedef _WxListBoxSetFirstItemNative = Void Function( Pointer, Int32  );
typedef _WxListBoxSetFirstItem = void Function( Pointer, int  );
late _WxListBoxSetFirstItem _wxListBoxSetFirstItem;

typedef _WxListBoxEnsureVisibleNative = Void Function( Pointer, Int32  );
typedef _WxListBoxEnsureVisible = void Function( Pointer, int  );
late _WxListBoxEnsureVisible _wxListBoxEnsureVisible;

typedef _WxListBoxGetCountPerPageNative = Int32 Function( Pointer  );
typedef _WxListBoxGetCountPerPage = int Function( Pointer  );
late _WxListBoxGetCountPerPage _wxListBoxGetCountPerPage;

typedef _WxListBoxGetTopItemNative = Int32 Function( Pointer  );
typedef _WxListBoxGetTopItem = int Function( Pointer  );
late _WxListBoxGetTopItem _wxListBoxGetTopItem;

typedef _WxListBoxGetCountNative = Int32 Function( Pointer  );
typedef _WxListBoxGetCount = int Function( Pointer  );
late _WxListBoxGetCount _wxListBoxGetCount;

typedef _WxListBoxIsEmptyNative = Bool Function( Pointer  );
typedef _WxListBoxIsEmpty = bool Function( Pointer  );
late _WxListBoxIsEmpty _wxListBoxIsEmpty;

typedef _WxListBoxSetStringNative = Void Function( Pointer, Int32, Pointer<Utf8>  );
typedef _WxListBoxSetString = void Function( Pointer, int, Pointer<Utf8>  );
late _WxListBoxSetString _wxListBoxSetString;

typedef _WxListBoxGetStringNative = Pointer<Utf8> Function( Pointer, Int32  );
typedef _WxListBoxGetString = Pointer<Utf8> Function( Pointer, int  );
late _WxListBoxGetString _wxListBoxGetString;

typedef _WxListBoxGetStringsNative = Pointer<Utf8> Function( Pointer  );
typedef _WxListBoxGetStrings = Pointer<Utf8> Function( Pointer  );
late _WxListBoxGetStrings _wxListBoxGetStrings;

typedef _WxListBoxFindStringNative = Int32 Function( Pointer, Pointer<Utf8>, Bool  );
typedef _WxListBoxFindString = int Function( Pointer, Pointer<Utf8>, bool  );
late _WxListBoxFindString _wxListBoxFindString;

typedef _WxListBoxSetSelectionNative = Void Function( Pointer, Int32  );
typedef _WxListBoxSetSelection = void Function( Pointer, int  );
late _WxListBoxSetSelection _wxListBoxSetSelection;

typedef _WxListBoxSetStringSelectionNative = Void Function( Pointer, Pointer<Utf8>  );
typedef _WxListBoxSetStringSelection = void Function( Pointer, Pointer<Utf8>  );
late _WxListBoxSetStringSelection _wxListBoxSetStringSelection;

typedef _WxListBoxSelectNative = Void Function( Pointer, Int32  );
typedef _WxListBoxSelect = void Function( Pointer, int  );
late _WxListBoxSelect _wxListBoxSelect;

typedef _WxListBoxGetSelectionNative = Int32 Function( Pointer  );
typedef _WxListBoxGetSelection = int Function( Pointer  );
late _WxListBoxGetSelection _wxListBoxGetSelection;

typedef _WxListBoxGetSelectionsNative = Pointer<Utf8> Function( Pointer  );
typedef _WxListBoxGetSelections = Pointer<Utf8> Function( Pointer  );
late _WxListBoxGetSelections _wxListBoxGetSelections;

typedef _WxListBoxGetStringSelectionNative = Pointer<Utf8> Function( Pointer  );
typedef _WxListBoxGetStringSelection = Pointer<Utf8> Function( Pointer  );
late _WxListBoxGetStringSelection _wxListBoxGetStringSelection;

typedef _WxListBoxClearNative = Void Function( Pointer  );
typedef _WxListBoxClear = void Function( Pointer  );
late _WxListBoxClear _wxListBoxClear;

typedef _WxListBoxDeleteNative = Void Function( Pointer, Int32  );
typedef _WxListBoxDelete = void Function( Pointer, int  );
late _WxListBoxDelete _wxListBoxDelete;

typedef _WxListBoxSetNative = Void Function( Pointer, Int32, Pointer<Pointer<Utf8>>  );
typedef _WxListBoxSet = void Function( Pointer, int, Pointer<Pointer<Utf8>>  );
late _WxListBoxSet _wxListBoxSet;

typedef _WxListBoxAppendNative = Void Function( Pointer, Pointer<Utf8>, Pointer  );
typedef _WxListBoxAppend = void Function( Pointer, Pointer<Utf8>, Pointer  );
late _WxListBoxAppend _wxListBoxAppend;

typedef _WxListBoxAppendListNative = Void Function( Pointer, Int32, Pointer<Pointer<Utf8>>  );
typedef _WxListBoxAppendList = void Function( Pointer, int, Pointer<Pointer<Utf8>>  );
late _WxListBoxAppendList _wxListBoxAppendList;

typedef _WxListBoxInsertNative = Void Function( Pointer, Pointer<Utf8>, Int32, Pointer  );
typedef _WxListBoxInsert = void Function( Pointer, Pointer<Utf8>, int, Pointer  );
late _WxListBoxInsert _wxListBoxInsert;

typedef _WxListBoxInsertListNative = Void Function( Pointer, Int32, Pointer<Pointer<Utf8>>, Int32  );
typedef _WxListBoxInsertList = void Function( Pointer, int, Pointer<Pointer<Utf8>>, int  );
late _WxListBoxInsertList _wxListBoxInsertList;

typedef _WxListBoxSetClientDataNative = Void Function( Pointer, Int32, Pointer  );
typedef _WxListBoxSetClientData = void Function( Pointer, int, Pointer  );
late _WxListBoxSetClientData _wxListBoxSetClientData;

typedef _WxListBoxGetClientDataNative = Pointer Function( Pointer, Int32  );
typedef _WxListBoxGetClientData = Pointer Function( Pointer, int  );
late _WxListBoxGetClientData _wxListBoxGetClientData;

/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxLB_SORT | 0x0010 |
/// | wxLB_SINGLE | 0x0020 |
/// | wxLB_MULTIPLE | 0x0040 |
/// | wxLB_EXTENDED | 0x0080 |
/// | wxLB_ALWAYS_SB | 0x0200 |
/// | wxLB_NO_SB | 0x0400 |
/// | wxLB_HSCROLL | wxHSCROLL |

const int wxLB_SORT = 0x0010;
const int wxLB_SINGLE = 0x0020;
const int wxLB_MULTIPLE = 0x0040;
const int wxLB_EXTENDED = 0x0080;
const int wxLB_ALWAYS_SB = 0x0200;
const int wxLB_NO_SB = 0x0400;
const int wxLB_HSCROLL = wxHSCROLL;

class WxListBox extends WxItemContainer {
  WxListBox._defaultConstructor() : super._defaultConstructor();
  WxListBox( WxWindow parent, int id, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, List<String>? choices, int style = 0 } ) : super._defaultConstructor() {
    Pointer<Pointer<Utf8>> choicesptrPtr = nullptr;
    List<Pointer<Utf8>> choicesUtf8PointerList = [];
    int choicesLength = 0;
    if ((choices != null) && (choices.isNotEmpty)) {
      choicesUtf8PointerList = choices.map((str) => str.toNativeUtf8()).toList();
      choicesptrPtr = malloc.allocate(choicesUtf8PointerList.length * sizeOf<Pointer<Utf8>>());
      choices.asMap().forEach((index, utf) { choicesptrPtr[index] = choicesUtf8PointerList[index]; });
      choicesLength = choices.length;
    }
    nativeHandle = _wxListBoxConstructor( parent.nativeHandle, id, pos.x, pos.y, size.x, size.y, choicesLength, choicesptrPtr, style );
    if ((choices != null) && (choices.isNotEmpty)) {
      malloc.free( choicesptrPtr );
      for (final utf8 in choicesUtf8PointerList) { malloc.free( utf8 ); }
    }
    _postCreation();
  }
  WxListBox.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  bool isSorted( ) {
    return _wxListBoxIsSorted( nativeHandle  );
  }

  bool isSelected( int n ) {
    return _wxListBoxIsSelected( nativeHandle, n );
  }

  void deselect( int n ) {
    _wxListBoxDeselect( nativeHandle, n );
  }

  void setFirstItem( int n ) {
    _wxListBoxSetFirstItem( nativeHandle, n );
  }

  void ensureVisible( int n ) {
    _wxListBoxEnsureVisible( nativeHandle, n );
  }

  int getCountPerPage( ) {
    return _wxListBoxGetCountPerPage( nativeHandle  );
  }

  int getTopItem( ) {
    return _wxListBoxGetTopItem( nativeHandle  );
  }

  int getCount( ) {
    return _wxListBoxGetCount( nativeHandle  );
  }

  bool isEmpty( ) {
    return _wxListBoxIsEmpty( nativeHandle  );
  }

  void setString( int index, String str ) {
    final strUtf8 = str.toNativeUtf8();
    _wxListBoxSetString( nativeHandle, index, strUtf8 );
    malloc.free( strUtf8 );
  }

  String getString( int index ) {
    Pointer<Utf8> ptrReturn = _wxListBoxGetString( nativeHandle, index );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }

  List<String> getStrings( ) {
    Pointer<Utf8> ptrReturn = _wxListBoxGetStrings( nativeHandle  );
    final List dynValues = jsonDecode(ptrReturn.toDartString());
    malloc.free( ptrReturn );
    final List<String> values = [];
    for ( final value in dynValues) { values.add( value as String ); }
    return values;
  }

  int findString( String string, { bool caseSensitive = false } ) {
    final stringUtf8 = string.toNativeUtf8();
    return _wxListBoxFindString( nativeHandle, stringUtf8, caseSensitive );
  }

  void setSelection( int index ) {
    _wxListBoxSetSelection( nativeHandle, index );
  }

  void setStringSelection( String sel ) {
    final selUtf8 = sel.toNativeUtf8();
    _wxListBoxSetStringSelection( nativeHandle, selUtf8 );
    malloc.free( selUtf8 );
  }

  void select( int index ) {
    _wxListBoxSelect( nativeHandle, index );
  }

  int getSelection( ) {
    return _wxListBoxGetSelection( nativeHandle  );
  }

  List<int> getSelections( ) {
    Pointer<Utf8> ptrReturn = _wxListBoxGetSelections( nativeHandle  );
    final List dynValues = jsonDecode(ptrReturn.toDartString());
    malloc.free( ptrReturn );
    final List<int> values = [];
    for ( final value in dynValues) { values.add( value as int ); }
    return values;
  }

  String getStringSelection( ) {
    Pointer<Utf8> ptrReturn = _wxListBoxGetStringSelection( nativeHandle  );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }

  void clear( ) {
    _wxListBoxClear( nativeHandle  );
  }

  void delete( int index ) {
    _wxListBoxDelete( nativeHandle, index );
  }

  void set( List<String> items ) {
    Pointer<Pointer<Utf8>> itemsptrPtr = nullptr;
    List<Pointer<Utf8>> itemsUtf8PointerList = [];
    int itemsLength = 0;
    if (items.isNotEmpty) {
      itemsUtf8PointerList = items.map((str) => str.toNativeUtf8()).toList();
      itemsptrPtr = malloc.allocate(itemsUtf8PointerList.length * sizeOf<Pointer<Utf8>>());
      items.asMap().forEach((index, utf) { itemsptrPtr[index] = itemsUtf8PointerList[index]; });
      itemsLength = items.length;
    }
    _wxListBoxSet( nativeHandle, itemsLength, itemsptrPtr );
    if (items.isNotEmpty) {
      malloc.free( itemsptrPtr );
      for (final utf8 in itemsUtf8PointerList) { malloc.free( utf8 ); }
    }
  }

  void append( String item, { dynamic data } ) {
    final itemUtf8 = item.toNativeUtf8();
    final dataClientDataNativeHandle = _wxClientDataConstructor();
    _clientDataList[ dataClientDataNativeHandle ] = data;
    _wxListBoxAppend( nativeHandle, itemUtf8, dataClientDataNativeHandle );
    malloc.free( itemUtf8 );
  }

  void appendList( List<String> items ) {
    Pointer<Pointer<Utf8>> itemsptrPtr = nullptr;
    List<Pointer<Utf8>> itemsUtf8PointerList = [];
    int itemsLength = 0;
    if (items.isNotEmpty) {
      itemsUtf8PointerList = items.map((str) => str.toNativeUtf8()).toList();
      itemsptrPtr = malloc.allocate(itemsUtf8PointerList.length * sizeOf<Pointer<Utf8>>());
      items.asMap().forEach((index, utf) { itemsptrPtr[index] = itemsUtf8PointerList[index]; });
      itemsLength = items.length;
    }
    _wxListBoxAppendList( nativeHandle, itemsLength, itemsptrPtr );
    if (items.isNotEmpty) {
      malloc.free( itemsptrPtr );
      for (final utf8 in itemsUtf8PointerList) { malloc.free( utf8 ); }
    }
  }

  void insert( String item, int pos, { dynamic data } ) {
    final itemUtf8 = item.toNativeUtf8();
    final dataClientDataNativeHandle = _wxClientDataConstructor();
    _clientDataList[ dataClientDataNativeHandle ] = data;
    _wxListBoxInsert( nativeHandle, itemUtf8, pos, dataClientDataNativeHandle );
    malloc.free( itemUtf8 );
  }

  void insertList( List<String> items, int pos ) {
    Pointer<Pointer<Utf8>> itemsptrPtr = nullptr;
    List<Pointer<Utf8>> itemsUtf8PointerList = [];
    int itemsLength = 0;
    if (items.isNotEmpty) {
      itemsUtf8PointerList = items.map((str) => str.toNativeUtf8()).toList();
      itemsptrPtr = malloc.allocate(itemsUtf8PointerList.length * sizeOf<Pointer<Utf8>>());
      items.asMap().forEach((index, utf) { itemsptrPtr[index] = itemsUtf8PointerList[index]; });
      itemsLength = items.length;
    }
    _wxListBoxInsertList( nativeHandle, itemsLength, itemsptrPtr, pos );
    if (items.isNotEmpty) {
      malloc.free( itemsptrPtr );
      for (final utf8 in itemsUtf8PointerList) { malloc.free( utf8 ); }
    }
  }

  void setClientData( int index, dynamic data ) {
    final dataClientDataNativeHandle = _wxClientDataConstructor();
    _clientDataList[ dataClientDataNativeHandle ] = data;
    _wxListBoxSetClientData( nativeHandle, index, dataClientDataNativeHandle );
  }

  dynamic getClientData( int index ) {
    final returnedNativeHandle = _wxListBoxGetClientData( nativeHandle, index );
    if (returnedNativeHandle == nullptr) return null;
    return _clientDataList[ returnedNativeHandle ] ;
  }
}

// ------------------------- wxGauge ----------------------

typedef _WxGaugeConstructorNative = Pointer Function( Pointer, Int32, Int32, Int32, Int32, Int32, Int32, Int32  );
typedef _WxGaugeConstructor = Pointer Function( Pointer, int, int, int, int, int, int, int  );
late _WxGaugeConstructor _wxGaugeConstructor;

typedef _WxGaugeIsVerticalNative = Bool Function( Pointer  );
typedef _WxGaugeIsVertical = bool Function( Pointer  );
late _WxGaugeIsVertical _wxGaugeIsVertical;

typedef _WxGaugeGetValueNative = Int32 Function( Pointer  );
typedef _WxGaugeGetValue = int Function( Pointer  );
late _WxGaugeGetValue _wxGaugeGetValue;

typedef _WxGaugeSetValueNative = Void Function( Pointer, Int32  );
typedef _WxGaugeSetValue = void Function( Pointer, int  );
late _WxGaugeSetValue _wxGaugeSetValue;

typedef _WxGaugeGetRangeNative = Int32 Function( Pointer  );
typedef _WxGaugeGetRange = int Function( Pointer  );
late _WxGaugeGetRange _wxGaugeGetRange;

typedef _WxGaugeSetRangeNative = Void Function( Pointer, Int32  );
typedef _WxGaugeSetRange = void Function( Pointer, int  );
late _WxGaugeSetRange _wxGaugeSetRange;

typedef _WxGaugePulseNative = Void Function( Pointer  );
typedef _WxGaugePulse = void Function( Pointer  );
late _WxGaugePulse _wxGaugePulse;

/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxGA_HORIZONTAL | wxHORIZONTAL |
/// | wxGA_VERTICAL | wxVERTICAL |
/// | wxGA_SMOOTH | 0x0020 |
/// | wxGA_TEXT | 0x0040 |

const int wxGA_HORIZONTAL = wxHORIZONTAL;
const int wxGA_VERTICAL = wxVERTICAL;
const int wxGA_SMOOTH = 0x0020;
const int wxGA_TEXT = 0x0040;

class WxGauge extends WxControl {
  WxGauge._defaultConstructor() : super._defaultConstructor();
  WxGauge( WxWindow parent, int id, int range, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = wxGA_HORIZONTAL } ) : super._defaultConstructor() {
    nativeHandle = _wxGaugeConstructor( parent.nativeHandle, id, range, pos.x, pos.y, size.x, size.y, style );
    _postCreation();
  }
  WxGauge.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  bool isVertical( ) {
    return _wxGaugeIsVertical( nativeHandle  );
  }

  int getValue( ) {
    return _wxGaugeGetValue( nativeHandle  );
  }

  void setValue( int value ) {
    _wxGaugeSetValue( nativeHandle, value );
  }

  int getRange( ) {
    return _wxGaugeGetRange( nativeHandle  );
  }

  void setRange( int range ) {
    _wxGaugeSetRange( nativeHandle, range );
  }

  void pulse( ) {
    _wxGaugePulse( nativeHandle  );
  }
}

// ------------------------- wxSlider ----------------------

typedef _WxSliderConstructorNative = Pointer Function( Pointer, Int32, Int32, Int32, Int32, Int32, Int32, Int32, Int32, Int32  );
typedef _WxSliderConstructor = Pointer Function( Pointer, int, int, int, int, int, int, int, int, int  );
late _WxSliderConstructor _wxSliderConstructor;

typedef _WxSliderGetLineSizeNative = Int32 Function( Pointer  );
typedef _WxSliderGetLineSize = int Function( Pointer  );
late _WxSliderGetLineSize _wxSliderGetLineSize;

typedef _WxSliderSetLineSizeNative = Void Function( Pointer, Int32  );
typedef _WxSliderSetLineSize = void Function( Pointer, int  );
late _WxSliderSetLineSize _wxSliderSetLineSize;

typedef _WxSliderGetValueNative = Int32 Function( Pointer  );
typedef _WxSliderGetValue = int Function( Pointer  );
late _WxSliderGetValue _wxSliderGetValue;

typedef _WxSliderSetValueNative = Void Function( Pointer, Int32  );
typedef _WxSliderSetValue = void Function( Pointer, int  );
late _WxSliderSetValue _wxSliderSetValue;

typedef _WxSliderGetTickFreqNative = Int32 Function( Pointer  );
typedef _WxSliderGetTickFreq = int Function( Pointer  );
late _WxSliderGetTickFreq _wxSliderGetTickFreq;

typedef _WxSliderSetTickNative = Void Function( Pointer, Int32  );
typedef _WxSliderSetTick = void Function( Pointer, int  );
late _WxSliderSetTick _wxSliderSetTick;

typedef _WxSliderClearTicksNative = Void Function( Pointer  );
typedef _WxSliderClearTicks = void Function( Pointer  );
late _WxSliderClearTicks _wxSliderClearTicks;

typedef _WxSliderSetRangeNative = Void Function( Pointer, Int32, Int32  );
typedef _WxSliderSetRange = void Function( Pointer, int, int  );
late _WxSliderSetRange _wxSliderSetRange;

typedef _WxSliderGetMinNative = Int32 Function( Pointer  );
typedef _WxSliderGetMin = int Function( Pointer  );
late _WxSliderGetMin _wxSliderGetMin;

typedef _WxSliderSetMinNative = Void Function( Pointer, Int32  );
typedef _WxSliderSetMin = void Function( Pointer, int  );
late _WxSliderSetMin _wxSliderSetMin;

typedef _WxSliderGetMaxNative = Int32 Function( Pointer  );
typedef _WxSliderGetMax = int Function( Pointer  );
late _WxSliderGetMax _wxSliderGetMax;

typedef _WxSliderSetMaxNative = Void Function( Pointer, Int32  );
typedef _WxSliderSetMax = void Function( Pointer, int  );
late _WxSliderSetMax _wxSliderSetMax;

typedef _WxSliderGetPageSizeNative = Int32 Function( Pointer  );
typedef _WxSliderGetPageSize = int Function( Pointer  );
late _WxSliderGetPageSize _wxSliderGetPageSize;

typedef _WxSliderSetPageSizeNative = Void Function( Pointer, Int32  );
typedef _WxSliderSetPageSize = void Function( Pointer, int  );
late _WxSliderSetPageSize _wxSliderSetPageSize;

/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxSL_HORIZONTAL | wxHORIZONTAL |
/// | wxSL_VERTICAL | wxVERTICAL |
/// | wxSL_LEFT | 0x0040 |
/// | wxSL_RIGHT | 0x0100 |
/// | wxSL_TOP | 0x0080 |
/// | wxSL_BOTTOM | 0x0200 |
/// | wxSL_AUTOTICKS | 0x0010 |
/// | wxSL_MIN_MAX_LABELS | 0x2000 |
/// | wxSL_VALUE_LABEL | 0x4000 |
/// | wxSL_LABELS | (wxSL_MIN_MAX_LABELS|wxSL_VALUE_LABEL) |
/// | wxSL_INVERSE | 0x1000 |

const int wxSL_HORIZONTAL = wxHORIZONTAL;
const int wxSL_VERTICAL = wxVERTICAL;
const int wxSL_LEFT = 0x0040;
const int wxSL_RIGHT = 0x0100;
const int wxSL_TOP = 0x0080;
const int wxSL_BOTTOM = 0x0200;
const int wxSL_AUTOTICKS = 0x0010;
const int wxSL_MIN_MAX_LABELS = 0x2000;
const int wxSL_VALUE_LABEL = 0x4000;
const int wxSL_LABELS = (wxSL_MIN_MAX_LABELS|wxSL_VALUE_LABEL);
const int wxSL_INVERSE = 0x1000;

class WxSlider extends WxControl {
  WxSlider._defaultConstructor() : super._defaultConstructor();
  WxSlider( WxWindow parent, int id, int value, int min, int max, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = wxSL_HORIZONTAL } ) : super._defaultConstructor() {
    nativeHandle = _wxSliderConstructor( parent.nativeHandle, id, value, min, max, pos.x, pos.y, size.x, size.y, style );
    _postCreation();
  }
  WxSlider.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  int getLineSize( ) {
    return _wxSliderGetLineSize( nativeHandle  );
  }

  void setLineSize( int lineSize ) {
    _wxSliderSetLineSize( nativeHandle, lineSize );
  }

  int getValue( ) {
    return _wxSliderGetValue( nativeHandle  );
  }

  void setValue( int value ) {
    _wxSliderSetValue( nativeHandle, value );
  }

  int getTickFreq( ) {
    return _wxSliderGetTickFreq( nativeHandle  );
  }

  void setTick( int tickPos ) {
    _wxSliderSetTick( nativeHandle, tickPos );
  }

  void clearTicks( ) {
    _wxSliderClearTicks( nativeHandle  );
  }

  void setRange( int min, int max ) {
    _wxSliderSetRange( nativeHandle, min, max );
  }

  int getMin( ) {
    return _wxSliderGetMin( nativeHandle  );
  }

  void setMin( int min ) {
    _wxSliderSetMin( nativeHandle, min );
  }

  int getMax( ) {
    return _wxSliderGetMax( nativeHandle  );
  }

  void setMax( int max ) {
    _wxSliderSetMax( nativeHandle, max );
  }

  int getPageSize( ) {
    return _wxSliderGetPageSize( nativeHandle  );
  }

  void setPageSize( int pageSize ) {
    _wxSliderSetPageSize( nativeHandle, pageSize );
  }
}

// ------------------------- wxSpinEvent ----------------------

typedef _WxSpinEventConstructorNative = Pointer Function( Int32, Int32  );
typedef _WxSpinEventConstructor = Pointer Function( int, int  );
late _WxSpinEventConstructor _wxSpinEventConstructor;

typedef _WxSpinEventSetPositionNative = Void Function( Pointer, Int32  );
typedef _WxSpinEventSetPosition = void Function( Pointer, int  );
late _WxSpinEventSetPosition _wxSpinEventSetPosition;

typedef _WxSpinEventGetPositionNative = Int32 Function( Pointer  );
typedef _WxSpinEventGetPosition = int Function( Pointer  );
late _WxSpinEventGetPosition _wxSpinEventGetPosition;

class WxSpinEvent extends WxNotifyEvent {
  WxSpinEvent._defaultConstructor() : super._defaultConstructor();
  WxSpinEvent( int eventType, int id ) : super._defaultConstructor() {
    nativeHandle = _wxSpinEventConstructor( eventType, id );
    attachFinalizer();
  }
  WxSpinEvent.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  void setPosition( int pos ) {
    _wxSpinEventSetPosition( nativeHandle, pos );
  }

  int getPosition( ) {
    return _wxSpinEventGetPosition( nativeHandle  );
  }
}

typedef _WxInstallDartSpinEventCallbackNative = Void Function( Pointer );
typedef _WxInstallDartSpinEventCallback = void Function( Pointer );
late _WxInstallDartSpinEventCallback _wxInstallDartSpinEventCallback;

typedef OnSpinEventFunc = void Function( WxSpinEvent event );
class WxSpinEventListItems {
  WxSpinEventListItems( this.func, this.eventType, this.eventId );
  final OnSpinEventFunc func;
  final int eventType;
  final int eventId;
}
Map<Pointer, List<WxSpinEventListItems>> wxSpinEventHandlerList = {};

void wxSpinEventCallback( Pointer handle, Pointer eventHandle ) {
    WxSpinEvent event = WxSpinEvent.fromHandle( eventHandle );

    final List<WxSpinEventListItems>? list = wxSpinEventHandlerList[handle];
    if (list == null) {
      wxLogError('Handle does not exist in wxSpinEventHandlerList');
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

typedef WxSpinEventCallbackNative = Void Function( Pointer, Pointer );
late NativeCallable<Void Function(Pointer<NativeType>, Pointer<NativeType>)> wxSpinEventNativeCallable;

// ------------------------- wxSpinCtrl ----------------------

typedef _WxSpinCtrlConstructorNative = Pointer Function( Pointer, Int32, Pointer<Utf8>, Int32, Int32, Int32, Int32, Int32, Int32, Int32, Int32  );
typedef _WxSpinCtrlConstructor = Pointer Function( Pointer, int, Pointer<Utf8>, int, int, int, int, int, int, int, int  );
late _WxSpinCtrlConstructor _wxSpinCtrlConstructor;

typedef _WxSpinCtrlGetMinNative = Int32 Function( Pointer  );
typedef _WxSpinCtrlGetMin = int Function( Pointer  );
late _WxSpinCtrlGetMin _wxSpinCtrlGetMin;

typedef _WxSpinCtrlGetMaxNative = Int32 Function( Pointer  );
typedef _WxSpinCtrlGetMax = int Function( Pointer  );
late _WxSpinCtrlGetMax _wxSpinCtrlGetMax;

typedef _WxSpinCtrlSetRangeNative = Void Function( Pointer, Int32, Int32  );
typedef _WxSpinCtrlSetRange = void Function( Pointer, int, int  );
late _WxSpinCtrlSetRange _wxSpinCtrlSetRange;

typedef _WxSpinCtrlGetIncrementNative = Int32 Function( Pointer  );
typedef _WxSpinCtrlGetIncrement = int Function( Pointer  );
late _WxSpinCtrlGetIncrement _wxSpinCtrlGetIncrement;

typedef _WxSpinCtrlSetIncrementNative = Void Function( Pointer, Int32  );
typedef _WxSpinCtrlSetIncrement = void Function( Pointer, int  );
late _WxSpinCtrlSetIncrement _wxSpinCtrlSetIncrement;

typedef _WxSpinCtrlGetBaseNative = Int32 Function( Pointer  );
typedef _WxSpinCtrlGetBase = int Function( Pointer  );
late _WxSpinCtrlGetBase _wxSpinCtrlGetBase;

typedef _WxSpinCtrlSetBaseNative = Void Function( Pointer, Int32  );
typedef _WxSpinCtrlSetBase = void Function( Pointer, int  );
late _WxSpinCtrlSetBase _wxSpinCtrlSetBase;

typedef _WxSpinCtrlGetValueNative = Int32 Function( Pointer  );
typedef _WxSpinCtrlGetValue = int Function( Pointer  );
late _WxSpinCtrlGetValue _wxSpinCtrlGetValue;

typedef _WxSpinCtrlSetValueNative = Void Function( Pointer, Int32  );
typedef _WxSpinCtrlSetValue = void Function( Pointer, int  );
late _WxSpinCtrlSetValue _wxSpinCtrlSetValue;

typedef _WxSpinCtrlGetTextValueNative = Pointer<Utf8> Function( Pointer  );
typedef _WxSpinCtrlGetTextValue = Pointer<Utf8> Function( Pointer  );
late _WxSpinCtrlGetTextValue _wxSpinCtrlGetTextValue;

typedef _WxSpinCtrlSetTextValueNative = Void Function( Pointer, Pointer<Utf8>  );
typedef _WxSpinCtrlSetTextValue = void Function( Pointer, Pointer<Utf8>  );
late _WxSpinCtrlSetTextValue _wxSpinCtrlSetTextValue;

/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxSP_HORIZONTAL | wxHORIZONTAL |
/// | wxSP_VERTICAL | wxVERTICAL |
/// | wxSP_ARROW_KEYS | 0x4000 |
/// | wxSP_WRAP | 0x8000 |

const int wxSP_HORIZONTAL = wxHORIZONTAL;
const int wxSP_VERTICAL = wxVERTICAL;
const int wxSP_ARROW_KEYS = 0x4000;
const int wxSP_WRAP = 0x8000;

class WxSpinCtrl extends WxControl {
  WxSpinCtrl._defaultConstructor() : super._defaultConstructor();
  WxSpinCtrl( WxWindow parent, int id, String value, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = wxSP_ARROW_KEYS, int min = 0, int max = 100, int initial = 0 } ) : super._defaultConstructor() {
    final valueUtf8 = value.toNativeUtf8();
    nativeHandle = _wxSpinCtrlConstructor( parent.nativeHandle, id, valueUtf8, pos.x, pos.y, size.x, size.y, style, min, max, initial );
    malloc.free( valueUtf8 );
    _postCreation();
  }
  WxSpinCtrl.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  int getMin( ) {
    return _wxSpinCtrlGetMin( nativeHandle  );
  }

  int getMax( ) {
    return _wxSpinCtrlGetMax( nativeHandle  );
  }

  void setRange( int min, int max ) {
    _wxSpinCtrlSetRange( nativeHandle, min, max );
  }

  int getIncrement( ) {
    return _wxSpinCtrlGetIncrement( nativeHandle  );
  }

  void setIncrement( int inc ) {
    _wxSpinCtrlSetIncrement( nativeHandle, inc );
  }

  int getBase( ) {
    return _wxSpinCtrlGetBase( nativeHandle  );
  }

  void setBase( int max ) {
    _wxSpinCtrlSetBase( nativeHandle, max );
  }

  int getValue( ) {
    return _wxSpinCtrlGetValue( nativeHandle  );
  }

  void setValue( int value ) {
    _wxSpinCtrlSetValue( nativeHandle, value );
  }

  String getTextValue( ) {
    Pointer<Utf8> ptrReturn = _wxSpinCtrlGetTextValue( nativeHandle  );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }

  void setTextValue( String value ) {
    final valueUtf8 = value.toNativeUtf8();
    _wxSpinCtrlSetTextValue( nativeHandle, valueUtf8 );
    malloc.free( valueUtf8 );
  }
}

// ------------------------- wxSpinDoubleEvent ----------------------

typedef _WxSpinDoubleEventConstructorNative = Pointer Function( Int32, Int32, Double  );
typedef _WxSpinDoubleEventConstructor = Pointer Function( int, int, double  );
late _WxSpinDoubleEventConstructor _wxSpinDoubleEventConstructor;

typedef _WxSpinDoubleEventSetValueNative = Void Function( Pointer, Double  );
typedef _WxSpinDoubleEventSetValue = void Function( Pointer, double  );
late _WxSpinDoubleEventSetValue _wxSpinDoubleEventSetValue;

typedef _WxSpinDoubleEventGetValueNative = Double Function( Pointer  );
typedef _WxSpinDoubleEventGetValue = double Function( Pointer  );
late _WxSpinDoubleEventGetValue _wxSpinDoubleEventGetValue;

class WxSpinDoubleEvent extends WxNotifyEvent {
  WxSpinDoubleEvent._defaultConstructor() : super._defaultConstructor();
  WxSpinDoubleEvent( int eventType, int id, { double value = 0 } ) : super._defaultConstructor() {
    nativeHandle = _wxSpinDoubleEventConstructor( eventType, id, value );
    attachFinalizer();
  }
  WxSpinDoubleEvent.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  void setValue( double value ) {
    _wxSpinDoubleEventSetValue( nativeHandle, value );
  }

  double getValue( ) {
    return _wxSpinDoubleEventGetValue( nativeHandle  );
  }
}

typedef _WxInstallDartSpinDoubleEventCallbackNative = Void Function( Pointer );
typedef _WxInstallDartSpinDoubleEventCallback = void Function( Pointer );
late _WxInstallDartSpinDoubleEventCallback _wxInstallDartSpinDoubleEventCallback;

typedef OnSpinDoubleEventFunc = void Function( WxSpinDoubleEvent event );
class WxSpinDoubleEventListItems {
  WxSpinDoubleEventListItems( this.func, this.eventType, this.eventId );
  final OnSpinDoubleEventFunc func;
  final int eventType;
  final int eventId;
}
Map<Pointer, List<WxSpinDoubleEventListItems>> wxSpinDoubleEventHandlerList = {};

void wxSpinDoubleEventCallback( Pointer handle, Pointer eventHandle ) {
    WxSpinDoubleEvent event = WxSpinDoubleEvent.fromHandle( eventHandle );

    final List<WxSpinDoubleEventListItems>? list = wxSpinDoubleEventHandlerList[handle];
    if (list == null) {
      wxLogError('Handle does not exist in wxSpinDoubleEventHandlerList');
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

typedef WxSpinDoubleEventCallbackNative = Void Function( Pointer, Pointer );
late NativeCallable<Void Function(Pointer<NativeType>, Pointer<NativeType>)> wxSpinDoubleEventNativeCallable;

// ------------------------- wxSpinCtrlDouble ----------------------

typedef _WxSpinCtrlDoubleConstructorNative = Pointer Function( Pointer, Int32, Pointer<Utf8>, Int32, Int32, Int32, Int32, Int32, Double, Double, Double, Double  );
typedef _WxSpinCtrlDoubleConstructor = Pointer Function( Pointer, int, Pointer<Utf8>, int, int, int, int, int, double, double, double, double  );
late _WxSpinCtrlDoubleConstructor _wxSpinCtrlDoubleConstructor;

typedef _WxSpinCtrlDoubleGetDigitsNative = Int32 Function( Pointer  );
typedef _WxSpinCtrlDoubleGetDigits = int Function( Pointer  );
late _WxSpinCtrlDoubleGetDigits _wxSpinCtrlDoubleGetDigits;

typedef _WxSpinCtrlDoubleSetDigitsNative = Void Function( Pointer, Int32  );
typedef _WxSpinCtrlDoubleSetDigits = void Function( Pointer, int  );
late _WxSpinCtrlDoubleSetDigits _wxSpinCtrlDoubleSetDigits;

typedef _WxSpinCtrlDoubleGetMinNative = Double Function( Pointer  );
typedef _WxSpinCtrlDoubleGetMin = double Function( Pointer  );
late _WxSpinCtrlDoubleGetMin _wxSpinCtrlDoubleGetMin;

typedef _WxSpinCtrlDoubleGetMaxNative = Double Function( Pointer  );
typedef _WxSpinCtrlDoubleGetMax = double Function( Pointer  );
late _WxSpinCtrlDoubleGetMax _wxSpinCtrlDoubleGetMax;

typedef _WxSpinCtrlDoubleSetRangeNative = Void Function( Pointer, Double, Double  );
typedef _WxSpinCtrlDoubleSetRange = void Function( Pointer, double, double  );
late _WxSpinCtrlDoubleSetRange _wxSpinCtrlDoubleSetRange;

typedef _WxSpinCtrlDoubleGetIncrementNative = Double Function( Pointer  );
typedef _WxSpinCtrlDoubleGetIncrement = double Function( Pointer  );
late _WxSpinCtrlDoubleGetIncrement _wxSpinCtrlDoubleGetIncrement;

typedef _WxSpinCtrlDoubleSetIncrementNative = Void Function( Pointer, Double  );
typedef _WxSpinCtrlDoubleSetIncrement = void Function( Pointer, double  );
late _WxSpinCtrlDoubleSetIncrement _wxSpinCtrlDoubleSetIncrement;

typedef _WxSpinCtrlDoubleGetValueNative = Double Function( Pointer  );
typedef _WxSpinCtrlDoubleGetValue = double Function( Pointer  );
late _WxSpinCtrlDoubleGetValue _wxSpinCtrlDoubleGetValue;

typedef _WxSpinCtrlDoubleSetValueNative = Void Function( Pointer, Double  );
typedef _WxSpinCtrlDoubleSetValue = void Function( Pointer, double  );
late _WxSpinCtrlDoubleSetValue _wxSpinCtrlDoubleSetValue;

typedef _WxSpinCtrlDoubleGetTextValueNative = Pointer<Utf8> Function( Pointer  );
typedef _WxSpinCtrlDoubleGetTextValue = Pointer<Utf8> Function( Pointer  );
late _WxSpinCtrlDoubleGetTextValue _wxSpinCtrlDoubleGetTextValue;

class WxSpinCtrlDouble extends WxControl {
  WxSpinCtrlDouble._defaultConstructor() : super._defaultConstructor();
  WxSpinCtrlDouble( WxWindow parent, int id, String value, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = wxSP_ARROW_KEYS, double min = 0, double max = 100, double initial = 0, double inc = 1.0 } ) : super._defaultConstructor() {
    final valueUtf8 = value.toNativeUtf8();
    nativeHandle = _wxSpinCtrlDoubleConstructor( parent.nativeHandle, id, valueUtf8, pos.x, pos.y, size.x, size.y, style, min, max, initial, inc );
    malloc.free( valueUtf8 );
    _postCreation();
  }
  WxSpinCtrlDouble.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  int getDigits( ) {
    return _wxSpinCtrlDoubleGetDigits( nativeHandle  );
  }

  void setDigits( int min ) {
    _wxSpinCtrlDoubleSetDigits( nativeHandle, min );
  }

  double getMin( ) {
    return _wxSpinCtrlDoubleGetMin( nativeHandle  );
  }

  double getMax( ) {
    return _wxSpinCtrlDoubleGetMax( nativeHandle  );
  }

  void setRange( double min, double max ) {
    _wxSpinCtrlDoubleSetRange( nativeHandle, min, max );
  }

  double getIncrement( ) {
    return _wxSpinCtrlDoubleGetIncrement( nativeHandle  );
  }

  void setIncrement( double inc ) {
    _wxSpinCtrlDoubleSetIncrement( nativeHandle, inc );
  }

  double getValue( ) {
    return _wxSpinCtrlDoubleGetValue( nativeHandle  );
  }

  void setValue( double value ) {
    _wxSpinCtrlDoubleSetValue( nativeHandle, value );
  }

  String getTextValue( ) {
    Pointer<Utf8> ptrReturn = _wxSpinCtrlDoubleGetTextValue( nativeHandle  );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }
}

// ------------------------- EVT_BUTTON ----------------------
///
/// [Button](/wxdart/wxGetButtonEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindButtonEvent( OnCommandEventFunc ) |
/// | void unbindButtonEvent() |

typedef _WxGetButtonEventTypeNative = Int32 Function();
typedef WxGetButtonEventType = int Function();
late WxGetButtonEventType wxGetButtonEventType;

typedef _WxEvtHandlerBindButtonEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindButtonEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindButtonEventCallback wxEvtHandlerBindButtonEventCallback;

typedef _WxEvtHandlerUnbindButtonEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindButtonEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindButtonEventCallback wxEvtHandlerUnbindButtonEventCallback;

extension ButtonEventBinder on WxEvtHandler {
  void bindButtonEvent( OnCommandEventFunc func, int id ) {
    List<WxCommandEventListItems>? list = wxCommandEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxCommandEventHandlerList[nativeHandle] = list;
    }
    list.add( WxCommandEventListItems( func, wxGetButtonEventType(), id ) );
    wxEvtHandlerBindButtonEventCallback( nativeHandle, id );
  }

  void unbindButtonEvent( int id )
  {
    final list = wxCommandEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetButtonEventType() ) ) );
    wxEvtHandlerUnbindButtonEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_CHECKBOX ----------------------
///
/// [Checkbox](/wxdart/wxGetCheckboxEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindCheckboxEvent( OnCommandEventFunc ) |
/// | void unbindCheckboxEvent() |

typedef _WxGetCheckboxEventTypeNative = Int32 Function();
typedef WxGetCheckboxEventType = int Function();
late WxGetCheckboxEventType wxGetCheckboxEventType;

typedef _WxEvtHandlerBindCheckboxEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindCheckboxEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindCheckboxEventCallback wxEvtHandlerBindCheckboxEventCallback;

typedef _WxEvtHandlerUnbindCheckboxEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindCheckboxEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindCheckboxEventCallback wxEvtHandlerUnbindCheckboxEventCallback;

extension CheckboxEventBinder on WxEvtHandler {
  void bindCheckboxEvent( OnCommandEventFunc func, int id ) {
    List<WxCommandEventListItems>? list = wxCommandEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxCommandEventHandlerList[nativeHandle] = list;
    }
    list.add( WxCommandEventListItems( func, wxGetCheckboxEventType(), id ) );
    wxEvtHandlerBindCheckboxEventCallback( nativeHandle, id );
  }

  void unbindCheckboxEvent( int id )
  {
    final list = wxCommandEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetCheckboxEventType() ) ) );
    wxEvtHandlerUnbindCheckboxEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_CHOICE ----------------------
///
/// [Choice](/wxdart/wxGetChoiceEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindChoiceEvent( OnCommandEventFunc ) |
/// | void unbindChoiceEvent() |

typedef _WxGetChoiceEventTypeNative = Int32 Function();
typedef WxGetChoiceEventType = int Function();
late WxGetChoiceEventType wxGetChoiceEventType;

typedef _WxEvtHandlerBindChoiceEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindChoiceEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindChoiceEventCallback wxEvtHandlerBindChoiceEventCallback;

typedef _WxEvtHandlerUnbindChoiceEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindChoiceEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindChoiceEventCallback wxEvtHandlerUnbindChoiceEventCallback;

extension ChoiceEventBinder on WxEvtHandler {
  void bindChoiceEvent( OnCommandEventFunc func, int id ) {
    List<WxCommandEventListItems>? list = wxCommandEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxCommandEventHandlerList[nativeHandle] = list;
    }
    list.add( WxCommandEventListItems( func, wxGetChoiceEventType(), id ) );
    wxEvtHandlerBindChoiceEventCallback( nativeHandle, id );
  }

  void unbindChoiceEvent( int id )
  {
    final list = wxCommandEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetChoiceEventType() ) ) );
    wxEvtHandlerUnbindChoiceEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_LISTBOX ----------------------
///
/// [Listbox](/wxdart/wxGetListboxEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindListboxEvent( OnCommandEventFunc ) |
/// | void unbindListboxEvent() |

typedef _WxGetListboxEventTypeNative = Int32 Function();
typedef WxGetListboxEventType = int Function();
late WxGetListboxEventType wxGetListboxEventType;

typedef _WxEvtHandlerBindListboxEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindListboxEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindListboxEventCallback wxEvtHandlerBindListboxEventCallback;

typedef _WxEvtHandlerUnbindListboxEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindListboxEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindListboxEventCallback wxEvtHandlerUnbindListboxEventCallback;

extension ListboxEventBinder on WxEvtHandler {
  void bindListboxEvent( OnCommandEventFunc func, int id ) {
    List<WxCommandEventListItems>? list = wxCommandEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxCommandEventHandlerList[nativeHandle] = list;
    }
    list.add( WxCommandEventListItems( func, wxGetListboxEventType(), id ) );
    wxEvtHandlerBindListboxEventCallback( nativeHandle, id );
  }

  void unbindListboxEvent( int id )
  {
    final list = wxCommandEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetListboxEventType() ) ) );
    wxEvtHandlerUnbindListboxEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_LISTBOX_DCLICK ----------------------
///
/// [ListboxDClick](/wxdart/wxGetListboxDClickEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindListboxDClickEvent( OnCommandEventFunc ) |
/// | void unbindListboxDClickEvent() |

typedef _WxGetListboxDClickEventTypeNative = Int32 Function();
typedef WxGetListboxDClickEventType = int Function();
late WxGetListboxDClickEventType wxGetListboxDClickEventType;

typedef _WxEvtHandlerBindListboxDClickEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindListboxDClickEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindListboxDClickEventCallback wxEvtHandlerBindListboxDClickEventCallback;

typedef _WxEvtHandlerUnbindListboxDClickEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindListboxDClickEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindListboxDClickEventCallback wxEvtHandlerUnbindListboxDClickEventCallback;

extension ListboxDClickEventBinder on WxEvtHandler {
  void bindListboxDClickEvent( OnCommandEventFunc func, int id ) {
    List<WxCommandEventListItems>? list = wxCommandEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxCommandEventHandlerList[nativeHandle] = list;
    }
    list.add( WxCommandEventListItems( func, wxGetListboxDClickEventType(), id ) );
    wxEvtHandlerBindListboxDClickEventCallback( nativeHandle, id );
  }

  void unbindListboxDClickEvent( int id )
  {
    final list = wxCommandEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetListboxDClickEventType() ) ) );
    wxEvtHandlerUnbindListboxDClickEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_RADIOBOX ----------------------
///
/// [Radiobox](/wxdart/wxGetRadioboxEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindRadioboxEvent( OnCommandEventFunc ) |
/// | void unbindRadioboxEvent() |

typedef _WxGetRadioboxEventTypeNative = Int32 Function();
typedef WxGetRadioboxEventType = int Function();
late WxGetRadioboxEventType wxGetRadioboxEventType;

typedef _WxEvtHandlerBindRadioboxEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindRadioboxEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindRadioboxEventCallback wxEvtHandlerBindRadioboxEventCallback;

typedef _WxEvtHandlerUnbindRadioboxEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindRadioboxEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindRadioboxEventCallback wxEvtHandlerUnbindRadioboxEventCallback;

extension RadioboxEventBinder on WxEvtHandler {
  void bindRadioboxEvent( OnCommandEventFunc func, int id ) {
    List<WxCommandEventListItems>? list = wxCommandEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxCommandEventHandlerList[nativeHandle] = list;
    }
    list.add( WxCommandEventListItems( func, wxGetRadioboxEventType(), id ) );
    wxEvtHandlerBindRadioboxEventCallback( nativeHandle, id );
  }

  void unbindRadioboxEvent( int id )
  {
    final list = wxCommandEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetRadioboxEventType() ) ) );
    wxEvtHandlerUnbindRadioboxEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_RADIOBUTTON ----------------------
///
/// [RadioButton](/wxdart/wxGetRadioButtonEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindRadioButtonEvent( OnCommandEventFunc ) |
/// | void unbindRadioButtonEvent() |

typedef _WxGetRadioButtonEventTypeNative = Int32 Function();
typedef WxGetRadioButtonEventType = int Function();
late WxGetRadioButtonEventType wxGetRadioButtonEventType;

typedef _WxEvtHandlerBindRadioButtonEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindRadioButtonEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindRadioButtonEventCallback wxEvtHandlerBindRadioButtonEventCallback;

typedef _WxEvtHandlerUnbindRadioButtonEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindRadioButtonEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindRadioButtonEventCallback wxEvtHandlerUnbindRadioButtonEventCallback;

extension RadioButtonEventBinder on WxEvtHandler {
  void bindRadioButtonEvent( OnCommandEventFunc func, int id ) {
    List<WxCommandEventListItems>? list = wxCommandEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxCommandEventHandlerList[nativeHandle] = list;
    }
    list.add( WxCommandEventListItems( func, wxGetRadioButtonEventType(), id ) );
    wxEvtHandlerBindRadioButtonEventCallback( nativeHandle, id );
  }

  void unbindRadioButtonEvent( int id )
  {
    final list = wxCommandEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetRadioButtonEventType() ) ) );
    wxEvtHandlerUnbindRadioButtonEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_TOGGLEBUTTON ----------------------
///
/// [ToggleButton](/wxdart/wxGetToggleButtonEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindToggleButtonEvent( OnCommandEventFunc ) |
/// | void unbindToggleButtonEvent() |

typedef _WxGetToggleButtonEventTypeNative = Int32 Function();
typedef WxGetToggleButtonEventType = int Function();
late WxGetToggleButtonEventType wxGetToggleButtonEventType;

typedef _WxEvtHandlerBindToggleButtonEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindToggleButtonEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindToggleButtonEventCallback wxEvtHandlerBindToggleButtonEventCallback;

typedef _WxEvtHandlerUnbindToggleButtonEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindToggleButtonEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindToggleButtonEventCallback wxEvtHandlerUnbindToggleButtonEventCallback;

extension ToggleButtonEventBinder on WxEvtHandler {
  void bindToggleButtonEvent( OnCommandEventFunc func, int id ) {
    List<WxCommandEventListItems>? list = wxCommandEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxCommandEventHandlerList[nativeHandle] = list;
    }
    list.add( WxCommandEventListItems( func, wxGetToggleButtonEventType(), id ) );
    wxEvtHandlerBindToggleButtonEventCallback( nativeHandle, id );
  }

  void unbindToggleButtonEvent( int id )
  {
    final list = wxCommandEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetToggleButtonEventType() ) ) );
    wxEvtHandlerUnbindToggleButtonEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_SLIDER ----------------------
///
/// [Slider](/wxdart/wxGetSliderEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindSliderEvent( OnCommandEventFunc ) |
/// | void unbindSliderEvent() |

typedef _WxGetSliderEventTypeNative = Int32 Function();
typedef WxGetSliderEventType = int Function();
late WxGetSliderEventType wxGetSliderEventType;

typedef _WxEvtHandlerBindSliderEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindSliderEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindSliderEventCallback wxEvtHandlerBindSliderEventCallback;

typedef _WxEvtHandlerUnbindSliderEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindSliderEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindSliderEventCallback wxEvtHandlerUnbindSliderEventCallback;

extension SliderEventBinder on WxEvtHandler {
  void bindSliderEvent( OnCommandEventFunc func, int id ) {
    List<WxCommandEventListItems>? list = wxCommandEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxCommandEventHandlerList[nativeHandle] = list;
    }
    list.add( WxCommandEventListItems( func, wxGetSliderEventType(), id ) );
    wxEvtHandlerBindSliderEventCallback( nativeHandle, id );
  }

  void unbindSliderEvent( int id )
  {
    final list = wxCommandEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetSliderEventType() ) ) );
    wxEvtHandlerUnbindSliderEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_SPIN ----------------------
///
/// [Spin](/wxdart/wxGetSpinEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindSpinEvent( OnSpinEventFunc ) |
/// | void unbindSpinEvent() |

typedef _WxGetSpinEventTypeNative = Int32 Function();
typedef WxGetSpinEventType = int Function();
late WxGetSpinEventType wxGetSpinEventType;

typedef _WxEvtHandlerBindSpinEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindSpinEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindSpinEventCallback wxEvtHandlerBindSpinEventCallback;

typedef _WxEvtHandlerUnbindSpinEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindSpinEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindSpinEventCallback wxEvtHandlerUnbindSpinEventCallback;

extension SpinEventBinder on WxEvtHandler {
  void bindSpinEvent( OnSpinEventFunc func, int id ) {
    List<WxSpinEventListItems>? list = wxSpinEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxSpinEventHandlerList[nativeHandle] = list;
    }
    list.add( WxSpinEventListItems( func, wxGetSpinEventType(), id ) );
    wxEvtHandlerBindSpinEventCallback( nativeHandle, id );
  }

  void unbindSpinEvent( int id )
  {
    final list = wxSpinEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetSpinEventType() ) ) );
    wxEvtHandlerUnbindSpinEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_SPIN_UP ----------------------
///
/// [SpinUp](/wxdart/wxGetSpinUpEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindSpinUpEvent( OnSpinEventFunc ) |
/// | void unbindSpinUpEvent() |

typedef _WxGetSpinUpEventTypeNative = Int32 Function();
typedef WxGetSpinUpEventType = int Function();
late WxGetSpinUpEventType wxGetSpinUpEventType;

typedef _WxEvtHandlerBindSpinUpEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindSpinUpEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindSpinUpEventCallback wxEvtHandlerBindSpinUpEventCallback;

typedef _WxEvtHandlerUnbindSpinUpEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindSpinUpEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindSpinUpEventCallback wxEvtHandlerUnbindSpinUpEventCallback;

extension SpinUpEventBinder on WxEvtHandler {
  void bindSpinUpEvent( OnSpinEventFunc func, int id ) {
    List<WxSpinEventListItems>? list = wxSpinEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxSpinEventHandlerList[nativeHandle] = list;
    }
    list.add( WxSpinEventListItems( func, wxGetSpinUpEventType(), id ) );
    wxEvtHandlerBindSpinUpEventCallback( nativeHandle, id );
  }

  void unbindSpinUpEvent( int id )
  {
    final list = wxSpinEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetSpinUpEventType() ) ) );
    wxEvtHandlerUnbindSpinUpEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_SPIN_DOWN ----------------------
///
/// [SpinDown](/wxdart/wxGetSpinDownEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindSpinDownEvent( OnSpinEventFunc ) |
/// | void unbindSpinDownEvent() |

typedef _WxGetSpinDownEventTypeNative = Int32 Function();
typedef WxGetSpinDownEventType = int Function();
late WxGetSpinDownEventType wxGetSpinDownEventType;

typedef _WxEvtHandlerBindSpinDownEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindSpinDownEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindSpinDownEventCallback wxEvtHandlerBindSpinDownEventCallback;

typedef _WxEvtHandlerUnbindSpinDownEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindSpinDownEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindSpinDownEventCallback wxEvtHandlerUnbindSpinDownEventCallback;

extension SpinDownEventBinder on WxEvtHandler {
  void bindSpinDownEvent( OnSpinEventFunc func, int id ) {
    List<WxSpinEventListItems>? list = wxSpinEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxSpinEventHandlerList[nativeHandle] = list;
    }
    list.add( WxSpinEventListItems( func, wxGetSpinDownEventType(), id ) );
    wxEvtHandlerBindSpinDownEventCallback( nativeHandle, id );
  }

  void unbindSpinDownEvent( int id )
  {
    final list = wxSpinEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetSpinDownEventType() ) ) );
    wxEvtHandlerUnbindSpinDownEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_SPINCTRL ----------------------
///
/// [SpinCtrl](/wxdart/wxGetSpinCtrlEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindSpinCtrlEvent( OnSpinEventFunc ) |
/// | void unbindSpinCtrlEvent() |

typedef _WxGetSpinCtrlEventTypeNative = Int32 Function();
typedef WxGetSpinCtrlEventType = int Function();
late WxGetSpinCtrlEventType wxGetSpinCtrlEventType;

typedef _WxEvtHandlerBindSpinCtrlEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindSpinCtrlEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindSpinCtrlEventCallback wxEvtHandlerBindSpinCtrlEventCallback;

typedef _WxEvtHandlerUnbindSpinCtrlEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindSpinCtrlEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindSpinCtrlEventCallback wxEvtHandlerUnbindSpinCtrlEventCallback;

extension SpinCtrlEventBinder on WxEvtHandler {
  void bindSpinCtrlEvent( OnSpinEventFunc func, int id ) {
    List<WxSpinEventListItems>? list = wxSpinEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxSpinEventHandlerList[nativeHandle] = list;
    }
    list.add( WxSpinEventListItems( func, wxGetSpinCtrlEventType(), id ) );
    wxEvtHandlerBindSpinCtrlEventCallback( nativeHandle, id );
  }

  void unbindSpinCtrlEvent( int id )
  {
    final list = wxSpinEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetSpinCtrlEventType() ) ) );
    wxEvtHandlerUnbindSpinCtrlEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_SPINCTRLDOUBLE ----------------------
///
/// [SpinCtrlDouble](/wxdart/wxGetSpinCtrlDoubleEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindSpinCtrlDoubleEvent( OnSpinDoubleEventFunc ) |
/// | void unbindSpinCtrlDoubleEvent() |

typedef _WxGetSpinCtrlDoubleEventTypeNative = Int32 Function();
typedef WxGetSpinCtrlDoubleEventType = int Function();
late WxGetSpinCtrlDoubleEventType wxGetSpinCtrlDoubleEventType;

typedef _WxEvtHandlerBindSpinCtrlDoubleEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindSpinCtrlDoubleEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindSpinCtrlDoubleEventCallback wxEvtHandlerBindSpinCtrlDoubleEventCallback;

typedef _WxEvtHandlerUnbindSpinCtrlDoubleEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindSpinCtrlDoubleEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindSpinCtrlDoubleEventCallback wxEvtHandlerUnbindSpinCtrlDoubleEventCallback;

extension SpinCtrlDoubleEventBinder on WxEvtHandler {
  void bindSpinCtrlDoubleEvent( OnSpinDoubleEventFunc func, int id ) {
    List<WxSpinDoubleEventListItems>? list = wxSpinDoubleEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxSpinDoubleEventHandlerList[nativeHandle] = list;
    }
    list.add( WxSpinDoubleEventListItems( func, wxGetSpinCtrlDoubleEventType(), id ) );
    wxEvtHandlerBindSpinCtrlDoubleEventCallback( nativeHandle, id );
  }

  void unbindSpinCtrlDoubleEvent( int id )
  {
    final list = wxSpinDoubleEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetSpinCtrlDoubleEventType() ) ) );
    wxEvtHandlerUnbindSpinCtrlDoubleEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_HYPERLINK ----------------------
///
/// [Hyperlink](/wxdart/wxGetHyperlinkEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindHyperlinkEvent( OnHyperlinkEventFunc ) |
/// | void unbindHyperlinkEvent() |

typedef _WxGetHyperlinkEventTypeNative = Int32 Function();
typedef WxGetHyperlinkEventType = int Function();
late WxGetHyperlinkEventType wxGetHyperlinkEventType;

typedef _WxEvtHandlerBindHyperlinkEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindHyperlinkEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindHyperlinkEventCallback wxEvtHandlerBindHyperlinkEventCallback;

typedef _WxEvtHandlerUnbindHyperlinkEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindHyperlinkEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindHyperlinkEventCallback wxEvtHandlerUnbindHyperlinkEventCallback;

extension HyperlinkEventBinder on WxEvtHandler {
  void bindHyperlinkEvent( OnHyperlinkEventFunc func, int id ) {
    List<WxHyperlinkEventListItems>? list = wxHyperlinkEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxHyperlinkEventHandlerList[nativeHandle] = list;
    }
    list.add( WxHyperlinkEventListItems( func, wxGetHyperlinkEventType(), id ) );
    wxEvtHandlerBindHyperlinkEventCallback( nativeHandle, id );
  }

  void unbindHyperlinkEvent( int id )
  {
    final list = wxHyperlinkEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetHyperlinkEventType() ) ) );
    wxEvtHandlerUnbindHyperlinkEventCallback( nativeHandle, id );
  }
}


void setupWxControls( DynamicLibrary dylib )
{
  // ------------------------- wxVectorVariant ----------------------

  final wxVectorVariantConstructorPtr = dylib.lookup <NativeFunction<_WxVectorVariantConstructorNative>>('wxVectorVariantConstructor');
  _wxVectorVariantConstructor = wxVectorVariantConstructorPtr.asFunction<_WxVectorVariantConstructor>();

  final wxVectorVariantDestructorPtr = dylib.lookup <NativeFunction<_WxVectorVariantDestructorNative>>('wxVectorVariantDestructor');
  _wxVectorVariantDestructor = wxVectorVariantDestructorPtr.asFunction<_WxVectorVariantDestructor>();

  final wxVectorVariantAddPtr = dylib.lookup <NativeFunction<_WxVectorVariantAddNative>>('wxVectorVariantAdd');
  _wxVectorVariantAdd = wxVectorVariantAddPtr.asFunction<_WxVectorVariantAdd>();

  final wxVectorVariantAddBoolPtr = dylib.lookup <NativeFunction<_WxVectorVariantAddBoolNative>>('wxVectorVariantAddBool');
  _wxVectorVariantAddBool = wxVectorVariantAddBoolPtr.asFunction<_WxVectorVariantAddBool>();

  final wxVectorVariantAddLongPtr = dylib.lookup <NativeFunction<_WxVectorVariantAddLongNative>>('wxVectorVariantAddLong');
  _wxVectorVariantAddLong = wxVectorVariantAddLongPtr.asFunction<_WxVectorVariantAddLong>();

  final wxVectorVariantAddDoublePtr = dylib.lookup <NativeFunction<_WxVectorVariantAddDoubleNative>>('wxVectorVariantAddDouble');
  _wxVectorVariantAddDouble = wxVectorVariantAddDoublePtr.asFunction<_WxVectorVariantAddDouble>();

  final wxVectorVariantAddStringPtr = dylib.lookup <NativeFunction<_WxVectorVariantAddStringNative>>('wxVectorVariantAddString');
  _wxVectorVariantAddString = wxVectorVariantAddStringPtr.asFunction<_WxVectorVariantAddString>();

  // ------------------------- wxVariant ----------------------

  final wxVariantConstructorPtr = dylib.lookup <NativeFunction<_WxVariantConstructorNative>>('wxVariantConstructor');
  _wxVariantConstructor = wxVariantConstructorPtr.asFunction<_WxVariantConstructor>();

  final wxVariantConstructorFromBoolPtr = dylib.lookup <NativeFunction<_WxVariantConstructorFromBoolNative>>('wxVariantConstructorFromBool');
  _wxVariantConstructorFromBool = wxVariantConstructorFromBoolPtr.asFunction<_WxVariantConstructorFromBool>();

  final wxVariantConstructorFromLongPtr = dylib.lookup <NativeFunction<_WxVariantConstructorFromLongNative>>('wxVariantConstructorFromLong');
  _wxVariantConstructorFromLong = wxVariantConstructorFromLongPtr.asFunction<_WxVariantConstructorFromLong>();

  final wxVariantConstructorFromDoublePtr = dylib.lookup <NativeFunction<_WxVariantConstructorFromDoubleNative>>('wxVariantConstructorFromDouble');
  _wxVariantConstructorFromDouble = wxVariantConstructorFromDoublePtr.asFunction<_WxVariantConstructorFromDouble>();

  final wxVariantConstructorFromStringPtr = dylib.lookup <NativeFunction<_WxVariantConstructorFromStringNative>>('wxVariantConstructorFromString');
  _wxVariantConstructorFromString = wxVariantConstructorFromStringPtr.asFunction<_WxVariantConstructorFromString>();

  final wxVariantGetTypePtr = dylib.lookup <NativeFunction<_WxVariantGetTypeNative>>('wxVariantGetType');
  _wxVariantGetType = wxVariantGetTypePtr.asFunction<_WxVariantGetType>();

  final wxVariantIsTypePtr = dylib.lookup <NativeFunction<_WxVariantIsTypeNative>>('wxVariantIsType');
  _wxVariantIsType = wxVariantIsTypePtr.asFunction<_WxVariantIsType>();

  final wxVariantIsNullPtr = dylib.lookup <NativeFunction<_WxVariantIsNullNative>>('wxVariantIsNull');
  _wxVariantIsNull = wxVariantIsNullPtr.asFunction<_WxVariantIsNull>();

  final wxVariantMakeNullPtr = dylib.lookup <NativeFunction<_WxVariantMakeNullNative>>('wxVariantMakeNull');
  _wxVariantMakeNull = wxVariantMakeNullPtr.asFunction<_WxVariantMakeNull>();

  final wxVariantGetBoolPtr = dylib.lookup <NativeFunction<_WxVariantGetBoolNative>>('wxVariantGetBool');
  _wxVariantGetBool = wxVariantGetBoolPtr.asFunction<_WxVariantGetBool>();

  final wxVariantGetLongPtr = dylib.lookup <NativeFunction<_WxVariantGetLongNative>>('wxVariantGetLong');
  _wxVariantGetLong = wxVariantGetLongPtr.asFunction<_WxVariantGetLong>();

  final wxVariantGetDoublePtr = dylib.lookup <NativeFunction<_WxVariantGetDoubleNative>>('wxVariantGetDouble');
  _wxVariantGetDouble = wxVariantGetDoublePtr.asFunction<_WxVariantGetDouble>();

  final wxVariantGetStringPtr = dylib.lookup <NativeFunction<_WxVariantGetStringNative>>('wxVariantGetString');
  _wxVariantGetString = wxVariantGetStringPtr.asFunction<_WxVariantGetString>();

  // ------------------------- wxControl ----------------------

  final wxControlGetLabelTextPtr = dylib.lookup <NativeFunction<_WxControlGetLabelTextNative>>('wxControlGetLabelText');
  _wxControlGetLabelText = wxControlGetLabelTextPtr.asFunction<_WxControlGetLabelText>();

  // ------------------------- wxAnyButton ----------------------

  final wxAnyButtonSetBitmapPtr = dylib.lookup <NativeFunction<_WxAnyButtonSetBitmapNative>>('wxAnyButtonSetBitmap');
  _wxAnyButtonSetBitmap = wxAnyButtonSetBitmapPtr.asFunction<_WxAnyButtonSetBitmap>();

  final wxAnyButtonSetBitmapCurrentPtr = dylib.lookup <NativeFunction<_WxAnyButtonSetBitmapCurrentNative>>('wxAnyButtonSetBitmapCurrent');
  _wxAnyButtonSetBitmapCurrent = wxAnyButtonSetBitmapCurrentPtr.asFunction<_WxAnyButtonSetBitmapCurrent>();

  final wxAnyButtonSetBitmapDisabledPtr = dylib.lookup <NativeFunction<_WxAnyButtonSetBitmapDisabledNative>>('wxAnyButtonSetBitmapDisabled');
  _wxAnyButtonSetBitmapDisabled = wxAnyButtonSetBitmapDisabledPtr.asFunction<_WxAnyButtonSetBitmapDisabled>();

  final wxAnyButtonSetBitmapFocusPtr = dylib.lookup <NativeFunction<_WxAnyButtonSetBitmapFocusNative>>('wxAnyButtonSetBitmapFocus');
  _wxAnyButtonSetBitmapFocus = wxAnyButtonSetBitmapFocusPtr.asFunction<_WxAnyButtonSetBitmapFocus>();

  final wxAnyButtonSetBitmapPressedPtr = dylib.lookup <NativeFunction<_WxAnyButtonSetBitmapPressedNative>>('wxAnyButtonSetBitmapPressed');
  _wxAnyButtonSetBitmapPressed = wxAnyButtonSetBitmapPressedPtr.asFunction<_WxAnyButtonSetBitmapPressed>();

  final wxAnyButtonSetBitmapLabelPtr = dylib.lookup <NativeFunction<_WxAnyButtonSetBitmapLabelNative>>('wxAnyButtonSetBitmapLabel');
  _wxAnyButtonSetBitmapLabel = wxAnyButtonSetBitmapLabelPtr.asFunction<_WxAnyButtonSetBitmapLabel>();

  final wxAnyButtonSetBitmapMarginsPtr = dylib.lookup <NativeFunction<_WxAnyButtonSetBitmapMarginsNative>>('wxAnyButtonSetBitmapMargins');
  _wxAnyButtonSetBitmapMargins = wxAnyButtonSetBitmapMarginsPtr.asFunction<_WxAnyButtonSetBitmapMargins>();

  final wxAnyButtonSetBitmapPositionPtr = dylib.lookup <NativeFunction<_WxAnyButtonSetBitmapPositionNative>>('wxAnyButtonSetBitmapPosition');
  _wxAnyButtonSetBitmapPosition = wxAnyButtonSetBitmapPositionPtr.asFunction<_WxAnyButtonSetBitmapPosition>();

  // ------------------------- wxButton ----------------------

  final wxButtonConstructorPtr = dylib.lookup <NativeFunction<_WxButtonConstructorNative>>('wxButtonConstructor');
  _wxButtonConstructor = wxButtonConstructorPtr.asFunction<_WxButtonConstructor>();

  final wxButtonSetAuthNeededPtr = dylib.lookup <NativeFunction<_WxButtonSetAuthNeededNative>>('wxButtonSetAuthNeeded');
  _wxButtonSetAuthNeeded = wxButtonSetAuthNeededPtr.asFunction<_WxButtonSetAuthNeeded>();

  final wxButtonSetDefaultPtr = dylib.lookup <NativeFunction<_WxButtonSetDefaultNative>>('wxButtonSetDefault');
  _wxButtonSetDefault = wxButtonSetDefaultPtr.asFunction<_WxButtonSetDefault>();

  // ------------------------- wxBitmapButton ----------------------

  final wxBitmapButtonConstructorPtr = dylib.lookup <NativeFunction<_WxBitmapButtonConstructorNative>>('wxBitmapButtonConstructor');
  _wxBitmapButtonConstructor = wxBitmapButtonConstructorPtr.asFunction<_WxBitmapButtonConstructor>();

  // ------------------------- wxHyperlinkCtrl ----------------------

  final wxHyperlinkCtrlConstructorPtr = dylib.lookup <NativeFunction<_WxHyperlinkCtrlConstructorNative>>('wxHyperlinkCtrlConstructor');
  _wxHyperlinkCtrlConstructor = wxHyperlinkCtrlConstructorPtr.asFunction<_WxHyperlinkCtrlConstructor>();

  final wxHyperlinkCtrlSetHoverColourPtr = dylib.lookup <NativeFunction<_WxHyperlinkCtrlSetHoverColourNative>>('wxHyperlinkCtrlSetHoverColour');
  _wxHyperlinkCtrlSetHoverColour = wxHyperlinkCtrlSetHoverColourPtr.asFunction<_WxHyperlinkCtrlSetHoverColour>();

  final wxHyperlinkCtrlSetNormalColourPtr = dylib.lookup <NativeFunction<_WxHyperlinkCtrlSetNormalColourNative>>('wxHyperlinkCtrlSetNormalColour');
  _wxHyperlinkCtrlSetNormalColour = wxHyperlinkCtrlSetNormalColourPtr.asFunction<_WxHyperlinkCtrlSetNormalColour>();

  final wxHyperlinkCtrlSetVisitedColourPtr = dylib.lookup <NativeFunction<_WxHyperlinkCtrlSetVisitedColourNative>>('wxHyperlinkCtrlSetVisitedColour');
  _wxHyperlinkCtrlSetVisitedColour = wxHyperlinkCtrlSetVisitedColourPtr.asFunction<_WxHyperlinkCtrlSetVisitedColour>();

  final wxHyperlinkCtrlGetHoverColourPtr = dylib.lookup <NativeFunction<_WxHyperlinkCtrlGetHoverColourNative>>('wxHyperlinkCtrlGetHoverColour');
  _wxHyperlinkCtrlGetHoverColour = wxHyperlinkCtrlGetHoverColourPtr.asFunction<_WxHyperlinkCtrlGetHoverColour>();

  final wxHyperlinkCtrlGetNormalColourPtr = dylib.lookup <NativeFunction<_WxHyperlinkCtrlGetNormalColourNative>>('wxHyperlinkCtrlGetNormalColour');
  _wxHyperlinkCtrlGetNormalColour = wxHyperlinkCtrlGetNormalColourPtr.asFunction<_WxHyperlinkCtrlGetNormalColour>();

  final wxHyperlinkCtrlGetVisitedColourPtr = dylib.lookup <NativeFunction<_WxHyperlinkCtrlGetVisitedColourNative>>('wxHyperlinkCtrlGetVisitedColour');
  _wxHyperlinkCtrlGetVisitedColour = wxHyperlinkCtrlGetVisitedColourPtr.asFunction<_WxHyperlinkCtrlGetVisitedColour>();

  final wxHyperlinkCtrlSetVisitedPtr = dylib.lookup <NativeFunction<_WxHyperlinkCtrlSetVisitedNative>>('wxHyperlinkCtrlSetVisited');
  _wxHyperlinkCtrlSetVisited = wxHyperlinkCtrlSetVisitedPtr.asFunction<_WxHyperlinkCtrlSetVisited>();

  final wxHyperlinkCtrlGetVisitedPtr = dylib.lookup <NativeFunction<_WxHyperlinkCtrlGetVisitedNative>>('wxHyperlinkCtrlGetVisited');
  _wxHyperlinkCtrlGetVisited = wxHyperlinkCtrlGetVisitedPtr.asFunction<_WxHyperlinkCtrlGetVisited>();

  final wxHyperlinkCtrlSetURLPtr = dylib.lookup <NativeFunction<_WxHyperlinkCtrlSetURLNative>>('wxHyperlinkCtrlSetURL');
  _wxHyperlinkCtrlSetURL = wxHyperlinkCtrlSetURLPtr.asFunction<_WxHyperlinkCtrlSetURL>();

  final wxHyperlinkCtrlGetURLPtr = dylib.lookup <NativeFunction<_WxHyperlinkCtrlGetURLNative>>('wxHyperlinkCtrlGetURL');
  _wxHyperlinkCtrlGetURL = wxHyperlinkCtrlGetURLPtr.asFunction<_WxHyperlinkCtrlGetURL>();

  // ------------------------- wxHyperlinkEvent ----------------------

  final wxHyperlinkEventConstructorPtr = dylib.lookup <NativeFunction<_WxHyperlinkEventConstructorNative>>('wxHyperlinkEventConstructor');
  _wxHyperlinkEventConstructor = wxHyperlinkEventConstructorPtr.asFunction<_WxHyperlinkEventConstructor>();

  final wxHyperlinkEventSetURLPtr = dylib.lookup <NativeFunction<_WxHyperlinkEventSetURLNative>>('wxHyperlinkEventSetURL');
  _wxHyperlinkEventSetURL = wxHyperlinkEventSetURLPtr.asFunction<_WxHyperlinkEventSetURL>();

  final wxHyperlinkEventGetURLPtr = dylib.lookup <NativeFunction<_WxHyperlinkEventGetURLNative>>('wxHyperlinkEventGetURL');
  _wxHyperlinkEventGetURL = wxHyperlinkEventGetURLPtr.asFunction<_WxHyperlinkEventGetURL>();

  final wxInstallDartHyperlinkEventCallbackPtr = dylib.lookup <NativeFunction<_WxInstallDartHyperlinkEventCallbackNative>>('wxInstallDartHyperlinkEventCallback');
  _wxInstallDartHyperlinkEventCallback = wxInstallDartHyperlinkEventCallbackPtr.asFunction<_WxInstallDartHyperlinkEventCallback>();

  wxHyperlinkEventNativeCallable = NativeCallable<WxHyperlinkEventCallbackNative>.isolateLocal( wxHyperlinkEventCallback );
  _wxInstallDartHyperlinkEventCallback( wxHyperlinkEventNativeCallable.nativeFunction );

  // ------------------------- wxStaticText ----------------------

  final wxStaticTextConstructorPtr = dylib.lookup <NativeFunction<_WxStaticTextConstructorNative>>('wxStaticTextConstructor');
  _wxStaticTextConstructor = wxStaticTextConstructorPtr.asFunction<_WxStaticTextConstructor>();

  final wxStaticTextWrapPtr = dylib.lookup <NativeFunction<_WxStaticTextWrapNative>>('wxStaticTextWrap');
  _wxStaticTextWrap = wxStaticTextWrapPtr.asFunction<_WxStaticTextWrap>();

  final wxStaticTextIsEllipsizedPtr = dylib.lookup <NativeFunction<_WxStaticTextIsEllipsizedNative>>('wxStaticTextIsEllipsized');
  _wxStaticTextIsEllipsized = wxStaticTextIsEllipsizedPtr.asFunction<_WxStaticTextIsEllipsized>();

  // ------------------------- wxStaticBitmap ----------------------

  final wxStaticBitmapConstructorPtr = dylib.lookup <NativeFunction<_WxStaticBitmapConstructorNative>>('wxStaticBitmapConstructor');
  _wxStaticBitmapConstructor = wxStaticBitmapConstructorPtr.asFunction<_WxStaticBitmapConstructor>();

  final wxStaticBitmapSetScaleModePtr = dylib.lookup <NativeFunction<_WxStaticBitmapSetScaleModeNative>>('wxStaticBitmapSetScaleMode');
  _wxStaticBitmapSetScaleMode = wxStaticBitmapSetScaleModePtr.asFunction<_WxStaticBitmapSetScaleMode>();

  final wxStaticBitmapGetScaleModePtr = dylib.lookup <NativeFunction<_WxStaticBitmapGetScaleModeNative>>('wxStaticBitmapGetScaleMode');
  _wxStaticBitmapGetScaleMode = wxStaticBitmapGetScaleModePtr.asFunction<_WxStaticBitmapGetScaleMode>();

  // ------------------------- wxAnimationCtrl ----------------------

  final wxAnimationCtrlConstructorPtr = dylib.lookup <NativeFunction<_WxAnimationCtrlConstructorNative>>('wxAnimationCtrlConstructor');
  _wxAnimationCtrlConstructor = wxAnimationCtrlConstructorPtr.asFunction<_WxAnimationCtrlConstructor>();

  final wxAnimationCtrlPlayPtr = dylib.lookup <NativeFunction<_WxAnimationCtrlPlayNative>>('wxAnimationCtrlPlay');
  _wxAnimationCtrlPlay = wxAnimationCtrlPlayPtr.asFunction<_WxAnimationCtrlPlay>();

  final wxAnimationCtrlIsPlayingPtr = dylib.lookup <NativeFunction<_WxAnimationCtrlIsPlayingNative>>('wxAnimationCtrlIsPlaying');
  _wxAnimationCtrlIsPlaying = wxAnimationCtrlIsPlayingPtr.asFunction<_WxAnimationCtrlIsPlaying>();

  final wxAnimationCtrlStopPtr = dylib.lookup <NativeFunction<_WxAnimationCtrlStopNative>>('wxAnimationCtrlStop');
  _wxAnimationCtrlStop = wxAnimationCtrlStopPtr.asFunction<_WxAnimationCtrlStop>();

  final wxAnimationCtrlSetInactiveBitmapPtr = dylib.lookup <NativeFunction<_WxAnimationCtrlSetInactiveBitmapNative>>('wxAnimationCtrlSetInactiveBitmap');
  _wxAnimationCtrlSetInactiveBitmap = wxAnimationCtrlSetInactiveBitmapPtr.asFunction<_WxAnimationCtrlSetInactiveBitmap>();

  // ------------------------- wxActivityIndicator ----------------------

  final wxActivityIndicatorConstructorPtr = dylib.lookup <NativeFunction<_WxActivityIndicatorConstructorNative>>('wxActivityIndicatorConstructor');
  _wxActivityIndicatorConstructor = wxActivityIndicatorConstructorPtr.asFunction<_WxActivityIndicatorConstructor>();

  final wxActivityIndicatorStartPtr = dylib.lookup <NativeFunction<_WxActivityIndicatorStartNative>>('wxActivityIndicatorStart');
  _wxActivityIndicatorStart = wxActivityIndicatorStartPtr.asFunction<_WxActivityIndicatorStart>();

  final wxActivityIndicatorIsRunningPtr = dylib.lookup <NativeFunction<_WxActivityIndicatorIsRunningNative>>('wxActivityIndicatorIsRunning');
  _wxActivityIndicatorIsRunning = wxActivityIndicatorIsRunningPtr.asFunction<_WxActivityIndicatorIsRunning>();

  final wxActivityIndicatorStopPtr = dylib.lookup <NativeFunction<_WxActivityIndicatorStopNative>>('wxActivityIndicatorStop');
  _wxActivityIndicatorStop = wxActivityIndicatorStopPtr.asFunction<_WxActivityIndicatorStop>();

  // ------------------------- wxStaticBox ----------------------

  final wxStaticBoxConstructorPtr = dylib.lookup <NativeFunction<_WxStaticBoxConstructorNative>>('wxStaticBoxConstructor');
  _wxStaticBoxConstructor = wxStaticBoxConstructorPtr.asFunction<_WxStaticBoxConstructor>();

  // ------------------------- wxStaticLine ----------------------

  final wxStaticLineConstructorPtr = dylib.lookup <NativeFunction<_WxStaticLineConstructorNative>>('wxStaticLineConstructor');
  _wxStaticLineConstructor = wxStaticLineConstructorPtr.asFunction<_WxStaticLineConstructor>();

  // ------------------------- wxCheckBox ----------------------

  final wxCheckBoxConstructorPtr = dylib.lookup <NativeFunction<_WxCheckBoxConstructorNative>>('wxCheckBoxConstructor');
  _wxCheckBoxConstructor = wxCheckBoxConstructorPtr.asFunction<_WxCheckBoxConstructor>();

  final wxCheckBoxIsCheckedPtr = dylib.lookup <NativeFunction<_WxCheckBoxIsCheckedNative>>('wxCheckBoxIsChecked');
  _wxCheckBoxIsChecked = wxCheckBoxIsCheckedPtr.asFunction<_WxCheckBoxIsChecked>();

  final wxCheckBoxIs3StatePtr = dylib.lookup <NativeFunction<_WxCheckBoxIs3StateNative>>('wxCheckBoxIs3State');
  _wxCheckBoxIs3State = wxCheckBoxIs3StatePtr.asFunction<_WxCheckBoxIs3State>();

  final wxCheckBoxIs3rdStateAllowedForUserPtr = dylib.lookup <NativeFunction<_WxCheckBoxIs3rdStateAllowedForUserNative>>('wxCheckBoxIs3rdStateAllowedForUser');
  _wxCheckBoxIs3rdStateAllowedForUser = wxCheckBoxIs3rdStateAllowedForUserPtr.asFunction<_WxCheckBoxIs3rdStateAllowedForUser>();

  final wxCheckBoxGet3StateValuePtr = dylib.lookup <NativeFunction<_WxCheckBoxGet3StateValueNative>>('wxCheckBoxGet3StateValue');
  _wxCheckBoxGet3StateValue = wxCheckBoxGet3StateValuePtr.asFunction<_WxCheckBoxGet3StateValue>();

  final wxCheckBoxGetValuePtr = dylib.lookup <NativeFunction<_WxCheckBoxGetValueNative>>('wxCheckBoxGetValue');
  _wxCheckBoxGetValue = wxCheckBoxGetValuePtr.asFunction<_WxCheckBoxGetValue>();

  final wxCheckBoxSetValuePtr = dylib.lookup <NativeFunction<_WxCheckBoxSetValueNative>>('wxCheckBoxSetValue');
  _wxCheckBoxSetValue = wxCheckBoxSetValuePtr.asFunction<_WxCheckBoxSetValue>();

  final wxCheckBoxSet3StateValuePtr = dylib.lookup <NativeFunction<_WxCheckBoxSet3StateValueNative>>('wxCheckBoxSet3StateValue');
  _wxCheckBoxSet3StateValue = wxCheckBoxSet3StateValuePtr.asFunction<_WxCheckBoxSet3StateValue>();

  // ------------------------- wxToggleButton ----------------------

  final wxToggleButtonConstructorPtr = dylib.lookup <NativeFunction<_WxToggleButtonConstructorNative>>('wxToggleButtonConstructor');
  _wxToggleButtonConstructor = wxToggleButtonConstructorPtr.asFunction<_WxToggleButtonConstructor>();

  final wxToggleButtonGetValuePtr = dylib.lookup <NativeFunction<_WxToggleButtonGetValueNative>>('wxToggleButtonGetValue');
  _wxToggleButtonGetValue = wxToggleButtonGetValuePtr.asFunction<_WxToggleButtonGetValue>();

  final wxToggleButtonSetValuePtr = dylib.lookup <NativeFunction<_WxToggleButtonSetValueNative>>('wxToggleButtonSetValue');
  _wxToggleButtonSetValue = wxToggleButtonSetValuePtr.asFunction<_WxToggleButtonSetValue>();

  // ------------------------- wxBitmapToggleButton ----------------------

  final wxBitmapToggleButtonConstructorPtr = dylib.lookup <NativeFunction<_WxBitmapToggleButtonConstructorNative>>('wxBitmapToggleButtonConstructor');
  _wxBitmapToggleButtonConstructor = wxBitmapToggleButtonConstructorPtr.asFunction<_WxBitmapToggleButtonConstructor>();

  // ------------------------- wxItemContainerImmutable ----------------------

  // ------------------------- wxItemContainer ----------------------

  // ------------------------- wxRadioButton ----------------------

  final wxRadioButtonConstructorPtr = dylib.lookup <NativeFunction<_WxRadioButtonConstructorNative>>('wxRadioButtonConstructor');
  _wxRadioButtonConstructor = wxRadioButtonConstructorPtr.asFunction<_WxRadioButtonConstructor>();

  final wxRadioButtonSetValuePtr = dylib.lookup <NativeFunction<_WxRadioButtonSetValueNative>>('wxRadioButtonSetValue');
  _wxRadioButtonSetValue = wxRadioButtonSetValuePtr.asFunction<_WxRadioButtonSetValue>();

  final wxRadioButtonGetValuePtr = dylib.lookup <NativeFunction<_WxRadioButtonGetValueNative>>('wxRadioButtonGetValue');
  _wxRadioButtonGetValue = wxRadioButtonGetValuePtr.asFunction<_WxRadioButtonGetValue>();

  // ------------------------- wxRadioBox ----------------------

  final wxRadioBoxConstructorPtr = dylib.lookup <NativeFunction<_WxRadioBoxConstructorNative>>('wxRadioBoxConstructor');
  _wxRadioBoxConstructor = wxRadioBoxConstructorPtr.asFunction<_WxRadioBoxConstructor>();

  final wxRadioBoxGetCountPtr = dylib.lookup <NativeFunction<_WxRadioBoxGetCountNative>>('wxRadioBoxGetCount');
  _wxRadioBoxGetCount = wxRadioBoxGetCountPtr.asFunction<_WxRadioBoxGetCount>();

  final wxRadioBoxIsEmptyPtr = dylib.lookup <NativeFunction<_WxRadioBoxIsEmptyNative>>('wxRadioBoxIsEmpty');
  _wxRadioBoxIsEmpty = wxRadioBoxIsEmptyPtr.asFunction<_WxRadioBoxIsEmpty>();

  final wxRadioBoxSetStringPtr = dylib.lookup <NativeFunction<_WxRadioBoxSetStringNative>>('wxRadioBoxSetString');
  _wxRadioBoxSetString = wxRadioBoxSetStringPtr.asFunction<_WxRadioBoxSetString>();

  final wxRadioBoxGetStringPtr = dylib.lookup <NativeFunction<_WxRadioBoxGetStringNative>>('wxRadioBoxGetString');
  _wxRadioBoxGetString = wxRadioBoxGetStringPtr.asFunction<_WxRadioBoxGetString>();

  final wxRadioBoxGetStringsPtr = dylib.lookup <NativeFunction<_WxRadioBoxGetStringsNative>>('wxRadioBoxGetStrings');
  _wxRadioBoxGetStrings = wxRadioBoxGetStringsPtr.asFunction<_WxRadioBoxGetStrings>();

  final wxRadioBoxFindStringPtr = dylib.lookup <NativeFunction<_WxRadioBoxFindStringNative>>('wxRadioBoxFindString');
  _wxRadioBoxFindString = wxRadioBoxFindStringPtr.asFunction<_WxRadioBoxFindString>();

  final wxRadioBoxSetSelectionPtr = dylib.lookup <NativeFunction<_WxRadioBoxSetSelectionNative>>('wxRadioBoxSetSelection');
  _wxRadioBoxSetSelection = wxRadioBoxSetSelectionPtr.asFunction<_WxRadioBoxSetSelection>();

  final wxRadioBoxSetStringSelectionPtr = dylib.lookup <NativeFunction<_WxRadioBoxSetStringSelectionNative>>('wxRadioBoxSetStringSelection');
  _wxRadioBoxSetStringSelection = wxRadioBoxSetStringSelectionPtr.asFunction<_WxRadioBoxSetStringSelection>();

  final wxRadioBoxSelectPtr = dylib.lookup <NativeFunction<_WxRadioBoxSelectNative>>('wxRadioBoxSelect');
  _wxRadioBoxSelect = wxRadioBoxSelectPtr.asFunction<_WxRadioBoxSelect>();

  final wxRadioBoxGetSelectionPtr = dylib.lookup <NativeFunction<_WxRadioBoxGetSelectionNative>>('wxRadioBoxGetSelection');
  _wxRadioBoxGetSelection = wxRadioBoxGetSelectionPtr.asFunction<_WxRadioBoxGetSelection>();

  final wxRadioBoxGetStringSelectionPtr = dylib.lookup <NativeFunction<_WxRadioBoxGetStringSelectionNative>>('wxRadioBoxGetStringSelection');
  _wxRadioBoxGetStringSelection = wxRadioBoxGetStringSelectionPtr.asFunction<_WxRadioBoxGetStringSelection>();

  final wxRadioBoxEnableItemPtr = dylib.lookup <NativeFunction<_WxRadioBoxEnableItemNative>>('wxRadioBoxEnableItem');
  _wxRadioBoxEnableItem = wxRadioBoxEnableItemPtr.asFunction<_WxRadioBoxEnableItem>();

  // ------------------------- wxChoice ----------------------

  final wxChoiceConstructorPtr = dylib.lookup <NativeFunction<_WxChoiceConstructorNative>>('wxChoiceConstructor');
  _wxChoiceConstructor = wxChoiceConstructorPtr.asFunction<_WxChoiceConstructor>();

  final wxChoiceSetColumnsPtr = dylib.lookup <NativeFunction<_WxChoiceSetColumnsNative>>('wxChoiceSetColumns');
  _wxChoiceSetColumns = wxChoiceSetColumnsPtr.asFunction<_WxChoiceSetColumns>();

  final wxChoiceGetColumnsPtr = dylib.lookup <NativeFunction<_WxChoiceGetColumnsNative>>('wxChoiceGetColumns');
  _wxChoiceGetColumns = wxChoiceGetColumnsPtr.asFunction<_WxChoiceGetColumns>();

  final wxChoiceIsSortedPtr = dylib.lookup <NativeFunction<_WxChoiceIsSortedNative>>('wxChoiceIsSorted');
  _wxChoiceIsSorted = wxChoiceIsSortedPtr.asFunction<_WxChoiceIsSorted>();

  final wxChoiceGetCountPtr = dylib.lookup <NativeFunction<_WxChoiceGetCountNative>>('wxChoiceGetCount');
  _wxChoiceGetCount = wxChoiceGetCountPtr.asFunction<_WxChoiceGetCount>();

  final wxChoiceIsEmptyPtr = dylib.lookup <NativeFunction<_WxChoiceIsEmptyNative>>('wxChoiceIsEmpty');
  _wxChoiceIsEmpty = wxChoiceIsEmptyPtr.asFunction<_WxChoiceIsEmpty>();

  final wxChoiceSetStringPtr = dylib.lookup <NativeFunction<_WxChoiceSetStringNative>>('wxChoiceSetString');
  _wxChoiceSetString = wxChoiceSetStringPtr.asFunction<_WxChoiceSetString>();

  final wxChoiceGetStringPtr = dylib.lookup <NativeFunction<_WxChoiceGetStringNative>>('wxChoiceGetString');
  _wxChoiceGetString = wxChoiceGetStringPtr.asFunction<_WxChoiceGetString>();

  final wxChoiceGetStringsPtr = dylib.lookup <NativeFunction<_WxChoiceGetStringsNative>>('wxChoiceGetStrings');
  _wxChoiceGetStrings = wxChoiceGetStringsPtr.asFunction<_WxChoiceGetStrings>();

  final wxChoiceFindStringPtr = dylib.lookup <NativeFunction<_WxChoiceFindStringNative>>('wxChoiceFindString');
  _wxChoiceFindString = wxChoiceFindStringPtr.asFunction<_WxChoiceFindString>();

  final wxChoiceSetSelectionPtr = dylib.lookup <NativeFunction<_WxChoiceSetSelectionNative>>('wxChoiceSetSelection');
  _wxChoiceSetSelection = wxChoiceSetSelectionPtr.asFunction<_WxChoiceSetSelection>();

  final wxChoiceSetStringSelectionPtr = dylib.lookup <NativeFunction<_WxChoiceSetStringSelectionNative>>('wxChoiceSetStringSelection');
  _wxChoiceSetStringSelection = wxChoiceSetStringSelectionPtr.asFunction<_WxChoiceSetStringSelection>();

  final wxChoiceSelectPtr = dylib.lookup <NativeFunction<_WxChoiceSelectNative>>('wxChoiceSelect');
  _wxChoiceSelect = wxChoiceSelectPtr.asFunction<_WxChoiceSelect>();

  final wxChoiceGetSelectionPtr = dylib.lookup <NativeFunction<_WxChoiceGetSelectionNative>>('wxChoiceGetSelection');
  _wxChoiceGetSelection = wxChoiceGetSelectionPtr.asFunction<_WxChoiceGetSelection>();

  final wxChoiceGetStringSelectionPtr = dylib.lookup <NativeFunction<_WxChoiceGetStringSelectionNative>>('wxChoiceGetStringSelection');
  _wxChoiceGetStringSelection = wxChoiceGetStringSelectionPtr.asFunction<_WxChoiceGetStringSelection>();

  final wxChoiceClearPtr = dylib.lookup <NativeFunction<_WxChoiceClearNative>>('wxChoiceClear');
  _wxChoiceClear = wxChoiceClearPtr.asFunction<_WxChoiceClear>();

  final wxChoiceDeletePtr = dylib.lookup <NativeFunction<_WxChoiceDeleteNative>>('wxChoiceDelete');
  _wxChoiceDelete = wxChoiceDeletePtr.asFunction<_WxChoiceDelete>();

  final wxChoiceSetPtr = dylib.lookup <NativeFunction<_WxChoiceSetNative>>('wxChoiceSet');
  _wxChoiceSet = wxChoiceSetPtr.asFunction<_WxChoiceSet>();

  final wxChoiceAppendPtr = dylib.lookup <NativeFunction<_WxChoiceAppendNative>>('wxChoiceAppend');
  _wxChoiceAppend = wxChoiceAppendPtr.asFunction<_WxChoiceAppend>();

  final wxChoiceAppendListPtr = dylib.lookup <NativeFunction<_WxChoiceAppendListNative>>('wxChoiceAppendList');
  _wxChoiceAppendList = wxChoiceAppendListPtr.asFunction<_WxChoiceAppendList>();

  final wxChoiceInsertPtr = dylib.lookup <NativeFunction<_WxChoiceInsertNative>>('wxChoiceInsert');
  _wxChoiceInsert = wxChoiceInsertPtr.asFunction<_WxChoiceInsert>();

  final wxChoiceInsertListPtr = dylib.lookup <NativeFunction<_WxChoiceInsertListNative>>('wxChoiceInsertList');
  _wxChoiceInsertList = wxChoiceInsertListPtr.asFunction<_WxChoiceInsertList>();

  final wxChoiceSetClientDataPtr = dylib.lookup <NativeFunction<_WxChoiceSetClientDataNative>>('wxChoiceSetClientData');
  _wxChoiceSetClientData = wxChoiceSetClientDataPtr.asFunction<_WxChoiceSetClientData>();

  final wxChoiceGetClientDataPtr = dylib.lookup <NativeFunction<_WxChoiceGetClientDataNative>>('wxChoiceGetClientData');
  _wxChoiceGetClientData = wxChoiceGetClientDataPtr.asFunction<_WxChoiceGetClientData>();

  // ------------------------- wxListBox ----------------------

  final wxListBoxConstructorPtr = dylib.lookup <NativeFunction<_WxListBoxConstructorNative>>('wxListBoxConstructor');
  _wxListBoxConstructor = wxListBoxConstructorPtr.asFunction<_WxListBoxConstructor>();

  final wxListBoxIsSortedPtr = dylib.lookup <NativeFunction<_WxListBoxIsSortedNative>>('wxListBoxIsSorted');
  _wxListBoxIsSorted = wxListBoxIsSortedPtr.asFunction<_WxListBoxIsSorted>();

  final wxListBoxIsSelectedPtr = dylib.lookup <NativeFunction<_WxListBoxIsSelectedNative>>('wxListBoxIsSelected');
  _wxListBoxIsSelected = wxListBoxIsSelectedPtr.asFunction<_WxListBoxIsSelected>();

  final wxListBoxDeselectPtr = dylib.lookup <NativeFunction<_WxListBoxDeselectNative>>('wxListBoxDeselect');
  _wxListBoxDeselect = wxListBoxDeselectPtr.asFunction<_WxListBoxDeselect>();

  final wxListBoxSetFirstItemPtr = dylib.lookup <NativeFunction<_WxListBoxSetFirstItemNative>>('wxListBoxSetFirstItem');
  _wxListBoxSetFirstItem = wxListBoxSetFirstItemPtr.asFunction<_WxListBoxSetFirstItem>();

  final wxListBoxEnsureVisiblePtr = dylib.lookup <NativeFunction<_WxListBoxEnsureVisibleNative>>('wxListBoxEnsureVisible');
  _wxListBoxEnsureVisible = wxListBoxEnsureVisiblePtr.asFunction<_WxListBoxEnsureVisible>();

  final wxListBoxGetCountPerPagePtr = dylib.lookup <NativeFunction<_WxListBoxGetCountPerPageNative>>('wxListBoxGetCountPerPage');
  _wxListBoxGetCountPerPage = wxListBoxGetCountPerPagePtr.asFunction<_WxListBoxGetCountPerPage>();

  final wxListBoxGetTopItemPtr = dylib.lookup <NativeFunction<_WxListBoxGetTopItemNative>>('wxListBoxGetTopItem');
  _wxListBoxGetTopItem = wxListBoxGetTopItemPtr.asFunction<_WxListBoxGetTopItem>();

  final wxListBoxGetCountPtr = dylib.lookup <NativeFunction<_WxListBoxGetCountNative>>('wxListBoxGetCount');
  _wxListBoxGetCount = wxListBoxGetCountPtr.asFunction<_WxListBoxGetCount>();

  final wxListBoxIsEmptyPtr = dylib.lookup <NativeFunction<_WxListBoxIsEmptyNative>>('wxListBoxIsEmpty');
  _wxListBoxIsEmpty = wxListBoxIsEmptyPtr.asFunction<_WxListBoxIsEmpty>();

  final wxListBoxSetStringPtr = dylib.lookup <NativeFunction<_WxListBoxSetStringNative>>('wxListBoxSetString');
  _wxListBoxSetString = wxListBoxSetStringPtr.asFunction<_WxListBoxSetString>();

  final wxListBoxGetStringPtr = dylib.lookup <NativeFunction<_WxListBoxGetStringNative>>('wxListBoxGetString');
  _wxListBoxGetString = wxListBoxGetStringPtr.asFunction<_WxListBoxGetString>();

  final wxListBoxGetStringsPtr = dylib.lookup <NativeFunction<_WxListBoxGetStringsNative>>('wxListBoxGetStrings');
  _wxListBoxGetStrings = wxListBoxGetStringsPtr.asFunction<_WxListBoxGetStrings>();

  final wxListBoxFindStringPtr = dylib.lookup <NativeFunction<_WxListBoxFindStringNative>>('wxListBoxFindString');
  _wxListBoxFindString = wxListBoxFindStringPtr.asFunction<_WxListBoxFindString>();

  final wxListBoxSetSelectionPtr = dylib.lookup <NativeFunction<_WxListBoxSetSelectionNative>>('wxListBoxSetSelection');
  _wxListBoxSetSelection = wxListBoxSetSelectionPtr.asFunction<_WxListBoxSetSelection>();

  final wxListBoxSetStringSelectionPtr = dylib.lookup <NativeFunction<_WxListBoxSetStringSelectionNative>>('wxListBoxSetStringSelection');
  _wxListBoxSetStringSelection = wxListBoxSetStringSelectionPtr.asFunction<_WxListBoxSetStringSelection>();

  final wxListBoxSelectPtr = dylib.lookup <NativeFunction<_WxListBoxSelectNative>>('wxListBoxSelect');
  _wxListBoxSelect = wxListBoxSelectPtr.asFunction<_WxListBoxSelect>();

  final wxListBoxGetSelectionPtr = dylib.lookup <NativeFunction<_WxListBoxGetSelectionNative>>('wxListBoxGetSelection');
  _wxListBoxGetSelection = wxListBoxGetSelectionPtr.asFunction<_WxListBoxGetSelection>();

  final wxListBoxGetSelectionsPtr = dylib.lookup <NativeFunction<_WxListBoxGetSelectionsNative>>('wxListBoxGetSelections');
  _wxListBoxGetSelections = wxListBoxGetSelectionsPtr.asFunction<_WxListBoxGetSelections>();

  final wxListBoxGetStringSelectionPtr = dylib.lookup <NativeFunction<_WxListBoxGetStringSelectionNative>>('wxListBoxGetStringSelection');
  _wxListBoxGetStringSelection = wxListBoxGetStringSelectionPtr.asFunction<_WxListBoxGetStringSelection>();

  final wxListBoxClearPtr = dylib.lookup <NativeFunction<_WxListBoxClearNative>>('wxListBoxClear');
  _wxListBoxClear = wxListBoxClearPtr.asFunction<_WxListBoxClear>();

  final wxListBoxDeletePtr = dylib.lookup <NativeFunction<_WxListBoxDeleteNative>>('wxListBoxDelete');
  _wxListBoxDelete = wxListBoxDeletePtr.asFunction<_WxListBoxDelete>();

  final wxListBoxSetPtr = dylib.lookup <NativeFunction<_WxListBoxSetNative>>('wxListBoxSet');
  _wxListBoxSet = wxListBoxSetPtr.asFunction<_WxListBoxSet>();

  final wxListBoxAppendPtr = dylib.lookup <NativeFunction<_WxListBoxAppendNative>>('wxListBoxAppend');
  _wxListBoxAppend = wxListBoxAppendPtr.asFunction<_WxListBoxAppend>();

  final wxListBoxAppendListPtr = dylib.lookup <NativeFunction<_WxListBoxAppendListNative>>('wxListBoxAppendList');
  _wxListBoxAppendList = wxListBoxAppendListPtr.asFunction<_WxListBoxAppendList>();

  final wxListBoxInsertPtr = dylib.lookup <NativeFunction<_WxListBoxInsertNative>>('wxListBoxInsert');
  _wxListBoxInsert = wxListBoxInsertPtr.asFunction<_WxListBoxInsert>();

  final wxListBoxInsertListPtr = dylib.lookup <NativeFunction<_WxListBoxInsertListNative>>('wxListBoxInsertList');
  _wxListBoxInsertList = wxListBoxInsertListPtr.asFunction<_WxListBoxInsertList>();

  final wxListBoxSetClientDataPtr = dylib.lookup <NativeFunction<_WxListBoxSetClientDataNative>>('wxListBoxSetClientData');
  _wxListBoxSetClientData = wxListBoxSetClientDataPtr.asFunction<_WxListBoxSetClientData>();

  final wxListBoxGetClientDataPtr = dylib.lookup <NativeFunction<_WxListBoxGetClientDataNative>>('wxListBoxGetClientData');
  _wxListBoxGetClientData = wxListBoxGetClientDataPtr.asFunction<_WxListBoxGetClientData>();

  // ------------------------- wxGauge ----------------------

  final wxGaugeConstructorPtr = dylib.lookup <NativeFunction<_WxGaugeConstructorNative>>('wxGaugeConstructor');
  _wxGaugeConstructor = wxGaugeConstructorPtr.asFunction<_WxGaugeConstructor>();

  final wxGaugeIsVerticalPtr = dylib.lookup <NativeFunction<_WxGaugeIsVerticalNative>>('wxGaugeIsVertical');
  _wxGaugeIsVertical = wxGaugeIsVerticalPtr.asFunction<_WxGaugeIsVertical>();

  final wxGaugeGetValuePtr = dylib.lookup <NativeFunction<_WxGaugeGetValueNative>>('wxGaugeGetValue');
  _wxGaugeGetValue = wxGaugeGetValuePtr.asFunction<_WxGaugeGetValue>();

  final wxGaugeSetValuePtr = dylib.lookup <NativeFunction<_WxGaugeSetValueNative>>('wxGaugeSetValue');
  _wxGaugeSetValue = wxGaugeSetValuePtr.asFunction<_WxGaugeSetValue>();

  final wxGaugeGetRangePtr = dylib.lookup <NativeFunction<_WxGaugeGetRangeNative>>('wxGaugeGetRange');
  _wxGaugeGetRange = wxGaugeGetRangePtr.asFunction<_WxGaugeGetRange>();

  final wxGaugeSetRangePtr = dylib.lookup <NativeFunction<_WxGaugeSetRangeNative>>('wxGaugeSetRange');
  _wxGaugeSetRange = wxGaugeSetRangePtr.asFunction<_WxGaugeSetRange>();

  final wxGaugePulsePtr = dylib.lookup <NativeFunction<_WxGaugePulseNative>>('wxGaugePulse');
  _wxGaugePulse = wxGaugePulsePtr.asFunction<_WxGaugePulse>();

  // ------------------------- wxSlider ----------------------

  final wxSliderConstructorPtr = dylib.lookup <NativeFunction<_WxSliderConstructorNative>>('wxSliderConstructor');
  _wxSliderConstructor = wxSliderConstructorPtr.asFunction<_WxSliderConstructor>();

  final wxSliderGetLineSizePtr = dylib.lookup <NativeFunction<_WxSliderGetLineSizeNative>>('wxSliderGetLineSize');
  _wxSliderGetLineSize = wxSliderGetLineSizePtr.asFunction<_WxSliderGetLineSize>();

  final wxSliderSetLineSizePtr = dylib.lookup <NativeFunction<_WxSliderSetLineSizeNative>>('wxSliderSetLineSize');
  _wxSliderSetLineSize = wxSliderSetLineSizePtr.asFunction<_WxSliderSetLineSize>();

  final wxSliderGetValuePtr = dylib.lookup <NativeFunction<_WxSliderGetValueNative>>('wxSliderGetValue');
  _wxSliderGetValue = wxSliderGetValuePtr.asFunction<_WxSliderGetValue>();

  final wxSliderSetValuePtr = dylib.lookup <NativeFunction<_WxSliderSetValueNative>>('wxSliderSetValue');
  _wxSliderSetValue = wxSliderSetValuePtr.asFunction<_WxSliderSetValue>();

  final wxSliderGetTickFreqPtr = dylib.lookup <NativeFunction<_WxSliderGetTickFreqNative>>('wxSliderGetTickFreq');
  _wxSliderGetTickFreq = wxSliderGetTickFreqPtr.asFunction<_WxSliderGetTickFreq>();

  final wxSliderSetTickPtr = dylib.lookup <NativeFunction<_WxSliderSetTickNative>>('wxSliderSetTick');
  _wxSliderSetTick = wxSliderSetTickPtr.asFunction<_WxSliderSetTick>();

  final wxSliderClearTicksPtr = dylib.lookup <NativeFunction<_WxSliderClearTicksNative>>('wxSliderClearTicks');
  _wxSliderClearTicks = wxSliderClearTicksPtr.asFunction<_WxSliderClearTicks>();

  final wxSliderSetRangePtr = dylib.lookup <NativeFunction<_WxSliderSetRangeNative>>('wxSliderSetRange');
  _wxSliderSetRange = wxSliderSetRangePtr.asFunction<_WxSliderSetRange>();

  final wxSliderGetMinPtr = dylib.lookup <NativeFunction<_WxSliderGetMinNative>>('wxSliderGetMin');
  _wxSliderGetMin = wxSliderGetMinPtr.asFunction<_WxSliderGetMin>();

  final wxSliderSetMinPtr = dylib.lookup <NativeFunction<_WxSliderSetMinNative>>('wxSliderSetMin');
  _wxSliderSetMin = wxSliderSetMinPtr.asFunction<_WxSliderSetMin>();

  final wxSliderGetMaxPtr = dylib.lookup <NativeFunction<_WxSliderGetMaxNative>>('wxSliderGetMax');
  _wxSliderGetMax = wxSliderGetMaxPtr.asFunction<_WxSliderGetMax>();

  final wxSliderSetMaxPtr = dylib.lookup <NativeFunction<_WxSliderSetMaxNative>>('wxSliderSetMax');
  _wxSliderSetMax = wxSliderSetMaxPtr.asFunction<_WxSliderSetMax>();

  final wxSliderGetPageSizePtr = dylib.lookup <NativeFunction<_WxSliderGetPageSizeNative>>('wxSliderGetPageSize');
  _wxSliderGetPageSize = wxSliderGetPageSizePtr.asFunction<_WxSliderGetPageSize>();

  final wxSliderSetPageSizePtr = dylib.lookup <NativeFunction<_WxSliderSetPageSizeNative>>('wxSliderSetPageSize');
  _wxSliderSetPageSize = wxSliderSetPageSizePtr.asFunction<_WxSliderSetPageSize>();

  // ------------------------- wxSpinEvent ----------------------

  final wxSpinEventConstructorPtr = dylib.lookup <NativeFunction<_WxSpinEventConstructorNative>>('wxSpinEventConstructor');
  _wxSpinEventConstructor = wxSpinEventConstructorPtr.asFunction<_WxSpinEventConstructor>();

  final wxSpinEventSetPositionPtr = dylib.lookup <NativeFunction<_WxSpinEventSetPositionNative>>('wxSpinEventSetPosition');
  _wxSpinEventSetPosition = wxSpinEventSetPositionPtr.asFunction<_WxSpinEventSetPosition>();

  final wxSpinEventGetPositionPtr = dylib.lookup <NativeFunction<_WxSpinEventGetPositionNative>>('wxSpinEventGetPosition');
  _wxSpinEventGetPosition = wxSpinEventGetPositionPtr.asFunction<_WxSpinEventGetPosition>();

  final wxInstallDartSpinEventCallbackPtr = dylib.lookup <NativeFunction<_WxInstallDartSpinEventCallbackNative>>('wxInstallDartSpinEventCallback');
  _wxInstallDartSpinEventCallback = wxInstallDartSpinEventCallbackPtr.asFunction<_WxInstallDartSpinEventCallback>();

  wxSpinEventNativeCallable = NativeCallable<WxSpinEventCallbackNative>.isolateLocal( wxSpinEventCallback );
  _wxInstallDartSpinEventCallback( wxSpinEventNativeCallable.nativeFunction );

  // ------------------------- wxSpinCtrl ----------------------

  final wxSpinCtrlConstructorPtr = dylib.lookup <NativeFunction<_WxSpinCtrlConstructorNative>>('wxSpinCtrlConstructor');
  _wxSpinCtrlConstructor = wxSpinCtrlConstructorPtr.asFunction<_WxSpinCtrlConstructor>();

  final wxSpinCtrlGetMinPtr = dylib.lookup <NativeFunction<_WxSpinCtrlGetMinNative>>('wxSpinCtrlGetMin');
  _wxSpinCtrlGetMin = wxSpinCtrlGetMinPtr.asFunction<_WxSpinCtrlGetMin>();

  final wxSpinCtrlGetMaxPtr = dylib.lookup <NativeFunction<_WxSpinCtrlGetMaxNative>>('wxSpinCtrlGetMax');
  _wxSpinCtrlGetMax = wxSpinCtrlGetMaxPtr.asFunction<_WxSpinCtrlGetMax>();

  final wxSpinCtrlSetRangePtr = dylib.lookup <NativeFunction<_WxSpinCtrlSetRangeNative>>('wxSpinCtrlSetRange');
  _wxSpinCtrlSetRange = wxSpinCtrlSetRangePtr.asFunction<_WxSpinCtrlSetRange>();

  final wxSpinCtrlGetIncrementPtr = dylib.lookup <NativeFunction<_WxSpinCtrlGetIncrementNative>>('wxSpinCtrlGetIncrement');
  _wxSpinCtrlGetIncrement = wxSpinCtrlGetIncrementPtr.asFunction<_WxSpinCtrlGetIncrement>();

  final wxSpinCtrlSetIncrementPtr = dylib.lookup <NativeFunction<_WxSpinCtrlSetIncrementNative>>('wxSpinCtrlSetIncrement');
  _wxSpinCtrlSetIncrement = wxSpinCtrlSetIncrementPtr.asFunction<_WxSpinCtrlSetIncrement>();

  final wxSpinCtrlGetBasePtr = dylib.lookup <NativeFunction<_WxSpinCtrlGetBaseNative>>('wxSpinCtrlGetBase');
  _wxSpinCtrlGetBase = wxSpinCtrlGetBasePtr.asFunction<_WxSpinCtrlGetBase>();

  final wxSpinCtrlSetBasePtr = dylib.lookup <NativeFunction<_WxSpinCtrlSetBaseNative>>('wxSpinCtrlSetBase');
  _wxSpinCtrlSetBase = wxSpinCtrlSetBasePtr.asFunction<_WxSpinCtrlSetBase>();

  final wxSpinCtrlGetValuePtr = dylib.lookup <NativeFunction<_WxSpinCtrlGetValueNative>>('wxSpinCtrlGetValue');
  _wxSpinCtrlGetValue = wxSpinCtrlGetValuePtr.asFunction<_WxSpinCtrlGetValue>();

  final wxSpinCtrlSetValuePtr = dylib.lookup <NativeFunction<_WxSpinCtrlSetValueNative>>('wxSpinCtrlSetValue');
  _wxSpinCtrlSetValue = wxSpinCtrlSetValuePtr.asFunction<_WxSpinCtrlSetValue>();

  final wxSpinCtrlGetTextValuePtr = dylib.lookup <NativeFunction<_WxSpinCtrlGetTextValueNative>>('wxSpinCtrlGetTextValue');
  _wxSpinCtrlGetTextValue = wxSpinCtrlGetTextValuePtr.asFunction<_WxSpinCtrlGetTextValue>();

  final wxSpinCtrlSetTextValuePtr = dylib.lookup <NativeFunction<_WxSpinCtrlSetTextValueNative>>('wxSpinCtrlSetTextValue');
  _wxSpinCtrlSetTextValue = wxSpinCtrlSetTextValuePtr.asFunction<_WxSpinCtrlSetTextValue>();

  // ------------------------- wxSpinDoubleEvent ----------------------

  final wxSpinDoubleEventConstructorPtr = dylib.lookup <NativeFunction<_WxSpinDoubleEventConstructorNative>>('wxSpinDoubleEventConstructor');
  _wxSpinDoubleEventConstructor = wxSpinDoubleEventConstructorPtr.asFunction<_WxSpinDoubleEventConstructor>();

  final wxSpinDoubleEventSetValuePtr = dylib.lookup <NativeFunction<_WxSpinDoubleEventSetValueNative>>('wxSpinDoubleEventSetValue');
  _wxSpinDoubleEventSetValue = wxSpinDoubleEventSetValuePtr.asFunction<_WxSpinDoubleEventSetValue>();

  final wxSpinDoubleEventGetValuePtr = dylib.lookup <NativeFunction<_WxSpinDoubleEventGetValueNative>>('wxSpinDoubleEventGetValue');
  _wxSpinDoubleEventGetValue = wxSpinDoubleEventGetValuePtr.asFunction<_WxSpinDoubleEventGetValue>();

  final wxInstallDartSpinDoubleEventCallbackPtr = dylib.lookup <NativeFunction<_WxInstallDartSpinDoubleEventCallbackNative>>('wxInstallDartSpinDoubleEventCallback');
  _wxInstallDartSpinDoubleEventCallback = wxInstallDartSpinDoubleEventCallbackPtr.asFunction<_WxInstallDartSpinDoubleEventCallback>();

  wxSpinDoubleEventNativeCallable = NativeCallable<WxSpinDoubleEventCallbackNative>.isolateLocal( wxSpinDoubleEventCallback );
  _wxInstallDartSpinDoubleEventCallback( wxSpinDoubleEventNativeCallable.nativeFunction );

  // ------------------------- wxSpinCtrlDouble ----------------------

  final wxSpinCtrlDoubleConstructorPtr = dylib.lookup <NativeFunction<_WxSpinCtrlDoubleConstructorNative>>('wxSpinCtrlDoubleConstructor');
  _wxSpinCtrlDoubleConstructor = wxSpinCtrlDoubleConstructorPtr.asFunction<_WxSpinCtrlDoubleConstructor>();

  final wxSpinCtrlDoubleGetDigitsPtr = dylib.lookup <NativeFunction<_WxSpinCtrlDoubleGetDigitsNative>>('wxSpinCtrlDoubleGetDigits');
  _wxSpinCtrlDoubleGetDigits = wxSpinCtrlDoubleGetDigitsPtr.asFunction<_WxSpinCtrlDoubleGetDigits>();

  final wxSpinCtrlDoubleSetDigitsPtr = dylib.lookup <NativeFunction<_WxSpinCtrlDoubleSetDigitsNative>>('wxSpinCtrlDoubleSetDigits');
  _wxSpinCtrlDoubleSetDigits = wxSpinCtrlDoubleSetDigitsPtr.asFunction<_WxSpinCtrlDoubleSetDigits>();

  final wxSpinCtrlDoubleGetMinPtr = dylib.lookup <NativeFunction<_WxSpinCtrlDoubleGetMinNative>>('wxSpinCtrlDoubleGetMin');
  _wxSpinCtrlDoubleGetMin = wxSpinCtrlDoubleGetMinPtr.asFunction<_WxSpinCtrlDoubleGetMin>();

  final wxSpinCtrlDoubleGetMaxPtr = dylib.lookup <NativeFunction<_WxSpinCtrlDoubleGetMaxNative>>('wxSpinCtrlDoubleGetMax');
  _wxSpinCtrlDoubleGetMax = wxSpinCtrlDoubleGetMaxPtr.asFunction<_WxSpinCtrlDoubleGetMax>();

  final wxSpinCtrlDoubleSetRangePtr = dylib.lookup <NativeFunction<_WxSpinCtrlDoubleSetRangeNative>>('wxSpinCtrlDoubleSetRange');
  _wxSpinCtrlDoubleSetRange = wxSpinCtrlDoubleSetRangePtr.asFunction<_WxSpinCtrlDoubleSetRange>();

  final wxSpinCtrlDoubleGetIncrementPtr = dylib.lookup <NativeFunction<_WxSpinCtrlDoubleGetIncrementNative>>('wxSpinCtrlDoubleGetIncrement');
  _wxSpinCtrlDoubleGetIncrement = wxSpinCtrlDoubleGetIncrementPtr.asFunction<_WxSpinCtrlDoubleGetIncrement>();

  final wxSpinCtrlDoubleSetIncrementPtr = dylib.lookup <NativeFunction<_WxSpinCtrlDoubleSetIncrementNative>>('wxSpinCtrlDoubleSetIncrement');
  _wxSpinCtrlDoubleSetIncrement = wxSpinCtrlDoubleSetIncrementPtr.asFunction<_WxSpinCtrlDoubleSetIncrement>();

  final wxSpinCtrlDoubleGetValuePtr = dylib.lookup <NativeFunction<_WxSpinCtrlDoubleGetValueNative>>('wxSpinCtrlDoubleGetValue');
  _wxSpinCtrlDoubleGetValue = wxSpinCtrlDoubleGetValuePtr.asFunction<_WxSpinCtrlDoubleGetValue>();

  final wxSpinCtrlDoubleSetValuePtr = dylib.lookup <NativeFunction<_WxSpinCtrlDoubleSetValueNative>>('wxSpinCtrlDoubleSetValue');
  _wxSpinCtrlDoubleSetValue = wxSpinCtrlDoubleSetValuePtr.asFunction<_WxSpinCtrlDoubleSetValue>();

  final wxSpinCtrlDoubleGetTextValuePtr = dylib.lookup <NativeFunction<_WxSpinCtrlDoubleGetTextValueNative>>('wxSpinCtrlDoubleGetTextValue');
  _wxSpinCtrlDoubleGetTextValue = wxSpinCtrlDoubleGetTextValuePtr.asFunction<_WxSpinCtrlDoubleGetTextValue>();

  // ------------------------- EVT_BUTTON ----------------------

  final wxGetButtonEventTypePtr = dylib.lookup <NativeFunction<_WxGetButtonEventTypeNative>>('wxGetButtonEventType');
  wxGetButtonEventType = wxGetButtonEventTypePtr.asFunction<WxGetButtonEventType>();

  final wxEvtHandlerBindButtonEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindButtonEventCallbackNative>>('wxEvtHandlerBindButtonEventCallback');
  wxEvtHandlerBindButtonEventCallback = wxEvtHandlerBindButtonEventCallbackPtr.asFunction<WxEvtHandlerBindButtonEventCallback>();

  final wxEvtHandlerUnbindButtonEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindButtonEventCallbackNative>>('wxEvtHandlerUnbindButtonEventCallback');
  wxEvtHandlerUnbindButtonEventCallback = wxEvtHandlerUnbindButtonEventCallbackPtr.asFunction<WxEvtHandlerUnbindButtonEventCallback>();

  // ------------------------- EVT_CHECKBOX ----------------------

  final wxGetCheckboxEventTypePtr = dylib.lookup <NativeFunction<_WxGetCheckboxEventTypeNative>>('wxGetCheckboxEventType');
  wxGetCheckboxEventType = wxGetCheckboxEventTypePtr.asFunction<WxGetCheckboxEventType>();

  final wxEvtHandlerBindCheckboxEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindCheckboxEventCallbackNative>>('wxEvtHandlerBindCheckboxEventCallback');
  wxEvtHandlerBindCheckboxEventCallback = wxEvtHandlerBindCheckboxEventCallbackPtr.asFunction<WxEvtHandlerBindCheckboxEventCallback>();

  final wxEvtHandlerUnbindCheckboxEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindCheckboxEventCallbackNative>>('wxEvtHandlerUnbindCheckboxEventCallback');
  wxEvtHandlerUnbindCheckboxEventCallback = wxEvtHandlerUnbindCheckboxEventCallbackPtr.asFunction<WxEvtHandlerUnbindCheckboxEventCallback>();

  // ------------------------- EVT_CHOICE ----------------------

  final wxGetChoiceEventTypePtr = dylib.lookup <NativeFunction<_WxGetChoiceEventTypeNative>>('wxGetChoiceEventType');
  wxGetChoiceEventType = wxGetChoiceEventTypePtr.asFunction<WxGetChoiceEventType>();

  final wxEvtHandlerBindChoiceEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindChoiceEventCallbackNative>>('wxEvtHandlerBindChoiceEventCallback');
  wxEvtHandlerBindChoiceEventCallback = wxEvtHandlerBindChoiceEventCallbackPtr.asFunction<WxEvtHandlerBindChoiceEventCallback>();

  final wxEvtHandlerUnbindChoiceEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindChoiceEventCallbackNative>>('wxEvtHandlerUnbindChoiceEventCallback');
  wxEvtHandlerUnbindChoiceEventCallback = wxEvtHandlerUnbindChoiceEventCallbackPtr.asFunction<WxEvtHandlerUnbindChoiceEventCallback>();

  // ------------------------- EVT_LISTBOX ----------------------

  final wxGetListboxEventTypePtr = dylib.lookup <NativeFunction<_WxGetListboxEventTypeNative>>('wxGetListboxEventType');
  wxGetListboxEventType = wxGetListboxEventTypePtr.asFunction<WxGetListboxEventType>();

  final wxEvtHandlerBindListboxEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindListboxEventCallbackNative>>('wxEvtHandlerBindListboxEventCallback');
  wxEvtHandlerBindListboxEventCallback = wxEvtHandlerBindListboxEventCallbackPtr.asFunction<WxEvtHandlerBindListboxEventCallback>();

  final wxEvtHandlerUnbindListboxEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindListboxEventCallbackNative>>('wxEvtHandlerUnbindListboxEventCallback');
  wxEvtHandlerUnbindListboxEventCallback = wxEvtHandlerUnbindListboxEventCallbackPtr.asFunction<WxEvtHandlerUnbindListboxEventCallback>();

  // ------------------------- EVT_LISTBOX_DCLICK ----------------------

  final wxGetListboxDClickEventTypePtr = dylib.lookup <NativeFunction<_WxGetListboxDClickEventTypeNative>>('wxGetListboxDClickEventType');
  wxGetListboxDClickEventType = wxGetListboxDClickEventTypePtr.asFunction<WxGetListboxDClickEventType>();

  final wxEvtHandlerBindListboxDClickEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindListboxDClickEventCallbackNative>>('wxEvtHandlerBindListboxDClickEventCallback');
  wxEvtHandlerBindListboxDClickEventCallback = wxEvtHandlerBindListboxDClickEventCallbackPtr.asFunction<WxEvtHandlerBindListboxDClickEventCallback>();

  final wxEvtHandlerUnbindListboxDClickEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindListboxDClickEventCallbackNative>>('wxEvtHandlerUnbindListboxDClickEventCallback');
  wxEvtHandlerUnbindListboxDClickEventCallback = wxEvtHandlerUnbindListboxDClickEventCallbackPtr.asFunction<WxEvtHandlerUnbindListboxDClickEventCallback>();

  // ------------------------- EVT_RADIOBOX ----------------------

  final wxGetRadioboxEventTypePtr = dylib.lookup <NativeFunction<_WxGetRadioboxEventTypeNative>>('wxGetRadioboxEventType');
  wxGetRadioboxEventType = wxGetRadioboxEventTypePtr.asFunction<WxGetRadioboxEventType>();

  final wxEvtHandlerBindRadioboxEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindRadioboxEventCallbackNative>>('wxEvtHandlerBindRadioboxEventCallback');
  wxEvtHandlerBindRadioboxEventCallback = wxEvtHandlerBindRadioboxEventCallbackPtr.asFunction<WxEvtHandlerBindRadioboxEventCallback>();

  final wxEvtHandlerUnbindRadioboxEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindRadioboxEventCallbackNative>>('wxEvtHandlerUnbindRadioboxEventCallback');
  wxEvtHandlerUnbindRadioboxEventCallback = wxEvtHandlerUnbindRadioboxEventCallbackPtr.asFunction<WxEvtHandlerUnbindRadioboxEventCallback>();

  // ------------------------- EVT_RADIOBUTTON ----------------------

  final wxGetRadioButtonEventTypePtr = dylib.lookup <NativeFunction<_WxGetRadioButtonEventTypeNative>>('wxGetRadioButtonEventType');
  wxGetRadioButtonEventType = wxGetRadioButtonEventTypePtr.asFunction<WxGetRadioButtonEventType>();

  final wxEvtHandlerBindRadioButtonEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindRadioButtonEventCallbackNative>>('wxEvtHandlerBindRadioButtonEventCallback');
  wxEvtHandlerBindRadioButtonEventCallback = wxEvtHandlerBindRadioButtonEventCallbackPtr.asFunction<WxEvtHandlerBindRadioButtonEventCallback>();

  final wxEvtHandlerUnbindRadioButtonEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindRadioButtonEventCallbackNative>>('wxEvtHandlerUnbindRadioButtonEventCallback');
  wxEvtHandlerUnbindRadioButtonEventCallback = wxEvtHandlerUnbindRadioButtonEventCallbackPtr.asFunction<WxEvtHandlerUnbindRadioButtonEventCallback>();

  // ------------------------- EVT_TOGGLEBUTTON ----------------------

  final wxGetToggleButtonEventTypePtr = dylib.lookup <NativeFunction<_WxGetToggleButtonEventTypeNative>>('wxGetToggleButtonEventType');
  wxGetToggleButtonEventType = wxGetToggleButtonEventTypePtr.asFunction<WxGetToggleButtonEventType>();

  final wxEvtHandlerBindToggleButtonEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindToggleButtonEventCallbackNative>>('wxEvtHandlerBindToggleButtonEventCallback');
  wxEvtHandlerBindToggleButtonEventCallback = wxEvtHandlerBindToggleButtonEventCallbackPtr.asFunction<WxEvtHandlerBindToggleButtonEventCallback>();

  final wxEvtHandlerUnbindToggleButtonEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindToggleButtonEventCallbackNative>>('wxEvtHandlerUnbindToggleButtonEventCallback');
  wxEvtHandlerUnbindToggleButtonEventCallback = wxEvtHandlerUnbindToggleButtonEventCallbackPtr.asFunction<WxEvtHandlerUnbindToggleButtonEventCallback>();

  // ------------------------- EVT_SLIDER ----------------------

  final wxGetSliderEventTypePtr = dylib.lookup <NativeFunction<_WxGetSliderEventTypeNative>>('wxGetSliderEventType');
  wxGetSliderEventType = wxGetSliderEventTypePtr.asFunction<WxGetSliderEventType>();

  final wxEvtHandlerBindSliderEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindSliderEventCallbackNative>>('wxEvtHandlerBindSliderEventCallback');
  wxEvtHandlerBindSliderEventCallback = wxEvtHandlerBindSliderEventCallbackPtr.asFunction<WxEvtHandlerBindSliderEventCallback>();

  final wxEvtHandlerUnbindSliderEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindSliderEventCallbackNative>>('wxEvtHandlerUnbindSliderEventCallback');
  wxEvtHandlerUnbindSliderEventCallback = wxEvtHandlerUnbindSliderEventCallbackPtr.asFunction<WxEvtHandlerUnbindSliderEventCallback>();

  // ------------------------- EVT_SPIN ----------------------

  final wxGetSpinEventTypePtr = dylib.lookup <NativeFunction<_WxGetSpinEventTypeNative>>('wxGetSpinEventType');
  wxGetSpinEventType = wxGetSpinEventTypePtr.asFunction<WxGetSpinEventType>();

  final wxEvtHandlerBindSpinEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindSpinEventCallbackNative>>('wxEvtHandlerBindSpinEventCallback');
  wxEvtHandlerBindSpinEventCallback = wxEvtHandlerBindSpinEventCallbackPtr.asFunction<WxEvtHandlerBindSpinEventCallback>();

  final wxEvtHandlerUnbindSpinEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindSpinEventCallbackNative>>('wxEvtHandlerUnbindSpinEventCallback');
  wxEvtHandlerUnbindSpinEventCallback = wxEvtHandlerUnbindSpinEventCallbackPtr.asFunction<WxEvtHandlerUnbindSpinEventCallback>();

  // ------------------------- EVT_SPIN_UP ----------------------

  final wxGetSpinUpEventTypePtr = dylib.lookup <NativeFunction<_WxGetSpinUpEventTypeNative>>('wxGetSpinUpEventType');
  wxGetSpinUpEventType = wxGetSpinUpEventTypePtr.asFunction<WxGetSpinUpEventType>();

  final wxEvtHandlerBindSpinUpEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindSpinUpEventCallbackNative>>('wxEvtHandlerBindSpinUpEventCallback');
  wxEvtHandlerBindSpinUpEventCallback = wxEvtHandlerBindSpinUpEventCallbackPtr.asFunction<WxEvtHandlerBindSpinUpEventCallback>();

  final wxEvtHandlerUnbindSpinUpEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindSpinUpEventCallbackNative>>('wxEvtHandlerUnbindSpinUpEventCallback');
  wxEvtHandlerUnbindSpinUpEventCallback = wxEvtHandlerUnbindSpinUpEventCallbackPtr.asFunction<WxEvtHandlerUnbindSpinUpEventCallback>();

  // ------------------------- EVT_SPIN_DOWN ----------------------

  final wxGetSpinDownEventTypePtr = dylib.lookup <NativeFunction<_WxGetSpinDownEventTypeNative>>('wxGetSpinDownEventType');
  wxGetSpinDownEventType = wxGetSpinDownEventTypePtr.asFunction<WxGetSpinDownEventType>();

  final wxEvtHandlerBindSpinDownEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindSpinDownEventCallbackNative>>('wxEvtHandlerBindSpinDownEventCallback');
  wxEvtHandlerBindSpinDownEventCallback = wxEvtHandlerBindSpinDownEventCallbackPtr.asFunction<WxEvtHandlerBindSpinDownEventCallback>();

  final wxEvtHandlerUnbindSpinDownEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindSpinDownEventCallbackNative>>('wxEvtHandlerUnbindSpinDownEventCallback');
  wxEvtHandlerUnbindSpinDownEventCallback = wxEvtHandlerUnbindSpinDownEventCallbackPtr.asFunction<WxEvtHandlerUnbindSpinDownEventCallback>();

  // ------------------------- EVT_SPINCTRL ----------------------

  final wxGetSpinCtrlEventTypePtr = dylib.lookup <NativeFunction<_WxGetSpinCtrlEventTypeNative>>('wxGetSpinCtrlEventType');
  wxGetSpinCtrlEventType = wxGetSpinCtrlEventTypePtr.asFunction<WxGetSpinCtrlEventType>();

  final wxEvtHandlerBindSpinCtrlEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindSpinCtrlEventCallbackNative>>('wxEvtHandlerBindSpinCtrlEventCallback');
  wxEvtHandlerBindSpinCtrlEventCallback = wxEvtHandlerBindSpinCtrlEventCallbackPtr.asFunction<WxEvtHandlerBindSpinCtrlEventCallback>();

  final wxEvtHandlerUnbindSpinCtrlEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindSpinCtrlEventCallbackNative>>('wxEvtHandlerUnbindSpinCtrlEventCallback');
  wxEvtHandlerUnbindSpinCtrlEventCallback = wxEvtHandlerUnbindSpinCtrlEventCallbackPtr.asFunction<WxEvtHandlerUnbindSpinCtrlEventCallback>();

  // ------------------------- EVT_SPINCTRLDOUBLE ----------------------

  final wxGetSpinCtrlDoubleEventTypePtr = dylib.lookup <NativeFunction<_WxGetSpinCtrlDoubleEventTypeNative>>('wxGetSpinCtrlDoubleEventType');
  wxGetSpinCtrlDoubleEventType = wxGetSpinCtrlDoubleEventTypePtr.asFunction<WxGetSpinCtrlDoubleEventType>();

  final wxEvtHandlerBindSpinCtrlDoubleEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindSpinCtrlDoubleEventCallbackNative>>('wxEvtHandlerBindSpinCtrlDoubleEventCallback');
  wxEvtHandlerBindSpinCtrlDoubleEventCallback = wxEvtHandlerBindSpinCtrlDoubleEventCallbackPtr.asFunction<WxEvtHandlerBindSpinCtrlDoubleEventCallback>();

  final wxEvtHandlerUnbindSpinCtrlDoubleEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindSpinCtrlDoubleEventCallbackNative>>('wxEvtHandlerUnbindSpinCtrlDoubleEventCallback');
  wxEvtHandlerUnbindSpinCtrlDoubleEventCallback = wxEvtHandlerUnbindSpinCtrlDoubleEventCallbackPtr.asFunction<WxEvtHandlerUnbindSpinCtrlDoubleEventCallback>();

  // ------------------------- EVT_HYPERLINK ----------------------

  final wxGetHyperlinkEventTypePtr = dylib.lookup <NativeFunction<_WxGetHyperlinkEventTypeNative>>('wxGetHyperlinkEventType');
  wxGetHyperlinkEventType = wxGetHyperlinkEventTypePtr.asFunction<WxGetHyperlinkEventType>();

  final wxEvtHandlerBindHyperlinkEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindHyperlinkEventCallbackNative>>('wxEvtHandlerBindHyperlinkEventCallback');
  wxEvtHandlerBindHyperlinkEventCallback = wxEvtHandlerBindHyperlinkEventCallbackPtr.asFunction<WxEvtHandlerBindHyperlinkEventCallback>();

  final wxEvtHandlerUnbindHyperlinkEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindHyperlinkEventCallbackNative>>('wxEvtHandlerUnbindHyperlinkEventCallback');
  wxEvtHandlerUnbindHyperlinkEventCallback = wxEvtHandlerUnbindHyperlinkEventCallbackPtr.asFunction<WxEvtHandlerUnbindHyperlinkEventCallback>();

}

void releaseWxControls()
{
  wxHyperlinkEventNativeCallable.close();
  wxSpinEventNativeCallable.close();
  wxSpinDoubleEventNativeCallable.close();
}
