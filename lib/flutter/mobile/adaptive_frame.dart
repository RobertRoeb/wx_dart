// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
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
/// Drawer interface:
/// * [openDrawer]
/// * [closeDrawer]
/// * [setDrawerTitle]
/// * [setDrawerFromWindow]
/// * [setDrawerFromMenuBar]

class WxAdaptiveFrame extends WxFrame {
  WxAdaptiveFrame( super._parent, super._id, super._title, { super.pos = wxDefaultPosition, super.size = wxDefaultSize, super.style = wxDEFAULT_FRAME_STYLE } );

  WxAppBar? _appBar;
  WxMenuBar? _drawerMenuBar;
  WxWindow? _drawerWindow;
  bool _buildDrawerFromStandardMenuBar = false;
  int _startMenu = 1;
  String _drawerTitle = "";
  WxWindow? _floatingActionButton;
  bool _drawerIsOpen = false;

  @override
  void _updateTheme()
  {
    super._updateTheme();
    if (_appBar != null) {
      _appBar!._updateTheme();
    }
  }

  @override
  void onInternalIdle()
  {
    super.onInternalIdle();
    if (_appBar != null) {
      _appBar!.onInternalIdle();
    }
    if (_drawerMenuBar != null) {
      _drawerMenuBar!.onInternalIdle();
    }
  }

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
    _appBar = WxAppBar( this, id, title, style: style );
    _children.remove(_appBar);
    _setState();
    return _appBar!;
  }

  /// Return appbar if any has been created
  WxAppBar? getAppBar() {
    return _appBar;
  }

  /// Instructs the drawwindow to be filled with a menu logically 
  /// resembling a menubar with menus
  void setDrawerFromMenuBar( WxMenuBar menubar ) {
    _drawerMenuBar = menubar;
  }

  /// Instructs frame to "steal" menus from main [WxMenuBar], starting with
  /// menu given [startMenu] as you might want to skip the file menu
  /// 
  /// Set [useMenuBar] to false to not use the menubar in the drawer.
  void setDrawerFromStandardMenuBar( { bool useMenuBar=true, int startMenu=1 }) {
    _buildDrawerFromStandardMenuBar = useMenuBar;
    _startMenu = startMenu;
  }

  /// Instructs drawer to use [window]
  void setDrawerFromWindow( WxWindow window ) {
    _drawerWindow = window;
  }

  /// Put a [title] at the top of the drawer
  void setDrawerTitle( String title ) {
    _drawerTitle = title;
  }

  /// Creates a floating action button, a typical feature of smartphone to
  /// initiate a major new action, like write a new mail or starting a game.
  WxButton createFloatingActionButton( String label, int id, WxBitmapBundle? bitmap ) {
    final button = WxButton( this, id, label );
    _children.remove( button );
    if (bitmap != null) {
      button.setBitmap( bitmap );
    }
    _floatingActionButton = button;
    return button;
  }

  /// Returns floating action button, if any
  WxWindow? getFloatingActionButton() {
    return _floatingActionButton;
  }

  Widget? _buildDrawerFromMenuBar()
  {
    int startmenu = 0;
    WxMenuBar ?menubar;
    if (_drawerMenuBar != null) {
      menubar = _drawerMenuBar;
    } else
    if ((_menubar != null) && (_buildDrawerFromStandardMenuBar)) {
      startmenu = _startMenu; // ignore file menu, this should be in appbar
      menubar = _menubar;
    } else {
      return null;
    }

    List<Widget> children = [];

    _addSpaceAtTheTopOfDrawer( children );

    if (_drawerTitle.isNotEmpty) {
        children.add(
          Padding(
            padding: EdgeInsets.fromLTRB(30,10,0,10),
            child:
              Center( child:
                Text(_drawerTitle,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
                     )
              ));
    }

    for (int i = startmenu; i < menubar!.getMenuCount(); i++)
    {
      final menu = menubar!.getMenu( i );
      if (menu != null) {
        children.add(Text(menu.getTitle(),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)));
        for (final item in menu._items)
        {
          if (item.getKind() == wxITEM_NORMAL)
          {
            children.add( Padding(
              padding: EdgeInsets.fromLTRB(30,5,0,5),
              child: ElevatedButton(
                  child:  Text(item.getText()),
                  onPressed: () {
                    closeDrawer();
                    WxCommandEvent event = WxCommandEvent( wxGetMenuEventType(), item.getId() );
                    event.setEventObject( this );
                    processEvent( event ); 
                    }),
              )
            );
          } else
          if (item.getKind() == wxITEM_CHECK)
          {
            children.add( Padding(
              padding: EdgeInsets.fromLTRB(30,5,0,5),
              child: Row(children: <Widget>[
                  Transform.scale(
                      scale: 0.7,
                      child: Switch(
                          value: item.isChecked(),
                          onChanged: (value) {
                            WxCommandEvent event = WxCommandEvent( wxGetMenuEventType(), item.getId() );
                            event.setInt( value ? 1 : 0 );
                            event.setEventObject( this );
                            processEvent( event ); 
                            onInternalIdle();
                            _setState();
                            // closeDrawer();
                          })),
                  Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(item.getText()))
                ]),
              )
            );
          } else
          if (item.getKind() == wxITEM_RADIO)
          {
            children.add( Padding(
              padding: EdgeInsets.fromLTRB(30,5,0,5),
              child: Row(children: <Widget>[
                Icon( 
                item.isChecked()
                ? Icons.radio_button_checked
                : Icons.radio_button_unchecked, 
              size: 16 ),
              SizedBox( width: 14 ),
              ElevatedButton(
                  child:  Text(item.getText()),
                  onPressed: () {
                    WxCommandEvent event = WxCommandEvent( wxGetMenuEventType(), item.getId() );
                    event.setInt( item.isChecked() ? 0 : 1 );
                    event.setEventObject( this );
                    processEvent( event ); 
                    onInternalIdle();
                    _setState();
                    closeDrawer();
                    })
                ]),
              )
            );
          } 

        }
      }
    }

    return Drawer( child:
      Padding( padding: EdgeInsets.all(5),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ) ) );
  }

  /// Open the drawer, if there is one
  void openDrawer()
  {
    if (_drawerIsOpen) return;
    final state = _scaffoldKey.currentState;
    if (state == null) {
      wxLogError("No context to _build drawer" );
      return;
    }
    _setState(); 
    state.openDrawer();
  }

  /// Close the drawer, if there is one and it is open
  void closeDrawer()
  {
    if (!_drawerIsOpen) return;
    BuildContext? context = _scaffoldKey.currentContext;
    if (context == null) {
      wxLogError("No context to close drawer" );
      return;
    }
    Navigator.of(context).pop();
  }

  void _addSpaceAtTheTopOfDrawer( List<Widget> children )
  {
    if (wxIsAndroid() || wxIsIOS()) {
      // don't hide behind camera etc.
      children.add( SizedBox( height: 50 ) );
    }
  }

  Widget _buildDrawerFromWindow( BuildContext context )
  {
    List<Widget> children = [];

    _addSpaceAtTheTopOfDrawer( children );

    if (_drawerTitle.isNotEmpty) {
        children.add(
          Padding(
            padding: EdgeInsets.fromLTRB(30,10,0,10),
            child:
              Center( child:
                Text(_drawerTitle,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
                     )
              ));
    }

    children.add(
      Expanded( child: 
        _drawerWindow!._build( context )
      )
    );

    return Drawer( child:
      Padding( padding: EdgeInsets.all(5),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ) ) );
  }

  Widget? _buildDrawer( BuildContext context)
  {
    if (_drawerMenuBar != null) {
      return _buildDrawerFromMenuBar();
    }

    if ((_menubar != null) && _buildDrawerFromStandardMenuBar) {
      return _buildDrawerFromMenuBar();
    }

    if (_drawerWindow != null) {
      return _buildDrawerFromWindow( context );
    }

    return null;
  }

  @override
  Widget _build(BuildContext context)
  {
    if (!wxTheApp.isTouch()) {
      return super._build( context );
    }

    Widget? body;
    NavigationBar ?navi;
    
    Column col = Column( children: [] );
    if (_toolBar != null) {
      col.children.add( 
        Row( children: [ Expanded( child: _toolBar!._build(context) ) ] ) );
    }

      // Find single nonTLW child
      int nonTLWs = 0;
      WxWindow? onlyChild;
      for (WxWindow child in _children) {
        if (child is WxTopLevelWindow) continue;
        if (!child.isShown()) continue;
        nonTLWs++;
        onlyChild = child;
        if (nonTLWs == 2) break;
      }

      // check if single nonTLW child is WxNavigationCtrl
      WxWindow ?page;
      if (nonTLWs == 1)
      {
        if (onlyChild is WxNavigationCtrl)
        {
          navi = onlyChild._build( context ) as NavigationBar;
          page = onlyChild.getCurrentPage();
        }
      }

      if (page != null)
      {
        // WxNavigationCtrl
        col.children.add( 
          Expanded( child: Row( children: [ Expanded( child: 
            Container( 
              // color: Colors.amber,
              child: page._build( context ) ) 
                ) ] ) 
        ) );
      } 
      else 
      {
        // no WxNavigationCtrl
        col.children.add( 
          Expanded( child: Row( children: [ Expanded( child: 
            Container( //color: Colors.amber,
              child: _doBuildChildrenWithOrWithoutSizer( context ) ) 
                ) ] ) ) 
        );
      }

    if (_statusBar != null) {
      col.children.add( 
        Row( children: [ Expanded( child: _statusBar!._build(context) ) ] ) );
    }
    body = col;

    Widget finalWidget = 
     Scaffold(
      key: theTLW == this ? _scaffoldKey : null,
      appBar: _appBar?._buildAppBar( context ), 
      drawer: _buildDrawer( context ),
      onDrawerChanged: (isOpen)=>_drawerIsOpen = isOpen,
      body: body,
      bottomNavigationBar: navi,
      floatingActionButton: _floatingActionButton != null 
        ? (!_floatingActionButton!.isShown()
            ? null
            : _floatingActionButton!._build( context ))
        : null
    ); 

    finalWidget = _buildTLW(context, finalWidget);

    finalWidget = _doBuildSizeEventHandler(context, finalWidget );

    return finalWidget;
  }
}

