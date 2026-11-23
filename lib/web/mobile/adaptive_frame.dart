// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01 (wxDart Web: 2026-11-21)
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- WxAdaptiveFrame ----------------------

/// [WxAdaptiveFrame] is a specialized [WxFrame] that can adapt to small screens
/// with a predominantly touch based interface.
/// 
/// The decision if a screen is "small" is based on [WxApp.isTouch] which provides
/// reasonable defaults, but can be overridden. In most cases, the interface will
/// be either "desktop" or "small touch" and will not change during run-time. In
/// order to maintain a single code base, you might want to define two different frames,
/// one deriving from [WxFrame] and one from [WxAdaptiveFrame] and then decide 
/// which one to use in [WxApp.onInit]. In this case, you will most usually use
/// a [WxNavigationCtrl] as the main window of the [WxAdaptiveFrame].
/// 
///```dart 
///class MyApp extends WxApp {
///  MyApp();
///
///  @override
///  bool onInit() {
///    if (isTouch()) {
///      WxFrame myFrame = MyAdaptiveFrame(null);
///      myFrame.show();
///    } else {
///      WxFrame myFrame = MyFrame(null);
///      myFrame.show();
///    }
///    return true;
///  }
///}
///```
/// However, [WxAdaptiveFrame] can also adapt its interface dynamically (e.g. when
/// the size of a web app changes) in two ways:
/// 
/// ## Live switching between AppBar and MenuBar
/// 
/// If you create both a classical [WxMenuBar] and an AppBar using [WxAdaptiveFrame.createAppBar]
/// then the app will switch between the two when going from Touch to Desktop interface and back:
///
///```dart
///class MyAdaptiveFrame extends WxAdaptiveFrame {
///  MyAdaptiveFrame( WxWindow ?parent ) 
///  : super( parent, -1, "MyAdaptiveFrame", size: WxSize( 800, 600 ) )
///  {
///    // currently only really availale in wxDart Flutter
/// 
///    // let frame create app bar
///    final appBar = createAppBar();
/// 
///    // add tools to app bar
///    appBar.addAction( idAbout, "About" );
///    appBar.addTool( wxID_EXIT, "", WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.exit_to_app, WxSize(32,32) ) );
///    // call realize() at the end
///    appBar.realize();
///
///    // Add menu bar for the desktop case
///    final menubar = WxMenuBar();
///    final filemenu = WxMenu();
///    filemenu.appendItem( idAbout, "About...\tAlt-A", help: "Info about wxDart 1.0" );
///    filemenu.appendSeparator();
///    filemenu.appendItem( wxID_EXIT, "Quit app\tCtrl-Q", help: "Run, baby, run!" );
///    menubar.append(filemenu, "&File");
///    setMenuBar(menubar);
///  }
///}
///```
/// ## Showing/hiding side control in drawer
/// 
/// wxDart Flutter also supports drawer windows which are usually invisible but can
/// be made to appear from the left side by clicking on a "Hamburger" menu or
/// with a swipe gesture from the left edge of the smartphone screen.
///
/// There are currently two different ways to create a drawer. Either from a
/// [WxMenuBar] using [setDrawerFromMenuBar] or from any normal window using
/// [setDrawerFromWindow]. Using the latter function, you can make a window
/// in the frame magically jump into the drawer if the frame is resized to be small.
/// [WxTreebook] and [WxDataViewBook] have this functionality built-in, so their
/// respective tree windows jump into the drawer:
/// 
/// ```dart
/// class MyTreebookFrame extends WxAdaptiveFrame {
///  MyTreebookFrame( WxWindow parent ) 
///  : super( parent, -1, "Treebook frame", size: WxSize( 500, 400 ) )
///  {
///    // create appbar here
///
///    final tree = WxTreebook(this, -1);
///
///    // inform WxAdaptiveFrame which window to put into the drawer
///    setDrawerFromWindow(tree.getTreeCtrl() );
///
///    // close drawer when an item has been selected
///    tree.bindTreebookPageChangedEvent((event) {
///      if (wxTheApp.isTouch()) {
///        closeDrawer();
///      }
///      event.skip();
///    }, -1 );
///
///    // add one example page
///    final panel1 = WxPanel( tree, -1 );
///    tree.addPage(panel1, "Panel 1" );
///  }
///}
/// ```
/// 
/// A classical feature on a small screen is a floating action button, usually
/// placed in the right bottom corner of the screen.  It can be
/// added to a [WxAdaptiveFrame] with [createFloatingActionButton].
/// 
/// Interface for main UI elements:
/// * [createAppBar]
/// * [getAppBar]
/// * [createFloatingActionButton]
/// * [getFloatingActionButton]
/// 
/// Inherited from [WxFrame]
/// * [createStatusBar]
/// * [getStatusBar]
/// * [createToolBar]
/// * [getToolBar]
/// 
/// # wxDart Web
/// The frame switches between both modes at runtime, e.g. when the browser
/// window gets narrower than 700 pixels or on a phone (see [WxApp.isTouch]):
/// * touch mode: the app bar replaces the menu bar (if there is an app
///   bar), the floating action button appears in the bottom right corner,
///   and if there is a drawer, a button at the start of the app bar opens
///   it
/// * desktop mode: menu bar, no app bar, no floating action button, no
///   drawer (a window shown in the drawer is back at its place)
///
/// Drawer interface:
/// * [openDrawer]
/// * [closeDrawer]
/// * [setDrawerTitle]
/// * [setDrawerFromWindow]
/// * [setDrawerFromMenuBar]

class WxAdaptiveFrame extends WxFrame {
  WxAdaptiveFrame( WxWindow? parent, int id, String title, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = wxDEFAULT_FRAME_STYLE } )
    : super( parent, id, title, pos: pos, size: size, style: style );

  WxAppBar? _appBar;
  WxMenuBar? _drawerMenuBar;
  WxWindow? _drawerWindow;
  bool _buildDrawerFromStandardMenuBar = false;
  int _startMenu = 1;
  String _drawerTitle = "";
  WxWindow? _floatingActionButton;
  bool _drawerIsOpen = false;

  /// null until the mode has been applied for the first time
  bool? _touchMode;
  /// the window currently shown in the drawer
  WxWindow? _windowInDrawer;
  WxSize _drawerSlot = WxSize.zero;

/// Let frame create app bar with given [title]
/// 
/// This will currently create a standard toolbar under wxDart Native
/// 
/// ## Appbar window styles
/// | constant | value |
/// | -------- | -------- |
/// | wxAB_FLEXIBLE | 0x0200 (when attached to a scrollwindow, make it bigger) |
/// | wxAB_PINNED | 0x0400 (when attached to a scrollwindow, don't disappear )|
/// | wxAB_DEFAULT_STYLE | wxAB_FLEXIBLE |
  WxAppBar createAppBar( String title, { int style = wxAB_DEFAULT_STYLE, int id = -1 } )
  {
    _appBar?.destroy();
    final appBar = WxAppBar( this, id, title, style: style );
    _appBar = appBar;
    _jsAttachAppBar( _handle, appBar._handle );
    _modeChanged();
    return appBar;
  }

  /// Return appbar if any has been created
  WxAppBar? getAppBar() {
    return _appBar;
  }

  /// Instructs the drawwindow to be filled with a menu logically 
  /// resembling a menubar with menus
  void setDrawerFromMenuBar( WxMenuBar menubar ) {
    _drawerMenuBar = menubar;
    _modeChanged();
  }

  /// Instructs frame to "steal" menus from main [WxMenuBar], starting with
  /// menu given [startMenu] as you might want to skip the file menu
  /// 
  /// Set [useMenuBar] to false to not use the menubar in the drawer.
  void setDrawerFromStandardMenuBar( { bool useMenuBar=true, int startMenu=1 }) {
    _buildDrawerFromStandardMenuBar = useMenuBar;
    _startMenu = startMenu;
    _modeChanged();
  }

  /// Instructs drawer to use [window]
  void setDrawerFromWindow( WxWindow window ) {
    _drawerWindow = window;
    _modeChanged();
  }

  /// Put a [title] at the top of the drawer
  void setDrawerTitle( String title ) {
    _drawerTitle = title;
    _modeChanged();
  }

  /// Creates a floating action button, a typical feature of smartphone to
  /// initiate a major new action, like write a new mail or starting a game.
  WxButton createFloatingActionButton( String label, int id, WxBitmapBundle? bitmap ) {
    final button = WxButton( this, id, label );
    if (bitmap != null) {
      // the button has the accent colour: an icon in the accent colour
      // would be invisible on it
      button.setBitmap( bitmap._themedOnAccent() ?? bitmap );
    }
    _floatingActionButton = button;
    _modeChanged();
    return button;
  }

  /// Returns floating action button, if any
  WxWindow? getFloatingActionButton() {
    return _floatingActionButton;
  }

  /// Open the drawer, if there is one
  void openDrawer() {
    _jsDrawerOpen( _handle, true );
  }

  /// Close the drawer, if there is one and it is open
  void closeDrawer() {
    _jsDrawerOpen( _handle, false );
  }

  // ------------------------- wxDart Web: switching modes ----------------------

  // app bar and floating action button are not laid out like children
  @override
  bool _isFrameChrome( WxWindow child ) {
    return super._isFrameChrome( child ) || child == _appBar || child == _floatingActionButton || child == _windowInDrawer;
  }

  @override
  void show({bool show = true}) {
    super.show(show: show);
    if (show) _modeChanged();
  }

  @override
  void onInternalIdle() {
    super.onInternalIdle();
    // the browser window may have become smaller or larger
    if (_touchMode != null && wxTheApp.isTouch() != _touchMode) {
      _modeChanged();
    } else if (_windowInDrawer != null) {
      _sizeWindowInDrawer();
    }
  }

  bool get _hasDrawer =>
      _drawerMenuBar != null || (_buildDrawerFromStandardMenuBar && getMenuBar() != null) || _drawerWindow != null;

  @override
  void _updateChrome() {
    final touch = _touchMode ?? false;
    _jsFrameChrome( _handle, _isSecondary && isShown(), touch && _hasDrawer, getTitle() );
  }

  /// Applies touch or desktop mode
  void _modeChanged() {
    if (_isDestroyed) return;
    final touch = wxTheApp.isTouch();
    _touchMode = touch;
    final appBar = _appBar;
    if (appBar != null) {
      _jsShow( appBar._handle, touch );
      appBar._hidden = !touch;
    }
    // without app bar, the menu bar stays
    _jsFrameMenuBar( _handle, !touch || appBar == null );
    final fab = _floatingActionButton;
    if (fab != null) {
      _jsFabSet( _handle, fab._handle, touch && !fab._hidden );
    }
    if (touch && _hasDrawer) {
      _fillDrawer();
    } else {
      _emptyDrawer();
    }
    _updateChrome();
    _layoutChildren();
  }

  /// The menus shown in the drawer
  List<WxMenu> _drawerMenus() {
    WxMenuBar? bar;
    int start = 0;
    if (_drawerMenuBar != null) {
      bar = _drawerMenuBar;
    } else if (_buildDrawerFromStandardMenuBar) {
      bar = getMenuBar();
      start = _startMenu;
    }
    if (bar == null) return [];
    final menus = <WxMenu>[];
    for (int i = start; i < bar.getMenuCount(); i++) {
      final menu = bar.getMenu( i );
      if (menu != null) menus.add( menu );
    }
    return menus;
  }

  void _fillDrawer() {
    final items = <Object>[];
    for (final menu in _drawerMenus()) {
      // let update UI handlers set checks and enabled states
      menu._updateUI();
      items.add( { "k": "menu", "t": _wxStripMnemonic( menu.getTitle() ) } );
      for (final item in menu.getMenuItems()) {
        if (item.isSeparator() || item.isSubMenu()) continue;
        items.add( {
          "k": item.isCheck() ? "check" : (item.isRadio() ? "radio" : "normal"),
          "t": item.getItemLabelText(),
          "id": item.getId(),
          "c": item.isChecked(),
          "e": item.isEnabled(),
        } );
      }
    }
    final window = _drawerWindow;
    if (_windowInDrawer != null && _windowInDrawer != window) _emptyDrawer();
    _jsDrawerSet( _handle, jsonEncode( { "title": _drawerTitle, "items": items } ), window?._handle ?? 0 );
    if (window != null && _windowInDrawer != window) {
      // taken out of the layout of the frame, but visible in the drawer
      _windowInDrawer = window;
      window._hidden = true;
      window._requestLayoutOfParents();
    }
    _sizeWindowInDrawer();
  }

  void _emptyDrawer() {
    final window = _windowInDrawer;
    _windowInDrawer = null;
    _drawerSlot = WxSize.zero;
    _jsDrawerSet( _handle, '', 0 );
    if (window != null && !window._isDestroyed) {
      window._hidden = false;
      _jsShow( window._handle, true );
      window._requestLayoutOfParents();
    }
  }

  void _sizeWindowInDrawer() {
    final window = _windowInDrawer;
    if (window == null) return;
    final s = _jsDrawerSlotSize( _handle );
    final size = WxSize( s.w, s.h );
    if (size == _drawerSlot || s.w <= 0 || s.h <= 0) return;
    _drawerSlot = size;
    window._setActualRect( 0, 0, s.w, s.h );
  }

  /// The drawer was opened or closed
  void _onDrawer( bool open ) {
    _drawerIsOpen = open;
    // update check marks and enabled states
    if (open && (_touchMode ?? false) && _hasDrawer) _fillDrawer();
  }

  /// A menu item in the drawer was clicked
  bool _onDrawerMenu( int id ) {
    for (final menu in _drawerMenus()) {
      final item = menu.findItem( id );
      if (item == null) continue;
      if (!item.isEnabled()) return true;
      if (item.isCheck()) {
        item.check( !item.isChecked() );
      } else if (item.isRadio()) {
        item.check( true );
      }
      // sent to the frame, as from the drawer in wxDart Flutter
      final event = WxCommandEvent( wxGetMenuEventType(), id );
      event.setInt( item.isChecked() ? 1 : 0 );
      event.setEventObject( this );
      processEvent( event );
      // show the new check marks
      if (_drawerIsOpen && (item.isCheck() || item.isRadio())) _fillDrawer();
      return true;
    }
    return false;
  }
}
