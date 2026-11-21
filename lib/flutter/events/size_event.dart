// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- WxSizeEvent ----------------------

typedef OnSizeEventFunc = void Function( WxSizeEvent event );

/// @nodoc

class WxSizeEventTableEntry extends WxEventTableEntry {
  WxSizeEventTableEntry( super.eventType, super.id, this.func );
  final OnSizeEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return eventType == eventTypeTested;
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxSizeEvent) {
      func( event );
    }
  }
}

/// [Size](/docs/wxdart/wxGetSizeEventType.html) event gets sent when the size of a window changes. |
/// | ----------------- |
/// | void bindSizeEvent( void function( [WxSizeEvent] event ) ) |
/// | void unbindSizeEvent() |
/// 
/// Make sure to call [WxSizeEvent.skip] so that ancestor windows can handle the
/// event as well.

class WxSizeEvent extends WxEvent {
  WxSizeEvent(  WxSize size, { id = 0 } ) : super( wxGetSizeEventType(), id ) {
    _size = size;
  }

  late WxSize _size;
  WxRect _rect = WxRect(0, 0, 0, 0);

  /// Returns the new size of the window
  WxSize getSize( ) {
    return _size;
  }

  /// Used internally. Sets the size of the window.
  void setSize( WxSize size ) {
    _size = size;
  }

  /// Returns the new full dimensions of the window
  WxRect getRect( ) {
    return _rect;
  }

  /// Used internally. Sets the dimension of the window.
  void setRect( WxRect rect ) {
    _rect = rect;
  }

}
