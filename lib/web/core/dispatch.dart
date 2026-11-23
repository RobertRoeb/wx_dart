// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-11-15
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ---------------------------------------------------------------------------
// All browser events arrive here from wxc.js and are translated into
// wxDart events which are then processed by the respective WxWindow.
// Returns true if the event was handled (JS then calls preventDefault()).
// ---------------------------------------------------------------------------

/// Entry point for all events from wxc.js. An exception in an event
/// handler is reported in the browser console with the event type and the
/// Dart stack trace (readable with `tool/build_example.sh --debug`).
JSBoolean _dispatchFromJs(JSObject raw) {
  try {
    return _dispatchFromJsUnguarded(raw);
  } catch (error, stack) {
    final e = raw as _JsEvent;
    _jsConsoleLog('error', 'wxDart Web: exception while handling "${e.type}" (window ${e.id}): $error\n$stack');
    _scheduleIdle();
    return false.toJS;
  }
}

JSBoolean _dispatchFromJsUnguarded(JSObject raw) {
  final e = raw as _JsEvent;
  bool handled = false;
  // a drag within the app gets mouse and key events first
  if (WxDropSource._current != null && _wxDropSourceFilter(e)) {
    _scheduleIdle();
    return true.toJS;
  }
  switch (e.type) {
    case 'dndenter':
    case 'dndover':
    case 'dndleave':
    case 'dnddrop':
      handled = _dispatchDnd(e);
      break;
    case 'paint':
      handled = _dispatchPaint(e);
      break;
    case 'size':
      handled = _dispatchSize(e);
      break;
    case 'mousedown':
    case 'mouseup':
    case 'dclick':
    case 'motion':
    case 'enter':
    case 'leave':
    case 'wheel':
      handled = _dispatchMouse(e);
      break;
    case 'keydown':
      handled = _dispatchKeyDown(e);
      break;
    case 'keyup':
      handled = _dispatchKeyUp(e);
      break;
    case 'button':
      handled = _dispatchButton(e);
      break;
    case 'menu':
      handled = _dispatchMenu(e.id);
      break;
    case 'menuopen':
      handled = _dispatchMenuOpen(e, true);
      break;
    case 'menuclose':
      handled = _dispatchMenuOpen(e, false);
      _dispatchMenuHelp(e, false);
      break;
    case 'menuhighlight':
      _dispatchMenuHelp(e, true);
      handled = true;
      break;
    case 'popupdismiss':
      final popup = _windowFromHandle(e.id);
      if (popup is WxPopupTransientWindow) popup._onJsDismiss();
      handled = true;
      break;
    case 'setfocus':
    case 'killfocus':
      handled = _dispatchFocus(e);
      break;
    case 'popupclose':
      _closePopupMenu();
      _dispatchMenuHelp(e, false);
      break;
    case 'scroll':
      _windowFromHandle(e.id)?._scrollOwner?._onJsScroll(e.x, e.y);
      break;
    case 'tool':
    case 'toolenter':
    case 'tooldropdown':
      handled = _dispatchTool(e);
      break;
    case 'close':
      handled = _dispatchClose(e);
      break;
    case 'infobaraction':
      final infoFrame = _windowFromHandle(e.id);
      if (infoFrame is WxFrame) infoFrame._onInfoBarAction();
      handled = true;
      break;
    case 'gesturepan':
    case 'gesturezoom':
      final gestureWin = _windowFromHandle(e.id);
      if (gestureWin != null) {
        final WxGestureEvent gesture;
        if (e.type == 'gesturepan') {
          final pan = WxPanGestureEvent(gestureWin.getId());
          pan.setDelta(WxPoint(e.dx, e.dy));
          gesture = pan;
        } else {
          final zoom = WxZoomGestureEvent(gestureWin.getId());
          zoom.setZoomFactor(e.zoom);
          gesture = zoom;
        }
        gesture.setEventObject(gestureWin);
        gesture.setPosition(WxPoint(e.x, e.y));
        gesture.setGestureStart(isStart: e.start);
        gesture.setGestureEnd(isEnd: e.end);
        final mask = gestureWin._touchEventMask;
        if (e.type == 'gesturepan' ? (mask & wxTOUCH_PAN_GESTURES != 0) : (mask & wxTOUCH_ZOOM_GESTURE != 0)) {
          handled = gestureWin.processEvent(gesture);
        }
      }
      break;
    case 'frameback':
      final back = _windowFromHandle(e.id);
      if (back is WxFrame) back._onBack();
      handled = true;
      break;
    case 'drawermenu':
      final drawerFrame = _windowFromHandle(e.id);
      handled = drawerFrame is WxAdaptiveFrame && drawerFrame._onDrawerMenu(e.x);
      break;
    case 'drawer':
      final drawerOwner = _windowFromHandle(e.id);
      if (drawerOwner is WxAdaptiveFrame) drawerOwner._onDrawer(e.x != 0);
      handled = true;
      break;
    case 'text':
    case 'checkbox':
    case 'choice':
    case 'slider':
    case 'hyperlink':
    case 'htmllink':
    case 'htmlloaded':
    case 'htmlerror':
    case 'listbox':
    case 'listboxdclick':
    case 'booksel':
    case 'bookexpand':
    case 'toggle':
    case 'radio':
    case 'radiobox':
    case 'spin':
    case 'search':
    case 'searchcancel':
    case 'combo':
    case 'collapsible':
      handled = _dispatchControl(e);
      break;
    case 'imageload':
      WxBitmap._onLoaded(e.id, e.w, e.h, true);
      break;
    case 'imageerror':
      WxBitmap._onLoaded(e.id, 0, 0, false);
      break;
    default:
      break;
  }
  // paint events do not change state; everything else might
  if (e.type != 'paint') _scheduleIdle();
  return handled.toJS;
}

WxWindow? _windowFromHandle(int handle) => _windowsByHandle[handle];

// ------------------------- focus ----------------------

bool _dispatchFocus(_JsEvent e) {
  final win = _windowFromHandle(e.id);
  if (win == null) return false;
  final event = WxFocusEvent(e.type == 'setfocus' ? wxGetSetFocusEventType() : wxGetKillFocusEventType(), win.getId());
  event.setEventObject(win);
  return win.processEvent(event);
}

// ------------------------- tool bar ----------------------

bool _dispatchTool(_JsEvent e) {
  final toolbar = _windowFromHandle(e.id);
  if (toolbar is! WxToolBar) return false;
  return toolbar._onJsTool(e.type, e.x, e.w, e.y);
}

// ------------------------- controls ----------------------

bool _dispatchControl(_JsEvent e) {
  final win = _windowFromHandle(e.id);
  if (win == null) return false;
  switch (e.type) {
    case 'text':
      if (win is WxTextEntry) win._onJsText(e.text);
      if (win is WxComboBox) win._onJsText(e.text);
      return false;
    case 'toggle':
      if (win is WxToggleButton) win._onJsToggle(e.x == 1);
      if (win is WxBitmapToggleButton) win._onJsToggle(e.x == 1);
      return true;
    case 'radio':
      if (win is WxRadioButton) win._onJsRadio();
      return true;
    case 'radiobox':
      if (win is WxRadioBox) win._onJsRadiobox(e.x);
      return true;
    case 'spin':
      if (win is WxSpinCtrl) win._onJsSpin(e.text, e.x == 1);
      if (win is WxSpinCtrlDouble) win._onJsSpin(e.text, e.x == 1);
      return false;
    case 'search':
      if (win is WxSearchCtrl) win._search();
      return true;
    case 'searchcancel':
      if (win is WxSearchCtrl) win._cancel();
      return true;
    case 'combo':
      if (win is WxComboBox) win._onJsCombo(e.x);
      return true;
    case 'collapsible':
      if (win is WxCollapsiblePane) win._onJsToggle();
      return true;
    case 'checkbox':
      if (win is WxCheckBox) win._onJsChange(e.x == 1);
      return false;
    case 'choice':
      if (win is WxChoice) win._onJsChoice(e.x);
      return false;
    case 'slider':
      if (win is WxSlider) win._onJsSlider(e.x);
      return false;
    case 'hyperlink':
      if (win is WxHyperlinkCtrl) win._onJsClick();
      return true;
    case 'htmllink':
      if (win is WxHtmlWindow) win._onJsLinkClicked(e.text, e.url);
      return true;
    case 'listbox':
      if (win is WxListBox) win._onJsListbox(e.x, e.y, e.text);
      return false;
    case 'listboxdclick':
      if (win is WxListBox) win._onJsDClick(e.x);
      return false;
    case 'booksel':
      if (win is WxBookCtrlBase) win._onJsSelect(e.x);
      return true;
    case 'bookexpand':
      if (win is WxTreebook) win._onJsExpand(e.x, e.y == 1);
      return true;
    case 'htmlloaded':
    case 'htmlerror':
      if (win is WxHtmlWindow) win._onJsLoaded(e.url, e.type == 'htmlloaded');
      return false;
    default:
      return false;
  }
}

// ------------------------- paint ----------------------

bool _dispatchPaint(_JsEvent e) {
  final win = _windowFromHandle(e.id);
  if (win == null) return false;
  win._paintCtx = _jsPaintContext(e.id);
  try {
    final event = WxPaintEvent(win);
    event.setEventObject(win);
    return win.processEvent(event);
  } finally {
    win._paintCtx = null;
  }
}

// ------------------------- size ----------------------

bool _dispatchSize(_JsEvent e) {
  final win = _windowFromHandle(e.id);
  if (win is! WxTopLevelWindow) return false;
  win._onClientResized(e.w, e.h);
  return true;
}

// ------------------------- mouse ----------------------

bool _dispatchMouse(_JsEvent e) {
  final win = _windowFromHandle(e.id);
  if (win == null) return false;
  int type;
  switch (e.type) {
    case 'mousedown':
      type = e.button == 2
          ? wxGetRightDownEventType()
          : (e.button == 1 ? wxGetMiddleDownEventType() : wxGetLeftDownEventType());
      break;
    case 'mouseup':
      type = e.button == 2
          ? wxGetRightUpEventType()
          : (e.button == 1 ? wxGetMiddleUpEventType() : wxGetLeftUpEventType());
      break;
    case 'dclick':
      type = e.button == 2
          ? wxGetRightDClickEventType()
          : (e.button == 1 ? wxGetMiddleDClickEventType() : wxGetLeftDClickEventType());
      break;
    case 'enter':
      type = wxGetEnterWindowEventType();
      break;
    case 'leave':
      type = wxGetLeaveWindowEventType();
      break;
    case 'wheel':
      type = wxGetMouseWheelEventType();
      break;
    default:
      type = wxGetMotionEventType();
  }
  final event = WxMouseEvent(type);
  event.setId(win.getId());
  event.setEventObject(win);
  event._x = e.x;
  event._y = e.y;
  event._leftIsDown = e.leftDown;
  event._middleIsDown = e.middleDown;
  event._rightIsDown = e.rightDown;
  event._controlDown = e.ctrl;
  event._shiftDown = e.shift;
  event._altDown = e.alt;
  event._metaDown = e.meta;
  event._wheelRotation = e.wheel;
  event._wheelAxis = wxMOUSE_WHEEL_VERTICAL;
  return win.processEvent(event);
}

// ------------------------- keyboard ----------------------

int _wxKeyCodeFromJs(String key, String code) {
  if (code == 'NumpadEnter') return WXK_NUMPAD_ENTER;
  switch (key) {
    case 'ArrowUp': return WXK_UP;
    case 'ArrowDown': return WXK_DOWN;
    case 'ArrowLeft': return WXK_LEFT;
    case 'ArrowRight': return WXK_RIGHT;
    case 'Enter': return WXK_RETURN;
    case 'Escape': return WXK_ESCAPE;
    case 'Backspace': return WXK_BACK;
    case 'Tab': return WXK_TAB;
    case 'Delete': return WXK_DELETE;
    case 'Insert': return WXK_INSERT;
    case 'Home': return WXK_HOME;
    case 'End': return WXK_END;
    case 'PageUp': return WXK_PAGEUP;
    case 'PageDown': return WXK_PAGEDOWN;
    case 'Shift': return WXK_SHIFT;
    case 'Control': return WXK_CONTROL;
    case 'Alt': return WXK_ALT;
    case 'Meta': return WXK_WINDOWS_LEFT;
    case ' ': return WXK_SPACE;
    default: break;
  }
  if (key.length > 1 && key.startsWith('F')) {
    final n = int.tryParse(key.substring(1));
    if (n != null && n >= 1 && n <= 24) return WXK_F1 + n - 1;
  }
  if (key.length == 1) {
    // like wxWidgets: letters are reported as upper case in key events
    return key.toUpperCase().codeUnitAt(0);
  }
  return WXK_NONE;
}

int _unicodeFromJs(String key) {
  if (key == 'Enter') return WXK_RETURN;
  if (key == 'Escape') return WXK_ESCAPE;
  if (key == 'Backspace') return WXK_BACK;
  if (key == 'Tab') return WXK_TAB;
  final runes = key.runes;
  if (runes.length == 1) return runes.first;
  return 0;
}

WxKeyEvent _makeKeyEvent(int type, _JsEvent e, WxWindow win, {bool forChar = false}) {
  final event = WxKeyEvent(type);
  event.setId(win.getId());
  event.setEventObject(win);
  event._unicode = _unicodeFromJs(e.key);
  event._keyCode = forChar && event._unicode != 0 && !e.ctrl && !e.alt
      ? event._unicode
      : _wxKeyCodeFromJs(e.key, e.code);
  event._controlDown = e.ctrl;
  event._shiftDown = e.shift;
  event._altDown = e.alt;
  event._metaDown = e.meta;
  return event;
}

WxTopLevelWindow? _getTopLevelParent(WxWindow win) {
  WxWindow? current = win;
  while (current != null) {
    if (current is WxTopLevelWindow) return current;
    current = current.getParent();
  }
  return null;
}

bool _dispatchKeyDown(_JsEvent e) {
  final win = _windowFromHandle(e.id);
  if (win == null) return false;
  final tlw = _getTopLevelParent(win);

  // 1. char hook, sent to the top level window first
  if (tlw != null) {
    final hook = _makeKeyEvent(wxGetCharHookEventType(), e, win);
    if (tlw.processEvent(hook)) return true;
  }

  // 2. key down
  final down = _makeKeyEvent(wxGetKeyDownEventType(), e, win);
  if (win.processEvent(down)) return true;

  // 3. char
  final keyCode = down.getKeyCode();
  final isModifier = (keyCode == WXK_SHIFT) || (keyCode == WXK_CONTROL) ||
      (keyCode == WXK_ALT) || (keyCode == WXK_WINDOWS_LEFT);
  if (!isModifier && keyCode != WXK_NONE) {
    final char = _makeKeyEvent(wxGetCharEventType(), e, win, forChar: true);
    if (win.processEvent(char)) return true;
  }

  // 4. default processing
  if ((win is WxTextCtrl) && win.hasFlag(wxTE_PROCESS_ENTER) && !win.isMultiLine() &&
      ((keyCode == WXK_RETURN) || (keyCode == WXK_NUMPAD_ENTER))) {
    if (win._sendTextEnter()) return true;
  }
  // e.g. Enter in focused buttons, links and multi-line text controls
  if (win._wantsNativeKey(keyCode)) {
    return false;
  }
  if (tlw is WxDialog) {
    return tlw._handleDefaultKey(keyCode);
  }
  if (tlw is WxFrame) {
    return tlw._handleAccelerator(keyCode, e.ctrl || e.meta, e.alt, e.shift);
  }
  return false;
}

bool _dispatchKeyUp(_JsEvent e) {
  final win = _windowFromHandle(e.id);
  if (win == null) return false;
  final up = _makeKeyEvent(wxGetKeyUpEventType(), e, win);
  return win.processEvent(up);
}

// ------------------------- button ----------------------

bool _dispatchButton(_JsEvent e) {
  final win = _windowFromHandle(e.id);
  if (win is! WxButton) return false;
  if (!win.isEnabled()) return false;
  win._sendClickEvent();
  return true;
}

// ------------------------- menus ----------------------

WxFrame? _findFrameWithMenuItem(int id) {
  for (final tlw in _topLevelWindows) {
    if (tlw is WxFrame) {
      final bar = tlw.getMenuBar();
      if (bar != null && bar.findItem(id) != null) return tlw;
    }
  }
  return null;
}

bool _dispatchMenu(int id) {
  final popup = _currentPopupMenu;
  if (popup != null) {
    final item = popup.findItem(id);
    if (item != null) return item._activate();
  }
  final frame = _findFrameWithMenuItem(id);
  if (frame == null) return false;
  final item = frame.getMenuBar()!.findItem(id)!;
  return item._activate();
}

bool _dispatchMenuOpen(_JsEvent e, bool open) {
  final win = _windowFromHandle(e.id);
  if (win is! WxFrame) return false;
  final bar = win.getMenuBar();
  if (bar == null) return false;
  if (open) {
    final menu = bar.getMenu(e.x);
    if (menu == null) return false;
    menu._updateUI(); // pushes changed states to wxc.js synchronously
    final event = WxMenuEvent(wxGetMenuOpenEventType(), -1, menu: menu);
    event.setEventObject(menu);
    menu.processEvent(event);
  } else {
    final event = WxMenuEvent(wxGetMenuCloseEventType(), -1);
    event.setEventObject(bar);
    bar.processEvent(event);
  }
  return true;
}

// ------------------------- close ----------------------

bool _dispatchClose(_JsEvent e) {
  final win = _windowFromHandle(e.id);
  if (win is! WxTopLevelWindow) return false;
  // returns true if vetoed
  return !win._doClose(canVeto: e.canVeto);
}

/// Menu help texts in the status bar of a frame
void _dispatchMenuHelp(_JsEvent e, bool highlight) {
  final frame = _windowFromHandle(e.id);
  if (frame is! WxFrame) return;
  if (highlight) {
    frame._onMenuHighlight(e.x);
  } else {
    frame._onMenuClosed();
  }
}
