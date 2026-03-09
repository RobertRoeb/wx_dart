// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxMessageDialog ----------------------

class WxMessageDialog extends WxDialog {
  WxMessageDialog( WxWindow? parent, String message, { String caption = '', int style = wxOK|wxCENTRE, WxPoint pos = wxDefaultPosition } ) 
  : super( parent, -1, caption, pos: pos )
  {
    _mainSizer = WxBoxSizer( wxVERTICAL );

    if (style & wxICON_ERROR != 0) {
      final bundle = WxBitmapBundle.fromMaterialIcon( WxMaterialIcon.report_gmailerrorred, WxSize( fromDIP(48),fromDIP(48)) );
      _mainSizer.add( WxStaticBitmap(this, -1, bundle ), flag: wxALL, border: 10 );
    } else
    if (style & wxICON_WARNING != 0) {
      final bundle = WxBitmapBundle.fromMaterialIcon( WxMaterialIcon.warning, WxSize( fromDIP(48),fromDIP(48)) );
      _mainSizer.add( WxStaticBitmap(this, -1, bundle ), flag: wxALL, border: 10 );
    } else
    if (style & wxICON_QUESTION != 0) {
      final bundle = WxBitmapBundle.fromMaterialIcon( WxMaterialIcon.question_mark, WxSize( fromDIP(48),fromDIP(48)) );
      _mainSizer.add( WxStaticBitmap(this, -1, bundle ), flag: wxALL, border: 10 );
    } else
    if (style & wxICON_INFORMATION != 0) {
      final bundle = WxBitmapBundle.fromMaterialIcon( WxMaterialIcon.info, WxSize( fromDIP(48),fromDIP(48)) );
      _mainSizer.add( WxStaticBitmap(this, -1, bundle ), flag: wxALL, border: 10 );
    } else
    if (style & wxICON_HAND != 0) {
      final bundle = WxBitmapBundle.fromMaterialIcon( WxMaterialIcon.warning, WxSize( fromDIP(48),fromDIP(48)) );
      _mainSizer.add( WxStaticBitmap(this, -1, bundle ), flag: wxALL, border: 10 );
    } else
    if (style & wxICON_AUTH_NEEDED != 0) {
      final bundle = WxBitmapBundle.fromMaterialIcon( WxMaterialIcon.login, WxSize( fromDIP(48),fromDIP(48)) );
      _mainSizer.add( WxStaticBitmap(this, -1, bundle ), flag: wxALL, border: 10 );
    } 

    _message = WxStaticText( this, -1, message );
    _mainSizer.add( _message, flag: wxALL, border: 10 );

    _mainSizer.addSizer( createStdDialogButtonSizer(style), flag: wxTOP|wxLEFT, border: 10 );

    setSizerAndFit( _mainSizer );
  }

  late WxStaticText _message;
  WxStaticText? _extendedMessage;
  String _yes = "Yes";
  String _no = "No";
  String _ok = "OK";
  String _cancel = "Cancel";
  String _help = "Help";
  late WxBoxSizer _mainSizer;

  void setMessage( String message ) {
    _message.setLabel( message );
    layout();  // does nothing on wxDart Flutter
  }

  void setExtendedMessage( String message ) {
    if (_extendedMessage != null) {
      _extendedMessage!.setLabel( message );
    } else {
      int count = _mainSizer.getItemCount();
      _extendedMessage = WxStaticText(this, -1, message );
      _mainSizer.insert( count-2, _extendedMessage!, flag: wxALL, border: 10 );
    }
    layout();  // does nothing on wxDart Flutter
  }

  void setOKLabel( String label ) {
    _ok = label;
    layout();  // does nothing on wxDart Flutter
  }

  void setHelpLabel( String label ) {
    _help = label;
    layout();  // does nothing on wxDart Flutter
  }

  void setYesNoLabels( String yes, String no ) {
    _yes = yes;
    _no = no;
    layout();  // does nothing on wxDart Flutter
  }

  void setYesNoCancelLabels( String yes, String no, String cancel ) {
    _yes = yes;
    _no = no;
    _cancel = cancel;
    layout();  // does nothing on wxDart Flutter
  }

  void setOKCancelLabels( String ok, String cancel ) {
    _ok = ok;
    _cancel = cancel;
    layout();  // does nothing on wxDart Flutter
  }
}


