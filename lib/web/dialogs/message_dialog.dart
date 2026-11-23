// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01 (wxDart Web: 2026-11-15)
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
    // not _style: that would override the window style of WxWindow
    _messageStyle = style;
    _mainSizer = WxBoxSizer( wxVERTICAL );
    final row = WxBoxSizer( wxHORIZONTAL );
    final icon = _iconFor( style );
    if (icon != null) {
      row.add( WxStaticBitmap( this, -1, WxBitmapBundle.fromMaterialIcon( icon, const WxSize( 40, 40 ),
          colour: _colourFor( style ) ) ), flag: wxRIGHT, border: 16 );
    }
    _texts = WxBoxSizer( wxVERTICAL );
    _message = WxStaticText( this, -1, message );
    _texts.add( _message );
    row.addSizer( _texts, proportion: 1, flag: wxALIGN_CENTER_VERTICAL );
    _mainSizer.addSizer( row, proportion: 1, flag: wxEXPAND|wxALL, border: 20 );
    _mainSizer.addSizer( createStdDialogButtonSizer( style ), flag: wxEXPAND|wxLEFT|wxRIGHT|wxBOTTOM, border: 16 );
    _updateLabels();
    setSizerAndFit( _mainSizer );
  }

  late int _messageStyle;
  late WxStaticText _message;
  late WxBoxSizer _texts;
  WxStaticText? _extendedMessage;
  String _yes = "Yes";
  String _no = "No";
  String _ok = "OK";
  String _cancel = "Cancel";
  String _help = "Help";
  late WxBoxSizer _mainSizer;

  static WxMaterialIcon? _iconFor( int style ) {
    if ((style & wxICON_NONE) != 0) return null;
    if ((style & wxICON_ERROR) != 0) return WxMaterialIcon.error_outline;
    if ((style & wxICON_WARNING) != 0) return WxMaterialIcon.warning_amber;
    if ((style & wxICON_QUESTION) != 0) return WxMaterialIcon.help_outline;
    if ((style & wxICON_INFORMATION) != 0) return WxMaterialIcon.info;
    if ((style & wxICON_AUTH_NEEDED) != 0) return WxMaterialIcon.lock;
    return null;
  }

  static WxColour? _colourFor( int style ) {
    if ((style & wxICON_ERROR) != 0) return WxColour( 211, 47, 47 );
    if ((style & wxICON_WARNING) != 0) return WxColour( 237, 108, 2 );
    return null;
  }

  void _updateLabels() {
    void label( int id, String text ) {
      final button = findWindow( id );
      if (button is WxButton) button.setLabel( text );
    }
    label( wxID_YES, _yes );
    label( wxID_NO, _no );
    label( wxID_OK, _ok );
    label( wxID_CANCEL, _cancel );
    label( wxID_HELP, _help );
  }

  /// Returns the style given in the constructor
  int getMessageDialogStyle() {
    return _messageStyle;
  }

  /// Sets the message of the message box
  void setMessage( String message ) {
    _message.setLabel( message );
    layout();
  }

  /// Sets the extended (extra) message of the message box
  void setExtendedMessage( String message ) {
    if (_extendedMessage != null) {
      _extendedMessage!.setLabel( message );
    } else {
      _extendedMessage = WxStaticText( this, -1, message );
      _texts.add( _extendedMessage!, flag: wxTOP, border: 8 );
      _message.setFont( WxFont( wxNORMAL_FONT.getPointSize() * 1.2, weight: wxFONTWEIGHT_BOLD ) );
    }
    fit();
  }

  /// Sets the label of the button with the wxID_OK ID
  void setOKLabel( String label ) {
    _ok = label;
    _updateLabels();
  }

  /// Sets the label of the button with the wxID_HELP ID
  void setHelpLabel( String label ) {
    _help = label;
    _updateLabels();
  }

  /// Sets the label of the yes/no buttons
  void setYesNoLabels( String yes, String no ) {
    _yes = yes;
    _no = no;
    _updateLabels();
  }

  /// Sets the label of the yes/no/cancel buttons
  void setYesNoCancelLabels( String yes, String no, String cancel ) {
    _yes = yes;
    _no = no;
    _cancel = cancel;
    _updateLabels();
  }

  void setOKCancelLabels( String ok, String cancel ) {
    _ok = ok;
    _cancel = cancel;
    _updateLabels();
  }
}

/*
/// wxDart Web: shows a [WxMessageDialog] and calls [onReturn] with the
/// id of the button that was pressed: wxID_YES, wxID_NO, wxID_OK,
/// wxID_CANCEL or wxID_HELP, as [WxDialog.showModal] in all ports.
/// (Note that wxMessageBox() in wxWidgets returns wxYES, wxNO etc.
/// instead.) Asynchronous, since a browser cannot block.
///
/// For code that also runs in wxDart Flutter and wxDart Native, use
/// [WxMessageDialog] directly.
void wxMessageBox( String message, { String caption = 'Message', int style = wxOK|wxCENTRE,
                   WxWindow? parent, void Function( int answer )? onReturn } )
{
  final dialog = WxMessageDialog( parent ?? theTLW, message, caption: caption, style: style );
  dialog.showModal( (code, _) {
    onReturn?.call( code );
  } );
}
*/
