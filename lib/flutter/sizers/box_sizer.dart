// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxBoxSizer ----------------------

/// Most important sizer. Lays out child controls in either a 
/// row or a column, depending on [orientation] being wxHORIZONTAL 
/// or wxVERTICAL.
/// 
/// * [WxColumn] is a synonym for a vertical [WxBoxSizer].
/// * [WxRow] is a synonym for a horizontal [WxBoxSizer].
/// 
/// For each added item, you can usually specify a border (space around the item) 
/// and which of the four sides that border (space) should be:
/// ```dart
/// class MyPanel extends WxPanel {
///   MyPanel( super.parent, super.id ) 
///   {
///     // Create a vertical sizer 
///     final mainSizer = WxBoxSizer(wxVERTICAL);
/// 
///     // Tell panel to actually use that sizer
///     setSizer( mainSizer );
/// 
///     // Create a text field
///     final text = WxTextCtrl( this, -1 );
/// 
///     // Add text field with border (space) of 5 pixel all around
///     mainSizer.add( text, border: 5, flag: wxALL );
///     // same as: mainSizer.add( text, border: 5, flag: WxSizerFlags.borderAll() );
///   }
/// }
/// ``` 
/// If the border (space) should just be left and right of the control,
/// change the flag like this
/// ```dart
///     mainSizer.add( text, border: 5, flag: wxLEFT|wxRIGHT );
///     // same as: mainSizer.add( text, border: 5, flag: WxSizerFlags.border(left: true, right: true) );
/// ``` 
/// The flag field is also used to indicate alignment if there is more space
/// than minimally needed in the secondary direction. In our case, the sizer
/// is vertical so the secondary direction is horizontal. We now want to
/// indicate that the text field should stretch out horizontally completely
/// if the owning panel grows horizontally using the [wxEXPAND] flag:
/// ```dart
///     mainSizer.add( text, border: 5, flag: wxEXPAND|wxLEFT|wxRIGHT );
///     // same as: mainSizer.add( text, border: 5, flag: WxSizerFlags.border(left: true, right: true, halign: WxHAlignment.expand) );
///     // same as: mainSizer.add( text, border: 5, flag: WxSizerFlags.expand(left: true, right: true) );
/// ``` 
/// If, however, you want the text field to not stretch out completely, but
/// rather be aligned to the right, then you use the corresponding [wxALIGN_RIGHT]
/// flag. In our case, this will require the text field to actually have a 
/// given width as there is no "natural" width of a text field (other controls,
/// like [WxButton], have a natural width on a given platfrom determined
/// from label size, presence of an icon and standard button sizes). In this
/// example, we choose an arbitrary 150 pixel width. The two borders of 5 pixels
/// on both sides come on top.
/// 
/// ```dart
///     final text = WxTextCtrl( this, -1, size: WxSize(150,-1) );
///     mainSizer.add( text, border: 5, flag: wxALIGN_RIGHT|wxLEFT|wxRIGHT );
///     // same as: mainSizer.add( text, border: 5, flag: WxSizerFlags.border(left: true, right: true, halign: WxHAlignment.right) );
/// ``` 
/// Often, you will want to stretch out controls also in the primary direction,
/// in our example vertically. This does not make sense for a single-line text field,
/// but does make sense for a multi-line text field. 
/// 
/// Stretching out in the primary direction is achieved using the _proportion_
/// parameter. This can be given to different child items in a sizer and the surplus
/// space (if any) will be distributed across those child items according to their
/// respective _proportion_ parameter. 
/// 
/// We now stretch out the text field both horizontally (using the flag [wxEXPAND])
/// and vertically (using proportion of >1).
/// 
/// ```dart
///     final text = WxTextCtrl( this, -1, style: wxTE_MULTILINE );
///     mainSizer.add( text, border: 5, flag: wxEXPAND|wxALL, proportion: 1 );
///     // same as: mainSizer.add( text, border: 5, flag: WxSizerFlags.borderAll( halign: WxHAlignment.expand ) );
/// ``` 
/// At the end, we create a [WxDialog] with a completely stretched out multiline 
/// [WxTextCtrl] and a right aligned [WxButton] at the bottom.
/// ```dart
/// class MyDialog extends WxDialog {
///   MyDialog( super.parent, super.id, super.title ) 
///   {
///     final mainSizer = WxBoxSizer(wxVERTICAL);
///     setSizer( mainSizer );
/// 
///     final text = WxTextCtrl( this, -1, style: wxTE_MULTILINE );
///     mainSizer.add( text, border: 5, flag: wxEXPAND|wxALL, proportion: 1 );
/// 
///     final button = WxButton( this, wxID_OK, "OK" );
///     mainSizer.add( button, border: 5, flag: wxALIGN_RIGHT|wxALL );
///   }
/// }
/// ```
/// _Experimental API:_
/// To avoid typing errors when constructing the _flag_ parameter, the [WxSizerFlags]
/// class has been introduced  although in a different way than in the original C++ library.
/// In wxDart, [WxSizerFlags] consists of static functions that translate the parameters
/// into the _flag_ parameter.
/// 
/// The same as above, but using the [WxSizerFlags] helper class.
/// 
/// ```dart
/// class MyDialog extends WxDialog {
///   MyDialog( super.parent, super.id, super.title ) 
///   {
///     final mainSizer = WxColumn();
///     setSizer( mainSizer );
/// 
///     final text = WxTextCtrl( this, -1, style: wxTE_MULTILINE );
///     mainSizer.add( text, border: 5, flag: WxSizerFlags.borderAll( halign: WxHAlignment.expand ), proportion: 1 );
/// 
///     final button = WxButton( this, wxID_OK, "OK" );
///     mainSizer.add( button, border: 5, flag: WxSizerFlags.borderAll( halign: WxHAlignment.right ) );
///   }
/// }
/// ``` 
/// 
/// # Constants
/// 
/// These flags determine on which side of a control extra 'border' space should be added
/// 
/// | constant | value |
/// | -------- | -------- |
/// | wxLEFT | 0x0010 |
/// | wxRIGHT | 0x0020 |
/// | wxUP | 0x0040 |
/// | wxDOWN | 0x0080 |
/// | wxTOP | wxUP |
/// | wxBOTTOM | wxDOWN |
/// | wxNORTH | wxUP |
/// | wxSOUTH | wxDOWN |
/// | wxWEST | wxLEFT |
/// | wxEAST | wxRIGHT |
/// | wxALL | (wxUP \| wxDOWN \| wxRIGHT \| wxLEFT) |
/// | wxDIRECTION_MASK | wxALL |
/// 
/// These flags determine the alignment
/// 
/// | constant | value |
/// | -------- | -------- |
/// | wxALIGN_INVALID | -1 |
/// | wxALIGN_NOT | 0x0000 |
/// | wxALIGN_CENTER_HORIZONTAL | 0x0100 |
/// | wxALIGN_CENTRE_HORIZONTAL | wxALIGN_CENTER_HORIZONTAL |
/// | wxALIGN_LEFT | wxALIGN_NOT |
/// | wxALIGN_TOP | wxALIGN_NOT |
/// | wxALIGN_RIGHT | 0x0200 |
/// | wxALIGN_BOTTOM | 0x0400 |
/// | wxALIGN_CENTER_VERTICAL | 0x0800 |
/// | wxALIGN_CENTRE_VERTICAL | wxALIGN_CENTER_VERTICAL |
/// | wxALIGN_CENTER | (wxALIGN_CENTER_HORIZONTAL \| wxALIGN_CENTER_VERTICAL) |
/// | wxALIGN_CENTRE | wxALIGN_CENTER |
/// | wxALIGN_MASK | 0x0f00 |
/// 
/// These flags determine the stretch behaviour. [wxEXPAND] is used for the
/// secondary direction (vertical stretch behaviour in a horizontal sizer and 
/// vice versa). The _proportion_ parameter in [WxSizer.add] determines the
/// stretch behaviour in the primary direction.
/// 
/// | constant | value |
/// | -------- | -------- |
/// | wxSTRETCH_NOT | 0x0000 |
/// | wxSHRINK | 0x1000 (shrink below minimal/initial size, always on in wxDart Flutter) |
/// | wxGROW | 0x2000 |
/// | wxEXPAND | wxGROW |
/// | wxSHAPED | 0x4000 (not supported in wxDart Flutter)|
/// | wxTILE | 0xc000 |
/// | wxSTRETCH_MASK | 0x7000 |

class WxBoxSizer extends WxSizer {
  WxBoxSizer( int orientation ) {
    _orientation = orientation;
  }

  late int _orientation;

  /// Sets the orientation
  void setOrientation( int orientation ) {
    _orientation = orientation;
  } 

  /// Returns the orientation
  int getOrientation() {
    return _orientation;
  } 

  @override
  Widget _build( BuildContext context, WxWindow owner ) {
    if (_orientation == wxHORIZONTAL) {

      Row row = Row( 
        mainAxisSize: MainAxisSize.min,
        children: [] );

/*      row.children.add( 
        Align( 
               alignment: const Alignment(0, -1.0),
               child: Text( "Text" ) )
        );
      row.children.add( 
        Expanded( flex: 1, 
              child: Align( 
               alignment: const Alignment(0, -1.0),
               child: TextField() ) ) );
      return row;
*/

      bool hasExpanded = false;

      for (WxSizerItem item in _items)
      {
        Widget ? finalWidget;
        if (item._kind == WxSizerKind.spacer)
        {
          item._spacerParentWindow = owner;
          finalWidget = ReportSize( 
            child: SizedBox(
              key: item._spacerWidgetKey,
              width: item._width.toDouble()), 
              onSizeChange: (size) { 
              item.spacerSize = WxSize(size.width.floor(),size.height.floor());
            } 
          );
          // finalWidget = SizedBox(height: item.height.toDouble());
        } else 
        if (item._kind == WxSizerKind.window) {
          if (!item._window!.isShown()) continue;
          finalWidget = item._window!._build( context );
          WxSize size = item._window!.getMinSize();
          
          if (((size.x != -1) && (item._proportion ==0)) || (size.y != -1))
          {
            finalWidget = SizedBox(
              width:  (item._proportion !=0) ? double.infinity : (size.x != -1) ? size.x.toDouble() : null,
              height: (size.y != -1) ? size.y.toDouble() : null,
              child: finalWidget
            );
          }
        } else 
        if (item._kind == WxSizerKind.sizer) {
          finalWidget = item._sizer!._build( context, owner );
        } else {
          return Text( 'empty WxSizerItem created');
        }

        if ((item._flag & wxALIGN_BOTTOM) != 0) {
            finalWidget = Align( 
               alignment: const Alignment(0, 1.0),
               child: finalWidget );
          } else 
          if ((item._flag & wxEXPAND) != 0) {
            hasExpanded = true;
            finalWidget = Column( children: [
              Expanded(child: finalWidget)
            ] );
          } else 
          if ((item._flag & wxALIGN_CENTRE) == 0) {
            finalWidget = Align( 
               alignment: const Alignment(0, -1.0),
               child: finalWidget );
        }

        if (((item._flag & wxALL) != 0) && (item._border != 0)) {
          final double b = item._border.toDouble();
          finalWidget = Padding(padding: 
            EdgeInsetsGeometry.fromLTRB(
              (item._flag & wxLEFT) == 0 ? 0 : b, 
              (item._flag & wxTOP) == 0 ? 0 : b, 
              (item._flag & wxRIGHT) == 0 ? 0 : b, 
              (item._flag & wxBOTTOM) == 0 ? 0 : b), 
            child: finalWidget);
        }

        if (item._proportion != 0) {
          Expanded exp = Expanded(flex: item._proportion, child: finalWidget);
          finalWidget = exp;
        }

        row.children.add( finalWidget );
      }

      if (hasExpanded) {
        return ReportSize( child: row, 
          onSizeChange: (size) {
            _setSizeInternal( WxSize(size.width.floor(),size.height.floor()) );
          }
        );
      }
      return ReportSize( child: IntrinsicHeight( child: row ), 
        onSizeChange: (size) {
          _setSizeInternal( WxSize(size.width.floor(),size.height.floor()) );
        }
      );
    } else {

      Column col = Column( 
        mainAxisSize: MainAxisSize.min,
        children: [] );
      bool hasExpanded = false;

      for (WxSizerItem item in _items) {
        Widget ? finalWidget;
        if (item._kind == WxSizerKind.spacer)
        {
          item._spacerParentWindow = owner;
          finalWidget = ReportSize( 
              key: item._spacerWidgetKey,
            child: SizedBox(height: item._height.toDouble()), 
            onSizeChange: (size) {
              item.spacerSize = WxSize(size.width.floor(),size.height.floor());
            }
          );
        } else 
        if (item._kind == WxSizerKind.window) {
          if (!item._window!.isShown()) continue;
          finalWidget = item._window!._build( context );
          WxSize size = item._window!.getMinSize();
          if (((size.y != -1) && (item._proportion ==0)) || (size.x != -1)) {
            finalWidget = SizedBox(
              width: (size.x != -1) ? size.x.toDouble() : null,
              height:  (item._proportion !=0) ? double.infinity : (size.y != -1) ? size.y.toDouble() : null,
              child: finalWidget
            );
          }
        } else 
        if (item._kind == WxSizerKind.sizer) {
          finalWidget = item._sizer!._build( context, owner );
        } else {
          return Text( 'empty WxSizerItem created');
        }

        if ((item._flag & wxALIGN_RIGHT) != 0) {
            finalWidget = Align( 
               alignment: const Alignment(1.0, 0),
               child: finalWidget );
          } else 
          if ((item._flag & wxEXPAND) != 0) {
            hasExpanded = true;
            finalWidget = Row( children: [
              Expanded(child: finalWidget)
            ] );
          } else
          if ((item._flag & wxALIGN_CENTRE) == 0) {
            finalWidget = Align( 
               alignment: const Alignment(-1.0, 0),
               child: finalWidget );
        }

        if (((item._flag & wxALL) != 0) && (item._border != 0)) {
          final double b = item._border.toDouble();
          finalWidget = Padding(padding: 
            EdgeInsetsGeometry.fromLTRB(
              (item._flag & wxLEFT) == 0 ? 0 : b, 
              (item._flag & wxTOP) == 0 ? 0 : b, 
              (item._flag & wxRIGHT) == 0 ? 0 : b, 
              (item._flag & wxBOTTOM) == 0 ? 0 : b), 
            child: finalWidget);
        }

        if (item._proportion != 0) {
          Expanded exp = Expanded(flex: item._proportion, child: finalWidget);
          finalWidget = exp;
        }

        col.children.add( finalWidget );      
      }

      if (hasExpanded) {
        return ReportSize( child: col, 
          onSizeChange: (size)
          {
            _setSizeInternal( WxSize(size.width.floor(),size.height.floor()) );
            /* for (WxSizerItem item in items) {
              if (item.kind == WxSizerKind.sizer) {
                if (item.sizer!.isFlexGridSizerWithGrowableRow()) {
                  WxFlexGridSizer flex = item.sizer as WxFlexGridSizer;
                  flex.distributeHeightAmongGrowableRows( size.height.floor() );
                  break;
                }
              }
            } */
          } 
        );
      } 
      return ReportSize( child: IntrinsicWidth( child: col ), 
        onSizeChange: (size) {
          _setSizeInternal( WxSize(size.width.floor(),size.height.floor()) );
        } 
      );
    }
  }
}
