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
///
/// To be used with [WxDropSource], [WxDropTarget]

abstract class WxDataObject extends WxClass {

  /// Returns a list of supported formats in the given [direction]
  List<WxDataFormat> getFormats( { int direction = wxDATAOBJECT_DIR_GET } ) {
    return [];
  }

  /// Returns the preferred format in the given [direction]
  WxDataFormat getPreferredFormat( { int direction = wxDATAOBJECT_DIR_GET } );

  /// Returns true if the [format] is supported in the given [direction].
  bool isSupported( WxDataFormat format, { int direction = wxDATAOBJECT_DIR_GET } ) {
    return false;
  }

  /// Needs to be called to transfers actual data to the [WxDataObject]
  /// in the given [format]
  /// 
  /// It is up the concrete implementation of this class to convert it
  /// to a usuable format such as a string or an image.
  void setData( WxDataFormat format, Uint8List data ) {
  }

  /// Gets the data from the [WxDataObject] in the given format.
  /// 
  /// Returns null if no such data is available.
  Uint8List? getData( WxDataFormat format ) {
    return null;
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
/// 
/// To be used with [WxDropSource], [WxDropTarget]

class WxTextDataObject extends WxDataObject {
  /// Creates a [WxTextDataObject] containing the [text]
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

  /// Sets raw data and converts is to a String
  @override
  void setData( WxDataFormat format, Uint8List data )
  {
    if (format.getId() != "text/plain") {
      wxLogError( "Wrong data transferred to WxTextDataObject (${format.getId()})." );
      _text = "";
      return;
    }
    final utf8Decoder = utf8.decoder;
    _text = utf8Decoder.convert( data );
  }

  @override
  Uint8List? getData( WxDataFormat format ) {
    final utf8Encoder = utf8.encoder;
    return utf8Encoder.convert( _text );
  }
  /// Returns WxDataFormat( wxDF_TEXT )
  @override
  List<WxDataFormat> getFormats( { int direction = wxDATAOBJECT_DIR_GET } ) {
    return [ WxDataFormat( wxDF_TEXT ) ];
  }

  /// Returns WxDataFormat( wxDF_TEXT )
  @override
  WxDataFormat getPreferredFormat( { int direction = wxDATAOBJECT_DIR_BOTH } ) {
    return WxDataFormat( wxDF_TEXT );
  }

  /// Returns true if [format] is WxDataFormat( wxDF_TEXT ) or WxDataFormat( wxDF_UNICODETEXT )
  @override
  bool isSupported( WxDataFormat format, { int direction = wxDATAOBJECT_DIR_GET } ) {
    return (format.getType() == wxDF_TEXT) || (format.getType() == wxDF_UNICODETEXT);
  }
}

// ------------------------- wxFileDataObject ----------------------

/// Specialized [WxDataObject] to hold a list of file names/paths.
/// 
/// To be used with [WxDropSource], [WxDropTarget]

class WxFileDataObject extends WxDataObject {
  WxFileDataObject( );

  final List <String> _filenames = [];

  void addFile( String file ) {
    _filenames.add( file );
  }

  List<String> getFilenames( ) {
    return _filenames;
  }

  /// Returns WxDataFormat( wxDF_FILENAME )
  @override
  List<WxDataFormat> getFormats( { int direction = wxDATAOBJECT_DIR_GET } ) {
    return [ WxDataFormat( wxDF_FILENAME ) ];
  }
  /// Returns WxDataFormat( wxDF_FILENAME )
  @override
  WxDataFormat getPreferredFormat( { int direction = wxDATAOBJECT_DIR_BOTH } ) {
    return WxDataFormat( wxDF_FILENAME );
  }

  /// Returns true if [format] is WxDataFormat( wxDF_FILENAME ) ´
  @override
  bool isSupported( WxDataFormat format, { int direction = wxDATAOBJECT_DIR_GET } ) {
    return (format.getType() == wxDF_FILENAME);
  }
}

// ------------------------- wxBitmapDataObject ----------------------

/// Specialized [WxDataObject] to hold a [WxBitmap]
/// 
/// To be used with [WxDropSource], [WxDropTarget]


class WxBitmapDataObject extends WxDataObject {
  WxBitmapDataObject( WxBitmap bitmap ) {
    _bitmap = bitmap;
  }

  WxBitmap? _bitmap;

  void setBitmap( WxBitmap bitmap ) {
    _bitmap = bitmap;
  }

  WxBitmap? getBitmap( ) {
    return _bitmap;
  }
  /// Returns WxDataFormat( wxDF_BITMAP )
  @override
  List<WxDataFormat> getFormats( { int direction = wxDATAOBJECT_DIR_GET } ) {
    return [ WxDataFormat( wxDF_BITMAP ) ];
  }
  /// Returns WxDataFormat( wxDF_BITMAP )
  @override
  WxDataFormat getPreferredFormat( { int direction = wxDATAOBJECT_DIR_BOTH } ) {
    return WxDataFormat( wxDF_BITMAP );
  }

  /// Returns true if [format] is WxDataFormat( wxDF_BITMAP ) ´
  @override
  bool isSupported( WxDataFormat format, { int direction = wxDATAOBJECT_DIR_GET } ) {
    return (format.getType() == wxDF_BITMAP);
  }
}
