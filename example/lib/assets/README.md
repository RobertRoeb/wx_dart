## wxDart GUI libraries

wxDart consists of two separate libraries which offer the same API and can be used independently. 'wxDart Native' is a bridge to the wxWidgets C++ GUI library. 'wxDart Flutter' implements the same API in pure Dart and supports all Flutter platforms including the Web.

'wxDart Flutter' is free software under the wxWindows licence. The wxWindows licence allows you to use 'wxDart Flutter' to create free and commercial software with no restrictions, but not to create a closed source competitor of the library itself.

'wxDart Native' is a commercial product.

### wxWidgets and Flutter

wxWidgets is a cross platform GUI library written in C++. It focuses on desktop platforms and uses native widgets on Windows (Win32), MacOS (Cocoa) and Linux (GTK+). A variant for iOS (using UIKit) in under development.

Look at [https://wxwidgets.org](https://wxwidgets.org).

Flutter is GUI toolkit from Google written in Dart that mainly targets mobile touch interfaces like iOS and Android, but also supports the Web (by drawing into a WebGL surface.) and desktops. Contrary to wxWidgets, it draws all widgets itself.

Look at [https://flutter.dev](https://flutter.dev).


### Features
- wxDart uses the API from the wxWidgets library with only minimal adaptions to the Dart languge.
- Much of the core library of wxWidgets is now available in wxDart.

### Installation
To use this package, add wx_dart_flutter as a dependency in your pubspec.yaml file.
```console
flutter pub add wx_dart
```

### Usage
Import the package into your Dart file:
```dart
import 'package:wx_dart/wx_dart.dart';
```
### Hello world
Here is the obvious Hello World.

```dart
const idAbout = 100;

const idRedTheme = 200;
const idGreenTheme = 201;
const idBlueTheme = 202;
const idPurpleTheme = 203;
const idLightMode = 204;
const idDarkMode = 205;


class MyFrame extends WxFrame {
  MyFrame() : super( null, -1, "Hello World", size: WxSize(900, 700), ) 
  {
    final menubar = WxMenuBar();
    final filemenu = WxMenu();
    filemenu.appendItem( idAbout, "About\tAlt-A", help: "ABout Hello World" );
    filemenu.appendSeparator();
    filemenu.appendItem( wxID_EXIT, "Quit app\tCtrl-Q", help: "Run, baby, run!" );
    menubar.append(filemenu, "File");

    final colormenu = WxMenu();
    colormenu.appendItem( idRedTheme, "Red", help: "Choose red theme" );
    colormenu.appendItem( idGreenTheme, "Green", help: "Choose green theme" );
    colormenu.appendItem( idBlueTheme, "Blue", help: "Choose blue theme" );
    colormenu.appendItem( idPurpleTheme, "Purple", help: "Choose purple theme" );
    colormenu.appendSeparator();
    colormenu.appendItem( idLightMode, "Light mode", help: "Choose light mode" );
    colormenu.appendItem( idDarkMode, "Dark mode", help: "See you on the dark side!" );
    menubar.append(colormenu, "Colors");

    setMenuBar(menubar);

    createStatusBar( number: 2 );
    setStatusText( "Welcome to wxDart" );
    setStatusText( "Looks great!", number: 1 );

    // About menu item

    bindMenuEvent( (event)  {
        wxLogStatus( this, "Hello to the world" );
    }, idAbout );

    // Quit menu item

    bindMenuEvent( (_) => close(false), wxID_EXIT );

    // Request to close

    bindCloseWindowEvent( (event) { 
      // You could veto
      // event.veto( true ); 
      // return

      // otherwise, go ahead and quit
      destroy();
    } );

    // Appearance menu for light and dark mode and accent colours

    bindMenuEvent( (_) => wxTheApp!.setAppearance( wxAPPEARANCE_DARK ), idDarkMode );
    bindMenuEvent( (_) => wxTheApp!.setAppearance( wxAPPEARANCE_LIGHT ), idLightMode );
    bindMenuEvent( (_) => wxTheApp!.setAccentColour( WxColour( 103, 58, 183 ) ), idPurpleTheme );
    bindMenuEvent( (_) => wxTheApp!.setAccentColour( WxColour( 44, 176, 48 ) ), idGreenTheme );
    bindMenuEvent( (_) => wxTheApp!.setAccentColour( WxColour(138, 184, 221) ), idBlueTheme );
    bindMenuEvent( (_) => wxTheApp!.setAccentColour( WxColour(212, 55, 55) ), idRedTheme);
  }
}


class MyApp extends WxApp {
  MyApp() {
    // do something here for start-up
  }

  @override
  bool onInit() {
    // create and show main window

    WxFrame myFrame = MyFrame();
    myFrame.show();

    return true;
  }

  @override
  int onExit() {
    // do something here for close-down
    return 0;
  }

}

void main()
{
  final myApp = MyApp();
  myApp.run();
  myApp.dispose();
}

```


### Developer
This package is developed by wxDesigner Software.

### License
```
wxWindows Library Licence, Version 3.1
                ======================================

  Copyright (c) 1998-2005 Julian Smart, Robert Roebling et al

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
