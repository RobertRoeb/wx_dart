// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxMessageDialog ----------------------

/// Standard dialog to show a message to the user.
/// 
/// Styles can be used to add icon indicating the nature of the message
/// (such as information, warning or error) and which buttons to display
/// 
///```dart
///   final msg = WxMessageDialog( this, "Pressed OK", caption: "wxDart" );
///   msg.setExtendedMessage( "File: $data" );
///   msg.showModal(null);
///```
///
/// # Style constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxICON_ERROR | indicates an error |
/// | wxICON_WARNING | indicates a warning |
/// | wxICON_QUESTION | question (mark) |
/// | wxICON_INFORMTION | information |
/// | wxICON_HAND | shows a hand |
/// | wxICON_AUTH_NEEDED | authentication is needed |
/// | wxYES | button with id wxID_YES |
/// | wxNO | button with id wxID_NO |
/// | wxYES_NO | 2 button with id wxID_NO and wxID_YES |
/// | wxOK | button with id wxID_OK |
/// | wxCANCEL | button with id wxID_CANCEL |
/// | wxAPPLY | button with if wxID_APPLY |
/// | wxHELP | button with if wxID_HELP |
/// | wxSTAY_ON_TOP | always stays on top |
/// | wxCENTRE | centre above owning frame |

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

  /// Sets the message of the message box
  void setMessage( String message ) {
    _message.setLabel( message );
    layout();  // does nothing on wxDart Flutter
  }

  /// Sets the extended (extra) message of the message box
  void setExtendedMessage( String message ) {
    if (_extendedMessage != null) {
      _extendedMessage!.setLabel( message );
    } else {
      int count = _mainSizer.getItemCount();
      _extendedMessage = WxStaticText(this, -1, message );
      _mainSizer.insert( count-1, _extendedMessage!, flag: wxALL, border: 10 );

      final pointSize = wxNORMAL_FONT.getPointSize();
      _message.setFont( WxFont( pointSize*1.3 ) );
    }
    layout();  // does nothing on wxDart Flutter
  }

  /// Sets the label of the button with the wxID_OK ID
  void setOKLabel( String label ) {
    _ok = label;
    layout();  // does nothing on wxDart Flutter
  }

  /// Sets the label of the button with the wxID_HELP ID
  void setHelpLabel( String label ) {
    _help = label;
    layout();  // does nothing on wxDart Flutter
  }

  /// Sets the label of the yes/no buttons
  void setYesNoLabels( String yes, String no ) {
    _yes = yes;
    _no = no;
    layout();  // does nothing on wxDart Flutter
  }

  /// Sets the label of the yes/no/cancel buttons
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


