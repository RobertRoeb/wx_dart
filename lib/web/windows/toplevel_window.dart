// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-11-15
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxNonOwnedWindow ----------------------

class WxNonOwnedWindow extends WxWindow {
  WxNonOwnedWindow(WxWindow? parent, int id,
      {WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = 0})
      : super(parent, id, pos, size, style);

  /// Returns true if the window is being closed or destroyed. Child
  /// windows are destroyed together with it: use [dispose] to stop timers
  /// and animations of a window.
  bool isBeingDeleted() {
    return _isDestroyed;
  }
}

// ------------------------- wxTopLevelWindow ----------------------

/// Base class for [WxFrame] and [WxDialog].
///
/// # Events emitted
/// [CloseWindow](/wxdart/wxGetCloseWindowEventType.html) event
/// | ----------------- |
/// | void bindCloseWindowEvent( OnCloseEventFunc ) |
/// | void unbindCloseWindowEvent() |
class WxTopLevelWindow extends WxNonOwnedWindow {
  /// Creates a toplevel window. Don't use this class directly, use [WxFrame] or [WxDialog] instead.
  WxTopLevelWindow(WxWindow? parent, int id, this._title,
      {WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = wxDEFAULT_FRAME_STYLE})
      : super(parent, id, pos: pos, size: size, style: style) {
    _hidden = true;
    _topLevelWindows.add(this);
    _jsSetLabel(_handle, _title);
  }

  String _title;
  WxSize _clientSize = WxSize.zero;
  bool _hasReceivedSize = false;

  @override
  bool isTopLevel() {
    return true;
  }

  /// Sets the title of the window, usually displayed above the window.
  void setTitle(String title) {
    _title = title;
    _jsSetLabel(_handle, title);
  }

  /// Returns the title of the window
  String getTitle() {
    return _title;
  }

  @override
  void setLabel(String label) {
    setTitle(label);
  }

  @override
  String getLabel() {
    return _title;
  }

  /// Shows window, or hides it if [show] is false.
  @override
  void show({bool show = true}) {
    _hidden = !show;
    _jsShow(_handle, show);
    if (show) _scheduleIdle();
  }

  /// Destroys the window and removes it from the list of child
  /// windows from the parent window, if any.
  ///
  /// Deletion may occur in a deferred way, not immediately.
  @override
  bool destroy() {
    if (_isDestroyed) return true;
    _topLevelWindows.remove(this);
    if (theTLW == this) {
      theTLW = null;
      wxTheApp.onExit();
    }
    return super.destroy();
  }

  /// Requests to close the window. Don't allow a veto if [force] is true.
  void close([bool force = false]) {
    _doClose(canVeto: !force);
  }

  /// Returns false if closing was vetoed
  bool _doClose({required bool canVeto}) {
    final event = WxCloseEvent(wxGetCloseWindowEventType(), id: getId());
    event.setCanVeto(canVeto);
    event.setEventObject(this);
    if (processEvent(event)) {
      return !(event.canVeto() && event.getVeto());
    }
    _defaultClose();
    return true;
  }

  void _defaultClose() {
    destroy();
  }

  // ------------------------- geometry ----------------------

  @override
  WxSize getClientSize() {
    if (!_hasReceivedSize) {
      final s = _jsClientSize(_handle);
      if (s.w > 0 && s.h > 0) return WxSize(s.w, s.h);
    }
    return _clientSize;
  }

  @override
  WxSize getSize() {
    return getClientSize();
  }

  @override
  WxRect getRect() {
    final s = getSize();
    return WxRect(0, 0, s.x, s.y);
  }

  @override
  WxPoint getPosition() {
    return WxPoint.zero;
  }

  /// Called by the dispatcher when wxc.js reports a new client size
  void _onClientResized(int width, int height) {
    final first = !_hasReceivedSize;
    _hasReceivedSize = true;
    if (!first && (_clientSize.x == width) && (_clientSize.y == height)) return;
    _clientSize = WxSize(width, height);
    _layoutChildren();
    _sendSizeEvent();
    if (first) {
      // children were created before the app could bind size handlers
      _sendSizeEventsRecursive();
    }
    refresh();
  }

  void _layoutChildren() {
    if (_sizer != null) layout();
  }

  /// Brings window to the top (among its window siblings)
  void raise() {
    if (isShown()) _jsShow(_handle, true);
  }

  /// Brings window to the back (among its window siblings)
  void lower() {}

  /// Maximizes window
  ///
  /// Not supported in wxDart Flutter
  void maximize([bool maximize = true]) {}
  /// Minimizes window
  ///
  /// Not supported in wxDart Flutter
  void minimize([bool minimize = true]) {}
  void iconize([bool iconize = true]) {}
  /// wxDart Native: restores window if it was iconized or maximized
  ///
  /// Not supported in wxDart Flutter
  void restore() {}
  bool isMaximized() {
    return true;
  }

  bool isIconized() {
    return false;
  }

  /// Returns true if this window is expected to be always maximized,
  /// either due to platform policy or due to local policy regarding particular class.
  bool isAlwaysMaximized() {
    return true;
  }

  bool isActive() {
    return isShown();
  }

  /// Request to go into or leave fullscreen mode. Depending on the flags used,
  /// this will hide menu, toolbar and titlebar- on contrast to [maximize].
  ///
  /// ## flag constants
  /// | constant | value (meaning) |
  /// | -------- | -------- |
  /// | wxFULLSCREEN_NOMENUBAR | 0x0001 |
  /// | wxFULLSCREEN_NOTOOLBAR | 0x0002 |
  /// | wxFULLSCREEN_NOSTATUSBAR | 0x0004 |
  /// | wxFULLSCREEN_NOBORDER | 0x0008 |
  /// | wxFULLSCREEN_NOCAPTION | 0x0010 |
  /// | wxFULLSCREEN_ALL | all of them |
  void showFullScreen({bool enable = true, int flags = wxFULLSCREEN_ALL}) {}
  /// Returns true is the window is in full screen
  bool isFullScreen() {
    return false;
  }

  /// wxDart Native: request user attention
  void requestUserAttention({int flags = wxUSER_ATTENTION_INFO}) {}

  /// wxDart Native: enables or disables close button
  bool enableCloseButton(bool enable) {
    return false;
  }

  /// wxDart Native: centre window on screen
  ///
  /// See also [centreOnParent]
  void centreOnScreen(int direction) {}
}
