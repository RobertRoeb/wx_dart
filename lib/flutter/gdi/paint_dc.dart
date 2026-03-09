// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxPaintDC ----------------------

/// Main device context (drawing class) for drawing into a window. The
/// interface is derived from [WxReadOnlyDC] and [WxDC].
/// 
/// This class can only be used in a paint event handler.
/// 
/// Here is an example of a how [WxPaintDC] is used.
/// 
///```dart
/// // Derive new class from WxWindow
/// class MyWindow extends WxWindow {
/// 
///   MyWindow( WxWindow parent, int id ) : super( parent, id, wxDefaultPosition, wxDefaultSize, 0 )
///   {
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
///     // draw something
///     dc.drawLine( 10, 10, 100, 100 );
///   }
/// }
/// ```
/// 
/// It is important to note that the [WxPaintDC] acts in unscrolled window
/// coordinates and does not know anything about scrolling. Adapt the
/// coordinate system using [WxScrolledWindow.doPrepareDC] like this:
/// 
/// ```dart
/// // Derive new class from WxWindow
/// class MyWindow extends WxScrolledWindow {
///   MyWindow( super.parent, super.id )
///   {
///     // Create scroll area of 600x2000 pixel
///     setScrollbars(10, 10, 60, 200 );
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
///     // adjust for scrolling
///     doPrepareDC(dc);
/// 
///     // draw a line
///     dc.drawLine( 10, 10, 100, 100 );
///   }
/// }
/// ```

class WxPaintDC extends WxDC {
  WxPaintDC( this._window ) {
    if (_window._canvas != null) {
      _canvas = _window._canvas!;
      _canvas.save();
      if (_window._scrollOwnerWindow != null) {
        _deviceLocalOriginX = _window._scrollOwnerWindow!.getDeviceOffsetX();
        _deviceLocalOriginY = _window._scrollOwnerWindow!.getDeviceOffsetY();
      }
    } else {
      wxLogError( "No canvas to draw onto." );
    }
  }

  final WxWindow _window;

}