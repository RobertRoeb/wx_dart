// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-11-15
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

/// A device context for measuring text (and coordinate conversions)
/// outside of a paint handler. Same API as in wxDart Flutter.
class WxInfoDC extends WxReadOnlyDC {
  /// Create a information DC for the given [window]
  WxInfoDC(this.window) {
    _contentScaleFactor = window.getContentScaleFactor();
    _font = window._font;
  }

  final WxWindow window;
}
