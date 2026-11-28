// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-11-15
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../wx_dart.dart';

// ---------------------------------------------------------------------------
// The complete interface between wxDart Web and the browser.
//
// Everything that touches the DOM lives in runtime/wxc.js. The Dart side
// only calls the functions on `window.wxc` declared below and draws on
// CanvasRenderingContext2D objects handed out by wxc.paintContext().
//
// Only dart:js_interop is used (no package:web), which keeps the compiled
// output small and works with both dart2js and dart2wasm.
// ---------------------------------------------------------------------------

@JS('wxc')
external JSObject? get _wxcRuntime;

@JS('wxc.init')
external void _jsInit(JSFunction dispatcher);

@JS('wxc.createWindow')
external void _jsCreateWindow(int id, int parentId, String kind, int style);

@JS('wxc.destroyWindow')
external void _jsDestroyWindow(int id);

@JS('wxc.setRect')
external void _jsSetRect(int id, int x, int y, int width, int height);

@JS('wxc.measure')
external _JsSize _jsMeasure(int id, int width);

@JS('wxc.clientSize')
external _JsSize _jsClientSize(int id);

@JS('wxc.setLabel')
external void _jsSetLabel(int id, String text);

@JS('wxc.setTextAlign')
external void _jsSetTextAlign(int id, String align, bool wrap, bool selectable);

@JS('wxc.setHeading')
external void _jsSetHeading(int id, int level);

@JS('wxc.show')
external void _jsShow(int id, bool show);

@JS('wxc.enable')
external void _jsEnable(int id, bool enable);

@JS('wxc.setColours')
external void _jsSetColours(int id, String fg, String bg);

@JS('wxc.setFont')
external void _jsSetFont(int id, String cssFont);

@JS('wxc.setToolTip')
external void _jsSetToolTip(int id, String text);

@JS('wxc.setFocus')
external void _jsSetFocus(int id);

@JS('wxc.hasFocus')
external bool _jsHasFocus(int id);

@JS('wxc.setDefaultButton')
external void _jsSetDefaultButton(int id);

@JS('wxc.captureMouse')
external void _jsCaptureMouse(int id);

@JS('wxc.releaseMouse')
external void _jsReleaseMouse(int id);

@JS('wxc.showModal')
external void _jsShowModal(int id, bool sheet, bool caption);

@JS('wxc.endModal')
external void _jsEndModal(int id);

@JS('wxc.showModeless')
external void _jsShowModeless(int id, bool show);

@JS('wxc.enablePaint')
external void _jsEnablePaint(int id);

@JS('wxc.refresh')
external void _jsRefresh(int id);

@JS('wxc.paintContext')
external _Ctx2D? _jsPaintContext(int id);

@JS('wxc.loadImage')
external void _jsLoadImage(int handle, String url);

@JS('wxc.getImage')
external JSObject? _jsGetImage(int handle);

@JS('wxc.freeImage')
external void _jsFreeImage(int handle);

@JS('wxc.measureText')
external _JsTextMetrics _jsMeasureText(String cssFont, String text);

@JS('wxc.setMenuBar')
external void _jsSetMenuBar(int frameId, String json);

@JS('wxc.updateMenuItem')
external void _jsUpdateMenuItem(int id, bool enabled, bool checked, String text);

@JS('wxc.closeMenus')
external void _jsCloseMenus();

@JS('wxc.isDark')
external bool _jsIsDark();

@JS('wxc.setAccent')
external void _jsSetAccent(String css, String onAccent);

@JS('wxc.dpr')
external double _jsDevicePixelRatio();

// ------------------------- event object from wxc.js ----------------------

extension type _JsEvent._(JSObject _) implements JSObject {
  external String get type;
  external int get id;
  external int get x;
  external int get y;
  external int get button;
  external int get wheel;
  external int get w;
  external int get h;
  external String get key;
  external String get code;
  external String get text;
  external String get url;
  external bool get ctrl;
  external bool get shift;
  external bool get alt;
  external bool get meta;
  external bool get leftDown;
  external bool get middleDown;
  external bool get rightDown;
  external bool get canVeto;
  external int get dx;
  external int get dy;
  external double get zoom;
  external bool get start;
  external bool get end;
  external JSArray<_JsFile>? get files;
}

/// A file dropped from outside the app (HTML5 drag and drop)
extension type _JsFile._(JSObject _) implements JSObject {
  external String get name;
  external String get type;
  external JSUint8Array get data;
  /// blob URL for images, otherwise empty
  external String get url;
}

/// Result of wxc.windowAt
extension type _JsHit._(JSObject _) implements JSObject {
  external int get id;
  external int get x;
  external int get y;
}

extension type _JsSize._(JSObject _) implements JSObject {
  external int get w;
  external int get h;
}

extension type _JsTextMetrics._(JSObject _) implements JSObject {
  external double get w;
  external double get ascent;
  external double get descent;
}

// ------------------------- CanvasRenderingContext2D ----------------------

extension type _CanvasGradient._(JSObject _) implements JSObject {
  external void addColorStop(double offset, String colour);
}

extension type _Ctx2D._(JSObject _) implements JSObject {
  external set fillStyle(String value);
  @JS('fillStyle')
  external set fillStyleGradient(_CanvasGradient value);
  external set strokeStyle(String value);
  external set lineWidth(double value);
  external set lineCap(String value);
  external set lineJoin(String value);
  external set font(String value);
  external set textBaseline(String value);
  external set textAlign(String value);

  external void save();
  external void restore();
  external void setTransform(double a, double b, double c, double d, double e, double f);
  external void translate(double x, double y);
  external void rotate(double angle);
  external void setLineDash(JSArray<JSNumber> segments);

  external void beginPath();
  external void closePath();
  external void moveTo(double x, double y);
  external void lineTo(double x, double y);
  external void quadraticCurveTo(double cpx, double cpy, double x, double y);
  external void rect(double x, double y, double w, double h);
  external void roundRect(double x, double y, double w, double h, double radius);
  external void arc(double x, double y, double radius, double start, double end);
  @JS('arc')
  external void arcDir(double x, double y, double radius, double start, double end, bool counterClockwise);
  external void ellipse(double x, double y, double rx, double ry, double rotation, double start, double end);
  @JS('ellipse')
  external void ellipseDir(double x, double y, double rx, double ry, double rotation, double start, double end, bool counterClockwise);
  external void fill([String fillRule]);
  external void stroke();
  external void clip();

  external void fillRect(double x, double y, double w, double h);
  external void strokeRect(double x, double y, double w, double h);
  external void clearRect(double x, double y, double w, double h);
  external void fillText(String text, double x, double y);

  external void drawImage(JSObject image, double x, double y);
  @JS('drawImage')
  external void drawImageScaled(JSObject image, double x, double y, double w, double h);

  external _CanvasGradient createLinearGradient(double x0, double y0, double x1, double y1);
  external _CanvasGradient createRadialGradient(double x0, double y0, double r0, double x1, double y1, double r1);

  // used by WxGraphicsContext
  @JS('strokeStyle')
  external set strokeStyleGradient(_CanvasGradient value);
  external set globalCompositeOperation(String value);
  external _DOMMatrix getTransform();
  @JS('fill')
  external void fillPath2D(_Path2D path, String fillRule);
  @JS('stroke')
  external void strokePath2D(_Path2D path);
  @JS('clip')
  external void clipPath2D(_Path2D path);
}

/// DOMMatrix (only the 2D part)
extension type _DOMMatrix._(JSObject _) implements JSObject {
  external double get a;
  external double get b;
  external double get c;
  external double get d;
  external double get e;
  external double get f;
}

/// Path2D, the path object of the HTML canvas
@JS('Path2D')
extension type _Path2D._(JSObject _) implements JSObject {
  external _Path2D();
  external void addPath(_Path2D path);
  external void moveTo(double x, double y);
  external void lineTo(double x, double y);
  external void bezierCurveTo(double cp1x, double cp1y, double cp2x, double cp2y, double x, double y);
  external void quadraticCurveTo(double cpx, double cpy, double x, double y);
  external void arc(double x, double y, double radius, double start, double end, bool counterClockwise);
  external void ellipse(double x, double y, double rx, double ry, double rotation, double start, double end);
  external void rect(double x, double y, double w, double h);
  external void closePath();
}

@JS('wxc.setDark')
external void _jsSetDark(bool dark);

// ------------------------- controls ----------------------

@JS('wxc.textGet')
external String _jsTextGet(int id);

@JS('wxc.textSet')
external void _jsTextSet(int id, String value);

@JS('wxc.textReplace')
external void _jsTextReplace(int id, int from, int to, String text);

@JS('wxc.textSelection')
external _JsRange _jsTextSelection(int id);

@JS('wxc.textSetSelection')
external void _jsTextSetSelection(int id, int from, int to);

@JS('wxc.textCommand')
external void _jsTextCommand(int id, String command);

@JS('wxc.textSetOptions')
external void _jsTextSetOptions(int id, bool editable, int maxLength, String hint, String align, bool wrap);

@JS('wxc.checkSet')
external void _jsCheckSet(int id, int state);

@JS('wxc.choiceSetItems')
external void _jsChoiceSetItems(int id, String json, int selection);

@JS('wxc.choiceSelect')
external void _jsChoiceSelect(int id, int index);

@JS('wxc.linkSet')
external void _jsLinkSet(int id, String url, String normal, String hover, String visited, bool isVisited);

@JS('wxc.openUrl')
external void _jsOpenUrl(String url);

@JS('wxc.htmlSet')
external void _jsHtmlSet(int id, String html, bool append);

@JS('wxc.htmlLoad')
external void _jsHtmlLoad(int id, String url);

@JS('wxc.htmlScrollTo')
external void _jsHtmlScrollTo(int id, String anchor);

@JS('wxc.sliderSet')
external void _jsSliderSet(int id, int value, int min, int max, int flags);

@JS('wxc.gaugeSet')
external void _jsGaugeSet(int id, int value, int range, bool vertical, bool pulse);

@JS('wxc.imageFromRGBA')
external void _jsImageFromRGBA(int handle, int width, int height, JSUint8Array data);

@JS('wxc.scaleImage')
external void _jsScaleImage(int handle, int src, int width, int height);

@JS('wxc.imageToRGBA')
external JSUint8Array _jsImageToRGBA(int handle, int width, int height);

extension type _JsRange._(JSObject _) implements JSObject {
  external int get from;
  external int get to;
}

// ------------------------- scrolling, tool bar, popup menus ----------------------

@JS('wxc.setScrollTarget')
external void _jsSetScrollTarget(int id, int ownerId, String hmode, String vmode);

@JS('wxc.setVirtualSize')
external void _jsSetVirtualSize(int id, int width, int height);

@JS('wxc.scrollTo')
external void _jsScrollTo(int id, int x, int y);

@JS('wxc.setPaintFixed')
external void _jsSetPaintFixed(int id, bool fixed);

@JS('wxc.scrollPos')
external _JsPoint _jsScrollPos(int id);

@JS('wxc.toolbarSet')
external void _jsToolbarSet(int id, String json);

@JS('wxc.attachToolBar')
external void _jsAttachToolBar(int frameId, int toolbarId);

// ---------------- mobile: frames, app bar, drawer

@JS('wxc.frameChrome')
external void _jsFrameChrome(int frameId, bool back, bool menu, String title);

@JS('wxc.frameHistory')
external void _jsFrameHistory(int frameId, bool on);

@JS('wxc.appBarSet')
external void _jsAppBarSet(int appbarId, String title, int flags);

@JS('wxc.attachAppBar')
external void _jsAttachAppBar(int frameId, int appbarId);

@JS('wxc.appBarAttach')
external void _jsAppBarAttach(int appbarId, int scrollId);

@JS('wxc.frameMenuBar')
external void _jsFrameMenuBar(int frameId, bool visible);

@JS('wxc.fabSet')
external void _jsFabSet(int frameId, int buttonId, bool visible);

@JS('wxc.drawerSet')
external void _jsDrawerSet(int frameId, String json, int windowId);

@JS('wxc.drawerSlotSize')
external _JsSize _jsDrawerSlotSize(int frameId);

@JS('wxc.drawerOpen')
external void _jsDrawerOpen(int frameId, bool open);

@JS('wxc.drawerIsOpen')
external bool _jsDrawerIsOpen(int frameId);

@JS('wxc.infoBar')
external void _jsInfoBar(int frameId, String message, int duration, int style, String action);

@JS('wxc.isTouch')
external bool _jsIsTouch();

@JS('wxc.fontScale')
external double _jsFontScale();

/// Current modifier keys: 1 control, 2 shift, 4 alt, 8 meta
@JS('wxc.modifiers')
external int _jsModifiers();

@JS('wxc.popupMenu')
external void _jsPopupMenu(int ownerId, String json, int x, int y);

extension type _JsPoint._(JSObject _) implements JSObject {
  external int get x;
  external int get y;
}

// ------------------------- material icons, list box ----------------------

@JS('wxc.iconFromPaths')
external void _jsIconFromPaths(int handle, String paths, int width, int height, String colour);

@JS('wxc.listboxSet')
external void _jsListboxSet(int id, String itemsJson, String selectedJson, int current, int mode);

@JS('wxc.listboxSelect')
external void _jsListboxSelect(int id, String selectedJson, int current);

@JS('wxc.listboxScroll')
external void _jsListboxScroll(int id, int index, bool toTop);

@JS('wxc.listboxTopItem')
external int _jsListboxTopItem(int id);

@JS('wxc.listboxPerPage')
external int _jsListboxPerPage(int id);

// ------------------------- generic controls ----------------------

@JS('wxc.setCursor')
external void _jsSetCursor(int id, String css);

@JS('wxc.setCanFocus')
external void _jsSetCanFocus(int id, bool canFocus);

@JS('wxc.screenSize')
external _JsSize _jsScreenSize();

// ------------------------- status bar ----------------------

@JS('wxc.statusBarSet')
external void _jsStatusBarSet(int frameId, String json);

// ------------------------- more controls ----------------------

extension type _JsChrome._(JSObject _) implements JSObject {
  external int get l;
  external int get t;
  external int get r;
  external int get b;
}

@JS('wxc.buttonSetBitmap')
external void _jsButtonSetBitmap(int id, int bitmap, int width, int height, int direction, bool noText);

@JS('wxc.toggleSet')
external void _jsToggleSet(int id, bool on);

@JS('wxc.staticBitmapSet')
external void _jsStaticBitmapSet(int id, int bitmap, int width, int height, int mode);

@JS('wxc.staticBoxChrome')
external _JsChrome _jsStaticBoxChrome(int id);

@JS('wxc.radioSetGroup')
external void _jsRadioSetGroup(int id, int group);

@JS('wxc.radioboxSet')
external void _jsRadioboxSet(int id, String json);

@JS('wxc.radioboxSelect')
external void _jsRadioboxSelect(int id, int selection);

@JS('wxc.spinSet')
external void _jsSpinSet(int id, double min, double max, double step, String value);

@JS('wxc.searchSet')
external void _jsSearchSet(int id, bool showSearch, bool showCancel, String descriptive);

@JS('wxc.comboSetItems')
external void _jsComboSetItems(int id, String json, int selection, bool readonly);

@JS('wxc.comboSelect')
external void _jsComboSelect(int id, int selection);

@JS('wxc.comboOpen')
external void _jsComboOpen(int id);

@JS('wxc.comboClose')
external void _jsComboClose(int id);

@JS('wxc.collapsibleSet')
external void _jsCollapsibleSet(int id, bool expanded);

@JS('wxc.collapsibleHeader')
external _JsSize _jsCollapsibleHeader(int id);

// ------------------------- activity indicator, animation ----------------------

@JS('wxc.activitySet')
external void _jsActivitySet(int id, bool running);

@JS('wxc.animLoad')
external JSPromise<_JsSize> _jsAnimLoad(int handle, String url);

@JS('wxc.animFrameCount')
external int _jsAnimFrameCount(int handle);

@JS('wxc.animDelay')
external int _jsAnimDelay(int handle, int frame);

@JS('wxc.animFrame')
external JSUint8Array? _jsAnimFrame(int handle, int frame);

@JS('wxc.animFree')
external void _jsAnimFree(int handle);

@JS('wxc.animCtrlSet')
external void _jsAnimCtrlSet(int id, int handle);

@JS('wxc.animPlay')
external void _jsAnimPlay(int id, bool play);

@JS('wxc.animSetInactive')
external void _jsAnimSetInactive(int id, int bitmapHandle);

// ------------------------- notebook, treebook ----------------------

@JS('wxc.bookSet')
external void _jsBookSet(int id, String json, int selection);

@JS('wxc.bookSelect')
external void _jsBookSelect(int id, int selection);

@JS('wxc.bookExpand')
external void _jsBookExpand(int id, int index, bool expand);

@JS('wxc.bookChrome')
external _JsSize _jsBookChrome(int id);

@JS('wxc.fetchText')
external JSPromise<JSString> _jsFetchText(String url);

// ------------------------- drag and drop ----------------------

@JS('wxc.setDropTarget')
external void _jsSetDropTarget(int id, bool enable);

@JS('wxc.touchEvents')
external void _jsTouchEvents(int id, int mask);

@JS('wxc.dragFeedback')
external void _jsDragFeedback(String kind);

@JS('wxc.mousePosition')
external _JsPoint _jsMousePosition();

@JS('wxc.windowAt')
external _JsHit _jsWindowAt(int x, int y);

@JS('wxc.clientOrigin')
external _JsPoint _jsClientOrigin(int id);

@JS('wxc.blobUrl')
external String _jsBlobUrl(JSUint8Array data, String mime);

@JS('wxc.pickFiles')
external JSPromise<JSArray<_JsPickedFile>?> _jsPickFiles(String accept, bool multiple, bool directory);

@JS('wxc.readFile')
external JSPromise<JSUint8Array> _jsReadFile(JSObject file);

@JS('wxc.downloadFile')
external void _jsDownloadFile(String name, JSUint8Array data, String mime);

@JS('wxc.exportDocument')
external JSPromise<JSNumber> _jsExportDocument(String name, JSUint8Array data, String mime,
    String message, int mode, bool open);

/// A file chosen in the browser's file chooser (see wxc.pickFiles)
extension type _JsPickedFile._(JSObject _) implements JSObject {
  external String get name;
  external String get path;
  external double get size;
  external String get type;
  external JSObject get file;
}

@JS('wxc.revokeUrl')
external void _jsRevokeUrl(String url);

@JS('wxc.bitmapToPng')
external JSUint8Array? _jsBitmapToPng(int handle);
