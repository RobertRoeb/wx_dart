
import 'package:wx_dart/wx_dart.dart';

const idAbout = 100;
const idDialog = 101;

class MyDialogData {
  String text = "This the text";
}

class MyFirstDialog extends WxDialog
{
  MyFirstDialog( WxWindow parent, this._data ) : super( parent, -1, "Dialog", size: WxSize(600,-1) )
  {
    final mainSizer = WxBoxSizer( wxVERTICAL );
    setSizer( mainSizer );


    final midSizer = WxStaticBoxSizer( wxVERTICAL, this, 'Test input' );

    // Create sizer with 2 columns
    final flexSizer = WxFlexGridSizer(2);

    final text1 = WxTextCtrl( midSizer.getStaticBox(), -1, size: WxSize(350,-1) );
    // row #1
    flexSizer.add( WxStaticText(midSizer.getStaticBox(), -1, "ENTER will try to close the dialog:" ), flag: wxALIGN_CENTER_VERTICAL|wxALIGN_RIGHT );
    text1.setHint( "Hit <ENTER>" );
    flexSizer.add( text1, flag: wxALL, border: 10 );
    // row #2
    flexSizer.add( WxStaticText(midSizer.getStaticBox(), -1, "ENTER intercepted, won't close:" ), flag: wxALIGN_CENTER_VERTICAL|wxALIGN_RIGHT );
    final text2 = WxTextCtrl( midSizer.getStaticBox(), -1, style: wxTE_PROCESS_ENTER, size: WxSize(350,-1) );
    text2.setHint( "Hit <ENTER>" );
    flexSizer.add( text2, flag: wxALL, border: 10 );
    // row #3
    flexSizer.add( WxStaticText(midSizer.getStaticBox(), -1, "No more than 17 characters allowed:" ), flag: wxALIGN_CENTER_VERTICAL|wxALIGN_RIGHT );
    final text3 = WxTextCtrl( midSizer.getStaticBox(), -1, value: "Max 17 characters", size: WxSize(350,-1) );
    flexSizer.add( text3, flag: wxALL, border: 10 );
    // row #4
    flexSizer.add( WxStaticText(midSizer.getStaticBox(), -1, "Text will be remembered next time:" ), flag: wxALIGN_CENTER_VERTICAL|wxALIGN_RIGHT );
    final text4 = WxTextCtrl( midSizer.getStaticBox(), -1, size: WxSize(350,-1) );
    flexSizer.add( text4, flag: wxALL, border: 10 );

    midSizer.addSizer(flexSizer, flag: wxEXPAND );
    mainSizer.addSizer( midSizer, flag: wxALL|wxEXPAND, border: 10); 

    // Create OK and Cancel buttons at the bottom
    mainSizer.addSizer(createStdDialogButtonSizer(wxOK|wxCANCEL), flag: wxALL|wxALIGN_RIGHT, border: 10);

    // transfer data to controls
    bindInitDialogEvent( (_) {
        text4.setValue( _data.text );
    });

    // validate data and transfer data from controls
    bindDialogValidateEvent( (event) {
      final str = text3.getValue();
      if (str.length > 17) {
        final dialog = WxMessageDialog(this, "Too many characters" );
        dialog.showModal( null );
        event.veto();
        return;
      }
      _data.text = text4.getValue();
    }, -1); 

    text2.bindTextEnterEvent((_) {
      wxLogStatus(parent as WxFrame, "Intercepted <ENTER>" );
    }, -1);
  }

  final MyDialogData _data;
}



class MyFrame extends WxAdaptiveFrame {
  MyFrame( WxFrame? parent) : super( parent, -1, "Hello World", size: WxSize(900, 700) ) 
  {
    // Touch interface
      final appBar = createAppBar("Hello World");
      appBar.addTool( wxID_EXIT, "Quit", WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.exit_to_app, WxSize(32,32) ) );
      appBar.addTool( idAbout, "", WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.info, WxSize(32,32) ) );
      createFloatingActionButton("Dialog", idDialog, WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.window, WxSize(32,32) ) );

    // Desktop interface

      final menubar = WxMenuBar();
      final filemenu = WxMenu();
      filemenu.appendItem( idAbout, "About\tAlt-A", help: "About Hello World" );
      filemenu.appendItem( idDialog, "Show dialog\tAlt-D", help: "Show dialog" );
      filemenu.appendSeparator();
      filemenu.appendItem( wxID_EXIT, "Quit app\tCtrl-Q", help: "Run, baby, run!" );
      menubar.append(filemenu, "File");
      setMenuBar(menubar);


    if (!wxTheApp.isTouch())
    {
      createStatusBar( number: 2 );
      setStatusText( "Welcome to wxDart" );
      setStatusText( "Looks great!", number: 1 );
    }


    // bind to idAbout from menu, toolbar or appbar
    bindMenuEvent( (_) => sayHello(), idAbout );

    // bind to wxID_EXIT from menu, toolbar or appbar
    bindMenuEvent( (_) => close(false), wxID_EXIT );

    // bind to idDialog from menu, toolbar or appbar
    bindMenuEvent( (_) => showDialog(), idDialog );

    // bind to idDialog from button (FloatingActionButton)
    bindButtonEvent((_) => showDialog(), idDialog );


    bindCloseWindowEvent( (_) => destroy() );
  }

  void sayHello() {
      final dialog = WxMessageDialog( this, "Welcome to Hello World", caption: "wxDart" );
      dialog.showModal(null);
  }

  void showDialog() {
    final dialog = MyFirstDialog(this, _data );
    dialog.showModal( (value, data ) {
      if (value == wxID_OK) {
        final msg = WxMessageDialog( this, "You pressed OK!", caption: "wxDialog" );
        msg.showModal(null);
      }
    });
  }

  final MyDialogData _data = MyDialogData();
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
