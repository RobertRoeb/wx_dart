// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxColour ----------------------

final wxBLACK = WxColour( 0, 0, 0 );
final wxWHITE = WxColour( 255, 255, 255 );
final wxRED = WxColour( 255, 0, 0 );
final wxCYAN = WxColour( 0, 255, 255 );
final wxGREEN = WxColour( 0, 255, 0 );
final wxBLUE = WxColour( 0, 0, 255 );
final wxYELLOW = WxColour( 255, 255, 0 );
final wxGREY = WxColour( 80, 80, 80 );
final wxMEDIUM_GREY = WxColour( 130, 130, 130 );
final wxLIGHT_GREY = WxColour( 192, 192, 192 );

/// Represents a colour in RGB space with an optional alpha channel.
/// 
/// This class is implemented in pure Dart on all platforms.
/// 
/// A small number of colours are predefined global objects:
/// # Global objects 
/// | Colour | value |
/// | -------- | -------- |
///  |  wxBLACK  |  WxColour( 0, 0, 0 ) | 
///  |  wxWHITE  |  WxColour( 255, 255, 255 ) | 
///  |  wxRED  |  WxColour( 255, 0, 0 ) | 
///  |  wxCYAN  |  WxColour( 0, 255, 255 ) | 
///  |  wxGREEN  |  WxColour( 0, 255, 0 ) | 
///  |  wxBLUE  |  WxColour( 0, 0, 255 ) | 
///  |  wxYELLOW  |  WxColour( 255, 255, 0 ) | 
///  |  wxGREY  |  WxColour( 80, 80, 80 ) | 
///  |  wxMEDIUM_GREY  |  WxColour( 130, 130, 130 ) | 
///  |  wxLIGHT_GREY  |  WxColour( 192, 192, 192 ) | 

class WxColour {
  /// Creates a colour from the RGB components and an optional [alpha] indicating transparency
  /// 
  /// All values are bytes ranging from 0 to 255
  WxColour( this.red, this.green, this.blue, { this.alpha = 255 } );
  /// Creates a colour from an int containing the RGB values and an optional [alpha] indicating transparency
  /// 
  /// All values are bytes ranging from 0 to 255
  WxColour.fromRGB( int rgb, { this.alpha = 255 } ) {
    red =   (0xFF & rgb);
    green = (0xFF & (rgb >> 8));
    blue =  (0xFF & (rgb >> 16));
  }
  /// Creates a colour from an int containing the RGB and the alpha transparency
  /// 
  /// All values are bytes ranging from 0 to 255
  WxColour.fromRGBA( int rgba ) {
    red =    (0xFF & rgba);
    green =  (0xFF & (rgba >> 8));
    blue =   (0xFF & (rgba >> 16));
    alpha =  (0xFF & (rgba >> 24));
  }
  int red = 0;
  int green = 0;
  int blue = 0;
  int alpha = 0;

  /// Returns the transparency (or alpha) compoment. 255 indicated fully opaque. 0 indicates fully transparent.
  int getAlpha() {
    return alpha;
  }
  /// Returns the red compoment from 0 to 255
  int getRed() {
    return red;
  }
  /// Returns the blue compoment from 0 to 255
  int getBlue() {
    return blue;
  }
  /// Returns the green compoment from 0 to 255
  int getGreen() {
    return green;
  }
  /// Returns the RGB compoments as a single int
  int getRGB() {
    return red | (green << 8) | (blue << 16);
  }
  /// Returns the RGBA compoments as a single int
  int getRGBA() {
    return red | (green << 8) | (blue << 16) | (alpha << 24) ;
  }
  /// Returns true if the colour is fully qualified
  bool isOk() {
    return true;
  }
  /// Change the lightness of the colour, 100 indicating not change, 120 indicating 20% lighter and
  /// 80 indicated 20% less bright. [percent] can be between 0 and 200.
  /// 
  /// Always returns a new instance, even if percent is 100 indicating no change.
  WxColour changeLightness( int percent )
  {
    if (percent == 100) {
      // copy, don't return this
      return WxColour(red, green, blue, alpha: alpha );
    }
    percent = percent.clamp(0, 200);  // the wx function only accepts 0-200%
    double dalpha = (percent.toDouble() - 100.0)/100.0; // convert to -1 to +1
    int bg = 255;
    if (percent > 100) {
        dalpha = 1.0 - dalpha;
    } else {
        bg = 0;
        dalpha = 1.0 + dalpha;
    }
    double newRed = bg + (dalpha * (red - bg));
    newRed = newRed.clamp( 0.0, 255.0);
    double newGreen = bg + (dalpha * (green - bg));
    newGreen = newGreen.clamp( 0.0, 255.0);
    double newBlue = bg + (dalpha * (blue - bg));
    newBlue = newBlue.clamp( 0.0, 255.0);
    return WxColour( newRed.floor(), newGreen.floor(), newBlue.floor(), alpha: alpha );
  }
}
