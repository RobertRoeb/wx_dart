## Overall design

wxDart consists of two separate libraries which offer the same API and can be used independently. 
* 'wxDart Flutter' uses the [Flutter](https://flutter.dev) libary as its backend and is written in pure Dart.
* 'wxDart Native' uses the [wxWidgets](https://wxwidgets.org) C++ GUI library as its backend using FFI calls.

Both wxDart Flutter and wxDart Native support
* Asynchronous code using the async await paradigm
* The Flutter assets system (used in many Dart libraries)
* An extensive list of controls from menus to animations
* WxDataViewCtrl to display and edit complex and large table and tree data
* Dark and light mode on all platforms
* Image formats including SVG, PNG and JPG
* Over 2000 Material icons built-in
* A path based modern 2D drawing API
* An OpenGL/WebGL based 3D canvas
* ThreeJS Dart through its own renderer using WxGLContext and WxGLCanvas

Only wxDart Flutter supports mobile devices (iOS and Android) and the web.

Note that both wxDart Native and wxDart Flutter support the main desktop architectures (Windows, macOS and Linux).
When using wxDart Flutter (this package), your applications will have an identical look and feel across all desktop
platforms (and on the web). With wxDart Native, your applications will have the native look and feel.

## Licence

'wxDart Flutter' is free software under the wxWindows licence. The wxWindows licence allows you to use 'wxDart Flutter' to create free and commercial software with no restrictions, but not to create a closed source competitor of the library itself.

'wxDart Native' is a not open source.

## Nomenclature

Overall, wxDart uses the exact API and nomenclature of the wxWidgets C++ GUI library. Since Dart demands that all class names start with a capital letter, all wxDart related classes use the capitalized prefix "Wx": 
* wxWindow becomes WxWindow
* wxBitmap becomes WxBitmap

All primitive types are matched to their respective equivalents in Dart:
* `wxString` is mapped to `String`
* `bool` remains `bool`
* `double` remains `double`
* all integer types are mapped to `int`
* `wxArrayInt` is mapped to `List<int>`
* `wxArrayString` is mapped to `List<String>`
* `wxClientDataObject` and `wxTreeItemData` are mapped to `dynamic`
* `wxVariant` is mapped to `dynamic` (not actually used yet)
* `wxVector<wxVariant>` is mapped to `List` (not actually used yet)
* `wxPointList` is mapped to `List<WxPoint>`

All constants and enums are mapped to "const int" with a non-capitalized prefix "wx". That - unfortunately - loses 
run-time type checking, but this cannot be avoided since wxWidgets uses enumns with concrete values.
* wxALIGN_RIGHT stays wxALIGN_RIGHT
* *wxBLUE becomes wxBLUE
* *wxBLUE_PEN becomes wxBLUE_PEN
* *wxNORMAL_FONT becomes wxNORMAL_FONT
* wxID_OK stays wxID_OK
* xxx::NO_IMAGE becomes wxNO_IMAGE
* wxNullCursor becomes null
* wxNullBitmap becomes null
* wxNullFont becomes null
* wxDefaultPosition and wxDefaultSize remain the same
* wxTheApp stays wxTheApp

Some factory creators have become global functions (this might change):
* wxStandardPaths::Get() becomes wxGetStandardPaths()
* wxRendererNative::Get() becomes wxGetRendererNative()
* wxSystemSettings::Get() becomes wxGetSystemSettings()

The wxWidgets logging functions have been mapped to
* wxLogError( String text );
* wxLogWarning( String text );
* wxLogMessage( String text );
* wxLogStatus( WxFrame frame, String text );
* setLogTarget( WxTextCtrl? textCtrl );

## WxPoint and WxSize are final (constant)

WxPoint and WxSize are implemented as const classes, so their values cannot be changed. This allows the
use of wxDefaultPosition and wxDefaultSize in constructors as it is widely done in wxWidgets. 

WxRect, however, is not a constant class and can be used and changed like its C++ counterpart.
A noteworthy difference - valid for all of wxDart - is that Dart does reference counting for
every instance of every class. Use WxRect.fromRect() to create a deep copy. 

## Derived wxWindow and wxSizer classes

wxDart Native and wxDart Flutter allow the use of 'generic' classes, i.e. classes written 
neither using the Flutter backend nor the C++ backend, but written in pure wxDart. 
The entire wxDataViewCtrl group of classes is inplemented in pure wxDart, including its
events, the data models, the header controls and the main control.

Such generic controls can then be used with both wxDart Flutter and wxDart Native - 
like it is done with wxDataViewCtrl.

Likewise, wxDart allows the creation of generic sizers by composing existing ones. The
WxTileSizer is a simple example of this and works with both wxDart Native and wxDart Flutter.

## Double buffering and background erasure

The wxWidgets C++ library was created many years ago when double buffering of window 
content to avoid flicker was an expensive operation. In particular the Windows port
still can show redraw flicker when not using a double buffering mechanism. 

wxDart hides this and provides built-in double buffering on all platforms (Windows, macOS,
Linux and Flutter). As a consequence of that, wxDart does not need a separate event or
function to clear the background (like it is done in the C++ library with the wxEraseEvent).

When drawing in an paint event handler, the background (i.e. the backing store) gets
automatically cleared to the window background. This may be a single colour or a more
complex background depending on the system, user setting, dark vs. light mode and the
particular window. You can overwrite this with e.g. pure white, a colour gradient or a 
bitmap in the paint handler.

## Advanced 2D and 3D drawing support

wxDart currently uses the original drawing API from the wxDC group of classes and it
uses the GDI backend under Windows which provides fastest drawing for simple geometries
and text.

wxWidgets has support for a modern path based drawing API from the wxGraphicsContext
group of classes. These are not available in wxDart yet. Once done, it will use the
Direct2D backend under Windows, CoreGraphics on MacOS, Cairo on Linux and Impellar
when using the Flutter backend.

wxDart supports OpenGL/WebGL based 3D drawing through its WxGLContext and WxGLCanvas 
classes and it supports ThreeJS Dart through its own renderer.

## Resources or assets

Flutter and wxWidgets have the notion of assets or resources, i.e. files that will be used
by the application during execution, such as image files or HTML text. Flutter loads assets
asynchronously - potentially from a web server when using the Web variant - while wxWidgets
loads them directly. wxDart either hides this difference on the level of controls or
uses callbacks (which might get called sooner or later). 

In wxDart, resource or asset files need to be in the lib/assets directory and the
Flutter build system needs to be informed about them by adding them to the project's
pubspec.yaml file. If README.md and flutter.svg need to be used, they have to be
declared in the pubspec.yaml file of your project like this:

```yaml
  # To add assets to your application, add an assets section, like this:
  assets:
     - lib/assets/README.md
     - lib/assets/flutter.svg
```

Such code is then needed to load the text file:

```dart
  void loadReadMe()
  {
    wxLoadStringFromResource( "README.md", (text) {
      // here is the text
      final readme = text;
    } );
  }
```

Note that for wxDart Native under OSX, the asset files need to be copied into the Resources 
directory of the app package. For Linux, they need to be installed as by the Linux standard.
Please refer to the 
[WxStandardPaths::GetResourcesDir()](https://docs.wxwidgets.org/3.2/classwx_standard_paths.html#a4faa3ebe2c42f101601ead08afd561b9)
which wxDart Native uses internally.

## Layout mechanism based on sizer class hierarchy

The system for laying out windows or controls on screen in wxWidgets is based on so called sizers deriving from the
wxSizer base class (see [wxSizer overview](https://docs.wxwidgets.org/3.3/overview_sizer.html)).
The most often used sizers are wxBoxSizer, wxFlexGridSizer and wxStaticBoxSizer. Flutter
has its own, very similar system where e.g. a [Row](https://api.flutter.dev/flutter/widgets/Row-class.html)
corresponds to a [wxBoxSizer(wxHORIZONTAL)](https://docs.wxwidgets.org/3.3/classwx_box_sizer.html) in wxWidgets.

Therefore, all wxDart sizer classes have been implemented to internally use the corresponding Flutter classes
in wxDart Flutter, whereas they use the C++ wxSizer classes in wxDart Native. Both wxDart Flutter and wxDart
Native lay out the controls automatically when the parent (e.g. a dialog) is shown on screen.

## Using sizers within a scrolled window

On the desktop, sizers are typically used to determine the size of dialog window, which usually
do not use scrolling. On mobile devices with limited space, but also on desktop interfaces, the
classical modal dialog is use less frequently now and vertical scrolling is used to layout
controls. 

Therefore, WxScrolledWindow in both wxDart Flutter and wxDart Native has been adapted to
re-size the scrolling area (virtual area) to the size the sizers ask for and enable vertical
scrolling automatically. This is slightly different from the semantics in the C++ library,
but very convenient.

## WxBitmapBundle

Like the wxWidgets C++ library, wxDart supports resolution independent bitmaps through the WxBitmapBundle
interface, i.e. a concrete WxBitmap can be constructed from e.g. two different PNG files (16x16 and 32x32)
or from a single SVG file (which gets scaled to whatever resolution is needed).

## WxBitmapBundle.fromMaterialIcon()

wxDart Flutter and wxDart Native have built-in support for more than 2000 scalable icons from 
Google's Material icon set. The data is included automatically in wxDart Native and is part of
wxDart Flutter as well.

## Dark/Light mode and accent colour

Both wxDart Native and wxDart Flutter support dark and light modes. Only wxDart Flutter additionally
supports setting an accent colour programmatically to use a specfic main branding colour in your application.
The default is light blue.

## Event classes

[C++ event handling overview](https://docs.wxwidgets.org/3.3/overview_events.html)

A key feature of the wxDart event handling system is that it allows you to override
a base class behaviour as the derived class's event handler will be called first.
If you want the base class to then execute its original code, you need to call
WxEvent.skip(). This is particularly important when overriding the WxSizeEvent
handler from the base class.

wxDart implements the "bind" interface of the wxWidgets event handling in both wxDart Native
and wxDart Flutter. You can bind any class deriving from WxEvtHandler to any event (even
if that class does not emit that event). If you want to react to the event from a WxButton,
you will typically call 
```dart
button.bindButtonEvent( (event)=>doSomething(), -1 );
```
You can also fully write out the event handler like this:

```dart
button.bindButtonEvent( onButton, -1 );

void onButton( WxCommandEvent event )
{
  // do something
}
```

System events like WxPaintEvent, WxKeyEvent and WxMouseEvent are only sent
to the actual window where they occur - which is why they don't need any ID.
It is very common to derive a new class if you handle these events

```dart
// in the constructor
bindPaintEvent( onPaint );

void onPaint( WxPaintEvent event )
{
  final dc = WxPaintDC( this );
  dc.drawLine(10,10,100,100);
}
```

Command events (all events deriving from WxCommandEvent) are propagated 
to their parent windows (if not intercepted before) until they finally reach a top-level window
such a s WxDialog or a WxFrame. 

One usage case for propagating events up to parent windows is that you might want to design
a dialog in an external GUI builder, then load the controls into
your dialog and react to events in that parent dialog. But propagation of command events to
parent windows is useful in many other situations.

When intercepting command events in parent windows, such as a WxDialog, a unique
id has to be assigned to the control and then used in the call to bind().

```dart
const int idTextCtrl = 300;

final dialog = WxDialog( parent, -1, "Dialog", size: WxSize( 500,600) );
final textctrl = WxTextCtrl( dialog, idTextCtrl );
dialog.bindTextEvent( (event) {
    // do something
},idTextCtrl);
```

If the event is intercepted in the control itself, then the default id of -1 is fine.

```dart
final textctrl = WxTextCtrl( parent, -1 );
textctrl.bindTextEvent( (event) {
    // do something
},-1);
```

Command events are typically sent from a control when the user e.g. clicked on a button,
entered text in a text field or chose an item in a tree control. 
Command events should are not be sent by controls when they are changed
programmatically. This includes those cases where the events are being sent in
the C++ library (wxNotebook::SetSelection() and wxTextCtrl::SetValue()) - these
two cases have been changed and corrected in wxDart Flutter and wxDart Native.




