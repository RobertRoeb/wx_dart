// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01 (wxDart Web: 2026-11-15)
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// -------------------- wxLogging -----------------------

@JS('wxc.consoleLog')
external void _jsConsoleLog(String level, String text);

WxTextCtrl? _logText;
bool _logToNull = false;

/// True in debug builds (dart2js/dart2wasm without -O... "release" mode)
const bool _wxDebugBuild = !bool.fromEnvironment('dart.vm.product');

void _wxLog( String level, String prefix, String text ) {
  if (_logToNull) return;
  final target = _logText;
  if (target != null && !target._isDestroyed) {
    target.appendText( "$prefix$text\n" );
  } else {
    _jsConsoleLog( level, "$prefix$text" );
  }
}

/// Logs an unrecoverable error
///
/// See [wxLogWarning], [wxLogMessage], [wxLogStatus], [wxLogDebug]
/// See [wxSetLogTarget], [wxSetLogTargetNull], [wxUnsetLogTargetNull]
///
/// Goes to the browser console (as an error) or to the text control set
/// with [wxSetLogTarget].
void wxLogError( String text ) {
  _wxLog( 'error', '[error]: ', text );
}

/// Logs a warning
/// 
/// See [wxLogError], [wxLogMessage], [wxLogStatus], [wxLogDebug]
/// See [wxSetLogTarget], [wxSetLogTargetNull], [wxUnsetLogTargetNull]
void wxLogWarning( String text ) {
  _wxLog( 'warn', '[warning]: ', text );
}

/// Logs a message
/// 
/// See [wxLogWarning], [wxLogError], [wxLogStatus], [wxLogDebug]
/// See [wxSetLogTarget], [wxSetLogTargetNull], [wxUnsetLogTargetNull]
void wxLogMessage( String text ) {
  _wxLog( 'log', _logText != null ? '[log]: ' : '', text );
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
  if (!_wxDebugBuild) return;
  _wxLog( 'debug', '[debug]: ', text );
}

/// Sets log target to this given [textCtrl] directing all
/// log output to it.
///
/// See [wxLogError], [wxLogWarning], [wxLogMessage], [wxLogStatus], [wxLogDebug]
/// See [wxSetLogTargetNull], [wxUnsetLogTargetNull]
///
/// Sets log target to this given [textCtrl] directing all
/// log output to it. Pass null to log to the browser console again.
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
