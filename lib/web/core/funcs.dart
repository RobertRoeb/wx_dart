// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-11-15
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- platform ----------------------

/// Returns true if the Flutter backend is used
///
/// Returns false: wxDart Web does not use Flutter
bool wxUsesFlutter() => false;

/// Returns true if the Native backend is used
///
/// Returns false: wxDart Web does not use FFI
bool wxUsesNative() => false;

/// Returns true if the Web/Javascript backend is used
///
/// Returns true if the app is wxDart Web (web only, no Flutter)
bool wxUsesHTML() => true;

/// Returns true if the app is running on the web
///
/// wxDart Web always runs in a browser
bool wxIsWeb() => true;

/// Returns true if the app is running on Linux (wxDart Native or wxDart Flutter)
///
/// The browser's operating system is not queried in wxDart Web
bool wxIsLinux() => false;
/// Returns true if the app is running on macOS (wxDart Native or wxDart Flutter)
bool wxIsMac() => false;
/// Returns true if the app is running on Windows (wxDart Native or wxDart Flutter)
bool wxIsMSW() => false;
/// Returns true if the app is running on Android (only possible in wxDart Flutter)
bool wxIsAndroid() => false;
/// Returns true if the app is running on iOS (wxDart Native or wxDart Flutter)
bool wxIsIOS() => false;

// ------------------------- wxNewControlId ----------------------

const int _wxFirstWindowID = -10;
int _wxLastWindowID = _wxFirstWindowID;

int _wxNewControlId() {
  _wxLastWindowID--;
  return _wxLastWindowID;
}

// ------------------------- standard paths ----------------------

/// Minimal version of WxStandardPaths for the web.
///
/// [getResourcesDir] returns the URL prefix from which assets are
/// downloaded, relative to the page (default "assets").
class WxStandardPaths {
  static String _resourcesDir = "assets";

  /// Returns the standard directory for resources/assets like text files or images.
  ///
  /// In wxDart, all resource files should be stored under lib/assets and this
  /// function will always return "lib/assets". wxDart will either add the actual
  /// files to the binary, put them into a resource folder or make them downloadable
  /// using http when using Flutter on the Web.
  ///
  /// In wxDart Native, there are two different scenarios. The resource directory is
  /// either the folder where the resource files should be located when the final
  /// software is installed indicated by [useInstalledDirectory], or they are left
  /// in lib/assets as explained above.
  ///
  /// TBD: If you use the [useInstalledDirectory] option the
  /// subdirectory _assets_ will be appended appended.
  ///
  /// * macOS myapp.app/Contents/Resources (bundle subdirectory)
  /// * iOS: myapp.app (bundle subdirectory)
  /// * Linux/Unix: prefix/share/myapp or $exepath/assets
  /// * Windows: folder where the executable is located or $exepath/assets
  ///
  String getResourcesDir({bool useInstalledDirectory = false}) {
    return _resourcesDir;
  }

  /// Returns the full path to the executable including the filename.
  /// Returns the base URI on the Web.
  String getExecutablePath( ) {
    final base = Uri.base;
    return base.toString();
  }


  /// wxDart Web only: changes the URL prefix for assets,
  /// e.g. to a CDN.
  static void setResourcesDir(String urlPrefix) {
    _resourcesDir = urlPrefix;
  }
}

final _theStandardPaths = WxStandardPaths();

/// Returns single global instance of [WxStandardPaths]. Most typical
/// usage is for loading resources:
///
/// ```dart
///  String assetPath = wxGetStandardPaths().getResourcesDir();
/// ```
WxStandardPaths wxGetStandardPaths() => _theStandardPaths;

// ------------------------- helpers ----------------------

String _cssColour(WxColour c) {
  if (c.alpha == 255) return "rgb(${c.red},${c.green},${c.blue})";
  return "rgba(${c.red},${c.green},${c.blue},${(c.alpha / 255).toStringAsFixed(3)})";
}

/// Removes the mnemonic marker "&" ("&&" becomes "&")
String _wxStripMnemonic(String text) {
  final buf = StringBuffer();
  for (int i = 0; i < text.length; i++) {
    final ch = text[i];
    if (ch == '&') {
      if (i + 1 < text.length && text[i + 1] == '&') {
        buf.write('&');
        i++;
      }
      continue;
    }
    buf.write(ch);
  }
  return buf.toString();
}

// ------------------------- wxLaunchDefaultBrowser ----------------------

/// Launches the default browser
///
/// Example usage:
///```dart
///  wxLaunchDefaultBrowser( "https://pub.dev/packages/wx_dart" );
///```
///
/// Opens [url] in a new browser tab
bool wxLaunchDefaultBrowser(String url, {int flags = 0}) {
  _jsOpenUrl(url);
  return true;
}

// ------------------------- wxExportDocument -------------------------

/// Hands a document the application created to the user, in the way the
/// platform expects it, e.g. a PDF from [WxPDFGraphicsContext].
///
/// | style | |
/// | -------- | -------- |
/// | wxEXPORT_DEFAULT | the share sheet on devices operated with fingers, saving elsewhere |
/// | wxEXPORT_SAVE | save under a name and in a folder chosen by the user |
/// | wxEXPORT_SHARE | the share sheet of the system (mail, messenger, "save to files", print) |
/// | wxEXPORT_OPEN | also open the document with the default application |
///
/// In wxDart Web, saving uses the save dialog of the browser where there is
/// one (Chrome, Edge), otherwise the document is downloaded to the
/// downloads folder. Sharing uses the share sheet of phones and tablets.
/// Both need a recent click of the user: create the document in the event
/// handler of the click, and do not wait for anything slow before. Without
/// such a click, the document is downloaded. [wxEXPORT_OPEN] shows the
/// document in a new tab. [message] is the text of a shared document and
/// the description of the file type in the save dialog.
///
/// [parent] is the window the dialog belongs to (not used in wxDart Web).
///
/// Returns wxID_OK if the document was saved or shared, wxID_CANCEL if the
/// user cancelled, and wxID_ANY if it is not known (a browser download
/// gives no feedback).
///
/// ```dart
/// final out = WxPDFUint8ListOutput();
/// final gc = WxPDFGraphicsContext( out, title: "Menu" );
/// await gc.generate( pageCount: 2, renderPage: drawPage );
/// await wxExportDocument( this, await out.result, "Menu.pdf", mimeType: "application/pdf" );
/// ```
Future<int> wxExportDocument( WxWindow? parent, Uint8List data, String fileName,
    { String mimeType = '', String message = '', int style = wxEXPORT_DEFAULT } ) async {
  final mode = (style & wxEXPORT_SHARE) != 0 ? 2 : ((style & wxEXPORT_SAVE) != 0 ? 1 : 0);
  final result = await _jsExportDocument( fileName, data.toJS, mimeType, message, mode,
      (style & wxEXPORT_OPEN) != 0 ).toDart;
  switch (result.toDartInt) {
    case 0: return wxID_OK;
    case 1: return wxID_CANCEL;
    default: return wxID_ANY;
  }
}

// ------------------------- wxVariant compatibility ----------------------

/// Returns the wxVariant type name from for a given dynamic type in Dart
///
/// wxWidgets and such wxDart Native uses the wxVariant class type to
/// offer a dynamic type (which C++ does not have natively). This function
/// can be used to if there will be a need to access wxWidgets methods
/// that use the wxVariant type in wxDart Native.
///
/// in wxWidgets, wxVariant is used in wxDataViewCtrl (which is not used
/// wxDart Native) and in wxPropertyGrid (which is not yet supported,
/// but might one day) and in few other places.
///
String wxDynamicTypeToVariantType( dynamic value ) {
  if (value is List) {
    return "list"; 
  }
  if (value is bool) {
    return "bool"; 
  }
  if (value is int) {
   return "long"; 
  }
  if (value is String) {
   return "string"; 
  }
  if (value is double) {
   return "double"; 
  }
  if (value is WxBitmap) {
   return "bitmap"; 
  }
  return value.runtimeType.toString();
}

// -------------------- wxFindWindowAtPoint -----------------------

/// Returns the window under the screen position given by [pos]
///
/// Uses the FlutterView under wxDart Flutter as the screen.
///
/// In wxDart Web, the screen is the browser's viewport.
WxWindow? wxFindWindowAtPoint( WxPoint pos )
{
  final hit = _jsWindowAt( pos.x, pos.y );
  return _windowFromHandle( hit.id );
}

// -------------------- wxGetMousePosition -----------------------

/// Returns the position of the mouse on the screen
///
/// Returns the last known mouse position in screen coordinates
/// (in wxDart Web: relative to the browser's viewport)
WxPoint wxGetMousePosition()
{
  final pos = _jsMousePosition();
  return WxPoint( pos.x, pos.y );
}

// --------------------- wxLoadStringFromResource ---------------------

/// Downloads a text file from the resources directory (default "assets",
/// see [WxStandardPaths.getResourcesDir]) and returns its contents in the
/// callback, asynchronously as in wxDart Flutter.
/// 
/// Example usage:
/// ```dart
/// wxLoadStringFromResource( "myfile.txt", (text) {
///   print( text );
/// } );
/// ```
/// [subdir] indicates a subdirectory where the file is located, e.g. for
/// assets/mydir/myfile.txt:
/// ```dart
/// wxLoadStringFromResource( "myfile.txt", subdir: "mydir", (text) {
///   print( text );
/// } );
/// ```
void wxLoadStringFromResource( String filename, void Function( String data ) returnString, { String subdir = "" } )
{
  String path = wxGetStandardPaths().getResourcesDir();
  if (subdir.isNotEmpty) {
    path = "$path/$subdir";
  }
  path = "$path/$filename";
  _jsFetchText( path ).toDart.then( (text) {
    returnString( text.toDart );
    _scheduleIdle();
  }, onError: (Object error) {
    wxLogError( "Asset file $path not found, error: $error" );
  } );
}

// ------------------ wxLoadSVGFromResource -------------------

/// Creates a [WxBitmapBundle] from an SVG file in the resources directory
/// (default "assets"), shown at [size]. The bitmap loads asynchronously;
/// windows showing it are refreshed when it has arrived.
WxBitmapBundle wxLoadSVGFromResource( String filename, WxSize size, { String subdir = "" } )
{
  final path = subdir.isEmpty ? filename : "$subdir/$filename";
  return WxBitmapBundle.fromSVGAsset( path, size );
}

/// Sets the modifier keys of a new [WxMouseEvent] from the current state
/// of the keyboard. Implemented in each port (wxDart Flutter uses
/// HardwareKeyboard), so that the event classes can be shared.
///
/// In wxDart Web, the runtime tracks the modifiers of all keyboard and
/// pointer events of the page. The dispatcher sets them again from the
/// browser event that caused a wxDart event.
void _wxInitMouseEventModifiers( WxMouseEvent event ) {
  final m = _jsModifiers();
  event._controlDown = (m & 1) != 0;
  event._shiftDown = (m & 2) != 0;
  event._altDown = (m & 4) != 0;
  event._metaDown = (m & 8) != 0;
}

/// Sets the modifier keys of a new [WxKeyEvent] from the current state
/// of the keyboard, see [_wxInitMouseEventModifiers]
void _wxInitKeyEventModifiers( WxKeyEvent event ) {
  final m = _jsModifiers();
  event._controlDown = (m & 1) != 0;
  event._shiftDown = (m & 2) != 0;
  event._altDown = (m & 4) != 0;
  event._metaDown = (m & 8) != 0;
}
