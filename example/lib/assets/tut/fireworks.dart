
import 'package:wx_dart/wx_dart.dart';
import 'dart:math';

const int idFire = 100;
const int idAbout = 101;

// Derive new class from WxWindow
class MyFireworksWindow extends WxWindow {
  MyFireworksWindow( WxWindow parent, int id ): super( parent, id, wxDefaultPosition, wxDefaultSize, 0)
  {
    myFont = WxFont( 24, weight: wxFONTWEIGHT_BOLD );

    // Bind to paint event
    bindPaintEvent(onPaint);
  }

  double radius1 = 0.0;
  double radius2 = 0.0;
  double radius3 = 0.0;
  double radius4 = 0.0;
  double radius5 = 0.0;
  double radius6 = 0.0;
  double radius7 = 0.0;
  double radius8 = 0.0;
  double radius9 = 0.0;
  double radius10 = 0.0;
  int seed = 40000;
  double timeSinceStart = 0.0;
  late WxFont myFont; 

  void drawFirework(WxDC dc, int cx, int cy, double radius, WxColour color)
  {
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
    final dc = WxPaintDC(this);
    
    final w = getClientSize().x;
    final h = getClientSize().y;
        
    int towerWidth  = (w * 0.05).floor();
    int towerHeight = (h * 0.6).floor();
    int baseY       = (h * 0.8).floor();
    int topY        = baseY - towerHeight;
    int leftX  = (w * 0.25).floor();
    int rightX = (w * 0.75).floor();
 
    dc.setBrush(WxBrush(WxColour(10, 10, 30)));
    dc.setPen(wxTRANSPARENT_PEN);
    dc.drawRectangle(0, 0, w, h);
    int diffY = (w < 600) ? 40 : 0;

    dc.setTextForeground( WxColour(255, 200, 100) );
    dc.setFont( myFont );
    if ((timeSinceStart > 0) && (timeSinceStart < 10.0)) {
      final start = timeSinceStart;
      dc.drawText("wxWidgets", 10 + (start*w/10).floor(), baseY - 50 );
    }
    if ((timeSinceStart > 3.0) && (timeSinceStart < 13.0)) {
      final start = timeSinceStart-3;
      dc.drawText("wxPython", 10 + (start*w/10).floor(), baseY - 50 - diffY );
    }
    if ((timeSinceStart > 6.0) && (timeSinceStart < 16.0)) {
      final start = timeSinceStart-6;
      dc.drawText("wxRuby", 10 + (start*w/10).floor(), baseY - 50 );
    }
    if ((timeSinceStart > 9.0) && (timeSinceStart < 19.0)) {
      final start = timeSinceStart-9;
      dc.drawText("wxPerl", 10 + (start*w/10).floor(), baseY - 50 - diffY );
    }
    if ((timeSinceStart > 12.0) && (timeSinceStart < 22.0)) {
      final start = timeSinceStart-12;
      dc.drawText("wxDragon", 10 + (start*w/10).floor(), baseY - 50 );
    }
    if ((timeSinceStart > 14.6) && (timeSinceStart < 25.0)) {
      final start = timeSinceStart-14.6;
      dc.drawText("wxDart", 10 + (start*w/10).floor(), baseY - 50 - diffY );
    }

    // Stars
    dc.setPen(WxPen(WxColour(255, 255, 255), width: 2));
    for (int i = 0; i < 80; i++) {
      dc.drawPoint(seed % w, seed % (h ~/2));
    }

    // Hanging cables
    dc.setPen(WxPen(WxColour(160, 160, 180) ));
    for (int x = 0; x <= w; x += w ~/30) {
      dc.drawLine(x, topY + 10, x, baseY);
    }

    // Main cables
    dc.setBrush(WxBrush(WxColour(10, 10, 30)));
    dc.setPen(WxPen(WxColour(180, 180, 200), width: 2));
    dc.drawEllipticArc(-leftX+towerWidth~/4, topY-towerHeight, 2*leftX-towerWidth~/2, 2*towerHeight, 270, 360);
    dc.drawEllipticArc(rightX, topY-towerHeight, 2*leftX, 2*towerHeight, 180, 270);
    dc.drawEllipticArc(w~/2 - w~/2, topY-w+(w~/10), w, w, 240, 300 ); 

    // Firework animations
        drawFirework(dc, (w * 0.35).floor(), (h * 0.15).floor(), 60*radius1, WxColour(255, 180, 80));
        drawFirework(dc, (w * 0.55).floor(), (h * 0.10).floor(), 40*radius2, WxColour(80, 200, 255));
        drawFirework(dc, (w * 0.75).floor(), (h * 0.18).floor(), 50*radius3, WxColour(255, 90, 170));
        drawFirework(dc, (w * 0.45).floor(), (h * 0.12).floor(), 50*radius4, WxColour(215, 120, 170));
        drawFirework(dc, (w * 0.65).floor(), (h * 0.14).floor(), 70*radius5, WxColour(255, 200, 170));
        drawFirework(dc, (w * 0.45).floor(), (h * 0.10).floor(), 40*radius6, WxColour(80, 220, 170));
        drawFirework(dc, (w * 0.65).floor(), (h * 0.14).floor(), 50*radius7, WxColour(255, 200, 170));
        drawFirework(dc, (w * 0.25).floor(), (h * 0.24).floor(), 50*radius8, WxColour(255, 200, 170));
        drawFirework(dc, (w * 0.40).floor(), (h * 0.30).floor(), 50*radius9, WxColour(85, 100, 255));
        drawFirework(dc, (w * 0.60).floor(), (h * 0.18).floor(), 50*radius10, WxColour(255, 200, 170));

    // Main bridge
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

class MyFireworksFrame extends WxAdaptiveFrame {
  MyFireworksFrame( WxFrame? parent) : super( parent, -1, "Fireworks!", size: WxSize(900, 700) ) 
  {
    // AppBar, similar to a toolbar
    final appBar = createAppBar("wxDart demo");

    // Add "Fireworks" action with text button
    appBar.addAction( idFire, "Start Fireworks!" );

    // add action with text button
    appBar.addAction( idAbout, "About" );

    // add floating action button
    final button = createFloatingActionButton("Fire!", idFire, WxBitmapBundle.fromMaterialIcon( WxMaterialIcon.fireplace, WxSize(32, 32)) );
    button.setBackgroundColour(wxWHITE);

    // Insert one single window into the client area
    // of the frame. That way, the frame will always 
    // resize this window to fill out the entire client
    // area.  
    firewindow = MyFireworksWindow( this, -1 );

    // bind to menu entries
    bindMenuEvent((_) => startFirework(), idFire );
    bindMenuEvent((_) => showMessage(), idAbout );
    bindButtonEvent((_) => startFirework(), idFire );

    // Close window and app
    bindMenuEvent( (_) => close(false), wxID_EXIT );
    bindCloseWindowEvent( (event) =>  destroy() );
  }

  late MyFireworksWindow firewindow;

  void showMessage()
  {
    final msg = WxMessageDialog(this, "This is a web app written with wxDart", caption: "About wxDart" );
    msg.setExtendedMessage( "Welcome!" );
    msg.showModal(null);
  }

  void startFirework()
  {
      // animation for 30 sec
      final anim = WxUIAnimation( (bigvalue)
      {
        double value = bigvalue * 20;
        firewindow.radius1 = (value-0.5).clamp(0,1);
        firewindow.radius2 = (value-2.5).clamp(0,1);
        firewindow.radius3 = (value-4.5).clamp(0,1);
        firewindow.radius4 = (value-7).clamp(0,1);
        firewindow.radius5 = (value-8).clamp(0,1.3);
        firewindow.radius6 = (value-9).clamp(0,1.1);
        firewindow.radius7 = (value-10).clamp(0,1.1);
        firewindow.radius8 = (value-11.5).clamp(0,1.3);
        firewindow.radius9 = (value-11.5).clamp(0,0.8);
        firewindow.radius10 = (value-12.5).clamp(0,1.5);
        if (firewindow.radius1 > 0.99) firewindow.radius1 = 0.0;
        if (firewindow.radius2 > 0.99) firewindow.radius2 = 0.0;
        if (firewindow.radius3 > 0.99) firewindow.radius3 = 0.0;
        if (firewindow.radius4 > 0.99) firewindow.radius4 = 0.0;
        if (firewindow.radius5 > 1.2) firewindow.radius5 = 0.0;
        if (firewindow.radius6 > 1.08) firewindow.radius6 = 0.0;
        if (firewindow.radius7 > 1.08) firewindow.radius7 = 0.0;
        if (firewindow.radius8 > 1.26) firewindow.radius8 = 0.0;
        if (firewindow.radius9 > 0.78) firewindow.radius9 = 0.0;
        if (firewindow.radius10 > 1.46) firewindow.radius10 = 0.0;
        firewindow.seed = Random().nextInt(10000);
        firewindow.refresh();
        firewindow.timeSinceStart = bigvalue * 30;
      }, 30000 );

      // start animation
      anim.start();
  }
}

class MyApp extends WxApp {

  @override
  bool onInit()
  {
    setAppName( "fireworks" );
    setAppDisplayName( "wxDart Demo" );
    final frame = MyFireworksFrame(null);
    frame.show();
    return true;
  }

  // always use touch interface, also on big screens
  @override
  bool isTouch() { return true; }
}

void main()
{
  final myApp = MyApp();
  myApp.run();
  myApp.dispose();
}
