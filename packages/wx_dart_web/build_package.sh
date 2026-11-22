#!/bin/sh
# Builds the wx_dart_web package from the source in
# ../../lib
#
echo "Creating wx_dart_native folders..."
set -e
mkdir -p lib
mkdir -p lib/common
mkdir -p lib/common_non_native
mkdir -p lib/common_non_native/events
mkdir -p lib/common_non_native/gdi
# mkdir -p lib/common_non_native/misc
mkdir -p lib/dataview
mkdir -p lib/generic
mkdir -p lib/web/art
mkdir -p lib/web/books
mkdir -p lib/web/controls
mkdir -p lib/web/core
mkdir -p lib/web/dialogs
mkdir -p lib/web/gdi
mkdir -p lib/web/menu
mkdir -p lib/web/misc
mkdir -p lib/web/mobile
mkdir -p lib/web/sizers
mkdir -p lib/web/windows
mkdir -p lib/web/wx_bridge
echo "Copying wx_dart_native files..."
cp ../../README.md .
cp ../../lib/wx_dart_web.dart ./lib/wx_dart.dart
cp ../../lib/common/*.dart ./lib/common
cp ../../lib/common_non_native/events/*.dart ./lib/common_non_native/events
cp ../../lib/common_non_native/gdi/*.dart ./lib/common_non_native/gdi
# cp ../../lib/common_non_native/misc/*.dart ./lib/common_non_native/misc
cp ../../lib/generic/*.dart ./lib/generic
cp ../../lib/dataview/*.dart ./lib/dataview
cp ../../lib/web/*.dart ./lib/web
cp ../../lib/web/art/*.dart ./lib/web/art
cp ../../lib/web/books/*.dart ./lib/web/books
cp ../../lib/web/controls/*.dart ./lib/web/controls
cp ../../lib/web/core/*.dart ./lib/web/core
cp ../../lib/web/dialogs/*.dart ./lib/web/dialogs
cp ../../lib/web/gdi/*.dart ./lib/web/gdi
cp ../../lib/web/menu/*.dart ./lib/web/menu
cp ../../lib/web/misc/*.dart ./lib/web/misc
cp ../../lib/web/mobile/*.dart ./lib/web/mobile
cp ../../lib/web/sizers/*.dart ./lib/web/sizers
cp ../../lib/web/windows/*.dart ./lib/web/windows
cp ../../lib/web/wx_bridge/*.* ./lib/web/wx_bridge
echo "Done."
