// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxReadOnlyDC ----------------------

/// Base class for [WxDC], [WxPaintDC] and [WxInfoDC] 
/// 
/// Device contexts (DCs) define the 2D drawing API in wxDart

class WxReadOnlyDC extends WxObject {
  WxReadOnlyDC();

  WxFont? _font;
  double _signX = 1.0;
  double _signY = 1.0;
  double _scaleX = 1.0;
  double _scaleY = 1.0;
  double _userScaleX = 1.0;
  double _userScaleY = 1.0;
  double _logicalScaleX = 1.0;
  double _logicalScaleY = 1.0;
  int _logicalOriginX = 0;
  int _logicalOriginY = 0;
  int _deviceOriginX = 0;
  int _deviceOriginY = 0;
  int _deviceLocalOriginX = 0;
  int _deviceLocalOriginY = 0;

  /// Sets the font currently used in the device context
  void setFont( WxFont? font ) {
    _font = font;
  }

  /// Returns the size in pixels of [text] using the current font
  WxSize getTextExtent( String text )
  {
    TextPainter textPainter = TextPainter(
        text: TextSpan(
            text: text, 
            style: _convertTextStyle(null, _font)), 
            maxLines: 1, 
            textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return WxSize( textPainter.size.width.floor(), textPainter.size.height.floor() );
  }

  void _recalcMatrix() {
    _scaleX = _userScaleX * _logicalScaleX;
    _scaleY = _userScaleY * _logicalScaleY;
  }

  /// Set the orientation of the axis.
  /// 
  /// The default in wxDart is the origin in the top left corner
  /// of a window.
  void setAxisOrientation( bool xLeftRight, bool yBottomUp ) {
    _signX = (xLeftRight ?  1 : -1);
    _signY = (yBottomUp  ? -1 :  1);
    _recalcMatrix();
  }

  /// Sets the device context origin. 
  /// 
  /// This is used internally by [WxScrolledWindow] to account
  /// for scrolling offsets.
  /// 
  /// See [WxPaintDC] on how draw in a [WxScrolledWindow].
  
  void setDeviceOrigin( int x, int y ) {
    _deviceOriginX = x;
    _deviceOriginY = y;
    _recalcMatrix();
  }
  
  /// Gets the device context origin. 
  /// 
  /// This is used internally by [WxScrolledWindow] to account
  /// for scrolling offsets.
  WxPoint getDeviceOrigin() {
    return WxPoint( _deviceOriginX, _deviceOriginY );
  }

  /// Scale the output of the device context. On most platforms
  /// the scaling is done by the GPU and as such very efficient.
  void setUserScale( double xScale, double yScale ) {
    _userScaleX = xScale;
    _userScaleY = yScale;
    _recalcMatrix();
  }

  /// @nodoc
  void setLogicalScale( double x, double y ) {
    _logicalScaleX = x;
    _logicalScaleY = y;
    _recalcMatrix();
  }

  /// Conversion between logical and device. Used internally.
  int deviceToLogicalX( int x ) {
    return (((x - _deviceOriginX - _deviceLocalOriginX) * _signX) / _scaleX ).floor() + _logicalOriginX ;
  }

  /// Conversion between logical and device. Used internally.
  int deviceToLogicalXRel( int x ) {
    return (x / _scaleX ).floor();
  }

  /// Conversion between logical and device. Used internally.
  int deviceToLogicalY( int y ) {
    return (((y - _deviceOriginY - _deviceLocalOriginY) * _signY) / _scaleY ).floor() + _logicalOriginY ;
  }

  /// Conversion between logical and device. Used internally.
  int deviceToLogicalYRel( int y ) {
    return (y / _scaleY ).floor();
  }

  /// Conversion between logical and device. Used internally.
  int logicalToDeviceX( int x ) {
    return ( ((x - _logicalOriginX) * _signX) * _scaleX).floor() + _deviceOriginX + _deviceLocalOriginX;
  }

  /// Conversion between logical and device. Used internally.
  int logicalToDeviceXRel( int x ) {
    return (x * _scaleX).floor();
  }

  /// Conversion between logical and device. Used internally.
  int logicalToDeviceY( int y ) {
    return ( ((y - _logicalOriginY) * _signY) * _scaleY).floor() + _deviceOriginY + _deviceLocalOriginY;
  }

  /// Conversion between logical and device. Used internally.
  int logicalToDeviceYRel( int y ) {
    return (y * _scaleY).floor();
  }
}

// ------------------------- wxReadOnlyDC ----------------------

/// Implements a light weight device context for querying metrics only.
/// Typically used to call [WxDC.setFont] and [WxDC.getTextExtent].

class WxInfoDC extends WxReadOnlyDC {

  /// Create a information DC for the given [window]
  WxInfoDC( this.window ) {
      if (window._scrollOwnerWindow != null) {
        _deviceLocalOriginX = window._scrollOwnerWindow!.getDeviceOffsetX();
        _deviceLocalOriginY = window._scrollOwnerWindow!.getDeviceOffsetY();
      }
  }

  final WxWindow window;
}
