// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxHyperlinkEvent ----------------------

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

/// @nodoc

extension HyperlinkEventBinder on WxEvtHandler {
  void bindHyperlinkEvent( OnHyperlinkEventFunc func, int id ) {
    _eventTable.add( WxHyperlinkEventTableEntry(wxGetHyperlinkEventType(), id, func));
  }

  void unbindHyperlinkEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetHyperlinkEventType(), id));
  }
}

/// Sent by [WxHyperlinkCtrl]
/// 
/// [Hyperlink](/wxdart/wxGetHyperlinkEventType.html) event gets sent when user clicked on hyper link |
/// | ----------------- |
/// | void bindHyperlinkEvent( OnHyperlinkEventFunc ) |
/// | void unbindHyperlinkEvent() |

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

// ------------------------- wxHyperlinkCtrl ----------------------

const int wxHL_CONTEXTMENU = 0x0001;
const int wxHL_ALIGN_LEFT = 0x0002;
const int wxHL_ALIGN_RIGHT = 0x0004;
const int wxHL_ALIGN_CENTRE = 0x0008;
const int wxHL_DEFAULT_STYLE = (wxHL_CONTEXTMENU|wxNO_BORDER|wxHL_ALIGN_CENTRE);

/// Represents a hyper link that the user can click.
/// 
/// # Events emitted
/// [Hyperlink](/wxdart/wxGetHyperlinkEventType.html) gets sent when user clicked on hyper link |
/// | ----------------- |
/// | void bindHyperlinkEvent( void function( [WxHyperlinkEvent] event ) ) |
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
class WxHyperlinkCtrl extends WxControl {
  WxHyperlinkCtrl( super.parent, super.id, String label, String url, { super.pos = wxDefaultPosition, super.size = wxDefaultSize, super.style = wxHL_DEFAULT_STYLE } )  {
    _url = url;
    _label = label;
  }

  String _url = "";
  String _label = "";
  bool _visited = false;
  WxColour _visitedColour = wxBLUE;
  WxColour _normalColour = wxBLUE;
  WxColour _hoverColour = wxBLUE;
  WxColour _normalColourThemed = wxBLUE;

  void setHoverColour( WxColour colour ) {
    _hoverColour = colour;
    _setState();
  }

  /// Sets the normal colour of the link. Note that different
  /// platform may have different standard backgrounds and setting
  /// this colour risks unwanted contrasts
  void setNormalColour( WxColour colour ) {
    _normalColour = colour;
    _setState();
  }

  /// Sets colour for a link that has already been visited
  void setVisitedColour( WxColour colour ) {
    _visitedColour = colour;
    _setState();
  }

  WxColour getHoverColour( ) {
    return _hoverColour;
  }

  WxColour getNormalColour( ) {
    return _normalColour;
  }

  WxColour getVisitedColour( ) {
    return _visitedColour;
  }

  /// Indicate that the link has been visited and that the
  /// colour should be changed - if supported
  void setVisited( { bool visited = true } ) {
    _visited = visited;
    _setState();
  }

  /// Returns true if link has been set to visited. See [setVisited]
  bool getVisited( ) {
    return _visited;
  }

  /// Sets URL of the link
  void setURL( String url ) {
    _url = url;
  }

  /// Returns URL of the link
  String getURL( ) {
    return _url;
  }

  /// Sets label text
  void setLabel( String label ) {
    _label = label;
    _setState();
  }

  /// Gets label text
  String getLabel( ) {
    return _label;
  }

  @override
  void _updateTheme() {
    if (wxTheApp.isDark()) {
      _normalColourThemed = _normalColour.changeLightness( 130 );
    } else {
      _normalColourThemed = _normalColour;
    }
  }


  @override
  Widget _build( BuildContext context )
  {
    return _buildControl( context,
     InkWell( child: 
      MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Text( _label, style: TextStyle( color: Color.fromARGB( 
          _normalColourThemed.alpha, _normalColourThemed.red, _normalColourThemed.green, _normalColourThemed.blue ) ),) ),
              onTap: () {
                final event = WxHyperlinkEvent(this, getId(), _url );
                if (!processEvent(event)) {
                  wxLaunchDefaultBrowser(_url); 
                }
              } )  );
  }
}
