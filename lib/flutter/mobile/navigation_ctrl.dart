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
/// In wxDart Native, [WxNavigatonCtrl] is emulated using a wxToolBook
/// on desktop platforms, but is natively implemented on iOS.
/// 
///```dart
///  // create navigation control
///  final navi = WxNavigationCtrl(this,-1);
///
///  // create image list
///  List<WxBitmapBundle> images = [];
/// 
///  // add images to image list
///  images.add( WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.home, WxSize(30,30) ) );
///  images.add( WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.info, WxSize(30,30) ) );
///  images.add( WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.tour, WxSize(30,30) ) );
/// 
///  // assign image list to navigation control
///  navi.setImages(images);
///
///  // add pages to navigation control
///  final home = MyHomePage( navi );
///  navi.addPage(info, "Home", image: 0);
/// 
///  final home = MyInfoPage( navi );
///  navi.addPage(info, "Info", image: 1);
/// 
///  final home = MyTourPage( navi );
///  navi.addPage(info, "Tour", image: 2);
///```
/// 
/// Page interface
/// * [addPage]
/// * [insertPage]
/// * [findPage]
/// * [getPage]
/// * [deletePage]
/// * [deleteAllPages]
/// * [findPage]
/// 
/// Image interface
/// * [setImages]
/// * [hasImages]
/// * [getImageCount]
/// 
/// Title interface
/// * [setPageText]
/// * [getPageText]
/// 
/// Selection interface
/// * [setSelection]
/// * [getSelection]
/// * [getCurrentPage]

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
