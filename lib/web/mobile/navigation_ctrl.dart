// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01 (wxDart Web: 2026-11-21)
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

/// The standard main window of most smart phone apps with 
/// three to five icons at the bottom of the smart phone screen.
/// 
/// In wxDart Native, [WxNavigationCtrl] is emulated using a wxToolBook
/// on desktop platforms, but is natively implemented on iOS.
///
/// In wxDart Web, it is a book control with its icons and labels at the
/// bottom. Put it as the only window into a [WxFrame] or [WxAdaptiveFrame]
/// to get the typical layout of a smartphone app.
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
///
/// Events emitted
///
/// [NavCtrlPageChanged](/wxdart/wxGetNavCtrlPageChangedEventType.html) event gets sent when the user changed page |
/// | ----------------- |
/// | void bindNavCtrlPageChangedEvent( void function( [WxNotebookEvent] event ), int id ) |
/// | void unbindNavCtrlPageChangedEvent( int id ) |
/// 
/// (Not actually implemented yet in wxDart Flutter, sent in wxDart Web)
/// [NavCtrlPageChanging](/wxdart/wxGetNavCtrlPageChangingEventType.html) event gets sent when the user has requested a page change |
/// | ----------------- |
/// | void bindNavCtrlPageChangingEvent( void function( [WxNotebookEvent] event ), int id ) |
/// | void unbindNavCtrlPageChangingEvent( int id ) |

class WxNavigationCtrl extends WxBookCtrlBase {
  WxNavigationCtrl( super.parent, super.id, { super.pos = wxDefaultPosition, super.size = wxDefaultSize, super.style = 0 } );

  @override
  String get _jsKind => 'navigation';

  @override
  int get _changingEventType => wxGetNavCtrlPageChangingEventType();
  @override
  int get _changedEventType => wxGetNavCtrlPageChangedEventType();
}
