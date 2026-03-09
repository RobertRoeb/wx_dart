
import 'package:wx_dart/wx_dart.dart';

const idAbout = 100;

// now give one button an ID, but not the other one
const idButton = 206;

class MyPanel extends WxPanel {
  MyPanel( super.parent, super.id ) 
  {
    WxStaticText( this, -1, "A dialog will appear when you press either button.", pos: WxPoint(20,50) );

    // button with -1, meaning no ID
    final button = WxButton( this, -1, "Push me!", pos: WxPoint(20,100) );

    // Bind to button event from button directly. No ID needed.
    button.bindButtonEvent((event) {
      final dialog = WxMessageDialog( this, "Button -1 pressed", caption: "wxDart" );
      dialog.showModal(null);
    },-1);

    // button with idButton = 206
    WxButton( this, idButton, "Push me, too!", pos: WxPoint(20,150) );

    // Bind to button event from panel (its parent window). ID needed.
    bindButtonEvent((event) {
      final dialog = WxMessageDialog( this, "Button 206 pressed", caption: "wxDart" );
      dialog.showModal(null);
    },idButton);

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

    MyPanel( this, -1 );

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
