
import 'package:wx_dart/wx_dart.dart';


class MyFocussableWindow extends WxWindow {
  MyFocussableWindow( WxWindow parent, WxSize size ) : super( parent, -1, wxDefaultPosition, size, 0)
  {  
    bindKillFocusEvent((_)=>refresh() );
    bindSetFocusEvent((_)=>refresh() );

    bindPaintEvent( (_) {
      final dc = WxPaintDC( this );
      dc.setBrush( wxWHITE_BRUSH );
      if (hasFocus()) {
        dc.setPen(wxBLACK_PEN);
        dc.drawRectangle(0, 0, getSize().x, getSize().y );
        dc.drawText("Has focus", 5, 5 );
      } else {
        dc.setPen(wxTRANSPARENT_PEN);
        dc.drawRectangle(0, 0, getSize().x, getSize().y );
        dc.drawText("No focus", 5, 5 );
      }
    });
  }
}

class MyNonFocussableWindow extends WxWindow {
  MyNonFocussableWindow( WxWindow parent, WxSize size ) : super( parent, -1, wxDefaultPosition, size, 0)
  {
    setCanFocus(false);

    bindKillFocusEvent((_)=>refresh() );
    bindSetFocusEvent((_)=>refresh() );

    bindPaintEvent( (_) {
      final dc = WxPaintDC( this );
      dc.setBrush( wxWHITE_BRUSH );
      if (hasFocus()) {
        dc.setPen(wxBLACK_PEN);
        dc.drawRectangle(0, 0, getSize().x, getSize().y );
        dc.drawText("Has focus, wrong!", 5, 5 );
      } else {
        dc.setPen(wxTRANSPARENT_PEN);
        dc.drawRectangle(0, 0, getSize().x, getSize().y );
        dc.drawText("Cannot get focus", 5, 5 );
      }
    });
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

    topSizer.add( WxTextCtrl(topPanel, -1, size: WxSize(150,-1) ), flag: wxALL, border: 10 );
    topSizer.add( WxStaticText(topPanel, -1, "WxStaticText 1"), flag: wxALL, border: 10 );
    topSizer.add( MyFocussableWindow(topPanel, WxSize(150,40)), flag: wxALL, border: 10 );
    topSizer.add( WxStaticText(topPanel, -1, "WxStaticText 2"), flag: wxALL, border: 10 );
    topSizer.add( MyNonFocussableWindow(topPanel, WxSize(150,40)), flag: wxALL, border: 10 );
    topSizer.add( WxStaticText(topPanel, -1, "WxStaticText 4"), flag: wxALL, border: 10 );
    topSizer.add( MyFocussableWindow(topPanel, WxSize(150,40)), flag: wxALL, border: 10 );
    topSizer.add( WxStaticText(topPanel, -1, "WxStaticText 6"), flag: wxALL, border: 10 );
    topSizer.add( WxTextCtrl(topPanel, -1, size: WxSize(150,-1) ), flag: wxALL, border: 10 );

    final bottomPanel = WxPanel(this, -1);
    bottomPanel.setBackgroundColour(wxYELLOW);
    mainSizer.add( bottomPanel, flag: wxEXPAND, proportion: 1 ); 

    final bottomSizer = WxFlexGridSizer(2);
    bottomPanel.setSizer(bottomSizer);

    bottomSizer.add( WxTextCtrl(bottomPanel, -1, size: WxSize(150,-1) ), flag: wxALL, border: 10 );
    bottomSizer.add( WxStaticText(bottomPanel, -1, "WxStaticText 1"), flag: wxALL, border: 10 );
    bottomSizer.add( MyFocussableWindow(bottomPanel, WxSize(150,40)), flag: wxALL, border: 10 );
    bottomSizer.add( WxStaticText(bottomPanel, -1, "WxStaticText 2"), flag: wxALL, border: 10 );
    bottomSizer.add( MyNonFocussableWindow(bottomPanel, WxSize(150,40)), flag: wxALL, border: 10 );
    bottomSizer.add( WxStaticText(bottomPanel, -1, "WxStaticText 4"), flag: wxALL, border: 10 );
    bottomSizer.add( MyFocussableWindow(bottomPanel, WxSize(150,40)), flag: wxALL, border: 10 );
    bottomSizer.add( WxStaticText(bottomPanel, -1, "WxStaticText 6"), flag: wxALL, border: 10 );
    bottomSizer.add( WxTextCtrl(bottomPanel, -1, size: WxSize(150,-1) ), flag: wxALL, border: 10 );

  }

}
