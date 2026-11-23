// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01 (wxDart Web: 2026-11-15)
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- EVT_RADIOBOX ----------------------

const int wxRA_LEFTTORIGHT = 0x0001;
const int wxRA_TOPTOBOTTOM = 0x0002;
const int wxRA_SPECIFY_COLS = wxHORIZONTAL;
const int wxRA_SPECIFY_ROWS = wxVERTICAL;
const int wxRA_HORIZONTAL = wxHORIZONTAL;
const int wxRA_VERTICAL = wxVERTICAL;

// ------------------------- wxRadioBox ----------------------

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
/// | void bindRadioboxEvent( void function( [WxCommandEvent] event ), int id ) |
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
    _selection = choices.isEmpty ? -1 : 0;
    _majorDimension = majorDimension == 0 ? choices.length : majorDimension;
    if (_majorDimension == 0) _majorDimension = 1;
    final minorDimension = (getCount() + _majorDimension - 1) ~/ _majorDimension;
    if (hasFlag(wxRA_SPECIFY_ROWS)) {
        _cols = minorDimension;
        _rows = _majorDimension;
    } else {
        _cols = _majorDimension;
        _rows = minorDimension;
    }
    setLabel( label );
  }

  late int _majorDimension;
  int _cols = 1;
  int _rows = 1;
  final Set<int> _disabledItems = {};

  @override
  String get _jsKind => 'radiobox';

  @override
  void setLabel( String label ) {
    _label = label;
    _jsSetLabel( _handle, _wxStripMnemonic( label ) );
    _itemsChanged();
  }

  @override
  void _itemsChanged() {
    _jsRadioboxSet( _handle, jsonEncode( {
      "items": getStrings(), "cols": _cols, "rows": _rows, "byRows": hasFlag(wxRA_SPECIFY_ROWS),
      "sel": _selection, "off": _disabledItems.toList() } ) );
    _labelOrFontChanged();
  }

  @override
  void _selectionChanged() {
    _jsRadioboxSelect( _handle, _selection );
  }

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
    if (n < 0 || n >= _items.length) return false;
    if (enable) {
      _disabledItems.remove( n );
    } else {
      _disabledItems.add( n );
    }
    _itemsChanged();
    return true;
  }

  /// Returns true if the item is enabled, false otherwise
  bool isItemEnabled( int n ) {
    return !_disabledItems.contains(n);
  }

  void _onJsRadiobox( int index ) {
    _selection = index;
    final event = WxCommandEvent( wxGetRadioboxEventType(), getId() );
    event.setEventObject(this);
    event.setInt( index );
    event.setString( getStringSelection() );
    processEvent( event );
  }
}
