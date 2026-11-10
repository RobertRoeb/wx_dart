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
    _removeOverlay();
    super.dispose();
  }

  void _removeOverlay() {
    _controller = null;
  }

  @override
  void show( { bool show = true } ) {
    _hidden = !show;
    if (show) {
      theTLW!._popup = this;
      _controller!.show();
      _setState();
    } else {
      theTLW!._popup = null;
      _controller!.hide();
      _setState();
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
          final size = getMinSize();
          return Positioned(
            left: (_origin.x + _sizeOfParent.x).toDouble(),
            top: (_origin.y + _sizeOfParent.y).toDouble(),
            width: size.x == -1 ? null : size.x.toDouble(),
            height: size.y == -1 ? null : size.y.toDouble(),
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

// ------------------------- wxPopupTransientWindow ----------------------

/// @nodoc

extension PopupWindowDismissEventBinder on WxEvtHandler {
  void bindPopupWindowDismissEvent( OnNotifyEventFunc func, int id ) {
    _eventTable.add( WxNotifyEventTableEntry(wxGetPopupWindowDismissEventType(), id, func));
  }

  void unbindPopupWindowDismissEvent( int id )
  {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetPopupWindowDismissEventType(), id) ));
  }
}

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
/// | void bindPopupWindowDismissEvent( function( WxNotifyEvent event ) ) |
/// | void unbindPopupWindowDismissEvent() |

class WxPopupTransientWindow extends WxPopupWindow {
  WxPopupTransientWindow( super.parent, { super.flags } );

  /// Shows the window and gives focus to [focus] if any
  void popup( WxWindow? focus ) {
    show();
  }

  /// Dismisses the window
  void dismiss( ) {
    hide();
  }

  @override 
  Widget _buildOverlay(BuildContext context, Widget child)
  {
    Widget finalWidget = OverlayPortal(
        controller: _controller!,
        child: child,
        overlayChildBuilder: (BuildContext context) {          
          return 
            Positioned(
              left: (_origin.x + _sizeOfParent.x).toDouble(),
              top: (_origin.y + _sizeOfParent.y).toDouble(),
              width: getSize().x == -1 ? null : getSize().x.toDouble(),
              height: getSize().y == -1 ? null : getSize().y.toDouble(),
              child:
                Material(
                  child:
                  TapRegion(
                    onTapOutside: (event) {
                      final event = WxNotifyEvent( wxGetPopupWindowDismissEventType(), getId() );
                      processEvent( event );
                      if (event.isAllowed()) {
                        dismiss();
                      }
                    },
                    child: 
                      Container(
                        color: Colors.white,
                        child: _doBuildChildrenWithOrWithoutSizer( context )
                    )
                  )
            ) );
        }
    );

    finalWidget = _doBuildSizeEventHandler(context, finalWidget );

    return finalWidget;
  }
}
