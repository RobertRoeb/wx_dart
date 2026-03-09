// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// -------------------- wxLogging -----------------------

WxTextCtrl? _logText;

void wxLogError( String text ) {
  debugPrint( "[error]: $text" );
  if (_logText != null) {
    _logText!.appendText( "[error]: $text\n" );
  }
}

void wxLogWarning( String text ) {
  if (_logText != null) {
    _logText!.appendText( "[warning]: $text\n" );
  } else {
    debugPrint( "[warning]: $text" );
  }
}

void wxLogMessage( String text ) {
  if (_logText != null) {
    _logText!.appendText( "[log]: $text\n" );
  } else {
    debugPrint( text );
  }
}

void wxLogStatus( WxFrame frame, String text ) {
  frame.setStatusText( text );
}

void wxLogDebug( String text ) {
  if (kDebugMode) {
    if (_logText != null) {
      _logText!.appendText( "[debug]: $text\n" );
    } else {
      debugPrint( "[debug]: $text" );
    }
  }
}

void setLogTarget( WxTextCtrl? textCtrl ) {
  _logText = textCtrl;
}
