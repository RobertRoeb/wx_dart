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
/// an effect. In most cases, you don't need to use or keep this class.

class WxSizerItem {
  WxSizerItem.asSpacer( int size ) {
    _kind = WxSizerKind.spacer;
    _width = size;
    _height = size;
    _spacerWidgetKey = GlobalKey();
  }

  WxSizerItem.asSizer( this._sizer, this._proportion, this._flag, this._border ) {
    _kind = WxSizerKind.sizer;
  }
  WxSizerItem.asWindow( this._window, this._proportion, this._flag, this._border ) {
    _kind = WxSizerKind.window;
  }

  WxSizer? getSizer() {
    return _sizer;
  }

  WxWindow? getWindow() {
    return _window;
  }

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
      size = spacerSize;   
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

  int getBorder() {
    return _border;
  }
  void setBorder( int border ) {
    _border = border;
  }

  int getFlag() {
    return _flag;
  }
  void setFlag( int flag ) {
    _flag = flag;
  }

  int getProportion() {
    return _proportion;
  }
  void setProportion( int proportion ) {
    _proportion = proportion;
  }

  WxPoint spacerPosition = wxDefaultPosition;
  WxSize spacerSize = wxDefaultSize;

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
