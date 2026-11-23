// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-11-15
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- EVT_BUTTON ----------------------

// ------------------------- wxAnyButton ----------------------

/// Base class of buttons that can show a bitmap next to (or instead of)
/// their label: [WxButton], [WxBitmapButton], [WxBitmapToggleButton].
/// 
/// In wxDart Web, the label bitmap is shown, and the disabled bitmap
/// while the button is disabled; the current, pressed and focus bitmaps
/// are remembered but not used.
class WxAnyButton extends WxControl {
  WxAnyButton(super.parent, super.id,
      {super.pos = wxDefaultPosition, super.size = wxDefaultSize, super.style = 0});

  int _direction = wxLEFT;
  WxSize _margins = wxDefaultSize;
  WxBitmapBundle? _bitmapLabel;
  WxBitmapBundle? _bitmapCurrent;
  WxBitmapBundle? _bitmapDisabled;
  WxBitmapBundle? _bitmapPressed;
  WxBitmapBundle? _bitmapFocus;

  /// Sets the bitmap shown on the button, by default left of the label
  void setBitmap( WxBitmapBundle bitmap, { int direction = wxLEFT } ) {
    _direction = direction;
    _bitmapLabel = bitmap;
    _bitmapCurrent = bitmap;
    _bitmapDisabled = bitmap;
    _bitmapPressed = bitmap;
    _bitmapFocus = bitmap;
    _updateJsBitmap();
  }

  void setBitmapCurrent( WxBitmapBundle bitmap ) {
    _bitmapCurrent = bitmap;
  }

  void setBitmapDisabled( WxBitmapBundle bitmap ) {
    _bitmapDisabled = bitmap;
    _updateJsBitmap();
  }

  void setBitmapFocus( WxBitmapBundle bitmap ) {
    _bitmapFocus = bitmap;
  }

  void setBitmapPressed( WxBitmapBundle bitmap ) {
    _bitmapPressed = bitmap;
  }

  void setBitmapLabel( WxBitmapBundle bitmap ) {
    _bitmapLabel = bitmap;
    _updateJsBitmap();
  }

  void setBitmapMargins( int x, int y ) {
    _margins = WxSize(x, y);
  }

  /// Sets where the bitmap is shown: wxLEFT, wxRIGHT, wxTOP or wxBOTTOM
  void setBitmapPosition( int dir ) {
    _direction = dir;
    _updateJsBitmap();
  }

  void _updateJsBitmap() {
    var bundle = _bitmapLabel;
    if (!isThisEnabled() && _bitmapDisabled != null) bundle = _bitmapDisabled;
    if (bundle == null) {
      _jsButtonSetBitmap(_handle, 0, 0, 0, _direction, false);
    } else {
      final bitmap = bundle.getBitmapFor(this);
      final size = bundle._logicalSize();
      _jsButtonSetBitmap(_handle, bitmap._handle, size.x, size.y, _direction, hasFlag(wxBU_NOTEXT));
      // the size is only known when the bitmap has been loaded
      _updateWhenLoaded(bitmap, _updateJsBitmap);
    }
    _labelOrFontChanged();
  }

  @override
  void enable({bool enable = true}) {
    super.enable(enable: enable);
    if (_bitmapDisabled != null && _bitmapDisabled != _bitmapLabel) _updateJsBitmap();
  }
}

// ------------------------- wxButton ----------------------

String _wxGetStockLabel(int id) {
  switch (id) {
    case wxID_OK: return "OK";
    case wxID_CANCEL: return "Cancel";
    case wxID_YES: return "Yes";
    case wxID_NO: return "No";
    case wxID_APPLY: return "Apply";
    case wxID_CLOSE: return "Close";
    case wxID_HELP: return "Help";
    case wxID_EXIT: return "Quit";
    case wxID_ABOUT: return "About";
    default: return "";
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
/// Example usage
/// ```dart
///  final myButton = WxButton( parent, -1, "Start it!");
///  myButton.bindButtonEvent((_)
///  {
///    // actually start something!
///  }, -1);
///```
///
/// Main interface
/// * [setLabel]
/// * [getLabel]
/// * [setBackgroundColour]
/// * [getBackgroundColour]
///
/// # Events emitted
/// [Button](/wxdart/wxGetButtonEventType.html) event gets sent when the button is pressed. |
/// | ----------------- |
/// | void bindButtonEvent( void function( [WxCommandEvent] event ), int id ) |
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
/// A push button, implemented as an HTML <button>.
class WxButton extends WxAnyButton {
  WxButton(super.parent, super.id, String label,
      {super.pos = wxDefaultPosition, super.size = wxDefaultSize, super.style = 0}) {
    setLabel(label.isEmpty ? _wxGetStockLabel(getId()) : label);
  }

  @override
  String get _jsKind => 'button';

  /// Sets the label. A "&" marks the mnemonic and is not shown.
  @override
  void setLabel(String label) {
    _label = label;
    _jsSetLabel(_handle, _wxStripMnemonic(label));
    if (_bitmapLabel != null) _updateJsBitmap(); // label shown or not
    _labelOrFontChanged();
  }

  /// Makes this the default button (highlighted, activated by Enter
  /// in dialogs if its id is the affirmative id)
  void setDefault() {
    _jsSetDefaultButton(_handle);
  }

  @override
  bool _wantsNativeKey(int keyCode) {
    return (keyCode == WXK_RETURN) || (keyCode == WXK_NUMPAD_ENTER) || (keyCode == WXK_SPACE);
  }

  /// Returns the default size of buttons
  static WxSize getDefaultSize() {
    return const WxSize(80, 28);
  }

  void _sendClickEvent() {
    final event = WxCommandEvent(wxGetButtonEventType(), getId());
    event.setEventObject(this);
    event.setString(getLabelText());
    processEvent(event);
  }
}

// ------------------------- wxBitmapButton ----------------------

/// A button showing a bitmap instead of a label
/// 
/// ```dart
/// final button = WxBitmapButton( this, -1, WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.save, const WxSize(20,20)) );
/// ```
class WxBitmapButton extends WxButton {
  WxBitmapButton( WxWindow parent, int id, WxBitmapBundle bitmap, { super.pos, super.size, super.style } )
  : super( parent, id, "" ) {
    setBitmap( bitmap );
  }
}
