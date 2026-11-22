// ---------------------------------------------------------------------------
// wxDart Web
//
// A small, web-only variant of wxDart with the same API as wxDart Flutter
// and wxDart Native for a subset of classes. It does not use Flutter, Skia
// or CanvasKit: windows are plain DOM elements, WxPaintDC draws on an HTML
// <canvas> (CanvasRenderingContext2D), and menus and dialogs are HTML/CSS.
// All DOM work is done by runtime/wxc.js; this library only depends on the
// Dart SDK (dart:js_interop), so it compiles to a small JavaScript or
// WebAssembly file that starts almost instantly.
//
// Author:      Robert Roebling
// Created:     2026-11-15
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

library;

import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';
import 'dart:math';
import 'dart:typed_data';

// shared with wxDart Flutter, unchanged except for the `part of` line
part 'common_non_native/events/event.dart';
part 'common_non_native/events/evt_handler.dart';
part 'common_non_native/events/events.dart';
part 'common_non_native/events/command_event.dart';
part 'common_non_native/events/mouse_event.dart';
part 'common_non_native/events/key_event.dart';
part 'common_non_native/events/paint_event.dart';
part 'common_non_native/events/size_event.dart';
part 'common_non_native/events/timer_event.dart';
part 'common_non_native/events/idle_event.dart';
part 'common_non_native/events/update_ui_event.dart';
part 'common_non_native/events/dialog_events.dart';
part 'common_non_native/events/notebook_event.dart';
part 'common_non_native/events/collapsible_pane_event.dart';
part 'common_non_native/events/html_link_event.dart';
part 'common_non_native/events/hyperlink_event.dart';
part 'common_non_native/events/spin_ctrl_event.dart';
part 'common_non_native/events/tree_event.dart';
part 'common_non_native/events/splitter_event.dart';
part 'common_non_native/events/menu_event.dart';
part 'common_non_native/events/notify_event.dart';
part 'common_non_native/events/drop_event.dart';
part 'common_non_native/events/drag_event.dart';
part 'common_non_native/gdi/image.dart';

part 'common/enums.dart';
part 'common/webgl_constants.dart';
part 'common/stop_watch.dart';
part 'common/geometry.dart';
part 'common/pen.dart';
part 'common/brush.dart';
part 'common/colour.dart';

// shared with wxDart Flutter, copied unchanged (pure Dart)
part 'web/core/object.dart';

// wxDart Web implementation
part 'web/js_bridge.dart';
part 'web/core/constants.dart';
part 'web/core/funcs.dart';
part 'web/core/log.dart';
part 'web/core/app.dart';
part 'web/core/dispatch.dart';
part 'web/windows/window.dart';
part 'web/windows/toplevel_window.dart';
part 'web/windows/frame.dart';
part 'web/windows/dialog.dart';
part 'web/windows/scrolled_window.dart';
part 'web/windows/panel.dart';
part 'web/windows/status_bar.dart';
part 'web/windows/splitter_window.dart';
part 'web/windows/popup_window.dart';
part 'web/dialogs/message_dialog.dart';
part 'web/dialogs/file_dialog.dart';
part 'web/mobile/navigation_ctrl.dart';
part 'web/mobile/app_bar.dart';
part 'web/mobile/adaptive_frame.dart';
part 'web/books/book_ctrl_base.dart';
part 'web/books/notebook.dart';
part 'web/books/treebook.dart';
part 'web/controls/control.dart';
part 'web/controls/button.dart';
part 'web/controls/static_text.dart';
part 'web/controls/text_ctrl.dart';
part 'web/controls/check_box.dart';
part 'web/controls/item_container.dart';
part 'web/controls/choice.dart';
part 'web/controls/listbox.dart';
part 'web/controls/hyperlink_ctrl.dart';
part 'web/controls/html_window.dart';
part 'web/controls/slider.dart';
part 'web/controls/gauge.dart';
part 'web/controls/activity_indicator.dart';
part 'web/controls/animation_ctrl.dart';
part 'web/controls/gl_canvas.dart';
part 'web/controls/toggle_button.dart';
part 'web/controls/static_line.dart';
part 'web/controls/static_bitmap.dart';
part 'web/controls/static_box.dart';
part 'web/controls/radio_button.dart';
part 'web/controls/radio_box.dart';
part 'web/controls/spin_ctrl.dart';
part 'web/controls/spin_ctrl_double.dart';
part 'web/controls/search_ctrl.dart';
part 'web/controls/combo_box.dart';
part 'web/controls/bitmap_combo_box.dart';
part 'web/controls/collapsible_pane.dart';
part 'web/controls/tree_ctrl.dart';
part 'web/controls/tool_bar.dart';
part 'web/sizers/sizer.dart';
part 'web/sizers/box_sizer.dart';
part 'web/sizers/grid_sizer.dart';
part 'web/sizers/static_box_sizer.dart';
part 'web/sizers/wrap_sizer.dart';
part 'web/menu/menu.dart';
part 'web/menu/menu_item.dart';
part 'web/menu/menu_bar.dart';
part 'web/gdi/font.dart';
part 'web/gdi/bitmap.dart';
part 'web/gdi/bitmap_bundle.dart';
part 'web/art/material_icons.dart';
part 'web/gdi/dc.dart';
part 'web/gdi/info_dc.dart';
part 'web/gdi/cursor.dart';
part 'web/gdi/renderer_native.dart';
part 'web/gdi/system_settings.dart';
part 'web/gdi/ui_animation.dart';
part 'web/gdi/animation.dart';
part 'web/gdi/memory_dc.dart';
part 'web/gdi/graphics_path.dart';
part 'web/gdi/graphics_context.dart';
part 'web/misc/timer.dart';
part 'web/misc/data_object.dart';
part 'web/misc/drop_source.dart';
part 'web/misc/drop_target.dart';

// generic controls, shared with wxDart Flutter (drawn with WxDC)
part 'generic/misc.dart';
part 'generic/header_ctrl.dart';
part 'generic/graphics_animation.dart';
part 'generic/tile_sizer.dart';
part 'generic/sizer_flags.dart';
part 'dataview/dataview_model.dart';
part 'dataview/dataview_renderer.dart';
part 'dataview/dataview_item.dart';
part 'dataview/dataview_ctrl.dart';
part 'dataview/dataview_column.dart';
part 'dataview/dataview_event.dart';
part 'dataview/dataview_list_ctrl.dart';
part 'dataview/dataview_tile_list_ctrl.dart';
part 'dataview/dataview_tree_ctrl.dart';
part 'dataview/dataview_chapter_ctrl.dart';
part 'dataview/databook.dart';
