# hello

This is an example for wxDart Native

## Getting Started

wxDart Native is the variant of wxDart that uses a bridge to the 
native Windows, macOS and Linux (GTK+ 3.0) operating system for
its display. wxDart Native uses the wxWidgets library for that
purpose and you need to either build the bridge libraries yourself
or download pre-built binaries (see below).

Since wxDart verison 0.9.11, all variants of wxDart Native use the Flutter
build system (i.e. no longer the Dart build system). 

In order to run a wxDart Native app on Windows you need to modify the runner.exe to use a
manifest file that includes the Common Controls 6.0 directives. See 
[here](https://github.com/MicrosoftDocs/win32/blob/docs/desktop-src/Controls/cookbook-overview.md)

To build a binary you use the flutter build command (identically for both wxDart Native and
wxDart Flutter). E.g. on macOS:
```bash
flutter build macos
```
from the example folder. Apps built with wxDart Native need one of the bridge libraries below.

## Download wxDart Native bridge libraries

The bridge libraries export a pure C interface and are therefore not compiler dependent.

The respective bridge library needs to be placed into the folder of the main binary (*.exe) on Windows and Linux
and into the Frameworks folder of the application package on macOS.

Get the pre-built bridge libraries from [libwxdart.dll](https://wxdesigner-software.com/downloads).
