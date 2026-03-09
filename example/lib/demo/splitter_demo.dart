
import 'package:wx_dart/wx_dart.dart';

const idDataViewListCtrl = 5005;

const idTreeCtrl = 5050;
const idTreeItemAddChild = 5051;
const idTreeItemGetSelection = 5052;
const idTreeItemGetParent = 5053;
const idTreeItemGetFirstChild = 5054;
const idTreeItemGetLastChild = 5055;
const idTreeItemGetNextSibling = 5056;
const idTreeItemGetPrevSibling = 5057;
const idTreeItemDelete = 5058;
const idTreeItemDeleteChildren = 5059;

const idListAppendRow = 5060;
const idListInsertRow = 5061;
const idListDeleteRow = 5062;
const idListSelectRow2 = 5063;
const idListSetValue = 5064;
const idListSetValue2 = 5065;
const idListSelect2 = 5066;



class MySplitterWindow extends WxSplitterWindow
{
  MySplitterWindow( super.parent, super.id, { super.style = wxSP_PERMIT_UNSPLIT|wxSP_3DSASH|wxSP_LIVE_UPDATE } ) {
    final treePanel = WxPanel( this, -1 );
    final treectrl = WxTreeCtrl(treePanel, idTreeCtrl, style: wxTR_DEFAULT_STYLE|wxBORDER_THEME );
    List<WxBitmapBundle> images = [];
    images.add( WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.airplanemode_active, WxSize(20,20), colour: wxGREY ) );
    images.add( WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.airplanemode_inactive, WxSize(20,20), colour: wxGREY) );
    images.add( WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.airplane_ticket, WxSize(20,20), colour: wxGREY) );
    images.add( WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.car_rental, WxSize(20,20), colour: wxGREY) );
    treectrl.setImages(images);
    final root = treectrl.addRoot("Super Root");
    final branch1 = treectrl.appendItem(root, "Branch 1", image: 0, selImage: 1 );
    final branch2 = treectrl.appendItem(root, "Branch 2", image: 0, selImage: 1 );
    treectrl.appendItem(branch1, "Item 1", image: 2);
    treectrl.appendItem(branch1, "Item 2", image: 2) ;
    treectrl.appendItem(branch1, "Item 3", image: 3);
    treectrl.appendItem(branch1, "Item 4", image: 2);
    treectrl.appendItem(branch1, "Item 5");
    treectrl.appendItem(branch2, "Item 1");
    treectrl.appendItem(branch2, "Item 2");
    treectrl.appendItem(branch2, "Item 3");
    treectrl.appendItem(branch2, "Item 4");
    treectrl.appendItem(branch2, "Item with data", data: "Last data" );
    treectrl.prependItem(branch2, "Item with data", data: "First data" );
    treectrl.expandAll();
    final treeSizer = WxBoxSizer( wxVERTICAL );
    treeSizer.add(treectrl, flag: wxEXPAND, proportion: 1 );
    final treeButtonSizer = WxWrapSizer();
    treeSizer.addSizer(treeButtonSizer);

    treeButtonSizer.add( WxButton(treePanel, idTreeItemAddChild, "Add child"), flag: wxALL, border: 10 );
    bindButtonEvent( (event) {
      WxTreeItemId item = treectrl.getSelection();
      treectrl.appendItem(item, "New child" );
    }, idTreeItemAddChild);

    final frame = getParent()!.getParent() as WxFrame;

    treeButtonSizer.add( WxButton(treePanel, idTreeItemGetSelection, "Current item"), flag: wxALL, border: 10 );
    bindButtonEvent( (event) {
      WxTreeItemId item = treectrl.getSelection();
      if (!item.isOk()) {
        wxLogStatus(frame, "No item selected" );
      } else {
        wxLogStatus( frame, "Item name: ${treectrl.getItemText(item)}" );
      }
    }, idTreeItemGetSelection );

    treeButtonSizer.add( WxButton(treePanel, idTreeItemGetParent, "Parent name"), flag: wxALL, border: 10 );
    bindButtonEvent( (event) {
      WxTreeItemId item = treectrl.getSelection();
      if (!item.isOk()) {
        wxLogStatus(frame, "No item selected" );
      }
      WxTreeItemId parent = treectrl.getItemParent(item);
      if (!parent.isOk()) {
        wxLogStatus(frame, "No parent item" );
      } else {
        wxLogStatus( frame, "Parent name: ${treectrl.getItemText(parent)}" );
      }
    }, idTreeItemGetParent );

    treeButtonSizer.add( WxButton(treePanel, idTreeItemGetFirstChild, "First child"), flag: wxALL, border: 10 );
    bindButtonEvent( (event) {
      WxTreeItemId item = treectrl.getSelection();
      if (!item.isOk()) {
        wxLogStatus(frame, "No item selected" );
      }
      WxTreeItemId parent = treectrl.getFirstChild(item);
      if (!parent.isOk()) {
        wxLogStatus(frame, "No first child" );
      } else {
        wxLogStatus( frame, "First child's name: ${treectrl.getItemText(parent)}" );
      }
    }, idTreeItemGetFirstChild );

    treeButtonSizer.add( WxButton(treePanel, idTreeItemGetLastChild, "Last child"), flag: wxALL, border: 10 );
    bindButtonEvent( (event) {
      WxTreeItemId item = treectrl.getSelection();
      if (!item.isOk()) {
        wxLogStatus(frame, "No item selected" );
      }
      WxTreeItemId parent = treectrl.getLastChild(item);
      if (!parent.isOk()) {
        wxLogStatus(frame, "No last child" );
      } else {
        wxLogStatus( frame, "Last child's name: ${treectrl.getItemText(parent)}" );
      }
    }, idTreeItemGetLastChild );

    treeButtonSizer.add( WxButton(treePanel, idTreeItemGetNextSibling, "Next sibling"), flag: wxALL, border: 10 );
    bindButtonEvent( (event) {
      WxTreeItemId item = treectrl.getSelection();
      if (!item.isOk()) {
        wxLogStatus(frame, "No item selected" );
      }
      WxTreeItemId next = treectrl.getNextSibling(item);
      if (!next.isOk()) {
        wxLogStatus(frame, "No next sibling" );
      } else {
        wxLogStatus( frame, "Next sibling's name: ${treectrl.getItemText(next)}" );
      }
    }, idTreeItemGetNextSibling );

    treeButtonSizer.add( WxButton(treePanel, idTreeItemGetPrevSibling, "Prev sibling"), flag: wxALL, border: 10 );
    bindButtonEvent( (event) {
      WxTreeItemId item = treectrl.getSelection();
      if (!item.isOk()) {
        wxLogStatus(frame, "No item selected" );
      }
      WxTreeItemId next = treectrl.getPrevSibling(item);
      if (!next.isOk()) {
        wxLogStatus(frame, "No prev sibling" );
      } else {
        wxLogStatus( frame, "Prev sibling's name: ${treectrl.getItemText(next)}" );
      }
    }, idTreeItemGetPrevSibling );

    treeButtonSizer.add( WxButton(treePanel, idTreeItemDelete, "Delete item"), flag: wxALL, border: 10 );
    bindButtonEvent( (event) {
      WxTreeItemId item = treectrl.getSelection();
      if (!item.isOk()) {
        wxLogStatus(frame, "No item selected" );
      }
      treectrl.delete(item);
    }, idTreeItemDelete );

    treeButtonSizer.add( WxButton(treePanel, idTreeItemDeleteChildren, "Delete children"), flag: wxALL, border: 10 );
    bindButtonEvent( (event) {
      WxTreeItemId item = treectrl.getSelection();
      if (!item.isOk()) {
        wxLogStatus(frame, "No item selected" );
      }
      treectrl.deleteChildren(item);
    }, idTreeItemDeleteChildren );

    treePanel.setSizer(treeSizer);

    final listPanel = WxPanel( this, -1 );
    final listctrl = WxDataViewListCtrl(listPanel, idDataViewListCtrl, style: wxDV_MULTIPLE /*|wxDV_HORIZ_RULES|wxDV_VERT_RULES*/ );
    listctrl.appendToggleColumn("", width: 25, mode: wxDATAVIEW_CELL_ACTIVATABLE );
    listctrl.appendTextColumn("Text", width: 120, mode: wxDATAVIEW_CELL_EDITABLE );
    listctrl.appendBitmapColumn("Col", width: 30);
    listctrl.appendProgressColumn("Progress", width: 100);
    listctrl.appendChoiceColumn("Choice", ["Hello", "Hallo", "Ola", "Ciao", "Hej", "Salut", "Cześć", "Γειά σου"], width: 120);
    listctrl.appendTextColumn("Column 4", width: 180);
    final b1 = WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.cloud_sync, WxSize(21,21), colour: wxGREY );
    final b2 = WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.cloud_off, WxSize(21,21), colour: wxGREY );
    final bitmap1 = b1.getBitmapFor(listctrl);
    final bitmap2 = b2.getBitmapFor(listctrl);
    for (int i = 0; i < 20; i++) {
      listctrl.appendItem( [ true, "Row $i", i % 2 == 0 ? bitmap1 : bitmap2, i*4 , "Hallo", "Column three" ] );
    }
    final listSizer = WxBoxSizer( wxVERTICAL );
    listSizer.add(listctrl, flag: wxEXPAND, proportion: 1 );
    listPanel.setSizer(listSizer);

  
    final listButtonSizer = WxWrapSizer();
    listSizer.addSizer(listButtonSizer);
    listButtonSizer.add( WxButton(listPanel, idListSelectRow2, "Move to #2"), flag: wxALL, border: 10 );
    bindButtonEvent( (event) {
        listctrl.setCurrentItem( listctrl.rowToItem(2));
    }, idListSelectRow2);

    
    listButtonSizer.add( WxButton(listPanel, idListSelect2, "Select #2"), flag: wxALL, border: 10 );
    bindButtonEvent( (event) {
        listctrl.select( listctrl.rowToItem(2) );
    }, idListSelect2);

    listButtonSizer.add( WxButton(listPanel, idListSetValue, "SetValue on #2,1"), flag: wxALL, border: 10 );
    bindButtonEvent( (event) {
        listctrl.setValue( "Hello", 2, 1 );
    }, idListSetValue );

    listButtonSizer.add( WxButton(listPanel, idListSetValue2, "SetValue on #2,3"), flag: wxALL, border: 10 );
    bindButtonEvent( (event) {
        listctrl.setValue( 60, 2, 3 );
    }, idListSetValue2 );

    listButtonSizer.add( WxButton(listPanel, idListAppendRow, "Append row"), flag: wxALL, border: 10 );
    bindButtonEvent( (event) {
        final bundle = WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.new_releases, WxSize(21,21), colour: wxGREY );
        final bitmap = bundle.getBitmapFor(listctrl);
        listctrl.appendItem([false, "New row", bitmap, 70, "Col 2", "Column three"]);
    }, idListAppendRow);


    listButtonSizer.add( WxButton(listPanel, idListInsertRow, "Insert row"), flag: wxALL, border: 10 );
    bindButtonEvent( (event) {
      final item = listctrl.getCurrentItem();
      if (item.isOk()) {        
        final row = listctrl.itemToRow(item);
        final bundle = WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.insert_chart, WxSize(21,21), colour: wxGREY );
        final bitmap = bundle.getBitmapFor(listctrl);
        listctrl.insertItem(row, [false, "New row", bitmap, 20, "Col 2", "Column three"]);
      }
    }, idListInsertRow);

    listButtonSizer.add( WxButton(listPanel, idListDeleteRow, "Delete row"), flag: wxALL, border: 10 );
    bindButtonEvent( (event) {
      final item = listctrl.getCurrentItem();
      if (item.isOk()) {
        final row = listctrl.itemToRow(item);
        listctrl.deleteItem(row);
      }
    }, idListDeleteRow);

    bindTreeSelChangedEvent( (event) {
      final item = event.getItem();
      wxLogStatus(frame, "Treeitem selected with text: ${treectrl.getItemText(item)}" );
      final data = event.getClientData();
      if (data is String) {
        wxLogStatus(frame, "Treeitem data is: $data" );
      }
    }, idTreeCtrl );
  
    bindTreeItemActivatedEvent( (event) {
      final item = event.getItem();
      wxLogStatus(frame, "Treeitem activated with text: ${treectrl.getItemText(item)}" );
    }, idTreeCtrl );
  
    bindTreeItemExpandedEvent( (event) {
      final item = event.getItem();
      wxLogStatus(frame, "Treeitem expanded text: ${treectrl.getItemText(item)}" );
    }, idTreeCtrl );
  
    bindTreeItemCollapsedEvent( (event) {
      final item = event.getItem();
      wxLogStatus(frame, "Treeitem collapsed text: ${treectrl.getItemText(item)}" );
    }, idTreeCtrl );
  
    bindDataViewItemEditingDoneEvent((event) {
      if (event.getColumn() == 1) {
        final str = event.getValue() as String;
        if (str.length > 7) {
          event.veto();
          wxLogStatus(frame, "String too long" );
        }
      }
    }, idDataViewListCtrl );
    
    bindDataViewSelectionChangedEvent( (event) {
      int selection = listctrl.getSelectedRow();
      if (selection == -1) {
        wxLogStatus(frame, "Row selected $selection" );
      } else {
        wxLogStatus(frame, "Row selected $selection with value : ${listctrl.getValue(selection, 0)}" );
      }
    }, idDataViewListCtrl);

    bindDataViewItemActivatedEvent((event) {
      WxDataViewItem item = event.getItem();
      int row = listctrl.itemToRow( item );
      wxLogStatus(frame, "Row activated $row" );
    }, idDataViewListCtrl); 

    splitVertically( treePanel, listPanel );
    setSashPosition( 400 );
  }

}

