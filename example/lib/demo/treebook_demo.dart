
import 'package:wx_dart/wx_dart.dart';

class MyTreebookFrame extends WxAdaptiveFrame {
  MyTreebookFrame( WxWindow parent ) 
  : super( parent, -1, "Treebook frame", size: WxSize( 500, 400 ) )
  {
    final appBar = createAppBar( "WxTreebook" );
    appBar.addTool( wxID_EXIT, "Exit", WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.menu_open, WxSize(32,32) ) );
    
    bindMenuEvent( (_) => close(false), wxID_EXIT );
    bindCloseWindowEvent( (_) => destroy() );

    createStatusBar();

    final tree = WxTreebook(this, -1);

    setDrawerFromWindow(tree.getTreeCtrl() );

    tree.bindTreebookPageChangedEvent((event) {
      if (wxTheApp.isTouch()) {
        closeDrawer();
      }
      event.skip();
    }, -1 );

    List<WxBitmapBundle> images = [];
    images.add( WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.airplanemode_active, WxSize(20,20), colour: wxGREY ) );
    images.add( WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.airplanemode_inactive, WxSize(20,20), colour: wxGREY) );
    tree.setImages(images);

    for (int i = 0; i < 4; i++) 
    {
      final panel1 = WxPanel( tree, -1 );
      WxStaticText( panel1, -1, "This is panel $i ", pos: WxPoint(30, 30) );
      WxStaticText( panel1, -1, "Some more text", pos: WxPoint(30, 60) );
      tree.addPage(panel1, "Panel $i", image: 0 );
    }

    for (int i = 0; i < 4; i++) 
    {
      final panel1 = WxPanel( tree, -1 );
      WxStaticText( panel1, -1, "This is sub panel $i", pos: WxPoint(30, 30) );
      WxStaticText( panel1, -1, "Some more text", pos: WxPoint(30, 60) );
      tree.addSubPage(panel1, "Subpanel $i", image: 1 );
    }

/*      final panel_a = WxPanel( tree, -1 );
      WxStaticText( panel_a, -1, "New page at #1", pos: WxPoint(30, 30) );
      WxStaticText( panel_a, -1, "Some more text", pos: WxPoint(30, 60) );
      tree.insertSubPage(1, panel_a, "New page at #1", image: 1 );
*/
      final panel_b = WxPanel( tree, -1 );
      WxStaticText( panel_b, -1, "New page at #6", pos: WxPoint(30, 30) );
      WxStaticText( panel_b, -1, "Some more text", pos: WxPoint(30, 60) );
      tree.insertSubPage(6, panel_b, "New long long long page at #6", image: 1 );

    for (int i = 0; i < 4; i++) 
    {
      final panel1 = WxPanel( tree, -1 );
      WxStaticText( panel1, -1, "This is panel $i ", pos: WxPoint(30, 30) );
      tree.addPage(panel1, "Panel $i", image: 0 );
    }

    final panel1 = WxPanel( tree, -1 );
    WxStaticText( panel1, -1, "This is panel #1 ", pos: WxPoint(30, 30) );
    tree.addPage(panel1, "Panel #1", image: 0 );

    final panel1b = WxPanel( tree, -1 );
    WxStaticText( panel1b, -1, "This is panel #1b ", pos: WxPoint(30, 30) );
    tree.addSubPage(panel1b, "Panel #1b", image: 1 );

    final panel2 = WxPanel( tree, -1 );
    WxStaticText( panel2, -1, "This is panel #2 ", pos: WxPoint(30, 30) );
    tree.addPage(panel2, "Panel #2", image: 0 );

    final panel3 = WxPanel( tree, -1 );
    WxStaticText( panel3, -1, "This is panel #3 ", pos: WxPoint(30, 30) );
    tree.addPage(panel3, "Panel #3", image: 0 );

    final panel3b = WxPanel( tree, -1 );
    WxStaticText( panel3b, -1, "This is panel #3b ", pos: WxPoint(30, 30) );
    tree.addSubPage(panel3b, "Panel #3b", image: 1 );

    final panel0 = WxPanel( tree, -1 );
    WxStaticText( panel0, -1, "This is panel #0 ", pos: WxPoint(30, 30) );
    tree.insertPage(0, panel0, "Panel #0", image: 1 );

    final panel3a = WxPanel( tree, -1 );
    WxStaticText( panel3a, -1, "This is panel #3a ", pos: WxPoint(30, 30) );
    tree.insertPage(4, panel3a, "Panel #3a", image: 1 );

    tree.deletePage(0);

    tree.bindTreebookPageChangedEvent((event) {
      wxLogStatus( this, "Page selected: ${event.getSelection()}, oldSel: ${event.getOldSelection()}");
      event.skip();
    }, -1);
    tree.bindTreebookNodeCollapsedEvent((event) {
      wxLogStatus( this, "Page collapsed: ${event.getSelection()}");
    }, -1);
    tree.bindTreebookNodeExpandedEvent((event) {
      wxLogStatus( this, "Page expanded: ${event.getSelection()}");
    }, -1);
  }
}

