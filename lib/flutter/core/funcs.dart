// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------ Operating system -----------------

/// Returns true if the Flutter backend is used (false for wxDart Native)
bool wxUsesFlutter() {
   return true;
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
/// [filename] is the filename relative to the directory returned from 
/// [WxStandardPaths.getResourcesDir]. If the file is located in
/// lib/assets/myfile.txt then use this
/// 
/// ```dart
/// wxLoadStringFromResource( "myfile.txt", (text) {
///   print( text );
/// }
/// ```
/// [subdir] indicates a subdirectory where the file is located.
/// If the file is located in
/// lib/assets/mydir/myfile.txt then use this
/// 
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

// ------------------ wxLoadSVGFromResource -------------------

WxBitmapBundle wxLoadSVGFromResource( String filename, WxSize size, { String subdir = "" } ) 
{
    String path = "lib/assets";
    if (subdir.isNotEmpty) {
      path = "$path/$subdir"; 
    }
    return WxBitmapBundle.fromSVGAsset( path, size );
}

// -------------------- wxGetMousePosition -----------------------

/// Returns the position of the mouse on the screen
WxPoint wxGetMousePosition() {
  return _globalMousePosition;
}

// -------------------- wxLaunchDefaultBrowser -----------------------

bool wxLaunchDefaultBrowser( String url, { int flags = 0 } ) {
  final Uri uri = Uri.parse( url );
  launchUrl(uri);
  return true;
}