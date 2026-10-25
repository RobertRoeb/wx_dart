// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxDataFormat ----------------------

/// Helper class to holding data formats for data exchange
/// between apps or within the app, most usually for drag and drop
/// and clipboard operations.
/// 
/// see [WxDataObject], [WxDropSource], [WxDropTarget]
/// 
/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxDF_INVALID  | Not suported on this platform  |
/// | wxDF_TEXT | Text |
/// | wxDF_UNICODETEXT | Text |
/// | wxDF_BITMAP | Bitmap |
/// | wxDF_PNG | PNG Image |
/// | wxDF_FILENAME | Filename(s) from dropping |
/// | wxDF_PRIVATE | Custom or private data |

class WxDataFormat extends WxClass {
  WxDataFormat( int type ) {
    switch (type) {
      case wxDF_TEXT: 
        _type = wxDF_TEXT;
        _id = "text/plain";
        return;
      case wxDF_UNICODETEXT: 
        _type = wxDF_UNICODETEXT;
        _id = "text/plain";
        return;
      case wxDF_BITMAP: 
        _type = wxDF_PNG;
        _id = "image/png";
        return;
      case wxDF_PNG: 
        _type = wxDF_PNG;
        _id = "image/png";
        return;
      case wxDF_FILENAME:
        _type = wxDF_FILENAME;
        _id = "text/uri-list";
        return;
      case wxDF_PRIVATE:
        _type = wxDF_PRIVATE;
        _id = "text/plain";
        return;
    }
    _type = wxDF_INVALID;
  }

  String _id = "";
  int _type = 0;

  /// Returns the platform dependent string representation of the data format.
  String getId( ) {
    return _id;
  }

  /// Returns the type
  /// 
  /// Returns wxDF_INVALID if not supported.
  int getType( ) {
    return _type;
  }
}

// ------------------------- wxDataObject ----------------------

const int wxDATAOBJECT_DIR_GET = 0;
const int wxDATAOBJECT_DIR_SET = 1;
const int wxDATAOBJECT_DIR_BOTH = 2;

/// Abstract base class for holding data for data exchange
/// between apps or within the app, most usually for drag and drop
/// and clipboard operations.
/// 
/// The class can hold multiple formats. See concrete implementations
/// [WxTextDataObject], [WxBitmapDataObject] and [WxFileDataObject].
/// 
/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxDATAOBJECT_DIR_GET | 0 |
/// | wxDATAOBJECT_DIR_SET | 1 |
/// | wxDATAOBJECT_DIR_BOTH | 2 |

abstract class WxDataObject extends WxClass {

  /// Returns the number of supported formats
  int getFormatCount( ) {
    return 0;
  }

  /// Returns true if the [format] is supported in the given [direction].
  bool isSupported( WxDataFormat format, { int direction = wxDATAOBJECT_DIR_BOTH } ) {
    return false;
  }
}

// ------------------------- WxTextDataObject ----------------------

/// Specialized [WxDataObject] to hold simple text.
/// 
/// Example usage with [WxDropSource]:
///```Dart
///  // Create data object with text
///  final data = WxTextDataObject( "This is so cool" );
///
///  // Create WxDropSource with data
///  final source = WxDropSource(data, this);
///
///  // Start DnD
///  source.doDragDrop();
///```

class WxTextDataObject extends WxDataObject {
  WxTextDataObject( String text ) {
    _text = text;
  }

  String _text = "";

  /// Sets the contents of this data object
  void setText( String text ) {
    _text = text;
  }

  /// Returns the contents of this data object
  String getText( ) {
    return _text;
  }

  /// Returns 1
  @override
  int getFormatCount( ) {
    return 1;
  }

  /// Returns true of WxDataFormat( wxDF_TEXT ) or WxDataFormat( wxDF_UNICODETEXT )
  @override
  bool isSupported( WxDataFormat format, { int direction = wxDATAOBJECT_DIR_BOTH } ) {
    return (format.getType() == wxDF_TEXT) || (format.getType() == wxDF_UNICODETEXT);
  }
}

