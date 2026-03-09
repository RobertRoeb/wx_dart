// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- TrianglePainter --------------------------

/// @nodoc

class TrianglePainter extends CustomPainter {
  TrianglePainter( this.up, { this.border = 2, this.otherBorder = 0 } );

  final bool up;
  final double border;
  final double otherBorder;

  @override
  void paint(Canvas canvas, Size size) {
    final WxColour p = wxTheApp.getSecondaryAccentColour();

    final paint = Paint()
      ..color = Color.fromARGB(p.alpha, p.red, p.green, p.blue )
      ..style = PaintingStyle.fill
      ..strokeWidth = 2.0;

    final path = Path();
    if (up) {
      path.moveTo(size.width / 2, otherBorder);
      path.lineTo(size.width, size.height-border);
      path.lineTo(0, size.height-border);
    } else {
      path.moveTo(size.width / 2, size.height-otherBorder);
      path.lineTo(size.width, border);
      path.lineTo(0, border);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // Repaint only if the underlying properties change
    return false;
  }
}
// ------------------------- wxControl ----------------------

/// Base class for all native control and many generic ones.

abstract class WxControl extends WxWindow {
  WxControl( WxWindow parent, int id, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = 0 } ) 
    : super( parent, id, pos, size, style );

  Widget _buildControl( BuildContext context, Widget control )
  {
    return _doBuildBackgroundAndBorder(context, 
      ReportSize( 
        key: _getWidgetKey(),
        child: control, 
      onSizeChange: (size) {
        WxSize wxSize = WxSize(size.width.floor(),size.height.floor());
          // add border calculation
          _setSizeInternal(wxSize);
      }   ) );
  }
}
