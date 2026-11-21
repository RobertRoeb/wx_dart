// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxHtmlWindow ----------------------

/// A window that shows HTML text. This only supports a subset of HTML and
/// is not designed to be a browser.
/// 
/// Example usage loading an HTML from a resource in lib/assets/README.html
/// ```dart
///  final html = WxHtmlWindow(parent, -1);
///  wxLoadStringFromResource( "README.html", (text) {
///    html.setPage( text );
///  });
/// 
///  // Actually launch links
///  bindHtmlLinkClickEvent((event) {
///    final url = event.getHref();
///    wxLaunchDefaultBrowser(url);
///  }, -1);
/// ```
/// 
/// [HtmlLinkClick](/wxdart/wxGetHtmlLinkClickEventType.html) event gets sent when the user clicks on a link |
/// | ----------------- |
/// | void bindHtmlLinkClickEvent( void Function( [WxHtmlLinkEvent] event ), int id ) |
/// | void unbindHtmlLinkClickEvent( int id ) |
/// 
/// Main interface
/// * [setPage]
/// * [loadPage]

class WxHtmlWindow extends WxControl {
  /// Creates the HTML window
  WxHtmlWindow( WxWindow parent, int id, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = 0 } ) 
  : super( parent, id, pos: pos, size: size, style: style );
  
  String _data = "";

  /// Sets the HTML source
  void setPage( String source ) {
    _data = source;
    _setState();
  }

  /// Loads an HTML from [location] relative to [WxStandardPaths.getResourcesDir]
  void loadPage( String location ) {
    rootBundle.loadString(location).then( (text) {
      _data = text;
      _setState();
    }); 
  }

  @override
  Widget _build(BuildContext context)
  {
    final finalWidget = SingleChildScrollView(
    /*
        child: Html(
          onLinkTap: (link, map, element) {
            if (link != null) {
              final event = WxHtmlLinkEvent(getId(), link );
              event.setEventObject( this );
              if (processEvent(event)) return;
              loadPage( link );
            }
          },
          data: _data )
    */
        child: HtmlWidget( _data,
        onTapUrl: (link) {
              final event = WxHtmlLinkEvent(getId(), link );
              event.setEventObject( this );
              if (processEvent(event)) return true;
              return false;
        }, )
    );

    return _buildControl( context, finalWidget );
  }
}
