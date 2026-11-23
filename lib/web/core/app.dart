// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-11-15
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

/// Global reference to the single instance of your WxApp
late WxApp wxTheApp;

final List<WxTopLevelWindow> _topLevelWindows = [];

// ------------------------- wxApp ----------------------

/// Represents the application itself. Same usage as in wxDart Flutter:
///
/// ```dart
/// class MyApp extends WxApp {
///   @override
///   bool onInit() {
///     MyFrame(null).show();
///     return true;
///   }
/// }
///
/// void main() {
///   final myApp = MyApp();
///   myApp.run();
///   myApp.dispose();
/// }
/// ```
///
/// The page must load runtime/wxc.js (and wxc.css) before the compiled
/// Dart code.
///
/// # Events emitted
/// [Idle](/wxdart/wxGetIdleEventType.html) event gets sent when the app is idle
/// | ----------------- |
/// | void bindIdleEvent( OnIdleEventFunc ) |
/// | void unbindIdleEvent() |
class WxApp extends WxEvtHandler {
  WxApp() {
    if (_wxcRuntime == null) {
      throw StateError(
          "wxDart Web: the runtime wxc.js has not been loaded. Add "
          "<script src=\"wxc.js\"></script> to index.html before the Dart code.");
    }
    wxTheApp = this;
    _jsInit(_dispatchFromJs.toJS);
    setAccentColour(WxColour(138, 184, 221)); // standard light blue
    onInit();
  }

  bool _isDark = false;
  late WxColour _primaryAccent;
  late WxColour _secondaryAccent;
  String _appName = "wxdart_app";
  String _appDisplayName = "wxDart";

  /// Override this and create main window here
  bool onInit() {
    return true;
  }

  /// Override this to return exit code other than 0 indicating an error has occurred
  int onExit() {
    return 0;
  }

  /// Actually runs the app.
  ///
  /// Starts processing. In the browser, this only starts idle processing
  /// as the browser runs the event loop.
  void run() {
    if (theTLW == null) {
      wxLogError("There is no WxFrame for WxApp to show!");
    }
    _scheduleIdle();
  }

  /// In wxDart Web, this does nothing as the page keeps running.
  @override
  void dispose() {
    // The browser calls us back after main() returned, so nothing
    // must be torn down here. onExit() is called when the main frame
    // gets destroyed.
  }

  /// static function returning the main toplevel window
  static WxWindow? getMainTopWindow() {
    return theTLW;
  }

  /// Returns the main toplevel window
  WxWindow? getTopWindow() {
    return theTLW;
  }

  /// Sets the main toplevel window
  void setTopWindow(WxWindow window) {
    if (window is WxFrame) {
      theTLW = window;
    }
  }

  String getApearanceName() {
    return "Web";
  }

  /// Returns true if currently running in dark mode
  bool isDark() {
    return _isDark;
  }

  bool isUsingDarkBackground() {
    return isDark();
  }

  /// Returns true if currently running on a touch device.
  /// Override this to define your own criteria when an
  /// adaptive app should be in touch mode.
  ///
  /// In wxDart Web, true if the browser window is less than 700 pixels
  /// wide (as in wxDart Flutter) or if the device has a touch screen and
  /// no mouse (phones and tablets).
  bool isTouch() {
    return _jsIsTouch();
  }

  /// Switch to dark mode, if [mode] is wxAPPEARANCE_DARK and to
  /// light mode otherwise. Switching at runtime is not supported
  /// under Windows in wxDart Native (but it is when using the
  /// Flutter backend anywhere, including Windows).
  int setAppearance(int mode) {
    if (mode == wxAPPEARANCE_SYSTEM) {
      _isDark = _jsIsDark();
    } else {
      _isDark = (mode == wxAPPEARANCE_DARK);
    }
    _jsSetDark(_isDark);
    _applyAccent();
    _updateThemedIcons();
    WxRendererNative._updateTheme();
    for (final window in List<WxWindow>.of(_windowsByHandle.values)) {
      final event = WxSysColourChangedEvent(id: window.getId());
      event.setEventObject(window);
      window.processEvent(event);
    }
    for (final tlw in _topLevelWindows) {
      tlw._refreshRecursive();
    }
    return wxAPPEARANCE_RESULT_OK;
  }

  /// Sets the application name
  void setAppName(String name) {
    _appName = name;
  }

  String getAppName() {
    return _appName;
  }

  /// Sets the user-visible application name
  ///
  /// See [getAppDisplayName]
  void setAppDisplayName(String name) {
    _appDisplayName = name;
  }

  /// Returns the user-readable application name.
  ///
  /// The difference between this string and the one returned by
  /// [getAppName] is that this one is meant to be shown to the
  /// user and so should be used for the window titles, page headers
  /// and so on while the other one should be only used internally,
  /// e.g. for the file names or configuration file keys.
  String getAppDisplayName() {
    return _appDisplayName;
  }

  /// Sets the main accent colour, used for title bars, highlighted
  /// menu entries and default buttons.
  ///
  /// Text on the accent colour becomes black or white, whichever is easier
  /// to read (see [getColourOnAccent]). Can be called at any time: all
  /// windows are refreshed.
  void setAccentColour(WxColour accent) {
    _primaryAccent = accent;
    _secondaryAccent = accent.changeLightness(60);
    _applyAccent();
    _updateThemedIcons();
    for (final tlw in _topLevelWindows) {
      tlw._refreshRecursive();
    }
  }

  void _applyAccent() {
    final primary = getPrimaryAccentColour();
    _jsSetAccent(_cssColour(primary), _cssColour(getColourOnAccent(primary)));
  }

  /// Returns black or white, whichever is more readable on [background]
  /// (by default the accent colour returned by [getAccentColour]).
  ///
  /// See [WxColour.getContrastingColour]
  WxColour getColourOnAccent([WxColour? background]) {
    return (background ?? getAccentColour()).getContrastingColour();
  }

  /// Returns the accent colour set by [setAccentColour] ignoring whether or
  /// not the app is in dark or light mode
  ///
  /// See [getPrimaryAccentColour] and [getSecondaryAccentColour]
  ///
  /// Only available in Dart Flutter
  WxColour getAccentColour() {
    return _primaryAccent;
  }

  /// Returns the unchanged accent colour in light mode and a darkened tone
  /// of it in dark mode
  ///
  /// See  [getSecondaryAccentColour]
  ///
  /// Only available in Dart Flutter
  WxColour getPrimaryAccentColour() {
    return (_isDark) ? _secondaryAccent : _primaryAccent;
  }

  /// Returns a darkened tone of the accent colour in light mode and the unchanged accent
  /// colour in dark mode
  ///
  /// See  [getPrimaryAccentColour]
  ///
  /// Only available in Dart Flutter
  WxColour getSecondaryAccentColour() {
    return (!_isDark) ? _secondaryAccent : _primaryAccent;
  }
}

// ------------------------- idle processing ----------------------

bool _idleScheduled = false;

void _scheduleIdle() {
  if (_idleScheduled) return;
  _idleScheduled = true;
  Timer(Duration.zero, _runIdle);
}

void _runIdle() {
  _idleScheduled = false;
  bool more = false;

  _doPendingLayouts();

  for (final tlw in List<WxTopLevelWindow>.of(_topLevelWindows)) {
    if (tlw.isBeingDeleted()) continue;
    tlw._sendUpdateUIRecursive();
    if (tlw._sendIdleRecursive()) more = true;
  }

  final event = WxIdleEvent();
  event.setEventObject(wxTheApp);
  wxTheApp.processEvent(event);
  if (event.moreRequested()) more = true;

  if (more) _scheduleIdle();
}
