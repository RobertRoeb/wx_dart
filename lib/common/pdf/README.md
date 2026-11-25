# wxDart PDF output (`/common/pdf`)

A `WxGraphicsContext` that writes PDF, in pure Dart. No C++, no dart:io, no external package.

| File | Contents |
|---|---|
| `pdf_graphics_context.dart` | `WxPDFGraphicsContext`: overrides **every** method of `WxGraphicsContext`, plus `generate()` (async, with progress and cancel) |
| `pdf_graphics_path.dart` | `WxPDFGraphicsPath`: records PDF path operators (lines, rectangles, arcs → Bézier, ellipses, rounded rectangles, plus `addCurveToPoint`/`addQuadCurveToPoint`) |
| `pdf_graphics_bitmap.dart` | `WxPDFGraphicsBitmap`: holds a `WxImage` (or a `WxBitmap` that is converted asynchronously); written only once per document, with alpha as `/SMask` |
| `pdf_text.dart` | `WxPDFFont`: standard fonts, WinAnsi encoding, text measurement |
| `pdf_std_fonts.dart` | **Generated**: glyph widths for the 12 standard text fonts (from the Adobe Core-14 AFM files, licence notice in the header) |
| `pdf_document.dart` | `WxPDFOutput`/`WxPDFMemoryOutput`, `WxPDFPaperSize`, `WxPDFProgress`, object writer with xref, matrix, number formatting |
| `../../native/pdf_file_output.dart` | `WxPDFFileOutput` (IOSink) and `wxPDFDeflate` (zlib). Needs dart:io, so it is **not** in `/common` |

## Integration

In `wx_dart.dart` (every variant):

```dart
import 'dart:async';
import 'dart:convert';
import 'dart:math';        // used unprefixed: sin, cos, tan, min, max, pi
import 'dart:typed_data';

part 'common/pdf/pdf_document.dart';
part 'common/pdf/pdf_text.dart';
part 'common/pdf/pdf_std_fonts.dart';
part 'common/pdf/pdf_graphics_path.dart';
part 'common/pdf/pdf_graphics_bitmap.dart';
part 'common/pdf/pdf_graphics_context.dart';
```

For Native, also add `import 'dart:io';` and `part 'native/pdf_file_output.dart';`. If the paths differ, fix the `part of '../../wx_dart.dart';` lines.

**Assumptions** (not verifiable from `gdi.dart` alone):
- `WxGraphicsContext`, `WxGraphicsPath` and `WxGraphicsBitmap` have `_defaultConstructor()` in every variant (in Native they do).
- `WxColour(r, g, b[, a])` exists, and `getRGBA()` uses the wx convention (red = lowest byte). Everything that depends on this is in `_pdfRGBA()`.
- The constants `wxPENSTYLE_TRANSPARENT/DOT/LONG_DASH/SHORT_DASH/DOT_DASH`, `wxBRUSHSTYLE_TRANSPARENT`, `wxCAP_BUTT/PROJECTING` and `wxJOIN_ROUND/BEVEL` are defined in `/common`.

## Why "inherit the interface, override everything"

- `WxPDFGraphicsContext` **is a** `WxGraphicsContext`, so existing drawing code that receives a `WxGraphicsContext` works unchanged.
- It is constructed via `_defaultConstructor()` with `ownsHandle = false`. This creates no native object and attaches no finalizer.
- No intermediate layer (`WxCustomGraphicsContext`) is needed. It would only become worthwhile if a second pure Dart context came along (SVG, for example).
- **Risk:** if the generator adds a method to `WxGraphicsContext` and nobody overrides it here, the inherited version calls C++ with an invalid handle. One remedy is for the generator to emit an `abstract interface class WxGraphicsContextInterface`, which both the Native class and the PDF class `implement`. The compiler then enforces completeness.
- Every private member has the `_pdf` prefix. Because the file belongs to the same library, a member such as `_state` could otherwise accidentally override a private member of `WxObject`.

## Coordinates and units

The origin is at the top left with y pointing down, as on screen. 1 unit = 1 pt (1/72"). `startPage(0, 0)` uses `paperSize`. For millimetres: `gc.scale(72 / 25.4, 72 / 25.4)`.

## Text (stage 1)

Only the 12 standard fonts that every PDF viewer has built in are used, so nothing is embedded. `WxFont` is mapped by family, weight and style (ROMAN → Times, TELETYPE/MODERN → Courier, everything else → Helvetica). Without a `WxFont`, use `setPDFFont(WxPDFFont.std(...))`. Text is written in WinAnsi (Windows-1252), which covers German and Western European languages and the euro sign. Other characters become `?`.

`getTextExtent()`/`getPreciseTextExtent()` compute from the Dart tables. The results are therefore **identical on every platform**, which is the foundation for platform-independent line breaking.

## Open items (TODO)

- Gradients (shading patterns): currently falls back to a single colour. Hatch brushes. Composition modes other than OVER.
- `resetClip()` only removes clips set since the last `pushState()`, because of a PDF limitation.
- JPEG pass-through for photos.
- TrueType embedding (subset, CIDFontType2 + ToUnicode), which brings full Unicode.
- Kerning (the KPX pairs from the AFM files, via `TJ`).
- `addCurveToPoint`/`addQuadCurveToPoint` in the Native binding of `WxGraphicsPath`.
