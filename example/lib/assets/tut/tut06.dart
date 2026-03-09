
import 'package:wx_dart/wx_dart.dart';

const idAbout = 100;

// Use WxAdaptiveFrame as a main window. This offers
// either a Touch or a Desktop interface
class MyFrame extends WxAdaptiveFrame {
  MyFrame( WxFrame? parent) : super( parent, -1, "Adaptive", size: WxSize(900, 700) ) 
  {
    // Create a Touch and a Desktop interface.
    // wxApp.isTouch() decides which one to show.
    // Experimental, but very cool.

    // Touch interface

      // AppBar, similar to a toolbar
      final appBar = createAppBar("Adaptive");
      // add action with text button
      appBar.addAction( wxID_EXIT, "Quit" );
      // add "about" tool with bitmap
      appBar.addTool( idAbout, "", WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.info, WxSize(32,32) ) );

      // Floating action button for main action
      createFloatingActionButton("About", idAbout, WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.info, WxSize(32,32) ) );

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


    if (wxTheApp.isTouch())
    {
      // You can create a status bar here, as well
      // but that is unusual on mobile devices
    }
    else
    {
      // Create status bar at the bottom
      createStatusBar( number: 2 );
      setStatusText( "Welcome to wxDart" );
      setStatusText( "Looks great!", number: 1 );
    }

    // Put main window here.
    // WxPanel( this, -1 );

    // bind to idAbout from menu, toolbar or appbar
    bindMenuEvent( (_) => sayHello(), idAbout );

    // bind to wxID_EXIT from menu, toolbar or appbar
    bindMenuEvent( (_) => close(false), wxID_EXIT );

    // bind to idAbout from button (FloatingActionButton)
    bindButtonEvent((_) => sayHello(), idAbout );


    bindCloseWindowEvent( (event) { 
      // You could veto
      // event.veto( true ); 
      // return

      // otherwise, go ahead and quit
      destroy();
    } );
  }

  void sayHello() {
      final dialog = WxMessageDialog( this, "Welcome to Hello World", caption: "wxDart" );
      dialog.showModal(null);
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

  @override
  int onExit() {
    return 0;
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
