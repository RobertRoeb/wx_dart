# wxDart

Build web apps, mobile apps and native desktop apps from a single source using the Dart programming language.

## Table of contents

* [Introduction](#wxdart-flutter-and-wxdart-native)
* [Fireworks web app example](#web-app-example)
* [Installation](#installation-of-wxdart-flutter)
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
    - [wxDataViewCtrl related classes](#wxdataviewctrl-related-classes)
    - [Layout classes](#layout-classes)
    - [Event classes](#event-classes)
* [Live web demo](#demo)
* [Live tutorial apps](#web-app-tutorials)
* [Screenshots (screencasts from desktops)](#screencasts-from-the-demo)
* [Hello World](#hello-world)
* [Who is doing all this?](#who)
* [Full Licence](#license-of-wxdart-flutter)
* [Design overview](#design-overview)
    - [Nomenclature](#nomenclature)
    - [WxPoint and WxSize](#wxpoint-and-wxsize)
    - [Deriving from wxWindow and wxSizer](#deriving-from-wxwindow-and-wxsizer)
    - [Double buffering and background erasure](#double-buffering-and-background-erasure)
    - [2D and 3D drawing support](#2d-and-3d-drawing-support)
    - [Modal dialogs](#modal-dialogs)
    - [Resources or assets](#resources-or-assets)
    - [Layout mechanism](#layout-mechanism)
    - [WxBitmapBundle](#wxbitmapbundle)
    - [Material icons](#material-icons)
    - [Dark and Light mode and accent colour](#dark-and-light-mode-and-accent-colour)
    - [Event handling](#event-handling)

## wxDart Flutter and wxDart Native

wxDart consists of two separate libraries which offer the same API and can be used independently. 
* 'wxDart Flutter' uses the [Flutter](https://flutter.dev) libary as its backend and is written in pure Dart.
* 'wxDart Native' uses the [wxWidgets](https://wxwidgets.org) C++ GUI library as its backend using FFI calls.

Note that both wxDart Native and wxDart Flutter support the main desktop architectures (Windows, macOS and Linux).
When using wxDart Flutter (this package), your applications will have an identical look and feel across all desktop
platforms (and on the web). With wxDart Native, your applications will have the native look and feel.

wxDart aims to provide Dart bindings to the wxWidgets library very similar to the hugely popular
[wxPython](https://wxpython.org/) for Python, adding support for mobile apps and web apps.

If you are coming from the Flutter world, consider wxDart a new toolkit based on the Flutter core (next to [Material UI](https://flutter.dev/docs/development/ui/widgets/material), [Cupertino UI](https://flutter.dev/docs/development/ui/widgets/cupertino), [MacOS UI](https://pub.dev/packages/macos_ui) or [Fluent UI](https://pub.dev/packages/fluent_ui)), but with a fully native twin brother library and a single code base for all of them.


## Installation of wxDart Flutter
To use wxDart Flutter, add wx_dart as a dependency in your pubspec.yaml file.
```console
flutter pub add wx_dart
```

Import the package into your Dart file:
```dart
import 'package:wx_dart/wx_dart.dart';
```

## Installation of wxDart Native

wxDart Native can be downloaded from [here](https://wxdesigner-software.com). It consists of the wxDart Native
library and the three bridge libraries (the Windows .dll, macOS .dynlib and Linux .so) as
the interface to the respective platforms.

## Licence

'wxDart Flutter' is free software under the wxWindows licence. The wxWindows licence allows you to
use 'wxDart Flutter' to create free and commercial software with no restrictions, but not to create
a closed source competitor of the library itself.

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
| [WxObject](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxObject-class.html) | [wxObject](https://docs.wxwidgets.org/3.3/classwx_object.html) |
| [String](https://api.flutter.dev/flutter/dart-core/String-class.html) | [wxString](https://docs.wxwidgets.org/3.3/classwx_string.html) |
| [List](https://api.flutter.dev/flutter/dart-core/List-class.html) | [wxList](https://docs.wxwidgets.org/3.3/classwx_list_3_01_t_01_4.html) |
| [dynamic](https://dart.dev/language/type-system) | [wxVariant](https://docs.wxwidgets.org/3.3/classwx_variant.html) |
| [WxApp](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxApp-class.html) | [wxApp](https://docs.wxwidgets.org/3.3/classwx_app.html) |

## Window classes

| Dart | C++ |
| ------------------ | ----------------- |
| [WxWindow](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxWindow-class.html) | [wxWindow](https://docs.wxwidgets.org/3.3/classwx_window.html) |
| [WxPanel](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxPanel-class.html) | [wxPanel](https://docs.wxwidgets.org/3.3/classwx_panel.html) |
| [WxScrolledWindow](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxScrolledWindow-class.html) | [wxScrolledWindow](https://docs.wxwidgets.org/3.3/classwx_scrolled.html) |
| [WxSplitterWindow](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxSplitterWindow-class.html) | [wxSplitterWindow](https://docs.wxwidgets.org/3.3/classwx_splitter_window.html) |
| [WxTopLevelWindow](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxTopLevelWindow-class.html) | [wxTopLevelWindow](https://docs.wxwidgets.org/3.3/classwx_top_level_window.html) |
| [WxDialog](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDialog-class.html) | [wxDialog](https://docs.wxwidgets.org/3.3/classwx_dialog.html) |
| [WxFrame](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxFrame-class.html) | [wxFrame](https://docs.wxwidgets.org/3.3/classwx_frame.html) |

## Book controls

| Dart | C++ |
| ------------------ | ----------------- |
| [WxNotebook](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxNotebook-class.html) | [wxNotebook](https://docs.wxwidgets.org/3.3/classwx_notebook.html) |
| [WxTreebook](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxTreebook-class.html) | [wxTreebook](https://docs.wxwidgets.org/3.3/classwx_treebook.html) |
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
| [WxMessageDialog](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxMessageDialog-class.html) | [wxMessageDialog](https://docs.wxwidgets.org/3.3/classwx_message_dialog.html) |
| [WxFileDialog](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxFileDialog-class.html) | [wxFileDialog](https://docs.wxwidgets.org/3.3/classwx_file_dialog.html) |
| [WxDirDialog](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDirDialog-class.html) | [wxDirDialog](https://docs.wxwidgets.org/3.3/classwx_dir_dialog.html) |

## Menu classes, status bar and tool bar

| Dart | C++ |
| ------------------ | ----------------- |
| [WxMenuBar](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxMenuBar-class.html) | [wxMenuBar](https://docs.wxwidgets.org/3.3/classwx_menu_bar.html) |
| [WxMenu](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxMenu-class.html) | [wxMenu](https://docs.wxwidgets.org/3.3/classwx_menu.html) |
| [WxMenuItem](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxMenuItem-class.html) | [wxMenuItem](https://docs.wxwidgets.org/3.3/classwx_menu_item.html) |
| [WxToolBar](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxToolBar-class.html) | [wxToolBar](https://docs.wxwidgets.org/3.3/classwx_tool_bar.html) |
| [WxStatusBar](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxStatusBar-class.html) | [wxStatusBar](https://docs.wxwidgets.org/3.3/classwx_status_bar.html) |

## Misc classes 

| Dart | C++ |
| ------------------ | ----------------- |
| [WxUIAnimation](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxUIAnimation-class.html) | Only available in wxDart |
| [WxTimer](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxTimer-class.html) | [wxTimer](https://docs.wxwidgets.org/3.3/classwx_timer.html) |
| [WxStopWatch](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxStopWatch-class.html) | [wxStopWatch](https://docs.wxwidgets.org/3.3/classwx_stop_watch.html) |
| [WxStandardPaths](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxStandardPaths-class.html) | [wxStandardPaths](https://docs.wxwidgets.org/3.3/classwx_standard_paths.html) |
| [WxSystemSettings](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxSystemSettings-class.html) | [wxSystemSettings](https://docs.wxwidgets.org/3.3/classwx_system_settings.html) |

## Graphics classes

[wxDC overview](https://docs.wxwidgets.org/3.3/overview_dc.html)

| Dart | C++ |
| ------------------ | ----------------- |
| [WxPoint](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxPoint-class.html) | [wxPoint](https://docs.wxwidgets.org/3.3/classwx_point.html) |
| [WxSize](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxSize-class.html) | [wxSize](https://docs.wxwidgets.org/3.3/classwx_size.html) |
| [WxRect](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxRect-class.html) | [wxRect](https://docs.wxwidgets.org/3.3/classwx_rect.html) |
| [WxReadOnlyDC](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxReadOnlyDC-class.html) | [wxReadOnlyDC](https://docs.wxwidgets.org/3.3/classwx_read_only_dc.html) |
| [WxDC](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDC-class.html) | [wxDC](https://docs.wxwidgets.org/3.3/classwx_dc.html) |
| [WxPaintDC](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxPaintDC-class.html) | [wxPaintDC](https://docs.wxwidgets.org/3.3/classwx_paint_dc.html) |
| [WxMemoryDC](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxMemoryDC-class.html) | [wxMemoryDC](https://docs.wxwidgets.org/3.3/classwx_memory_dc.html) |
| [WxInfoDC](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxInfoDC-class.html) | [wxInfoDC](https://docs.wxwidgets.org/3.3/classwx_info_dc.html) |
| [WxPaintEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxPaintEvent-class.html) | [wxPaintEvent](https://docs.wxwidgets.org/3.3/classwx_paint_event.html) |
| [WxColour](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxColour-class.html) | [wxColour](https://docs.wxwidgets.org/3.3/classwx_colour.html) |
| [WxCursor](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxCursor-class.html) | [wxCursor](https://docs.wxwidgets.org/3.3/classwx_cursor.html) |
| [WxFont](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxFont-class.html) | [wxFont](https://docs.wxwidgets.org/3.3/classwx_font.html) |
| [WxPen](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxPen-class.html) | [wxPen](https://docs.wxwidgets.org/3.3/classwx_pen.html) |
| [WxBrush](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxBrush-class.html) | [wxBrush](https://docs.wxwidgets.org/3.3/classwx_brush.html) |
| [WxBitmap](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxBitmap-class.html) | [wxBitmap](https://docs.wxwidgets.org/3.3/classwx_bitmap.html) |
| [WxBitmapBundle](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxBitmapBundle-class.html) | [wxBitmapBundle](https://docs.wxwidgets.org/3.3/classwx_bitmap_bundle.html) |
| [WxImage](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxImage-class.html) | [wxImage](https://docs.wxwidgets.org/3.3/classwx_image.html) |
| [WxRendererNative](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxRendererNative-class.html) | [wxRendererNative](https://docs.wxwidgets.org/3.3/classwx_renderer_native.html) |

## Control classes

| Dart | C++ |
| ------------------ | ----------------- |
| [WxControl](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxControl-class.html) | [wxControl](https://docs.wxwidgets.org/3.3/classwx_control.html) |
| [WxStaticLine](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxStaticLine-class.html) | [wxStaticLine](https://docs.wxwidgets.org/3.3/classwx_static_line.html) |
| [WxStaticBox](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxStaticBox-class.html) | [wxStaticBox](https://docs.wxwidgets.org/3.3/classwx_static_box.html) |
| [WxStaticText](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxStaticText-class.html) | [wxStaticText](https://docs.wxwidgets.org/3.3/classwx_static_text.html) |
| [WxStaticBitmap](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxStaticBitmap-class.html) | [wxStaticBitmap](https://docs.wxwidgets.org/3.3/classwx_static_bitmap.html) |
| [WxButton](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxButton-class.html) | [wxButton](https://docs.wxwidgets.org/3.3/classwx_button.html) |
| [WxBitmapButton](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxBitmapButton-class.html) | [wxBitmapButton](https://docs.wxwidgets.org/3.3/classwx_bitmap_button.html) |
| [WxToggleButton](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxToggleButton-class.html) | [wxToggleButton](https://docs.wxwidgets.org/3.3/classwx_toggle_button.html) |
| [WxAnimationCtrl](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxAnimationCtrl-class.html) | [wxAnimationCtrl](https://docs.wxwidgets.org/3.3/classwx_animation_ctrl.html) |
| [WxCheckBox](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxCheckBox-class.html) | [wxCheckBox](https://docs.wxwidgets.org/3.3/classwx_check_box.html) |
| [WxTextCtrl](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxTextCtrl-class.html) | [wxTextCtrl](https://docs.wxwidgets.org/3.3/classwx_text_ctrl.html) |
| [WxChoice](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxChoice-class.html) | [wxChoice](https://docs.wxwidgets.org/3.3/classwx_choice.html) |
| [WxRadioButton](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxRadioButton-class.html) | [wxRadioButton](https://docs.wxwidgets.org/3.3/classwx_radio_button.html) |
| [WxRadioBox](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxRadioBox-class.html) | [wxRadioBox](https://docs.wxwidgets.org/3.3/classwx_radio_box.html) |
| [WxComboBox](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxComboBox-class.html) | [wxComboBox](https://docs.wxwidgets.org/3.3/classwx_combo_box.html) |
| [WxListBox](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxListBox-class.html) | [wxListBox](https://docs.wxwidgets.org/3.3/classwx_list_box.html) |
| [WxSlider](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxSlider-class.html) | [wxSlider](https://docs.wxwidgets.org/3.3/classwx_slider.html) |
| [WxGauge](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxGauge-class.html) | [wxGauge](https://docs.wxwidgets.org/3.3/classwx_gauge.html) |
| [WxSpinCtrl](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxSpinCtrl-class.html) | [wxSpinCtrl](https://docs.wxwidgets.org/3.3/classwx_spin_ctrl.html) |
| [WxSpinCtrlDouble](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxSpinCtrlDouble-class.html) | [wxSpinCtrlDouble](https://docs.wxwidgets.org/3.3/classwx_spin_ctrl_double.html) |
| [WxHyperlinkCtrl](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxHyperlinkCtrl-class.html) | [wxHyperlinkCtrl](https://docs.wxwidgets.org/3.3/classwx_hyperlink_ctrl.html) |

## Complex control classes

| Dart | C++ |
| ------------------ | ----------------- |
| [WxTreeCtrl](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxTreeCtrl-class.html) | [wxTreeCtrl](https://docs.wxwidgets.org/3.3/classwx_tree_ctrl.html) |
| [WxHeaderCtrl](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxHeaderCtrl-class.html) | [wxHeaderCtrl](https://docs.wxwidgets.org/3.3/classwx_header_ctrl.html) |
| [WxHtmlWindow](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxHtmlWindow-class.html) | [wxHtmlWindow](https://docs.wxwidgets.org/3.3/classwx_html_window.html) |

## wxDataViewCtrl related classes

| Dart | C++ |
| ------------------ | ----------------- |
| [WxDataViewCtrl](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDataViewCtrl-class.html) | [wxDataViewCtrl](https://docs.wxwidgets.org/3.3/classwx_data_view_ctrl.html) |
| [WxDataViewModel](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDataViewModel-class.html) | [wxDataViewModel](https://docs.wxwidgets.org/3.3/classwx_data_view_model.html) |
| [WxDataViewModelNotifier](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDataViewModelNotifier-class.html) | [wxDataViewModelNotifier](https://docs.wxwidgets.org/3.3/classwx_data_view_model_notifier.html) |
| [WxDataViewListVirtualModel](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDataViewListVirtualModel-class.html) | [wxDataViewListVirtualModel](https://docs.wxwidgets.org/3.3/classwx_data_view_list_virtual_model.html) |
| [WxDataViewColumn](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDataViewColumn-class.html) | [wxDataViewColumn](https://docs.wxwidgets.org/3.3/classwx_data_view_Column.html) |

wxDataViewCtrl Renderers

| Dart | C++ |
| ------------------ | ----------------- |
| [WxDataViewRenderer](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDataViewRenderer-class.html) | [wxDataViewRenderer](https://docs.wxwidgets.org/3.3/classwx_data_view_renderer.html) |
| [WxDataViewTextRenderer](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDataViewTextRenderer-class.html) | [wxDataViewTextRenderer](https://docs.wxwidgets.org/3.3/classwx_data_view_text_renderer.html) |
| [WxDataViewChoiceRenderer](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDataViewChoiceRenderer-class.html) | [wxDataViewChoiceRenderer](https://docs.wxwidgets.org/3.3/classwx_data_view_choice_renderer.html) |
| [WxDataViewBitmapRenderer](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDataViewBitmapRenderer-class.html) | [wxDataViewBitmapRenderer](https://docs.wxwidgets.org/3.3/classwx_data_view_bitmap_renderer.html) |
| [WxDataViewProgressRenderer](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDataViewProgressRenderer-class.html) | [wxDataViewProgressRenderer](https://docs.wxwidgets.org/3.3/classwx_data_view_progress_renderer.html) |
| [WxDataViewToggleRenderer](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDataViewToggleRenderer-class.html) | [wxDataViewToggleRenderer](https://docs.wxwidgets.org/3.3/classwx_data_view_toggle_renderer.html) |
| [WxDataViewTileRenderer](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDataViewTileRenderer-class.html) | Only available in wxDart |

Predefined model and controls for tabular data

| Dart | C++ |
| ------------------ | ----------------- |
| [WxDataViewListStore](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDataViewListStore-class.html) | [wxDataViewListStore](https://docs.wxwidgets.org/3.3/classwx_data_view_list_store.html) |
| [WxDataViewListCtrl](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDataViewListCtrl-class.html) | [wxDataViewListCtrl](https://docs.wxwidgets.org/3.3/classwx_data_view_list_ctrl.html) |
| [WxDataViewTileListCtrl](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDataViewTileListCtrl-class.html) | Only available in wxDart |

Predefined models and controls for tree data

| Dart | C++ |
| ------------------ | ----------------- |
| [WxDataViewTreeStore](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDataViewTreeStore-class.html) | [wxDataViewTreeStore](https://docs.wxwidgets.org/3.3/classwx_data_view_list_store.html) |
| [WxDataViewTreeCtrl](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDataViewTreeCtrl-class.html) | [wxDataViewTreeCtrl](https://docs.wxwidgets.org/3.3/classwx_data_view_list_ctrl.html) |
| [WxDataViewBookStore](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDataViewBookStore-class.html) | Only available in wxDart |
| [WxDataViewChapterRenderer](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDataViewChapterRenderer-class.html) | Only available in wxDart |
| [WxDataViewChapterCtrl](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDataViewChapterCtrl-class.html) | Only available in wxDart |

## Layout classes

[WxSizer overview](https://docs.wxwidgets.org/3.3/overview_sizer.html)

| Dart | C++ |
| ------------------ | ----------------- |
| [WxSizer](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxSizer-class.html) | [wxSizer](https://docs.wxwidgets.org/3.3/classwx_sizer.html) |
| [WxSizerItem](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxSizerItem-class.html) | [wxSizerItem](https://docs.wxwidgets.org/3.3/classwx_sizer_item.html) |
| [WxBoxSizer](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxBoxSizer-class.html) | [wxBoxSizer](https://docs.wxwidgets.org/3.3/classwx_box_sizer.html) |
| [WxStaticBoxSizer](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxStaticBoxSizer-class.html) | [wxStaticBoxSizer](https://docs.wxwidgets.org/3.3/classwx_static_box_sizer.html) |
| [WxFlexGridSizer](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxFlexGridSizer-class.html) | [wxFlexGridSizer](https://docs.wxwidgets.org/3.3/classwx_flex_grid_sizer.html) |
| [WxWrapSizer](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxWrapSizer-class.html) | [wxWrapSizer](https://docs.wxwidgets.org/3.3/classwx_wrap_sizer.html) |
| [WxTileSizer](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxTileSizer-class.html) | Only available in wxDart |

## Event classes

[Event handling overview](https://docs.wxwidgets.org/3.3/overview_events.html)

| Dart | C++ |
| ------------------ | ----------------- |
| [WxEvtHandler](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxEvtHandler-class.html) | [wxEvtHandler](https://docs.wxwidgets.org/3.3/classwx_evt_handler.html) |
| [WxEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxEvent-class.html) | [wxEvent](https://docs.wxwidgets.org/3.3/classwx_event.html) |
| [WxEventTableEntry](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxEventTableEntry-class.html) | Internal implementation detail. |
| [WxCommandEventTableEntry](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxCommandEventTableEntry-class.html) | Internal implementation detail. |

System events (deriving from WxEvent directly)

| Dart | C++ |
| ------------------ | ----------------- |
| [WxEvtHandler](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxEvtHandler-class.html) | [wxEvtHandler](https://docs.wxwidgets.org/3.3/classwx_evt_handler.html) |
| [WxPaintEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxPaintEvent-class.html) | [WxPaintEvent](https://docs.wxwidgets.org/3.3/classwx_paint_event.html) |
| [WxMouseEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxMouseEvent-class.html) | [WxMouseEvent](https://docs.wxwidgets.org/3.3/classwx_mouse_event.html) |
| [WxKeyEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxKeyEvent-class.html) | [WxKeyEvent](https://docs.wxwidgets.org/3.3/classwx_key_event.html) |
| [WxSizeEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxSizeEvent-class.html) | [WxSizeEvent](https://docs.wxwidgets.org/3.3/classwx_size_event.html) |
| [WxShowEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxShowEvent-class.html) | [WxShowEvent](https://docs.wxwidgets.org/3.3/classwx_show_event.html) |
| [WxIdleEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxIdleEvent-class.html) | [WxIdleEvent](https://docs.wxwidgets.org/3.3/classwx_idle_event.html) |
| [WxTimerEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxTimerEvent-class.html) | [WxTimerEvent](https://docs.wxwidgets.org/3.3/classwx_timer_event.html) |
| [WxCloseEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxCloseEvent-class.html) | [WxCloseEvent](https://docs.wxwidgets.org/3.3/classwx_close_event.html) |
| [WxFocusEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxFocusEvent-class.html) | [WxFocusEvent](https://docs.wxwidgets.org/3.3/classwx_focus_event.html) |
| [WxScrollWinEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxScrollWinEvent-class.html) | [WxScrollWinEvent](https://docs.wxwidgets.org/3.3/classwx_scroll_win_event.html) |
| [wxActivateEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/wxActivateEvent-class.html) | [wxActivateEvent](https://docs.wxwidgets.org/3.3/classwx_activate_event.html) |
| [WxDPIChangedEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDPIChangedEvent-class.html) | [WxDPIChangedEvent](https://docs.wxwidgets.org/3.3/classwx_dpi_changed_event.html) |
| [WxSysColourChangedEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxSysColourChangedEvent-class.html) | [WxSysColourChangedEvent](https://docs.wxwidgets.org/3.3/classwx_sys_colour_changed_event.html) |
| [WxInitDialogEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxInitDialogEvent-class.html) | [WxInitDialogEvent](https://docs.wxwidgets.org/3.3/classwx_init_dialog_event.html) |
| [WxDialogValidateEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDialogValidateEvent-class.html) | Only available in wxDart |
| [WxMenuEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxMenuEvent-class.html) | [WxMenuEvent](https://docs.wxwidgets.org/3.3/classwx_menu_event.html) |

Command events (deriving from WxCommandEvent)

| Dart | C++ |
| ------------------ | ----------------- |
| [WxCommandEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxCommandEvent-class.html) | [wxCommandEvent](https://docs.wxwidgets.org/3.3/classwx_command_event.html) |
| [WxUpdateUIEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxUpdateUIEvent-class.html) | [wxUpdateUIEvent](https://docs.wxwidgets.org/3.3/classwx_update_ui_event.html) |
| [WxNotifyEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxNotifyEvent-class.html) | [wxNotifyEvent](https://docs.wxwidgets.org/3.3/classwx_notify_event.html) |
| [WxNotebookEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxNotebookEvent-class.html) | [wxNotebookEvent](https://docs.wxwidgets.org/3.3/classwx_notebook_event.html) |
| [WxTreeEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxTreeEvent-class.html) | [wxTreeEvent](https://docs.wxwidgets.org/3.3/classwx_command_event.html) |
| [WxSplitterEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxSplitterEvent-class.html) | [wxSplitterEvent](https://docs.wxwidgets.org/3.3/classwx_splitter_event.html) |
| [WxDataViewEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxDataViewEvent-class.html) | [wxDataViewEvent](https://docs.wxwidgets.org/3.3/classwx_data_view_event.html) |
| [WxHtmlEvent](https://pub.dev/documentation/wx_dart/latest/wx_dart/WxHtmlEvent-class.html) | [wxHtmlEvent](https://docs.wxwidgets.org/3.3/classwx_html_event.html) |

## Demo

Here is a link to the [demo app](https://wxdesigner-software.com/demo03) (written in wxDart) running in your browser.<BR>

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

## Developer
This package is developed by wxDesigner Software.

## License of wxDart Flutter (this package)
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
## Design overview

## Nomenclature

Overall, wxDart uses the exact API and nomenclature of the wxWidgets C++ GUI library. Since Dart demands that all class names start with a capital letter, all wxDart related classes use the capitalized prefix "Wx": 
* wxWindow becomes WxWindow
* wxBitmap becomes WxBitmap

All primitive types are matched to their respective equivalents in Dart.
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

Some factory creators have become global functions
* wxStandardPaths::Get() becomes wxGetStandardPaths()
* wxRendererNative::Get() becomes wxGetRendererNative()
* wxSystemSettings::Get() becomes wxGetSystemSettings()

The wxWidgets logging functions have been mapped to
* wxLogError( String text );
* wxLogWarning( String text );
* wxLogMessage( String text );
* wxLogStatus( WxFrame frame, String text );
* setLogTarget( WxTextCtrl? textCtrl );

## WxPoint and WxSize

WxPoint and WxSize are implemented as const classes, so their values cannot be changed. This allows the
use of wxDefaultPosition and wxDefaultSize in constructors as it is widely done in wxWidgets. 

WxRect, however, is not a constant class and can be used and changed like its C++ counterpart.
A noteworthy difference - valid for all of wxDart - is that Dart does reference counting for
every instance of every class. Use WxRect.fromRect() to create a deep copy. 

## Deriving from wxWindow and wxSizer

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

## 2D and 3D drawing support

wxDart currently uses the original drawing API from the wxDC group of classes and it
uses the GDI backend under Windows which provides fastest drawing for simple geometries
and text.

wxWidgets has support for a modern path based drawing API from the wxGraphicsContext
group of classes. These are not available in wxDart yet. Once done, it will use the
Direct2D backend under Windows, CoreGraphics on MacOS, Cairo on Linux and Impellar
when using the Flutter backend.

There is no 3D support in wxDart yet. Ideal would be a port of ThreeJS on all platforms.

## Main loop

A key technical difference between wxDart Native and wxDart Flutter is that wxDart
Native uses the native system's main event loop while wxDart Flutter uses a specialized
hybrid Dart/native main loop. This makes no difference when executing synchronous code, 
but using the native event loop in wxDart Native means that you cannot run any asynchronous
Dart code in wxDart Native. Put differently, wxDart Flutter supports the async await paradigm,
but wxDart Native currently does not.

Eventually, the goal is to enable asynchronous code execution in wxDart Native, as well, but
currently no asynchronous Dart operations are supported in wxDart Native (but they are fully
supported in wxDart Flutter) including streams and asynchronous file operations or web transfer.

## Modal dialogs

As written above, wxDart Native does not currently support the async await paradigm of Dart, but Flutter
requires it to show dialogs modally (i.e. blocking input to all other windows on screen). Therefore, 
wxDart uses a slightly different API compared to the API of wxWidgets: the return value from
WxDialog.showModal() is retrieved through a callback function.
```dart
    void showSomeDialog()
    {
      final dialog = MyDialog(this);
      dialog.showModal( (ret, data) {
        if (ret == wxID_OK) {
          // Pressed OK
        } else {
          // Cancelled dialog
        }
      });
    }
```
If the return value is not relevant, you can pass null to WxDialog.showModal():

```dart
    void showSomeDialog()
    {
      final dialog = MyDialog(this);
      dialog.showModal(null);
    }
```
WxDialog.showModal() will also destroy the dialog, so you cannot call WxDialog.showModal() twice.

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

## Layout mechanism

The system for laying out windows or controls on screen in wxWidgets is based on so called sizers deriving from the
wxSizer base class (see [wxSizer overview](https://docs.wxwidgets.org/3.3/overview_sizer.html)).
The most often used sizers are wxBoxSizer, wxFlexGridSizer and wxStaticBoxSizer. Flutter
has its own, very similar system where e.g. a [Row](https://api.flutter.dev/flutter/widgets/Row-class.html)
corresponds to a [wxBoxSizer(wxHORIZONTAL)](https://docs.wxwidgets.org/3.3/classwx_box_sizer.html) in wxWidgets.

Therefore, all wxDart sizer classes have been implemented to internally use the corresponding Flutter classes
in wxDart Flutter, whereas they use the C++ wxSizer classes in wxDart Native. Both wxDart Flutter and wxDart
Native lay out the controls automatically when the parent (e.g. a dialog) is shown on screen.

A very subtle difference is that Flutter's layout classes automatically re-layout when they are changed also
_after_ they have been shown on screen (e.g. by adding a control or by changing text with a different length).
In wxWidgets, you then need to call 
[wxDialog::Layout()](https://docs.wxwidgets.org/3.3/classwx_top_level_window.html#adfe7e3f4a32f3ed178968f64431bbfe0)
for the controls to be laid out correctly again. 

In practice, you should call WxDialog.layout() in wxDart which will do nothing in wxDart Flutter (as Flutter does
the layout for you) and will call the C++ layout algorithm in wxDart Native. 

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

## Material icons

wxDart Flutter and wxDart Native have built-in support for more than 2000 scalable icons from 
Google's Material icon set. The data is included automatically in wxDart Native and is part of
wxDart Flutter as well.

## Dark and Light mode and accent colour

Both wxDart Native and wxDart Flutter support dark and light modes. Only wxDart Flutter additionally
supports setting an accent colour programmatically to use a specfic main branding colour in your application.
The default is light blue.

## Event handling

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
Command events are not sent by controls when their content or selection is changed
programmatically. This includes those cases where the events are being sent in
the original C++ library (wxNotebook::SetSelection() and wxTextCtrl::SetValue()) - these
two cases have been changed and corrected in wxDart Flutter _and wxDart Native_.

