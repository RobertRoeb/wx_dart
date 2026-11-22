
import 'package:wx_dart/wx_dart.dart';

// Menu/toolbar IDs
const idAbout = 100;
const idLightMode = 204;
const idDarkMode = 205;

class MyInfoPage extends WxScrolledWindow {
  MyInfoPage( WxWindow parent ) : super( parent, -1, style: wxVSCROLL )
  {
    WxBoxSizer sizer = WxBoxSizer( wxVERTICAL );

    sizer.add( WxStaticText( this, -1, "About wxDart" )..setFont(WxFont(16,weight:wxFONTWEIGHT_BOLD)), flag: wxALL|wxALIGN_LEFT, border: 10 );

    sizer.add( WxStaticText( this, -1, 
    "Build web apps, mobile apps and native desktop apps from a single source using the Dart programming language.", 
      style: wxST_WRAP), flag: wxLEFT, border: 10 );

    sizer.addSpacer(10);
    sizer.add( WxStaticText( this, -1, "Main benefits" )..setFont(WxFont(16,weight:wxFONTWEIGHT_BOLD)), flag: wxALL|wxALIGN_LEFT, border: 10 );

    sizer.add( WxStaticText( this, -1, "- Dart creates native binaries (and Javascript on the Web)"), flag: wxLEFT, border: 5 );
    sizer.add( WxStaticText( this, -1, "- Native look'n'feel on Windows, macOS and Linux"), flag: wxLEFT, border: 5 );
    sizer.add( WxStaticText( this, -1, "- Supports 'async await' on all platforms"), flag: wxLEFT, border: 5 );
    sizer.add( WxStaticText( this, -1, "- Supports OpenGL on all platforms"), flag: wxLEFT, border: 5 );
    sizer.add( WxStaticText( this, -1, "- Support for iOS and Android (touch interface) and the web"), flag: wxLEFT, border: 5 );
    sizer.add( WxStaticText( this, -1, "- Support for light and dark modes"), flag: wxLEFT, border: 5 );
  
    sizer.addSpacer(10);
    sizer.add( WxStaticText( this, -1, "Current stage" )..setFont(WxFont(16,weight:wxFONTWEIGHT_BOLD)), flag: wxALL|wxALIGN_LEFT, border: 10 );
    sizer.add( WxStaticText( this, -1, 
      "wxDart is approaching a first stable version. This app has been written using wxDart.",
      style: wxST_WRAP ), flag: wxALL, border: 10 );

    sizer.add( WxStaticText(this, -1, 'Read more...'), flag: wxALL, border: 5 );

    final flex = WxFlexGridSizer( 2, vgap: 5, hgap: 5);
    sizer.addSizer( flex, flag: wxALIGN_CENTRE_HORIZONTAL ); 

    flex.add( WxStaticBitmap(this, -1, WxBitmapBundle.fromPNGAsset("wxWidgets.png")), flag: wxALIGN_CENTER_VERTICAL|wxALL, border: 5 );
    flex.add( WxStaticBitmap(this, -1, WxBitmapBundle.fromSVGAsset("flutter.svg", WxSize(48, 48))), flag: wxALIGN_CENTER_VERTICAL|wxALL, border: 5 );

    final hl = WxHyperlinkCtrl(this, -1, 'http://wxwidgets.org', 'http://wxwidgets.org');
    flex.add( hl, flag: wxALL, border: 5 );

    flex.add( WxHyperlinkCtrl(this, -1, 'http://flutter.dev', 'http://flutter.dev'), flag: wxALL, border: 5 );

    hl.bindHyperlinkEvent((event){
      wxLogMessage( "You clicked on the best!" );
      event.skip();
    }, -1);


    setSizer( sizer ); 
  }
}

/// Material icons: only the icons used here end up in main.dart.js.
/// Without a colour, they follow the light/dark appearance.
WxBitmapBundle materialIcon(WxMaterialIcon icon, {WxColour? colour}) =>
    WxBitmapBundle.fromMaterialIcon(icon, const WxSize(20, 20), colour: colour);

class MyFrame extends WxFrame {
  MyFrame( WxFrame? parent) : super( parent, -1, "Hello World", size: WxSize(900, 700), ) 
  {
    // Menu bar
    final menubar = WxMenuBar();
    final filemenu = WxMenu();
    filemenu.appendItem( idAbout, "About\tAlt-A", help: "About Hello World" );
    filemenu.appendSeparator();
    filemenu.appendItem( wxID_EXIT, "Quit app\tCtrl-Q", help: "Run, baby, run!" );
    menubar.append(filemenu, "File");

    final colormenu = WxMenu();
    // Add menu to let user choose colour and light
    // or dark mode. 
    colormenu.appendItem( idLightMode, "Light mode", help: "Choose light mode" );
    colormenu.appendItem( idDarkMode, "Dark mode", help: "See you on the dark side!" );
    menubar.append(colormenu, "Colors");

    setMenuBar(menubar);

    // Tool bar

    final toolbar = createToolBar(style: wxTB_DEFAULT_STYLE | wxTB_TEXT);
    toolbar.addRadioTool(idLightMode, "Light", materialIcon(WxMaterialIcon.light_mode), null, shortHelp: "Light appearance");
    toolbar.addRadioTool(idDarkMode, "Dark", materialIcon(WxMaterialIcon.dark_mode), null, shortHelp: "Dark appearance");
    toolbar.addStretchableSpace();
    toolbar.addTool(idAbout, "About", materialIcon(WxMaterialIcon.info),
        shortHelp: "About wxDart Native");
    toolbar.realize();

    // Status bar

    createStatusBar( number: 2 );
    setStatusText( "Welcome to wxDart Native" );
    setStatusText( "Looks great!", number: 1 );

    final sizer = WxColumn();
    setSizer( sizer );
    sizer.add( MyInfoPage(this), proportion: 1, flag: wxEXPAND );

    // Create a log at the bottom
    _log = WxTextCtrl(this, -1, size: WxSize(100,80), style: wxTE_MULTILINE );
    sizer.add( _log, flag: wxEXPAND );
    wxSetLogTarget(_log);

    // Bind to menu event
    bindMenuEvent((_) {
      final dialog = WxMessageDialog( this, "Welcome to Hello World", caption: "wxDart" );
      dialog.showModal( (result,_) {
        if (result == wxID_OK) {
          showInfoBar("You pressed OK", duration: 1500 );
        } else {
          wxLogMessage( "You cancelled." );
        }
      });
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
  }

  late WxTextCtrl _log;
}


class MyApp extends WxApp {
  MyApp() {
    // do something here for start-up
  }

  @override
  bool isTouch() {
    return true;
  }

  @override
  bool onInit() {
    // Desktop web
    final myFrame = MyFrame( null );
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
void main()
{
  final myApp = MyApp();
  myApp.run();
  myApp.dispose();
}
