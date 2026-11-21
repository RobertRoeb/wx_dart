// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- WxHyperlinkEvent binder ----------------------

/// @nodoc

extension HyperlinkEventBinder on WxEvtHandler {
  void bindHyperlinkEvent( OnHyperlinkEventFunc func, int id ) {
    _eventTable.add( WxHyperlinkEventTableEntry(wxGetHyperlinkEventType(), id, func));
  }

  void unbindHyperlinkEvent( int id ) {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetHyperlinkEventType(), id) ));
  }
}

// ------------------------- WxHyperlinkEvent ----------------------

typedef OnHyperlinkEventFunc = void Function( WxHyperlinkEvent event );

/// @nodoc

class WxHyperlinkEventTableEntry extends WxEventTableEntry {
  WxHyperlinkEventTableEntry( super.eventType, super.id, this.func );
  final OnHyperlinkEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return (eventType == eventTypeTested) && ((id == wxID_ANY) || (id == idTested));
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxHyperlinkEvent) {
      func( event );
    }
  }
}
/// Sent by [WxHyperlinkCtrl]
/// 
/// [Hyperlink](/wxdart/wxGetHyperlinkEventType.html) event gets sent when user clicked on a hyper link |
/// | ----------------- |
/// | void bindHyperlinkEvent( void function( [WxHyperlinkEvent] event ), int id ) |
/// | void unbindHyperlinkEvent( int id ) |

class WxHyperlinkEvent extends WxCommandEvent {
  WxHyperlinkEvent( WxObject originator, int id, String url ) : super( wxGetHyperlinkEventType(), id ) {
    setEventObject(originator);
    _url = url;
  }

  String _url = "";

  void setURL( String url ) {
    _url = url;
  }

  /// Returns the URL of the link
  String getURL( ) {
    return _url;
  }
}
