// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------ Helper functions -----------------

_wxInitMouseEventModifiers( WxMouseEvent event )
{
  final keyboard = HardwareKeyboard.instance;
  event._altDown = keyboard.isAltPressed;
  event._controlDown = keyboard.isControlPressed;
  event._metaDown = keyboard.isMetaPressed;
  event._shiftDown = keyboard.isShiftPressed;
}

_wxInitKeyEventModifiers( WxKeyEvent event )
{
  final keyboard = HardwareKeyboard.instance;
  event._altDown = keyboard.isAltPressed;
  event._controlDown = keyboard.isControlPressed;
  event._metaDown = keyboard.isMetaPressed;
  event._shiftDown = keyboard.isShiftPressed;
}

// ------------------ Operating system -----------------

/// Returns true if the Flutter backend is used
/// 
/// see [wxUsesNative], [wxUsesHTML], [wxIsWeb], [wxIsLinux], [wxIsMac], [wxIsMSW]
bool wxUsesFlutter() {
   return true;
}

/// Returns true if the Native backend is used
/// 
/// see [wxUsesFlutter], [wxUsesHTML], [wxIsWeb], [wxIsLinux], [wxIsMac], [wxIsMSW]
bool wxUsesNative() {
   return false;
}

/// Returns true if the Web/Javascript backend is used
/// 
/// see [wxUsesNative], [wxUsesFlutter], [wxIsWeb], [wxIsLinux], [wxIsMac], [wxIsMSW]
bool wxUsesHTML() {
   return false;
}

/// Returns true if the app is running on the web
bool wxIsWeb() {
  return (kIsWeb);
}

/// Returns true if the app is running on Linux (wxDart Native or wxDart Flutter)
bool wxIsLinux() {
    if (!kIsWeb) {
      return Platform.isLinux;
    } else {
      return false;
    }
}

/// Returns true if the app is running on macOS (wxDart Native or wxDart Flutter)
bool wxIsMac() {
    if (!kIsWeb) {
      return Platform.isMacOS;
    } else {
      return false;
    }
}

/// Returns true if the app is running on Windows (wxDart Native or wxDart Flutter)
bool wxIsMSW() {
    if (!kIsWeb) {
      return Platform.isWindows;
    } else {
      return false;
    }
}

/// Returns true if the app is running on Android (only possible in wxDart Flutter)
bool wxIsAndroid() {
    if (!kIsWeb) {
      return Platform.isAndroid;
    } else {
      return false;
    }
}

/// Returns true if the app is running on iOS (wxDart Native or wxDart Flutter)
bool wxIsIOS() {
    if (!kIsWeb) {
      return Platform.isIOS;
    } else {
      return false;
    }
}

// ------------------------- wxNewWindowId ----------------------

const int _wxFirstWindowID = -10;
int _wxLastWindowID = _wxFirstWindowID;

/// Use this to register a new window id. This will get called automatically
/// by windows, menu items and toolbar items given the the ID wxID_ANY (-1)
/// 
/// The function returns a unique negative window ID 
int _wxNewControlId() {
  _wxLastWindowID--;
  return _wxLastWindowID;
}

// --------------- dynamic type to variantType -----------------

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

// --------------------- wxLoadStringFromResource ---------------------

/// Reads an entire file as a string and returns the string as the _data_
/// paramater in the callback. Note that in wxDart Flutter on the web,
/// the file gets transfered from the server via HTTP.
/// 
/// If the file is located in lib/assets/myfile.txt
/// 
/// Example usage:
/// ```dart
/// wxLoadStringFromResource( "myfile.txt", (text) {
///   print( text );
/// }
/// ```
/// [subdir] indicates a subdirectory where the file is located.
/// If the file is located in
/// lib/assets/mydir/myfile.txt then use this
/// 
/// Example usage:
/// ```dart
/// wxLoadStringFromResource( "myfile.txt", subdir: "mydir", (text) {
///   print( text );
/// }
/// ```
/// 
/// In wxDart Native, you can eiher copy the files to the final destination
/// on the respective plaform as outlined in  [WxStandardPaths.getResourcesDir]
/// or keep them in lib/assets locally. wxDart Native will look in both on
/// Windows and Linux (in macOS, they have to be to be in the Resources folder
/// of your package as you won't have read access anywhere else).

void wxLoadStringFromResource( String filename, void Function( String data ) returnString, { String subdir = "" } ) 
{
    String path = "lib/assets";
    if (subdir.isNotEmpty) {
      path = "$path/$subdir"; 
    }
    path = "$path/$filename";
    rootBundle.loadString(path).then( (text) {      
      returnString( text );
    }).catchError((error) {
      wxLogError( "Asset file $path not found, error: $error" );
  });
}

/// Read an image from file or asset and returns the RGBA data in the callback.
/// This will occur synchronously in wxDart Native and asynchronously in
/// wxDart Flutter.
/// If the file is located in lib/assets/myimage.png 
/// 
/// Example usage:
/// ```dart
/// wxLoadRGBAFromResource( "myimage.png", (RGBA, width, height) {
///   // do something with RGBA data ...
/// } );
/// ```
/// 
/// [subdir] indicates a subdirectory where the file is located, 
/// but forward slashes in the filename are allowed on all platforms
/// 
/// Example usage:
/// ```dart
/// wxLoadRGBAFromResource( "images/myimage.png", (RGBA, width, height) {
///   // do something with RGBA data ...
/// } );
/// wxLoadRGBAFromResource( "myimage.png", subdir: "images", (RGBA, width, height) {
///   // do something with RGBA data ...
/// } );
/// ```

void wxLoadRGBAFromResource( String filename, void Function( Uint8List rgba, int width, int height ) returnRGBA,
 { int format = wxBITMAP_TYPE_PNG, String subdir = "" } )
{
    String path = wxGetStandardPaths().getResourcesDir();
    if (subdir.isNotEmpty) {
      path = "$path/$subdir"; 
    }
    path = "$path/$filename";
    rootBundle.load(path).then( (data) async {   
      final codec = await ui.instantiateImageCodec( data.buffer.asUint8List() );
      final uiImage = (await codec.getNextFrame()).image;
      final sizeRGBA = uiImage.width * uiImage.height * 4;
      final byteData = await uiImage.toByteData( format: ui.ImageByteFormat.rawStraightRgba );
      if (byteData == null) {
        wxLogError( "Failed to decode image in $path" );
        return;
      }
      if (byteData!.lengthInBytes != sizeRGBA) {
        wxLogError( "Image data of $path not available as RGBA" );
        return;
      }
      final rgba = byteData.buffer.asUint8List();
      returnRGBA( rgba, uiImage.width, uiImage.height );

    }).catchError((error) {
      wxLogError( "Asset file $path not found, error: $error" );
  });
}

// ------------------ wxLoadImageFromResource -------------------

/// Read an image from file or asset and returns the image in the callback.
/// This will occur synchronously in wxDart Native and asynchronously in
/// wxDart Flutter.
/// If the file is located in lib/assets/myimage.png 
/// 
/// Example usage:
/// ```dart
/// wxLoadImageFromResource( "myimage.png", (image) {
///   // do something with image ...
/// } );
/// ```
/// [subdir] indicates a subdirectory where the file is located, 
/// but forward slashes in the filename are allowed on all platforms
/// 
/// Example usage:
/// ```dart
/// wxLoadImageFromResource( "images/myimage.png", (image) {
///   // do something with image ...
/// } );
/// wxLoadImageFromResource( "myimage.png", subdir: "images", (image) {
///   // do something with image ...
/// } );
/// ```

void wxLoadImageFromResource( String filename, void Function( WxImage image ) returnImage, { int format = wxBITMAP_TYPE_PNG, String subdir = "" } ) 
{
    String path = wxGetStandardPaths().getResourcesDir();
    if (subdir.isNotEmpty) {
      path = "$path/$subdir"; 
    }
    path = "$path/$filename";
    rootBundle.load(path).then( (data) async {   
      final codec = await ui.instantiateImageCodec( data.buffer.asUint8List() );
      final uiImage = (await codec.getNextFrame()).image;
      final sizeRGBA = uiImage.width * uiImage.height * 4;
      final byteData = await uiImage.toByteData( format: ui.ImageByteFormat.rawStraightRgba );
      if (byteData == null) {
        wxLogError( "Failed to decode image in $path" );
        return;
      }
      if (byteData!.lengthInBytes != sizeRGBA) {
        wxLogError( "Image data of $path not available as RGBA and cannot be converted to WxImage" );
        return;
      }
      final image = WxImage.fromRGBA( uiImage.width, uiImage.height, byteData.buffer.asUint8List() );
      returnImage( image );

    }).catchError((error) {
      wxLogError( "Asset file $path not found, error: $error" );
  });
}

// ------------------ wxLoadSVGFromResource -------------------

WxBitmapBundle wxLoadSVGFromResource( String filename, WxSize size, { String subdir = "" } ) 
{
    String path = wxGetStandardPaths().getResourcesDir();
    if (subdir.isNotEmpty) {
      path = "$path/$subdir"; 
    }
    return WxBitmapBundle.fromSVGAsset( path, size );
}

// -------------------- wxFindWindowAtPoint -----------------------

WxWindow? _wxFindWindowAtPointRecursive( WxWindow current, WxPoint pos )
{
  final currentPos = current.getPosition();
  final rect = WxRect.fromPositionAndSize( currentPos, current.getSize() );
  if (!rect.containsPoint(pos)) return null;
  final newPos = WxPoint( pos.x - currentPos.x, pos.y - currentPos.y );
  for (final child in current._getChildren())
  {
    if (!child.isShown()) continue;
    if (child is WxNonOwnedWindow) continue;
    final res = _wxFindWindowAtPointRecursive( child, newPos );
    if (res != null) return res;
  }
  return current;
}

/// Returns the window under the screen position given by [pos]
/// 
/// Uses the FlutterView under wxDart Flutter as the screen.
WxWindow? wxFindWindowAtPoint( WxPoint pos )
{
  for (int i = _topLevelWindows.length-1; i >= 0; i--) {
    final tlw = _topLevelWindows[i];
    final res = _wxFindWindowAtPointRecursive( tlw, pos );
    if (res != null) return res;
  }
  return null;
}

// -------------------- wxGetMousePosition -----------------------

/// Returns the position of the mouse on the screen
WxPoint wxGetMousePosition() {
  return _globalMousePosition;
}

// -------------------- wxLaunchDefaultBrowser -----------------------

/// Launches the default browser
/// 
/// Example usage:
///```dart
///  wxLaunchDefaultBrowser( "https://pub.dev/packages/wx_dart" );
///``` 
bool wxLaunchDefaultBrowser( String url, { int flags = 0 } ) {
  final Uri uri = Uri.parse( url );
  launchUrl(uri);
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
/// In wxDart Flutter, the document is saved with the save dialog of the
/// system (package file_picker): on the desktop, the user chooses folder
/// and name; on Android and iOS, the system's document picker writes the
/// file; on the web, the browser downloads it. [wxEXPORT_SHARE] needs a
/// share sheet (e.g. package share_plus) and saves for now. [message] is
/// the title of the dialog.
///
/// Returns wxID_OK if the document was saved or shared, wxID_CANCEL if the
/// user cancelled, and wxID_ANY if it is not known.
///
/// ```dart
/// final out = WxPDFUint8ListOutput();
/// final gc = WxPDFGraphicsContext( out, title: "Menu" );
/// await gc.generate( pageCount: 2, renderPage: drawPage );
/// await wxExportDocument( this, await out.result, "Menu.pdf", mimeType: "application/pdf" );
/// ```
Future<int> wxExportDocument( WxWindow? parent, Uint8List data, String fileName,
    { String mimeType = '', String message = '', int style = wxEXPORT_DEFAULT } ) async {
  // file_picker writes the bytes itself on Android, iOS and the web; on the
  // desktop it only returns the path chosen by the user
  final writesItself = kIsWeb || Platform.isAndroid || Platform.isIOS;
  final dot = fileName.lastIndexOf('.');
  final ext = dot > 0 ? fileName.substring(dot + 1) : '';
  try {
    final path = await FilePicker.platform.saveFile(
      dialogTitle: message.isNotEmpty ? message : null,
      fileName: fileName,
      bytes: writesItself ? data : null,
      type: ext.isEmpty ? FileType.any : FileType.custom,
      allowedExtensions: ext.isEmpty ? null : [ext],
      lockParentWindow: true,
    );
    if (path == null) {
      // the web gives no feedback for a download
      return kIsWeb ? wxID_ANY : wxID_CANCEL;
    }
    if (!writesItself) {
      await File(path).writeAsBytes(data, flush: true);
    }
    if ((style & wxEXPORT_OPEN) != 0 && !kIsWeb) {
      launchUrl(Uri.file(path));
    }
    return wxID_OK;
  } catch (e) {
    wxLogError("wxExportDocument: $e");
    return wxID_ANY;
  }
}
