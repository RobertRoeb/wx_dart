// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01 (wxDart Web: 2026-11-15)
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxPopupWindow ----------------------

@JS('wxc.popupTransient')
external void _jsPopupTransient(int id, bool on);

const int wxPU_CONTAINS_CONTROLS = 0x0001;

class WxPopupWindow extends WxNonOwnedWindow {
  /// Create the window
  WxPopupWindow( WxWindow parent, { int flags = wxBORDER_NONE } ) : super( parent, -1, style: flags ) {
    _hidden = true;
  }

  WxPoint _origin = WxPoint.zero;
  WxSize _sizeOfParent = WxSize.zero;

  @override
  String get _jsKind => 'popup';

  /// Positions the window on screen: at [origin] + [size] (in screen
  /// coordinates, see [WxWindow.clientToScreen]), i.e. right of and below
  /// a window at [origin] with [size], or to the left of or above it if
  /// there is not enough room on the screen.
  ///
  /// ```dart
  /// // below a button
  /// popup.position( button.clientToScreen( WxPoint.zero ), WxSize( 0, button.getSize().y ) );
  /// ```
  void position( WxPoint origin, WxSize size ) {
    _origin = origin;
    _sizeOfParent = size;
    if (!_hidden) _place();
  }

  WxSize _popupSize() {
    if (_size.x > 0 && _size.y > 0) return WxSize( _size.x, _size.y );
    final best = getBestSize();
    return WxSize( _size.x > 0 ? _size.x : max( best.x, 10 ), _size.y > 0 ? _size.y : max( best.y, 10 ) );
  }

  void _place() {
    final size = _popupSize();
    final screen = _jsScreenSize();
    int x = _origin.x + _sizeOfParent.x;
    int y = _origin.y + _sizeOfParent.y;
    if (x + size.x > screen.w) x = _origin.x - size.x;
    if (y + size.y > screen.h) y = _origin.y - size.y;
    x = x.clamp( 0, max( 0, screen.w - size.x ) );
    y = y.clamp( 0, max( 0, screen.h - size.y ) );
    _setActualRect( x, y, size.x, size.y );
  }

  @override
  void show( { bool show = true } ) {
    if (show) _place();
    super.show( show: show );
  }
}

// ------------------------- wxPopupTransientWindow ----------------------

/// [WxPopupTransientWindow] is a specialized [WxPopupWindow] that gets
/// dismissed if the user clicks or taps outside of it. This can be vetoed.
/// 
/// Example usage:
///```dart
/// class MyWindow extends WxWindow {
///   MyWindow( WxWindow parent, int id ) : super( parent, id, wxDefaultPosition, wxDefaultSize, 0 )
///   {
///     _popup = WxPopupTransientWindow(this);
/// 
///     // Put a panel with two texts inside
///     final panel = WxPanel( _popup, -1 );
///     panel.setBackgroundColour(wxGREEN);
///     final sizer = WxColumn();
///     sizer.add( WxStaticText( panel, -1, "This is a wonderful WxTransientPopupwindow" ) );
///     sizer.add( WxStaticText( panel, -1, "Second line" ) );
///     panel.setSizerAndFit(sizer);
/// 
///     // Set size to the size of the content
///     _popup.setSize( panel.getSize() );
///   }
/// 
///   late WxPopupTransientWindow _popup;
/// 
///   void onSomeEvent( WxCommandEvent event )
///   {
///      // Position the popup at the right bottom corner
///      // of this window
///      WxPoint pos = clientToScreen( WxPoint(0,0) );
///      _popup.position( pos, getSize() );
/// 
///      // Show it - it will get dismissed by clicking
///      // or tapping outside of it
///      _popup.popup(null);
///   }
/// }
/// ```
/// 
/// # Events emitted
/// [PopupWindowDismiss](/wxdart/wxGetPopupWindowDismissEventType.html) event gets sent when the clicks or taps outside of it |
/// | ----------------- |
/// | void bindPopupWindowDismissEvent( void function( WxNotifyEvent event ), int id ) |
/// | void unbindPopupWindowDismissEvent() |

class WxPopupTransientWindow extends WxPopupWindow {
  WxPopupTransientWindow( super.parent, { super.flags } );

  /// Shows the window and gives focus to [focus] if any
  void popup( WxWindow? focus ) {
    show();
    if (focus != null) {
      focus.setFocus();
    }
  }

  /// Dismisses the window
  void dismiss( ) {
    hide();
  }

  /// Called after the popup has been dismissed by a click outside of it
  /// or by Escape (unless the PopupWindowDismiss event was vetoed)
  void onDismiss( ) {
  }

  @override
  void show( { bool show = true } ) {
    super.show( show: show );
    _jsPopupTransient( _handle, show );
  }

  void _onJsDismiss() {
    final event = WxNotifyEvent( wxGetPopupWindowDismissEventType(), getId() );
    event.setEventObject( this );
    processEvent( event );
    if (!event.isAllowed()) return;
    dismiss();
    onDismiss();
  }
}
