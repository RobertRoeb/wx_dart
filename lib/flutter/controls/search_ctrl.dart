
// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- WxSearchCtrl ----------------------

/// @nodoc

extension SearchEventBinder on WxEvtHandler {
  void bindSearchEvent( OnCommandEventFunc func, int id ) {
    _eventTable.add( WxCommandEventTableEntry(wxGetSearchEventType(), id, func));
  }

  void unbindSearchEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetSearchEventType(), id));
  }
}

/// @nodoc

extension SearchCancelEventBinder on WxEvtHandler {
  void bindSearchCancelEvent( OnCommandEventFunc func, int id ) {
    _eventTable.add( WxCommandEventTableEntry(wxGetSearchCancelEventType(), id, func));
  }

  void unbindSearchEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetSearchCancelEventType(), id));
  }
}

/// A text control with additional buttons to start and stop a search action.
/// [WxSearchCtrl] does not actually perform the search itself.
/// 
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
/// | void bindSearchEvent( OnCommandEventFunc ) |
/// | void unbindSearchEvent() |
/// 
/// [SearchCancel](/wxdart/wxGetSearchCancelEventType.html) event gets sent when user cancel the search |
/// | ----------------- |
/// | void bindSearchCancelEvent( OnCommandEventFunc ) |
/// | void unbindSearchCancelEvent() |

class WxSearchCtrl extends WxTextEntry {
  WxSearchCtrl( super.parent, super.id, { super.value, super.pos, WxSize size = wxDefaultSize, super.style } ) 
  : super( size: WxSize( size.x == -1 ? 180 : size.x , size.y ) );

  bool _showSearchButton = true;
  bool _showCancelButton = true;
  String _descriptive = "";

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
    _setState();
  }

  /// Determines of if canceö button is visible
  void showCancelButton( bool show ) {
    _showCancelButton = show;
    _setState();
  }

  /// Sets descritptive text in the control, where supported
  void setDescriptiveText( String text ) {
    _descriptive = text;
    _setState();
  }

  /// Adds a [WxMenu] to the control, where supported
  void setMenu( WxMenu? menu ) {
  }

  @override
  Widget _build(BuildContext context)
  {
    if (_focusNode == null)
    {
      _focusNode = FocusNode();
      _focusNode!.addListener( () {
        if (_focusNode!.hasFocus) {
            _hasFocus2 = true;
            final event = WxFocusEvent( wxGetSetFocusEventType(), getId() );
            event.setEventObject( this );
            processEvent(event);
        } else {
            _hasFocus2 = false;
            final event = WxFocusEvent( wxGetKillFocusEventType(), getId() );
            event.setEventObject( this );
            processEvent(event);
        }

      } );
    }

    Widget text = TextField(
      decoration:  
        InputDecoration(
            hintText: _hint.isEmpty ? null : _hint,
            helperText: _descriptive.isEmpty ? null : _descriptive,
            isDense: !wxTheApp.isTouch(),
            contentPadding: wxTheApp.isTouch() ? null : EdgeInsets.all( hasFlag(wxNO_BORDER) ? 1 : 4 ),
            prefix: _showSearchButton ? IconButton(
              iconSize: fromDIP(24).toDouble(),
              icon: const Icon( Icons.search ),
              onPressed: () {
                final event = WxCommandEvent( wxGetSearchEventType(), getId() );
                event.setEventObject( this );
                processEvent( event );
            }) : null,
            suffix: _showCancelButton ? IconButton(
              iconSize: fromDIP(24).toDouble(),
              icon: const Icon( Icons.cancel ),
              onPressed: () {
                final event = WxCommandEvent( wxGetSearchCancelEventType(), getId() );
                event.setEventObject( this );
                processEvent( event );
            }) : null,
            border: (!hasFlag(wxNO_BORDER)) ? OutlineInputBorder( borderRadius: BorderRadius.circular(8.0) ) : null ,
          ),
      controller: _textEditingController,
      focusNode: _focusNode,
      textAlignVertical: TextAlignVertical.top,
      maxLines: 1,
      maxLength: _maxLength == -1 ? null : _maxLength,
      onChanged: (text) {
        _sendTextEvent(text);
      },
      onSubmitted: hasFlag(wxTE_PROCESS_ENTER) ? (text) {
        WxCommandEvent event = WxCommandEvent( wxGetTextEnterEventType(), getId() );
        event.setEventObject( this );
        event.setString( text );
        if (!processEvent(event)) {
          WxWindow current = this;
          while (current.getParent() != null) {
            if (current.getParent() is WxDialog) {
              final dialog = current.getParent() as WxDialog;
              final action = dialog.getAffirmativeId();
              dialog._endDialog(action);
              return;
            }
            current = current.getParent()!;
          }
        }
      } : null,
    );

    
    /*final inToolbar = getParent() is WxToolBar;

    // if (!hasFlag(wxNO_BORDER) && !hasFlag(wxBORDER_SIMPLE) && !hasFlag(wxBORDER_DOUBLE) )
    
    if (inToolbar)
    {
      text = InputDecorator(
          decoration: InputDecoration(
            hintText: _hint.isEmpty ? null : _hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          child: text,
        ); 
    } */

    return _buildControl(context, text );
  }
}
