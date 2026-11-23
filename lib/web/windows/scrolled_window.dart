// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-11-15
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxScrolledWindow ----------------------

/// A window that scrolls its content: either itself (default) or a
/// _target window_ set with [setTargetWindow].
///
/// The target window becomes a native scroll container in the browser, so
/// mouse wheel, touch pad, touch screen, scroll bars and keyboard scroll
/// natively and smoothly. The scroll bars are those of the target window.
/// The [WxScrolledWindow] owns the scroll state: scroll rate, virtual size,
/// [getViewStart], [scroll], [doPrepareDC] and it receives the
/// [WxScrollWinEvent]s, also when a target window is scrolled.
///
/// Child windows of the scrolled (target) window scroll with the content.
/// Painting is done in client coordinates; call [doPrepareDC] to draw in
/// content ("unscrolled") coordinates:
///
/// ```dart
/// class Canvas extends WxScrolledWindow {
///   Canvas(WxWindow parent) : super(parent, -1) {
///     setScrollbars(10, 10, 200, 100);   // virtual size 2000 x 1000
///     bindPaintEvent((_) {
///       final dc = WxPaintDC(this);
///       doPrepareDC(dc);
///       dc.drawText("at (1000, 500) in the virtual area", 1000, 500);
///     });
///   }
/// }
/// ```
///
/// A typical use of a target window is a table with fixed headers: the
/// [WxScrolledWindow] contains a column header, a row header and the data
/// window, which is the target. Only the data window scrolls; the headers
/// read [getViewStartPixels] in their paint handlers and are refreshed in
/// a [WxScrollWinEvent] handler:
///
/// ```dart
///   final data = DataWindow(this);
///   setTargetWindow(data);
///   setScrollbars(10, 10, 100, 500);
///   bindScrollWinEvent((event) {
///     columnHeader.refresh();
///     rowHeader.refresh();
///     event.skip();
///   });
/// ```
///
/// With a sizer, the sizer's minimal size becomes the virtual size and the
/// sizer is laid out in the virtual area (which is at least as large as the
/// visible area).
///
/// # Styles
/// | constant | meaning |
/// | -------- | -------- |
/// | wxHSCROLL | horizontal scrolling only if also given without wxVSCROLL |
/// | wxVSCROLL | vertical scrolling only if given without wxHSCROLL |
/// By default (neither or both) the window scrolls in both directions.
///
/// # Events emitted
/// [ScrollWin](/wxdart/wxGetScrollWinEventType.html) event gets sent when the view is scrolled
/// | ----------------- |
/// | void bindScrollWinEvent( OnScrollWinEventFunc ) |
/// | void unbindScrollWinEvent() |
class WxScrolledWindow extends WxWindow {
  /// Create window
  WxScrolledWindow(WxWindow parent, int id,
      {WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = wxTAB_TRAVERSAL})
      : super(parent, id, pos, size, style) {
    _scrollTarget = this;
    _attachTarget(this);
  }

  late WxWindow _scrollTarget;
  int _pixelsPerUnitX = 0;
  int _pixelsPerUnitY = 0;
  bool _enableX = true;
  bool _enableY = true;
  int _showX = wxSHOW_SB_DEFAULT;
  int _showY = wxSHOW_SB_DEFAULT;
  WxPoint _lastViewStart = WxPoint.zero;

  // ------------------------- directions ----------------------

  bool _canScrollX() {
    if (hasFlag(wxVSCROLL) && !hasFlag(wxHSCROLL)) return false;
    return _enableX && _showX != wxSHOW_SB_NEVER;
  }

  bool _canScrollY() {
    if (hasFlag(wxHSCROLL) && !hasFlag(wxVSCROLL)) return false;
    return _enableY && _showY != wxSHOW_SB_NEVER;
  }

  String _overflow(bool canScroll, int show) {
    if (!canScroll) return 'hidden';
    return show == wxSHOW_SB_ALWAYS ? 'scroll' : 'auto';
  }

  void _attachTarget(WxWindow target) {
    target._scrollOwner = this;
    _jsSetScrollTarget(target._handle, _handle, _overflow(_canScrollX(), _showX), _overflow(_canScrollY(), _showY));
    target._applyVirtualSize();
    _lastViewStart = WxPoint.zero;
  }

  void _updateOverflow() {
    _jsSetScrollTarget(
        _scrollTarget._handle, _handle, _overflow(_canScrollX(), _showX), _overflow(_canScrollY(), _showY));
    _scrollTarget._requestLayout();
  }

  // ------------------------- target window ----------------------

  /// Instructs to do scrolling on child window, not this window itself.
  void setTargetWindow(WxWindow target) {
    if (target == _scrollTarget) return;
    final old = _scrollTarget;
    if (!old._isDestroyed) {
      _jsSetScrollTarget(old._handle, 0, "", "");
    }
    old._scrollOwner = null;
    _scrollTarget = target;
    _attachTarget(target);
    target.refresh();
    if (old != target) old.refresh();
  }

  WxWindow getTargetWindow() {
    return _scrollTarget;
  }

  // ------------------------- scroll rate and virtual size ----------------------

  /// Sets up scroll area and scrollbars. The size of the scroll area will
  /// be the product of [noUnitsX] and [pixelsPerUnitX] horizontally and
  /// the equivalent for the Y-axis. [xPos] and [yPos] define the intial
  /// scroll positions in units, not pixels.
  void setScrollbars(int pixelsPerUnitX, int pixelsPerUnitY, int noUnitsX, int noUnitsY,
      {int xPos = 0, int yPos = 0, bool noRefresh = false}) {
    _pixelsPerUnitX = pixelsPerUnitX;
    _pixelsPerUnitY = pixelsPerUnitY;
    _scrollTarget.setVirtualSize(WxSize(pixelsPerUnitX * noUnitsX, pixelsPerUnitY * noUnitsY));
    if (xPos != 0 || yPos != 0) scroll(xPos, yPos);
    if (!noRefresh) _scrollTarget.refresh();
  }

  /// Sets the size of scroll units (pixels per scroll step)
  void setScrollRate(int pixelsPerUnitX, int pixelsPerUnitY) {
    _pixelsPerUnitX = pixelsPerUnitX;
    _pixelsPerUnitY = pixelsPerUnitY;
  }

  /// Returns number of pixels per horizontal scroll step
  int getScrollPixelsPerUnitX() {
    return _pixelsPerUnitX;
  }

  /// Returns number of pixels per vertical scroll step
  int getScrollPixelsPerUnitY() {
    return _pixelsPerUnitY;
  }

  /// Enables or disables scrolling in each direction
  void enableScrolling(bool xScrolling, bool yScrolling) {
    _enableX = xScrolling;
    _enableY = yScrolling;
    _updateOverflow();
  }

  /// wxSHOW_SB_DEFAULT (when needed), wxSHOW_SB_ALWAYS or wxSHOW_SB_NEVER
  void showScrollbars(int horz, int vert) {
    _showX = horz;
    _showY = vert;
    _updateOverflow();
  }

  /// Set size and set up scrollbars
  @override
  void setSizer(WxSizer? sizer, {bool deleteOld = true}) {
    super.setSizer(sizer, deleteOld: deleteOld);
    if (_pixelsPerUnitX == 0 && _pixelsPerUnitY == 0) {
      setScrollRate(10, 10);
    }
  }

  // ------------------------- position ----------------------

  int _toPixels(int units, int ppu) => ppu > 0 ? units * ppu : units;
  int _toUnits(int pixels, int ppu) => ppu > 0 ? pixels ~/ ppu : pixels;

  /// Scroll [x] and [y] number of units (not pixels)
  ///
  /// -1 indicates no change in the respective direction
  void scroll(int x, int y) {
    _jsScrollTo(_scrollTarget._handle, x < 0 ? -1 : _toPixels(x, _pixelsPerUnitX),
        y < 0 ? -1 : _toPixels(y, _pixelsPerUnitY));
  }

  /// Scrolls to [x], [y] in pixels (-1 leaves a direction unchanged)
  void scrollPixels(int x, int y) {
    _jsScrollTo(_scrollTarget._handle, x, y);
  }

  /// Returns the view start (how much has been scrolled) in units, not pixels
  ///
  /// see [getViewStartPixels], [getScrollPixelsPerUnitX], [getScrollPixelsPerUnitY]
  WxPoint getViewStart() {
    final p = getViewStartPixels();
    return WxPoint(_toUnits(p.x, _pixelsPerUnitX), _toUnits(p.y, _pixelsPerUnitY));
  }

  /// Returns the view start (how much has been scrolled) in pixels
  ///
  /// see [getViewStart]
  WxPoint getViewStartPixels() {
    final p = _jsScrollPos(_scrollTarget._handle);
    return WxPoint(p.x, p.y);
  }

  /// Transforms window coordinates to scrolled coordinates
  WxPoint calcScrolledPosition(WxPoint pt) {
    final start = getViewStartPixels();
    return WxPoint(pt.x - start.x, pt.y - start.y);
  }

  /// Transforms scrolled coordinates to window coordinates
  WxPoint calcUnscrolledPosition(WxPoint pt) {
    final start = getViewStartPixels();
    return WxPoint(pt.x + start.x, pt.y + start.y);
  }

  /// Returns origin of the client area
  WxPoint getClientOrigin() {
    return WxPoint.zero;
  }

  /// Adapts the [dc] to the amount scrolled
  void doPrepareDC(WxDC dc) {
    final start = getViewStartPixels();
    dc.setDeviceOrigin(-start.x, -start.y);
  }

  /// Returns device offset, identical to view start
  @override
  int getDeviceOffsetX() {
    return getViewStartPixels().x;
  }

  /// Returns device offset, identical to view start
  @override
  int getDeviceOffsetY() {
    return getViewStartPixels().y;
  }

  // ------------------------- events ----------------------

  /// Called by the dispatcher when the target window was scrolled
  void _onJsScroll(int x, int y) {
    final old = _lastViewStart;
    _lastViewStart = WxPoint(x, y);
    if (x != old.x) _sendScrollEvent(wxHORIZONTAL, x, _pixelsPerUnitX);
    if (y != old.y) _sendScrollEvent(wxVERTICAL, y, _pixelsPerUnitY);
  }

  void _sendScrollEvent(int orientation, int pixels, int ppu) {
    final event = WxScrollWinEvent(wxGetScrollWinThumbTrackEventType(),
        orientation: orientation, position: _toUnits(pixels, ppu));
    event.setPixelOffset(ppu > 0 ? pixels % ppu : 0);
    event.setEventObject(this);
    processEvent(event);
  }
}
