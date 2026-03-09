// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxClass ----------------------

/// The base class for all wxDart classes that have a C++ counterpart
/// in wxDart Native. 
/// 
/// Implements the Finalizable interface in wxDart Native in order to
/// manage the memory of the underlying C++ classes (given that these
/// are not managed directly by the Dart garbage collector).
/// 
/// wxClass manages memory of C++ classes _not_ deriving from wxObject in
/// wxDart Native where it acts as a shadow class for its C++ counterpart.
/// 
/// Since C++ classes that do not derive from wxObject do not
/// have a common virtual destructor, a new wxClass shadow class has
/// to be created for every C++ class not deriving from wxObject.

class WxClass {
  WxClass();

  /// Destroys the C++ class in wxDart Native. This can either
  /// be called directly or it will be called when the Dart 
  /// instance is destroyed by the Dart garbage collector.
  void dispose() {
  }

  /// Prints the name of the Dart class in wxDart Flutter and the
  /// name of the C++ class in wxDart Native 
  void printName() {
    print( (this).runtimeType );
  }
}

// ------------------------- wxObject ----------------------

/// Base class for all window and drawing related classes in
/// wxDart.
/// 
/// Corresponds to a wxObject class in wxWidgets and acts
/// as a shadow class for its C++ counterpart.
/// 
/// The key function in wxDart Native is to correctly delete
/// the C++ class instance by calling the virtual destructor
/// of the C++ wxObject.

class WxObject extends WxClass {
  WxObject();

  /// Destroys the C++ wxObject instance in wxDart Native
  @override
  void dispose() {
  }
}
