// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxFrame ----------------------

WxFrame? theTLW;
const int wxDEFAULT_FRAME_STYLE = (wxSYSTEM_MENU | wxRESIZE_BORDER | wxMINIMIZE_BOX | wxMAXIMIZE_BOX | wxCLOSE_BOX | wxCAPTION | wxCLIP_CHILDREN);


/// Main toplevel window. Each app needs to have at least one WxFrame.
/// 
/// For mobile devices, use the specialized [WxAdaptiveFrame].
/// 
/// On the desktop, a [WxFrame] most often has a [WxMenuBar] and/or a [WxToolBar] and
/// it may have a [WxStatusBar] at the bottom for information.
/// 
/// Here is an example to start with
/// 
/// ```Dart
/// // wxDart uses IDs to identify menu items,
/// // toolbar items, and sometimes controls.
/// const idAbout = 100;
/// 
/// // Every app needs a WxFrame as a main window.
/// class MyFrame extends WxFrame {
///   MyFrame( WxFrame? parent) : super( parent, -1, "Hello World", size: WxSize(900, 700) ) 
///   {
///     // Create a menu bar
///     final menubar = WxMenuBar();
/// 
///     // Create a menu 
///     final filemenu = WxMenu();
///     // Create a menu item with short cuts and help text
///     filemenu.appendItem( idAbout, "About\tAlt-A", help: "About Hello World" );
///     filemenu.appendSeparator();
///     filemenu.appendItem( wxID_EXIT, "Quit app\tCtrl-Q", help: "Run, baby, run!" );
///     // Attach menu to menu bar
///     menubar.append(filemenu, "File");
/// 
///     // Attach menu bar to this frame
///     setMenuBar(menubar);
/// 
///     // Create status bar at the bottom
///     createStatusBar();
///     setStatusText( "Welcome to wxDart" );
/// 
///     // Bind this function to wxID_EXIT (which is a pre-defined ID) used
///     // in the 'Quit' menu item. In the handler, request to close the WxFrame
///     bindMenuEvent( (_) => close(false), wxID_EXIT );
/// 
///     // Someone requested to close. This could also come from the user clicking
///     // on the X button at the top of a window, or from a menu, or programmatically
///     // by calling WxFrame.close()
///     bindCloseWindowEvent( (event) { 
///       // You could veto
///       // event.veto( true ); 
///       // return
/// 
///       // otherwise, go ahead and quit
///       destroy();
///     } );
///   }
/// }
/// ```
/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxDEFAULT_FRAME_STYLE | (wxSYSTEM_MENU | wxRESIZE_BORDER | wxMINIMIZE_BOX | wxMAXIMIZE_BOX | wxCLOSE_BOX | wxCAPTION | wxCLIP_CHILDREN) |

class WxFrame extends WxTopLevelWindow {
  WxFrame( super._parent, super._id, super._title, { super.pos = wxDefaultPosition, super.size = wxDefaultSize, super.style = wxDEFAULT_FRAME_STYLE } ) {
    theTLW ??= this;

    bindMenuHighlightEvent(onMenuHighlight);
  }

  WxMenuBar? _menubar;
  WxStatusBar? _statusBar;
  WxToolBar? _toolBar;

  void onMenuHighlight( WxMenuEvent event )
  {
    WxMenuItem? item = findItemInMenuBar(event.getMenuId() );
    if (item != null) {
      if (item.getHelp().isNotEmpty) {
        setStatusText( item.getHelp() );
      }
    }
  }

  @override
  void _updateTheme()
  {
    if (_toolBar != null) {
      _toolBar!._updateTheme();
    }
  }

  @override
  void onInternalIdle()
  {
    if (theTLW == this) {
      final event = WxIdleEvent();
      event.setEventObject(wxTheApp);
      wxTheApp.processEvent( event );
    }
    if (_toolBar != null) {
      _toolBar!.onInternalIdle();
    }
    if (_menubar != null) {
      _menubar!.onInternalIdle();
    }
    super.onInternalIdle();
  }

  WxToolBar createToolBar( { int style = wxTB_DEFAULT_STYLE, int id = -1 } )
  {
    _toolBar = WxToolBar( this, id, style: style );
    _children.remove(_toolBar);
    _setState();
    return _toolBar!;
  }
  WxToolBar? getToolBar() {
    return _toolBar;
  }

  WxStatusBar createStatusBar( { int number = 1 } )
  {
    if (_statusBar != null) {
      wxLogError( "status bar already created" );
      return _statusBar!;  
    }
    _statusBar = WxStatusBar(this);
    _statusBar!.setFieldsCount( count: number );
    _setState();
    return _statusBar!;
  }
  WxStatusBar? getStatusBar() {
    return _statusBar;
  }

  WxMenuItem? findItemInMenuBar( int id ) {
    if (_menubar == null) {
      return null;
    }
    return  _menubar!.findItem( id );
  }

  void setStatusText( String text, { int number = 0 } ) {
    if (_statusBar != null) {
      _statusBar!.setStatusText(text,index: number);
    }
  }

  void setMenuBar( WxMenuBar menubar ) {
    _menubar = menubar;
    menubar.attach( this );
    _setState();
  }

  WxMenuBar? getMenuBar() {
    return _menubar;
  } 

  @override
  Widget _build(BuildContext context) {

    Widget? body;
    NavigationBar ?navi;
    
    if ((_menubar != null) || (_statusBar != null) || (_toolBar != null))
    {
      Column col = Column( children: [] );
      if ((_menubar != null) && (_fullScreenFlags & wxFULLSCREEN_NOMENUBAR == 0)) {
        col.children.add( 
          Row( children: [ Expanded( child:  _menubar!._build(context, this) ) ] ) );
      }
      if ((_toolBar != null) && (_fullScreenFlags & wxFULLSCREEN_NOTOOLBAR == 0)){
        col.children.add( 
          Row( children: [ Expanded( child:  _toolBar!._build(context) ) ] ) );
      }

      // check if single child is WxNavigationCtrl
      WxWindow ?page;
      if (_children.length == 1)
      {
        final child = _children[0];
        if (child is WxNavigationCtrl)
        {
          navi = child._build( context ) as NavigationBar;
          page = child.getCurrentPage();
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
                ) ] ) ) 
        );
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

      if ((_statusBar != null) && (_fullScreenFlags & wxFULLSCREEN_NOSTATUSBAR == 0)) {
        col.children.add( 
          Row( children: [ Expanded( child: _statusBar!._build(context) ) ] ) );
      }
      body = col;

    } 
    else 
    {
      // check if single child is WxNavigationCtrl
      WxWindow ?page;
      if (_children.length == 1)
      {
        final child = _children[0];
        if (child is WxNavigationCtrl)
        {
          navi = child._build( context ) as NavigationBar;
          page = child.getCurrentPage();
        }
      }

      if (page != null)
      {
        // is WxNavigationCtrl
        body = page._build( context );
      } 
      else 
      {
        // no WxNavigationCtrl
        body = _doBuildChildrenWithOrWithoutSizer( context );
      }
    }

    Widget finalWidget = 
     Scaffold(
      appBar: getParent() == null ? null : AppBar(  // main title should be in the titlebar of the browser
        title: Text(_title),
      ),
      body: body,
      bottomNavigationBar: navi,
    ); 

    finalWidget = _buildTLW(context, finalWidget);

    finalWidget = _doBuildSizeEventHandler(context, finalWidget );

    return finalWidget;
  }
}
