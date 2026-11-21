// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- WxPaintEvent ----------------------

typedef OnPaintEventFunc = void Function( WxPaintEvent event );

/// @nodoc

class WxPaintEventTableEntry extends WxEventTableEntry {
  WxPaintEventTableEntry( super.eventType, super.id, this.func );
  final OnPaintEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return eventType == eventTypeTested;
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxPaintEvent) {
      func( event );
    }
  }
}

/// [Paint](/docs/wxdart/wxGetPaintEventType.html) event gets sent when a part of the window needs to be redrawn |
/// | ----------------- |
/// | void bindPaintEvent( void function( [WxPaintEvent] event ) |
/// | void unbindPaintEvent() |
/// 
/// Here is an example of how paint event are usually processed.
/// 
///```dart
/// // Derive new class from WxWindow
/// class MyWindow extends WxWindow {
/// 
///   MyWindow( WxWindow parent, int id ) : super( parent, id, wxDefaultPosition, wxDefaultSize, 0 )
///   {
///     // Bind to paint event
///     bindPaintEvent(onPaint);
///   }
/// 
///   // define new paint event handler
///   void onPaint( WxPaintEvent event )
///   {
///     // create paint device context during paint event
///     final dc = WxPaintDC( this );
///     dc.drawLine( 10, 10, 100, 100 );
///   }
/// }
/// ```
/// Sometimes, only a part of the window needs to be redrawn. In this
/// case, you can query the update rectangle using [WxWindow.getUpdateClientRect].
/// However, this is actually not supported on all platforms and may not
/// be required or useful with modern hardware.
/// 
///```dart
/// // Derive new class from WxWindow
/// class MyWindow extends WxWindow {
/// 
///   MyWindow( WxWindow parent, int id ) : super( parent, id, wxDefaultPosition, wxDefaultSize, 0 )
///   {
///     // Bind to paint event
///     bindPaintEvent(onPaint);
///   }
/// 
///   // define new paint event handler
///   void onPaint( WxPaintEvent event )
///   {
///     // create paint device context during paint event
///     final dc = WxPaintDC( this );
/// 
///     final updateRect = getUpdateClientRect();
///     final rect = WxRect(10,10,100,100);
///     if (updateRect.intersects( rect ) )
///     {
///       // draw a line
///       dc.drawLinePts( rect.getTopLeft(), rect.getBottomRight() );
///     }
///   }
/// }
/// ```

class WxPaintEvent extends WxEvent {
  WxPaintEvent( WxWindow window ) : super( wxGetPaintEventType(), window.getId() );
}
