
import 'package:wx_dart/wx_dart.dart';

import 'package:markdown/markdown.dart' as md;

import 'sizer_demo.dart';
import 'controls_demo.dart';
import 'dialogs_demo.dart';
import 'tiles_demo.dart';
import 'drawing_demo.dart';
import 'treebook_demo.dart';
import 'logging_demo.dart';
import 'info_demo.dart';
import 'tutorial_demo.dart';
import 'gesture_demo.dart';


const idRedTheme = 200;
const idGreenTheme = 201;
const idBlueTheme = 202;
const idPurpleTheme = 203;
const idLightMode = 204;
const idDarkMode = 205;
const idSystemMode = 206;

const idCheck = 210;
const idLeftAlign = 211;
const idCenterAlign = 212;
const idRightAlign = 213;

const idDialog = 220;
const idFirstTabSet = 221;
const idFirstTabChange = 222;
const idFourthTabChange = 223;
const idFifthTabChange = 224;
const idAbout = 225;
const idInfo = 226;
const idError = 227;
const idTreeDialog = 228;
const idChapterDialog = 229;

const idRunApp = 230;
const idTutorialList = 231;

const idDialogButton = 5000;
const idFrameButton = 5001;
const idScrolledButton = 5002;
const idHeaderCtrl = 5007;
const idDataTree = 5008;

class MyTutorialsPage extends WxScrolledWindow {
  MyTutorialsPage( WxWindow parent ) : super( parent, -1, style: wxVSCROLL )
  {
    final mainSizer = WxBoxSizer(wxVERTICAL);
    setSizer( mainSizer );

    late WxButton tutButton;

    final flex = WxFlexGridSizer( 2, vgap: 10, hgap: 10 );
    mainSizer.addSizer( flex, flag: wxTOP|wxRIGHT|wxEXPAND, border: 10 );

    final parent = wxTheApp.getTopWindow() as WxFrame;

    flex.add( WxStaticText(this, -1, "Hello world:") );
    tutButton = WxButton(this, -1, "Start..." );
    flex.add( tutButton );
    tutButton.bindButtonEvent( (_) {
        final frame = WxFrame( parent, -1, "Hello world" );
        MyTutorialPage( frame, -1, "tut01.dart" );
        frame.show();
    }, -1);


    flex.add( WxStaticText(this, -1, "Color themes:") );
    tutButton = WxButton(this, -1, "Start..." );
    flex.add( tutButton );
    tutButton.bindButtonEvent( (_) {
        final frame = WxFrame( parent, -1, "Color themes" );
        MyTutorialPage( frame, -1, "tut02.dart" );
        frame.show();
    }, -1);

    flex.add( WxStaticText(this, -1, "Child window:") );
    tutButton = WxButton(this, -1, "Start..." );
    flex.add( tutButton );
    tutButton.bindButtonEvent( (_) {
        final frame = WxFrame( parent, -1, "Child window" );
        MyTutorialPage( frame, -1, "tut03.dart" );
        frame.show();
    }, -1);

    flex.add( WxStaticText(this, -1, "Event #1:") );
    tutButton = WxButton(this, -1, "Start..." );
    flex.add( tutButton );
    tutButton.bindButtonEvent( (_) {
        final frame = WxFrame( parent, -1, "Events" );
        MyTutorialPage( frame, -1, "tut04.dart" );
        frame.show();
    }, -1);

    flex.add( WxStaticText(this, -1, "Events: #2") );
    tutButton = WxButton(this, -1, "Start..." );
    flex.add( tutButton );
    tutButton.bindButtonEvent( (_) {
        final frame = WxFrame( parent, -1, "Events" );
        MyTutorialPage( frame, -1, "tut05.dart" );
        frame.show();
    }, -1);

    flex.add( WxStaticText(this, -1, "Adaptive:") );
    tutButton = WxButton(this, -1, "Start..." );
    flex.add( tutButton );
    tutButton.bindButtonEvent( (_) {
        final frame = WxFrame( parent, -1, "Adaptive UI" );
        MyTutorialPage( frame, -1, "tut06.dart" );
        frame.show();
    }, -1);

    flex.add( WxStaticText(this, -1, "Sizers:") );
    tutButton = WxButton(this, -1, "Start..." );
    flex.add( tutButton );
    tutButton.bindButtonEvent( (_) {
        final frame = WxFrame( parent, -1, "Sizers" );
        MyTutorialPage( frame, -1, "tut07.dart" );
        frame.show();
    }, -1);

    flex.add( WxStaticText(this, -1, "Dialogs:") );
    tutButton = WxButton(this, -1, "Start..." );
    flex.add( tutButton );
    tutButton.bindButtonEvent( (_) {
        final frame = WxFrame( parent, -1, "Dialogs" );
        MyTutorialPage( frame, -1, "tut08.dart" );
        frame.show();
    }, -1);

    flex.add( WxStaticText(this, -1, "Drawing:") );
    tutButton = WxButton(this, -1, "Start..." );
    flex.add( tutButton );
    tutButton.bindButtonEvent( (_) {
        final frame = WxFrame( parent, -1, "Drawing" );
        MyTutorialPage( frame, -1, "tut09.dart" );
        frame.show();
    }, -1);

    flex.add( WxStaticText(this, -1, "Scrolling:") );
    tutButton = WxButton(this, -1, "Start..." );
    flex.add( tutButton );
    tutButton.bindButtonEvent( (_) {
        final frame = WxFrame( parent, -1, "Scrolling" );
        MyTutorialPage( frame, -1, "tut10.dart" );
        frame.show();
    }, -1);

    flex.add( WxStaticText(this, -1, "Tiles:") );
    tutButton = WxButton(this, -1, "Start..." );
    flex.add( tutButton );
    tutButton.bindButtonEvent( (_) {
        final frame = WxFrame( parent, -1, "Tiles" );
        MyTutorialPage( frame, -1, "tut11.dart" );
        frame.show();
    }, -1);
  }
}

class MyLessonsPage extends WxScrolledWindow {
  MyLessonsPage( WxWindow parent ) : super( parent, -1, style: wxVSCROLL )
  {
    final mainSizer = WxBoxSizer(wxVERTICAL);
    setSizer( mainSizer );

    const int idSizers = 100;
    const int idTextCtrls = 101;
    const int idCtrls = 102;
    const int idDataView = 103;

    const int idDialog = 104;
    const int idTreebook = 105;
    const int idMessage = 106;
    const int idDrawing = 107;
    const int idGestures = 108;

    final flex = WxFlexGridSizer( 2, vgap: 10, hgap: 10 );
    mainSizer.addSizer( flex, flag: wxTOP|wxRIGHT|wxEXPAND, border: 10 );

    flex.add( WxStaticText(this, -1, "Layout using sizers:") );
    flex.add( WxButton(this, idSizers, "Start...") );

    flex.add( WxStaticText(this, -1, "Text controls:") );
    flex.add( WxButton(this, idTextCtrls, "Start...") );

    flex.add( WxStaticText(this, -1, "Other controls:") );
    flex.add( WxButton(this, idCtrls, "Start...") );

    flex.add( WxStaticText(this, -1, "wxDataViewCtrl:") );
    flex.add( WxButton(this, idDataView, "Start...") );

    flex.addSpacer(20);
    flex.addSpacer(20);

    flex.add( WxStaticText(this, -1, "Message dialog") );
    flex.add( WxButton(this, idMessage, "Start...") );

    flex.add( WxStaticText(this, -1, "Dialog with data") );
    flex.add( WxButton(this, idDialog, "Start...") );

    flex.add( WxStaticText(this, -1, "Tree book") );
    flex.add( WxButton(this, idTreebook, "Start...") );

    flex.addSpacer(20);    
    flex.addSpacer(20);

    flex.add( WxStaticText(this, -1, "Drawing") );
    flex.add( WxButton(this, idDrawing, "Start...") );

    flex.add( WxStaticText(this, -1, "Gestures") );
    flex.add( WxButton(this, idGestures, "Start...") );

    bindButtonEvent( (event) {
      switch (event.getId()) {
        case idSizers:
        final frame = WxFrame(getParent(), -1, 'Layout examples' );
        MySizerWindow( frame );
        frame.show(); 
        break;

        case idTextCtrls:
        final frame = WxFrame(getParent(), -1, 'Text control examples' );
        MyLoggingWindow( frame );
        frame.show(); 
        break;
        case idCtrls:
        final frame = WxFrame(getParent(), -1, 'Controls examples' );
        MyControlsWindow( frame );
        frame.show(); 
        break;

        case idDataView:
        final frame = WxFrame(getParent(), -1, 'wxDataViewCtrl example' );
        MyTileDataView( frame );
        frame.show(); 
        break;

        case idMessage:
        final dialog = MyMessageDialog( getParent()! );
        dialog.showModal( null );
        break;

        case idTreebook:
        final adaptiveFrame = MyTreebookFrame( this );
        adaptiveFrame.show();
        break;

        case idDrawing:
        final frame = WxFrame(getParent(), -1, 'Drawing example' );
        MyDrawingWindow( frame );
        frame.show(); 
        break;

        case idGestures:
        final frame = WxFrame(getParent(), -1, 'Gesture example' );
        frame.createStatusBar();
        frame.setStatusText( "Hallo" );
        MyGestureWindow( frame );
        frame.show(); 
        break;

        case idDialog:
        final dialog = MyFirstDialog(this, _data);
        dialog.showModal( (value, data) {
          if (value == wxID_OK) {
            final msg = WxMessageDialog( this, "Pressed OK", caption: "wxDart" );
            msg.showModal(null);
          } else {
            final msg = WxMessageDialog( this, "Pressed Cancel", caption: "wxDart"  );
            msg.showModal(null);
          }
        } );
        break;

        default: break;
      }

    }, -1);
  }

  final MyDialogData _data = MyDialogData();
}

class MyMobileFrame extends WxAdaptiveFrame {
  MyMobileFrame( WxWindow ?parent ) 
  : super( parent, -1, "wxDart Demo", size: WxSize( 800, 600 ) )
  {
    WxAppBar? appBar;

      appBar = createAppBar( "Mobile Demo", style: 0);
      appBar.addAction( idAbout, "About" );
      appBar.realize();

      final menubar = WxMenuBar();
      final filemenu = WxMenu();
      filemenu.appendItem( idAbout, "About...\tAlt-A", help: "Info about wxDart 1.0" );
      menubar.append(filemenu, "&File");

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
    images.add( WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.list_alt, WxSize(30,30) ) );
    images.add( WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.developer_board, WxSize(30,30) ) );
    images.add( WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.tour, WxSize(30,30) ) );
    navi.setImages(images);

    final info = MyInfoPage( navi );
    navi.addPage(info, "Info", image: 0);

    if (appBar != null) {
      appBar.attach( info );
    }

    final design = WxHtmlWindow( navi, -1);
    navi.addPage( design, "Overview", image: 1 );
    wxLoadStringFromResource( "DesignOverview.md", (text) {
      design.setPage( md.markdownToHtml(text) );
    });

    final classes = WxHtmlWindow(navi, -1);
    navi.addPage( classes, "Classes", image: 2 );
    wxLoadStringFromResource( "ClassesByCategory.md", (text) {
      classes.setPage( md.markdownToHtml(text) );
    });

    final lessons = MyLessonsPage( navi );
    navi.addPage(lessons, "Examples", image: 3);
    if (appBar != null) {
      appBar.attach( lessons );
    }

    bool selectTutorial = false;
    if (wxIsWeb())
    {
      final queryParameters = Uri.base.queryParameters;
      selectTutorial = queryParameters["tutorial"] != null;
    }

    final tuts = MyTutorialsPage( navi );
    navi.addPage(tuts, "Tutorials", image: 4, select: selectTutorial );
    if (appBar != null) {
      appBar.attach( tuts );
    }

    bindMenuEvent((_)  {
      final dialog = WxMessageDialog( this, 
        "Welcome to wxDart $wxDART_MAJOR_VERSION.$wxDART_MINOR_VERSION.$wxDART_MICRO_VERSION", 
        caption: "Welcome" );
      if (wxUsesFlutter()) {
        dialog.setExtendedMessage("This is wxDart using the Flutter backend." );
      } else {
        dialog.setExtendedMessage("This is wxDart using the wxWidgets backend." );
      }
      dialog.showModal( (returnValue, data) {
      if (returnValue == wxID_OK) {
        wxLogStatus( this, "Pressed OK" );
      }
      });
    }, idAbout );
    

    // set dark/light mode
    bindMenuEvent( (_) {
      wxTheApp.setAppearance( wxAPPEARANCE_DARK );
    }, idDarkMode );
    bindMenuEvent( (_) {
      wxTheApp.setAppearance( wxAPPEARANCE_LIGHT );
    }, idLightMode );

    bindMenuEvent( (_) {
      wxTheApp.setAccentColour( WxColour( 103, 58, 183 ) );
    }, idPurpleTheme );
    bindMenuEvent( (_) {
      wxTheApp.setAccentColour( WxColour( 44, 176, 48 ) );
    }, idGreenTheme );
    bindMenuEvent( (_) {
      wxTheApp.setAccentColour( WxColour(138, 184, 221) );
    }, idBlueTheme );
    bindMenuEvent( (_) {
      wxTheApp.setAccentColour( WxColour(212, 55, 55) );
    }, idRedTheme);

  }
}
