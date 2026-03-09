// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

/// The standard main window of most smart phone apps with 
/// three to five icons at the bottom of the smart phone screen.
/// 
/// This control is emulated on desktop platforms in wxDart Native
/// but uses the UITabBar in wxDart Native on iOS.

class WxNavigationCtrl extends WxBookCtrlBase {
  WxNavigationCtrl( super.parent, super.id, { super.pos = wxDefaultPosition, super.size = wxDefaultSize, super.style = 0 } );


@override
  Widget _build(BuildContext context)
  {
    final List<Widget> destinations = [];

    for (WxPageItem item in _pages)
    {

      WxBitmap? bitmap;
      if (item.image !=-1)
      {
          if (item.image >= _bitmaps.length) {
            wxLogError( "bitmap is missing in WxNavigationCtrl" );
          } 
          else
          {
            bitmap = _images[item.image].getBitmapFor(this);
            if (!bitmap.isOk()) {
              bitmap._addListener(this);
              bitmap = null;
            }
          }
      }
      late Widget child;
      if (bitmap == null)
      {
        child = Text( "IMG" );
      } 
      else 
      {
        child = RawImage( image: bitmap._image! );
      }
 
      destinations.add( 
        NavigationDestination(
          icon: child,
          label: item.text
      ) );
    }

    Widget finalWidget = NavigationBar(
      selectedIndex: _currentSelection,
      destinations: destinations,
      onDestinationSelected: (value) {
        _currentSelection = value;
        _setState();
      },
    );

    // finalWidget = _doBuildSizeEventHandler( context, finalWidget );

    return finalWidget;
  }
}
