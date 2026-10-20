// ---------------------------------------------------------------------------
// Name:        dataview_item.dart
// Name:        src/generic/datavgen.cpp from wxWidgets
// Purpose:     wxDataViewColumn
// Author:      Robert Roebling
// Modified by: Francesco Montorsi, Guru Kathiresan, Bo Yang
// Copyright:   (c) 1998 Robert Roebling (C++ version)
// Copyright:   (c) 2026 Robert Roebling (Dart version)
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../wx_dart.dart';

// ------------------------- wxDataViewItem ----------------------

/// Represents an item in a [WxDataViewCtrl].
/// 
/// The only [WxDataViewItem] you should ever create is an empty one
/// meaning the root item in a tree control
/// ```dart
///  final root = WxDataViewItem();
/// ```

class WxDataViewItem {
  /// Creates an item from an index or an ID
  WxDataViewItem( { this.index = -1, this.id });

  /// Creates a deep copy of an item
  WxDataViewItem.fromItem( WxDataViewItem item ) {
    index = item.getIndex();
    id = item.getID();
  }
  late int index;
  dynamic id;

  /// Returns index of an item if in a list control
  int getIndex() {
    return index;
  }
  /// Returns ID from the item. Internal.
  dynamic getID() {
    return id;
  }

  /// Returns if valid. Otherwise indicates root or invalid item.
  bool isOk() {
    return (index >= 0) || (id != null);
  }

  @override
  bool operator == (Object other) {
    if (other is! WxDataViewItem) return false;
    return hashCode == other.hashCode;
  }

  @override
  int get hashCode {
    if (id != null) {
      return id.hashCode;
    }
    if (index > 0) {
      return index.hashCode;
    }
    return -1;
  }
}

