// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-11-15
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxDialog ----------------------

/// Height of the dialog's title bar in wxc.css
const int _kDialogTitleHeight = 30;

/// A dialog, shown centred over the page with an HTML title bar.
///
/// As in wxDart Flutter, [showModal] does not block but takes a callback
/// that receives the return code once the dialog has been ended with
/// [endModal] (e.g. by pressing a button with the id wxID_OK or
/// wxID_CANCEL). The dialog is destroyed after the callback returned.
///
/// A dialog needs either a size or a sizer, as in wxDart Flutter:
/// * with a size (`size:` or [setSize]), the dialog gets that size
/// * with [setSizerAndFit], the dialog gets the minimal size of the sizer
/// * with [setSizer] only, the dialog is 500 pixels wide and as high as
///   the sizer needs at that width
/// * without both, the dialog is 500 x 300 pixels (and a debug build
///   logs a warning)
///
/// Enter presses the button with the affirmative id (wxID_OK by default),
/// Escape and the close button in the title bar the one with the escape
/// id (wxID_CANCEL by default).
///
/// # Events emitted
/// [InitDialog](/wxdart/wxGetInitDialogEventType.html) event is sent before the dialog is shown
/// | ----------------- |
/// | void bindInitDialogEvent( OnInitDialogEventFunc ) |
/// | void unbindInitDialogEvent() |
/// [DialogValidate](/wxdart/wxGetDialogValidateEventType.html) event is sent before closing with the affirmative id, call veto() to keep it open.
/// | ----------------- |
/// | void bindDialogValidateEvent( OnDialogValidateEventFunc, int id ) |
/// | void unbindDialogValidateEvent( int id ) |
/// Width of a dialog without a size and not fitted to its sizer (as in wxDart Flutter)
const int _kDefaultDialogWidth = 500;
/// Height of a dialog with neither a size nor a sizer
const int _kDefaultDialogHeight = 300;
/// A modal dialog on a touch device is a bottom sheet as wide as the
/// screen, but at most this wide on screens wider than [_kSheetFullWidthUpTo]
const int _kSheetMaxWidth = 440;
const int _kSheetFullWidthUpTo = 450;
/// Space of a bottom sheet around its client area (see wxc.css)
const int _kSheetPaddingX = 10;
const int _kSheetPaddingY = 35;
/// Space a bottom sheet leaves free above it at least
const int _kSheetTopGap = 40;

class WxDialog extends WxTopLevelWindow {
  /// Creates a dialog with the given [id] and [title].
  ///
  /// It will also install event handlers for default dialog buttons.
  WxDialog(WxWindow? parent, int id, String title,
      {WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = wxDEFAULT_DIALOG_STYLE})
      : super(parent, id, title, pos: pos, size: size, style: style) {
    bindButtonEvent(_onButton, wxID_YES);
    bindButtonEvent(_onButton, wxID_NO);
    bindButtonEvent(_onButton, wxID_OK);
    bindButtonEvent(_onButton, wxID_APPLY);
    bindButtonEvent(_onButton, wxID_CANCEL);
  }

  int _retCode = 0;
  int _affirmativeId = wxID_OK;
  int _escapeId = wxID_CANCEL;
  bool _isModal = false;
  bool _asSheet = false;   // shown as a bottom sheet
  bool _hasSentInitEvent = false;
  void Function(int, dynamic)? _onReturn;

  @override
  String get _jsKind => 'dialog';

  /// Returns ID that closes the dialog with user indicating to accept the
  /// input (like hitting OK).
  ///
  /// Default is wxID_OK.
  int getAffirmativeId() {
    return _affirmativeId;
  }

  /// Sets ID that closes the dialog like hitting OK. Default is wxID_OK.
  void setAffirmativeId(int id) {
    _affirmativeId = id;
  }

  /// Returns ID that closes the dialog like hitting ESC.
  ///
  /// Default is wxID_CANCEL.
  int getEscapeId() {
    return _escapeId;
  }

  /// Sets ID that closes the dialog like hitting ESC. Default is wxID_CANCEL.
  void setEscapeId(int id) {
    _escapeId = id;
  }

  /// Returns a sizer with buttons in a platform dependent order
  /// and layout. For possible values of [flag], see [createStdDialogButtonSizer]
  WxSizer createButtonSizer(int flags) {
    return createStdDialogButtonSizer(flags);
  }

  /// Same as [createStdDialogButtonSizer] (no separator line in wxDart Web)
  WxSizer createSeparatedButtonSizer(int flags) {
    return createStdDialogButtonSizer(flags);
  }

  /// Returns a [WxSizer] containing a horizontal element
  /// separating logical groups in a platform dependent way.
  /// It may return the incoming [sizer] unchanged.
  ///
  /// Returns [sizer] (no separator line in wxDart Web)
  WxSizer createSeparatedSizer(WxSizer sizer) {
    return sizer;
  }

  /// Returns a sizer with standard dialotg buttons in a platform dependent order
  /// and layout. For possible values of [flag], see [createStdDialogButtonSizer]
  /// and sets the respective affirmative and escape IDs that close the dialog,
  ///
  /// # flag
  /// [ constant | value |
  /// | -------- | -------- |
  /// | wxYES | button with id wxID_YES |
  /// | wxNO | button with id wxID_NO |
  /// | wxYES_NO | 2 button with id wxID_NO and wxID_YES |
  /// | wxOK | button with id wxID_OK |
  /// | wxCANCEL | button with id wxID_CANCEL |
  /// | wxAPPLY | button with if wxID_APPLY |
  /// | wxHELP | button with if wxID_HELP |
  WxSizer createStdDialogButtonSizer(int flags) {
    final sizer = WxBoxSizer(wxHORIZONTAL);
    if ((flags & wxHELP) != 0) {
      sizer.add(WxButton(this, wxID_HELP, ""), flag: wxRIGHT, border: 8);
    }
    sizer.addStretchSpacer();
    final ids = <int>[];
    if ((flags & wxYES) != 0) ids.add(wxID_YES);
    if ((flags & wxNO) != 0) ids.add(wxID_NO);
    if ((flags & wxOK) != 0) ids.add(wxID_OK);
    if ((flags & wxAPPLY) != 0) ids.add(wxID_APPLY);
    if ((flags & wxCANCEL) != 0) ids.add(wxID_CANCEL);
    for (int i = 0; i < ids.length; i++) {
      sizer.add(WxButton(this, ids[i], ""), flag: i > 0 ? wxLEFT : 0, border: 8);
    }
    if ((flags & wxYES) != 0) {
      _affirmativeId = wxID_YES;
      if ((flags & wxCANCEL) == 0 && (flags & wxNO) != 0) _escapeId = wxID_NO;
    } else if ((flags & wxOK) != 0) {
      _affirmativeId = wxID_OK;
    }
    if ((flags & wxNO_DEFAULT) != 0 && (flags & wxNO) != 0) {
      _defaultId = wxID_NO;
    } else if ((flags & wxCANCEL_DEFAULT) != 0 && (flags & wxCANCEL) != 0) {
      _defaultId = wxID_CANCEL;
    }
    return sizer;
  }

  /// Returns a [WxSizer] containing a text message in a platform dependant way.
  WxSizer createTextSizer(String message) {
    final ret = WxBoxSizer(wxVERTICAL);
    ret.add(WxStaticText(this, -1, message));
    return ret;
  }

  /// The button marked as default, if not the affirmative one
  int? _defaultId;

  /// Returns the return code of the dialog once it has been closed.
  /// The return code is the ID of the button that closed the dialog,
  /// often either of [wxID_OK] or [wxID_CANCEL].
  ///
  /// For modal dialogs, the way to be informed about the return
  /// code is via the callback given to [showModal]
  int getReturnCode() {
    return _retCode;
  }

  void setReturnCode(int retCode) {
    _retCode = retCode;
  }

  /// Returns true if the dialog is a modal dialog (blocking input
  /// to all other windows)
  bool isModal() {
    return _isModal;
  }

  void _onButton(WxCommandEvent event) {
    final id = event.getId();
    if (id == getAffirmativeId()) {
      if (_validate()) _endDialog(id);
    } else if (id == wxID_APPLY) {
      _validate();
    } else if (id == getEscapeId()) {
      _endDialog(id);
    } else {
      event.skip();
    }
  }

  bool _validate() {
    final event = WxDialogValidateEvent(id: getId());
    event.setEventObject(this);
    processEvent(event);
    return event.isAllowed();
  }

  void _endDialog(int retCode) {
    if (_isModal) {
      endModal(retCode);
    } else {
      _retCode = retCode;
      hide();
    }
  }

  // ------------------------- showing ----------------------

  void _sendInitDialog() {
    if (_hasSentInitEvent) return;
    _hasSentInitEvent = true;
    final event = WxInitDialogEvent(id: getId());
    event.setEventObject(this);
    processEvent(event);
  }

  /// Computes the client size, passes it to wxc.js and lays out the
  /// children with the sizer (if any).
  void _fit() {
    if (_asSheet) {
      _fitSheet();
      return;
    }
    int cw = -1, ch = -1;
    if (_size.x != -1) cw = _size.x;
    if (_size.y != -1) ch = _size.y - _kDialogTitleHeight;
    if ((cw == -1) || (ch == -1)) {
      // like wxDart Flutter: 500 pixels wide unless fitted to the sizer
      // with setSizerAndFit() (which sets the size)
      if (cw == -1) cw = _kDefaultDialogWidth;
      final sizer = _sizer;
      if (sizer != null) {
        if (ch == -1) {
          sizer.informFirstDirection(wxHORIZONTAL, cw, -1);
          final minSize = sizer.getMinSize();
          ch = minSize.y;
          if (minSize.x > cw) {
            wxLogDebug("WxDialog \"$_title\" is too narrow for its sizer: use setSizerAndFit() or give it a size");
          }
        }
      } else {
        if (ch == -1) ch = _kDefaultDialogHeight;
        wxLogDebug("WxDialog \"$_title\" has neither a size nor a sizer");
      }
    }
    if (_minSize.x != -1) cw = max(cw, _minSize.x);
    if (_minSize.y != -1) ch = max(ch, _minSize.y - _kDialogTitleHeight);
    _clientSize = WxSize(cw, ch);
    _jsSetRect(_handle, -1, -1, cw, ch);
    layout();
  }

  /// Like wxDart Flutter: a bottom sheet has the width of the screen (at
  /// most 440 pixels on wider screens) and the height of its content, or
  /// the height given to the dialog
  void _fitSheet() {
    final screen = _jsScreenSize();
    final total = screen.w > _kSheetFullWidthUpTo ? _kSheetMaxWidth : screen.w;
    final cw = max(1, total - _kSheetPaddingX);
    int ch;
    final sizer = _sizer;
    if (_size.y != -1) {
      ch = _size.y - _kDialogTitleHeight;
    } else if (sizer != null) {
      sizer.informFirstDirection(wxHORIZONTAL, cw, -1);
      ch = sizer.getMinSize().y;
    } else {
      ch = _kDefaultDialogHeight;
    }
    if (_minSize.y != -1) ch = max(ch, _minSize.y - _kDialogTitleHeight);
    // never higher than the screen
    ch = min(ch, screen.h - _kDialogTitleHeight - _kSheetPaddingY - _kSheetTopGap);
    _clientSize = WxSize(cw, max(1, ch));
    _jsSetRect(_handle, -1, -1, cw, _clientSize.y);
    layout();
  }

  void _markDefaultButton() {
    final def = findWindow(_defaultId ?? getAffirmativeId());
    if (def is WxButton) def.setDefault();
  }

  /// Shows the dialog modally. [onReturn] gets called with the return
  /// code after the dialog has been ended. Afterwards, the dialog is
  /// destroyed.
  void showModal(void Function(int, dynamic)? onReturn) {
    _onReturn = onReturn;
    _isModal = true;
    // on touch devices, as in wxDart Flutter, a bottom sheet
    _asSheet = wxTheApp.isTouch();
    _sendInitDialog();
    _fit();
    _markDefaultButton();
    _hidden = false;
    _jsShowModal(_handle, _asSheet, hasFlag(wxCAPTION));
    _scheduleIdle();
  }

  /// Shows the dialog without blocking the rest of the page
  @override
  void show({bool show = true}) {
    if (show) {
      _sendInitDialog();
      _fit();
      _markDefaultButton();
    }
    _hidden = !show;
    _jsShowModeless(_handle, show);
    _scheduleIdle();
  }

  /// Closes the modal dialog with the given [retCode]. The code that
  /// created and showed the dialog will be informed about this
  /// return code via the callback given to [showModal]
  void endModal(int retCode) {
    if (!_isModal) return;
    _retCode = retCode;
    _isModal = false;
    _hidden = true;
    _jsEndModal(_handle);
    final callback = _onReturn;
    _onReturn = null;
    if (callback != null) {
      callback(retCode, null);
    }
    destroy();
  }

  @override
  void _defaultClose() {
    // like wxWidgets: closing a dialog is the same as cancelling it
    final event = WxCommandEvent(wxGetButtonEventType(), getEscapeId() == wxID_ANY ? wxID_CANCEL : getEscapeId());
    event.setEventObject(this);
    processEvent(event);
    if (_isModal) {
      endModal(wxID_CANCEL);
    } else if (isShown()) {
      hide();
    }
  }

  @override
  WxSize getSize() {
    final c = getClientSize();
    return WxSize(c.x, c.y + _kDialogTitleHeight);
  }

  @override
  void setSize(WxSize size) {
    _size = size;
    if (isShown()) _fit();
  }

  @override
  WxSize clientToWindowSize(WxSize size) {
    return WxSize(size.x, size.y + _kDialogTitleHeight);
  }

  @override
  WxSize windowToClientSize(WxSize size) {
    return WxSize(size.x, size.y - _kDialogTitleHeight);
  }

  @override
  void setClientSize(WxSize size) {
    setSize(WxSize(size.x, size.y + _kDialogTitleHeight));
  }

  /// Handles Enter and Escape if no window handled the key
  bool _handleDefaultKey(int keyCode) {
    if ((keyCode == WXK_RETURN) || (keyCode == WXK_NUMPAD_ENTER)) {
      final button = findWindow(getAffirmativeId());
      if ((button is WxButton) && button.isShown() && button.isEnabled()) {
        button._sendClickEvent();
        return true;
      }
      return false;
    }
    if (keyCode == WXK_ESCAPE) {
      final button = findWindow(getEscapeId());
      if ((button is WxButton) && button.isShown() && button.isEnabled()) {
        button._sendClickEvent();
      } else {
        _doClose(canVeto: true);
      }
      return true;
    }
    return false;
  }
}
