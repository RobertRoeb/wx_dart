// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxStaticLine ----------------------

const int wxLI_HORIZONTAL = wxHORIZONTAL;
const int wxLI_VERTICAL = wxVERTICAL;

/// Shows a static line
/// 
/// # Window styles
/// | constant | meaning |
/// | -------- | -------- |
/// | wxLI_HORIZONTAL | wxHORIZONTAL |
/// | wxLI_VERTICAL | wxVERTICAL |
/// 
/// Example usage:
/// dart```
/// class MyDialog extends WxDialog
/// {
///   MyDialog( WxWindow parent ) : super( parent, -1, "Hello", size: WxSize(800,600) )
///   {
///     final mainSizer = WxRow();
///     setSizer( mainSizer );
/// 
///     // Add something big on top
///     final notebook = WxNotebook( this, -1 );
///     mainSizer.add( notebook, proportion: 1, flag: wxEXPAND|wxALL, border: 5 );
/// 
///     // Add page1 
///     final page1 = WxPanel( notebook, -1 );
///     notebook.addPage(page1, "page one" );
/// 
///     // Add more pages etc.
/// 
///     // Now add static line as a visual separator
///     mainSizer.add( WxStaticLine( this, -1 ), flag: wxEXPAND|wxALL, border: 5 );
/// 
///     // Add standard buttons at the bottom
///     mainSizer.addSizer(createStdDialogButtonSizer(wxOK|wxCANCEL), flag: wxALL|wxALIGN_RIGHT, border: 10);
///   }
/// }
///```

class WxStaticLine extends WxControl {
  WxStaticLine( super.parent, super.id, { super.pos, super.size, super.style = wxLI_HORIZONTAL } );

  @override
  Widget _build(BuildContext context)
  {
    Widget line = Divider();
    return _buildControl(context, line );
  }
}
