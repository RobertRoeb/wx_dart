
import 'package:wx_dart/wx_dart.dart';

// ------------------------- MyTileSizerWindow ----------------------

class MyTileSizerWindow extends WxScrolledWindow {
  MyTileSizerWindow( WxWindow parent ) : super(parent,-1,style:wxVSCROLL)
  {
    final mainSizer = WxBoxSizer( wxVERTICAL );
    setSizer( mainSizer );

    mainSizer.addSpacer(10);

    double pointSize = wxNORMAL_FONT.getPointSize();

    final topSizer = WxStaticBoxSizer( wxVERTICAL, this, "Top" );
    final topParent = topSizer.getStaticBox();
    for (int i = 0; i < 6; i++) 
    {
      final leading = WxStaticBitmap(topParent, -1, WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.account_balance, WxSize(48,48), colour: wxGREY ) );
      final title = WxStaticText(topParent, -1, "Main text in row #$i" )..setFont(WxFont(pointSize*1.2));
      final subtitle = WxStaticText(topParent, -1, "Medium text" );
      final third = WxStaticText(topParent, -1, "Small text at the bottom" )..setFont(WxFont(pointSize/1.2));
      final trailing = WxButton(topParent, -1, "More..." );
      final tileSizer = WxTileSizer(leading, title, subtitle, third: third, trailing: trailing );
      topSizer.addSizer(tileSizer, flag: wxEXPAND|wxTOP|wxBOTTOM, border: 3 );
    }
    mainSizer.addSizer(topSizer, flag: wxLEFT|wxRIGHT, border: 5);

    mainSizer.addSpacer(20);

    final bottomSizer = WxStaticBoxSizer( wxVERTICAL, this, "Bottom" );
    final bottomParent = bottomSizer.getStaticBox();
    for (int i = 0; i < 6; i++) 
    {
      final leading = WxStaticBitmap(bottomParent, -1, WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.account_balance, WxSize(48,48), colour: wxGREY ) );
      final title = WxStaticText(bottomParent, -1, "Main text in row #$i" );
      final third = WxStaticText(bottomParent, -1, "Small text in middle row" )..setFont(WxFont(pointSize/1.2));
      final trailing = WxButton(bottomParent, -1, "" );
      trailing.setBitmap( WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.delete_sweep, WxSize(28,28), colour: wxRED) );
      final tileSizer = WxTileSizer(leading, title, null, third: third, trailing: trailing );
      bottomSizer.addSizer(tileSizer, flag: wxEXPAND|wxTOP|wxBOTTOM, border: 3 );
    }
    mainSizer.addSizer(bottomSizer, flag: wxLEFT|wxRIGHT, border: 5);

    mainSizer.addSpacer(10);
  }
}

// ------------------------- MyTileDataView ----------------------

class MyTileDataView extends WxPanel {
  MyTileDataView( WxWindow parent ) : super( parent, -1 )
  {
    _mainSizer = WxBoxSizer( wxHORIZONTAL );
    setSizer(_mainSizer);

    _dataview = WxDataViewTileListCtrl( this, -1, 80, 4, size: WxSize(300,-1), style: wxDV_NO_HEADER|wxVSCROLL );

    _isTouch = wxTheApp.isTouch();
    if (_isTouch)
    {
      _item = _mainSizer.add( _dataview, flag: wxEXPAND, proportion: 1 );
    }
    else
    {
      _item = _mainSizer.add( _dataview, flag: wxEXPAND );
      _mainSizer.addStretchSpacer();
    }

    final leading = WxBitmap.fromMaterialIcon( WxMaterialIcon.account_balance, WxSize(48,48), wxGREY );
    final trailing = WxBitmap.fromMaterialIcon( WxMaterialIcon.hot_tub, WxSize(48,48), wxGREY );
    for (int i = 0; i < 200; i++) {
      _dataview.appendTile( leading, "Main text in row #$i", "Medium text", small: "Small text at the bottom", trailing: trailing );
    }

    bindDataViewSelectionChangedEvent((event) {
      final frame = WxApp.getMainTopWindow() as WxFrame;
      int selection = _dataview.getSelectedRow();
      if (selection != -1) {
        final tileData = _dataview.getValue(selection, 0) as WxDataViewTileData;
        wxLogStatus( frame, "Selected item: ${tileData.big}" );
      }
    }, -1);

    bindDataViewItemActivatedEvent((event) {
      final frame = WxApp.getMainTopWindow() as WxFrame;
      int selection = _dataview.getSelectedRow();
      if (selection != -1) {
        final tileData = _dataview.getValue(selection, 0) as WxDataViewTileData;
        final dialog = WxMessageDialog(frame, "Clicked", caption: "WxDataViewTileListCtrl" );
        dialog.setExtendedMessage("Item click is: ${tileData.big}" );
        dialog.showModal(null);
        
      }
    }, -1);

    _isTouch = wxTheApp.isTouch();
    bindSizeEvent( onSize );
  }

  bool _isTouch = false;
  late WxBoxSizer _mainSizer;
  late WxSizerItem _item;
  late WxDataViewTileListCtrl _dataview;

  void onSize( WxSizeEvent event )
  {
    if (_isTouch != wxTheApp.isTouch())
    {
      _isTouch = wxTheApp.isTouch();
      if (_isTouch)
      {
        _item.setProportion( 1 );
        _dataview.setSize( WxSize(-1,-1) );
        _mainSizer.remove(1);
      }
      else
      {
        _item.setProportion( 0 );
        _dataview.setSize( WxSize(300,-1) );
        _mainSizer.addStretchSpacer();
      }
    }
    event.skip();
  }
}
