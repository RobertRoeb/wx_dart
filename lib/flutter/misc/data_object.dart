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
        _type = wxDF_BITMAP;
        _id = "image/png";
        return;
      case wxDF_PNG: 
        _type = wxDF_BITMAP;
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

  /// Sets raw data (UTF8) and converts is to a String
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

  /// Converts the text to the raw data (in UTF8)
  @override
  Uint8List? getData( WxDataFormat format ) {
    if (format.getId() != "text/plain") {
      wxLogError( "Wrong data format request." );
      _text = "";
      return null;
    }
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

  List <String> _filenames = [];

  /// Add file URI to the data object
  void addFile( String file ) {
    _filenames.add( file );
  }

  /// Returns the list of file URIs in the data object
  List<String> getFilenames( ) {
    return _filenames;
  }

  int _getPosOfCRLFOrEnd( Uint8List data, int start ) {
    int pos = start;
    for (; pos < data.buffer.lengthInBytes-1; pos++) {
      if ((data[pos] == 13) && (pos < data.buffer.lengthInBytes-1) && (data[pos+1] == 10)) {
        return pos;
      }
    }
 
    return pos == start ? -1 : pos+1;
  }

  /// Sets raw data in "text/uri-list" format and converts is to a list of file URIs
  @override
  void setData( WxDataFormat format, Uint8List data )
  {
    _filenames = [];
    if (format.getId() != "text/uri-list") {
      wxLogError( "Wrong data transferred to WxFileDataObject (${format.getId()})." );
      return;
    }
    final utf8Decoder = utf8.decoder;
    int start = 0;
    int end = _getPosOfCRLFOrEnd( data, start );
    while (end != -1) {
      final uri = utf8Decoder.convert( data, start, end );
      _filenames.add( uri );
      start = end+2;
      end = _getPosOfCRLFOrEnd( data, start );
    }
  }

  /// Returns the file URIs to the "text/uri-list" format
  @override
  Uint8List? getData( WxDataFormat format ) {
    if (format.getId() != "text/uri-list") {
      wxLogError( "Wrong data format request." );
      return null;
    }
    late Uint8List data;
    int size = 0;
    final utf8Encoder = utf8.encoder;
    for (int i = 0; i < _filenames.length; i++) {
      final fileData = utf8Encoder.convert( _filenames[i] );
      if (size > 0) {
        final newData = Uint8List( size + 2 + fileData.buffer.lengthInBytes );
        int pos = 0;
        for ( ; pos < size; pos++) {
          newData[pos] = data[pos];
        }
        newData[pos] = 13;
        pos++;
        newData[pos] = 10;
        pos++;
        int filePos = 0;
        for ( ; pos < size + 2 + fileData.buffer.lengthInBytes; pos++) {
          newData[pos] = fileData[filePos];
          filePos++;
        }
        data = newData;
        size = data.buffer.lengthInBytes;
      } else {
        data = fileData;
        size = data.buffer.lengthInBytes;
      }
    }
    return data;
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
    _createPNG().then( (data) {
      _data = data;
    } );
  }

  WxBitmapDataObject._fromUint8List( Uint8List data ) {
    _data = data;
    _bitmap = WxBitmap._fromUint8List(data);
  }

  WxBitmap? _bitmap;
  Uint8List? _data;

  void setBitmap( WxBitmap bitmap ) {
    _bitmap = bitmap;
    _createPNG().then( (data) {
      _data = data;
    } );
  }

  /// Sets raw data in "image/pmg" format and converts is to a [WxBitmap]
  @override
  void setData( WxDataFormat format, Uint8List data )
  {
    _bitmap = null;
    if (format.getId() != "image/png") {
      wxLogError( "Wrong data transferred to WxBitmapDataObject (${format.getId()})." );
      return;
    }
    _bitmap = WxBitmap._fromUint8List(data);
  }

  @override
  Uint8List? getData( WxDataFormat format ) {
    if (format.getId() != "image/png") {
      wxLogError( "Wrong data format request." );
      return null;
    }
    return _data;
  }

  Future<Uint8List?> _createPNG() async
  {
    if (_bitmap == null) {
      return null;
    }
    if (_bitmap!._image == null) {
      return null;
    }
    final byteData = await _bitmap!._image!.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) {
      wxLogError( "Could not convert bitmap to PNG" );
      return null;
    }
    final Uint8List pngBytes = byteData.buffer.asUint8List();
    return pngBytes;
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
