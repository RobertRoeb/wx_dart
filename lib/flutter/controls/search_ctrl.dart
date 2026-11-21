
// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- WxSearchCtrl ----------------------

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
/// | void unbindSearchEvent( int id ) |
/// 
/// [SearchCancel](/wxdart/wxGetSearchCancelEventType.html) event gets sent when user cancel the search |
/// | ----------------- |
/// | void bindSearchCancelEvent( void function( [WxCommandEvent] event ), int id ) |
/// | void unbindSearchCancelEvent( int id ) |

class WxSearchCtrl extends WxTextEntry {
  WxSearchCtrl( super.parent, super.id, { super.value, super.pos, WxSize size = wxDefaultSize, super.style } ) 
  : super( size: WxSize( size.x == -1 ? 180 : size.x , size.y ) )
  {
    bindKeyDownEvent( (event) {
      if (event.getKeyCode() == WXK_ESCAPE) {
        final event = WxCommandEvent( wxGetSearchCancelEventType(), getId() );
        event.setEventObject( this );
        processEvent( event );
      } else {
        event.skip();
      }
    } );
  }

  bool _showSearchButton = true;
  bool _showCancelButton = false;
  String _descriptive = "";
  WxMenu? _menu;

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
    _menu = menu;
  }

  /// An icon button for the search control: compact in desktop mode
  Widget _iconButton( Widget icon, VoidCallback onPressed, { bool narrow = false } ) {
    if (wxTheApp.isTouch()) {
      return IconButton(
        padding: EdgeInsets.all( 0 ),
        iconSize: fromDIP(24).toDouble(),
        icon: icon,
        onPressed: onPressed );
    }
    final size = fromDIP(24).toDouble();
    return IconButton(
      padding: EdgeInsetsGeometry.only(left: 2),
      visualDensity: VisualDensity.compact,
      iconSize: fromDIP(18).toDouble(),
      // no minimum size of 40 or 48 pixels for touch targets
      constraints: narrow ? BoxConstraints( minHeight: size ) : BoxConstraints.tightFor( width: size, height: size ),
      style: const ButtonStyle( tapTargetSize: MaterialTapTargetSize.shrinkWrap ),
      icon: icon,
      onPressed: onPressed );
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

    final touch = wxTheApp.isTouch();

    Widget? searchButton;
    if (_showSearchButton)
    {
      final search = _iconButton( const Icon( Icons.search ), () {
        final event = WxCommandEvent( wxGetSearchEventType(), getId() );
        event.setEventObject( this );
        event.setString( getValue() );
        processEvent( event );
      } );
      if (_menu != null)
      {
        searchButton = Row(
            mainAxisSize: MainAxisSize.min,
            children: [
            search,
            _iconButton(
              Padding(
                  padding: EdgeInsetsGeometry.only(left: 2),
                  child: CustomPaint(
                  size: touch ? const Size(13, 30) : const Size(13, 20),
                    painter: TrianglePainter( false, border: 6, otherBorder: 6 ),
                  )
                ),
              () => popupMenu( _menu! ),
              narrow: true ),
            ]
          );
      }
      else
      {
        searchButton = search;
      }
    }

    // icons next to the text: prefixIcon/suffixIcon are always shown and
    // centred vertically. (prefix/suffix are only shown with focus or text
    // and are aligned to the baseline of the text, which pushes the text
    // down if they are higher than the text.)
    const noMinimum = BoxConstraints( minWidth: 28, minHeight: 0 );
    Widget text = TextField(
      decoration:  
        InputDecoration(
            hintText: _descriptive.isEmpty ? null : _descriptive,
            isDense: !touch,
            contentPadding: touch ? null : EdgeInsets.symmetric( horizontal: 6, vertical: hasFlag(wxNO_BORDER) ? 2 : 8 ),
            prefixIcon: searchButton,
            prefixIconConstraints: touch ? null : noMinimum,
            suffixIcon: (_showCancelButton) ? _iconButton( const Icon( Icons.cancel ), () {
                final event = WxCommandEvent( wxGetSearchCancelEventType(), getId() );
                event.setEventObject( this );
                processEvent( event );
              } ) : null,
            suffixIconConstraints: touch ? null : noMinimum,
            border: (!hasFlag(wxNO_BORDER)) ? OutlineInputBorder( borderRadius: BorderRadius.circular(touch ? 8.0 : 4.0) ) : InputBorder.none,
          ), 
      textAlignVertical: TextAlignVertical.center,
      controller: _textEditingController,
      focusNode: _focusNode,
      maxLines: 1,
      maxLength: _maxLength == -1 ? null : _maxLength,
      onChanged: (text) {
        _sendTextEvent(text);
      },
      onSubmitted:  (text) {
        final event = WxCommandEvent( wxGetSearchEventType(), getId() );
        event.setEventObject( this );
        event.setString( text );
        processEvent( event );
      } ,
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
