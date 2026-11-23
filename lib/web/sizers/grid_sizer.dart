// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-11-15
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxGridSizer ----------------------

/// This sizer puts the child items into cells of equal size.
/// If a new item get added with a bigger size, all cells
/// get bigger, which may require a call to [layout].
///
/// Adding items
/// * [add]
/// * [addSizer]
/// * [addSpacer]
/// * [addStretchSpacer]
/// * [insert]
/// * [insertSizer]
/// * [insertSpacer]
/// * [insertStretchSpacer]
/// * [prepend]
/// * [prependSizer]
/// * [prependSpacer]
/// * [prependStretchSpacer]
///
/// Handling of child items
/// * [getItemCount]
/// * [getItem]
/// * [getSizerItem]
/// * [getWindowItem]
///
/// Removing (but not deleting) items
/// * [remove]
/// * [removeWindow]
/// * [removeSizer]
///
/// Gaps and layout
/// * [getEffectiveColsCount]
/// * [getEffectiveRowsCount]
/// * [setVGap]
/// * [getVGap]
/// * [setHGap]
/// * [getHGap]
///
/// Size and position
/// * [getSize]
/// * [getPosition]
/// * [layout]
///
/// Example:
///```dart
/// class MyDialog extends WxDialog {
///   MyDialog( super.parent, super.id, super.title )
///   {
///     // create main sizer
///     final mainSizer = WxColumn();
///
///     /// create grid sizer with 2 columns
///     final grid = WxGridSizer(2 /*,vgap: 5, hgap: 5*/);
///     mainSizer.addSizer(grid, flag: wxEXPAND );
///
///     // add controls, first row
///     grid.add( WxStaticText(parent, -1, "Short text"), flag: wxALL|wxALIGN_CENTRE, border: 5 );
///     grid.add( WxStaticText(parent, -1, "Short text"), flag: wxALL|wxALIGN_CENTRE, border: 5 );
///
///     // add controls, second row
///     grid.add( WxStaticText(parent, -1, "Very long text"), flag: wxALL|wxALIGN_CENTRE, border: 5 );
///     grid.add( WxStaticText(parent, -1, "Very long text"), flag: wxALL|wxALIGN_CENTRE, border: 5 );
///
///     // create OK and Cancel buttons
///     final buttons = createStdDialogButtonSizer( wxOK|wxCANCEL );
///
///     // add button sizer to main sizer
///     mainSizer.addSizer( buttons, flag: wxALL|wxALIGN_RIGHT );
///
///     // Tell dialog to actually use the main sizer and to use it
///     // to determine the initial size
///     setSizerAndFit( mainSizer );
///
///     // Centre the dialog on the parent window
///     centreOnParent();
///   }
/// }
/// dart````
class WxGridSizer extends WxSizer {
  WxGridSizer(int cols, {int vgap = 0, int hgap = 0}) {
    _cols = max(1, cols);
    _vgap = vgap;
    _hgap = hgap;
  }

  late int _cols;
  late int _vgap;
  late int _hgap;

  int getCols() {
    return _cols;
  }

  void setCols(int cols) {
    _cols = max(1, cols);
    _requestLayout();
  }

  /// Returns the actual number of columns
  int getEffectiveColsCount() {
    return _cols;
  }

  /// Returns the actual number of rows
  int getEffectiveRowsCount() {
    return (_items.length + _cols - 1) ~/ _cols;
  }

  int getRows() {
    return getEffectiveRowsCount();
  }

  /// Specifies the gap between rows
  void setVGap(int vgap) {
    _vgap = vgap;
    _requestLayout();
  }

  /// Returns the currently specified gap between rows
  int getVGap() {
    return _vgap;
  }

  /// Specifies the gap between columns
  void setHGap(int hgap) {
    _hgap = hgap;
    _requestLayout();
  }

  /// Returns the currently specified gap between columns
  int getHGap() {
    return _hgap;
  }

  int _gaps(int count, int gap) => count > 1 ? (count - 1) * gap : 0;

  @override
  WxSize calcMin() {
    final rows = getEffectiveRowsCount();
    if (rows == 0) return WxSize.zero;
    int cellWidth = 0, cellHeight = 0;
    for (final item in _items) {
      if (!item.isShown()) continue;
      final size = item.getMinSizeWithBorder();
      cellWidth = max(cellWidth, size.x);
      cellHeight = max(cellHeight, size.y);
    }
    return WxSize(_cols * cellWidth + _gaps(_cols, _hgap), rows * cellHeight + _gaps(rows, _vgap));
  }

  @override
  void repositionChildren() {
    final rows = getEffectiveRowsCount();
    if (rows == 0) return;
    final cellWidth = max(0, (_size.x - _gaps(_cols, _hgap)) ~/ _cols);
    final cellHeight = max(0, (_size.y - _gaps(rows, _vgap)) ~/ rows);
    for (int i = 0; i < _items.length; i++) {
      final item = _items[i];
      if (!item.isShown()) continue;
      final col = i % _cols;
      final row = i ~/ _cols;
      _placeInCell(item, _position.x + col * (cellWidth + _hgap),
          _position.y + row * (cellHeight + _vgap), cellWidth, cellHeight);
    }
  }
}

// ------------------------- wxFlexGridSizer ----------------------

/// Like [WxGridSizer], but every column is as wide as its widest item and
/// every row as high as its highest item. Additional space goes to the
/// columns and rows made growable with [addGrowableCol] and
/// [addGrowableRow] (in relation to their proportion).
///
/// ```dart
///   final grid = WxFlexGridSizer(2, vgap: 8, hgap: 8);
///   grid.add(WxStaticText(this, -1, "Name:"), flag: wxALIGN_CENTER_VERTICAL);
///   grid.add(WxTextCtrl(this, -1), flag: wxEXPAND);
///   grid.addGrowableCol(1);
/// ```
class WxFlexGridSizer extends WxGridSizer {
  /// Creates a [WxFlexGridSizer] with the given number of column and optional gap between items.
  WxFlexGridSizer(super.cols, {super.vgap = 0, super.hgap = 0});

  final Map<int, int> _growableCols = {};
  final Map<int, int> _growableRows = {};
  int _flexibleDirection = wxBOTH;
  int _nonFlexibleGrowMode = wxFLEX_GROWMODE_SPECIFIED;
  List<int> _colWidths = [];
  List<int> _rowHeights = [];

  /// Adds the col at [index] to the growable columns.
  void addGrowableCol(int index, {int proportion = 0}) {
    _growableCols[index] = proportion;
    _requestLayout();
  }

  /// Adds the row at [index] to the growable rows.
  ///
  /// Currently wxDart Native only.
  void addGrowableRow(int index, {int proportion = 0}) {
    _growableRows[index] = proportion;
    _requestLayout();
  }

  /// Remove the column from the flexible columns.
  void removeGrowableCol(int index) {
    _growableCols.remove(index);
    _requestLayout();
  }

  /// Remove the row from the flexible rows.
  ///
  /// Currently wxDart Native only.
  void removeGrowableRow(int index) {
    _growableRows.remove(index);
    _requestLayout();
  }

  /// Returns true of column at [index] is growable
  bool isColGrowable(int index) {
    return _growableCols.containsKey(index);
  }

  /// Returns true of row is growable. Currently always returns false
  /// in wxDart Flutter.
  bool isRowGrowable(int index) {
    return _growableRows.containsKey(index);
  }

  void setFlexibleDirection(int direction) {
    _flexibleDirection = direction;
    _requestLayout();
  }

  /// Returns the flexible direction.
  ///
  /// Currently wxDart Native only.
  int getFlexibleDirection() {
    return _flexibleDirection;
  }

  /// Sets the non-flexibel grow mode.
  ///
  /// Currently wxDart Native only.
  void setNonFlexibleGrowMode(int mode) {
    _nonFlexibleGrowMode = mode;
    _requestLayout();
  }

  int getNonFlexibleGrowMode() {
    return _nonFlexibleGrowMode;
  }

  List<int> getColWidths() {
    return List<int>.unmodifiable(_colWidths);
  }

  List<int> getRowHeights() {
    return List<int>.unmodifiable(_rowHeights);
  }

  void _calcRowsAndCols() {
    final rows = getEffectiveRowsCount();
    _colWidths = List<int>.filled(_cols, 0);
    _rowHeights = List<int>.filled(rows, 0);
    for (int i = 0; i < _items.length; i++) {
      final item = _items[i];
      if (!item.isShown()) continue;
      final size = item.getMinSizeWithBorder();
      final col = i % _cols;
      final row = i ~/ _cols;
      _colWidths[col] = max(_colWidths[col], size.x);
      _rowHeights[row] = max(_rowHeights[row], size.y);
    }
  }

  int _sum(List<int> values) => values.fold(0, (a, b) => a + b);

  @override
  WxSize calcMin() {
    _calcRowsAndCols();
    if (_rowHeights.isEmpty) return WxSize.zero;
    return WxSize(_sum(_colWidths) + _gaps(_cols, _hgap),
        _sum(_rowHeights) + _gaps(_rowHeights.length, _vgap));
  }

  /// Distributes [extra] pixels among [sizes] according to [growable]
  void _distribute(List<int> sizes, int extra, Map<int, int> growable, bool flexible) {
    if (extra <= 0 || sizes.isEmpty) return;
    Map<int, int> grow = Map<int, int>.of(growable)..removeWhere((index, _) => index >= sizes.length);
    if (!flexible) {
      if (_nonFlexibleGrowMode == wxFLEX_GROWMODE_NONE) return;
      if (_nonFlexibleGrowMode == wxFLEX_GROWMODE_ALL) {
        grow = {for (int i = 0; i < sizes.length; i++) i: 1};
      }
    }
    if (grow.isEmpty) return;
    // a proportion of 0 means "equal share"
    final allZero = grow.values.every((p) => p == 0);
    int total = 0;
    grow.forEach((index, p) => total += allZero ? 1 : p);
    if (total == 0) return;
    int remaining = extra;
    int remainingTotal = total;
    for (final entry in grow.entries) {
      final p = allZero ? 1 : entry.value;
      if (p == 0) continue;
      final share = (remaining * p / remainingTotal).round();
      sizes[entry.key] += share;
      remaining -= share;
      remainingTotal -= p;
    }
  }

  @override
  void repositionChildren() {
    _calcRowsAndCols();
    if (_rowHeights.isEmpty) return;
    final widths = List<int>.of(_colWidths);
    final heights = List<int>.of(_rowHeights);
    _distribute(widths, _size.x - _sum(widths) - _gaps(_cols, _hgap), _growableCols,
        (_flexibleDirection & wxHORIZONTAL) != 0);
    _distribute(heights, _size.y - _sum(heights) - _gaps(heights.length, _vgap), _growableRows,
        (_flexibleDirection & wxVERTICAL) != 0);

    int y = _position.y;
    for (int row = 0; row < heights.length; row++) {
      int x = _position.x;
      for (int col = 0; col < _cols; col++) {
        final index = row * _cols + col;
        if (index >= _items.length) break;
        final item = _items[index];
        if (item.isShown()) {
          _placeInCell(item, x, y, widths[col], heights[row]);
        }
        x += widths[col] + _hgap;
      }
      y += heights[row] + _vgap;
    }
  }
}
