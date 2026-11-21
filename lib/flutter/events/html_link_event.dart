// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- WxHtmlLinkEvent binders ----------------------

/// @nodoc

extension HtmlLinkEventBinder on WxEvtHandler {
  void bindHtmlLinkClickEvent( OnHtmlLinkEventFunc func, int id ) {
    _eventTable.add( WxHtmlLinkEventTableEntry(wxGetHtmlLinkClickEventType(), id, func));
  }

  void unbindHtmlLinkClickEvent( int id ) {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetHtmlLinkClickEventType(), id) ));
  }
}

// ------------------------- WxHtmlLinkEvent ----------------------

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

/// Event sent by [WxHtmlWindow]
/// 
/// [HtmlLink](/wxdart/wxGetHtmlLinkEventType.html) event gets sent when user clicked on a html link |
/// | ----------------- |
/// | void bindHtmlLinkEvent( void function( [WxHtmlLinkEvent] event ), int id ) |
/// | void unbindHtmlLinkEvent( int id ) |

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
