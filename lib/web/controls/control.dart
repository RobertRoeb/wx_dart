// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-11-15
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxControl ----------------------

/// Base class for controls. Controls are native HTML elements whose
/// best size is measured by the browser.
///
/// Controls receive a [WxUpdateUIEvent] during idle time which they
/// (or their parents, as it is a command event) can use to enable,
/// show or relabel them.
class WxControl extends WxWindow {
  WxControl(WxWindow parent, int id,
      {WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = 0})
      : super(parent, id, pos, size, style);

  @override
  WxSize _doGetBestSize() {
    final s = _jsMeasure(_handle, -1);
    return WxSize(s.w, s.h);
  }

  @override
  void _sendUpdateUI() {
    final event = WxUpdateUIEvent(id: getId());
    event.setEventObject(this);
    if (!processEvent(event)) return;
    _applyUpdateUI(event);
  }

  /// Applies the result of a [WxUpdateUIEvent]; overridden by controls
  /// for which check or text mean something else.
  void _applyUpdateUI(WxUpdateUIEvent event) {
    if (event.getSetEnabled() && (event.getEnabled() != isThisEnabled())) {
      enable(enable: event.getEnabled());
    }
    if (event.getSetShown() && (event.getShown() != isShown())) {
      show(show: event.getShown());
    }
    if (event.getSetText() && (event.getText() != getLabel())) {
      setLabel(event.getText());
    }
  }

  /// Returns the label without mnemonics
  String getLabelText() {
    return _wxStripMnemonic(getLabel());
  }
}
