// -------------------------------------------------------------
// Purpose:     PDF output for wxDart - document level helpers
// Author:      Robert Roebling
// Created:     25/11/2026
// Copyright:   (c) Robert Roebling
// Licence:     wxWindows licence 3.1
// -------------------------------------------------------------
//
// Pure Dart, no dart:io and no C++, so that this file can be shared
// between wxDart Native, wxDart Flutter and wxDart Web.
//
// Requires these imports in wx_dart.dart (part files cannot import):
//   dart:async, dart:convert, dart:math, dart:typed_data

part of '../../wx_dart.dart';

// ------------------------- WxPDFOutput ----------------------

/// Byte sink the PDF is written to. The PDF is written incrementally
/// (page by page), so large documents never have to be in memory as a whole.
abstract class WxPDFOutput {
  void add(List<int> bytes);

  /// Called after every page by [WxPDFGraphicsContext.generate].
  Future<void> flush() async {}

  Future<void> close() async {}
}

/// Collects the PDF in memory as a Uint8List. Only depends on dart:typed_data
/// and dart:async, so it runs everywhere: Native, Flutter and Web.
///
/// ```dart
/// final out = WxPDFUint8ListOutput();
/// final gc = WxPDFGraphicsContext(out);
/// await gc.generate(pageCount: 3, renderPage: (gc, page) { ... });  // page 0, 1, 2
/// final Uint8List pdf = await out.result;   // or out.bytes
/// ```
class WxPDFUint8ListOutput extends WxPDFOutput {
  WxPDFUint8ListOutput({int initialCapacity = 64 * 1024})
      : _pdfBuffer = Uint8List(initialCapacity > 0 ? initialCapacity : 1024);

  Uint8List _pdfBuffer;
  int _pdfLength = 0;
  bool _pdfClosed = false;
  final Completer<Uint8List> _pdfResult = Completer<Uint8List>();

  /// Number of bytes written so far.
  int get length => _pdfLength;

  bool get isClosed => _pdfClosed;

  @override
  void add(List<int> bytes) {
    if (_pdfClosed) {
      throw StateError('WxPDFUint8ListOutput: add() after close()');
    }
    final needed = _pdfLength + bytes.length;
    if (needed > _pdfBuffer.length) {
      var capacity = _pdfBuffer.length * 2;
      while (capacity < needed) {
        capacity *= 2;
      }
      final grown = Uint8List(capacity);
      grown.setRange(0, _pdfLength, _pdfBuffer);
      _pdfBuffer = grown;
    }
    _pdfBuffer.setRange(_pdfLength, needed, bytes);
    _pdfLength = needed;
  }

  /// A copy of the bytes written so far (also usable before close()).
  Uint8List get bytes => Uint8List.fromList(Uint8List.sublistView(_pdfBuffer, 0, _pdfLength));

  /// The complete PDF, available after close() (called by generate()).
  Future<Uint8List> get result => _pdfResult.future;

  @override
  Future<void> close() async {
    if (_pdfClosed) return;
    _pdfClosed = true;
    _pdfResult.complete(Uint8List.sublistView(_pdfBuffer, 0, _pdfLength));
  }

  /// Empties the buffer so the object can be used for another document
  /// (only before close()).
  void clear() {
    if (_pdfClosed) {
      throw StateError('WxPDFUint8ListOutput: clear() after close()');
    }
    _pdfLength = 0;
  }
}

// ------------------------- WxPDFPaperSize ----------------------

/// Paper size in PDF points (1/72 inch).
class WxPDFPaperSize {
  const WxPDFPaperSize(this.name, this.width, this.height);

  WxPDFPaperSize.fromMillimetres(this.name, double widthMM, double heightMM)
      : width = widthMM * 72.0 / 25.4,
        height = heightMM * 72.0 / 25.4;

  final String name;
  final double width;
  final double height;

  WxPDFPaperSize get landscape =>
      width >= height ? this : WxPDFPaperSize('$name landscape', height, width);
  WxPDFPaperSize get portrait =>
      width <= height ? this : WxPDFPaperSize(name, height, width);

  static const a3 = WxPDFPaperSize('A3', 841.89, 1190.55);
  static const a4 = WxPDFPaperSize('A4', 595.28, 841.89);
  static const a5 = WxPDFPaperSize('A5', 419.53, 595.28);
  static const a6 = WxPDFPaperSize('A6', 297.64, 419.53);
  static const b5 = WxPDFPaperSize('B5', 498.90, 708.66);
  static const letter = WxPDFPaperSize('Letter', 612, 792);
  static const legal = WxPDFPaperSize('Legal', 612, 1008);
  static const tabloid = WxPDFPaperSize('Tabloid', 792, 1224);
}

// ------------------------- WxPDFProgress ----------------------

class WxPDFProgress {
  const WxPDFProgress(this.page, this.pageCount);

  /// Number of pages written so far, i.e. the page that has just been
  /// written, counted from 1 (the page index passed to renderPage + 1).
  final int page;
  final int pageCount;

  double get fraction => pageCount == 0 ? 1.0 : page / pageCount;
  bool get isDone => page >= pageCount;

  /// Untranslated default text, wrap in your own translation if needed.
  String get message => 'printed page $page of $pageCount';

  @override
  String toString() => message;
}

// ------------------------- internal: writer ----------------------

/// Low level PDF object writer. Keeps track of byte offsets for the xref table.
class _WxPDFWriter {
  _WxPDFWriter(this.output, this.deflate);

  final WxPDFOutput output;
  final List<int> Function(List<int> data)? deflate;

  int _offset = 0;
  // index = object number, value = byte offset (0 = allocated, not yet written)
  final List<int> _xref = [0];

  int allocate() {
    _xref.add(0);
    return _xref.length - 1;
  }

  void raw(String s) {
    final b = latin1.encode(s);
    output.add(b);
    _offset += b.length;
  }

  void bytes(List<int> b) {
    output.add(b);
    _offset += b.length;
  }

  void header() {
    raw('%PDF-1.4\n');
    // binary marker so that transfer programs treat the file as binary
    bytes(const [0x25, 0xE2, 0xE3, 0xCF, 0xD3, 0x0A]);
  }

  void object(int n, String body) {
    _xref[n] = _offset;
    raw('$n 0 obj\n$body\nendobj\n');
  }

  /// [dict] is the content of the stream dictionary without << >>, /Length and /Filter.
  void streamObject(int n, String dict, List<int> data, {bool compress = true}) {
    List<int> payload = data;
    String filter = '';
    if (compress && deflate != null) {
      payload = deflate!(data);
      filter = ' /Filter /FlateDecode';
    }
    _xref[n] = _offset;
    raw('$n 0 obj\n<< $dict /Length ${payload.length}$filter >>\nstream\n');
    bytes(payload);
    raw('\nendstream\nendobj\n');
  }

  void trailer(int root, int info) {
    for (int i = 1; i < _xref.length; i++) {
      if (_xref[i] == 0) {
        // should never happen - keep the file valid anyway
        object(i, 'null');
      }
    }
    final xrefOffset = _offset;
    final sb = StringBuffer('xref\n0 ${_xref.length}\n0000000000 65535 f \n');
    for (int i = 1; i < _xref.length; i++) {
      sb.write('${_xref[i].toString().padLeft(10, '0')} 00000 n \n');
    }
    sb.write('trailer\n<< /Size ${_xref.length} /Root $root 0 R /Info $info 0 R >>\n');
    sb.write('startxref\n$xrefOffset\n%%EOF\n');
    raw(sb.toString());
  }
}

// ------------------------- internal: matrix ----------------------

/// Affine matrix in PDF notation [a b c d e f]:
///   x' = a*x + c*y + e,  y' = b*x + d*y + f
class _WxPDFMatrix {
  const _WxPDFMatrix(this.a, this.b, this.c, this.d, this.e, this.f);

  static const identity = _WxPDFMatrix(1, 0, 0, 1, 0, 0);

  final double a, b, c, d, e, f;

  /// Same as PDF's "this cm" applied when CTM == other: result = this x other
  _WxPDFMatrix times(_WxPDFMatrix m) => _WxPDFMatrix(
        a * m.a + b * m.c,
        a * m.b + b * m.d,
        c * m.a + d * m.c,
        c * m.b + d * m.d,
        e * m.a + f * m.c + m.e,
        e * m.b + f * m.d + m.f,
      );

  _WxPDFMatrix inverted() {
    final det = a * d - b * c;
    if (det == 0) return identity;
    return _WxPDFMatrix(
      d / det,
      -b / det,
      -c / det,
      a / det,
      (c * f - d * e) / det,
      (b * e - a * f) / det,
    );
  }

  bool get isIdentity => a == 1 && b == 0 && c == 0 && d == 1 && e == 0 && f == 0;

  String toPdf() =>
      '${_pdfNum(a)} ${_pdfNum(b)} ${_pdfNum(c)} ${_pdfNum(d)} ${_pdfNum(e)} ${_pdfNum(f)} cm\n';
}

// ------------------------- internal: formatting ----------------------

/// PDF numbers must not use exponent notation. 4 decimals are plenty
/// (1/10000 pt).
String _pdfNum(double v) {
  if (v.isNaN || v.isInfinite) return '0';
  final r = (v * 10000).round();
  if (r % 10000 == 0) return (r ~/ 10000).toString();
  var s = (r / 10000).toStringAsFixed(4);
  while (s.endsWith('0')) {
    s = s.substring(0, s.length - 1);
  }
  if (s.endsWith('.')) s = s.substring(0, s.length - 1);
  return s;
}

/// Text string for the document info dictionary (UTF-16BE with BOM, hex form).
String _pdfTextString(String s) {
  final sb = StringBuffer('<FEFF');
  for (final unit in s.codeUnits) {
    sb.write(unit.toRadixString(16).padLeft(4, '0').toUpperCase());
  }
  sb.write('>');
  return sb.toString();
}

String _pdfDate(DateTime t) {
  String two(int v) => v.toString().padLeft(2, '0');
  final u = t.toUtc();
  return '(D:${u.year}${two(u.month)}${two(u.day)}${two(u.hour)}${two(u.minute)}${two(u.second)}Z)';
}

/// wxColour::GetRGBA() convention: red is the least significant byte.
/// This is the only place that depends on the WxColour encoding.
List<int> _pdfRGBA(WxColour colour) {
  final v = colour.getRGBA();
  return [v & 0xFF, (v >> 8) & 0xFF, (v >> 16) & 0xFF, (v >> 24) & 0xFF];
}

String _pdfColourOps(WxColour colour, String op) {
  final c = _pdfRGBA(colour);
  return '${_pdfNum(c[0] / 255)} ${_pdfNum(c[1] / 255)} ${_pdfNum(c[2] / 255)} $op\n';
}

double _pdfAlpha(WxColour colour) => _pdfRGBA(colour)[3] / 255.0;
