// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxCollapsiblePaneEvent ----------------------

typedef OnCollapsiblePaneEventFunc = void Function( WxCollapsiblePaneEvent event );

/// @nodoc

class WxCollapsiblePaneEventTableEntry extends WxEventTableEntry {
  WxCollapsiblePaneEventTableEntry( super.eventType, super.id, this.func );
  final OnCollapsiblePaneEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return (eventType == eventTypeTested) && ((id == wxID_ANY) || (id == idTested));
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxCollapsiblePaneEvent) {
      func( event );
    }
  }
}

/// @nodoc

extension CollapsiblePaneEventBinder on WxEvtHandler {
  void bindCollapsiblePaneChangedEvent( OnCollapsiblePaneEventFunc func, int id ) {
    _eventTable.add( WxCollapsiblePaneEventTableEntry(wxGetCollapsiblePaneChangedEventType(), id, func));
  }

  void unbindCollapsiblePaneChangedEvent( int id ) {
    _eventTable.remove( _eventTable.lastWhere( (entry) => entry.matches(wxGetCollapsiblePaneChangedEventType(), id) ));
  }
}

/// [WxCollapsiblePaneEvent] gets sent from [WxCollapsiblePane]
/// 
/// [CollapsiblePaneChanged](/wxdart/wxGetCollapsiblePaneChangedEventType.html) event gets sent when the user collapses or expands the pane. |
/// | ----------------- |
/// | void bindCollapsiblePaneChangedEvent( void function( WxCollapsiblePaneEvent event ) ) |
/// | void unbindCollapsiblePaneChangedEvent() |
class WxCollapsiblePaneEvent extends WxCommandEvent {
  /// Creates the event.
  WxCollapsiblePaneEvent( WxWindow generator, int id, bool collapse ) : super( wxGetCollapsiblePaneChangedEventType(), id)
  {
      _collapsed = collapse;
      setEventObject( generator );
  }

  /// Sets if the pane was collapsed or expanded. Used internally.
  void setCollapsed( bool collapsed ) {
    _collapsed = collapsed;
  }

  /// Returns true of the pane got collapsed, false when it expanded.
  bool getCollapsed( ) {
    return _collapsed;
  }
  bool _collapsed = false;
}

// ------------------------- wxCollapsiblePane ----------------------

const int wxCP_DEFAULT_STYLE = wxTAB_TRAVERSAL|wxBORDER_NONE;
const int wxCP_NO_TLW_RESIZE = 0x0002;

/// A widgets that can be expanded or collapsed to show an additional window,
/// usually implemented with a turning chevron or arrow.
/// 
/// The [WxCollapsiblePane] creates the pane to hide or show itself and the
/// child windows need to children of that pane, not of the [WxCollapsiblePane].
/// This pane is retrieved using [getPane].
/// 
/// [wxCP_NO_TLW_RESIZE] specifies whether the toplevel window (typically a [WxDialog])
/// should be resized. That is common on desktop platforms.
/// 
/// Example usage:
/// ```dart
///  // Create collapsible pane 
///  final collpane = WxCollapsiblePane(this, -1, "WxCollapsiblePanel", style: wxNO_BORDER|wxCP_NO_TLW_RESIZE );
/// 
///  // Insert some text in it
///  WxStaticText( collpane.getPane(), -1, "This is text that can be hidden in a WxCollapsiblePanel" );
/// 
///  // React to change by laying out parent window again
///  collpane.bindCollapsiblePaneChangedEvent( (_)=> layout(), -1);
/// ```
/// 
/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxCP_DEFAULT_STYLE | wxTAB_TRAVERSAL|wxBORDER_NONE |
/// | wxCP_NO_TLW_RESIZE | 0x0002 |
/// 
/// [CollapsiblePaneChanged](/wxdart/wxGetCollapsiblePaneChangedEventType.html) event gets sent when the user collapses or expands the pane. |
/// | ----------------- |
/// | void bindCollapsiblePaneChangedEvent( void function( WxCollapsiblePaneEvent event ) ) |
/// | void unbindCollapsiblePaneChangedEvent() |

class WxCollapsiblePane extends WxControl {
  WxCollapsiblePane( WxWindow parent, int id, String label, { super.pos, super.size, super.style = wxCP_DEFAULT_STYLE } ) 
    : super(parent,id) {
    _pane = WxPanel( parent, -1 );
    _label = label;
    _controller = ExpansibleController();
    _controller.addListener( () {
      final event = WxCollapsiblePaneEvent(this, getId(), !_controller.isExpanded );
      processEvent( event );
    } );
  }

  String _label = "";
  late WxPanel _pane;
  late ExpansibleController _controller;

  /// Sets label
  void setLabel( String label ) {
    _label = label;
    _setState();
  }
  /// Returns current label
  String getLabel() {
    return _label;
  }

  /// Returns true if child window is hidden
  bool isCollapsed( ) {
    return !_controller.isExpanded;
  }

  /// Returns true if child window is shown
  bool isExpanded( ) {
    return _controller.isExpanded;
  }

  /// Collapses (or expands) the child window
  void collapse( { bool collapse = true } ) {
    if (collapse) {
      _controller.collapse();
    } else {
      _controller.expand();
    }
  }

  /// Expands the child window
  void expand( ) {
    _controller.expand();
  }

  /// Returns the panel into which the child window(s) have to be placed.
  WxWindow getPane( ) {
    return _pane;
  }

  @override
  Widget _build(BuildContext context)
  {
    Widget finalWidget = Expansible( 
      controller: _controller,
      headerBuilder: (context, animation) => ListTile(
          title: Text( _label ),
          onTap: () {
            if (_controller.isExpanded) {
              _controller.collapse();
            } else {
              _controller.expand();
            }
          },
          trailing: RotationTransition(
            turns: Tween<double>(begin: 0.0, end: 0.5).animate(animation),
            child: const Icon(Icons.arrow_drop_down),
          ) ),
      bodyBuilder: (context, animation) => SizeTransition(
          sizeFactor: animation,
          child: _pane.getChildCount() == 1
                  ? _pane._children.first._build( context )
                  : IntrinsicHeight( child: _pane._build( context ) ),
        ),
      expansibleBuilder: (context, header, body, animation) => Column(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          children: [header, body],
        )  );

    finalWidget = _buildControl( context, finalWidget );
    return finalWidget;
  }

}
