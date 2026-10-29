
import 'package:wx_dart/wx_dart.dart';
import 'dart:math';


class MyFocussableWindow extends WxWindow {
  MyFocussableWindow( WxWindow parent, WxSize size ) : super( parent, -1, wxDefaultPosition, size, 0)
  {  
    bindKillFocusEvent((_)=>refresh() );
    bindSetFocusEvent((_)=>refresh() );

    bindPaintEvent( onPaint );

    _data = WxTextDataObject( "" );
    _target = WxDropTarget( _data );
    setDropTarget( _target );

    bindDropEnterEvent( (_) { 
      print( "DropEnterEvent" );
      setBackgroundColour(wxGREEN);
    }, -1 );
    bindDropLeaveEvent( (_) {
      print( "DropLeaveEvent" );
      setBackgroundColour(wxGREY);
    }, -1 );
    bindDropDropEvent( onDrop, -1);
    bindDropDataEvent( onData, -1);
  }

  late WxTextDataObject _data;
  late WxDropTarget _target;
  String _dropText = "";

  void onDrop( WxDropEvent event )
  {
    print( "onDrop" );
  }
  void onData( WxDropEvent event )
  {
    print( "onData" );
    _target.getData();
    _dropText = _data.getText();
    refresh();
  }

  void onPaint( WxPaintEvent event )
  {
      final dc = WxPaintDC( this );
      dc.setBrush( wxWHITE_BRUSH );
      if (hasFocus()) {
        dc.setPen(wxBLACK_PEN);
        dc.drawRectangle(0, 0, getSize().x, getSize().y );
        if (_dropText.isNotEmpty) {
          dc.drawText("Has focus.\nReceived: $_dropText", 5, 5 );
        } else {
          dc.drawText("Has focus.\nThis is a WxDropTarget!", 5, 5 );
        }
      } else {
        dc.setPen(wxTRANSPARENT_PEN);
        dc.drawRectangle(0, 0, getSize().x, getSize().y );
        if (_dropText.isNotEmpty) {
          dc.drawText("Doesn't have focus.\nReceived: $_dropText", 5, 5 );
        } else {
          dc.drawText("Doesn't have focus.\nThis is a WxDropTarget!", 5, 5 );
        }
      }
  }
}

class MyNonFocussableWindow extends WxWindow {
  MyNonFocussableWindow( WxWindow parent, WxSize size ) : super( parent, -1, wxDefaultPosition, size, 0)
  {
    setCanFocus(false);

    bindKillFocusEvent((_)=>refresh() );
    bindSetFocusEvent((_)=>refresh() );

    bindPaintEvent( onPaint );
    bindLeftDownEvent((event) {_isDown = true; _start = event.getPosition(); } );
    bindLeftUpEvent((_) {
      _isDown = false;
    } );
    bindLeaveWindowEvent( (_) => _isDown = false );
    bindMotionEvent(onMotion);

    bindDragFeedbackEvent( (_) {
      // give custom feedback
    }, -1 );
  }

  bool _isDown = false;
  WxPoint _start = WxPoint.zero;
  String _dropText = "DropText";

  void setDropText( String text ) {
    _dropText = text;
  }

  void onMotion( WxMouseEvent event )
  {
    if (!_isDown) return;
    final dx = (event.getPosition().x - _start.x).toDouble();
    final dy = (event.getPosition().y - _start.y).toDouble();
    final dist = sqrt(dx*dx + dy*dy);
    if (dist > 7) {
      _isDown = false;
      final data = WxTextDataObject( _dropText );
      final source = WxDropSource(data, this);
      source.doDragDrop();
    }
  }

  void onPaint( WxPaintEvent event )
  {
      final dc = WxPaintDC( this );
      dc.setBrush( wxWHITE_BRUSH );
      if (hasFocus()) {
        dc.setPen(wxBLACK_PEN);
        dc.drawRectangle(0, 0, getSize().x, getSize().y );
        dc.drawText("Has focus, wrong!", 5, 5 );
      } else {
        dc.setPen(wxTRANSPARENT_PEN);
        dc.drawRectangle(0, 0, getSize().x, getSize().y );
        dc.drawText("Cannot get focus.\nThis is a WxDropSource!", 5, 5 );
      }
  }
}

class MyFocusWindow extends WxScrolledWindow {
  MyFocusWindow( WxWindow parent ) : super( parent, -1, style: wxVSCROLL )
  {
    final mainSizer = WxColumn();
    setSizer( mainSizer );

    final topPanel = WxPanel(this, -1);
    topPanel.setBackgroundColour(wxGREEN);
    mainSizer.add( topPanel, flag: wxEXPAND, proportion: 1 ); 

    final topSizer = WxFlexGridSizer(2);
    topPanel.setSizer(topSizer);

    _dragTextCtrl1 = WxTextCtrl(topPanel, -1, value: "wxDart is cool 1", size: WxSize(220,-1) );
    topSizer.add( _dragTextCtrl1, flag: wxALL, border: 10 );
    topSizer.add( WxStaticText(topPanel, -1, "Drag and Drop text 1"), flag: wxALL, border: 10 );
    topSizer.add( MyFocussableWindow(topPanel, WxSize(220,40)), flag: wxALL, border: 10 );
    topSizer.add( WxStaticText(topPanel, -1, "WxStaticText 2"), flag: wxALL, border: 10 );
    _dropSourceWindow1 = MyNonFocussableWindow(topPanel, WxSize(220,40));
    topSizer.add( _dropSourceWindow1, flag: wxALL, border: 10 );
    topSizer.add( WxStaticText(topPanel, -1, "WxStaticText 4"), flag: wxALL, border: 10 );
    topSizer.add( MyFocussableWindow(topPanel, WxSize(220,40)), flag: wxALL, border: 10 );
    topSizer.add( WxStaticText(topPanel, -1, "WxStaticText 6"), flag: wxALL, border: 10 );
    topSizer.add( WxTextCtrl(topPanel, -1, size: WxSize(220,-1) ), flag: wxALL, border: 10 );
    _dropSourceWindow1.setDropText( _dragTextCtrl1.getValue() );
    _dragTextCtrl1.bindTextEvent( (event) => _dropSourceWindow1.setDropText( event.getString() ), -1 );

    final bottomPanel = WxPanel(this, -1);
    bottomPanel.setBackgroundColour(wxYELLOW);
    mainSizer.add( bottomPanel, flag: wxEXPAND, proportion: 1 ); 

    final bottomSizer = WxFlexGridSizer(2);
    bottomPanel.setSizer(bottomSizer);

    _dragTextCtrl2 = WxTextCtrl(bottomPanel, -1, value: "wxDart is cool 2", size: WxSize(220,-1) );
    bottomSizer.add( _dragTextCtrl2, flag: wxALL, border: 10 );
    bottomSizer.add( WxStaticText(bottomPanel, -1, "Drag and Drop text 2"), flag: wxALL, border: 10 );
    bottomSizer.add( MyFocussableWindow(bottomPanel, WxSize(220,40)), flag: wxALL, border: 10 );
    bottomSizer.add( WxStaticText(bottomPanel, -1, "WxStaticText 2"), flag: wxALL, border: 10 );
    _dropSourceWindow2 = MyNonFocussableWindow(bottomPanel, WxSize(220,40));
    bottomSizer.add( _dropSourceWindow2, flag: wxALL, border: 10 );
    bottomSizer.add( WxStaticText(bottomPanel, -1, "WxStaticText 4"), flag: wxALL, border: 10 );
    bottomSizer.add( MyFocussableWindow(bottomPanel, WxSize(220,40)), flag: wxALL, border: 10 );
    bottomSizer.add( WxStaticText(bottomPanel, -1, "WxStaticText 6"), flag: wxALL, border: 10 );
    bottomSizer.add( WxTextCtrl(bottomPanel, -1, size: WxSize(220,-1) ), flag: wxALL, border: 10 );
    _dropSourceWindow2.setDropText( _dragTextCtrl2.getValue() );
    _dragTextCtrl2.bindTextEvent( (event) => _dropSourceWindow2.setDropText( event.getString() ), -1 );
  }

  late MyNonFocussableWindow _dropSourceWindow1;
  late MyNonFocussableWindow _dropSourceWindow2;
  late WxTextCtrl _dragTextCtrl1;
  late WxTextCtrl _dragTextCtrl2;
}
