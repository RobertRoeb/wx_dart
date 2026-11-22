
library;

import 'dart:ffi';
import 'dart:convert';
import 'package:ffi/ffi.dart';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/widgets.dart'; // for bindings
import 'dart:ui' as ui;
part 'common/enums.dart';
part 'common/webgl_constants.dart';
part 'common/stop_watch.dart';
part 'common/geometry.dart';
part 'common/pen.dart';
part 'common/brush.dart';
part 'common/colour.dart';
part 'native/core.dart';
part 'native/misc.dart';
part 'native/utils.dart';
part 'native/controls.dart';
part 'native/controls2.dart';
part 'native/glcontext.dart';
part 'native/menus.dart';
part 'native/events.dart';
part 'native/windows.dart';
part 'native/gdi.dart';
part 'native/sizers.dart';
part 'native/books.dart';
part 'native/material.dart';

part 'generic/misc.dart';
part 'generic/header_ctrl.dart';
part 'generic/tile_sizer.dart';
part 'generic/graphics_animation.dart';
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

part 'native/opengl/opengl_header.dart';
part 'native/opengl/opengl_library.dart';
part 'native/opengl/opengl_init.dart';
