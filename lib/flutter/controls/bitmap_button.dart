// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxBitmapButton ----------------------

/// Represents a button with a bitmap
/// 
/// The only difference to [WxButton] using [WxButton.setBitmap] is the convenience
/// of having the bitmap in the constructor.
/// 
/// # Events emitted
/// [Button](/wxdart/wxGetButtonEventType.html) event gets sent when the button is pressed. |
/// | ----------------- |
/// | void bindButtonEvent( void function( [WxCommandEvent] event ) ) |
/// | void unbindButtonEvent() |

class WxBitmapButton extends WxButton {
  WxBitmapButton( WxWindow parent, int id, WxBitmapBundle bitmap, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = 0 } ) 
  : super( parent, id, "", pos: pos, size: size, style: style) {
    setBitmap( bitmap );
  }
}
