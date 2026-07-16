// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxBitmapComboBox ----------------------

/// Offers the user a choice of items (bitmap and text) and an addtional text field.
class WxBitmapComboBox extends WxComboBox {

  /// Create a bitmap combobox. Items with bitmaps can only be added later.
  WxBitmapComboBox( super.parent, super.id, 
  { super.value, super.pos, super.size, super.choices, super.style } );

  /// append an item with a bitmap and optional client data 
  void appendWithBitmap( String item, WxBitmapBundle bundle, { dynamic data } ) {
    _items.add( _WxItem( item, data: data, bitmap: bundle.getBitmapFor(this) ) );
    _resort();
    _setState();
  }

  /// append an item with a bitmap and optional client data 
  void insertWithBitmap( String item, WxBitmapBundle bundle, int pos, { dynamic data } ) {
    _items.insert( pos, _WxItem( item, data: data, bitmap: bundle.getBitmapFor(this) ) );
    _resort();
    _setState();
  }

  /// append an item with a bitmap and optional client data 
  void setItemBitmap( int pos, WxBitmapBundle bundle ) {
    final item = _items[pos];
    item.bitmap = bundle.getBitmapFor(this);
    _setState();
  }

  @override
  Widget _build(BuildContext context)
  {
    final  List<DropdownMenuEntry<String>> entries = [];
    for (final item in _items) {
      Widget? leadingIcon;
      if (item.bitmap != null) {
        if (item.bitmap!.isOk()) {
          leadingIcon = RawImage( image: item.bitmap!._image! );
        } else {
          item.bitmap!._addListener( this );
        }
      }
      
      entries.add( DropdownMenuEntry(value: item.text, label: item.text, leadingIcon: leadingIcon ) );
    }

    final inToolbar = getParent() is WxToolBar;

    Widget combo = 
      DropdownMenu<String>(
        controller: _textEditingController,
        enableSearch: false,
        menuStyle: wxTheApp.isTouch() ? null : MenuStyle( 
          visualDensity: VisualDensity.compact,
          padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(EdgeInsetsGeometry.all(0)),
        ),
        trailingIcon: CustomPaint(
            size: const Size(13, 8), 
            painter: TrianglePainter( false, border: 2),
          ),
        selectedTrailingIcon: CustomPaint(
            size: const Size(13, 8), 
            painter: TrianglePainter( true, border: 2 ),
          ),
        
        inputDecorationTheme: inToolbar ? null : InputDecorationTheme( 
            isDense: !wxTheApp.isTouch(),
            filled: true,
            border: (hasFlag(wxNO_BORDER) || hasFlag(wxBORDER_SIMPLE) || hasFlag(wxBORDER_DOUBLE)) 
              ? InputBorder.none
              : UnderlineInputBorder(),
            suffixIconConstraints: BoxConstraints( minHeight: 8, minWidth: 13 ),
          ),
        onSelected: (value) {
          WxCommandEvent event = WxCommandEvent( wxGetComboboxEventType(), getId() );
          event.setEventObject( this );
          if (value != null) {
            event.setString( value );
            event.setClientData( getClientData(findString(value)) );
          }
          processEvent(event);
          
        },
        requestFocusOnTap: true,
        dropdownMenuEntries: entries
      );

      _focusNode ??= FocusNode();
      combo = Focus (
        focusNode: _focusNode,
        // autofocus: true,
        onFocusChange: (enter) => _sendFocusEvents(enter),
        onKeyEvent: hasFlag(wxTE_PROCESS_ENTER) ? (node, event)
        {
          if (event is KeyDownEvent)
          {
            if (event.logicalKey == LogicalKeyboardKey.enter) {
              WxCommandEvent event = WxCommandEvent( wxGetTextEnterEventType(), getId() );
              event.setEventObject( this );
              event.setString( _textEditingController.text );
              if (processEvent(event)) {
                return KeyEventResult.handled;      
              }
            }
          }
          return KeyEventResult.ignored;
        } : null,
        child: combo
      );

    return _buildControl( context, combo );
  }

}

