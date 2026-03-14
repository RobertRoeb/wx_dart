
import 'package:wx_dart/wx_dart.dart';

// ------------------------- MyDataView ----------------------

class MyDataView extends WxPanel {
  MyDataView( WxWindow parent ) : super( parent, -1 )
  {
    final mainSizer = WxColumn();
    setSizer( mainSizer );

    final dataview = WxDataViewListCtrl( this, -1, style: wxDV_ROW_LINES );
    mainSizer.add( dataview, proportion: 1, flag: wxEXPAND );

    dataview.appendTextColumn("Column #1", width: 120,
                             mode: wxDATAVIEW_CELL_ACTIVATABLE,
                             flags: wxDATAVIEW_COL_RESIZABLE|wxDATAVIEW_COL_SORTABLE );
    dataview.appendTextColumn("Column #2", width: 120,
                             mode: wxDATAVIEW_CELL_ACTIVATABLE,
                             flags: wxDATAVIEW_COL_RESIZABLE|wxDATAVIEW_COL_SORTABLE );
    dataview.appendTextColumn("Column #3", width: wxDVC_DEFAULT_WIDTH,
                             mode: wxDATAVIEW_CELL_ACTIVATABLE,
                             flags: wxDATAVIEW_COL_RESIZABLE );
    // setRowHeight( 35 );

    for (int i = 0; i < 6; i++) {
      dataview.appendItem( [ "Row $i", "Row ${200-i}","Row $i" ] );
    }

    final buttonSizer = WxRow();
    mainSizer.addSizer( buttonSizer );

    final addRowButton = WxButton(this, -1, "Add row" );
    buttonSizer.add( addRowButton, flag: wxALL, border: 10 );
    addRowButton.bindButtonEvent( (event) {
      dataview.appendItem( [ "Row xxx", "Row xxx", "Row xxx" ] );
    },-1);

    final addRow4Button = WxButton(this, -1, "Add row 4" );
    buttonSizer.add( addRow4Button, flag: wxALL, border: 10 );
    addRow4Button.bindButtonEvent( (event) {
      dataview.appendItem( [ "Row 4", "Row 196", "Row xxx" ] );
    },-1);

    final insertRowButton = WxButton(this, -1, "Insert row" );
    buttonSizer.add( insertRowButton, flag: wxALL, border: 10 );
    insertRowButton.bindButtonEvent( (event) {
      dataview.prependItem( [ "Row xxx", "Row xxx", "Row xxx" ] );
    },-1);

    final deleteRowButton = WxButton(this, -1, "Delete row" );
    buttonSizer.add( deleteRowButton, flag: wxALL, border: 10 );
    deleteRowButton.bindButtonEvent( (event) {
      final sel = dataview.getSelectedRow();
      if (sel != -1) {
        dataview.deleteItem( sel );
      }
    },-1);

    bindDataViewColumnSortedEvent( (event) {
      // print( "Sorted" );
    }, -1);

    bindDataViewSelectionChangedEvent((event) {
      final frame = WxApp.getMainTopWindow() as WxFrame;
      int selection = dataview.getSelectedRow();
      if (selection != -1) {
        final text = dataview.getValue(selection, 0);
        wxLogStatus( frame, "Selected item: $text" );
      }
    }, -1);

    bindDataViewItemActivatedEvent((event) {
      final frame = WxApp.getMainTopWindow() as WxFrame;
      int selection = dataview.getSelectedRow();
      if (selection != -1) {
        final text = dataview.getValue(selection, 0);
        final dialog = WxMessageDialog(frame, "Clicked" );
        dialog.setExtendedMessage("Item click is: $text" );
        dialog.showModal(null);
        
      }
    }, -1);
  }
}
