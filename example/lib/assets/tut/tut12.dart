
import 'package:wx_dart/wx_dart.dart';
import 'dart:math';

const idAbout = 100;

// Derive new class from WxScrolledWindow
class MyWindow extends WxScrolledWindow {
  MyWindow( super.parent, super.id )
  {
    // Create scroll area of 800x400 pixel
    setScrollbars(10, 10, 80, 40 );

    // Bind to paint event
    bindPaintEvent(onPaint);
  }

  double radius1 = 0.0;
  double radius2 = 0.0;
  double radius3 = 0.0;
  int seed = 40000;

  void drawFirework(WxDC dc, int cx, int cy, double radius, WxColour color) {
    dc.setPen(WxPen(color, width: 2));
    const int rays = 24;
        for (int i = 0; i < rays; i++) {
            double a = (pi * 2.0 / rays) * i;
            int x2 = (cx + cos(a) * radius).floor();
            int y2 = (cy + sin(a) * radius).floor();
            dc.drawLine(cx, cy, x2, y2);
        }
    }

  void onPaint(WxPaintEvent event)
  {
    // create dc    
    final dc = WxPaintDC(this);
    
    // adjust for scrolling
    doPrepareDC(dc);

        // fill out entire window
        final w = getVirtualSize().x;
        final h = getVirtualSize().y;

        // Draw Brooklyn Bridge in the night        
        int towerWidth  = (w * 0.05).floor();
        int towerHeight = (h * 0.6).floor();
        int baseY       = (h * 0.8).floor();
        int topY        = baseY - towerHeight;
        int leftX  = (w * 0.25).floor();
        int rightX = (w * 0.75).floor();
 
        dc.setBrush(WxBrush(WxColour(10, 10, 30)));
        dc.setPen(wxTRANSPARENT_PEN);
        dc.drawRectangle(0, 0, w, h);

        dc.setPen(WxPen(WxColour(255, 255, 255), width: 2));
        for (int i = 0; i < 80; i++) {
            dc.drawPoint(seed % w, seed % (h ~/2));
        }

        drawFirework(dc, (w * 0.35).floor(), (h * 0.15).floor(), 60*radius1, WxColour(255, 180, 80));
        drawFirework(dc, (w * 0.55).floor(), (h * 0.10).floor(), 40*radius2, WxColour(80, 200, 255));
        drawFirework(dc, (w * 0.75).floor(), (h * 0.18).floor(), 50*radius3, WxColour(255, 90, 170));

        dc.setBrush(WxBrush(WxColour(60, 60, 90)));
        dc.setPen(WxPen(WxColour(200, 200, 220), width: 2));
        dc.drawRectangle(leftX - towerWidth~/2,  topY, towerWidth, towerHeight);
        dc.drawRectangle(rightX - towerWidth~/2, topY, towerWidth, towerHeight);
 
        dc.setBrush(WxBrush(WxColour(255, 220, 120)));
        dc.setPen(wxTRANSPARENT_PEN);

        for (int i = 0; i < 6; i++) {
            int y = topY + (i+1)*(towerHeight~/7);
            dc.drawRectangle(leftX  - 8, y, 5, 8);
            dc.drawRectangle(rightX - 8, y, 5, 8);
        }

        dc.setPen(WxPen(WxColour(40, 40, 40), width: 4));
        dc.setBrush(WxBrush(WxColour(50, 50, 60)));
        dc.drawRectangle(0, baseY, w, h - baseY);

        dc.setBrush(WxBrush(WxColour(255, 200, 100)));
        for (int x = 0; x < w; x += 80) {
            dc.drawCircle(x, baseY - 4, 3);
        }

        // Main cables
        dc.setBrush(wxTRANSPARENT_BRUSH);
        dc.setPen(WxPen(WxColour(180, 180, 200), width: 2));
        dc.drawEllipticArc(-leftX, topY-towerHeight, 2*leftX, 2*towerHeight, 270, 360);
        dc.drawEllipticArc(rightX, topY-towerHeight, 2*leftX, 2*towerHeight, 180, 270);
        dc.drawLine( leftX, topY, rightX, topY );

        // Hanging cables
        dc.setPen(WxPen(WxColour(160, 160, 180) ));
        for (int x = leftX; x <= rightX; x += 18) {
            dc.drawLine(x, topY + 10, x, baseY);
        }

        int waterTop = baseY + 20;
        dc.setBrush(WxBrush(WxColour(15, 20, 40)));
        dc.setPen(wxTRANSPARENT_PEN);
        dc.drawRectangle(0, waterTop, w, h - waterTop);

        dc.setPen(WxPen(WxColour(255, 200, 100) ));
        for (int x = 0; x < w; x += 80) {
            for (int dy = 0; dy < 50; dy += 5) {
                int y = waterTop + dy;
                int length = 8 - dy ~/ 10;
                dc.drawLine(x - length, y, x + length, y);
            }
        }

        dc.setPen(WxPen(WxColour(80, 80, 110), width: 2));
        for (int dy = 0; dy < 70; dy += 4) {
            dc.drawLine(leftX - towerWidth~/2,  baseY + dy,
                        leftX + towerWidth~/2,  baseY + dy);
            dc.drawLine(rightX - towerWidth~/2, baseY + dy,
                        rightX + towerWidth~/2, baseY + dy);

        }
  }
}

class MyFrame extends WxAdaptiveFrame {
  MyFrame( WxFrame? parent) : super( parent, -1, "Scrolling", size: WxSize(900, 700) ) 
  {
    // Create a Touch and a Desktop interface.
    // wxApp.isTouch() decides which one to show.
    // Experimental, but very cool.

    // Touch interface

      // AppBar, similar to a toolbar
      final appBar = createAppBar("Scrolling");
      // add "Fireworks" action with text button
      appBar.addAction( idAbout, "Fireworks!" );
      // add action with text button
      appBar.addAction( wxID_EXIT, "Quit" );

    // Desktop interface

      // Create a menu bar. This might be at the
      // top of the screen on a Mac.
      final menubar = WxMenuBar();

      // Create a menu 
      final filemenu = WxMenu();
      // Create a menu item with short cuts
      // and help text
      filemenu.appendItem( idAbout, "Fireworks\tAlt-A", help: "Start the fireworks!" );
      filemenu.appendSeparator();
      filemenu.appendItem( wxID_EXIT, "Quit app\tCtrl-Q", help: "Run, baby, run!" );
      // Attach menu to menu bar
      menubar.append(filemenu, "File");

      // Attach menu bar to this frame
      setMenuBar(menubar);

    // Insert one single window into the client area
    // of the frame. That way, the frame will always 
    // resize this window to fill out the entire client
    // area.  
    final firewindow = MyWindow( this, -1 );

    createStatusBar();
    setStatusText( "Start the fireworks" );

    bindMenuEvent((_) {
      final anim = WxUIAnimation( (value) {
        value *= 5;
        firewindow.radius1 = (value-0.5).clamp(0,1);
        firewindow.radius2 = (value-1.5).clamp(0,1);
        firewindow.radius3 = (value-2.5).clamp(0,1);
        if (firewindow.radius1 > 0.99) firewindow.radius1 = 0.0;
        if (firewindow.radius2 > 0.99) firewindow.radius2 = 0.0;
        if (firewindow.radius3 > 0.99) firewindow.radius3 = 0.0;
        firewindow.seed = Random().nextInt(10000);
        firewindow.refresh();
      }, 5000 );
      anim.start();

    }, idAbout );

    bindMenuEvent( (_) => close(false), wxID_EXIT );
    bindCloseWindowEvent( (event) =>  destroy() );
  }
}

class MyApp extends WxApp {
  MyApp();
  
  @override
  bool onInit() {
    WxFrame myFrame = MyFrame( null );
    myFrame.show();
    return true;
  }
}

// The main function creating, running and
// deleting the app
/*void main()
{
  final myApp = MyApp();
  myApp.run();
  myApp.dispose();
}*/
