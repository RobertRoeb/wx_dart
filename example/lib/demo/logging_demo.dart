
import 'package:wx_dart/wx_dart.dart';

class MyLoggingWindow extends WxScrolledWindow {
  MyLoggingWindow( parent ) : super( parent, -1, style: wxVSCROLL ) {

    final sizer = WxBoxSizer( wxVERTICAL );

    sizer.add( WxStaticText( this, -1, "This page tests WxTextCtrl"), flag: wxALL|wxALIGN_CENTRE, border: 20 );

    final sbs = WxStaticBoxSizer(wxVERTICAL, this, "Various text controls" );
    sizer.addSizer(sbs, flag: wxEXPAND );
    final sb = sbs.getStaticBox();
    sbs.add( WxStaticText(sb, -1, 'Single line WxTextCtrl with an initial value'), flag: wxALL, border: 5 );
    sbs.add( WxTextCtrl(sb, -1, value: 'Start value' ), flag: wxALL|wxEXPAND, border: 5 );

    sbs.add( WxStaticText(sb, -1, 'With hint and wxBORDER_SIMPLE'), flag: wxALL, border: 5);
    final text2 = WxTextCtrl(sb, -1, style: wxBORDER_SIMPLE );
    text2.setHint( "Hinting...");
    sbs.add( text2, flag: wxALL|wxEXPAND, border: 5 );

    sbs.add( WxStaticText(sb, -1, 'With wxTE_PASSWORD'), flag: wxALL, border: 5);
    sbs.add( WxTextCtrl(sb, -1, style: wxTE_PASSWORD ), flag: wxALL|wxEXPAND, border: 5 );

    sbs.add( WxStaticText(sb, -1, 'Multi line WxTextCtrl, 100px high, wxBORDER_SIMPLE') );
    final multi1 = WxTextCtrl(sb, -1, value: '100px high', size: WxSize(-1, 100), style: wxTE_MULTILINE+wxBORDER_SIMPLE);
    sbs.add( multi1, flag: wxALL|wxEXPAND, border: 5 );

    sbs.add( WxStaticText(sb, -1, 'Multi line WxTextCtrl, 100px high, wxTE_PROCESS_ENTER') );
    final multi = WxTextCtrl(sb, -1, value: '100px high', size: WxSize(-1, 100), style: wxTE_MULTILINE|wxTE_PROCESS_ENTER);
    sbs.add( multi, flag: wxALL|wxEXPAND, border: 5 );

    final wrap = WxWrapSizer();
    sbs.addSizer(wrap, flag: wxALL|wxEXPAND, border: 5 );

    final setValueButton = WxButton(sb, -1, 'setValue' );
    wrap.add( setValueButton, flag: wxALL, border: 5 );
    final changeValueButton = WxButton(sb, -1, 'changeValue' );
    wrap.add( changeValueButton, flag: wxALL, border: 5 );
    final selectAllButton = WxButton(sb, -1, 'selectAll' );
    wrap.add( selectAllButton, flag: wxALL, border: 5 );
    final selectNoneButton = WxButton(sb, -1, 'selectNone' );
    wrap.add( selectNoneButton, flag: wxALL, border: 5 );
    final getStringSelectionButton = WxButton(sb, -1, 'getStringSelection' );
    wrap.add( getStringSelectionButton, flag: wxALL, border: 5 );
    final getInsertionPointButton = WxButton(sb, -1, 'getInsertionPoint' );
    wrap.add( getInsertionPointButton, flag: wxALL, border: 5 );


    final lowerBox = WxStaticBoxSizer(wxVERTICAL, this, "Log window" );
    sizer.addSizer(lowerBox, flag: wxEXPAND|wxTOP, border: 5 );
    final log = WxTextCtrl(lowerBox.getStaticBox(), -1, size: WxSize( 100,100), style: wxTE_MULTILINE );
    lowerBox.add( log, flag: wxEXPAND  );

    multi.bindTextEnterEvent((event) {
      log.changeValue( 'bindTextEnterEvent:\n' );
      log.appendText( event.getString() );
    },-1);

    multi.bindTextEvent((event) {
      log.changeValue( 'bindTextEvent:\n' );
      log.appendText( event.getString() );
    },-1);

    changeValueButton.bindButtonEvent((event) {
      multi.changeValue( 'New text from changeValue' );
    },-1);

    setValueButton.bindButtonEvent((event) {
      multi.setValue( 'New text from setValue' );
    },-1);

    selectAllButton.bindButtonEvent((event) {
      multi.selectAll();
    },-1);

    selectNoneButton.bindButtonEvent((event) {
      multi.selectNone();
    },-1);

    getStringSelectionButton.bindButtonEvent((event) {
      final sel = multi.getStringSelection();
      log.changeValue( 'getStringSelection():\n' );
      log.appendText(sel);
    },-1);

    getInsertionPointButton.bindButtonEvent((event) {
      final sel = multi.getInsertionPoint();
      log.changeValue( 'getInsertionPoint():\n' );
      log.appendText("$sel");
    },-1);

    setSizer( sizer ); 
  }
}
