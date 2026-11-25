// -------------------------------------------------------------
// Purpose:     PDF output for wxDart - WxPDFGraphicsBitmap
// Author:      Robert Roebling
// Created:     25/11/2026
// Copyright:   (c) Robert Roebling
// Licence:     wxWindows licence 3.1
// -------------------------------------------------------------

part of '../../wx_dart.dart';

/// Bitmap for the PDF context. Holds a WxImage. When created from a
/// WxBitmap, the conversion to WxImage is done lazily and asynchronously
/// (WxBitmap.convertToImage() is async in wxDart), see [resolve].
///
/// The image is written into the PDF only once per document, even if it
/// is drawn on many pages.
class WxPDFGraphicsBitmap extends WxGraphicsBitmap {
  WxPDFGraphicsBitmap.fromImage(WxImage image)
      : _pdfImage = image,
        super._defaultConstructor() {
    ownsHandle = false;
  }

  WxPDFGraphicsBitmap.fromBitmap(WxBitmap bitmap)
      : _pdfBitmap = bitmap,
        super._defaultConstructor() {
    ownsHandle = false;
  }

  WxImage? _pdfImage;
  WxBitmap? _pdfBitmap;

  // per document bookkeeping
  _WxPDFWriter? _pdfWriter;
  int _pdfObjectNumber = 0;
  String _pdfResourceName = '';
  bool _pdfWritten = false;

  WxImage? get image => _pdfImage;

  /// true if the pixel data is available synchronously
  bool get isResolved => _pdfImage != null;

  Future<void> resolve() async {
    if (_pdfImage == null && _pdfBitmap != null) {
      _pdfImage = await _pdfBitmap!.convertToImage();
    }
  }

  int get width => _pdfImage?.getWidth() ?? _pdfBitmap?.getWidth() ?? 0;
  int get height => _pdfImage?.getHeight() ?? _pdfBitmap?.getHeight() ?? 0;

  void _pdfWrite(_WxPDFWriter w) {
    final img = _pdfImage;
    if (img == null || !img.isOk()) {
      wxLogError('WxPDFGraphicsBitmap: image data not available, writing placeholder. '
          'Call resolve() before endPage() or use WxPDFGraphicsContext.generate().');
      w.streamObject(_pdfObjectNumber,
          '/Type /XObject /Subtype /Image /Width 1 /Height 1 /ColorSpace /DeviceGray /BitsPerComponent 8',
          const [255]);
      _pdfWritten = true;
      return;
    }
    final width = img.getWidth();
    final height = img.getHeight();
    // copy: getData() may be a view on native memory
    final rgb = Uint8List.fromList(img.getData());
    String smask = '';
    if (img.hasAlpha()) {
      final alpha = img.getAlphaData();
      if (alpha != null) {
        final maskObj = w.allocate();
        w.streamObject(maskObj,
            '/Type /XObject /Subtype /Image /Width $width /Height $height /ColorSpace /DeviceGray /BitsPerComponent 8',
            Uint8List.fromList(alpha));
        smask = ' /SMask $maskObj 0 R';
      }
    }
    // TODO: JPEG pass-through (/DCTDecode) for photos to keep files small
    w.streamObject(_pdfObjectNumber,
        '/Type /XObject /Subtype /Image /Width $width /Height $height /ColorSpace /DeviceRGB /BitsPerComponent 8$smask',
        rgb);
    _pdfWritten = true;
  }
}
