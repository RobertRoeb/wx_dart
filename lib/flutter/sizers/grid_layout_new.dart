// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-11-18
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- grid layout ----------------------

/// Flags for [WxFlexGridSizer.setNonFlexibleGrowMode]: rows or columns in
/// the non-flexible direction don't grow
const int wxFLEX_GROWMODE_NONE = 0;

/// Flags for [WxFlexGridSizer.setNonFlexibleGrowMode]: rows or columns in
/// the non-flexible direction made growable with addGrowableRow or
/// addGrowableCol grow equally, ignoring their proportion (default)
const int wxFLEX_GROWMODE_SPECIFIED = 1;

/// Flags for [WxFlexGridSizer.setNonFlexibleGrowMode]: all rows or columns
/// in the non-flexible direction grow equally
const int wxFLEX_GROWMODE_ALL = 2;

/// The layout of [WxGridSizer] and [WxFlexGridSizer] as a Flutter render
/// object, following wxFlexGridSizer::RecalcSizes() in wxWidgets:
///
/// 1. every column is as wide as its widest item, every row as high as its
///    highest item (with [uniform], all cells are as large as the largest item)
/// 2. space left in the constraints goes to the growable columns and rows
///    according to their proportion
/// 3. items with wxEXPAND fill their cell, the others are aligned in it
///    with wxALIGN_xxx
///
/// The children are the cells row by row, [flags] holds the sizer flags
/// of each cell. Borders are part of the child widgets.
class _WxGridLayout extends MultiChildRenderObjectWidget {
  const _WxGridLayout( {
    required this.cols,
    required this.flags,
    required this.hgap,
    required this.vgap,
    this.growableCols = const {},
    this.growableRows = const {},
    this.flexibleDirection = wxBOTH,
    this.nonFlexibleGrowMode = wxFLEX_GROWMODE_SPECIFIED,
    this.uniform = false,
    required super.children,
  } );

  final int cols;
  final List<int> flags;
  final double hgap;
  final double vgap;
  /// index -> proportion
  final Map<int, int> growableCols;
  /// index -> proportion
  final Map<int, int> growableRows;
  final int flexibleDirection;
  final int nonFlexibleGrowMode;
  final bool uniform;

  @override
  RenderObject createRenderObject( BuildContext context ) {
    return _RenderWxGridLayout()
      .._cols = cols
      .._flags = flags
      .._hgap = hgap
      .._vgap = vgap
      .._growableCols = growableCols
      .._growableRows = growableRows
      .._flexibleDirection = flexibleDirection
      .._nonFlexibleGrowMode = nonFlexibleGrowMode
      .._uniform = uniform;
  }

  @override
  void updateRenderObject( BuildContext context, _RenderWxGridLayout renderObject ) {
    renderObject
      .._cols = cols
      .._flags = flags
      .._hgap = hgap
      .._vgap = vgap
      .._growableCols = growableCols
      .._growableRows = growableRows
      .._flexibleDirection = flexibleDirection
      .._nonFlexibleGrowMode = nonFlexibleGrowMode
      .._uniform = uniform;
    renderObject.markNeedsLayout();
  }
}

class _WxGridParentData extends ContainerBoxParentData<RenderBox> {}

class _RenderWxGridLayout extends RenderBox
    with ContainerRenderObjectMixin<RenderBox, _WxGridParentData>,
         RenderBoxContainerDefaultsMixin<RenderBox, _WxGridParentData> {

  int _cols = 1;
  List<int> _flags = const [];
  double _hgap = 0;
  double _vgap = 0;
  Map<int, int> _growableCols = const {};
  Map<int, int> _growableRows = const {};
  int _flexibleDirection = wxBOTH;
  int _nonFlexibleGrowMode = wxFLEX_GROWMODE_SPECIFIED;
  bool _uniform = false;

  @override
  void setupParentData( RenderBox child ) {
    if (child.parentData is! _WxGridParentData) {
      child.parentData = _WxGridParentData();
    }
  }

  List<RenderBox> get _cells {
    final list = <RenderBox>[];
    RenderBox? child = firstChild;
    while (child != null) {
      list.add( child );
      child = childAfter( child );
    }
    return list;
  }

  int get _colCount => max( 1, _cols );
  int _rowCount( int cellCount ) => (cellCount + _colCount - 1) ~/ _colCount;

  int _flagOf( int index ) => index < _flags.length ? _flags[index] : 0;

  double _sum( List<double> sizes, double gap ) {
    if (sizes.isEmpty) return 0;
    return sizes.fold<double>( 0, (a, b) => a + b ) + gap * (sizes.length - 1);
  }

  /// Intrinsic sizes can be infinite, e.g. for a WxWindow without a size
  /// (SizedBox with double.infinity): such an item has no natural size and
  /// only gets what the growable columns and rows give it.
  double _finite( double value ) => value.isFinite ? value : 0;

  /// Natural column widths (widest item per column)
  List<double> _naturalColWidths( List<RenderBox> cells ) {
    final widths = List<double>.filled( _colCount, 0 );
    for (int i = 0; i < cells.length; i++) {
      final w = _finite( cells[i].getMaxIntrinsicWidth( double.infinity ) );
      final col = i % _colCount;
      widths[col] = max( widths[col], w );
    }
    if (_uniform) {
      final widest = widths.fold<double>( 0, max );
      widths.fillRange( 0, widths.length, widest );
    }
    return widths;
  }

  /// Natural row heights for the given column widths, from the intrinsic
  /// heights of the items (texts wrap at the column width). The items are
  /// not laid out here: a layout with an unbounded height would give
  /// items that fill the available height (a WxWindow without a size) an
  /// infinite height.
  List<double> _naturalRowHeights( List<RenderBox> cells, List<double> colWidths ) {
    final heights = List<double>.filled( _rowCount( cells.length ), 0 );
    for (int i = 0; i < cells.length; i++) {
      final width = colWidths[i % _colCount];
      final h = _finite( cells[i].getMaxIntrinsicHeight( width ) );
      final row = i ~/ _colCount;
      heights[row] = max( heights[row], h );
    }
    if (_uniform) {
      final highest = heights.fold<double>( 0, max );
      heights.fillRange( 0, heights.length, highest );
    }
    return heights;
  }

  /// Distributes [extra] space over [sizes] (in place), as in wxWidgets
  void _grow( List<double> sizes, double extra, Map<int, int> growable, bool flexible ) {
    if (extra <= 0 || sizes.isEmpty) return;
    // which items grow, and by which proportion
    final shares = <int, int>{};
    if (flexible) {
      growable.forEach( (index, proportion) {
        if (index >= 0 && index < sizes.length) shares[index] = proportion;
      } );
      // all proportions 0: they grow equally
      if (shares.isNotEmpty && shares.values.every( (p) => p == 0 )) {
        shares.updateAll( (index, p) => 1 );
      }
    } else {
      switch (_nonFlexibleGrowMode) {
        case wxFLEX_GROWMODE_NONE:
          return;
        case wxFLEX_GROWMODE_ALL:
          for (int i = 0; i < sizes.length; i++) {
            shares[i] = 1;
          }
          break;
        default: // wxFLEX_GROWMODE_SPECIFIED
          for (final index in growable.keys) {
            if (index >= 0 && index < sizes.length) shares[index] = 1;
          }
      }
    }
    int total = shares.values.fold<int>( 0, (a, b) => a + b );
    if (total == 0) return;
    double remaining = extra;
    for (final entry in shares.entries) {
      if (entry.value == 0) continue;
      final share = remaining * entry.value / total;
      sizes[entry.key] += share;
      remaining -= share;
      total -= entry.value;
    }
  }

  /// Computes column widths and row heights for [constraints]
  (List<double>, List<double>) _computeGrid( BoxConstraints constraints ) {
    final cells = _cells;
    final colWidths = _naturalColWidths( cells );
    if (constraints.hasBoundedWidth) {
      _grow( colWidths, constraints.maxWidth - _sum( colWidths, _hgap ), _growableCols,
             (_flexibleDirection & wxHORIZONTAL) != 0 );
    }
    final rowHeights = _naturalRowHeights( cells, colWidths );
    if (constraints.hasBoundedHeight) {
      _grow( rowHeights, constraints.maxHeight - _sum( rowHeights, _vgap ), _growableRows,
             (_flexibleDirection & wxVERTICAL) != 0 );
    }
    return (colWidths, rowHeights);
  }

  @override
  double computeMinIntrinsicWidth( double height ) {
    return _sum( _naturalColWidths( _cells ), _hgap );
  }

  @override
  double computeMaxIntrinsicWidth( double height ) {
    return computeMinIntrinsicWidth( height );
  }

  @override
  double computeMinIntrinsicHeight( double width ) {
    final cells = _cells;
    return _sum( _naturalRowHeights( cells, _naturalColWidths( cells ) ), _vgap );
  }

  @override
  double computeMaxIntrinsicHeight( double width ) {
    return computeMinIntrinsicHeight( width );
  }

  @override
  Size computeDryLayout( covariant BoxConstraints constraints ) {
    final (colWidths, rowHeights) = _computeGrid( constraints );
    return constraints.constrain( Size( _sum( colWidths, _hgap ), _sum( rowHeights, _vgap ) ) );
  }

  @override
  void performLayout() {
    final cells = _cells;
    final (colWidths, rowHeights) = _computeGrid( constraints );

    double y = 0;
    for (int row = 0; row < rowHeights.length; row++) {
      double x = 0;
      for (int col = 0; col < _colCount; col++) {
        final index = row * _colCount + col;
        if (index >= cells.length) break;
        final child = cells[index];
        final flag = _flagOf( index );
        final cellWidth = colWidths[col];
        final cellHeight = rowHeights[row];
        if ((flag & wxEXPAND) != 0) {
          child.layout( BoxConstraints.tight( Size( cellWidth, cellHeight ) ), parentUsesSize: true );
        } else {
          child.layout( BoxConstraints.loose( Size( cellWidth, cellHeight ) ), parentUsesSize: true );
        }
        double dx = 0, dy = 0;
        if ((flag & wxALIGN_CENTER_HORIZONTAL) != 0) {
          dx = (cellWidth - child.size.width) / 2;
        } else if ((flag & wxALIGN_RIGHT) != 0) {
          dx = cellWidth - child.size.width;
        }
        if ((flag & wxALIGN_CENTER_VERTICAL) != 0) {
          dy = (cellHeight - child.size.height) / 2;
        } else if ((flag & wxALIGN_BOTTOM) != 0) {
          dy = cellHeight - child.size.height;
        }
        (child.parentData as _WxGridParentData).offset = Offset( x + dx, y + dy );
        x += cellWidth + _hgap;
      }
      y += rowHeights[row] + _vgap;
    }
    size = constraints.constrain( Size( _sum( colWidths, _hgap ), _sum( rowHeights, _vgap ) ) );
  }

  @override
  bool hitTestChildren( BoxHitTestResult result, { required Offset position } ) {
    return defaultHitTestChildren( result, position: position );
  }

  @override
  void paint( PaintingContext context, Offset offset ) {
    defaultPaint( context, offset );
  }

  @override
  double? computeDistanceToActualBaseline( TextBaseline baseline ) {
    return defaultComputeDistanceToFirstActualBaseline( baseline );
  }
}

/// Builds the widget of one item of a grid sizer: the window, sizer or
/// spacer with its border (alignment and wxEXPAND are done by [_WxGridLayout])
Widget _wxBuildGridCell( BuildContext context, WxWindow owner, WxSizerItem item ) {
  Widget widget;
  if (item._kind == WxSizerKind.window) {
    if (!item._window!.isShown()) return const SizedBox.shrink();
    widget = item._window!._build( context );
    final size = item._window!.getMinSize();
    if ((size.x != -1) || (size.y != -1)) {
      widget = ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: size.x != -1 ? size.x.toDouble() : 0,
          minHeight: size.y != -1 ? size.y.toDouble() : 0 ),
        child: widget );
    }
  } else if (item._kind == WxSizerKind.sizer) {
    widget = item._sizer!._build( context, owner );
  } else {
    item._spacerParentWindow = owner;
    widget = ReportSize(
      key: item._spacerWidgetKey,
      child: SizedBox( width: item._width.toDouble(), height: item._height.toDouble() ),
      onSizeChange: (size) {
        item._spacerSize = WxSize( size.width.floor(), size.height.floor() );
      } );
  }
  if (((item._flag & wxALL) != 0) && (item._border != 0)) {
    final double b = item._border.toDouble();
    widget = Padding(
      padding: EdgeInsets.fromLTRB(
        (item._flag & wxLEFT) == 0 ? 0 : b,
        (item._flag & wxTOP) == 0 ? 0 : b,
        (item._flag & wxRIGHT) == 0 ? 0 : b,
        (item._flag & wxBOTTOM) == 0 ? 0 : b ),
      child: widget );
  }
  return widget;
}
