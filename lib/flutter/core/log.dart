// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// -------------------- wxLogging -----------------------

WxTextCtrl? _logText;
bool _logToNull = false;

/// Logs an unrecoverable error
/// 
/// See [wxLogWarning], [wxLogMessage], [wxLogStatus], [wxLogDebug]
/// See [wxSetLogTarget], [wxSetLogTargetNull], [wxUnsetLogTargetNull]
void wxLogError( String text ) {
  if (_logToNull) return;
  debugPrint( "[error]: $text" );
  if (_logText != null) {
    _logText!.appendText( "[error]: $text\n" );
  }
}

/// Logs a warning
/// 
/// See [wxLogError], [wxLogMessage], [wxLogStatus], [wxLogDebug]
/// See [wxSetLogTarget], [wxSetLogTargetNull], [wxUnsetLogTargetNull]
void wxLogWarning( String text ) {
  if (_logToNull) return;
  if (_logText != null) {
    _logText!.appendText( "[warning]: $text\n" );
  } else {
    debugPrint( "[warning]: $text" );
  }
}

/// Logs a message
/// 
/// See [wxLogWarning], [wxLogError], [wxLogStatus], [wxLogDebug]
/// See [wxSetLogTarget], [wxSetLogTargetNull], [wxUnsetLogTargetNull]
void wxLogMessage( String text ) {
  if (_logToNull) return;
  if (_logText != null) {
    _logText!.appendText( "[log]: $text\n" );
  } else {
    debugPrint( text );
  }
}

/// Logs a message in the [WxStatusBar] of the given [frame]
/// 
/// See [wxLogWarning], [wxLogMessage], [wxLogError], [wxLogDebug]
/// See [wxSetLogTarget], [wxSetLogTargetNull], [wxUnsetLogTargetNull]
void wxLogStatus( WxFrame frame, String text ) {
  if (_logToNull) return;
  frame.setStatusText( text );
}

/// 
/// See [wxLogWarning], [wxLogMessage], [wxLogStatus], [wxLogError]
/// See [wxSetLogTarget], [wxSetLogTargetNull], [wxUnsetLogTargetNull]
void wxLogDebug( String text ) {
  if (_logToNull) return;
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
/// 
/// See [wxLogError], [wxLogWarning], [wxLogMessage], [wxLogStatus], [wxLogDebug]
/// See [wxSetLogTargetNull], [wxUnsetLogTargetNull]
void wxSetLogTarget( WxTextCtrl? textCtrl ) {
  _logText = textCtrl;
}

/// Shuts off logging until call to [wxUnsetLogTargetNull]
/// 
/// See [wxLogError], [wxLogWarning], [wxLogMessage], [wxLogStatus], [wxLogDebug]
/// See [wxSetLogTarget], [wxUnsetLogTargetNull]
void wxSetLogTargetNull() {
  _logToNull = true;
}

/// Restart logging after call to [wxSetLogTargetNull]
/// 
/// See [wxLogError], [wxLogWarning], [wxLogMessage], [wxLogStatus], [wxLogDebug]
/// See [wxSetLogTarget], [wxSetLogTargetNull]
void wxUnsetLogTargetNull() {
  _logToNull = false;
}
