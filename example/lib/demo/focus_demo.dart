
import 'dart:typed_data';

import 'package:wx_dart/wx_dart.dart';
import 'dart:math';


class MyFocussableWindow extends WxWindow {
  MyFocussableWindow( WxWindow parent, WxSize size, { bool isFile = false, bool isBitmap = false } ) : super( parent, -1, wxDefaultPosition, size, 0)
  {  
    bindKillFocusEvent((_)=>refresh() );
    bindSetFocusEvent((_)=>refresh() );

    bindPaintEvent( onPaint );

    _isFile = isFile;
    _isBitmap = isBitmap;

    _textDataObject = WxTextDataObject( "" );
    _fileDataObject = WxFileDataObject();
    _bitmapDataObject = WxBitmapDataObject( WxBitmap.fromAsset("wxWidgets.png", wxBITMAP_TYPE_PNG) );

    if (_isBitmap) {
      _target = WxDropTarget( _bitmapDataObject );
    } else
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
  late WxBitmapDataObject _bitmapDataObject;
  late WxDropTarget _target;
  String _dropText = "";
  bool _isFile = false;
  bool _isBitmap = false;
  bool _highlight = false;
  WxBitmap? _bitmap;

  @override
  WxSize getMinSize() {
    if (_isBitmap) {
      return WxSize( 250, 120);
    }
    return WxSize(250,60);
  }

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
    if (_isBitmap) {
      _bitmap = _bitmapDataObject.getBitmap();
      refresh();
    } else
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
          if (_isBitmap) {
            dc.drawText("Has focus.\nThis is a WxDropTarget for bitmaps!", 5, 5 );
            if (_bitmap != null) {
              int width = _bitmap!.getWidth();
              dc.drawBitmap(_bitmap!, getSize().x - width - 5, 5 );
            }
          } else 
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
          if (_isBitmap) {
            dc.drawText("Doesn't have focus.\nThis is a WxDropTarget for bitmaps!", 5, 5 );
            if (_bitmap != null) {
              int width = _bitmap!.getWidth();
              dc.drawBitmap(_bitmap!, getSize().x - width - 5, 5 );
            }
          } else 
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
  MyNonFocussableWindow( WxWindow parent, WxSize size, { bool isFile= false, bool isBitmap = false} ) 
  : super( parent, -1, wxDefaultPosition, size, 0 )
  {
    setCanFocus(false);

    _isFile = isFile;
    _isBitmap = isBitmap;

    if (_isBitmap) {
      _bitmap = WxBitmap.fromAsset("wxWidgets.png", wxBITMAP_TYPE_PNG );
    }

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
  bool _isBitmap = false;
  WxBitmap? _bitmap;

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
      if (_isBitmap) {
        final data = WxBitmapDataObject( _bitmap! );
        final source = WxDropSource(data, this);
        source.doDragDrop();
      } else
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
        if (_isBitmap) {
          dc.drawText("Cannot get focus.\nThis is a WxDropSource for:", 5, 5 );
          if (_bitmap != null) {
            final width = _bitmap!.getWidth();
            dc.drawBitmap(_bitmap!, getSize().x - width - 5, 5 );
          }
        } else 
        if (_isFile) {
          dc.drawText("Cannot get focus.\nThis is a WxDropSource for files!", 5, 5 );
        } else {
          dc.drawText("Cannot get focus.\nThis is a WxDropSource for text!", 5, 5 );
        }
      }
  }
}

const int idPopupWindowButton = 100;
const int idPopupTransientWindowButton = 101;

class MyFocusWindow extends WxScrolledWindow {
  MyFocusWindow( WxWindow parent ) : super( parent, -1, style: wxVSCROLL )
  {
    _popup = WxPopupWindow(this);
      final panel1 = WxPanel( _popup, -1 );
      // panel1.setBackgroundColour(wxRED);
      final sizer1 = WxColumn();
      sizer1.add( WxStaticText( panel1, -1, "This is a wonderful WxPopupwindow" ) );
      sizer1.add( WxStaticText( panel1, -1, "Second line" ) );
      panel1.setSizerAndFit(sizer1);
      _popup.setClientSize( panel1.getSize() );

    _popupTransient = WxPopupTransientWindow(this);
      final panel2 = WxPanel( _popupTransient, -1 );
      panel2.setBackgroundColour(wxGREEN);
      final sizer2 = WxColumn();
      sizer2.add( WxStaticText( panel2, -1, "This is a wonderful WxTransientPopupwindow" ) );
      sizer2.add( WxStaticText( panel2, -1, "Second line" ) );
      panel2.setSizerAndFit(sizer2);
      _popupTransient.setClientSize( panel2.getSize() );

    _popupTimer = WxTimer.withOwner(this);
    bindTimerEvent( (_) {
        _popup.hide();
    } );

    _popupTransient.bindPopupWindowDismissEvent( (event) {
      final frame = wxTheApp.getTopWindow();
      if (frame is WxFrame) {
        frame.showInfoBar("Dismissed popup - but did not veto", duration: 1500 );
      }
    }, -1 );

    final mainSizer = WxColumn();
    setSizer( mainSizer );

    final topPanel = WxPanel(this, -1);
    // topPanel.setBackgroundColour(wxGREEN);
    mainSizer.add( topPanel, flag: wxEXPAND, proportion: 1 ); 

    final topSizer = WxFlexGridSizer(2);
    topSizer.addGrowableCol(0);
    topPanel.setSizer(topSizer);

    final buttonSizer = WxRow();
    buttonSizer.add( WxButton( topPanel, idPopupWindowButton, "WxPopupWindow"), flag: wxALL, border: 5 );
    // buttonSizer.addStretchSpacer();
    buttonSizer.add( WxButton( topPanel, idPopupTransientWindowButton, "WxTransientPopupWindow"), flag: wxALL, border: 5 );
    topSizer.addSizer(buttonSizer);
    topSizer.add( WxStaticText(topPanel, -1, "<- Popup window tests"), flag: wxALL|wxALIGN_CENTER_VERTICAL, border: 10 );

    bindButtonEvent( (_) {
      final window = findWindow(idPopupWindowButton);
      if (window != null) {
        WxPoint pos = clientToScreen( window.getPosition() );
        _popup.position( pos, window.getSize() );
        _popup.show();
        _popupTimer.startOnce( milliseconds: 4000 );
      }
    }, idPopupWindowButton );
    bindButtonEvent( (_) {
      final window = findWindow(idPopupTransientWindowButton);
      if (window != null) {
        WxPoint pos = clientToScreen( window.getPosition() );
        _popupTransient.position( pos, window.getSize() );
        _popupTransient.popup(null);
      }
    }, idPopupTransientWindowButton );

    final buttonSizer2 = WxRow();
    buttonSizer2.add( WxButton( topPanel, -1, "Button 1"), flag: wxALL, border: 5 );
    buttonSizer2.addStretchSpacer();
    buttonSizer2.add( WxButton( topPanel, -1, "Button 2"), flag: wxALL, border: 5 );
    topSizer.addSizer(buttonSizer2,flag: wxEXPAND);
    topSizer.add( WxStaticText(topPanel, -1, "<- stretch spacer test"), flag: wxALL|wxALIGN_CENTER_VERTICAL, border: 10 );


    topSizer.add( MyFocussableWindow(topPanel, WxSize(250,50)), flag: wxALL|wxEXPAND, border: 10 );
    topSizer.add( WxStaticText(topPanel, -1, "<- WxDropTarget for text"), flag: wxALL|wxALIGN_CENTER_VERTICAL, border: 10 );

    topSizer.add( MyFocussableWindow(topPanel, WxSize(250,60), isBitmap: true ), flag: wxALL|wxALIGN_RIGHT, border: 10 );
    topSizer.add( WxStaticText(topPanel, -1, "<- WxDropTarget for bitmap"), flag: wxALL|wxALIGN_CENTER_VERTICAL, border: 10 );

    topSizer.add( MyFocussableWindow(topPanel, WxSize(250,50), isFile: true ), flag: wxALL|wxALIGN_LEFT, border: 10 );
    topSizer.add( WxStaticText(topPanel, -1, "<- WxDropTarget for files"), flag: wxALL|wxALIGN_CENTER_VERTICAL, border: 10 );

    final bottomPanel = WxPanel(this, -1);
    mainSizer.add( bottomPanel, flag: wxEXPAND, proportion: 1 ); 

    final bottomSizer = WxFlexGridSizer(2);
    bottomPanel.setSizer(bottomSizer);

    _dragTextCtrl1 = WxTextCtrl(bottomPanel, -1, value: "wxDart is cool", size: WxSize(220,-1) );
    bottomSizer.add( _dragTextCtrl1, flag: wxALL, border: 10 );
    bottomSizer.add( WxStaticText(bottomPanel, -1, "Drag and Drop text"), flag: wxALL, border: 10 );
    _dropSourceWindow1 = MyNonFocussableWindow(bottomPanel, WxSize(250,50) );
    _dropSourceWindow1.setDropText( _dragTextCtrl1.getValue() );
    _dragTextCtrl1.bindTextEvent( (event) => _dropSourceWindow1.setDropText( event.getString() ), -1 );
    bottomSizer.add( _dropSourceWindow1, flag: wxALL, border: 10 );
    bottomSizer.add( WxStaticText(bottomPanel, -1, "<- WxDropSource for text"), flag: wxALL|wxALIGN_CENTER_VERTICAL, border: 10 );

    bottomSizer.add( MyNonFocussableWindow(bottomPanel, WxSize(250,50), isFile: true ), flag: wxALL|wxEXPAND, border: 10 );
    bottomSizer.add( WxStaticText(bottomPanel, -1, "<- WxDropSource for files"), flag: wxALL|wxALIGN_CENTER_VERTICAL, border: 10 );
    
    bottomSizer.add( MyNonFocussableWindow(bottomPanel, WxSize(250,60), isBitmap: true ), flag: wxALL, border: 10 );
    bottomSizer.add( WxStaticText(bottomPanel, -1, "<- WxDropSource for bitmap"), flag: wxALL|wxALIGN_CENTER_VERTICAL, border: 10 );
    
  }

  late WxPopupWindow _popup;
  late WxPopupTransientWindow _popupTransient;

  late MyNonFocussableWindow _dropSourceWindow1;
  late WxTextCtrl _dragTextCtrl1;
  late WxTimer _popupTimer;

  @override
  void dispose() {
    _popupTimer.stop();
    super.dispose();
  }
}
