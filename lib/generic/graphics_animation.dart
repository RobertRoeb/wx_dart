// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

/// Represents a simple image animation drawn directly into a window
/// using a [WxGraphicsContext]. You can use the simpler base class [WxAnimation]
/// to display the animation in a [WxAnimationCtrl].
/// 
/// [WxGraphicsAnimation] will load the animation asynchronously. The [draw]
/// method checks if the animation is already loaded.
/// 
/// Not to be mixed up with [WxUIAnimation] which controls animations 
/// onscreen.
/// 
/// ```dart
/// 
/// class MyWindow extends WxWindow {
/// 
///   MyWindow( WxWindow parent, int id ) : super( parent, id, wxDefaultPosition, wxDefaultSize, 0 )
///   {
///     String path = wxGetStandardPaths().getResourcesDir();
///     // Add forward or backward slash
///     if (wxIsMSW() && !wxUsesFlutter()) {
///       path += "\\throbber.gif";
///     } else {
///       path += "/throbber.gif";
///     }
/// 
///     // Create a graphics context
///     final context = WxGraphicsContext();
/// 
///     // Create animation and load it in the background
///     _animation = WxGraphicsAnimation( path, context );
/// 
///     // Bind paint handler to the paint event
///     bindPaintEvent(onPaint);
///   }
/// 
///   // define a new paint event handler
///   void onPaint( WxPaintEvent event )
///   {
///     // create paint device context during paint event
///     final dc = WxPaintDC( this );
/// 
///     // create WxGraphicsContext from WxPaintDC
///     final gc = WxGraphicsContext.fromDC(dc);
/// 
///     _animation.draw( gc, 10, 10, 20, 20, DateTime.now().millisecondsSinceEpoch );
///   }
/// 
///   late WxGraphicsAnimation _animation;
/// }
/// ```

class WxGraphicsAnimation extends WxAnimation {
  /// Creates the animation from the path for the given [WxGraphicsContext].
  WxGraphicsAnimation( super.path, WxGraphicsContext context )
  {
    load().then( (_) {
      // print( "getFrameCount: ${getFrameCount()}" );
      _duration = 0;
      for (int i = 0; i < getFrameCount(); i++) {
        _duration += getDelay(i);
        final image = getFrame(i);
        if (image != null) {
          if (!image.hasAlpha()) {
            image.initAlpha();
          }
          _frames.add( context.createBitmapFromImage(image));
        }
      }
      if (getFrameCount() != _frames.length) {
        wxLogError( "Failed to convert frames to WxGraphicsBitmaps" );
      } else {
        _fullyLoaded = true;
      }
    } );
  }

  /// Returns the duration of the animation. This is only known once the 
  /// animation has been fully loaded.
  int getDuration() {
    return _duration;
  }

  /// Returns true if the animation has been fully loaded. You can safely call
  /// [draw] before that is the case.
  bool fullyLoaded() {
    return _fullyLoaded;
  }

  /// Draws the animation into the given [WxGraphicsContext] at the given position and
  /// stretches the animation to [width] and [height]. [millis] indicates which timepoint
  /// of the animation that should be drawn.
  /// 
  /// Does not draw the frame if it is not yet loaded.
  /// 
  /// If [millis] is longer than the total duration of the animation then the animation
  /// will restart (e.g. draw the respectively first frame). 
  void draw( WxGraphicsContext context, double x, double y, double width, double height, int millis )
  {
    if (_frames.isEmpty) return;
    millis = millis % _duration;
    int i;
    for (i = 0; i < getFrameCount(); i++) {
      final delay = getDelay(i);
      if (millis - delay <= 0) break;
      millis -= delay;
    }
    final bitmap = _frames[i];
    context.drawBitmap(bitmap, x, y, width, height );
  }

  final List<WxGraphicsBitmap> _frames = [];
  int _duration = 0;
  bool _fullyLoaded = false;
}
