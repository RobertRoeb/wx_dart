#!/bin/sh
# Builds the wx_dart package from the source in
# ../../lib
#
echo "Creating wx_dart_flutter folders..."
set -e
mkdir -p lib
mkdir -p lib/common
mkdir -p lib/common_non_native
mkdir -p lib/common_non_native/events
mkdir -p lib/common_non_native/gdi
# mkdir -p lib/common_non_native/misc
mkdir -p lib/dataview
mkdir -p lib/generic
mkdir -p lib/flutter/art
mkdir -p lib/flutter/books
mkdir -p lib/flutter/controls
mkdir -p lib/flutter/core
mkdir -p lib/flutter/dialogs
mkdir -p lib/flutter/gdi
mkdir -p lib/flutter/menu
mkdir -p lib/flutter/misc
mkdir -p lib/flutter/mobile
mkdir -p lib/flutter/sizers
mkdir -p lib/flutter/windows
mkdir -p lib/flutter/wx_bridge
echo "Copying wx_dart_flutter files..."
cp ../../README.md .
cp ../../lib/wx_dart_flutter.dart ./lib/wx_dart.dart
cp ../../lib/common/*.dart ./lib/common
cp ../../lib/common_non_native/events/*.dart ./lib/common_non_native/events
cp ../../lib/common_non_native/gdi/*.dart ./lib/common_non_native/gdi
# cp ../../lib/common_non_native/misc/*.dart ./lib/common_non_native/misc
cp ../../lib/generic/*.dart ./lib/generic
cp ../../lib/dataview/*.dart ./lib/dataview
cp ../../lib/flutter/art/*.dart ./lib/flutter/art
cp ../../lib/flutter/books/*.dart ./lib/flutter/books
cp ../../lib/flutter/controls/*.dart ./lib/flutter/controls
cp ../../lib/flutter/core/*.dart ./lib/flutter/core
cp ../../lib/flutter/dialogs/*.dart ./lib/flutter/dialogs
cp ../../lib/flutter/gdi/*.dart ./lib/flutter/gdi
cp ../../lib/flutter/menu/*.dart ./lib/flutter/menu
cp ../../lib/flutter/misc/*.dart ./lib/flutter/misc
cp ../../lib/flutter/mobile/*.dart ./lib/flutter/mobile
cp ../../lib/flutter/sizers/*.dart ./lib/flutter/sizers
cp ../../lib/flutter/windows/*.dart ./lib/flutter/windows
echo "Done."
