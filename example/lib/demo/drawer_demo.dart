
import 'package:wx_dart/wx_dart.dart';

class MyWindowWithJumpingSidebar extends WxWindow {
  MyWindowWithJumpingSidebar( WxWindow parent, int id, { WxPoint pos=wxDefaultPosition, WxSize size=wxDefaultSize, int style=0 }) :
    super( parent, id, pos, size, style )
  {
    _isTouch = wxTheApp.isTouch();

    _mainSizer = WxBoxSizer( wxHORIZONTAL );
    setSizer( _mainSizer );

    _drawerPanel = WxPanel( this, -1, size: WxSize( 250,100), style: wxTRANSLUCENT_WINDOW  );
    _mainSizer.add( _drawerPanel, flag: wxEXPAND );
    _drawerPanel.show( show: !_isTouch );

    final panelSizer = WxBoxSizer( wxVERTICAL );
    _drawerPanel.setSizer( panelSizer );

    // create jumping window on the left
    _jumpingWindow = WxWindow( _drawerPanel, -1, wxDefaultPosition, wxDefaultSize, 0 ); 
    WxStaticText( _jumpingWindow, -1, "Jumping window", pos: WxPoint(10, 10) );
    panelSizer.add( _jumpingWindow, flag: wxEXPAND, proportion: 1 );

    // create main window on the right
    _mainWindow = WxWindow( this, -1, wxDefaultPosition, wxDefaultSize, wxBORDER_SIMPLE ); 
    WxStaticText( _mainWindow, -1, "Main window", pos: WxPoint(10, 10) );
    // _mainWindow.setBackgroundColour(wxYELLOW);
    _mainSizer.add( _mainWindow, flag: wxEXPAND, proportion: 1 );

    bindSizeEvent( _onSize );
  }

  WxWindow getJumpingWindow() {
    return _jumpingWindow;
  }

  late WxWindow _jumpingWindow;
  late WxWindow _mainWindow;
  bool _isTouch = false;
  late WxPanel _drawerPanel;
  late WxBoxSizer _mainSizer;
 
  void _onSize( WxSizeEvent event )
  {
    if (_isTouch != wxTheApp.isTouch())
    {
      _isTouch = wxTheApp.isTouch();
      _drawerPanel.show( show: !_isTouch );
    }
    event.skip();
  }
}

class MyDrawerFrame extends WxAdaptiveFrame {
  MyDrawerFrame( WxWindow parent ) 
  : super( parent, -1, "MyDrawerFrame", size: WxSize( 500, 400 ) )
  {
    final appBar = createAppBar("Drawer Demo");
    appBar.addTool( wxID_EXIT, "Exit", WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.menu_open, WxSize(32,32) ) );
    
    bindMenuEvent( (_) => close(false), wxID_EXIT );
    bindCloseWindowEvent( (_) => destroy() );

    final window = MyWindowWithJumpingSidebar(this, -1);

    setDrawerFromWindow( window.getJumpingWindow() );
  }
}
