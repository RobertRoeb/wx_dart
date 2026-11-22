
import 'package:wx_dart_web/wx_dart.dart';

const idAbout = 100;

// Some proposals for colours
const idRedTheme = 200;
const idGreenTheme = 201;
const idBlueTheme = 202;
const idPurpleTheme = 203;
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

    final hl = WxHyperlinkCtrl(this, -1, 'http://wxwidgets.org', 'http://wxwidgets.org');
    flex.add( hl, flag: wxALL, border: 5 );

    flex.add( WxHyperlinkCtrl(this, -1, 'http://flutter.dev', 'http://flutter.dev'), flag: wxALL, border: 5 );

    hl.bindHyperlinkEvent((event){
      WxWindow parent = getParent()!;
      parent = parent.getParent()!;
      if (parent is WxFrame) {
        wxLogStatus( parent, "You clicked on the best!" );
      }
      event.skip();
    }, -1);


    setSizer( sizer ); 
  }
}

class MyPanel extends WxScrolledWindow {
  MyPanel( super.parent, super.id ) : super( style: wxVERTICAL)
  {
    final sizer = WxColumn();
    setSizer( sizer );

    sizer.addStretchSpacer();
    sizer.add( WxStaticText(this, -1, "wxDart Web is fast."), flag: wxALIGN_CENTER );
    sizer.addStretchSpacer();
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

    // Only wxDart Flutter and wxDart Web supports the accent colours.  
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

    // Tool bar

    final toolbar = createToolBar(style: wxTB_DEFAULT_STYLE | wxTB_TEXT);
    toolbar.addRadioTool(idRedTheme, "Red", materialIcon(WxMaterialIcon.palette, colour: WxColour(200, 40, 40)), null,
        shortHelp: "Red theme");
    toolbar.addRadioTool(idGreenTheme, "Green", materialIcon(WxMaterialIcon.palette, colour: WxColour(40, 150, 60)), null,
        shortHelp: "Green theme");
    toolbar.addRadioTool(idBlueTheme, "Blue", materialIcon(WxMaterialIcon.palette, colour: WxColour(40, 80, 200)), null,
        shortHelp: "Blue theme");
    toolbar.addRadioTool(idBlueTheme, "Purple", materialIcon(WxMaterialIcon.palette, colour: WxColour(103, 58, 183 )), null,
        shortHelp: "Purple theme");
    toolbar.addSeparator();
    // appearance: a second radio group
    toolbar.addRadioTool(idLightMode, "Light", materialIcon(WxMaterialIcon.light_mode), null, shortHelp: "Light appearance");
    toolbar.addRadioTool(idDarkMode, "Dark", materialIcon(WxMaterialIcon.dark_mode), null, shortHelp: "Dark appearance");
    toolbar.addStretchableSpace();
    toolbar.addTool(idAbout, "About", materialIcon(WxMaterialIcon.info),
        shortHelp: "About wxDart Web");

    // Status bar

    createStatusBar( number: 2 );
    setStatusText( "Welcome to wxDart Web" );
    setStatusText( "Looks great!", number: 1 );

    final sizer = WxColumn();
    setSizer( sizer );
    sizer.add( MyPanel(this, -1), proportion: 1, flag: wxEXPAND );

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
    // Set accent colours
    bindMenuEvent( (_) => wxTheApp.setAccentColour( WxColour( 103, 58, 183 ) ), idPurpleTheme );
    bindMenuEvent( (_) => wxTheApp.setAccentColour( WxColour( 44, 176, 48 ) ), idGreenTheme );
    bindMenuEvent( (_) => wxTheApp.setAccentColour( WxColour(138, 184, 221) ), idBlueTheme );
    bindMenuEvent( (_) => wxTheApp.setAccentColour( WxColour(212, 55, 55) ), idRedTheme);
  }

  late WxTextCtrl _log;
}

class MyMobileFrame extends WxAdaptiveFrame {
  MyMobileFrame( WxWindow ?parent ) 
  : super( parent, -1, "wxDart Demo" )
  {
    WxAppBar? appBar;

    appBar = createAppBar( "Demo", style: 0);
    appBar.addAction( idAbout, "About" );
    appBar.realize();

      final menubar = WxMenuBar();
      final colormenu = WxMenu();
      colormenu.appendItem( idRedTheme, "Red", help: "Choose red theme" );
      colormenu.appendItem( idGreenTheme, "Green\tCtrl-G", help: "Choose green theme" );
      colormenu.appendItem( idBlueTheme, "Blue\tCtrl-B", help: "Choose blue theme" );
      colormenu.appendItem( idPurpleTheme, "Purple\tCtrl-P", help: "Choose purple theme" );
      colormenu.appendSeparator();
      colormenu.appendItem( idLightMode, "Light mode", help: "Choose light mode" );
      colormenu.appendItem( idDarkMode, "Dark mode\tCtrl-D", help: "See you on the dark side!" );
      menubar.append(colormenu, "&Colors");

      setDrawerFromMenuBar(menubar);
      setDrawerTitle("wxDart rocks" );

    bindMenuEvent( (_) => close(false), wxID_EXIT );
    bindCloseWindowEvent( (_) => destroy() );

    final navi = WxNavigationCtrl(this,-1);

    List<WxBitmapBundle> images = [];
    images.add( WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.home, WxSize(30,30) ) );
    images.add( WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.info, WxSize(30,30) ) );
    navi.setImages(images);

    final panel = MyPanel( navi, -1 );
    navi.addPage(panel, "Start", image: 0);

    final info = MyInfoPage( navi );
    navi.addPage(info, "Info", image: 1);

    appBar.attach( info );

    // Bind to menu event
    bindMenuEvent((_) {
      final dialog = WxMessageDialog( this, "Welcome to Hello World", caption: "wxDart" );
      dialog.showModal( (result,_) {
        if (result == wxID_OK) {
          showInfoBar("You pressed OK", duration: 1500 );
        }
      });
    }, idAbout );

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
  bool isTouch() {
    return true;
  }

  @override
  bool onInit() {
    if (isTouch()) {
      // Mobile web
      final myFrame = MyMobileFrame( null );
      myFrame.show();
    } else {
      // Desktop web
      final myFrame = MyFrame( null );
      myFrame.show();
    }
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
