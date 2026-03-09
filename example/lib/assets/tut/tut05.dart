
import 'package:wx_dart/wx_dart.dart';

const idAbout = 100;

// Give the button an ID
const idButton = 206;

class MyPanel extends WxPanel {
  MyPanel( super.parent, super.id ) 
  {
    WxStaticText( this, -1, "A dialog will appear when you press the button.", pos: WxPoint(20,50) );

    // A button with idButton = 206
    // We will intercept the button event in MyFrame
    WxButton( this, idButton, "Push me!", pos: WxPoint(20,150) );
  }
}

class MyFrame extends WxFrame {
  MyFrame( WxFrame? parent) : super( parent, -1, "Event", size: WxSize(900, 700), ) 
  {
    final menubar = WxMenuBar();
    final filemenu = WxMenu();
    filemenu.appendItem( idAbout, "About\tAlt-A", help: "About Hello World" );
    filemenu.appendSeparator();
    filemenu.appendItem( wxID_EXIT, "Quit app\tCtrl-Q", help: "Run, baby, run!" );
    menubar.append(filemenu, "File");

    setMenuBar(menubar);

    MyPanel( this, -1 );

    // Bind to button event from the button in MyPanel. The
    // button event will get propagated up to the MyFrame
    // and is identified by the id 'idButton'.
    bindButtonEvent((event) {
      final dialog = WxMessageDialog( this, "Button 206 pressed", caption: "wxDart" );
      dialog.showModal(null);
    },idButton);

    bindMenuEvent((_) {
      final dialog = WxMessageDialog( this, "Welcome to Hello World", caption: "wxDart" );
      dialog.showModal(null);
    }, idAbout );

    bindMenuEvent( (_) => close(false), wxID_EXIT );

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

// The main function creating, running and deleting the app
/*void main()
{
  final myApp = MyApp();
  myApp.run();
  myApp.dispose();
}*/
