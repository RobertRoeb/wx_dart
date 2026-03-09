
import 'package:wx_dart/wx_dart.dart';

const idAbout = 100;

// Derive new class from WxWindow
class MyWindow extends WxWindow {
  MyWindow( WxWindow parent, int id ) : super( parent, id, wxDefaultPosition, wxDefaultSize, 0 )
  {
    // Bind to paint event
    bindPaintEvent(onPaint);

    final font = WxFont( 15, weight: wxFONTWEIGHT_BOLD );
    final height = getTextExtent("H").y;
  }

  // define new paint event handler
  void onPaint( WxPaintEvent event )
  {
    // create paint device context during paint event
    final dc = WxPaintDC( this );

    // draw a line from a WxRect
    final rect = WxRect(10,10,100,100);
    dc.drawLinePts( rect.getTopLeft(), rect.getBottomRight() );
  }
}

class MyFrame extends WxFrame {
  MyFrame( WxFrame? parent) : super( parent, -1, "Hello World", size: WxSize(900, 700) ) 
  {
    final menubar = WxMenuBar();

    final filemenu = WxMenu();
    filemenu.appendItem( idAbout, "About\tAlt-A", help: "About Hello World" );
    filemenu.appendSeparator();
    filemenu.appendItem( wxID_EXIT, "Quit app\tCtrl-Q", help: "Run, baby, run!" );
    menubar.append(filemenu, "File");
    setMenuBar(menubar);

    // Insert one single window into the client area
    // of the frame. That way, the frame will always 
    // resize this window to fill out the entire client
    // area.  
    MyWindow( this, -1 );

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
