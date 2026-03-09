
import 'package:wx_dart/wx_dart.dart';

const idAbout = 100;

// Derive new class from WxScrolledWindow
class MyWindow extends WxScrolledWindow {
  MyWindow( super.parent, super.id )
  {
    // Create scroll area of 600x800 pixel
    setScrollbars(10, 10, 60, 80 );

    // Bind to paint event
    bindPaintEvent(onPaint);
  }

  // define new paint event handler
  void onPaint( WxPaintEvent event )
  {
    // create paint device context during paint event
    final dc = WxPaintDC( this );

    // adjust for scrolling
    doPrepareDC(dc);

    // draw a line
    dc.drawLine( 10, 10, 100, 100 );

      dc.setBackgroundMode(wxBRUSHSTYLE_TRANSPARENT);
      int x = 10;
      int y = 40;
      dc.setBrush( wxTRANSPARENT_BRUSH );
      dc.setPen( wxBLACK_PEN);

      for (int pointSize = 6; pointSize <= 18; pointSize++)
      {
          final font = WxFont( pointSize.toDouble() );
          dc.setFont( font );
          final size = dc.getTextExtent("Hello" );
          dc.drawRectangle(x, y, size.getWidth(), size.getHeight() );
          dc.drawText( "Hello at size $pointSize, w: ${size.getWidth()} h: ${size.getHeight()}", x, y );
          y += size.y + 5;
      }
  }
}

class MyFrame extends WxAdaptiveFrame {
  MyFrame( WxFrame? parent) : super( parent, -1, "Scrolling", size: WxSize(900, 700) ) 
  {
    // Create a Touch and a Desktop interface.
    // wxApp.isTouch() decides which one to show.
    // Experimental, but very cool.

    // Touch interface

      // AppBar, similar to a toolbar
      final appBar = createAppBar("Scrolling");
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
