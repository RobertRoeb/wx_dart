// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01 (wxDart Web: 2026-11-21)
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ----------------------------- WxAppBar ---------------------------

const int wxAB_FLEXIBLE = 0x0200;
const int wxAB_PINNED = 0x0400;
const int wxAB_DEFAULT_STYLE = wxAB_FLEXIBLE;

/// Specialized toolbar that is used in smartphone apps.
///
/// It usually has a small number of text only buttons (add
/// using [addAction]) and a small number of bitmap-only buttons (add using [WxToolBar.addTool]).
///
/// A [WxAppBar] can be logically attached to a [WxScrolledWindow] so that they
/// scroll together (fade away when scrolling up, fade to front when scrolling down).
///
///```dart
///class MyMobileFrame extends WxAdaptiveFrame {
///  MyMobileFrame( WxWindow ?parent )
///  : super( parent, -1, "Cool app", size: WxSize( 800, 600 ) )
///  {
///    // Let frame create appbar
///    final appBar = createAppBar( "Mobile Demo", style: 0);
///
///    // Add "About" text only action/button
///    appBar.addAction( idAbout, "About" );
///
///    // Like for WxToolBar, call realize() at the end.
///    appBar.realize();
///
///    // Close if requested
///    bindMenuEvent( (_) => close(false), wxID_EXIT );
///    bindCloseWindowEvent( (_) => destroy() );
///
///    // Create main navigation control
///    final navi = WxNavigationCtrl(this,-1);
///
///    // Image list for navigation control with "home" button
///    List<WxBitmapBundle> images = [];
///    images.add( WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.home, WxSize(30,30) ) );
///    navi.setImages(images);
///
///    // Create main window
///    final home = MyScrolledWindow( navi );
///
///    // Add main window to navigation control
///    navi.addPage(home, "Home", image: 0);
///
///    // Connect scrolling of home to appbar to make it disappear
///    appBar.attach( home );
///  }
///}
///```
///
/// # Appbar window styles
/// | constant | value |
/// | -------- | -------- |
/// | wxAB_FLEXIBLE | 0x0200 (when attached to a scrollwindow, make it bigger) |
/// | wxAB_PINNED | 0x0400 (when attached to a scrollwindow, don't disappear )|
/// | wxAB_DEFAULT_STYLE | wxAB_FLEXIBLE |
///
/// # wxDart Web
/// The app bar is shown at the top of the [WxAdaptiveFrame] in touch mode
/// (see [WxApp.isTouch]): the title on the left, preceded by the back arrow
/// of a secondary frame or the button of the drawer, the actions and tools
/// on the right. When attached to a scrolled window, it is larger with a
/// larger title while the window is scrolled to the top (wxAB_FLEXIBLE) and
/// moves out of view when scrolling down (unless wxAB_PINNED).

class WxAppBar extends WxToolBar {
/// Creates app bar with a title. Usually done from [WxAdaptiveFrame.createAppBar]
///
/// ## Appbar window styles
/// | constant | value |
/// | -------- | -------- |
/// | wxAB_FLEXIBLE | 0x0200 (when attached to a scrollwindow, make it bigger) |
/// | wxAB_PINNED | 0x0400 (when attached to a scrollwindow, don't disappear )|
/// | wxAB_DEFAULT_STYLE | wxAB_FLEXIBLE |
  WxAppBar( WxWindow parent, int id, String title, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = wxAB_DEFAULT_STYLE } )
    : _appBarTitle = title,
      super( parent, id, pos: pos, size: size, style: style ) {
    _jsAppBarSet( _handle, title, style );
  }

  String _appBarTitle;

  /// Adds a text only button/action to the appbar. You would typically
  /// only have one or two of these
  WxToolBarToolBase addAction( int id, String label, { String shortHelp = "" } ) {
    return _insert( -1, _makeTool( id, label, null, null, wxITEM_NORMAL, shortHelp ) );
  }

  /// Sets the title shown in the app bar
  void setTitle( String title ) {
    _appBarTitle = title;
    _jsAppBarSet( _handle, title, getWindowStyle() );
  }

  /// Returns the title shown in the app bar
  String getTitle() {
    return _appBarTitle;
  }

  /// Attaches the app bar logically to a [WxScrolledWindow] with the [wxVSCROLL] style
  /// so that they scroll together (fade away when scrolling up, fade to front when
  /// scrolling down). This is a popular UI feature on smartphones.
  ///
  /// An app bar can be attached to several [WxScrolledWindow]s, e.g. if they are
  /// different pages of a [WxNavigationCtrl].
  void attach( WxScrolledWindow window ) {
    if (!window.hasFlag(wxVSCROLL)) {
      wxLogError( "WxAppBar can only be attached to a WxScrolledWindow with the wxVSCROLL style" );
      return;
    }
    _jsAppBarAttach( _handle, window._scrollTarget._handle );
  }
}
