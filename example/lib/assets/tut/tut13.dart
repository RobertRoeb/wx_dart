
import 'package:wx_dart/wx_dart.dart';

const idAbout = 100;

// Create new WxDataViewListCtrl
class MyPanel extends WxDataViewListCtrl {
  MyPanel( super.parent, super.id ) : super( style: wxDV_ROW_LINES ) 
  {
    // Add two sortable columns
    appendTextColumn("Column #1", width: 120,
      mode: wxDATAVIEW_CELL_ACTIVATABLE,
      flags: wxDATAVIEW_COL_RESIZABLE|wxDATAVIEW_COL_SORTABLE );
    appendTextColumn("Column #2", width: 120,
      mode: wxDATAVIEW_CELL_ACTIVATABLE,
      flags: wxDATAVIEW_COL_RESIZABLE|wxDATAVIEW_COL_SORTABLE );

    // Add data into the table
    for (int i = 0; i < 25; i++) {
      appendItem( [ "Row $i", "Row ${200-i}" ] );
    }

    // bind to activate event
    bindDataViewItemActivatedEvent((event) {
      final frame = WxApp.getMainTopWindow() as WxFrame;
      int selection = getSelectedRow();
      if (selection != -1) {
        final text = getValue(selection, 0);
        final dialog = WxMessageDialog(frame, "Clicked" );
        dialog.setExtendedMessage("Item click is: $text" );
        dialog.showModal(null);
        
      }
    }, -1);
  }
}

class MyFrame extends WxFrame {
  MyFrame( WxFrame? parent) : super( parent, -1, "Table", size: WxSize(900, 700), ) 
  {
    final menubar = WxMenuBar();
    final filemenu = WxMenu();
    filemenu.appendItem( idAbout, "About\tAlt-A", 
        help: "WxDataViewCtrl" );
    filemenu.appendSeparator();
    filemenu.appendItem( wxID_EXIT, "Quit app\tCtrl-Q", 
        help: "Run, baby, run!" );
    menubar.append(filemenu, "File");

    setMenuBar(menubar);

    MyPanel( this, -1 );

    bindMenuEvent((_) {
      final dialog = WxMessageDialog( this, "Welcome WxDataViewCtrl", caption: "wxDart" );
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
