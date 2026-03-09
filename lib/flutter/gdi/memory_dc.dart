// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxMemoryDC ----------------------

/// Device context (drawing class) that draws into a [WxBitmap]. 
/// 
/// The bitmap created in [getBitmap] and you cannot draw into
/// the [WxMemoryDC] after retrieving that bitmap.
/// 
/// ```dart
///  final dc = WxMemoryDC(100, 100);
///  dc.setPen( wxTRANSPARENT_PEN );
///  dc.setPen( wxRED_PEN );
///  dc.drawCircle( 50, 50, 20 ); 
///  // create bitmap from it
///  final bitmap = dc.getBitmap();
/// ```

class WxMemoryDC extends WxDC {

  /// Creates the memory DC and will create a [WxBitmap] of size
  /// [width] and [height] at some point. the bitmap will have
  /// an alpha channel depending on [withAlpha].
  WxMemoryDC( int width, int height, { bool withAlpha=true} )
  {
    _width = width;
    _height = height;
    _withAlpha = withAlpha;
    _recorder = ui.PictureRecorder();
    _canvas = Canvas( _recorder );
    _canvas.save();
    if (!_recorder.isRecording) {
      wxLogError( "Failed to set up WxMemoryDC" );
    }
  }

  /// Recording of drawing operations is ongoing. Once the
  /// bitmap has been retrieved, this reports false.
  bool isRecording() {
    return _recorder.isRecording;
  }

  /// Retrieve the final bitmap. Afterwards, you cannot draw in the
  /// [WxMemoryDC] anymore.
  WxBitmap getBitmap() {
    final picture = _recorder.endRecording();
    return WxBitmap._fromPicture(picture, _width, _height );
  }

  int _width = -1;
  int _height = -1;
  bool _withAlpha = false;
  late ui.PictureRecorder _recorder;
}

