// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-11-15
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

/// Style of [WxFrame.showInfoBar]: at the bottom of the frame
const int wxINFOBAR_BOTTOM = 0;
/// Style of [WxFrame.showInfoBar]: at the top of the frame
const int wxINFOBAR_TOP = 1;
/// Style of [WxFrame.showInfoBar]: a floating card at the bottom
const int wxINFOBAR_FLOATING = 2;

// ------------------------- wxFrame ----------------------

/// The first frame created; becomes the main window of the app
WxFrame? theTLW;

const int wxDEFAULT_FRAME_STYLE = (wxSYSTEM_MENU | wxRESIZE_BORDER | wxMINIMIZE_BOX |
    wxMAXIMIZE_BOX | wxCLOSE_BOX | wxCAPTION | wxCLIP_CHILDREN);

/// A frame is the main window of an app. In wxDart Web, a frame
/// always fills the entire browser window. Its title becomes the title
/// of the browser tab and its [WxMenuBar] is rendered with HTML and CSS
/// at the top of the page.
///
/// If the frame has a sizer, it arranges the children. Otherwise, if the
/// frame has a single child window, that child fills the client area (as
/// in wxWidgets), else children are placed where their constructor or
/// [WxWindow.setPosition] put them.
///
/// Closing the browser tab sends a vetoable [WxCloseEvent] to the main
/// frame; vetoing it makes the browser ask the user for confirmation.
class WxFrame extends WxTopLevelWindow {
  WxFrame(WxWindow? parent, int id, String title,
      {WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = wxDEFAULT_FRAME_STYLE})
      : super(parent, id, title, pos: pos, size: size, style: style) {
    theTLW ??= this;
  }

  WxMenuBar? _menubar;
  WxToolBar? _toolBar;
  WxStatusBar? _statusBar;

  /// Creates and returns the frame's statusbar at the bottom of the frame.
  /// [number] indicates the number of field in it.
  ///
  /// see [setStatusText]
  WxStatusBar createStatusBar( { int number = 1 } )
  {
    if (_statusBar != null) {
      wxLogError( "Frame already has a status bar" );
      return _statusBar!;  
    }
    _statusBar = WxStatusBar( this );
    _statusBar!.setFieldsCount( count: number );
    return _statusBar!;
  }

  /// Returns the current status bar, if any has been created, or null
  WxStatusBar? getStatusBar() {
    return _statusBar;
  }

  /// Sets the text if the status bar. [number] indicates the field if
  /// more than one field has been created with [createStatusBar].
  void setStatusText( String text, { int number = 0 } ) {
    _statusBar?.setStatusText( text, index: number );
  }

  /// Saves the current text of the status bar field [number] and shows
  /// [text]. See [WxStatusBar.pushStatusText]
  void pushStatusText( String text, { int number = 0 } ) {
    _statusBar?.pushStatusText( text, index: number );
  }

  /// Restores the text saved by [pushStatusText].
  /// See [WxStatusBar.popStatusText]
  void popStatusText( { int number = 0 } ) {
    _statusBar?.popStatusText( index: number );
  }

  /// Sets the widths of the status bar fields.
  /// See [WxStatusBar.setStatusWidths].
  void setStatusWidths( List<int> widths ) {
    _statusBar?.setStatusWidths( widths );
  }

  /// Shows the help text of the menu item [id] in the status bar
  void _onMenuHighlight( int id ) {
    final event = WxMenuEvent( wxGetMenuHighlightEventType(), id );
    event.setEventObject( this );
    processEvent( event );
    final bar = _statusBar;
    if (bar == null) return;
    final item = findItemInMenuBar( id );
    bar._setHelpText( item?.getHelp() ?? "" );
  }

  void _onMenuClosed() {
    _statusBar?._setHelpText( "" );
  }

  @override
  String get _jsKind => 'frame';

  /// Shows a short information message, usually at the bottom of the frame.
  /// 
  /// When no actionId is given, the message will be shown in the status bar of the
  /// frame on wxDart Native. In wxDart Flutter, a small window will appear and will
  /// disappear again after [duration] in milliseconds.
  /// 
  /// If the actionId is give (and not -1), a small window will appear that will 
  /// contain the action button and a small close button. In this case, the info
  /// bar will not disappear by itself. Showing an info bar with an action button
  /// requires the frame to have a vertical sizer [WxColumn]/[WxBoxSizer] into
  /// which the info gets inserted.
  /// 
  /// The action button emits a button event when pressed.
  /// 
  /// wxDart Flutter suppports the [style] flags wxINFOBAR_BOTTOM and wxINFOBAR_FLOATING.
  /// wxDart Native suppports the [style] flag wxINFOBAR_TOP or wxINFOBAR_BOTTOM.
  
  ///
  /// In wxDart Web, the info bar appears at the bottom of the frame (above
  /// the bar of a [WxNavigationCtrl]), at the top (wxINFOBAR_TOP) or as a
  /// floating card (wxINFOBAR_FLOATING). Without an action, it disappears
  /// after [duration] milliseconds; with an action, it has the action
  /// button and a close button and stays until one of them is pressed. No
  /// sizer is needed. A new info bar replaces the previous one.
  void showInfoBar( String message, { int duration = 500, int style = wxINFOBAR_BOTTOM, int actionId = -1, String action = "" } )
  {
    _infoBarActionId = actionId;
    _jsInfoBar( _handle, message, duration, style, actionId == -1 ? "" : (action.isEmpty ? "OK" : action) );
  }

  int _infoBarActionId = -1;

  void _onInfoBarAction() {
    final event = WxCommandEvent( wxGetButtonEventType(), _infoBarActionId );
    event.setEventObject( this );
    processEvent( event );
  }

  // ------------------------- secondary frames ----------------------

  /// True for all frames except the main frame (the first one)
  bool get _isSecondary => theTLW != this;

  /// Shows window, or hides it if [show] is false.
  ///
  /// In wxDart Web (as in wxDart Flutter), every frame fills the browser
  /// window. A secondary frame (every frame but the first one) is shown
  /// on top of the others with a back arrow at the start of its app bar,
  /// tool bar or a header with its title, like a page of a smartphone app.
  /// The arrow, the back button of the browser and the back gesture of a
  /// phone close the frame (with a [WxCloseEvent] that can be vetoed).
  @override
  void show({bool show = true}) {
    super.show(show: show);
    _updateChrome();
    if (_isSecondary) _jsFrameHistory(_handle, show);
  }

  @override
  void setTitle(String title) {
    super.setTitle(title);
    _updateChrome();
  }

  /// Updates back arrow and drawer button
  void _updateChrome() {
    _jsFrameChrome(_handle, _isSecondary && isShown(), false, getTitle());
  }

  /// The user pressed the back arrow or the back button of the browser
  void _onBack() {
    close();
    // vetoed: the frame stays, so does its history entry
    if (!_isDestroyed && isShown()) _jsFrameHistory(_handle, true);
  }

  /// Sets the menu bar of the frame
  void setMenuBar(WxMenuBar menubar) {
    if (_menubar != null && _menubar != menubar) {
      _menubar!.detach();
    }
    _menubar = menubar;
    menubar.attach(this);
    menubar._realize();
  }

  /// Returns the current menu bar, if any has been created, or null
  WxMenuBar? getMenuBar() {
    return _menubar;
  }

  WxMenuItem? findItemInMenuBar(int id) {
    return _menubar?.findItem(id);
  }

  /// Creates and returns the frame's main toolbar
  WxToolBar createToolBar({int style = wxTB_DEFAULT_STYLE, int id = -1}) {
    final toolbar = WxToolBar(this, id, style: style & ~wxTB_VERTICAL);
    setToolBar(toolbar);
    return toolbar;
  }

  /// Makes [toolbar] (a child of this frame) the frame's tool bar
  void setToolBar(WxToolBar? toolbar) {
    _toolBar = toolbar;
    if (toolbar != null) {
      _jsAttachToolBar(_handle, toolbar._handle);
    }
    _layoutChildren();
  }

  WxToolBar? getToolBar() {
    return _toolBar;
  }

  @override
  void onInternalIdle() {
    final bar = _menubar;
    if (bar != null) {
      if (bar._dirty) bar._realize();
      bar.onInternalIdle();
    }
  }

  /// Children that are part of the frame (tool bar etc.), not laid out
  /// like the other children
  bool _isFrameChrome(WxWindow child) {
    return child == _toolBar;
  }

  @override
  void _layoutChildren() {
    if (_sizer != null) {
      layout();
      return;
    }
    final visible =
        _children.where((c) => c is! WxNonOwnedWindow && !_isFrameChrome(c) && c.isShown()).toList();
    if (visible.length == 1) {
      final size = getClientSize();
      visible.first._setActualRect(0, 0, size.x, size.y);
    }
  }

  bool _handleAccelerator(int keyCode, bool ctrl, bool alt, bool shift) {
    final bar = _menubar;
    if (bar == null) return false;
    final item = bar._findAccelerator(keyCode, ctrl, alt, shift);
    if (item == null) return false;
    // update enabled state first, like a real menu would
    item.getMenu()?._updateUI();
    if (!item.isEnabled()) return false;
    item._activate();
    return true;
  }
}
