// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxAnyButton ----------------------

const int wxBU_LEFT = 0x0040;
const int wxBU_TOP = 0x0080;
const int wxBU_RIGHT = 0x0100;
const int wxBU_BOTTOM = 0x0200;
const int wxBU_ALIGN_MASK = ( wxBU_LEFT | wxBU_TOP | wxBU_RIGHT | wxBU_BOTTOM );
const int wxBU_EXACTFIT = 0x0001;
const int wxBU_NOTEXT = 0x0002;

/// Base class for various button controls. Defines the interface
/// for adding bitmaps.

class WxAnyButton extends WxControl {
  WxAnyButton( super.parent, super.id, { super.pos = wxDefaultPosition, super.size = wxDefaultSize, super.style = 0 } );
  int _direction = wxLEFT;
  WxSize _margins = wxDefaultSize;
  WxBitmap? _bitmapLabel;
  WxBitmap? _bitmapCurrent;
  WxBitmap? _bitmapDisabled;
  WxBitmap? _bitmapPressed;
  WxBitmap? _bitmapFocus;

  void setBitmap( WxBitmapBundle bitmap, { int direction = wxLEFT } ) {
    _direction = direction;
    _bitmapLabel = bitmap.getBitmapFor(this);
    _bitmapCurrent = _bitmapLabel;
    _bitmapDisabled = _bitmapLabel;
    _bitmapPressed = _bitmapLabel;
    _bitmapFocus = _bitmapLabel;
    _setState();
  }

  void setBitmapCurrent( WxBitmapBundle bitmap ) {
    _bitmapCurrent = bitmap.getBitmapFor(this);
  }

  void setBitmapDisabled( WxBitmapBundle bitmap ) {
    _bitmapDisabled = bitmap.getBitmapFor(this);
  }

  void setBitmapFocus( WxBitmapBundle bitmap ) {
    _bitmapFocus = bitmap.getBitmapFor(this);
  }

  void setBitmapPressed( WxBitmapBundle bitmap ) {
    _bitmapPressed = bitmap.getBitmapFor(this);
  }

  void setBitmapLabel( WxBitmapBundle bitmap ) {
    _bitmapLabel = bitmap.getBitmapFor(this);
  }

  void setBitmapMargins( int x, int y ) {
    _margins = WxSize(x, y);
  }

  void setBitmapPosition( int dir ) {
    _direction = dir;
  }

  @override
  void _updateTheme() {
    if (_bitmapLabel != null)
    {
      _bitmapLabel!._updateTheme();
      _bitmapLabel!._addListener(this);
      if (_bitmapCurrent != _bitmapLabel) _bitmapCurrent!._updateTheme();
      if (_bitmapFocus != _bitmapLabel) _bitmapFocus!._updateTheme();
      if (_bitmapDisabled != _bitmapLabel) _bitmapDisabled!._updateTheme();
      if (_bitmapPressed != _bitmapLabel) _bitmapPressed!._updateTheme();
      _setState();
    }
  }
}
