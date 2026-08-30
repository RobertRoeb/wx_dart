// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxSizerItem ----------------------

enum WxSizerKind { none, spacer, sizer, window }

/// Helper class created by sizers for each item. You can keep a reference
/// to one of these and e.g. query the position or size of the item later
/// on. When changing the values of an item once the owning window is already
/// shown, a call to [WxWindow.layout] maybe needed for the change to have
/// an effect. In many cases, you don't need to use or keep this class.

class WxSizerItem {
  WxSizerItem._asSpacer( int size ) {
    _kind = WxSizerKind.spacer;
    _width = size;
    _height = size;
    _spacerWidgetKey = GlobalKey();
  }

  WxSizerItem._asSizer( this._sizer, this._proportion, this._flag, this._border ) {
    _kind = WxSizerKind.sizer;
  }
  WxSizerItem._asWindow( this._window, this._proportion, this._flag, this._border ) {
    _kind = WxSizerKind.window;
  }

  /// Returns true if item is a sizer
  bool isSizer() {
    return _kind == WxSizerKind.sizer;
  }

  /// Returns true if item is a spacer
  bool isSpacer() {
    return _kind == WxSizerKind.spacer;
  }

  /// Returns true if item is a window
  bool isWindow() {
    return _kind == WxSizerKind.window;
  }

  /// Returns the associated sizer, or null.
  WxSizer? getSizer() {
    return _sizer;
  }

  /// Returns the associated window, or null.
  WxWindow? getWindow() {
    return _window;
  }

  /// Returns the current position on the parent window, if already known.
  WxPoint getPosition()
  {
    WxPoint pos = wxDefaultPosition;

    if (_kind == WxSizerKind.window) {
      pos = _window!.getPosition();
    } 
    else
    if (_kind == WxSizerKind.sizer) {
      if (_sizer is WxStaticBoxSizer) {
        WxStaticBoxSizer sbs = _sizer as WxStaticBoxSizer;
        pos = sbs.getStaticBox().getPosition();
      }  else {
        pos = _sizer!.getPosition();
      }
    } else 
    {
      if (_spacerParentWindow == null) {
        return WxPoint(-1, -1);
      }
      if (_spacerWidgetKey==null) {
        return WxPoint(-1, -1);
      }
      final RenderObject? renderObject = _spacerWidgetKey!.currentContext?.findRenderObject();
      if (renderObject == null) {
        return WxPoint(-1, -1);
      }
      final RenderObject? renderParentObject = _spacerParentWindow!._getWidgetKey().currentContext?.findRenderObject();
      if (renderParentObject == null) {
        return WxPoint(-1, -1);
      }
      final RenderBox renderBox = renderObject as RenderBox;
      final Offset offset = renderBox.localToGlobal(Offset.zero, ancestor: renderParentObject);
      pos = WxPoint( offset.dx.floor(), offset.dy.floor());
    }

    if ((_flag & wxLEFT) != 0) {
      pos = WxPoint(pos.x-_border, pos.y);
    }
    if ((_flag & wxTOP) != 0) {
      pos = WxPoint(pos.x, pos.y-_border);
    }

    return pos;
  }

  /// Returns the current size on the parent window, if already known.
  WxSize getSize() {
    WxSize size = wxDefaultSize;
    if (_kind == WxSizerKind.window) {
      size = _window!.getSize();
    } 
    else
    if (_kind == WxSizerKind.sizer) {
      if (_sizer is WxStaticBoxSizer) {
        WxStaticBoxSizer sbs = _sizer as WxStaticBoxSizer;
        size = sbs.getStaticBox().getSize();
      } else {
       size = _sizer!.getSize(); 
      }
    } else {
      size = _spacerSize;   
    }

    if ((_flag & wxLEFT) != 0) {
      size = WxSize(size.x+_border, size.y);
    }
    if ((_flag & wxRIGHT) != 0) {
      size = WxSize(size.x+_border, size.y);
    }
    if ((_flag & wxTOP) != 0) {
      size = WxSize(size.x, size.y+_border);
    }
    if ((_flag & wxBOTTOM) != 0) {
      size = WxSize(size.x, size.y+_border);
    }

    return size;
  }

  /// Returns the border width around the item.
  int getBorder() {
    return _border;
  }
  /// Sets the border width around the item.
  void setBorder( int border ) {
    _border = border;
  }

/// Returns the flag parameter (which determines alignment and
/// where the borders are). A bitwise combination of the below constants. 
/// 
/// These flags determine on which side of a control extra 'border' space should be added
/// 
/// | constant | value |
/// | -------- | -------- |
/// | wxLEFT | 0x0010 |
/// | wxRIGHT | 0x0020 |
/// | wxUP | 0x0040 |
/// | wxDOWN | 0x0080 |
/// | wxTOP | wxUP |
/// | wxBOTTOM | wxDOWN |
/// | wxNORTH | wxUP |
/// | wxSOUTH | wxDOWN |
/// | wxWEST | wxLEFT |
/// | wxEAST | wxRIGHT |
/// | wxALL | (wxUP \| wxDOWN \| wxRIGHT \| wxLEFT) |
/// | wxDIRECTION_MASK | wxALL |
/// 
/// These flags determine the alignment
/// 
/// | constant | value |
/// | -------- | -------- |
/// | wxALIGN_INVALID | -1 |
/// | wxALIGN_NOT | 0x0000 |
/// | wxALIGN_CENTER_HORIZONTAL | 0x0100 |
/// | wxALIGN_CENTRE_HORIZONTAL | wxALIGN_CENTER_HORIZONTAL |
/// | wxALIGN_LEFT | wxALIGN_NOT |
/// | wxALIGN_TOP | wxALIGN_NOT |
/// | wxALIGN_RIGHT | 0x0200 |
/// | wxALIGN_BOTTOM | 0x0400 |
/// | wxALIGN_CENTER_VERTICAL | 0x0800 |
/// | wxALIGN_CENTRE_VERTICAL | wxALIGN_CENTER_VERTICAL |
/// | wxALIGN_CENTER | (wxALIGN_CENTER_HORIZONTAL \| wxALIGN_CENTER_VERTICAL) |
/// | wxALIGN_CENTRE | wxALIGN_CENTER |
/// | wxALIGN_MASK | 0x0f00 |
/// 
/// These flags determine the stretch behaviour. [wxEXPAND] is used for the
/// secondary direction (vertical stretch behaviour in a horizontal sizer and 
/// vice versa). The _proportion_ parameter in [WxSizer.add] determines the
/// stretch behaviour in the primary direction.
/// 
/// | constant | value |
/// | -------- | -------- |
/// | wxSTRETCH_NOT | 0x0000 |
/// | wxSHRINK | 0x1000 (shrink below minimal/initial size, always on in wxDart Flutter) |
/// | wxGROW | 0x2000 |
/// | wxEXPAND | wxGROW |
/// | wxSHAPED | 0x4000 (not supported in wxDart Flutter)|
/// | wxTILE | 0xc000 |
/// | wxSTRETCH_MASK | 0x7000 |
  int getFlag() {
    return _flag;
  }
  /// Sets the flag parameter (which determines alignment and
  /// were the borders are). A bitwise combination of the below constants.
  /// 
  /// See [getFlag].
  void setFlag( int flag ) {
    _flag = flag;
  }

  /// Returns the proportion parameter which determines the relative stretch factor
  /// in the respective primary direction.
  int getProportion() {
    return _proportion;
  }
  /// Sets the proportion parameter which determines the relative stretch factor
  /// in the respective primary direction.
  void setProportion( int proportion ) {
    _proportion = proportion;
  }

  WxPoint _spacerPosition = wxDefaultPosition;
  WxSize _spacerSize = wxDefaultSize;

  WxSizerKind _kind = WxSizerKind.none;
  int _width = 0;
  int _height = 0;
  int _proportion = 0;
  int _flag = 0;
  int _border = 0;
  WxSizer? _sizer;
  WxWindow? _window;
  GlobalKey? _spacerWidgetKey;
  WxWindow? _spacerParentWindow;
}
