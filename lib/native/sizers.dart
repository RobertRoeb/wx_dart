// -------------------------------------------------------------
// Purpose:     Dart bindings for wxWidgets
// Author:      Robert Roebling
// Modified by: The magic C++ to Dart code generator
// Created:     07/01/2025
// Copyright:   (c) Robert Roebling
// Licence:     wxWindows licence 3.1
// -------------------------------------------------------------

part of '../wx_dart.dart';

// ------------------------- wxSizerItem ----------------------

typedef _WxSizerItemConstructorNative = Pointer Function(  );
typedef _WxSizerItemConstructor = Pointer Function(  );
late _WxSizerItemConstructor _wxSizerItemConstructor;

typedef _WxSizerItemIsWindowNative = Bool Function( Pointer  );
typedef _WxSizerItemIsWindow = bool Function( Pointer  );
late _WxSizerItemIsWindow _wxSizerItemIsWindow;

typedef _WxSizerItemIsSizerNative = Bool Function( Pointer  );
typedef _WxSizerItemIsSizer = bool Function( Pointer  );
late _WxSizerItemIsSizer _wxSizerItemIsSizer;

typedef _WxSizerItemIsSpacerNative = Bool Function( Pointer  );
typedef _WxSizerItemIsSpacer = bool Function( Pointer  );
late _WxSizerItemIsSpacer _wxSizerItemIsSpacer;

typedef _WxSizerItemGetPositionNative = WxPointNative Function( Pointer  );
typedef _WxSizerItemGetPosition = WxPointNative Function( Pointer  );
late _WxSizerItemGetPosition _wxSizerItemGetPosition;

typedef _WxSizerItemGetSizeNative = WxSizeNative Function( Pointer  );
typedef _WxSizerItemGetSize = WxSizeNative Function( Pointer  );
late _WxSizerItemGetSize _wxSizerItemGetSize;

typedef _WxSizerItemGetFlagNative = Int32 Function( Pointer  );
typedef _WxSizerItemGetFlag = int Function( Pointer  );
late _WxSizerItemGetFlag _wxSizerItemGetFlag;

typedef _WxSizerItemGetBorderNative = Int32 Function( Pointer  );
typedef _WxSizerItemGetBorder = int Function( Pointer  );
late _WxSizerItemGetBorder _wxSizerItemGetBorder;

typedef _WxSizerItemGetProportionNative = Int32 Function( Pointer  );
typedef _WxSizerItemGetProportion = int Function( Pointer  );
late _WxSizerItemGetProportion _wxSizerItemGetProportion;

typedef _WxSizerItemGetSizerNative = Pointer Function( Pointer  );
typedef _WxSizerItemGetSizer = Pointer Function( Pointer  );
late _WxSizerItemGetSizer _wxSizerItemGetSizer;

typedef _WxSizerItemGetWindowNative = Pointer Function( Pointer  );
typedef _WxSizerItemGetWindow = Pointer Function( Pointer  );
late _WxSizerItemGetWindow _wxSizerItemGetWindow;

typedef _WxSizerItemSetFlagNative = Void Function( Pointer, Int32  );
typedef _WxSizerItemSetFlag = void Function( Pointer, int  );
late _WxSizerItemSetFlag _wxSizerItemSetFlag;

typedef _WxSizerItemSetBorderNative = Void Function( Pointer, Int32  );
typedef _WxSizerItemSetBorder = void Function( Pointer, int  );
late _WxSizerItemSetBorder _wxSizerItemSetBorder;

typedef _WxSizerItemSetProportionNative = Void Function( Pointer, Int32  );
typedef _WxSizerItemSetProportion = void Function( Pointer, int  );
late _WxSizerItemSetProportion _wxSizerItemSetProportion;

class WxSizerItem extends WxObject {
  WxSizerItem._defaultConstructor() : super._defaultConstructor();
  WxSizerItem( ) : super._defaultConstructor() {
    nativeHandle = _wxSizerItemConstructor(  );
  }
  WxSizerItem.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  bool isWindow( ) {
    return _wxSizerItemIsWindow( nativeHandle  );
  }

  bool isSizer( ) {
    return _wxSizerItemIsSizer( nativeHandle  );
  }

  bool isSpacer( ) {
    return _wxSizerItemIsSpacer( nativeHandle  );
  }

  WxPoint getPosition( ) {
    final WxPointNative pointReturn = _wxSizerItemGetPosition( nativeHandle  );
    return WxPoint(pointReturn.x, pointReturn.y);
  }

  WxSize getSize( ) {
    final WxSizeNative sizeReturn = _wxSizerItemGetSize( nativeHandle  );
    return WxSize(sizeReturn.x, sizeReturn.y);
  }

  int getFlag( ) {
    return _wxSizerItemGetFlag( nativeHandle  );
  }

  int getBorder( ) {
    return _wxSizerItemGetBorder( nativeHandle  );
  }

  int getProportion( ) {
    return _wxSizerItemGetProportion( nativeHandle  );
  }

  WxSizer? getSizer( ) {
    final returnedNativeHandle = _wxSizerItemGetSizer( nativeHandle  );
    if (returnedNativeHandle == nullptr) return null;
    return WxSizer.fromHandle( returnedNativeHandle );
  }

  WxWindow? getWindow( ) {
    final returnedNativeHandle = _wxSizerItemGetWindow( nativeHandle  );
    if (returnedNativeHandle == nullptr) return null;
    WxEvtHandler? eh = _evtHandlerList[returnedNativeHandle];
    if (eh != null) {
      // There already is a Dart class associated with this C++ object
      return eh as WxWindow;
    }
    return wxCreateBestMatchingClassFromWxWindowHandle( returnedNativeHandle );
  }

  void setFlag( int flag ) {
    _wxSizerItemSetFlag( nativeHandle, flag );
  }

  void setBorder( int border ) {
    _wxSizerItemSetBorder( nativeHandle, border );
  }

  void setProportion( int proportion ) {
    _wxSizerItemSetProportion( nativeHandle, proportion );
  }
}

// ------------------------- wxSizer ----------------------

typedef _WxSizerLayoutNative = Void Function( Pointer  );
typedef _WxSizerLayout = void Function( Pointer  );
late _WxSizerLayout _wxSizerLayout;

typedef _WxSizerGetSizeNative = WxSizeNative Function( Pointer  );
typedef _WxSizerGetSize = WxSizeNative Function( Pointer  );
late _WxSizerGetSize _wxSizerGetSize;

typedef _WxSizerGetMinSizeNative = WxSizeNative Function( Pointer  );
typedef _WxSizerGetMinSize = WxSizeNative Function( Pointer  );
late _WxSizerGetMinSize _wxSizerGetMinSize;

typedef _WxSizerGetPositionNative = WxPointNative Function( Pointer  );
typedef _WxSizerGetPosition = WxPointNative Function( Pointer  );
late _WxSizerGetPosition _wxSizerGetPosition;

typedef _WxSizerRemoveNative = Bool Function( Pointer, Int32  );
typedef _WxSizerRemove = bool Function( Pointer, int  );
late _WxSizerRemove _wxSizerRemove;

typedef _WxSizerRemoveSizerNative = Bool Function( Pointer, Pointer  );
typedef _WxSizerRemoveSizer = bool Function( Pointer, Pointer  );
late _WxSizerRemoveSizer _wxSizerRemoveSizer;

typedef _WxSizerRemoveWindowNative = Bool Function( Pointer, Pointer  );
typedef _WxSizerRemoveWindow = bool Function( Pointer, Pointer  );
late _WxSizerRemoveWindow _wxSizerRemoveWindow;

typedef _WxSizerGetItemCountNative = Int32 Function( Pointer  );
typedef _WxSizerGetItemCount = int Function( Pointer  );
late _WxSizerGetItemCount _wxSizerGetItemCount;

typedef _WxSizerGetItemNative = Pointer Function( Pointer, Int32  );
typedef _WxSizerGetItem = Pointer Function( Pointer, int  );
late _WxSizerGetItem _wxSizerGetItem;

typedef _WxSizerGetWindowItemNative = Pointer Function( Pointer, Pointer  );
typedef _WxSizerGetWindowItem = Pointer Function( Pointer, Pointer  );
late _WxSizerGetWindowItem _wxSizerGetWindowItem;

typedef _WxSizerGetSizerItemNative = Pointer Function( Pointer, Pointer  );
typedef _WxSizerGetSizerItem = Pointer Function( Pointer, Pointer  );
late _WxSizerGetSizerItem _wxSizerGetSizerItem;

typedef _WxSizerAddNative = Pointer Function( Pointer, Pointer, Int32, Int32, Int32  );
typedef _WxSizerAdd = Pointer Function( Pointer, Pointer, int, int, int  );
late _WxSizerAdd _wxSizerAdd;

typedef _WxSizerAddSizerNative = Pointer Function( Pointer, Pointer, Int32, Int32, Int32  );
typedef _WxSizerAddSizer = Pointer Function( Pointer, Pointer, int, int, int  );
late _WxSizerAddSizer _wxSizerAddSizer;

typedef _WxSizerAddSpacerNative = Pointer Function( Pointer, Int32  );
typedef _WxSizerAddSpacer = Pointer Function( Pointer, int  );
late _WxSizerAddSpacer _wxSizerAddSpacer;

typedef _WxSizerAddStretchSpacerNative = Pointer Function( Pointer, Int32  );
typedef _WxSizerAddStretchSpacer = Pointer Function( Pointer, int  );
late _WxSizerAddStretchSpacer _wxSizerAddStretchSpacer;

typedef _WxSizerPrependNative = Pointer Function( Pointer, Pointer, Int32, Int32, Int32  );
typedef _WxSizerPrepend = Pointer Function( Pointer, Pointer, int, int, int  );
late _WxSizerPrepend _wxSizerPrepend;

typedef _WxSizerPrependSizerNative = Pointer Function( Pointer, Pointer, Int32, Int32, Int32  );
typedef _WxSizerPrependSizer = Pointer Function( Pointer, Pointer, int, int, int  );
late _WxSizerPrependSizer _wxSizerPrependSizer;

typedef _WxSizerPrependSpacerNative = Pointer Function( Pointer, Int32  );
typedef _WxSizerPrependSpacer = Pointer Function( Pointer, int  );
late _WxSizerPrependSpacer _wxSizerPrependSpacer;

typedef _WxSizerPrependStretchSpacerNative = Pointer Function( Pointer, Int32  );
typedef _WxSizerPrependStretchSpacer = Pointer Function( Pointer, int  );
late _WxSizerPrependStretchSpacer _wxSizerPrependStretchSpacer;

typedef _WxSizerInsertNative = Pointer Function( Pointer, Int32, Pointer, Int32, Int32, Int32  );
typedef _WxSizerInsert = Pointer Function( Pointer, int, Pointer, int, int, int  );
late _WxSizerInsert _wxSizerInsert;

typedef _WxSizerInsertSizerNative = Pointer Function( Pointer, Int32, Pointer, Int32, Int32, Int32  );
typedef _WxSizerInsertSizer = Pointer Function( Pointer, int, Pointer, int, int, int  );
late _WxSizerInsertSizer _wxSizerInsertSizer;

typedef _WxSizerInsertSpacerNative = Pointer Function( Pointer, Int32, Int32  );
typedef _WxSizerInsertSpacer = Pointer Function( Pointer, int, int  );
late _WxSizerInsertSpacer _wxSizerInsertSpacer;

typedef _WxSizerInsertStretchSpacerNative = Pointer Function( Pointer, Int32, Int32  );
typedef _WxSizerInsertStretchSpacer = Pointer Function( Pointer, int, int  );
late _WxSizerInsertStretchSpacer _wxSizerInsertStretchSpacer;

/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxLEFT | 0x0010 |
/// | wxRIGHT | 0x0020 |
/// | wxUP | 0x0040 |
/// | wxDOWN | 0x0080 |
/// | wxTOP | wxUP |
/// | wxBOTTOM | wxDOWN |
/// | wxNORTH | wxUP |
/// | wxSOUTH | wxDOWN |
/// | wxWEST | wxLEFT |
/// | wxEAST | wxRIGHT |
/// | wxALL | (wxUP | wxDOWN | wxRIGHT | wxLEFT) |
/// | wxDIRECTION_MASK | wxALL |
/// | wxALIGN_INVALID | -1 |
/// | wxALIGN_NOT | 0x0000 |
/// | wxALIGN_CENTER_HORIZONTAL | 0x0100 |
/// | wxALIGN_CENTRE_HORIZONTAL | wxALIGN_CENTER_HORIZONTAL |
/// | wxALIGN_LEFT | wxALIGN_NOT |
/// | wxALIGN_TOP | wxALIGN_NOT |
/// | wxALIGN_RIGHT | 0x0200 |
/// | wxALIGN_BOTTOM | 0x0400 |
/// | wxALIGN_CENTER_VERTICAL | 0x0800 |
/// | wxALIGN_CENTRE_VERTICAL | wxALIGN_CENTER_VERTICAL |
/// | wxALIGN_CENTER | (wxALIGN_CENTER_HORIZONTAL | wxALIGN_CENTER_VERTICAL) |
/// | wxALIGN_CENTRE | wxALIGN_CENTER |
/// | wxALIGN_MASK | 0x0f00 |
/// | wxSTRETCH_NOT | 0x0000 |
/// | wxSHRINK | 0x1000 |
/// | wxGROW | 0x2000 |
/// | wxEXPAND | wxGROW |
/// | wxSHAPED | 0x4000 |
/// | wxTILE | 0xc000 |
/// | wxSTRETCH_MASK | 0x7000 |

const int wxLEFT = 0x0010;
const int wxRIGHT = 0x0020;
const int wxUP = 0x0040;
const int wxDOWN = 0x0080;
const int wxTOP = wxUP;
const int wxBOTTOM = wxDOWN;
const int wxNORTH = wxUP;
const int wxSOUTH = wxDOWN;
const int wxWEST = wxLEFT;
const int wxEAST = wxRIGHT;
const int wxALL = (wxUP | wxDOWN | wxRIGHT | wxLEFT);
const int wxDIRECTION_MASK = wxALL;
const int wxALIGN_INVALID = -1;
const int wxALIGN_NOT = 0x0000;
const int wxALIGN_CENTER_HORIZONTAL = 0x0100;
const int wxALIGN_CENTRE_HORIZONTAL = wxALIGN_CENTER_HORIZONTAL;
const int wxALIGN_LEFT = wxALIGN_NOT;
const int wxALIGN_TOP = wxALIGN_NOT;
const int wxALIGN_RIGHT = 0x0200;
const int wxALIGN_BOTTOM = 0x0400;
const int wxALIGN_CENTER_VERTICAL = 0x0800;
const int wxALIGN_CENTRE_VERTICAL = wxALIGN_CENTER_VERTICAL;
const int wxALIGN_CENTER = (wxALIGN_CENTER_HORIZONTAL | wxALIGN_CENTER_VERTICAL);
const int wxALIGN_CENTRE = wxALIGN_CENTER;
const int wxALIGN_MASK = 0x0f00;
const int wxSTRETCH_NOT = 0x0000;
const int wxSHRINK = 0x1000;
const int wxGROW = 0x2000;
const int wxEXPAND = wxGROW;
const int wxSHAPED = 0x4000;
const int wxTILE = 0xc000;
const int wxSTRETCH_MASK = 0x7000;

class WxSizer extends WxObject {
  WxSizer._defaultConstructor() : super._defaultConstructor();
  WxSizer.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  void layout( ) {
    _wxSizerLayout( nativeHandle  );
  }

  WxSize getSize( ) {
    final WxSizeNative sizeReturn = _wxSizerGetSize( nativeHandle  );
    return WxSize(sizeReturn.x, sizeReturn.y);
  }

  WxSize getMinSize( ) {
    final WxSizeNative sizeReturn = _wxSizerGetMinSize( nativeHandle  );
    return WxSize(sizeReturn.x, sizeReturn.y);
  }

  WxPoint getPosition( ) {
    final WxPointNative pointReturn = _wxSizerGetPosition( nativeHandle  );
    return WxPoint(pointReturn.x, pointReturn.y);
  }

  bool remove( int index ) {
    return _wxSizerRemove( nativeHandle, index );
  }

  bool removeSizer( WxSizer sizer ) {
    return _wxSizerRemoveSizer( nativeHandle, sizer.nativeHandle );
  }

  bool removeWindow( WxWindow window ) {
    return _wxSizerRemoveWindow( nativeHandle, window.nativeHandle );
  }

  int getItemCount( ) {
    return _wxSizerGetItemCount( nativeHandle  );
  }

  WxSizerItem? getItem( int index ) {
    final returnedNativeHandle = _wxSizerGetItem( nativeHandle, index );
    if (returnedNativeHandle == nullptr) return null;
    return WxSizerItem.fromHandle( returnedNativeHandle );
  }

  WxSizerItem? getWindowItem( WxWindow window ) {
    final returnedNativeHandle = _wxSizerGetWindowItem( nativeHandle, window.nativeHandle );
    if (returnedNativeHandle == nullptr) return null;
    return WxSizerItem.fromHandle( returnedNativeHandle );
  }

  WxSizerItem? getSizerItem( WxSizer sizer ) {
    final returnedNativeHandle = _wxSizerGetSizerItem( nativeHandle, sizer.nativeHandle );
    if (returnedNativeHandle == nullptr) return null;
    return WxSizerItem.fromHandle( returnedNativeHandle );
  }

  WxSizerItem add( WxWindow window, { int proportion = 0, int flag = 0, int border = 0 } ) {
    final returnedNativeHandle = _wxSizerAdd( nativeHandle, window.nativeHandle, proportion, flag, border );
    return WxSizerItem.fromHandle( returnedNativeHandle );
  }

  WxSizerItem addSizer( WxSizer sizer, { int proportion = 0, int flag = 0, int border = 0 } ) {
    final returnedNativeHandle = _wxSizerAddSizer( nativeHandle, sizer.nativeHandle, proportion, flag, border );
    return WxSizerItem.fromHandle( returnedNativeHandle );
  }

  WxSizerItem addSpacer( int size ) {
    final returnedNativeHandle = _wxSizerAddSpacer( nativeHandle, size );
    return WxSizerItem.fromHandle( returnedNativeHandle );
  }

  WxSizerItem addStretchSpacer( { int prop = 1 } ) {
    final returnedNativeHandle = _wxSizerAddStretchSpacer( nativeHandle, prop );
    return WxSizerItem.fromHandle( returnedNativeHandle );
  }

  WxSizerItem prepend( WxWindow window, { int proportion = 0, int flag = 0, int border = 0 } ) {
    final returnedNativeHandle = _wxSizerPrepend( nativeHandle, window.nativeHandle, proportion, flag, border );
    return WxSizerItem.fromHandle( returnedNativeHandle );
  }

  WxSizerItem prependSizer( WxSizer sizer, { int proportion = 0, int flag = 0, int border = 0 } ) {
    final returnedNativeHandle = _wxSizerPrependSizer( nativeHandle, sizer.nativeHandle, proportion, flag, border );
    return WxSizerItem.fromHandle( returnedNativeHandle );
  }

  WxSizerItem prependSpacer( int size ) {
    final returnedNativeHandle = _wxSizerPrependSpacer( nativeHandle, size );
    return WxSizerItem.fromHandle( returnedNativeHandle );
  }

  WxSizerItem prependStretchSpacer( { int prop = 1 } ) {
    final returnedNativeHandle = _wxSizerPrependStretchSpacer( nativeHandle, prop );
    return WxSizerItem.fromHandle( returnedNativeHandle );
  }

  WxSizerItem insert( int index, WxWindow window, { int proportion = 0, int flag = 0, int border = 0 } ) {
    final returnedNativeHandle = _wxSizerInsert( nativeHandle, index, window.nativeHandle, proportion, flag, border );
    return WxSizerItem.fromHandle( returnedNativeHandle );
  }

  WxSizerItem insertSizer( int index, WxSizer sizer, { int proportion = 0, int flag = 0, int border = 0 } ) {
    final returnedNativeHandle = _wxSizerInsertSizer( nativeHandle, index, sizer.nativeHandle, proportion, flag, border );
    return WxSizerItem.fromHandle( returnedNativeHandle );
  }

  WxSizerItem insertSpacer( int index, int size ) {
    final returnedNativeHandle = _wxSizerInsertSpacer( nativeHandle, index, size );
    return WxSizerItem.fromHandle( returnedNativeHandle );
  }

  WxSizerItem insertStretchSpacer( int index, { int prop = 1 } ) {
    final returnedNativeHandle = _wxSizerInsertStretchSpacer( nativeHandle, index, prop );
    return WxSizerItem.fromHandle( returnedNativeHandle );
  }
}

// ------------------------- wxBoxSizer ----------------------

typedef _WxBoxSizerConstructorNative = Pointer Function( Int32  );
typedef _WxBoxSizerConstructor = Pointer Function( int  );
late _WxBoxSizerConstructor _wxBoxSizerConstructor;

typedef _WxBoxSizerSetOrientationNative = Void Function( Pointer, Int32  );
typedef _WxBoxSizerSetOrientation = void Function( Pointer, int  );
late _WxBoxSizerSetOrientation _wxBoxSizerSetOrientation;

typedef _WxBoxSizerGetOrientationNative = Int32 Function( Pointer  );
typedef _WxBoxSizerGetOrientation = int Function( Pointer  );
late _WxBoxSizerGetOrientation _wxBoxSizerGetOrientation;

class WxBoxSizer extends WxSizer {
  WxBoxSizer._defaultConstructor() : super._defaultConstructor();
  WxBoxSizer( int orientation ) : super._defaultConstructor() {
    nativeHandle = _wxBoxSizerConstructor( orientation );
  }
  WxBoxSizer.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  void setOrientation( int orientation ) {
    _wxBoxSizerSetOrientation( nativeHandle, orientation );
  }

  int getOrientation( ) {
    return _wxBoxSizerGetOrientation( nativeHandle  );
  }
}

// ------------------------- wxStaticBoxSizer ----------------------

typedef _WxStaticBoxSizerConstructorNative = Pointer Function( Int32, Pointer, Pointer<Utf8>  );
typedef _WxStaticBoxSizerConstructor = Pointer Function( int, Pointer, Pointer<Utf8>  );
late _WxStaticBoxSizerConstructor _wxStaticBoxSizerConstructor;

typedef _WxStaticBoxSizerGetStaticBoxNative = Pointer Function( Pointer  );
typedef _WxStaticBoxSizerGetStaticBox = Pointer Function( Pointer  );
late _WxStaticBoxSizerGetStaticBox _wxStaticBoxSizerGetStaticBox;

class WxStaticBoxSizer extends WxBoxSizer {
  WxStaticBoxSizer._defaultConstructor() : super._defaultConstructor();
  WxStaticBoxSizer( int orientation, WxWindow parent, String label ) : super._defaultConstructor() {
    final labelUtf8 = label.toNativeUtf8();
    nativeHandle = _wxStaticBoxSizerConstructor( orientation, parent.nativeHandle, labelUtf8 );
    malloc.free( labelUtf8 );
  }
  WxStaticBoxSizer.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  WxStaticBox getStaticBox( ) {
    final returnedNativeHandle = _wxStaticBoxSizerGetStaticBox( nativeHandle  );
    WxEvtHandler? eh = _evtHandlerList[returnedNativeHandle];
    if (eh != null) {
      // There already is a Dart class associated with this C++ object
      return eh as WxStaticBox;
    }
    return WxStaticBox.fromHandle( returnedNativeHandle );
  }
}

// ------------------------- wxWrapSizer ----------------------

typedef _WxWrapSizerConstructorNative = Pointer Function( Int32, Int32  );
typedef _WxWrapSizerConstructor = Pointer Function( int, int  );
late _WxWrapSizerConstructor _wxWrapSizerConstructor;

/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxREMOVE_LEADING_SPACES | 2 |

const int wxREMOVE_LEADING_SPACES = 2;

class WxWrapSizer extends WxBoxSizer {
  WxWrapSizer._defaultConstructor() : super._defaultConstructor();
  WxWrapSizer( { int orientation = wxHORIZONTAL, int flags = wxREMOVE_LEADING_SPACES } ) : super._defaultConstructor() {
    nativeHandle = _wxWrapSizerConstructor( orientation, flags );
  }
  WxWrapSizer.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }
}

// ------------------------- wxGridSizer ----------------------

typedef _WxGridSizerConstructorNative = Pointer Function( Int32, Int32, Int32  );
typedef _WxGridSizerConstructor = Pointer Function( int, int, int  );
late _WxGridSizerConstructor _wxGridSizerConstructor;

typedef _WxGridSizerGetEffectiveColsCountNative = Int32 Function( Pointer  );
typedef _WxGridSizerGetEffectiveColsCount = int Function( Pointer  );
late _WxGridSizerGetEffectiveColsCount _wxGridSizerGetEffectiveColsCount;

typedef _WxGridSizerGetEffectiveRowsCountNative = Int32 Function( Pointer  );
typedef _WxGridSizerGetEffectiveRowsCount = int Function( Pointer  );
late _WxGridSizerGetEffectiveRowsCount _wxGridSizerGetEffectiveRowsCount;

typedef _WxGridSizerSetColsNative = Void Function( Pointer, Int32  );
typedef _WxGridSizerSetCols = void Function( Pointer, int  );
late _WxGridSizerSetCols _wxGridSizerSetCols;

typedef _WxGridSizerGetColsNative = Int32 Function( Pointer  );
typedef _WxGridSizerGetCols = int Function( Pointer  );
late _WxGridSizerGetCols _wxGridSizerGetCols;

typedef _WxGridSizerSetRowsNative = Void Function( Pointer, Int32  );
typedef _WxGridSizerSetRows = void Function( Pointer, int  );
late _WxGridSizerSetRows _wxGridSizerSetRows;

typedef _WxGridSizerGetRowsNative = Int32 Function( Pointer  );
typedef _WxGridSizerGetRows = int Function( Pointer  );
late _WxGridSizerGetRows _wxGridSizerGetRows;

typedef _WxGridSizerSetHGapNative = Void Function( Pointer, Int32  );
typedef _WxGridSizerSetHGap = void Function( Pointer, int  );
late _WxGridSizerSetHGap _wxGridSizerSetHGap;

typedef _WxGridSizerGetHGapNative = Int32 Function( Pointer  );
typedef _WxGridSizerGetHGap = int Function( Pointer  );
late _WxGridSizerGetHGap _wxGridSizerGetHGap;

typedef _WxGridSizerSetVGapNative = Void Function( Pointer, Int32  );
typedef _WxGridSizerSetVGap = void Function( Pointer, int  );
late _WxGridSizerSetVGap _wxGridSizerSetVGap;

typedef _WxGridSizerGetVGapNative = Int32 Function( Pointer  );
typedef _WxGridSizerGetVGap = int Function( Pointer  );
late _WxGridSizerGetVGap _wxGridSizerGetVGap;

class WxGridSizer extends WxSizer {
  WxGridSizer._defaultConstructor() : super._defaultConstructor();
  WxGridSizer( int cols, { int vgap = 0, int hgap = 0 } ) : super._defaultConstructor() {
    nativeHandle = _wxGridSizerConstructor( cols, vgap, hgap );
  }
  WxGridSizer.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  int getEffectiveColsCount( ) {
    return _wxGridSizerGetEffectiveColsCount( nativeHandle  );
  }

  int getEffectiveRowsCount( ) {
    return _wxGridSizerGetEffectiveRowsCount( nativeHandle  );
  }

  void setCols( int cols ) {
    _wxGridSizerSetCols( nativeHandle, cols );
  }

  int getCols( ) {
    return _wxGridSizerGetCols( nativeHandle  );
  }

  void setRows( int rows ) {
    _wxGridSizerSetRows( nativeHandle, rows );
  }

  int getRows( ) {
    return _wxGridSizerGetRows( nativeHandle  );
  }

  void setHGap( int hgap ) {
    _wxGridSizerSetHGap( nativeHandle, hgap );
  }

  int getHGap( ) {
    return _wxGridSizerGetHGap( nativeHandle  );
  }

  void setVGap( int vgap ) {
    _wxGridSizerSetVGap( nativeHandle, vgap );
  }

  int getVGap( ) {
    return _wxGridSizerGetVGap( nativeHandle  );
  }
}

// ------------------------- wxFlexGridSizer ----------------------

typedef _WxFlexGridSizerConstructorNative = Pointer Function( Int32, Int32, Int32  );
typedef _WxFlexGridSizerConstructor = Pointer Function( int, int, int  );
late _WxFlexGridSizerConstructor _wxFlexGridSizerConstructor;

typedef _WxFlexGridSizerAddGrowableColNative = Void Function( Pointer, Int32, Int32  );
typedef _WxFlexGridSizerAddGrowableCol = void Function( Pointer, int, int  );
late _WxFlexGridSizerAddGrowableCol _wxFlexGridSizerAddGrowableCol;

typedef _WxFlexGridSizerAddGrowableRowNative = Void Function( Pointer, Int32, Int32  );
typedef _WxFlexGridSizerAddGrowableRow = void Function( Pointer, int, int  );
late _WxFlexGridSizerAddGrowableRow _wxFlexGridSizerAddGrowableRow;

typedef _WxFlexGridSizerRemoveGrowableColNative = Void Function( Pointer, Int32  );
typedef _WxFlexGridSizerRemoveGrowableCol = void Function( Pointer, int  );
late _WxFlexGridSizerRemoveGrowableCol _wxFlexGridSizerRemoveGrowableCol;

typedef _WxFlexGridSizerRemoveGrowableRowNative = Void Function( Pointer, Int32  );
typedef _WxFlexGridSizerRemoveGrowableRow = void Function( Pointer, int  );
late _WxFlexGridSizerRemoveGrowableRow _wxFlexGridSizerRemoveGrowableRow;

typedef _WxFlexGridSizerIsColGrowableNative = Bool Function( Pointer, Int32  );
typedef _WxFlexGridSizerIsColGrowable = bool Function( Pointer, int  );
late _WxFlexGridSizerIsColGrowable _wxFlexGridSizerIsColGrowable;

typedef _WxFlexGridSizerIsRowGrowableNative = Bool Function( Pointer, Int32  );
typedef _WxFlexGridSizerIsRowGrowable = bool Function( Pointer, int  );
late _WxFlexGridSizerIsRowGrowable _wxFlexGridSizerIsRowGrowable;

typedef _WxFlexGridSizerSetFlexibleDirectionNative = Void Function( Pointer, Int32  );
typedef _WxFlexGridSizerSetFlexibleDirection = void Function( Pointer, int  );
late _WxFlexGridSizerSetFlexibleDirection _wxFlexGridSizerSetFlexibleDirection;

typedef _WxFlexGridSizerGetFlexibleDirectionNative = Int32 Function( Pointer  );
typedef _WxFlexGridSizerGetFlexibleDirection = int Function( Pointer  );
late _WxFlexGridSizerGetFlexibleDirection _wxFlexGridSizerGetFlexibleDirection;

typedef _WxFlexGridSizerSetNonFlexibleGrowModeNative = Void Function( Pointer, Int32  );
typedef _WxFlexGridSizerSetNonFlexibleGrowMode = void Function( Pointer, int  );
late _WxFlexGridSizerSetNonFlexibleGrowMode _wxFlexGridSizerSetNonFlexibleGrowMode;

typedef _WxFlexGridSizerGetNonFlexibleGrowModeNative = Int32 Function( Pointer  );
typedef _WxFlexGridSizerGetNonFlexibleGrowMode = int Function( Pointer  );
late _WxFlexGridSizerGetNonFlexibleGrowMode _wxFlexGridSizerGetNonFlexibleGrowMode;

/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxFLEX_GROWMODE_NONE | 0 |
/// | wxFLEX_GROWMODE_SPECIFIED | 1 |
/// | wxFLEX_GROWMODE_ALL | 2 |

const int wxFLEX_GROWMODE_NONE = 0;
const int wxFLEX_GROWMODE_SPECIFIED = 1;
const int wxFLEX_GROWMODE_ALL = 2;

class WxFlexGridSizer extends WxGridSizer {
  WxFlexGridSizer._defaultConstructor() : super._defaultConstructor();
  WxFlexGridSizer( int cols, { int vgap = 0, int hgap = 0 } ) : super._defaultConstructor() {
    nativeHandle = _wxFlexGridSizerConstructor( cols, vgap, hgap );
  }
  WxFlexGridSizer.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  void addGrowableCol( int index, { int proportion = 0 } ) {
    _wxFlexGridSizerAddGrowableCol( nativeHandle, index, proportion );
  }

  void addGrowableRow( int index, { int proportion = 0 } ) {
    _wxFlexGridSizerAddGrowableRow( nativeHandle, index, proportion );
  }

  void removeGrowableCol( int index ) {
    _wxFlexGridSizerRemoveGrowableCol( nativeHandle, index );
  }

  void removeGrowableRow( int index ) {
    _wxFlexGridSizerRemoveGrowableRow( nativeHandle, index );
  }

  bool isColGrowable( int index ) {
    return _wxFlexGridSizerIsColGrowable( nativeHandle, index );
  }

  bool isRowGrowable( int index ) {
    return _wxFlexGridSizerIsRowGrowable( nativeHandle, index );
  }

  void setFlexibleDirection( int direction ) {
    _wxFlexGridSizerSetFlexibleDirection( nativeHandle, direction );
  }

  int getFlexibleDirection( ) {
    return _wxFlexGridSizerGetFlexibleDirection( nativeHandle  );
  }

  void setNonFlexibleGrowMode( int mode ) {
    _wxFlexGridSizerSetNonFlexibleGrowMode( nativeHandle, mode );
  }

  int getNonFlexibleGrowMode( ) {
    return _wxFlexGridSizerGetNonFlexibleGrowMode( nativeHandle  );
  }
}


void setupWxSizer( DynamicLibrary dylib )
{
  // ------------------------- wxSizerItem ----------------------

  final wxSizerItemConstructorPtr = dylib.lookup <NativeFunction<_WxSizerItemConstructorNative>>('wxSizerItemConstructor');
  _wxSizerItemConstructor = wxSizerItemConstructorPtr.asFunction<_WxSizerItemConstructor>();

  final wxSizerItemIsWindowPtr = dylib.lookup <NativeFunction<_WxSizerItemIsWindowNative>>('wxSizerItemIsWindow');
  _wxSizerItemIsWindow = wxSizerItemIsWindowPtr.asFunction<_WxSizerItemIsWindow>();

  final wxSizerItemIsSizerPtr = dylib.lookup <NativeFunction<_WxSizerItemIsSizerNative>>('wxSizerItemIsSizer');
  _wxSizerItemIsSizer = wxSizerItemIsSizerPtr.asFunction<_WxSizerItemIsSizer>();

  final wxSizerItemIsSpacerPtr = dylib.lookup <NativeFunction<_WxSizerItemIsSpacerNative>>('wxSizerItemIsSpacer');
  _wxSizerItemIsSpacer = wxSizerItemIsSpacerPtr.asFunction<_WxSizerItemIsSpacer>();

  final wxSizerItemGetPositionPtr = dylib.lookup <NativeFunction<_WxSizerItemGetPositionNative>>('wxSizerItemGetPosition');
  _wxSizerItemGetPosition = wxSizerItemGetPositionPtr.asFunction<_WxSizerItemGetPosition>();

  final wxSizerItemGetSizePtr = dylib.lookup <NativeFunction<_WxSizerItemGetSizeNative>>('wxSizerItemGetSize');
  _wxSizerItemGetSize = wxSizerItemGetSizePtr.asFunction<_WxSizerItemGetSize>();

  final wxSizerItemGetFlagPtr = dylib.lookup <NativeFunction<_WxSizerItemGetFlagNative>>('wxSizerItemGetFlag');
  _wxSizerItemGetFlag = wxSizerItemGetFlagPtr.asFunction<_WxSizerItemGetFlag>();

  final wxSizerItemGetBorderPtr = dylib.lookup <NativeFunction<_WxSizerItemGetBorderNative>>('wxSizerItemGetBorder');
  _wxSizerItemGetBorder = wxSizerItemGetBorderPtr.asFunction<_WxSizerItemGetBorder>();

  final wxSizerItemGetProportionPtr = dylib.lookup <NativeFunction<_WxSizerItemGetProportionNative>>('wxSizerItemGetProportion');
  _wxSizerItemGetProportion = wxSizerItemGetProportionPtr.asFunction<_WxSizerItemGetProportion>();

  final wxSizerItemGetSizerPtr = dylib.lookup <NativeFunction<_WxSizerItemGetSizerNative>>('wxSizerItemGetSizer');
  _wxSizerItemGetSizer = wxSizerItemGetSizerPtr.asFunction<_WxSizerItemGetSizer>();

  final wxSizerItemGetWindowPtr = dylib.lookup <NativeFunction<_WxSizerItemGetWindowNative>>('wxSizerItemGetWindow');
  _wxSizerItemGetWindow = wxSizerItemGetWindowPtr.asFunction<_WxSizerItemGetWindow>();

  final wxSizerItemSetFlagPtr = dylib.lookup <NativeFunction<_WxSizerItemSetFlagNative>>('wxSizerItemSetFlag');
  _wxSizerItemSetFlag = wxSizerItemSetFlagPtr.asFunction<_WxSizerItemSetFlag>();

  final wxSizerItemSetBorderPtr = dylib.lookup <NativeFunction<_WxSizerItemSetBorderNative>>('wxSizerItemSetBorder');
  _wxSizerItemSetBorder = wxSizerItemSetBorderPtr.asFunction<_WxSizerItemSetBorder>();

  final wxSizerItemSetProportionPtr = dylib.lookup <NativeFunction<_WxSizerItemSetProportionNative>>('wxSizerItemSetProportion');
  _wxSizerItemSetProportion = wxSizerItemSetProportionPtr.asFunction<_WxSizerItemSetProportion>();

  // ------------------------- wxSizer ----------------------

  final wxSizerLayoutPtr = dylib.lookup <NativeFunction<_WxSizerLayoutNative>>('wxSizerLayout');
  _wxSizerLayout = wxSizerLayoutPtr.asFunction<_WxSizerLayout>();

  final wxSizerGetSizePtr = dylib.lookup <NativeFunction<_WxSizerGetSizeNative>>('wxSizerGetSize');
  _wxSizerGetSize = wxSizerGetSizePtr.asFunction<_WxSizerGetSize>();

  final wxSizerGetMinSizePtr = dylib.lookup <NativeFunction<_WxSizerGetMinSizeNative>>('wxSizerGetMinSize');
  _wxSizerGetMinSize = wxSizerGetMinSizePtr.asFunction<_WxSizerGetMinSize>();

  final wxSizerGetPositionPtr = dylib.lookup <NativeFunction<_WxSizerGetPositionNative>>('wxSizerGetPosition');
  _wxSizerGetPosition = wxSizerGetPositionPtr.asFunction<_WxSizerGetPosition>();

  final wxSizerRemovePtr = dylib.lookup <NativeFunction<_WxSizerRemoveNative>>('wxSizerRemove');
  _wxSizerRemove = wxSizerRemovePtr.asFunction<_WxSizerRemove>();

  final wxSizerRemoveSizerPtr = dylib.lookup <NativeFunction<_WxSizerRemoveSizerNative>>('wxSizerRemoveSizer');
  _wxSizerRemoveSizer = wxSizerRemoveSizerPtr.asFunction<_WxSizerRemoveSizer>();

  final wxSizerRemoveWindowPtr = dylib.lookup <NativeFunction<_WxSizerRemoveWindowNative>>('wxSizerRemoveWindow');
  _wxSizerRemoveWindow = wxSizerRemoveWindowPtr.asFunction<_WxSizerRemoveWindow>();

  final wxSizerGetItemCountPtr = dylib.lookup <NativeFunction<_WxSizerGetItemCountNative>>('wxSizerGetItemCount');
  _wxSizerGetItemCount = wxSizerGetItemCountPtr.asFunction<_WxSizerGetItemCount>();

  final wxSizerGetItemPtr = dylib.lookup <NativeFunction<_WxSizerGetItemNative>>('wxSizerGetItem');
  _wxSizerGetItem = wxSizerGetItemPtr.asFunction<_WxSizerGetItem>();

  final wxSizerGetWindowItemPtr = dylib.lookup <NativeFunction<_WxSizerGetWindowItemNative>>('wxSizerGetWindowItem');
  _wxSizerGetWindowItem = wxSizerGetWindowItemPtr.asFunction<_WxSizerGetWindowItem>();

  final wxSizerGetSizerItemPtr = dylib.lookup <NativeFunction<_WxSizerGetSizerItemNative>>('wxSizerGetSizerItem');
  _wxSizerGetSizerItem = wxSizerGetSizerItemPtr.asFunction<_WxSizerGetSizerItem>();

  final wxSizerAddPtr = dylib.lookup <NativeFunction<_WxSizerAddNative>>('wxSizerAdd');
  _wxSizerAdd = wxSizerAddPtr.asFunction<_WxSizerAdd>();

  final wxSizerAddSizerPtr = dylib.lookup <NativeFunction<_WxSizerAddSizerNative>>('wxSizerAddSizer');
  _wxSizerAddSizer = wxSizerAddSizerPtr.asFunction<_WxSizerAddSizer>();

  final wxSizerAddSpacerPtr = dylib.lookup <NativeFunction<_WxSizerAddSpacerNative>>('wxSizerAddSpacer');
  _wxSizerAddSpacer = wxSizerAddSpacerPtr.asFunction<_WxSizerAddSpacer>();

  final wxSizerAddStretchSpacerPtr = dylib.lookup <NativeFunction<_WxSizerAddStretchSpacerNative>>('wxSizerAddStretchSpacer');
  _wxSizerAddStretchSpacer = wxSizerAddStretchSpacerPtr.asFunction<_WxSizerAddStretchSpacer>();

  final wxSizerPrependPtr = dylib.lookup <NativeFunction<_WxSizerPrependNative>>('wxSizerPrepend');
  _wxSizerPrepend = wxSizerPrependPtr.asFunction<_WxSizerPrepend>();

  final wxSizerPrependSizerPtr = dylib.lookup <NativeFunction<_WxSizerPrependSizerNative>>('wxSizerPrependSizer');
  _wxSizerPrependSizer = wxSizerPrependSizerPtr.asFunction<_WxSizerPrependSizer>();

  final wxSizerPrependSpacerPtr = dylib.lookup <NativeFunction<_WxSizerPrependSpacerNative>>('wxSizerPrependSpacer');
  _wxSizerPrependSpacer = wxSizerPrependSpacerPtr.asFunction<_WxSizerPrependSpacer>();

  final wxSizerPrependStretchSpacerPtr = dylib.lookup <NativeFunction<_WxSizerPrependStretchSpacerNative>>('wxSizerPrependStretchSpacer');
  _wxSizerPrependStretchSpacer = wxSizerPrependStretchSpacerPtr.asFunction<_WxSizerPrependStretchSpacer>();

  final wxSizerInsertPtr = dylib.lookup <NativeFunction<_WxSizerInsertNative>>('wxSizerInsert');
  _wxSizerInsert = wxSizerInsertPtr.asFunction<_WxSizerInsert>();

  final wxSizerInsertSizerPtr = dylib.lookup <NativeFunction<_WxSizerInsertSizerNative>>('wxSizerInsertSizer');
  _wxSizerInsertSizer = wxSizerInsertSizerPtr.asFunction<_WxSizerInsertSizer>();

  final wxSizerInsertSpacerPtr = dylib.lookup <NativeFunction<_WxSizerInsertSpacerNative>>('wxSizerInsertSpacer');
  _wxSizerInsertSpacer = wxSizerInsertSpacerPtr.asFunction<_WxSizerInsertSpacer>();

  final wxSizerInsertStretchSpacerPtr = dylib.lookup <NativeFunction<_WxSizerInsertStretchSpacerNative>>('wxSizerInsertStretchSpacer');
  _wxSizerInsertStretchSpacer = wxSizerInsertStretchSpacerPtr.asFunction<_WxSizerInsertStretchSpacer>();

  // ------------------------- wxBoxSizer ----------------------

  final wxBoxSizerConstructorPtr = dylib.lookup <NativeFunction<_WxBoxSizerConstructorNative>>('wxBoxSizerConstructor');
  _wxBoxSizerConstructor = wxBoxSizerConstructorPtr.asFunction<_WxBoxSizerConstructor>();

  final wxBoxSizerSetOrientationPtr = dylib.lookup <NativeFunction<_WxBoxSizerSetOrientationNative>>('wxBoxSizerSetOrientation');
  _wxBoxSizerSetOrientation = wxBoxSizerSetOrientationPtr.asFunction<_WxBoxSizerSetOrientation>();

  final wxBoxSizerGetOrientationPtr = dylib.lookup <NativeFunction<_WxBoxSizerGetOrientationNative>>('wxBoxSizerGetOrientation');
  _wxBoxSizerGetOrientation = wxBoxSizerGetOrientationPtr.asFunction<_WxBoxSizerGetOrientation>();

  // ------------------------- wxStaticBoxSizer ----------------------

  final wxStaticBoxSizerConstructorPtr = dylib.lookup <NativeFunction<_WxStaticBoxSizerConstructorNative>>('wxStaticBoxSizerConstructor');
  _wxStaticBoxSizerConstructor = wxStaticBoxSizerConstructorPtr.asFunction<_WxStaticBoxSizerConstructor>();

  final wxStaticBoxSizerGetStaticBoxPtr = dylib.lookup <NativeFunction<_WxStaticBoxSizerGetStaticBoxNative>>('wxStaticBoxSizerGetStaticBox');
  _wxStaticBoxSizerGetStaticBox = wxStaticBoxSizerGetStaticBoxPtr.asFunction<_WxStaticBoxSizerGetStaticBox>();

  // ------------------------- wxWrapSizer ----------------------

  final wxWrapSizerConstructorPtr = dylib.lookup <NativeFunction<_WxWrapSizerConstructorNative>>('wxWrapSizerConstructor');
  _wxWrapSizerConstructor = wxWrapSizerConstructorPtr.asFunction<_WxWrapSizerConstructor>();

  // ------------------------- wxGridSizer ----------------------

  final wxGridSizerConstructorPtr = dylib.lookup <NativeFunction<_WxGridSizerConstructorNative>>('wxGridSizerConstructor');
  _wxGridSizerConstructor = wxGridSizerConstructorPtr.asFunction<_WxGridSizerConstructor>();

  final wxGridSizerGetEffectiveColsCountPtr = dylib.lookup <NativeFunction<_WxGridSizerGetEffectiveColsCountNative>>('wxGridSizerGetEffectiveColsCount');
  _wxGridSizerGetEffectiveColsCount = wxGridSizerGetEffectiveColsCountPtr.asFunction<_WxGridSizerGetEffectiveColsCount>();

  final wxGridSizerGetEffectiveRowsCountPtr = dylib.lookup <NativeFunction<_WxGridSizerGetEffectiveRowsCountNative>>('wxGridSizerGetEffectiveRowsCount');
  _wxGridSizerGetEffectiveRowsCount = wxGridSizerGetEffectiveRowsCountPtr.asFunction<_WxGridSizerGetEffectiveRowsCount>();

  final wxGridSizerSetColsPtr = dylib.lookup <NativeFunction<_WxGridSizerSetColsNative>>('wxGridSizerSetCols');
  _wxGridSizerSetCols = wxGridSizerSetColsPtr.asFunction<_WxGridSizerSetCols>();

  final wxGridSizerGetColsPtr = dylib.lookup <NativeFunction<_WxGridSizerGetColsNative>>('wxGridSizerGetCols');
  _wxGridSizerGetCols = wxGridSizerGetColsPtr.asFunction<_WxGridSizerGetCols>();

  final wxGridSizerSetRowsPtr = dylib.lookup <NativeFunction<_WxGridSizerSetRowsNative>>('wxGridSizerSetRows');
  _wxGridSizerSetRows = wxGridSizerSetRowsPtr.asFunction<_WxGridSizerSetRows>();

  final wxGridSizerGetRowsPtr = dylib.lookup <NativeFunction<_WxGridSizerGetRowsNative>>('wxGridSizerGetRows');
  _wxGridSizerGetRows = wxGridSizerGetRowsPtr.asFunction<_WxGridSizerGetRows>();

  final wxGridSizerSetHGapPtr = dylib.lookup <NativeFunction<_WxGridSizerSetHGapNative>>('wxGridSizerSetHGap');
  _wxGridSizerSetHGap = wxGridSizerSetHGapPtr.asFunction<_WxGridSizerSetHGap>();

  final wxGridSizerGetHGapPtr = dylib.lookup <NativeFunction<_WxGridSizerGetHGapNative>>('wxGridSizerGetHGap');
  _wxGridSizerGetHGap = wxGridSizerGetHGapPtr.asFunction<_WxGridSizerGetHGap>();

  final wxGridSizerSetVGapPtr = dylib.lookup <NativeFunction<_WxGridSizerSetVGapNative>>('wxGridSizerSetVGap');
  _wxGridSizerSetVGap = wxGridSizerSetVGapPtr.asFunction<_WxGridSizerSetVGap>();

  final wxGridSizerGetVGapPtr = dylib.lookup <NativeFunction<_WxGridSizerGetVGapNative>>('wxGridSizerGetVGap');
  _wxGridSizerGetVGap = wxGridSizerGetVGapPtr.asFunction<_WxGridSizerGetVGap>();

  // ------------------------- wxFlexGridSizer ----------------------

  final wxFlexGridSizerConstructorPtr = dylib.lookup <NativeFunction<_WxFlexGridSizerConstructorNative>>('wxFlexGridSizerConstructor');
  _wxFlexGridSizerConstructor = wxFlexGridSizerConstructorPtr.asFunction<_WxFlexGridSizerConstructor>();

  final wxFlexGridSizerAddGrowableColPtr = dylib.lookup <NativeFunction<_WxFlexGridSizerAddGrowableColNative>>('wxFlexGridSizerAddGrowableCol');
  _wxFlexGridSizerAddGrowableCol = wxFlexGridSizerAddGrowableColPtr.asFunction<_WxFlexGridSizerAddGrowableCol>();

  final wxFlexGridSizerAddGrowableRowPtr = dylib.lookup <NativeFunction<_WxFlexGridSizerAddGrowableRowNative>>('wxFlexGridSizerAddGrowableRow');
  _wxFlexGridSizerAddGrowableRow = wxFlexGridSizerAddGrowableRowPtr.asFunction<_WxFlexGridSizerAddGrowableRow>();

  final wxFlexGridSizerRemoveGrowableColPtr = dylib.lookup <NativeFunction<_WxFlexGridSizerRemoveGrowableColNative>>('wxFlexGridSizerRemoveGrowableCol');
  _wxFlexGridSizerRemoveGrowableCol = wxFlexGridSizerRemoveGrowableColPtr.asFunction<_WxFlexGridSizerRemoveGrowableCol>();

  final wxFlexGridSizerRemoveGrowableRowPtr = dylib.lookup <NativeFunction<_WxFlexGridSizerRemoveGrowableRowNative>>('wxFlexGridSizerRemoveGrowableRow');
  _wxFlexGridSizerRemoveGrowableRow = wxFlexGridSizerRemoveGrowableRowPtr.asFunction<_WxFlexGridSizerRemoveGrowableRow>();

  final wxFlexGridSizerIsColGrowablePtr = dylib.lookup <NativeFunction<_WxFlexGridSizerIsColGrowableNative>>('wxFlexGridSizerIsColGrowable');
  _wxFlexGridSizerIsColGrowable = wxFlexGridSizerIsColGrowablePtr.asFunction<_WxFlexGridSizerIsColGrowable>();

  final wxFlexGridSizerIsRowGrowablePtr = dylib.lookup <NativeFunction<_WxFlexGridSizerIsRowGrowableNative>>('wxFlexGridSizerIsRowGrowable');
  _wxFlexGridSizerIsRowGrowable = wxFlexGridSizerIsRowGrowablePtr.asFunction<_WxFlexGridSizerIsRowGrowable>();

  final wxFlexGridSizerSetFlexibleDirectionPtr = dylib.lookup <NativeFunction<_WxFlexGridSizerSetFlexibleDirectionNative>>('wxFlexGridSizerSetFlexibleDirection');
  _wxFlexGridSizerSetFlexibleDirection = wxFlexGridSizerSetFlexibleDirectionPtr.asFunction<_WxFlexGridSizerSetFlexibleDirection>();

  final wxFlexGridSizerGetFlexibleDirectionPtr = dylib.lookup <NativeFunction<_WxFlexGridSizerGetFlexibleDirectionNative>>('wxFlexGridSizerGetFlexibleDirection');
  _wxFlexGridSizerGetFlexibleDirection = wxFlexGridSizerGetFlexibleDirectionPtr.asFunction<_WxFlexGridSizerGetFlexibleDirection>();

  final wxFlexGridSizerSetNonFlexibleGrowModePtr = dylib.lookup <NativeFunction<_WxFlexGridSizerSetNonFlexibleGrowModeNative>>('wxFlexGridSizerSetNonFlexibleGrowMode');
  _wxFlexGridSizerSetNonFlexibleGrowMode = wxFlexGridSizerSetNonFlexibleGrowModePtr.asFunction<_WxFlexGridSizerSetNonFlexibleGrowMode>();

  final wxFlexGridSizerGetNonFlexibleGrowModePtr = dylib.lookup <NativeFunction<_WxFlexGridSizerGetNonFlexibleGrowModeNative>>('wxFlexGridSizerGetNonFlexibleGrowMode');
  _wxFlexGridSizerGetNonFlexibleGrowMode = wxFlexGridSizerGetNonFlexibleGrowModePtr.asFunction<_WxFlexGridSizerGetNonFlexibleGrowMode>();

}
