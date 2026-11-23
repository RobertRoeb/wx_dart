// -------------------------------------------------------------
// Purpose:     Dart bindings for wxWidgets
// Author:      Robert Roebling
// Modified by:
// Created:     07/01/2025
// Copyright:   (c) Robert Roebling
// Licence:     wxWindows licence 3.1
// -------------------------------------------------------------

part of '../wx_dart.dart';

// ------------------ Operating system -----------------

bool wxUsesFlutter() {
   return false;
}

bool wxUsesHTML() {
   return false;
}

bool wxIsWeb() {
  return false;
}

bool wxIsLinux() {
  return Platform.isLinux;
}

bool wxIsMac() {
  return Platform.isMacOS;
}

bool wxIsMSW() {
  return Platform.isWindows;
}

bool wxIsAndroid() {
  return false;
}

bool wxIsIOS() {
  return Platform.isIOS;
}

// ------------------------ wxTimer ---------------------------

class WxTimer extends WxNativeTimer {
  WxTimer( ) : super()
  {
    bindTimerEvent( (_)=>notify() );
  }
  WxTimer.withOwner( super.owner, { super.id } ) : super.withOwner();

  void notify() {
  }
}

// -------------------- wxSystemSettings -----------------------

typedef _WxSystemSettingsConstructorNative = Pointer Function();
typedef _WxSystemSettingsConstructor = Pointer Function();
late _WxSystemSettingsConstructor _wxSystemSettingsConstructor;

WxSystemSettings? _theSystemSettings;

WxSystemSettings wxGetSystemSettings() {
  if (_theSystemSettings != null) {
    return _theSystemSettings!;
  }

  _theSystemSettings = WxSystemSettings.fromHandle( _wxSystemSettingsConstructor() );
  return _theSystemSettings!;
}

// -------------------- wxStandardPaths -----------------------

typedef _WxStandardPathsConstructorNative = Pointer Function();
typedef _WxStandardPathsConstructor = Pointer Function();
late _WxStandardPathsConstructor _wxStandardPathsConstructor;

WxStandardPaths? _theStandardPaths;

WxStandardPaths wxGetStandardPaths() {
  if (_theStandardPaths != null) {
    return _theStandardPaths!;
  }

  _theStandardPaths = WxStandardPaths.fromHandle( _wxStandardPathsConstructor() );
  return _theStandardPaths!;
}

String _wxConvertToAssetPath( String path )
{
  if (wxIsMSW()) {
    path.replaceAll("/", "\\");
    path = "${wxGetStandardPaths().getResourcesDir()}\\$path";
  } else {
    path = "${wxGetStandardPaths().getResourcesDir()}/$path";
  }
  return path;
}

// ------------------ wxLoadRGBAFromResource -------------------

void _wxLoadRGBAFromResourceSync( String assetPath, void Function( Uint8List rgba, int width, int height ) returnRGBA,
 { int format = wxBITMAP_TYPE_PNG } )
{
  final image = WxImage.fromFile( assetPath, format );
  if (!image.isOk()) {
    wxLogError( "Could not decode image $assetPath" );
    return;
  }
  returnRGBA( image.getRGBA(), image.getWidth(), image.getHeight() );
}

void _wxLoadRGBAFromResourceAsync( String assetPath, void Function( Uint8List rgba, int width, int height ) returnRGBA,
 { int format = wxBITMAP_TYPE_PNG } ) async
{
  // give scheduler a chance to postpone
  await Future.delayed( const Duration( milliseconds: 0 ));

  final image = WxImage.fromFile( assetPath, format );
  if (!image.isOk()) {
    wxLogError( "Could not decode image $assetPath" );
    return;
  }
  returnRGBA( image.getRGBA(), image.getWidth(), image.getHeight() );
}

void wxLoadRGBAFromResource( String filename, void Function( Uint8List rgba, int width, int height ) returnRGBA,
 { int format = wxBITMAP_TYPE_PNG, String subdir = "" } )
{
    String assetPath = wxGetStandardPaths().getResourcesDir();
    if (wxIsMSW()) {
      if (subdir.isEmpty) {
        assetPath += "\\$filename";
      } else {
        assetPath += "\\$subdir\\$filename";
      }
    } else {
      if (subdir.isEmpty) {
        assetPath += "/$filename";
      } else {
        assetPath += "/$subdir/$filename";
      }
    }
    final file = File(assetPath);
    if (file.existsSync()) {
      _wxLoadRGBAFromResourceAsync( assetPath, returnRGBA, format: format );
      return;
    }

    // the above code assumes we are installed on the final machine
    // below is testing locally in the assets folder

    if (wxIsMac()) {
      assetPath = wxGetStandardPaths().getExecutablePath();
      assetPath = assetPath.substring(0, assetPath.lastIndexOf("/")+1 ); // clip off exe filename
      assetPath = assetPath.substring(0, assetPath.length-6 ); // clip off MacOS/
      assetPath += 'Frameworks/App.framework/Resources/flutter_assets/lib/assets';
      if (subdir.isEmpty) {
        assetPath += "/$filename";
      } else {
        assetPath += "/$subdir/$filename";
      }
      final localFile = File(assetPath);
      if (localFile.existsSync()) {
        _wxLoadRGBAFromResourceAsync( assetPath, returnRGBA, format: format );
        return;
      }
    } else 
    if (wxIsLinux()) {
      assetPath = wxGetStandardPaths().getExecutablePath();
      assetPath = assetPath.substring(0, assetPath.lastIndexOf("/")+1 ); // clip off exe filename
      assetPath += 'data/flutter_assets/lib/assets';
      if (subdir.isEmpty) {
        assetPath += "/$filename";
      } else {
        assetPath += "/$subdir/$filename";
      }
      final localFile = File(assetPath);
      if (localFile.existsSync()) {
        _wxLoadRGBAFromResourceAsync( assetPath, returnRGBA, format: format );
        return;
      }
    } else 
    if (wxIsMSW()) {
      assetPath = wxGetStandardPaths().getExecutablePath();
      assetPath = assetPath.substring(0, assetPath.lastIndexOf("\\")+1 ); // clip off exe filename
      assetPath += 'data/flutter_assets/lib/assets';
      if (subdir.isEmpty) {
        assetPath += "\\$filename";
      } else {
        assetPath += "\\$subdir\\$filename";
      }
      final localFile = File(assetPath);
      if (localFile.existsSync()) {
        _wxLoadRGBAFromResourceAsync( assetPath, returnRGBA, format: format );
        return;
      }
    }
    wxLogError( "Resource file $filename not found" );
}


// ------------------ wxLoadImageFromResource -------------------

void _wxLoadImageFromResourceSync( String assetPath, void Function( WxImage image ) returnImage, { int format = wxBITMAP_TYPE_PNG } ) 
{
      final image = WxImage.fromFile( assetPath, format );
      
      if (!image.isOk()) {
        wxLogError( "Could not decode image $assetPath" );
        return;
      }
      returnImage( image );
}

void _wxLoadImageFromResourceAsync( String assetPath, void Function( WxImage image ) returnImage, { int format = wxBITMAP_TYPE_PNG } ) async
{
  // give scheduler a chance to postpone
  await Future.delayed( const Duration( milliseconds: 0 ));

  final image = WxImage.fromFile( assetPath, format );
  if (!image.isOk()) {
    wxLogError( "Could not decode image $assetPath" );
    return;
  }
  returnImage( image );
}

void wxLoadImageFromResource( String filename, void Function( WxImage image ) returnImage, { int format = wxBITMAP_TYPE_PNG, String subdir = "" } ) 
{
    String assetPath = wxGetStandardPaths().getResourcesDir();
    if (wxIsMSW()) {
      if (subdir.isEmpty) {
        assetPath += "\\$filename";
      } else {
        assetPath += "\\$subdir\\$filename";
      }
    } else {
      if (subdir.isEmpty) {
        assetPath += "/$filename";
      } else {
        assetPath += "/$subdir/$filename";
      }
    }
    final file = File(assetPath);
    if (file.existsSync()) {
      _wxLoadImageFromResourceAsync( assetPath, returnImage, format: format );
      return;
    }

    // the above code assumes we are installed on the final machine
    // below is testing the locally in the assets folder

    if (wxIsMac()) {
      assetPath = wxGetStandardPaths().getExecutablePath();
      assetPath = assetPath.substring(0, assetPath.lastIndexOf("/")+1 ); // clip off exe filename
      assetPath = assetPath.substring(0, assetPath.length-6 ); // clip off MacOS/
      assetPath += 'Frameworks/App.framework/Resources/flutter_assets/lib/assets';
      if (subdir.isEmpty) {
        assetPath += "/$filename";
      } else {
        assetPath += "/$subdir/$filename";
      }
      final localFile = File(assetPath);
      if (localFile.existsSync()) {
        _wxLoadImageFromResourceAsync( assetPath, returnImage, format: format );
        return;
      }
    } else 
    if (wxIsLinux()) {
      assetPath = wxGetStandardPaths().getExecutablePath();
      assetPath = assetPath.substring(0, assetPath.lastIndexOf("/")+1 );   // clip off exe filename
      assetPath += 'data/flutter_assets/lib/assets';
      if (subdir.isEmpty) {
        assetPath += "/$filename";
      } else {
        assetPath += "/$subdir/$filename";
      }
      final localFile = File(assetPath);
      if (localFile.existsSync()) {
        _wxLoadImageFromResourceAsync( assetPath, returnImage, format: format );
        return;
      }
    } else 
    if (wxIsMSW()) {
      assetPath = wxGetStandardPaths().getExecutablePath();
      assetPath = assetPath.substring(0, assetPath.lastIndexOf("\\")+1 ); // clip off exe filename
      assetPath += 'data/flutter_assets/lib/assets';
      if (subdir.isEmpty) {
        assetPath += "\\$filename";
      } else {
        assetPath += "\\$subdir\\$filename";
      }
      final localFile = File(assetPath);
      if (localFile.existsSync()) {
        _wxLoadImageFromResourceAsync( assetPath, returnImage, format: format );
        return;
      }
    }
    wxLogError( "Resource file $filename not found" );
}

// ------------------ wxLoadStringFromResource -------------------

void wxLoadStringFromResource( String filename, void Function( String data ) returnString, { String subdir = "" } ) 
{
    String assetPath = wxGetStandardPaths().getResourcesDir();
    if (wxIsMSW()) {
      if (subdir.isEmpty) {
        assetPath += "\\$filename";
      } else {
        assetPath += "\\$subdir\\$filename";
      }
    } else {
      if (subdir.isEmpty) {
        assetPath += "/$filename";
      } else {
        assetPath += "/$subdir/$filename";
      }
    }
    final file = File(assetPath);
    if (file.existsSync()) {
      // returnString( file.readAsStringSync() );
      file.readAsString().then( (str) {
        returnString( str );
      } );
      return;
    }

    // the above code assumes we are installed on the final machine
    // below is testing the locally in the assets folder

    if (wxIsMac()) {
      assetPath = wxGetStandardPaths().getExecutablePath();
      assetPath = assetPath.substring(0, assetPath.lastIndexOf("/")+1 ); // clip off exe filename
      assetPath = assetPath.substring(0, assetPath.length-6 ); // clip off MacOS/
      assetPath += 'Frameworks/App.framework/Resources/flutter_assets/lib/assets';
      if (subdir.isEmpty) {
        assetPath += "/$filename";
      } else {
        assetPath += "/$subdir/$filename";
      } 
      final localFile = File(assetPath);
      if (localFile.existsSync()) {
        localFile.readAsString().then( (str) {
          returnString( str );
        } );
        return;
      }
    } else
    if (wxIsLinux()) {
      assetPath = wxGetStandardPaths().getExecutablePath();
      assetPath = assetPath.substring(0, assetPath.lastIndexOf("/")+1 ); // clip off exe filename
      assetPath += 'data/flutter_assets/lib/assets';
      if (subdir.isEmpty) {
        assetPath += "/$filename";
      } else {
        assetPath += "/$subdir/$filename";
      }
      final localFile = File(assetPath);
      if (localFile.existsSync()) {
        localFile.readAsString().then( (str) {
          returnString( str );
        } );
        return;
      }
    } else 
    if (wxIsMSW()) {
      assetPath = wxGetStandardPaths().getExecutablePath();
      assetPath = assetPath.substring(0, assetPath.lastIndexOf("\\")+1 ); // clip off exe filename
      assetPath += 'data/flutter_assets/lib/assets';
      if (subdir.isEmpty) {
        assetPath += "\\$filename";
      } else {
        assetPath += "\\$subdir\\$filename";
      }
      final localFile = File(assetPath);
      if (localFile.existsSync()) {
        // returnString( file.readAsStringSync() );
        localFile.readAsString().then( (str) {
          returnString( str );
        } );
        return;
      }
    }
    wxLogError( "Resource file $filename not found" );
}

// -------------------- wxRendererNative -----------------------

const int wxHDR_SORT_ICON_NONE = 0;
const int wxHDR_SORT_ICON_UP = 1;
const int wxHDR_SORT_ICON_DOWN = 2;

const int wxCONTROL_NONE       = 0x00000000;
const int wxCONTROL_DISABLED   = 0x00000001;
const int wxCONTROL_FOCUSED    = 0x00000002;
const int wxCONTROL_PRESSED    = 0x00000004;
const int wxCONTROL_SPECIAL    = 0x00000008;
const int wxCONTROL_ISDEFAULT  = wxCONTROL_SPECIAL;
const int wxCONTROL_ISSUBMENU  = wxCONTROL_SPECIAL;
const int wxCONTROL_EXPANDED   = wxCONTROL_SPECIAL;
const int wxCONTROL_SIZEGRIP   = wxCONTROL_SPECIAL;
const int wxCONTROL_FLAT       = wxCONTROL_SPECIAL;
const int wxCONTROL_CELL       = wxCONTROL_SPECIAL;
const int wxCONTROL_CURRENT    = 0x00000010;
const int wxCONTROL_SELECTED   = 0x00000020;
const int wxCONTROL_CHECKED    = 0x00000040;
const int wxCONTROL_CHECKABLE  = 0x00000080;
const int wxCONTROL_UNDETERMINED = wxCONTROL_CHECKABLE;
const int wxCONTROL_FLAGS_MASK = 0x000000ff;
const int wxCONTROL_DIRTY      = 0x80000000;

const int wxCONTROL_SELECTION_GROUP  = 0x20000000;
const int wxCONTROL_ITEM_FIRST       = 0x40000000;
const int wxCONTROL_ITEM_LAST        = wxCONTROL_DIRTY;

typedef _WxRendererNativeConstructorNative = Pointer Function();
typedef _WxRendererNativeConstructor = Pointer Function();
late _WxRendererNativeConstructor _wxRendererNativeConstructor;

WxRendererNative? theRendererNative;

WxRendererNative wxGetRendererNative() {
  if (theRendererNative != null) {
    return theRendererNative!;
  }

  theRendererNative = WxRendererNative.fromHandle( _wxRendererNativeConstructor() );
  return theRendererNative!;
}

// ------------------------- WxUIAnimation ----------------------

const int _millisecsPerStep = 50;

class WxUIAnimationTimer extends WxTimer {
  WxUIAnimationTimer( WxUIAnimation owner, int millisecs, int curve ) : super()
  {
    _millisecs = millisecs;
    _owner = owner;
    _curve = curve;
  }

  late WxUIAnimation _owner;
  int _counter = 0;
  late int _millisecs;
  late int _curve;

  void setDuration( int millisecs ) {
    _millisecs = millisecs;
  }

  double _easeInEaseOut(double source)
  {
      final square = source * source;
      return square / (2.0 * (square - source) + 1.0);
  }

  double _easeIn(double source)
  {
      return source * source;
  }

  double _easeOut(double source)
  {
      return source * (2 - source);
  }

  double _bounce(double source)
  {
    const n1 = 7.5625;
    const d1 = 2.75;

    if (source < 1 / d1) {
        return n1 * source * source;
    } else if (source < 2 / d1) {
        return n1 * (source -= 1.5 / d1) * source + 0.75;
    } else if (source < 2.5 / d1) {
        return n1 * (source -= 2.25 / d1) * source + 0.9375;
    } else {
        return n1 * (source -= 2.625 / d1) * source + 0.984375;
    }
  }

  @override
  void notify()
  {
    _counter++;

    if (_counter*_millisecsPerStep >= _millisecs)
    {
      _counter = 0;
      // Call stop before the callback as the callback might restart
      // the animation as an infinite loop
      stop();
      _owner._callback( 1.0 );
      if (_owner._callbackCompleted != null) {
        _owner._callbackCompleted!();
      }
      return;
    }
    double value = (_counter * _millisecsPerStep) / _millisecs;
    switch (_curve) {
      case wxCURVE_EASE_IN_EASE_OUT:  value = _easeInEaseOut(value);
      case wxCURVE_EASE_IN:           value = _easeIn(value);
      case wxCURVE_EASE_OUT:          value = _easeOut(value);
      case wxCURVE_BOUNCE:            value = _bounce(value);
    }
    _owner._callback( value );
  }
}

const int wxCURVE_LINEAR = 1;
const int wxCURVE_EASE_IN_EASE_OUT = 2;
const int wxCURVE_EASE_IN = 3;
const int wxCURVE_EASE_OUT = 4;
const int wxCURVE_BOUNCE = 5;

class WxUIAnimation extends WxObject {
  WxUIAnimation( void Function( double value ) callback, int millisecs, { void Function ()? callbackCompleted,
   int curve = wxCURVE_LINEAR } )
  {
    _callback = callback;
    _callbackCompleted = callbackCompleted;
    _timer = WxUIAnimationTimer( this, millisecs, curve );
  }

  void setDuration( int millisecs ) {
    _timer.setDuration( millisecs );
  }

  void start() {
    _timer._counter = 0;
    _timer.start( milliseconds: _millisecsPerStep );
  }

  void stop() {
    _timer.stop();
  }

  bool isRunning() {
    return _timer.isRunning();
  }

  late void Function( double value ) _callback;
  void Function()? _callbackCompleted;
  late WxUIAnimationTimer _timer;
}

// -------------------- wxFindWindowAtPoint -----------------------

typedef _WxFindWindowAtPointNative = Pointer Function( Int32, Int32 );
typedef _WxFindWindowAtPoint = Pointer Function( int, int );
late _WxFindWindowAtPoint _wxFindWindowAtPoint;

WxWindow? wxFindWindowAtPoint( WxPoint point ) {
  final result = _wxFindWindowAtPoint( point.x, point.y );
  if (result == nullptr) {
    return null;
  }
  WxEvtHandler? eh = _evtHandlerList[result];
  if (eh != null) {
    // There already is a Dart class associated with this C++ object
    return eh as WxWindow;
  }
  return wxCreateBestMatchingClassFromWxWindowHandle( result );
}

// -------------------- wxLaunchDefaultBrowser -----------------------

typedef _WxLaunchDefaultBrowserNative = Bool Function( Pointer<Utf8>, Int32 );
typedef _WxLaunchDefaultBrowser = bool Function( Pointer<Utf8>, int );
late _WxLaunchDefaultBrowser _wxLaunchDefaultBrowser;

const int wxBROWSER_NEW_WINDOW = 0x01;
const int wxBROWSER_NOBUSYCURSOR = 0x02;


bool wxLaunchDefaultBrowser( String url, { int flags = 0 } ) {
  return _wxLaunchDefaultBrowser( url.toNativeUtf8(), flags );
}

// -------------------- wxLogging -----------------------

typedef _WxLogErrorNative = Void Function( Pointer<Utf8> );
typedef _WxLogError = void Function( Pointer<Utf8> );
late _WxLogError _wxLogError;

void wxLogError( String text ) {
  _wxLogError( text.toNativeUtf8() );
}

typedef _WxLogWarningNative = Void Function( Pointer<Utf8> );
typedef _WxLogWarning = void Function( Pointer<Utf8> );
late _WxLogWarning _wxLogWarning;

void wxLogWarning( String text ) {
  _wxLogWarning( text.toNativeUtf8() );
}

typedef _WxLogMessageNative = Void Function( Pointer<Utf8> );
typedef _WxLogMessage = void Function( Pointer<Utf8> );
late _WxLogMessage _wxLogMessage;

void wxLogMessage( String text ) {
  _wxLogMessage( text.toNativeUtf8() );
}

typedef _WxLogStatusNative = Void Function( Pointer, Pointer<Utf8> );
typedef _WxLogStatus = void Function( Pointer, Pointer<Utf8> );
late _WxLogStatus _wxLogStatus;

void wxLogStatus( WxFrame frame, String text ) {
  _wxLogStatus( frame.nativeHandle, text.toNativeUtf8() );
}

typedef _WxLogDebugNative = Void Function( Pointer<Utf8> );
typedef _WxLogDebug = void Function( Pointer<Utf8> );
late _WxLogDebug _wxLogDebug;

void wxLogDebug( String text ) {
  _wxLogDebug( text.toNativeUtf8() );
}

typedef _WxSetLogTargetTextCtrlNative = Void Function( Pointer );
typedef _WxSetLogTargetTextCtrl = void Function( Pointer );
late _WxSetLogTargetTextCtrl _wxSetLogTargetTextCtrl;

typedef _WxSetLogTargetDefaultNative = Void Function();
typedef _WxSetLogTargetDefault = void Function();
late _WxSetLogTargetDefault _wxSetLogTargetDefault;

void wxSetLogTarget( WxTextCtrl? textCtrl ) {
  if (textCtrl != null) {
    _wxSetLogTargetTextCtrl( textCtrl.nativeHandle );
  } else {
    _wxSetLogTargetDefault();
  }
}

typedef _WxSetLogTargetNullNative = Void Function();
typedef _WxSetLogTargetNull = void Function();
late _WxSetLogTargetNull _wxSetLogTargetNull;

void wxSetLogTargetNull() {
    _wxSetLogTargetNull();
}

typedef _WxUnsetLogTargetNullNative = Void Function();
typedef _WxUnsetLogTargetNull = void Function();
late _WxUnsetLogTargetNull _wxUnsetLogTargetNull;

void wxUnsetLogTargetNull() {
    _wxUnsetLogTargetNull();
}


void setupWxUtils( DynamicLibrary dylib )
{

  // -------------------- wxSystemSettings -----------------------

  final wxSystemSettingsConstructorPtr = dylib.lookup <NativeFunction<_WxSystemSettingsConstructorNative>>('wxSystemSettingsGet');
  _wxSystemSettingsConstructor = wxSystemSettingsConstructorPtr.asFunction<_WxSystemSettingsConstructor>();

  // -------------------- wxStandardPaths -----------------------

  final wxStandardPathsConstructorPtr = dylib.lookup <NativeFunction<_WxStandardPathsConstructorNative>>('wxStandardPathsGet');
  _wxStandardPathsConstructor = wxStandardPathsConstructorPtr.asFunction<_WxStandardPathsConstructor>();

  // -------------------- wxRendererNative -----------------------

  final wxRendererNativeConstructorPtr = dylib.lookup <NativeFunction<_WxRendererNativeConstructorNative>>('wxRendererNativeGet');
  _wxRendererNativeConstructor = wxRendererNativeConstructorPtr.asFunction<_WxRendererNativeConstructor>();

  // -------------------- wxLaunchDefaultBrowser -----------------------

  final wxLaunchDefaultBrowserPtr = dylib.lookup <NativeFunction<_WxLaunchDefaultBrowserNative>>('wxDartLaunchDefaultBrowser');
  _wxLaunchDefaultBrowser = wxLaunchDefaultBrowserPtr.asFunction<_WxLaunchDefaultBrowser>();

  // -------------------- wxFindWindowAtPoint -----------------------

  final wxFindWindowAtPointPtr = dylib.lookup <NativeFunction<_WxFindWindowAtPointNative>>('wxDartFindWindowAtPoint');
  _wxFindWindowAtPoint = wxFindWindowAtPointPtr.asFunction<_WxFindWindowAtPoint>();

  // -------------------- wxLogging -----------------------

  final wxLogErrorPtr = dylib.lookup <NativeFunction<_WxLogErrorNative>>('wxDartLogError');
  _wxLogError = wxLogErrorPtr.asFunction<_WxLogError>();

  final wxLogWarningPtr = dylib.lookup <NativeFunction<_WxLogWarningNative>>('wxDartLogWarning');
  _wxLogWarning = wxLogWarningPtr.asFunction<_WxLogWarning>();

  final wxLogMessagePtr = dylib.lookup <NativeFunction<_WxLogMessageNative>>('wxDartLogMessage');
  _wxLogMessage = wxLogMessagePtr.asFunction<_WxLogMessage>();

  final wxLogStatusPtr = dylib.lookup <NativeFunction<_WxLogStatusNative>>('wxDartLogStatus');
  _wxLogStatus = wxLogStatusPtr.asFunction<_WxLogStatus>();

  final wxLogDebugPtr = dylib.lookup <NativeFunction<_WxLogDebugNative>>('wxDartLogDebug');
  _wxLogDebug = wxLogDebugPtr.asFunction<_WxLogDebug>();

  final wxSetLogTargetTextCtrlPtr = dylib.lookup <NativeFunction<_WxSetLogTargetTextCtrlNative>>('wxSetLogTargetTextCtrl');
  _wxSetLogTargetTextCtrl = wxSetLogTargetTextCtrlPtr.asFunction<_WxSetLogTargetTextCtrl>();

  final wxSetLogTargetDefaultPtr = dylib.lookup <NativeFunction<_WxSetLogTargetDefaultNative>>('wxSetLogTargetDefault');
  _wxSetLogTargetDefault = wxSetLogTargetDefaultPtr.asFunction<_WxSetLogTargetDefault>();

  final wxSetLogTargetNullPtr = dylib.lookup <NativeFunction<_WxSetLogTargetNullNative>>('wxSetLogTargetNull');
  _wxSetLogTargetNull = wxSetLogTargetNullPtr.asFunction<_WxSetLogTargetNull>();

  final wxUnsetLogTargetNullPtr = dylib.lookup <NativeFunction<_WxUnsetLogTargetNullNative>>('wxUnsetLogTargetNull');
  _wxUnsetLogTargetNull = wxUnsetLogTargetNullPtr.asFunction<_WxUnsetLogTargetNull>();
}
