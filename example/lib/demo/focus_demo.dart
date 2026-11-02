
import 'dart:typed_data';

import 'package:wx_dart/wx_dart.dart';
import 'dart:math';


class MyFocussableWindow extends WxWindow {
  MyFocussableWindow( WxWindow parent, WxSize size, { bool isFile = false } ) : super( parent, -1, wxDefaultPosition, size, 0)
  {  
    bindKillFocusEvent((_)=>refresh() );
    bindSetFocusEvent((_)=>refresh() );

    bindPaintEvent( onPaint );

    _isFile = isFile;

    _textDataObject = WxTextDataObject( "" );
    _fileDataObject = WxFileDataObject();
    if (_isFile) {
      _target = WxDropTarget( _fileDataObject );
    } else {
      _target = WxDropTarget( _textDataObject );
    }
    setDropTarget( _target );

    bindDropEnterEvent( (_) {
      _highlight = true;
      refresh();
    }, -1 );
    bindDropLeaveEvent( (_) {
      _highlight = false;
      refresh();
    }, -1 );
    bindDropDropEvent( onDrop, -1);
    bindDropDataEvent( onData, -1);
  }

  late WxTextDataObject _textDataObject;
  late WxFileDataObject _fileDataObject;
  late WxDropTarget _target;
  String _dropText = "";
  bool _isFile = false;
  bool _highlight = false;

  void onDrop( WxDropEvent event )
  {
    final frame = wxTheApp.getTopWindow();
    if (frame is WxFrame) {
      frame.showInfoBar("Received drop from Drag and Drop", duration: 1500 );
    }
    _highlight = false;
    refresh();
  }
  void onData( WxDropEvent event )
  {
    _target.getData();
    if (_isFile) {
      final files = _fileDataObject.getFilenames();
      if (files.isNotEmpty) {
        _dropText = files.first; 
      }
    } else {
      _dropText = _textDataObject.getText();
    }
    refresh();
  }

  void onPaint( WxPaintEvent event )
  {
      final dc = WxPaintDC( this );
      dc.setBrush( wxTRANSPARENT_BRUSH );
      if (hasFocus()) {
        dc.setPen(WxPen(wxTheApp.getAccentColour(), width: _highlight ? 3 : 1 ));
        dc.drawRectangle(0, 0, getSize().x, getSize().y );
        if (_dropText.isNotEmpty) {
          dc.drawText("Has focus.\nReceived: $_dropText", 5, 5 );
        } else {
          if (_isFile) {
            dc.drawText("Has focus.\nThis is a WxDropTarget for files!", 5, 5 );
          } else {
            dc.drawText("Has focus.\nThis is a WxDropTarget for text!", 5, 5 );
          }
        }
      } else {
        dc.setPen(WxPen( wxGREY, width: _highlight ? 3 : 1 ));
        dc.drawRectangle(0, 0, getSize().x, getSize().y );
        if (_dropText.isNotEmpty) {
          dc.drawText("Doesn't have focus.\nReceived: $_dropText", 5, 5 );
        } else {
          if (_isFile) {
            dc.drawText("Doesn't have focus.\nThis is a WxDropTarget for files!", 5, 5 );
          } else {
            dc.drawText("Doesn't have focus.\nThis is a WxDropTarget for text!", 5, 5 );
          }
        }
      }
  }
}

class MyNonFocussableWindow extends WxWindow {
  MyNonFocussableWindow( WxWindow parent, WxSize size, { bool isFile= false} ) : super( parent, -1, wxDefaultPosition, size, 0)
  {
    setCanFocus(false);

    _isFile = isFile;

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
  bool _isFile = false;

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
      if (_isFile) {
        final data = WxFileDataObject( );
        final path = wxGetStandardPaths().getExecutablePath();
        final uri = Uri.file(path, windows: wxIsMSW() );
        data.addFile( uri.toString() );
        final source = WxDropSource(data, this);
        source.doDragDrop();
      } else {
        final data = WxTextDataObject( _dropText );
        final source = WxDropSource(data, this);
        source.doDragDrop();
      }
    }
  }

  void onPaint( WxPaintEvent event )
  {
      final dc = WxPaintDC( this );
      dc.setBrush( wxTRANSPARENT_BRUSH );
      if (hasFocus()) {
        dc.setPen(wxRED_PEN);
        dc.drawRectangle(0, 0, getSize().x, getSize().y );
        dc.drawText("Has focus, wrong!", 5, 5 );
      } else {
        dc.setPen( WxPen( wxTheApp.getAccentColour() ) );
        dc.drawRectangle(0, 0, getSize().x, getSize().y );
        if (_isFile) {
          dc.drawText("Cannot get focus.\nThis is a WxDropSource for files!", 5, 5 );
        } else {
          dc.drawText("Cannot get focus.\nThis is a WxDropSource for text!", 5, 5 );
        }
      }
  }
}

class MyFocusWindow extends WxScrolledWindow {
  MyFocusWindow( WxWindow parent ) : super( parent, -1, style: wxVSCROLL )
  {
    final mainSizer = WxColumn();
    setSizer( mainSizer );

    final topPanel = WxPanel(this, -1);
    // topPanel.setBackgroundColour(wxGREEN);
    mainSizer.add( topPanel, flag: wxEXPAND, proportion: 1 ); 

    final topSizer = WxFlexGridSizer(2);
    topPanel.setSizer(topSizer);

    _dragTextCtrl1 = WxTextCtrl(topPanel, -1, value: "wxDart is cool", size: WxSize(220,-1) );
    topSizer.add( _dragTextCtrl1, flag: wxALL, border: 10 );
    topSizer.add( WxStaticText(topPanel, -1, "Drag and Drop text"), flag: wxALL, border: 10 );
    topSizer.add( MyFocussableWindow(topPanel, WxSize(250,40)), flag: wxALL, border: 10 );
    topSizer.add( WxStaticText(topPanel, -1, "WxStaticText 2"), flag: wxALL, border: 10 );
    _dropSourceWindow1 = MyNonFocussableWindow(topPanel, WxSize(250,40));
    topSizer.add( _dropSourceWindow1, flag: wxALL, border: 10 );
    topSizer.add( WxStaticText(topPanel, -1, "WxStaticText 4"), flag: wxALL, border: 10 );
    topSizer.add( MyFocussableWindow(topPanel, WxSize(250,40), isFile: true ), flag: wxALL, border: 10 );
    topSizer.add( WxStaticText(topPanel, -1, "WxStaticText 6"), flag: wxALL, border: 10 );
    topSizer.add( WxTextCtrl(topPanel, -1, size: WxSize(250,-1) ), flag: wxALL, border: 10 );
    _dropSourceWindow1.setDropText( _dragTextCtrl1.getValue() );
    _dragTextCtrl1.bindTextEvent( (event) => _dropSourceWindow1.setDropText( event.getString() ), -1 );

    final bottomPanel = WxPanel(this, -1);
    // bottomPanel.setBackgroundColour(wxYELLOW);
    mainSizer.add( bottomPanel, flag: wxEXPAND, proportion: 1 ); 

    final bottomSizer = WxFlexGridSizer(2);
    bottomPanel.setSizer(bottomSizer);

    bottomSizer.add( MyFocussableWindow(bottomPanel, WxSize(250,40)), flag: wxALL, border: 10 );
    bottomSizer.add( WxStaticText(bottomPanel, -1, "WxStaticText 2"), flag: wxALL, border: 10 );
    _dropSourceWindow2 = MyNonFocussableWindow(bottomPanel, WxSize(250,40), isFile: true );
    bottomSizer.add( _dropSourceWindow2, flag: wxALL, border: 10 );
    bottomSizer.add( WxStaticText(bottomPanel, -1, "WxStaticText 4"), flag: wxALL, border: 10 );
    bottomSizer.add( MyFocussableWindow(bottomPanel, WxSize(250,40), isFile: true ), flag: wxALL, border: 10 );
    bottomSizer.add( WxStaticText(bottomPanel, -1, "WxStaticText 6"), flag: wxALL, border: 10 );
    bottomSizer.add( WxTextCtrl(bottomPanel, -1, size: WxSize(250,-1) ), flag: wxALL, border: 10 );
  }

  late MyNonFocussableWindow _dropSourceWindow1;
  late MyNonFocussableWindow _dropSourceWindow2;
  late WxTextCtrl _dragTextCtrl1;
}
