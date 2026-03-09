
import 'package:wx_dart/wx_dart.dart';

const idAbout = 100;

// WxPanel is a simple window that usually handles
// child windows, mostly controls
class MyPanel extends WxPanel {
  MyPanel( super.parent, super.id ) 
  {
    // place some controls here using
    // absolute positions
    WxStaticText( this, -1, "Nothing will happen when you press the button.", pos: WxPoint(20,50) );
    WxButton( this, -1, "Push me!", pos: WxPoint(20,100) );
  }
}

class MyFrame extends WxFrame {
  MyFrame( WxFrame? parent) : super( parent, -1, "Hello World", size: WxSize(900, 700), ) 
  {
    final menubar = WxMenuBar();
    final filemenu = WxMenu();
    filemenu.appendItem( idAbout, "About\tAlt-A", help: "About Hello World" );
    filemenu.appendSeparator();
    filemenu.appendItem( wxID_EXIT, "Quit app\tCtrl-Q", help: "Run, baby, run!" );
    menubar.append(filemenu, "File");

    setMenuBar(menubar);

    // Insert MyPanel into the frame. If there is only one
    // window in a WxFrame then it will be automatically
    // resized to fill up the entire client area
    MyPanel( this, -1 );

    bindMenuEvent((_) {
      final dialog = WxMessageDialog( this, "Welcome to Hello World", caption: "wxDart" );
      dialog.showModal(null);
    }, idAbout );

    // Bind to 'Quit app' menu item
    // WxFrame.close() asks to close the frame.
    // This will trigger a wxCloseWindowEvent
    bindMenuEvent( (_) => close(false), wxID_EXIT );

    // Received request to close
    // WxFrame.destroy() closes the frame
    bindCloseWindowEvent( (_) => destroy() );
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

/*void main()
{
  final myApp = MyApp();
  myApp.run();
  myApp.dispose();
}*/
