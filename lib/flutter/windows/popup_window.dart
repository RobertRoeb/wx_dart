// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

/// [WxTopLevelWindow] that floats above other windows and usually displays
/// information or options. Different from [WxFrame] or [WxDialog], a
/// [WxPopupWindow] usually does not have any window decorations like
/// title bars or close buttons.
/// 
/// 
/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxPU_CONTAINS_CONTROLS | 0x0001 |

const int wxPU_CONTAINS_CONTROLS = 0x0001;

class WxPopupWindow extends WxNonOwnedWindow {

  /// Create the window
  WxPopupWindow( WxWindow? parent, { int flags = wxBORDER_NONE } ) : super( parent, -1, style: flags ) {
    theTLW!._popup = this;
    _createOverlay();
  }

  WxPoint _origin = wxDefaultPosition;
  WxSize _sizeOfParent = WxSize.zero;

  /// Positions the window on screen
  void position( WxPoint origin, WxSize size ) {
    _origin = origin;
    _sizeOfParent = size;
  }

  OverlayPortalController? _controller;

  @override
  void dispose() {
    theTLW!._popup = null;
    _removeOverlay();
    super.dispose();
  }

  void _removeOverlay() {
    _controller = null;
  }

  @override
  void show( { bool show = true } ) {
    if (show) {
      _controller!.show();
    } else {
      _controller!.hide();
    }
  }  

  void _createOverlay() {
    _controller = OverlayPortalController();
  }

  Widget _buildOverlay(BuildContext context, Widget child)
  {
    Widget finalWidget = OverlayPortal(
        controller: _controller!,
        child: child,
        overlayChildBuilder: (BuildContext context) {          
          return Positioned(
            left: (_origin.x + _sizeOfParent.x).toDouble(),
            top: (_origin.y + _sizeOfParent.y).toDouble(),
            width: getSize().x == -1 ? null : getSize().x.toDouble(),
            height: getSize().y == -1 ? null : getSize().y.toDouble(),
            child:
              Material(
                child:
                  Container(
                    color: Colors.white,
                    child: _doBuildChildrenWithOrWithoutSizer( context )
                ) )
          );
        }
    );

    finalWidget = _doBuildSizeEventHandler(context, finalWidget );

    return finalWidget;
  }
}
