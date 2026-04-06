// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxRadioBox ----------------------

/// @nodoc

extension RadioboxEventBinder on WxEvtHandler {
  void bindRadioboxEvent( OnCommandEventFunc func, int id ) {
    _eventTable.add( WxCommandEventTableEntry(wxGetRadioboxEventType(), id, func));
  }

  void unbindRadioboxEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetRadioboxEventType(), id));
  }
}

const int wxRA_LEFTTORIGHT = 0x0001;
const int wxRA_TOPTOBOTTOM = 0x0002;
const int wxRA_SPECIFY_COLS = wxHORIZONTAL;
const int wxRA_SPECIFY_ROWS = wxVERTICAL;
const int wxRA_HORIZONTAL = wxHORIZONTAL;
const int wxRA_VERTICAL = wxVERTICAL;

/// Lets users choose one of several items. Selecting one item automatically
/// deselects the others. 
/// 
/// Example usage:
///```dart
///    // Create the control
///    final radiobox = WxRadiobox( parent, -1, "You choose", wxDefaultPosition, wxDefaultSize, ['Choice #1','Choice #2','Choice #3'] );
/// 
///    // bind to event when user selects an item
///    radiobox.bindRadioboxEvent((event) {
///      final index = event.getInt();
///      final text = event.getString();
///    }, -1 );
///```
///
/// See also [WxRadioButton] that achieves the same with individual controls
/// 
/// # Event emitted
/// [Radiobox](/wxdart/wxGetRadioboxEventType.html) event gets sent when the user selects this item. |
/// | ----------------- |
/// | void bindRadioboxEvent( void function( [WxCommandEvent] event ) ) |
/// | void unbindRadioboxEvent() |
/// 
/// # Window style
/// | constant | meaning |
/// | -------- | -------- |
/// | wxRA_LEFTTORIGHT | 0x0001 |
/// | wxRA_TOPTOBOTTOM | 0x0002 |
/// | wxRA_SPECIFY_COLS | wxHORIZONTAL |
/// | wxRA_SPECIFY_ROWS | wxVERTICAL |
/// | wxRA_HORIZONTAL | wxHORIZONTAL |
/// | wxRA_VERTICAL | wxVERTICAL |
/// 
/// Main interface
/// * [getCount]
/// * [isEmpty]
/// * [setString]
/// * [getString]
/// * [getStrings]
/// * [findString]
/// 
/// Selection interface
/// * [setSelection]
/// * [getSelection]
/// * [select] same as [setSelection]
/// * [setStringSelection]
/// * [getStringSelection]

class WxRadioBox extends WxItemContainerImmutable {
  WxRadioBox( super.parent, super.id, String label, WxPoint pos, WxSize size, List<String> choices, 
  { int majorDimension = 0, super.style = wxRA_SPECIFY_COLS } ) 
  : super(pos: pos, size: size )
  {
    for (final str in choices) {
        _items.add( _WxItem( str ) );
    }
    _selection = 0;
    _label = label;
    _majorDimension = majorDimension == 0 ? choices.length : majorDimension;
    if (_majorDimension == 0) {
      wxLogError( "empty radio box" );
      return;
    }
    int minorDimension = (getCount() + _majorDimension - 1) ~/ _majorDimension;
    if (hasFlag(wxRA_SPECIFY_COLS)) {
        _cols = _majorDimension;
        _rows = minorDimension;
    } else {
        _cols = minorDimension;
        _rows = _majorDimension;
    }
  }

  late int _majorDimension;
  int _cols = 1;
  int _rows = 1;
  List<int> _disabledItems = [];

  String _label = "";

  /// Returns the number of columns
  int getColumnCount () {
    return _cols;
  }

  /// Returns the number of rows
  int getRowCount () {
    return _rows;
  }

  /// Disable or enables a single item in the control
  bool enableItem(int n, {bool enable=true } )
  {
    if (!enable) {
      if (!_disabledItems.contains(n)) {
        _disabledItems.add( n );
        _setState();
      }
    } else {
      if (_disabledItems.contains(n)) {
        _disabledItems.remove( n );
        _setState();
      }
    }
    return true;
  }

  /// Returns true if the item is enabled, false otherwise
  bool isItemEnabled( int n ) {
    return !_disabledItems.contains(n);
  }

  @override
  Widget _build(BuildContext context)
  {
    List<Widget> children = [];
    if ((_label.isNotEmpty) && wxTheApp.isTouch()) {
      children.add( Text( _label ) );
    }
    int count = 0;
    for (final item in _items) {
      children.add( 
        wxTheApp.isTouch()
        ? ListTile( 
          title: Text( item.text ),
          leading: Radio<int>( value: count )
        )
        : Row( 
          mainAxisSize: MainAxisSize.min,
          children: [
            wxIsIOS() // not on macOS
            ? Radio<int>.adaptive( value: count )
            : Radio<int>( value: count ),
          Text( item.text ),
          ]
        )
      );
      count++;
    }

    final List<Column> cols = [];
    for (int i = 0; i < _cols; i++) {
      final List<Widget> childrenInColumn = [];
      for (int j = 0; j < _rows; j++) {
        final index = i*_rows + j;
        if (index >= _items.length) break;
        childrenInColumn.add( children[index] );
      }

      cols.add( Column(
        mainAxisSize: MainAxisSize.min,
        children: childrenInColumn
      ) );
    }

    Widget group = 
      RadioGroup<int>( 
        groupValue: _selection,
        onChanged: (value) {
            if (value != null)
            {
              _selection = value;
              _setState();
              final event = WxCommandEvent( wxGetRadioboxEventType(), getId() );
              event.setEventObject(this);
              event.setInt( value );
              event.setString( getStringSelection() );
              processEvent( event );
            }
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: cols,
        )
    );

    if (!wxTheApp.isTouch())
    {
      group = IntrinsicWidth( child:
        InputDecorator(
          decoration: InputDecoration(
            labelText: _label,
            border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: group ) 
      );
    }

    return _buildControl(context, group );
  }
}
