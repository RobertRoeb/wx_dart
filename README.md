# wxDart

A cross-platform GUI library to build native desktop apps, web apps and mobile apps from a single source using the Dart programming language.

## Table of contents

* [Introduction](#wxdart-flutter-and-wxdart-native)
* [Screenshot](#screenshot)
* [Installation](#installation-of-wxdart-flutter)
* [Tutorial with samples](#tutorial-with-samples)
* [Licence](#licence)
* [Classes by Category](#classes-by-category)
    - [Core data classes](#core-data-classes)
    - [Window classes](#window-classes)
    - [Book controls](#book-controls)
    - [Windows for mobile interfaces](#windows-for-mobile-interfaces)
    - [Common dialogs](#common-dialogs)
    - [Misc classes](#misc-classes)
    - [Graphics classes](#graphics-classes)
    - [Control classes](#control-classes)
    - [Complex control classes](#complex-control-classes)
    - [OpenGL/WebGL classes](#opengl-and-webgl-classes)
    - [wxDataViewCtrl related classes](#wxdataviewctrl-related-classes)
    - [Layout classes](#layout-classes)
    - [Event classes](#event-classes)
* [Live web demo](#demo)
* [More screenshots](#screenshots)
* [Live tutorial apps](#web-app-tutorials)
* [Screencasts from desktops](#screencasts-from-the-demo)
* [Hello World](#hello-world)
* [Full Licence](#license-of-wxdart-flutter)

## wxDart Flutter and wxDart Native

wxDart consists of two separate libraries which offer the same API and can be used independently. 
* 'wxDart Flutter' uses the [Flutter](https://flutter.dev) libary as its backend and is written in pure Dart.
* 'wxDart Native' uses the [wxWidgets](https://wxwidgets.org) C++ GUI library as its backend using FFI calls.

Since version 0.9.11, both wxDart Flutter and wxDart Native support
* Asynchronous code using the [async await](https://dart.dev/libraries/async/async-await) paradigm
* The Flutter [assets](https://api.flutter.dev/flutter/services/AssetBundle-class.html) system (used in many Dart libraries)
* An extensive list of controls from [menus](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxMenuBar-class.html) to [animations](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxAnimationCtrl-class.html)
* [WxDataViewCtrl](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDataViewCtrl-class.html) to display and edit complex and large table and tree data
* [Dark and light](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxApp/setAppearance.html) mode on all platforms
* Image formats including [SVG](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxBitmapBundle/WxBitmapBundle.fromSVG.html), PNG and JPG
* Over 2000 [Material icons](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxBitmapBundle/WxBitmapBundle.fromMaterialIcon.html) built-in
* A path based modern [2D drawing](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxGraphicsContext-class.html) API
* An OpenGL ES/WebGL based [OpenGL canvas](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxGLCanvas-class.html).
* 3D scenes through its own [ThreeJS renderer](https://pub.dev/packages/three_js_wx_renderer) linking WxGLContext and WxGLCanvas to [ThreeJS Dart](https://pub.dev/packages/three_js)

Only wxDart Flutter supports mobile devices (iOS and Android) and the web.

Note that both wxDart Native and wxDart Flutter support the main desktop architectures (Windows, macOS and Linux).
When using wxDart Flutter (this package), your applications will have an identical look and feel across all desktop
platforms (and on the web). With wxDart Native, your applications will have the native look and feel.

wxDart aims to provide Dart bindings to the wxWidgets library very similar to the hugely popular
[wxPython](https://wxpython.org/) for Python, with additional support for mobile devices and web apps.

If you are coming from the Flutter world, consider wxDart a new toolkit based on the Flutter core (next to [Material UI](https://flutter.dev/docs/development/ui/widgets/material), [Cupertino UI](https://flutter.dev/docs/development/ui/widgets/cupertino), [MacOS UI](https://pub.dev/packages/macos_ui) or [Fluent UI](https://pub.dev/packages/fluent_ui)), but with a fully native twin brother library and a single code base for all of them.

## Screenshot

A screenshot showing the demo running side-by-side in a web browser (wxDart Flutter, in light mode)
and running natively on macOS Tahoe (wxDart Native, in dark mode). There are more screenshots
[below](#screenshots) and you can run the entire demo in the browser by clicking 
[here](https://wxdesigner-software.com/demo03).

![Web vs macOS](https://wxdesigner-software.com/resources/macOS_Web.png)

## Installation of wxDart Flutter

wxDart Flutter has been published as wx_dart on [pub.dev](https://pub.dev), the central repository for most Dart and
Flutter packages and pub.dev also hosts the documentation. Click
[here](https://pub.dev/packages/wx_dart) to go there.

To use wxDart Flutter, add wx_dart as a dependency in your pubspec.yaml file.
```console
flutter pub add wx_dart
```

Import the package into your Dart file:
```dart
import 'package:wx_dart/wx_dart.dart';
```
## Tutorial with samples

The demo app includes a number of samples that can be used as a tutorial. You can also have a look
at the samples directly in the [tutorial folder](https://github.com/RobertRoeb/wx_dart/tree/main/example/lib/assets/tut)
on GitHub.

You can see some of these tutorials live embedded into HTML 
[here](https://wxdesigner-software.com/tutorial01).

## Installation of wxDart Native

wxDart Native can be downloaded from [here](https://wxdesigner-software.com). It consists of the wxDart Native
library and the three bridge libraries (the Windows .dll, macOS .dylib and Linux .so) as
the interface to the respective platforms.

## Licence

'wxDart Flutter' is free software under the wxWindows licence. The wxWindows licence allows you to
use 'wxDart Flutter' to create free and commercial software with no restrictions, but not to create
a closed source competitor of the library itself. See the [Licence](#license-of-wxdart-flutter) in full.

'wxDart Native' is not open source.

## Classes by Category

wxDart uses the API from the wxWidgets library with only minimal adaptions to the Dart
langauge. 

Below you find a table of the main classes by category with links to both the documentation
of the Dart classes as well as the C++ classes which wxDart Native uses internally.

## Core data classes 

| Dart | C++ |
| ------------------ | ----------------- |
| [WxClass](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxClass-class.html) | Any C++ class |
| [WxObject](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxObject-class.html) | [wxObject](https://docs.wxwidgets.org/trunk/classwx_object.html) |
| [String](https://api.flutter.dev/flutter/dart-core/String-class.html) | [wxString](https://docs.wxwidgets.org/trunk/classwx_string.html) |
| [List](https://api.flutter.dev/flutter/dart-core/List-class.html) | [wxList](https://docs.wxwidgets.org/trunk/classwx_list_3_01_t_01_4.html) |
| [dynamic](https://dart.dev/language/type-system) | [wxVariant](https://docs.wxwidgets.org/trunk/classwx_variant.html) |
| [WxApp](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxApp-class.html) | [wxApp](https://docs.wxwidgets.org/trunk/classwx_app.html) |

## Window classes

| Dart | C++ |
| ------------------ | ----------------- |
| [WxWindow](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxWindow-class.html) | [wxWindow](https://docs.wxwidgets.org/trunk/classwx_window.html) |
| [WxPanel](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxPanel-class.html) | [wxPanel](https://docs.wxwidgets.org/trunk/classwx_panel.html) |
| [WxScrolledWindow](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxScrolledWindow-class.html) | [wxScrolledWindow](https://docs.wxwidgets.org/trunk/classwx_scrolled.html) |
| [WxSplitterWindow](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxSplitterWindow-class.html) | [wxSplitterWindow](https://docs.wxwidgets.org/trunk/classwx_splitter_window.html) |
| [WxTopLevelWindow](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxTopLevelWindow-class.html) | [wxTopLevelWindow](https://docs.wxwidgets.org/trunk/classwx_top_level_window.html) |
| [WxDialog](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDialog-class.html) | [wxDialog](https://docs.wxwidgets.org/trunk/classwx_dialog.html) |
| [WxFrame](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxFrame-class.html) | [wxFrame](https://docs.wxwidgets.org/trunk/classwx_frame.html) |

## Book controls

| Dart | C++ |
| ------------------ | ----------------- |
| [WxNotebook](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxNotebook-class.html) | [wxNotebook](https://docs.wxwidgets.org/trunk/classwx_notebook.html) |
| [WxTreebook](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxTreebook-class.html) | [wxTreebook](https://docs.wxwidgets.org/trunk/classwx_treebook.html) |
| [WxDataViewBook](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDataViewBook-class.html) | Only available in wxDart |

## Windows for mobile interfaces

| Dart | C++ |
| ------------------ | ----------------- |
| [WxAdaptiveFrame](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxAdaptiveFrame-class.html) | Only available in wxDart |
| [WxAppBar](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxAppBar-class.html) | Only available in wxDart |
| [WxNavigationCtrl](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxNavigationCtrl-class.html) | Only available in wxDart |

## Common dialogs

| Dart | C++ |
| ------------------ | ----------------- |
| [WxMessageDialog](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxMessageDialog-class.html) | [wxMessageDialog](https://docs.wxwidgets.org/trunk/classwx_message_dialog.html) |
| [WxFileDialog](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxFileDialog-class.html) | [wxFileDialog](https://docs.wxwidgets.org/trunk/classwx_file_dialog.html) |
| [WxDirDialog](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDirDialog-class.html) | [wxDirDialog](https://docs.wxwidgets.org/trunk/classwx_dir_dialog.html) |

## Menu classes, status bar and tool bar

| Dart | C++ |
| ------------------ | ----------------- |
| [WxMenuBar](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxMenuBar-class.html) | [wxMenuBar](https://docs.wxwidgets.org/trunk/classwx_menu_bar.html) |
| [WxMenu](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxMenu-class.html) | [wxMenu](https://docs.wxwidgets.org/trunk/classwx_menu.html) |
| [WxMenuItem](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxMenuItem-class.html) | [wxMenuItem](https://docs.wxwidgets.org/trunk/classwx_menu_item.html) |
| [WxToolBar](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxToolBar-class.html) | [wxToolBar](https://docs.wxwidgets.org/trunk/classwx_tool_bar.html) |
| [WxStatusBar](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxStatusBar-class.html) | [wxStatusBar](https://docs.wxwidgets.org/trunk/classwx_status_bar.html) |

## Misc classes 

| Dart | C++ |
| ------------------ | ----------------- |
| [WxUIAnimation](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxUIAnimation-class.html) | Only available in wxDart |
| [WxTimer](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxTimer-class.html) | [wxTimer](https://docs.wxwidgets.org/trunk/classwx_timer.html) |
| [WxStopWatch](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxStopWatch-class.html) | [wxStopWatch](https://docs.wxwidgets.org/trunk/classwx_stop_watch.html) |
| [WxStandardPaths](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxStandardPaths-class.html) | [wxStandardPaths](https://docs.wxwidgets.org/trunk/classwx_standard_paths.html) |
| [WxSystemSettings](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxSystemSettings-class.html) | [wxSystemSettings](https://docs.wxwidgets.org/trunk/classwx_system_settings.html) |

## Graphics classes

[wxDC overview](https://docs.wxwidgets.org/trunk/overview_dc.html)

| Dart | C++ |
| ------------------ | ----------------- |
| [WxPoint](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxPoint-class.html) | [wxPoint](https://docs.wxwidgets.org/trunk/classwx_point.html) |
| [WxRealPoint](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxRealPoint-class.html) | [wxRealPoint](https://docs.wxwidgets.org/trunk/classwx_real_point.html) |
| [WxSize](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxSize-class.html) | [wxSize](https://docs.wxwidgets.org/trunk/classwx_size.html) |
| [WxRect](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxRect-class.html) | [wxRect](https://docs.wxwidgets.org/trunk/classwx_rect.html) |
| [WxGraphicsContext](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxGraphicsContext-class.html) | [wxGraphicsContext](https://docs.wxwidgets.org/trunk/classwx_graphics_context.html) |
| [WxGraphicsPath](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxGraphicsPath-class.html) | [wxGraphicsPath](https://docs.wxwidgets.org/trunk/classwx_graphics_path.html) |
| [WxGraphicsBitmap](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxGraphicsBitmap-class.html) | [wxGraphicsBitmap](https://docs.wxwidgets.org/trunk/classwx_graphics_bitmap.html) |
| [WxReadOnlyDC](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxReadOnlyDC-class.html) | [wxReadOnlyDC](https://docs.wxwidgets.org/trunk/classwx_read_only_dc.html) |
| [WxDC](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDC-class.html) | [wxDC](https://docs.wxwidgets.org/trunk/classwx_dc.html) |
| [WxPaintDC](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxPaintDC-class.html) | [wxPaintDC](https://docs.wxwidgets.org/trunk/classwx_paint_dc.html) |
| [WxMemoryDC](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxMemoryDC-class.html) | [wxMemoryDC](https://docs.wxwidgets.org/trunk/classwx_memory_dc.html) |
| [WxInfoDC](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxInfoDC-class.html) | [wxInfoDC](https://docs.wxwidgets.org/trunk/classwx_info_dc.html) |
| [WxPaintEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxPaintEvent-class.html) | [wxPaintEvent](https://docs.wxwidgets.org/trunk/classwx_paint_event.html) |
| [WxColour](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxColour-class.html) | [wxColour](https://docs.wxwidgets.org/trunk/classwx_colour.html) |
| [WxCursor](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxCursor-class.html) | [wxCursor](https://docs.wxwidgets.org/trunk/classwx_cursor.html) |
| [WxFont](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxFont-class.html) | [wxFont](https://docs.wxwidgets.org/trunk/classwx_font.html) |
| [WxPen](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxPen-class.html) | [wxPen](https://docs.wxwidgets.org/trunk/classwx_pen.html) |
| [WxBrush](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxBrush-class.html) | [wxBrush](https://docs.wxwidgets.org/trunk/classwx_brush.html) |
| [WxBitmap](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxBitmap-class.html) | [wxBitmap](https://docs.wxwidgets.org/trunk/classwx_bitmap.html) |
| [WxBitmapBundle](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxBitmapBundle-class.html) | [wxBitmapBundle](https://docs.wxwidgets.org/trunk/classwx_bitmap_bundle.html) |
| [WxImage](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxImage-class.html) | [wxImage](https://docs.wxwidgets.org/trunk/classwx_image.html) |
| [WxRendererNative](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxRendererNative-class.html) | [wxRendererNative](https://docs.wxwidgets.org/trunk/classwx_renderer_native.html) |

## Control classes

| Dart | C++ |
| ------------------ | ----------------- |
| [WxControl](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxControl-class.html) | [wxControl](https://docs.wxwidgets.org/trunk/classwx_control.html) |
| [WxStaticLine](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxStaticLine-class.html) | [wxStaticLine](https://docs.wxwidgets.org/trunk/classwx_static_line.html) |
| [WxStaticBox](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxStaticBox-class.html) | [wxStaticBox](https://docs.wxwidgets.org/trunk/classwx_static_box.html) |
| [WxStaticText](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxStaticText-class.html) | [wxStaticText](https://docs.wxwidgets.org/trunk/classwx_static_text.html) |
| [WxStaticBitmap](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxStaticBitmap-class.html) | [wxStaticBitmap](https://docs.wxwidgets.org/trunk/classwx_static_bitmap.html) |
| [WxButton](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxButton-class.html) | [wxButton](https://docs.wxwidgets.org/trunk/classwx_button.html) |
| [WxBitmapButton](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxBitmapButton-class.html) | [wxBitmapButton](https://docs.wxwidgets.org/trunk/classwx_bitmap_button.html) |
| [WxToggleButton](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxToggleButton-class.html) | [wxToggleButton](https://docs.wxwidgets.org/trunk/classwx_toggle_button.html) |
| [WxAnimationCtrl](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxAnimationCtrl-class.html) | [wxAnimationCtrl](https://docs.wxwidgets.org/trunk/classwx_animation_ctrl.html) |
| [WxCheckBox](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxCheckBox-class.html) | [wxCheckBox](https://docs.wxwidgets.org/trunk/classwx_check_box.html) |
| [WxTextCtrl](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxTextCtrl-class.html) | [wxTextCtrl](https://docs.wxwidgets.org/trunk/classwx_text_ctrl.html) |
| [WxChoice](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxChoice-class.html) | [wxChoice](https://docs.wxwidgets.org/trunk/classwx_choice.html) |
| [WxRadioButton](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxRadioButton-class.html) | [wxRadioButton](https://docs.wxwidgets.org/trunk/classwx_radio_button.html) |
| [WxRadioBox](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxRadioBox-class.html) | [wxRadioBox](https://docs.wxwidgets.org/trunk/classwx_radio_box.html) |
| [WxComboBox](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxComboBox-class.html) | [wxComboBox](https://docs.wxwidgets.org/trunk/classwx_combo_box.html) |
| [WxBitmapComboBox](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxBitmapComboBox-class.html) | [wxBitmapComboBox](https://docs.wxwidgets.org/trunk/classwx_bitmap_combo_box.html) |
| [WxListBox](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxListBox-class.html) | [wxListBox](https://docs.wxwidgets.org/trunk/classwx_list_box.html) |
| [WxSlider](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxSlider-class.html) | [wxSlider](https://docs.wxwidgets.org/trunk/classwx_slider.html) |
| [WxGauge](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxGauge-class.html) | [wxGauge](https://docs.wxwidgets.org/trunk/classwx_gauge.html) |
| [WxSpinCtrl](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxSpinCtrl-class.html) | [wxSpinCtrl](https://docs.wxwidgets.org/trunk/classwx_spin_ctrl.html) |
| [WxSpinCtrlDouble](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxSpinCtrlDouble-class.html) | [wxSpinCtrlDouble](https://docs.wxwidgets.org/trunk/classwx_spin_ctrl_double.html) |
| [WxHyperlinkCtrl](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxHyperlinkCtrl-class.html) | [wxHyperlinkCtrl](https://docs.wxwidgets.org/trunk/classwx_hyperlink_ctrl.html) |

## OpenGL and WebGL classes

| Dart | C++ |
| ------------------ | ----------------- |
| [WxGLCanvas](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxGLCanvas-class.html) | [wxGLCanvas](https://docs.wxwidgets.org/trunk/classwx_g_l_canvas.html) |
| [WxGLContext](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxGLContext-class.html) | [wxGLContext](https://docs.wxwidgets.org/trunk/classwx_g_l_context.html) |

## Complex control classes

| Dart | C++ |
| ------------------ | ----------------- |
| [WxTreeCtrl](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxTreeCtrl-class.html) | [wxTreeCtrl](https://docs.wxwidgets.org/trunk/classwx_tree_ctrl.html) |
| [WxHeaderCtrl](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxHeaderCtrl-class.html) | [wxHeaderCtrl](https://docs.wxwidgets.org/trunk/classwx_header_ctrl.html) |
| [WxHtmlWindow](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxHtmlWindow-class.html) | [wxHtmlWindow](https://docs.wxwidgets.org/trunk/classwx_html_window.html) |

## wxDataViewCtrl related classes

| Dart | C++ |
| ------------------ | ----------------- |
| [WxDataViewCtrl](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDataViewCtrl-class.html) | [wxDataViewCtrl](https://docs.wxwidgets.org/trunk/classwx_data_view_ctrl.html) |
| [WxDataViewModel](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDataViewModel-class.html) | [wxDataViewModel](https://docs.wxwidgets.org/trunk/classwx_data_view_model.html) |
| [WxDataViewModelNotifier](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDataViewModelNotifier-class.html) | [wxDataViewModelNotifier](https://docs.wxwidgets.org/trunk/classwx_data_view_model_notifier.html) |
| [WxDataViewIndexListModel](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDataViewIndexListModel-class.html) | [wxDataViewIndexListModel](https://docs.wxwidgets.org/trunk/classwx_data_view_index_list_model.html) |
| [WxDataViewVirtualListModel](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDataViewVirtualListModel-class.html) | [wxDataViewVirtualListModel](https://docs.wxwidgets.org/trunk/classwx_data_view_virtual_list_model.html) |
| [WxDataViewColumn](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDataViewColumn-class.html) | [wxDataViewColumn](https://docs.wxwidgets.org/trunk/classwx_data_view_Column.html) |

wxDataViewCtrl Renderers

| Dart | C++ |
| ------------------ | ----------------- |
| [WxDataViewRenderer](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDataViewRenderer-class.html) | [wxDataViewRenderer](https://docs.wxwidgets.org/trunk/classwx_data_view_renderer.html) |
| [WxDataViewTextRenderer](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDataViewTextRenderer-class.html) | [wxDataViewTextRenderer](https://docs.wxwidgets.org/trunk/classwx_data_view_text_renderer.html) |
| [WxDataViewChoiceRenderer](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDataViewChoiceRenderer-class.html) | [wxDataViewChoiceRenderer](https://docs.wxwidgets.org/trunk/classwx_data_view_choice_renderer.html) |
| [WxDataViewBitmapRenderer](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDataViewBitmapRenderer-class.html) | [wxDataViewBitmapRenderer](https://docs.wxwidgets.org/trunk/classwx_data_view_bitmap_renderer.html) |
| [WxDataViewProgressRenderer](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDataViewProgressRenderer-class.html) | [wxDataViewProgressRenderer](https://docs.wxwidgets.org/trunk/classwx_data_view_progress_renderer.html) |
| [WxDataViewToggleRenderer](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDataViewToggleRenderer-class.html) | [wxDataViewToggleRenderer](https://docs.wxwidgets.org/trunk/classwx_data_view_toggle_renderer.html) |
| [WxDataViewTileRenderer](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDataViewTileRenderer-class.html) | Only available in wxDart |

Predefined model and controls for tabular data

| Dart | C++ |
| ------------------ | ----------------- |
| [WxDataViewListStore](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDataViewListStore-class.html) | [wxDataViewListStore](https://docs.wxwidgets.org/trunk/classwx_data_view_list_store.html) |
| [WxDataViewListCtrl](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDataViewListCtrl-class.html) | [wxDataViewListCtrl](https://docs.wxwidgets.org/trunk/classwx_data_view_list_ctrl.html) |
| [WxDataViewTileListCtrl](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDataViewTileListCtrl-class.html) | Only available in wxDart |

Predefined models and controls for tree data

| Dart | C++ |
| ------------------ | ----------------- |
| [WxDataViewTreeStore](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDataViewTreeStore-class.html) | [wxDataViewTreeStore](https://docs.wxwidgets.org/trunk/classwx_data_view_list_store.html) |
| [WxDataViewTreeCtrl](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDataViewTreeCtrl-class.html) | [wxDataViewTreeCtrl](https://docs.wxwidgets.org/trunk/classwx_data_view_list_ctrl.html) |
| [WxDataViewBookStore](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDataViewBookStore-class.html) | Only available in wxDart |
| [WxDataViewChapterRenderer](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDataViewChapterRenderer-class.html) | Only available in wxDart |
| [WxDataViewChapterCtrl](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDataViewChapterCtrl-class.html) | Only available in wxDart |

## Layout classes

[WxSizer overview](https://docs.wxwidgets.org/trunk/overview_sizer.html)

| Dart | C++ |
| ------------------ | ----------------- |
| [WxSizer](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxSizer-class.html) | [wxSizer](https://docs.wxwidgets.org/trunk/classwx_sizer.html) |
| [WxSizerItem](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxSizerItem-class.html) | [wxSizerItem](https://docs.wxwidgets.org/trunk/classwx_sizer_item.html) |
| [WxBoxSizer](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxBoxSizer-class.html) | [wxBoxSizer](https://docs.wxwidgets.org/trunk/classwx_box_sizer.html) |
| [WxStaticBoxSizer](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxStaticBoxSizer-class.html) | [wxStaticBoxSizer](https://docs.wxwidgets.org/trunk/classwx_static_box_sizer.html) |
| [WxFlexGridSizer](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxFlexGridSizer-class.html) | [wxFlexGridSizer](https://docs.wxwidgets.org/trunk/classwx_flex_grid_sizer.html) |
| [WxWrapSizer](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxWrapSizer-class.html) | [wxWrapSizer](https://docs.wxwidgets.org/trunk/classwx_wrap_sizer.html) |
| [WxTileSizer](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxTileSizer-class.html) | Only available in wxDart |

## Event classes

[Event handling overview](https://docs.wxwidgets.org/trunk/overview_events.html)

| Dart | C++ |
| ------------------ | ----------------- |
| [WxEvtHandler](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxEvtHandler-class.html) | [wxEvtHandler](https://docs.wxwidgets.org/trunk/classwx_evt_handler.html) |
| [WxEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxEvent-class.html) | [wxEvent](https://docs.wxwidgets.org/trunk/classwx_event.html) |
| [WxEventTableEntry](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxEventTableEntry-class.html) | Internal implementation detail. |
| [WxCommandEventTableEntry](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxCommandEventTableEntry-class.html) | Internal implementation detail. |

System events (deriving from WxEvent directly)

| Dart | C++ |
| ------------------ | ----------------- |
| [WxEvtHandler](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxEvtHandler-class.html) | [wxEvtHandler](https://docs.wxwidgets.org/trunk/classwx_evt_handler.html) |
| [WxPaintEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxPaintEvent-class.html) | [wxPaintEvent](https://docs.wxwidgets.org/trunk/classwx_paint_event.html) |
| [WxMouseEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxMouseEvent-class.html) | [wxMouseEvent](https://docs.wxwidgets.org/trunk/classwx_mouse_event.html) |
| [WxKeyEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxKeyEvent-class.html) | [wxKeyEvent](https://docs.wxwidgets.org/trunk/classwx_key_event.html) |
| [WxSizeEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxSizeEvent-class.html) | [wxSizeEvent](https://docs.wxwidgets.org/trunk/classwx_size_event.html) |
| [WxShowEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxShowEvent-class.html) | [wxShowEvent](https://docs.wxwidgets.org/trunk/classwx_show_event.html) |
| [WxIdleEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxIdleEvent-class.html) | [wxIdleEvent](https://docs.wxwidgets.org/trunk/classwx_idle_event.html) |
| [WxTimerEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxTimerEvent-class.html) | [wxTimerEvent](https://docs.wxwidgets.org/trunk/classwx_timer_event.html) |
| [WxCloseEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxCloseEvent-class.html) | [wxCloseEvent](https://docs.wxwidgets.org/trunk/classwx_close_event.html) |
| [WxFocusEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxFocusEvent-class.html) | [wxFocusEvent](https://docs.wxwidgets.org/trunk/classwx_focus_event.html) |
| [WxScrollWinEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxScrollWinEvent-class.html) | [wxScrollWinEvent](https://docs.wxwidgets.org/trunk/classwx_scroll_win_event.html) |
| [wxActivateEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/wxActivateEvent-class.html) | [wxActivateEvent](https://docs.wxwidgets.org/trunk/classwx_activate_event.html) |
| [WxDPIChangedEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDPIChangedEvent-class.html) | [wxDPIChangedEvent](https://docs.wxwidgets.org/trunk/classwx_dpi_changed_event.html) |
| [WxSysColourChangedEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxSysColourChangedEvent-class.html) | [wxSysColourChangedEvent](https://docs.wxwidgets.org/trunk/classwx_sys_colour_changed_event.html) |
| [WxInitDialogEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxInitDialogEvent-class.html) | [wxInitDialogEvent](https://docs.wxwidgets.org/trunk/classwx_init_dialog_event.html) |
| [WxDialogValidateEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDialogValidateEvent-class.html) | Only available in wxDart |
| [WxMenuEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxMenuEvent-class.html) | [wxMenuEvent](https://docs.wxwidgets.org/trunk/classwx_menu_event.html) |

Command events (deriving from WxCommandEvent)

| Dart | C++ |
| ------------------ | ----------------- |
| [WxCommandEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxCommandEvent-class.html) | [wxCommandEvent](https://docs.wxwidgets.org/trunk/classwx_command_event.html) |
| [WxWindowCreateEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxWindowCreateEvent-class.html) | [wxWindowCreateEvent](https://docs.wxwidgets.org/trunk/classwx_window_create_event.html) |
| [WxUpdateUIEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxUpdateUIEvent-class.html) | [wxUpdateUIEvent](https://docs.wxwidgets.org/trunk/classwx_update_ui_event.html) |
| [WxNotifyEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxNotifyEvent-class.html) | [wxNotifyEvent](https://docs.wxwidgets.org/trunk/classwx_notify_event.html) |
| [WxNotebookEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxNotebookEvent-class.html) | [wxNotebookEvent](https://docs.wxwidgets.org/trunk/classwx_book_ctrl_event.html) |
| [WxTreeEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxTreeEvent-class.html) | [wxTreeEvent](https://docs.wxwidgets.org/trunk/classwx_command_event.html) |
| [WxSplitterEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxSplitterEvent-class.html) | [wxSplitterEvent](https://docs.wxwidgets.org/trunk/classwx_splitter_event.html) |
| [WxDataViewEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDataViewEvent-class.html) | [wxDataViewEvent](https://docs.wxwidgets.org/trunk/classwx_data_view_event.html) |
| [WxHtmlEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxHtmlEvent-class.html) | [wxHtmlEvent](https://docs.wxwidgets.org/trunk/classwx_html_event.html) |

## Demo

Here is a link to the [demo app](https://wxdesigner-software.com/demo03) (written in wxDart) running in your browser.<BR>

## Screenshots

Several pages from the demo running on the iPhone emulator:
![iPhone](https://wxdesigner-software.com/resources/iPhone17.png)

The demo running on Windows 11 in light mode
![Windows 11 light mode](https://wxdesigner-software.com/resources/Windows11Small.png)

The demo running on Windows 11 in dark mode
![Windows 11 dark mode](https://wxdesigner-software.com/resources/Windows11DarkSmall.png)

The demo running on Linux Ubuntu in light and dark mode
![Linux Ubuntu](https://wxdesigner-software.com/resources/UbuntuLightDarkSmall.png)

For completeness: the demo running in the Android emulator
![Android](https://wxdesigner-software.com/resources/Android.png)

wxDart Native and wxDart Flutter showing a WxDataViewListCtrl on the desktop
![Native vs Flutter](https://wxdesigner-software.com/resources/NativeVsFlutter.png)

## Web app tutorials

Here are samples from the [tutorials](https://wxdesigner-software.com/tutorial01) that you can run in the window.<BR>

## Screencasts from the demo

Here are [screencasts](https://wxdesigner-software.com/screenshots) from the demo running on different platforms.<BR>

## Hello world
```dart
import 'package:wx_dart/wx_dart.dart';

// wxDart uses IDs to identify menu items, toolbar items, and sometimes controls.
const idAbout = 100;

// Every app needs a WxFrame as a main window.
class MyFrame extends WxFrame {
  MyFrame( WxFrame? parent) : super( parent, -1, "Hello World", size: WxSize(900, 700) ) 
  {
    // Create a menu bar
    final menubar = WxMenuBar();

    // Create a menu 
    final filemenu = WxMenu();
    // Create a menu item with short cuts and help text
    filemenu.appendItem( idAbout, "About\tAlt-A", help: "About Hello World" );
    filemenu.appendSeparator();
    filemenu.appendItem( wxID_EXIT, "Quit app\tCtrl-Q", help: "Run, baby, run!" );
    // Attach menu to menu bar
    menubar.append(filemenu, "File");

    // Attach menu bar to this frame
    setMenuBar(menubar);

    // Create status bar at the bottom
    createStatusBar();
    setStatusText( "Welcome to wxDart" );

    // Bind this function to idAbout ID menu item
    bindMenuEvent((_) {
      // Show a message dialog
      final dialog = WxMessageDialog( this, "Welcome to Hello World", caption: "wxDart" );
      dialog.showModal(null);
    }, idAbout );

    // Bind this function to wxID_EXIT 
    bindMenuEvent( (_) => close(false), wxID_EXIT );

    // Someone requested to close. 
    bindCloseWindowEvent( (event) { 
      // You didn't save your data? Veto!
      // event.veto( true ); 
      // return

      // otherwise, go ahead and quit
      destroy();
    } );
  }
}

// Every app needs an instance of WxApp
class MyApp extends WxApp {
  MyApp();

  @override
  bool onInit() {
    // create and show main window
    WxFrame myFrame = MyFrame( null );
    myFrame.show();

    return true;
  }
}

void main()
{
  final myApp = MyApp();
  myApp.run();
  myApp.dispose();
}
```

## License of wxDart Flutter
```
wxWindows Library Licence, Version 3.1
                ======================================

  Copyright (c) 1998-2026 Julian Smart, Robert Roebling et al

  Everyone is permitted to copy and distribute verbatim copies
  of this licence document, but changing it is not allowed.

                       WXWINDOWS LIBRARY LICENCE
     TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

  This library is free software; you can redistribute it and/or modify it
  under the terms of the GNU Library General Public Licence as published by
  the Free Software Foundation; either version 2 of the Licence, or (at
  your option) any later version.

  This library is distributed in the hope that it will be useful, but
  WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Library
  General Public Licence for more details.

  You should have received a copy of the GNU Library General Public Licence
  along with this software, usually in a file named COPYING.LIB.  If not,
  write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
  Boston, MA 02110-1301 USA.

  EXCEPTION NOTICE

  1. As a special exception, the copyright holders of this library give
  permission for additional uses of the text contained in this release of
  the library as licenced under the wxWindows Library Licence, applying
  either version 3.1 of the Licence, or (at your option) any later version of
  the Licence as published by the copyright holders of version
  3.1 of the Licence document.

  2. The exception is that you may use, copy, link, modify and distribute
  under your own terms, binary object code versions of works based
  on the Library.

  3. If you copy code from files distributed under the terms of the GNU
  General Public Licence or the GNU Library General Public Licence into a
  copy of this library, as this licence permits, the exception does not
  apply to the code that you add in this way.  To avoid misleading anyone as
  to the status of such modified files, you must delete this exception
  notice from such code and/or adjust the licensing conditions notice
  accordingly.

  4. If you write modifications of your own for this library, it is your
  choice whether to permit this exception to apply to your modifications.
  If you do not wish that, you must delete the exception notice from such
  code and/or adjust the licensing conditions notice accordingly.
```
