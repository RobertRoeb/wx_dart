
import 'package:wx_dart/wx_dart.dart';

class MyControlsWindow extends WxScrolledWindow {
  MyControlsWindow( WxWindow parent ) : super( parent, -1, style: wxVSCROLL )
  {
    final mainSizer = WxBoxSizer( wxVERTICAL );
    setSizer( mainSizer );

    late WxStaticBoxSizer sbs;

    mainSizer.add( WxStaticText(this, -1, "The boxes below show various controls", style: wxST_WRAP), 
        flag: wxALL|wxALIGN_CENTER_HORIZONTAL, border: 10 );


    sbs = WxStaticBoxSizer(wxVERTICAL, this, "WxStaticText" );
    mainSizer.addSizer( sbs, flag: wxEXPAND|wxALL, border: 10 );
    createBoxSizerPage( sbs, sbs.getStaticBox() );

    sbs = WxStaticBoxSizer(wxVERTICAL, this, "WxStaticText with wxST_WRAP" );
    mainSizer.addSizer( sbs, flag: wxEXPAND|wxALL, border: 10 );
    createWrapSizerPage( sbs, sbs.getStaticBox() );

    sbs = WxStaticBoxSizer(wxVERTICAL, this, "WxRadioButton" );
    mainSizer.addSizer( sbs, flag: wxEXPAND|wxALL, border: 10 );
    createRadioButtonPage( sbs, sbs.getStaticBox() );

    sbs = WxStaticBoxSizer(wxVERTICAL, this, "WxCheckBox" );
    mainSizer.addSizer( sbs, flag: wxEXPAND|wxALL, border: 10 );
    createCheckBoxPage( sbs, sbs.getStaticBox() );

    sbs = WxStaticBoxSizer(wxVERTICAL, this, "WxStaticImage and WxAnimationCtrl" );
    mainSizer.addSizer( sbs, flag: wxEXPAND|wxALL, border: 10 );
    createImagePage( sbs, sbs.getStaticBox() );

    sbs = WxStaticBoxSizer(wxVERTICAL, this, "WxSpinCtrl and WxSpinCtrlDouble" );
    mainSizer.addSizer( sbs, flag: wxEXPAND|wxALL, border: 10 );
    createSpinCtrlPage(sbs, sbs.getStaticBox() );

    sbs = WxStaticBoxSizer(wxVERTICAL, this, "WxSlider and WxGauge" );
    mainSizer.addSizer( sbs, flag: wxEXPAND|wxALL, border: 10 );
    createSliderPage(sbs, sbs.getStaticBox() );

    sbs = WxStaticBoxSizer(wxVERTICAL, this, "WxChoice" );
    mainSizer.addSizer( sbs, flag: wxEXPAND|wxALL, border: 10 );
    createChoicePage(sbs, sbs.getStaticBox() );

    sbs = WxStaticBoxSizer(wxVERTICAL, this, "WxComboBox" );
    mainSizer.addSizer( sbs, flag: wxEXPAND|wxALL, border: 10 );
    createComboBoxPage(sbs, sbs.getStaticBox() );

    sbs = WxStaticBoxSizer(wxVERTICAL, this, "WxListBox" );
    mainSizer.addSizer( sbs, flag: wxEXPAND|wxALL, border: 10 );
    createListBoxPage(sbs, sbs.getStaticBox() );
  }

  void createListBoxPage( WxStaticBoxSizer sizer, WxWindow parent )
  {
    final choice = WxListBox( parent, -1, choices: ['Choice #1','Choice #2','Choice #3'], 
      size: WxSize( 200, wxTheApp.isTouch() ? 120 : 80) );
    sizer.add( choice, flag: wxALL, border: 5 );

    const idSelectTwo = 100;
    const idAppend = 101;
    const idInsert = 102;
    const idDelete = 103;

    final wrap = WxWrapSizer();
    sizer.addSizer(wrap);

    final log = WxTextCtrl(parent, -1, size: WxSize(80, 80), style: wxTE_MULTILINE );
    sizer.add( log, flag: wxEXPAND|wxALL, border: 5 );

    wrap.add( WxButton(parent, idSelectTwo, "Select #2"), flag: wxALL, border: 5 );
    wrap.add( WxButton(parent, idAppend, "Append item"), flag: wxALL, border: 5 );
    wrap.add( WxButton(parent, idInsert, "Insert item"), flag: wxALL, border: 5 );
    wrap.add( WxButton(parent, idDelete, "Delete item"), flag: wxALL, border: 5 );

    parent.bindButtonEvent((event) {
      switch (event.getId()) {
        case idSelectTwo: choice.select( 1 ); break;
        case idInsert: choice.insert( "Item inserted", 0); break;
        case idAppend: choice.append( "Item appended"); break;
        case idDelete:
          final idx = choice.getSelection();
          if (idx != -1) choice.delete(idx); 
          break;
        default:
      }
    }, -1);

    choice.bindListboxEvent((event) {
      log.changeValue("ListboxEvent\n" );
      log.appendText("getInt(): ${event.getInt()}\n" );
      log.appendText("getString(): ${event.getString()}\n" );
      log.appendText("listbox.getSelection(): ${choice.getSelection()}\n" );
    }, -1 );
  }

  void createComboBoxPage( WxStaticBoxSizer sizer, WxWindow parent )
  {
    final combo = WxComboBox( parent, -1, choices: ['Choice #3','Choice #2','Choice #1'], size: WxSize(200, -1), style: wxCB_SORT );
    sizer.add( combo, flag: wxALL, border: 5 );

    const idSelectTwo = 100;
    const idAppend = 101;
    const idInsert = 102;
    const idDelete = 103;
    const idSetValue = 104;

    final wrap = WxWrapSizer();
    sizer.addSizer(wrap);

    final log = WxTextCtrl(parent, -1, size: WxSize(80, 120), style: wxTE_MULTILINE );
    sizer.add( log, flag: wxEXPAND|wxALL, border: 5 );

    final log2 = WxTextCtrl(parent, -1, size: WxSize(80, 120), style: wxTE_MULTILINE );
    sizer.add( log2, flag: wxEXPAND|wxALL, border: 5 );

    wrap.add( WxButton(parent, idSelectTwo, "Select #2"), flag: wxALL, border: 5 );
    wrap.add( WxButton(parent, idAppend, "Append item"), flag: wxALL, border: 5 );
    wrap.add( WxButton(parent, idInsert, "Insert item"), flag: wxALL, border: 5 );
    wrap.add( WxButton(parent, idDelete, "Delete item"), flag: wxALL, border: 5 );
    wrap.add( WxButton(parent, idSetValue, "SetValue"), flag: wxALL, border: 5 );

    parent.bindButtonEvent((event) {
      switch (event.getId()) {
        case idSelectTwo: combo.select( 1 ); break;
        case idInsert: combo.insert( "Item inserted", 0); break;
        case idAppend: combo.append( "Item appended"); break;
        case idDelete: 
          final idx = combo.getSelection();
          if (idx != -1) combo.delete(idx); 
        break;
        case idSetValue: combo.setValue('New Value' ); break;
        default:
      }
    }, -1);

    combo.bindTextEvent((event) {
      log2.changeValue("TextEvent\n" );
      log2.appendText("getString(): ${event.getString()}\n" );
      log2.appendText("combo.getSelection(): ${combo.getSelection()}\n" );
      log2.appendText("combo.getValue(): ${combo.getValue()}\n" );
    }, -1 );

    combo.bindTextEnterEvent((event) {
      log2.changeValue("TextEnterEvent\n" );
      log2.appendText("getString(): ${event.getString()}\n" );
      log2.appendText("combo.getSelection(): ${combo.getSelection()}\n" );
      log2.appendText("combo.getValue(): ${combo.getValue()}\n" );
    }, -1 );

    combo.bindComboboxEvent((event) {
      log.changeValue("ComboboxEvent\n" );
      log.appendText("getInt(): ${event.getInt()}\n" );
      log.appendText("getString(): ${event.getString()}\n" );
      log.appendText("combo.getSelection(): ${combo.getSelection()}\n" );
      log.appendText("combo.getValue(): ${combo.getValue()}\n" );
    }, -1 );
  }

  void createChoicePage( WxStaticBoxSizer sizer, WxWindow parent )
  {
    final choice = WxChoice( parent, -1, choices: ['Choice #1','Choice #2','Choice #3'], size: WxSize(200, -1) );
    sizer.add( choice, flag: wxALL, border: 5 );

    const idSelectTwo = 100;
    const idAppend = 101;
    const idInsert = 102;
    const idDelete = 103;

    final wrap = WxWrapSizer();
    sizer.addSizer(wrap);

    final log = WxTextCtrl(parent, -1, size: WxSize(80, 120), style: wxTE_MULTILINE );
    sizer.add( log, flag: wxEXPAND|wxALL, border: 5 );

    wrap.add( WxButton(parent, idSelectTwo, "Select #2"), flag: wxALL, border: 5 );
    wrap.add( WxButton(parent, idAppend, "Append item"), flag: wxALL, border: 5 );
    wrap.add( WxButton(parent, idInsert, "Insert item"), flag: wxALL, border: 5 );
    wrap.add( WxButton(parent, idDelete, "Delete item"), flag: wxALL, border: 5 );

    parent.bindButtonEvent((event) {
      switch (event.getId()) {
        case idSelectTwo: choice.select( 1 ); break;
        case idInsert: choice.insert( "Item inserted", 0); break;
        case idAppend: choice.append( "Item appended"); break;
        case idDelete:
          final idx = choice.getSelection();
          if (idx != -1) choice.delete(idx); 
          break;
        default:
      }
    }, -1);

    choice.bindChoiceEvent((event) {
      log.changeValue("ChoiceEvent\n" );
      log.appendText("getInt(): ${event.getInt()}\n" );
      log.appendText("getString(): ${event.getString()}\n" );
      log.appendText("choice.getSelection(): ${choice.getSelection()}\n" );
    }, -1 );
  }

  void createSliderPage( WxStaticBoxSizer sizer, WxWindow parent )
  {
    final flex = WxFlexGridSizer(2,vgap: 10, hgap: 5);
    sizer.addSizer(flex);
    flex.add( WxStaticText(parent, -1, "WxGauge:") );
    final gauge = WxGauge(parent, -1, 100, size: WxSize(150,-1) );
    flex.add( gauge );
    gauge.setValue( 30 );

    flex.add( WxStaticText(parent, -1, "WxSider:") );
    final slider1 = WxSlider(parent, -1, 0, 0, 100, size: WxSize(150,-1) );
    flex.add( slider1 );

    flex.add( WxStaticText(parent, -1, "wxSL_MIN_MAX_LABELS:") );
    final slider2 = WxSlider(parent, -1, 0, 0, 100, style: wxSL_MIN_MAX_LABELS,  size: WxSize(150,-1) );
    flex.add( slider2 );

    flex.add( WxStaticText(parent, -1, "wxSL_LABELS:") );
    final slider3 = WxSlider(parent, -1, 0, 0, 100, style: wxSL_LABELS,  size: WxSize(150,-1) );
    flex.add( slider3 );

    const idInderminate = 100;
    sizer.add( WxButton(parent, idInderminate, 'pulse!'), flag: wxALL, border: 7 );

    parent.bindButtonEvent((event) {
      gauge.pulse();
    }, idInderminate);

    final log = WxTextCtrl(parent, -1, size: WxSize(80, 80), style: wxTE_MULTILINE );
    sizer.add( log, flag: wxEXPAND|wxALL, border: 5 );

    slider1.bindSliderEvent((event) {
      log.changeValue("SliderEvent 1\n" );
      log.appendText("value: ${event.getInt()}\n" );
      gauge.setValue( event.getInt() );
    }, -1);

    slider2.bindSliderEvent((event) {
      log.changeValue("SliderEvent 2\n" );
      log.appendText("value: ${event.getInt()}\n" );
      gauge.setValue( event.getInt() );
    }, -1);

    slider3.bindSliderEvent((event) {
      log.changeValue("SliderEvent 3\n" );
      log.appendText("value: ${event.getInt()}\n" );
      gauge.setValue( event.getInt() );
    }, -1);
  }


  void createRadioButtonPage( WxStaticBoxSizer sizer, WxWindow parent )
  {
    const idSelectButton = 103;
    sizer.add( WxRadioButton(parent, 100, "Choice #1", style: wxRB_GROUP), flag: wxALIGN_LEFT );
    sizer.add( WxRadioButton(parent, 101, "Choice #2"), flag: wxALIGN_CENTER_HORIZONTAL );
    sizer.add( WxRadioButton(parent, 102, "Choice #3"), flag: wxALIGN_RIGHT );
    sizer.add( WxButton( parent, idSelectButton, "Select #1" ), flag: wxALL, border: 5 );

    final log = WxTextCtrl(parent, -1, size: WxSize(80, 80), style: wxTE_MULTILINE );
    sizer.add( log, flag: wxEXPAND|wxALL, border: 5 );

    parent.bindRadioButtonEvent((event) {
      log.changeValue("RadioButtonEvent\n" );
      log.appendText( "Control ID: ${event.getId()}" );
    }, -1);

    parent.bindButtonEvent((event) {
      final child = parent.findWindow( 100 );
      if (child is WxRadioButton) {
        child.setValue( true );
      }
    }, idSelectButton );
  }

  void createSpinCtrlPage( WxStaticBoxSizer sizer, WxWindow parent )
  {
    final flex = WxFlexGridSizer(2, vgap: 5, hgap: 5 );
    // Currently, WxFlexGridSizer always expands in wxDart Flutter
    sizer.addSizer(flex /*, flag: wxEXPAND*/ );
/*
    flex.add( WxStaticText( parent, -1, "Very loooooooooooooooooooooog" ), flag: wxALIGN_LEFT );
    flex.add( WxStaticText( parent, -1, "Very loooooooooooooooooooooog" ), flag: wxALIGN_RIGHT );
*/
    flex.add( WxStaticText( parent, -1, "WxSpinCtrl:"), flag: wxALIGN_LEFT );
    final spin = WxSpinCtrl(parent, -1, '-10', initial: -10, min: -20, max: 20 /*, size: WxSize(150,-1) */);
    flex.add( spin, flag: wxALL, border: 5 );
    flex.add( WxStaticText( parent, -1, "WxSpinCtrlDouble:"), flag: wxALIGN_CENTER_VERTICAL );
    final spinDouble = WxSpinCtrlDouble(parent, -1, '-10.0', initial: -10, min: -20, max: 20 /*, size: WxSize(150,-1)*/);
    flex.add( spinDouble, flag: wxALL|wxALIGN_CENTER_VERTICAL, border: 5 );
  /*
    flex.add( WxStaticText( parent, -1, "wxALIGN_LEFT:"), flag: wxALIGN_LEFT );
    flex.add( WxStaticText( parent, -1, "wxALIGN_RIGHT:"), flag: wxALIGN_RIGHT );
*/
    final log = WxTextCtrl(parent, -1, size: WxSize(80, 80), style: wxTE_MULTILINE );
    sizer.add( log, flag: wxEXPAND|wxALL, border: 5 );

    spin.bindSpinCtrlEvent((event) {
      log.changeValue("SpinCtrlEvent\n" );
      log.appendText( "Value: ${event.getInt()}" );
    },-1);

    spinDouble.bindSpinCtrlDoubleEvent((event) {
      log.changeValue("SpinCtrlEvent\n" );
      log.appendText( "Value: ${event.getValue()}" );
    },-1);

  }

  void createImagePage( WxStaticBoxSizer sizer, WxWindow parent )
  {
      // this assumes we are installed on the final machine
      String assetPath = wxGetStandardPaths().getResourcesDir( useLocalDirOnLinuxAndWindows: true );

      // Add forward or backward slash
      if (wxIsMSW() && !wxUsesFlutter()) {
        assetPath += "\\";
      } else {
        assetPath += "/";
      }

    final bottomSizer = WxBoxSizer( wxHORIZONTAL );
    sizer.addSizer( bottomSizer, flag: wxEXPAND ); 

    String path = "";

    bottomSizer.addStretchSpacer();
    bottomSizer.add( WxStaticText(parent, -1, 'PNG:  '), flag: wxALIGN_CENTER_VERTICAL );
    path = "${assetPath}wxWidgets.png";
    bottomSizer.add( WxStaticBitmap(parent, -1, WxBitmapBundle.fromPNGAsset( path)), flag: wxALIGN_CENTER_VERTICAL|wxALL, border: 5 );
    bottomSizer.addStretchSpacer();
    bottomSizer.add( WxStaticText(parent, -1, 'SVG:  '), flag: wxALIGN_CENTER_VERTICAL );
    path = "${assetPath}flutter.svg";
    bottomSizer.add( WxStaticBitmap(parent, -1, WxBitmapBundle.fromSVGAsset( path, WxSize(48, 48))), flag: wxALIGN_CENTER_VERTICAL|wxALL, border: 5 );
    bottomSizer.addStretchSpacer();


    final matSizer = WxBoxSizer( wxHORIZONTAL );
    sizer.addSizer( matSizer, flag: wxEXPAND ); 

    matSizer.add( WxStaticText(parent, -1, 'Material icons:  '), flag: wxALIGN_CENTER_VERTICAL|wxALL, border: 5  );
    final bitmap1 = WxBitmapBundle.fromMaterialIcon( WxMaterialIcon.fit_screen, WxSize(16, 16), colour: wxGREEN );
    matSizer.add( WxStaticBitmap(parent, -1, bitmap1), flag: wxALIGN_CENTER_VERTICAL|wxALL, border: 5 );
    final bitmap2 = WxBitmapBundle.fromMaterialIcon( WxMaterialIcon.fit_screen, WxSize(32, 32), colour: wxGREEN );
    matSizer.add( WxStaticBitmap(parent, -1, bitmap2), flag: wxALIGN_CENTER_VERTICAL|wxALL, border: 5 );
    final bitmap3 = WxBitmapBundle.fromMaterialIcon( WxMaterialIcon.fit_screen, WxSize(48, 48), colour: wxGREEN );
    matSizer.add( WxStaticBitmap(parent, -1, bitmap3), flag: wxALIGN_CENTER_VERTICAL|wxALL, border: 5 );


    final  imageSizer = WxBoxSizer( wxHORIZONTAL );
    sizer.addSizer( imageSizer, flag: wxEXPAND ); 

    path = "${assetPath}PlayPause.png";
    final playpause = WxButton( parent, -1 ,"Play" );
    playpause.setBitmap(WxBitmapBundle.fromMaterialIcon( WxMaterialIcon.play_arrow, WxSize(48, 48) ));
    imageSizer.add( playpause, flag: wxALIGN_CENTER_VERTICAL );
    imageSizer.addSpacer(10);

    imageSizer.add( WxStaticText(parent, -1, 'GIF:  '), flag: wxALIGN_CENTER_VERTICAL );
    path = "${assetPath}throbber2.gif";
    final ani = WxAnimationCtrl(parent, -1, WxAnimation(path) );
    imageSizer.add( ani, flag: wxALIGN_CENTER_VERTICAL );
    imageSizer.addStretchSpacer();

    playpause.bindButtonEvent((_) {
    if (ani.isPlaying()) {
          ani.stop();
          playpause.setBitmap(WxBitmapBundle.fromMaterialIcon( WxMaterialIcon.play_arrow, WxSize(48, 48) ));
          playpause.setLabel( "Play" );
          parent.getParent()!.layout(); // not needed on wxDart Flutter
        } else {
          ani.play();
          playpause.setBitmap(WxBitmapBundle.fromMaterialIcon( WxMaterialIcon.pause, WxSize(48, 48) ));
          playpause.setLabel( "Pause" );
          parent.getParent()!.layout(); // not needed on wxDart Flutter
        }
    }, -1);
    imageSizer.addStretchSpacer();
  }

  void createCheckBoxPage( WxStaticBoxSizer sizer, WxWindow parent )
  {
    const idTwoStateCheckBox = 100;
    const idThreeStateCheckBox = 101;
    const idThreeUserStateCheckBox = 102;
    const idSelectTwoButton = 104;
    const idSelectTriButton = 105;
    sizer.add( WxCheckBox(parent, idTwoStateCheckBox, "Two state check box", style: wxCHK_2STATE), flag: wxALIGN_LEFT );
    sizer.add( WxCheckBox(parent, idThreeStateCheckBox, "Tri state check box", style: wxCHK_3STATE), flag: wxALIGN_CENTER_HORIZONTAL );
    sizer.add( WxCheckBox(parent, idThreeUserStateCheckBox, "Tri state check box, incl user", style: wxCHK_ALLOW_3RD_STATE_FOR_USER|wxCHK_3STATE), flag: wxALIGN_RIGHT );
    final wrap = WxWrapSizer();
    sizer.addSizer(wrap);
    wrap.add( WxButton( parent, idSelectTwoButton, "Two state" ), flag: wxALL, border: 5 );
    wrap.add( WxButton( parent, idSelectTriButton, "Tri state" ), flag: wxALL, border: 5 );

    final log = WxTextCtrl(parent, -1, size: WxSize(80, 80), style: wxTE_MULTILINE );
    sizer.add( log, flag: wxEXPAND|wxALL, border: 5 );

    parent.bindCheckboxEvent((event) {
      log.changeValue("CheckboxEvent from two state checkbox\n" );
      log.appendText( event.isChecked() ? "Checked!" : "Unchecked!" );
    }, idTwoStateCheckBox);

    parent.bindCheckboxEvent((event) {
      log.changeValue("CheckboxEvent from tri state checkbox\n" );
      log.appendText( event.isChecked() ? "Checked!" : "Unchecked!" );
    }, idThreeStateCheckBox);

    parent.bindCheckboxEvent((event) {
      log.changeValue("CheckboxEvent from user tri state checkbox\n" );
      log.appendText(  "Value: ${event.getInt()}" );
    }, idThreeUserStateCheckBox);

    parent.bindButtonEvent((event) {
      final child = parent.findWindow( idTwoStateCheckBox );
      if (child is WxCheckBox) {
        child.setValue( true );
      }
    }, idSelectTwoButton );

    parent.bindButtonEvent((event) {
      final child = parent.findWindow( idThreeStateCheckBox );
      if (child is WxCheckBox) {
        child.set3StateValue(2);
      }
      final child2 = parent.findWindow( idThreeUserStateCheckBox );
      if (child2 is WxCheckBox) {
        child2.set3StateValue(2);
      }
    }, idSelectTriButton );
  }

  void createWrapSizerPage( WxStaticBoxSizer sizer, WxWindow parent )
  {
    final text = "This is a long text in a WxStaticText with wxST_WRAP flag. "
                 "This is a long text in a WxStaticText with wxST_WRAP flag.";
    sizer.add( WxStaticText(parent, -1, text, style: wxST_WRAP), flag: wxEXPAND|wxALL, border: 10 );
  }

  void createBoxSizerPage( WxStaticBoxSizer sizer, WxWindow parent )
  {
    sizer.add( WxStaticText(parent, -1, "WxStaticText"), flag: wxALIGN_LEFT );
    sizer.add( WxStaticText(parent, -1, "WxStaticText"), flag: wxALIGN_CENTER_HORIZONTAL );
    sizer.add( WxStaticText(parent, -1, "WxStaticText"), flag: wxALIGN_RIGHT );
  }
}
