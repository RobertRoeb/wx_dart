// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01 (wxDart Web: 2026-11-15)
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxMemoryDC ----------------------

@JS('wxc.memCanvas')
external _Ctx2D _jsMemCanvas(int handle, int width, int height, bool alpha);

/// A device context for drawing into a bitmap
/// 
/// ```dart
/// final dc = WxMemoryDC( 64, 64 );
/// dc.setBrush( wxRED_BRUSH );
/// dc.drawCircle( 32, 32, 30 );
/// final bitmap = dc.getBitmap();
/// ```
/// 
/// In wxDart Web, the bitmap has [width] x [height] pixels (one pixel per
/// unit, not scaled for high DPI screens). [getBitmap] returns the bitmap
/// the DC draws into, so it is available immediately; drawing after
/// [getBitmap] changes it, too. Without alpha, the bitmap starts black,
/// otherwise transparent.
class WxMemoryDC extends WxDC {
  /// Creates the memory DC and will create a [WxBitmap] of size
  /// [width] and [height] at some point. the bitmap will have
  /// an alpha channel depending on [withAlpha].
  WxMemoryDC( int width, int height, { bool withAlpha=true} )
  {
    _width = max( width, 1 );
    _height = max( height, 1 );
    _withAlpha = withAlpha;
    _handle = _nextBitmapHandle++;
    _init( _jsMemCanvas( _handle, _width, _height, withAlpha ), null );
    // pixels, not DIPs
    _dpr = 1.0;
    _contentScaleFactor = 1.0;
    _applyTransform();
    _bitmap = WxBitmap._fromCanvas( _handle, _width, _height );
  }

  int _width = -1;
  int _height = -1;
  bool _withAlpha = false;
  late final int _handle;
  late final WxBitmap _bitmap;

  /// Recording of drawing operations is ongoing. Once the
  /// bitmap has been retrieved, this reports false.
  bool isRecording() {
    return true;
  }

  /// Returns true if the bitmap has an alpha channel
  bool hasAlpha() {
    return _withAlpha;
  }

  /// Retrieve the final bitmap. Afterwards, you cannot draw in the
  /// [WxMemoryDC] anymore.
  WxBitmap getBitmap() {
    return _bitmap;
  }

  @override
  WxSize getSize() {
    return WxSize( _width, _height );
  }
}
