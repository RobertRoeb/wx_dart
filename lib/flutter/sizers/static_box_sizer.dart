// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
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
    _staticBox._associateSizer( this );
  }

  late WxStaticBox _staticBox;

  /// Returns the [WxStaticBox] associated with this sizer. All controls
  /// owned by this sizer need to be child windows of this [WxStaticBox].
  WxStaticBox getStaticBox( ) {
    return _staticBox;
  }

  @override
  WxSizerItem add( WxWindow window, { int proportion = 0, int flag = 0, int border = 0 } )
  {
    if (window.getParent() != _staticBox) {
      wxLogError( "Child of WxStaticBoxSizer needs to use its WxStaticBox as parent" );
    }
    return super.add( window, proportion: proportion, flag: flag, border: border );
  }

  @override
  WxSizerItem prepend( WxWindow window, { int proportion = 0, int flag = 0, int border = 0 } )
  {
    if (window.getParent() != _staticBox) {
      wxLogError( "Child of WxStaticBoxSizer needs to use its WxStaticBox as parent" );
    }
    return super.prepend( window, proportion: proportion, flag: flag, border: border );
  }

  @override
  WxSizerItem insert( int index, WxWindow window, { int proportion = 0, int flag = 0, int border = 0 } )
  {
    if (window.getParent() != _staticBox) {
      wxLogError( "Child of WxStaticBoxSizer needs to use its WxStaticBox as parent" );
    }
    return super.insert( 0, window, proportion: proportion, flag: flag, border: border );
  }

  @override
  Widget _build( BuildContext context, WxWindow owner ) {
    return _staticBox._build( context );
  }

  Widget _buildChildren( BuildContext context, WxWindow owner ) {
    return super._build( context, owner );
  }
}
