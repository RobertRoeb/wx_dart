// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
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
  WxGridSizer( int cols, { int vgap = 0, int hgap = 0 } ) {
    _cols = cols;
    _vgap = vgap;
    _hgap = hgap;
  }

  late int _cols;
  late int _vgap;
  late int _hgap;
  bool _sizeKnown = false;
  final List<WxSizerItem> _newItems = [];

  /// Returns the actual number of columns
  int getEffectiveColsCount( ) {
    return _cols;
  }

  /// Returns the actual number of rows
  int getEffectiveRowsCount( ) {
    int count = (_items.length / _cols).floor();
    if (_items.length % _cols != 0) {
      count ++;
    }
    return count;
  }

  /// Adds a [window] as a new item.
  /// 
  /// May require a call to [WxDialog.layout] if done after the dialog
  /// (or other parent window) is shown already.
  @override
  WxSizerItem add( WxWindow window, { int proportion = 0, int flag = 0, int border = 0 } )
  {
    final newItem = super.add( window, proportion: proportion, flag: flag, border: border );
    _newItems.add( newItem );
    return newItem;
  }

  /// Prepends a [window] as a new item.
  /// 
  /// May require a call to [WxDialog.layout] if done after the dialog
  /// (or other parent window) is shown already.
  @override
  WxSizerItem prepend( WxWindow window, { int proportion = 0, int flag = 0, int border = 0 } )
  {
    final newItem = super.prepend( window, proportion: proportion, flag: flag, border: border );
    _newItems.add( newItem );
    return newItem;
  }

  /// Inserts a [window] as a new item at position [index].
  /// 
  /// May require a call to [WxDialog.layout] if done after the dialog
  /// (or other parent window) is shown already.
  @override
  WxSizerItem insert( int index, WxWindow window, { int proportion = 0, int flag = 0, int border = 0 } )
  {
    final newItem = super.insert( index, window, proportion: proportion, flag: flag, border: border );
    _newItems.add( newItem );
    return newItem;
  }

  @override
  WxSizerItem addSizer( WxSizer sizer, { int proportion = 0, int flag = 0, int border = 0 } )
  {
    final newItem = super.addSizer( sizer, proportion: proportion, flag: flag, border: border );
    _newItems.add( newItem );
    return newItem;
  }

  @override
  WxSizerItem prependSizer( WxSizer sizer, { int proportion = 0, int flag = 0, int border = 0 } )
  {
    final newItem = super.prependSizer( sizer, proportion: proportion, flag: flag, border: border );
    _newItems.add( newItem );
    return newItem;
  }

  @override
  WxSizerItem insertSizer( int index, WxSizer sizer, { int proportion = 0, int flag = 0, int border = 0 } )
  {
    final newItem = super.insertSizer( 0, sizer, proportion: proportion, flag: flag, border: border );
    _newItems.add( newItem );
    return newItem;
  }

  /// Causes the [WxGridSizer] to layout again, e.g. after a change
  /// to a control's size after the sizer aleady had been shown.
  @override
  void layout() 
  {
    // Only update new items if some have been added.
    if (_newItems.isNotEmpty) {
      // Calculate everything anew. This might cause flicker. 
      _sizeKnown = false;
    }
    super.layout();
  }

  /// Specifies the gap between rows
  void setVGap( int vgap) {
    _vgap = vgap;
  }

  /// Returns the currently specified gap between rows
  int getVGap() {
    return _vgap;
  }

  /// Specifies the gap between columns
  void setHGap( int hgap) {
    _hgap = hgap;
  }

  /// Returns the currently specified gap between columns
  int getHGap() {
    return _hgap;
  }

  @override
  Widget _build(BuildContext context, WxWindow owner)
  {
    // all cells are as large as the largest item, in a single layout pass
    _newItems.clear();
    _sizeKnown = true;

    final cols = getEffectiveColsCount();
    final cellCount = getEffectiveRowsCount() * cols;
    final children = <Widget>[];
    final flags = <int>[];
    for (int index = 0; index < cellCount; index++) {
      if (index < _items.length) {
        children.add( _wxBuildGridCell( context, owner, _items[index] ) );
        flags.add( _items[index]._flag );
      } else {
        children.add( const SizedBox.shrink() );
        flags.add( 0 );
      }
    }

    final grid = _WxGridLayout(
      cols: cols,
      flags: flags,
      hgap: getHGap().toDouble(),
      vgap: getVGap().toDouble(),
      uniform: true,
      children: children,
    );

    return ReportSize( child: grid,
          onSizeChange: (size) {
            _setSizeInternal( WxSize(size.width.floor(),size.height.floor()) );
          }
        );
  }
}
