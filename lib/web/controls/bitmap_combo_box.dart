// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01 (wxDart Web: 2026-11-15)
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxBitmapComboBox ----------------------

/// Offers the user a choice of items (bitmap and text) and an addtional text field.
/// 
/// Example usage:
///```dart
///    // Create the control
///    final combo = WxBitmapComboBox( parent, -1, size: WxSize(200, -1) );
/// 
///    // Create bitmaps
///    final bitmapOnline = WxBitmapBundle.fromMaterialIcon( .cloud_done, WxSize(32,32), colour: wxBLUE );
///    final bitmapOffline = WxBitmapBundle.fromMaterialIcon( .cloud_off, WxSize(32,32), colour: wxBLUE );
/// 
///    combo.appendWithBitmap( "Online", bitmapOnline );
///    combo.appendWithBitmap( "Offline", bitmapOffline );
/// 
///    // bind to event when user selects an item from the drop down menu
///    combo.bindComboboxEvent((event) {
///      final index = event.getInt();
///      final text = event.getString();
///    }, -1 );
/// 
///    // bind to event when user types in the text field
///    combo.bindTextEvent((event) {
///      final text = event.getString();
///    }, -1 );
///```
/// 
/// # Events emitted
/// [Combobox](/wxdart/wxGetComboboxEventType.html) event gets sent when the user selects an item from the drop down. |
/// | ----------------- |
/// | void bindComboboxEvent( void function( [WxCommandEvent] event ), int id ) |
/// | void unbindComboboxEvent() |
/// [Text](/wxdart/wxGetTextEventType.html) event gets sent when the user enters text. |
/// | ----------------- |
/// | void bindTextEvent( void function( [WxCommandEvent] event ), int id ) |
/// | void unbindTextEvent() |
/// [TextEnter](/wxdart/wxGetTextEnterEventType.html) event gets sent when hits enter and the wxTE_PROCESS_ENTER style is used. |
/// | ----------------- |
/// | void bindTextEnterEvent( void function( [WxCommandEvent] event ), int id ) |
/// | void unbindTextEnterEvent() |
class WxBitmapComboBox extends WxComboBox {

  /// Create a bitmap combobox. Items with bitmaps can only be added later.
  WxBitmapComboBox( super.parent, super.id, 
  { super.value, super.pos, super.size, super.choices, super.style } );

  /// append an item with a bitmap and optional client data 
  void appendWithBitmap( String item, WxBitmapBundle bundle, { dynamic data } ) {
    _items.add( _WxItem( item, data: data, bitmap: bundle.getBitmapFor(this) ) );
    _resort();
    _itemsChanged();
  }

  /// append an item with a bitmap and optional client data
  void insertWithBitmap( String item, WxBitmapBundle bundle, int pos, { dynamic data } ) {
    _items.insert( pos, _WxItem( item, data: data, bitmap: bundle.getBitmapFor(this) ) );
    if (_selection >= pos) _selection++;
    _resort();
    _itemsChanged();
  }

  /// append an item with a bitmap and optional client data
  void setItemBitmap( int pos, WxBitmapBundle bundle ) {
    _items[pos].bitmap = bundle.getBitmapFor(this);
    _itemsChanged();
  }

  /// get the bitmap of item at [pos]
  WxBitmap? getItemBitmap( int pos ) {
    return _items[pos].bitmap;
  }
}
