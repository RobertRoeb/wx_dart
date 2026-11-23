// -------------------------------------------------------------
// Purpose:     Dart bindings for wxWidgets
// Author:      Robert Roebling
// Modified by: The magic C++ to Dart code generator
// Created:     07/01/2025
// Copyright:   (c) Robert Roebling
// Licence:     wxWindows licence 3.1
// -------------------------------------------------------------

part of '../wx_dart.dart';

// ------------------------- wxMenuBar ----------------------

typedef _WxMenuBarConstructorNative = Pointer Function( Int32  );
typedef _WxMenuBarConstructor = Pointer Function( int  );
late _WxMenuBarConstructor _wxMenuBarConstructor;

typedef _WxMenuBarFindItemNative = Pointer Function( Pointer, Int32  );
typedef _WxMenuBarFindItem = Pointer Function( Pointer, int  );
late _WxMenuBarFindItem _wxMenuBarFindItem;

typedef _WxMenuBarGetMenuCountNative = Int32 Function( Pointer  );
typedef _WxMenuBarGetMenuCount = int Function( Pointer  );
late _WxMenuBarGetMenuCount _wxMenuBarGetMenuCount;

typedef _WxMenuBarGetMenuNative = Pointer Function( Pointer, Int32  );
typedef _WxMenuBarGetMenu = Pointer Function( Pointer, int  );
late _WxMenuBarGetMenu _wxMenuBarGetMenu;

typedef _WxMenuBarRemoveNative = Pointer Function( Pointer, Int32  );
typedef _WxMenuBarRemove = Pointer Function( Pointer, int  );
late _WxMenuBarRemove _wxMenuBarRemove;

typedef _WxMenuBarAppendNative = Bool Function( Pointer, Pointer, Pointer<Utf8>  );
typedef _WxMenuBarAppend = bool Function( Pointer, Pointer, Pointer<Utf8>  );
late _WxMenuBarAppend _wxMenuBarAppend;

typedef _WxMenuBarInsertNative = Bool Function( Pointer, Int32, Pointer, Pointer<Utf8>  );
typedef _WxMenuBarInsert = bool Function( Pointer, int, Pointer, Pointer<Utf8>  );
late _WxMenuBarInsert _wxMenuBarInsert;

typedef _WxMenuBarCheckItemNative = Void Function( Pointer, Int32, Bool  );
typedef _WxMenuBarCheckItem = void Function( Pointer, int, bool  );
late _WxMenuBarCheckItem _wxMenuBarCheckItem;

typedef _WxMenuBarEnableItemNative = Void Function( Pointer, Int32, Bool  );
typedef _WxMenuBarEnableItem = void Function( Pointer, int, bool  );
late _WxMenuBarEnableItem _wxMenuBarEnableItem;

typedef _WxMenuBarIsItemCheckedNative = Bool Function( Pointer, Int32  );
typedef _WxMenuBarIsItemChecked = bool Function( Pointer, int  );
late _WxMenuBarIsItemChecked _wxMenuBarIsItemChecked;

typedef _WxMenuBarIsItemEnabledNative = Bool Function( Pointer, Int32  );
typedef _WxMenuBarIsItemEnabled = bool Function( Pointer, int  );
late _WxMenuBarIsItemEnabled _wxMenuBarIsItemEnabled;

/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxMB_DOCKABLE | 0x0001 |
/// | wxMB_UNDERLINE | 0x0002 |

const int wxMB_DOCKABLE = 0x0001;
const int wxMB_UNDERLINE = 0x0002;

class WxMenuBar extends WxWindow {
  WxMenuBar._defaultConstructor() : super._defaultConstructor();
  WxMenuBar( { int style = 0 } ) : super._defaultConstructor() {
    nativeHandle = _wxMenuBarConstructor( style );
    _postCreation();
  }
  WxMenuBar.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  WxMenuItem? findItem( int Id ) {
    final returnedNativeHandle = _wxMenuBarFindItem( nativeHandle, Id );
    if (returnedNativeHandle == nullptr) return null;
    return WxMenuItem.fromHandle( returnedNativeHandle );
  }

  int getMenuCount( ) {
    return _wxMenuBarGetMenuCount( nativeHandle  );
  }

  WxMenu? getMenu( int pos ) {
    final returnedNativeHandle = _wxMenuBarGetMenu( nativeHandle, pos );
    if (returnedNativeHandle == nullptr) return null;
    WxEvtHandler? eh = _evtHandlerList[returnedNativeHandle];
    if (eh != null) {
      // There already is a Dart class associated with this C++ object
      return eh as WxMenu;
    }
    return WxMenu.fromHandle( returnedNativeHandle );
  }

  WxMenu? remove( int pos ) {
    final returnedNativeHandle = _wxMenuBarRemove( nativeHandle, pos );
    if (returnedNativeHandle == nullptr) return null;
    WxEvtHandler? eh = _evtHandlerList[returnedNativeHandle];
    if (eh != null) {
      // There already is a Dart class associated with this C++ object
      return eh as WxMenu;
    }
    return WxMenu.fromHandle( returnedNativeHandle );
  }

  bool append( WxMenu menu, String title ) {
    final titleUtf8 = title.toNativeUtf8();
    return _wxMenuBarAppend( nativeHandle, menu.nativeHandle, titleUtf8 );
  }

  bool insert( int pos, WxMenu menu, String title ) {
    final titleUtf8 = title.toNativeUtf8();
    return _wxMenuBarInsert( nativeHandle, pos, menu.nativeHandle, titleUtf8 );
  }

  void checkItem( int id, { bool check = true } ) {
    _wxMenuBarCheckItem( nativeHandle, id, check );
  }

  void enableItem( int id, { bool enable = true } ) {
    _wxMenuBarEnableItem( nativeHandle, id, enable );
  }

  bool isItemChecked( int id ) {
    return _wxMenuBarIsItemChecked( nativeHandle, id );
  }

  bool isItemEnabled( int id ) {
    return _wxMenuBarIsItemEnabled( nativeHandle, id );
  }
}

// ------------------------- wxMenu ----------------------

typedef _WxMenuConstructorNative = Pointer Function( Int32  );
typedef _WxMenuConstructor = Pointer Function( int  );
late _WxMenuConstructor _wxMenuConstructor;

typedef _WxMenuFindItemNative = Pointer Function( Pointer, Int32  );
typedef _WxMenuFindItem = Pointer Function( Pointer, int  );
late _WxMenuFindItem _wxMenuFindItem;

typedef _WxMenuGetMenuItemCountNative = Int32 Function( Pointer  );
typedef _WxMenuGetMenuItemCount = int Function( Pointer  );
late _WxMenuGetMenuItemCount _wxMenuGetMenuItemCount;

typedef _WxMenuFindItemByPositionNative = Pointer Function( Pointer, Int32  );
typedef _WxMenuFindItemByPosition = Pointer Function( Pointer, int  );
late _WxMenuFindItemByPosition _wxMenuFindItemByPosition;

typedef _WxMenuAppendNative = Pointer Function( Pointer, Pointer  );
typedef _WxMenuAppend = Pointer Function( Pointer, Pointer  );
late _WxMenuAppend _wxMenuAppend;

typedef _WxMenuAppendItemNative = Pointer Function( Pointer, Int32, Pointer<Utf8>, Pointer<Utf8>  );
typedef _WxMenuAppendItem = Pointer Function( Pointer, int, Pointer<Utf8>, Pointer<Utf8>  );
late _WxMenuAppendItem _wxMenuAppendItem;

typedef _WxMenuAppendCheckItemNative = Pointer Function( Pointer, Int32, Pointer<Utf8>, Pointer<Utf8>  );
typedef _WxMenuAppendCheckItem = Pointer Function( Pointer, int, Pointer<Utf8>, Pointer<Utf8>  );
late _WxMenuAppendCheckItem _wxMenuAppendCheckItem;

typedef _WxMenuAppendRadioItemNative = Pointer Function( Pointer, Int32, Pointer<Utf8>, Pointer<Utf8>  );
typedef _WxMenuAppendRadioItem = Pointer Function( Pointer, int, Pointer<Utf8>, Pointer<Utf8>  );
late _WxMenuAppendRadioItem _wxMenuAppendRadioItem;

typedef _WxMenuAppendSubMenuNative = Pointer Function( Pointer, Pointer, Pointer<Utf8>, Pointer<Utf8>  );
typedef _WxMenuAppendSubMenu = Pointer Function( Pointer, Pointer, Pointer<Utf8>, Pointer<Utf8>  );
late _WxMenuAppendSubMenu _wxMenuAppendSubMenu;

typedef _WxMenuAppendSeparatorNative = Pointer Function( Pointer  );
typedef _WxMenuAppendSeparator = Pointer Function( Pointer  );
late _WxMenuAppendSeparator _wxMenuAppendSeparator;

typedef _WxMenuInsertNative = Pointer Function( Pointer, Int32, Pointer  );
typedef _WxMenuInsert = Pointer Function( Pointer, int, Pointer  );
late _WxMenuInsert _wxMenuInsert;

typedef _WxMenuInsertItemNative = Pointer Function( Pointer, Int32, Int32, Pointer<Utf8>, Pointer<Utf8>  );
typedef _WxMenuInsertItem = Pointer Function( Pointer, int, int, Pointer<Utf8>, Pointer<Utf8>  );
late _WxMenuInsertItem _wxMenuInsertItem;

typedef _WxMenuInsertCheckItemNative = Pointer Function( Pointer, Int32, Int32, Pointer<Utf8>, Pointer<Utf8>  );
typedef _WxMenuInsertCheckItem = Pointer Function( Pointer, int, int, Pointer<Utf8>, Pointer<Utf8>  );
late _WxMenuInsertCheckItem _wxMenuInsertCheckItem;

typedef _WxMenuInsertRadioItemNative = Pointer Function( Pointer, Int32, Int32, Pointer<Utf8>, Pointer<Utf8>  );
typedef _WxMenuInsertRadioItem = Pointer Function( Pointer, int, int, Pointer<Utf8>, Pointer<Utf8>  );
late _WxMenuInsertRadioItem _wxMenuInsertRadioItem;

typedef _WxMenuInsertSubMenuNative = Pointer Function( Pointer, Int32, Int32, Pointer<Utf8>, Pointer, Pointer<Utf8>  );
typedef _WxMenuInsertSubMenu = Pointer Function( Pointer, int, int, Pointer<Utf8>, Pointer, Pointer<Utf8>  );
late _WxMenuInsertSubMenu _wxMenuInsertSubMenu;

typedef _WxMenuInsertSeparatorNative = Pointer Function( Pointer, Int32  );
typedef _WxMenuInsertSeparator = Pointer Function( Pointer, int  );
late _WxMenuInsertSeparator _wxMenuInsertSeparator;

typedef _WxMenuDeleteItemNative = Bool Function( Pointer, Int32  );
typedef _WxMenuDeleteItem = bool Function( Pointer, int  );
late _WxMenuDeleteItem _wxMenuDeleteItem;

typedef _WxMenuDeleteNative = Bool Function( Pointer, Pointer  );
typedef _WxMenuDelete = bool Function( Pointer, Pointer  );
late _WxMenuDelete _wxMenuDelete;

typedef _WxMenuEnableItemNative = Void Function( Pointer, Int32, Bool  );
typedef _WxMenuEnableItem = void Function( Pointer, int, bool  );
late _WxMenuEnableItem _wxMenuEnableItem;

/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxMENU_TEAROFF | 0x0001 |

const int wxMENU_TEAROFF = 0x0001;

class WxMenu extends WxEvtHandler {
  WxMenu._defaultConstructor() : super._defaultConstructor();
  WxMenu( { int style = 0 } ) : super._defaultConstructor() {
    nativeHandle = _wxMenuConstructor( style );
    _postCreation();
  }
  WxMenu.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  WxMenuItem? findItem( int Id ) {
    final returnedNativeHandle = _wxMenuFindItem( nativeHandle, Id );
    if (returnedNativeHandle == nullptr) return null;
    return WxMenuItem.fromHandle( returnedNativeHandle );
  }

  int getMenuItemCount( ) {
    return _wxMenuGetMenuItemCount( nativeHandle  );
  }

  WxMenuItem? findItemByPosition( int position ) {
    final returnedNativeHandle = _wxMenuFindItemByPosition( nativeHandle, position );
    if (returnedNativeHandle == nullptr) return null;
    return WxMenuItem.fromHandle( returnedNativeHandle );
  }

  WxMenuItem append( WxMenuItem item ) {
    final returnedNativeHandle = _wxMenuAppend( nativeHandle, item.nativeHandle );
    return WxMenuItem.fromHandle( returnedNativeHandle );
  }

  WxMenuItem appendItem( int id, String item, { String help = "" } ) {
    final itemUtf8 = item.toNativeUtf8();
    final helpUtf8 = help.toNativeUtf8();
    final returnedNativeHandle = _wxMenuAppendItem( nativeHandle, id, itemUtf8, helpUtf8 );
    return WxMenuItem.fromHandle( returnedNativeHandle );
  }

  WxMenuItem appendCheckItem( int id, String item, { String help = "" } ) {
    final itemUtf8 = item.toNativeUtf8();
    final helpUtf8 = help.toNativeUtf8();
    final returnedNativeHandle = _wxMenuAppendCheckItem( nativeHandle, id, itemUtf8, helpUtf8 );
    return WxMenuItem.fromHandle( returnedNativeHandle );
  }

  WxMenuItem appendRadioItem( int id, String item, { String help = "" } ) {
    final itemUtf8 = item.toNativeUtf8();
    final helpUtf8 = help.toNativeUtf8();
    final returnedNativeHandle = _wxMenuAppendRadioItem( nativeHandle, id, itemUtf8, helpUtf8 );
    return WxMenuItem.fromHandle( returnedNativeHandle );
  }

  WxMenuItem appendSubMenu( WxMenu submenu, String item, { String help = "" } ) {
    final itemUtf8 = item.toNativeUtf8();
    final helpUtf8 = help.toNativeUtf8();
    final returnedNativeHandle = _wxMenuAppendSubMenu( nativeHandle, submenu.nativeHandle, itemUtf8, helpUtf8 );
    return WxMenuItem.fromHandle( returnedNativeHandle );
  }

  WxMenuItem appendSeparator( ) {
    final returnedNativeHandle = _wxMenuAppendSeparator( nativeHandle  );
    return WxMenuItem.fromHandle( returnedNativeHandle );
  }

  WxMenuItem insert( int pos, WxMenuItem item ) {
    final returnedNativeHandle = _wxMenuInsert( nativeHandle, pos, item.nativeHandle );
    return WxMenuItem.fromHandle( returnedNativeHandle );
  }

  WxMenuItem insertItem( int pos, int id, String item, { String help = "" } ) {
    final itemUtf8 = item.toNativeUtf8();
    final helpUtf8 = help.toNativeUtf8();
    final returnedNativeHandle = _wxMenuInsertItem( nativeHandle, pos, id, itemUtf8, helpUtf8 );
    return WxMenuItem.fromHandle( returnedNativeHandle );
  }

  WxMenuItem insertCheckItem( int pos, int id, String item, { String help = "" } ) {
    final itemUtf8 = item.toNativeUtf8();
    final helpUtf8 = help.toNativeUtf8();
    final returnedNativeHandle = _wxMenuInsertCheckItem( nativeHandle, pos, id, itemUtf8, helpUtf8 );
    return WxMenuItem.fromHandle( returnedNativeHandle );
  }

  WxMenuItem insertRadioItem( int pos, int id, String item, { String help = "" } ) {
    final itemUtf8 = item.toNativeUtf8();
    final helpUtf8 = help.toNativeUtf8();
    final returnedNativeHandle = _wxMenuInsertRadioItem( nativeHandle, pos, id, itemUtf8, helpUtf8 );
    return WxMenuItem.fromHandle( returnedNativeHandle );
  }

  WxMenuItem insertSubMenu( int pos, int id, String item, WxMenu submenu, { String help = "" } ) {
    final itemUtf8 = item.toNativeUtf8();
    final helpUtf8 = help.toNativeUtf8();
    final returnedNativeHandle = _wxMenuInsertSubMenu( nativeHandle, pos, id, itemUtf8, submenu.nativeHandle, helpUtf8 );
    return WxMenuItem.fromHandle( returnedNativeHandle );
  }

  WxMenuItem insertSeparator( int pos ) {
    final returnedNativeHandle = _wxMenuInsertSeparator( nativeHandle, pos );
    return WxMenuItem.fromHandle( returnedNativeHandle );
  }

  bool deleteItem( int id ) {
    return _wxMenuDeleteItem( nativeHandle, id );
  }

  bool delete( WxMenuItem item ) {
    return _wxMenuDelete( nativeHandle, item.nativeHandle );
  }

  void enableItem( int id, { bool enable = true } ) {
    _wxMenuEnableItem( nativeHandle, id, enable );
  }
}

// ------------------------- wxMenuItem ----------------------

typedef _WxMenuItemConstructorNative = Pointer Function( Pointer, Int32, Pointer<Utf8>, Pointer<Utf8>  );
typedef _WxMenuItemConstructor = Pointer Function( Pointer, int, Pointer<Utf8>, Pointer<Utf8>  );
late _WxMenuItemConstructor _wxMenuItemConstructor;

typedef _WxMenuItemGetHelpNative = Pointer<Utf8> Function( Pointer  );
typedef _WxMenuItemGetHelp = Pointer<Utf8> Function( Pointer  );
late _WxMenuItemGetHelp _wxMenuItemGetHelp;

typedef _WxMenuItemGetItemLabelNative = Pointer<Utf8> Function( Pointer  );
typedef _WxMenuItemGetItemLabel = Pointer<Utf8> Function( Pointer  );
late _WxMenuItemGetItemLabel _wxMenuItemGetItemLabel;

typedef _WxMenuItemGetItemLabelTextNative = Pointer<Utf8> Function( Pointer  );
typedef _WxMenuItemGetItemLabelText = Pointer<Utf8> Function( Pointer  );
late _WxMenuItemGetItemLabelText _wxMenuItemGetItemLabelText;

typedef _WxMenuItemGetIdNative = Int32 Function( Pointer  );
typedef _WxMenuItemGetId = int Function( Pointer  );
late _WxMenuItemGetId _wxMenuItemGetId;

typedef _WxMenuItemGetKindNative = Int32 Function( Pointer  );
typedef _WxMenuItemGetKind = int Function( Pointer  );
late _WxMenuItemGetKind _wxMenuItemGetKind;

typedef _WxMenuItemSetBitmapNative = Void Function( Pointer, Pointer  );
typedef _WxMenuItemSetBitmap = void Function( Pointer, Pointer  );
late _WxMenuItemSetBitmap _wxMenuItemSetBitmap;

typedef _WxMenuItemSetHelpNative = Void Function( Pointer, Pointer<Utf8>  );
typedef _WxMenuItemSetHelp = void Function( Pointer, Pointer<Utf8>  );
late _WxMenuItemSetHelp _wxMenuItemSetHelp;

typedef _WxMenuItemCheckNative = Void Function( Pointer, Bool  );
typedef _WxMenuItemCheck = void Function( Pointer, bool  );
late _WxMenuItemCheck _wxMenuItemCheck;

typedef _WxMenuItemEnableNative = Void Function( Pointer, Bool  );
typedef _WxMenuItemEnable = void Function( Pointer, bool  );
late _WxMenuItemEnable _wxMenuItemEnable;

typedef _WxMenuItemIsCheckNative = Bool Function( Pointer  );
typedef _WxMenuItemIsCheck = bool Function( Pointer  );
late _WxMenuItemIsCheck _wxMenuItemIsCheck;

typedef _WxMenuItemIsCheckedNative = Bool Function( Pointer  );
typedef _WxMenuItemIsChecked = bool Function( Pointer  );
late _WxMenuItemIsChecked _wxMenuItemIsChecked;

typedef _WxMenuItemIsCheckableNative = Bool Function( Pointer  );
typedef _WxMenuItemIsCheckable = bool Function( Pointer  );
late _WxMenuItemIsCheckable _wxMenuItemIsCheckable;

typedef _WxMenuItemIsRadioNative = Bool Function( Pointer  );
typedef _WxMenuItemIsRadio = bool Function( Pointer  );
late _WxMenuItemIsRadio _wxMenuItemIsRadio;

typedef _WxMenuItemIsEnabledNative = Bool Function( Pointer  );
typedef _WxMenuItemIsEnabled = bool Function( Pointer  );
late _WxMenuItemIsEnabled _wxMenuItemIsEnabled;

typedef _WxMenuItemIsSeparatorNative = Bool Function( Pointer  );
typedef _WxMenuItemIsSeparator = bool Function( Pointer  );
late _WxMenuItemIsSeparator _wxMenuItemIsSeparator;

class WxMenuItem extends WxObject {
  WxMenuItem._defaultConstructor() : super._defaultConstructor();
  WxMenuItem( WxMenu parent, int id, String text, { String help = "" } ) : super._defaultConstructor() {
    final textUtf8 = text.toNativeUtf8();
    final helpUtf8 = help.toNativeUtf8();
    nativeHandle = _wxMenuItemConstructor( parent.nativeHandle, id, textUtf8, helpUtf8 );
    malloc.free( textUtf8 );
    malloc.free( helpUtf8 );
  }
  WxMenuItem.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  String getHelp( ) {
    Pointer<Utf8> ptrReturn = _wxMenuItemGetHelp( nativeHandle  );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }

  String getItemLabel( ) {
    Pointer<Utf8> ptrReturn = _wxMenuItemGetItemLabel( nativeHandle  );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }

  String getItemLabelText( ) {
    Pointer<Utf8> ptrReturn = _wxMenuItemGetItemLabelText( nativeHandle  );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }

  int getId( ) {
    return _wxMenuItemGetId( nativeHandle  );
  }

  int getKind( ) {
    return _wxMenuItemGetKind( nativeHandle  );
  }

  void setBitmap( WxBitmapBundle bitmap ) {
    _wxMenuItemSetBitmap( nativeHandle, bitmap.nativeHandle );
  }

  void setHelp( String help ) {
    final helpUtf8 = help.toNativeUtf8();
    _wxMenuItemSetHelp( nativeHandle, helpUtf8 );
    malloc.free( helpUtf8 );
  }

  void check( bool check ) {
    _wxMenuItemCheck( nativeHandle, check );
  }

  void enable( bool enable ) {
    _wxMenuItemEnable( nativeHandle, enable );
  }

  bool isCheck( ) {
    return _wxMenuItemIsCheck( nativeHandle  );
  }

  bool isChecked( ) {
    return _wxMenuItemIsChecked( nativeHandle  );
  }

  bool isCheckable( ) {
    return _wxMenuItemIsCheckable( nativeHandle  );
  }

  bool isRadio( ) {
    return _wxMenuItemIsRadio( nativeHandle  );
  }

  bool isEnabled( ) {
    return _wxMenuItemIsEnabled( nativeHandle  );
  }

  bool isSeparator( ) {
    return _wxMenuItemIsSeparator( nativeHandle  );
  }
}


void setupWxMenus( DynamicLibrary dylib )
{
  // ------------------------- wxMenuBar ----------------------

  final wxMenuBarConstructorPtr = dylib.lookup <NativeFunction<_WxMenuBarConstructorNative>>('wxMenuBarConstructor');
  _wxMenuBarConstructor = wxMenuBarConstructorPtr.asFunction<_WxMenuBarConstructor>();

  final wxMenuBarFindItemPtr = dylib.lookup <NativeFunction<_WxMenuBarFindItemNative>>('wxMenuBarFindItem');
  _wxMenuBarFindItem = wxMenuBarFindItemPtr.asFunction<_WxMenuBarFindItem>();

  final wxMenuBarGetMenuCountPtr = dylib.lookup <NativeFunction<_WxMenuBarGetMenuCountNative>>('wxMenuBarGetMenuCount');
  _wxMenuBarGetMenuCount = wxMenuBarGetMenuCountPtr.asFunction<_WxMenuBarGetMenuCount>();

  final wxMenuBarGetMenuPtr = dylib.lookup <NativeFunction<_WxMenuBarGetMenuNative>>('wxMenuBarGetMenu');
  _wxMenuBarGetMenu = wxMenuBarGetMenuPtr.asFunction<_WxMenuBarGetMenu>();

  final wxMenuBarRemovePtr = dylib.lookup <NativeFunction<_WxMenuBarRemoveNative>>('wxMenuBarRemove');
  _wxMenuBarRemove = wxMenuBarRemovePtr.asFunction<_WxMenuBarRemove>();

  final wxMenuBarAppendPtr = dylib.lookup <NativeFunction<_WxMenuBarAppendNative>>('wxMenuBarAppend');
  _wxMenuBarAppend = wxMenuBarAppendPtr.asFunction<_WxMenuBarAppend>();

  final wxMenuBarInsertPtr = dylib.lookup <NativeFunction<_WxMenuBarInsertNative>>('wxMenuBarInsert');
  _wxMenuBarInsert = wxMenuBarInsertPtr.asFunction<_WxMenuBarInsert>();

  final wxMenuBarCheckItemPtr = dylib.lookup <NativeFunction<_WxMenuBarCheckItemNative>>('wxMenuBarCheckItem');
  _wxMenuBarCheckItem = wxMenuBarCheckItemPtr.asFunction<_WxMenuBarCheckItem>();

  final wxMenuBarEnableItemPtr = dylib.lookup <NativeFunction<_WxMenuBarEnableItemNative>>('wxMenuBarEnableItem');
  _wxMenuBarEnableItem = wxMenuBarEnableItemPtr.asFunction<_WxMenuBarEnableItem>();

  final wxMenuBarIsItemCheckedPtr = dylib.lookup <NativeFunction<_WxMenuBarIsItemCheckedNative>>('wxMenuBarIsItemChecked');
  _wxMenuBarIsItemChecked = wxMenuBarIsItemCheckedPtr.asFunction<_WxMenuBarIsItemChecked>();

  final wxMenuBarIsItemEnabledPtr = dylib.lookup <NativeFunction<_WxMenuBarIsItemEnabledNative>>('wxMenuBarIsItemEnabled');
  _wxMenuBarIsItemEnabled = wxMenuBarIsItemEnabledPtr.asFunction<_WxMenuBarIsItemEnabled>();

  // ------------------------- wxMenu ----------------------

  final wxMenuConstructorPtr = dylib.lookup <NativeFunction<_WxMenuConstructorNative>>('wxMenuConstructor');
  _wxMenuConstructor = wxMenuConstructorPtr.asFunction<_WxMenuConstructor>();

  final wxMenuFindItemPtr = dylib.lookup <NativeFunction<_WxMenuFindItemNative>>('wxMenuFindItem');
  _wxMenuFindItem = wxMenuFindItemPtr.asFunction<_WxMenuFindItem>();

  final wxMenuGetMenuItemCountPtr = dylib.lookup <NativeFunction<_WxMenuGetMenuItemCountNative>>('wxMenuGetMenuItemCount');
  _wxMenuGetMenuItemCount = wxMenuGetMenuItemCountPtr.asFunction<_WxMenuGetMenuItemCount>();

  final wxMenuFindItemByPositionPtr = dylib.lookup <NativeFunction<_WxMenuFindItemByPositionNative>>('wxMenuFindItemByPosition');
  _wxMenuFindItemByPosition = wxMenuFindItemByPositionPtr.asFunction<_WxMenuFindItemByPosition>();

  final wxMenuAppendPtr = dylib.lookup <NativeFunction<_WxMenuAppendNative>>('wxMenuAppend');
  _wxMenuAppend = wxMenuAppendPtr.asFunction<_WxMenuAppend>();

  final wxMenuAppendItemPtr = dylib.lookup <NativeFunction<_WxMenuAppendItemNative>>('wxMenuAppendItem');
  _wxMenuAppendItem = wxMenuAppendItemPtr.asFunction<_WxMenuAppendItem>();

  final wxMenuAppendCheckItemPtr = dylib.lookup <NativeFunction<_WxMenuAppendCheckItemNative>>('wxMenuAppendCheckItem');
  _wxMenuAppendCheckItem = wxMenuAppendCheckItemPtr.asFunction<_WxMenuAppendCheckItem>();

  final wxMenuAppendRadioItemPtr = dylib.lookup <NativeFunction<_WxMenuAppendRadioItemNative>>('wxMenuAppendRadioItem');
  _wxMenuAppendRadioItem = wxMenuAppendRadioItemPtr.asFunction<_WxMenuAppendRadioItem>();

  final wxMenuAppendSubMenuPtr = dylib.lookup <NativeFunction<_WxMenuAppendSubMenuNative>>('wxMenuAppendSubMenu');
  _wxMenuAppendSubMenu = wxMenuAppendSubMenuPtr.asFunction<_WxMenuAppendSubMenu>();

  final wxMenuAppendSeparatorPtr = dylib.lookup <NativeFunction<_WxMenuAppendSeparatorNative>>('wxMenuAppendSeparator');
  _wxMenuAppendSeparator = wxMenuAppendSeparatorPtr.asFunction<_WxMenuAppendSeparator>();

  final wxMenuInsertPtr = dylib.lookup <NativeFunction<_WxMenuInsertNative>>('wxMenuInsert');
  _wxMenuInsert = wxMenuInsertPtr.asFunction<_WxMenuInsert>();

  final wxMenuInsertItemPtr = dylib.lookup <NativeFunction<_WxMenuInsertItemNative>>('wxMenuInsertItem');
  _wxMenuInsertItem = wxMenuInsertItemPtr.asFunction<_WxMenuInsertItem>();

  final wxMenuInsertCheckItemPtr = dylib.lookup <NativeFunction<_WxMenuInsertCheckItemNative>>('wxMenuInsertCheckItem');
  _wxMenuInsertCheckItem = wxMenuInsertCheckItemPtr.asFunction<_WxMenuInsertCheckItem>();

  final wxMenuInsertRadioItemPtr = dylib.lookup <NativeFunction<_WxMenuInsertRadioItemNative>>('wxMenuInsertRadioItem');
  _wxMenuInsertRadioItem = wxMenuInsertRadioItemPtr.asFunction<_WxMenuInsertRadioItem>();

  final wxMenuInsertSubMenuPtr = dylib.lookup <NativeFunction<_WxMenuInsertSubMenuNative>>('wxMenuInsertSubMenu');
  _wxMenuInsertSubMenu = wxMenuInsertSubMenuPtr.asFunction<_WxMenuInsertSubMenu>();

  final wxMenuInsertSeparatorPtr = dylib.lookup <NativeFunction<_WxMenuInsertSeparatorNative>>('wxMenuInsertSeparator');
  _wxMenuInsertSeparator = wxMenuInsertSeparatorPtr.asFunction<_WxMenuInsertSeparator>();

  final wxMenuDeleteItemPtr = dylib.lookup <NativeFunction<_WxMenuDeleteItemNative>>('wxMenuDeleteItem');
  _wxMenuDeleteItem = wxMenuDeleteItemPtr.asFunction<_WxMenuDeleteItem>();

  final wxMenuDeletePtr = dylib.lookup <NativeFunction<_WxMenuDeleteNative>>('wxMenuDelete');
  _wxMenuDelete = wxMenuDeletePtr.asFunction<_WxMenuDelete>();

  final wxMenuEnableItemPtr = dylib.lookup <NativeFunction<_WxMenuEnableItemNative>>('wxMenuEnableItem');
  _wxMenuEnableItem = wxMenuEnableItemPtr.asFunction<_WxMenuEnableItem>();

  // ------------------------- wxMenuItem ----------------------

  final wxMenuItemConstructorPtr = dylib.lookup <NativeFunction<_WxMenuItemConstructorNative>>('wxMenuItemConstructor');
  _wxMenuItemConstructor = wxMenuItemConstructorPtr.asFunction<_WxMenuItemConstructor>();

  final wxMenuItemGetHelpPtr = dylib.lookup <NativeFunction<_WxMenuItemGetHelpNative>>('wxMenuItemGetHelp');
  _wxMenuItemGetHelp = wxMenuItemGetHelpPtr.asFunction<_WxMenuItemGetHelp>();

  final wxMenuItemGetItemLabelPtr = dylib.lookup <NativeFunction<_WxMenuItemGetItemLabelNative>>('wxMenuItemGetItemLabel');
  _wxMenuItemGetItemLabel = wxMenuItemGetItemLabelPtr.asFunction<_WxMenuItemGetItemLabel>();

  final wxMenuItemGetItemLabelTextPtr = dylib.lookup <NativeFunction<_WxMenuItemGetItemLabelTextNative>>('wxMenuItemGetItemLabelText');
  _wxMenuItemGetItemLabelText = wxMenuItemGetItemLabelTextPtr.asFunction<_WxMenuItemGetItemLabelText>();

  final wxMenuItemGetIdPtr = dylib.lookup <NativeFunction<_WxMenuItemGetIdNative>>('wxMenuItemGetId');
  _wxMenuItemGetId = wxMenuItemGetIdPtr.asFunction<_WxMenuItemGetId>();

  final wxMenuItemGetKindPtr = dylib.lookup <NativeFunction<_WxMenuItemGetKindNative>>('wxMenuItemGetKind');
  _wxMenuItemGetKind = wxMenuItemGetKindPtr.asFunction<_WxMenuItemGetKind>();

  final wxMenuItemSetBitmapPtr = dylib.lookup <NativeFunction<_WxMenuItemSetBitmapNative>>('wxMenuItemSetBitmap');
  _wxMenuItemSetBitmap = wxMenuItemSetBitmapPtr.asFunction<_WxMenuItemSetBitmap>();

  final wxMenuItemSetHelpPtr = dylib.lookup <NativeFunction<_WxMenuItemSetHelpNative>>('wxMenuItemSetHelp');
  _wxMenuItemSetHelp = wxMenuItemSetHelpPtr.asFunction<_WxMenuItemSetHelp>();

  final wxMenuItemCheckPtr = dylib.lookup <NativeFunction<_WxMenuItemCheckNative>>('wxMenuItemCheck');
  _wxMenuItemCheck = wxMenuItemCheckPtr.asFunction<_WxMenuItemCheck>();

  final wxMenuItemEnablePtr = dylib.lookup <NativeFunction<_WxMenuItemEnableNative>>('wxMenuItemEnable');
  _wxMenuItemEnable = wxMenuItemEnablePtr.asFunction<_WxMenuItemEnable>();

  final wxMenuItemIsCheckPtr = dylib.lookup <NativeFunction<_WxMenuItemIsCheckNative>>('wxMenuItemIsCheck');
  _wxMenuItemIsCheck = wxMenuItemIsCheckPtr.asFunction<_WxMenuItemIsCheck>();

  final wxMenuItemIsCheckedPtr = dylib.lookup <NativeFunction<_WxMenuItemIsCheckedNative>>('wxMenuItemIsChecked');
  _wxMenuItemIsChecked = wxMenuItemIsCheckedPtr.asFunction<_WxMenuItemIsChecked>();

  final wxMenuItemIsCheckablePtr = dylib.lookup <NativeFunction<_WxMenuItemIsCheckableNative>>('wxMenuItemIsCheckable');
  _wxMenuItemIsCheckable = wxMenuItemIsCheckablePtr.asFunction<_WxMenuItemIsCheckable>();

  final wxMenuItemIsRadioPtr = dylib.lookup <NativeFunction<_WxMenuItemIsRadioNative>>('wxMenuItemIsRadio');
  _wxMenuItemIsRadio = wxMenuItemIsRadioPtr.asFunction<_WxMenuItemIsRadio>();

  final wxMenuItemIsEnabledPtr = dylib.lookup <NativeFunction<_WxMenuItemIsEnabledNative>>('wxMenuItemIsEnabled');
  _wxMenuItemIsEnabled = wxMenuItemIsEnabledPtr.asFunction<_WxMenuItemIsEnabled>();

  final wxMenuItemIsSeparatorPtr = dylib.lookup <NativeFunction<_WxMenuItemIsSeparatorNative>>('wxMenuItemIsSeparator');
  _wxMenuItemIsSeparator = wxMenuItemIsSeparatorPtr.asFunction<_WxMenuItemIsSeparator>();

}
