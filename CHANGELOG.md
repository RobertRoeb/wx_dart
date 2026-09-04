## 0.9.12

* Allow wxDart Flutter apps on the web to appear in an HTML window - not just full-screen apps
* Added WxRealOffset for conveniance
* Change from flutter_html to flutter_widget_from_html because the former is no longer maintained
* Several documentation updates 

## 0.9.11

* Changed wxDart Native way to build to use Flutter system on all systems
* Added support for asynchronous code execution (async await) to wxDart Native
* Added support for using the Asset framework (and other Bindings) to wxDart Native
* Added async await sample to demo
* Properly documented WxSizerItem and WxSizer
* Added WxSizerItem.isSizer(), isWindow() and isSpacer()
* Added WxSizer.getItemCount(), getItem(), getWindowItem() and getSizerItem()
* Added WxSizer.remove(), removeSizer() and removeWindow()
* Removed or hid platform specific code from WxSizer and WxSizerItem 
* Corrected WxSizer.layout() and WxWindow.layout() in wxDart Flutter to update the display
* Added WxImage.hasAlpha() and clearAlpha()
* Added WxImage.fromRGB() and WxImage.fromRGBA() constructors
* Updated TabbedView, used for WxNotebook, code to latest version
* Initial work to support multi-windows on Flutter Desktop
* Work on flutter_angle to support Flutter on Linux as well
* Work on wxWidget's GTK+ port to allow synchronous wxDart code execution
* Wrote ThreeJS Dart renderer using wxGlContext as the backend 

## 0.9.10

* Corrected filled WxGraphicsContext.drawRectangle() etc. if a brush is used
* Adapted OpenGL/WxGLCanvas/WxGLContext code for Flutter Web / WebGL
* Adapted OpenGL to run on the Web and on Linux native as well
* Synthesize idle event after main window resize
* Defer sending WxSizeEvent to next Flutter frame
* Added WxWindowCreateEvent
* Changed OpenGL constants to WebGL.DRAW_TRIANGLES notation
* Added all missing WxGLContext to run ThreeJS (three_js_dart) on it
* Added wxLoadRGBAFromResource to load the RGBA raw data from an asset or file
* Added WxImage.getRGBA()
* Added WxImage.isOK()
* Removed hacks due to issues in flutter_angle 0.4.1 on web

## 0.9.9

* Added wxLoadImageFromResource
* Change return type from WxImage.getData() to Uint8List
* Change return type from WxImage.getAlphaData() to Uint8List
* Enabled Textures in OpenGL code
* Numerous OpenGL bug fixes
* Documented the wxDart-Native-only WxImage.fromFile() constructor
* Corrected wxBITMAP_TYPE_XXX constants
* Corrected event type for repeated key down events

## 0.9.8

* Added WxGLCanvas and WxGLContext for OpenGL (ES) support on all platforms
* Added WxWindow.getChildCount() and WxWindow.getChild(index) as we don't have a GetChildren() accessor like in C++
* Added WxRealPoint for conveniance
* Corrected WxGraphicsPath.addCircle()

## 0.9.7

* Implemented control of focus behaviour (disable focus, child window focus)
* Updated function category documentation for the wxWindow class
* Added wxBitmapComboBox

## 0.9.6

* Allow a WxNativeWindow to generate key, mouse and focus events

## 0.9.5

* Corrected/added key up events
* Documented WxKeyEvent and key code constants

## 0.9.4

* Added WxNativeWindow to allow using native Flutter widgets in wxDart Flutter
* Doc updates

## 0.9.3

* Further work WxGraphicsContext
* Added linear and radial colour gradients and complex filled paths

## 0.9.2

* Further work on WxGraphicsBitmap and WxGraphicsContext
* Added WxGraphicsPath
* Added WxGraphicsContext clip, drawText, setFont, stokeLine and more
* Documentation updates for item containers
* Added lots of sample code to documentation

## 0.9.1

* Make wxDart Flutter menu items and windows given an ID of -1 create their own unique negative ID (align with wxDart Native/wxWidgets)
* Added sorting in WxListBox, WxComboBox and WxChoice in wxDart Flutter (align with wxDart Native/wxWidgets)
* Began implementation of wxGraphicsContext group of classes (modern 2D drawing API) which uses
* Documentation updates

## 0.9.0

* This is the first public release

