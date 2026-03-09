
import 'package:wx_dart/wx_dart.dart';

const idAbout = 100;

// Some proposals for colours
const idRedTheme = 200;
const idGreenTheme = 201;
const idBlueTheme = 202;
const idPurpleTheme = 203;
const idLightMode = 204;
const idDarkMode = 205;

class MyFrame extends WxFrame {
  MyFrame( WxFrame? parent) : super( parent, -1, "Hello World", size: WxSize(900, 700), ) 
  {
    final menubar = WxMenuBar();
    final filemenu = WxMenu();
    filemenu.appendItem( idAbout, "About\tAlt-A", help: "About Hello World" );
    filemenu.appendSeparator();
    filemenu.appendItem( wxID_EXIT, "Quit app\tCtrl-Q", help: "Run, baby, run!" );
    menubar.append(filemenu, "File");

    // Only wxDart Flutter supports the accent colours.  
    final colormenu = WxMenu();
    colormenu.appendItem( idRedTheme, "Red", help: "Choose red theme" );
    colormenu.appendItem( idGreenTheme, "Green", help: "Choose green theme" );
    colormenu.appendItem( idBlueTheme, "Blue", help: "Choose blue theme" );
    colormenu.appendItem( idPurpleTheme, "Purple", help: "Choose purple theme" );
    colormenu.appendSeparator();
    // Add menu to let user choose colour and light
    // or dark mode. Both wxDart Flutter and wxDart Native
    // support light and dark modes.
    colormenu.appendItem( idLightMode, "Light mode", help: "Choose light mode" );
    colormenu.appendItem( idDarkMode, "Dark mode", help: "See you on the dark side!" );
    menubar.append(colormenu, "Colors");

    setMenuBar(menubar);

    createStatusBar( number: 2 );
    setStatusText( "Welcome to wxDart" );
    setStatusText( "Looks great!", number: 1 );

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

    // Set light or dark appearance in app
    bindMenuEvent( (_) => wxTheApp.setAppearance( wxAPPEARANCE_DARK ), idDarkMode );
    bindMenuEvent( (_) => wxTheApp.setAppearance( wxAPPEARANCE_LIGHT ), idLightMode );
    // Set accent colours
    bindMenuEvent( (_) => wxTheApp.setAccentColour( WxColour( 103, 58, 183 ) ), idPurpleTheme );
    bindMenuEvent( (_) => wxTheApp.setAccentColour( WxColour( 44, 176, 48 ) ), idGreenTheme );
    bindMenuEvent( (_) => wxTheApp.setAccentColour( WxColour(138, 184, 221) ), idBlueTheme );
    bindMenuEvent( (_) => wxTheApp.setAccentColour( WxColour(212, 55, 55) ), idRedTheme);
  }
}

class MyApp extends WxApp {
  MyApp() {
    // do something here for start-up
  }

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
