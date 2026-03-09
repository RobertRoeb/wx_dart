
import 'package:wx_dart/wx_dart.dart';

// ------------------------- MyDataView ----------------------

class MyDataView extends WxDataViewListCtrl {
  MyDataView( WxWindow parent ) : super( parent, -1, style: wxDV_NO_HEADER )
  {
    appendTextColumn("Text", width: wxDVC_DEFAULT_WIDTH,
                             mode: wxDATAVIEW_CELL_ACTIVATABLE,
                             flags: wxDATAVIEW_COL_RESIZABLE );
    setRowHeight( 35 );
    for (int i = 0; i < 200; i++) {
      appendItem( [ "Row $i to check clicking vs. scrolling" ] );
    }

    bindDataViewSelectionChangedEvent((event) {
      final frame = WxApp.getMainTopWindow() as WxFrame;
      int selection = getSelectedRow();
      if (selection != -1) {
        final text = getValue(selection, 0);
        wxLogStatus( frame, "Selected item: $text" );
      }
    }, -1);

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
