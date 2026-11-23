// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01 (wxDart Web: 2026-11-15)
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxAnimation ----------------------

int _nextAnimationHandle = 1;

/// Represents a simple image animation owned by [WxAnimationCtrl].
/// 
/// Example:
/// ```dart
/// // create animation from lib/assets/animations/circular.gif
/// final animation = WxAnimation( "animations/circular.gif" ); 
/// ```
/// 
/// Not to be mixed up with [WxUIAnimation] which controls animations 
/// onscreen.
///
/// This is how to retrieve the individual frames of an animation and
/// convert them to [WxBitmap]s. You need to call [load] as the animation
/// is loaded asynchronously.
/// 
/// Example usage to retrieve images from animation:
/// ```dart
///  final List<WxBitmap> frames = [];
///  final animation = WxAnimation("throbber.gif");
///  animation.load().then( (_) {
///    if (!animation.isOk()) {
///      wxLogError( "animation did not load" );
///      return;
///    }
///    for (int i = 0; i < animation.getFrameCount(); i++ ) {
///      final image = animation.getFrame(i);
///      if (image != null) {
///        if (!image.hasAlpha()) {
///         // this will convert from mask to alpha which is
///         // currently required in wxDart Native
///         image.initAlpha();
///      }
///      frames.add( WxBitmap.fromImage(image) );
///    }
///    refresh();
///  } );
/// ```

class WxAnimation extends WxObject {
  /// Creates an animation from a GIF image. Supports WebP and ANI
  /// formats on wxDart Native (Windows, macOS) as well.
  ///
  /// Note that the wxDart Native implementation does not accept animations
  /// that are incorrectly encoded as GIF87a files, only GIF89a files.
  ///
  /// [path] is relative to [WxStandardPaths.getResourcesDir]
  WxAnimation( String path ) {
    _path = "${wxGetStandardPaths().getResourcesDir()}/$path";
    _handle = _nextAnimationHandle++;
  }

  late final String _path;
  late final int _handle;
  bool _isOk = false;
  WxSize _size = WxSize.zero;
  Future<void>? _loading;

  /// Returns true if the animation has been successfully and completely loaded
  ///
  /// Loading is currently asynchronous in wxDart Flutter
  ///
  /// Loading is asynchronous in wxDart Web, see [load]
  bool isOk() {
    return _isOk;
  }

  /// Returns the number of frames in the animation.
  /// 
  /// Only available once fully loaded. Check [isOk] before.
  int getFrameCount() {
    if (!_isOk) {
      wxLogError( "WxAnimation not yet loaded" );
      return 0;
    }
    return _jsAnimFrameCount( _handle );
  }

  /// Returns the image of [frame] in the animation.
  /// 
  /// Only available once fully loaded. Check [isOk] before.
  WxImage? getFrame( int frame ) {
    if (!_isOk) {
      wxLogError( "WxAnimation not yet loaded" );
      return null;
    }
    final rgba = _jsAnimFrame( _handle, frame );
    if (rgba == null) return null;
    return WxImage.fromRGBA( _size.x, _size.y, rgba.toDart );
  }

  /// Returns the delay of [frame] in milliseconds or -1 if the
  /// frame is to be shown continuously
  ///
  /// Only available once fully loaded. Check [isOk] before.
  ///
  /// As browsers do, delays of up to 10 ms are reported as 100 ms.
  /// Only available once fully loaded. Check [isOk] before.
  int getDelay( int frame ) {
    if (!_isOk) {
      wxLogError( "WxAnimation not yet loaded" );
      return -1;
    }
    return _jsAnimDelay( _handle, frame );
  }

  /// Returns the size of the animation
  /// 
  /// Only available once fully loaded. Check [isOk] before.
  WxSize getSize() {
    if (!_isOk) {
      wxLogError( "WxAnimation not yet loaded" );
      return WxSize.zero;
    }
    return _size;
  }

  /// Loads the animation asynchronously. Call this if you need to access the
  /// individual frame as [WxImage]s.
  Future<void> load() {
    _loading ??= _load();
    return _loading!;
  }

  Future<void> _load() async {
    try {
      final size = await _jsAnimLoad( _handle, _path ).toDart;
      _size = WxSize( size.w, size.h );
      _isOk = true;
    } catch (error) {
      wxLogError( "Could not load animation $_path: $error" );
    }
    _scheduleIdle();
  }

  @override
  void dispose() {
    _jsAnimFree( _handle );
    super.dispose();
  }
}
