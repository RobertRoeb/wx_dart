
import 'package:wx_dart/wx_dart.dart';
import 'dart:math';

// ------------------------- MyGraphicsPathWindow ----------------------

class MyGraphicsPathWindow extends WxScrolledWindow {
  MyGraphicsPathWindow( WxWindow parent, int style ) : super( parent, -1, pos: wxDefaultPosition, size: WxSize( 200, 200) )
  {
    setVirtualSize(WxSize(600,400));
    setScrollRate(10, 10);

    bindPaintEvent( onPaint );
  }


  void onPaint( WxPaintEvent event )
  {
    final dc = WxPaintDC( this );
    doPrepareDC(dc);

    final gc = WxGraphicsContext.fromDC(dc);

    gc.setPen(wxRED_PEN);

    dc.drawRectangle(0,0, 100, 100);

    dc.drawRectangle(120,0, 2, 2);
    dc.drawRectangle(120,10, 3, 3);
    dc.drawRectangle(120,20, 4, 4);

    gc.drawRectangle(130,0, 2, 2);
    gc.drawRectangle(130,10, 3, 3);
    gc.drawRectangle(130,20, 4, 4);

    dc.drawRectangle(24,24, 53, 53);
    final path = gc.createPath();
        path.addCircle( 50.0, 50.0, 50.0 );
        path.moveTo(0.0, 50.0);
        path.addLineTo(100.0, 50.0);
        path.moveTo(50.0, 0.0);
        path.addLineTo(50.0, 100.0 );
        path.closeSubpath();
        path.addRectangle(25.0, 25.0, 50.0, 50.0); 
    gc.strokePath(path);    

    // scale everything
    gc.scale(1.1,1.1);
    // translate right
    gc.translate(100,0);
    // rotate
    gc.rotate(0.1);

    // draw again
    gc.setPen(wxGREEN_PEN);
    gc.strokePath(path);    
  }
}

// ------------------------- MyGraphicsWindow ----------------------

class MyGraphicsWindow extends WxScrolledWindow {
  MyGraphicsWindow( WxWindow parent, int style, bool background ) : super( parent, -1, pos: wxDefaultPosition, size: WxSize( 200, 200) )
  {
    if (background) {
      setBackgroundColour( wxYELLOW );
    }

    setVirtualSize(WxSize(600,400));
    setScrollRate(10, 10);


    final image = WxImage( 80, 120 );
    image.initAlpha();
    for (int y = 0; y < 120; y++) {
        for (int x = 0; x < 80; x++) {
          // same colour everywhere
          image.setRGB(x, y, 100, 100, 255 );

          // increase transparency downwards
          image.setAlpha(x, y, 255 - y*2 );  
        }
    }

    // create bitmap from image
    bitmap = WxBitmap.fromImage( image ); 

    // create graphics context for build optimize graphics bitmaps
    final gc = WxGraphicsContext();

    // build WxGraphicsBitmap from image
    bitmapFromImage = gc.createBitmapFromImage( image );

    // build WxGraphicsBitmap from bitmap
    bitmapFromBitmap = gc.createBitmap( bitmap );

    bindPaintEvent( onPaint );
  }

  late WxBitmap bitmap;
  late WxGraphicsBitmap bitmapFromImage;
  late WxGraphicsBitmap bitmapFromBitmap;

  void onPaint( WxPaintEvent event )
  {
    final dc = WxPaintDC( this );
    doPrepareDC(dc);

    final gc = WxGraphicsContext.fromDC(dc);

    gc.setPen(wxRED_PEN);
    gc.drawRectangle(2, 2, 48, 48 );

    dc.setPen(wxBLACK_PEN);
    dc.drawRectangle(4, 4, 44, 4);

    // still draws red
    gc.drawRectangle(50, 2, 48, 48 );

    dc.drawText("dc.drawBitmap", 20, 100 );
    dc.drawBitmap(bitmap, 20, 50 );

    // still draws red around
    gc.drawRectangle(19, 49, 82, 122 );

    dc.setBrush(wxTRANSPARENT_BRUSH);
    dc.drawRectangle(21, 51, 78, 118 );

    dc.drawText("gc.drawBitmap", 120, 100 );
    gc.drawBitmap(bitmapFromImage, 120, 50, 80, 120 );

    gc.pushState();

    // scale everything
    gc.scale(1.1,1.1);
    // translate right
    gc.translate(100,0);
    // rotate
    gc.rotate(0.1);

    gc.drawBitmap(bitmapFromImage, 120, 50, 80, 120 );

    gc.popState();
    
    dc.drawText("rotated + scaled", 220, 100 );

    dc.drawText("rotated back", 350, 100 );

    // translate right
    gc.translate(200,0);
    gc.rotate(-0.1);

    // draw again, but not scaled
    gc.drawBitmap(bitmapFromBitmap, 120, 50, 80, 120 );
  }
}

// ------------------------- MyLinesWindow ----------------------

class MyLinesWindow extends WxWindow {
  MyLinesWindow( WxWindow parent, int style, bool background ) : super( parent, -1, wxDefaultPosition, WxSize( 200, 100), style )
  {
    if (background) {
      setBackgroundColour( wxYELLOW );
    }

    bindPaintEvent( onPaint );
  }

  void onPaint( WxPaintEvent event )
  {
    final dc = WxPaintDC( this );
    dc.setPen( wxBLACK_PEN );
    dc.drawLine( 10, 10, 200, 10 );
    dc.setPen(WxPen(wxBLUE, width: 3 ));
    dc.drawLine( 10, 10, 200, 30 );
    dc.setPen(WxPen(wxRED, width: 5 ));
    dc.drawLine( 10, 10, 200, 50 );

    dc.gradientFillLinear(WxRect(250, 10, 100, 100), wxGREEN, wxBLUE );
    dc.gradientFillConcentric(WxRect(351, 10, 100, 100), wxGREEN, wxBLUE );
  }
}

// ------------------------- MyShapesWindow ----------------------

class MyShapesWindow extends WxWindow {
  MyShapesWindow( WxWindow parent, int style ) : super( parent, -1, wxDefaultPosition, WxSize( 200, 300), style )
  {
    bindPaintEvent( onPaint );
  }

  void onPaint( WxPaintEvent event )
  {
      final dc = WxPaintDC( this );

      dc.setPen( wxRED_PEN );
      dc.drawLine( -1,5, -1,25 );
      dc.setPen( WxPen( wxBLUE, capStyle: wxCAP_BUTT ) );
      dc.drawLine( 0,5, 0,25 );
      dc.setPen( WxPen( wxBLUE, capStyle: wxCAP_PROJECTING ) );
      dc.drawLine( 1,5, 1,25 );
      dc.setPen( WxPen( wxBLUE, capStyle: wxCAP_ROUND ) );
      dc.drawLine( 3,5, 3,25 );

      dc.setPen( wxTRANSPARENT_PEN);
      dc.setBrush( wxYELLOW_BRUSH );
      dc.drawRectangle( 5, 5, 20, 21 );

      dc.setPen( wxBLUE_PEN );
      dc.drawRectangle( 5, 12, 20, 13 );
      dc.setPen( wxBLUE_PEN );
      dc.drawRectangle( 25, 12, 20, 13 );


      dc.setBrush( wxTRANSPARENT_BRUSH );
      dc.setPen( wxBLACK_PEN);

      dc.drawCircle( 50, 50, 20 );
      dc.drawRoundedRectangle( 100, 10, 100, 100, 20 );
      dc.drawEllipticArc( 50, 200, 100, 50, -45, 270 );

      // strange API
      dc.drawArc( 0, 150, 70, 120, 50, 150 );

      dc.setBrush( wxYELLOW_BRUSH );

      dc.drawCircle(250, 50, 20 );
      dc.drawRoundedRectangle( 300, 10, 100, 100, 20 );
      dc.drawEllipticArc(250, 200, 100, 50, -45, 270 );

      // strange API
      dc.drawArc(150, 150, 220, 120, 200, 150 );

      // Lines
      final List<WxPoint> points1 = [];
        points1.add( WxPoint( 375, 50 ) );
        points1.add( WxPoint( 400, 100 ) );
        points1.add( WxPoint( 375, 150 ) );
        points1.add( WxPoint( 350, 200 ) );
        points1.add( WxPoint( 375, 250 ) );
      dc.setPen( wxBLUE_PEN );
      dc.drawLines(points1);

      final List<WxPoint> points2 = [];
        points2.add( WxPoint( 400, 50 ) );
        points2.add( WxPoint( 425, 100 ) );
        points2.add( WxPoint( 400, 150 ) );
        points2.add( WxPoint( 375, 200 ) );
        points2.add( WxPoint( 400, 250 ) );
      dc.setPen( wxRED_PEN );
      dc.drawSpline(points2);

      // Polygon
      final List<WxPoint> points3 = [];
        points3.add( WxPoint( 170, 240 ) );
        points3.add( WxPoint( 220, 220 ) );
        points3.add( WxPoint( 220, 280 ) );
        points3.add( WxPoint( 170, 260 ) );
      dc.setBrush( wxYELLOW_BRUSH );
      dc.drawPolygon(points3);

  }
}

// ------------------------- MyFontWindow ----------------------

class MyFontWindow extends WxWindow {
  MyFontWindow( WxWindow parent, int style ) : super( parent, -1, wxDefaultPosition, WxSize( 200, 300), style )
  {
    bindPaintEvent( (_) {
      final dc = WxPaintDC( this );

      dc.setTextForeground( wxRED );
      dc.drawText("Hello in red.", 10, 0 );

      dc.setTextForeground( wxBLUE );
      dc.setFont( WxFont.fromPixelSize( WxSize(0,15), weight: wxFONTWEIGHT_BOLD, family: wxFONTFAMILY_ROMAN  ) );
      dc.drawText("Hello in blue bold roman.", 10, 30 );

      dc.setTextForeground( wxGREY );
      dc.setFont( WxFont.fromPixelSize(WxSize(0,15), style: wxFONTSTYLE_ITALIC) );
      dc.setBackgroundMode(wxBRUSHSTYLE_SOLID);
      dc.setTextBackground(wxYELLOW);
      dc.drawText("Hello in grey italic.", 10, 60 );

      dc.setBackgroundMode(wxBRUSHSTYLE_TRANSPARENT);
      int x = 130;
      int y = 10;
      dc.setBrush( wxTRANSPARENT_BRUSH );
      dc.setPen( wxBLACK_PEN);

      for (int pointSize = 6; pointSize <= 18; pointSize++)
      {
          final font = WxFont( pointSize.toDouble() );
          dc.setFont( font );
          final size = dc.getTextExtent("Hello" );
          dc.drawRectangle(x, y, size.getWidth(), size.getHeight() );
          dc.drawText( "Hello at size $pointSize, w: ${size.getWidth()} h: ${size.getHeight()}", x, y );
          y += size.y + 5;
      }
    } );
  }
}

// ------------------------- MyImageWindow ----------------------

class MyImageWindow extends WxWindow {
  MyImageWindow( WxWindow parent, int style ) : super( parent, -1, wxDefaultPosition, WxSize( 200, 300), style )
  {
    final image = WxImage( 100, 200 );
    image.initAlpha();
    for (int y = 5; y < 195; y++) {
        for (int x = 5; x < 95; x++) {
          image.setRGB(x, y, 50+y, 100, 100 );
          image.setAlpha(x, y, 50+y );
        }
    }

    // make top 20 rows white
    final data = image.getData();
    for (int i = 0; i < 100*20*3; i++) {
        data.setUint8(i, 255);
    }
    bitmap = WxBitmap.fromImage( image ); 

    final dc = WxMemoryDC(100, 100);

    dc.setPen( wxTRANSPARENT_PEN );

    dc.setBrush( wxRED_BRUSH );
    dc.drawRectangle(-10, -10, 120, 120 );  // this is too big, but only 1 pixel will be on the bitmap
    dc.setBrush( wxLIGHT_GREY_BRUSH );
    dc.drawRectangle(1,1, 98, 98 ); 

    dc.setPen( wxRED_PEN );
    dc.setBrush( wxTRANSPARENT_BRUSH );
    for (int i = 0; i < 10; i++) {
      dc.drawCircle( 50+i, 40+i*5, 10+i*2 ); 
    }
    dc.setTextForeground(wxBLACK);
    dc.setFont(wxNORMAL_FONT);
    dc.drawText("WxMemoryDC", 10, 10 );
    memBitmap = dc.getBitmap();

    icon1 = WxBitmap.fromMaterialIcon( WxMaterialIcon.add_home_work, WxSize(15,15), wxRED );
    icon2 = WxBitmap.fromMaterialIcon( WxMaterialIcon.add_home_work, WxSize(21,21), wxRED );
    icon3 = WxBitmap.fromMaterialIcon( WxMaterialIcon.add_home_work, WxSize(25,25), wxRED );
    icon4 = WxBitmap.fromMaterialIcon( WxMaterialIcon.add_home_work, WxSize(32,32), wxRED );
    icon5 = WxBitmap.fromMaterialIcon( WxMaterialIcon.add_home_work, WxSize(41,41), wxRED );

    icon6 = WxBitmap.fromMaterialIcon( WxMaterialIcon.garage, WxSize(15,15), wxGREY );
    icon7 = WxBitmap.fromMaterialIcon( WxMaterialIcon.garage, WxSize(21,21), wxGREY );
    icon8 = WxBitmap.fromMaterialIcon( WxMaterialIcon.garage, WxSize(25,25), wxGREY );
    icon9 = WxBitmap.fromMaterialIcon( WxMaterialIcon.garage, WxSize(32,32), wxGREY );
    icon10 = WxBitmap.fromMaterialIcon( WxMaterialIcon.garage, WxSize(41,41), wxGREY );

    icon11 = WxBitmap.fromMaterialIcon( WxMaterialIcon.data_exploration, WxSize(15,15), wxBLUE );
    icon12 = WxBitmap.fromMaterialIcon( WxMaterialIcon.data_exploration, WxSize(21,21), wxBLUE );
    icon13 = WxBitmap.fromMaterialIcon( WxMaterialIcon.data_exploration, WxSize(25,25), wxBLUE );
    icon14 = WxBitmap.fromMaterialIcon( WxMaterialIcon.data_exploration, WxSize(32,32), wxBLUE );
    icon15 = WxBitmap.fromMaterialIcon( WxMaterialIcon.data_exploration, WxSize(41,41), wxBLUE );

    bindPaintEvent( onPaint );
  }

  late WxBitmap bitmap,memBitmap;
  late WxBitmap icon1,icon2,icon3,icon4,icon5;
  late WxBitmap icon6,icon7,icon8,icon9,icon10;
  late WxBitmap icon11,icon12,icon13,icon14,icon15;

  void onPaint( WxPaintEvent event )
  {
    final dc = WxPaintDC( this );

    dc.drawBitmap(bitmap, 10, 10);
    dc.drawBitmap(memBitmap, 120, 10);

        dc.drawBitmap(icon1, 200, 80 );
        dc.drawBitmap(icon2, 200, 120 );
        dc.drawBitmap(icon3, 200, 160 );
        dc.drawBitmap(icon4, 200, 200 );
        dc.drawBitmap(icon5, 200, 250 );

        dc.drawBitmap(icon6, 250, 80 );
        dc.drawBitmap(icon7, 250, 120 );
        dc.drawBitmap(icon8, 250, 160 );
        dc.drawBitmap(icon9, 250, 200 );
        dc.drawBitmap(icon10, 250, 250 );

        dc.drawBitmap(icon11, 300, 80 );
        dc.drawBitmap(icon12, 300, 120 );
        dc.drawBitmap(icon13, 300, 160 );
        dc.drawBitmap(icon14, 300, 200 );
        dc.drawBitmap(icon15, 300, 250 );

  }
}

// ------------------------- MyImageWindow ----------------------

class MyScrollAndMouseWindow extends WxScrolledWindow
{
  MyScrollAndMouseWindow( WxWindow parent, bool useSetVirtualSize ) : super( parent, -1, size: WxSize( 300, 150), style: wxBORDER_SIMPLE )
  {
      WxStaticText( this, -1, "Move the mouse over the rectangle or click somewhere", pos: WxPoint( 10, 10 ) );

      final mouseInfo = WxStaticText( this, -1, "WxMouseEvents:", pos: WxPoint( 10, 30 ) );

      // these should be the same
      if (useSetVirtualSize) {
        setVirtualSize( WxSize(500,300) );
        setScrollRate(10, 10);
      } else {
        setScrollbars( 10, 10, 50, 30 );
      }

      bindScrollWinEvent( (event) {
        //print( "Pos: ${event.getPosition()}, Offset: ${event.getPixelOffset()}" );
        event.skip();
      } );

      bindPaintEvent( onPaint );
      bindMotionEvent( onMotion );
      bindEnterWindowEvent( (event) {
        mouseInfo.setLabel('Entered window!');
      });
      bindLeaveWindowEvent( (event) {
        mouseInfo.setLabel('Left window!');
      });
      bindLeftDownEvent( (event) {
        mouseInfo.setLabel("Left mouse down at ${event.getX()},${event.getY()}, Left is down?: ${event.leftIsDown()}");
      });
      bindRightDownEvent( (event) {
        mouseInfo.setLabel("Right mouse down at ${event.getX()},${event.getY()}, Right is down?: ${event.rightIsDown()}");
      });
      bindLeftDClickEvent( (event) {
        mouseInfo.setLabel("Left double click at ${event.getX()},${event.getY()}, Left is down?: ${event.leftIsDown()}");
      });
      bindRightDClickEvent( (event) {
        mouseInfo.setLabel("Right double click at ${event.getX()},${event.getY()}, Right is down?: ${event.rightIsDown()}");
      });
  }

  void onMotion( WxMouseEvent event )
  {
    final pos = calcUnscrolledPosition(event.getPosition());
    
    if (( pos.x > 10) && (pos.y > 50) &&
        ( pos.x < 210) && (pos.y < 250)) {
      setCursor( WxCursor(wxCURSOR_CROSS) );
    } else {
      setCursor( null );
    }
  }

  void onPaint( WxPaintEvent event )
  {
    WxPaintDC dc = WxPaintDC( this );
    doPrepareDC( dc );

    dc.setBrush( wxLIGHT_GREY_BRUSH );
    dc.drawRectangle(10, 50, 200, 200 );
  }
}

// ------------------------- MyAnimationWindow ----------------------

class MyAnimationWindow extends WxWindow {
  MyAnimationWindow( WxWindow parent ) : super( parent, -1, wxDefaultPosition, WxSize( 200, 150), 0 )
  {
      bindPaintEvent( onPaint );

      final startButton = WxButton(this, -1, "Go!", pos: WxPoint(10,80) );
      final animation = WxUIAnimation((value) {
        _animatedNumber = (200 * value).floor();
        refresh();
      }, 3000 );
      startButton.bindButtonEvent( (_) => animation.start(), -1) ;
  }

  int _animatedNumber = 0;

  void onPaint( WxPaintEvent event )
  {
    WxPaintDC dc = WxPaintDC( this );

    dc.setBrush( wxLIGHT_GREY_BRUSH );
    dc.drawCircle(30+_animatedNumber, 30, 20);

    dc.setBrush( WxBrush( WxColour(50+_animatedNumber, 50+_animatedNumber, 255)) );
    dc.drawRectangle(200, 10, 100, 100 );
  }
}

// ------------------------- MyDrawingWindow ----------------------

class MyDrawingWindow extends WxScrolledWindow {
  MyDrawingWindow( WxWindow parent ) : super( parent, -1, style: wxVSCROLL )
  {
    final mainSizer = WxBoxSizer( wxVERTICAL );
    setSizer( mainSizer );

    late WxStaticBoxSizer sbs;
    sbs = WxStaticBoxSizer(wxVERTICAL, this, "Simple lines, no background" );
    mainSizer.addSizer(sbs, flag: wxEXPAND|wxALL, border: 5  );
    sbs.add( MyLinesWindow(sbs.getStaticBox(), 0, false), flag: wxEXPAND|wxALL, border: 5 );

    sbs = WxStaticBoxSizer(wxVERTICAL, this, "Simple lines on yellow background" );
    mainSizer.addSizer(sbs, flag: wxEXPAND|wxALL, border: 5  );
    sbs.add( MyLinesWindow(sbs.getStaticBox(), 0, true), flag: wxEXPAND|wxALL, border: 5 );

    sbs = WxStaticBoxSizer(wxVERTICAL, this, "Simple lines, wxBORDER_SIMPLE" );
    mainSizer.addSizer(sbs, flag: wxEXPAND|wxALL, border: 5 );
    sbs.add( MyLinesWindow(sbs.getStaticBox(), wxSIMPLE_BORDER, true), flag: wxEXPAND|wxALL, border: 5 );

    sbs = WxStaticBoxSizer(wxVERTICAL, this, "WxGraphicsBitmap" );
    mainSizer.addSizer(sbs, flag: wxEXPAND|wxALL, border: 5 );
    sbs.add( MyGraphicsWindow(sbs.getStaticBox(), wxSIMPLE_BORDER, true), flag: wxEXPAND|wxALL, border: 5 );

    sbs = WxStaticBoxSizer(wxVERTICAL, this, "WxGraphicsPath" );
    mainSizer.addSizer(sbs, flag: wxEXPAND|wxALL, border: 5 );
    sbs.add( MyGraphicsPathWindow(sbs.getStaticBox(), wxSIMPLE_BORDER ), flag: wxEXPAND|wxALL, border: 5 );

    sbs = WxStaticBoxSizer(wxVERTICAL, this, "Filled and unfilled shapes" );
    mainSizer.addSizer(sbs, flag: wxEXPAND|wxALL, border: 5 );
    sbs.add( MyShapesWindow(sbs.getStaticBox(), wxSIMPLE_BORDER ), flag: wxEXPAND|wxALL, border: 5 );

    sbs = WxStaticBoxSizer(wxVERTICAL, this, "Fonts" );
    mainSizer.addSizer(sbs, flag: wxEXPAND|wxALL, border: 5 );
    sbs.add( MyFontWindow(sbs.getStaticBox(), wxSIMPLE_BORDER ), flag: wxEXPAND|wxALL, border: 5 );

    sbs = WxStaticBoxSizer(wxVERTICAL, this, "wxImage with alpha channel and Material Icons" );
    mainSizer.addSizer(sbs, flag: wxEXPAND|wxALL, border: 5 );
    sbs.add( MyImageWindow(sbs.getStaticBox(), wxSIMPLE_BORDER ), flag: wxEXPAND|wxALL, border: 5 );

    sbs = WxStaticBoxSizer(wxVERTICAL, this, "WxScrolledWindow using setVirtualSize()" );
    mainSizer.addSizer(sbs, flag: wxEXPAND|wxALL, border: 5 );
    sbs.add( MyScrollAndMouseWindow(sbs.getStaticBox(), true ), flag: /*wxEXPAND|*/wxALL, border: 5 );
    
    sbs = WxStaticBoxSizer(wxVERTICAL, this, "WxScrolledWindow using setScrollbars()" );
    mainSizer.addSizer(sbs, flag: wxEXPAND|wxALL, border: 5 );
    sbs.add( MyScrollAndMouseWindow(sbs.getStaticBox(), false ), flag: /*wxEXPAND|*/wxALL, border: 5 );
    
    sbs = WxStaticBoxSizer(wxVERTICAL, this, "WxUIAnimation" );
    mainSizer.addSizer(sbs, flag: wxEXPAND|wxALL, border: 5 );
    sbs.add( MyAnimationWindow(sbs.getStaticBox() ), flag: wxEXPAND|wxALL, border: 5 );
  }
}
