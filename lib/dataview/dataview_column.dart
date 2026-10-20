// ---------------------------------------------------------------------------
// Name:        dataview_column.dart
// Name:        src/generic/datavgen.cpp from wxWidgets
// Purpose:     wxDataViewColumn
// Author:      Robert Roebling
// Modified by: Francesco Montorsi, Guru Kathiresan, Bo Yang
// Copyright:   (c) 1998 Robert Roebling (C++ version)
// Copyright:   (c) 2026 Robert Roebling (Dart version)
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../wx_dart.dart';

// ------------------------- wxDataViewColumn ----------------------

const int wxDVC_DEFAULT_WIDTH = 80;
const int wxDVC_DEFAULT_MINWIDTH = 30;
const int wxDVC_DEFAULT_RENDERER_SIZE = 25; // 20;
const int wxDVC_TOGGLE_DEFAULT_WIDTH = 30;
const int wxDATAVIEW_COL_RESIZABLE = wxCOL_RESIZABLE;
const int wxDATAVIEW_COL_SORTABLE = wxCOL_SORTABLE;
const int wxDATAVIEW_COL_REORDERABLE = wxCOL_REORDERABLE;
const int wxDATAVIEW_COL_HIDDEN = wxCOL_HIDDEN;

/// Represents a column in a [WxDataViewCtrl]. The size and position of the columns
/// are controled by the [WxDataViewHeaderWindow] deriving from [WxHeaderCtrl]
/// 
/// A column usually has a [title], an associated [WxDataViewRenderer], an associated
/// column in the model and option related to width, resizing, aligment and sorting.
/// 
/// # Dataview column constants
/// | constant | value |
/// | -------- | -------- |
/// | wxDVC_DEFAULT_WIDTH | 80 |
/// | wxDVC_DEFAULT_MINWIDTH | 30 |
/// | wxDVC_DEFAULT_RENDERER_SIZE | 25 |
/// | wxDVC_TOGGLE_DEFAULT_WIDTH | 30 |
/// 
/// # Column flags
/// | constant | value |
/// | -------- | -------- |
/// | wxDATAVIEW_COL_RESIZABLE | wxCOL_RESIZABLE |
/// | wxDATAVIEW_COL_SORTABLE | wxCOL_SORTABLE |
/// | wxDATAVIEW_COL_REORDERABLE | wxCOL_REORDERABLE |
/// | wxDATAVIEW_COL_HIDDEN | wxCOL_HIDDEN |


class WxDataViewColumn extends WxSettableHeaderColumn {
  WxDataViewColumn( String title, WxDataViewRenderer renderer, int modelColumn, { int width = wxDVC_DEFAULT_WIDTH, int alignment = wxALIGN_CENTER, int flags = wxDATAVIEW_COL_RESIZABLE } ) {
    _title = title;
    _renderer = renderer;
    _renderer.setOwner( this );
    _modelColumn = modelColumn;
    _width = width;
    _minWidth = wxDVC_DEFAULT_MINWIDTH;
    _alignment = alignment;
    _flags = flags;
    _manuallySetWidth = _width;
  }

  late final WxDataViewRenderer _renderer;
  late final int _modelColumn;
  late int _manuallySetWidth;
  WxDataViewCtrl? _owner;

  WxDataViewRenderer getRenderer() {
    return _renderer;
  }

  int getModelColumn() {
    return _modelColumn;
  }

  void setOwner( WxDataViewCtrl owner ) {
    _owner = owner;
  }

  WxDataViewCtrl? getOwner() {
    return _owner;
  }

  // ---------

  @override
  void setTitle( String title ) {
    super.setTitle(title);
    _updateWidth();
  }

  @override
  void setBitmap( WxBitmap bitmap ) {
    super.setBitmap(bitmap);
    _updateWidth();
  }

  @override
  void setWidth( int width ) {
    super.setWidth(width);
    _manuallySetWidth = width;
    _updateWidth();
  }

  @override
  int getWidth() {
    return _doGetEffectiveWidth(_width);
  }

  @override
  void setMinWidth( int minWidth ) {
    super.setMinWidth(minWidth);
    _updateWidth();
  }

  @override
  void setFlags( int flags ) {
    super.setFlags(flags);
    _updateWidth();
  }

  @override
  void setFlag( int flag ) {
    super.setFlag(flag);
    _updateWidth();
  }

  @override
  void clearFlag( int flag ) {
    super.clearFlag(flag);
    _updateWidth();
  }

  @override
  void setAlignment( int alignment ) {
    super.setAlignment(alignment);
    _updateWidth();
  }

  @override
  void setResizeable( bool resizable ) {
    super.setResizeable(resizable);
    _updateWidth();
  }

  @override
  void setSortable( bool sortable ) {
    super.setSortable(sortable);
    _updateWidth();
  }

  @override
  void setHidden( bool hidden ) {
    super.setHidden(hidden);
    _updateWidth();
  }

  @override
  void unsetAsSortKey( ) {
    super.unsetAsSortKey();
    if (_owner != null) {
        _owner!.dontUseColumnForSorting(_owner!.getColumnIndex(this));
    }
    _updateDisplay();
  }

  @override
  void setSortOrder( bool ascending ) {
    if (_owner == null) {
        return;
    }

    if (!_owner!.isMultiColumnSortAllowed()) {
      _owner!._resetAllSortColumns();
    }

    final idx = _owner!.getColumnIndex(this);

    if (!_isSortKey) {
        _owner!.useColumnForSorting(idx);
        _isSortKey = true;
    }

   _isSortOrderAscending = ascending;

    _owner!.onColumnChange(idx);
  }

  // ---------

  void _updateWidthInternal(int width)
  {
    if (width == _width) {
      return;
    }

    _width = width;
    _updateWidth();
  }

  void _onResizeFromHeaderCtrl(int width) {
    _width =
    _manuallySetWidth = width;

    if (_owner != null) {
      _owner!.onColumnResized();
    }
  }

  int _getSpecifiedWidth() {
    return _doGetEffectiveWidth(_manuallySetWidth);
  }

  void _updateDisplay() {
    if (_owner != null) {
        int idx = _owner!.getColumnIndex( this );
        _owner!.onColumnChange( idx );
    }
  }
  
  void _updateWidth() {
    if (_owner != null) {
        int idx = _owner!.getColumnIndex( this );
        _owner!.onColumnWidthChange( idx );
    }
  }

  int _doGetEffectiveWidth(int width) {
    if (_owner == null) return wxDVC_DEFAULT_WIDTH;
    switch ( width )
    {
        case wxCOL_WIDTH_DEFAULT:
            return wxDVC_DEFAULT_WIDTH;

        case wxCOL_WIDTH_AUTOSIZE:
            return _owner!.getBestColumnWidth(_owner!.getColumnIndex(this));

    }
    return width;
  }
}

