// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxHtmlLinkEvent ----------------------

typedef OnHtmlLinkEventFunc = void Function( WxHtmlLinkEvent event );

/// @nodoc

class WxHtmlLinkEventTableEntry extends WxEventTableEntry {
  WxHtmlLinkEventTableEntry( super.eventType, super.id, this.func );
  final OnHtmlLinkEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return (eventType == eventTypeTested) && ((id == wxID_ANY) || (id == idTested));
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxHtmlLinkEvent) {
      func( event );
    }
  }
}

/// @nodoc

extension HtmlLinkEventBinder on WxEvtHandler {
  void bindHtmlLinkClickEvent( OnHtmlLinkEventFunc func, int id ) {
    _eventTable.add( WxHtmlLinkEventTableEntry(wxGetHtmlLinkClickEventType(), id, func));
  }

  void unbindHtmlLinkClickEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetHtmlLinkClickEventType(), id));
  }
}


/// Event sent by [WxHtmlWindow]
class WxHtmlLinkEvent extends WxCommandEvent {
  /// Creates the event with the given [href]. Done inside [WxHtmlWindow]
  WxHtmlLinkEvent( int id, String href ) : super( wxGetHtmlLinkClickEventType(), id ) {
    _href = href;
  }

  String _href = "";
  final String _target = "";

  /// Returns the HREF of the link
  String getHref( ) {
    return _href;
  }

  /// Returns the target of the link (wxDart Native only)
  String getTarget( ) {
    return _target;
  }
}

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
/// | void bindHtmlLinkClickEvent( OnHtmlLinkEventFunc ) |
/// | void unbindHtmlLinkClickEvent() |
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
    );

    return _buildControl( context, finalWidget );
  }
}
