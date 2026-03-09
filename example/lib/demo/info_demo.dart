
import 'package:wx_dart/wx_dart.dart';

// ------------------------- MyInfoPage ----------------------

class MyInfoPage extends WxScrolledWindow {
  MyInfoPage( WxWindow parent ) : super( parent, -1, style: wxVSCROLL )
  {
    WxBoxSizer sizer = WxBoxSizer( wxVERTICAL );

    
    sizer.add( WxStaticText( this, -1, "About wxDart" )..setFont(WxFont(16,weight:wxFONTWEIGHT_BOLD)), flag: wxALL|wxALIGN_LEFT, border: 10 );

    sizer.add( WxStaticText( this, -1, 
    "Build web apps, mobile apps and native desktop apps from a single source using the Dart programming language.", 
      style: wxST_WRAP), flag: wxLEFT, border: 10 );

    sizer.addSpacer(10);
    sizer.add( WxStaticText( this, -1, "Main benefits" )..setFont(WxFont(16,weight:wxFONTWEIGHT_BOLD)), flag: wxALL|wxALIGN_LEFT, border: 10 );

    sizer.add( WxStaticText( this, -1, "- Dart creates native binaries (and Javascript on the Web)"), flag: wxLEFT, border: 5 );
    sizer.add( WxStaticText( this, -1, "- Native look'n'feel on Windows, macOS and Linux"), flag: wxLEFT, border: 5 );
    sizer.add( WxStaticText( this, -1, "- Alternatively, identical look'n'feel on all platforms"), flag: wxLEFT, border: 5 );
    sizer.add( WxStaticText( this, -1, "- Support for iOS and Android"), flag: wxLEFT, border: 5 );
    sizer.add( WxStaticText( this, -1, "- Desktop Web and mobile Web"), flag: wxLEFT, border: 5 );
    sizer.add( WxStaticText( this, -1, "- Support for light and dark modes"), flag: wxLEFT, border: 5 );
    sizer.add( WxStaticText( this, -1, "- Support for touch and desktop interfaces"), flag: wxLEFT, border: 5 );
  
    sizer.addSpacer(10);
    sizer.add( WxStaticText( this, -1, "Current stage" )..setFont(WxFont(16,weight:wxFONTWEIGHT_BOLD)), flag: wxALL|wxALIGN_LEFT, border: 10 );
    sizer.add( WxStaticText( this, -1, 
      "wxDart is currently in the stage of tech preview. This app has been written using wxDart."
     , style: wxST_WRAP ), flag: wxALL, border: 10 );


      // this assumes we are installed on the final machine
      String assetPath = wxGetStandardPaths().getResourcesDir( useLocalDirOnLinuxAndWindows: true );

      // Add forward or backward slash
      if (wxIsMSW() && !wxUsesFlutter()) {
        assetPath += "\\";
      } else {
        assetPath += "/";
      }

    sizer.add( WxStaticText(this, -1, 'Read more...'), flag: wxALL, border: 5 );

    final flex = WxFlexGridSizer( 2, vgap: 5, hgap: 5);
    sizer.addSizer( flex, flag: wxALIGN_CENTRE_HORIZONTAL ); 

    String path = "${assetPath}wxWidgets.png";
    flex.add( WxStaticBitmap(this, -1, WxBitmapBundle.fromPNGAsset( path)), flag: wxALIGN_CENTER_VERTICAL|wxALL, border: 5 );

    path = "${assetPath}flutter.svg";
    flex.add( WxStaticBitmap(this, -1, WxBitmapBundle.fromSVGAsset( path, WxSize(48, 48))), flag: wxALIGN_CENTER_VERTICAL|wxALL, border: 5 );

    final hl = WxHyperlinkCtrl(this, -1, 'http://wxwidgets.org', 'http://wxwidgets.org');
    flex.add( hl, flag: wxALL, border: 5 );

    flex.add( WxHyperlinkCtrl(this, -1, 'http://flutter.dev', 'http://flutter.dev'), flag: wxALL, border: 5 );

    hl.bindHyperlinkEvent((event){
      WxWindow parent = getParent()!;
      parent = parent.getParent()!;
      if (parent is WxFrame) {
        wxLogStatus( parent, "You clicked on the best!" );
      }
      event.skip();
    }, -1);


    setSizer( sizer ); 
  }

  int counter = 0;
}

