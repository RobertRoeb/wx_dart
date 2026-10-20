// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// -------------------- wxLogging -----------------------

WxTextCtrl? _logText;

/// Logs an unrecoverable error
void wxLogError( String text ) {
  debugPrint( "[error]: $text" );
  if (_logText != null) {
    _logText!.appendText( "[error]: $text\n" );
  }
}

/// Logs a warning
void wxLogWarning( String text ) {
  if (_logText != null) {
    _logText!.appendText( "[warning]: $text\n" );
  } else {
    debugPrint( "[warning]: $text" );
  }
}

/// Logs a message
void wxLogMessage( String text ) {
  if (_logText != null) {
    _logText!.appendText( "[log]: $text\n" );
  } else {
    debugPrint( text );
  }
}

/// Logs a message in the [WxStatusBar] of the given [frame]
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

/// Sets log target to this given [textCtrl] directing all 
/// log output to it.
void wxSetLogTarget( WxTextCtrl? textCtrl ) {
  _logText = textCtrl;
}
