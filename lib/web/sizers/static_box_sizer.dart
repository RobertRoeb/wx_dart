// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01 (wxDart Web: 2026-11-15)
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxStaticBoxSizer ----------------------

/// This sizer wraps a border or box around the child items and optionally
/// puts a title to the top.
/// 
/// NOTE: All windows managed by the sizer need to be child windows of the 
/// [WxStaticBox] returned by [getStaticBox], not of the owning dialog!
/// 
/// Example:
/// ```dart
/// // in the constructor of a dialog...
/// final mainSizer = WxColumn();
/// setSizer( mainSizer );
/// 
/// // create static boxsizer
/// final sbs = WxStaticBoxSizer( wxVERTICAL, this, 'Title' );
/// 
/// // add it to mainSizer
/// mainSizer.addSizer( sbs );
/// 
/// // add two text fields to interior of static boxsizer
/// final textCtrl1 = WxTextCtrl( sbs.getStaticBox(), -1, value: "Text #1");
/// sbs.add( textCtrl1, flag: wxALL|wxEXPAND, border: 5 );
/// final textCtrl2 = WxTextCtrl( sbs.getStaticBox(), -1, value: "Text #2");
/// sbs.add( textCtrl2, flag: wxALL|wxEXPAND, border: 5 );
/// 
/// // add buttons etc.
/// ```

class WxStaticBoxSizer extends WxBoxSizer {
  WxStaticBoxSizer( super.orientation, WxWindow parent, String label ) {
    _staticBox = WxStaticBox( parent, -1, label );
    // changes inside the box lay out the window around it
    _staticBox._containingSizer = this;
  }

  late WxStaticBox _staticBox;

  /// Returns the [WxStaticBox] associated with this sizer. All controls
  /// owned by this sizer need to be child windows of this [WxStaticBox].
  WxStaticBox getStaticBox( ) {
    return _staticBox;
  }

  void _checkParent( WxWindow window ) {
    if (window.getParent() != _staticBox) {
      wxLogError( "Child of WxStaticBoxSizer needs to use its WxStaticBox as parent" );
    }
  }

  @override
  WxSizerItem add( WxWindow window, { int proportion = 0, int flag = 0, int border = 0 } )
  {
    _checkParent( window );
    return super.add( window, proportion: proportion, flag: flag, border: border );
  }

  @override
  WxSizerItem prepend( WxWindow window, { int proportion = 0, int flag = 0, int border = 0 } )
  {
    _checkParent( window );
    return super.prepend( window, proportion: proportion, flag: flag, border: border );
  }

  @override
  WxSizerItem insert( int index, WxWindow window, { int proportion = 0, int flag = 0, int border = 0 } )
  {
    _checkParent( window );
    return super.insert( index, window, proportion: proportion, flag: flag, border: border );
  }

  @override
  WxSize calcMin() {
    final inner = super.calcMin();
    final c = _staticBox._chrome();
    final best = _staticBox._doGetBestSize();
    return WxSize( max( inner.x + c.l + c.r, best.x ), inner.y + c.t + c.b );
  }

  /// The items only get the space inside the frame of the box
  @override
  bool informFirstDirection( int direction, int size, int availableOtherDir ) {
    if (size < 0) return false;
    final c = _staticBox._chrome();
    final frame = direction == wxHORIZONTAL ? c.l + c.r : c.t + c.b;
    return super.informFirstDirection( direction, max( 0, size - frame ), -1 );
  }

  /// Positions the box at [pos] with [size] (in the coordinates of the
  /// parent window) and the items inside it (in the box's coordinates)
  @override
  void setDimension( WxPoint pos, WxSize size ) {
    _staticBox._setActualRect( pos.x, pos.y, size.x, size.y );
    final c = _staticBox._chrome();
    super.setDimension( WxPoint.zero, WxSize( max( 0, size.x - c.l - c.r ), max( 0, size.y - c.t - c.b ) ) );
  }
}
