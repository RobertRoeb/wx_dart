// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01 (wxDart Web: 2026-11-15)
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- EVT_SEARCH ----------------------

// ------------------------- wxSearchCtrl ----------------------

/// A text control with additional buttons to start and stop a search action.
/// [WxSearchCtrl] does not actually perform the search itself.
/// 
/// Example usage:
/// ```dart
///  // Create search control
///  final search = WxSearchCtrl( this, -1 );
/// 
///  search.bindSearchEvent( (event) {
///    final term = event.getString();
///    // start the search here
///  }, -1 );
/// ```
/// 
/// Main text interface is from [WxTextEntry]. Otherwise
/// * [showSearchButton]
/// * [showCancelButton]
/// * [setDescriptiveText]
/// * [setMenu]
/// 
/// # Events emitted:
/// 
/// [Search](/wxdart/wxGetSearchEventType.html) event gets sent when user presses ENTER or clicks the search icon |
/// | ----------------- |
/// | void bindSearchEvent( void function( [WxCommandEvent] event ), int id ) |
/// | void unbindSearchEvent() |
/// 
/// [SearchCancel](/wxdart/wxGetSearchCancelEventType.html) event gets sent when user cancel the search |
/// | ----------------- |
/// | void bindSearchCancelEvent( void function( [WxCommandEvent] event ), int id ) |
/// | void unbindSearchCancelEvent() |

class WxSearchCtrl extends WxTextEntry {
  WxSearchCtrl( super.parent, super.id, { super.value, super.pos, WxSize size = wxDefaultSize, super.style } ) 
  : super( size: WxSize( size.x == -1 ? 180 : size.x , size.y ) )
  {
    _updateButtons();
    bindKeyDownEvent( (event) {
      if (event.getKeyCode() == WXK_ESCAPE) {
        _cancel();
      } else if (event.getKeyCode() == WXK_RETURN || event.getKeyCode() == WXK_NUMPAD_ENTER) {
        _search();
      } else {
        event.skip();
      }
    } );
  }

  bool _showSearchButton = true;
  bool _showCancelButton = false;
  String _descriptive = "Search";
  WxMenu? _menu;

  @override
  String get _jsKind => 'search';

  void _updateButtons() {
    _jsSearchSet( _handle, _showSearchButton, _showCancelButton, _descriptive );
  }

  @override
  WxSize _doGetBestSize() {
    return const WxSize( 180, 28 );
  }

  /// Returns true if search button is visible
  bool isSearchButtonVisible( ) {
    return _showSearchButton;
  }

  /// Returns true if cancel button is visible
  bool isCancelButtonVisible( ) {
    return _showCancelButton;
  }

  /// Determines of if search button is visible
  void showSearchButton( bool show ) {
    _showSearchButton = show;
    _updateButtons();
  }

  /// Determines of if canceö button is visible
  void showCancelButton( bool show ) {
    _showCancelButton = show;
    _updateButtons();
  }

  /// Sets descritptive text in the control, where supported
  void setDescriptiveText( String text ) {
    _descriptive = text;
    _updateButtons();
  }

  String getDescriptiveText( ) {
    return _descriptive;
  }

  /// Adds a [WxMenu] to the control, where supported
  ///
  /// In wxDart Web, the menu pops up when the search button is clicked
  /// while the control is empty
  void setMenu( WxMenu? menu ) {
    _menu = menu;
  }

  WxMenu? getMenu( ) {
    return _menu;
  }

  void _search() {
    if (_menu != null && getValue().isEmpty) {
      popupMenu( _menu!, pos: WxPoint( 0, getSize().y ) );
      return;
    }
    final event = WxCommandEvent( wxGetSearchEventType(), getId() );
    event.setString( getValue() );
    event.setEventObject( this );
    processEvent( event );
  }

  void _cancel() {
    changeValue( "" );
    _sendTextEvent( "" );
    final event = WxCommandEvent( wxGetSearchCancelEventType(), getId() );
    event.setEventObject( this );
    processEvent( event );
  }
}
