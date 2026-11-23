// -------------------------------------------------------------
// Purpose:     Dart bindings for wxWidgets
// Author:      Robert Roebling
// Modified by: The magic C++ to Dart code generator
// Created:     07/01/2025
// Copyright:   (c) Robert Roebling
// Licence:     wxWindows licence 3.1
// -------------------------------------------------------------

part of '../wx_dart.dart';

// ------------------------- wxDataFormat ----------------------

typedef _WxDataFormatConstructorNative = Pointer Function( Int32  );
typedef _WxDataFormatConstructor = Pointer Function( int  );
late _WxDataFormatConstructor _wxDataFormatConstructor;

typedef _WxDataFormatGetIdNative = Pointer<Utf8> Function( Pointer  );
typedef _WxDataFormatGetId = Pointer<Utf8> Function( Pointer  );
late _WxDataFormatGetId _wxDataFormatGetId;

typedef _WxDataFormatGetTypeNative = Int32 Function( Pointer  );
typedef _WxDataFormatGetType = int Function( Pointer  );
late _WxDataFormatGetType _wxDataFormatGetType;

class WxDataFormat extends WxClass {
  WxDataFormat( int id ) : super._defaultConstructor() {
    nativeHandle = _wxDataFormatConstructor( id );
    attachFinalizer();
  }
  WxDataFormat.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  String getId( ) {
    Pointer<Utf8> ptrReturn = _wxDataFormatGetId( nativeHandle  );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }

  int getType( ) {
    return _wxDataFormatGetType( nativeHandle  );
  }
}

// ------------------------- wxDataFormatArray ----------------------

typedef _WxDataFormatArrayConstructorNative = Pointer Function( Pointer, Int32  );
typedef _WxDataFormatArrayConstructor = Pointer Function( Pointer, int  );
late _WxDataFormatArrayConstructor _wxDataFormatArrayConstructor;

typedef _WxDataFormatArrayGetCountNative = Int32 Function( Pointer  );
typedef _WxDataFormatArrayGetCount = int Function( Pointer  );
late _WxDataFormatArrayGetCount _wxDataFormatArrayGetCount;

typedef _WxDataFormatArrayGetFormatNative = Pointer Function( Pointer, Int32  );
typedef _WxDataFormatArrayGetFormat = Pointer Function( Pointer, int  );
late _WxDataFormatArrayGetFormat _wxDataFormatArrayGetFormat;

class WxDataFormatArray extends WxClass {
  WxDataFormatArray( WxDataObject object, int direction ) : super._defaultConstructor() {
    nativeHandle = _wxDataFormatArrayConstructor( object.nativeHandle, direction );
    attachFinalizer();
  }
  WxDataFormatArray.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  int getCount( ) {
    return _wxDataFormatArrayGetCount( nativeHandle  );
  }

  WxDataFormat getFormat( int index ) {
    final returnedNativeHandle = _wxDataFormatArrayGetFormat( nativeHandle, index );
    return WxDataFormat.fromHandle( returnedNativeHandle );
  }
}

// ------------------------- wxDataObject ----------------------

typedef _WxDataObject_getDataSizeNative = Int32 Function( Pointer, Pointer  );
typedef _WxDataObject_getDataSize = int Function( Pointer, Pointer  );
late _WxDataObject_getDataSize _wxDataObject_getDataSize;

typedef _WxDataObject_getDataHereNative = Bool Function( Pointer, Pointer, Pointer  );
typedef _WxDataObject_getDataHere = bool Function( Pointer, Pointer, Pointer  );
late _WxDataObject_getDataHere _wxDataObject_getDataHere;

typedef _WxDataObject_setDataNative = Bool Function( Pointer, Pointer, Int32, Pointer  );
typedef _WxDataObject_setData = bool Function( Pointer, Pointer, int, Pointer  );
late _WxDataObject_setData _wxDataObject_setData;

typedef _WxDataObjectIsSupportedNative = Bool Function( Pointer, Pointer, Int32  );
typedef _WxDataObjectIsSupported = bool Function( Pointer, Pointer, int  );
late _WxDataObjectIsSupported _wxDataObjectIsSupported;

/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxDATAOBJECT_DIR_GET | 0 |
/// | wxDATAOBJECT_DIR_SET | 1 |
/// | wxDATAOBJECT_DIR_BOTH | 2 |

const int wxDATAOBJECT_DIR_GET = 0;
const int wxDATAOBJECT_DIR_SET = 1;
const int wxDATAOBJECT_DIR_BOTH = 2;

class WxDataObject extends WxClass {
  WxDataObject._defaultConstructor() : super._defaultConstructor();
  WxDataObject.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }
  List<WxDataFormat> getFormats( { int direction = wxDATAOBJECT_DIR_GET } ) {
    final array = WxDataFormatArray( this, direction );
    final List<WxDataFormat> res = [];
    for (int i = 0; i < array.getCount(); i++) {
      res.add( array.getFormat(i) );
    }
    return res;
  }

  Uint8List? getData( WxDataFormat format )
  {
    final size = _getDataSize( format );
    if (size < 1) return null;
    final Pointer<Uint8> ptr = calloc<Uint8>(size);
    if (!_getDataHere(format,ptr)) {
      wxLogError( "Could not retrieve data from wxDataObject" );
      calloc.free(ptr);
      return null;
    }
    final cdata = ptr.asTypedList(size);
    final data = Uint8List.fromList(cdata);
    calloc.free(ptr);
    return data;
  }

  bool setData( WxDataFormat format, Uint8List data )
  {
    final size = data.buffer.lengthInBytes;
    final Pointer<Uint8> ptr = calloc<Uint8>(size);
    ptr.asTypedList(size).setAll(0, List<int>.from(data));
    final res = _setData( format, size, ptr );
    calloc.free(ptr);
    return res;
  }

  int _getDataSize( WxDataFormat format ) {
    return _wxDataObject_getDataSize( nativeHandle, format.nativeHandle );
  }

  bool _getDataHere( WxDataFormat format, Pointer dataPtr ) {
    return _wxDataObject_getDataHere( nativeHandle, format.nativeHandle, dataPtr );
  }

  bool _setData( WxDataFormat format, int size, Pointer dataPtr ) {
    return _wxDataObject_setData( nativeHandle, format.nativeHandle, size, dataPtr );
  }

  bool isSupported( WxDataFormat format, { int direction = wxDATAOBJECT_DIR_GET } ) {
    return _wxDataObjectIsSupported( nativeHandle, format.nativeHandle, direction );
  }
}

// ------------------------- wxTextDataObject ----------------------

typedef _WxTextDataObjectConstructorNative = Pointer Function( Pointer<Utf8>  );
typedef _WxTextDataObjectConstructor = Pointer Function( Pointer<Utf8>  );
late _WxTextDataObjectConstructor _wxTextDataObjectConstructor;

typedef _WxTextDataObjectSetTextNative = Void Function( Pointer, Pointer<Utf8>  );
typedef _WxTextDataObjectSetText = void Function( Pointer, Pointer<Utf8>  );
late _WxTextDataObjectSetText _wxTextDataObjectSetText;

typedef _WxTextDataObjectGetTextNative = Pointer<Utf8> Function( Pointer  );
typedef _WxTextDataObjectGetText = Pointer<Utf8> Function( Pointer  );
late _WxTextDataObjectGetText _wxTextDataObjectGetText;

class WxTextDataObject extends WxDataObject {
  WxTextDataObject( String text ) : super._defaultConstructor() {
    final textUtf8 = text.toNativeUtf8();
    nativeHandle = _wxTextDataObjectConstructor( textUtf8 );
    malloc.free( textUtf8 );
    attachFinalizer();
  }
  WxTextDataObject.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  void setText( String text ) {
    final textUtf8 = text.toNativeUtf8();
    _wxTextDataObjectSetText( nativeHandle, textUtf8 );
    malloc.free( textUtf8 );
  }

  String getText( ) {
    Pointer<Utf8> ptrReturn = _wxTextDataObjectGetText( nativeHandle  );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }
}

// ------------------------- wxFileDataObject ----------------------

typedef _WxFileDataObjectConstructorNative = Pointer Function(  );
typedef _WxFileDataObjectConstructor = Pointer Function(  );
late _WxFileDataObjectConstructor _wxFileDataObjectConstructor;

typedef _WxFileDataObjectAddFileNative = Void Function( Pointer, Pointer<Utf8>  );
typedef _WxFileDataObjectAddFile = void Function( Pointer, Pointer<Utf8>  );
late _WxFileDataObjectAddFile _wxFileDataObjectAddFile;

typedef _WxFileDataObjectGetFilenamesNative = Pointer<Utf8> Function( Pointer  );
typedef _WxFileDataObjectGetFilenames = Pointer<Utf8> Function( Pointer  );
late _WxFileDataObjectGetFilenames _wxFileDataObjectGetFilenames;

class WxFileDataObject extends WxDataObject {
  WxFileDataObject( ) : super._defaultConstructor() {
    nativeHandle = _wxFileDataObjectConstructor(  );
    attachFinalizer();
  }
  WxFileDataObject.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  void addFile( String file ) {
    final fileUtf8 = file.toNativeUtf8();
    _wxFileDataObjectAddFile( nativeHandle, fileUtf8 );
    malloc.free( fileUtf8 );
  }

  List<String> getFilenames( ) {
    Pointer<Utf8> ptrReturn = _wxFileDataObjectGetFilenames( nativeHandle  );
    final List dynValues = jsonDecode(ptrReturn.toDartString());
    malloc.free( ptrReturn );
    final List<String> values = [];
    for ( final value in dynValues) { values.add( value as String ); }
    return values;
  }
}

// ------------------------- wxBitmapDataObject ----------------------

typedef _WxBitmapDataObjectConstructorNative = Pointer Function( Pointer  );
typedef _WxBitmapDataObjectConstructor = Pointer Function( Pointer  );
late _WxBitmapDataObjectConstructor _wxBitmapDataObjectConstructor;

typedef _WxBitmapDataObjectSetBitmapNative = Void Function( Pointer, Pointer  );
typedef _WxBitmapDataObjectSetBitmap = void Function( Pointer, Pointer  );
late _WxBitmapDataObjectSetBitmap _wxBitmapDataObjectSetBitmap;

typedef _WxBitmapDataObjectGetBitmapNative = Pointer Function( Pointer  );
typedef _WxBitmapDataObjectGetBitmap = Pointer Function( Pointer  );
late _WxBitmapDataObjectGetBitmap _wxBitmapDataObjectGetBitmap;

class WxBitmapDataObject extends WxDataObject {
  WxBitmapDataObject( WxBitmap bitmap ) : super._defaultConstructor() {
    nativeHandle = _wxBitmapDataObjectConstructor( bitmap.nativeHandle );
    attachFinalizer();
  }
  WxBitmapDataObject.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  void setBitmap( WxBitmap bitmap ) {
    _wxBitmapDataObjectSetBitmap( nativeHandle, bitmap.nativeHandle );
  }

  WxBitmap? getBitmap( ) {
    final returnedNativeHandle = _wxBitmapDataObjectGetBitmap( nativeHandle  );
    if (returnedNativeHandle == nullptr) return null;
    return WxBitmap.fromHandle( returnedNativeHandle );
  }
}

// ------------------------- wxDropSource ----------------------

typedef _WxDropSourceConstructorNative = Pointer Function( Pointer, Pointer  );
typedef _WxDropSourceConstructor = Pointer Function( Pointer, Pointer  );
late _WxDropSourceConstructor _wxDropSourceConstructor;

typedef _WxDropSource_doDragDropSyncNative = Int32 Function( Pointer, Int32  );
typedef _WxDropSource_doDragDropSync = int Function( Pointer, int  );
late _WxDropSource_doDragDropSync _wxDropSource_doDragDropSync;

/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxDRAG_COPY_ONLY | 0 |
/// | wxDRAG_ALLOW_MOVE | 1 |
/// | wxDRAG_DEFAULT_MOVE | 3 |
/// | wxDRAG_RESULT_ERROR | 0 |
/// | wxDRAG_RESULT_NONE | 1 |
/// | wxDRAG_RESULT_COPY | 2 |
/// | wxDRAG_RESULT_MOVE | 3 |
/// | wxDRAG_RESULT_LINK | 4 |
/// | wxDRAG_RESULT_CANCEL | 5 |

const int wxDRAG_COPY_ONLY = 0;
const int wxDRAG_ALLOW_MOVE = 1;
const int wxDRAG_DEFAULT_MOVE = 3;
const int wxDRAG_RESULT_ERROR = 0;
const int wxDRAG_RESULT_NONE = 1;
const int wxDRAG_RESULT_COPY = 2;
const int wxDRAG_RESULT_MOVE = 3;
const int wxDRAG_RESULT_LINK = 4;
const int wxDRAG_RESULT_CANCEL = 5;

class WxDropSource extends WxClass {
  WxDropSource( WxDataObject data, WxWindow win ) : super._defaultConstructor() {
    nativeHandle = _wxDropSourceConstructor( data.nativeHandle, win.nativeHandle );
    attachFinalizer();
  }
  WxDropSource.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }
  void doDragDrop( { int flags = 0, void Function( int result )? onDone } )
  {
    int result = _doDragDropSync( flags: flags );
    if (onDone != null) {
      onDone( result );
    }
  }
  
  int _doDragDropSync( { int flags = 0 } ) {
    return _wxDropSource_doDragDropSync( nativeHandle, flags );
  }
}

// ------------------------- wxDropTarget ----------------------

typedef _WxDropTargetConstructorNative = Pointer Function( Pointer  );
typedef _WxDropTargetConstructor = Pointer Function( Pointer  );
late _WxDropTargetConstructor _wxDropTargetConstructor;

typedef _WxDropTargetGetDataNative = Bool Function( Pointer  );
typedef _WxDropTargetGetData = bool Function( Pointer  );
late _WxDropTargetGetData _wxDropTargetGetData;

typedef _WxDropTargetSetDefaultActionNative = Void Function( Pointer, Int32  );
typedef _WxDropTargetSetDefaultAction = void Function( Pointer, int  );
late _WxDropTargetSetDefaultAction _wxDropTargetSetDefaultAction;

class WxDropTarget extends WxClass {
  WxDropTarget( WxDataObject data ) : super._defaultConstructor() {
    nativeHandle = _wxDropTargetConstructor( data.nativeHandle );
    attachFinalizer();
  }
  WxDropTarget.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  bool getData( ) {
    return _wxDropTargetGetData( nativeHandle  );
  }

  void setDefaultAction( int action ) {
    _wxDropTargetSetDefaultAction( nativeHandle, action );
  }
}

// ------------------------- wxSystemSettings ----------------------

typedef _WxSystemSettingsGetColourNative = Uint32 Function( Pointer, Int32  );
typedef _WxSystemSettingsGetColour = int Function( Pointer, int  );
late _WxSystemSettingsGetColour _wxSystemSettingsGetColour;

typedef _WxSystemSettingsGetFontNative = Pointer Function( Pointer, Int32  );
typedef _WxSystemSettingsGetFont = Pointer Function( Pointer, int  );
late _WxSystemSettingsGetFont _wxSystemSettingsGetFont;

typedef _WxSystemSettingsGetMetricNative = Int32 Function( Pointer, Int32  );
typedef _WxSystemSettingsGetMetric = int Function( Pointer, int  );
late _WxSystemSettingsGetMetric _wxSystemSettingsGetMetric;

typedef _WxSystemSettingsSelectLightDarkNative = Uint32 Function( Pointer, Uint32, Uint32  );
typedef _WxSystemSettingsSelectLightDark = int Function( Pointer, int, int  );
late _WxSystemSettingsSelectLightDark _wxSystemSettingsSelectLightDark;

/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxSYS_DEFAULT_GUI_FONT | 17 |
/// | wxSYS_COLOUR_WINDOW | 5 |
/// | wxSYS_COLOUR_WINDOWTEXT | 8 |
/// | wxSYS_COLOUR_HIGHLIGHT | 13 |
/// | wxSYS_COLOUR_HIGHLIGHTTEXT | 14 |
/// | wxSYS_COLOUR_BTNTEXT | 18 |
/// | wxSYS_COLOUR_LISTBOX | 25 |
/// | wxSYS_COLOUR_LISTBOXTEXT | 31 |
/// | wxSYS_COLOUR_LISTBOXHIGHLIGHTTEXT | 32 |
/// | wxSYS_COLOUR_LISTBOXHIGHLIGHT | 34 |
/// | wxSYS_COLOUR_GRIDLINES | 33 |
/// | wxSYS_MOUSE_BUTTONS | 1 |
/// | wxSYS_SCREEN_X | 21 |
/// | wxSYS_SCREEN_Y | 22 |

const int wxSYS_DEFAULT_GUI_FONT = 17;
const int wxSYS_COLOUR_WINDOW = 5;
const int wxSYS_COLOUR_WINDOWTEXT = 8;
const int wxSYS_COLOUR_HIGHLIGHT = 13;
const int wxSYS_COLOUR_HIGHLIGHTTEXT = 14;
const int wxSYS_COLOUR_BTNTEXT = 18;
const int wxSYS_COLOUR_LISTBOX = 25;
const int wxSYS_COLOUR_LISTBOXTEXT = 31;
const int wxSYS_COLOUR_LISTBOXHIGHLIGHTTEXT = 32;
const int wxSYS_COLOUR_LISTBOXHIGHLIGHT = 34;
const int wxSYS_COLOUR_GRIDLINES = 33;
const int wxSYS_MOUSE_BUTTONS = 1;
const int wxSYS_SCREEN_X = 21;
const int wxSYS_SCREEN_Y = 22;

class WxSystemSettings extends WxClass {
  WxSystemSettings.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  WxColour getColour( int colour ) {
    final int rgba = _wxSystemSettingsGetColour( nativeHandle, colour );
    return WxColour.fromRGBA( rgba );
  }

  WxFont getFont( { int font = wxSYS_DEFAULT_GUI_FONT } ) {
    final returnedNativeHandle = _wxSystemSettingsGetFont( nativeHandle, font );
    return WxFont.fromHandle( returnedNativeHandle );
  }

  int getMetric( int metric ) {
    return _wxSystemSettingsGetMetric( nativeHandle, metric );
  }

  WxColour selectLightDark( WxColour colForLight, WxColour colForDark ) {
    final int rgba = _wxSystemSettingsSelectLightDark( nativeHandle, colForLight.getRGBA(), colForDark.getRGBA() );
    return WxColour.fromRGBA( rgba );
  }
}

// ------------------------- wxStandardPaths ----------------------

typedef _WxStandardPathsGetExecutablePathNative = Pointer<Utf8> Function( Pointer  );
typedef _WxStandardPathsGetExecutablePath = Pointer<Utf8> Function( Pointer  );
late _WxStandardPathsGetExecutablePath _wxStandardPathsGetExecutablePath;

typedef _WxStandardPaths_getResourcesDirNative = Pointer<Utf8> Function( Pointer  );
typedef _WxStandardPaths_getResourcesDir = Pointer<Utf8> Function( Pointer  );
late _WxStandardPaths_getResourcesDir _wxStandardPaths_getResourcesDir;

typedef _WxStandardPathsGetConfigDirNative = Pointer<Utf8> Function( Pointer  );
typedef _WxStandardPathsGetConfigDir = Pointer<Utf8> Function( Pointer  );
late _WxStandardPathsGetConfigDir _wxStandardPathsGetConfigDir;

typedef _WxStandardPathsGetDocumentsDirNative = Pointer<Utf8> Function( Pointer  );
typedef _WxStandardPathsGetDocumentsDir = Pointer<Utf8> Function( Pointer  );
late _WxStandardPathsGetDocumentsDir _wxStandardPathsGetDocumentsDir;

typedef _WxStandardPathsGetTempDirNative = Pointer<Utf8> Function( Pointer  );
typedef _WxStandardPathsGetTempDir = Pointer<Utf8> Function( Pointer  );
late _WxStandardPathsGetTempDir _wxStandardPathsGetTempDir;

class WxStandardPaths extends WxClass {
  WxStandardPaths.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  String getResourcesDir( { bool useInstalledDirectory = false } )
  {
    if (!useInstalledDirectory)
    {
      String path = getExecutablePath();
      if (wxIsLinux()) {
        path = path.substring(0, path.lastIndexOf("/")+1 );
        path += "data/flutter_assets/lib/";
      } else 
      if (wxIsMac()) {
        path = path.substring(0, path.lastIndexOf("/")+1 ); // clip off exe filename
        path = path.substring(0, path.length-6 ); // clip off MacOS
        path += "Frameworks/App.framework/Resources/flutter_assets/lib/";
      } else 
      if (wxIsMSW()) {
        path = path.substring(0, path.lastIndexOf("\\")+1 );
        path += "data\\flutter_assets\\lib\\";
      } else {
        wxLogError( "no platform" );
      }
      return "${path}assets";
    }
    return _getResourcesDir();
  }

  String getExecutablePath( ) {
    Pointer<Utf8> ptrReturn = _wxStandardPathsGetExecutablePath( nativeHandle  );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }

  String _getResourcesDir( ) {
    Pointer<Utf8> ptrReturn = _wxStandardPaths_getResourcesDir( nativeHandle  );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }

  String getConfigDir( ) {
    Pointer<Utf8> ptrReturn = _wxStandardPathsGetConfigDir( nativeHandle  );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }

  String getDocumentsDir( ) {
    Pointer<Utf8> ptrReturn = _wxStandardPathsGetDocumentsDir( nativeHandle  );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }

  String getTempDir( ) {
    Pointer<Utf8> ptrReturn = _wxStandardPathsGetTempDir( nativeHandle  );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }
}

// ------------------------- wxNativeTimer ----------------------

typedef _WxNativeTimerConstructorNative = Pointer Function(  );
typedef _WxNativeTimerConstructor = Pointer Function(  );
late _WxNativeTimerConstructor _wxNativeTimerConstructor;

typedef _WxNativeTimerConstructorWithOwnerNative = Pointer Function( Pointer, Int32  );
typedef _WxNativeTimerConstructorWithOwner = Pointer Function( Pointer, int  );
late _WxNativeTimerConstructorWithOwner _wxNativeTimerConstructorWithOwner;
typedef _WxNativeTimerSetOwnerNative = Void Function( Pointer, Pointer  );
typedef _WxNativeTimerSetOwner = void Function( Pointer, Pointer  );
late _WxNativeTimerSetOwner _wxNativeTimerSetOwner;

typedef _WxNativeTimerGetIdNative = Int32 Function( Pointer  );
typedef _WxNativeTimerGetId = int Function( Pointer  );
late _WxNativeTimerGetId _wxNativeTimerGetId;

typedef _WxNativeTimerGetIntervalNative = Int32 Function( Pointer  );
typedef _WxNativeTimerGetInterval = int Function( Pointer  );
late _WxNativeTimerGetInterval _wxNativeTimerGetInterval;

typedef _WxNativeTimerIsOneShotNative = Bool Function( Pointer  );
typedef _WxNativeTimerIsOneShot = bool Function( Pointer  );
late _WxNativeTimerIsOneShot _wxNativeTimerIsOneShot;

typedef _WxNativeTimerIsRunningNative = Bool Function( Pointer  );
typedef _WxNativeTimerIsRunning = bool Function( Pointer  );
late _WxNativeTimerIsRunning _wxNativeTimerIsRunning;

typedef _WxNativeTimerStartNative = Bool Function( Pointer, Int32, Bool  );
typedef _WxNativeTimerStart = bool Function( Pointer, int, bool  );
late _WxNativeTimerStart _wxNativeTimerStart;

typedef _WxNativeTimerStartOnceNative = Void Function( Pointer, Int32  );
typedef _WxNativeTimerStartOnce = void Function( Pointer, int  );
late _WxNativeTimerStartOnce _wxNativeTimerStartOnce;

typedef _WxNativeTimerStopNative = Void Function( Pointer  );
typedef _WxNativeTimerStop = void Function( Pointer  );
late _WxNativeTimerStop _wxNativeTimerStop;

class WxNativeTimer extends WxEvtHandler {
  WxNativeTimer( ) : super._defaultConstructor() {
    nativeHandle = _wxNativeTimerConstructor(  );
  }
  WxNativeTimer.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }
  WxNativeTimer.withOwner( WxEvtHandler owner, { int id = -1 } ) : super._defaultConstructor() {
    nativeHandle = _wxNativeTimerConstructorWithOwner( owner.nativeHandle, id );
  }

  void setOwner( WxEvtHandler owner ) {
    _wxNativeTimerSetOwner( nativeHandle, owner.nativeHandle );
  }

  int getId( ) {
    return _wxNativeTimerGetId( nativeHandle  );
  }

  int getInterval( ) {
    return _wxNativeTimerGetInterval( nativeHandle  );
  }

  bool isOneShot( ) {
    return _wxNativeTimerIsOneShot( nativeHandle  );
  }

  bool isRunning( ) {
    return _wxNativeTimerIsRunning( nativeHandle  );
  }

  bool start( { int milliseconds = -1, bool oneshot = false } ) {
    return _wxNativeTimerStart( nativeHandle, milliseconds, oneshot );
  }

  void startOnce( { int milliseconds = -1 } ) {
    _wxNativeTimerStartOnce( nativeHandle, milliseconds );
  }

  void stop( ) {
    _wxNativeTimerStop( nativeHandle  );
  }
}


void setupWxMisc( DynamicLibrary dylib )
{
  // ------------------------- wxDataFormat ----------------------

  final wxDataFormatConstructorPtr = dylib.lookup <NativeFunction<_WxDataFormatConstructorNative>>('wxDataFormatConstructor');
  _wxDataFormatConstructor = wxDataFormatConstructorPtr.asFunction<_WxDataFormatConstructor>();

  final wxDataFormatGetIdPtr = dylib.lookup <NativeFunction<_WxDataFormatGetIdNative>>('wxDataFormatGetId');
  _wxDataFormatGetId = wxDataFormatGetIdPtr.asFunction<_WxDataFormatGetId>();

  final wxDataFormatGetTypePtr = dylib.lookup <NativeFunction<_WxDataFormatGetTypeNative>>('wxDataFormatGetType');
  _wxDataFormatGetType = wxDataFormatGetTypePtr.asFunction<_WxDataFormatGetType>();

  // ------------------------- wxDataFormatArray ----------------------

  final wxDataFormatArrayConstructorPtr = dylib.lookup <NativeFunction<_WxDataFormatArrayConstructorNative>>('wxDataFormatArrayConstructor');
  _wxDataFormatArrayConstructor = wxDataFormatArrayConstructorPtr.asFunction<_WxDataFormatArrayConstructor>();

  final wxDataFormatArrayGetCountPtr = dylib.lookup <NativeFunction<_WxDataFormatArrayGetCountNative>>('wxDataFormatArrayGetCount');
  _wxDataFormatArrayGetCount = wxDataFormatArrayGetCountPtr.asFunction<_WxDataFormatArrayGetCount>();

  final wxDataFormatArrayGetFormatPtr = dylib.lookup <NativeFunction<_WxDataFormatArrayGetFormatNative>>('wxDataFormatArrayGetFormat');
  _wxDataFormatArrayGetFormat = wxDataFormatArrayGetFormatPtr.asFunction<_WxDataFormatArrayGetFormat>();

  // ------------------------- wxDataObject ----------------------

  final wxDataObject_getDataSizePtr = dylib.lookup <NativeFunction<_WxDataObject_getDataSizeNative>>('wxDataObject_getDataSize');
  _wxDataObject_getDataSize = wxDataObject_getDataSizePtr.asFunction<_WxDataObject_getDataSize>();

  final wxDataObject_getDataHerePtr = dylib.lookup <NativeFunction<_WxDataObject_getDataHereNative>>('wxDataObject_getDataHere');
  _wxDataObject_getDataHere = wxDataObject_getDataHerePtr.asFunction<_WxDataObject_getDataHere>();

  final wxDataObject_setDataPtr = dylib.lookup <NativeFunction<_WxDataObject_setDataNative>>('wxDataObject_setData');
  _wxDataObject_setData = wxDataObject_setDataPtr.asFunction<_WxDataObject_setData>();

  final wxDataObjectIsSupportedPtr = dylib.lookup <NativeFunction<_WxDataObjectIsSupportedNative>>('wxDataObjectIsSupported');
  _wxDataObjectIsSupported = wxDataObjectIsSupportedPtr.asFunction<_WxDataObjectIsSupported>();

  // ------------------------- wxTextDataObject ----------------------

  final wxTextDataObjectConstructorPtr = dylib.lookup <NativeFunction<_WxTextDataObjectConstructorNative>>('wxTextDataObjectConstructor');
  _wxTextDataObjectConstructor = wxTextDataObjectConstructorPtr.asFunction<_WxTextDataObjectConstructor>();

  final wxTextDataObjectSetTextPtr = dylib.lookup <NativeFunction<_WxTextDataObjectSetTextNative>>('wxTextDataObjectSetText');
  _wxTextDataObjectSetText = wxTextDataObjectSetTextPtr.asFunction<_WxTextDataObjectSetText>();

  final wxTextDataObjectGetTextPtr = dylib.lookup <NativeFunction<_WxTextDataObjectGetTextNative>>('wxTextDataObjectGetText');
  _wxTextDataObjectGetText = wxTextDataObjectGetTextPtr.asFunction<_WxTextDataObjectGetText>();

  // ------------------------- wxFileDataObject ----------------------

  final wxFileDataObjectConstructorPtr = dylib.lookup <NativeFunction<_WxFileDataObjectConstructorNative>>('wxFileDataObjectConstructor');
  _wxFileDataObjectConstructor = wxFileDataObjectConstructorPtr.asFunction<_WxFileDataObjectConstructor>();

  final wxFileDataObjectAddFilePtr = dylib.lookup <NativeFunction<_WxFileDataObjectAddFileNative>>('wxFileDataObjectAddFile');
  _wxFileDataObjectAddFile = wxFileDataObjectAddFilePtr.asFunction<_WxFileDataObjectAddFile>();

  final wxFileDataObjectGetFilenamesPtr = dylib.lookup <NativeFunction<_WxFileDataObjectGetFilenamesNative>>('wxFileDataObjectGetFilenames');
  _wxFileDataObjectGetFilenames = wxFileDataObjectGetFilenamesPtr.asFunction<_WxFileDataObjectGetFilenames>();

  // ------------------------- wxBitmapDataObject ----------------------

  final wxBitmapDataObjectConstructorPtr = dylib.lookup <NativeFunction<_WxBitmapDataObjectConstructorNative>>('wxBitmapDataObjectConstructor');
  _wxBitmapDataObjectConstructor = wxBitmapDataObjectConstructorPtr.asFunction<_WxBitmapDataObjectConstructor>();

  final wxBitmapDataObjectSetBitmapPtr = dylib.lookup <NativeFunction<_WxBitmapDataObjectSetBitmapNative>>('wxBitmapDataObjectSetBitmap');
  _wxBitmapDataObjectSetBitmap = wxBitmapDataObjectSetBitmapPtr.asFunction<_WxBitmapDataObjectSetBitmap>();

  final wxBitmapDataObjectGetBitmapPtr = dylib.lookup <NativeFunction<_WxBitmapDataObjectGetBitmapNative>>('wxBitmapDataObjectGetBitmap');
  _wxBitmapDataObjectGetBitmap = wxBitmapDataObjectGetBitmapPtr.asFunction<_WxBitmapDataObjectGetBitmap>();

  // ------------------------- wxDropSource ----------------------

  final wxDropSourceConstructorPtr = dylib.lookup <NativeFunction<_WxDropSourceConstructorNative>>('wxDropSourceConstructor');
  _wxDropSourceConstructor = wxDropSourceConstructorPtr.asFunction<_WxDropSourceConstructor>();

  final wxDropSource_doDragDropSyncPtr = dylib.lookup <NativeFunction<_WxDropSource_doDragDropSyncNative>>('wxDropSource_doDragDropSync');
  _wxDropSource_doDragDropSync = wxDropSource_doDragDropSyncPtr.asFunction<_WxDropSource_doDragDropSync>();

  // ------------------------- wxDropTarget ----------------------

  final wxDropTargetConstructorPtr = dylib.lookup <NativeFunction<_WxDropTargetConstructorNative>>('wxDropTargetConstructor');
  _wxDropTargetConstructor = wxDropTargetConstructorPtr.asFunction<_WxDropTargetConstructor>();

  final wxDropTargetGetDataPtr = dylib.lookup <NativeFunction<_WxDropTargetGetDataNative>>('wxDropTargetGetData');
  _wxDropTargetGetData = wxDropTargetGetDataPtr.asFunction<_WxDropTargetGetData>();

  final wxDropTargetSetDefaultActionPtr = dylib.lookup <NativeFunction<_WxDropTargetSetDefaultActionNative>>('wxDropTargetSetDefaultAction');
  _wxDropTargetSetDefaultAction = wxDropTargetSetDefaultActionPtr.asFunction<_WxDropTargetSetDefaultAction>();

  // ------------------------- wxSystemSettings ----------------------

  final wxSystemSettingsGetColourPtr = dylib.lookup <NativeFunction<_WxSystemSettingsGetColourNative>>('wxSystemSettingsGetColour');
  _wxSystemSettingsGetColour = wxSystemSettingsGetColourPtr.asFunction<_WxSystemSettingsGetColour>();

  final wxSystemSettingsGetFontPtr = dylib.lookup <NativeFunction<_WxSystemSettingsGetFontNative>>('wxSystemSettingsGetFont');
  _wxSystemSettingsGetFont = wxSystemSettingsGetFontPtr.asFunction<_WxSystemSettingsGetFont>();

  final wxSystemSettingsGetMetricPtr = dylib.lookup <NativeFunction<_WxSystemSettingsGetMetricNative>>('wxSystemSettingsGetMetric');
  _wxSystemSettingsGetMetric = wxSystemSettingsGetMetricPtr.asFunction<_WxSystemSettingsGetMetric>();

  final wxSystemSettingsSelectLightDarkPtr = dylib.lookup <NativeFunction<_WxSystemSettingsSelectLightDarkNative>>('wxSystemSettingsSelectLightDark');
  _wxSystemSettingsSelectLightDark = wxSystemSettingsSelectLightDarkPtr.asFunction<_WxSystemSettingsSelectLightDark>();

  // ------------------------- wxStandardPaths ----------------------

  final wxStandardPathsGetExecutablePathPtr = dylib.lookup <NativeFunction<_WxStandardPathsGetExecutablePathNative>>('wxStandardPathsGetExecutablePath');
  _wxStandardPathsGetExecutablePath = wxStandardPathsGetExecutablePathPtr.asFunction<_WxStandardPathsGetExecutablePath>();

  final wxStandardPaths_getResourcesDirPtr = dylib.lookup <NativeFunction<_WxStandardPaths_getResourcesDirNative>>('wxStandardPaths_getResourcesDir');
  _wxStandardPaths_getResourcesDir = wxStandardPaths_getResourcesDirPtr.asFunction<_WxStandardPaths_getResourcesDir>();

  final wxStandardPathsGetConfigDirPtr = dylib.lookup <NativeFunction<_WxStandardPathsGetConfigDirNative>>('wxStandardPathsGetConfigDir');
  _wxStandardPathsGetConfigDir = wxStandardPathsGetConfigDirPtr.asFunction<_WxStandardPathsGetConfigDir>();

  final wxStandardPathsGetDocumentsDirPtr = dylib.lookup <NativeFunction<_WxStandardPathsGetDocumentsDirNative>>('wxStandardPathsGetDocumentsDir');
  _wxStandardPathsGetDocumentsDir = wxStandardPathsGetDocumentsDirPtr.asFunction<_WxStandardPathsGetDocumentsDir>();

  final wxStandardPathsGetTempDirPtr = dylib.lookup <NativeFunction<_WxStandardPathsGetTempDirNative>>('wxStandardPathsGetTempDir');
  _wxStandardPathsGetTempDir = wxStandardPathsGetTempDirPtr.asFunction<_WxStandardPathsGetTempDir>();

  // ------------------------- wxNativeTimer ----------------------

  final wxNativeTimerConstructorPtr = dylib.lookup <NativeFunction<_WxNativeTimerConstructorNative>>('wxNativeTimerConstructor');
  _wxNativeTimerConstructor = wxNativeTimerConstructorPtr.asFunction<_WxNativeTimerConstructor>();

  final wxNativeTimerConstructorWithOwnerPtr = dylib.lookup <NativeFunction<_WxNativeTimerConstructorWithOwnerNative>>('wxNativeTimerConstructorWithOwner');
  _wxNativeTimerConstructorWithOwner = wxNativeTimerConstructorWithOwnerPtr.asFunction<_WxNativeTimerConstructorWithOwner>();

  final wxNativeTimerSetOwnerPtr = dylib.lookup <NativeFunction<_WxNativeTimerSetOwnerNative>>('wxNativeTimerSetOwner');
  _wxNativeTimerSetOwner = wxNativeTimerSetOwnerPtr.asFunction<_WxNativeTimerSetOwner>();

  final wxNativeTimerGetIdPtr = dylib.lookup <NativeFunction<_WxNativeTimerGetIdNative>>('wxNativeTimerGetId');
  _wxNativeTimerGetId = wxNativeTimerGetIdPtr.asFunction<_WxNativeTimerGetId>();

  final wxNativeTimerGetIntervalPtr = dylib.lookup <NativeFunction<_WxNativeTimerGetIntervalNative>>('wxNativeTimerGetInterval');
  _wxNativeTimerGetInterval = wxNativeTimerGetIntervalPtr.asFunction<_WxNativeTimerGetInterval>();

  final wxNativeTimerIsOneShotPtr = dylib.lookup <NativeFunction<_WxNativeTimerIsOneShotNative>>('wxNativeTimerIsOneShot');
  _wxNativeTimerIsOneShot = wxNativeTimerIsOneShotPtr.asFunction<_WxNativeTimerIsOneShot>();

  final wxNativeTimerIsRunningPtr = dylib.lookup <NativeFunction<_WxNativeTimerIsRunningNative>>('wxNativeTimerIsRunning');
  _wxNativeTimerIsRunning = wxNativeTimerIsRunningPtr.asFunction<_WxNativeTimerIsRunning>();

  final wxNativeTimerStartPtr = dylib.lookup <NativeFunction<_WxNativeTimerStartNative>>('wxNativeTimerStart');
  _wxNativeTimerStart = wxNativeTimerStartPtr.asFunction<_WxNativeTimerStart>();

  final wxNativeTimerStartOncePtr = dylib.lookup <NativeFunction<_WxNativeTimerStartOnceNative>>('wxNativeTimerStartOnce');
  _wxNativeTimerStartOnce = wxNativeTimerStartOncePtr.asFunction<_WxNativeTimerStartOnce>();

  final wxNativeTimerStopPtr = dylib.lookup <NativeFunction<_WxNativeTimerStopNative>>('wxNativeTimerStop');
  _wxNativeTimerStop = wxNativeTimerStopPtr.asFunction<_WxNativeTimerStop>();

}

void releaseWxMisc()
{
}
