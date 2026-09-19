// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxAnimation ----------------------

class _AnimationFrame
{
  final ImageInfo imageInfo;
  final Duration duration;
  final WxImage? image;
  const _AnimationFrame(this.imageInfo, this.duration, this.image );
}

/// Represents a simple image animation owned by [WxAnimationCtrl].
/// 
/// You can used the derived class [WxGraphicsAnimation] to draw 
/// the animation frames directly into a window using a [WxGraphicsContext].
/// 
/// Not to be mixed up with [WxUIAnimation] which controls animations 
/// onscreen.
///
/// This is how to retrieve the individual frames of an animation and
/// convert them to [WxBitmap]s. You need to call [load] as the animation
/// is loaded asynchronously.
/// 
/// ```dart
///  String path = wxGetStandardPaths().getResourcesDir();
///  // Add forward or backward slash
///  if (wxIsMSW() && !wxUsesFlutter()) {
///    path += "\\throbber.gif";
///  } else {
///    path += "/throbber.gif";
///  }
/// 
///  final List<WxBitmap> frames = [];
///  final animation = WxAnimation(path);
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
    _path = path;
  }

  /// Returns true if the animation has been successfully and completely loaded
  /// 
  /// Loading is currently asynchronous in wxDart Flutter
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
    return _list.length;
  }

  /// Returns the image of [frame] in the animation.
  /// 
  /// Only available once fully loaded. Check [isOk] before.
  WxImage? getFrame( int frame ) {
    if (!_isOk) {
      wxLogError( "WxAnimation not yet loaded" );
      return null;
    }
    if ((frame < 0) || (frame >=_list.length)) return null;
    return  _list[frame].image;
  }

  /// Returns the delay of [frame] in milliseconds or -1 if the
  /// frame is to be shown continuously
  /// 
  /// Only available once fully loaded. Check [isOk] before.
  int getDelay( int frame ) {
    if (!_isOk) {
      wxLogError( "WxAnimation not yet loaded" );
      return -1;
    }
    if ((frame < 0) || (frame >=_list.length)) return -1;
    return  _list[frame].duration.inMilliseconds;
  }

  /// Returns the size of the animation
  /// 
  /// Only available once fully loaded. Check [isOk] before.
  WxSize getSize() {
    if (!_isOk) {
      wxLogError( "WxAnimation not yet loaded" );
      return WxSize.zero;
    }
    if (_list.isEmpty) return WxSize.zero;
    return WxSize( _list.first.imageInfo.image.width, _list.first.imageInfo.image.height );
  }

  /// Loads the animation asynchronously. Call this if you need to access the
  /// individual frame as [WxImage]s.
  Future<void> load() async
  {
    if (_isOk) {
      wxLogError( "Animation already loaded" );
      return;
    }

    final data = await rootBundle.load(_path);
    ui.Codec codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(),
        allowUpscaling: false,
    );
    for (int i = 0; i < codec.frameCount; i++) {
      final frameInfo = await codec.getNextFrame();
      final uiImage = frameInfo.image;
      final sizeRGBA = uiImage.width * uiImage.height * 4;
      final byteData = await uiImage.toByteData();
      if (byteData!.lengthInBytes != sizeRGBA) {
        wxLogError( "WxAnimation frame data of $_path not available as RGBA" );
      }
      _list.add(
        _AnimationFrame(
          ImageInfo(image: frameInfo.image),
          frameInfo.duration,
          byteData.lengthInBytes == sizeRGBA 
            ? WxImage.fromRGBA( uiImage.width, uiImage.height, byteData.buffer.asUint8List() )
            : null
        ),
      );
    }
    _isOk = true;
  }

  late String _path;
  bool _isOk = false;
  final List<_AnimationFrame> _list = [];
}

