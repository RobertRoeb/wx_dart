// -------------------------------------------------------------
// Purpose:     PDF output for wxDart - file output (dart:io only)
// Author:      Robert Roebling
// Created:     25/11/2026
// Copyright:   (c) Robert Roebling
// Licence:     wxWindows licence 3.1
// -------------------------------------------------------------
//
// Not in /common because it needs dart:io (not available in wxDart Web).
// Add as part of the Native (and Flutter desktop) library.

part of '../wx_dart.dart';

/// Writes the PDF directly into a file, page by page.
/// 
/// This class is only available in wxDart Native.

class WxPDFFileOutput extends WxPDFOutput {
  WxPDFFileOutput(String path) : _pdfSink = File(path).openWrite();

  final IOSink _pdfSink;

  @override
  void add(List<int> bytes) => _pdfSink.add(bytes);

  @override
  Future<void> flush() => _pdfSink.flush();

  @override
  Future<void> close() => _pdfSink.close();
}

/// Flate compression for PDF streams, pass as `deflate:` to WxPDFGraphicsContext.
List<int> wxPDFDeflate(List<int> data) => zlib.encode(data);
