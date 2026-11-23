// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01 (wxDart Web: 2026-11-15)
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxCollapsiblePaneEvent ----------------------

// ------------------------- wxCollapsiblePane ----------------------

const int wxCP_DEFAULT_STYLE = wxTAB_TRAVERSAL|wxBORDER_NONE;
const int wxCP_NO_TLW_RESIZE = 0x0002;

// ------------------------- wxCollapsiblePane ----------------------

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
/// Main interface
/// * [getPane]
/// * [setLabel]
/// * [getLabel]
/// * [collapse]
/// * [expand]
/// * [isCollapsed]
/// * [isExpanded]
/// 
/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxCP_DEFAULT_STYLE | wxTAB_TRAVERSAL|wxBORDER_NONE |
/// | wxCP_NO_TLW_RESIZE | 0x0002 |
/// 
/// [CollapsiblePaneChanged](/wxdart/wxGetCollapsiblePaneChangedEventType.html) event gets sent when the user collapses or expands the pane. |
/// | ----------------- |
/// | void bindCollapsiblePaneChangedEvent( void function( WxCollapsiblePaneEvent event ), int id ) |
/// | void unbindCollapsiblePaneChangedEvent() |

class WxCollapsiblePane extends WxControl {
  WxCollapsiblePane( WxWindow parent, int id, String label, { super.pos, super.size, super.style = wxCP_DEFAULT_STYLE } ) 
    : super(parent,id) {
    setLabel( label );
    _paneOrNull = WxPanel( this, -1 );
    _jsCollapsibleSet( _handle, false );
  }

  // null while the WxWindow constructor runs (it already asks for the
  // best size and sends a size event)
  WxPanel? _paneOrNull;
  WxPanel get _pane => _paneOrNull!;
  bool _expanded = false;

  @override
  String get _jsKind => 'collapsible';

  @override
  void setLabel( String label ) {
    _label = label;
    _jsSetLabel( _handle, _wxStripMnemonic( label ) );
    _labelOrFontChanged();
  }

  @override
  WxSize _doGetBestSize() {
    final header = _jsCollapsibleHeader( _handle );
    if (!_expanded || _paneOrNull == null) return WxSize( header.w, header.h );
    final pane = _pane.getBestSize();
    return WxSize( max( header.w, pane.x ), header.h + pane.y );
  }

  /// Passes the size on to the pane
  @override
  bool informFirstDirection( int direction, int size, int availableOtherDir ) {
    final pane = _paneOrNull;
    if (pane == null || size < 0) return false;
    final header = _jsCollapsibleHeader( _handle );
    final available = direction == wxHORIZONTAL ? size : max( 0, size - header.h );
    final used = pane.informFirstDirection( direction, available, -1 );
    if (used) _bestSize = null;  // depends on the pane
    return used;
  }

  @override
  WxSize getBestSize() {
    // the pane's sizer decides, not a sizer of the collapsible pane
    _bestSize ??= _doGetBestSize();
    return _bestSize!;
  }

  @override
  void _sendSizeEvent() {
    if (_expanded && _paneOrNull != null) {
      final header = _jsCollapsibleHeader( _handle );
      final size = getSize();
      _pane._setActualRect( 0, 0, size.x, max( 0, size.y - header.h ) );
    }
    super._sendSizeEvent();
  }

  /// Returns true if child window is hidden
  bool isCollapsed( ) {
    return !_expanded;
  }

  /// Returns true if child window is shown
  bool isExpanded( ) {
    return _expanded;
  }

  /// Collapses (or expands) the child window
  void collapse( { bool collapse = true } ) {
    if (_expanded == !collapse) return;
    _expanded = !collapse;
    _jsCollapsibleSet( _handle, _expanded );
    invalidateBestSize();
    if (_expanded) _sendSizeEvent();
  }

  /// Expands the child window
  void expand( ) {
    collapse( collapse: false );
  }

  /// Returns the panel into which the child window(s) have to be placed.
  WxWindow getPane( ) {
    return _pane;
  }

  void _onJsToggle() {
    collapse( collapse: _expanded );
    final event = WxCollapsiblePaneEvent( this, getId(), !_expanded );
    processEvent( event );
  }
}
