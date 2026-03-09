
import 'package:wx_dart/wx_dart.dart';

const idAbout = 100;

class MyPanel extends WxPanel {
  MyPanel( super.parent, super.id ) 
  {
    // Create a vertical sizer for text field at the
    // top and buttons at the bottom
    final mainSizer = WxBoxSizer(wxVERTICAL);

    // Tell panel to actually use that sizer
    setSizer( mainSizer );

    // Create a multiline text field
    final text = WxTextCtrl(this, 
      -1,             // -1 means no ID
      value: "Text",  // initial value
      style: wxTE_MULTILINE );

    // Create a button that will clear the text field
    final clearbutton = WxButton( this, -1, "Clear text" );

    // Create a button that will select all text 
    final selectbutton = WxButton( this, -1, "Select all" );

    // add text field to mainSizer
    mainSizer.add( text,
      proportion: 1,    // expand it vertically
      flag: wxEXPAND |  // expand it horizontally
            wxALL,      // give it a border all around
      border: 20        // 20 pixel border width
    ); 

    // create horizontal sizer for the buttons
    final buttonSizer = WxBoxSizer(wxHORIZONTAL);

    // add buttons to buttonSizer
    buttonSizer.add( clearbutton,
      flag: wxALL,      // give it a border all around
      border: 10        // 10 pixel border width
    );
    buttonSizer.add( selectbutton,
      flag: wxALL,      // give it a border all around
      border: 10        // 10 pixel border width
    );

    // now add buttonSizer to mainSizer
    mainSizer.addSizer(buttonSizer,
      flag: wxALIGN_CENTRE_HORIZONTAL // centre the buttons
    );

    // bind button event from clearbutton
    clearbutton.bindButtonEvent( (_) {
      text.clear();
    }, -1 );

    // bind button event from selectbutton
    selectbutton.bindButtonEvent( (_) {
      text.selectAll();
      text.setFocus();
    }, -1 );
  }
}

class MyFrame extends WxAdaptiveFrame {
  MyFrame( WxFrame? parent) : super( parent, -1, "Sizers", size: WxSize(900, 700), ) 
  {
    // Create a Touch and a Desktop interface.
    // wxApp.isTouch() decides which one to show.
    // Experimental, but very cool.

    // Touch interface

      // AppBar, similar to a toolbar
      final appBar = createAppBar("Sizers");
      // add action with text button
      appBar.addAction( wxID_EXIT, "Quit" );
      // add "about" tool with bitmap
      appBar.addTool( idAbout, "", WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.info, WxSize(32,32) ) );

    // Desktop interface

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
