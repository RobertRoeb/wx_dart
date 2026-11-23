// -------------------------------------------------------------
// Purpose:     Dart bindings for wxWidgets
// Author:      Robert Roebling
// Modified by: The magic C++ to Dart code generator
// Created:     07/01/2025
// Copyright:   (c) Robert Roebling
// Licence:     wxWindows licence 3.1
// -------------------------------------------------------------

part of '../wx_dart.dart';

// ------------------------- wxMessageDialog ----------------------

typedef _WxMessageDialogConstructorNative = Pointer Function( Pointer, Pointer<Utf8>, Pointer<Utf8>, Int32, Int32, Int32  );
typedef _WxMessageDialogConstructor = Pointer Function( Pointer, Pointer<Utf8>, Pointer<Utf8>, int, int, int  );
late _WxMessageDialogConstructor _wxMessageDialogConstructor;

typedef _WxMessageDialogSetMessageNative = Void Function( Pointer, Pointer<Utf8>  );
typedef _WxMessageDialogSetMessage = void Function( Pointer, Pointer<Utf8>  );
late _WxMessageDialogSetMessage _wxMessageDialogSetMessage;

typedef _WxMessageDialogSetExtendedMessageNative = Void Function( Pointer, Pointer<Utf8>  );
typedef _WxMessageDialogSetExtendedMessage = void Function( Pointer, Pointer<Utf8>  );
late _WxMessageDialogSetExtendedMessage _wxMessageDialogSetExtendedMessage;

typedef _WxMessageDialogSetOKLabelNative = Void Function( Pointer, Pointer<Utf8>  );
typedef _WxMessageDialogSetOKLabel = void Function( Pointer, Pointer<Utf8>  );
late _WxMessageDialogSetOKLabel _wxMessageDialogSetOKLabel;

typedef _WxMessageDialogSetHelpLabelNative = Void Function( Pointer, Pointer<Utf8>  );
typedef _WxMessageDialogSetHelpLabel = void Function( Pointer, Pointer<Utf8>  );
late _WxMessageDialogSetHelpLabel _wxMessageDialogSetHelpLabel;

typedef _WxMessageDialogSetYesNoLabelsNative = Void Function( Pointer, Pointer<Utf8>, Pointer<Utf8>  );
typedef _WxMessageDialogSetYesNoLabels = void Function( Pointer, Pointer<Utf8>, Pointer<Utf8>  );
late _WxMessageDialogSetYesNoLabels _wxMessageDialogSetYesNoLabels;

typedef _WxMessageDialogSetYesNoCancelLabelsNative = Void Function( Pointer, Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>  );
typedef _WxMessageDialogSetYesNoCancelLabels = void Function( Pointer, Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>  );
late _WxMessageDialogSetYesNoCancelLabels _wxMessageDialogSetYesNoCancelLabels;

typedef _WxMessageDialogSetOKCancelLabelsNative = Void Function( Pointer, Pointer<Utf8>, Pointer<Utf8>  );
typedef _WxMessageDialogSetOKCancelLabels = void Function( Pointer, Pointer<Utf8>, Pointer<Utf8>  );
late _WxMessageDialogSetOKCancelLabels _wxMessageDialogSetOKCancelLabels;

class WxMessageDialog extends WxDialog {
  WxMessageDialog._defaultConstructor() : super._defaultConstructor();
  WxMessageDialog( WxWindow? parent, String message, { String caption = '', int style = wxOK|wxCENTRE, WxPoint pos = wxDefaultPosition } ) : super._defaultConstructor() {
    final messageUtf8 = message.toNativeUtf8();
    final captionUtf8 = caption.toNativeUtf8();
    nativeHandle = _wxMessageDialogConstructor( (parent == null) ? nullptr : parent.nativeHandle, messageUtf8, captionUtf8, style, pos.x, pos.y );
    malloc.free( messageUtf8 );
    malloc.free( captionUtf8 );
    _postCreation();
  }
  WxMessageDialog.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  void setMessage( String message ) {
    final messageUtf8 = message.toNativeUtf8();
    _wxMessageDialogSetMessage( nativeHandle, messageUtf8 );
    malloc.free( messageUtf8 );
  }

  void setExtendedMessage( String message ) {
    final messageUtf8 = message.toNativeUtf8();
    _wxMessageDialogSetExtendedMessage( nativeHandle, messageUtf8 );
    malloc.free( messageUtf8 );
  }

  void setOKLabel( String label ) {
    final labelUtf8 = label.toNativeUtf8();
    _wxMessageDialogSetOKLabel( nativeHandle, labelUtf8 );
    malloc.free( labelUtf8 );
  }

  void setHelpLabel( String label ) {
    final labelUtf8 = label.toNativeUtf8();
    _wxMessageDialogSetHelpLabel( nativeHandle, labelUtf8 );
    malloc.free( labelUtf8 );
  }

  void setYesNoLabels( String yes, String no ) {
    final yesUtf8 = yes.toNativeUtf8();
    final noUtf8 = no.toNativeUtf8();
    _wxMessageDialogSetYesNoLabels( nativeHandle, yesUtf8, noUtf8 );
    malloc.free( yesUtf8 );
    malloc.free( noUtf8 );
  }

  void setYesNoCancelLabels( String yes, String no, String cancel ) {
    final yesUtf8 = yes.toNativeUtf8();
    final noUtf8 = no.toNativeUtf8();
    final cancelUtf8 = cancel.toNativeUtf8();
    _wxMessageDialogSetYesNoCancelLabels( nativeHandle, yesUtf8, noUtf8, cancelUtf8 );
    malloc.free( yesUtf8 );
    malloc.free( noUtf8 );
    malloc.free( cancelUtf8 );
  }

  void setOKCancelLabels( String ok, String cancel ) {
    final okUtf8 = ok.toNativeUtf8();
    final cancelUtf8 = cancel.toNativeUtf8();
    _wxMessageDialogSetOKCancelLabels( nativeHandle, okUtf8, cancelUtf8 );
    malloc.free( okUtf8 );
    malloc.free( cancelUtf8 );
  }
}

// ------------------------- wxFileDialog ----------------------

typedef _WxFileDialogConstructorNative = Pointer Function( Pointer, Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>, Int32, Int32, Int32, Int32, Int32  );
typedef _WxFileDialogConstructor = Pointer Function( Pointer, Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>, Pointer<Utf8>, int, int, int, int, int  );
late _WxFileDialogConstructor _wxFileDialogConstructor;

typedef _WxFileDialogGetPathNative = Pointer<Utf8> Function( Pointer  );
typedef _WxFileDialogGetPath = Pointer<Utf8> Function( Pointer  );
late _WxFileDialogGetPath _wxFileDialogGetPath;

/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxFD_OPEN | 0x0001 |
/// | wxFD_DEFAULT_STYLE | wxFD_OPEN |
/// | wxFD_SAVE | 0x0002 |
/// | wxFD_OVERWRITE_PROMPT | 0x0004 |
/// | wxFD_NO_FOLLOW | 0x0008 |
/// | wxFD_FILE_MUST_EXIST | 0x0010 |
/// | wxFD_CHANGE_DIR | 0x0080 |
/// | wxFD_PREVIEW | 0x0100 |
/// | wxFD_MULTIPLE | 0x0200 |
/// | wxFD_SHOW_HIDDEN | 0x0400 |

const int wxFD_OPEN = 0x0001;
const int wxFD_DEFAULT_STYLE = wxFD_OPEN;
const int wxFD_SAVE = 0x0002;
const int wxFD_OVERWRITE_PROMPT = 0x0004;
const int wxFD_NO_FOLLOW = 0x0008;
const int wxFD_FILE_MUST_EXIST = 0x0010;
const int wxFD_CHANGE_DIR = 0x0080;
const int wxFD_PREVIEW = 0x0100;
const int wxFD_MULTIPLE = 0x0200;
const int wxFD_SHOW_HIDDEN = 0x0400;

class WxFileDialog extends WxDialog {
  WxFileDialog._defaultConstructor() : super._defaultConstructor();
  WxFileDialog( WxWindow? parent, String message, { String defaultDir = '', String defaultFile = '', String defaultWildCard = '*.*', int style = wxFD_DEFAULT_STYLE, WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize } ) : super._defaultConstructor() {
    final messageUtf8 = message.toNativeUtf8();
    final defaultDirUtf8 = defaultDir.toNativeUtf8();
    final defaultFileUtf8 = defaultFile.toNativeUtf8();
    final defaultWildCardUtf8 = defaultWildCard.toNativeUtf8();
    nativeHandle = _wxFileDialogConstructor( (parent == null) ? nullptr : parent.nativeHandle, messageUtf8, defaultDirUtf8, defaultFileUtf8, defaultWildCardUtf8, style, pos.x, pos.y, size.x, size.y );
    malloc.free( messageUtf8 );
    malloc.free( defaultDirUtf8 );
    malloc.free( defaultFileUtf8 );
    malloc.free( defaultWildCardUtf8 );
    _postCreation();
  }
  WxFileDialog.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  void showModal( void Function( int, dynamic )? onReturn )
  {
    int ret = _showModalSync();
    if (onReturn != null) {
      onReturn( ret, getPath() );
    }
    destroy();
  }

  String getPath( ) {
    Pointer<Utf8> ptrReturn = _wxFileDialogGetPath( nativeHandle  );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }
}

// ------------------------- wxDirDialog ----------------------

typedef _WxDirDialogConstructorNative = Pointer Function( Pointer, Pointer<Utf8>, Pointer<Utf8>, Int32, Int32, Int32, Int32, Int32  );
typedef _WxDirDialogConstructor = Pointer Function( Pointer, Pointer<Utf8>, Pointer<Utf8>, int, int, int, int, int  );
late _WxDirDialogConstructor _wxDirDialogConstructor;

typedef _WxDirDialogGetPathNative = Pointer<Utf8> Function( Pointer  );
typedef _WxDirDialogGetPath = Pointer<Utf8> Function( Pointer  );
late _WxDirDialogGetPath _wxDirDialogGetPath;

/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxDD_CHANGE_DIR | 0x0100 |
/// | wxDD_DIR_MUST_EXIST | 0x0200 |
/// | wxDD_MULTIPLE | 0x0400 |
/// | wxDD_SHOW_HIDDEN | 0x0001 |
/// | wxDD_DEFAULT_STYLE | (wxDEFAULT_DIALOG_STYLE|wxRESIZE_BORDER) |

const int wxDD_CHANGE_DIR = 0x0100;
const int wxDD_DIR_MUST_EXIST = 0x0200;
const int wxDD_MULTIPLE = 0x0400;
const int wxDD_SHOW_HIDDEN = 0x0001;
const int wxDD_DEFAULT_STYLE = (wxDEFAULT_DIALOG_STYLE|wxRESIZE_BORDER);

class WxDirDialog extends WxDialog {
  WxDirDialog._defaultConstructor() : super._defaultConstructor();
  WxDirDialog( WxWindow? parent, String message, { String defaultDir = '', int style = wxDD_DEFAULT_STYLE, WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize } ) : super._defaultConstructor() {
    final messageUtf8 = message.toNativeUtf8();
    final defaultDirUtf8 = defaultDir.toNativeUtf8();
    nativeHandle = _wxDirDialogConstructor( (parent == null) ? nullptr : parent.nativeHandle, messageUtf8, defaultDirUtf8, style, pos.x, pos.y, size.x, size.y );
    malloc.free( messageUtf8 );
    malloc.free( defaultDirUtf8 );
    _postCreation();
  }
  WxDirDialog.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  void showModal( void Function( int, dynamic )? onReturn )
  {
    int ret = _showModalSync();
    if (onReturn != null) {
      onReturn( ret, getPath() );
    }
    destroy();
  }

  String getPath( ) {
    Pointer<Utf8> ptrReturn = _wxDirDialogGetPath( nativeHandle  );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }
}

// ------------------------- wxBookCtrlBase ----------------------

typedef _WxBookCtrlBaseAddPageNative = Bool Function( Pointer, Pointer, Pointer<Utf8>, Bool, Int32  );
typedef _WxBookCtrlBaseAddPage = bool Function( Pointer, Pointer, Pointer<Utf8>, bool, int  );
late _WxBookCtrlBaseAddPage _wxBookCtrlBaseAddPage;

typedef _WxBookCtrlBaseInsertPageNative = Bool Function( Pointer, Int32, Pointer, Pointer<Utf8>, Bool, Int32  );
typedef _WxBookCtrlBaseInsertPage = bool Function( Pointer, int, Pointer, Pointer<Utf8>, bool, int  );
late _WxBookCtrlBaseInsertPage _wxBookCtrlBaseInsertPage;

typedef _WxBookCtrlBaseGetPageCountNative = Int32 Function( Pointer  );
typedef _WxBookCtrlBaseGetPageCount = int Function( Pointer  );
late _WxBookCtrlBaseGetPageCount _wxBookCtrlBaseGetPageCount;

typedef _WxBookCtrlBaseFindPageNative = Int32 Function( Pointer, Pointer  );
typedef _WxBookCtrlBaseFindPage = int Function( Pointer, Pointer  );
late _WxBookCtrlBaseFindPage _wxBookCtrlBaseFindPage;

typedef _WxBookCtrlBaseGetSelectionNative = Int32 Function( Pointer  );
typedef _WxBookCtrlBaseGetSelection = int Function( Pointer  );
late _WxBookCtrlBaseGetSelection _wxBookCtrlBaseGetSelection;

typedef _WxBookCtrlBaseSetSelectionNative = Int32 Function( Pointer, Int32  );
typedef _WxBookCtrlBaseSetSelection = int Function( Pointer, int  );
late _WxBookCtrlBaseSetSelection _wxBookCtrlBaseSetSelection;

typedef _WxBookCtrlBaseChangeSelectionNative = Int32 Function( Pointer, Int32  );
typedef _WxBookCtrlBaseChangeSelection = int Function( Pointer, int  );
late _WxBookCtrlBaseChangeSelection _wxBookCtrlBaseChangeSelection;

typedef _WxBookCtrlBaseGetPageNative = Pointer Function( Pointer, Int32  );
typedef _WxBookCtrlBaseGetPage = Pointer Function( Pointer, int  );
late _WxBookCtrlBaseGetPage _wxBookCtrlBaseGetPage;

typedef _WxBookCtrlBaseGetCurrentPageNative = Pointer Function( Pointer  );
typedef _WxBookCtrlBaseGetCurrentPage = Pointer Function( Pointer  );
late _WxBookCtrlBaseGetCurrentPage _wxBookCtrlBaseGetCurrentPage;

typedef _WxBookCtrlBaseGetPageTextNative = Pointer<Utf8> Function( Pointer, Int32  );
typedef _WxBookCtrlBaseGetPageText = Pointer<Utf8> Function( Pointer, int  );
late _WxBookCtrlBaseGetPageText _wxBookCtrlBaseGetPageText;

typedef _WxBookCtrlBaseSetPageTextNative = Void Function( Pointer, Int32, Pointer<Utf8>  );
typedef _WxBookCtrlBaseSetPageText = void Function( Pointer, int, Pointer<Utf8>  );
late _WxBookCtrlBaseSetPageText _wxBookCtrlBaseSetPageText;

typedef _WxBookCtrlBaseGetPageImageNative = Int32 Function( Pointer, Int32  );
typedef _WxBookCtrlBaseGetPageImage = int Function( Pointer, int  );
late _WxBookCtrlBaseGetPageImage _wxBookCtrlBaseGetPageImage;

typedef _WxBookCtrlBaseSetPageImageNative = Bool Function( Pointer, Int32, Int32  );
typedef _WxBookCtrlBaseSetPageImage = bool Function( Pointer, int, int  );
late _WxBookCtrlBaseSetPageImage _wxBookCtrlBaseSetPageImage;

typedef _WxBookCtrlBaseDeletePageNative = Bool Function( Pointer, Int32  );
typedef _WxBookCtrlBaseDeletePage = bool Function( Pointer, int  );
late _WxBookCtrlBaseDeletePage _wxBookCtrlBaseDeletePage;

typedef _WxBookCtrlBaseRemovePageNative = Bool Function( Pointer, Int32  );
typedef _WxBookCtrlBaseRemovePage = bool Function( Pointer, int  );
late _WxBookCtrlBaseRemovePage _wxBookCtrlBaseRemovePage;

typedef _WxBookCtrlBaseAdvanceSelectionNative = Void Function( Pointer, Bool  );
typedef _WxBookCtrlBaseAdvanceSelection = void Function( Pointer, bool  );
late _WxBookCtrlBaseAdvanceSelection _wxBookCtrlBaseAdvanceSelection;

typedef _WxBookCtrlBaseDeleteAllPagesNative = Bool Function( Pointer  );
typedef _WxBookCtrlBaseDeleteAllPages = bool Function( Pointer  );
late _WxBookCtrlBaseDeleteAllPages _wxBookCtrlBaseDeleteAllPages;

/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxBK_DEFAULT | 0x0000 |
/// | wxBK_TOP | 0x0010 |
/// | wxBK_BOTTOM | 0x0020 |
/// | wxBK_LEFT | 0x0040 |
/// | wxBK_RIGHT | 0x0080 |
/// | wxBK_ALIGN_MASK | (wxBK_TOP | wxBK_BOTTOM | wxBK_LEFT | wxBK_RIGHT) |

const int wxBK_DEFAULT = 0x0000;
const int wxBK_TOP = 0x0010;
const int wxBK_BOTTOM = 0x0020;
const int wxBK_LEFT = 0x0040;
const int wxBK_RIGHT = 0x0080;
const int wxBK_ALIGN_MASK = (wxBK_TOP | wxBK_BOTTOM | wxBK_LEFT | wxBK_RIGHT);

class WxBookCtrlBase extends WxControl {
  WxBookCtrlBase._defaultConstructor() : super._defaultConstructor();
  WxBookCtrlBase.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  bool addPage( WxWindow page, String text, { bool select = false, int image = wxNO_IMAGE } ) {
    final textUtf8 = text.toNativeUtf8();
    return _wxBookCtrlBaseAddPage( nativeHandle, page.nativeHandle, textUtf8, select, image );
  }

  bool insertPage( int pos, WxWindow page, String text, { bool select = false, int image = wxNO_IMAGE } ) {
    final textUtf8 = text.toNativeUtf8();
    return _wxBookCtrlBaseInsertPage( nativeHandle, pos, page.nativeHandle, textUtf8, select, image );
  }

  int getPageCount( ) {
    return _wxBookCtrlBaseGetPageCount( nativeHandle  );
  }

  int findPage( WxWindow page ) {
    return _wxBookCtrlBaseFindPage( nativeHandle, page.nativeHandle );
  }

  int getSelection( ) {
    return _wxBookCtrlBaseGetSelection( nativeHandle  );
  }

  int setSelection( int selection ) {
    return _wxBookCtrlBaseSetSelection( nativeHandle, selection );
  }

  int changeSelection( int selection ) {
    return _wxBookCtrlBaseChangeSelection( nativeHandle, selection );
  }

  WxWindow? getPage( int page ) {
    final returnedNativeHandle = _wxBookCtrlBaseGetPage( nativeHandle, page );
    if (returnedNativeHandle == nullptr) return null;
    WxEvtHandler? eh = _evtHandlerList[returnedNativeHandle];
    if (eh != null) {
      // There already is a Dart class associated with this C++ object
      return eh as WxWindow;
    }
    return wxCreateBestMatchingClassFromWxWindowHandle( returnedNativeHandle );
  }

  WxWindow? getCurrentPage( ) {
    final returnedNativeHandle = _wxBookCtrlBaseGetCurrentPage( nativeHandle  );
    if (returnedNativeHandle == nullptr) return null;
    WxEvtHandler? eh = _evtHandlerList[returnedNativeHandle];
    if (eh != null) {
      // There already is a Dart class associated with this C++ object
      return eh as WxWindow;
    }
    return wxCreateBestMatchingClassFromWxWindowHandle( returnedNativeHandle );
  }

  String getPageText( int page ) {
    Pointer<Utf8> ptrReturn = _wxBookCtrlBaseGetPageText( nativeHandle, page );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }

  void setPageText( int page, String text ) {
    final textUtf8 = text.toNativeUtf8();
    _wxBookCtrlBaseSetPageText( nativeHandle, page, textUtf8 );
    malloc.free( textUtf8 );
  }

  int getPageImage( int page ) {
    return _wxBookCtrlBaseGetPageImage( nativeHandle, page );
  }

  bool setPageImage( int page, int image ) {
    return _wxBookCtrlBaseSetPageImage( nativeHandle, page, image );
  }

  bool deletePage( int page ) {
    return _wxBookCtrlBaseDeletePage( nativeHandle, page );
  }

  bool removePage( int page ) {
    return _wxBookCtrlBaseRemovePage( nativeHandle, page );
  }

  void advanceSelection( { bool forward = true } ) {
    _wxBookCtrlBaseAdvanceSelection( nativeHandle, forward );
  }

  bool deleteAllPages( ) {
    return _wxBookCtrlBaseDeleteAllPages( nativeHandle  );
  }
}

// ------------------------- wxNotebookEvent ----------------------

typedef _WxNotebookEventConstructorNative = Pointer Function( Int32, Int32, Int32, Int32  );
typedef _WxNotebookEventConstructor = Pointer Function( int, int, int, int  );
late _WxNotebookEventConstructor _wxNotebookEventConstructor;

typedef _WxNotebookEventGetSelectionNative = Int32 Function( Pointer  );
typedef _WxNotebookEventGetSelection = int Function( Pointer  );
late _WxNotebookEventGetSelection _wxNotebookEventGetSelection;

typedef _WxNotebookEventGetOldSelectionNative = Int32 Function( Pointer  );
typedef _WxNotebookEventGetOldSelection = int Function( Pointer  );
late _WxNotebookEventGetOldSelection _wxNotebookEventGetOldSelection;

class WxNotebookEvent extends WxNotifyEvent {
  WxNotebookEvent._defaultConstructor() : super._defaultConstructor();
  WxNotebookEvent( { int eventType = 0, int id = 0, int sel = 0, int oldSel = 0 } ) : super._defaultConstructor() {
    nativeHandle = _wxNotebookEventConstructor( eventType, id, sel, oldSel );
    attachFinalizer();
  }
  WxNotebookEvent.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  int getSelection( ) {
    return _wxNotebookEventGetSelection( nativeHandle  );
  }

  int getOldSelection( ) {
    return _wxNotebookEventGetOldSelection( nativeHandle  );
  }
}

typedef _WxInstallDartNotebookEventCallbackNative = Void Function( Pointer );
typedef _WxInstallDartNotebookEventCallback = void Function( Pointer );
late _WxInstallDartNotebookEventCallback _wxInstallDartNotebookEventCallback;

typedef OnNotebookEventFunc = void Function( WxNotebookEvent event );
class WxNotebookEventListItems {
  WxNotebookEventListItems( this.func, this.eventType, this.eventId );
  final OnNotebookEventFunc func;
  final int eventType;
  final int eventId;
}
Map<Pointer, List<WxNotebookEventListItems>> wxNotebookEventHandlerList = {};

void wxNotebookEventCallback( Pointer handle, Pointer eventHandle ) {
    WxNotebookEvent event = WxNotebookEvent.fromHandle( eventHandle );

    final List<WxNotebookEventListItems>? list = wxNotebookEventHandlerList[handle];
    if (list == null) {
      wxLogError('Handle does not exist in wxNotebookEventHandlerList');
      return;
    } else {
      for (int i = list.length-1; i >= 0; i--) { // go backwards to allow overloading
        final items = list[i];
        if (items.eventType != event.getEventType()) continue;
        if ((items.eventId != -1) && (items.eventId != event.getId())) continue;
        event.skip( skip: false );
        items.func( event );
        if (!event.getSkipped()) return;
      }
    }
}

typedef WxNotebookEventCallbackNative = Void Function( Pointer, Pointer );
late NativeCallable<Void Function(Pointer<NativeType>, Pointer<NativeType>)> wxNotebookEventNativeCallable;

// ------------------------- wxNotebook ----------------------

typedef _WxNotebookConstructorNative = Pointer Function( Pointer, Int32, Int32, Int32, Int32, Int32, Int32  );
typedef _WxNotebookConstructor = Pointer Function( Pointer, int, int, int, int, int, int  );
late _WxNotebookConstructor _wxNotebookConstructor;

typedef _WxNotebookSetImagesNative = Void Function( Pointer, Pointer  );
typedef _WxNotebookSetImages = void Function( Pointer, Pointer  );
late _WxNotebookSetImages _wxNotebookSetImages;

typedef _WxNotebookHasImagesNative = Bool Function( Pointer  );
typedef _WxNotebookHasImages = bool Function( Pointer  );
late _WxNotebookHasImages _wxNotebookHasImages;

typedef _WxNotebookGetImageCountNative = Int32 Function( Pointer  );
typedef _WxNotebookGetImageCount = int Function( Pointer  );
late _WxNotebookGetImageCount _wxNotebookGetImageCount;

/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxNB_DEFAULT | wxBK_DEFAULT |
/// | wxNB_TOP | wxBK_TOP |
/// | wxNB_BOTTOM | wxBK_BOTTOM |
/// | wxNB_LEFT | wxBK_LEFT |
/// | wxNB_RIGHT | wxBK_RIGHT |
/// | wxNB_FIXEDWIDTH | 0x0100 |
/// | wxNB_MULTILINE | 0x0200 |
/// | wxNB_NOPAGETHEME | 0x0400 |
/// | wxNB_CLASSIC_THEME | 0x0800 |
/// | wxNB_ANIMATED_THEME | 0x1000 |

const int wxNB_DEFAULT = wxBK_DEFAULT;
const int wxNB_TOP = wxBK_TOP;
const int wxNB_BOTTOM = wxBK_BOTTOM;
const int wxNB_LEFT = wxBK_LEFT;
const int wxNB_RIGHT = wxBK_RIGHT;
const int wxNB_FIXEDWIDTH = 0x0100;
const int wxNB_MULTILINE = 0x0200;
const int wxNB_NOPAGETHEME = 0x0400;
const int wxNB_CLASSIC_THEME = 0x0800;
const int wxNB_ANIMATED_THEME = 0x1000;

class WxNotebook extends WxBookCtrlBase {
  WxNotebook._defaultConstructor() : super._defaultConstructor();
  WxNotebook( WxWindow parent, int id, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = wxNB_DEFAULT } ) : super._defaultConstructor() {
    nativeHandle = _wxNotebookConstructor( parent.nativeHandle, id, pos.x, pos.y, size.x, size.y, style );
    _postCreation();
  }
  WxNotebook.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  void setImages( List<WxBitmapBundle> images ) {
    final imagesList = wxListBitmapBundleToVectorBitmapBundle( images );
    _wxNotebookSetImages( nativeHandle, imagesList.nativeHandle );
    // imagesList.dispose();
  }

  bool hasImages( ) {
    return _wxNotebookHasImages( nativeHandle  );
  }

  int getImageCount( ) {
    return _wxNotebookGetImageCount( nativeHandle  );
  }
}

// ------------------------- wxTreebook ----------------------

typedef _WxTreebookConstructorNative = Pointer Function( Pointer, Int32, Int32, Int32, Int32, Int32, Int32  );
typedef _WxTreebookConstructor = Pointer Function( Pointer, int, int, int, int, int, int  );
late _WxTreebookConstructor _wxTreebookConstructor;

typedef _WxTreebookGetTreeCtrlNative = Pointer Function( Pointer  );
typedef _WxTreebookGetTreeCtrl = Pointer Function( Pointer  );
late _WxTreebookGetTreeCtrl _wxTreebookGetTreeCtrl;

typedef _WxTreebookSetSpacingNative = Void Function( Pointer, Int32  );
typedef _WxTreebookSetSpacing = void Function( Pointer, int  );
late _WxTreebookSetSpacing _wxTreebookSetSpacing;

typedef _WxTreebookSetImagesNative = Void Function( Pointer, Pointer  );
typedef _WxTreebookSetImages = void Function( Pointer, Pointer  );
late _WxTreebookSetImages _wxTreebookSetImages;

typedef _WxTreebookHasImagesNative = Bool Function( Pointer  );
typedef _WxTreebookHasImages = bool Function( Pointer  );
late _WxTreebookHasImages _wxTreebookHasImages;

typedef _WxTreebookGetImageCountNative = Int32 Function( Pointer  );
typedef _WxTreebookGetImageCount = int Function( Pointer  );
late _WxTreebookGetImageCount _wxTreebookGetImageCount;

typedef _WxTreebookAddSubPageNative = Bool Function( Pointer, Pointer, Pointer<Utf8>, Bool, Int32  );
typedef _WxTreebookAddSubPage = bool Function( Pointer, Pointer, Pointer<Utf8>, bool, int  );
late _WxTreebookAddSubPage _wxTreebookAddSubPage;

typedef _WxTreebookInsertSubPageNative = Bool Function( Pointer, Int32, Pointer, Pointer<Utf8>, Bool, Int32  );
typedef _WxTreebookInsertSubPage = bool Function( Pointer, int, Pointer, Pointer<Utf8>, bool, int  );
late _WxTreebookInsertSubPage _wxTreebookInsertSubPage;

typedef _WxTreebookGetPageParentNative = Int32 Function( Pointer, Int32  );
typedef _WxTreebookGetPageParent = int Function( Pointer, int  );
late _WxTreebookGetPageParent _wxTreebookGetPageParent;

typedef _WxTreebookExpandNodeNative = Bool Function( Pointer, Int32  );
typedef _WxTreebookExpandNode = bool Function( Pointer, int  );
late _WxTreebookExpandNode _wxTreebookExpandNode;

typedef _WxTreebookCollapseNodeNative = Bool Function( Pointer, Int32  );
typedef _WxTreebookCollapseNode = bool Function( Pointer, int  );
late _WxTreebookCollapseNode _wxTreebookCollapseNode;

typedef _WxTreebookIsNodeExpandedNative = Bool Function( Pointer, Int32  );
typedef _WxTreebookIsNodeExpanded = bool Function( Pointer, int  );
late _WxTreebookIsNodeExpanded _wxTreebookIsNodeExpanded;

class WxTreebook extends WxBookCtrlBase {
  WxTreebook._defaultConstructor() : super._defaultConstructor();
  WxTreebook( WxWindow parent, int id, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = 0 } ) : super._defaultConstructor() {
    nativeHandle = _wxTreebookConstructor( parent.nativeHandle, id, pos.x, pos.y, size.x, size.y, style );
    _postCreation();
  }
  WxTreebook.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  WxTreeCtrl getTreeCtrl( ) {
    final returnedNativeHandle = _wxTreebookGetTreeCtrl( nativeHandle  );
    WxEvtHandler? eh = _evtHandlerList[returnedNativeHandle];
    if (eh != null) {
      // There already is a Dart class associated with this C++ object
      return eh as WxTreeCtrl;
    }
    return WxTreeCtrl.fromHandle( returnedNativeHandle );
  }

  void setSpacing( int spacing ) {
    _wxTreebookSetSpacing( nativeHandle, spacing );
  }

  void setImages( List<WxBitmapBundle> images ) {
    final imagesList = wxListBitmapBundleToVectorBitmapBundle( images );
    _wxTreebookSetImages( nativeHandle, imagesList.nativeHandle );
    // imagesList.dispose();
  }

  bool hasImages( ) {
    return _wxTreebookHasImages( nativeHandle  );
  }

  int getImageCount( ) {
    return _wxTreebookGetImageCount( nativeHandle  );
  }

  bool addSubPage( WxWindow page, String text, { bool select = false, int image = wxNO_IMAGE } ) {
    final textUtf8 = text.toNativeUtf8();
    return _wxTreebookAddSubPage( nativeHandle, page.nativeHandle, textUtf8, select, image );
  }

  bool insertSubPage( int pos, WxWindow page, String text, { bool select = false, int image = wxNO_IMAGE } ) {
    final textUtf8 = text.toNativeUtf8();
    return _wxTreebookInsertSubPage( nativeHandle, pos, page.nativeHandle, textUtf8, select, image );
  }

  int getPageParent( int pagePos ) {
    return _wxTreebookGetPageParent( nativeHandle, pagePos );
  }

  bool expandNode( int pagePos ) {
    return _wxTreebookExpandNode( nativeHandle, pagePos );
  }

  bool collapseNode( int pagePos ) {
    return _wxTreebookCollapseNode( nativeHandle, pagePos );
  }

  bool isNodeExpanded( int pagePos ) {
    return _wxTreebookIsNodeExpanded( nativeHandle, pagePos );
  }
}

// ------------------------- wxNavigationCtrl ----------------------

typedef _WxNavigationCtrlConstructorNative = Pointer Function( Pointer, Int32, Int32, Int32, Int32, Int32, Int32  );
typedef _WxNavigationCtrlConstructor = Pointer Function( Pointer, int, int, int, int, int, int  );
late _WxNavigationCtrlConstructor _wxNavigationCtrlConstructor;

typedef _WxNavigationCtrlSetImagesNative = Void Function( Pointer, Pointer  );
typedef _WxNavigationCtrlSetImages = void Function( Pointer, Pointer  );
late _WxNavigationCtrlSetImages _wxNavigationCtrlSetImages;

typedef _WxNavigationCtrlHasImagesNative = Bool Function( Pointer  );
typedef _WxNavigationCtrlHasImages = bool Function( Pointer  );
late _WxNavigationCtrlHasImages _wxNavigationCtrlHasImages;

typedef _WxNavigationCtrlGetImageCountNative = Int32 Function( Pointer  );
typedef _WxNavigationCtrlGetImageCount = int Function( Pointer  );
late _WxNavigationCtrlGetImageCount _wxNavigationCtrlGetImageCount;

class WxNavigationCtrl extends WxBookCtrlBase {
  WxNavigationCtrl._defaultConstructor() : super._defaultConstructor();
  WxNavigationCtrl( WxWindow parent, int id, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = wxBK_BOTTOM } ) : super._defaultConstructor() {
    nativeHandle = _wxNavigationCtrlConstructor( parent.nativeHandle, id, pos.x, pos.y, size.x, size.y, style );
    _postCreation();
  }
  WxNavigationCtrl.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  void setImages( List<WxBitmapBundle> images ) {
    final imagesList = wxListBitmapBundleToVectorBitmapBundle( images );
    _wxNavigationCtrlSetImages( nativeHandle, imagesList.nativeHandle );
    // imagesList.dispose();
  }

  bool hasImages( ) {
    return _wxNavigationCtrlHasImages( nativeHandle  );
  }

  int getImageCount( ) {
    return _wxNavigationCtrlGetImageCount( nativeHandle  );
  }
}

// ------------------------- EVT_NOTEBOOK_PAGE_CHANGED ----------------------
///
/// [NotebookPageChanged](/wxdart/wxGetNotebookPageChangedEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindNotebookPageChangedEvent( OnNotebookEventFunc ) |
/// | void unbindNotebookPageChangedEvent() |

typedef _WxGetNotebookPageChangedEventTypeNative = Int32 Function();
typedef WxGetNotebookPageChangedEventType = int Function();
late WxGetNotebookPageChangedEventType wxGetNotebookPageChangedEventType;

typedef _WxEvtHandlerBindNotebookPageChangedEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindNotebookPageChangedEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindNotebookPageChangedEventCallback wxEvtHandlerBindNotebookPageChangedEventCallback;

typedef _WxEvtHandlerUnbindNotebookPageChangedEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindNotebookPageChangedEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindNotebookPageChangedEventCallback wxEvtHandlerUnbindNotebookPageChangedEventCallback;

extension NotebookPageChangedEventBinder on WxEvtHandler {
  void bindNotebookPageChangedEvent( OnNotebookEventFunc func, int id ) {
    List<WxNotebookEventListItems>? list = wxNotebookEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxNotebookEventHandlerList[nativeHandle] = list;
    }
    list.add( WxNotebookEventListItems( func, wxGetNotebookPageChangedEventType(), id ) );
    wxEvtHandlerBindNotebookPageChangedEventCallback( nativeHandle, id );
  }

  void unbindNotebookPageChangedEvent( int id )
  {
    final list = wxNotebookEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetNotebookPageChangedEventType() ) ) );
    wxEvtHandlerUnbindNotebookPageChangedEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_NOTEBOOK_PAGE_CHANGING ----------------------
///
/// [NotebookPageChanging](/wxdart/wxGetNotebookPageChangingEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindNotebookPageChangingEvent( OnNotebookEventFunc ) |
/// | void unbindNotebookPageChangingEvent() |

typedef _WxGetNotebookPageChangingEventTypeNative = Int32 Function();
typedef WxGetNotebookPageChangingEventType = int Function();
late WxGetNotebookPageChangingEventType wxGetNotebookPageChangingEventType;

typedef _WxEvtHandlerBindNotebookPageChangingEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindNotebookPageChangingEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindNotebookPageChangingEventCallback wxEvtHandlerBindNotebookPageChangingEventCallback;

typedef _WxEvtHandlerUnbindNotebookPageChangingEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindNotebookPageChangingEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindNotebookPageChangingEventCallback wxEvtHandlerUnbindNotebookPageChangingEventCallback;

extension NotebookPageChangingEventBinder on WxEvtHandler {
  void bindNotebookPageChangingEvent( OnNotebookEventFunc func, int id ) {
    List<WxNotebookEventListItems>? list = wxNotebookEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxNotebookEventHandlerList[nativeHandle] = list;
    }
    list.add( WxNotebookEventListItems( func, wxGetNotebookPageChangingEventType(), id ) );
    wxEvtHandlerBindNotebookPageChangingEventCallback( nativeHandle, id );
  }

  void unbindNotebookPageChangingEvent( int id )
  {
    final list = wxNotebookEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetNotebookPageChangingEventType() ) ) );
    wxEvtHandlerUnbindNotebookPageChangingEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_TREEBOOK_PAGE_CHANGED ----------------------
///
/// [TreebookPageChanged](/wxdart/wxGetTreebookPageChangedEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindTreebookPageChangedEvent( OnNotebookEventFunc ) |
/// | void unbindTreebookPageChangedEvent() |

typedef _WxGetTreebookPageChangedEventTypeNative = Int32 Function();
typedef WxGetTreebookPageChangedEventType = int Function();
late WxGetTreebookPageChangedEventType wxGetTreebookPageChangedEventType;

typedef _WxEvtHandlerBindTreebookPageChangedEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindTreebookPageChangedEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindTreebookPageChangedEventCallback wxEvtHandlerBindTreebookPageChangedEventCallback;

typedef _WxEvtHandlerUnbindTreebookPageChangedEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindTreebookPageChangedEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindTreebookPageChangedEventCallback wxEvtHandlerUnbindTreebookPageChangedEventCallback;

extension TreebookPageChangedEventBinder on WxEvtHandler {
  void bindTreebookPageChangedEvent( OnNotebookEventFunc func, int id ) {
    List<WxNotebookEventListItems>? list = wxNotebookEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxNotebookEventHandlerList[nativeHandle] = list;
    }
    list.add( WxNotebookEventListItems( func, wxGetTreebookPageChangedEventType(), id ) );
    wxEvtHandlerBindTreebookPageChangedEventCallback( nativeHandle, id );
  }

  void unbindTreebookPageChangedEvent( int id )
  {
    final list = wxNotebookEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetTreebookPageChangedEventType() ) ) );
    wxEvtHandlerUnbindTreebookPageChangedEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_TREEBOOK_PAGE_CHANGING ----------------------
///
/// [TreebookPageChanging](/wxdart/wxGetTreebookPageChangingEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindTreebookPageChangingEvent( OnNotebookEventFunc ) |
/// | void unbindTreebookPageChangingEvent() |

typedef _WxGetTreebookPageChangingEventTypeNative = Int32 Function();
typedef WxGetTreebookPageChangingEventType = int Function();
late WxGetTreebookPageChangingEventType wxGetTreebookPageChangingEventType;

typedef _WxEvtHandlerBindTreebookPageChangingEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindTreebookPageChangingEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindTreebookPageChangingEventCallback wxEvtHandlerBindTreebookPageChangingEventCallback;

typedef _WxEvtHandlerUnbindTreebookPageChangingEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindTreebookPageChangingEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindTreebookPageChangingEventCallback wxEvtHandlerUnbindTreebookPageChangingEventCallback;

extension TreebookPageChangingEventBinder on WxEvtHandler {
  void bindTreebookPageChangingEvent( OnNotebookEventFunc func, int id ) {
    List<WxNotebookEventListItems>? list = wxNotebookEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxNotebookEventHandlerList[nativeHandle] = list;
    }
    list.add( WxNotebookEventListItems( func, wxGetTreebookPageChangingEventType(), id ) );
    wxEvtHandlerBindTreebookPageChangingEventCallback( nativeHandle, id );
  }

  void unbindTreebookPageChangingEvent( int id )
  {
    final list = wxNotebookEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetTreebookPageChangingEventType() ) ) );
    wxEvtHandlerUnbindTreebookPageChangingEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_TREEBOOK_NODE_COLLAPSED ----------------------
///
/// [TreebookNodeCollapsed](/wxdart/wxGetTreebookNodeCollapsedEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindTreebookNodeCollapsedEvent( OnNotebookEventFunc ) |
/// | void unbindTreebookNodeCollapsedEvent() |

typedef _WxGetTreebookNodeCollapsedEventTypeNative = Int32 Function();
typedef WxGetTreebookNodeCollapsedEventType = int Function();
late WxGetTreebookNodeCollapsedEventType wxGetTreebookNodeCollapsedEventType;

typedef _WxEvtHandlerBindTreebookNodeCollapsedEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindTreebookNodeCollapsedEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindTreebookNodeCollapsedEventCallback wxEvtHandlerBindTreebookNodeCollapsedEventCallback;

typedef _WxEvtHandlerUnbindTreebookNodeCollapsedEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindTreebookNodeCollapsedEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindTreebookNodeCollapsedEventCallback wxEvtHandlerUnbindTreebookNodeCollapsedEventCallback;

extension TreebookNodeCollapsedEventBinder on WxEvtHandler {
  void bindTreebookNodeCollapsedEvent( OnNotebookEventFunc func, int id ) {
    List<WxNotebookEventListItems>? list = wxNotebookEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxNotebookEventHandlerList[nativeHandle] = list;
    }
    list.add( WxNotebookEventListItems( func, wxGetTreebookNodeCollapsedEventType(), id ) );
    wxEvtHandlerBindTreebookNodeCollapsedEventCallback( nativeHandle, id );
  }

  void unbindTreebookNodeCollapsedEvent( int id )
  {
    final list = wxNotebookEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetTreebookNodeCollapsedEventType() ) ) );
    wxEvtHandlerUnbindTreebookNodeCollapsedEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_TREEBOOK_NODE_EXPANDED ----------------------
///
/// [TreebookNodeExpanded](/wxdart/wxGetTreebookNodeExpandedEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindTreebookNodeExpandedEvent( OnNotebookEventFunc ) |
/// | void unbindTreebookNodeExpandedEvent() |

typedef _WxGetTreebookNodeExpandedEventTypeNative = Int32 Function();
typedef WxGetTreebookNodeExpandedEventType = int Function();
late WxGetTreebookNodeExpandedEventType wxGetTreebookNodeExpandedEventType;

typedef _WxEvtHandlerBindTreebookNodeExpandedEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindTreebookNodeExpandedEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindTreebookNodeExpandedEventCallback wxEvtHandlerBindTreebookNodeExpandedEventCallback;

typedef _WxEvtHandlerUnbindTreebookNodeExpandedEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindTreebookNodeExpandedEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindTreebookNodeExpandedEventCallback wxEvtHandlerUnbindTreebookNodeExpandedEventCallback;

extension TreebookNodeExpandedEventBinder on WxEvtHandler {
  void bindTreebookNodeExpandedEvent( OnNotebookEventFunc func, int id ) {
    List<WxNotebookEventListItems>? list = wxNotebookEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxNotebookEventHandlerList[nativeHandle] = list;
    }
    list.add( WxNotebookEventListItems( func, wxGetTreebookNodeExpandedEventType(), id ) );
    wxEvtHandlerBindTreebookNodeExpandedEventCallback( nativeHandle, id );
  }

  void unbindTreebookNodeExpandedEvent( int id )
  {
    final list = wxNotebookEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetTreebookNodeExpandedEventType() ) ) );
    wxEvtHandlerUnbindTreebookNodeExpandedEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_NAV_CTRL_PAGE_CHANGED ----------------------
///
/// [NavCtrlPageChanged](/wxdart/wxGetNavCtrlPageChangedEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindNavCtrlPageChangedEvent( OnNotebookEventFunc ) |
/// | void unbindNavCtrlPageChangedEvent() |

typedef _WxGetNavCtrlPageChangedEventTypeNative = Int32 Function();
typedef WxGetNavCtrlPageChangedEventType = int Function();
late WxGetNavCtrlPageChangedEventType wxGetNavCtrlPageChangedEventType;

typedef _WxEvtHandlerBindNavCtrlPageChangedEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindNavCtrlPageChangedEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindNavCtrlPageChangedEventCallback wxEvtHandlerBindNavCtrlPageChangedEventCallback;

typedef _WxEvtHandlerUnbindNavCtrlPageChangedEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindNavCtrlPageChangedEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindNavCtrlPageChangedEventCallback wxEvtHandlerUnbindNavCtrlPageChangedEventCallback;

extension NavCtrlPageChangedEventBinder on WxEvtHandler {
  void bindNavCtrlPageChangedEvent( OnNotebookEventFunc func, int id ) {
    List<WxNotebookEventListItems>? list = wxNotebookEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxNotebookEventHandlerList[nativeHandle] = list;
    }
    list.add( WxNotebookEventListItems( func, wxGetNavCtrlPageChangedEventType(), id ) );
    wxEvtHandlerBindNavCtrlPageChangedEventCallback( nativeHandle, id );
  }

  void unbindNavCtrlPageChangedEvent( int id )
  {
    final list = wxNotebookEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetNavCtrlPageChangedEventType() ) ) );
    wxEvtHandlerUnbindNavCtrlPageChangedEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_NAV_CTRL_PAGE_CHANGING ----------------------
///
/// [NavCtrlPageChanging](/wxdart/wxGetNavCtrlPageChangingEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindNavCtrlPageChangingEvent( OnNotebookEventFunc ) |
/// | void unbindNavCtrlPageChangingEvent() |

typedef _WxGetNavCtrlPageChangingEventTypeNative = Int32 Function();
typedef WxGetNavCtrlPageChangingEventType = int Function();
late WxGetNavCtrlPageChangingEventType wxGetNavCtrlPageChangingEventType;

typedef _WxEvtHandlerBindNavCtrlPageChangingEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindNavCtrlPageChangingEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindNavCtrlPageChangingEventCallback wxEvtHandlerBindNavCtrlPageChangingEventCallback;

typedef _WxEvtHandlerUnbindNavCtrlPageChangingEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindNavCtrlPageChangingEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindNavCtrlPageChangingEventCallback wxEvtHandlerUnbindNavCtrlPageChangingEventCallback;

extension NavCtrlPageChangingEventBinder on WxEvtHandler {
  void bindNavCtrlPageChangingEvent( OnNotebookEventFunc func, int id ) {
    List<WxNotebookEventListItems>? list = wxNotebookEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxNotebookEventHandlerList[nativeHandle] = list;
    }
    list.add( WxNotebookEventListItems( func, wxGetNavCtrlPageChangingEventType(), id ) );
    wxEvtHandlerBindNavCtrlPageChangingEventCallback( nativeHandle, id );
  }

  void unbindNavCtrlPageChangingEvent( int id )
  {
    final list = wxNotebookEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetNavCtrlPageChangingEventType() ) ) );
    wxEvtHandlerUnbindNavCtrlPageChangingEventCallback( nativeHandle, id );
  }
}


void setupWxBooks( DynamicLibrary dylib )
{
  // ------------------------- wxMessageDialog ----------------------

  final wxMessageDialogConstructorPtr = dylib.lookup <NativeFunction<_WxMessageDialogConstructorNative>>('wxMessageDialogConstructor');
  _wxMessageDialogConstructor = wxMessageDialogConstructorPtr.asFunction<_WxMessageDialogConstructor>();

  final wxMessageDialogSetMessagePtr = dylib.lookup <NativeFunction<_WxMessageDialogSetMessageNative>>('wxMessageDialogSetMessage');
  _wxMessageDialogSetMessage = wxMessageDialogSetMessagePtr.asFunction<_WxMessageDialogSetMessage>();

  final wxMessageDialogSetExtendedMessagePtr = dylib.lookup <NativeFunction<_WxMessageDialogSetExtendedMessageNative>>('wxMessageDialogSetExtendedMessage');
  _wxMessageDialogSetExtendedMessage = wxMessageDialogSetExtendedMessagePtr.asFunction<_WxMessageDialogSetExtendedMessage>();

  final wxMessageDialogSetOKLabelPtr = dylib.lookup <NativeFunction<_WxMessageDialogSetOKLabelNative>>('wxMessageDialogSetOKLabel');
  _wxMessageDialogSetOKLabel = wxMessageDialogSetOKLabelPtr.asFunction<_WxMessageDialogSetOKLabel>();

  final wxMessageDialogSetHelpLabelPtr = dylib.lookup <NativeFunction<_WxMessageDialogSetHelpLabelNative>>('wxMessageDialogSetHelpLabel');
  _wxMessageDialogSetHelpLabel = wxMessageDialogSetHelpLabelPtr.asFunction<_WxMessageDialogSetHelpLabel>();

  final wxMessageDialogSetYesNoLabelsPtr = dylib.lookup <NativeFunction<_WxMessageDialogSetYesNoLabelsNative>>('wxMessageDialogSetYesNoLabels');
  _wxMessageDialogSetYesNoLabels = wxMessageDialogSetYesNoLabelsPtr.asFunction<_WxMessageDialogSetYesNoLabels>();

  final wxMessageDialogSetYesNoCancelLabelsPtr = dylib.lookup <NativeFunction<_WxMessageDialogSetYesNoCancelLabelsNative>>('wxMessageDialogSetYesNoCancelLabels');
  _wxMessageDialogSetYesNoCancelLabels = wxMessageDialogSetYesNoCancelLabelsPtr.asFunction<_WxMessageDialogSetYesNoCancelLabels>();

  final wxMessageDialogSetOKCancelLabelsPtr = dylib.lookup <NativeFunction<_WxMessageDialogSetOKCancelLabelsNative>>('wxMessageDialogSetOKCancelLabels');
  _wxMessageDialogSetOKCancelLabels = wxMessageDialogSetOKCancelLabelsPtr.asFunction<_WxMessageDialogSetOKCancelLabels>();

  // ------------------------- wxFileDialog ----------------------

  final wxFileDialogConstructorPtr = dylib.lookup <NativeFunction<_WxFileDialogConstructorNative>>('wxFileDialogConstructor');
  _wxFileDialogConstructor = wxFileDialogConstructorPtr.asFunction<_WxFileDialogConstructor>();

  final wxFileDialogGetPathPtr = dylib.lookup <NativeFunction<_WxFileDialogGetPathNative>>('wxFileDialogGetPath');
  _wxFileDialogGetPath = wxFileDialogGetPathPtr.asFunction<_WxFileDialogGetPath>();

  // ------------------------- wxDirDialog ----------------------

  final wxDirDialogConstructorPtr = dylib.lookup <NativeFunction<_WxDirDialogConstructorNative>>('wxDirDialogConstructor');
  _wxDirDialogConstructor = wxDirDialogConstructorPtr.asFunction<_WxDirDialogConstructor>();

  final wxDirDialogGetPathPtr = dylib.lookup <NativeFunction<_WxDirDialogGetPathNative>>('wxDirDialogGetPath');
  _wxDirDialogGetPath = wxDirDialogGetPathPtr.asFunction<_WxDirDialogGetPath>();

  // ------------------------- wxBookCtrlBase ----------------------

  final wxBookCtrlBaseAddPagePtr = dylib.lookup <NativeFunction<_WxBookCtrlBaseAddPageNative>>('wxBookCtrlBaseAddPage');
  _wxBookCtrlBaseAddPage = wxBookCtrlBaseAddPagePtr.asFunction<_WxBookCtrlBaseAddPage>();

  final wxBookCtrlBaseInsertPagePtr = dylib.lookup <NativeFunction<_WxBookCtrlBaseInsertPageNative>>('wxBookCtrlBaseInsertPage');
  _wxBookCtrlBaseInsertPage = wxBookCtrlBaseInsertPagePtr.asFunction<_WxBookCtrlBaseInsertPage>();

  final wxBookCtrlBaseGetPageCountPtr = dylib.lookup <NativeFunction<_WxBookCtrlBaseGetPageCountNative>>('wxBookCtrlBaseGetPageCount');
  _wxBookCtrlBaseGetPageCount = wxBookCtrlBaseGetPageCountPtr.asFunction<_WxBookCtrlBaseGetPageCount>();

  final wxBookCtrlBaseFindPagePtr = dylib.lookup <NativeFunction<_WxBookCtrlBaseFindPageNative>>('wxBookCtrlBaseFindPage');
  _wxBookCtrlBaseFindPage = wxBookCtrlBaseFindPagePtr.asFunction<_WxBookCtrlBaseFindPage>();

  final wxBookCtrlBaseGetSelectionPtr = dylib.lookup <NativeFunction<_WxBookCtrlBaseGetSelectionNative>>('wxBookCtrlBaseGetSelection');
  _wxBookCtrlBaseGetSelection = wxBookCtrlBaseGetSelectionPtr.asFunction<_WxBookCtrlBaseGetSelection>();

  final wxBookCtrlBaseSetSelectionPtr = dylib.lookup <NativeFunction<_WxBookCtrlBaseSetSelectionNative>>('wxBookCtrlBaseSetSelection');
  _wxBookCtrlBaseSetSelection = wxBookCtrlBaseSetSelectionPtr.asFunction<_WxBookCtrlBaseSetSelection>();

  final wxBookCtrlBaseChangeSelectionPtr = dylib.lookup <NativeFunction<_WxBookCtrlBaseChangeSelectionNative>>('wxBookCtrlBaseChangeSelection');
  _wxBookCtrlBaseChangeSelection = wxBookCtrlBaseChangeSelectionPtr.asFunction<_WxBookCtrlBaseChangeSelection>();

  final wxBookCtrlBaseGetPagePtr = dylib.lookup <NativeFunction<_WxBookCtrlBaseGetPageNative>>('wxBookCtrlBaseGetPage');
  _wxBookCtrlBaseGetPage = wxBookCtrlBaseGetPagePtr.asFunction<_WxBookCtrlBaseGetPage>();

  final wxBookCtrlBaseGetCurrentPagePtr = dylib.lookup <NativeFunction<_WxBookCtrlBaseGetCurrentPageNative>>('wxBookCtrlBaseGetCurrentPage');
  _wxBookCtrlBaseGetCurrentPage = wxBookCtrlBaseGetCurrentPagePtr.asFunction<_WxBookCtrlBaseGetCurrentPage>();

  final wxBookCtrlBaseGetPageTextPtr = dylib.lookup <NativeFunction<_WxBookCtrlBaseGetPageTextNative>>('wxBookCtrlBaseGetPageText');
  _wxBookCtrlBaseGetPageText = wxBookCtrlBaseGetPageTextPtr.asFunction<_WxBookCtrlBaseGetPageText>();

  final wxBookCtrlBaseSetPageTextPtr = dylib.lookup <NativeFunction<_WxBookCtrlBaseSetPageTextNative>>('wxBookCtrlBaseSetPageText');
  _wxBookCtrlBaseSetPageText = wxBookCtrlBaseSetPageTextPtr.asFunction<_WxBookCtrlBaseSetPageText>();

  final wxBookCtrlBaseGetPageImagePtr = dylib.lookup <NativeFunction<_WxBookCtrlBaseGetPageImageNative>>('wxBookCtrlBaseGetPageImage');
  _wxBookCtrlBaseGetPageImage = wxBookCtrlBaseGetPageImagePtr.asFunction<_WxBookCtrlBaseGetPageImage>();

  final wxBookCtrlBaseSetPageImagePtr = dylib.lookup <NativeFunction<_WxBookCtrlBaseSetPageImageNative>>('wxBookCtrlBaseSetPageImage');
  _wxBookCtrlBaseSetPageImage = wxBookCtrlBaseSetPageImagePtr.asFunction<_WxBookCtrlBaseSetPageImage>();

  final wxBookCtrlBaseDeletePagePtr = dylib.lookup <NativeFunction<_WxBookCtrlBaseDeletePageNative>>('wxBookCtrlBaseDeletePage');
  _wxBookCtrlBaseDeletePage = wxBookCtrlBaseDeletePagePtr.asFunction<_WxBookCtrlBaseDeletePage>();

  final wxBookCtrlBaseRemovePagePtr = dylib.lookup <NativeFunction<_WxBookCtrlBaseRemovePageNative>>('wxBookCtrlBaseRemovePage');
  _wxBookCtrlBaseRemovePage = wxBookCtrlBaseRemovePagePtr.asFunction<_WxBookCtrlBaseRemovePage>();

  final wxBookCtrlBaseAdvanceSelectionPtr = dylib.lookup <NativeFunction<_WxBookCtrlBaseAdvanceSelectionNative>>('wxBookCtrlBaseAdvanceSelection');
  _wxBookCtrlBaseAdvanceSelection = wxBookCtrlBaseAdvanceSelectionPtr.asFunction<_WxBookCtrlBaseAdvanceSelection>();

  final wxBookCtrlBaseDeleteAllPagesPtr = dylib.lookup <NativeFunction<_WxBookCtrlBaseDeleteAllPagesNative>>('wxBookCtrlBaseDeleteAllPages');
  _wxBookCtrlBaseDeleteAllPages = wxBookCtrlBaseDeleteAllPagesPtr.asFunction<_WxBookCtrlBaseDeleteAllPages>();

  // ------------------------- wxNotebookEvent ----------------------

  final wxNotebookEventConstructorPtr = dylib.lookup <NativeFunction<_WxNotebookEventConstructorNative>>('wxNotebookEventConstructor');
  _wxNotebookEventConstructor = wxNotebookEventConstructorPtr.asFunction<_WxNotebookEventConstructor>();

  final wxNotebookEventGetSelectionPtr = dylib.lookup <NativeFunction<_WxNotebookEventGetSelectionNative>>('wxNotebookEventGetSelection');
  _wxNotebookEventGetSelection = wxNotebookEventGetSelectionPtr.asFunction<_WxNotebookEventGetSelection>();

  final wxNotebookEventGetOldSelectionPtr = dylib.lookup <NativeFunction<_WxNotebookEventGetOldSelectionNative>>('wxNotebookEventGetOldSelection');
  _wxNotebookEventGetOldSelection = wxNotebookEventGetOldSelectionPtr.asFunction<_WxNotebookEventGetOldSelection>();

  final wxInstallDartNotebookEventCallbackPtr = dylib.lookup <NativeFunction<_WxInstallDartNotebookEventCallbackNative>>('wxInstallDartNotebookEventCallback');
  _wxInstallDartNotebookEventCallback = wxInstallDartNotebookEventCallbackPtr.asFunction<_WxInstallDartNotebookEventCallback>();

  wxNotebookEventNativeCallable = NativeCallable<WxNotebookEventCallbackNative>.isolateLocal( wxNotebookEventCallback );
  _wxInstallDartNotebookEventCallback( wxNotebookEventNativeCallable.nativeFunction );

  // ------------------------- wxNotebook ----------------------

  final wxNotebookConstructorPtr = dylib.lookup <NativeFunction<_WxNotebookConstructorNative>>('wxNotebookConstructor');
  _wxNotebookConstructor = wxNotebookConstructorPtr.asFunction<_WxNotebookConstructor>();

  final wxNotebookSetImagesPtr = dylib.lookup <NativeFunction<_WxNotebookSetImagesNative>>('wxNotebookSetImages');
  _wxNotebookSetImages = wxNotebookSetImagesPtr.asFunction<_WxNotebookSetImages>();

  final wxNotebookHasImagesPtr = dylib.lookup <NativeFunction<_WxNotebookHasImagesNative>>('wxNotebookHasImages');
  _wxNotebookHasImages = wxNotebookHasImagesPtr.asFunction<_WxNotebookHasImages>();

  final wxNotebookGetImageCountPtr = dylib.lookup <NativeFunction<_WxNotebookGetImageCountNative>>('wxNotebookGetImageCount');
  _wxNotebookGetImageCount = wxNotebookGetImageCountPtr.asFunction<_WxNotebookGetImageCount>();

  // ------------------------- wxTreebook ----------------------

  final wxTreebookConstructorPtr = dylib.lookup <NativeFunction<_WxTreebookConstructorNative>>('wxTreebookConstructor');
  _wxTreebookConstructor = wxTreebookConstructorPtr.asFunction<_WxTreebookConstructor>();

  final wxTreebookGetTreeCtrlPtr = dylib.lookup <NativeFunction<_WxTreebookGetTreeCtrlNative>>('wxTreebookGetTreeCtrl');
  _wxTreebookGetTreeCtrl = wxTreebookGetTreeCtrlPtr.asFunction<_WxTreebookGetTreeCtrl>();

  final wxTreebookSetSpacingPtr = dylib.lookup <NativeFunction<_WxTreebookSetSpacingNative>>('wxTreebookSetSpacing');
  _wxTreebookSetSpacing = wxTreebookSetSpacingPtr.asFunction<_WxTreebookSetSpacing>();

  final wxTreebookSetImagesPtr = dylib.lookup <NativeFunction<_WxTreebookSetImagesNative>>('wxTreebookSetImages');
  _wxTreebookSetImages = wxTreebookSetImagesPtr.asFunction<_WxTreebookSetImages>();

  final wxTreebookHasImagesPtr = dylib.lookup <NativeFunction<_WxTreebookHasImagesNative>>('wxTreebookHasImages');
  _wxTreebookHasImages = wxTreebookHasImagesPtr.asFunction<_WxTreebookHasImages>();

  final wxTreebookGetImageCountPtr = dylib.lookup <NativeFunction<_WxTreebookGetImageCountNative>>('wxTreebookGetImageCount');
  _wxTreebookGetImageCount = wxTreebookGetImageCountPtr.asFunction<_WxTreebookGetImageCount>();

  final wxTreebookAddSubPagePtr = dylib.lookup <NativeFunction<_WxTreebookAddSubPageNative>>('wxTreebookAddSubPage');
  _wxTreebookAddSubPage = wxTreebookAddSubPagePtr.asFunction<_WxTreebookAddSubPage>();

  final wxTreebookInsertSubPagePtr = dylib.lookup <NativeFunction<_WxTreebookInsertSubPageNative>>('wxTreebookInsertSubPage');
  _wxTreebookInsertSubPage = wxTreebookInsertSubPagePtr.asFunction<_WxTreebookInsertSubPage>();

  final wxTreebookGetPageParentPtr = dylib.lookup <NativeFunction<_WxTreebookGetPageParentNative>>('wxTreebookGetPageParent');
  _wxTreebookGetPageParent = wxTreebookGetPageParentPtr.asFunction<_WxTreebookGetPageParent>();

  final wxTreebookExpandNodePtr = dylib.lookup <NativeFunction<_WxTreebookExpandNodeNative>>('wxTreebookExpandNode');
  _wxTreebookExpandNode = wxTreebookExpandNodePtr.asFunction<_WxTreebookExpandNode>();

  final wxTreebookCollapseNodePtr = dylib.lookup <NativeFunction<_WxTreebookCollapseNodeNative>>('wxTreebookCollapseNode');
  _wxTreebookCollapseNode = wxTreebookCollapseNodePtr.asFunction<_WxTreebookCollapseNode>();

  final wxTreebookIsNodeExpandedPtr = dylib.lookup <NativeFunction<_WxTreebookIsNodeExpandedNative>>('wxTreebookIsNodeExpanded');
  _wxTreebookIsNodeExpanded = wxTreebookIsNodeExpandedPtr.asFunction<_WxTreebookIsNodeExpanded>();

  // ------------------------- wxNavigationCtrl ----------------------

  final wxNavigationCtrlConstructorPtr = dylib.lookup <NativeFunction<_WxNavigationCtrlConstructorNative>>('wxNavigationCtrlConstructor');
  _wxNavigationCtrlConstructor = wxNavigationCtrlConstructorPtr.asFunction<_WxNavigationCtrlConstructor>();

  final wxNavigationCtrlSetImagesPtr = dylib.lookup <NativeFunction<_WxNavigationCtrlSetImagesNative>>('wxNavigationCtrlSetImages');
  _wxNavigationCtrlSetImages = wxNavigationCtrlSetImagesPtr.asFunction<_WxNavigationCtrlSetImages>();

  final wxNavigationCtrlHasImagesPtr = dylib.lookup <NativeFunction<_WxNavigationCtrlHasImagesNative>>('wxNavigationCtrlHasImages');
  _wxNavigationCtrlHasImages = wxNavigationCtrlHasImagesPtr.asFunction<_WxNavigationCtrlHasImages>();

  final wxNavigationCtrlGetImageCountPtr = dylib.lookup <NativeFunction<_WxNavigationCtrlGetImageCountNative>>('wxNavigationCtrlGetImageCount');
  _wxNavigationCtrlGetImageCount = wxNavigationCtrlGetImageCountPtr.asFunction<_WxNavigationCtrlGetImageCount>();

  // ------------------------- EVT_NOTEBOOK_PAGE_CHANGED ----------------------

  final wxGetNotebookPageChangedEventTypePtr = dylib.lookup <NativeFunction<_WxGetNotebookPageChangedEventTypeNative>>('wxGetNotebookPageChangedEventType');
  wxGetNotebookPageChangedEventType = wxGetNotebookPageChangedEventTypePtr.asFunction<WxGetNotebookPageChangedEventType>();

  final wxEvtHandlerBindNotebookPageChangedEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindNotebookPageChangedEventCallbackNative>>('wxEvtHandlerBindNotebookPageChangedEventCallback');
  wxEvtHandlerBindNotebookPageChangedEventCallback = wxEvtHandlerBindNotebookPageChangedEventCallbackPtr.asFunction<WxEvtHandlerBindNotebookPageChangedEventCallback>();

  final wxEvtHandlerUnbindNotebookPageChangedEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindNotebookPageChangedEventCallbackNative>>('wxEvtHandlerUnbindNotebookPageChangedEventCallback');
  wxEvtHandlerUnbindNotebookPageChangedEventCallback = wxEvtHandlerUnbindNotebookPageChangedEventCallbackPtr.asFunction<WxEvtHandlerUnbindNotebookPageChangedEventCallback>();

  // ------------------------- EVT_NOTEBOOK_PAGE_CHANGING ----------------------

  final wxGetNotebookPageChangingEventTypePtr = dylib.lookup <NativeFunction<_WxGetNotebookPageChangingEventTypeNative>>('wxGetNotebookPageChangingEventType');
  wxGetNotebookPageChangingEventType = wxGetNotebookPageChangingEventTypePtr.asFunction<WxGetNotebookPageChangingEventType>();

  final wxEvtHandlerBindNotebookPageChangingEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindNotebookPageChangingEventCallbackNative>>('wxEvtHandlerBindNotebookPageChangingEventCallback');
  wxEvtHandlerBindNotebookPageChangingEventCallback = wxEvtHandlerBindNotebookPageChangingEventCallbackPtr.asFunction<WxEvtHandlerBindNotebookPageChangingEventCallback>();

  final wxEvtHandlerUnbindNotebookPageChangingEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindNotebookPageChangingEventCallbackNative>>('wxEvtHandlerUnbindNotebookPageChangingEventCallback');
  wxEvtHandlerUnbindNotebookPageChangingEventCallback = wxEvtHandlerUnbindNotebookPageChangingEventCallbackPtr.asFunction<WxEvtHandlerUnbindNotebookPageChangingEventCallback>();

  // ------------------------- EVT_TREEBOOK_PAGE_CHANGED ----------------------

  final wxGetTreebookPageChangedEventTypePtr = dylib.lookup <NativeFunction<_WxGetTreebookPageChangedEventTypeNative>>('wxGetTreebookPageChangedEventType');
  wxGetTreebookPageChangedEventType = wxGetTreebookPageChangedEventTypePtr.asFunction<WxGetTreebookPageChangedEventType>();

  final wxEvtHandlerBindTreebookPageChangedEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindTreebookPageChangedEventCallbackNative>>('wxEvtHandlerBindTreebookPageChangedEventCallback');
  wxEvtHandlerBindTreebookPageChangedEventCallback = wxEvtHandlerBindTreebookPageChangedEventCallbackPtr.asFunction<WxEvtHandlerBindTreebookPageChangedEventCallback>();

  final wxEvtHandlerUnbindTreebookPageChangedEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindTreebookPageChangedEventCallbackNative>>('wxEvtHandlerUnbindTreebookPageChangedEventCallback');
  wxEvtHandlerUnbindTreebookPageChangedEventCallback = wxEvtHandlerUnbindTreebookPageChangedEventCallbackPtr.asFunction<WxEvtHandlerUnbindTreebookPageChangedEventCallback>();

  // ------------------------- EVT_TREEBOOK_PAGE_CHANGING ----------------------

  final wxGetTreebookPageChangingEventTypePtr = dylib.lookup <NativeFunction<_WxGetTreebookPageChangingEventTypeNative>>('wxGetTreebookPageChangingEventType');
  wxGetTreebookPageChangingEventType = wxGetTreebookPageChangingEventTypePtr.asFunction<WxGetTreebookPageChangingEventType>();

  final wxEvtHandlerBindTreebookPageChangingEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindTreebookPageChangingEventCallbackNative>>('wxEvtHandlerBindTreebookPageChangingEventCallback');
  wxEvtHandlerBindTreebookPageChangingEventCallback = wxEvtHandlerBindTreebookPageChangingEventCallbackPtr.asFunction<WxEvtHandlerBindTreebookPageChangingEventCallback>();

  final wxEvtHandlerUnbindTreebookPageChangingEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindTreebookPageChangingEventCallbackNative>>('wxEvtHandlerUnbindTreebookPageChangingEventCallback');
  wxEvtHandlerUnbindTreebookPageChangingEventCallback = wxEvtHandlerUnbindTreebookPageChangingEventCallbackPtr.asFunction<WxEvtHandlerUnbindTreebookPageChangingEventCallback>();

  // ------------------------- EVT_TREEBOOK_NODE_COLLAPSED ----------------------

  final wxGetTreebookNodeCollapsedEventTypePtr = dylib.lookup <NativeFunction<_WxGetTreebookNodeCollapsedEventTypeNative>>('wxGetTreebookNodeCollapsedEventType');
  wxGetTreebookNodeCollapsedEventType = wxGetTreebookNodeCollapsedEventTypePtr.asFunction<WxGetTreebookNodeCollapsedEventType>();

  final wxEvtHandlerBindTreebookNodeCollapsedEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindTreebookNodeCollapsedEventCallbackNative>>('wxEvtHandlerBindTreebookNodeCollapsedEventCallback');
  wxEvtHandlerBindTreebookNodeCollapsedEventCallback = wxEvtHandlerBindTreebookNodeCollapsedEventCallbackPtr.asFunction<WxEvtHandlerBindTreebookNodeCollapsedEventCallback>();

  final wxEvtHandlerUnbindTreebookNodeCollapsedEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindTreebookNodeCollapsedEventCallbackNative>>('wxEvtHandlerUnbindTreebookNodeCollapsedEventCallback');
  wxEvtHandlerUnbindTreebookNodeCollapsedEventCallback = wxEvtHandlerUnbindTreebookNodeCollapsedEventCallbackPtr.asFunction<WxEvtHandlerUnbindTreebookNodeCollapsedEventCallback>();

  // ------------------------- EVT_TREEBOOK_NODE_EXPANDED ----------------------

  final wxGetTreebookNodeExpandedEventTypePtr = dylib.lookup <NativeFunction<_WxGetTreebookNodeExpandedEventTypeNative>>('wxGetTreebookNodeExpandedEventType');
  wxGetTreebookNodeExpandedEventType = wxGetTreebookNodeExpandedEventTypePtr.asFunction<WxGetTreebookNodeExpandedEventType>();

  final wxEvtHandlerBindTreebookNodeExpandedEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindTreebookNodeExpandedEventCallbackNative>>('wxEvtHandlerBindTreebookNodeExpandedEventCallback');
  wxEvtHandlerBindTreebookNodeExpandedEventCallback = wxEvtHandlerBindTreebookNodeExpandedEventCallbackPtr.asFunction<WxEvtHandlerBindTreebookNodeExpandedEventCallback>();

  final wxEvtHandlerUnbindTreebookNodeExpandedEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindTreebookNodeExpandedEventCallbackNative>>('wxEvtHandlerUnbindTreebookNodeExpandedEventCallback');
  wxEvtHandlerUnbindTreebookNodeExpandedEventCallback = wxEvtHandlerUnbindTreebookNodeExpandedEventCallbackPtr.asFunction<WxEvtHandlerUnbindTreebookNodeExpandedEventCallback>();

  // ------------------------- EVT_NAV_CTRL_PAGE_CHANGED ----------------------

  final wxGetNavCtrlPageChangedEventTypePtr = dylib.lookup <NativeFunction<_WxGetNavCtrlPageChangedEventTypeNative>>('wxGetNavCtrlPageChangedEventType');
  wxGetNavCtrlPageChangedEventType = wxGetNavCtrlPageChangedEventTypePtr.asFunction<WxGetNavCtrlPageChangedEventType>();

  final wxEvtHandlerBindNavCtrlPageChangedEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindNavCtrlPageChangedEventCallbackNative>>('wxEvtHandlerBindNavCtrlPageChangedEventCallback');
  wxEvtHandlerBindNavCtrlPageChangedEventCallback = wxEvtHandlerBindNavCtrlPageChangedEventCallbackPtr.asFunction<WxEvtHandlerBindNavCtrlPageChangedEventCallback>();

  final wxEvtHandlerUnbindNavCtrlPageChangedEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindNavCtrlPageChangedEventCallbackNative>>('wxEvtHandlerUnbindNavCtrlPageChangedEventCallback');
  wxEvtHandlerUnbindNavCtrlPageChangedEventCallback = wxEvtHandlerUnbindNavCtrlPageChangedEventCallbackPtr.asFunction<WxEvtHandlerUnbindNavCtrlPageChangedEventCallback>();

  // ------------------------- EVT_NAV_CTRL_PAGE_CHANGING ----------------------

  final wxGetNavCtrlPageChangingEventTypePtr = dylib.lookup <NativeFunction<_WxGetNavCtrlPageChangingEventTypeNative>>('wxGetNavCtrlPageChangingEventType');
  wxGetNavCtrlPageChangingEventType = wxGetNavCtrlPageChangingEventTypePtr.asFunction<WxGetNavCtrlPageChangingEventType>();

  final wxEvtHandlerBindNavCtrlPageChangingEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindNavCtrlPageChangingEventCallbackNative>>('wxEvtHandlerBindNavCtrlPageChangingEventCallback');
  wxEvtHandlerBindNavCtrlPageChangingEventCallback = wxEvtHandlerBindNavCtrlPageChangingEventCallbackPtr.asFunction<WxEvtHandlerBindNavCtrlPageChangingEventCallback>();

  final wxEvtHandlerUnbindNavCtrlPageChangingEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindNavCtrlPageChangingEventCallbackNative>>('wxEvtHandlerUnbindNavCtrlPageChangingEventCallback');
  wxEvtHandlerUnbindNavCtrlPageChangingEventCallback = wxEvtHandlerUnbindNavCtrlPageChangingEventCallbackPtr.asFunction<WxEvtHandlerUnbindNavCtrlPageChangingEventCallback>();

}

void releaseWxBooks()
{
  wxNotebookEventNativeCallable.close();
}
