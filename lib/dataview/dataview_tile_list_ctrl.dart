// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../wx_dart.dart';

// ---------------------- WxDataViewTileRenderer -------------------

/// Helper class holding the data of an item a tile to displayed with
/// a [WxDataViewTileRenderer] in a [WxDataViewTileListCtrl].

class WxDataViewTileData {
  WxDataViewTileData( this.leading, this.big, { this.medium = "", this.small = "", 
    this.trailing, this.trailingHighlighted, this.leadingHighlighted,
    this.bigAlignment = WxHAlignment.left, this.mediumAlignment = WxHAlignment.left, this.smallAlignment = WxHAlignment.left,  } );

  final WxBitmap? leading;
  final WxBitmap? leadingHighlighted;
  final String big;
  final WxHAlignment bigAlignment;
  final String medium;
  final WxHAlignment mediumAlignment;
  final String small;
  final WxHAlignment smallAlignment;
  final WxBitmap? trailing;
  final WxBitmap? trailingHighlighted;
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

        int _height;
  final int _margins;
  late double _bigSize;
  late double _mediumSize;
  late double _smallSize;
  final int _rightPadding = 10;
  final int _leftPadding = 0;

  /// Sets the font sizes of the (possible) text fields
  void setSizes( double big, double medium, double small ) {
    _bigSize = big;
    _mediumSize = medium;
    _smallSize = small;
  }

  void _calculateHeight( WxInfoDC dc )
  {
    if (_value is! WxDataViewTileData) {
      return;
    }

    int leadingHeight = 0;
    if (_value.leading != null) {
        leadingHeight = _value.leading.getHeight() as int;
        leadingHeight += 2*_margins;
    }
    int trailingHeight = 0;
    if (_value.trailing != null) {
        trailingHeight = _value.trailing.getHeight() as int;
        trailingHeight += 2*_margins;
    }
    int textHeight = _margins;
    if (_value.big.isNotEmpty)
    {
      dc.setFont( WxFont(_bigSize) );
      textHeight += dc.getTextExtent( 'H' ).y + _margins;
    }
    if (_value.medium.isNotEmpty)
    {
      dc.setFont( WxFont(_mediumSize) );
      textHeight += dc.getTextExtent( 'H' ).y + _margins;
    }
    if (_value.small.isNotEmpty)
    {
      dc.setFont( WxFont(_smallSize) );
      textHeight += dc.getTextExtent( 'H' ).y + _margins;
    }
    _height = max( trailingHeight, leadingHeight );
    _height = max( _height, textHeight );

    if (_attr != null) {
      final margins = _attr!.getMargins();
      _height += 2* margins.y;
    }
  }

  int _getHeight() {
    return _height;
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
    int imageHeight = 12;

    WxBitmap? leading = _value.leading;
    if (leading != null) {
      if ((state & wxDATAVIEW_CELL_SELECTED != 0) && (_value.leadingHighlighted != null)) {
        leading = _value.leadingHighlighted;
      }
      int width = 20;
      if (leading!.isOk()) 
      {
        width = leading.getWidth();
        final height = leading.getHeight();
        imageHeight = max( height, imageHeight );
        final y = paddedCell.y + _margins - (height-(paddedCell.height-2*_margins))~/2;
        dc.drawBitmap( leading, paddedCell.x + _margins, y );
      }
      widthForText -= width + _margins;
      xForText += width + _margins;
    }

    WxBitmap? trailing = _value.trailing;
    if (trailing != null)
    {
      if ((state & wxDATAVIEW_CELL_SELECTED != 0) && (_value.trailingHighlighted != null)) {
        leading = _value.trailingHighlighted;
      }
      int width = 20;
      if (trailing.isOk()) {
        width = trailing.getWidth();
        final height = trailing.getHeight();
        imageHeight = max( height, imageHeight );
        final y = paddedCell.y + _margins - (height-(paddedCell.height-2*_margins))~/2;
        dc.drawBitmap( trailing, paddedCell.x + paddedCell.width - width - _margins, y );
      }
      widthForText -= width + _margins;
    }
    if (_value.big.isNotEmpty)
    {
      dc.setFont( WxFont(_bigSize) );
      final height = dc.getTextExtent( 'H' ).y;
      if ((_value.medium.isEmpty) && (_value.small.isEmpty)) {
        // centre around bitmap
        yForText = paddedCell.y + _margins - (height-(paddedCell.height-2*_margins))~/2;
      }
      renderText( _value.big, 0, WxRect(xForText,yForText,widthForText,height), dc, state, alignment: _value.bigAlignment );
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
    return WxSize( 300, _height == -1 ? 36 : _height );
  }
}

// ------------------------- WxDataViewTileListCtrl ----------------------

/// Specialized variant of a [WxDataViewListCtrl] showing tiles constructed from
/// [WxDataViewTileData] rendered by a [WxDataViewTileRenderer].
/// 
/// This controls stores the actual data in a [WxDataViewListStore]. If you needed
/// to fetch the data from an external source (database) on demand, use the 
/// [WxDataViewVirtualTileListCtrl].
/// 
/// This is an example case of how [WxDataViewCtrl] can be used on mobile devices
/// showing one large vertical list of similar objects, in this case a tile.
/// 
/// A tile is a typical user interface element showing a leading bitmap/icon, some
/// text in up to three rows in the middle and optionally a trailing bitmap/icon again.
/// 
/// The leading and trailing bitmap/icon can optionally have a highlighted variant
/// to allow contrast to the highlight selection colours. This could be a e.g.  white
/// variant on macOS.
/// 
/// All rows have the same height. See [setRowHeight].
/// 
/// ```dart
///    dataview = WxDataViewTileListCtrl( this, -1 );
///
///    final leading = WxBitmap.fromMaterialIcon( WxMaterialIcon.account_balance, WxSize(48,48), wxGREY );
///    final trailing = WxBitmap.fromMaterialIcon( WxMaterialIcon.delete, WxSize(48,48), wxRED );
///    for (int i = 0; i < 200; i++) {
///      dataview.appendTile( leading, "Title in row #$i", "Medium text", small: "Small text at the bottom", trailing: trailing );
///    }
/// ```
/// 
/// Adding tiles:
/// * [appendTile]
/// * [prependTile]
/// * [insertTile]

class WxDataViewTileListCtrl extends WxDataViewListCtrl {
  /// Creates the control
  /// 
  /// If the height is left at -1 the control will use the first item to calculate the
  /// height of the rows
  WxDataViewTileListCtrl( super.parent, super.id, { int height = -1, int margins = 5,
         super.pos = wxDefaultPosition, super.size = wxDefaultSize, super.style = wxDV_NO_HEADER|wxVSCROLL } )
  {
    _store._columns.add( (WxDataViewTileData).toString() );
    _tileRenderer = _wxAppendTileColumn( this, height, margins );
    if (height != -1) {
      setRowHeight( height );
    } else {
      _needToCalculateHeight = true;
    }
  }

  late WxDataViewTileRenderer _tileRenderer;

  /// Calculate height of all rows based on this single item (which should be the largest item)
  int calculateRowHeight( WxDataViewTileData tile ) 
  {
    _tileRenderer.setValue( tile );
    _tileRenderer._calculateHeight( WxInfoDC( this ));
    return _tileRenderer._getHeight();
  }

  /// Append a tile
  void appendTile( WxBitmap? leading, String big, { String medium="", String small="", 
    WxBitmap? trailing, WxBitmap? trailingHighlighted, WxBitmap? leadingHighlighted, dynamic clientData,
    WxHAlignment bigAlignment = WxHAlignment.left, WxHAlignment mediumAlignment = WxHAlignment.left, WxHAlignment smallAlignment = WxHAlignment.left } )
  {
    final tile = WxDataViewTileData( leading, big, medium: medium, small: small, trailing: trailing,
     trailingHighlighted: trailingHighlighted, leadingHighlighted: leadingHighlighted,
     bigAlignment: bigAlignment, mediumAlignment: mediumAlignment, smallAlignment: smallAlignment );

    if (_needToCalculateHeight) {
      setRowHeight( calculateRowHeight( tile) );
      _needToCalculateHeight = false;
    }

    // append list with a single item
    appendItem( [tile], clientData: clientData );
  }

  /// Prepend a tile
  void prependTile( WxBitmap? leading, String big, { String medium = "", String small="", 
    WxBitmap? trailing, WxBitmap? trailingHighlighted, WxBitmap? leadingHighlighted, dynamic clientData,
    WxHAlignment bigAlignment = WxHAlignment.left, WxHAlignment mediumAlignment = WxHAlignment.left, WxHAlignment smallAlignment = WxHAlignment.left } )
  {
    final tile = WxDataViewTileData( leading, big, medium: medium, small: small, trailing: trailing,
     trailingHighlighted: trailingHighlighted, leadingHighlighted: leadingHighlighted,
     bigAlignment: bigAlignment, mediumAlignment: mediumAlignment, smallAlignment: smallAlignment );

    if (_needToCalculateHeight) {
      setRowHeight( calculateRowHeight(tile) );
      _needToCalculateHeight = false;
    }

    // prepend list with a single item
    prependItem( [tile], clientData: clientData );
  }

  /// Insert a tile at [pos]
  void insertTile( int pos, WxBitmap? leading, String big, { String medium = "", String small="", 
    WxBitmap? trailing, WxBitmap? trailingHighlighted, WxBitmap? leadingHighlighted, dynamic clientData,
    WxHAlignment bigAlignment = WxHAlignment.left, WxHAlignment mediumAlignment = WxHAlignment.left, WxHAlignment smallAlignment = WxHAlignment.left } )
  {
    final tile = WxDataViewTileData( leading, big, medium: medium, small: small, trailing: trailing,
     trailingHighlighted: trailingHighlighted, leadingHighlighted: leadingHighlighted,
     bigAlignment: bigAlignment, mediumAlignment: mediumAlignment, smallAlignment: smallAlignment );

    if (_needToCalculateHeight) {
      setRowHeight( calculateRowHeight(tile) );
      _needToCalculateHeight = false;
    }

    // insert list with a single item
    insertItem( pos, [tile], clientData: clientData );
  }

  bool _needToCalculateHeight = false;
}

// ---------------------- shared by both tile list controls -------------------

/// Appends the single column with a [WxDataViewTileRenderer] that both tile
/// list controls use and returns the renderer
WxDataViewTileRenderer _wxAppendTileColumn( WxDataViewCtrl ctrl, int height, int margins )
{
  final renderer = WxDataViewTileRenderer( height, margins );
  final dvc = WxDataViewColumn("", renderer, 0, width: wxDVC_DEFAULT_WIDTH,
                           flags: wxDATAVIEW_COL_RESIZABLE );
  ctrl.appendColumn( dvc );
  return renderer;
}

/// Calculates the row height from the first row of the model as soon as
/// the model has one (used if no height was given)
class _WxTileHeightNotifier extends WxDataViewModelNotifier
{
  _WxTileHeightNotifier( super.owner, this._ctrl );
  final WxDataViewVirtualTileListCtrl _ctrl;

  @override
  bool cleared() { _ctrl._checkRowHeight(); return true; }
  @override
  bool itemAdded( WxDataViewItem parent, WxDataViewItem item ) { _ctrl._checkRowHeight(); return true; }
  @override
  bool itemChanged( WxDataViewItem item ) { return true; }
  @override
  bool itemDeleted( WxDataViewItem parent, WxDataViewItem item ) { return true; }
  @override
  bool valueChanged( WxDataViewItem item, int column ) { return true; }
}

// ---------------------- WxDataViewVirtualTileListCtrl -------------------

/// Shows tiles like [WxDataViewTileListCtrl], but the tiles come from a
/// [WxDataViewVirtualListModel] that creates them on demand. This allows
/// (nearly) endless lists, e.g. with rows that are loaded from a server.
///
/// The model returns a [WxDataViewTileData] for column 0 of each row. The
/// application changes the rows through the model ([WxDataViewVirtualListModel.rowAppended],
/// [WxDataViewVirtualListModel.rowChanged], [WxDataViewVirtualListModel.reset]
/// followed by [WxDataViewModel.cleared], ...).
///
/// All rows have the same height: the [height] given to the constructor or,
/// if that is -1, the height of the first row of the model.
///
/// ```dart
/// class Numbers extends WxDataViewVirtualListModel {
///   Numbers() : super( initalSize: 100000 );
///   @override
///   dynamic getValueByRow( int row, int col ) =>
///       WxDataViewTileData( null, "Row $row", medium: "Created on demand" );
///   @override
///   bool setValueByRow( dynamic value, int row, int col ) => false;
/// }
///
/// final tiles = WxDataViewVirtualTileListCtrl( this, -1, Numbers() );
/// ```
class WxDataViewVirtualTileListCtrl extends WxDataViewCtrl {
  /// Creates the control showing the tiles of [model]
  WxDataViewVirtualTileListCtrl( super.parent, super.id, WxDataViewVirtualListModel model,
         { int height = -1, int margins = 5,
         super.pos = wxDefaultPosition, super.size = wxDefaultSize, super.style = wxDV_NO_HEADER|wxVSCROLL } )
  {
    _virtualModel = model;
    _tileRenderer = _wxAppendTileColumn( this, height, margins );
    associateModel( model );
    if (height != -1) {
      setRowHeight( height );
    } else {
      _heightNotifier = _WxTileHeightNotifier( model, this );
      model.addNotifier( _heightNotifier! );
      _checkRowHeight();
    }
  }

  late final WxDataViewVirtualListModel _virtualModel;
  late final WxDataViewTileRenderer _tileRenderer;
  _WxTileHeightNotifier? _heightNotifier;

  void _checkRowHeight() {
    final notifier = _heightNotifier;
    if (notifier == null || _virtualModel.getCount() == 0) return;
    final first = _virtualModel.getValueByRow( 0, 0 );
    if (first is! WxDataViewTileData) return;
    setRowHeight( calculateRowHeight( first ) );
    // the notifier stays attached (removing it here would change the
    // model's list of notifiers while the model iterates over it), but
    // does nothing from now on
    _heightNotifier = null;
  }

  /// Returns the model given to the constructor
  WxDataViewVirtualListModel getVirtualModel() {
    return _virtualModel;
  }

  /// Sets the font sizes of the (possible) text fields of the tiles
  void setSizes( double big, double medium, double small ) {
    _tileRenderer.setSizes( big, medium, small );
    refresh();
  }

  /// Calculate height of all rows based on this single item (which should be the largest item)
  int calculateRowHeight( WxDataViewTileData tile )
  {
    _tileRenderer.setValue( tile );
    _tileRenderer._calculateHeight( WxInfoDC( this ));
    return _tileRenderer._getHeight();
  }

  /// Returns the number of rows (the number of rows of the model)
  int getItemCount() {
    return _virtualModel.getCount();
  }

  /// Returns the [WxDataViewItem] for the [row]
  WxDataViewItem rowToItem( int row ) {
    if ((row < 0) || (row >= _virtualModel.getCount())) {
      return WxDataViewItem();
    }
    return _virtualModel.getItem( row );
  }

  /// Returns the row index of [item]
  int itemToRow( WxDataViewItem item ) {
    if (!item.isOk()) return -1;
    return _virtualModel.getRow( item );
  }

  /// Selects the item in [row]
  void selectRow( int row ) {
    setCurrentItem( rowToItem(row) );
  }

  /// Unselects the item in [row]
  void unselectRow( int row ) {
    unselect( rowToItem(row) );
  }

  /// Returns the selected row or -1
  int getSelectedRow() {
    return itemToRow( getSelection() );
  }

  /// Returns true if [row] is selected
  bool isRowSelected( int row ) {
    return isSelected( rowToItem(row) );
  }
}
