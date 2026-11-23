// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxHyperlinkEvent ----------------------

// ------------------------- wxHyperlinkCtrl ----------------------

/// Represents a hyper link that the user can click.
///
/// By default, it will launch the system's default browswer.
///
/// Example
/// ```dart
///   final hyperlink = WxHyperlinkCtrl( this, -1, "wxDart", "https://pub.dev/packages/wx_dart" );
///
///   hyperlink.bindHyperlinkEvent( (event) {
///     final url = event.getURL();
///     // do something or launch a browser
///   }, -1)
/// ```
///
/// # Events emitted
/// [Hyperlink](/wxdart/wxGetHyperlinkEventType.html) gets sent when user clicked on hyper link |
/// | ----------------- |
/// | void bindHyperlinkEvent( void function( [WxHyperlinkEvent] event ), int id ) |
/// | void unbindHyperlinkEvent() |
///
/// # Windows styles
/// | constant | meaning |
/// | -------- | -------- |
/// | wxHL_CONTEXTMENU | 0x0001 |
/// | wxHL_ALIGN_LEFT | 0x0002 |
/// | wxHL_ALIGN_RIGHT | 0x0004 |
/// | wxHL_ALIGN_CENTRE | 0x0008 |
/// | wxHL_DEFAULT_STYLE | (wxHL_CONTEXTMENU\|wxNO_BORDER\|wxHL_ALIGN_CENTRE) |
///
///
/// A link (HTML <a>). Clicking it sends a [WxHyperlinkEvent]; if that is
/// not handled, the URL is opened in a new browser tab.
class WxHyperlinkCtrl extends WxControl {
  WxHyperlinkCtrl(super.parent, super.id, String label, String url,
      {super.pos = wxDefaultPosition, super.size = wxDefaultSize, super.style = wxHL_DEFAULT_STYLE}) {
    _url = url;
    String align = "left";
    if (hasFlag(wxHL_ALIGN_CENTRE)) align = "center";
    if (hasFlag(wxHL_ALIGN_RIGHT)) align = "right";
    _jsSetTextAlign(_handle, align, false);
    setLabel(label);
    _update();
  }

  String _url = "";
  bool _visited = false;
  WxColour _normalColour = WxColour(26, 95, 180);
  WxColour _hoverColour = WxColour(42, 127, 212);
  WxColour _visitedColour = WxColour(106, 61, 154);

  @override
  String get _jsKind => 'hyperlink';

  @override
  void setLabel(String label) {
    _label = label;
    _jsSetLabel(_handle, label);
    _labelOrFontChanged();
  }

  void _update() {
    _jsLinkSet(_handle, _url, _cssColour(_normalColour), _cssColour(_hoverColour),
        _cssColour(_visitedColour), _visited);
  }

  void setHoverColour(WxColour colour) {
    _hoverColour = colour;
    _update();
  }

  /// Sets the normal colour of the link. Note that different
  /// platform may have different standard backgrounds and setting
  /// this colour risks unwanted contrasts
  void setNormalColour(WxColour colour) {
    _normalColour = colour;
    _update();
  }

  /// Sets colour for a link that has already been visited
  void setVisitedColour(WxColour colour) {
    _visitedColour = colour;
    _update();
  }

  WxColour getHoverColour() {
    return _hoverColour;
  }

  WxColour getNormalColour() {
    return _normalColour;
  }

  WxColour getVisitedColour() {
    return _visitedColour;
  }

  /// Indicate that the link has been visited and that the
  /// colour should be changed - if supported
  void setVisited({bool visited = true}) {
    _visited = visited;
    _update();
  }

  /// Returns true if link has been set to visited. See [setVisited]
  bool getVisited() {
    return _visited;
  }

  /// Sets URL of the link
  void setURL(String url) {
    _url = url;
    _update();
  }

  /// Returns URL of the link
  String getURL() {
    return _url;
  }

  void _onJsClick() {
    setVisited();
    final event = WxHyperlinkEvent(this, getId(), _url);
    if (!processEvent(event)) {
      wxLaunchDefaultBrowser(_url);
    }
  }

  @override
  bool _wantsNativeKey(int keyCode) {
    return (keyCode == WXK_RETURN) || (keyCode == WXK_NUMPAD_ENTER);
  }
}
