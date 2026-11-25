// -------------------------------------------------------------
// Purpose:     PDF output for wxDart - WxPDFGraphicsContext
// Author:      Robert Roebling
// Created:     25/11/2026
// Copyright:   (c) Robert Roebling
// Licence:     wxWindows licence 3.1
// -------------------------------------------------------------
//
// A WxGraphicsContext that writes PDF, written entirely in Dart.
//
// Design:
//  * Inherits only the interface of WxGraphicsContext. It is constructed
//    with _defaultConstructor(), so no native object is ever created, and
//    it overrides every method. nativeHandle is never used.
//    CAUTION: if the code generator adds a method to WxGraphicsContext,
//    it must be added here too, otherwise the inherited version would
//    call C++ with an invalid handle.
//  * User units are PDF points (1/72 inch), origin top left, y down - as
//    on screen. Use scale() for other units.
//  * Pages are written to the WxPDFOutput as soon as they are finished, so
//    memory use does not grow with the number of pages.
//  * Pen, brush and font are kept in Dart and written lazily right before
//    a drawing operation, only when they changed.
//
// Not yet implemented (TODO):
//  * gradient pens and brushes (PDF shading patterns) - fall back to a colour
//  * composition modes other than wxCOMPOSITION_OVER
//  * resetClip() only removes clips set after the last pushState()
//  * font embedding (TrueType subsets) and text outside WinAnsiEncoding

part of '../../wx_dart.dart';

class _WxPDFGradient {
  _WxPDFGradient.linear(this.x1, this.y1, this.x2, this.y2, this.colour1, this.colour2)
      : radial = false,
        radius = 0;
  _WxPDFGradient.radial(this.x1, this.y1, this.x2, this.y2, this.radius, this.colour1, this.colour2)
      : radial = true;
  final bool radial;
  final double x1, y1, x2, y2, radius;
  final WxColour colour1, colour2;
}

class _WxPDFState {
  _WxPDFState();

  // pen
  bool penVisible = false;
  WxColour penColour = WxColour(0, 0, 0);
  double penWidth = 1.0;
  int penStyle = wxPENSTYLE_SOLID;
  int penCap = wxCAP_ROUND;
  int penJoin = wxJOIN_MITER;
  _WxPDFGradient? penGradient;

  // brush
  bool brushVisible = false;
  WxColour brushColour = WxColour(255, 255, 255);

  // text
  WxPDFFont font = WxPDFFont('Helvetica', 10);
  WxColour textColour = WxColour(0, 0, 0);

  // transformation relative to the page's base system (top left, y down)
  _WxPDFMatrix matrix = _WxPDFMatrix.identity;

  // number of entries in _pdfClipMatrices when this state was pushed
  int clipCount = 0;

  _WxPDFState copy() => _WxPDFState()
    ..penVisible = penVisible
    ..penColour = penColour
    ..penWidth = penWidth
    ..penStyle = penStyle
    ..penCap = penCap
    ..penJoin = penJoin
    ..penGradient = penGradient
    ..brushVisible = brushVisible
    ..brushColour = brushColour
    ..font = font
    ..textColour = textColour
    ..matrix = matrix
    ..clipCount = clipCount;
}

class WxPDFGraphicsContext extends WxGraphicsContext {
  /// [deflate] compresses the streams of the PDF (page contents, images,
  /// fonts). Without it the PDF is valid but larger, often several times.
  ///
  /// wxDart Native and wxDart Flutter (not on the web) can use zlib from
  /// dart:io (wxDart Native also offers `wxPDFDeflate` for this):
  ///
  /// ```dart
  /// import 'dart:io';
  ///
  /// final gc = WxPDFGraphicsContext( out, deflate: (data) => zlib.encode(data) );
  /// ```
  ///
  /// dart:io does not exist in the browser. In wxDart Web (and in all
  /// ports alike) the pure Dart package
  /// [archive](https://pub.dev/packages/archive) can compress. Only the
  /// encoder that is used ends up in the compiled app:
  ///
  /// ```dart
  /// import 'package:archive/archive.dart';
  ///
  /// final gc = WxPDFGraphicsContext( out, deflate: (data) => ZLibEncoder().encode(data) );
  /// ```
  WxPDFGraphicsContext(
    WxPDFOutput output, {
    this.paperSize = WxPDFPaperSize.a4,
    this.title = '',
    this.author = '',
    this.subject = '',
    this.creator = 'wxDart',
    List<int> Function(List<int> data)? deflate,
  })  : _pdfWriter = _WxPDFWriter(output, deflate),
        super._defaultConstructor() {
    ownsHandle = false;
  }

  /// Default page size, used when startPage() is called with 0, 0.
  WxPDFPaperSize paperSize;
  String title;
  String author;
  String subject;
  String creator;

  final _WxPDFWriter _pdfWriter;
  WxPDFOutput get output => _pdfWriter.output;

  // document state
  bool _pdfDocStarted = false;
  bool _pdfDocEnded = false;
  int _pdfCatalogObj = 0;
  int _pdfPagesObj = 0;
  int _pdfInfoObj = 0;
  final List<int> _pdfPageObjs = [];
  final Map<String, int> _pdfFontObjs = {}; // base font name -> object
  final Map<String, String> _pdfFontRes = {}; // base font name -> /F1
  final Map<String, int> _pdfGStateObjs = {}; // /GS1 -> object
  final Map<String, String> _pdfGStateRes = {}; // "CA 0.5" -> /GS1
  final Map<String, String> _pdfGStateDicts = {}; // /GS1 -> dictionary
  int _pdfImageCount = 0;

  // page state
  bool _pdfInPage = false;
  double _pdfPageWidth = 0;
  double _pdfPageHeight = 0;
  StringBuffer _pdfContent = StringBuffer();
  final Set<String> _pdfPageFonts = {};
  final Set<String> _pdfPageGStates = {};
  final List<WxPDFGraphicsBitmap> _pdfPageImages = [];
  bool _pdfPageUsesAlpha = false;

  // graphics state
  _WxPDFState _pdfState = _WxPDFState();
  final List<_WxPDFState> _pdfStateStack = [];
  final List<_WxPDFMatrix> _pdfClipMatrices = [];
  // what has been written to the content stream (null = unknown)
  String? _pdfEmittedStroke;
  String? _pdfEmittedFill;

  int get pageCount => _pdfPageObjs.length;
  double get pageWidth => _pdfPageWidth;
  double get pageHeight => _pdfPageHeight;

  // ------------------------------------------------------------------
  // asynchronous driver
  // ------------------------------------------------------------------

  /// Generates a complete document. [renderPage] is called for every page
  /// (page index from 0 to pageCount - 1, like [paperSizeForPage]) between
  /// startPage() and endPage(). [onProgress] counts the pages written so far
  /// (1 after the first page), for "page 1 of 3". Between pages
  /// control returns to the event loop, so the UI stays responsive and
  /// [onProgress] can update a progress dialog ("printed page 1 of 399").
  ///
  /// Returns false if cancelled via [isCancelled]; the PDF is then still
  /// valid and contains the pages written so far.
  Future<bool> generate({
    required int pageCount,
    required FutureOr<void> Function(WxPDFGraphicsContext gc, int page) renderPage,
    void Function(WxPDFProgress progress)? onProgress,
    bool Function()? isCancelled,
    WxPDFPaperSize Function(int page)? paperSizeForPage,
  }) async {
    startDoc(title);
    bool completed = true;
    for (int page = 0; page < pageCount; page++) {
      if (isCancelled != null && isCancelled()) {
        completed = false;
        break;
      }
      final paper = paperSizeForPage?.call(page) ?? paperSize;
      startPage(paper.width, paper.height);
      await renderPage(this, page);
      for (final bitmap in _pdfPageImages) {
        await bitmap.resolve();
      }
      endPage();
      onProgress?.call(WxPDFProgress(page + 1, pageCount));
      await output.flush();
      // let the event loop run (repaint progress dialog, handle cancel button)
      await Future<void>.delayed(Duration.zero);
    }
    await close();
    return completed;
  }

  /// Ends the document (if not yet done) and closes the output.
  Future<void> close() async {
    if (_pdfDocStarted && !_pdfDocEnded) endDoc();
    await output.close();
  }

  // ------------------------------------------------------------------
  // document and pages
  // ------------------------------------------------------------------

  @override
  void startDoc(String message) {
    if (_pdfDocStarted) return;
    _pdfDocStarted = true;
    if (title.isEmpty) title = message;
    _pdfWriter.header();
    _pdfCatalogObj = _pdfWriter.allocate();
    _pdfPagesObj = _pdfWriter.allocate();
    _pdfInfoObj = _pdfWriter.allocate();
  }

  @override
  void endDoc() {
    if (!_pdfDocStarted) startDoc(title);
    if (_pdfDocEnded) return;
    if (_pdfInPage) endPage();
    final w = _pdfWriter;
    if (_pdfPageObjs.isEmpty) {
      // a PDF needs at least one page
      startPage(0, 0);
      endPage();
    }
    _pdfFontObjs.forEach((name, obj) {
      w.object(obj, '<< /Type /Font /Subtype /Type1 /BaseFont /$name /Encoding /WinAnsiEncoding >>');
    });
    _pdfGStateObjs.forEach((res, obj) {
      w.object(obj, '<< /Type /ExtGState ${_pdfGStateDicts[res]} >>');
    });
    final kids = _pdfPageObjs.map((o) => '$o 0 R').join(' ');
    w.object(_pdfPagesObj, '<< /Type /Pages /Kids [$kids] /Count ${_pdfPageObjs.length} >>');
    w.object(_pdfCatalogObj, '<< /Type /Catalog /Pages $_pdfPagesObj 0 R >>');
    final info = StringBuffer('<< /Producer ${_pdfTextString('wxDart PDF')}');
    if (title.isNotEmpty) info.write(' /Title ${_pdfTextString(title)}');
    if (author.isNotEmpty) info.write(' /Author ${_pdfTextString(author)}');
    if (subject.isNotEmpty) info.write(' /Subject ${_pdfTextString(subject)}');
    if (creator.isNotEmpty) info.write(' /Creator ${_pdfTextString(creator)}');
    info.write(' /CreationDate ${_pdfDate(DateTime.now())} >>');
    w.object(_pdfInfoObj, info.toString());
    w.trailer(_pdfCatalogObj, _pdfInfoObj);
    _pdfDocEnded = true;
  }

  /// Width and height in points; 0, 0 means [paperSize].
  @override
  void startPage(double width, double height) {
    if (!_pdfDocStarted) startDoc(title);
    if (_pdfInPage) endPage();
    _pdfInPage = true;
    _pdfPageWidth = width > 0 ? width : paperSize.width;
    _pdfPageHeight = height > 0 ? height : paperSize.height;
    _pdfContent = StringBuffer();
    _pdfPageFonts.clear();
    _pdfPageGStates.clear();
    _pdfPageImages.clear();
    _pdfPageUsesAlpha = false;
    _pdfState = _WxPDFState();
    _pdfStateStack.clear();
    _pdfClipMatrices.clear();
    _pdfEmittedStroke = null;
    _pdfEmittedFill = null;
    // base system: origin top left, y axis down
    _pdfContent.write('1 0 0 -1 0 ${_pdfNum(_pdfPageHeight)} cm\n');
  }

  @override
  void endPage() {
    if (!_pdfInPage) return;
    _pdfInPage = false;
    // balance q/Q
    final open = _pdfClipMatrices.length + _pdfStateStack.length;
    for (int i = 0; i < open; i++) {
      _pdfContent.write('Q\n');
    }
    final w = _pdfWriter;

    for (final bitmap in _pdfPageImages) {
      if (!bitmap._pdfWritten) bitmap._pdfWrite(w);
    }

    final contentObj = w.allocate();
    w.streamObject(contentObj, '', latin1.encode(_pdfContent.toString()));

    final res = StringBuffer('<< /ProcSet [/PDF /Text /ImageB /ImageC]');
    if (_pdfPageFonts.isNotEmpty) {
      res.write(' /Font <<');
      for (final name in _pdfPageFonts) {
        res.write(' /${_pdfFontRes[name]} ${_pdfFontObjs[name]} 0 R');
      }
      res.write(' >>');
    }
    if (_pdfPageImages.isNotEmpty) {
      res.write(' /XObject <<');
      for (final bitmap in _pdfPageImages) {
        res.write(' /${bitmap._pdfResourceName} ${bitmap._pdfObjectNumber} 0 R');
      }
      res.write(' >>');
    }
    if (_pdfPageGStates.isNotEmpty) {
      res.write(' /ExtGState <<');
      for (final gs in _pdfPageGStates) {
        res.write(' /$gs ${_pdfGStateObjs[gs]} 0 R');
      }
      res.write(' >>');
    }
    res.write(' >>');

    final pageObj = w.allocate();
    w.object(pageObj,
        '<< /Type /Page /Parent $_pdfPagesObj 0 R /MediaBox [0 0 ${_pdfNum(_pdfPageWidth)} ${_pdfNum(_pdfPageHeight)}] '
        '/Resources $res /Contents $contentObj 0 R >>');
    _pdfPageObjs.add(pageObj);
    _pdfContent = StringBuffer();
  }

  @override
  void flush() {
    // Nothing to do: pages are written in endPage(). Use generate() or
    // output.flush() for flushing a file.
  }

  // ------------------------------------------------------------------
  // pen, brush, font
  // ------------------------------------------------------------------

  @override
  void setFont(WxFont? font, WxColour colour) {
    _pdfState.font = font == null ? WxPDFFont('Helvetica', 10) : WxPDFFont.fromWxFont(font);
    _pdfState.textColour = colour;
  }

  /// Sets one of the standard fonts directly, no WxFont (and no native code) needed.
  void setPDFFont(WxPDFFont font, WxColour colour) {
    _pdfState.font = font;
    _pdfState.textColour = colour;
  }

  WxPDFFont get pdfFont => _pdfState.font;

  @override
  WxSize getTextExtent(String text) {
    final e = getPreciseTextExtent(text);
    return WxSize(e.width.ceil(), e.height.ceil());
  }

  /// Unrounded text extent in user units. Lines are separated by '\n'.
  ({double width, double height, double descent}) getPreciseTextExtent(String text) {
    final font = _pdfState.font;
    final lines = text.split('\n');
    double width = 0;
    for (final line in lines) {
      width = max(width, font.lineWidth(line));
    }
    return (width: width, height: lines.length * font.lineHeight, descent: font.descent);
  }

  @override
  void setPen(WxPen pen) {
    final s = _pdfState;
    s.penVisible = pen.style != wxPENSTYLE_TRANSPARENT;
    s.penColour = pen.colour;
    s.penWidth = pen.width.toDouble();
    s.penStyle = pen.style;
    s.penCap = pen.capStyle;
    s.penJoin = pen.joinStyle;
    s.penGradient = null;
  }

  @override
  void setPenWithConstantColour(WxColour colour,
      {double width = 1.0, int style = wxPENSTYLE_SOLID, int cap = wxCAP_ROUND, int join = wxJOIN_MITER}) {
    final s = _pdfState;
    s.penVisible = style != wxPENSTYLE_TRANSPARENT;
    s.penColour = colour;
    s.penWidth = width;
    s.penStyle = style;
    s.penCap = cap;
    s.penJoin = join;
    s.penGradient = null;
  }

  @override
  void setPenWithLinearGradient(double x1, double y1, double x2, double y2, WxColour colour1, WxColour colour2,
      {double width = 1.0, int style = wxPENSTYLE_SOLID, int cap = wxCAP_ROUND, int join = wxJOIN_MITER}) {
    // TODO: axial shading pattern (/ShadingType 2) as stroke colour
    setPenWithConstantColour(colour1, width: width, style: style, cap: cap, join: join);
    _pdfState.penGradient = _WxPDFGradient.linear(x1, y1, x2, y2, colour1, colour2);
  }

  @override
  void setPenWithRadialGradient(double startX, double startY, double endX, double endY, double radius,
      WxColour outerColour, WxColour innerColour,
      {double width = 1.0, int style = wxPENSTYLE_SOLID, int cap = wxCAP_ROUND, int join = wxJOIN_MITER}) {
    // TODO: radial shading pattern (/ShadingType 3) as stroke colour
    setPenWithConstantColour(innerColour, width: width, style: style, cap: cap, join: join);
    _pdfState.penGradient =
        _WxPDFGradient.radial(startX, startY, endX, endY, radius, outerColour, innerColour);
  }

  @override
  void setBrush(WxBrush brush) {
    _pdfState.brushVisible = brush.style != wxBRUSHSTYLE_TRANSPARENT;
    _pdfState.brushColour = brush.colour;
    // TODO: hatch brush styles as tiling patterns
  }

  @override
  bool setCompositionMode(int mode) {
    // PDF's default blend mode /Normal is wxCOMPOSITION_OVER.
    // TODO: some modes map to PDF blend modes, the Porter-Duff ones do not.
    return mode == wxCOMPOSITION_OVER;
  }

  // ------------------------------------------------------------------
  // bitmaps and paths
  // ------------------------------------------------------------------

  @override
  WxPDFGraphicsBitmap createBitmap(WxBitmap bitmap) => WxPDFGraphicsBitmap.fromBitmap(bitmap);

  @override
  WxPDFGraphicsBitmap createBitmapFromImage(WxImage image) => WxPDFGraphicsBitmap.fromImage(image);

  @override
  WxPDFGraphicsPath createPath() => WxPDFGraphicsPath();

  // ------------------------------------------------------------------
  // clipping, state, transformation
  // ------------------------------------------------------------------

  @override
  void clip(double x, double y, double width, double height) {
    if (!_pdfCheckPage('clip')) return;
    _pdfClipMatrices.add(_pdfState.matrix);
    _pdfContent.write('q ${_pdfNum(x)} ${_pdfNum(y)} ${_pdfNum(width)} ${_pdfNum(height)} re W n\n');
  }

  /// Removes all clip regions set since the last pushState() (PDF cannot
  /// remove a clip region other than by restoring a saved state).
  @override
  void resetClip() {
    if (!_pdfCheckPage('resetClip')) return;
    final base = _pdfState.clipCount;
    if (_pdfClipMatrices.length <= base) return;
    final matrixAtClip = _pdfClipMatrices[base];
    for (int i = _pdfClipMatrices.length; i > base; i--) {
      _pdfContent.write('Q\n');
    }
    _pdfClipMatrices.removeRange(base, _pdfClipMatrices.length);
    _pdfStateLost();
    // re-establish the transformation that was set after the first clip
    final delta = _pdfState.matrix.times(matrixAtClip.inverted());
    if (!delta.isIdentity) _pdfContent.write(delta.toPdf());
  }

  @override
  void pushState() {
    if (!_pdfCheckPage('pushState')) return;
    _pdfContent.write('q\n');
    _pdfStateStack.add(_pdfState);
    _pdfState = _pdfState.copy()..clipCount = _pdfClipMatrices.length;
  }

  @override
  void popState() {
    if (!_pdfCheckPage('popState')) return;
    if (_pdfStateStack.isEmpty) {
      wxLogError('WxPDFGraphicsContext.popState() without pushState()');
      return;
    }
    final base = _pdfState.clipCount;
    for (int i = _pdfClipMatrices.length; i > base; i--) {
      _pdfContent.write('Q\n');
    }
    _pdfClipMatrices.removeRange(base, _pdfClipMatrices.length);
    _pdfContent.write('Q\n');
    _pdfState = _pdfStateStack.removeLast();
    _pdfStateLost();
  }

  @override
  void rotate(double angle) {
    final c = cos(angle), s = sin(angle);
    _pdfConcat(_WxPDFMatrix(c, s, -s, c, 0, 0));
  }

  @override
  void translate(double x, double y) => _pdfConcat(_WxPDFMatrix(1, 0, 0, 1, x, y));

  @override
  void scale(double xScale, double yScale) => _pdfConcat(_WxPDFMatrix(xScale, 0, 0, yScale, 0, 0));

  void _pdfConcat(_WxPDFMatrix m) {
    if (!_pdfCheckPage('transform')) return;
    _pdfState.matrix = m.times(_pdfState.matrix);
    _pdfContent.write(m.toPdf());
  }

  // ------------------------------------------------------------------
  // drawing
  // ------------------------------------------------------------------

  @override
  void strokePath(WxGraphicsPath path) {
    final p = _pdfCheckPath(path, 'strokePath');
    if (p == null || !_pdfState.penVisible) return;
    _pdfApplyStroke();
    _pdfContent.write(p._pdfOps);
    _pdfContent.write('S\n');
  }

  @override
  void fillPath(WxGraphicsPath path, { int fillStyle = wxODDEVEN_RULE }) {
    final p = _pdfCheckPath(path, 'fillPath');
    if (p == null || !_pdfState.brushVisible) return;
    _pdfApplyFill();
    _pdfContent.write(p._pdfOps);
    _pdfContent.write('f*\n'); // wxODDEVEN_RULE is the wx default
  }

  @override
  void drawPath(WxGraphicsPath path, { int fillStyle = wxODDEVEN_RULE }) {
    final p = _pdfCheckPath(path, 'drawPath');
    if (p == null) return;
    _pdfPaint(p._pdfOps.toString());
  }

  @override
  void strokeLine(double x1, double y1, double x2, double y2) {
    if (!_pdfCheckPage('strokeLine') || !_pdfState.penVisible) return;
    _pdfApplyStroke();
    _pdfContent.write('${_pdfNum(x1)} ${_pdfNum(y1)} m ${_pdfNum(x2)} ${_pdfNum(y2)} l S\n');
  }

  @override
  void strokeLines(List<WxRealPoint> lines) {
    if (!_pdfCheckPage('strokeLines') || !_pdfState.penVisible || lines.length < 2) return;
    _pdfApplyStroke();
    final sb = StringBuffer('${_pdfNum(lines[0].x)} ${_pdfNum(lines[0].y)} m\n');
    for (int i = 1; i < lines.length; i++) {
      sb.write('${_pdfNum(lines[i].x)} ${_pdfNum(lines[i].y)} l\n');
    }
    sb.write('S\n');
    _pdfContent.write(sb);
  }

  @override
  void drawEllipse(double x, double y, double width, double height) {
    final p = WxPDFGraphicsPath()..addEllipse(x, y, width, height);
    if (_pdfCheckPage('drawEllipse')) _pdfPaint(p.pdfOperators);
  }

  @override
  void drawRectangle(double x, double y, double width, double height) {
    if (_pdfCheckPage('drawRectangle')) {
      _pdfPaint('${_pdfNum(x)} ${_pdfNum(y)} ${_pdfNum(width)} ${_pdfNum(height)} re\n');
    }
  }

  @override
  void drawRoundedRectangle(double x, double y, double width, double height, double radius) {
    final p = WxPDFGraphicsPath()..addRoundedRectangle(x, y, width, height, radius);
    if (_pdfCheckPage('drawRoundedRectangle')) _pdfPaint(p.pdfOperators);
  }

  @override
  void drawBitmap(WxGraphicsBitmap bitmap, double x, double y, double width, double height) {
    if (!_pdfCheckPage('drawBitmap')) return;
    if (bitmap is! WxPDFGraphicsBitmap) {
      wxLogError('WxPDFGraphicsContext.drawBitmap: bitmap was not created by a WxPDFGraphicsContext');
      return;
    }
    if (!identical(bitmap._pdfWriter, _pdfWriter)) {
      // first use in this document
      bitmap._pdfWriter = _pdfWriter;
      bitmap._pdfObjectNumber = _pdfWriter.allocate();
      bitmap._pdfResourceName = 'Im${++_pdfImageCount}';
      bitmap._pdfWritten = false;
    }
    if (!_pdfPageImages.contains(bitmap)) _pdfPageImages.add(bitmap);
    // map the image's unit square so that its first row is at the top (y)
    _pdfContent.write('q ${_pdfNum(width)} 0 0 ${_pdfNum(-height)} ${_pdfNum(x)} ${_pdfNum(y + height)} cm '
        '/${bitmap._pdfResourceName} Do Q\n');
  }

  /// (x, y) is the top left corner of the text, as in wx. '\n' starts a new line.
  @override
  void drawText(String text, double x, double y) {
    if (!_pdfCheckPage('drawText') || text.isEmpty) return;
    final font = _pdfState.font;
    _pdfApplyTextColour();
    final res = _pdfUseFont(font.name);
    final sb = StringBuffer('BT /$res ${_pdfNum(font.size)} Tf\n');
    var baseline = y + font.ascent;
    for (final line in text.split('\n')) {
      if (line.isNotEmpty) {
        // the text matrix flips y back, otherwise glyphs would be upside down
        sb.write('1 0 0 -1 ${_pdfNum(x)} ${_pdfNum(baseline)} Tm ${font.encodeLiteral(line)} Tj\n');
      }
      baseline += font.lineHeight;
    }
    sb.write('ET\n');
    _pdfContent.write(sb);
  }

  // ------------------------------------------------------------------
  // internals
  // ------------------------------------------------------------------

  bool _pdfCheckPage(String what) {
    if (_pdfInPage) return true;
    wxLogError('WxPDFGraphicsContext.$what called outside of startPage()/endPage()');
    return false;
  }

  WxPDFGraphicsPath? _pdfCheckPath(WxGraphicsPath path, String what) {
    if (!_pdfCheckPage(what)) return null;
    if (path is! WxPDFGraphicsPath) {
      wxLogError('WxPDFGraphicsContext.$what: path was not created by a WxPDFGraphicsContext');
      return null;
    }
    return path;
  }

  /// Fill and/or stroke a path given as PDF operators, like wxGraphicsContext::DrawPath.
  void _pdfPaint(String ops) {
    final fill = _pdfState.brushVisible;
    final stroke = _pdfState.penVisible;
    if (!fill && !stroke) return;
    if (fill) _pdfApplyFill();
    if (stroke) _pdfApplyStroke();
    _pdfContent.write(ops);
    _pdfContent.write(fill && stroke ? 'B*\n' : (fill ? 'f*\n' : 'S\n'));
  }

  /// After Q the graphics state in the PDF is no longer what we wrote last.
  void _pdfStateLost() {
    _pdfEmittedStroke = null;
    _pdfEmittedFill = null;
  }

  void _pdfApplyStroke() {
    final s = _pdfState;
    final sb = StringBuffer(_pdfColourOps(s.penColour, 'RG'));
    sb.write('${_pdfNum(s.penWidth)} w ');
    sb.write(switch (s.penCap) { wxCAP_BUTT => '0', wxCAP_PROJECTING => '2', _ => '1' });
    sb.write(' J ');
    sb.write(switch (s.penJoin) { wxJOIN_ROUND => '1', wxJOIN_BEVEL => '2', _ => '0' });
    sb.write(' j ');
    sb.write(_pdfDash(s.penStyle, s.penWidth));
    sb.write(' d\n');
    sb.write(_pdfAlphaOps('CA', _pdfAlpha(s.penColour)));
    final ops = sb.toString();
    if (ops != _pdfEmittedStroke) {
      _pdfContent.write(ops);
      _pdfEmittedStroke = ops;
    }
  }

  void _pdfApplyFill() => _pdfApplyFillColour(_pdfState.brushColour);

  void _pdfApplyTextColour() => _pdfApplyFillColour(_pdfState.textColour);

  void _pdfApplyFillColour(WxColour colour) {
    final ops = _pdfColourOps(colour, 'rg') + _pdfAlphaOps('ca', _pdfAlpha(colour));
    if (ops != _pdfEmittedFill) {
      _pdfContent.write(ops);
      _pdfEmittedFill = ops;
    }
  }

  String _pdfDash(int style, double width) {
    final u = max(width, 1.0);
    String arr(List<double> l) => '[${l.map((v) => _pdfNum(v * u)).join(' ')}] 0';
    switch (style) {
      case wxPENSTYLE_DOT:
        return arr([1, 2]);
      case wxPENSTYLE_LONG_DASH:
        return arr([8, 4]);
      case wxPENSTYLE_SHORT_DASH:
        return arr([4, 4]);
      case wxPENSTYLE_DOT_DASH:
        return arr([8, 3, 1, 3]);
      default:
        return '[] 0';
    }
  }

  /// Opacity needs an ExtGState resource. Only written once a page uses
  /// transparency, so opaque documents stay free of them.
  String _pdfAlphaOps(String key, double alpha) {
    if (alpha >= 1.0 && !_pdfPageUsesAlpha) return '';
    _pdfPageUsesAlpha = true;
    final dict = '/$key ${_pdfNum(alpha)}';
    var res = _pdfGStateRes[dict];
    if (res == null) {
      res = 'GS${_pdfGStateRes.length + 1}';
      _pdfGStateRes[dict] = res;
      _pdfGStateDicts[res] = dict;
      _pdfGStateObjs[res] = _pdfWriter.allocate();
    }
    _pdfPageGStates.add(res);
    return '/$res gs\n';
  }

  String _pdfUseFont(String baseFont) {
    var res = _pdfFontRes[baseFont];
    if (res == null) {
      res = 'F${_pdfFontRes.length + 1}';
      _pdfFontRes[baseFont] = res;
      _pdfFontObjs[baseFont] = _pdfWriter.allocate();
    }
    _pdfPageFonts.add(baseFont);
    return res;
  }
}
