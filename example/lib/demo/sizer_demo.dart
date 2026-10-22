
import 'package:wx_dart/wx_dart.dart';

class MySizerWindow extends WxScrolledWindow {
  MySizerWindow( WxWindow parent ) : super( parent, -1, style: wxVSCROLL )
  {
    final mainSizer = WxBoxSizer( wxVERTICAL );
    setSizer( mainSizer );

    late WxStaticBoxSizer sbs;

    mainSizer.add( WxStaticText(this, -1, "The boxes below are WxStaticBoxSizer instances", style: wxST_WRAP), 
        flag: wxALL|wxALIGN_CENTER_HORIZONTAL, border: 10 );

    sbs = WxStaticBoxSizer(wxVERTICAL, this, "WxBoxSizer( wxVERTICAL )" );
    mainSizer.addSizer( sbs, flag: wxEXPAND|wxALL, border: 10 );
    createBoxSizerPage( sbs, sbs.getStaticBox() );

    sbs = WxStaticBoxSizer(wxVERTICAL, this, "proportion: 1" );
    mainSizer.addSizer( sbs, flag: wxEXPAND|wxALL, border: 10 );
    createProportionPage( sbs, sbs.getStaticBox() );

    sbs = WxStaticBoxSizer(wxVERTICAL, this, "Mixed proportions" );
    mainSizer.addSizer( sbs, flag: wxEXPAND|wxALL, border: 10 );
    createProportionsPage( sbs, sbs.getStaticBox() );

    sbs = WxStaticBoxSizer(wxVERTICAL, this, "sizer.addStretchSpacer" );
    mainSizer.addSizer( sbs, flag: wxEXPAND|wxALL, border: 10 );
    createStretchSpacerPage( sbs, sbs.getStaticBox() );

    sbs = WxStaticBoxSizer(wxVERTICAL, this, "WxFlexGridSizer" );
    mainSizer.addSizer( sbs, flag: wxEXPAND|wxALL, border: 10 );
    createFlexGridSizerPage( sbs, sbs.getStaticBox() );

    /*
    final flex = WxFlexGridSizer( 3 );
    for (int i = 0; i < 7; i++) {
      flex.add( WxStaticText( this, -1, "Text 3" ), flag: wxALL, border: 5  );
    }
    // flex.addGrowableCol(0);
    mainSizer.addSizer(flex, flag: 0);
    */

    sbs = WxStaticBoxSizer(wxVERTICAL, this, "WxGridSizer" );
    mainSizer.addSizer( sbs, flag: wxALL, border: 10 );
    createGridSizerPage( sbs, sbs.getStaticBox() );

    sbs = WxStaticBoxSizer(wxVERTICAL, this, "WxWrapSizer" );
    mainSizer.addSizer( sbs, flag: wxEXPAND|wxALL, border: 10 );
    createWrapSizerPage( sbs, sbs.getStaticBox() );

    final text = "This is a long text in a WxStaticText with wxST_WRAP flag. "
                 "This is a long text in a WxStaticText with wxST_WRAP flag.";
    mainSizer.add( WxStaticText(this, -1, text, style: wxST_WRAP), flag: wxEXPAND|wxALL, border: 10 );

    sbs = WxStaticBoxSizer(wxVERTICAL, this, "WxTileSizer" );
    mainSizer.addSizer( sbs, flag: wxALL, border: 10 );
    createTileSizerPage( sbs, sbs.getStaticBox() );
  }

  void createGridSizerPage( WxStaticBoxSizer sizer, WxWindow parent )
  {
    final topSizer = WxRow();

    final grid = WxGridSizer(3 /*,vgap: 5, hgap: 5*/);
    topSizer.addSizer(grid, flag: wxEXPAND );
    for (int i = 0; i < 4; i++) {
      grid.add( WxStaticText(parent, -1, "Text #$i"), flag: wxALL, border: 5 );
      grid.add( WxStaticText(parent, -1, "Text #$i"), flag: wxALL, border: 5 );
      grid.add( WxStaticText(parent, -1, "Long text #$i"), flag: wxALL, border: 5 );
    }
    grid.add( WxStaticText(parent, -1, "Mulitline\ntext\nline 3."), flag: wxALL, border: 5 );
    grid.add( WxStaticText(parent, -1, "wxALIGN_TOP"), flag: wxALL|wxALIGN_TOP, border: 5 );
    grid.add( WxStaticText(parent, -1, "wxALIGN_BOTTOM"), flag: wxALL|wxALIGN_BOTTOM, border: 5 );
    sizer.addSizer( topSizer );

    final buttons = WxRow();
    final textForGrid = WxTextCtrl(parent, -1, value: "Test", size: WxSize(120,-1) );
    buttons.add(textForGrid, flag: WxSizerFlags.borderAll(valign: .center), border: 5);
    buttons.add( WxStaticText(parent, -1, "Border:"), flag: WxSizerFlags.borderAll(valign: .center), border: 5 );
    final borderForGrid = WxSpinCtrl(parent, -1, "5", min: 0, max: 15 );
    buttons.add( borderForGrid, flag: WxSizerFlags.borderAll(valign: .center), border: 5 );
    final addToGrid = WxButton(parent, -1, "Add item" );
    buttons.add( addToGrid, flag: WxSizerFlags.borderAll(valign: .center), border: 5 );
    addToGrid.bindButtonEvent( (_) {
      grid.add( WxStaticText( parent, -1, textForGrid.getValue() ), 
        flag: wxALL, border: borderForGrid.getValue() );
      layout();
    }, -1);
    final removeFromGrid = WxButton(parent, -1, "Remove #1" );
    buttons.add( removeFromGrid, flag: WxSizerFlags.borderAll(valign: .center), border: 5 );
    removeFromGrid.bindButtonEvent( (_) {
      if (grid.getItemCount() > 0) {
        final item = grid.getItem(0);
        final win = item!.getWindow();
        grid.remove(0);
        win!.destroy();
        layout();
      }
    }, -1);
    final addSpacer = WxButton(parent, -1, "Add sizer" );
    buttons.add( addSpacer, flag: WxSizerFlags.borderAll(valign: .center), border: 5 );
    addSpacer.bindButtonEvent( (_) {
      final row = WxRow();
      row.add( WxStaticText(parent, -1, 'left left left'), flag: wxALL, border: 2 );
      row.add( WxStaticText(parent, -1, 'right right right'), flag: wxALL, border: 2 );
      grid.addSizer(row);
      layout();
    }, -1);
    sizer.addSizer( buttons );
  }

  void createTileSizerPage( WxStaticBoxSizer sizer, WxWindow parent )
  {
    final pointSize = wxNORMAL_FONT.getPointSize();
    for (int i = 0; i < 6; i++) 
    {
      final leading = WxStaticBitmap(parent, -1, WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.account_balance, WxSize(48,48), colour: wxGREY ) );
      final title = WxStaticText(parent, -1, "Main text in row #$i" )..setFont(WxFont(pointSize*1.2));
      final subtitle = WxStaticText(parent, -1, "Medium text" );
      final third = WxStaticText(parent, -1, "Small text at the bottom" )..setFont(WxFont(pointSize/1.2));
      final trailing = WxButton(parent, -1, "More..." );
      final tileSizer = WxTileSizer(leading, title, subtitle, third: third, trailing: trailing );
      sizer.addSizer(tileSizer, flag: wxEXPAND|wxTOP|wxBOTTOM, border: 3 );
    }
  }
  void createFlexGridSizerPage( WxStaticBoxSizer sizer, WxWindow parent )
  {
    final topSizer = WxRow();
    final flex = WxFlexGridSizer(3,vgap: 5, hgap: 5);
    topSizer.addSizer(flex, flag: wxEXPAND );
    for (int i = 0; i < 12; i++) {
      flex.add( WxStaticText(parent, -1, "Text #$i"), flag: wxALL, border: 5 );
    }
    flex.add( WxStaticText(parent, -1, "Mulitline\ntext\nline 3."), flag: wxALL, border: 5 );
    flex.add( WxStaticText(parent, -1, "wxALIGN_TOP"), flag: wxALL|wxALIGN_TOP, border: 5 );
    flex.add( WxStaticText(parent, -1, "wxALIGN_BOTTOM"), flag: wxALL|wxALIGN_BOTTOM, border: 5 );
    sizer.addSizer( topSizer );

    final buttons = WxRow();
    final textForGrid = WxTextCtrl(parent, -1, value: "Test", size: WxSize(120,-1) );
    buttons.add(textForGrid, flag: WxSizerFlags.borderAll(valign: .center), border: 5);
    buttons.add( WxStaticText(parent, -1, "Border:"), flag: WxSizerFlags.borderAll(valign: .center), border: 5 );
    final borderForGrid = WxSpinCtrl(parent, -1, "5", min: 0, max: 15 );
    buttons.add( borderForGrid, flag: WxSizerFlags.borderAll(valign: .center), border: 5 );
    final addToGrid = WxButton(parent, -1, "Add item" );
    buttons.add( addToGrid, flag: WxSizerFlags.borderAll(valign: .center), border: 5 );
    addToGrid.bindButtonEvent( (_) {
      flex.add( WxStaticText( parent, -1, textForGrid.getValue() ), 
        flag: wxALL, border: borderForGrid.getValue() );
      layout();
    }, -1);
    final removeFromGrid = WxButton(parent, -1, "Remove #1" );
    buttons.add( removeFromGrid, flag: WxSizerFlags.borderAll(valign: .center), border: 5 );
    removeFromGrid.bindButtonEvent( (_) {
      if (flex.getItemCount() > 0) {
        final item = flex.getItem(0);
        final win = item!.getWindow();
        flex.remove(0);
        win!.destroy();
        layout();
      }
    }, -1);
    final addSpacer = WxButton(parent, -1, "Add sizer" );
    buttons.add( addSpacer, flag: WxSizerFlags.borderAll(valign: .center), border: 5 );
    addSpacer.bindButtonEvent( (_) {
      final row = WxRow();
      row.add( WxStaticText(parent, -1, 'left left left'), flag: wxALL, border: 2 );
      row.add( WxStaticText(parent, -1, 'right right right'), flag: wxALL, border: 2 );
      flex.addSizer(row);
      layout();
    }, -1);
    sizer.addSizer( buttons );
  }
  void createWrapSizerPage( WxStaticBoxSizer sizer, WxWindow parent )
  {
    final wrap = WxWrapSizer();
    sizer.addSizer(wrap);
    for (int i = 0; i < 40; i++) {
      wrap.add( WxStaticText(parent, -1, "Text"), flag: wxALL, border: 5 );
    }
  }
  void createProportionPage( WxStaticBoxSizer sizer, WxWindow parent )
  {
    final horiz = WxBoxSizer( wxHORIZONTAL );
    sizer.addSizer(horiz,flag: wxEXPAND);
    horiz.add( WxStaticText(parent, -1, "Text field:"), flag: wxALL|wxALIGN_CENTRE_VERTICAL, border: 5 );
    horiz.add( WxTextCtrl(parent, -1, value: "Text field with proportion: 1" ), proportion: 1, flag: wxALL, border: 5 );
  }
  void createProportionsPage( WxStaticBoxSizer sizer, WxWindow parent )
  {
    final horiz = WxBoxSizer( wxHORIZONTAL );
    sizer.addSizer(horiz,flag: wxEXPAND);

    WxColour col = wxGREY;
    if (wxTheApp.isDark()) {
      col = wxLIGHT_GREY;
    }

    WxPanel panel = WxPanel( parent, -1, size: WxSize( 50,50 ) );
    panel.setBackgroundColour(col);
    horiz.add( panel, proportion: 1, flag: wxALL, border: 5 );
    panel = WxPanel( parent, -1, size: WxSize( 50,50 ) );
    panel.setBackgroundColour(col);
    horiz.add( panel, proportion: 2, flag: wxALL, border: 5 );
    panel = WxPanel( parent, -1, size: WxSize( 50,50 ) );
    panel.setBackgroundColour(col);
    horiz.add( panel, proportion: 3, flag: wxALL, border: 5 );
  }
  void createStretchSpacerPage( WxStaticBoxSizer sizer, WxWindow parent )
  {
    final horiz = WxBoxSizer( wxHORIZONTAL );
    sizer.addSizer(horiz,flag: wxEXPAND);
    horiz.add( WxStaticText(parent, -1, "Left of StretchSpacer") );
    horiz.addStretchSpacer();
    horiz.add( WxStaticText(parent, -1, "Right of StretchSpacer") );
  }
  void createBoxSizerPage( WxStaticBoxSizer sizer, WxWindow parent )
  {
    sizer.add( WxStaticText(parent, -1, "wxALIGN_LEFT"), flag: wxALIGN_LEFT );
    sizer.add( WxStaticText(parent, -1, "wxALIGN_CENTER_HORIZONTAL"), flag: wxALIGN_CENTER_HORIZONTAL );
    sizer.add( WxStaticText(parent, -1, "wxALIGN_RIGHT"), flag: wxALIGN_RIGHT );
  }
}
