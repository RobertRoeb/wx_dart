// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxStaticBox ----------------------

/// Draws a frame around a group of child controls, optionally with 
/// a title/label. used to logically group controls.
/// 
/// Often used with [WxStaticBoxSizer].

class WxStaticBox extends WxControl {
  WxStaticBox( super._parent, super._id, this._label, { super.pos = wxDefaultPosition, super.size = wxDefaultSize, super.style = 0 } );

  final String _label;
  WxStaticBoxSizer? _staticBoxSizer;


  void _associateSizer( WxStaticBoxSizer sizer ) {
    _staticBoxSizer = sizer;
  }

  @override
  Widget _build( BuildContext context )
  {
    return 
       _doBuildRadioButtonGroup(context, 
          _buildControl( context,
          IntrinsicWidth( child:
          InputDecorator(
              decoration: InputDecoration(
                labelText: _label,
                border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: _staticBoxSizer != null 
                ? _staticBoxSizer!._buildChildren(context, this)
                : super._build(context),
            ) )
          ) );
  }
}
