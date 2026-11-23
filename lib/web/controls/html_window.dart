// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxHtmlLinkEvent ----------------------

// ------------------------- wxHtmlWindow ----------------------

/// A scrollable window that shows HTML (a <div> rendered by the browser,
/// so all of HTML and CSS work).
///
/// The HTML is cleaned before it is shown: scripts, frames, style sheets
/// and event handler attributes are removed. This is not a complete
/// sanitizer, so only show HTML you trust.
///
/// Clicking a link sends a [WxHtmlLinkEvent]. If it is not handled,
/// links to anchors ("#name") scroll, links with a scheme ("https:",
/// "mailto:") open in a new browser tab and other (relative) links are
/// loaded into the window with [loadPage].
///
/// # Events emitted
/// [HtmlLinkClick](/wxdart/wxGetHtmlLinkClickEventType.html) event gets sent when a link is clicked
/// | ----------------- |
/// | void bindHtmlLinkClickEvent( OnHtmlLinkEventFunc, int id ) |
/// | void unbindHtmlLinkClickEvent( int id ) |
class WxHtmlWindow extends WxControl {
  /// Creates the HTML window
  WxHtmlWindow(WxWindow parent, int id,
      {WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = 0})
      : super(parent, id, pos: pos, size: size, style: style);

  String _source = "";
  String _openedPage = "";

  @override
  String get _jsKind => 'html';

  /// Sets the HTML source
  ///
  /// Shows [source] (HTML)
  bool setPage(String source) {
    _source = source;
    _openedPage = "";
    _jsHtmlSet(_handle, source, false);
    return true;
  }

  /// Appends HTML to the current page
  bool appendToPage(String source) {
    _source += source;
    _jsHtmlSet(_handle, source, true);
    return true;
  }

  /// Loads an HTML from [location] relative to [WxStandardPaths.getResourcesDir]
  bool loadPage(String location) {
    _jsHtmlLoad(_handle, location);
    return true;
  }

  /// URL of the last page loaded with [loadPage]
  String getOpenedPage() {
    return _openedPage;
  }

  /// The HTML set with [setPage] and [appendToPage]
  String getSource() {
    return _source;
  }

  void _onJsLinkClicked(String href, String url) {
    final event = WxHtmlLinkEvent(getId(), href);
    event.setEventObject(this);
    if (processEvent(event)) return;
    if (href.startsWith("#")) {
      _jsHtmlScrollTo(_handle, href.substring(1));
    } else if (RegExp(r"^[a-zA-Z][a-zA-Z0-9+.-]*:").hasMatch(href)) {
      wxLaunchDefaultBrowser(url);
    } else {
      loadPage(url);
    }
  }

  void _onJsLoaded(String url, bool ok) {
    if (ok) {
      _openedPage = url;
      _source = "";
    } else {
      wxLogError("WxHtmlWindow: could not load $url");
    }
  }
}
