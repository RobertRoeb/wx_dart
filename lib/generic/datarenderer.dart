// ---------------------------------------------------------------------------
// Name:        datarenderer.dart
// Name:        src/generic/datavgen.cpp from wxWidgets C++
// Purpose:     wxDataViewCtrl generic implementation
// Author:      Robert Roebling
// Modified by: Francesco Montorsi, Guru Kathiresan, Bo Yang
// Copyright:   (c) 1998 Robert Roebling (C++ version)
// Copyright:   (c) 2026 Robert Roebling (Dart version)
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../wx_dart.dart';

// ------------------------- wxDataViewRenderer ----------------------

const int wxDATAVIEW_CELL_PADDING_RIGHTLEFT = 3;
const int wxDATAVIEW_DEFAULT_ROW_HEIGHT = 20;

const int wxDATAVIEW_CELL_INERT = 0;
const int wxDATAVIEW_CELL_ACTIVATABLE = 1;
const int wxDATAVIEW_CELL_EDITABLE = 2;
const int wxDATAVIEW_CELL_SELECTED = 1;
const int wxDATAVIEW_CELL_PRELIT = 2;
const int wxDATAVIEW_CELL_INSENSITIVE = 4;
const int wxDATAVIEW_CELL_FOCUSED = 8;
const int wxDVR_DEFAULT_ALIGNMENT = -1;

const int wxDataViewTextRendererPadding = 2;

/// Base class for all renderers used for [WxDataViewCtrl].
/// 
/// A derived renderer usually has to override [render] and sometimes
/// [getSize] and sometimes [activateCell] in order to react to a 
/// double click or pressing \<ENTER\>.
/// 
/// Provides the convenience function [renderText] that clips text to 
/// fit into a column using an ellipsis.
/// 
/// # Cell mode constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxDATAVIEW_CELL_INERT | not editing possible |
/// | wxDATAVIEW_CELL_ACTIVATABLE | can react to mouse click on \<ENTER\> |
/// | wxDATAVIEW_CELL_EDITABLE | can be editted in-place |
/// 
/// # Cell state constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxDATAVIEW_CELL_SELECTED | cell or row is currently selected |
/// | wxDATAVIEW_CELL_PRELIT | mouse is over cell or row |
/// | wxDATAVIEW_CELL_INSENSITIVE | cell should show disabled state |
/// | wxDATAVIEW_CELL_FOCUSED | cell or control has focus |

class WxDataViewRenderer extends WxObject {
  WxDataViewRenderer( String variantType, { int mode = wxDATAVIEW_CELL_INERT, int alignment = wxDVR_DEFAULT_ALIGNMENT } ) {
    _mode = mode;
    _alignment = alignment;
    _variantType = variantType;
  }

  dynamic _value;
  WxDataViewItemAttr? _attr;
  late int _mode;
  late int _alignment;
  late String _variantType;
  late WxDataViewColumn _owner;
  int _ellipsizeMode = wxELLIPSIZE_MIDDLE;
  WxWindow? _editorCtrl;
  bool _enabled = true;
  int _state = 0;
  WxDataViewItem _item = WxDataViewItem();
  WxInfoDC? _infoDC;

  void setOwner( WxDataViewColumn owner ) {
    _owner = owner;
  }
  WxDataViewColumn getOwner() {
    return _owner;
  }

  dynamic getValue() {
    return _value;
  }
  void setValue( dynamic value ) {
    _value = value;
  }

  bool render( WxRect cell, WxDC dc, int state ) {

    // print( "Render cell ${cell.x}, ${cell.y}, ${cell.width}, ${cell.height} : $_value " );
    // dc.setTextForeground( wxBLACK );

    if (_value is String) {
      renderText( _value, 0, cell, dc, state );
    } else if (_value is int) {
      renderText( "$_value", 0, cell, dc, state );
    } else if (_value is bool) {
      renderText( "$_value", 0, cell, dc, state );
    } else if (_value is double) {
      renderText( _value.toStringAsFixed(2), 0, cell, dc, state );
    }
    return false;
  }
  void renderText( String text, int xoffset, WxRect rect, WxDC dc, int state)
  {
      final textExtent = dc.getTextExtent( text );
      String finalText = text;
      if (textExtent.x+xoffset > rect.width)
      {
        for (int i = text.length; i > 0; i--) {
          finalText = "${text.substring(0,i)}...";
          if (dc.getTextExtent(finalText).x+xoffset <= rect.width) break;
        }
      }
      // print( "textHeight: $textHeight cell.height ${cell.height}" );
      dc.drawText(finalText, wxDataViewTextRendererPadding + rect.x + xoffset, rect.y + (rect.height-textExtent.y)~/2 );
  }
  void renderBackground( WxDC dc, WxRect rect ) {
  }

  bool activateCell( WxRect cell, WxDataViewModel model, WxDataViewItem item, int col, { bool fromMouseClick=false, WxPoint pos=wxDefaultPosition} ) { 
    return false;
  }

  // Prepare DC to use attributes and call Render().
  void _render( WxRect rectCell, WxDC dc, int state)
  {
    WxRect rectItem = WxRect.fromRect( rectCell );

    if (_attr != null) {
      final margins = _attr!.getMargins();
      rectItem.deflate( margins.x, margins.y );
    }
    
    final align = _getEffectiveAlignment();
    final size = getSize();

    // take alignment into account only if there is enough space, otherwise
    // show as much contents as possible
    //
    // notice that many existing renderers (e.g. wxDataViewSpinRenderer)
    // return hard-coded size which can be more than they need and if we
    // trusted their GetSize() we'd draw the text out of cell bounds
    // entirely

    if ( size.x >= 0 && size.x < rectItem.width )
    {
        if ( align & wxALIGN_CENTER_HORIZONTAL != 0) {
          rectItem.x += (rectItem.width - size.x)~/2;
          rectItem.width = size.x;
        }
        else if ( align & wxALIGN_RIGHT != 0) {
          rectItem.x += rectItem.width - size.x;
          rectItem.width = size.x;
        }
        else if ( align & wxEXPAND != 0) {
          // do nothing
        }
        else { // wxALIGN_LEFT is 0 
          rectItem.width = size.x;
        }
    }

    if ( size.y >= 0 && size.y < rectItem.height )
    {
        if ( align & wxALIGN_CENTER_VERTICAL != 0) {
          rectItem.y += (rectItem.height - size.y)~/2;
        }
        else if ( align & wxALIGN_BOTTOM != 0) {
          rectItem.y += rectItem.height - size.y;
        } 
          // else: wxALIGN_TOP is 0

        rectItem.height = size.y;
    }

    if ((_attr != null) && _attr!.hasColour())
    {
      dc.setTextForeground( _attr!.getColour()! );
    }
    else
    {
      WxColour col = wxTheApp.isDark() ? wxWHITE : wxBLACK;
      if ( state & wxDATAVIEW_CELL_SELECTED != 0) {
        if (wxIsLinux() && !wxUsesFlutter()) {
          col = wxWHITE;
        }
        if (wxIsMac() && !wxUsesFlutter() && (state & wxDATAVIEW_CELL_FOCUSED != 0)) {
          col = wxWHITE;
        }
      }
      dc.setTextForeground( col );
    }

    if ((_attr != null) && _attr!.hasFont()) {
      dc.setFont( _attr!.getFont()! );
    } else {
      dc.setFont( wxNORMAL_FONT );
    }

    render( rectItem, dc, state );
  }

  WxInfoDC? getInfoDC()
  {
    if (_infoDC != null) {
      return _infoDC;
    }
    final dvc = _owner.getOwner();
    if (dvc == null) {
      return null;
    }
    return WxInfoDC( dvc );
  }

  WxSize getSize()
  {
    if (_value is String) 
    {
      final dc = getInfoDC();
      if (dc != null) {
        if ((_attr != null) && (_attr!._font != null))
        {
          dc.setFont( _attr!._font! );
          return dc.getTextExtent( _value );
        }
        else
        {
          dc.setFont( wxNORMAL_FONT );
          final size = dc.getTextExtent( _value );
          return WxSize( size.x + 2*wxDataViewTextRendererPadding, size.y );
        }
      }
    }
    return WxSize( 120, 28 );
  }

  WxSize _getSize()
  {
    final WxSize size = getSize();
    if (_attr != null) {
      final margins = _attr!.getMargins();
      return WxSize( size.x + 2*margins.x, size.y + 2*margins.y );
    }
    return size;
  }

  WxSize _getMargins() {
    if (_attr != null) {
      return _attr!.getMargins();
    }
    return WxSize.zero;
  }

  int getMode() {
    return _mode;
  }
  void setMode ( int mode ) {
    _mode = mode;
  }
  int getAlignment() {
    return _alignment;
  }
  void setAlignment( int alignment ) {
    _alignment = alignment;
  }
  WxDataViewItemAttr? getAttr() {
    return _attr;
  }
  String getVariantType() {
    return _variantType;
  }
  void setVariantType( String variantType ) {
    _variantType = variantType;
  }
  void enableEllipsize( { int mode = wxELLIPSIZE_MIDDLE } ) {
    _ellipsizeMode = mode;
  }
  void disableEllipsize() { 
    enableEllipsize( mode: wxELLIPSIZE_NONE);
  }
  int getEllipsizeMode() {
    return _ellipsizeMode;
  }

  bool isCompatibleVariantType(String variantType) {
    return variantType == getVariantType();
  }
  bool validate( dynamic value ) {
    return true;
  }

  dynamic checkedGetValue( WxDataViewModel model, WxDataViewItem item, int column )
  {
    if (!(model.hasValue(item, column))) return null;
    final value = model.getValue(item, column);
    if (value != null)
    {
        final variantType = wxDynamicTypeToVariantType(value);
        if ( !isCompatibleVariantType( variantType ) )
        {
            wxLogError( "Wrong type $variantType vs. ${getVariantType()} returned from the model for column $column" );
            return null;
        }
    }
    return value;
}

  bool prepareForItem( WxDataViewModel model, WxDataViewItem item )
  {
    final column = getOwner().getModelColumn();
    final value = checkedGetValue( model, item, column );
    if ( value == null ) return false;
    /*
        if ( m_valueAdjuster )
        {
            if ( IsHighlighted() )
                value = m_valueAdjuster->MakeHighlighted(value);
        }
    */
    setValue( value );
    
    _attr = model.getAttr(item, column);
    
    setEnabled( model.isEnabled(item, column) );
    return true;
  }

  bool hasEditorCtrl() { 
    return false;
  }
  WxWindow? createEditorCtrl( WxWindow parent, WxRect labelRect, dynamic value ) {
    return null;
  }
  dynamic getValueFromEditorCtrl( WxWindow editor ) { 
    return null;
  }

  bool startEditing( WxDataViewItem item, WxRect labelRect )
  {
    final column = getOwner();
    final dvCtrl = column.getOwner();
    if (dvCtrl == null) {
      wxLogError( "Missing associated wxDataViewCtrl" );
      return false;
    }

    // Before doing anything we send an event asking if editing of this item is really wanted.
    final event = WxDataViewEvent( wxGetDataViewItemStartEditingEventType(), dvCtrl, column, item);
    dvCtrl.processEvent( event );
    if( !event.isAllowed() ) {
        return false;
    }

    // Remember the item being edited for use in FinishEditing() later.
    _item = item;

    final col = getOwner().getModelColumn();
    final value = checkedGetValue(dvCtrl.getModel()!, item, col);

    _editorCtrl = createEditorCtrl( dvCtrl.getMainWindow(), labelRect, value );

    // there might be no editor control for the given item
    if(_editorCtrl == null)
    {
        _item = WxDataViewItem();
        return false;
    }

    _editorCtrl!.bindKillFocusEvent( (event)
    {
      if (_editorCtrl == null) {
        wxLogError( "editor control already killed" );
        return;
      }
      final parent = _editorCtrl!.getParent();
      if (parent is WxDataViewMainWindow) {
        parent.finishEditing();
      }
    } );

    _editorCtrl!.bindTextEnterEvent( (event)
    {
      if (_editorCtrl == null) {
        wxLogError( "editor control already killed" );
        return;
      }
      final parent = _editorCtrl!.getParent();
      if (parent is WxDataViewMainWindow) {
        parent.finishEditing();
      }
    }, -1 );

    _editorCtrl!.bindKeyDownEvent( (event)
    {
      if (_editorCtrl == null) {
        wxLogError( "editor control already killed" );
        return;
      }
      if (event.getKeyCode() != WXK_ESCAPE) {
        event.skip();
        return;
      }
      final parent = _editorCtrl!.getParent();
      if (parent is WxDataViewMainWindow) {
        parent.cancelEditing();
      }
    } );

    _editorCtrl!.setFocus();
    dvCtrl.refresh();

    return true;
  }

  void cancelEditing() {
    final parent = _editorCtrl!.getParent();
    _destroyEditorCtrl();
    parent!.setFocus();
  }

  bool finishEditing()
  {
    if (_editorCtrl == null) return true;
    dynamic value = getValueFromEditorCtrl( _editorCtrl!);
    final parent = _editorCtrl!.getParent();
    _destroyEditorCtrl();
    parent!.setFocus();
    return _doHandleEditingDone( value );
  }

  bool _doHandleEditingDone( dynamic value )
  {
    if ( value != null)
    {
        if ( !validate(value) ) {
            value = null;
        }
    }
    final column = getOwner();
    final dvCtrl = column.getOwner();
    final col = column.getModelColumn();
    final event = WxDataViewEvent( wxGetDataViewItemEditingDoneEventType(), dvCtrl!, column, _item);
    if ( value != null) {
        event.setValue( value );
    } else {
        event.setEditCancelled();
    }
    dvCtrl.processEvent( event );

    bool accepted = false;
    if ( (value != null) && event.isAllowed() )
    {
        dvCtrl.getModel()!.changeValue(value, _item, col);
        accepted = true;
    }
    _item = WxDataViewItem();
    return accepted;
  }


  WxWindow? getEditorCtrl() { 
    return _editorCtrl;
  }
  bool isCustomRenderer() { 
    return true;
  }

  void _notifyEditingStarted( WxDataViewItem item )
  {
    final column = getOwner();
    final dvCtrl = column.getOwner();
    if (dvCtrl == null) return;
    final event = WxDataViewEvent( wxGetDataViewItemEditingStartedEventType(), dvCtrl, column, item);
    dvCtrl.processEvent( event );
  }

  void _setState(int state) { 
    _state = state;
  }
  bool _isHighlighted()  { 
    return (_state & wxDATAVIEW_CELL_SELECTED) != 0;
  }

  void setEnabled( bool enabled ) {
    _enabled = enabled;
  }
  bool getEnabled() { 
    return _enabled;
  }
  void _destroyEditorCtrl()
  {
    if (_editorCtrl != null)
    {
      _editorCtrl!.destroy();
      _editorCtrl = null;
    }
  }
  int _getEffectiveAlignment() {
    if (_alignment == wxDVR_DEFAULT_ALIGNMENT) {
      return wxALIGN_LEFT|wxALIGN_CENTER_VERTICAL;    // TODO RTL
    }
    return _alignment;
  }
}

// ---------------------- WxDataViewTextRenderer -------------------

/// Renders text and optionally lets the user edit it in-place using a [WxTextCtrl].

class WxDataViewTextRenderer extends WxDataViewRenderer {
  WxDataViewTextRenderer( { super.mode = wxDATAVIEW_CELL_EDITABLE, super.alignment = wxDVR_DEFAULT_ALIGNMENT } ) : 
    super( "string" );

  @override
  bool hasEditorCtrl() { 
    return true;
  }
  @override
  WxWindow? createEditorCtrl( WxWindow parent, WxRect labelRect, dynamic value ) {
    String str = "error";
    if (value is String) {
      str = value;
    }
    return WxTextCtrl( parent, -1, value: str, pos: labelRect.getPosition(), size: labelRect.getSize(), style: wxTE_PROCESS_ENTER );
  }
  @override
  dynamic getValueFromEditorCtrl( WxWindow editor ) { 
    if (_editorCtrl == null) {
      wxLogError( "no editor control created" );
      return null;
    }
    if (_editorCtrl is WxTextCtrl) {
      final textCtrl = _editorCtrl as WxTextCtrl;
      return textCtrl.getValue();
    }
    return null;
  }
}

// ---------------------- WxDataViewChoiceRenderer -------------------

/// Renders the selected choice and lets the user pick a choice using a [WxChoice] control.

class WxDataViewChoiceRenderer extends WxDataViewRenderer {
  WxDataViewChoiceRenderer( List<String> choices, { super.mode = wxDATAVIEW_CELL_EDITABLE, super.alignment = wxDVR_DEFAULT_ALIGNMENT } ) : 
    super( "string" ) {
      _choices = choices;
  }

  List<String> _choices = [];

  void setChoices( List<String> choices ) {
    _choices = choices;
  }
  List<String> getChoices() {
    return _choices;
  }

  @override
  bool hasEditorCtrl() { 
    return true;
  }
  @override
  WxWindow? createEditorCtrl( WxWindow parent, WxRect labelRect, dynamic value ) {
    String str = "";
    if (value is String) {
      str = value;
    }
    final choice = WxChoice( parent, -1, choices: _choices, pos: labelRect.getPosition(), size: WxSize(labelRect.getSize().x, 23 ));
    choice.setBackgroundColour( wxWHITE );
    if (str.isNotEmpty) {
      choice.setStringSelection( str );
    }
    return choice;
  }
  @override
  dynamic getValueFromEditorCtrl( WxWindow editor ) { 
    if (_editorCtrl == null) {
      wxLogError( "no editor control created" );
      return null;
    }
    if (_editorCtrl is WxChoice) {
      final choice = _editorCtrl as WxChoice;
      return choice.getStringSelection();

    }
    return null;
  }
}

// ---------------------- WxDataViewBitmapRenderer -------------------

/// Renders a bitmap

class WxDataViewBitmapRenderer extends WxDataViewRenderer {
  WxDataViewBitmapRenderer( { super.mode = wxDATAVIEW_CELL_INERT, super.alignment = wxDVR_DEFAULT_ALIGNMENT } ) : 
    super( "bitmap" );

  @override
  bool render( WxRect cell, WxDC dc, int state ) {
    if (_value is WxBitmap) {
      final bitmap = _value as WxBitmap;
      dc.drawBitmap( bitmap, cell.x, cell.y );
      return true;
    }
    dc.drawText( "No image", cell.x, cell.y );
    return false;
  }

  @override
  WxSize getSize() {
    if (_value is WxBitmap) {
      final bitmap = _value as WxBitmap;
      if (!bitmap.isOk()) {
        final col = getOwner();
        final dvc = col.getOwner();
        if (dvc != null) {
          // bitmap._addListener( dvc );
        }
        return WxSize( 20, 20 );
      }
      return WxSize( bitmap.getWidth(), bitmap.getHeight() );
    }
    wxLogError( "no bitmap to get size from" );
    return WxSize( 10, 10 );
  }
}

// ---------------------- WxDataViewProgressRenderer -------------------

/// Renders a progress bar from a value of 0-100

class WxDataViewProgressRenderer extends WxDataViewRenderer {
  WxDataViewProgressRenderer( { super.mode = wxDATAVIEW_CELL_INERT, super.alignment = wxDVR_DEFAULT_ALIGNMENT } ) : 
    super( "long" );

  @override
  bool render( WxRect cell, WxDC dc, int state ) {
    final column = getOwner();
    final dvCtrl = column.getOwner();
    if (dvCtrl == null) {
      wxLogError( "Missing associated wxDataViewCtrl" );
      return false;
    }    
    if (_value is int) {
      final value = _value as int;
      if (wxUsesFlutter() || wxIsMac()) {
        // looks great on OSX and Flutter
        wxGetRendererNative().drawGauge(dvCtrl, dc, cell, value, 100 );
      } else {
        dc.setPen( wxTRANSPARENT_PEN );
        if (wxTheApp.isDark()) {
          dc.setBrush( wxGREY_BRUSH );
        } else {
          dc.setBrush( wxLIGHT_GREY_BRUSH );
        }
        final totalWidth = cell.width-6;
        dc.drawRectangle( cell.x+3, cell.y + cell.height - 12, totalWidth, 6 );
        final partialWidth = (totalWidth * value / 100).floor();
        dc.setBrush( WxBrush( wxTheApp.getSecondaryAccentColour()) );
        dc.drawRectangle( cell.x+3, cell.y + cell.height - 12, partialWidth, 6 );
      }
      return true;
    }
    dc.drawText( "No data", cell.x, cell.y );
    return false;
  }

  @override
  WxSize getSize() {
    return WxSize( 80, 20 );
  }
}

// ---------------------- WxDataViewToggleRenderer -------------------

/// Renders a toggle that the user can click (or use the space key) to toggle.

class WxDataViewToggleRenderer extends WxDataViewRenderer {
  WxDataViewToggleRenderer( { super.mode = wxDATAVIEW_CELL_INERT, super.alignment = wxDVR_DEFAULT_ALIGNMENT } ) : 
    super( "bool" );

  @override
  bool render( WxRect cell, WxDC dc, int state ) {
    final column = getOwner();
    final dvCtrl = column.getOwner();
    if (dvCtrl == null) {
      wxLogError( "Missing associated wxDataViewCtrl" );
      return false;
    }        
    if (_value is bool) {
      final toggle = _value as bool;
      wxGetRendererNative().drawCheckBox(dvCtrl, dc, cell, flags: toggle ? wxCONTROL_CHECKED : 0 );
      return true;
    }
    dc.drawText( "--", cell.x, cell.y );
    return false;
  }

  @override
  WxSize getSize() {
    return WxSize( 20, 20 );
  }

  @override
  bool activateCell( WxRect cell, WxDataViewModel model, WxDataViewItem item, int col, { bool fromMouseClick=false, WxPoint pos=wxDefaultPosition} )
  {
    if ( fromMouseClick )
    {
        // Only react to clicks directly on the checkbox, not elsewhere in the
        // same cell.
        final rect = WxRect.fromSize( getSize() );
        if (!rect.contains( pos.x, pos.y )) {
            return false;
        }
    }
    bool toggle = _value as bool;
    model.changeValue(!toggle, item, col);
    return true;
  }
}

// ---------------------- WxDataViewIconTextRenderer -------------------

/// Holds a combination of a bitmap and text to be rendered by [WxDataViewIconTextRenderer]

class WxDataViewIconTextData {
  WxDataViewIconTextData( this.icon, this.text );

  final WxBitmap? icon;
  final String text;
}

/// Renders a combination of a bitmap and text. Holds data of type [WxDataViewIconTextData].

class WxDataViewIconTextRenderer extends WxDataViewTextRenderer {
  WxDataViewIconTextRenderer( { super.mode = wxDATAVIEW_CELL_INERT, super.alignment = wxDVR_DEFAULT_ALIGNMENT } ) 
  {
    setVariantType( (WxDataViewIconTextData).toString() );
  }

  @override
  bool render( WxRect cell, WxDC dc, int state ) {
    if (_value is WxDataViewIconTextData)
    {
      int xoffset = 0;
      if ((_value.icon != null) && (_value.icon.isOk)) {
        xoffset = 5 + _value.icon.getWidth() as int;
        dc.drawBitmap( _value.icon, cell.x, cell.y );
      }
      renderText( _value.text, xoffset, cell, dc, state );
      return true;
    }
    return false;
  }

  @override
  WxSize getSize()
  {
    if (_value is WxDataViewIconTextData)
    {
      final oldValue = _value;
      _value = _value.text;
      final textSize = super.getSize();
      _value = oldValue;
      if ((_value.icon != null) && (_value.icon.isOk)) {
        int width = _value.icon.getWidth();
        int height = _value.icon.getHeight();
        return WxSize( textSize.x + 5 + width, max(height,textSize.y) );
      }
      return textSize;
    }
    return WxSize( 20, 20 );
  }
}

// ---------------------- WxDataViewTileRenderer -------------------

/// Helper class holding the data of an item a tile to displayed with
/// a [WxDataViewTileRenderer] in a [WxDataViewTileListCtrl].

class WxDataViewTileData {
  WxDataViewTileData( this.leading, this.big, this.medium, { this.small = "", this.trailing } );

  final WxBitmap? leading;
  final String big;
  final String medium;
  final String small;
  final WxBitmap? trailing;
}

/// Renderer that renders a tile as defined by a [WxDataViewTileData] to be display by a [WxDataViewTileListCtrl].

class WxDataViewTileRenderer extends WxDataViewRenderer {
  WxDataViewTileRenderer( this._height, this._margins, { super.mode = wxDATAVIEW_CELL_ACTIVATABLE, super.alignment = wxEXPAND } ) : 
    super( (WxDataViewTileData).toString() )
  {
    double pointSize = wxNORMAL_FONT.getPointSize();
     _bigSize = pointSize*1.2;
     _mediumSize = pointSize;
     _smallSize = pointSize/1.2;
  }

  final int _height;
  final int _margins;
  late double _bigSize;
  late double _mediumSize;
  late double _smallSize;
  final int _rightPadding = 10;
  final int _leftPadding = 0;

  void setSizes( double big, double medium, double small ) {
    _bigSize = big;
    _mediumSize = medium;
    _smallSize = small;
  }

  @override
  bool render( WxRect cell, WxDC dc, int state )
  {
    if (_value is! WxDataViewTileData)
    {
      dc.drawText( "--", cell.x, cell.y );
      return false;
    }

    WxRect paddedCell = WxRect.fromRect(cell);
    paddedCell.x += _leftPadding;
    paddedCell.width -= (_leftPadding + _rightPadding);

    int widthForText = paddedCell.width - 2*_margins; // TODO with ellipsis
    int xForText = paddedCell.x + _margins;
    int yForText = paddedCell.y + _margins;
    if (_value.leading != null) {
      int width = 20;
      if (_value.leading.isOk()) 
      {
        width = _value.leading.getWidth() as int;
        final height = _value.leading.getHeight() as int;
        final y = paddedCell.y + _margins - (height-(paddedCell.height-2*_margins))~/2;
        dc.drawBitmap( _value.leading, paddedCell.x + _margins, y );
        yForText = y;
      }
      widthForText -= width + _margins;
      xForText += width + _margins;
    }
    if (_value.trailing != null)
    {
      int width = 20;
      if (_value.trailing.isOk()) {
        width = _value.trailing.getWidth() as int;
        final height = _value.trailing.getHeight() as int;
        final y = paddedCell.y + _margins - (height-(paddedCell.height-2*_margins))~/2;
        dc.drawBitmap( _value.trailing, paddedCell.x + paddedCell.width - width - _margins, y );
        yForText = y;
      }
      widthForText -= width + _margins;
    }
    if (_value.big.isNotEmpty)
    {
      dc.setFont( WxFont(_bigSize) );
      final height = dc.getTextExtent( 'H' ).y;
      renderText( _value.big, 0, WxRect(xForText,yForText,widthForText,height), dc, state );
      yForText += height;
      yForText += _margins;
    }
    if (_value.medium.isNotEmpty)
    {
      dc.setFont( WxFont(_mediumSize) );
      final height = dc.getTextExtent( 'H' ).y;
      renderText( _value.medium, 0, WxRect(xForText,yForText,widthForText,height), dc, state );
      yForText += height;
      yForText += _margins;
    }
    if (_value.small.isNotEmpty)
    {
      dc.setFont( WxFont(_smallSize) );
      final height = dc.getTextExtent( 'H' ).y;
      renderText( _value.small, 0, WxRect(xForText,yForText,widthForText,height), dc, state );
      yForText += height;
      yForText += _margins;
    }
    return true;
  }

  @override
  WxSize getSize() {
    return WxSize( 300, _height );
  }
}
