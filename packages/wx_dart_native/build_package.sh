#!/bin/sh
# Builds the wx_dart_native package from the source in
# ../../lib
#
echo "Creating wx_dart_native folders..."
set -e
mkdir -p lib
mkdir -p lib/common
mkdir -p lib/dataview
mkdir -p lib/generic
mkdir -p lib/native
mkdir -p lib/native/opengl
echo "Copying wx_dart_native files..."
cp ../../README.md .
cp ../../lib/wx_dart_native.dart ./lib/wx_dart.dart
cp ../../lib/common/*.dart ./lib/common
cp ../../lib/native/*.dart ./lib/native
cp ../../lib/native/opengl/*.dart ./lib/native/opengl
cp ../../lib/generic/*.dart ./lib/generic
cp ../../lib/dataview/*.dart ./lib/dataview
echo "Done."
