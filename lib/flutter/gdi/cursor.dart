// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxCursor ----------------------

final wxSTANDARD_CURSOR = WxCursor( wxCURSOR_DEFAULT );
final wxHOURGLASS_CURSOR = WxCursor( wxCURSOR_WAIT );
final wxCROSSGLASS_CURSOR = WxCursor( wxCURSOR_CROSS );

const int wxCURSOR_NONE = 0;
const int wxCURSOR_ARROW = 1;
const int wxCURSOR_RIGHT_ARROW = 2;
const int wxCURSOR_BULLSEYE = 3;
const int wxCURSOR_CHAR = 4;
const int wxCURSOR_CROSS = 5;
const int wxCURSOR_HAND = 6;
const int wxCURSOR_IBEAM = 7;
const int wxCURSOR_LEFT_BUTTON = 8;
const int wxCURSOR_MAGNIFIER = 9;
const int wxCURSOR_MIDDLE_BUTTON = 10;
const int wxCURSOR_NO_ENTRY = 11;
const int wxCURSOR_PAINT_BRUSH = 12;
const int wxCURSOR_PENCIL = 13;
const int wxCURSOR_POINT_LEFT = 14;
const int wxCURSOR_POINT_RIGHT = 15;
const int wxCURSOR_QUESTION_ARROW = 16;
const int wxCURSOR_RIGHT_BUTTON = 17;
const int wxCURSOR_SIZENESW = 18;
const int wxCURSOR_SIZENS = 19;
const int wxCURSOR_SIZENWSE = 20;
const int wxCURSOR_SIZEWE = 21;
const int wxCURSOR_SIZING = 22;
const int wxCURSOR_SPRAYCAN = 23;
const int wxCURSOR_WAIT = 24;
const int wxCURSOR_WATCH = 25;
const int wxCURSOR_DEFAULT = wxCURSOR_ARROW;

/// Represents a mouse cursor.
/// 
/// Currently, wxDart only supports system stock cursors.
/// 
/// You can set the mouse cursor for a certain window like this:
/// ```dart
///       setCursor( WxCursor(wxCURSOR_CROSS) );
/// ```
/// If you want to show that mouse cursor only in a certain
/// area, capture the mouse motion event and set the mouse
/// cursor there:
/// ```dart
/// // Derive new class from WxWindow
/// class MyWindow extends WxWindow {
/// 
///   MyWindow( WxWindow parent, int id ) : super( parent, id, wxDefaultPosition, wxDefaultSize, 0 )
///   {
///     // Bind to mouse motion event
///     bindMotionEvent( onMotion );
///   }
/// 
///   // define new mouse motion event handler
///   void onMotion( WxMouseEvent event )
///   {
///    final pos = event.getPosition();
///    // in a scrolled window, this would need to be adapted
///    // final pos = calcUnscrolledPosition(event.getPosition());
///    
///    if (( pos.x > 10) && (pos.y > 50) &&
///        ( pos.x < 210) && (pos.y < 250)) {
///      setCursor( WxCursor(wxCURSOR_CROSS) );
///    } else {
///      setCursor( null );  // reset to standard mouse cursor
///    }
///   }
/// }
/// ```
/// A small number of cursors are predefined global objects:
/// # Global objects 
/// | Object | 
/// | -------- |
/// |  wxSTANDARD_CURSOR  |  
/// |  wxHOURGLASS_CURSOR  |  
/// |  wxCROSSGLASS_CURSOR  |  
/// 
/// # List of supported stock cursors
/// | Cursor | value |
/// | -------- | -------- |
/// |  wxCURSOR_NONE |  0 |
/// |  wxCURSOR_ARROW |  1 |
/// |  wxCURSOR_RIGHT_ARROW |  2 |
/// |  wxCURSOR_BULLSEYE |  3 |
/// |  wxCURSOR_CHAR |  4 |
/// |  wxCURSOR_CROSS |  5 |
/// |  wxCURSOR_HAND |  6 |
/// |  wxCURSOR_IBEAM |  7 |
/// |  wxCURSOR_LEFT_BUTTON |  8 |
/// |  wxCURSOR_MAGNIFIER |  9 |
/// |  wxCURSOR_MIDDLE_BUTTON |  10 |
/// |  wxCURSOR_NO_ENTRY |  11 |
/// |  wxCURSOR_PAINT_BRUSH |  12 |
/// |  wxCURSOR_PENCIL |  13 |
/// |  wxCURSOR_POINT_LEFT |  14 |
/// |  wxCURSOR_POINT_RIGHT |  15 |
/// |  wxCURSOR_QUESTION_ARROW |  16 |
/// |  wxCURSOR_RIGHT_BUTTON |  17 |
/// |  wxCURSOR_SIZENESW |  18 |
/// |  wxCURSOR_SIZENS |  19 |
/// |  wxCURSOR_SIZENWSE |  20 |
/// |  wxCURSOR_SIZEWE |  21 |
/// |  wxCURSOR_SIZING |  22 |
/// |  wxCURSOR_SPRAYCAN |  23 |
/// |  wxCURSOR_WAIT |  24 |
/// |  wxCURSOR_WATCH | 25 |
/// |  wxCURSOR_DEFAULT | wxCURSOR_ARROW |

class WxCursor {
  /// Creates a stock cursor
  WxCursor( int stockCursor ) {
    _stockCursor = stockCursor;
  }

  bool isOk() {
    return true;
  }

  /// Returns the ID of the stock cursor
  int getStockCursor() {
    return _stockCursor;
  }

  /// Sets the ID of the stock cursor
  void setStockCursor( int stockCursor ) {
    _stockCursor = stockCursor;
  }

  late int _stockCursor; 
}