# hello

This is an example for wxDart Web

## Getting Started

wxDart Web is a slightly limited variant of wxDart next to **wxDart Flutter** and
**wxDart Native**. It only runs in a browser and is designed to start fast:

* no Flutter engine, no Skia/CanvasKit, no web fonts to download
* `WxPaintDC` draws directly on an HTML `<canvas>` (CanvasRenderingContext2D)
* the first `WxFrame` fills the browser window; its title is the tab title
* `WxMenuBar`/`WxMenu` and `WxDialog` are rendered with HTML and CSS
* `WxButton` and `WxStaticText` are plain `<button>` and `<div>` elements
* bitmaps are downloaded from the server asynchronously (like Flutter web assets)
* all events are created by JavaScript and dispatched to the `WxWindow`s
* the Dart package has **no dependencies** besides the SDK (`dart:js_interop`),
  so it compiles to JavaScript (`dart compile js`) or WebAssembly (`dart compile wasm`)

## Building the example

```sh
cd example
dart pub get
cp ../wx_bridge/wxc.js ../wx_bridge/wxc.css web/
dart compile js -O2 -o web/main.dart.js lib/main.dart
# or: dart compile wasm -o web/main.wasm web/main.dart  (needs a Wasm loader page)
cd web && python3 -m http.server 8080
```
