// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxChoice ----------------------

/// @nodoc

extension ChoiceEventBinder on WxEvtHandler {
  void bindChoiceEvent( OnCommandEventFunc func, int id ) {
    _eventTable.add( WxCommandEventTableEntry(wxGetChoiceEventType(), id, func));
  }

  void unbindChoiceEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetChoiceEventType(), id));
  }
}

/// Offers the user a choice of items.
///
/// Example usage:
///```dart
///    // Create choice control
///    final choice = WxChoice( parent, -1, choices: ['Choice #1','Choice #2','Choice #3'], size: WxSize(200, -1) );
/// 
///    // bind event when user selects an item
///    choice.bindChoiceEvent((event) {
///      final text = event.getInt();
///    }, -1 );
///```
/// 
/// [Choice](/wxdart/wxGetChoiceEventType.html) event gets sent when the user has selected an item |
/// | ----------------- |
/// | void bindChoiceEvent( void function( [WxCommandEvent] event )  ) |
/// | void unbindChoiceEvent() |
/// 
/// # Window style
/// | constant | meaning |
/// | -------- | -------- |
/// | wxCB_SORT | 0x0008 (not yet in wxDart Flutter) |


class WxChoice extends WxItemContainer {
  WxChoice( super.parent, super.id, { super.pos, 
     super.size, List<String>? choices,  super.style } ) 
{
    if (choices != null) {
      for (final str in choices) {
        _items.add( _WxItem( str ) );
      }
    }
    _selection = 0;
  }

  bool _ignoreNextKillEvent = false;

  /// Set number of columns on platforms supporting it
  void setColumns( int cols ) {
  }

  /// Returns number of columns
  int getColumns( ) {
    return 1;
  }

  /// returns true if items are sorted by the control
  bool isSorted( ) {
    return false;
  }

  @override
  Widget _build(BuildContext context)
  {
    if (_focusNode == null)
    {
      _focusNode = FocusNode();
      _focusNode!.addListener( ()
      {
        if (_focusNode!.hasFocus) {
            _hasFocus2 = true;
            final event = WxFocusEvent( wxGetSetFocusEventType(), getId() );
            event.setEventObject( this );
            processEvent(event);
        } else {
            if (_ignoreNextKillEvent) {
              _ignoreNextKillEvent = false;
            } else {
              _hasFocus2 = false;
              final event = WxFocusEvent( wxGetKillFocusEventType(), getId() );
              event.setEventObject( this );
              processEvent(event);
            }
        }

      } );
    }

    Widget finalWidget = 
/*
_buildControl(context, 
       Listener(
        behavior: HitTestBehavior.opaque,
        onPointerDown: (event) {
          _ignoreNextKillEvent = true;
        },
        child:
        Container(
          color: wxTheApp.isDark() ? Colors.grey[900] : Colors.white,
          decoration: UnderlineTabIndicator(
            borderSide: 
              BorderSide(
                color: wxTheApp._getSeedColor() ),
          ),
        child: 
*/
      DropdownButton<String>(
        itemHeight: wxTheApp.isTouch() ? null : getTextExtent("H").y + 10.0,
        isDense: !wxTheApp.isTouch(),
        focusNode: _focusNode,
        icon: Padding( 
          padding: EdgeInsetsGeometry.only( left: 4 ),
          child: CustomPaint(
            size: const Size(13, 12), 
            painter: TrianglePainter( false, border: 4 ),
          )
        ),
        value: _selection == -1 ? null : getStringSelection(),
        onChanged: (value) {
          dynamic data;
          if (value != null) {
            _selection = findString(value);
            data = getClientData( _selection );
          } else {
            _selection = -1;
          }
          _setState();
          final event = WxCommandEvent( wxGetChoiceEventType(), getId() );
          event.setClientData( data );
          event.setEventObject(this);
          event.setInt(_selection);
          if (value != null) {
            event.setString(value);
          }
          processEvent(event);
        },
        items: _items.map<DropdownMenuItem<String>>((_WxItem value) {
        return DropdownMenuItem<String>(value: value.text, child: Text(value.text));
      }).toList(),
      );

    if (!wxTheApp.isTouch())
    {
      finalWidget = 
       Listener(
        behavior: HitTestBehavior.opaque,
        onPointerDown: (event) {
          _ignoreNextKillEvent = true;
        },
        child:
        Container(
          color: wxTheApp.isDark() ? Colors.grey[900] : Colors.white,
          decoration: UnderlineTabIndicator(
            borderSide: 
              BorderSide(
                color: wxTheApp._getSeedColor() ),
          ),
        child: finalWidget ) );
    }

    return _buildControl(context, finalWidget );
  }
}
