// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxButton ----------------------

/// @nodoc

extension ButtonEventBinder on WxEvtHandler {
  void bindButtonEvent( OnCommandEventFunc func, int id ) {
    _eventTable.add( WxCommandEventTableEntry(wxGetButtonEventType(), id, func));
  }

  void unbindButtonEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetButtonEventType(), id));
  }
}

/// Represents a button.
/// 
/// It may contain a text label and/or an image ([WxBitmapBundle]) using
/// [setBitmap]. Different platforms may enforce different buttons sizes
/// as per the system's standard. 
/// 
/// Using buttons with certain pre-defined IDs like [wxID_OK], [wxID_CANCEL]
/// or [wxID_APPLY] in a [WxDialog] will automatically close the dialog
/// using event handlers in [WxDialog]. See also [WxDialog.setAffirmativeId].
/// 
/// # Events emitted
/// [Button](/wxdart/wxGetButtonEventType.html) event gets sent when the button is pressed. |
/// | ----------------- |
/// | void bindButtonEvent( void function( [WxCommandEvent] event ) ) |
/// | void unbindButtonEvent() |
/// 
/// # Windows styles
/// | constant | meaning |
/// | -------- | -------- |
/// | wxBU_LEFT | 0x0040 |
/// | wxBU_TOP | 0x0080 |
/// | wxBU_RIGHT | 0x0100 |
/// | wxBU_BOTTOM | 0x0200 |
/// | wxBU_ALIGN_MASK | ( wxBU_LEFT \| wxBU_TOP \| wxBU_RIGHT \| wxBU_BOTTOM ) |
/// | wxBU_EXACTFIT | 0x0001 |
/// | wxBU_NOTEXT | 0x0002 |
/// 
class WxButton extends WxAnyButton {
  WxButton( super.parent, super.id, String label, { super.pos = wxDefaultPosition, super.size = wxDefaultSize, super.style = 0 } ) 
  {
    _label = label;
  }

  String _label = "";
  bool _isHover = false;
  WxColour ?_buttonColour;

  /// Sets the background colour of the button
  @override 
  void setBackgroundColour( WxColour col ) {
    _buttonColour = col;
  }
  
  /// Gets the background colour of the button. This may
  /// not reflect the actual colour which may be transparent or
  /// complex.
  @override 
  WxColour getBackgroundColour() {
    if (_buttonColour == null) {
      return super.getBackgroundColour();
    }
    return _buttonColour!;
  }

  @override
  Widget _build( BuildContext context )
  {
    Widget? bitmap;
    WxBitmap? wxbitmap; 
    if (_bitmapLabel != null) {
      wxbitmap = _bitmapLabel;
    }
    if (_isHover && (_bitmapCurrent != null)) {
      wxbitmap = _bitmapCurrent;
    }

    if (wxbitmap != null)
    {
      if (wxbitmap.isOk()) {
        bitmap = RawImage( image: wxbitmap._image!, fit: BoxFit.fitHeight );
      } else {
        wxbitmap._addListener( this );
      }
    }

    ButtonStyle? flatButtonStyle;
    if (!wxTheApp.isTouch())
    {
      flatButtonStyle = OutlinedButton.styleFrom(
        visualDensity: VisualDensity.compact,
        padding: EdgeInsets.symmetric(horizontal: 10),
        minimumSize: Size(80,16),
        backgroundColor:  (_buttonColour == null) ? null : Color.fromARGB( 
                _buttonColour!.getAlpha(),
                _buttonColour!.getRed(),
                _buttonColour!.getGreen(),
                _buttonColour!.getBlue() ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
      );
    } 
    else
    {
      if (_buttonColour != null) {
        flatButtonStyle = OutlinedButton.styleFrom(
        backgroundColor:  Color.fromARGB( 
                _buttonColour!.getAlpha(),
                _buttonColour!.getRed(),
                _buttonColour!.getGreen(),
                _buttonColour!.getBlue() ),
      );
      }
    }

    return _buildControl( context, 
      MouseRegion(
        onExit: (event) {
          _isHover = false;
          _setState();
        },
        onHover: (event)  {
          _isHover = true;
          _setState();
        },
        child:
          bitmap == null 
          ? SizedBox( height: fromDIP(32).toDouble(), child:
            OutlinedButton(
              style: flatButtonStyle,
              onPressed: () {
                WxCommandEvent event = WxCommandEvent( wxGetButtonEventType(), getId() );
                event.setEventObject( this );
                processEvent( event ); 
              }, 
              /*
              style: ButtonStyle( 
                shape: WidgetStateProperty<OutlinedBorder?>.all,
              ),
              */
              child: Text ( _label ) 
            ) )
          : MaterialButton( 
            onPressed:() {
              WxCommandEvent event = WxCommandEvent( wxGetButtonEventType(), getId() );
              event.setEventObject( this );
              processEvent( event ); 
            }, 
            color: (_buttonColour == null) ? null : Color.fromARGB( 
                _buttonColour!.getAlpha(),
                _buttonColour!.getRed(),
                _buttonColour!.getGreen(),
                _buttonColour!.getBlue() ),
            minWidth: 16,
            padding: EdgeInsetsGeometry.all(0),
            shape: RoundedRectangleBorder(
              side: BorderSide( width: 0.5 ),
              borderRadius: BorderRadius.all(Radius.circular(4))
            ),
            child: 
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                Padding(padding: EdgeInsetsGeometry.all(3), child: bitmap ),
                Padding(padding: EdgeInsetsGeometry.only( right: 8), child: Text ( _label ) )
              ])
            ) 
      ) );
    }

  void setLabel( String label ) {
    _label = label;
    _setState();
  }
}
