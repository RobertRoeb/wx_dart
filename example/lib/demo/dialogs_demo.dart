
import 'package:wx_dart/wx_dart.dart';

// ------------------------- MyTestDialog -----------------------------

class MyTestDialog extends WxDialog
{
  MyTestDialog( WxWindow parent ) : super( parent, -1, "Hello", size: WxSize(800,600) )
  {
    final mainSizer = WxColumn();
    setSizer( mainSizer );

    mainSizer.add( WxTextCtrl(this, -1, style: wxTE_MULTILINE), border: 5, proportion: 1, 
      flag: WxSizerFlags.borderAll( halign: WxHAlignment.expand) );

    mainSizer.add( WxButton(this, -1, "OK"), border: 5, 
      flag: WxSizerFlags.borderAll( halign: WxHAlignment.right) );

  }
}

// ------------------------- MyMessageDialog -----------------------------

class MyMessageDialog extends WxMessageDialog {
  MyMessageDialog( WxWindow parent ) : super ( parent, "Information message here", style: wxOK|wxICON_INFORMATION, caption: "Info" )
  {

    setExtendedMessage("This is a very long message that will\n"
                    "span across several lines\n"
                    "Many lines.\n"
                    "wxGetStandardPaths().getExecutablePath()\n"
                    "${wxGetStandardPaths().getExecutablePath()}\n"
                    "wxGetStandardPaths().getResourcesDir()\n"
                    "${wxGetStandardPaths().getResourcesDir()}\n"
                    "wxGetStandardPaths().getDocumentsDir()\n"
                    "${wxGetStandardPaths().getDocumentsDir()}\n"
                    "wxGetStandardPaths().getConfigDir()\n"
                    "${wxGetStandardPaths().getConfigDir()}\n"
                    "wxGetStandardPaths().getTempDir()\n"
                    "${wxGetStandardPaths().getTempDir()}");
} }

// ------------------------- MyFirstDialog -----------------------------

class MyDialogData {
  String text = "This the text";
}

class MyFirstDialog extends WxDialog
{
  MyFirstDialog( WxWindow parent, this._data ) : super( parent, -1, "Hello", size: WxSize(800,600) )
  {
    final mainSizer = WxBoxSizer( wxVERTICAL );
    setSizer( mainSizer );

    final notebook = WxNotebook( this, -1 );

    mainSizer.add( notebook, proportion: 1, flag: wxEXPAND|wxALL, border: 5 );

    mainSizer.add( WxStaticLine( this, -1 ), flag: wxEXPAND|wxALL, border: 5 );

    // Page1 without any sizer, just a single control
    final page1 = WxPanel( notebook, -1 );
    notebook.addPage(page1, "wxWidgets book" );

    String assetPath = wxGetStandardPaths().getResourcesDir( useLocalDirOnLinuxAndWindows: true );

      // Add forward backwars slash
      if (wxIsMSW() && !wxUsesFlutter()) {
        assetPath += "\\Splash.jpg";
      } else {
        assetPath += "/Splash.jpg";
      }
    final bundle = WxBitmapBundle.fromJPEGAsset(assetPath);

    final imageSizer = WxBoxSizer( wxTheApp.isTouch() ? wxVERTICAL : wxHORIZONTAL );
    if (wxTheApp.isTouch()) {
      imageSizer.add( WxStaticBitmap(page1, -1, bundle, size: WxSize(180,230) ), flag: wxALL|wxALIGN_CENTER_HORIZONTAL, border: 10 );
    } else {
      imageSizer.add( WxStaticBitmap(page1, -1, bundle ), flag: wxALL|wxALIGN_CENTER_VERTICAL, border: 10 );
    }

    final flex = WxFlexGridSizer( wxTheApp.isTouch() ? 2 : 4, vgap: 15, hgap: 5);

    if (wxTheApp.isTouch())
    {
      flex.add( WxStaticText( page1, -1, "scaleNone"), flag: wxALIGN_CENTER_HORIZONTAL );
      flex.add( WxStaticText( page1, -1, "scaleFill"), flag: wxALIGN_CENTER_HORIZONTAL );
      flex.add( WxStaticBitmap(page1, -1, bundle, size: WxSize(80,80) ), flag: wxALIGN_CENTER_HORIZONTAL );
      final bitmap1 = WxStaticBitmap(page1, -1, bundle, size: WxSize(80,80) );
      bitmap1.setScaleMode(scaleFill);
      flex.add( bitmap1, flag: wxALIGN_CENTER_HORIZONTAL );
      flex.add( WxStaticText( page1, -1, "scaleAspectFit"), flag: wxALIGN_CENTER_HORIZONTAL );
      flex.add( WxStaticText( page1, -1, "scaleAspectFill"), flag: wxALIGN_CENTER_HORIZONTAL );
      final bitmap2 = WxStaticBitmap(page1, -1, bundle, size: WxSize(80,80) );
      bitmap2.setScaleMode(scaleAspectFit);
      flex.add( bitmap2, flag: wxALIGN_CENTER_HORIZONTAL );
      final bitmap3 = WxStaticBitmap(page1, -1, bundle, size: WxSize(80,80) );
      bitmap3.setScaleMode(scaleAspectFill);
      flex.add( bitmap3, flag: wxALIGN_CENTER_HORIZONTAL );
    }
    else
    {
      flex.add( WxStaticText( page1, -1, "scaleNone") );
      flex.add( WxStaticText( page1, -1, "scaleFill") );
      flex.add( WxStaticText( page1, -1, "scaleAspectFit") );
      flex.add( WxStaticText( page1, -1, "scaleAspectFill") );
      flex.add( WxStaticBitmap(page1, -1, bundle, size: WxSize(80,80) ) );
      final bitmap1 = WxStaticBitmap(page1, -1, bundle, size: WxSize(80,80) );
      bitmap1.setScaleMode(scaleFill);
      flex.add( bitmap1 );
      final bitmap2 = WxStaticBitmap(page1, -1, bundle, size: WxSize(80,80) );
      bitmap2.setScaleMode(scaleAspectFit);
      flex.add( bitmap2 );
      final bitmap3 = WxStaticBitmap(page1, -1, bundle, size: WxSize(80,80) );
      bitmap3.setScaleMode(scaleAspectFill);
      flex.add( bitmap3 );
    }

    imageSizer.addSizer( flex, flag: wxALIGN_CENTER_VERTICAL, proportion: 1 );
    page1.setSizer(imageSizer);

    // Page2 with sizers

    _page2 = WxPanel( notebook, -1 );
    notebook.addPage(_page2, "Test page" );
    final pageTwoSizer = WxBoxSizer( wxVERTICAL );

    final topSizer = WxBoxSizer( wxVERTICAL );
    topSizer.add( WxStaticText( _page2, -1, 
      'The text controls below test a number of things, e.g. intercepting ENTER, validating input and transfering '
      'data from and to the dialog.',
      style: wxST_WRAP ), flag: wxALL, border: 5);
    _sizerItem = pageTwoSizer.addSizer( topSizer, flag: wxALL, border: 10); 

    final midSizer = WxStaticBoxSizer( wxVERTICAL, _page2, 'Mid' );

    final flexSizer = WxFlexGridSizer(2);

    final text1 = WxTextCtrl( midSizer.getStaticBox(), -1, size: WxSize(350,-1) );
    // row #1
    flexSizer.add( WxStaticText(midSizer.getStaticBox(), -1, "ENTER will try to close the dialog:" ), flag: wxALIGN_CENTER_VERTICAL|wxALIGN_RIGHT );
    text1.setHint( "Hit <ENTER>" );
    flexSizer.add( text1, flag: wxALL, border: 10 );
    // row #2
    flexSizer.add( WxStaticText(midSizer.getStaticBox(), -1, "ENTER intercepted, won't close:" ), flag: wxALIGN_CENTER_VERTICAL|wxALIGN_RIGHT );
    final text2 = WxTextCtrl( midSizer.getStaticBox(), -1, style: wxTE_PROCESS_ENTER, size: WxSize(350,-1) );
    text2.setHint( "Hit <ENTER>" );
    flexSizer.add( text2, flag: wxALL, border: 10 );
    // row #3
    flexSizer.add( WxStaticText(midSizer.getStaticBox(), -1, "No more than 17 characters allowed:" ), flag: wxALIGN_CENTER_VERTICAL|wxALIGN_RIGHT );
    final text3 = WxTextCtrl( midSizer.getStaticBox(), -1, value: "Max 17 characters", size: WxSize(350,-1) );
    flexSizer.add( text3, flag: wxALL, border: 10 );
    // row #4
    flexSizer.add( WxStaticText(midSizer.getStaticBox(), -1, "Text will be remembered next time:" ), flag: wxALIGN_CENTER_VERTICAL|wxALIGN_RIGHT );
    final text4 = WxTextCtrl( midSizer.getStaticBox(), -1, size: WxSize(350,-1) );
    flexSizer.add( text4, flag: wxALL, border: 10 );

    midSizer.addSizer(flexSizer, flag: wxEXPAND );
    pageTwoSizer.addSizer( midSizer, flag: wxALL|wxEXPAND, border: 10); 

    _page2.setSizer( pageTwoSizer );

    final buttonSizer = createStdDialogButtonSizer(wxOK|wxCANCEL);
    final setNotebookSelectionButton = WxButton( this, -1, "Go to #0");
    setNotebookSelectionButton.bindButtonEvent( (_) {
      notebook.setSelection(0);
    }, -1);
    buttonSizer.insert(0, setNotebookSelectionButton, flag: wxRIGHT, border: 10 );
    mainSizer.addSizer(buttonSizer, flag: wxALL|wxALIGN_RIGHT, border: 10);

    notebook.bindNotebookPageChangedEvent((event) {
      // print( "Changed from ${event.getOldSelection()} to ${event.getSelection()}" );
    },-1);


    bindInitDialogEvent( (_) {
        text4.setValue( _data.text );
    });

    bindDialogValidateEvent( (event) {
      final str = text3.getValue();
      if (str.length > 17) {
        final dialog = WxMessageDialog(this, "Too many characters", caption: "wxDart" );
        dialog.showModal( null );
        event.veto();
        return;
      }
      _data.text = text4.getValue();
    }, -1); 

    text2.bindTextEnterEvent((_) {
      wxLogStatus(parent as WxFrame, "Intercepted <ENTER>" );
    }, -1);

    // _page2.bindPaintEvent(onPaint);
  }

  void onPaint( WxPaintEvent event ) {
    final dc = WxPaintDC(_page2);
    dc.setPen( wxRED_PEN );
    dc.setBrush( wxTRANSPARENT_BRUSH );
    dc.drawRectangleRect( WxRect.fromPositionAndSize(_sizerItem.getPosition(), _sizerItem.getSize()));
  }

  late WxSizerItem _sizerItem;
  late WxPanel _page2;
  final MyDialogData _data;
}
