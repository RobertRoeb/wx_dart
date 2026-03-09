
import 'package:wx_dart/wx_dart.dart';

// wxDart uses IDs to identify menu items,
// toolbar items, and sometimes controls.
const idAbout = 100;

// Every app needs a WxFrame as a main window.
class MyFrame extends WxFrame {
  MyFrame( WxFrame? parent) : super( parent, -1, "Hello World", size: WxSize(900, 700) ) 
  {
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

    // Create status bar at the bottom
    createStatusBar( number: 2 );
    setStatusText( "Welcome to wxDart" );
    setStatusText( "Looks great!", number: 1 );

    // Bind this function to idAbout ID menu item
    bindMenuEvent((_) {
      // Show a message
      final dialog = WxMessageDialog( this, "Welcome to Hello World", caption: "wxDart" );
      dialog.showModal(null);
    }, idAbout );

    // Bind this function to wxID_EXIT (which is a
    // pre-defined ID) used in the 'Quit' menu item.
    // In the handler, request to close the WxFrame
    bindMenuEvent( (_) => close(false), wxID_EXIT );

    // Someone requested to close. This could also come
    // from the user clicking on the X button at the top
    // of a window, or from a menu, or programmatically
    // by calling WxFrame.close()
    bindCloseWindowEvent( (event) { 
      // You could veto
      // event.veto( true ); 
      // return

      // otherwise, go ahead and quit
      destroy();
    } );
  }
}

class MyApp extends WxApp {
  MyApp() {
    // do something here for start-up
  }

  @override
  bool onInit() {
    // create and show main window

    WxFrame myFrame = MyFrame( null );
    myFrame.show();

    return true;
  }

  @override
  int onExit() {
    // do something here for close-down
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
