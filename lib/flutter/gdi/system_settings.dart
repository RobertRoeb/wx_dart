// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// -------------------- wxSystemSettings -----------------------

WxSystemSettings? theSystemSettings;

WxSystemSettings wxGetSystemSettings() {
  if (theSystemSettings != null) {
    return theSystemSettings!;
  }

  theSystemSettings = WxSystemSettings();
  return theSystemSettings!;
}

// ------------------------- wxSystemSettings ----------------------

const int wxSYS_DEFAULT_GUI_FONT = 17;
const int wxSYS_COLOUR_WINDOW = 5;
const int wxSYS_COLOUR_WINDOWTEXT = 8;
const int wxSYS_COLOUR_HIGHLIGHT = 13;
const int wxSYS_COLOUR_HIGHLIGHTTEXT = 14;
const int wxSYS_COLOUR_BTNTEXT = 18;
const int wxSYS_COLOUR_LISTBOX = 25;
const int wxSYS_COLOUR_LISTBOXTEXT = 31;
const int wxSYS_COLOUR_LISTBOXHIGHLIGHTTEXT = 32;
const int wxSYS_COLOUR_LISTBOXHIGHLIGHT = 34;
const int wxSYS_COLOUR_GRIDLINES = 33;
const int wxSYS_MOUSE_BUTTONS = 1;
const int wxSYS_SCREEN_X = 21;
const int wxSYS_SCREEN_Y = 22;

/// Helper class to query certain system settings, such as colours,
/// fonts or certain metrics. The the global getter to access this
/// class:
/// 
/// ```dart
///   final font = wxGetSystemSettings.getFont( wxSYS_DEFAULT_GUI_FONT );
/// ```
/// 
/// # System fonts
/// | constant | meaning |
/// | -------- | -------- |
/// | wxSYS_DEFAULT_GUI_FONT | 17 |
/// 
/// # System colours
/// | constant | meaning |
/// | -------- | -------- |
/// | wxSYS_COLOUR_WINDOW | 5 (standard background) |
/// | wxSYS_COLOUR_WINDOWTEXT | 8 |
/// | wxSYS_COLOUR_HIGHLIGHT | 13 |
/// | wxSYS_COLOUR_HIGHLIGHTTEXT | 14 |
/// | wxSYS_COLOUR_BTNTEXT | 18 |
/// | wxSYS_COLOUR_LISTBOX | 25 |
/// | wxSYS_COLOUR_LISTBOXTEXT | 31 |
/// | wxSYS_COLOUR_LISTBOXHIGHLIGHTTEXT | 32 |
/// | wxSYS_COLOUR_LISTBOXHIGHLIGHT | 34 (standard selection colour) |
/// | wxSYS_COLOUR_GRIDLINES | 33 |
/// 
/// # System metrics
/// | constant | meaning |
/// | -------- | -------- |
/// | wxSYS_MOUSE_BUTTONS | 1 |
/// | wxSYS_SCREEN_X | 21 |
/// | wxSYS_SCREEN_Y | 22 |

class WxSystemSettings extends WxClass {
  WxSystemSettings();

  /// Returns the respective colour on the current platform
  /// 
  /// This can change following changes in user settings or
  /// changes between dark and light modes
  WxColour getColour( int colour ) {
    if (wxTheApp.isDark())
    {
      switch (colour)
      {
        case wxSYS_COLOUR_HIGHLIGHTTEXT: 
        case wxSYS_COLOUR_LISTBOXTEXT: 
        case wxSYS_COLOUR_BTNTEXT: 
        case wxSYS_COLOUR_LISTBOXHIGHLIGHTTEXT: 
        case wxSYS_COLOUR_WINDOWTEXT: 
          return wxWHITE;

        case wxSYS_COLOUR_HIGHLIGHT:
        case wxSYS_COLOUR_LISTBOXHIGHLIGHT:
          return wxTheApp.getAccentColour();

        case wxSYS_COLOUR_LISTBOX:
          return wxGREY;

        case wxSYS_COLOUR_WINDOW:
          if (_darkTheme == null) {
            return WxColour(42,48,50);
          }
          Color color = _darkTheme!.scaffoldBackgroundColor;
          final int r = (color.r*255).floor();
          final int g = (color.g*255).floor();
          final int b = (color.b*255).floor();
          return WxColour(r,g,b);


        default: 
          return wxLIGHT_GREY;
      }
    } 
    else
    {
      switch (colour)
      {
        case wxSYS_COLOUR_HIGHLIGHTTEXT: 
        case wxSYS_COLOUR_LISTBOXTEXT: 
        case wxSYS_COLOUR_BTNTEXT: 
        case wxSYS_COLOUR_LISTBOXHIGHLIGHTTEXT: 
        case wxSYS_COLOUR_WINDOWTEXT: 
          return wxBLACK;

        case wxSYS_COLOUR_WINDOW:
          if (_lightTheme == null) {
            return wxWHITE;
          }
          Color color = _lightTheme!.scaffoldBackgroundColor;
          final int r = (color.r*255).floor();
          final int g = (color.g*255).floor();
          final int b = (color.b*255).floor();
          return WxColour(r,g,b);
        case wxSYS_COLOUR_HIGHLIGHT:
        case wxSYS_COLOUR_LISTBOXHIGHLIGHT:
          return wxTheApp.getAccentColour();

        case wxSYS_COLOUR_LISTBOX:
          return wxWHITE;

        default: 
          return wxLIGHT_GREY;
      }
    }
  }

  /// Returns a standard system font. 
  /// 
  /// Currently only supports
  /// wxSYS_DEFAULT_GUI_FONT which is identical to wxNORMAL_FONT,
  /// but wxNORMAL_FONT may not get updated if the default font
  /// is chamged during run-time of the app.
  WxFont getFont( { int font = wxSYS_DEFAULT_GUI_FONT } ) {
    return wxNORMAL_FONT; 
  }

/// Returns certain metrics from the system
/// 
/// # System metrics
/// | constant | meaning |
/// | -------- | -------- |
/// | wxSYS_MOUSE_BUTTONS | 1 |
/// | wxSYS_SCREEN_X | 21 |
/// | wxSYS_SCREEN_Y | 22 |
  int getMetric( int metric ) {
    switch (metric) {
      case wxSYS_MOUSE_BUTTONS:
        // I don't know yet how to query the number of mouse buttons
        return 2;
      case wxSYS_SCREEN_X:
        if (_theWxDartAppState != null) {
          return _theWxDartAppState!._screenWidth.floor();
        }
        break;
      case wxSYS_SCREEN_Y:
        if (_theWxDartAppState != null) {
          return _theWxDartAppState!._screenHeight.floor();
        }
        break;
      default:
    }
    return 0;
  }
}