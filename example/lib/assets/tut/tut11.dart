
import 'package:wx_dart/wx_dart.dart';

const idAbout = 100;

class MyTileDataView extends WxPanel {
  MyTileDataView( WxWindow parent ) : super( parent, -1 )
  {
    _mainSizer = WxBoxSizer( wxHORIZONTAL );
    setSizer(_mainSizer);

    _dataview = WxDataViewTileListCtrl( this, -1, 80, 4, size: WxSize(300,-1), style: wxDV_NO_HEADER|wxVSCROLL );

    _isTouch = wxTheApp.isTouch();
    if (_isTouch)
    {
      _item = _mainSizer.add( _dataview, flag: wxEXPAND, proportion: 1 );
    }
    else
    {
      _item = _mainSizer.add( _dataview, flag: wxEXPAND );
      _mainSizer.addStretchSpacer();
    }

    final leading = WxBitmap.fromMaterialIcon( WxMaterialIcon.account_balance, WxSize(48,48), wxGREY );
    final trailing = WxBitmap.fromMaterialIcon( WxMaterialIcon.hot_tub, WxSize(48,48), wxGREY );
    for (int i = 0; i < 200; i++) {
      _dataview.appendTile( leading, "Main text in row #$i", "Medium text", small: "Small text at the bottom", trailing: trailing );
    }

    bindDataViewSelectionChangedEvent((event) {
      final frame = WxApp.getMainTopWindow() as WxFrame;
      int selection = _dataview.getSelectedRow();
      if (selection != -1) {
        final tileData = _dataview.getValue(selection, 0) as WxDataViewTileData;
        wxLogStatus( frame, "Selected item: ${tileData.big}" );
      }
    }, -1);

    bindDataViewItemActivatedEvent((event) {
      final frame = WxApp.getMainTopWindow() as WxFrame;
      int selection = _dataview.getSelectedRow();
      if (selection != -1) {
        final tileData = _dataview.getValue(selection, 0) as WxDataViewTileData;
        final dialog = WxMessageDialog(frame, "Clicked", caption: "WxDataViewTileListCtrl" );
        dialog.setExtendedMessage("Item click is: ${tileData.big}" );
        dialog.showModal(null);
        
      }
    }, -1);

    _isTouch = wxTheApp.isTouch();
    bindSizeEvent( onSize );
  }

  bool _isTouch = false;
  late WxBoxSizer _mainSizer;
  late WxSizerItem _item;
  late WxDataViewTileListCtrl _dataview;

  void onSize( WxSizeEvent event )
  {
    if (_isTouch != wxTheApp.isTouch())
    {
      _isTouch = wxTheApp.isTouch();
      if (_isTouch)
      {
        _item.setProportion( 1 );
        _dataview.setSize( WxSize(-1,-1) );
        _mainSizer.remove(1);
      }
      else
      {
        _item.setProportion( 0 );
        _dataview.setSize( WxSize(300,-1) );
        _mainSizer.addStretchSpacer();
      }
    }
    event.skip();
  }
}


class MyFrame extends WxAdaptiveFrame {
  MyFrame( WxFrame? parent) : super( parent, -1, "Tiles", size: WxSize(900, 700) ) 
  {
    // Create a Touch and a Desktop interface.
    // wxApp.isTouch() decides which one to show.
    // Experimental, but very cool.

    // Touch interface

      // AppBar, similar to a toolbar
      final appBar = createAppBar("Tiles");
      // add action with text button
      appBar.addAction( wxID_EXIT, "Quit" );
      // add "about" tool with bitmap
      appBar.addTool( idAbout, "", WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.info, WxSize(32,32) ) );

    // Desktop interface

      // Create a menu bar. This might be at the
      // top of the screen on a Mac.
      final menubar = WxMenuBar();

      // Create a menu 
      final filemenu = WxMenu();
      // Create a menu item with short cuts
      // and help text
      filemenu.appendItem( idAbout, "About\tAlt-A", help: "About Hello World" );
      filemenu.appendSeparator();
      filemenu.appendItem( wxID_EXIT, "Quit app\tCtrl-Q", help: "Run, baby, run!" );
      // Attach menu to menu bar
      menubar.append(filemenu, "File");

      // Attach menu bar to this frame
      setMenuBar(menubar);

    // Insert one single window into the client area
    // of the frame. That way, the frame will always 
    // resize this window to fill out the entire client
    // area.  
    MyTileDataView( this );

    createStatusBar( number: 2 );
    setStatusText( "Welcome to wxDart" );
    setStatusText( "Looks great!", number: 1 );

    bindMenuEvent((_) {
      final dialog = WxMessageDialog( this, "Welcome to Hello World", caption: "wxDart" );
      dialog.showModal(null);
    }, idAbout );

    bindMenuEvent( (_) => close(false), wxID_EXIT );
    bindCloseWindowEvent( (event) =>  destroy() );
  }
}

class MyApp extends WxApp {
  MyApp();
  
  @override
  bool onInit() {
    WxFrame myFrame = MyFrame( null );
    myFrame.show();
    return true;
  }
}

// The main function creating, running and
// deleting the app
/*void main()
{
  final myApp = MyApp();
  myApp.run();
  myApp.dispose();
}*/
