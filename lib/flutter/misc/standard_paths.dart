// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// -------------------- wxStandardPaths -----------------------

WxStandardPaths? _theStandardPaths;

/// Returns single global instance of [WxStandardPaths]. Most typical
/// usage is for loading resources:
/// 
/// ```dart
///  String assetPath = wxGetStandardPaths().getResourcesDir();
/// ```
WxStandardPaths wxGetStandardPaths() {
  if (_theStandardPaths != null) {
    return _theStandardPaths!;
  }

  _theStandardPaths = WxStandardPaths();
  return _theStandardPaths!;
}

// ------------------------- wxStandardPaths ----------------------

/// Helper class to query standard directories. This class is used
/// internally when loading assets such as images. Importantly,
/// [getResourcesDir] returns the path to the assets.
/// 
/// ```dart
///  // create WxBitmapBundle from lib/assets/wxWidgets.png
///  final bundle = WxBitmapBundle.fromPNGAsset( "wxWidgets.png" );
/// 
///  // create WxStaticBitmap
///  final staticbitmap = WxStaticBitmap( this, -1, bundle ); 
/// ```

class WxStandardPaths extends WxClass {
  WxStandardPaths();

  /// Returns the full path to the executable including the filename
  /// 
  /// Not supported on the Web
  String getExecutablePath( ) {
    if (wxIsWeb()) {
      return "/";
    }
    return Platform.resolvedExecutable;
  }

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
  String getResourcesDir( { bool useInstalledDirectory = false } ) {
    return "lib/assets";
  }

  static String _temporaryDir = "/";

  /// Returns the directory where temporary files should be stored
  /// 
  /// Not supported on the Web
  String getTempDir( ) {
    return _temporaryDir;
  }

  static String _configDir = "/";

  /// Returns the directory where configuration files should be stored
  /// 
  /// Not supported on the Web
  String getConfigDir( ) {
    return _configDir;
  }

  static String _documentsDir = "/";

  /// Returns the directory where documents should be stored
  /// 
  /// Not supported on the Web
  String getDocumentsDir( ) {
    return _documentsDir;
  }
}
