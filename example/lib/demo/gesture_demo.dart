
import 'package:wx_dart/wx_dart.dart';

// ------------------------- MyGestureWindow ----------------------

const mapSize = WxPoint( 3000, 2248 );

class MyGestureWindow extends WxWindow {
  MyGestureWindow( WxWindow parent, { WxPoint pos=wxDefaultPosition, WxSize size=wxDefaultSize, int style=0 }) :
    super( parent, -1, pos, size, style )
  { 
      // this assumes we are installed on the final machine
      String assetPath = wxGetStandardPaths().getResourcesDir();

      // this is for running locally
      if (!wxUsesFlutter() && (wxIsLinux() || wxIsMSW())) {
        assetPath = wxGetStandardPaths().getExecutablePath();
        assetPath = assetPath.substring(0, assetPath.length-8);
        assetPath += 'assets';
      }

      // Add forward or backward slash
      if (wxIsMSW() && !wxUsesFlutter()) {
        assetPath += "\\Merian_Germania_big.jpg";
      } else {
        assetPath += "/Merian_Germania_big.jpg";
      }

    _bitmap = WxBitmap(assetPath, wxBITMAP_TYPE_JPEG);

    _castle = WxBitmap.fromMaterialIcon( WxMaterialIcon.castle, WxSize(20,20), wxRED );

    _zoomIn = WxButton( this, -1, "", pos: WxPoint(10,10), style: wxBU_EXACTFIT );
    _zoomIn.setBitmap(WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.zoom_in, WxSize(24,24)) );
    _zoomIn.bindButtonEvent((_) {
      final windowSize = getSize();
      final centre = WxPoint( (windowSize.x/(_zoom*2)).floor()-_offset.x, (windowSize.y/(_zoom*2)).floor()-_offset.y );
      _zoom *= 1.2;
      _offset = WxPoint( (((windowSize.x~/2)/_zoom) - centre.x).floor(), (((windowSize.y~/2)/_zoom - centre.y)).floor() );
      refresh();
    }, -1);
    
    _zoomOut = WxButton( this, -1, "", pos: WxPoint(70,10), style: wxBU_EXACTFIT );
    _zoomOut.setBitmap(WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.zoom_out, WxSize(24,24)) );
    _zoomOut.bindButtonEvent((_) {
      final windowSize = getSize();
      final centre = WxPoint( (windowSize.x/(_zoom*2)).floor()-_offset.x, (windowSize.y/(_zoom*2)).floor()-_offset.y );
      _zoom /= 1.2;
      _offset = WxPoint( (((windowSize.x~/2)/_zoom) - centre.x).floor(), (((windowSize.y~/2)/_zoom - centre.y)).floor() );
      refresh();
    }, -1);

    _zoomFit = WxButton( this, -1, "Fit vertical", pos: WxPoint(140,10) );
    _zoomFit.bindButtonEvent((_) {
      final windowHeight = getSize().y;
      _zoom = windowHeight / mapSize.y;
      _offset = WxPoint.zero;
      refresh();
    }, -1);

    _touchToggle = WxToggleButton( this, -1, "Gestures", pos: WxPoint(330,10) );
    _touchToggle.bindToggleButtonEvent((event)
    {
      _usingGestures = event.isChecked();
      if (event.isChecked()) {
        enableTouchEvents( wxTOUCH_ALL_GESTURES );
      } else {
        enableTouchEvents( 0 );
      }
      refresh();
    }, -1);


    if (wxTheApp.isTouch()) {
      enableTouchEvents( wxTOUCH_ALL_GESTURES );
      _usingGestures = true;
      _touchToggle.setValue(true);
    }

    updateButtonBackgrounds();

    bindMotionEvent(onMouseMotion);
    bindLeftDownEvent(onLeftDown);
    bindLeftUpEvent(onLeftUp);

    bindMouseWheelEvent(onWheel);
    bindGestureZoomEvent(onZoomGesture);
    bindGesturePanEvent(onPanGesture);

    bindPaintEvent(onPaint);

    bindSysColourChangedEvent((_) => updateButtonBackgrounds() );
  }

  void onZoomGesture( WxZoomGestureEvent event )
  {
    if (event.isGestureStart()) {
      _isZooming = true;
      _liveZoom = 1.0;
    } else 
    if (event.isGestureEnd()) {
      _isZooming = false;
      _zoom = _zoom * _liveZoom;
      _liveZoom = 1.0;
    } else {
      _liveZoom = event.getZoomFactor();
    }
    refresh();
  }

  void onPanGesture( WxPanGestureEvent event )
  {
    if (event.isGestureStart()) {
      _isPanning = true;
    } else 
    if (event.isGestureEnd()) {
      _offset = WxPoint( _offset.x + _liveOffset.x, _offset.y + _liveOffset.y );
      _liveOffset = WxPoint.zero;
      _isPanning = false;
    } else {
      _liveOffset = WxPoint( _liveOffset.x + event.getDelta().x, _liveOffset.y + event.getDelta().y );
    }
    refresh();
  }

  void onWheel( WxMouseEvent event )
  {
    if (_usingGestures) return;

    // TODO center zoom around mouse position
    final windowSize = getSize();
    final centre = WxPoint( (windowSize.x/(_zoom*2)).floor()-_offset.x, (windowSize.y/(_zoom*2)).floor()-_offset.y );
    int rotations = event.getWheelRotation() ~/ event.getWheelDelta();
    if (rotations > 0)
    {
      for (int i = 0; i < rotations; i++) {
        _zoom *= 1.05; 
      }
    } else {
      for (int i = 0; i < rotations*-1; i++) {
        _zoom /= 1.05; 
      }
    }
    _offset = WxPoint( (((windowSize.x~/2)/_zoom) - centre.x).floor(), (((windowSize.y~/2)/_zoom - centre.y)).floor() );
    refresh();
  }

  void onPaint( WxPaintEvent event )
  {
    const cities = [
      [ 946, 1200, "Frankfurt" ],
      [ 739, 996, "Cologne" ],
      [ 1123, 355, "Hamburg" ],
      [ 1677, 654, "Berlin" ],
      [ 1798, 1196, "Prague" ],
      [ 350, 995, "Brussels" ],
      [ 788, 1730, "Basel" ],
      [ 1424, 1662, "Munich" ],
      [ 1691, 1736, "Salzburg" ],
      [ 2159, 1543, "Vienna" ],
    ];

    final dc = WxPaintDC(this);
    dc.setUserScale(_zoom*_liveZoom, _zoom*_liveZoom );
    dc.drawBitmap(_bitmap, _offset.x + _liveOffset.x, _offset.y + _liveOffset.y );

/*
    dc.setUserScale(1.0, 1.0 );
    dc.setPen( WxPen( wxBLACK, width: 2) );
    dc.drawRectangle(10, 10, 100, 100);

    dc.setUserScale(_zoom, _zoom );
    dc.setPen( WxPen( wxRED, width: 2) );
    dc.drawRectangle(10, 10, 100, 100);
*/

    dc.setTextForeground(wxBLACK);
    dc.setUserScale(1.0, 1.0 );
    dc.setFont( WxFont( 13, weight: wxFONTWEIGHT_BOLD ) );
    dc.setPen( wxBLACK_PEN );
    for (final entry in cities) {
      int x = entry[0] as int;
      int y = entry[1] as int;
      x = x+_offset.x+_liveOffset.x;
      y = y+_offset.y+_liveOffset.y;
      x = (x*_zoom*_liveZoom).floor();
      y = (y*_zoom*_liveZoom).floor();
      dc.drawBitmap( _castle, x, y );

      String name = entry[2] as String;
      final size = dc.getTextExtent(name);
      dc.drawRectangle(x+19 - 2, y-11 - 2, size.x+4, size.y+4 );       
      dc.drawText( name, x+19, y-11 );
    }

    final size = getClientSize();
    if (_isDragging) {
      dc.drawRectangle( 10, size.y-50, 100, 30 );
      dc.drawText( "dragging", 20, size.y-45 );
    }
    if (_usingGestures) {
      dc.drawRectangle( 10, size.y-50, 90, 30 );
      dc.drawText( "Gesture:", 20, size.y-45 );
    }
    if (_isPanning) {
      dc.drawRectangle( 110, size.y-50, 100, 30 );
      dc.drawText( "panning", 120, size.y-45 );
    }
    if (_isZooming) {
      dc.drawRectangle( 110, size.y-50, 100, 30 );
      dc.drawText( "zooming", 120, size.y-45 );
    }
  }

  void onLeftDown( WxMouseEvent event )
  {
    if (_usingGestures) return;

    final x = ((event.getX()/ _zoom - _offset.x) ).floor();
    final y = ((event.getY()/ _zoom - _offset.y) ).floor();

    _dragStart = event.getPosition();
    _isDragging = true;
  }
  void onLeftUp( WxMouseEvent event )
  {
    if (_usingGestures) return;
    
    final dx = ((event.getPosition().x-_dragStart.x) / _zoom ).floor();
    final dy = ((event.getPosition().y-_dragStart.y) / _zoom ).floor();
    _offset = WxPoint( _offset.x + dx, _offset.y + dy);
    _liveOffset = WxPoint.zero;
    refresh();
    _isDragging = false;
  }
  void onMouseMotion( WxMouseEvent event )
  {
    if (_usingGestures) return;    
    if (!_isDragging) return;

    final dx = ((event.getPosition().x-_dragStart.x) / _zoom ).floor();
    final dy = ((event.getPosition().y-_dragStart.y) / _zoom ).floor();
    _liveOffset = WxPoint( dx, dy );
    refresh();
  }

  void updateButtonBackgrounds()
  {
    if (wxTheApp.isDark()) {
      _zoomIn.setBackgroundColour(wxGREY);
      _zoomOut.setBackgroundColour(wxGREY);
      _zoomFit.setBackgroundColour(wxGREY);
      _touchToggle.setBackgroundColour(wxGREY);
    } else {
      _zoomIn.setBackgroundColour(wxYELLOW);
      _zoomOut.setBackgroundColour(wxYELLOW);
      _zoomFit.setBackgroundColour(wxWHITE);
      _touchToggle.setBackgroundColour(wxWHITE);
    }
  }

  late WxButton _zoomIn;
  late WxButton _zoomOut;
  late WxButton _zoomFit;
  late WxToggleButton _touchToggle;

  bool _isDragging = false;
  bool _isPanning = false;
  bool _isZooming = false;
  bool _usingGestures = false;
  double _zoom = 1.0;
  double _liveZoom = 1.0;
  WxPoint _offset = WxPoint.zero;
  WxPoint _liveOffset = WxPoint.zero;
  WxPoint _dragStart = WxPoint.zero;
  late WxBitmap _bitmap;
  late WxBitmap _castle;
}