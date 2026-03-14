

import 'package:wx_dart/wx_dart.dart';

import 'package:markdown/markdown.dart' as md;

import 'demo/sizer_demo.dart';
import 'demo/controls_demo.dart';
import 'demo/dialogs_demo.dart';
import 'demo/splitter_demo.dart';
import 'demo/dataview_demo.dart';
import 'demo/tiles_demo.dart';
import 'demo/drawing_demo.dart';
import 'demo/treebook_demo.dart';
import 'demo/logging_demo.dart';
import 'demo/tutorial_demo.dart';
import 'demo/mobile_demo.dart';
import 'demo/info_demo.dart';
import 'demo/drawer_demo.dart';
import 'demo/gesture_demo.dart';
import 'demo/fireworks_demo.dart';


// ------------------------- Ids ----------------------

const idRedTheme = 200;
const idGreenTheme = 201;
const idBlueTheme = 202;
const idPurpleTheme = 203;
const idLightMode = 204;
const idDarkMode = 205;
const idSystemMode = 206;

const idSubMenu = 207;
const idSubMenuOne = 208;
const idSubMenuTwo = 209;

const idCheck = 210;
const idLeftAlign = 211;
const idCenterAlign = 212;
const idRightAlign = 213;

const idDirDialog = 217;
const idFileDialog = 218;
const idSaveDialog = 219;
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
const idDrawerFrame = 230;

const idRunApp = 240;
const idTutorialList = 241;

const idDialogButton = 5000;
const idFrameButton = 5001;
const idScrolledButton = 5002;
const idNotebook = 5003;
const idSplitter = 5004;
const idDataViewTreeCtrl = 5006;
const idHeaderCtrl = 5007;
const idDataTree = 5008;


class MyMainFrame extends WxAdaptiveFrame {
  MyMainFrame( WxWindow ?parent ) 
  : super( parent, -1, "wxDart Demo", size: WxSize( 800, 600 ) )
  {
    if (wxUsesFlutter())
    {
      final appBar = createAppBar("Mobile wxDart");
      appBar.addAction( idAbout, "About" );
      appBar.addTool( wxID_EXIT, "", WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.exit_to_app, WxSize(32,32) ) );
      appBar.realize();
    }


    final submenu = WxMenu();
    submenu.appendItem( idSubMenuOne, "Item one", help: "Submenu item 1\tF3" );
    submenu.appendItem( idInfo, "Info message", help: "Submenu item 2\tF4" );


    final menubar = WxMenuBar();
    final filemenu = WxMenu();
    filemenu.appendItem( idAbout, "About...\tAlt-A", help: "Info about wxDart 1.0" );
    filemenu.appendSeparator();
    filemenu.appendItem( idDialog, "Dialog", help: "Open dialog" );
    filemenu.appendItem( idFileDialog, "Open file...", help: "Open file" );
    filemenu.appendItem( idSaveDialog, "Save as...", help: "Save file" );
    filemenu.appendItem( idDirDialog, "Choose dir...", help: "Choose folder" );
    filemenu.appendItem( idInfo, "Info message...", help: "A very long message" );
    filemenu.appendItem( idError, "Error message...", help: "An error ocurred" );
    filemenu.appendSeparator();
    filemenu.appendItem( idDrawerFrame, "Drawer...", help: "Frame with Sidebar vs. Drawer" );
    filemenu.appendItem( idTreeDialog, "Treebook...", help: "Frame with WxTreebook" );
    filemenu.appendSubMenu(submenu, "Sub menu");
    filemenu.appendSeparator();
    filemenu.appendItem( wxID_EXIT, "Quit app\tCtrl-Q", help: "Run, baby, run!" );
    menubar.append(filemenu, "&File");

    final colormenu = WxMenu();

    if (wxUsesFlutter())
    {
      colormenu.appendItem( idRedTheme, "Red", help: "Choose red theme" );
      colormenu.appendItem( idGreenTheme, "Green\tCtrl-G", help: "Choose green theme" );
      colormenu.appendItem( idBlueTheme, "Blue\tCtrl-B", help: "Choose blue theme" );
      colormenu.appendItem( idPurpleTheme, "Purple\tCtrl-P", help: "Choose purple theme" );
      colormenu.appendSeparator();
    }
    colormenu.appendRadioItem( idLightMode, "Light mode", help: "Choose light mode" );
    colormenu.appendRadioItem( idDarkMode, "Dark mode\tCtrl-D", help: "See you on the dark side!" );
    menubar.append(colormenu, "&Colors");
    setMenuBar(menubar);

    final submenuitemone = menubar.findItem(idSubMenuOne);
    if (submenuitemone != null)
    {
      submenuitemone.enable(false);
    }


    final toolbar = createToolBar( style: wxTB_FLAT|wxTB_TEXT );
    toolbar.addTool( idFileDialog, "Open..", WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.file_open, WxSize(32,32) ), shortHelp: "Open file dialog" );
    toolbar.addTool( idDialog, "Dialog", WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.window, WxSize(32,32) ), shortHelp: "Show dialog", kind: wxITEM_DROPDOWN );
    toolbar.addTool( idTreeDialog, "Tree", WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.account_tree, WxSize(32,32) ), shortHelp: "Show tree frame" );
    toolbar.addTool( idInfo, "Message", WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.message, WxSize(32,32) ), shortHelp: "Show message" );
    toolbar.addSeparator();
    toolbar.addRadioTool( idLightMode, "Light", WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.light_mode, WxSize(32,32) ), null, shortHelp: "Light mode" );
    toolbar.addRadioTool( idDarkMode, "Dark", WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.dark_mode, WxSize(32,32) ), null, shortHelp: "Dark mode" );

    final dropmenu = WxMenu();
    dropmenu.appendItem( idRedTheme, "Red", help: "Choose red theme" );
    dropmenu.appendItem( idGreenTheme, "Green\tCtrl-G", help: "Choose green theme" );
    dropmenu.appendItem( idBlueTheme, "Blue\tCtrl-B", help: "Choose blue theme" );
    dropmenu.appendItem( idPurpleTheme, "Purple\tCtrl-P", help: "Choose purple theme" );
    toolbar.setDropdownMenu(idDialog, dropmenu );
    toolbar.realize();
    
    bindMenuEvent( (_) => close(false), wxID_EXIT );
    bindCloseWindowEvent( (_) => destroy() );

    if (wxTheApp.isTouch()) {
      createStatusBar( number: 1 );
    } else {
      createStatusBar( number: 2 );
      setStatusText( "Looks great!", number: 1 );
    }
    if (wxUsesFlutter()) {
      setStatusText( "Welcome to wxDart Flutter $wxDART_MAJOR_VERSION.$wxDART_MINOR_VERSION.$wxDART_MICRO_VERSION" );
    } else {
      setStatusText( "Welcome to wxDart Native $wxDART_MAJOR_VERSION.$wxDART_MINOR_VERSION.$wxDART_MICRO_VERSION" );
    }

    final databook = WxDataViewBook(this, -1);

    final panel1 = MyInfoPage(databook);
    final chapter1 = databook.appendChapter( null, "Start", panel1 );

    final design = WxHtmlWindow(databook, -1);
    databook.appendPage( chapter1, null, "Overview", design );
    wxLoadStringFromResource( "DesignOverview.md", (text) {
      design.setPage( md.markdownToHtml(text) );
    });
    final classes = WxHtmlWindow(databook, -1);
    databook.appendPage( chapter1, null, "Classes", classes );
    wxLoadStringFromResource( "ClassesByCategory.md", (text) {
      classes.setPage( md.markdownToHtml(text, blockSyntaxes: [md.TableSyntax()]) );
    });


    databook.appendPage( chapter1, null, "Sizers", MySizerWindow(databook) );

    databook.appendPage( chapter1, null, "Text controls", MyLoggingWindow(databook) );

    databook.appendPage( chapter1, null, "Other controls", MyControlsWindow(databook) );

    databook.appendPage( chapter1, null, "Tiles", MyTileDataView(databook) );

    databook.appendPage( chapter1, null, "Drawing", MyDrawingWindow(databook) );

    databook.appendPage( chapter1, null, "Gestures", MyGestureWindow(databook) );

    databook.appendPage( chapter1, null, "Tree and list", MySplitterWindow(databook, idSplitter) );

    databook.appendPage( chapter1, null, "Sorted list", MyDataView(databook) );

    final panel2 = WxPanel( databook, -1, style: wxTRANSLUCENT_WINDOW );
    final chapter2 = databook.appendChapter( null, "Tutorial", panel2 );

    final tut12 = databook.appendPage( chapter2, null, "Fireworks!", MyTutorialPage(databook, -1, "tut12.dart") );
    final tut01 = databook.appendPage( chapter2, null, "Hello world", MyTutorialPage(databook, -1, "tut01.dart") );
    final tut02 = databook.appendPage( chapter2, null, "Color themes", MyTutorialPage(databook, -1, "tut02.dart") );
    final tut03 = databook.appendPage( chapter2, null, "Panel with controls", MyTutorialPage(databook, -1, "tut03.dart") );
    final tut04 = databook.appendPage( chapter2, null, "Bind to an event", MyTutorialPage(databook, -1, "tut04.dart") );
    final tut05 = databook.appendPage( chapter2, null, "Event propagation", MyTutorialPage(databook, -1, "tut05.dart") );
    final tut06 = databook.appendPage( chapter2, null, "Touch vs Desktop", MyTutorialPage(databook, -1, "tut06.dart") );
    final tut07 = databook.appendPage( chapter2, null, "Layout with sizers", MyTutorialPage(databook, -1, "tut07.dart") );
    final tut08 = databook.appendPage( chapter2, null, "Dialog with data", MyTutorialPage(databook, -1, "tut08.dart") );
    final tut09 = databook.appendPage( chapter2, null, "Paint events", MyTutorialPage(databook, -1, "tut09.dart") );
    final tut10 = databook.appendPage( chapter2, null, "Scrolling", MyTutorialPage(databook, -1, "tut10.dart") );

    // expand both chapters
    final datactrl = databook.getDataViewChapterCtrl();
    datactrl.expand( chapter1 );
    datactrl.expand( chapter2 );

    if (wxIsWeb())
    {
      final queryParameters = Uri.base.queryParameters;
      String? tutorial = queryParameters["tutorial"];
      if (tutorial != null)
      {
        if (tutorial == "tut01") {
          databook.setSelection(tut01);
        } else
        if (tutorial == "tut02") {
          databook.setSelection(tut02);
        } else
        if (tutorial == "tut03") {
          databook.setSelection(tut03);
        } else
        if (tutorial == "tut04") {
          databook.setSelection(tut04);
        } else
        if (tutorial == "tut05") {
          databook.setSelection(tut05);
        } else
        if (tutorial == "tut06") {
          databook.setSelection(tut06);
        } else
        if (tutorial == "tut07") {
          databook.setSelection(tut07);
        } else
        if (tutorial == "tut08") {
          databook.setSelection(tut08);
        } else
        if (tutorial == "tut09") {
          databook.setSelection(tut09);
        } else
        if (tutorial == "tut10") {
          databook.setSelection(tut10);
        }
      }
    }

    // close drawer when item is clicked
    setDrawerFromWindow( datactrl );
    databook.getDataViewChapterCtrl().bindDataViewSelectionChangedEvent( (event) {
      closeDrawer();
      event.skip();
    }, -1);

    // Actually launch links
    bindHtmlLinkClickEvent((event) {
      final url = event.getHref();
      wxLaunchDefaultBrowser(url);
    }, -1);

    // update toolbar and menus
    bindUpdateUIEvent( (event) {
      switch (event.getId()) {
        case idDarkMode:   event.check( wxTheApp.isDark() ); return;
        case idLightMode:  event.check( !wxTheApp.isDark() ); return;
      } 
    }, -1 );

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

    bindMenuEvent((_)  {
      final dialog = WxMessageDialog( this, "Welcome to wxDart", caption: "Welcome" );
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

    bindMenuEvent((_) {
      final dialog = MyMessageDialog( this );
        dialog.showModal( null );
    }, idInfo );

    bindMenuEvent((_) {
      final dialog = WxMessageDialog( this, "An error occurred", style: wxOK|wxHELP|wxICON_ERROR, caption: "Error" );
      dialog.setExtendedMessage("This is a very long message that may potentially span across several lines." );
      dialog.showModal(null);
    }, idError );

    bindMenuEvent( (event) {
      final dialog = MyFirstDialog(this, _data);
      dialog.showModal( (value, data) {
        if (value == wxID_OK) {
          // final msg = WxMessageDialog( this, "Pressed OK", caption: "wxDart" );
          // msg.showModal(null);
        } else {
          final msg = WxMessageDialog( this, "Pressed Cancel", caption: "wxDart"  );
          msg.showModal(null);
        }
      } );
    }, idDialog );
    
    bindMenuEvent( (event) {
      final dialog = WxFileDialog(this, "Open JPEG", defaultWildCard: '*.jpg;*.jpeg' );
      dialog.showModal( (value, data) {
        if (value == wxID_OK)
        {
            final msg = WxMessageDialog( this, "Pressed OK", caption: "wxDart" );
            msg.setExtendedMessage( "File: $data" );
            msg.showModal(null);
        }
      } );
    }, idFileDialog );
    
    bindMenuEvent( (event) {
      final dialog = WxFileDialog(this, "Save file", defaultWildCard: '*.jpg;*.jpeg' );
      dialog.showModal( (value, data) {
        if (value == wxID_OK)
        {
            final msg = WxMessageDialog( this, "Pressed OK", caption: "wxDart" );
            msg.setExtendedMessage( "File: $data" );
            msg.showModal(null);
        }
      } );
    }, idSaveDialog );

    bindMenuEvent( (event) {
      final dialog = WxDirDialog(this, "Open JPEG" );
      dialog.showModal( (value, data) {
        if (value == wxID_OK)
        {
            final msg = WxMessageDialog( this, "Pressed OK", caption: "wxDart" );
            msg.setExtendedMessage( "File: $data" );
            msg.showModal(null);
        }
      } );
    }, idDirDialog );

    bindMenuEvent( (event) {
      final adaptiveFrame = MyTreebookFrame( this );
      adaptiveFrame.show();
    }, idTreeDialog );

    bindMenuEvent( (event) {
      final adaptiveFrame = MyDrawerFrame( this );
      adaptiveFrame.show();
    }, idDrawerFrame );

/*
    final floating = createFloatingActionButton("Start!", idRunApp, null );

    bindButtonEvent((event)
    {
      if (_tutorial == "tut01.dart") {
        final frame = tut01.MyFrame( this );
        frame.show();
      } else 
      if (_tutorial == "tut02.dart") {
        final frame = tut02.MyFrame( this );
        frame.show();
      } else 
      if (_tutorial == "tut03.dart") {
        final frame = tut03.MyFrame( this );
        frame.show();
      } else 
      if (_tutorial == "tut04.dart") {
        final frame = tut04.MyFrame( this );
        frame.show();
      } else 
      if (_tutorial == "tut05.dart") {
        final frame = tut05.MyFrame( this );
        frame.show();
      } else 
      if (_tutorial == "tut06.dart") {
        final frame = tut06.MyFrame( this );
        frame.show();
      } else 
      if (_tutorial == "tut07.dart") {
        final frame = tut07.MyFrame( this );
        frame.show();
      } else 
      if (_tutorial == "tut08.dart") {
        final frame = tut08.MyFrame( this );
        frame.show();
      } 
    },idRunApp);
*/

  }



  String _tutorial = "tut01.dart";
  final MyDialogData _data = MyDialogData();
}


/*
class MyDataTreeWindow extends WxPanel
{
  MyDataTreeWindow( super.parent, super.id )
  {
    // final model = MyTreeModel();

    final mainSizer = WxBoxSizer( wxVERTICAL );
    setSizer( mainSizer );

    final dataviewSizer = WxBoxSizer( wxHORIZONTAL );
    mainSizer.addSizer( dataviewSizer, proportion: 1, flag: wxEXPAND );

    final dataview = WxDataViewTreeCtrl(this, -1, style: wxDV_HORIZ_RULES|wxDV_NO_HEADER );
    dataviewSizer.add(dataview, proportion: 1, flag: wxEXPAND );

    final branch1 = dataview.appendItem( WxDataViewItem(), null, "First branch" );
    dataview.appendItem( branch1, null, "Leaf 1,1" );
    dataview.expandChildren( branch1 );
    dataview.appendItem( branch1, null, "Leaf 1,2" );
    dataview.appendItem( branch1, null, "Leaf 1,3" );
    dataview.appendItem( branch1, null, "Leaf 1,4" );
    final branch2 = dataview.appendItem( WxDataViewItem(), null, "Second branch" );
    dataview.appendItem( branch2, null, "Leaf 2,1" );
    dataview.appendItem( branch2, null, "Leaf 2,2" );
    dataview.appendItem( branch2, null, "Leaf 2,3" );
    dataview.appendItem( branch2, null, "Leaf 2,4" );

    final book = WxDataViewChapterCtrl(this, -1, style: wxDV_VARIABLE_LINE_HEIGHT|wxDV_NO_TWISTER_BUTTONS|wxDV_NO_HEADER);
    dataviewSizer.add(book, proportion: 1, flag: wxEXPAND );
    
    final chapter1 = book.appendItem( WxDataViewItem(), null, "First chapter" );
    final sub1 = book.appendItem( chapter1, null, "Subchapter 1,1" );
    book.appendItem( sub1, null, "Page 1,1.1" );
    book.appendItem( sub1, null, "Page 1,1.2" );
    book.appendItem( sub1, null, "Page 1,1.3" );
    book.appendItem( sub1, null, "Page 1,1.4" );
    final sub2 = book.appendItem( chapter1, null, "Subchapter 1,2" );
    final subsub1 = book.appendItem( sub2, null, "Subsubchapter 1,1.1" );
    book.appendItem( subsub1, null, "Page 1,2.1-1" );
    book.appendItem( subsub1, null, "Page 1,2.1-2" );
    book.appendItem( subsub1, null, "Page 1,2.1-3" );
    final subsub2 = book.appendItem( sub2, null, "Subsubchapter 1,1.2" );
    book.appendItem( subsub2, null, "Page 1,2.2-1" );
    book.appendItem( subsub2, null, "Page 1,2.2-2" );
    book.appendItem( subsub2, null, "Page 1,2.2-3" );
    final chapter2 = book.appendItem( WxDataViewItem(), null, "Second chapter" );
    book.appendItem( chapter2, null, "Page 2,1" );
    book.appendItem( chapter2, null, "Page 2,2" );
    book.appendItem( chapter2, null, "Page 2,3" );
    book.appendItem( chapter2, null, "Page 2,4" );
    book.expandChildren( chapter1 );
    book.expandChildren( chapter2 );

    final buttonSizer = WxBoxSizer( wxHORIZONTAL );
    mainSizer.addSizer( buttonSizer, flag: wxALIGN_CENTER );

    final addItemButton = WxButton(this, -1, "5/6 leaves");
    addItemButton.bindButtonEvent((_)
    {
    }, -1);
    buttonSizer.add( addItemButton, flag: wxALL, border: 5 ); 

    final addBranchButton = WxButton(this, -1, "2/3 branches");
    addBranchButton.bindButtonEvent((_)
    {
    }, -1);
    buttonSizer.add( addBranchButton, flag: wxALL, border: 5 ); 
  }
}

*/


// ------------------------- MyApp ----------------------



class MyMicroFrame extends WxFrame {
  MyMicroFrame( WxWindow ?parent ) 
  : super( parent, -1, "wxDart Demo", size: WxSize( 800, 600 ) )
  {
    const int test = 4;

    if (test == 0)
    {
      final mainSizer = WxBoxSizer(wxHORIZONTAL);
      mainSizer.add( WxStaticText(this, -1, "Propor = 0") );
      mainSizer.add( WxTextCtrl(this, -1, value: "Propor = 1", size: WxSize(200,20)), proportion: 1 );
      setSizer( mainSizer );
    }
    if (test == 1)
    {
      MyLoggingWindow(this);
    }
    if (test == 2)
    {
      // MyMiniTileDataView(this);
      MyTileDataView(this) ;
    }
    if (test == 3)
    {
      final panel = WxPanel( this, -1 /*, pos: WxPoint(50,50), size: WxSize(400,300) */ );
      panel.setBackgroundColour( wxYELLOW );
      WxStaticText( panel, -1, "Hallo", pos: WxPoint(30,100) );
    }
    if (test == 4)
    {
      MyGestureWindow(this);
    }
  }
}


class MyApp extends WxApp {

  @override
  bool onInit()
  {
    setAppName( "wxdart_demo" );
    setAppDisplayName( "wxDart Demo" );

    if (wxIsWeb())
    {
      final queryParameters = Uri.base.queryParameters;

      enforceDesktop = queryParameters["Desktop"] != null;
      enforceDesktop = queryParameters["Touch"] != null;

      String? tutorial = queryParameters["tutorial"];
      if (tutorial != null)
      {
        if (tutorial=="Fireworks") {
          final frame = MyFireworksFrame(null);
          frame.show();
          return true;
        }

        final frame = WxFrame( null, -1, "Tutorial" );
        if (tutorial == "Map") {
          MyGestureWindow(frame);
          frame.show();
          return true;
        }


        MyTutorialPage( frame, -1, "$tutorial.dart" );
        frame.show();
        return true;
      }
    }
/*
      WxFrame myFrame = MyMicroFrame(null);
      myFrame.show();
      return true;
*/
    if (isTouch()) {
      WxFrame myFrame = MyMobileFrame(null);
      myFrame.show();
    } else {
      WxFrame myFrame = MyMainFrame(null);
      myFrame.show();
/*
      if (!wxUsesFlutter())
      {
        WxFrame myFrame2 = MyMobileFrame(null);
        myFrame2.show();
      }
*/
    }
    return true;
  }

  @override
  bool isTouch()
  { 
    if (enforceDesktop) return false;
    if (enforceTouch) return true;
    return super.isTouch();
  }

  bool showTutorial = false;
  bool enforceTouch = false;
  bool enforceDesktop = false;
}

void main()
{
  final myApp = MyApp();
  myApp.run();
  myApp.dispose();
}
