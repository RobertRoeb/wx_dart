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
    if (_value.leading != null) {
      int width = 20;
      if (_value.leading.isOk()) 
      {
        width = _value.leading.getWidth() as int;
        final height = _value.leading.getHeight() as int;
        imageHeight = max( height, imageHeight );
        final y = paddedCell.y + _margins - (height-(paddedCell.height-2*_margins))~/2;
        dc.drawBitmap( _value.leading, paddedCell.x + _margins, y );
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
        imageHeight = max( height, imageHeight );
        final y = paddedCell.y + _margins - (height-(paddedCell.height-2*_margins))~/2;
        dc.drawBitmap( _value.trailing, paddedCell.x + paddedCell.width - width - _margins, y );
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
    return WxSize( 300, _height == -1 ? 36 : _height );
  }
}

// ------------------------- wxDataViewTileListCtrl ----------------------

/// Specialized variant of a [WxDataViewListCtrl] showing tiles constructed from
/// [WxDataViewTileData] rendered by a [WxDataViewTileRenderer].
/// 
/// This is an example case of how [WxDataViewCtrl] can be used on mobile devices
/// showing one large vertical list of similar objects, in this case a tile.
/// A tile is a typical user interface element showing a leading icon, some
/// text in up to three rows in the middle and optionally a trailing icons again.
/// 
/// All rows have the same height. See [setRowHeight].
/// 
/// ```dart
///    dataview = WxDataViewTileListCtrl( this, 
///    -1,  // No ID used in this case 
///    height: 80,  // height of the tile in pixels
///    margins: 4,   // margin between elements
///    style: wxDV_NO_HEADER|wxVSCROLL ); // no header and only vertical scrolling on mobile
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
    _tileRenderer = WxDataViewTileRenderer( height, margins );  
    final dvc = WxDataViewColumn("", _tileRenderer, 0, width: wxDVC_DEFAULT_WIDTH,
                             flags: wxDATAVIEW_COL_RESIZABLE );
    appendColumn( dvc );
    if (height != -1) {
      setRowHeight( height );
    } else {
      _needToCalculateHeight = true;
    }
  }

  late WxDataViewTileRenderer _tileRenderer;

  /// Calculate height of all rows based on this single item (which should be the largest item)
  int calculateRowHeight( WxBitmap? leading, String big, String medium, String small, WxBitmap? trailing ) 
  {
    _tileRenderer.setValue( WxDataViewTileData( leading, big, medium, small: small, trailing: trailing ) );
    _tileRenderer._calculateHeight( WxInfoDC( this ));
    return _tileRenderer._getHeight();
  }

  /// Append a tile
  void appendTile( WxBitmap? leading, String big, String medium, { String small="", WxBitmap? trailing } )
  {
    if (_needToCalculateHeight) {
      setRowHeight( calculateRowHeight(leading, big, medium, small, trailing) );
      _needToCalculateHeight = false;
    }

    // append list with a single item
    appendItem( [WxDataViewTileData( leading, big, medium, small: small, trailing: trailing )] );
  }

  /// Prepend a tile
  void prependTile( WxBitmap? leading, String big, String medium, { String small="", WxBitmap? trailing } )
  {
    if (_needToCalculateHeight) {
      setRowHeight( calculateRowHeight(leading, big, medium, small, trailing) );
      _needToCalculateHeight = false;
    }

    // prepend list with a single item
    prependItem( [WxDataViewTileData( leading, big, medium, small: small, trailing: trailing )] );
  }

  /// Insert a tile at [pos]
  void insertTile( int pos, WxBitmap? leading, String big, String medium, { String small="", WxBitmap? trailing } )
  {
    if (_needToCalculateHeight) {
      setRowHeight( calculateRowHeight(leading, big, medium, small, trailing) );
      _needToCalculateHeight = false;
    }

    // insert list with a single item
    insertItem( pos, [WxDataViewTileData( leading, big, medium, small: small, trailing: trailing )] );
  }

  bool _needToCalculateHeight = false;
}
