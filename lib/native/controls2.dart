// -------------------------------------------------------------
// Purpose:     Dart bindings for wxWidgets
// Author:      Robert Roebling
// Modified by: The magic C++ to Dart code generator
// Created:     07/01/2025
// Copyright:   (c) Robert Roebling
// Licence:     wxWindows licence 3.1
// -------------------------------------------------------------

part of '../wx_dart.dart';

// ------------------------- wxGLAttributes ----------------------

typedef _WxGLAttributesConstructorNative = Pointer Function(  );
typedef _WxGLAttributesConstructor = Pointer Function(  );
late _WxGLAttributesConstructor _wxGLAttributesConstructor;

typedef _WxGLAttributesDestructorNative = Pointer Function( Pointer );
typedef _WxGLAttributesDestructor = Pointer Function( Pointer );
late _WxGLAttributesDestructor _wxGLAttributesDestructor;

typedef _WxGLAttributesFinalizerNative = Pointer Function( Pointer );
late NativeFinalizer _wxGLAttributesNativeFinalizer;

typedef _WxGLAttributesPlatformDefaultsNative = Void Function( Pointer  );
typedef _WxGLAttributesPlatformDefaults = void Function( Pointer  );
late _WxGLAttributesPlatformDefaults _wxGLAttributesPlatformDefaults;

typedef _WxGLAttributesDefaultsNative = Void Function( Pointer  );
typedef _WxGLAttributesDefaults = void Function( Pointer  );
late _WxGLAttributesDefaults _wxGLAttributesDefaults;

typedef _WxGLAttributesDoubleBufferNative = Void Function( Pointer  );
typedef _WxGLAttributesDoubleBuffer = void Function( Pointer  );
late _WxGLAttributesDoubleBuffer _wxGLAttributesDoubleBuffer;

typedef _WxGLAttributesRGBANative = Void Function( Pointer  );
typedef _WxGLAttributesRGBA = void Function( Pointer  );
late _WxGLAttributesRGBA _wxGLAttributesRGBA;

typedef _WxGLAttributesLevelNative = Void Function( Pointer, Int32  );
typedef _WxGLAttributesLevel = void Function( Pointer, int  );
late _WxGLAttributesLevel _wxGLAttributesLevel;

typedef _WxGLAttributesBufferSizeNative = Void Function( Pointer, Int32  );
typedef _WxGLAttributesBufferSize = void Function( Pointer, int  );
late _WxGLAttributesBufferSize _wxGLAttributesBufferSize;

typedef _WxGLAttributesDepthNative = Void Function( Pointer, Int32  );
typedef _WxGLAttributesDepth = void Function( Pointer, int  );
late _WxGLAttributesDepth _wxGLAttributesDepth;

typedef _WxGLAttributesStencilNative = Void Function( Pointer, Int32  );
typedef _WxGLAttributesStencil = void Function( Pointer, int  );
late _WxGLAttributesStencil _wxGLAttributesStencil;

typedef _WxGLAttributesSampleBuffersNative = Void Function( Pointer, Int32  );
typedef _WxGLAttributesSampleBuffers = void Function( Pointer, int  );
late _WxGLAttributesSampleBuffers _wxGLAttributesSampleBuffers;

typedef _WxGLAttributesSamplersNative = Void Function( Pointer, Int32  );
typedef _WxGLAttributesSamplers = void Function( Pointer, int  );
late _WxGLAttributesSamplers _wxGLAttributesSamplers;

typedef _WxGLAttributesEndListNative = Void Function( Pointer  );
typedef _WxGLAttributesEndList = void Function( Pointer  );
late _WxGLAttributesEndList _wxGLAttributesEndList;

class WxGLAttributes extends WxClass {
  WxGLAttributes._defaultConstructor() : super._defaultConstructor();
  WxGLAttributes( ) : super._defaultConstructor() {
    nativeHandle = _wxGLAttributesConstructor(  );
    attachFinalizer();
  }
  WxGLAttributes.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    attachFinalizer();
  }
  @override
  void nativeDestroy() {
    nativeHandle = _wxGLAttributesDestructor( nativeHandle );
  }

  @override
  void attachFinalizer() {
    hasFinalizer = true;
    _wxGLAttributesNativeFinalizer.attach( this, nativeHandle.cast(), detach: this );
  }

  @override
  void detachFinalizer() {
     hasFinalizer = false;
     _wxGLAttributesNativeFinalizer.detach( this );
  }


  void platformDefaults( ) {
    _wxGLAttributesPlatformDefaults( nativeHandle  );
  }

  void defaults( ) {
    _wxGLAttributesDefaults( nativeHandle  );
  }

  void doubleBuffer( ) {
    _wxGLAttributesDoubleBuffer( nativeHandle  );
  }

  void RGBA( ) {
    _wxGLAttributesRGBA( nativeHandle  );
  }

  void level( int val ) {
    _wxGLAttributesLevel( nativeHandle, val );
  }

  void bufferSize( int val ) {
    _wxGLAttributesBufferSize( nativeHandle, val );
  }

  void depth( int val ) {
    _wxGLAttributesDepth( nativeHandle, val );
  }

  void stencil( int val ) {
    _wxGLAttributesStencil( nativeHandle, val );
  }

  void sampleBuffers( int val ) {
    _wxGLAttributesSampleBuffers( nativeHandle, val );
  }

  void samplers( int val ) {
    _wxGLAttributesSamplers( nativeHandle, val );
  }

  void endList( ) {
    _wxGLAttributesEndList( nativeHandle  );
  }
}

// ------------------------- wxGLContextAttrs ----------------------

typedef _WxGLContextAttrsConstructorNative = Pointer Function(  );
typedef _WxGLContextAttrsConstructor = Pointer Function(  );
late _WxGLContextAttrsConstructor _wxGLContextAttrsConstructor;

typedef _WxGLContextAttrsDestructorNative = Pointer Function( Pointer );
typedef _WxGLContextAttrsDestructor = Pointer Function( Pointer );
late _WxGLContextAttrsDestructor _wxGLContextAttrsDestructor;

typedef _WxGLContextAttrsFinalizerNative = Pointer Function( Pointer );
late NativeFinalizer _wxGLContextAttrsNativeFinalizer;

typedef _WxGLContextAttrsOGLVersionNative = Void Function( Pointer, Int32, Int32  );
typedef _WxGLContextAttrsOGLVersion = void Function( Pointer, int, int  );
late _WxGLContextAttrsOGLVersion _wxGLContextAttrsOGLVersion;

typedef _WxGLContextAttrsCoreProfileNative = Void Function( Pointer  );
typedef _WxGLContextAttrsCoreProfile = void Function( Pointer  );
late _WxGLContextAttrsCoreProfile _wxGLContextAttrsCoreProfile;

typedef _WxGLContextAttrsForwardCompatibleNative = Void Function( Pointer  );
typedef _WxGLContextAttrsForwardCompatible = void Function( Pointer  );
late _WxGLContextAttrsForwardCompatible _wxGLContextAttrsForwardCompatible;

typedef _WxGLContextAttrsES2Native = Void Function( Pointer  );
typedef _WxGLContextAttrsES2 = void Function( Pointer  );
late _WxGLContextAttrsES2 _wxGLContextAttrsES2;

typedef _WxGLContextAttrsRobustNative = Void Function( Pointer  );
typedef _WxGLContextAttrsRobust = void Function( Pointer  );
late _WxGLContextAttrsRobust _wxGLContextAttrsRobust;

typedef _WxGLContextAttrsLoseOnResetNative = Void Function( Pointer  );
typedef _WxGLContextAttrsLoseOnReset = void Function( Pointer  );
late _WxGLContextAttrsLoseOnReset _wxGLContextAttrsLoseOnReset;

typedef _WxGLContextAttrsResetIsolationNative = Void Function( Pointer  );
typedef _WxGLContextAttrsResetIsolation = void Function( Pointer  );
late _WxGLContextAttrsResetIsolation _wxGLContextAttrsResetIsolation;

typedef _WxGLContextAttrsEndListNative = Void Function( Pointer  );
typedef _WxGLContextAttrsEndList = void Function( Pointer  );
late _WxGLContextAttrsEndList _wxGLContextAttrsEndList;

class WxGLContextAttrs extends WxClass {
  WxGLContextAttrs._defaultConstructor() : super._defaultConstructor();
  WxGLContextAttrs( ) : super._defaultConstructor() {
    nativeHandle = _wxGLContextAttrsConstructor(  );
    attachFinalizer();
  }
  WxGLContextAttrs.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    attachFinalizer();
  }
  @override
  void nativeDestroy() {
    nativeHandle = _wxGLContextAttrsDestructor( nativeHandle );
  }

  @override
  void attachFinalizer() {
    hasFinalizer = true;
    _wxGLContextAttrsNativeFinalizer.attach( this, nativeHandle.cast(), detach: this );
  }

  @override
  void detachFinalizer() {
     hasFinalizer = false;
     _wxGLContextAttrsNativeFinalizer.detach( this );
  }


  void oGLVersion( int major, int minor ) {
    _wxGLContextAttrsOGLVersion( nativeHandle, major, minor );
  }

  void coreProfile( ) {
    _wxGLContextAttrsCoreProfile( nativeHandle  );
  }

  void forwardCompatible( ) {
    _wxGLContextAttrsForwardCompatible( nativeHandle  );
  }

  void ES2( ) {
    _wxGLContextAttrsES2( nativeHandle  );
  }

  void Robust( ) {
    _wxGLContextAttrsRobust( nativeHandle  );
  }

  void loseOnReset( ) {
    _wxGLContextAttrsLoseOnReset( nativeHandle  );
  }

  void resetIsolation( ) {
    _wxGLContextAttrsResetIsolation( nativeHandle  );
  }

  void endList( ) {
    _wxGLContextAttrsEndList( nativeHandle  );
  }
}

// ------------------------- wxGLCanvas ----------------------

typedef _WxGLCanvasConstructorNative = Pointer Function( Pointer, Pointer, Int32, Int32, Int32, Int32, Int32, Int32  );
typedef _WxGLCanvasConstructor = Pointer Function( Pointer, Pointer, int, int, int, int, int, int  );
late _WxGLCanvasConstructor _wxGLCanvasConstructor;

typedef _WxGLCanvasSwapBuffersNative = Void Function( Pointer  );
typedef _WxGLCanvasSwapBuffers = void Function( Pointer  );
late _WxGLCanvasSwapBuffers _wxGLCanvasSwapBuffers;

typedef _WxGLCanvasSetCurrentNative = Bool Function( Pointer, Pointer  );
typedef _WxGLCanvasSetCurrent = bool Function( Pointer, Pointer  );
late _WxGLCanvasSetCurrent _wxGLCanvasSetCurrent;

class WxGLCanvas extends WxWindow {
  WxGLCanvas._defaultConstructor() : super._defaultConstructor();
  WxGLCanvas( WxWindow parent, WxGLAttributes dispAttrs, int id, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = 0 } ) : super._defaultConstructor() {
    nativeHandle = _wxGLCanvasConstructor( parent.nativeHandle, dispAttrs.nativeHandle, id, pos.x, pos.y, size.x, size.y, style );
    _postCreation();
  }
  WxGLCanvas.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  void swapBuffers( ) {
    _wxGLCanvasSwapBuffers( nativeHandle  );
  }

  bool setCurrent( WxGLContext context ) {
    return _wxGLCanvasSetCurrent( nativeHandle, context.nativeHandle );
  }
}

// ------------------------- wxTextEntry ----------------------

class WxTextEntry extends WxControl {
  WxTextEntry._defaultConstructor() : super._defaultConstructor();
  WxTextEntry.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }
}

// ------------------------- wxTextCtrl ----------------------

typedef _WxTextCtrlConstructorNative = Pointer Function( Pointer, Int32, Pointer<Utf8>, Int32, Int32, Int32, Int32, Int32  );
typedef _WxTextCtrlConstructor = Pointer Function( Pointer, int, Pointer<Utf8>, int, int, int, int, int  );
late _WxTextCtrlConstructor _wxTextCtrlConstructor;

typedef _WxTextCtrlIsModifiedNative = Bool Function( Pointer  );
typedef _WxTextCtrlIsModified = bool Function( Pointer  );
late _WxTextCtrlIsModified _wxTextCtrlIsModified;

typedef _WxTextCtrlMarkDirtyNative = Void Function( Pointer  );
typedef _WxTextCtrlMarkDirty = void Function( Pointer  );
late _WxTextCtrlMarkDirty _wxTextCtrlMarkDirty;

typedef _WxTextCtrlIsSingleLineNative = Bool Function( Pointer  );
typedef _WxTextCtrlIsSingleLine = bool Function( Pointer  );
late _WxTextCtrlIsSingleLine _wxTextCtrlIsSingleLine;

typedef _WxTextCtrlIsMultiLineNative = Bool Function( Pointer  );
typedef _WxTextCtrlIsMultiLine = bool Function( Pointer  );
late _WxTextCtrlIsMultiLine _wxTextCtrlIsMultiLine;

typedef _WxTextCtrlGetNumberOfLinesNative = Int32 Function( Pointer  );
typedef _WxTextCtrlGetNumberOfLines = int Function( Pointer  );
late _WxTextCtrlGetNumberOfLines _wxTextCtrlGetNumberOfLines;

typedef _WxTextCtrlGetLineTextNative = Pointer<Utf8> Function( Pointer, Int32  );
typedef _WxTextCtrlGetLineText = Pointer<Utf8> Function( Pointer, int  );
late _WxTextCtrlGetLineText _wxTextCtrlGetLineText;

typedef _WxTextCtrlGetLineLengthNative = Int32 Function( Pointer, Int32  );
typedef _WxTextCtrlGetLineLength = int Function( Pointer, int  );
late _WxTextCtrlGetLineLength _wxTextCtrlGetLineLength;

typedef _WxTextCtrlAppendTextNative = Void Function( Pointer, Pointer<Utf8>  );
typedef _WxTextCtrlAppendText = void Function( Pointer, Pointer<Utf8>  );
late _WxTextCtrlAppendText _wxTextCtrlAppendText;

typedef _WxTextCtrlWriteTextNative = Void Function( Pointer, Pointer<Utf8>  );
typedef _WxTextCtrlWriteText = void Function( Pointer, Pointer<Utf8>  );
late _WxTextCtrlWriteText _wxTextCtrlWriteText;

typedef _WxTextCtrlChangeValueNative = Void Function( Pointer, Pointer<Utf8>  );
typedef _WxTextCtrlChangeValue = void Function( Pointer, Pointer<Utf8>  );
late _WxTextCtrlChangeValue _wxTextCtrlChangeValue;

typedef _WxTextCtrlSelectAllNative = Void Function( Pointer  );
typedef _WxTextCtrlSelectAll = void Function( Pointer  );
late _WxTextCtrlSelectAll _wxTextCtrlSelectAll;

typedef _WxTextCtrlSelectNoneNative = Void Function( Pointer  );
typedef _WxTextCtrlSelectNone = void Function( Pointer  );
late _WxTextCtrlSelectNone _wxTextCtrlSelectNone;

typedef _WxTextCtrlSetSelectionNative = Void Function( Pointer, Int32, Int32  );
typedef _WxTextCtrlSetSelection = void Function( Pointer, int, int  );
late _WxTextCtrlSetSelection _wxTextCtrlSetSelection;

typedef _WxTextCtrlGetStringSelectionNative = Pointer<Utf8> Function( Pointer  );
typedef _WxTextCtrlGetStringSelection = Pointer<Utf8> Function( Pointer  );
late _WxTextCtrlGetStringSelection _wxTextCtrlGetStringSelection;

typedef _WxTextCtrlRemoveNative = Void Function( Pointer, Int32, Int32  );
typedef _WxTextCtrlRemove = void Function( Pointer, int, int  );
late _WxTextCtrlRemove _wxTextCtrlRemove;

typedef _WxTextCtrlReplaceNative = Void Function( Pointer, Int32, Int32, Pointer<Utf8>  );
typedef _WxTextCtrlReplace = void Function( Pointer, int, int, Pointer<Utf8>  );
late _WxTextCtrlReplace _wxTextCtrlReplace;

typedef _WxTextCtrlSetEditableNative = Void Function( Pointer, Bool  );
typedef _WxTextCtrlSetEditable = void Function( Pointer, bool  );
late _WxTextCtrlSetEditable _wxTextCtrlSetEditable;

typedef _WxTextCtrlSetInsertionPointNative = Void Function( Pointer, Int32  );
typedef _WxTextCtrlSetInsertionPoint = void Function( Pointer, int  );
late _WxTextCtrlSetInsertionPoint _wxTextCtrlSetInsertionPoint;

typedef _WxTextCtrlSetInsertionPointEndNative = Void Function( Pointer  );
typedef _WxTextCtrlSetInsertionPointEnd = void Function( Pointer  );
late _WxTextCtrlSetInsertionPointEnd _wxTextCtrlSetInsertionPointEnd;

typedef _WxTextCtrlGetInsertionPointNative = Int32 Function( Pointer  );
typedef _WxTextCtrlGetInsertionPoint = int Function( Pointer  );
late _WxTextCtrlGetInsertionPoint _wxTextCtrlGetInsertionPoint;

typedef _WxTextCtrlSetMaxLengthNative = Void Function( Pointer, Int32  );
typedef _WxTextCtrlSetMaxLength = void Function( Pointer, int  );
late _WxTextCtrlSetMaxLength _wxTextCtrlSetMaxLength;

typedef _WxTextCtrlClearNative = Void Function( Pointer  );
typedef _WxTextCtrlClear = void Function( Pointer  );
late _WxTextCtrlClear _wxTextCtrlClear;

typedef _WxTextCtrlCopyNative = Void Function( Pointer  );
typedef _WxTextCtrlCopy = void Function( Pointer  );
late _WxTextCtrlCopy _wxTextCtrlCopy;

typedef _WxTextCtrlCutNative = Void Function( Pointer  );
typedef _WxTextCtrlCut = void Function( Pointer  );
late _WxTextCtrlCut _wxTextCtrlCut;

typedef _WxTextCtrlPasteNative = Void Function( Pointer  );
typedef _WxTextCtrlPaste = void Function( Pointer  );
late _WxTextCtrlPaste _wxTextCtrlPaste;

typedef _WxTextCtrlRedoNative = Void Function( Pointer  );
typedef _WxTextCtrlRedo = void Function( Pointer  );
late _WxTextCtrlRedo _wxTextCtrlRedo;

typedef _WxTextCtrlUndoNative = Void Function( Pointer  );
typedef _WxTextCtrlUndo = void Function( Pointer  );
late _WxTextCtrlUndo _wxTextCtrlUndo;

typedef _WxTextCtrlCanCopyNative = Bool Function( Pointer  );
typedef _WxTextCtrlCanCopy = bool Function( Pointer  );
late _WxTextCtrlCanCopy _wxTextCtrlCanCopy;

typedef _WxTextCtrlCanCutNative = Bool Function( Pointer  );
typedef _WxTextCtrlCanCut = bool Function( Pointer  );
late _WxTextCtrlCanCut _wxTextCtrlCanCut;

typedef _WxTextCtrlCanPasteNative = Bool Function( Pointer  );
typedef _WxTextCtrlCanPaste = bool Function( Pointer  );
late _WxTextCtrlCanPaste _wxTextCtrlCanPaste;

typedef _WxTextCtrlCanRedoNative = Bool Function( Pointer  );
typedef _WxTextCtrlCanRedo = bool Function( Pointer  );
late _WxTextCtrlCanRedo _wxTextCtrlCanRedo;

typedef _WxTextCtrlCanUndoNative = Bool Function( Pointer  );
typedef _WxTextCtrlCanUndo = bool Function( Pointer  );
late _WxTextCtrlCanUndo _wxTextCtrlCanUndo;

typedef _WxTextCtrlSetValueNative = Void Function( Pointer, Pointer<Utf8>  );
typedef _WxTextCtrlSetValue = void Function( Pointer, Pointer<Utf8>  );
late _WxTextCtrlSetValue _wxTextCtrlSetValue;

typedef _WxTextCtrlGetValueNative = Pointer<Utf8> Function( Pointer  );
typedef _WxTextCtrlGetValue = Pointer<Utf8> Function( Pointer  );
late _WxTextCtrlGetValue _wxTextCtrlGetValue;

typedef _WxTextCtrlSetHintNative = Void Function( Pointer, Pointer<Utf8>  );
typedef _WxTextCtrlSetHint = void Function( Pointer, Pointer<Utf8>  );
late _WxTextCtrlSetHint _wxTextCtrlSetHint;

typedef _WxTextCtrlGetHintNative = Pointer<Utf8> Function( Pointer  );
typedef _WxTextCtrlGetHint = Pointer<Utf8> Function( Pointer  );
late _WxTextCtrlGetHint _wxTextCtrlGetHint;

typedef _WxTextCtrlIsEditableNative = Bool Function( Pointer  );
typedef _WxTextCtrlIsEditable = bool Function( Pointer  );
late _WxTextCtrlIsEditable _wxTextCtrlIsEditable;

typedef _WxTextCtrlIsEmptyNative = Bool Function( Pointer  );
typedef _WxTextCtrlIsEmpty = bool Function( Pointer  );
late _WxTextCtrlIsEmpty _wxTextCtrlIsEmpty;

/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxTE_READONLY | 0x0010 |
/// | wxTE_MULTILINE | 0x0020 |
/// | wxTE_PROCESS_TAB | 0x0040 |
/// | wxTE_PROCESS_ENTER | 0x0400 |
/// | wxTE_PASSWORD | 0x0800 |

const int wxTE_READONLY = 0x0010;
const int wxTE_MULTILINE = 0x0020;
const int wxTE_PROCESS_TAB = 0x0040;
const int wxTE_PROCESS_ENTER = 0x0400;
const int wxTE_PASSWORD = 0x0800;

class WxTextCtrl extends WxTextEntry {
  WxTextCtrl._defaultConstructor() : super._defaultConstructor();
  WxTextCtrl( WxWindow parent, int id, { String value = "", WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = 0 } ) : super._defaultConstructor() {
    final valueUtf8 = value.toNativeUtf8();
    nativeHandle = _wxTextCtrlConstructor( parent.nativeHandle, id, valueUtf8, pos.x, pos.y, size.x, size.y, style );
    malloc.free( valueUtf8 );
    _postCreation();
  }
  WxTextCtrl.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  bool isModified( ) {
    return _wxTextCtrlIsModified( nativeHandle  );
  }

  void markDirty( ) {
    _wxTextCtrlMarkDirty( nativeHandle  );
  }

  bool isSingleLine( ) {
    return _wxTextCtrlIsSingleLine( nativeHandle  );
  }

  bool isMultiLine( ) {
    return _wxTextCtrlIsMultiLine( nativeHandle  );
  }

  int getNumberOfLines( ) {
    return _wxTextCtrlGetNumberOfLines( nativeHandle  );
  }

  String getLineText( int lineNo ) {
    Pointer<Utf8> ptrReturn = _wxTextCtrlGetLineText( nativeHandle, lineNo );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }

  int getLineLength( int lineNo ) {
    return _wxTextCtrlGetLineLength( nativeHandle, lineNo );
  }

  void appendText( String text ) {
    final textUtf8 = text.toNativeUtf8();
    _wxTextCtrlAppendText( nativeHandle, textUtf8 );
    malloc.free( textUtf8 );
  }

  void writeText( String text ) {
    final textUtf8 = text.toNativeUtf8();
    _wxTextCtrlWriteText( nativeHandle, textUtf8 );
    malloc.free( textUtf8 );
  }

  void changeValue( String text ) {
    final textUtf8 = text.toNativeUtf8();
    _wxTextCtrlChangeValue( nativeHandle, textUtf8 );
    malloc.free( textUtf8 );
  }

  void selectAll( ) {
    _wxTextCtrlSelectAll( nativeHandle  );
  }

  void selectNone( ) {
    _wxTextCtrlSelectNone( nativeHandle  );
  }

  void setSelection( int from, int to ) {
    _wxTextCtrlSetSelection( nativeHandle, from, to );
  }

  String getStringSelection( ) {
    Pointer<Utf8> ptrReturn = _wxTextCtrlGetStringSelection( nativeHandle  );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }

  void remove( int from, int to ) {
    _wxTextCtrlRemove( nativeHandle, from, to );
  }

  void replace( int from, int to, String value ) {
    final valueUtf8 = value.toNativeUtf8();
    _wxTextCtrlReplace( nativeHandle, from, to, valueUtf8 );
    malloc.free( valueUtf8 );
  }

  void setEditable( bool editable ) {
    _wxTextCtrlSetEditable( nativeHandle, editable );
  }

  void setInsertionPoint( int pos ) {
    _wxTextCtrlSetInsertionPoint( nativeHandle, pos );
  }

  void setInsertionPointEnd( ) {
    _wxTextCtrlSetInsertionPointEnd( nativeHandle  );
  }

  int getInsertionPoint( ) {
    return _wxTextCtrlGetInsertionPoint( nativeHandle  );
  }

  void setMaxLength( int maxLength ) {
    _wxTextCtrlSetMaxLength( nativeHandle, maxLength );
  }

  void clear( ) {
    _wxTextCtrlClear( nativeHandle  );
  }

  void copy( ) {
    _wxTextCtrlCopy( nativeHandle  );
  }

  void cut( ) {
    _wxTextCtrlCut( nativeHandle  );
  }

  void paste( ) {
    _wxTextCtrlPaste( nativeHandle  );
  }

  void redo( ) {
    _wxTextCtrlRedo( nativeHandle  );
  }

  void undo( ) {
    _wxTextCtrlUndo( nativeHandle  );
  }

  bool canCopy( ) {
    return _wxTextCtrlCanCopy( nativeHandle  );
  }

  bool canCut( ) {
    return _wxTextCtrlCanCut( nativeHandle  );
  }

  bool canPaste( ) {
    return _wxTextCtrlCanPaste( nativeHandle  );
  }

  bool canRedo( ) {
    return _wxTextCtrlCanRedo( nativeHandle  );
  }

  bool canUndo( ) {
    return _wxTextCtrlCanUndo( nativeHandle  );
  }

  void setValue( String value ) {
    final valueUtf8 = value.toNativeUtf8();
    _wxTextCtrlSetValue( nativeHandle, valueUtf8 );
    malloc.free( valueUtf8 );
  }

  String getValue( ) {
    Pointer<Utf8> ptrReturn = _wxTextCtrlGetValue( nativeHandle  );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }

  void setHint( String hint ) {
    final hintUtf8 = hint.toNativeUtf8();
    _wxTextCtrlSetHint( nativeHandle, hintUtf8 );
    malloc.free( hintUtf8 );
  }

  String getHint( ) {
    Pointer<Utf8> ptrReturn = _wxTextCtrlGetHint( nativeHandle  );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }

  bool isEditable( ) {
    return _wxTextCtrlIsEditable( nativeHandle  );
  }

  bool isEmpty( ) {
    return _wxTextCtrlIsEmpty( nativeHandle  );
  }
}

// ------------------------- wxSearchCtrl ----------------------

typedef _WxSearchCtrlConstructorNative = Pointer Function( Pointer, Int32, Pointer<Utf8>, Int32, Int32, Int32, Int32, Int32  );
typedef _WxSearchCtrlConstructor = Pointer Function( Pointer, int, Pointer<Utf8>, int, int, int, int, int  );
late _WxSearchCtrlConstructor _wxSearchCtrlConstructor;

typedef _WxSearchCtrlIsSearchButtonVisibleNative = Bool Function( Pointer  );
typedef _WxSearchCtrlIsSearchButtonVisible = bool Function( Pointer  );
late _WxSearchCtrlIsSearchButtonVisible _wxSearchCtrlIsSearchButtonVisible;

typedef _WxSearchCtrlIsCancelButtonVisibleNative = Bool Function( Pointer  );
typedef _WxSearchCtrlIsCancelButtonVisible = bool Function( Pointer  );
late _WxSearchCtrlIsCancelButtonVisible _wxSearchCtrlIsCancelButtonVisible;

typedef _WxSearchCtrlShowSearchButtonNative = Void Function( Pointer, Bool  );
typedef _WxSearchCtrlShowSearchButton = void Function( Pointer, bool  );
late _WxSearchCtrlShowSearchButton _wxSearchCtrlShowSearchButton;

typedef _WxSearchCtrlShowCancelButtonNative = Void Function( Pointer, Bool  );
typedef _WxSearchCtrlShowCancelButton = void Function( Pointer, bool  );
late _WxSearchCtrlShowCancelButton _wxSearchCtrlShowCancelButton;

typedef _WxSearchCtrlSetDescriptiveTextNative = Void Function( Pointer, Pointer<Utf8>  );
typedef _WxSearchCtrlSetDescriptiveText = void Function( Pointer, Pointer<Utf8>  );
late _WxSearchCtrlSetDescriptiveText _wxSearchCtrlSetDescriptiveText;

typedef _WxSearchCtrlSetMenuNative = Void Function( Pointer, Pointer  );
typedef _WxSearchCtrlSetMenu = void Function( Pointer, Pointer  );
late _WxSearchCtrlSetMenu _wxSearchCtrlSetMenu;

typedef _WxSearchCtrlAppendTextNative = Void Function( Pointer, Pointer<Utf8>  );
typedef _WxSearchCtrlAppendText = void Function( Pointer, Pointer<Utf8>  );
late _WxSearchCtrlAppendText _wxSearchCtrlAppendText;

typedef _WxSearchCtrlWriteTextNative = Void Function( Pointer, Pointer<Utf8>  );
typedef _WxSearchCtrlWriteText = void Function( Pointer, Pointer<Utf8>  );
late _WxSearchCtrlWriteText _wxSearchCtrlWriteText;

typedef _WxSearchCtrlChangeValueNative = Void Function( Pointer, Pointer<Utf8>  );
typedef _WxSearchCtrlChangeValue = void Function( Pointer, Pointer<Utf8>  );
late _WxSearchCtrlChangeValue _wxSearchCtrlChangeValue;

typedef _WxSearchCtrlSelectAllNative = Void Function( Pointer  );
typedef _WxSearchCtrlSelectAll = void Function( Pointer  );
late _WxSearchCtrlSelectAll _wxSearchCtrlSelectAll;

typedef _WxSearchCtrlSelectNoneNative = Void Function( Pointer  );
typedef _WxSearchCtrlSelectNone = void Function( Pointer  );
late _WxSearchCtrlSelectNone _wxSearchCtrlSelectNone;

typedef _WxSearchCtrlSetSelectionNative = Void Function( Pointer, Int32, Int32  );
typedef _WxSearchCtrlSetSelection = void Function( Pointer, int, int  );
late _WxSearchCtrlSetSelection _wxSearchCtrlSetSelection;

typedef _WxSearchCtrlGetStringSelectionNative = Pointer<Utf8> Function( Pointer  );
typedef _WxSearchCtrlGetStringSelection = Pointer<Utf8> Function( Pointer  );
late _WxSearchCtrlGetStringSelection _wxSearchCtrlGetStringSelection;

typedef _WxSearchCtrlRemoveNative = Void Function( Pointer, Int32, Int32  );
typedef _WxSearchCtrlRemove = void Function( Pointer, int, int  );
late _WxSearchCtrlRemove _wxSearchCtrlRemove;

typedef _WxSearchCtrlReplaceNative = Void Function( Pointer, Int32, Int32, Pointer<Utf8>  );
typedef _WxSearchCtrlReplace = void Function( Pointer, int, int, Pointer<Utf8>  );
late _WxSearchCtrlReplace _wxSearchCtrlReplace;

typedef _WxSearchCtrlSetEditableNative = Void Function( Pointer, Bool  );
typedef _WxSearchCtrlSetEditable = void Function( Pointer, bool  );
late _WxSearchCtrlSetEditable _wxSearchCtrlSetEditable;

typedef _WxSearchCtrlSetInsertionPointNative = Void Function( Pointer, Int32  );
typedef _WxSearchCtrlSetInsertionPoint = void Function( Pointer, int  );
late _WxSearchCtrlSetInsertionPoint _wxSearchCtrlSetInsertionPoint;

typedef _WxSearchCtrlSetInsertionPointEndNative = Void Function( Pointer  );
typedef _WxSearchCtrlSetInsertionPointEnd = void Function( Pointer  );
late _WxSearchCtrlSetInsertionPointEnd _wxSearchCtrlSetInsertionPointEnd;

typedef _WxSearchCtrlGetInsertionPointNative = Int32 Function( Pointer  );
typedef _WxSearchCtrlGetInsertionPoint = int Function( Pointer  );
late _WxSearchCtrlGetInsertionPoint _wxSearchCtrlGetInsertionPoint;

typedef _WxSearchCtrlSetMaxLengthNative = Void Function( Pointer, Int32  );
typedef _WxSearchCtrlSetMaxLength = void Function( Pointer, int  );
late _WxSearchCtrlSetMaxLength _wxSearchCtrlSetMaxLength;

typedef _WxSearchCtrlClearNative = Void Function( Pointer  );
typedef _WxSearchCtrlClear = void Function( Pointer  );
late _WxSearchCtrlClear _wxSearchCtrlClear;

typedef _WxSearchCtrlCopyNative = Void Function( Pointer  );
typedef _WxSearchCtrlCopy = void Function( Pointer  );
late _WxSearchCtrlCopy _wxSearchCtrlCopy;

typedef _WxSearchCtrlCutNative = Void Function( Pointer  );
typedef _WxSearchCtrlCut = void Function( Pointer  );
late _WxSearchCtrlCut _wxSearchCtrlCut;

typedef _WxSearchCtrlPasteNative = Void Function( Pointer  );
typedef _WxSearchCtrlPaste = void Function( Pointer  );
late _WxSearchCtrlPaste _wxSearchCtrlPaste;

typedef _WxSearchCtrlRedoNative = Void Function( Pointer  );
typedef _WxSearchCtrlRedo = void Function( Pointer  );
late _WxSearchCtrlRedo _wxSearchCtrlRedo;

typedef _WxSearchCtrlUndoNative = Void Function( Pointer  );
typedef _WxSearchCtrlUndo = void Function( Pointer  );
late _WxSearchCtrlUndo _wxSearchCtrlUndo;

typedef _WxSearchCtrlCanCopyNative = Bool Function( Pointer  );
typedef _WxSearchCtrlCanCopy = bool Function( Pointer  );
late _WxSearchCtrlCanCopy _wxSearchCtrlCanCopy;

typedef _WxSearchCtrlCanCutNative = Bool Function( Pointer  );
typedef _WxSearchCtrlCanCut = bool Function( Pointer  );
late _WxSearchCtrlCanCut _wxSearchCtrlCanCut;

typedef _WxSearchCtrlCanPasteNative = Bool Function( Pointer  );
typedef _WxSearchCtrlCanPaste = bool Function( Pointer  );
late _WxSearchCtrlCanPaste _wxSearchCtrlCanPaste;

typedef _WxSearchCtrlCanRedoNative = Bool Function( Pointer  );
typedef _WxSearchCtrlCanRedo = bool Function( Pointer  );
late _WxSearchCtrlCanRedo _wxSearchCtrlCanRedo;

typedef _WxSearchCtrlCanUndoNative = Bool Function( Pointer  );
typedef _WxSearchCtrlCanUndo = bool Function( Pointer  );
late _WxSearchCtrlCanUndo _wxSearchCtrlCanUndo;

typedef _WxSearchCtrlSetValueNative = Void Function( Pointer, Pointer<Utf8>  );
typedef _WxSearchCtrlSetValue = void Function( Pointer, Pointer<Utf8>  );
late _WxSearchCtrlSetValue _wxSearchCtrlSetValue;

typedef _WxSearchCtrlGetValueNative = Pointer<Utf8> Function( Pointer  );
typedef _WxSearchCtrlGetValue = Pointer<Utf8> Function( Pointer  );
late _WxSearchCtrlGetValue _wxSearchCtrlGetValue;

typedef _WxSearchCtrlSetHintNative = Void Function( Pointer, Pointer<Utf8>  );
typedef _WxSearchCtrlSetHint = void Function( Pointer, Pointer<Utf8>  );
late _WxSearchCtrlSetHint _wxSearchCtrlSetHint;

typedef _WxSearchCtrlGetHintNative = Pointer<Utf8> Function( Pointer  );
typedef _WxSearchCtrlGetHint = Pointer<Utf8> Function( Pointer  );
late _WxSearchCtrlGetHint _wxSearchCtrlGetHint;

typedef _WxSearchCtrlIsEditableNative = Bool Function( Pointer  );
typedef _WxSearchCtrlIsEditable = bool Function( Pointer  );
late _WxSearchCtrlIsEditable _wxSearchCtrlIsEditable;

typedef _WxSearchCtrlIsEmptyNative = Bool Function( Pointer  );
typedef _WxSearchCtrlIsEmpty = bool Function( Pointer  );
late _WxSearchCtrlIsEmpty _wxSearchCtrlIsEmpty;

class WxSearchCtrl extends WxTextEntry {
  WxSearchCtrl._defaultConstructor() : super._defaultConstructor();
  WxSearchCtrl( WxWindow parent, int id, { String value = "", WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = 0 } ) : super._defaultConstructor() {
    final valueUtf8 = value.toNativeUtf8();
    nativeHandle = _wxSearchCtrlConstructor( parent.nativeHandle, id, valueUtf8, pos.x, pos.y, size.x, size.y, style );
    malloc.free( valueUtf8 );
    _postCreation();
  }
  WxSearchCtrl.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  bool isSearchButtonVisible( ) {
    return _wxSearchCtrlIsSearchButtonVisible( nativeHandle  );
  }

  bool isCancelButtonVisible( ) {
    return _wxSearchCtrlIsCancelButtonVisible( nativeHandle  );
  }

  void showSearchButton( bool show ) {
    _wxSearchCtrlShowSearchButton( nativeHandle, show );
  }

  void showCancelButton( bool show ) {
    _wxSearchCtrlShowCancelButton( nativeHandle, show );
  }

  void setDescriptiveText( String text ) {
    final textUtf8 = text.toNativeUtf8();
    _wxSearchCtrlSetDescriptiveText( nativeHandle, textUtf8 );
    malloc.free( textUtf8 );
  }

  void setMenu( WxMenu? menu ) {
    _wxSearchCtrlSetMenu( nativeHandle, (menu == null) ? nullptr : menu.nativeHandle );
  }

  void appendText( String search ) {
    final searchUtf8 = search.toNativeUtf8();
    _wxSearchCtrlAppendText( nativeHandle, searchUtf8 );
    malloc.free( searchUtf8 );
  }

  void writeText( String search ) {
    final searchUtf8 = search.toNativeUtf8();
    _wxSearchCtrlWriteText( nativeHandle, searchUtf8 );
    malloc.free( searchUtf8 );
  }

  void changeValue( String search ) {
    final searchUtf8 = search.toNativeUtf8();
    _wxSearchCtrlChangeValue( nativeHandle, searchUtf8 );
    malloc.free( searchUtf8 );
  }

  void selectAll( ) {
    _wxSearchCtrlSelectAll( nativeHandle  );
  }

  void selectNone( ) {
    _wxSearchCtrlSelectNone( nativeHandle  );
  }

  void setSelection( int from, int to ) {
    _wxSearchCtrlSetSelection( nativeHandle, from, to );
  }

  String getStringSelection( ) {
    Pointer<Utf8> ptrReturn = _wxSearchCtrlGetStringSelection( nativeHandle  );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }

  void remove( int from, int to ) {
    _wxSearchCtrlRemove( nativeHandle, from, to );
  }

  void replace( int from, int to, String value ) {
    final valueUtf8 = value.toNativeUtf8();
    _wxSearchCtrlReplace( nativeHandle, from, to, valueUtf8 );
    malloc.free( valueUtf8 );
  }

  void setEditable( bool editable ) {
    _wxSearchCtrlSetEditable( nativeHandle, editable );
  }

  void setInsertionPoint( int pos ) {
    _wxSearchCtrlSetInsertionPoint( nativeHandle, pos );
  }

  void setInsertionPointEnd( ) {
    _wxSearchCtrlSetInsertionPointEnd( nativeHandle  );
  }

  int getInsertionPoint( ) {
    return _wxSearchCtrlGetInsertionPoint( nativeHandle  );
  }

  void setMaxLength( int maxLength ) {
    _wxSearchCtrlSetMaxLength( nativeHandle, maxLength );
  }

  void clear( ) {
    _wxSearchCtrlClear( nativeHandle  );
  }

  void copy( ) {
    _wxSearchCtrlCopy( nativeHandle  );
  }

  void cut( ) {
    _wxSearchCtrlCut( nativeHandle  );
  }

  void paste( ) {
    _wxSearchCtrlPaste( nativeHandle  );
  }

  void redo( ) {
    _wxSearchCtrlRedo( nativeHandle  );
  }

  void undo( ) {
    _wxSearchCtrlUndo( nativeHandle  );
  }

  bool canCopy( ) {
    return _wxSearchCtrlCanCopy( nativeHandle  );
  }

  bool canCut( ) {
    return _wxSearchCtrlCanCut( nativeHandle  );
  }

  bool canPaste( ) {
    return _wxSearchCtrlCanPaste( nativeHandle  );
  }

  bool canRedo( ) {
    return _wxSearchCtrlCanRedo( nativeHandle  );
  }

  bool canUndo( ) {
    return _wxSearchCtrlCanUndo( nativeHandle  );
  }

  void setValue( String value ) {
    final valueUtf8 = value.toNativeUtf8();
    _wxSearchCtrlSetValue( nativeHandle, valueUtf8 );
    malloc.free( valueUtf8 );
  }

  String getValue( ) {
    Pointer<Utf8> ptrReturn = _wxSearchCtrlGetValue( nativeHandle  );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }

  void setHint( String hint ) {
    final hintUtf8 = hint.toNativeUtf8();
    _wxSearchCtrlSetHint( nativeHandle, hintUtf8 );
    malloc.free( hintUtf8 );
  }

  String getHint( ) {
    Pointer<Utf8> ptrReturn = _wxSearchCtrlGetHint( nativeHandle  );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }

  bool isEditable( ) {
    return _wxSearchCtrlIsEditable( nativeHandle  );
  }

  bool isEmpty( ) {
    return _wxSearchCtrlIsEmpty( nativeHandle  );
  }
}

// ------------------------- wxComboBox ----------------------

typedef _WxComboBoxConstructorNative = Pointer Function( Pointer, Int32, Pointer<Utf8>, Int32, Int32, Int32, Int32, Int32, Pointer<Pointer<Utf8>>, Int32  );
typedef _WxComboBoxConstructor = Pointer Function( Pointer, int, Pointer<Utf8>, int, int, int, int, int, Pointer<Pointer<Utf8>>, int  );
late _WxComboBoxConstructor _wxComboBoxConstructor;

typedef _WxComboBoxPopupNative = Void Function( Pointer  );
typedef _WxComboBoxPopup = void Function( Pointer  );
late _WxComboBoxPopup _wxComboBoxPopup;

typedef _WxComboBoxDismissNative = Void Function( Pointer  );
typedef _WxComboBoxDismiss = void Function( Pointer  );
late _WxComboBoxDismiss _wxComboBoxDismiss;

typedef _WxComboBoxIsListEmptyNative = Bool Function( Pointer  );
typedef _WxComboBoxIsListEmpty = bool Function( Pointer  );
late _WxComboBoxIsListEmpty _wxComboBoxIsListEmpty;

typedef _WxComboBoxIsTextEmptyNative = Bool Function( Pointer  );
typedef _WxComboBoxIsTextEmpty = bool Function( Pointer  );
late _WxComboBoxIsTextEmpty _wxComboBoxIsTextEmpty;

typedef _WxComboBoxSetSelectionNative = Void Function( Pointer, Int32  );
typedef _WxComboBoxSetSelection = void Function( Pointer, int  );
late _WxComboBoxSetSelection _wxComboBoxSetSelection;

typedef _WxComboBoxSetTextSelectionNative = Void Function( Pointer, Int32, Int32  );
typedef _WxComboBoxSetTextSelection = void Function( Pointer, int, int  );
late _WxComboBoxSetTextSelection _wxComboBoxSetTextSelection;

typedef _WxComboBoxClearNative = Void Function( Pointer  );
typedef _WxComboBoxClear = void Function( Pointer  );
late _WxComboBoxClear _wxComboBoxClear;

typedef _WxComboBoxSetValueNative = Void Function( Pointer, Pointer<Utf8>  );
typedef _WxComboBoxSetValue = void Function( Pointer, Pointer<Utf8>  );
late _WxComboBoxSetValue _wxComboBoxSetValue;

typedef _WxComboBoxGetValueNative = Pointer<Utf8> Function( Pointer  );
typedef _WxComboBoxGetValue = Pointer<Utf8> Function( Pointer  );
late _WxComboBoxGetValue _wxComboBoxGetValue;

typedef _WxComboBoxChangeValueNative = Void Function( Pointer, Pointer<Utf8>  );
typedef _WxComboBoxChangeValue = void Function( Pointer, Pointer<Utf8>  );
late _WxComboBoxChangeValue _wxComboBoxChangeValue;

typedef _WxComboBoxAppendTextNative = Void Function( Pointer, Pointer<Utf8>  );
typedef _WxComboBoxAppendText = void Function( Pointer, Pointer<Utf8>  );
late _WxComboBoxAppendText _wxComboBoxAppendText;

typedef _WxComboBoxWriteTextNative = Void Function( Pointer, Pointer<Utf8>  );
typedef _WxComboBoxWriteText = void Function( Pointer, Pointer<Utf8>  );
late _WxComboBoxWriteText _wxComboBoxWriteText;

typedef _WxComboBoxSelectAllNative = Void Function( Pointer  );
typedef _WxComboBoxSelectAll = void Function( Pointer  );
late _WxComboBoxSelectAll _wxComboBoxSelectAll;

typedef _WxComboBoxSelectNoneNative = Void Function( Pointer  );
typedef _WxComboBoxSelectNone = void Function( Pointer  );
late _WxComboBoxSelectNone _wxComboBoxSelectNone;

typedef _WxComboBoxRemoveNative = Void Function( Pointer, Int32, Int32  );
typedef _WxComboBoxRemove = void Function( Pointer, int, int  );
late _WxComboBoxRemove _wxComboBoxRemove;

typedef _WxComboBoxReplaceNative = Void Function( Pointer, Int32, Int32, Pointer<Utf8>  );
typedef _WxComboBoxReplace = void Function( Pointer, int, int, Pointer<Utf8>  );
late _WxComboBoxReplace _wxComboBoxReplace;

typedef _WxComboBoxSetEditableNative = Void Function( Pointer, Bool  );
typedef _WxComboBoxSetEditable = void Function( Pointer, bool  );
late _WxComboBoxSetEditable _wxComboBoxSetEditable;

typedef _WxComboBoxSetInsertionPointNative = Void Function( Pointer, Int32  );
typedef _WxComboBoxSetInsertionPoint = void Function( Pointer, int  );
late _WxComboBoxSetInsertionPoint _wxComboBoxSetInsertionPoint;

typedef _WxComboBoxSetInsertionPointEndNative = Void Function( Pointer  );
typedef _WxComboBoxSetInsertionPointEnd = void Function( Pointer  );
late _WxComboBoxSetInsertionPointEnd _wxComboBoxSetInsertionPointEnd;

typedef _WxComboBoxGetInsertionPointNative = Int32 Function( Pointer  );
typedef _WxComboBoxGetInsertionPoint = int Function( Pointer  );
late _WxComboBoxGetInsertionPoint _wxComboBoxGetInsertionPoint;

typedef _WxComboBoxSetMaxLengthNative = Void Function( Pointer, Int32  );
typedef _WxComboBoxSetMaxLength = void Function( Pointer, int  );
late _WxComboBoxSetMaxLength _wxComboBoxSetMaxLength;

typedef _WxComboBoxCopyNative = Void Function( Pointer  );
typedef _WxComboBoxCopy = void Function( Pointer  );
late _WxComboBoxCopy _wxComboBoxCopy;

typedef _WxComboBoxCutNative = Void Function( Pointer  );
typedef _WxComboBoxCut = void Function( Pointer  );
late _WxComboBoxCut _wxComboBoxCut;

typedef _WxComboBoxPasteNative = Void Function( Pointer  );
typedef _WxComboBoxPaste = void Function( Pointer  );
late _WxComboBoxPaste _wxComboBoxPaste;

typedef _WxComboBoxRedoNative = Void Function( Pointer  );
typedef _WxComboBoxRedo = void Function( Pointer  );
late _WxComboBoxRedo _wxComboBoxRedo;

typedef _WxComboBoxUndoNative = Void Function( Pointer  );
typedef _WxComboBoxUndo = void Function( Pointer  );
late _WxComboBoxUndo _wxComboBoxUndo;

typedef _WxComboBoxCanCopyNative = Bool Function( Pointer  );
typedef _WxComboBoxCanCopy = bool Function( Pointer  );
late _WxComboBoxCanCopy _wxComboBoxCanCopy;

typedef _WxComboBoxCanCutNative = Bool Function( Pointer  );
typedef _WxComboBoxCanCut = bool Function( Pointer  );
late _WxComboBoxCanCut _wxComboBoxCanCut;

typedef _WxComboBoxCanPasteNative = Bool Function( Pointer  );
typedef _WxComboBoxCanPaste = bool Function( Pointer  );
late _WxComboBoxCanPaste _wxComboBoxCanPaste;

typedef _WxComboBoxCanRedoNative = Bool Function( Pointer  );
typedef _WxComboBoxCanRedo = bool Function( Pointer  );
late _WxComboBoxCanRedo _wxComboBoxCanRedo;

typedef _WxComboBoxCanUndoNative = Bool Function( Pointer  );
typedef _WxComboBoxCanUndo = bool Function( Pointer  );
late _WxComboBoxCanUndo _wxComboBoxCanUndo;

typedef _WxComboBoxSetHintNative = Void Function( Pointer, Pointer<Utf8>  );
typedef _WxComboBoxSetHint = void Function( Pointer, Pointer<Utf8>  );
late _WxComboBoxSetHint _wxComboBoxSetHint;

typedef _WxComboBoxGetHintNative = Pointer<Utf8> Function( Pointer  );
typedef _WxComboBoxGetHint = Pointer<Utf8> Function( Pointer  );
late _WxComboBoxGetHint _wxComboBoxGetHint;

typedef _WxComboBoxIsEditableNative = Bool Function( Pointer  );
typedef _WxComboBoxIsEditable = bool Function( Pointer  );
late _WxComboBoxIsEditable _wxComboBoxIsEditable;

typedef _WxComboBoxGetCountNative = Int32 Function( Pointer  );
typedef _WxComboBoxGetCount = int Function( Pointer  );
late _WxComboBoxGetCount _wxComboBoxGetCount;

typedef _WxComboBoxSetStringNative = Void Function( Pointer, Int32, Pointer<Utf8>  );
typedef _WxComboBoxSetString = void Function( Pointer, int, Pointer<Utf8>  );
late _WxComboBoxSetString _wxComboBoxSetString;

typedef _WxComboBoxGetStringNative = Pointer<Utf8> Function( Pointer, Int32  );
typedef _WxComboBoxGetString = Pointer<Utf8> Function( Pointer, int  );
late _WxComboBoxGetString _wxComboBoxGetString;

typedef _WxComboBoxGetStringsNative = Pointer<Utf8> Function( Pointer  );
typedef _WxComboBoxGetStrings = Pointer<Utf8> Function( Pointer  );
late _WxComboBoxGetStrings _wxComboBoxGetStrings;

typedef _WxComboBoxFindStringNative = Int32 Function( Pointer, Pointer<Utf8>, Bool  );
typedef _WxComboBoxFindString = int Function( Pointer, Pointer<Utf8>, bool  );
late _WxComboBoxFindString _wxComboBoxFindString;

typedef _WxComboBoxSetStringSelectionNative = Void Function( Pointer, Pointer<Utf8>  );
typedef _WxComboBoxSetStringSelection = void Function( Pointer, Pointer<Utf8>  );
late _WxComboBoxSetStringSelection _wxComboBoxSetStringSelection;

typedef _WxComboBoxSelectNative = Void Function( Pointer, Int32  );
typedef _WxComboBoxSelect = void Function( Pointer, int  );
late _WxComboBoxSelect _wxComboBoxSelect;

typedef _WxComboBoxGetSelectionNative = Int32 Function( Pointer  );
typedef _WxComboBoxGetSelection = int Function( Pointer  );
late _WxComboBoxGetSelection _wxComboBoxGetSelection;

typedef _WxComboBoxGetStringSelectionNative = Pointer<Utf8> Function( Pointer  );
typedef _WxComboBoxGetStringSelection = Pointer<Utf8> Function( Pointer  );
late _WxComboBoxGetStringSelection _wxComboBoxGetStringSelection;

typedef _WxComboBoxDeleteNative = Void Function( Pointer, Int32  );
typedef _WxComboBoxDelete = void Function( Pointer, int  );
late _WxComboBoxDelete _wxComboBoxDelete;

typedef _WxComboBoxSetNative = Void Function( Pointer, Int32, Pointer<Pointer<Utf8>>  );
typedef _WxComboBoxSet = void Function( Pointer, int, Pointer<Pointer<Utf8>>  );
late _WxComboBoxSet _wxComboBoxSet;

typedef _WxComboBoxAppendNative = Void Function( Pointer, Pointer<Utf8>, Pointer  );
typedef _WxComboBoxAppend = void Function( Pointer, Pointer<Utf8>, Pointer  );
late _WxComboBoxAppend _wxComboBoxAppend;

typedef _WxComboBoxAppendListNative = Void Function( Pointer, Int32, Pointer<Pointer<Utf8>>  );
typedef _WxComboBoxAppendList = void Function( Pointer, int, Pointer<Pointer<Utf8>>  );
late _WxComboBoxAppendList _wxComboBoxAppendList;

typedef _WxComboBoxInsertNative = Void Function( Pointer, Pointer<Utf8>, Int32, Pointer  );
typedef _WxComboBoxInsert = void Function( Pointer, Pointer<Utf8>, int, Pointer  );
late _WxComboBoxInsert _wxComboBoxInsert;

typedef _WxComboBoxInsertListNative = Void Function( Pointer, Int32, Pointer<Pointer<Utf8>>, Int32  );
typedef _WxComboBoxInsertList = void Function( Pointer, int, Pointer<Pointer<Utf8>>, int  );
late _WxComboBoxInsertList _wxComboBoxInsertList;

typedef _WxComboBoxSetClientDataNative = Void Function( Pointer, Int32, Pointer  );
typedef _WxComboBoxSetClientData = void Function( Pointer, int, Pointer  );
late _WxComboBoxSetClientData _wxComboBoxSetClientData;

typedef _WxComboBoxGetClientDataNative = Pointer Function( Pointer, Int32  );
typedef _WxComboBoxGetClientData = Pointer Function( Pointer, int  );
late _WxComboBoxGetClientData _wxComboBoxGetClientData;

/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxCB_SIMPLE | 0x0004 |
/// | wxCB_SORT | 0x0008 |
/// | wxCB_READONLY | 0x0010 |
/// | wxCB_DROPDOWN | 0x0020 |

const int wxCB_SIMPLE = 0x0004;
const int wxCB_SORT = 0x0008;
const int wxCB_READONLY = 0x0010;
const int wxCB_DROPDOWN = 0x0020;

class WxComboBox extends WxItemContainer {
  WxComboBox._defaultConstructor() : super._defaultConstructor();
  WxComboBox( WxWindow parent, int id, { String value = '', WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, List<String>? choices, int style = 0 } ) : super._defaultConstructor() {
    final valueUtf8 = value.toNativeUtf8();
    Pointer<Pointer<Utf8>> choicesptrPtr = nullptr;
    List<Pointer<Utf8>> choicesUtf8PointerList = [];
    int choicesLength = 0;
    if ((choices != null) && (choices.isNotEmpty)) {
      choicesUtf8PointerList = choices.map((str) => str.toNativeUtf8()).toList();
      choicesptrPtr = malloc.allocate(choicesUtf8PointerList.length * sizeOf<Pointer<Utf8>>());
      choices.asMap().forEach((index, utf) { choicesptrPtr[index] = choicesUtf8PointerList[index]; });
      choicesLength = choices.length;
    }
    nativeHandle = _wxComboBoxConstructor( parent.nativeHandle, id, valueUtf8, pos.x, pos.y, size.x, size.y, choicesLength, choicesptrPtr, style );
    malloc.free( valueUtf8 );
    if ((choices != null) && (choices.isNotEmpty)) {
      malloc.free( choicesptrPtr );
      for (final utf8 in choicesUtf8PointerList) { malloc.free( utf8 ); }
    }
    _postCreation();
  }
  WxComboBox.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  void popup( ) {
    _wxComboBoxPopup( nativeHandle  );
  }

  void dismiss( ) {
    _wxComboBoxDismiss( nativeHandle  );
  }

  bool isListEmpty( ) {
    return _wxComboBoxIsListEmpty( nativeHandle  );
  }

  bool isTextEmpty( ) {
    return _wxComboBoxIsTextEmpty( nativeHandle  );
  }

  void setSelection( int n ) {
    _wxComboBoxSetSelection( nativeHandle, n );
  }

  void setTextSelection( int from, int to ) {
    _wxComboBoxSetTextSelection( nativeHandle, from, to );
  }

  void clear( ) {
    _wxComboBoxClear( nativeHandle  );
  }

  void setValue( String value ) {
    final valueUtf8 = value.toNativeUtf8();
    _wxComboBoxSetValue( nativeHandle, valueUtf8 );
    malloc.free( valueUtf8 );
  }

  String getValue( ) {
    Pointer<Utf8> ptrReturn = _wxComboBoxGetValue( nativeHandle  );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }

  void changeValue( String text ) {
    final textUtf8 = text.toNativeUtf8();
    _wxComboBoxChangeValue( nativeHandle, textUtf8 );
    malloc.free( textUtf8 );
  }

  void appendText( String text ) {
    final textUtf8 = text.toNativeUtf8();
    _wxComboBoxAppendText( nativeHandle, textUtf8 );
    malloc.free( textUtf8 );
  }

  void writeText( String text ) {
    final textUtf8 = text.toNativeUtf8();
    _wxComboBoxWriteText( nativeHandle, textUtf8 );
    malloc.free( textUtf8 );
  }

  void selectAll( ) {
    _wxComboBoxSelectAll( nativeHandle  );
  }

  void selectNone( ) {
    _wxComboBoxSelectNone( nativeHandle  );
  }

  void remove( int from, int to ) {
    _wxComboBoxRemove( nativeHandle, from, to );
  }

  void replace( int from, int to, String value ) {
    final valueUtf8 = value.toNativeUtf8();
    _wxComboBoxReplace( nativeHandle, from, to, valueUtf8 );
    malloc.free( valueUtf8 );
  }

  void setEditable( bool editable ) {
    _wxComboBoxSetEditable( nativeHandle, editable );
  }

  void setInsertionPoint( int pos ) {
    _wxComboBoxSetInsertionPoint( nativeHandle, pos );
  }

  void setInsertionPointEnd( ) {
    _wxComboBoxSetInsertionPointEnd( nativeHandle  );
  }

  int getInsertionPoint( ) {
    return _wxComboBoxGetInsertionPoint( nativeHandle  );
  }

  void setMaxLength( int maxLength ) {
    _wxComboBoxSetMaxLength( nativeHandle, maxLength );
  }

  void copy( ) {
    _wxComboBoxCopy( nativeHandle  );
  }

  void cut( ) {
    _wxComboBoxCut( nativeHandle  );
  }

  void paste( ) {
    _wxComboBoxPaste( nativeHandle  );
  }

  void redo( ) {
    _wxComboBoxRedo( nativeHandle  );
  }

  void undo( ) {
    _wxComboBoxUndo( nativeHandle  );
  }

  bool canCopy( ) {
    return _wxComboBoxCanCopy( nativeHandle  );
  }

  bool canCut( ) {
    return _wxComboBoxCanCut( nativeHandle  );
  }

  bool canPaste( ) {
    return _wxComboBoxCanPaste( nativeHandle  );
  }

  bool canRedo( ) {
    return _wxComboBoxCanRedo( nativeHandle  );
  }

  bool canUndo( ) {
    return _wxComboBoxCanUndo( nativeHandle  );
  }

  void setHint( String hint ) {
    final hintUtf8 = hint.toNativeUtf8();
    _wxComboBoxSetHint( nativeHandle, hintUtf8 );
    malloc.free( hintUtf8 );
  }

  String getHint( ) {
    Pointer<Utf8> ptrReturn = _wxComboBoxGetHint( nativeHandle  );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }

  bool isEditable( ) {
    return _wxComboBoxIsEditable( nativeHandle  );
  }

  int getCount( ) {
    return _wxComboBoxGetCount( nativeHandle  );
  }

  void setString( int index, String str ) {
    final strUtf8 = str.toNativeUtf8();
    _wxComboBoxSetString( nativeHandle, index, strUtf8 );
    malloc.free( strUtf8 );
  }

  String getString( int index ) {
    Pointer<Utf8> ptrReturn = _wxComboBoxGetString( nativeHandle, index );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }

  List<String> getStrings( ) {
    Pointer<Utf8> ptrReturn = _wxComboBoxGetStrings( nativeHandle  );
    final List dynValues = jsonDecode(ptrReturn.toDartString());
    malloc.free( ptrReturn );
    final List<String> values = [];
    for ( final value in dynValues) { values.add( value as String ); }
    return values;
  }

  int findString( String string, { bool caseSensitive = false } ) {
    final stringUtf8 = string.toNativeUtf8();
    return _wxComboBoxFindString( nativeHandle, stringUtf8, caseSensitive );
  }

  void setStringSelection( String sel ) {
    final selUtf8 = sel.toNativeUtf8();
    _wxComboBoxSetStringSelection( nativeHandle, selUtf8 );
    malloc.free( selUtf8 );
  }

  void select( int index ) {
    _wxComboBoxSelect( nativeHandle, index );
  }

  int getSelection( ) {
    return _wxComboBoxGetSelection( nativeHandle  );
  }

  String getStringSelection( ) {
    Pointer<Utf8> ptrReturn = _wxComboBoxGetStringSelection( nativeHandle  );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }

  void delete( int index ) {
    _wxComboBoxDelete( nativeHandle, index );
  }

  void set( List<String> items ) {
    Pointer<Pointer<Utf8>> itemsptrPtr = nullptr;
    List<Pointer<Utf8>> itemsUtf8PointerList = [];
    int itemsLength = 0;
    if (items.isNotEmpty) {
      itemsUtf8PointerList = items.map((str) => str.toNativeUtf8()).toList();
      itemsptrPtr = malloc.allocate(itemsUtf8PointerList.length * sizeOf<Pointer<Utf8>>());
      items.asMap().forEach((index, utf) { itemsptrPtr[index] = itemsUtf8PointerList[index]; });
      itemsLength = items.length;
    }
    _wxComboBoxSet( nativeHandle, itemsLength, itemsptrPtr );
    if (items.isNotEmpty) {
      malloc.free( itemsptrPtr );
      for (final utf8 in itemsUtf8PointerList) { malloc.free( utf8 ); }
    }
  }

  void append( String item, { dynamic data } ) {
    final itemUtf8 = item.toNativeUtf8();
    final dataClientDataNativeHandle = _wxClientDataConstructor();
    _clientDataList[ dataClientDataNativeHandle ] = data;
    _wxComboBoxAppend( nativeHandle, itemUtf8, dataClientDataNativeHandle );
    malloc.free( itemUtf8 );
  }

  void appendList( List<String> items ) {
    Pointer<Pointer<Utf8>> itemsptrPtr = nullptr;
    List<Pointer<Utf8>> itemsUtf8PointerList = [];
    int itemsLength = 0;
    if (items.isNotEmpty) {
      itemsUtf8PointerList = items.map((str) => str.toNativeUtf8()).toList();
      itemsptrPtr = malloc.allocate(itemsUtf8PointerList.length * sizeOf<Pointer<Utf8>>());
      items.asMap().forEach((index, utf) { itemsptrPtr[index] = itemsUtf8PointerList[index]; });
      itemsLength = items.length;
    }
    _wxComboBoxAppendList( nativeHandle, itemsLength, itemsptrPtr );
    if (items.isNotEmpty) {
      malloc.free( itemsptrPtr );
      for (final utf8 in itemsUtf8PointerList) { malloc.free( utf8 ); }
    }
  }

  void insert( String item, int pos, { dynamic data } ) {
    final itemUtf8 = item.toNativeUtf8();
    final dataClientDataNativeHandle = _wxClientDataConstructor();
    _clientDataList[ dataClientDataNativeHandle ] = data;
    _wxComboBoxInsert( nativeHandle, itemUtf8, pos, dataClientDataNativeHandle );
    malloc.free( itemUtf8 );
  }

  void insertList( List<String> items, int pos ) {
    Pointer<Pointer<Utf8>> itemsptrPtr = nullptr;
    List<Pointer<Utf8>> itemsUtf8PointerList = [];
    int itemsLength = 0;
    if (items.isNotEmpty) {
      itemsUtf8PointerList = items.map((str) => str.toNativeUtf8()).toList();
      itemsptrPtr = malloc.allocate(itemsUtf8PointerList.length * sizeOf<Pointer<Utf8>>());
      items.asMap().forEach((index, utf) { itemsptrPtr[index] = itemsUtf8PointerList[index]; });
      itemsLength = items.length;
    }
    _wxComboBoxInsertList( nativeHandle, itemsLength, itemsptrPtr, pos );
    if (items.isNotEmpty) {
      malloc.free( itemsptrPtr );
      for (final utf8 in itemsUtf8PointerList) { malloc.free( utf8 ); }
    }
  }

  void setClientData( int index, dynamic data ) {
    final dataClientDataNativeHandle = _wxClientDataConstructor();
    _clientDataList[ dataClientDataNativeHandle ] = data;
    _wxComboBoxSetClientData( nativeHandle, index, dataClientDataNativeHandle );
  }

  dynamic getClientData( int index ) {
    final returnedNativeHandle = _wxComboBoxGetClientData( nativeHandle, index );
    if (returnedNativeHandle == nullptr) return null;
    return _clientDataList[ returnedNativeHandle ] ;
  }
}

// ------------------------- wxBitmapComboBox ----------------------

typedef _WxBitmapComboBoxConstructorNative = Pointer Function( Pointer, Int32, Pointer<Utf8>, Int32, Int32, Int32, Int32, Int32, Pointer<Pointer<Utf8>>, Int32  );
typedef _WxBitmapComboBoxConstructor = Pointer Function( Pointer, int, Pointer<Utf8>, int, int, int, int, int, Pointer<Pointer<Utf8>>, int  );
late _WxBitmapComboBoxConstructor _wxBitmapComboBoxConstructor;

typedef _WxBitmapComboBoxAppendWithBitmapNative = Void Function( Pointer, Pointer<Utf8>, Pointer, Pointer  );
typedef _WxBitmapComboBoxAppendWithBitmap = void Function( Pointer, Pointer<Utf8>, Pointer, Pointer  );
late _WxBitmapComboBoxAppendWithBitmap _wxBitmapComboBoxAppendWithBitmap;

typedef _WxBitmapComboBoxInsertWithBitmapNative = Void Function( Pointer, Pointer<Utf8>, Pointer, Int32, Pointer  );
typedef _WxBitmapComboBoxInsertWithBitmap = void Function( Pointer, Pointer<Utf8>, Pointer, int, Pointer  );
late _WxBitmapComboBoxInsertWithBitmap _wxBitmapComboBoxInsertWithBitmap;

typedef _WxBitmapComboBoxSetItemBitmapNative = Void Function( Pointer, Int32, Pointer  );
typedef _WxBitmapComboBoxSetItemBitmap = void Function( Pointer, int, Pointer  );
late _WxBitmapComboBoxSetItemBitmap _wxBitmapComboBoxSetItemBitmap;

class WxBitmapComboBox extends WxComboBox {
  WxBitmapComboBox._defaultConstructor() : super._defaultConstructor();
  WxBitmapComboBox( WxWindow parent, int id, { String value = '', WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, List<String>? choices, int style = 0 } ) : super._defaultConstructor() {
    final valueUtf8 = value.toNativeUtf8();
    Pointer<Pointer<Utf8>> choicesptrPtr = nullptr;
    List<Pointer<Utf8>> choicesUtf8PointerList = [];
    int choicesLength = 0;
    if ((choices != null) && (choices.isNotEmpty)) {
      choicesUtf8PointerList = choices.map((str) => str.toNativeUtf8()).toList();
      choicesptrPtr = malloc.allocate(choicesUtf8PointerList.length * sizeOf<Pointer<Utf8>>());
      choices.asMap().forEach((index, utf) { choicesptrPtr[index] = choicesUtf8PointerList[index]; });
      choicesLength = choices.length;
    }
    nativeHandle = _wxBitmapComboBoxConstructor( parent.nativeHandle, id, valueUtf8, pos.x, pos.y, size.x, size.y, choicesLength, choicesptrPtr, style );
    malloc.free( valueUtf8 );
    if ((choices != null) && (choices.isNotEmpty)) {
      malloc.free( choicesptrPtr );
      for (final utf8 in choicesUtf8PointerList) { malloc.free( utf8 ); }
    }
    _postCreation();
  }
  WxBitmapComboBox.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  void appendWithBitmap( String item, WxBitmapBundle bundle, { dynamic data } ) {
    final itemUtf8 = item.toNativeUtf8();
    final dataClientDataNativeHandle = _wxClientDataConstructor();
    _clientDataList[ dataClientDataNativeHandle ] = data;
    _wxBitmapComboBoxAppendWithBitmap( nativeHandle, itemUtf8, bundle.nativeHandle, dataClientDataNativeHandle );
    malloc.free( itemUtf8 );
  }

  void insertWithBitmap( String item, WxBitmapBundle bundle, int pos, { dynamic data } ) {
    final itemUtf8 = item.toNativeUtf8();
    final dataClientDataNativeHandle = _wxClientDataConstructor();
    _clientDataList[ dataClientDataNativeHandle ] = data;
    _wxBitmapComboBoxInsertWithBitmap( nativeHandle, itemUtf8, bundle.nativeHandle, pos, dataClientDataNativeHandle );
    malloc.free( itemUtf8 );
  }

  void setItemBitmap( int pos, WxBitmapBundle bundle ) {
    _wxBitmapComboBoxSetItemBitmap( nativeHandle, pos, bundle.nativeHandle );
  }
}

// ------------------------- wxTreeEvent ----------------------

typedef _WxTreeEventConstructorNative = Pointer Function( Int32, Pointer, Pointer  );
typedef _WxTreeEventConstructor = Pointer Function( int, Pointer, Pointer  );
late _WxTreeEventConstructor _wxTreeEventConstructor;

typedef _WxTreeEventGetItemNative = Pointer Function( Pointer  );
typedef _WxTreeEventGetItem = Pointer Function( Pointer  );
late _WxTreeEventGetItem _wxTreeEventGetItem;

typedef _WxTreeEventGetLabelNative = Pointer<Utf8> Function( Pointer  );
typedef _WxTreeEventGetLabel = Pointer<Utf8> Function( Pointer  );
late _WxTreeEventGetLabel _wxTreeEventGetLabel;

typedef _WxTreeEventGetPointNative = WxPointNative Function( Pointer  );
typedef _WxTreeEventGetPoint = WxPointNative Function( Pointer  );
late _WxTreeEventGetPoint _wxTreeEventGetPoint;

typedef _WxTreeEventIsEditCancelledNative = Bool Function( Pointer  );
typedef _WxTreeEventIsEditCancelled = bool Function( Pointer  );
late _WxTreeEventIsEditCancelled _wxTreeEventIsEditCancelled;

class WxTreeEvent extends WxNotifyEvent {
  WxTreeEvent._defaultConstructor() : super._defaultConstructor();
  WxTreeEvent( int eventType, WxTreeCtrl tree, WxTreeItemId item ) : super._defaultConstructor() {
    nativeHandle = _wxTreeEventConstructor( eventType, tree.nativeHandle, item.getId() );
    attachFinalizer();
  }
  WxTreeEvent.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  WxTreeItemId getItem( ) {
    final returnId = _wxTreeEventGetItem( nativeHandle  );
    return WxTreeItemId( returnId );
  }

  String getLabel( ) {
    Pointer<Utf8> ptrReturn = _wxTreeEventGetLabel( nativeHandle  );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }

  WxPoint getPoint( ) {
    final WxPointNative pointReturn = _wxTreeEventGetPoint( nativeHandle  );
    return WxPoint(pointReturn.x, pointReturn.y);
  }

  bool isEditCancelled( ) {
    return _wxTreeEventIsEditCancelled( nativeHandle  );
  }
}

typedef _WxInstallDartTreeEventCallbackNative = Void Function( Pointer );
typedef _WxInstallDartTreeEventCallback = void Function( Pointer );
late _WxInstallDartTreeEventCallback _wxInstallDartTreeEventCallback;

typedef OnTreeEventFunc = void Function( WxTreeEvent event );
class WxTreeEventListItems {
  WxTreeEventListItems( this.func, this.eventType, this.eventId );
  final OnTreeEventFunc func;
  final int eventType;
  final int eventId;
}
Map<Pointer, List<WxTreeEventListItems>> wxTreeEventHandlerList = {};

void wxTreeEventCallback( Pointer handle, Pointer eventHandle ) {
    WxTreeEvent event = WxTreeEvent.fromHandle( eventHandle );

    final List<WxTreeEventListItems>? list = wxTreeEventHandlerList[handle];
    if (list == null) {
      wxLogError('Handle does not exist in wxTreeEventHandlerList');
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

typedef WxTreeEventCallbackNative = Void Function( Pointer, Pointer );
late NativeCallable<Void Function(Pointer<NativeType>, Pointer<NativeType>)> wxTreeEventNativeCallable;

// ------------------------- wxTreeCtrl ----------------------

typedef _WxTreeCtrlConstructorNative = Pointer Function( Pointer, Int32, Int32, Int32, Int32, Int32, Int32  );
typedef _WxTreeCtrlConstructor = Pointer Function( Pointer, int, int, int, int, int, int  );
late _WxTreeCtrlConstructor _wxTreeCtrlConstructor;

typedef _WxTreeCtrlSetImagesNative = Void Function( Pointer, Pointer  );
typedef _WxTreeCtrlSetImages = void Function( Pointer, Pointer  );
late _WxTreeCtrlSetImages _wxTreeCtrlSetImages;

typedef _WxTreeCtrlHasImagesNative = Bool Function( Pointer  );
typedef _WxTreeCtrlHasImages = bool Function( Pointer  );
late _WxTreeCtrlHasImages _wxTreeCtrlHasImages;

typedef _WxTreeCtrlGetImageCountNative = Int32 Function( Pointer  );
typedef _WxTreeCtrlGetImageCount = int Function( Pointer  );
late _WxTreeCtrlGetImageCount _wxTreeCtrlGetImageCount;

typedef _WxTreeCtrlSetSpacingNative = Void Function( Pointer, Int32  );
typedef _WxTreeCtrlSetSpacing = void Function( Pointer, int  );
late _WxTreeCtrlSetSpacing _wxTreeCtrlSetSpacing;

typedef _WxTreeCtrlSetIndentNative = Void Function( Pointer, Int32  );
typedef _WxTreeCtrlSetIndent = void Function( Pointer, int  );
late _WxTreeCtrlSetIndent _wxTreeCtrlSetIndent;

typedef _WxTreeCtrlGetSpacingNative = Int32 Function( Pointer  );
typedef _WxTreeCtrlGetSpacing = int Function( Pointer  );
late _WxTreeCtrlGetSpacing _wxTreeCtrlGetSpacing;

typedef _WxTreeCtrlGetIndentNative = Int32 Function( Pointer  );
typedef _WxTreeCtrlGetIndent = int Function( Pointer  );
late _WxTreeCtrlGetIndent _wxTreeCtrlGetIndent;

typedef _WxTreeCtrlAddRootNative = Pointer Function( Pointer, Pointer<Utf8>, Int32, Int32, Pointer  );
typedef _WxTreeCtrlAddRoot = Pointer Function( Pointer, Pointer<Utf8>, int, int, Pointer  );
late _WxTreeCtrlAddRoot _wxTreeCtrlAddRoot;

typedef _WxTreeCtrlAppendItemNative = Pointer Function( Pointer, Pointer, Pointer<Utf8>, Int32, Int32, Pointer  );
typedef _WxTreeCtrlAppendItem = Pointer Function( Pointer, Pointer, Pointer<Utf8>, int, int, Pointer  );
late _WxTreeCtrlAppendItem _wxTreeCtrlAppendItem;

typedef _WxTreeCtrlPrependItemNative = Pointer Function( Pointer, Pointer, Pointer<Utf8>, Int32, Int32, Pointer  );
typedef _WxTreeCtrlPrependItem = Pointer Function( Pointer, Pointer, Pointer<Utf8>, int, int, Pointer  );
late _WxTreeCtrlPrependItem _wxTreeCtrlPrependItem;

typedef _WxTreeCtrlInsertItemNative = Pointer Function( Pointer, Pointer, Int32, Pointer<Utf8>, Int32, Int32, Pointer  );
typedef _WxTreeCtrlInsertItem = Pointer Function( Pointer, Pointer, int, Pointer<Utf8>, int, int, Pointer  );
late _WxTreeCtrlInsertItem _wxTreeCtrlInsertItem;

typedef _WxTreeCtrlInsertItemAfterNative = Pointer Function( Pointer, Pointer, Pointer, Pointer<Utf8>, Int32, Int32, Pointer  );
typedef _WxTreeCtrlInsertItemAfter = Pointer Function( Pointer, Pointer, Pointer, Pointer<Utf8>, int, int, Pointer  );
late _WxTreeCtrlInsertItemAfter _wxTreeCtrlInsertItemAfter;

typedef _WxTreeCtrlDeleteNative = Void Function( Pointer, Pointer  );
typedef _WxTreeCtrlDelete = void Function( Pointer, Pointer  );
late _WxTreeCtrlDelete _wxTreeCtrlDelete;

typedef _WxTreeCtrlDeleteChildrenNative = Void Function( Pointer, Pointer  );
typedef _WxTreeCtrlDeleteChildren = void Function( Pointer, Pointer  );
late _WxTreeCtrlDeleteChildren _wxTreeCtrlDeleteChildren;

typedef _WxTreeCtrlDeleteAllItemsNative = Void Function( Pointer  );
typedef _WxTreeCtrlDeleteAllItems = void Function( Pointer  );
late _WxTreeCtrlDeleteAllItems _wxTreeCtrlDeleteAllItems;

typedef _WxTreeCtrlGetCountNative = Int32 Function( Pointer  );
typedef _WxTreeCtrlGetCount = int Function( Pointer  );
late _WxTreeCtrlGetCount _wxTreeCtrlGetCount;

typedef _WxTreeCtrlGetChildrenCountNative = Int32 Function( Pointer, Pointer, Bool  );
typedef _WxTreeCtrlGetChildrenCount = int Function( Pointer, Pointer, bool  );
late _WxTreeCtrlGetChildrenCount _wxTreeCtrlGetChildrenCount;

typedef _WxTreeCtrlEnsureVisibleNative = Void Function( Pointer, Pointer  );
typedef _WxTreeCtrlEnsureVisible = void Function( Pointer, Pointer  );
late _WxTreeCtrlEnsureVisible _wxTreeCtrlEnsureVisible;

typedef _WxTreeCtrlGetRootItemNative = Pointer Function( Pointer  );
typedef _WxTreeCtrlGetRootItem = Pointer Function( Pointer  );
late _WxTreeCtrlGetRootItem _wxTreeCtrlGetRootItem;

typedef _WxTreeCtrlGetItemParentNative = Pointer Function( Pointer, Pointer  );
typedef _WxTreeCtrlGetItemParent = Pointer Function( Pointer, Pointer  );
late _WxTreeCtrlGetItemParent _wxTreeCtrlGetItemParent;

typedef _WxTreeCtrlGetFirstChildNative = Pointer Function( Pointer, Pointer  );
typedef _WxTreeCtrlGetFirstChild = Pointer Function( Pointer, Pointer  );
late _WxTreeCtrlGetFirstChild _wxTreeCtrlGetFirstChild;

typedef _WxTreeCtrlGetLastChildNative = Pointer Function( Pointer, Pointer  );
typedef _WxTreeCtrlGetLastChild = Pointer Function( Pointer, Pointer  );
late _WxTreeCtrlGetLastChild _wxTreeCtrlGetLastChild;

typedef _WxTreeCtrlGetNextSiblingNative = Pointer Function( Pointer, Pointer  );
typedef _WxTreeCtrlGetNextSibling = Pointer Function( Pointer, Pointer  );
late _WxTreeCtrlGetNextSibling _wxTreeCtrlGetNextSibling;

typedef _WxTreeCtrlGetPrevSiblingNative = Pointer Function( Pointer, Pointer  );
typedef _WxTreeCtrlGetPrevSibling = Pointer Function( Pointer, Pointer  );
late _WxTreeCtrlGetPrevSibling _wxTreeCtrlGetPrevSibling;

typedef _WxTreeCtrlGetFocusedItemNative = Pointer Function( Pointer  );
typedef _WxTreeCtrlGetFocusedItem = Pointer Function( Pointer  );
late _WxTreeCtrlGetFocusedItem _wxTreeCtrlGetFocusedItem;

typedef _WxTreeCtrlSetFocusedItemNative = Void Function( Pointer, Pointer  );
typedef _WxTreeCtrlSetFocusedItem = void Function( Pointer, Pointer  );
late _WxTreeCtrlSetFocusedItem _wxTreeCtrlSetFocusedItem;

typedef _WxTreeCtrlClearFocusedItemNative = Void Function( Pointer  );
typedef _WxTreeCtrlClearFocusedItem = void Function( Pointer  );
late _WxTreeCtrlClearFocusedItem _wxTreeCtrlClearFocusedItem;

typedef _WxTreeCtrlGetSelectionNative = Pointer Function( Pointer  );
typedef _WxTreeCtrlGetSelection = Pointer Function( Pointer  );
late _WxTreeCtrlGetSelection _wxTreeCtrlGetSelection;

typedef _WxTreeCtrlIsSelectedNative = Bool Function( Pointer, Pointer  );
typedef _WxTreeCtrlIsSelected = bool Function( Pointer, Pointer  );
late _WxTreeCtrlIsSelected _wxTreeCtrlIsSelected;

typedef _WxTreeCtrlSelectItemNative = Void Function( Pointer, Pointer, Bool  );
typedef _WxTreeCtrlSelectItem = void Function( Pointer, Pointer, bool  );
late _WxTreeCtrlSelectItem _wxTreeCtrlSelectItem;

typedef _WxTreeCtrlUnselectItemNative = Void Function( Pointer, Pointer  );
typedef _WxTreeCtrlUnselectItem = void Function( Pointer, Pointer  );
late _WxTreeCtrlUnselectItem _wxTreeCtrlUnselectItem;

typedef _WxTreeCtrlSelectChildrenNative = Void Function( Pointer, Pointer  );
typedef _WxTreeCtrlSelectChildren = void Function( Pointer, Pointer  );
late _WxTreeCtrlSelectChildren _wxTreeCtrlSelectChildren;

typedef _WxTreeCtrlToggleItemSelectionNative = Void Function( Pointer, Pointer  );
typedef _WxTreeCtrlToggleItemSelection = void Function( Pointer, Pointer  );
late _WxTreeCtrlToggleItemSelection _wxTreeCtrlToggleItemSelection;

typedef _WxTreeCtrlIsExpandedNative = Bool Function( Pointer, Pointer  );
typedef _WxTreeCtrlIsExpanded = bool Function( Pointer, Pointer  );
late _WxTreeCtrlIsExpanded _wxTreeCtrlIsExpanded;

typedef _WxTreeCtrlItemHasChildrenNative = Bool Function( Pointer, Pointer  );
typedef _WxTreeCtrlItemHasChildren = bool Function( Pointer, Pointer  );
late _WxTreeCtrlItemHasChildren _wxTreeCtrlItemHasChildren;

typedef _WxTreeCtrlExpandNative = Void Function( Pointer, Pointer  );
typedef _WxTreeCtrlExpand = void Function( Pointer, Pointer  );
late _WxTreeCtrlExpand _wxTreeCtrlExpand;

typedef _WxTreeCtrlExpandAllNative = Void Function( Pointer  );
typedef _WxTreeCtrlExpandAll = void Function( Pointer  );
late _WxTreeCtrlExpandAll _wxTreeCtrlExpandAll;

typedef _WxTreeCtrlExpandAllChildrenNative = Void Function( Pointer, Pointer  );
typedef _WxTreeCtrlExpandAllChildren = void Function( Pointer, Pointer  );
late _WxTreeCtrlExpandAllChildren _wxTreeCtrlExpandAllChildren;

typedef _WxTreeCtrlToggleNative = Void Function( Pointer, Pointer  );
typedef _WxTreeCtrlToggle = void Function( Pointer, Pointer  );
late _WxTreeCtrlToggle _wxTreeCtrlToggle;

typedef _WxTreeCtrlCollapseNative = Void Function( Pointer, Pointer  );
typedef _WxTreeCtrlCollapse = void Function( Pointer, Pointer  );
late _WxTreeCtrlCollapse _wxTreeCtrlCollapse;

typedef _WxTreeCtrlCollapseAndResetNative = Void Function( Pointer, Pointer  );
typedef _WxTreeCtrlCollapseAndReset = void Function( Pointer, Pointer  );
late _WxTreeCtrlCollapseAndReset _wxTreeCtrlCollapseAndReset;

typedef _WxTreeCtrlCollapseAllNative = Void Function( Pointer  );
typedef _WxTreeCtrlCollapseAll = void Function( Pointer  );
late _WxTreeCtrlCollapseAll _wxTreeCtrlCollapseAll;

typedef _WxTreeCtrlCollapseAllChildrenNative = Void Function( Pointer, Pointer  );
typedef _WxTreeCtrlCollapseAllChildren = void Function( Pointer, Pointer  );
late _WxTreeCtrlCollapseAllChildren _wxTreeCtrlCollapseAllChildren;

typedef _WxTreeCtrlSetItemTextNative = Void Function( Pointer, Pointer, Pointer<Utf8>  );
typedef _WxTreeCtrlSetItemText = void Function( Pointer, Pointer, Pointer<Utf8>  );
late _WxTreeCtrlSetItemText _wxTreeCtrlSetItemText;

typedef _WxTreeCtrlGetItemTextNative = Pointer<Utf8> Function( Pointer, Pointer  );
typedef _WxTreeCtrlGetItemText = Pointer<Utf8> Function( Pointer, Pointer  );
late _WxTreeCtrlGetItemText _wxTreeCtrlGetItemText;

typedef _WxTreeCtrlSetItemDataNative = Void Function( Pointer, Pointer, Pointer  );
typedef _WxTreeCtrlSetItemData = void Function( Pointer, Pointer, Pointer  );
late _WxTreeCtrlSetItemData _wxTreeCtrlSetItemData;

typedef _WxTreeCtrlGetItemDataNative = Pointer Function( Pointer, Pointer  );
typedef _WxTreeCtrlGetItemData = Pointer Function( Pointer, Pointer  );
late _WxTreeCtrlGetItemData _wxTreeCtrlGetItemData;

/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxTreeItemIcon_Normal | 0 |
/// | wxTreeItemIcon_Selected | 1 |
/// | wxTreeItemIcon_Expanded | 2 |
/// | wxTreeItemIcon_SelectedExpanded | 3 |
/// | wxTreeItemIcon_Max | 4 |
/// | wxTREE_ITEMSTATE_NONE | -1 |
/// | wxTREE_ITEMSTATE_NEXT | -2 |
/// | wxTREE_ITEMSTATE_PREV  | -3 |
/// | wxTR_NO_BUTTONS | 0x0000 |
/// | wxTR_HAS_BUTTONS | 0x0001 |
/// | wxTR_NO_LINES | 0x0004 |
/// | wxTR_LINES_AT_ROOT | 0x0008 |
/// | wxTR_TWIST_BUTTONS | 0x0010 |
/// | wxTR_SINGLE | 0x0000 |
/// | wxTR_MULTIPLE  | 0x0020 |
/// | wxTR_HAS_VARIABLE_ROW_HEIGHT | 0x0080 |
/// | wxTR_EDIT_LABELS | 0x0200 |
/// | wxTR_ROW_LINES | 0x0400 |
/// | wxTR_HIDE_ROOT | 0x0800 |
/// | wxTR_FULL_ROW_HIGHLIGHT | 0x2000 |
/// | wxTR_DEFAULT_STYLE  | (wxTR_HAS_BUTTONS | wxTR_NO_LINES | wxTR_FULL_ROW_HIGHLIGHT) |

const int wxTreeItemIcon_Normal = 0;
const int wxTreeItemIcon_Selected = 1;
const int wxTreeItemIcon_Expanded = 2;
const int wxTreeItemIcon_SelectedExpanded = 3;
const int wxTreeItemIcon_Max = 4;
const int wxTREE_ITEMSTATE_NONE = -1;
const int wxTREE_ITEMSTATE_NEXT = -2;
const int wxTREE_ITEMSTATE_PREV  = -3;
const int wxTR_NO_BUTTONS = 0x0000;
const int wxTR_HAS_BUTTONS = 0x0001;
const int wxTR_NO_LINES = 0x0004;
const int wxTR_LINES_AT_ROOT = 0x0008;
const int wxTR_TWIST_BUTTONS = 0x0010;
const int wxTR_SINGLE = 0x0000;
const int wxTR_MULTIPLE  = 0x0020;
const int wxTR_HAS_VARIABLE_ROW_HEIGHT = 0x0080;
const int wxTR_EDIT_LABELS = 0x0200;
const int wxTR_ROW_LINES = 0x0400;
const int wxTR_HIDE_ROOT = 0x0800;
const int wxTR_FULL_ROW_HIGHLIGHT = 0x2000;
const int wxTR_DEFAULT_STYLE  = (wxTR_HAS_BUTTONS | wxTR_NO_LINES | wxTR_FULL_ROW_HIGHLIGHT);

class WxTreeCtrl extends WxControl {
  WxTreeCtrl._defaultConstructor() : super._defaultConstructor();
  WxTreeCtrl( WxWindow parent, int id, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = wxTR_DEFAULT_STYLE } ) : super._defaultConstructor() {
    nativeHandle = _wxTreeCtrlConstructor( parent.nativeHandle, id, pos.x, pos.y, size.x, size.y, style );
    _postCreation();
  }
  WxTreeCtrl.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  void setImages( List<WxBitmapBundle> images ) {
    final imagesList = wxListBitmapBundleToVectorBitmapBundle( images );
    _wxTreeCtrlSetImages( nativeHandle, imagesList.nativeHandle );
    // imagesList.dispose();
  }

  bool hasImages( ) {
    return _wxTreeCtrlHasImages( nativeHandle  );
  }

  int getImageCount( ) {
    return _wxTreeCtrlGetImageCount( nativeHandle  );
  }

  void setSpacing( int spacing ) {
    _wxTreeCtrlSetSpacing( nativeHandle, spacing );
  }

  void setIndent( int indent ) {
    _wxTreeCtrlSetIndent( nativeHandle, indent );
  }

  int getSpacing( ) {
    return _wxTreeCtrlGetSpacing( nativeHandle  );
  }

  int getIndent( ) {
    return _wxTreeCtrlGetIndent( nativeHandle  );
  }

  WxTreeItemId addRoot( String text, { int image = -1, int selImage = -1, dynamic data } ) {
    final textUtf8 = text.toNativeUtf8();
    final dataClientDataNativeHandle = _wxTreeItemDataConstructor();
    _clientDataList[ dataClientDataNativeHandle ] = data;
    final returnId = _wxTreeCtrlAddRoot( nativeHandle, textUtf8, image, selImage, dataClientDataNativeHandle );
    malloc.free( textUtf8 );
    return WxTreeItemId( returnId );
  }

  WxTreeItemId appendItem( WxTreeItemId parent, String text, { int image = -1, int selImage = -1, dynamic data } ) {
    final textUtf8 = text.toNativeUtf8();
    final dataClientDataNativeHandle = _wxTreeItemDataConstructor();
    _clientDataList[ dataClientDataNativeHandle ] = data;
    final returnId = _wxTreeCtrlAppendItem( nativeHandle, parent.getId(), textUtf8, image, selImage, dataClientDataNativeHandle );
    malloc.free( textUtf8 );
    return WxTreeItemId( returnId );
  }

  WxTreeItemId prependItem( WxTreeItemId parent, String text, { int image = -1, int selImage = -1, dynamic data } ) {
    final textUtf8 = text.toNativeUtf8();
    final dataClientDataNativeHandle = _wxTreeItemDataConstructor();
    _clientDataList[ dataClientDataNativeHandle ] = data;
    final returnId = _wxTreeCtrlPrependItem( nativeHandle, parent.getId(), textUtf8, image, selImage, dataClientDataNativeHandle );
    malloc.free( textUtf8 );
    return WxTreeItemId( returnId );
  }

  WxTreeItemId insertItem( WxTreeItemId parent, int pos, String text, { int image = -1, int selImage = -1, dynamic data } ) {
    final textUtf8 = text.toNativeUtf8();
    final dataClientDataNativeHandle = _wxTreeItemDataConstructor();
    _clientDataList[ dataClientDataNativeHandle ] = data;
    final returnId = _wxTreeCtrlInsertItem( nativeHandle, parent.getId(), pos, textUtf8, image, selImage, dataClientDataNativeHandle );
    malloc.free( textUtf8 );
    return WxTreeItemId( returnId );
  }

  WxTreeItemId insertItemAfter( WxTreeItemId parent, WxTreeItemId previous, String text, { int image = -1, int selImage = -1, dynamic data } ) {
    final textUtf8 = text.toNativeUtf8();
    final dataClientDataNativeHandle = _wxTreeItemDataConstructor();
    _clientDataList[ dataClientDataNativeHandle ] = data;
    final returnId = _wxTreeCtrlInsertItemAfter( nativeHandle, parent.getId(), previous.getId(), textUtf8, image, selImage, dataClientDataNativeHandle );
    malloc.free( textUtf8 );
    return WxTreeItemId( returnId );
  }

  void delete( WxTreeItemId item ) {
    _wxTreeCtrlDelete( nativeHandle, item.getId() );
  }

  void deleteChildren( WxTreeItemId item ) {
    _wxTreeCtrlDeleteChildren( nativeHandle, item.getId() );
  }

  void deleteAllItems( ) {
    _wxTreeCtrlDeleteAllItems( nativeHandle  );
  }

  int getCount( ) {
    return _wxTreeCtrlGetCount( nativeHandle  );
  }

  int getChildrenCount( WxTreeItemId item, { bool recursively = true } ) {
    return _wxTreeCtrlGetChildrenCount( nativeHandle, item.getId(), recursively );
  }

  void ensureVisible( WxTreeItemId item ) {
    _wxTreeCtrlEnsureVisible( nativeHandle, item.getId() );
  }

  WxTreeItemId getRootItem( ) {
    final returnId = _wxTreeCtrlGetRootItem( nativeHandle  );
    return WxTreeItemId( returnId );
  }

  WxTreeItemId getItemParent( WxTreeItemId item ) {
    final returnId = _wxTreeCtrlGetItemParent( nativeHandle, item.getId() );
    return WxTreeItemId( returnId );
  }

  WxTreeItemId getFirstChild( WxTreeItemId parent ) {
    final returnId = _wxTreeCtrlGetFirstChild( nativeHandle, parent.getId() );
    return WxTreeItemId( returnId );
  }

  WxTreeItemId getLastChild( WxTreeItemId parent ) {
    final returnId = _wxTreeCtrlGetLastChild( nativeHandle, parent.getId() );
    return WxTreeItemId( returnId );
  }

  WxTreeItemId getNextSibling( WxTreeItemId item ) {
    final returnId = _wxTreeCtrlGetNextSibling( nativeHandle, item.getId() );
    return WxTreeItemId( returnId );
  }

  WxTreeItemId getPrevSibling( WxTreeItemId item ) {
    final returnId = _wxTreeCtrlGetPrevSibling( nativeHandle, item.getId() );
    return WxTreeItemId( returnId );
  }

  WxTreeItemId getFocusedItem( ) {
    final returnId = _wxTreeCtrlGetFocusedItem( nativeHandle  );
    return WxTreeItemId( returnId );
  }

  void setFocusedItem( WxTreeItemId item ) {
    _wxTreeCtrlSetFocusedItem( nativeHandle, item.getId() );
  }

  void clearFocusedItem( ) {
    _wxTreeCtrlClearFocusedItem( nativeHandle  );
  }

  WxTreeItemId getSelection( ) {
    final returnId = _wxTreeCtrlGetSelection( nativeHandle  );
    return WxTreeItemId( returnId );
  }

  bool isSelected( WxTreeItemId item ) {
    return _wxTreeCtrlIsSelected( nativeHandle, item.getId() );
  }

  void selectItem( WxTreeItemId item, { bool select = true } ) {
    _wxTreeCtrlSelectItem( nativeHandle, item.getId(), select );
  }

  void unselectItem( WxTreeItemId item ) {
    _wxTreeCtrlUnselectItem( nativeHandle, item.getId() );
  }

  void selectChildren( WxTreeItemId item ) {
    _wxTreeCtrlSelectChildren( nativeHandle, item.getId() );
  }

  void toggleItemSelection( WxTreeItemId item ) {
    _wxTreeCtrlToggleItemSelection( nativeHandle, item.getId() );
  }

  bool isExpanded( WxTreeItemId item ) {
    return _wxTreeCtrlIsExpanded( nativeHandle, item.getId() );
  }

  bool itemHasChildren( WxTreeItemId item ) {
    return _wxTreeCtrlItemHasChildren( nativeHandle, item.getId() );
  }

  void expand( WxTreeItemId item ) {
    _wxTreeCtrlExpand( nativeHandle, item.getId() );
  }

  void expandAll( ) {
    _wxTreeCtrlExpandAll( nativeHandle  );
  }

  void expandAllChildren( WxTreeItemId item ) {
    _wxTreeCtrlExpandAllChildren( nativeHandle, item.getId() );
  }

  void toggle( WxTreeItemId item ) {
    _wxTreeCtrlToggle( nativeHandle, item.getId() );
  }

  void collapse( WxTreeItemId item ) {
    _wxTreeCtrlCollapse( nativeHandle, item.getId() );
  }

  void collapseAndReset( WxTreeItemId item ) {
    _wxTreeCtrlCollapseAndReset( nativeHandle, item.getId() );
  }

  void collapseAll( ) {
    _wxTreeCtrlCollapseAll( nativeHandle  );
  }

  void collapseAllChildren( WxTreeItemId item ) {
    _wxTreeCtrlCollapseAllChildren( nativeHandle, item.getId() );
  }

  void setItemText( WxTreeItemId item, String text ) {
    final textUtf8 = text.toNativeUtf8();
    _wxTreeCtrlSetItemText( nativeHandle, item.getId(), textUtf8 );
    malloc.free( textUtf8 );
  }

  String getItemText( WxTreeItemId item ) {
    Pointer<Utf8> ptrReturn = _wxTreeCtrlGetItemText( nativeHandle, item.getId() );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }

  void setItemData( WxTreeItemId item, dynamic data ) {
    final dataClientDataNativeHandle = _wxTreeItemDataConstructor();
    _clientDataList[ dataClientDataNativeHandle ] = data;
    _wxTreeCtrlSetItemData( nativeHandle, item.getId(), dataClientDataNativeHandle );
  }

  dynamic getItemData( WxTreeItemId item ) {
    final returnedNativeHandle = _wxTreeCtrlGetItemData( nativeHandle, item.getId() );
    if (returnedNativeHandle == nullptr) return null;
    return _clientDataList[ returnedNativeHandle ] ;
  }
}

// ------------------------- wxSplitterWindow ----------------------

typedef _WxSplitterWindowConstructorNative = Pointer Function( Pointer, Int32, Int32, Int32, Int32, Int32, Int32  );
typedef _WxSplitterWindowConstructor = Pointer Function( Pointer, int, int, int, int, int, int  );
late _WxSplitterWindowConstructor _wxSplitterWindowConstructor;

typedef _WxSplitterWindowSplitHorizontallyNative = Bool Function( Pointer, Pointer, Pointer, Int32  );
typedef _WxSplitterWindowSplitHorizontally = bool Function( Pointer, Pointer, Pointer, int  );
late _WxSplitterWindowSplitHorizontally _wxSplitterWindowSplitHorizontally;

typedef _WxSplitterWindowSplitVerticallyNative = Bool Function( Pointer, Pointer, Pointer, Int32  );
typedef _WxSplitterWindowSplitVertically = bool Function( Pointer, Pointer, Pointer, int  );
late _WxSplitterWindowSplitVertically _wxSplitterWindowSplitVertically;

typedef _WxSplitterWindowSetMinimumPaneSizeNative = Void Function( Pointer, Int32  );
typedef _WxSplitterWindowSetMinimumPaneSize = void Function( Pointer, int  );
late _WxSplitterWindowSetMinimumPaneSize _wxSplitterWindowSetMinimumPaneSize;

typedef _WxSplitterWindowIsSplitNative = Bool Function( Pointer  );
typedef _WxSplitterWindowIsSplit = bool Function( Pointer  );
late _WxSplitterWindowIsSplit _wxSplitterWindowIsSplit;

typedef _WxSplitterWindowSetSashInvisibleNative = Void Function( Pointer, Bool  );
typedef _WxSplitterWindowSetSashInvisible = void Function( Pointer, bool  );
late _WxSplitterWindowSetSashInvisible _wxSplitterWindowSetSashInvisible;

typedef _WxSplitterWindowIsSashInvisibleNative = Bool Function( Pointer  );
typedef _WxSplitterWindowIsSashInvisible = bool Function( Pointer  );
late _WxSplitterWindowIsSashInvisible _wxSplitterWindowIsSashInvisible;

typedef _WxSplitterWindowSetSashPositionNative = Void Function( Pointer, Int32, Bool  );
typedef _WxSplitterWindowSetSashPosition = void Function( Pointer, int, bool  );
late _WxSplitterWindowSetSashPosition _wxSplitterWindowSetSashPosition;

typedef _WxSplitterWindowGetSashPositionNative = Int32 Function( Pointer  );
typedef _WxSplitterWindowGetSashPosition = int Function( Pointer  );
late _WxSplitterWindowGetSashPosition _wxSplitterWindowGetSashPosition;

typedef _WxSplitterWindowSetSashGravityNative = Void Function( Pointer, Double  );
typedef _WxSplitterWindowSetSashGravity = void Function( Pointer, double  );
late _WxSplitterWindowSetSashGravity _wxSplitterWindowSetSashGravity;

typedef _WxSplitterWindowGetSashGravityNative = Double Function( Pointer  );
typedef _WxSplitterWindowGetSashGravity = double Function( Pointer  );
late _WxSplitterWindowGetSashGravity _wxSplitterWindowGetSashGravity;

typedef _WxSplitterWindowUnsplitNative = Bool Function( Pointer, Pointer  );
typedef _WxSplitterWindowUnsplit = bool Function( Pointer, Pointer  );
late _WxSplitterWindowUnsplit _wxSplitterWindowUnsplit;

typedef _WxSplitterWindowUpdateSizeNative = Void Function( Pointer  );
typedef _WxSplitterWindowUpdateSize = void Function( Pointer  );
late _WxSplitterWindowUpdateSize _wxSplitterWindowUpdateSize;

/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxSP_NOBORDER | 0x0000 |
/// | wxSP_THIN_SASH | 0x0000 |
/// | wxSP_NOSASH | 0x0010 |
/// | wxSP_PERMIT_UNSPLIT | 0x0040 |
/// | wxSP_LIVE_UPDATE | 0x0080 |
/// | wxSP_3DSASH | 0x0100 |
/// | wxSP_3DBORDER | 0x0200 |
/// | wxSP_NO_XP_THEME | 0x0400 |
/// | wxSP_BORDER | wxSP_3DBORDER |
/// | wxSP_3D | (wxSP_3DBORDER | wxSP_3DSASH) |

const int wxSP_NOBORDER = 0x0000;
const int wxSP_THIN_SASH = 0x0000;
const int wxSP_NOSASH = 0x0010;
const int wxSP_PERMIT_UNSPLIT = 0x0040;
const int wxSP_LIVE_UPDATE = 0x0080;
const int wxSP_3DSASH = 0x0100;
const int wxSP_3DBORDER = 0x0200;
const int wxSP_NO_XP_THEME = 0x0400;
const int wxSP_BORDER = wxSP_3DBORDER;
const int wxSP_3D = (wxSP_3DBORDER | wxSP_3DSASH);

class WxSplitterWindow extends WxWindow {
  WxSplitterWindow._defaultConstructor() : super._defaultConstructor();
  WxSplitterWindow( WxWindow parent, int id, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = wxSP_3D } ) : super._defaultConstructor() {
    nativeHandle = _wxSplitterWindowConstructor( parent.nativeHandle, id, pos.x, pos.y, size.x, size.y, style );
    _postCreation();
  }
  WxSplitterWindow.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  bool splitHorizontally( WxWindow window1, WxWindow window2, { int sashPosition = 0 } ) {
    return _wxSplitterWindowSplitHorizontally( nativeHandle, window1.nativeHandle, window2.nativeHandle, sashPosition );
  }

  bool splitVertically( WxWindow window1, WxWindow window2, { int sashPosition = 0 } ) {
    return _wxSplitterWindowSplitVertically( nativeHandle, window1.nativeHandle, window2.nativeHandle, sashPosition );
  }

  void setMinimumPaneSize( int paneSize ) {
    _wxSplitterWindowSetMinimumPaneSize( nativeHandle, paneSize );
  }

  bool isSplit( ) {
    return _wxSplitterWindowIsSplit( nativeHandle  );
  }

  void setSashInvisible( { bool invisible = true } ) {
    _wxSplitterWindowSetSashInvisible( nativeHandle, invisible );
  }

  bool isSashInvisible( ) {
    return _wxSplitterWindowIsSashInvisible( nativeHandle  );
  }

  void setSashPosition( int pos, { bool redraw = true } ) {
    _wxSplitterWindowSetSashPosition( nativeHandle, pos, redraw );
  }

  int getSashPosition( ) {
    return _wxSplitterWindowGetSashPosition( nativeHandle  );
  }

  void setSashGravity( double gravity ) {
    _wxSplitterWindowSetSashGravity( nativeHandle, gravity );
  }

  double getSashGravity( ) {
    return _wxSplitterWindowGetSashGravity( nativeHandle  );
  }

  bool unsplit( WxWindow toRemove ) {
    return _wxSplitterWindowUnsplit( nativeHandle, toRemove.nativeHandle );
  }

  void updateSize( ) {
    _wxSplitterWindowUpdateSize( nativeHandle  );
  }
}

// ------------------------- wxSplitterEvent ----------------------

typedef _WxSplitterEventConstructorNative = Pointer Function( Int32, Pointer  );
typedef _WxSplitterEventConstructor = Pointer Function( int, Pointer  );
late _WxSplitterEventConstructor _wxSplitterEventConstructor;

typedef _WxSplitterEventSetSashPositionNative = Void Function( Pointer, Int32  );
typedef _WxSplitterEventSetSashPosition = void Function( Pointer, int  );
late _WxSplitterEventSetSashPosition _wxSplitterEventSetSashPosition;

typedef _WxSplitterEventGetSashPositionNative = Int32 Function( Pointer  );
typedef _WxSplitterEventGetSashPosition = int Function( Pointer  );
late _WxSplitterEventGetSashPosition _wxSplitterEventGetSashPosition;

typedef _WxSplitterEventGetXNative = Int32 Function( Pointer  );
typedef _WxSplitterEventGetX = int Function( Pointer  );
late _WxSplitterEventGetX _wxSplitterEventGetX;

typedef _WxSplitterEventGetYNative = Int32 Function( Pointer  );
typedef _WxSplitterEventGetY = int Function( Pointer  );
late _WxSplitterEventGetY _wxSplitterEventGetY;

typedef _WxSplitterEventGetWindowBeingRemovedNative = Pointer Function( Pointer  );
typedef _WxSplitterEventGetWindowBeingRemoved = Pointer Function( Pointer  );
late _WxSplitterEventGetWindowBeingRemoved _wxSplitterEventGetWindowBeingRemoved;

class WxSplitterEvent extends WxNotifyEvent {
  WxSplitterEvent._defaultConstructor() : super._defaultConstructor();
  WxSplitterEvent( { int eventType = 0, WxSplitterWindow? splitter } ) : super._defaultConstructor() {
    nativeHandle = _wxSplitterEventConstructor( eventType, (splitter == null) ? nullptr : splitter.nativeHandle );
    attachFinalizer();
  }
  WxSplitterEvent.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  void setSashPosition( int pos ) {
    _wxSplitterEventSetSashPosition( nativeHandle, pos );
  }

  int getSashPosition( ) {
    return _wxSplitterEventGetSashPosition( nativeHandle  );
  }

  int getX( ) {
    return _wxSplitterEventGetX( nativeHandle  );
  }

  int getY( ) {
    return _wxSplitterEventGetY( nativeHandle  );
  }

  WxWindow? getWindowBeingRemoved( ) {
    final returnedNativeHandle = _wxSplitterEventGetWindowBeingRemoved( nativeHandle  );
    if (returnedNativeHandle == nullptr) return null;
    WxEvtHandler? eh = _evtHandlerList[returnedNativeHandle];
    if (eh != null) {
      // There already is a Dart class associated with this C++ object
      return eh as WxWindow;
    }
    return wxCreateBestMatchingClassFromWxWindowHandle( returnedNativeHandle );
  }
}

typedef _WxInstallDartSplitterEventCallbackNative = Void Function( Pointer );
typedef _WxInstallDartSplitterEventCallback = void Function( Pointer );
late _WxInstallDartSplitterEventCallback _wxInstallDartSplitterEventCallback;

typedef OnSplitterEventFunc = void Function( WxSplitterEvent event );
class WxSplitterEventListItems {
  WxSplitterEventListItems( this.func, this.eventType, this.eventId );
  final OnSplitterEventFunc func;
  final int eventType;
  final int eventId;
}
Map<Pointer, List<WxSplitterEventListItems>> wxSplitterEventHandlerList = {};

void wxSplitterEventCallback( Pointer handle, Pointer eventHandle ) {
    WxSplitterEvent event = WxSplitterEvent.fromHandle( eventHandle );

    final List<WxSplitterEventListItems>? list = wxSplitterEventHandlerList[handle];
    if (list == null) {
      wxLogError('Handle does not exist in wxSplitterEventHandlerList');
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

typedef WxSplitterEventCallbackNative = Void Function( Pointer, Pointer );
late NativeCallable<Void Function(Pointer<NativeType>, Pointer<NativeType>)> wxSplitterEventNativeCallable;

// ------------------------- wxHtmlWindow ----------------------

typedef _WxHtmlWindowConstructorNative = Pointer Function( Pointer, Int32, Int32, Int32, Int32, Int32, Int32  );
typedef _WxHtmlWindowConstructor = Pointer Function( Pointer, int, int, int, int, int, int  );
late _WxHtmlWindowConstructor _wxHtmlWindowConstructor;

typedef _WxHtmlWindowSetPageNative = Void Function( Pointer, Pointer<Utf8>  );
typedef _WxHtmlWindowSetPage = void Function( Pointer, Pointer<Utf8>  );
late _WxHtmlWindowSetPage _wxHtmlWindowSetPage;

typedef _WxHtmlWindowLoadPageNative = Void Function( Pointer, Pointer<Utf8>  );
typedef _WxHtmlWindowLoadPage = void Function( Pointer, Pointer<Utf8>  );
late _WxHtmlWindowLoadPage _wxHtmlWindowLoadPage;

class WxHtmlWindow extends WxScrolledWindow {
  WxHtmlWindow._defaultConstructor() : super._defaultConstructor();
  WxHtmlWindow( WxWindow parent, int id, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = 0 } ) : super._defaultConstructor() {
    nativeHandle = _wxHtmlWindowConstructor( parent.nativeHandle, id, pos.x, pos.y, size.x, size.y, style );
    _postCreation();
  }
  WxHtmlWindow.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  void setPage( String source ) {
    final sourceUtf8 = source.toNativeUtf8();
    _wxHtmlWindowSetPage( nativeHandle, sourceUtf8 );
    malloc.free( sourceUtf8 );
  }

  void loadPage( String location ) {
    final locationUtf8 = location.toNativeUtf8();
    _wxHtmlWindowLoadPage( nativeHandle, locationUtf8 );
    malloc.free( locationUtf8 );
  }
}

// ------------------------- wxHtmlLinkEvent ----------------------

typedef _WxHtmlLinkEventConstructorNative = Pointer Function( Int32, Pointer<Utf8>  );
typedef _WxHtmlLinkEventConstructor = Pointer Function( int, Pointer<Utf8>  );
late _WxHtmlLinkEventConstructor _wxHtmlLinkEventConstructor;

typedef _WxHtmlLinkEventGetTargetNative = Pointer<Utf8> Function( Pointer  );
typedef _WxHtmlLinkEventGetTarget = Pointer<Utf8> Function( Pointer  );
late _WxHtmlLinkEventGetTarget _wxHtmlLinkEventGetTarget;

typedef _WxHtmlLinkEventGetHrefNative = Pointer<Utf8> Function( Pointer  );
typedef _WxHtmlLinkEventGetHref = Pointer<Utf8> Function( Pointer  );
late _WxHtmlLinkEventGetHref _wxHtmlLinkEventGetHref;

class WxHtmlLinkEvent extends WxCommandEvent {
  WxHtmlLinkEvent._defaultConstructor() : super._defaultConstructor();
  WxHtmlLinkEvent( int id, String href ) : super._defaultConstructor() {
    final hrefUtf8 = href.toNativeUtf8();
    nativeHandle = _wxHtmlLinkEventConstructor( id, hrefUtf8 );
    malloc.free( hrefUtf8 );
    attachFinalizer();
  }
  WxHtmlLinkEvent.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  String getTarget( ) {
    Pointer<Utf8> ptrReturn = _wxHtmlLinkEventGetTarget( nativeHandle  );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }

  String getHref( ) {
    Pointer<Utf8> ptrReturn = _wxHtmlLinkEventGetHref( nativeHandle  );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }
}

typedef _WxInstallDartHtmlLinkEventCallbackNative = Void Function( Pointer );
typedef _WxInstallDartHtmlLinkEventCallback = void Function( Pointer );
late _WxInstallDartHtmlLinkEventCallback _wxInstallDartHtmlLinkEventCallback;

typedef OnHtmlLinkEventFunc = void Function( WxHtmlLinkEvent event );
class WxHtmlLinkEventListItems {
  WxHtmlLinkEventListItems( this.func, this.eventType, this.eventId );
  final OnHtmlLinkEventFunc func;
  final int eventType;
  final int eventId;
}
Map<Pointer, List<WxHtmlLinkEventListItems>> wxHtmlLinkEventHandlerList = {};

void wxHtmlLinkEventCallback( Pointer handle, Pointer eventHandle ) {
    WxHtmlLinkEvent event = WxHtmlLinkEvent.fromHandle( eventHandle );

    final List<WxHtmlLinkEventListItems>? list = wxHtmlLinkEventHandlerList[handle];
    if (list == null) {
      wxLogError('Handle does not exist in wxHtmlLinkEventHandlerList');
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

typedef WxHtmlLinkEventCallbackNative = Void Function( Pointer, Pointer );
late NativeCallable<Void Function(Pointer<NativeType>, Pointer<NativeType>)> wxHtmlLinkEventNativeCallable;

// ------------------------- wxCollapsiblePane ----------------------

typedef _WxCollapsiblePaneConstructorNative = Pointer Function( Pointer, Int32, Pointer<Utf8>, Int32, Int32, Int32, Int32, Int32  );
typedef _WxCollapsiblePaneConstructor = Pointer Function( Pointer, int, Pointer<Utf8>, int, int, int, int, int  );
late _WxCollapsiblePaneConstructor _wxCollapsiblePaneConstructor;

typedef _WxCollapsiblePaneIsCollapsedNative = Bool Function( Pointer  );
typedef _WxCollapsiblePaneIsCollapsed = bool Function( Pointer  );
late _WxCollapsiblePaneIsCollapsed _wxCollapsiblePaneIsCollapsed;

typedef _WxCollapsiblePaneIsExpandedNative = Bool Function( Pointer  );
typedef _WxCollapsiblePaneIsExpanded = bool Function( Pointer  );
late _WxCollapsiblePaneIsExpanded _wxCollapsiblePaneIsExpanded;

typedef _WxCollapsiblePaneCollapseNative = Void Function( Pointer, Bool  );
typedef _WxCollapsiblePaneCollapse = void Function( Pointer, bool  );
late _WxCollapsiblePaneCollapse _wxCollapsiblePaneCollapse;

typedef _WxCollapsiblePaneExpandNative = Void Function( Pointer  );
typedef _WxCollapsiblePaneExpand = void Function( Pointer  );
late _WxCollapsiblePaneExpand _wxCollapsiblePaneExpand;

typedef _WxCollapsiblePaneGetPaneNative = Pointer Function( Pointer  );
typedef _WxCollapsiblePaneGetPane = Pointer Function( Pointer  );
late _WxCollapsiblePaneGetPane _wxCollapsiblePaneGetPane;

/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxCP_DEFAULT_STYLE | wxTAB_TRAVERSAL|wxBORDER_NONE |
/// | wxCP_NO_TLW_RESIZE | 0x0002 |

const int wxCP_DEFAULT_STYLE = wxTAB_TRAVERSAL|wxBORDER_NONE;
const int wxCP_NO_TLW_RESIZE = 0x0002;

class WxCollapsiblePane extends WxControl {
  WxCollapsiblePane._defaultConstructor() : super._defaultConstructor();
  WxCollapsiblePane( WxWindow parent, int id, String label, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = wxCP_DEFAULT_STYLE } ) : super._defaultConstructor() {
    final labelUtf8 = label.toNativeUtf8();
    nativeHandle = _wxCollapsiblePaneConstructor( parent.nativeHandle, id, labelUtf8, pos.x, pos.y, size.x, size.y, style );
    malloc.free( labelUtf8 );
    _postCreation();
  }
  WxCollapsiblePane.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  bool isCollapsed( ) {
    return _wxCollapsiblePaneIsCollapsed( nativeHandle  );
  }

  bool isExpanded( ) {
    return _wxCollapsiblePaneIsExpanded( nativeHandle  );
  }

  void collapse( { bool collapse = true } ) {
    _wxCollapsiblePaneCollapse( nativeHandle, collapse );
  }

  void expand( ) {
    _wxCollapsiblePaneExpand( nativeHandle  );
  }

  WxWindow getPane( ) {
    final returnedNativeHandle = _wxCollapsiblePaneGetPane( nativeHandle  );
    WxEvtHandler? eh = _evtHandlerList[returnedNativeHandle];
    if (eh != null) {
      // There already is a Dart class associated with this C++ object
      return eh as WxWindow;
    }
    return wxCreateBestMatchingClassFromWxWindowHandle( returnedNativeHandle );
  }
}

// ------------------------- wxCollapsiblePaneEvent ----------------------

typedef _WxCollapsiblePaneEventConstructorNative = Pointer Function( Pointer, Int32, Bool  );
typedef _WxCollapsiblePaneEventConstructor = Pointer Function( Pointer, int, bool  );
late _WxCollapsiblePaneEventConstructor _wxCollapsiblePaneEventConstructor;

typedef _WxCollapsiblePaneEventSetCollapsedNative = Void Function( Pointer, Bool  );
typedef _WxCollapsiblePaneEventSetCollapsed = void Function( Pointer, bool  );
late _WxCollapsiblePaneEventSetCollapsed _wxCollapsiblePaneEventSetCollapsed;

typedef _WxCollapsiblePaneEventGetCollapsedNative = Bool Function( Pointer  );
typedef _WxCollapsiblePaneEventGetCollapsed = bool Function( Pointer  );
late _WxCollapsiblePaneEventGetCollapsed _wxCollapsiblePaneEventGetCollapsed;

class WxCollapsiblePaneEvent extends WxCommandEvent {
  WxCollapsiblePaneEvent._defaultConstructor() : super._defaultConstructor();
  WxCollapsiblePaneEvent( WxWindow generator, int id, bool collapse ) : super._defaultConstructor() {
    nativeHandle = _wxCollapsiblePaneEventConstructor( generator.nativeHandle, id, collapse );
    attachFinalizer();
  }
  WxCollapsiblePaneEvent.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  void setCollapsed( bool collapsed ) {
    _wxCollapsiblePaneEventSetCollapsed( nativeHandle, collapsed );
  }

  bool getCollapsed( ) {
    return _wxCollapsiblePaneEventGetCollapsed( nativeHandle  );
  }
}

typedef _WxInstallDartCollapsiblePaneEventCallbackNative = Void Function( Pointer );
typedef _WxInstallDartCollapsiblePaneEventCallback = void Function( Pointer );
late _WxInstallDartCollapsiblePaneEventCallback _wxInstallDartCollapsiblePaneEventCallback;

typedef OnCollapsiblePaneEventFunc = void Function( WxCollapsiblePaneEvent event );
class WxCollapsiblePaneEventListItems {
  WxCollapsiblePaneEventListItems( this.func, this.eventType, this.eventId );
  final OnCollapsiblePaneEventFunc func;
  final int eventType;
  final int eventId;
}
Map<Pointer, List<WxCollapsiblePaneEventListItems>> wxCollapsiblePaneEventHandlerList = {};

void wxCollapsiblePaneEventCallback( Pointer handle, Pointer eventHandle ) {
    WxCollapsiblePaneEvent event = WxCollapsiblePaneEvent.fromHandle( eventHandle );

    final List<WxCollapsiblePaneEventListItems>? list = wxCollapsiblePaneEventHandlerList[handle];
    if (list == null) {
      wxLogError('Handle does not exist in wxCollapsiblePaneEventHandlerList');
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

typedef WxCollapsiblePaneEventCallbackNative = Void Function( Pointer, Pointer );
late NativeCallable<Void Function(Pointer<NativeType>, Pointer<NativeType>)> wxCollapsiblePaneEventNativeCallable;

// ------------------------- EVT_TEXT ----------------------
///
/// [Text](/wxdart/wxGetTextEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindTextEvent( OnCommandEventFunc ) |
/// | void unbindTextEvent() |

typedef _WxGetTextEventTypeNative = Int32 Function();
typedef WxGetTextEventType = int Function();
late WxGetTextEventType wxGetTextEventType;

typedef _WxEvtHandlerBindTextEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindTextEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindTextEventCallback wxEvtHandlerBindTextEventCallback;

typedef _WxEvtHandlerUnbindTextEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindTextEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindTextEventCallback wxEvtHandlerUnbindTextEventCallback;

extension TextEventBinder on WxEvtHandler {
  void bindTextEvent( OnCommandEventFunc func, int id ) {
    List<WxCommandEventListItems>? list = wxCommandEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxCommandEventHandlerList[nativeHandle] = list;
    }
    list.add( WxCommandEventListItems( func, wxGetTextEventType(), id ) );
    wxEvtHandlerBindTextEventCallback( nativeHandle, id );
  }

  void unbindTextEvent( int id )
  {
    final list = wxCommandEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetTextEventType() ) ) );
    wxEvtHandlerUnbindTextEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_TEXT_ENTER ----------------------
///
/// [TextEnter](/wxdart/wxGetTextEnterEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindTextEnterEvent( OnCommandEventFunc ) |
/// | void unbindTextEnterEvent() |

typedef _WxGetTextEnterEventTypeNative = Int32 Function();
typedef WxGetTextEnterEventType = int Function();
late WxGetTextEnterEventType wxGetTextEnterEventType;

typedef _WxEvtHandlerBindTextEnterEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindTextEnterEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindTextEnterEventCallback wxEvtHandlerBindTextEnterEventCallback;

typedef _WxEvtHandlerUnbindTextEnterEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindTextEnterEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindTextEnterEventCallback wxEvtHandlerUnbindTextEnterEventCallback;

extension TextEnterEventBinder on WxEvtHandler {
  void bindTextEnterEvent( OnCommandEventFunc func, int id ) {
    List<WxCommandEventListItems>? list = wxCommandEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxCommandEventHandlerList[nativeHandle] = list;
    }
    list.add( WxCommandEventListItems( func, wxGetTextEnterEventType(), id ) );
    wxEvtHandlerBindTextEnterEventCallback( nativeHandle, id );
  }

  void unbindTextEnterEvent( int id )
  {
    final list = wxCommandEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetTextEnterEventType() ) ) );
    wxEvtHandlerUnbindTextEnterEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_COMBOBOX ----------------------
///
/// [Combobox](/wxdart/wxGetComboboxEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindComboboxEvent( OnCommandEventFunc ) |
/// | void unbindComboboxEvent() |

typedef _WxGetComboboxEventTypeNative = Int32 Function();
typedef WxGetComboboxEventType = int Function();
late WxGetComboboxEventType wxGetComboboxEventType;

typedef _WxEvtHandlerBindComboboxEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindComboboxEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindComboboxEventCallback wxEvtHandlerBindComboboxEventCallback;

typedef _WxEvtHandlerUnbindComboboxEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindComboboxEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindComboboxEventCallback wxEvtHandlerUnbindComboboxEventCallback;

extension ComboboxEventBinder on WxEvtHandler {
  void bindComboboxEvent( OnCommandEventFunc func, int id ) {
    List<WxCommandEventListItems>? list = wxCommandEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxCommandEventHandlerList[nativeHandle] = list;
    }
    list.add( WxCommandEventListItems( func, wxGetComboboxEventType(), id ) );
    wxEvtHandlerBindComboboxEventCallback( nativeHandle, id );
  }

  void unbindComboboxEvent( int id )
  {
    final list = wxCommandEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetComboboxEventType() ) ) );
    wxEvtHandlerUnbindComboboxEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_SEARCH ----------------------
///
/// [Search](/wxdart/wxGetSearchEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindSearchEvent( OnCommandEventFunc ) |
/// | void unbindSearchEvent() |

typedef _WxGetSearchEventTypeNative = Int32 Function();
typedef WxGetSearchEventType = int Function();
late WxGetSearchEventType wxGetSearchEventType;

typedef _WxEvtHandlerBindSearchEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindSearchEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindSearchEventCallback wxEvtHandlerBindSearchEventCallback;

typedef _WxEvtHandlerUnbindSearchEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindSearchEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindSearchEventCallback wxEvtHandlerUnbindSearchEventCallback;

extension SearchEventBinder on WxEvtHandler {
  void bindSearchEvent( OnCommandEventFunc func, int id ) {
    List<WxCommandEventListItems>? list = wxCommandEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxCommandEventHandlerList[nativeHandle] = list;
    }
    list.add( WxCommandEventListItems( func, wxGetSearchEventType(), id ) );
    wxEvtHandlerBindSearchEventCallback( nativeHandle, id );
  }

  void unbindSearchEvent( int id )
  {
    final list = wxCommandEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetSearchEventType() ) ) );
    wxEvtHandlerUnbindSearchEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_SEARCH_CANCEL ----------------------
///
/// [SearchCancel](/wxdart/wxGetSearchCancelEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindSearchCancelEvent( OnCommandEventFunc ) |
/// | void unbindSearchCancelEvent() |

typedef _WxGetSearchCancelEventTypeNative = Int32 Function();
typedef WxGetSearchCancelEventType = int Function();
late WxGetSearchCancelEventType wxGetSearchCancelEventType;

typedef _WxEvtHandlerBindSearchCancelEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindSearchCancelEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindSearchCancelEventCallback wxEvtHandlerBindSearchCancelEventCallback;

typedef _WxEvtHandlerUnbindSearchCancelEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindSearchCancelEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindSearchCancelEventCallback wxEvtHandlerUnbindSearchCancelEventCallback;

extension SearchCancelEventBinder on WxEvtHandler {
  void bindSearchCancelEvent( OnCommandEventFunc func, int id ) {
    List<WxCommandEventListItems>? list = wxCommandEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxCommandEventHandlerList[nativeHandle] = list;
    }
    list.add( WxCommandEventListItems( func, wxGetSearchCancelEventType(), id ) );
    wxEvtHandlerBindSearchCancelEventCallback( nativeHandle, id );
  }

  void unbindSearchCancelEvent( int id )
  {
    final list = wxCommandEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetSearchCancelEventType() ) ) );
    wxEvtHandlerUnbindSearchCancelEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_TREE_DELETE_ITEM ----------------------
///
/// [TreeDeleteItem](/wxdart/wxGetTreeDeleteItemEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindTreeDeleteItemEvent( OnTreeEventFunc ) |
/// | void unbindTreeDeleteItemEvent() |

typedef _WxGetTreeDeleteItemEventTypeNative = Int32 Function();
typedef WxGetTreeDeleteItemEventType = int Function();
late WxGetTreeDeleteItemEventType wxGetTreeDeleteItemEventType;

typedef _WxEvtHandlerBindTreeDeleteItemEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindTreeDeleteItemEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindTreeDeleteItemEventCallback wxEvtHandlerBindTreeDeleteItemEventCallback;

typedef _WxEvtHandlerUnbindTreeDeleteItemEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindTreeDeleteItemEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindTreeDeleteItemEventCallback wxEvtHandlerUnbindTreeDeleteItemEventCallback;

extension TreeDeleteItemEventBinder on WxEvtHandler {
  void bindTreeDeleteItemEvent( OnTreeEventFunc func, int id ) {
    List<WxTreeEventListItems>? list = wxTreeEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxTreeEventHandlerList[nativeHandle] = list;
    }
    list.add( WxTreeEventListItems( func, wxGetTreeDeleteItemEventType(), id ) );
    wxEvtHandlerBindTreeDeleteItemEventCallback( nativeHandle, id );
  }

  void unbindTreeDeleteItemEvent( int id )
  {
    final list = wxTreeEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetTreeDeleteItemEventType() ) ) );
    wxEvtHandlerUnbindTreeDeleteItemEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_TREE_ITEM_ACTIVATED ----------------------
///
/// [TreeItemActivated](/wxdart/wxGetTreeItemActivatedEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindTreeItemActivatedEvent( OnTreeEventFunc ) |
/// | void unbindTreeItemActivatedEvent() |

typedef _WxGetTreeItemActivatedEventTypeNative = Int32 Function();
typedef WxGetTreeItemActivatedEventType = int Function();
late WxGetTreeItemActivatedEventType wxGetTreeItemActivatedEventType;

typedef _WxEvtHandlerBindTreeItemActivatedEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindTreeItemActivatedEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindTreeItemActivatedEventCallback wxEvtHandlerBindTreeItemActivatedEventCallback;

typedef _WxEvtHandlerUnbindTreeItemActivatedEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindTreeItemActivatedEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindTreeItemActivatedEventCallback wxEvtHandlerUnbindTreeItemActivatedEventCallback;

extension TreeItemActivatedEventBinder on WxEvtHandler {
  void bindTreeItemActivatedEvent( OnTreeEventFunc func, int id ) {
    List<WxTreeEventListItems>? list = wxTreeEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxTreeEventHandlerList[nativeHandle] = list;
    }
    list.add( WxTreeEventListItems( func, wxGetTreeItemActivatedEventType(), id ) );
    wxEvtHandlerBindTreeItemActivatedEventCallback( nativeHandle, id );
  }

  void unbindTreeItemActivatedEvent( int id )
  {
    final list = wxTreeEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetTreeItemActivatedEventType() ) ) );
    wxEvtHandlerUnbindTreeItemActivatedEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_TREE_ITEM_EXPANDED ----------------------
///
/// [TreeItemExpanded](/wxdart/wxGetTreeItemExpandedEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindTreeItemExpandedEvent( OnTreeEventFunc ) |
/// | void unbindTreeItemExpandedEvent() |

typedef _WxGetTreeItemExpandedEventTypeNative = Int32 Function();
typedef WxGetTreeItemExpandedEventType = int Function();
late WxGetTreeItemExpandedEventType wxGetTreeItemExpandedEventType;

typedef _WxEvtHandlerBindTreeItemExpandedEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindTreeItemExpandedEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindTreeItemExpandedEventCallback wxEvtHandlerBindTreeItemExpandedEventCallback;

typedef _WxEvtHandlerUnbindTreeItemExpandedEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindTreeItemExpandedEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindTreeItemExpandedEventCallback wxEvtHandlerUnbindTreeItemExpandedEventCallback;

extension TreeItemExpandedEventBinder on WxEvtHandler {
  void bindTreeItemExpandedEvent( OnTreeEventFunc func, int id ) {
    List<WxTreeEventListItems>? list = wxTreeEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxTreeEventHandlerList[nativeHandle] = list;
    }
    list.add( WxTreeEventListItems( func, wxGetTreeItemExpandedEventType(), id ) );
    wxEvtHandlerBindTreeItemExpandedEventCallback( nativeHandle, id );
  }

  void unbindTreeItemExpandedEvent( int id )
  {
    final list = wxTreeEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetTreeItemExpandedEventType() ) ) );
    wxEvtHandlerUnbindTreeItemExpandedEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_TREE_ITEM_EXPANDING ----------------------
///
/// [TreeItemExpanding](/wxdart/wxGetTreeItemExpandingEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindTreeItemExpandingEvent( OnTreeEventFunc ) |
/// | void unbindTreeItemExpandingEvent() |

typedef _WxGetTreeItemExpandingEventTypeNative = Int32 Function();
typedef WxGetTreeItemExpandingEventType = int Function();
late WxGetTreeItemExpandingEventType wxGetTreeItemExpandingEventType;

typedef _WxEvtHandlerBindTreeItemExpandingEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindTreeItemExpandingEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindTreeItemExpandingEventCallback wxEvtHandlerBindTreeItemExpandingEventCallback;

typedef _WxEvtHandlerUnbindTreeItemExpandingEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindTreeItemExpandingEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindTreeItemExpandingEventCallback wxEvtHandlerUnbindTreeItemExpandingEventCallback;

extension TreeItemExpandingEventBinder on WxEvtHandler {
  void bindTreeItemExpandingEvent( OnTreeEventFunc func, int id ) {
    List<WxTreeEventListItems>? list = wxTreeEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxTreeEventHandlerList[nativeHandle] = list;
    }
    list.add( WxTreeEventListItems( func, wxGetTreeItemExpandingEventType(), id ) );
    wxEvtHandlerBindTreeItemExpandingEventCallback( nativeHandle, id );
  }

  void unbindTreeItemExpandingEvent( int id )
  {
    final list = wxTreeEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetTreeItemExpandingEventType() ) ) );
    wxEvtHandlerUnbindTreeItemExpandingEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_TREE_ITEM_COLLAPSED ----------------------
///
/// [TreeItemCollapsed](/wxdart/wxGetTreeItemCollapsedEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindTreeItemCollapsedEvent( OnTreeEventFunc ) |
/// | void unbindTreeItemCollapsedEvent() |

typedef _WxGetTreeItemCollapsedEventTypeNative = Int32 Function();
typedef WxGetTreeItemCollapsedEventType = int Function();
late WxGetTreeItemCollapsedEventType wxGetTreeItemCollapsedEventType;

typedef _WxEvtHandlerBindTreeItemCollapsedEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindTreeItemCollapsedEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindTreeItemCollapsedEventCallback wxEvtHandlerBindTreeItemCollapsedEventCallback;

typedef _WxEvtHandlerUnbindTreeItemCollapsedEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindTreeItemCollapsedEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindTreeItemCollapsedEventCallback wxEvtHandlerUnbindTreeItemCollapsedEventCallback;

extension TreeItemCollapsedEventBinder on WxEvtHandler {
  void bindTreeItemCollapsedEvent( OnTreeEventFunc func, int id ) {
    List<WxTreeEventListItems>? list = wxTreeEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxTreeEventHandlerList[nativeHandle] = list;
    }
    list.add( WxTreeEventListItems( func, wxGetTreeItemCollapsedEventType(), id ) );
    wxEvtHandlerBindTreeItemCollapsedEventCallback( nativeHandle, id );
  }

  void unbindTreeItemCollapsedEvent( int id )
  {
    final list = wxTreeEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetTreeItemCollapsedEventType() ) ) );
    wxEvtHandlerUnbindTreeItemCollapsedEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_TREE_ITEM_COLLAPSING ----------------------
///
/// [TreeItemCollapsing](/wxdart/wxGetTreeItemCollapsingEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindTreeItemCollapsingEvent( OnTreeEventFunc ) |
/// | void unbindTreeItemCollapsingEvent() |

typedef _WxGetTreeItemCollapsingEventTypeNative = Int32 Function();
typedef WxGetTreeItemCollapsingEventType = int Function();
late WxGetTreeItemCollapsingEventType wxGetTreeItemCollapsingEventType;

typedef _WxEvtHandlerBindTreeItemCollapsingEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindTreeItemCollapsingEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindTreeItemCollapsingEventCallback wxEvtHandlerBindTreeItemCollapsingEventCallback;

typedef _WxEvtHandlerUnbindTreeItemCollapsingEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindTreeItemCollapsingEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindTreeItemCollapsingEventCallback wxEvtHandlerUnbindTreeItemCollapsingEventCallback;

extension TreeItemCollapsingEventBinder on WxEvtHandler {
  void bindTreeItemCollapsingEvent( OnTreeEventFunc func, int id ) {
    List<WxTreeEventListItems>? list = wxTreeEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxTreeEventHandlerList[nativeHandle] = list;
    }
    list.add( WxTreeEventListItems( func, wxGetTreeItemCollapsingEventType(), id ) );
    wxEvtHandlerBindTreeItemCollapsingEventCallback( nativeHandle, id );
  }

  void unbindTreeItemCollapsingEvent( int id )
  {
    final list = wxTreeEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetTreeItemCollapsingEventType() ) ) );
    wxEvtHandlerUnbindTreeItemCollapsingEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_TREE_SEL_CHANGED ----------------------
///
/// [TreeSelChanged](/wxdart/wxGetTreeSelChangedEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindTreeSelChangedEvent( OnTreeEventFunc ) |
/// | void unbindTreeSelChangedEvent() |

typedef _WxGetTreeSelChangedEventTypeNative = Int32 Function();
typedef WxGetTreeSelChangedEventType = int Function();
late WxGetTreeSelChangedEventType wxGetTreeSelChangedEventType;

typedef _WxEvtHandlerBindTreeSelChangedEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindTreeSelChangedEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindTreeSelChangedEventCallback wxEvtHandlerBindTreeSelChangedEventCallback;

typedef _WxEvtHandlerUnbindTreeSelChangedEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindTreeSelChangedEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindTreeSelChangedEventCallback wxEvtHandlerUnbindTreeSelChangedEventCallback;

extension TreeSelChangedEventBinder on WxEvtHandler {
  void bindTreeSelChangedEvent( OnTreeEventFunc func, int id ) {
    List<WxTreeEventListItems>? list = wxTreeEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxTreeEventHandlerList[nativeHandle] = list;
    }
    list.add( WxTreeEventListItems( func, wxGetTreeSelChangedEventType(), id ) );
    wxEvtHandlerBindTreeSelChangedEventCallback( nativeHandle, id );
  }

  void unbindTreeSelChangedEvent( int id )
  {
    final list = wxTreeEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetTreeSelChangedEventType() ) ) );
    wxEvtHandlerUnbindTreeSelChangedEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_TREE_SEL_CHANGING ----------------------
///
/// [TreeSelChanging](/wxdart/wxGetTreeSelChangingEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindTreeSelChangingEvent( OnTreeEventFunc ) |
/// | void unbindTreeSelChangingEvent() |

typedef _WxGetTreeSelChangingEventTypeNative = Int32 Function();
typedef WxGetTreeSelChangingEventType = int Function();
late WxGetTreeSelChangingEventType wxGetTreeSelChangingEventType;

typedef _WxEvtHandlerBindTreeSelChangingEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindTreeSelChangingEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindTreeSelChangingEventCallback wxEvtHandlerBindTreeSelChangingEventCallback;

typedef _WxEvtHandlerUnbindTreeSelChangingEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindTreeSelChangingEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindTreeSelChangingEventCallback wxEvtHandlerUnbindTreeSelChangingEventCallback;

extension TreeSelChangingEventBinder on WxEvtHandler {
  void bindTreeSelChangingEvent( OnTreeEventFunc func, int id ) {
    List<WxTreeEventListItems>? list = wxTreeEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxTreeEventHandlerList[nativeHandle] = list;
    }
    list.add( WxTreeEventListItems( func, wxGetTreeSelChangingEventType(), id ) );
    wxEvtHandlerBindTreeSelChangingEventCallback( nativeHandle, id );
  }

  void unbindTreeSelChangingEvent( int id )
  {
    final list = wxTreeEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetTreeSelChangingEventType() ) ) );
    wxEvtHandlerUnbindTreeSelChangingEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_TREE_ITEM_MENU ----------------------
///
/// [TreeItemMenu](/wxdart/wxGetTreeItemMenuEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindTreeItemMenuEvent( OnTreeEventFunc ) |
/// | void unbindTreeItemMenuEvent() |

typedef _WxGetTreeItemMenuEventTypeNative = Int32 Function();
typedef WxGetTreeItemMenuEventType = int Function();
late WxGetTreeItemMenuEventType wxGetTreeItemMenuEventType;

typedef _WxEvtHandlerBindTreeItemMenuEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindTreeItemMenuEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindTreeItemMenuEventCallback wxEvtHandlerBindTreeItemMenuEventCallback;

typedef _WxEvtHandlerUnbindTreeItemMenuEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindTreeItemMenuEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindTreeItemMenuEventCallback wxEvtHandlerUnbindTreeItemMenuEventCallback;

extension TreeItemMenuEventBinder on WxEvtHandler {
  void bindTreeItemMenuEvent( OnTreeEventFunc func, int id ) {
    List<WxTreeEventListItems>? list = wxTreeEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxTreeEventHandlerList[nativeHandle] = list;
    }
    list.add( WxTreeEventListItems( func, wxGetTreeItemMenuEventType(), id ) );
    wxEvtHandlerBindTreeItemMenuEventCallback( nativeHandle, id );
  }

  void unbindTreeItemMenuEvent( int id )
  {
    final list = wxTreeEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetTreeItemMenuEventType() ) ) );
    wxEvtHandlerUnbindTreeItemMenuEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_TREE_ITEM_RIGHT_CLICK ----------------------
///
/// [TreeItemRightClick](/wxdart/wxGetTreeItemRightClickEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindTreeItemRightClickEvent( OnTreeEventFunc ) |
/// | void unbindTreeItemRightClickEvent() |

typedef _WxGetTreeItemRightClickEventTypeNative = Int32 Function();
typedef WxGetTreeItemRightClickEventType = int Function();
late WxGetTreeItemRightClickEventType wxGetTreeItemRightClickEventType;

typedef _WxEvtHandlerBindTreeItemRightClickEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindTreeItemRightClickEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindTreeItemRightClickEventCallback wxEvtHandlerBindTreeItemRightClickEventCallback;

typedef _WxEvtHandlerUnbindTreeItemRightClickEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindTreeItemRightClickEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindTreeItemRightClickEventCallback wxEvtHandlerUnbindTreeItemRightClickEventCallback;

extension TreeItemRightClickEventBinder on WxEvtHandler {
  void bindTreeItemRightClickEvent( OnTreeEventFunc func, int id ) {
    List<WxTreeEventListItems>? list = wxTreeEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxTreeEventHandlerList[nativeHandle] = list;
    }
    list.add( WxTreeEventListItems( func, wxGetTreeItemRightClickEventType(), id ) );
    wxEvtHandlerBindTreeItemRightClickEventCallback( nativeHandle, id );
  }

  void unbindTreeItemRightClickEvent( int id )
  {
    final list = wxTreeEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetTreeItemRightClickEventType() ) ) );
    wxEvtHandlerUnbindTreeItemRightClickEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_TREE_BEGIN_DRAG ----------------------
///
/// [TreeBeginDrag](/wxdart/wxGetTreeBeginDragEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindTreeBeginDragEvent( OnTreeEventFunc ) |
/// | void unbindTreeBeginDragEvent() |

typedef _WxGetTreeBeginDragEventTypeNative = Int32 Function();
typedef WxGetTreeBeginDragEventType = int Function();
late WxGetTreeBeginDragEventType wxGetTreeBeginDragEventType;

typedef _WxEvtHandlerBindTreeBeginDragEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindTreeBeginDragEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindTreeBeginDragEventCallback wxEvtHandlerBindTreeBeginDragEventCallback;

typedef _WxEvtHandlerUnbindTreeBeginDragEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindTreeBeginDragEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindTreeBeginDragEventCallback wxEvtHandlerUnbindTreeBeginDragEventCallback;

extension TreeBeginDragEventBinder on WxEvtHandler {
  void bindTreeBeginDragEvent( OnTreeEventFunc func, int id ) {
    List<WxTreeEventListItems>? list = wxTreeEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxTreeEventHandlerList[nativeHandle] = list;
    }
    list.add( WxTreeEventListItems( func, wxGetTreeBeginDragEventType(), id ) );
    wxEvtHandlerBindTreeBeginDragEventCallback( nativeHandle, id );
  }

  void unbindTreeBeginDragEvent( int id )
  {
    final list = wxTreeEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetTreeBeginDragEventType() ) ) );
    wxEvtHandlerUnbindTreeBeginDragEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_TREE_BEGIN_RDRAG ----------------------
///
/// [TreeBeginRDrag](/wxdart/wxGetTreeBeginRDragEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindTreeBeginRDragEvent( OnTreeEventFunc ) |
/// | void unbindTreeBeginRDragEvent() |

typedef _WxGetTreeBeginRDragEventTypeNative = Int32 Function();
typedef WxGetTreeBeginRDragEventType = int Function();
late WxGetTreeBeginRDragEventType wxGetTreeBeginRDragEventType;

typedef _WxEvtHandlerBindTreeBeginRDragEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindTreeBeginRDragEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindTreeBeginRDragEventCallback wxEvtHandlerBindTreeBeginRDragEventCallback;

typedef _WxEvtHandlerUnbindTreeBeginRDragEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindTreeBeginRDragEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindTreeBeginRDragEventCallback wxEvtHandlerUnbindTreeBeginRDragEventCallback;

extension TreeBeginRDragEventBinder on WxEvtHandler {
  void bindTreeBeginRDragEvent( OnTreeEventFunc func, int id ) {
    List<WxTreeEventListItems>? list = wxTreeEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxTreeEventHandlerList[nativeHandle] = list;
    }
    list.add( WxTreeEventListItems( func, wxGetTreeBeginRDragEventType(), id ) );
    wxEvtHandlerBindTreeBeginRDragEventCallback( nativeHandle, id );
  }

  void unbindTreeBeginRDragEvent( int id )
  {
    final list = wxTreeEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetTreeBeginRDragEventType() ) ) );
    wxEvtHandlerUnbindTreeBeginRDragEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_TREE_END_DRAG ----------------------
///
/// [TreeEndDrag](/wxdart/wxGetTreeEndDragEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindTreeEndDragEvent( OnTreeEventFunc ) |
/// | void unbindTreeEndDragEvent() |

typedef _WxGetTreeEndDragEventTypeNative = Int32 Function();
typedef WxGetTreeEndDragEventType = int Function();
late WxGetTreeEndDragEventType wxGetTreeEndDragEventType;

typedef _WxEvtHandlerBindTreeEndDragEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindTreeEndDragEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindTreeEndDragEventCallback wxEvtHandlerBindTreeEndDragEventCallback;

typedef _WxEvtHandlerUnbindTreeEndDragEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindTreeEndDragEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindTreeEndDragEventCallback wxEvtHandlerUnbindTreeEndDragEventCallback;

extension TreeEndDragEventBinder on WxEvtHandler {
  void bindTreeEndDragEvent( OnTreeEventFunc func, int id ) {
    List<WxTreeEventListItems>? list = wxTreeEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxTreeEventHandlerList[nativeHandle] = list;
    }
    list.add( WxTreeEventListItems( func, wxGetTreeEndDragEventType(), id ) );
    wxEvtHandlerBindTreeEndDragEventCallback( nativeHandle, id );
  }

  void unbindTreeEndDragEvent( int id )
  {
    final list = wxTreeEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetTreeEndDragEventType() ) ) );
    wxEvtHandlerUnbindTreeEndDragEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_TREE_BEGIN_LABEL_EDIT ----------------------
///
/// [TreeBeginLabelEdit](/wxdart/wxGetTreeBeginLabelEditEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindTreeBeginLabelEditEvent( OnTreeEventFunc ) |
/// | void unbindTreeBeginLabelEditEvent() |

typedef _WxGetTreeBeginLabelEditEventTypeNative = Int32 Function();
typedef WxGetTreeBeginLabelEditEventType = int Function();
late WxGetTreeBeginLabelEditEventType wxGetTreeBeginLabelEditEventType;

typedef _WxEvtHandlerBindTreeBeginLabelEditEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindTreeBeginLabelEditEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindTreeBeginLabelEditEventCallback wxEvtHandlerBindTreeBeginLabelEditEventCallback;

typedef _WxEvtHandlerUnbindTreeBeginLabelEditEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindTreeBeginLabelEditEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindTreeBeginLabelEditEventCallback wxEvtHandlerUnbindTreeBeginLabelEditEventCallback;

extension TreeBeginLabelEditEventBinder on WxEvtHandler {
  void bindTreeBeginLabelEditEvent( OnTreeEventFunc func, int id ) {
    List<WxTreeEventListItems>? list = wxTreeEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxTreeEventHandlerList[nativeHandle] = list;
    }
    list.add( WxTreeEventListItems( func, wxGetTreeBeginLabelEditEventType(), id ) );
    wxEvtHandlerBindTreeBeginLabelEditEventCallback( nativeHandle, id );
  }

  void unbindTreeBeginLabelEditEvent( int id )
  {
    final list = wxTreeEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetTreeBeginLabelEditEventType() ) ) );
    wxEvtHandlerUnbindTreeBeginLabelEditEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_TREE_END_LABEL_EDIT ----------------------
///
/// [TreeEndLabelEdit](/wxdart/wxGetTreeEndLabelEditEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindTreeEndLabelEditEvent( OnTreeEventFunc ) |
/// | void unbindTreeEndLabelEditEvent() |

typedef _WxGetTreeEndLabelEditEventTypeNative = Int32 Function();
typedef WxGetTreeEndLabelEditEventType = int Function();
late WxGetTreeEndLabelEditEventType wxGetTreeEndLabelEditEventType;

typedef _WxEvtHandlerBindTreeEndLabelEditEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindTreeEndLabelEditEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindTreeEndLabelEditEventCallback wxEvtHandlerBindTreeEndLabelEditEventCallback;

typedef _WxEvtHandlerUnbindTreeEndLabelEditEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindTreeEndLabelEditEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindTreeEndLabelEditEventCallback wxEvtHandlerUnbindTreeEndLabelEditEventCallback;

extension TreeEndLabelEditEventBinder on WxEvtHandler {
  void bindTreeEndLabelEditEvent( OnTreeEventFunc func, int id ) {
    List<WxTreeEventListItems>? list = wxTreeEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxTreeEventHandlerList[nativeHandle] = list;
    }
    list.add( WxTreeEventListItems( func, wxGetTreeEndLabelEditEventType(), id ) );
    wxEvtHandlerBindTreeEndLabelEditEventCallback( nativeHandle, id );
  }

  void unbindTreeEndLabelEditEvent( int id )
  {
    final list = wxTreeEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetTreeEndLabelEditEventType() ) ) );
    wxEvtHandlerUnbindTreeEndLabelEditEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_SPLITTER_SASH_POS_CHANGING ----------------------
///
/// [SplitterSashPosChanging](/wxdart/wxGetSplitterSashPosChangingEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindSplitterSashPosChangingEvent( OnSplitterEventFunc ) |
/// | void unbindSplitterSashPosChangingEvent() |

typedef _WxGetSplitterSashPosChangingEventTypeNative = Int32 Function();
typedef WxGetSplitterSashPosChangingEventType = int Function();
late WxGetSplitterSashPosChangingEventType wxGetSplitterSashPosChangingEventType;

typedef _WxEvtHandlerBindSplitterSashPosChangingEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindSplitterSashPosChangingEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindSplitterSashPosChangingEventCallback wxEvtHandlerBindSplitterSashPosChangingEventCallback;

typedef _WxEvtHandlerUnbindSplitterSashPosChangingEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindSplitterSashPosChangingEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindSplitterSashPosChangingEventCallback wxEvtHandlerUnbindSplitterSashPosChangingEventCallback;

extension SplitterSashPosChangingEventBinder on WxEvtHandler {
  void bindSplitterSashPosChangingEvent( OnSplitterEventFunc func, int id ) {
    List<WxSplitterEventListItems>? list = wxSplitterEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxSplitterEventHandlerList[nativeHandle] = list;
    }
    list.add( WxSplitterEventListItems( func, wxGetSplitterSashPosChangingEventType(), id ) );
    wxEvtHandlerBindSplitterSashPosChangingEventCallback( nativeHandle, id );
  }

  void unbindSplitterSashPosChangingEvent( int id )
  {
    final list = wxSplitterEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetSplitterSashPosChangingEventType() ) ) );
    wxEvtHandlerUnbindSplitterSashPosChangingEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_SPLITTER_SASH_POS_CHANGED ----------------------
///
/// [SplitterSashPosChanged](/wxdart/wxGetSplitterSashPosChangedEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindSplitterSashPosChangedEvent( OnSplitterEventFunc ) |
/// | void unbindSplitterSashPosChangedEvent() |

typedef _WxGetSplitterSashPosChangedEventTypeNative = Int32 Function();
typedef WxGetSplitterSashPosChangedEventType = int Function();
late WxGetSplitterSashPosChangedEventType wxGetSplitterSashPosChangedEventType;

typedef _WxEvtHandlerBindSplitterSashPosChangedEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindSplitterSashPosChangedEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindSplitterSashPosChangedEventCallback wxEvtHandlerBindSplitterSashPosChangedEventCallback;

typedef _WxEvtHandlerUnbindSplitterSashPosChangedEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindSplitterSashPosChangedEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindSplitterSashPosChangedEventCallback wxEvtHandlerUnbindSplitterSashPosChangedEventCallback;

extension SplitterSashPosChangedEventBinder on WxEvtHandler {
  void bindSplitterSashPosChangedEvent( OnSplitterEventFunc func, int id ) {
    List<WxSplitterEventListItems>? list = wxSplitterEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxSplitterEventHandlerList[nativeHandle] = list;
    }
    list.add( WxSplitterEventListItems( func, wxGetSplitterSashPosChangedEventType(), id ) );
    wxEvtHandlerBindSplitterSashPosChangedEventCallback( nativeHandle, id );
  }

  void unbindSplitterSashPosChangedEvent( int id )
  {
    final list = wxSplitterEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetSplitterSashPosChangedEventType() ) ) );
    wxEvtHandlerUnbindSplitterSashPosChangedEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_SPLITTER_UNSPLIT ----------------------
///
/// [SplitterUnsplit](/wxdart/wxGetSplitterUnsplitEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindSplitterUnsplitEvent( OnSplitterEventFunc ) |
/// | void unbindSplitterUnsplitEvent() |

typedef _WxGetSplitterUnsplitEventTypeNative = Int32 Function();
typedef WxGetSplitterUnsplitEventType = int Function();
late WxGetSplitterUnsplitEventType wxGetSplitterUnsplitEventType;

typedef _WxEvtHandlerBindSplitterUnsplitEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindSplitterUnsplitEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindSplitterUnsplitEventCallback wxEvtHandlerBindSplitterUnsplitEventCallback;

typedef _WxEvtHandlerUnbindSplitterUnsplitEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindSplitterUnsplitEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindSplitterUnsplitEventCallback wxEvtHandlerUnbindSplitterUnsplitEventCallback;

extension SplitterUnsplitEventBinder on WxEvtHandler {
  void bindSplitterUnsplitEvent( OnSplitterEventFunc func, int id ) {
    List<WxSplitterEventListItems>? list = wxSplitterEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxSplitterEventHandlerList[nativeHandle] = list;
    }
    list.add( WxSplitterEventListItems( func, wxGetSplitterUnsplitEventType(), id ) );
    wxEvtHandlerBindSplitterUnsplitEventCallback( nativeHandle, id );
  }

  void unbindSplitterUnsplitEvent( int id )
  {
    final list = wxSplitterEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetSplitterUnsplitEventType() ) ) );
    wxEvtHandlerUnbindSplitterUnsplitEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_SPLITTER_DOUBLECLICKED ----------------------
///
/// [SplitterDoubleClick](/wxdart/wxGetSplitterDoubleClickEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindSplitterDoubleClickEvent( OnSplitterEventFunc ) |
/// | void unbindSplitterDoubleClickEvent() |

typedef _WxGetSplitterDoubleClickEventTypeNative = Int32 Function();
typedef WxGetSplitterDoubleClickEventType = int Function();
late WxGetSplitterDoubleClickEventType wxGetSplitterDoubleClickEventType;

typedef _WxEvtHandlerBindSplitterDoubleClickEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindSplitterDoubleClickEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindSplitterDoubleClickEventCallback wxEvtHandlerBindSplitterDoubleClickEventCallback;

typedef _WxEvtHandlerUnbindSplitterDoubleClickEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindSplitterDoubleClickEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindSplitterDoubleClickEventCallback wxEvtHandlerUnbindSplitterDoubleClickEventCallback;

extension SplitterDoubleClickEventBinder on WxEvtHandler {
  void bindSplitterDoubleClickEvent( OnSplitterEventFunc func, int id ) {
    List<WxSplitterEventListItems>? list = wxSplitterEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxSplitterEventHandlerList[nativeHandle] = list;
    }
    list.add( WxSplitterEventListItems( func, wxGetSplitterDoubleClickEventType(), id ) );
    wxEvtHandlerBindSplitterDoubleClickEventCallback( nativeHandle, id );
  }

  void unbindSplitterDoubleClickEvent( int id )
  {
    final list = wxSplitterEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetSplitterDoubleClickEventType() ) ) );
    wxEvtHandlerUnbindSplitterDoubleClickEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_HTML_LINK_CLICKED ----------------------
///
/// [HtmlLinkClick](/wxdart/wxGetHtmlLinkClickEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindHtmlLinkClickEvent( OnHtmlLinkEventFunc ) |
/// | void unbindHtmlLinkClickEvent() |

typedef _WxGetHtmlLinkClickEventTypeNative = Int32 Function();
typedef WxGetHtmlLinkClickEventType = int Function();
late WxGetHtmlLinkClickEventType wxGetHtmlLinkClickEventType;

typedef _WxEvtHandlerBindHtmlLinkClickEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindHtmlLinkClickEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindHtmlLinkClickEventCallback wxEvtHandlerBindHtmlLinkClickEventCallback;

typedef _WxEvtHandlerUnbindHtmlLinkClickEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindHtmlLinkClickEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindHtmlLinkClickEventCallback wxEvtHandlerUnbindHtmlLinkClickEventCallback;

extension HtmlLinkClickEventBinder on WxEvtHandler {
  void bindHtmlLinkClickEvent( OnHtmlLinkEventFunc func, int id ) {
    List<WxHtmlLinkEventListItems>? list = wxHtmlLinkEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxHtmlLinkEventHandlerList[nativeHandle] = list;
    }
    list.add( WxHtmlLinkEventListItems( func, wxGetHtmlLinkClickEventType(), id ) );
    wxEvtHandlerBindHtmlLinkClickEventCallback( nativeHandle, id );
  }

  void unbindHtmlLinkClickEvent( int id )
  {
    final list = wxHtmlLinkEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetHtmlLinkClickEventType() ) ) );
    wxEvtHandlerUnbindHtmlLinkClickEventCallback( nativeHandle, id );
  }
}

// ------------------------- EVT_COLLAPSIBLEPANE_CHANGED ----------------------
///
/// [CollapsiblePaneChanged](/wxdart/wxGetCollapsiblePaneChangedEventType.html) event gets sent when XXX |
/// | ----------------- |
/// | void bindCollapsiblePaneChangedEvent( OnCollapsiblePaneEventFunc ) |
/// | void unbindCollapsiblePaneChangedEvent() |

typedef _WxGetCollapsiblePaneChangedEventTypeNative = Int32 Function();
typedef WxGetCollapsiblePaneChangedEventType = int Function();
late WxGetCollapsiblePaneChangedEventType wxGetCollapsiblePaneChangedEventType;

typedef _WxEvtHandlerBindCollapsiblePaneChangedEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerBindCollapsiblePaneChangedEventCallback = void Function( Pointer, int );
late WxEvtHandlerBindCollapsiblePaneChangedEventCallback wxEvtHandlerBindCollapsiblePaneChangedEventCallback;

typedef _WxEvtHandlerUnbindCollapsiblePaneChangedEventCallbackNative = Void Function( Pointer, Int32 );
typedef WxEvtHandlerUnbindCollapsiblePaneChangedEventCallback = void Function( Pointer, int );
late WxEvtHandlerUnbindCollapsiblePaneChangedEventCallback wxEvtHandlerUnbindCollapsiblePaneChangedEventCallback;

extension CollapsiblePaneChangedEventBinder on WxEvtHandler {
  void bindCollapsiblePaneChangedEvent( OnCollapsiblePaneEventFunc func, int id ) {
    List<WxCollapsiblePaneEventListItems>? list = wxCollapsiblePaneEventHandlerList[nativeHandle];
    if (list == null) {
        list = [];
        wxCollapsiblePaneEventHandlerList[nativeHandle] = list;
    }
    list.add( WxCollapsiblePaneEventListItems( func, wxGetCollapsiblePaneChangedEventType(), id ) );
    wxEvtHandlerBindCollapsiblePaneChangedEventCallback( nativeHandle, id );
  }

  void unbindCollapsiblePaneChangedEvent( int id )
  {
    final list = wxCollapsiblePaneEventHandlerList[nativeHandle];
    if (list == null) return;
    list.remove( list.lastWhere( (items) => (items.eventId == id) && (items.eventType == wxGetCollapsiblePaneChangedEventType() ) ) );
    wxEvtHandlerUnbindCollapsiblePaneChangedEventCallback( nativeHandle, id );
  }
}


void setupWxControls2( DynamicLibrary dylib )
{
  // ------------------------- wxGLAttributes ----------------------

  final wxGLAttributesConstructorPtr = dylib.lookup <NativeFunction<_WxGLAttributesConstructorNative>>('wxGLAttributesConstructor');
  _wxGLAttributesConstructor = wxGLAttributesConstructorPtr.asFunction<_WxGLAttributesConstructor>();

  final wxGLAttributesDestructorPtr = dylib.lookup <NativeFunction<_WxGLAttributesDestructorNative>>('wxGLAttributesDestructor');
  _wxGLAttributesDestructor = wxGLAttributesDestructorPtr.asFunction<_WxGLAttributesDestructor>();

  final wxGLAttributesFinalizerPtr = dylib.lookup <NativeFunction<_WxGLAttributesFinalizerNative>>('wxGLAttributesFinalizer');
  _wxGLAttributesNativeFinalizer = NativeFinalizer( wxGLAttributesFinalizerPtr.cast() );

  final wxGLAttributesPlatformDefaultsPtr = dylib.lookup <NativeFunction<_WxGLAttributesPlatformDefaultsNative>>('wxGLAttributesPlatformDefaults');
  _wxGLAttributesPlatformDefaults = wxGLAttributesPlatformDefaultsPtr.asFunction<_WxGLAttributesPlatformDefaults>();

  final wxGLAttributesDefaultsPtr = dylib.lookup <NativeFunction<_WxGLAttributesDefaultsNative>>('wxGLAttributesDefaults');
  _wxGLAttributesDefaults = wxGLAttributesDefaultsPtr.asFunction<_WxGLAttributesDefaults>();

  final wxGLAttributesDoubleBufferPtr = dylib.lookup <NativeFunction<_WxGLAttributesDoubleBufferNative>>('wxGLAttributesDoubleBuffer');
  _wxGLAttributesDoubleBuffer = wxGLAttributesDoubleBufferPtr.asFunction<_WxGLAttributesDoubleBuffer>();

  final wxGLAttributesRGBAPtr = dylib.lookup <NativeFunction<_WxGLAttributesRGBANative>>('wxGLAttributesRGBA');
  _wxGLAttributesRGBA = wxGLAttributesRGBAPtr.asFunction<_WxGLAttributesRGBA>();

  final wxGLAttributesLevelPtr = dylib.lookup <NativeFunction<_WxGLAttributesLevelNative>>('wxGLAttributesLevel');
  _wxGLAttributesLevel = wxGLAttributesLevelPtr.asFunction<_WxGLAttributesLevel>();

  final wxGLAttributesBufferSizePtr = dylib.lookup <NativeFunction<_WxGLAttributesBufferSizeNative>>('wxGLAttributesBufferSize');
  _wxGLAttributesBufferSize = wxGLAttributesBufferSizePtr.asFunction<_WxGLAttributesBufferSize>();

  final wxGLAttributesDepthPtr = dylib.lookup <NativeFunction<_WxGLAttributesDepthNative>>('wxGLAttributesDepth');
  _wxGLAttributesDepth = wxGLAttributesDepthPtr.asFunction<_WxGLAttributesDepth>();

  final wxGLAttributesStencilPtr = dylib.lookup <NativeFunction<_WxGLAttributesStencilNative>>('wxGLAttributesStencil');
  _wxGLAttributesStencil = wxGLAttributesStencilPtr.asFunction<_WxGLAttributesStencil>();

  final wxGLAttributesSampleBuffersPtr = dylib.lookup <NativeFunction<_WxGLAttributesSampleBuffersNative>>('wxGLAttributesSampleBuffers');
  _wxGLAttributesSampleBuffers = wxGLAttributesSampleBuffersPtr.asFunction<_WxGLAttributesSampleBuffers>();

  final wxGLAttributesSamplersPtr = dylib.lookup <NativeFunction<_WxGLAttributesSamplersNative>>('wxGLAttributesSamplers');
  _wxGLAttributesSamplers = wxGLAttributesSamplersPtr.asFunction<_WxGLAttributesSamplers>();

  final wxGLAttributesEndListPtr = dylib.lookup <NativeFunction<_WxGLAttributesEndListNative>>('wxGLAttributesEndList');
  _wxGLAttributesEndList = wxGLAttributesEndListPtr.asFunction<_WxGLAttributesEndList>();

  // ------------------------- wxGLContextAttrs ----------------------

  final wxGLContextAttrsConstructorPtr = dylib.lookup <NativeFunction<_WxGLContextAttrsConstructorNative>>('wxGLContextAttrsConstructor');
  _wxGLContextAttrsConstructor = wxGLContextAttrsConstructorPtr.asFunction<_WxGLContextAttrsConstructor>();

  final wxGLContextAttrsDestructorPtr = dylib.lookup <NativeFunction<_WxGLContextAttrsDestructorNative>>('wxGLContextAttrsDestructor');
  _wxGLContextAttrsDestructor = wxGLContextAttrsDestructorPtr.asFunction<_WxGLContextAttrsDestructor>();

  final wxGLContextAttrsFinalizerPtr = dylib.lookup <NativeFunction<_WxGLContextAttrsFinalizerNative>>('wxGLContextAttrsFinalizer');
  _wxGLContextAttrsNativeFinalizer = NativeFinalizer( wxGLContextAttrsFinalizerPtr.cast() );

  final wxGLContextAttrsOGLVersionPtr = dylib.lookup <NativeFunction<_WxGLContextAttrsOGLVersionNative>>('wxGLContextAttrsOGLVersion');
  _wxGLContextAttrsOGLVersion = wxGLContextAttrsOGLVersionPtr.asFunction<_WxGLContextAttrsOGLVersion>();

  final wxGLContextAttrsCoreProfilePtr = dylib.lookup <NativeFunction<_WxGLContextAttrsCoreProfileNative>>('wxGLContextAttrsCoreProfile');
  _wxGLContextAttrsCoreProfile = wxGLContextAttrsCoreProfilePtr.asFunction<_WxGLContextAttrsCoreProfile>();

  final wxGLContextAttrsForwardCompatiblePtr = dylib.lookup <NativeFunction<_WxGLContextAttrsForwardCompatibleNative>>('wxGLContextAttrsForwardCompatible');
  _wxGLContextAttrsForwardCompatible = wxGLContextAttrsForwardCompatiblePtr.asFunction<_WxGLContextAttrsForwardCompatible>();

  final wxGLContextAttrsES2Ptr = dylib.lookup <NativeFunction<_WxGLContextAttrsES2Native>>('wxGLContextAttrsES2');
  _wxGLContextAttrsES2 = wxGLContextAttrsES2Ptr.asFunction<_WxGLContextAttrsES2>();

  final wxGLContextAttrsRobustPtr = dylib.lookup <NativeFunction<_WxGLContextAttrsRobustNative>>('wxGLContextAttrsRobust');
  _wxGLContextAttrsRobust = wxGLContextAttrsRobustPtr.asFunction<_WxGLContextAttrsRobust>();

  final wxGLContextAttrsLoseOnResetPtr = dylib.lookup <NativeFunction<_WxGLContextAttrsLoseOnResetNative>>('wxGLContextAttrsLoseOnReset');
  _wxGLContextAttrsLoseOnReset = wxGLContextAttrsLoseOnResetPtr.asFunction<_WxGLContextAttrsLoseOnReset>();

  final wxGLContextAttrsResetIsolationPtr = dylib.lookup <NativeFunction<_WxGLContextAttrsResetIsolationNative>>('wxGLContextAttrsResetIsolation');
  _wxGLContextAttrsResetIsolation = wxGLContextAttrsResetIsolationPtr.asFunction<_WxGLContextAttrsResetIsolation>();

  final wxGLContextAttrsEndListPtr = dylib.lookup <NativeFunction<_WxGLContextAttrsEndListNative>>('wxGLContextAttrsEndList');
  _wxGLContextAttrsEndList = wxGLContextAttrsEndListPtr.asFunction<_WxGLContextAttrsEndList>();

  // ------------------------- wxGLCanvas ----------------------

  final wxGLCanvasConstructorPtr = dylib.lookup <NativeFunction<_WxGLCanvasConstructorNative>>('wxGLCanvasConstructor');
  _wxGLCanvasConstructor = wxGLCanvasConstructorPtr.asFunction<_WxGLCanvasConstructor>();

  final wxGLCanvasSwapBuffersPtr = dylib.lookup <NativeFunction<_WxGLCanvasSwapBuffersNative>>('wxGLCanvasSwapBuffers');
  _wxGLCanvasSwapBuffers = wxGLCanvasSwapBuffersPtr.asFunction<_WxGLCanvasSwapBuffers>();

  final wxGLCanvasSetCurrentPtr = dylib.lookup <NativeFunction<_WxGLCanvasSetCurrentNative>>('wxGLCanvasSetCurrent');
  _wxGLCanvasSetCurrent = wxGLCanvasSetCurrentPtr.asFunction<_WxGLCanvasSetCurrent>();

  // ------------------------- wxTextEntry ----------------------

  // ------------------------- wxTextCtrl ----------------------

  final wxTextCtrlConstructorPtr = dylib.lookup <NativeFunction<_WxTextCtrlConstructorNative>>('wxTextCtrlConstructor');
  _wxTextCtrlConstructor = wxTextCtrlConstructorPtr.asFunction<_WxTextCtrlConstructor>();

  final wxTextCtrlIsModifiedPtr = dylib.lookup <NativeFunction<_WxTextCtrlIsModifiedNative>>('wxTextCtrlIsModified');
  _wxTextCtrlIsModified = wxTextCtrlIsModifiedPtr.asFunction<_WxTextCtrlIsModified>();

  final wxTextCtrlMarkDirtyPtr = dylib.lookup <NativeFunction<_WxTextCtrlMarkDirtyNative>>('wxTextCtrlMarkDirty');
  _wxTextCtrlMarkDirty = wxTextCtrlMarkDirtyPtr.asFunction<_WxTextCtrlMarkDirty>();

  final wxTextCtrlIsSingleLinePtr = dylib.lookup <NativeFunction<_WxTextCtrlIsSingleLineNative>>('wxTextCtrlIsSingleLine');
  _wxTextCtrlIsSingleLine = wxTextCtrlIsSingleLinePtr.asFunction<_WxTextCtrlIsSingleLine>();

  final wxTextCtrlIsMultiLinePtr = dylib.lookup <NativeFunction<_WxTextCtrlIsMultiLineNative>>('wxTextCtrlIsMultiLine');
  _wxTextCtrlIsMultiLine = wxTextCtrlIsMultiLinePtr.asFunction<_WxTextCtrlIsMultiLine>();

  final wxTextCtrlGetNumberOfLinesPtr = dylib.lookup <NativeFunction<_WxTextCtrlGetNumberOfLinesNative>>('wxTextCtrlGetNumberOfLines');
  _wxTextCtrlGetNumberOfLines = wxTextCtrlGetNumberOfLinesPtr.asFunction<_WxTextCtrlGetNumberOfLines>();

  final wxTextCtrlGetLineTextPtr = dylib.lookup <NativeFunction<_WxTextCtrlGetLineTextNative>>('wxTextCtrlGetLineText');
  _wxTextCtrlGetLineText = wxTextCtrlGetLineTextPtr.asFunction<_WxTextCtrlGetLineText>();

  final wxTextCtrlGetLineLengthPtr = dylib.lookup <NativeFunction<_WxTextCtrlGetLineLengthNative>>('wxTextCtrlGetLineLength');
  _wxTextCtrlGetLineLength = wxTextCtrlGetLineLengthPtr.asFunction<_WxTextCtrlGetLineLength>();

  final wxTextCtrlAppendTextPtr = dylib.lookup <NativeFunction<_WxTextCtrlAppendTextNative>>('wxTextCtrlAppendText');
  _wxTextCtrlAppendText = wxTextCtrlAppendTextPtr.asFunction<_WxTextCtrlAppendText>();

  final wxTextCtrlWriteTextPtr = dylib.lookup <NativeFunction<_WxTextCtrlWriteTextNative>>('wxTextCtrlWriteText');
  _wxTextCtrlWriteText = wxTextCtrlWriteTextPtr.asFunction<_WxTextCtrlWriteText>();

  final wxTextCtrlChangeValuePtr = dylib.lookup <NativeFunction<_WxTextCtrlChangeValueNative>>('wxTextCtrlChangeValue');
  _wxTextCtrlChangeValue = wxTextCtrlChangeValuePtr.asFunction<_WxTextCtrlChangeValue>();

  final wxTextCtrlSelectAllPtr = dylib.lookup <NativeFunction<_WxTextCtrlSelectAllNative>>('wxTextCtrlSelectAll');
  _wxTextCtrlSelectAll = wxTextCtrlSelectAllPtr.asFunction<_WxTextCtrlSelectAll>();

  final wxTextCtrlSelectNonePtr = dylib.lookup <NativeFunction<_WxTextCtrlSelectNoneNative>>('wxTextCtrlSelectNone');
  _wxTextCtrlSelectNone = wxTextCtrlSelectNonePtr.asFunction<_WxTextCtrlSelectNone>();

  final wxTextCtrlSetSelectionPtr = dylib.lookup <NativeFunction<_WxTextCtrlSetSelectionNative>>('wxTextCtrlSetSelection');
  _wxTextCtrlSetSelection = wxTextCtrlSetSelectionPtr.asFunction<_WxTextCtrlSetSelection>();

  final wxTextCtrlGetStringSelectionPtr = dylib.lookup <NativeFunction<_WxTextCtrlGetStringSelectionNative>>('wxTextCtrlGetStringSelection');
  _wxTextCtrlGetStringSelection = wxTextCtrlGetStringSelectionPtr.asFunction<_WxTextCtrlGetStringSelection>();

  final wxTextCtrlRemovePtr = dylib.lookup <NativeFunction<_WxTextCtrlRemoveNative>>('wxTextCtrlRemove');
  _wxTextCtrlRemove = wxTextCtrlRemovePtr.asFunction<_WxTextCtrlRemove>();

  final wxTextCtrlReplacePtr = dylib.lookup <NativeFunction<_WxTextCtrlReplaceNative>>('wxTextCtrlReplace');
  _wxTextCtrlReplace = wxTextCtrlReplacePtr.asFunction<_WxTextCtrlReplace>();

  final wxTextCtrlSetEditablePtr = dylib.lookup <NativeFunction<_WxTextCtrlSetEditableNative>>('wxTextCtrlSetEditable');
  _wxTextCtrlSetEditable = wxTextCtrlSetEditablePtr.asFunction<_WxTextCtrlSetEditable>();

  final wxTextCtrlSetInsertionPointPtr = dylib.lookup <NativeFunction<_WxTextCtrlSetInsertionPointNative>>('wxTextCtrlSetInsertionPoint');
  _wxTextCtrlSetInsertionPoint = wxTextCtrlSetInsertionPointPtr.asFunction<_WxTextCtrlSetInsertionPoint>();

  final wxTextCtrlSetInsertionPointEndPtr = dylib.lookup <NativeFunction<_WxTextCtrlSetInsertionPointEndNative>>('wxTextCtrlSetInsertionPointEnd');
  _wxTextCtrlSetInsertionPointEnd = wxTextCtrlSetInsertionPointEndPtr.asFunction<_WxTextCtrlSetInsertionPointEnd>();

  final wxTextCtrlGetInsertionPointPtr = dylib.lookup <NativeFunction<_WxTextCtrlGetInsertionPointNative>>('wxTextCtrlGetInsertionPoint');
  _wxTextCtrlGetInsertionPoint = wxTextCtrlGetInsertionPointPtr.asFunction<_WxTextCtrlGetInsertionPoint>();

  final wxTextCtrlSetMaxLengthPtr = dylib.lookup <NativeFunction<_WxTextCtrlSetMaxLengthNative>>('wxTextCtrlSetMaxLength');
  _wxTextCtrlSetMaxLength = wxTextCtrlSetMaxLengthPtr.asFunction<_WxTextCtrlSetMaxLength>();

  final wxTextCtrlClearPtr = dylib.lookup <NativeFunction<_WxTextCtrlClearNative>>('wxTextCtrlClear');
  _wxTextCtrlClear = wxTextCtrlClearPtr.asFunction<_WxTextCtrlClear>();

  final wxTextCtrlCopyPtr = dylib.lookup <NativeFunction<_WxTextCtrlCopyNative>>('wxTextCtrlCopy');
  _wxTextCtrlCopy = wxTextCtrlCopyPtr.asFunction<_WxTextCtrlCopy>();

  final wxTextCtrlCutPtr = dylib.lookup <NativeFunction<_WxTextCtrlCutNative>>('wxTextCtrlCut');
  _wxTextCtrlCut = wxTextCtrlCutPtr.asFunction<_WxTextCtrlCut>();

  final wxTextCtrlPastePtr = dylib.lookup <NativeFunction<_WxTextCtrlPasteNative>>('wxTextCtrlPaste');
  _wxTextCtrlPaste = wxTextCtrlPastePtr.asFunction<_WxTextCtrlPaste>();

  final wxTextCtrlRedoPtr = dylib.lookup <NativeFunction<_WxTextCtrlRedoNative>>('wxTextCtrlRedo');
  _wxTextCtrlRedo = wxTextCtrlRedoPtr.asFunction<_WxTextCtrlRedo>();

  final wxTextCtrlUndoPtr = dylib.lookup <NativeFunction<_WxTextCtrlUndoNative>>('wxTextCtrlUndo');
  _wxTextCtrlUndo = wxTextCtrlUndoPtr.asFunction<_WxTextCtrlUndo>();

  final wxTextCtrlCanCopyPtr = dylib.lookup <NativeFunction<_WxTextCtrlCanCopyNative>>('wxTextCtrlCanCopy');
  _wxTextCtrlCanCopy = wxTextCtrlCanCopyPtr.asFunction<_WxTextCtrlCanCopy>();

  final wxTextCtrlCanCutPtr = dylib.lookup <NativeFunction<_WxTextCtrlCanCutNative>>('wxTextCtrlCanCut');
  _wxTextCtrlCanCut = wxTextCtrlCanCutPtr.asFunction<_WxTextCtrlCanCut>();

  final wxTextCtrlCanPastePtr = dylib.lookup <NativeFunction<_WxTextCtrlCanPasteNative>>('wxTextCtrlCanPaste');
  _wxTextCtrlCanPaste = wxTextCtrlCanPastePtr.asFunction<_WxTextCtrlCanPaste>();

  final wxTextCtrlCanRedoPtr = dylib.lookup <NativeFunction<_WxTextCtrlCanRedoNative>>('wxTextCtrlCanRedo');
  _wxTextCtrlCanRedo = wxTextCtrlCanRedoPtr.asFunction<_WxTextCtrlCanRedo>();

  final wxTextCtrlCanUndoPtr = dylib.lookup <NativeFunction<_WxTextCtrlCanUndoNative>>('wxTextCtrlCanUndo');
  _wxTextCtrlCanUndo = wxTextCtrlCanUndoPtr.asFunction<_WxTextCtrlCanUndo>();

  final wxTextCtrlSetValuePtr = dylib.lookup <NativeFunction<_WxTextCtrlSetValueNative>>('wxTextCtrlSetValue');
  _wxTextCtrlSetValue = wxTextCtrlSetValuePtr.asFunction<_WxTextCtrlSetValue>();

  final wxTextCtrlGetValuePtr = dylib.lookup <NativeFunction<_WxTextCtrlGetValueNative>>('wxTextCtrlGetValue');
  _wxTextCtrlGetValue = wxTextCtrlGetValuePtr.asFunction<_WxTextCtrlGetValue>();

  final wxTextCtrlSetHintPtr = dylib.lookup <NativeFunction<_WxTextCtrlSetHintNative>>('wxTextCtrlSetHint');
  _wxTextCtrlSetHint = wxTextCtrlSetHintPtr.asFunction<_WxTextCtrlSetHint>();

  final wxTextCtrlGetHintPtr = dylib.lookup <NativeFunction<_WxTextCtrlGetHintNative>>('wxTextCtrlGetHint');
  _wxTextCtrlGetHint = wxTextCtrlGetHintPtr.asFunction<_WxTextCtrlGetHint>();

  final wxTextCtrlIsEditablePtr = dylib.lookup <NativeFunction<_WxTextCtrlIsEditableNative>>('wxTextCtrlIsEditable');
  _wxTextCtrlIsEditable = wxTextCtrlIsEditablePtr.asFunction<_WxTextCtrlIsEditable>();

  final wxTextCtrlIsEmptyPtr = dylib.lookup <NativeFunction<_WxTextCtrlIsEmptyNative>>('wxTextCtrlIsEmpty');
  _wxTextCtrlIsEmpty = wxTextCtrlIsEmptyPtr.asFunction<_WxTextCtrlIsEmpty>();

  // ------------------------- wxSearchCtrl ----------------------

  final wxSearchCtrlConstructorPtr = dylib.lookup <NativeFunction<_WxSearchCtrlConstructorNative>>('wxSearchCtrlConstructor');
  _wxSearchCtrlConstructor = wxSearchCtrlConstructorPtr.asFunction<_WxSearchCtrlConstructor>();

  final wxSearchCtrlIsSearchButtonVisiblePtr = dylib.lookup <NativeFunction<_WxSearchCtrlIsSearchButtonVisibleNative>>('wxSearchCtrlIsSearchButtonVisible');
  _wxSearchCtrlIsSearchButtonVisible = wxSearchCtrlIsSearchButtonVisiblePtr.asFunction<_WxSearchCtrlIsSearchButtonVisible>();

  final wxSearchCtrlIsCancelButtonVisiblePtr = dylib.lookup <NativeFunction<_WxSearchCtrlIsCancelButtonVisibleNative>>('wxSearchCtrlIsCancelButtonVisible');
  _wxSearchCtrlIsCancelButtonVisible = wxSearchCtrlIsCancelButtonVisiblePtr.asFunction<_WxSearchCtrlIsCancelButtonVisible>();

  final wxSearchCtrlShowSearchButtonPtr = dylib.lookup <NativeFunction<_WxSearchCtrlShowSearchButtonNative>>('wxSearchCtrlShowSearchButton');
  _wxSearchCtrlShowSearchButton = wxSearchCtrlShowSearchButtonPtr.asFunction<_WxSearchCtrlShowSearchButton>();

  final wxSearchCtrlShowCancelButtonPtr = dylib.lookup <NativeFunction<_WxSearchCtrlShowCancelButtonNative>>('wxSearchCtrlShowCancelButton');
  _wxSearchCtrlShowCancelButton = wxSearchCtrlShowCancelButtonPtr.asFunction<_WxSearchCtrlShowCancelButton>();

  final wxSearchCtrlSetDescriptiveTextPtr = dylib.lookup <NativeFunction<_WxSearchCtrlSetDescriptiveTextNative>>('wxSearchCtrlSetDescriptiveText');
  _wxSearchCtrlSetDescriptiveText = wxSearchCtrlSetDescriptiveTextPtr.asFunction<_WxSearchCtrlSetDescriptiveText>();

  final wxSearchCtrlSetMenuPtr = dylib.lookup <NativeFunction<_WxSearchCtrlSetMenuNative>>('wxSearchCtrlSetMenu');
  _wxSearchCtrlSetMenu = wxSearchCtrlSetMenuPtr.asFunction<_WxSearchCtrlSetMenu>();

  final wxSearchCtrlAppendTextPtr = dylib.lookup <NativeFunction<_WxSearchCtrlAppendTextNative>>('wxSearchCtrlAppendText');
  _wxSearchCtrlAppendText = wxSearchCtrlAppendTextPtr.asFunction<_WxSearchCtrlAppendText>();

  final wxSearchCtrlWriteTextPtr = dylib.lookup <NativeFunction<_WxSearchCtrlWriteTextNative>>('wxSearchCtrlWriteText');
  _wxSearchCtrlWriteText = wxSearchCtrlWriteTextPtr.asFunction<_WxSearchCtrlWriteText>();

  final wxSearchCtrlChangeValuePtr = dylib.lookup <NativeFunction<_WxSearchCtrlChangeValueNative>>('wxSearchCtrlChangeValue');
  _wxSearchCtrlChangeValue = wxSearchCtrlChangeValuePtr.asFunction<_WxSearchCtrlChangeValue>();

  final wxSearchCtrlSelectAllPtr = dylib.lookup <NativeFunction<_WxSearchCtrlSelectAllNative>>('wxSearchCtrlSelectAll');
  _wxSearchCtrlSelectAll = wxSearchCtrlSelectAllPtr.asFunction<_WxSearchCtrlSelectAll>();

  final wxSearchCtrlSelectNonePtr = dylib.lookup <NativeFunction<_WxSearchCtrlSelectNoneNative>>('wxSearchCtrlSelectNone');
  _wxSearchCtrlSelectNone = wxSearchCtrlSelectNonePtr.asFunction<_WxSearchCtrlSelectNone>();

  final wxSearchCtrlSetSelectionPtr = dylib.lookup <NativeFunction<_WxSearchCtrlSetSelectionNative>>('wxSearchCtrlSetSelection');
  _wxSearchCtrlSetSelection = wxSearchCtrlSetSelectionPtr.asFunction<_WxSearchCtrlSetSelection>();

  final wxSearchCtrlGetStringSelectionPtr = dylib.lookup <NativeFunction<_WxSearchCtrlGetStringSelectionNative>>('wxSearchCtrlGetStringSelection');
  _wxSearchCtrlGetStringSelection = wxSearchCtrlGetStringSelectionPtr.asFunction<_WxSearchCtrlGetStringSelection>();

  final wxSearchCtrlRemovePtr = dylib.lookup <NativeFunction<_WxSearchCtrlRemoveNative>>('wxSearchCtrlRemove');
  _wxSearchCtrlRemove = wxSearchCtrlRemovePtr.asFunction<_WxSearchCtrlRemove>();

  final wxSearchCtrlReplacePtr = dylib.lookup <NativeFunction<_WxSearchCtrlReplaceNative>>('wxSearchCtrlReplace');
  _wxSearchCtrlReplace = wxSearchCtrlReplacePtr.asFunction<_WxSearchCtrlReplace>();

  final wxSearchCtrlSetEditablePtr = dylib.lookup <NativeFunction<_WxSearchCtrlSetEditableNative>>('wxSearchCtrlSetEditable');
  _wxSearchCtrlSetEditable = wxSearchCtrlSetEditablePtr.asFunction<_WxSearchCtrlSetEditable>();

  final wxSearchCtrlSetInsertionPointPtr = dylib.lookup <NativeFunction<_WxSearchCtrlSetInsertionPointNative>>('wxSearchCtrlSetInsertionPoint');
  _wxSearchCtrlSetInsertionPoint = wxSearchCtrlSetInsertionPointPtr.asFunction<_WxSearchCtrlSetInsertionPoint>();

  final wxSearchCtrlSetInsertionPointEndPtr = dylib.lookup <NativeFunction<_WxSearchCtrlSetInsertionPointEndNative>>('wxSearchCtrlSetInsertionPointEnd');
  _wxSearchCtrlSetInsertionPointEnd = wxSearchCtrlSetInsertionPointEndPtr.asFunction<_WxSearchCtrlSetInsertionPointEnd>();

  final wxSearchCtrlGetInsertionPointPtr = dylib.lookup <NativeFunction<_WxSearchCtrlGetInsertionPointNative>>('wxSearchCtrlGetInsertionPoint');
  _wxSearchCtrlGetInsertionPoint = wxSearchCtrlGetInsertionPointPtr.asFunction<_WxSearchCtrlGetInsertionPoint>();

  final wxSearchCtrlSetMaxLengthPtr = dylib.lookup <NativeFunction<_WxSearchCtrlSetMaxLengthNative>>('wxSearchCtrlSetMaxLength');
  _wxSearchCtrlSetMaxLength = wxSearchCtrlSetMaxLengthPtr.asFunction<_WxSearchCtrlSetMaxLength>();

  final wxSearchCtrlClearPtr = dylib.lookup <NativeFunction<_WxSearchCtrlClearNative>>('wxSearchCtrlClear');
  _wxSearchCtrlClear = wxSearchCtrlClearPtr.asFunction<_WxSearchCtrlClear>();

  final wxSearchCtrlCopyPtr = dylib.lookup <NativeFunction<_WxSearchCtrlCopyNative>>('wxSearchCtrlCopy');
  _wxSearchCtrlCopy = wxSearchCtrlCopyPtr.asFunction<_WxSearchCtrlCopy>();

  final wxSearchCtrlCutPtr = dylib.lookup <NativeFunction<_WxSearchCtrlCutNative>>('wxSearchCtrlCut');
  _wxSearchCtrlCut = wxSearchCtrlCutPtr.asFunction<_WxSearchCtrlCut>();

  final wxSearchCtrlPastePtr = dylib.lookup <NativeFunction<_WxSearchCtrlPasteNative>>('wxSearchCtrlPaste');
  _wxSearchCtrlPaste = wxSearchCtrlPastePtr.asFunction<_WxSearchCtrlPaste>();

  final wxSearchCtrlRedoPtr = dylib.lookup <NativeFunction<_WxSearchCtrlRedoNative>>('wxSearchCtrlRedo');
  _wxSearchCtrlRedo = wxSearchCtrlRedoPtr.asFunction<_WxSearchCtrlRedo>();

  final wxSearchCtrlUndoPtr = dylib.lookup <NativeFunction<_WxSearchCtrlUndoNative>>('wxSearchCtrlUndo');
  _wxSearchCtrlUndo = wxSearchCtrlUndoPtr.asFunction<_WxSearchCtrlUndo>();

  final wxSearchCtrlCanCopyPtr = dylib.lookup <NativeFunction<_WxSearchCtrlCanCopyNative>>('wxSearchCtrlCanCopy');
  _wxSearchCtrlCanCopy = wxSearchCtrlCanCopyPtr.asFunction<_WxSearchCtrlCanCopy>();

  final wxSearchCtrlCanCutPtr = dylib.lookup <NativeFunction<_WxSearchCtrlCanCutNative>>('wxSearchCtrlCanCut');
  _wxSearchCtrlCanCut = wxSearchCtrlCanCutPtr.asFunction<_WxSearchCtrlCanCut>();

  final wxSearchCtrlCanPastePtr = dylib.lookup <NativeFunction<_WxSearchCtrlCanPasteNative>>('wxSearchCtrlCanPaste');
  _wxSearchCtrlCanPaste = wxSearchCtrlCanPastePtr.asFunction<_WxSearchCtrlCanPaste>();

  final wxSearchCtrlCanRedoPtr = dylib.lookup <NativeFunction<_WxSearchCtrlCanRedoNative>>('wxSearchCtrlCanRedo');
  _wxSearchCtrlCanRedo = wxSearchCtrlCanRedoPtr.asFunction<_WxSearchCtrlCanRedo>();

  final wxSearchCtrlCanUndoPtr = dylib.lookup <NativeFunction<_WxSearchCtrlCanUndoNative>>('wxSearchCtrlCanUndo');
  _wxSearchCtrlCanUndo = wxSearchCtrlCanUndoPtr.asFunction<_WxSearchCtrlCanUndo>();

  final wxSearchCtrlSetValuePtr = dylib.lookup <NativeFunction<_WxSearchCtrlSetValueNative>>('wxSearchCtrlSetValue');
  _wxSearchCtrlSetValue = wxSearchCtrlSetValuePtr.asFunction<_WxSearchCtrlSetValue>();

  final wxSearchCtrlGetValuePtr = dylib.lookup <NativeFunction<_WxSearchCtrlGetValueNative>>('wxSearchCtrlGetValue');
  _wxSearchCtrlGetValue = wxSearchCtrlGetValuePtr.asFunction<_WxSearchCtrlGetValue>();

  final wxSearchCtrlSetHintPtr = dylib.lookup <NativeFunction<_WxSearchCtrlSetHintNative>>('wxSearchCtrlSetHint');
  _wxSearchCtrlSetHint = wxSearchCtrlSetHintPtr.asFunction<_WxSearchCtrlSetHint>();

  final wxSearchCtrlGetHintPtr = dylib.lookup <NativeFunction<_WxSearchCtrlGetHintNative>>('wxSearchCtrlGetHint');
  _wxSearchCtrlGetHint = wxSearchCtrlGetHintPtr.asFunction<_WxSearchCtrlGetHint>();

  final wxSearchCtrlIsEditablePtr = dylib.lookup <NativeFunction<_WxSearchCtrlIsEditableNative>>('wxSearchCtrlIsEditable');
  _wxSearchCtrlIsEditable = wxSearchCtrlIsEditablePtr.asFunction<_WxSearchCtrlIsEditable>();

  final wxSearchCtrlIsEmptyPtr = dylib.lookup <NativeFunction<_WxSearchCtrlIsEmptyNative>>('wxSearchCtrlIsEmpty');
  _wxSearchCtrlIsEmpty = wxSearchCtrlIsEmptyPtr.asFunction<_WxSearchCtrlIsEmpty>();

  // ------------------------- wxComboBox ----------------------

  final wxComboBoxConstructorPtr = dylib.lookup <NativeFunction<_WxComboBoxConstructorNative>>('wxComboBoxConstructor');
  _wxComboBoxConstructor = wxComboBoxConstructorPtr.asFunction<_WxComboBoxConstructor>();

  final wxComboBoxPopupPtr = dylib.lookup <NativeFunction<_WxComboBoxPopupNative>>('wxComboBoxPopup');
  _wxComboBoxPopup = wxComboBoxPopupPtr.asFunction<_WxComboBoxPopup>();

  final wxComboBoxDismissPtr = dylib.lookup <NativeFunction<_WxComboBoxDismissNative>>('wxComboBoxDismiss');
  _wxComboBoxDismiss = wxComboBoxDismissPtr.asFunction<_WxComboBoxDismiss>();

  final wxComboBoxIsListEmptyPtr = dylib.lookup <NativeFunction<_WxComboBoxIsListEmptyNative>>('wxComboBoxIsListEmpty');
  _wxComboBoxIsListEmpty = wxComboBoxIsListEmptyPtr.asFunction<_WxComboBoxIsListEmpty>();

  final wxComboBoxIsTextEmptyPtr = dylib.lookup <NativeFunction<_WxComboBoxIsTextEmptyNative>>('wxComboBoxIsTextEmpty');
  _wxComboBoxIsTextEmpty = wxComboBoxIsTextEmptyPtr.asFunction<_WxComboBoxIsTextEmpty>();

  final wxComboBoxSetSelectionPtr = dylib.lookup <NativeFunction<_WxComboBoxSetSelectionNative>>('wxComboBoxSetSelection');
  _wxComboBoxSetSelection = wxComboBoxSetSelectionPtr.asFunction<_WxComboBoxSetSelection>();

  final wxComboBoxSetTextSelectionPtr = dylib.lookup <NativeFunction<_WxComboBoxSetTextSelectionNative>>('wxComboBoxSetTextSelection');
  _wxComboBoxSetTextSelection = wxComboBoxSetTextSelectionPtr.asFunction<_WxComboBoxSetTextSelection>();

  final wxComboBoxClearPtr = dylib.lookup <NativeFunction<_WxComboBoxClearNative>>('wxComboBoxClear');
  _wxComboBoxClear = wxComboBoxClearPtr.asFunction<_WxComboBoxClear>();

  final wxComboBoxSetValuePtr = dylib.lookup <NativeFunction<_WxComboBoxSetValueNative>>('wxComboBoxSetValue');
  _wxComboBoxSetValue = wxComboBoxSetValuePtr.asFunction<_WxComboBoxSetValue>();

  final wxComboBoxGetValuePtr = dylib.lookup <NativeFunction<_WxComboBoxGetValueNative>>('wxComboBoxGetValue');
  _wxComboBoxGetValue = wxComboBoxGetValuePtr.asFunction<_WxComboBoxGetValue>();

  final wxComboBoxChangeValuePtr = dylib.lookup <NativeFunction<_WxComboBoxChangeValueNative>>('wxComboBoxChangeValue');
  _wxComboBoxChangeValue = wxComboBoxChangeValuePtr.asFunction<_WxComboBoxChangeValue>();

  final wxComboBoxAppendTextPtr = dylib.lookup <NativeFunction<_WxComboBoxAppendTextNative>>('wxComboBoxAppendText');
  _wxComboBoxAppendText = wxComboBoxAppendTextPtr.asFunction<_WxComboBoxAppendText>();

  final wxComboBoxWriteTextPtr = dylib.lookup <NativeFunction<_WxComboBoxWriteTextNative>>('wxComboBoxWriteText');
  _wxComboBoxWriteText = wxComboBoxWriteTextPtr.asFunction<_WxComboBoxWriteText>();

  final wxComboBoxSelectAllPtr = dylib.lookup <NativeFunction<_WxComboBoxSelectAllNative>>('wxComboBoxSelectAll');
  _wxComboBoxSelectAll = wxComboBoxSelectAllPtr.asFunction<_WxComboBoxSelectAll>();

  final wxComboBoxSelectNonePtr = dylib.lookup <NativeFunction<_WxComboBoxSelectNoneNative>>('wxComboBoxSelectNone');
  _wxComboBoxSelectNone = wxComboBoxSelectNonePtr.asFunction<_WxComboBoxSelectNone>();

  final wxComboBoxRemovePtr = dylib.lookup <NativeFunction<_WxComboBoxRemoveNative>>('wxComboBoxRemove');
  _wxComboBoxRemove = wxComboBoxRemovePtr.asFunction<_WxComboBoxRemove>();

  final wxComboBoxReplacePtr = dylib.lookup <NativeFunction<_WxComboBoxReplaceNative>>('wxComboBoxReplace');
  _wxComboBoxReplace = wxComboBoxReplacePtr.asFunction<_WxComboBoxReplace>();

  final wxComboBoxSetEditablePtr = dylib.lookup <NativeFunction<_WxComboBoxSetEditableNative>>('wxComboBoxSetEditable');
  _wxComboBoxSetEditable = wxComboBoxSetEditablePtr.asFunction<_WxComboBoxSetEditable>();

  final wxComboBoxSetInsertionPointPtr = dylib.lookup <NativeFunction<_WxComboBoxSetInsertionPointNative>>('wxComboBoxSetInsertionPoint');
  _wxComboBoxSetInsertionPoint = wxComboBoxSetInsertionPointPtr.asFunction<_WxComboBoxSetInsertionPoint>();

  final wxComboBoxSetInsertionPointEndPtr = dylib.lookup <NativeFunction<_WxComboBoxSetInsertionPointEndNative>>('wxComboBoxSetInsertionPointEnd');
  _wxComboBoxSetInsertionPointEnd = wxComboBoxSetInsertionPointEndPtr.asFunction<_WxComboBoxSetInsertionPointEnd>();

  final wxComboBoxGetInsertionPointPtr = dylib.lookup <NativeFunction<_WxComboBoxGetInsertionPointNative>>('wxComboBoxGetInsertionPoint');
  _wxComboBoxGetInsertionPoint = wxComboBoxGetInsertionPointPtr.asFunction<_WxComboBoxGetInsertionPoint>();

  final wxComboBoxSetMaxLengthPtr = dylib.lookup <NativeFunction<_WxComboBoxSetMaxLengthNative>>('wxComboBoxSetMaxLength');
  _wxComboBoxSetMaxLength = wxComboBoxSetMaxLengthPtr.asFunction<_WxComboBoxSetMaxLength>();

  final wxComboBoxCopyPtr = dylib.lookup <NativeFunction<_WxComboBoxCopyNative>>('wxComboBoxCopy');
  _wxComboBoxCopy = wxComboBoxCopyPtr.asFunction<_WxComboBoxCopy>();

  final wxComboBoxCutPtr = dylib.lookup <NativeFunction<_WxComboBoxCutNative>>('wxComboBoxCut');
  _wxComboBoxCut = wxComboBoxCutPtr.asFunction<_WxComboBoxCut>();

  final wxComboBoxPastePtr = dylib.lookup <NativeFunction<_WxComboBoxPasteNative>>('wxComboBoxPaste');
  _wxComboBoxPaste = wxComboBoxPastePtr.asFunction<_WxComboBoxPaste>();

  final wxComboBoxRedoPtr = dylib.lookup <NativeFunction<_WxComboBoxRedoNative>>('wxComboBoxRedo');
  _wxComboBoxRedo = wxComboBoxRedoPtr.asFunction<_WxComboBoxRedo>();

  final wxComboBoxUndoPtr = dylib.lookup <NativeFunction<_WxComboBoxUndoNative>>('wxComboBoxUndo');
  _wxComboBoxUndo = wxComboBoxUndoPtr.asFunction<_WxComboBoxUndo>();

  final wxComboBoxCanCopyPtr = dylib.lookup <NativeFunction<_WxComboBoxCanCopyNative>>('wxComboBoxCanCopy');
  _wxComboBoxCanCopy = wxComboBoxCanCopyPtr.asFunction<_WxComboBoxCanCopy>();

  final wxComboBoxCanCutPtr = dylib.lookup <NativeFunction<_WxComboBoxCanCutNative>>('wxComboBoxCanCut');
  _wxComboBoxCanCut = wxComboBoxCanCutPtr.asFunction<_WxComboBoxCanCut>();

  final wxComboBoxCanPastePtr = dylib.lookup <NativeFunction<_WxComboBoxCanPasteNative>>('wxComboBoxCanPaste');
  _wxComboBoxCanPaste = wxComboBoxCanPastePtr.asFunction<_WxComboBoxCanPaste>();

  final wxComboBoxCanRedoPtr = dylib.lookup <NativeFunction<_WxComboBoxCanRedoNative>>('wxComboBoxCanRedo');
  _wxComboBoxCanRedo = wxComboBoxCanRedoPtr.asFunction<_WxComboBoxCanRedo>();

  final wxComboBoxCanUndoPtr = dylib.lookup <NativeFunction<_WxComboBoxCanUndoNative>>('wxComboBoxCanUndo');
  _wxComboBoxCanUndo = wxComboBoxCanUndoPtr.asFunction<_WxComboBoxCanUndo>();

  final wxComboBoxSetHintPtr = dylib.lookup <NativeFunction<_WxComboBoxSetHintNative>>('wxComboBoxSetHint');
  _wxComboBoxSetHint = wxComboBoxSetHintPtr.asFunction<_WxComboBoxSetHint>();

  final wxComboBoxGetHintPtr = dylib.lookup <NativeFunction<_WxComboBoxGetHintNative>>('wxComboBoxGetHint');
  _wxComboBoxGetHint = wxComboBoxGetHintPtr.asFunction<_WxComboBoxGetHint>();

  final wxComboBoxIsEditablePtr = dylib.lookup <NativeFunction<_WxComboBoxIsEditableNative>>('wxComboBoxIsEditable');
  _wxComboBoxIsEditable = wxComboBoxIsEditablePtr.asFunction<_WxComboBoxIsEditable>();

  final wxComboBoxGetCountPtr = dylib.lookup <NativeFunction<_WxComboBoxGetCountNative>>('wxComboBoxGetCount');
  _wxComboBoxGetCount = wxComboBoxGetCountPtr.asFunction<_WxComboBoxGetCount>();

  final wxComboBoxSetStringPtr = dylib.lookup <NativeFunction<_WxComboBoxSetStringNative>>('wxComboBoxSetString');
  _wxComboBoxSetString = wxComboBoxSetStringPtr.asFunction<_WxComboBoxSetString>();

  final wxComboBoxGetStringPtr = dylib.lookup <NativeFunction<_WxComboBoxGetStringNative>>('wxComboBoxGetString');
  _wxComboBoxGetString = wxComboBoxGetStringPtr.asFunction<_WxComboBoxGetString>();

  final wxComboBoxGetStringsPtr = dylib.lookup <NativeFunction<_WxComboBoxGetStringsNative>>('wxComboBoxGetStrings');
  _wxComboBoxGetStrings = wxComboBoxGetStringsPtr.asFunction<_WxComboBoxGetStrings>();

  final wxComboBoxFindStringPtr = dylib.lookup <NativeFunction<_WxComboBoxFindStringNative>>('wxComboBoxFindString');
  _wxComboBoxFindString = wxComboBoxFindStringPtr.asFunction<_WxComboBoxFindString>();

  final wxComboBoxSetStringSelectionPtr = dylib.lookup <NativeFunction<_WxComboBoxSetStringSelectionNative>>('wxComboBoxSetStringSelection');
  _wxComboBoxSetStringSelection = wxComboBoxSetStringSelectionPtr.asFunction<_WxComboBoxSetStringSelection>();

  final wxComboBoxSelectPtr = dylib.lookup <NativeFunction<_WxComboBoxSelectNative>>('wxComboBoxSelect');
  _wxComboBoxSelect = wxComboBoxSelectPtr.asFunction<_WxComboBoxSelect>();

  final wxComboBoxGetSelectionPtr = dylib.lookup <NativeFunction<_WxComboBoxGetSelectionNative>>('wxComboBoxGetSelection');
  _wxComboBoxGetSelection = wxComboBoxGetSelectionPtr.asFunction<_WxComboBoxGetSelection>();

  final wxComboBoxGetStringSelectionPtr = dylib.lookup <NativeFunction<_WxComboBoxGetStringSelectionNative>>('wxComboBoxGetStringSelection');
  _wxComboBoxGetStringSelection = wxComboBoxGetStringSelectionPtr.asFunction<_WxComboBoxGetStringSelection>();

  final wxComboBoxDeletePtr = dylib.lookup <NativeFunction<_WxComboBoxDeleteNative>>('wxComboBoxDelete');
  _wxComboBoxDelete = wxComboBoxDeletePtr.asFunction<_WxComboBoxDelete>();

  final wxComboBoxSetPtr = dylib.lookup <NativeFunction<_WxComboBoxSetNative>>('wxComboBoxSet');
  _wxComboBoxSet = wxComboBoxSetPtr.asFunction<_WxComboBoxSet>();

  final wxComboBoxAppendPtr = dylib.lookup <NativeFunction<_WxComboBoxAppendNative>>('wxComboBoxAppend');
  _wxComboBoxAppend = wxComboBoxAppendPtr.asFunction<_WxComboBoxAppend>();

  final wxComboBoxAppendListPtr = dylib.lookup <NativeFunction<_WxComboBoxAppendListNative>>('wxComboBoxAppendList');
  _wxComboBoxAppendList = wxComboBoxAppendListPtr.asFunction<_WxComboBoxAppendList>();

  final wxComboBoxInsertPtr = dylib.lookup <NativeFunction<_WxComboBoxInsertNative>>('wxComboBoxInsert');
  _wxComboBoxInsert = wxComboBoxInsertPtr.asFunction<_WxComboBoxInsert>();

  final wxComboBoxInsertListPtr = dylib.lookup <NativeFunction<_WxComboBoxInsertListNative>>('wxComboBoxInsertList');
  _wxComboBoxInsertList = wxComboBoxInsertListPtr.asFunction<_WxComboBoxInsertList>();

  final wxComboBoxSetClientDataPtr = dylib.lookup <NativeFunction<_WxComboBoxSetClientDataNative>>('wxComboBoxSetClientData');
  _wxComboBoxSetClientData = wxComboBoxSetClientDataPtr.asFunction<_WxComboBoxSetClientData>();

  final wxComboBoxGetClientDataPtr = dylib.lookup <NativeFunction<_WxComboBoxGetClientDataNative>>('wxComboBoxGetClientData');
  _wxComboBoxGetClientData = wxComboBoxGetClientDataPtr.asFunction<_WxComboBoxGetClientData>();

  // ------------------------- wxBitmapComboBox ----------------------

  final wxBitmapComboBoxConstructorPtr = dylib.lookup <NativeFunction<_WxBitmapComboBoxConstructorNative>>('wxBitmapComboBoxConstructor');
  _wxBitmapComboBoxConstructor = wxBitmapComboBoxConstructorPtr.asFunction<_WxBitmapComboBoxConstructor>();

  final wxBitmapComboBoxAppendWithBitmapPtr = dylib.lookup <NativeFunction<_WxBitmapComboBoxAppendWithBitmapNative>>('wxBitmapComboBoxAppendWithBitmap');
  _wxBitmapComboBoxAppendWithBitmap = wxBitmapComboBoxAppendWithBitmapPtr.asFunction<_WxBitmapComboBoxAppendWithBitmap>();

  final wxBitmapComboBoxInsertWithBitmapPtr = dylib.lookup <NativeFunction<_WxBitmapComboBoxInsertWithBitmapNative>>('wxBitmapComboBoxInsertWithBitmap');
  _wxBitmapComboBoxInsertWithBitmap = wxBitmapComboBoxInsertWithBitmapPtr.asFunction<_WxBitmapComboBoxInsertWithBitmap>();

  final wxBitmapComboBoxSetItemBitmapPtr = dylib.lookup <NativeFunction<_WxBitmapComboBoxSetItemBitmapNative>>('wxBitmapComboBoxSetItemBitmap');
  _wxBitmapComboBoxSetItemBitmap = wxBitmapComboBoxSetItemBitmapPtr.asFunction<_WxBitmapComboBoxSetItemBitmap>();

  // ------------------------- wxTreeEvent ----------------------

  final wxTreeEventConstructorPtr = dylib.lookup <NativeFunction<_WxTreeEventConstructorNative>>('wxTreeEventConstructor');
  _wxTreeEventConstructor = wxTreeEventConstructorPtr.asFunction<_WxTreeEventConstructor>();

  final wxTreeEventGetItemPtr = dylib.lookup <NativeFunction<_WxTreeEventGetItemNative>>('wxTreeEventGetItem');
  _wxTreeEventGetItem = wxTreeEventGetItemPtr.asFunction<_WxTreeEventGetItem>();

  final wxTreeEventGetLabelPtr = dylib.lookup <NativeFunction<_WxTreeEventGetLabelNative>>('wxTreeEventGetLabel');
  _wxTreeEventGetLabel = wxTreeEventGetLabelPtr.asFunction<_WxTreeEventGetLabel>();

  final wxTreeEventGetPointPtr = dylib.lookup <NativeFunction<_WxTreeEventGetPointNative>>('wxTreeEventGetPoint');
  _wxTreeEventGetPoint = wxTreeEventGetPointPtr.asFunction<_WxTreeEventGetPoint>();

  final wxTreeEventIsEditCancelledPtr = dylib.lookup <NativeFunction<_WxTreeEventIsEditCancelledNative>>('wxTreeEventIsEditCancelled');
  _wxTreeEventIsEditCancelled = wxTreeEventIsEditCancelledPtr.asFunction<_WxTreeEventIsEditCancelled>();

  final wxInstallDartTreeEventCallbackPtr = dylib.lookup <NativeFunction<_WxInstallDartTreeEventCallbackNative>>('wxInstallDartTreeEventCallback');
  _wxInstallDartTreeEventCallback = wxInstallDartTreeEventCallbackPtr.asFunction<_WxInstallDartTreeEventCallback>();

  wxTreeEventNativeCallable = NativeCallable<WxTreeEventCallbackNative>.isolateLocal( wxTreeEventCallback );
  _wxInstallDartTreeEventCallback( wxTreeEventNativeCallable.nativeFunction );

  // ------------------------- wxTreeCtrl ----------------------

  final wxTreeCtrlConstructorPtr = dylib.lookup <NativeFunction<_WxTreeCtrlConstructorNative>>('wxTreeCtrlConstructor');
  _wxTreeCtrlConstructor = wxTreeCtrlConstructorPtr.asFunction<_WxTreeCtrlConstructor>();

  final wxTreeCtrlSetImagesPtr = dylib.lookup <NativeFunction<_WxTreeCtrlSetImagesNative>>('wxTreeCtrlSetImages');
  _wxTreeCtrlSetImages = wxTreeCtrlSetImagesPtr.asFunction<_WxTreeCtrlSetImages>();

  final wxTreeCtrlHasImagesPtr = dylib.lookup <NativeFunction<_WxTreeCtrlHasImagesNative>>('wxTreeCtrlHasImages');
  _wxTreeCtrlHasImages = wxTreeCtrlHasImagesPtr.asFunction<_WxTreeCtrlHasImages>();

  final wxTreeCtrlGetImageCountPtr = dylib.lookup <NativeFunction<_WxTreeCtrlGetImageCountNative>>('wxTreeCtrlGetImageCount');
  _wxTreeCtrlGetImageCount = wxTreeCtrlGetImageCountPtr.asFunction<_WxTreeCtrlGetImageCount>();

  final wxTreeCtrlSetSpacingPtr = dylib.lookup <NativeFunction<_WxTreeCtrlSetSpacingNative>>('wxTreeCtrlSetSpacing');
  _wxTreeCtrlSetSpacing = wxTreeCtrlSetSpacingPtr.asFunction<_WxTreeCtrlSetSpacing>();

  final wxTreeCtrlSetIndentPtr = dylib.lookup <NativeFunction<_WxTreeCtrlSetIndentNative>>('wxTreeCtrlSetIndent');
  _wxTreeCtrlSetIndent = wxTreeCtrlSetIndentPtr.asFunction<_WxTreeCtrlSetIndent>();

  final wxTreeCtrlGetSpacingPtr = dylib.lookup <NativeFunction<_WxTreeCtrlGetSpacingNative>>('wxTreeCtrlGetSpacing');
  _wxTreeCtrlGetSpacing = wxTreeCtrlGetSpacingPtr.asFunction<_WxTreeCtrlGetSpacing>();

  final wxTreeCtrlGetIndentPtr = dylib.lookup <NativeFunction<_WxTreeCtrlGetIndentNative>>('wxTreeCtrlGetIndent');
  _wxTreeCtrlGetIndent = wxTreeCtrlGetIndentPtr.asFunction<_WxTreeCtrlGetIndent>();

  final wxTreeCtrlAddRootPtr = dylib.lookup <NativeFunction<_WxTreeCtrlAddRootNative>>('wxTreeCtrlAddRoot');
  _wxTreeCtrlAddRoot = wxTreeCtrlAddRootPtr.asFunction<_WxTreeCtrlAddRoot>();

  final wxTreeCtrlAppendItemPtr = dylib.lookup <NativeFunction<_WxTreeCtrlAppendItemNative>>('wxTreeCtrlAppendItem');
  _wxTreeCtrlAppendItem = wxTreeCtrlAppendItemPtr.asFunction<_WxTreeCtrlAppendItem>();

  final wxTreeCtrlPrependItemPtr = dylib.lookup <NativeFunction<_WxTreeCtrlPrependItemNative>>('wxTreeCtrlPrependItem');
  _wxTreeCtrlPrependItem = wxTreeCtrlPrependItemPtr.asFunction<_WxTreeCtrlPrependItem>();

  final wxTreeCtrlInsertItemPtr = dylib.lookup <NativeFunction<_WxTreeCtrlInsertItemNative>>('wxTreeCtrlInsertItem');
  _wxTreeCtrlInsertItem = wxTreeCtrlInsertItemPtr.asFunction<_WxTreeCtrlInsertItem>();

  final wxTreeCtrlInsertItemAfterPtr = dylib.lookup <NativeFunction<_WxTreeCtrlInsertItemAfterNative>>('wxTreeCtrlInsertItemAfter');
  _wxTreeCtrlInsertItemAfter = wxTreeCtrlInsertItemAfterPtr.asFunction<_WxTreeCtrlInsertItemAfter>();

  final wxTreeCtrlDeletePtr = dylib.lookup <NativeFunction<_WxTreeCtrlDeleteNative>>('wxTreeCtrlDelete');
  _wxTreeCtrlDelete = wxTreeCtrlDeletePtr.asFunction<_WxTreeCtrlDelete>();

  final wxTreeCtrlDeleteChildrenPtr = dylib.lookup <NativeFunction<_WxTreeCtrlDeleteChildrenNative>>('wxTreeCtrlDeleteChildren');
  _wxTreeCtrlDeleteChildren = wxTreeCtrlDeleteChildrenPtr.asFunction<_WxTreeCtrlDeleteChildren>();

  final wxTreeCtrlDeleteAllItemsPtr = dylib.lookup <NativeFunction<_WxTreeCtrlDeleteAllItemsNative>>('wxTreeCtrlDeleteAllItems');
  _wxTreeCtrlDeleteAllItems = wxTreeCtrlDeleteAllItemsPtr.asFunction<_WxTreeCtrlDeleteAllItems>();

  final wxTreeCtrlGetCountPtr = dylib.lookup <NativeFunction<_WxTreeCtrlGetCountNative>>('wxTreeCtrlGetCount');
  _wxTreeCtrlGetCount = wxTreeCtrlGetCountPtr.asFunction<_WxTreeCtrlGetCount>();

  final wxTreeCtrlGetChildrenCountPtr = dylib.lookup <NativeFunction<_WxTreeCtrlGetChildrenCountNative>>('wxTreeCtrlGetChildrenCount');
  _wxTreeCtrlGetChildrenCount = wxTreeCtrlGetChildrenCountPtr.asFunction<_WxTreeCtrlGetChildrenCount>();

  final wxTreeCtrlEnsureVisiblePtr = dylib.lookup <NativeFunction<_WxTreeCtrlEnsureVisibleNative>>('wxTreeCtrlEnsureVisible');
  _wxTreeCtrlEnsureVisible = wxTreeCtrlEnsureVisiblePtr.asFunction<_WxTreeCtrlEnsureVisible>();

  final wxTreeCtrlGetRootItemPtr = dylib.lookup <NativeFunction<_WxTreeCtrlGetRootItemNative>>('wxTreeCtrlGetRootItem');
  _wxTreeCtrlGetRootItem = wxTreeCtrlGetRootItemPtr.asFunction<_WxTreeCtrlGetRootItem>();

  final wxTreeCtrlGetItemParentPtr = dylib.lookup <NativeFunction<_WxTreeCtrlGetItemParentNative>>('wxTreeCtrlGetItemParent');
  _wxTreeCtrlGetItemParent = wxTreeCtrlGetItemParentPtr.asFunction<_WxTreeCtrlGetItemParent>();

  final wxTreeCtrlGetFirstChildPtr = dylib.lookup <NativeFunction<_WxTreeCtrlGetFirstChildNative>>('wxTreeCtrlGetFirstChild');
  _wxTreeCtrlGetFirstChild = wxTreeCtrlGetFirstChildPtr.asFunction<_WxTreeCtrlGetFirstChild>();

  final wxTreeCtrlGetLastChildPtr = dylib.lookup <NativeFunction<_WxTreeCtrlGetLastChildNative>>('wxTreeCtrlGetLastChild');
  _wxTreeCtrlGetLastChild = wxTreeCtrlGetLastChildPtr.asFunction<_WxTreeCtrlGetLastChild>();

  final wxTreeCtrlGetNextSiblingPtr = dylib.lookup <NativeFunction<_WxTreeCtrlGetNextSiblingNative>>('wxTreeCtrlGetNextSibling');
  _wxTreeCtrlGetNextSibling = wxTreeCtrlGetNextSiblingPtr.asFunction<_WxTreeCtrlGetNextSibling>();

  final wxTreeCtrlGetPrevSiblingPtr = dylib.lookup <NativeFunction<_WxTreeCtrlGetPrevSiblingNative>>('wxTreeCtrlGetPrevSibling');
  _wxTreeCtrlGetPrevSibling = wxTreeCtrlGetPrevSiblingPtr.asFunction<_WxTreeCtrlGetPrevSibling>();

  final wxTreeCtrlGetFocusedItemPtr = dylib.lookup <NativeFunction<_WxTreeCtrlGetFocusedItemNative>>('wxTreeCtrlGetFocusedItem');
  _wxTreeCtrlGetFocusedItem = wxTreeCtrlGetFocusedItemPtr.asFunction<_WxTreeCtrlGetFocusedItem>();

  final wxTreeCtrlSetFocusedItemPtr = dylib.lookup <NativeFunction<_WxTreeCtrlSetFocusedItemNative>>('wxTreeCtrlSetFocusedItem');
  _wxTreeCtrlSetFocusedItem = wxTreeCtrlSetFocusedItemPtr.asFunction<_WxTreeCtrlSetFocusedItem>();

  final wxTreeCtrlClearFocusedItemPtr = dylib.lookup <NativeFunction<_WxTreeCtrlClearFocusedItemNative>>('wxTreeCtrlClearFocusedItem');
  _wxTreeCtrlClearFocusedItem = wxTreeCtrlClearFocusedItemPtr.asFunction<_WxTreeCtrlClearFocusedItem>();

  final wxTreeCtrlGetSelectionPtr = dylib.lookup <NativeFunction<_WxTreeCtrlGetSelectionNative>>('wxTreeCtrlGetSelection');
  _wxTreeCtrlGetSelection = wxTreeCtrlGetSelectionPtr.asFunction<_WxTreeCtrlGetSelection>();

  final wxTreeCtrlIsSelectedPtr = dylib.lookup <NativeFunction<_WxTreeCtrlIsSelectedNative>>('wxTreeCtrlIsSelected');
  _wxTreeCtrlIsSelected = wxTreeCtrlIsSelectedPtr.asFunction<_WxTreeCtrlIsSelected>();

  final wxTreeCtrlSelectItemPtr = dylib.lookup <NativeFunction<_WxTreeCtrlSelectItemNative>>('wxTreeCtrlSelectItem');
  _wxTreeCtrlSelectItem = wxTreeCtrlSelectItemPtr.asFunction<_WxTreeCtrlSelectItem>();

  final wxTreeCtrlUnselectItemPtr = dylib.lookup <NativeFunction<_WxTreeCtrlUnselectItemNative>>('wxTreeCtrlUnselectItem');
  _wxTreeCtrlUnselectItem = wxTreeCtrlUnselectItemPtr.asFunction<_WxTreeCtrlUnselectItem>();

  final wxTreeCtrlSelectChildrenPtr = dylib.lookup <NativeFunction<_WxTreeCtrlSelectChildrenNative>>('wxTreeCtrlSelectChildren');
  _wxTreeCtrlSelectChildren = wxTreeCtrlSelectChildrenPtr.asFunction<_WxTreeCtrlSelectChildren>();

  final wxTreeCtrlToggleItemSelectionPtr = dylib.lookup <NativeFunction<_WxTreeCtrlToggleItemSelectionNative>>('wxTreeCtrlToggleItemSelection');
  _wxTreeCtrlToggleItemSelection = wxTreeCtrlToggleItemSelectionPtr.asFunction<_WxTreeCtrlToggleItemSelection>();

  final wxTreeCtrlIsExpandedPtr = dylib.lookup <NativeFunction<_WxTreeCtrlIsExpandedNative>>('wxTreeCtrlIsExpanded');
  _wxTreeCtrlIsExpanded = wxTreeCtrlIsExpandedPtr.asFunction<_WxTreeCtrlIsExpanded>();

  final wxTreeCtrlItemHasChildrenPtr = dylib.lookup <NativeFunction<_WxTreeCtrlItemHasChildrenNative>>('wxTreeCtrlItemHasChildren');
  _wxTreeCtrlItemHasChildren = wxTreeCtrlItemHasChildrenPtr.asFunction<_WxTreeCtrlItemHasChildren>();

  final wxTreeCtrlExpandPtr = dylib.lookup <NativeFunction<_WxTreeCtrlExpandNative>>('wxTreeCtrlExpand');
  _wxTreeCtrlExpand = wxTreeCtrlExpandPtr.asFunction<_WxTreeCtrlExpand>();

  final wxTreeCtrlExpandAllPtr = dylib.lookup <NativeFunction<_WxTreeCtrlExpandAllNative>>('wxTreeCtrlExpandAll');
  _wxTreeCtrlExpandAll = wxTreeCtrlExpandAllPtr.asFunction<_WxTreeCtrlExpandAll>();

  final wxTreeCtrlExpandAllChildrenPtr = dylib.lookup <NativeFunction<_WxTreeCtrlExpandAllChildrenNative>>('wxTreeCtrlExpandAllChildren');
  _wxTreeCtrlExpandAllChildren = wxTreeCtrlExpandAllChildrenPtr.asFunction<_WxTreeCtrlExpandAllChildren>();

  final wxTreeCtrlTogglePtr = dylib.lookup <NativeFunction<_WxTreeCtrlToggleNative>>('wxTreeCtrlToggle');
  _wxTreeCtrlToggle = wxTreeCtrlTogglePtr.asFunction<_WxTreeCtrlToggle>();

  final wxTreeCtrlCollapsePtr = dylib.lookup <NativeFunction<_WxTreeCtrlCollapseNative>>('wxTreeCtrlCollapse');
  _wxTreeCtrlCollapse = wxTreeCtrlCollapsePtr.asFunction<_WxTreeCtrlCollapse>();

  final wxTreeCtrlCollapseAndResetPtr = dylib.lookup <NativeFunction<_WxTreeCtrlCollapseAndResetNative>>('wxTreeCtrlCollapseAndReset');
  _wxTreeCtrlCollapseAndReset = wxTreeCtrlCollapseAndResetPtr.asFunction<_WxTreeCtrlCollapseAndReset>();

  final wxTreeCtrlCollapseAllPtr = dylib.lookup <NativeFunction<_WxTreeCtrlCollapseAllNative>>('wxTreeCtrlCollapseAll');
  _wxTreeCtrlCollapseAll = wxTreeCtrlCollapseAllPtr.asFunction<_WxTreeCtrlCollapseAll>();

  final wxTreeCtrlCollapseAllChildrenPtr = dylib.lookup <NativeFunction<_WxTreeCtrlCollapseAllChildrenNative>>('wxTreeCtrlCollapseAllChildren');
  _wxTreeCtrlCollapseAllChildren = wxTreeCtrlCollapseAllChildrenPtr.asFunction<_WxTreeCtrlCollapseAllChildren>();

  final wxTreeCtrlSetItemTextPtr = dylib.lookup <NativeFunction<_WxTreeCtrlSetItemTextNative>>('wxTreeCtrlSetItemText');
  _wxTreeCtrlSetItemText = wxTreeCtrlSetItemTextPtr.asFunction<_WxTreeCtrlSetItemText>();

  final wxTreeCtrlGetItemTextPtr = dylib.lookup <NativeFunction<_WxTreeCtrlGetItemTextNative>>('wxTreeCtrlGetItemText');
  _wxTreeCtrlGetItemText = wxTreeCtrlGetItemTextPtr.asFunction<_WxTreeCtrlGetItemText>();

  final wxTreeCtrlSetItemDataPtr = dylib.lookup <NativeFunction<_WxTreeCtrlSetItemDataNative>>('wxTreeCtrlSetItemData');
  _wxTreeCtrlSetItemData = wxTreeCtrlSetItemDataPtr.asFunction<_WxTreeCtrlSetItemData>();

  final wxTreeCtrlGetItemDataPtr = dylib.lookup <NativeFunction<_WxTreeCtrlGetItemDataNative>>('wxTreeCtrlGetItemData');
  _wxTreeCtrlGetItemData = wxTreeCtrlGetItemDataPtr.asFunction<_WxTreeCtrlGetItemData>();

  // ------------------------- wxSplitterWindow ----------------------

  final wxSplitterWindowConstructorPtr = dylib.lookup <NativeFunction<_WxSplitterWindowConstructorNative>>('wxSplitterWindowConstructor');
  _wxSplitterWindowConstructor = wxSplitterWindowConstructorPtr.asFunction<_WxSplitterWindowConstructor>();

  final wxSplitterWindowSplitHorizontallyPtr = dylib.lookup <NativeFunction<_WxSplitterWindowSplitHorizontallyNative>>('wxSplitterWindowSplitHorizontally');
  _wxSplitterWindowSplitHorizontally = wxSplitterWindowSplitHorizontallyPtr.asFunction<_WxSplitterWindowSplitHorizontally>();

  final wxSplitterWindowSplitVerticallyPtr = dylib.lookup <NativeFunction<_WxSplitterWindowSplitVerticallyNative>>('wxSplitterWindowSplitVertically');
  _wxSplitterWindowSplitVertically = wxSplitterWindowSplitVerticallyPtr.asFunction<_WxSplitterWindowSplitVertically>();

  final wxSplitterWindowSetMinimumPaneSizePtr = dylib.lookup <NativeFunction<_WxSplitterWindowSetMinimumPaneSizeNative>>('wxSplitterWindowSetMinimumPaneSize');
  _wxSplitterWindowSetMinimumPaneSize = wxSplitterWindowSetMinimumPaneSizePtr.asFunction<_WxSplitterWindowSetMinimumPaneSize>();

  final wxSplitterWindowIsSplitPtr = dylib.lookup <NativeFunction<_WxSplitterWindowIsSplitNative>>('wxSplitterWindowIsSplit');
  _wxSplitterWindowIsSplit = wxSplitterWindowIsSplitPtr.asFunction<_WxSplitterWindowIsSplit>();

  final wxSplitterWindowSetSashInvisiblePtr = dylib.lookup <NativeFunction<_WxSplitterWindowSetSashInvisibleNative>>('wxSplitterWindowSetSashInvisible');
  _wxSplitterWindowSetSashInvisible = wxSplitterWindowSetSashInvisiblePtr.asFunction<_WxSplitterWindowSetSashInvisible>();

  final wxSplitterWindowIsSashInvisiblePtr = dylib.lookup <NativeFunction<_WxSplitterWindowIsSashInvisibleNative>>('wxSplitterWindowIsSashInvisible');
  _wxSplitterWindowIsSashInvisible = wxSplitterWindowIsSashInvisiblePtr.asFunction<_WxSplitterWindowIsSashInvisible>();

  final wxSplitterWindowSetSashPositionPtr = dylib.lookup <NativeFunction<_WxSplitterWindowSetSashPositionNative>>('wxSplitterWindowSetSashPosition');
  _wxSplitterWindowSetSashPosition = wxSplitterWindowSetSashPositionPtr.asFunction<_WxSplitterWindowSetSashPosition>();

  final wxSplitterWindowGetSashPositionPtr = dylib.lookup <NativeFunction<_WxSplitterWindowGetSashPositionNative>>('wxSplitterWindowGetSashPosition');
  _wxSplitterWindowGetSashPosition = wxSplitterWindowGetSashPositionPtr.asFunction<_WxSplitterWindowGetSashPosition>();

  final wxSplitterWindowSetSashGravityPtr = dylib.lookup <NativeFunction<_WxSplitterWindowSetSashGravityNative>>('wxSplitterWindowSetSashGravity');
  _wxSplitterWindowSetSashGravity = wxSplitterWindowSetSashGravityPtr.asFunction<_WxSplitterWindowSetSashGravity>();

  final wxSplitterWindowGetSashGravityPtr = dylib.lookup <NativeFunction<_WxSplitterWindowGetSashGravityNative>>('wxSplitterWindowGetSashGravity');
  _wxSplitterWindowGetSashGravity = wxSplitterWindowGetSashGravityPtr.asFunction<_WxSplitterWindowGetSashGravity>();

  final wxSplitterWindowUnsplitPtr = dylib.lookup <NativeFunction<_WxSplitterWindowUnsplitNative>>('wxSplitterWindowUnsplit');
  _wxSplitterWindowUnsplit = wxSplitterWindowUnsplitPtr.asFunction<_WxSplitterWindowUnsplit>();

  final wxSplitterWindowUpdateSizePtr = dylib.lookup <NativeFunction<_WxSplitterWindowUpdateSizeNative>>('wxSplitterWindowUpdateSize');
  _wxSplitterWindowUpdateSize = wxSplitterWindowUpdateSizePtr.asFunction<_WxSplitterWindowUpdateSize>();

  // ------------------------- wxSplitterEvent ----------------------

  final wxSplitterEventConstructorPtr = dylib.lookup <NativeFunction<_WxSplitterEventConstructorNative>>('wxSplitterEventConstructor');
  _wxSplitterEventConstructor = wxSplitterEventConstructorPtr.asFunction<_WxSplitterEventConstructor>();

  final wxSplitterEventSetSashPositionPtr = dylib.lookup <NativeFunction<_WxSplitterEventSetSashPositionNative>>('wxSplitterEventSetSashPosition');
  _wxSplitterEventSetSashPosition = wxSplitterEventSetSashPositionPtr.asFunction<_WxSplitterEventSetSashPosition>();

  final wxSplitterEventGetSashPositionPtr = dylib.lookup <NativeFunction<_WxSplitterEventGetSashPositionNative>>('wxSplitterEventGetSashPosition');
  _wxSplitterEventGetSashPosition = wxSplitterEventGetSashPositionPtr.asFunction<_WxSplitterEventGetSashPosition>();

  final wxSplitterEventGetXPtr = dylib.lookup <NativeFunction<_WxSplitterEventGetXNative>>('wxSplitterEventGetX');
  _wxSplitterEventGetX = wxSplitterEventGetXPtr.asFunction<_WxSplitterEventGetX>();

  final wxSplitterEventGetYPtr = dylib.lookup <NativeFunction<_WxSplitterEventGetYNative>>('wxSplitterEventGetY');
  _wxSplitterEventGetY = wxSplitterEventGetYPtr.asFunction<_WxSplitterEventGetY>();

  final wxSplitterEventGetWindowBeingRemovedPtr = dylib.lookup <NativeFunction<_WxSplitterEventGetWindowBeingRemovedNative>>('wxSplitterEventGetWindowBeingRemoved');
  _wxSplitterEventGetWindowBeingRemoved = wxSplitterEventGetWindowBeingRemovedPtr.asFunction<_WxSplitterEventGetWindowBeingRemoved>();

  final wxInstallDartSplitterEventCallbackPtr = dylib.lookup <NativeFunction<_WxInstallDartSplitterEventCallbackNative>>('wxInstallDartSplitterEventCallback');
  _wxInstallDartSplitterEventCallback = wxInstallDartSplitterEventCallbackPtr.asFunction<_WxInstallDartSplitterEventCallback>();

  wxSplitterEventNativeCallable = NativeCallable<WxSplitterEventCallbackNative>.isolateLocal( wxSplitterEventCallback );
  _wxInstallDartSplitterEventCallback( wxSplitterEventNativeCallable.nativeFunction );

  // ------------------------- wxHtmlWindow ----------------------

  final wxHtmlWindowConstructorPtr = dylib.lookup <NativeFunction<_WxHtmlWindowConstructorNative>>('wxHtmlWindowConstructor');
  _wxHtmlWindowConstructor = wxHtmlWindowConstructorPtr.asFunction<_WxHtmlWindowConstructor>();

  final wxHtmlWindowSetPagePtr = dylib.lookup <NativeFunction<_WxHtmlWindowSetPageNative>>('wxHtmlWindowSetPage');
  _wxHtmlWindowSetPage = wxHtmlWindowSetPagePtr.asFunction<_WxHtmlWindowSetPage>();

  final wxHtmlWindowLoadPagePtr = dylib.lookup <NativeFunction<_WxHtmlWindowLoadPageNative>>('wxHtmlWindowLoadPage');
  _wxHtmlWindowLoadPage = wxHtmlWindowLoadPagePtr.asFunction<_WxHtmlWindowLoadPage>();

  // ------------------------- wxHtmlLinkEvent ----------------------

  final wxHtmlLinkEventConstructorPtr = dylib.lookup <NativeFunction<_WxHtmlLinkEventConstructorNative>>('wxHtmlLinkEventConstructor');
  _wxHtmlLinkEventConstructor = wxHtmlLinkEventConstructorPtr.asFunction<_WxHtmlLinkEventConstructor>();

  final wxHtmlLinkEventGetTargetPtr = dylib.lookup <NativeFunction<_WxHtmlLinkEventGetTargetNative>>('wxHtmlLinkEventGetTarget');
  _wxHtmlLinkEventGetTarget = wxHtmlLinkEventGetTargetPtr.asFunction<_WxHtmlLinkEventGetTarget>();

  final wxHtmlLinkEventGetHrefPtr = dylib.lookup <NativeFunction<_WxHtmlLinkEventGetHrefNative>>('wxHtmlLinkEventGetHref');
  _wxHtmlLinkEventGetHref = wxHtmlLinkEventGetHrefPtr.asFunction<_WxHtmlLinkEventGetHref>();

  final wxInstallDartHtmlLinkEventCallbackPtr = dylib.lookup <NativeFunction<_WxInstallDartHtmlLinkEventCallbackNative>>('wxInstallDartHtmlLinkEventCallback');
  _wxInstallDartHtmlLinkEventCallback = wxInstallDartHtmlLinkEventCallbackPtr.asFunction<_WxInstallDartHtmlLinkEventCallback>();

  wxHtmlLinkEventNativeCallable = NativeCallable<WxHtmlLinkEventCallbackNative>.isolateLocal( wxHtmlLinkEventCallback );
  _wxInstallDartHtmlLinkEventCallback( wxHtmlLinkEventNativeCallable.nativeFunction );

  // ------------------------- wxCollapsiblePane ----------------------

  final wxCollapsiblePaneConstructorPtr = dylib.lookup <NativeFunction<_WxCollapsiblePaneConstructorNative>>('wxCollapsiblePaneConstructor');
  _wxCollapsiblePaneConstructor = wxCollapsiblePaneConstructorPtr.asFunction<_WxCollapsiblePaneConstructor>();

  final wxCollapsiblePaneIsCollapsedPtr = dylib.lookup <NativeFunction<_WxCollapsiblePaneIsCollapsedNative>>('wxCollapsiblePaneIsCollapsed');
  _wxCollapsiblePaneIsCollapsed = wxCollapsiblePaneIsCollapsedPtr.asFunction<_WxCollapsiblePaneIsCollapsed>();

  final wxCollapsiblePaneIsExpandedPtr = dylib.lookup <NativeFunction<_WxCollapsiblePaneIsExpandedNative>>('wxCollapsiblePaneIsExpanded');
  _wxCollapsiblePaneIsExpanded = wxCollapsiblePaneIsExpandedPtr.asFunction<_WxCollapsiblePaneIsExpanded>();

  final wxCollapsiblePaneCollapsePtr = dylib.lookup <NativeFunction<_WxCollapsiblePaneCollapseNative>>('wxCollapsiblePaneCollapse');
  _wxCollapsiblePaneCollapse = wxCollapsiblePaneCollapsePtr.asFunction<_WxCollapsiblePaneCollapse>();

  final wxCollapsiblePaneExpandPtr = dylib.lookup <NativeFunction<_WxCollapsiblePaneExpandNative>>('wxCollapsiblePaneExpand');
  _wxCollapsiblePaneExpand = wxCollapsiblePaneExpandPtr.asFunction<_WxCollapsiblePaneExpand>();

  final wxCollapsiblePaneGetPanePtr = dylib.lookup <NativeFunction<_WxCollapsiblePaneGetPaneNative>>('wxCollapsiblePaneGetPane');
  _wxCollapsiblePaneGetPane = wxCollapsiblePaneGetPanePtr.asFunction<_WxCollapsiblePaneGetPane>();

  // ------------------------- wxCollapsiblePaneEvent ----------------------

  final wxCollapsiblePaneEventConstructorPtr = dylib.lookup <NativeFunction<_WxCollapsiblePaneEventConstructorNative>>('wxCollapsiblePaneEventConstructor');
  _wxCollapsiblePaneEventConstructor = wxCollapsiblePaneEventConstructorPtr.asFunction<_WxCollapsiblePaneEventConstructor>();

  final wxCollapsiblePaneEventSetCollapsedPtr = dylib.lookup <NativeFunction<_WxCollapsiblePaneEventSetCollapsedNative>>('wxCollapsiblePaneEventSetCollapsed');
  _wxCollapsiblePaneEventSetCollapsed = wxCollapsiblePaneEventSetCollapsedPtr.asFunction<_WxCollapsiblePaneEventSetCollapsed>();

  final wxCollapsiblePaneEventGetCollapsedPtr = dylib.lookup <NativeFunction<_WxCollapsiblePaneEventGetCollapsedNative>>('wxCollapsiblePaneEventGetCollapsed');
  _wxCollapsiblePaneEventGetCollapsed = wxCollapsiblePaneEventGetCollapsedPtr.asFunction<_WxCollapsiblePaneEventGetCollapsed>();

  final wxInstallDartCollapsiblePaneEventCallbackPtr = dylib.lookup <NativeFunction<_WxInstallDartCollapsiblePaneEventCallbackNative>>('wxInstallDartCollapsiblePaneEventCallback');
  _wxInstallDartCollapsiblePaneEventCallback = wxInstallDartCollapsiblePaneEventCallbackPtr.asFunction<_WxInstallDartCollapsiblePaneEventCallback>();

  wxCollapsiblePaneEventNativeCallable = NativeCallable<WxCollapsiblePaneEventCallbackNative>.isolateLocal( wxCollapsiblePaneEventCallback );
  _wxInstallDartCollapsiblePaneEventCallback( wxCollapsiblePaneEventNativeCallable.nativeFunction );

  // ------------------------- EVT_TEXT ----------------------

  final wxGetTextEventTypePtr = dylib.lookup <NativeFunction<_WxGetTextEventTypeNative>>('wxGetTextEventType');
  wxGetTextEventType = wxGetTextEventTypePtr.asFunction<WxGetTextEventType>();

  final wxEvtHandlerBindTextEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindTextEventCallbackNative>>('wxEvtHandlerBindTextEventCallback');
  wxEvtHandlerBindTextEventCallback = wxEvtHandlerBindTextEventCallbackPtr.asFunction<WxEvtHandlerBindTextEventCallback>();

  final wxEvtHandlerUnbindTextEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindTextEventCallbackNative>>('wxEvtHandlerUnbindTextEventCallback');
  wxEvtHandlerUnbindTextEventCallback = wxEvtHandlerUnbindTextEventCallbackPtr.asFunction<WxEvtHandlerUnbindTextEventCallback>();

  // ------------------------- EVT_TEXT_ENTER ----------------------

  final wxGetTextEnterEventTypePtr = dylib.lookup <NativeFunction<_WxGetTextEnterEventTypeNative>>('wxGetTextEnterEventType');
  wxGetTextEnterEventType = wxGetTextEnterEventTypePtr.asFunction<WxGetTextEnterEventType>();

  final wxEvtHandlerBindTextEnterEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindTextEnterEventCallbackNative>>('wxEvtHandlerBindTextEnterEventCallback');
  wxEvtHandlerBindTextEnterEventCallback = wxEvtHandlerBindTextEnterEventCallbackPtr.asFunction<WxEvtHandlerBindTextEnterEventCallback>();

  final wxEvtHandlerUnbindTextEnterEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindTextEnterEventCallbackNative>>('wxEvtHandlerUnbindTextEnterEventCallback');
  wxEvtHandlerUnbindTextEnterEventCallback = wxEvtHandlerUnbindTextEnterEventCallbackPtr.asFunction<WxEvtHandlerUnbindTextEnterEventCallback>();

  // ------------------------- EVT_COMBOBOX ----------------------

  final wxGetComboboxEventTypePtr = dylib.lookup <NativeFunction<_WxGetComboboxEventTypeNative>>('wxGetComboboxEventType');
  wxGetComboboxEventType = wxGetComboboxEventTypePtr.asFunction<WxGetComboboxEventType>();

  final wxEvtHandlerBindComboboxEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindComboboxEventCallbackNative>>('wxEvtHandlerBindComboboxEventCallback');
  wxEvtHandlerBindComboboxEventCallback = wxEvtHandlerBindComboboxEventCallbackPtr.asFunction<WxEvtHandlerBindComboboxEventCallback>();

  final wxEvtHandlerUnbindComboboxEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindComboboxEventCallbackNative>>('wxEvtHandlerUnbindComboboxEventCallback');
  wxEvtHandlerUnbindComboboxEventCallback = wxEvtHandlerUnbindComboboxEventCallbackPtr.asFunction<WxEvtHandlerUnbindComboboxEventCallback>();

  // ------------------------- EVT_SEARCH ----------------------

  final wxGetSearchEventTypePtr = dylib.lookup <NativeFunction<_WxGetSearchEventTypeNative>>('wxGetSearchEventType');
  wxGetSearchEventType = wxGetSearchEventTypePtr.asFunction<WxGetSearchEventType>();

  final wxEvtHandlerBindSearchEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindSearchEventCallbackNative>>('wxEvtHandlerBindSearchEventCallback');
  wxEvtHandlerBindSearchEventCallback = wxEvtHandlerBindSearchEventCallbackPtr.asFunction<WxEvtHandlerBindSearchEventCallback>();

  final wxEvtHandlerUnbindSearchEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindSearchEventCallbackNative>>('wxEvtHandlerUnbindSearchEventCallback');
  wxEvtHandlerUnbindSearchEventCallback = wxEvtHandlerUnbindSearchEventCallbackPtr.asFunction<WxEvtHandlerUnbindSearchEventCallback>();

  // ------------------------- EVT_SEARCH_CANCEL ----------------------

  final wxGetSearchCancelEventTypePtr = dylib.lookup <NativeFunction<_WxGetSearchCancelEventTypeNative>>('wxGetSearchCancelEventType');
  wxGetSearchCancelEventType = wxGetSearchCancelEventTypePtr.asFunction<WxGetSearchCancelEventType>();

  final wxEvtHandlerBindSearchCancelEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindSearchCancelEventCallbackNative>>('wxEvtHandlerBindSearchCancelEventCallback');
  wxEvtHandlerBindSearchCancelEventCallback = wxEvtHandlerBindSearchCancelEventCallbackPtr.asFunction<WxEvtHandlerBindSearchCancelEventCallback>();

  final wxEvtHandlerUnbindSearchCancelEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindSearchCancelEventCallbackNative>>('wxEvtHandlerUnbindSearchCancelEventCallback');
  wxEvtHandlerUnbindSearchCancelEventCallback = wxEvtHandlerUnbindSearchCancelEventCallbackPtr.asFunction<WxEvtHandlerUnbindSearchCancelEventCallback>();

  // ------------------------- EVT_TREE_DELETE_ITEM ----------------------

  final wxGetTreeDeleteItemEventTypePtr = dylib.lookup <NativeFunction<_WxGetTreeDeleteItemEventTypeNative>>('wxGetTreeDeleteItemEventType');
  wxGetTreeDeleteItemEventType = wxGetTreeDeleteItemEventTypePtr.asFunction<WxGetTreeDeleteItemEventType>();

  final wxEvtHandlerBindTreeDeleteItemEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindTreeDeleteItemEventCallbackNative>>('wxEvtHandlerBindTreeDeleteItemEventCallback');
  wxEvtHandlerBindTreeDeleteItemEventCallback = wxEvtHandlerBindTreeDeleteItemEventCallbackPtr.asFunction<WxEvtHandlerBindTreeDeleteItemEventCallback>();

  final wxEvtHandlerUnbindTreeDeleteItemEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindTreeDeleteItemEventCallbackNative>>('wxEvtHandlerUnbindTreeDeleteItemEventCallback');
  wxEvtHandlerUnbindTreeDeleteItemEventCallback = wxEvtHandlerUnbindTreeDeleteItemEventCallbackPtr.asFunction<WxEvtHandlerUnbindTreeDeleteItemEventCallback>();

  // ------------------------- EVT_TREE_ITEM_ACTIVATED ----------------------

  final wxGetTreeItemActivatedEventTypePtr = dylib.lookup <NativeFunction<_WxGetTreeItemActivatedEventTypeNative>>('wxGetTreeItemActivatedEventType');
  wxGetTreeItemActivatedEventType = wxGetTreeItemActivatedEventTypePtr.asFunction<WxGetTreeItemActivatedEventType>();

  final wxEvtHandlerBindTreeItemActivatedEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindTreeItemActivatedEventCallbackNative>>('wxEvtHandlerBindTreeItemActivatedEventCallback');
  wxEvtHandlerBindTreeItemActivatedEventCallback = wxEvtHandlerBindTreeItemActivatedEventCallbackPtr.asFunction<WxEvtHandlerBindTreeItemActivatedEventCallback>();

  final wxEvtHandlerUnbindTreeItemActivatedEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindTreeItemActivatedEventCallbackNative>>('wxEvtHandlerUnbindTreeItemActivatedEventCallback');
  wxEvtHandlerUnbindTreeItemActivatedEventCallback = wxEvtHandlerUnbindTreeItemActivatedEventCallbackPtr.asFunction<WxEvtHandlerUnbindTreeItemActivatedEventCallback>();

  // ------------------------- EVT_TREE_ITEM_EXPANDED ----------------------

  final wxGetTreeItemExpandedEventTypePtr = dylib.lookup <NativeFunction<_WxGetTreeItemExpandedEventTypeNative>>('wxGetTreeItemExpandedEventType');
  wxGetTreeItemExpandedEventType = wxGetTreeItemExpandedEventTypePtr.asFunction<WxGetTreeItemExpandedEventType>();

  final wxEvtHandlerBindTreeItemExpandedEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindTreeItemExpandedEventCallbackNative>>('wxEvtHandlerBindTreeItemExpandedEventCallback');
  wxEvtHandlerBindTreeItemExpandedEventCallback = wxEvtHandlerBindTreeItemExpandedEventCallbackPtr.asFunction<WxEvtHandlerBindTreeItemExpandedEventCallback>();

  final wxEvtHandlerUnbindTreeItemExpandedEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindTreeItemExpandedEventCallbackNative>>('wxEvtHandlerUnbindTreeItemExpandedEventCallback');
  wxEvtHandlerUnbindTreeItemExpandedEventCallback = wxEvtHandlerUnbindTreeItemExpandedEventCallbackPtr.asFunction<WxEvtHandlerUnbindTreeItemExpandedEventCallback>();

  // ------------------------- EVT_TREE_ITEM_EXPANDING ----------------------

  final wxGetTreeItemExpandingEventTypePtr = dylib.lookup <NativeFunction<_WxGetTreeItemExpandingEventTypeNative>>('wxGetTreeItemExpandingEventType');
  wxGetTreeItemExpandingEventType = wxGetTreeItemExpandingEventTypePtr.asFunction<WxGetTreeItemExpandingEventType>();

  final wxEvtHandlerBindTreeItemExpandingEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindTreeItemExpandingEventCallbackNative>>('wxEvtHandlerBindTreeItemExpandingEventCallback');
  wxEvtHandlerBindTreeItemExpandingEventCallback = wxEvtHandlerBindTreeItemExpandingEventCallbackPtr.asFunction<WxEvtHandlerBindTreeItemExpandingEventCallback>();

  final wxEvtHandlerUnbindTreeItemExpandingEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindTreeItemExpandingEventCallbackNative>>('wxEvtHandlerUnbindTreeItemExpandingEventCallback');
  wxEvtHandlerUnbindTreeItemExpandingEventCallback = wxEvtHandlerUnbindTreeItemExpandingEventCallbackPtr.asFunction<WxEvtHandlerUnbindTreeItemExpandingEventCallback>();

  // ------------------------- EVT_TREE_ITEM_COLLAPSED ----------------------

  final wxGetTreeItemCollapsedEventTypePtr = dylib.lookup <NativeFunction<_WxGetTreeItemCollapsedEventTypeNative>>('wxGetTreeItemCollapsedEventType');
  wxGetTreeItemCollapsedEventType = wxGetTreeItemCollapsedEventTypePtr.asFunction<WxGetTreeItemCollapsedEventType>();

  final wxEvtHandlerBindTreeItemCollapsedEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindTreeItemCollapsedEventCallbackNative>>('wxEvtHandlerBindTreeItemCollapsedEventCallback');
  wxEvtHandlerBindTreeItemCollapsedEventCallback = wxEvtHandlerBindTreeItemCollapsedEventCallbackPtr.asFunction<WxEvtHandlerBindTreeItemCollapsedEventCallback>();

  final wxEvtHandlerUnbindTreeItemCollapsedEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindTreeItemCollapsedEventCallbackNative>>('wxEvtHandlerUnbindTreeItemCollapsedEventCallback');
  wxEvtHandlerUnbindTreeItemCollapsedEventCallback = wxEvtHandlerUnbindTreeItemCollapsedEventCallbackPtr.asFunction<WxEvtHandlerUnbindTreeItemCollapsedEventCallback>();

  // ------------------------- EVT_TREE_ITEM_COLLAPSING ----------------------

  final wxGetTreeItemCollapsingEventTypePtr = dylib.lookup <NativeFunction<_WxGetTreeItemCollapsingEventTypeNative>>('wxGetTreeItemCollapsingEventType');
  wxGetTreeItemCollapsingEventType = wxGetTreeItemCollapsingEventTypePtr.asFunction<WxGetTreeItemCollapsingEventType>();

  final wxEvtHandlerBindTreeItemCollapsingEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindTreeItemCollapsingEventCallbackNative>>('wxEvtHandlerBindTreeItemCollapsingEventCallback');
  wxEvtHandlerBindTreeItemCollapsingEventCallback = wxEvtHandlerBindTreeItemCollapsingEventCallbackPtr.asFunction<WxEvtHandlerBindTreeItemCollapsingEventCallback>();

  final wxEvtHandlerUnbindTreeItemCollapsingEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindTreeItemCollapsingEventCallbackNative>>('wxEvtHandlerUnbindTreeItemCollapsingEventCallback');
  wxEvtHandlerUnbindTreeItemCollapsingEventCallback = wxEvtHandlerUnbindTreeItemCollapsingEventCallbackPtr.asFunction<WxEvtHandlerUnbindTreeItemCollapsingEventCallback>();

  // ------------------------- EVT_TREE_SEL_CHANGED ----------------------

  final wxGetTreeSelChangedEventTypePtr = dylib.lookup <NativeFunction<_WxGetTreeSelChangedEventTypeNative>>('wxGetTreeSelChangedEventType');
  wxGetTreeSelChangedEventType = wxGetTreeSelChangedEventTypePtr.asFunction<WxGetTreeSelChangedEventType>();

  final wxEvtHandlerBindTreeSelChangedEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindTreeSelChangedEventCallbackNative>>('wxEvtHandlerBindTreeSelChangedEventCallback');
  wxEvtHandlerBindTreeSelChangedEventCallback = wxEvtHandlerBindTreeSelChangedEventCallbackPtr.asFunction<WxEvtHandlerBindTreeSelChangedEventCallback>();

  final wxEvtHandlerUnbindTreeSelChangedEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindTreeSelChangedEventCallbackNative>>('wxEvtHandlerUnbindTreeSelChangedEventCallback');
  wxEvtHandlerUnbindTreeSelChangedEventCallback = wxEvtHandlerUnbindTreeSelChangedEventCallbackPtr.asFunction<WxEvtHandlerUnbindTreeSelChangedEventCallback>();

  // ------------------------- EVT_TREE_SEL_CHANGING ----------------------

  final wxGetTreeSelChangingEventTypePtr = dylib.lookup <NativeFunction<_WxGetTreeSelChangingEventTypeNative>>('wxGetTreeSelChangingEventType');
  wxGetTreeSelChangingEventType = wxGetTreeSelChangingEventTypePtr.asFunction<WxGetTreeSelChangingEventType>();

  final wxEvtHandlerBindTreeSelChangingEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindTreeSelChangingEventCallbackNative>>('wxEvtHandlerBindTreeSelChangingEventCallback');
  wxEvtHandlerBindTreeSelChangingEventCallback = wxEvtHandlerBindTreeSelChangingEventCallbackPtr.asFunction<WxEvtHandlerBindTreeSelChangingEventCallback>();

  final wxEvtHandlerUnbindTreeSelChangingEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindTreeSelChangingEventCallbackNative>>('wxEvtHandlerUnbindTreeSelChangingEventCallback');
  wxEvtHandlerUnbindTreeSelChangingEventCallback = wxEvtHandlerUnbindTreeSelChangingEventCallbackPtr.asFunction<WxEvtHandlerUnbindTreeSelChangingEventCallback>();

  // ------------------------- EVT_TREE_ITEM_MENU ----------------------

  final wxGetTreeItemMenuEventTypePtr = dylib.lookup <NativeFunction<_WxGetTreeItemMenuEventTypeNative>>('wxGetTreeItemMenuEventType');
  wxGetTreeItemMenuEventType = wxGetTreeItemMenuEventTypePtr.asFunction<WxGetTreeItemMenuEventType>();

  final wxEvtHandlerBindTreeItemMenuEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindTreeItemMenuEventCallbackNative>>('wxEvtHandlerBindTreeItemMenuEventCallback');
  wxEvtHandlerBindTreeItemMenuEventCallback = wxEvtHandlerBindTreeItemMenuEventCallbackPtr.asFunction<WxEvtHandlerBindTreeItemMenuEventCallback>();

  final wxEvtHandlerUnbindTreeItemMenuEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindTreeItemMenuEventCallbackNative>>('wxEvtHandlerUnbindTreeItemMenuEventCallback');
  wxEvtHandlerUnbindTreeItemMenuEventCallback = wxEvtHandlerUnbindTreeItemMenuEventCallbackPtr.asFunction<WxEvtHandlerUnbindTreeItemMenuEventCallback>();

  // ------------------------- EVT_TREE_ITEM_RIGHT_CLICK ----------------------

  final wxGetTreeItemRightClickEventTypePtr = dylib.lookup <NativeFunction<_WxGetTreeItemRightClickEventTypeNative>>('wxGetTreeItemRightClickEventType');
  wxGetTreeItemRightClickEventType = wxGetTreeItemRightClickEventTypePtr.asFunction<WxGetTreeItemRightClickEventType>();

  final wxEvtHandlerBindTreeItemRightClickEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindTreeItemRightClickEventCallbackNative>>('wxEvtHandlerBindTreeItemRightClickEventCallback');
  wxEvtHandlerBindTreeItemRightClickEventCallback = wxEvtHandlerBindTreeItemRightClickEventCallbackPtr.asFunction<WxEvtHandlerBindTreeItemRightClickEventCallback>();

  final wxEvtHandlerUnbindTreeItemRightClickEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindTreeItemRightClickEventCallbackNative>>('wxEvtHandlerUnbindTreeItemRightClickEventCallback');
  wxEvtHandlerUnbindTreeItemRightClickEventCallback = wxEvtHandlerUnbindTreeItemRightClickEventCallbackPtr.asFunction<WxEvtHandlerUnbindTreeItemRightClickEventCallback>();

  // ------------------------- EVT_TREE_BEGIN_DRAG ----------------------

  final wxGetTreeBeginDragEventTypePtr = dylib.lookup <NativeFunction<_WxGetTreeBeginDragEventTypeNative>>('wxGetTreeBeginDragEventType');
  wxGetTreeBeginDragEventType = wxGetTreeBeginDragEventTypePtr.asFunction<WxGetTreeBeginDragEventType>();

  final wxEvtHandlerBindTreeBeginDragEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindTreeBeginDragEventCallbackNative>>('wxEvtHandlerBindTreeBeginDragEventCallback');
  wxEvtHandlerBindTreeBeginDragEventCallback = wxEvtHandlerBindTreeBeginDragEventCallbackPtr.asFunction<WxEvtHandlerBindTreeBeginDragEventCallback>();

  final wxEvtHandlerUnbindTreeBeginDragEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindTreeBeginDragEventCallbackNative>>('wxEvtHandlerUnbindTreeBeginDragEventCallback');
  wxEvtHandlerUnbindTreeBeginDragEventCallback = wxEvtHandlerUnbindTreeBeginDragEventCallbackPtr.asFunction<WxEvtHandlerUnbindTreeBeginDragEventCallback>();

  // ------------------------- EVT_TREE_BEGIN_RDRAG ----------------------

  final wxGetTreeBeginRDragEventTypePtr = dylib.lookup <NativeFunction<_WxGetTreeBeginRDragEventTypeNative>>('wxGetTreeBeginRDragEventType');
  wxGetTreeBeginRDragEventType = wxGetTreeBeginRDragEventTypePtr.asFunction<WxGetTreeBeginRDragEventType>();

  final wxEvtHandlerBindTreeBeginRDragEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindTreeBeginRDragEventCallbackNative>>('wxEvtHandlerBindTreeBeginRDragEventCallback');
  wxEvtHandlerBindTreeBeginRDragEventCallback = wxEvtHandlerBindTreeBeginRDragEventCallbackPtr.asFunction<WxEvtHandlerBindTreeBeginRDragEventCallback>();

  final wxEvtHandlerUnbindTreeBeginRDragEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindTreeBeginRDragEventCallbackNative>>('wxEvtHandlerUnbindTreeBeginRDragEventCallback');
  wxEvtHandlerUnbindTreeBeginRDragEventCallback = wxEvtHandlerUnbindTreeBeginRDragEventCallbackPtr.asFunction<WxEvtHandlerUnbindTreeBeginRDragEventCallback>();

  // ------------------------- EVT_TREE_END_DRAG ----------------------

  final wxGetTreeEndDragEventTypePtr = dylib.lookup <NativeFunction<_WxGetTreeEndDragEventTypeNative>>('wxGetTreeEndDragEventType');
  wxGetTreeEndDragEventType = wxGetTreeEndDragEventTypePtr.asFunction<WxGetTreeEndDragEventType>();

  final wxEvtHandlerBindTreeEndDragEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindTreeEndDragEventCallbackNative>>('wxEvtHandlerBindTreeEndDragEventCallback');
  wxEvtHandlerBindTreeEndDragEventCallback = wxEvtHandlerBindTreeEndDragEventCallbackPtr.asFunction<WxEvtHandlerBindTreeEndDragEventCallback>();

  final wxEvtHandlerUnbindTreeEndDragEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindTreeEndDragEventCallbackNative>>('wxEvtHandlerUnbindTreeEndDragEventCallback');
  wxEvtHandlerUnbindTreeEndDragEventCallback = wxEvtHandlerUnbindTreeEndDragEventCallbackPtr.asFunction<WxEvtHandlerUnbindTreeEndDragEventCallback>();

  // ------------------------- EVT_TREE_BEGIN_LABEL_EDIT ----------------------

  final wxGetTreeBeginLabelEditEventTypePtr = dylib.lookup <NativeFunction<_WxGetTreeBeginLabelEditEventTypeNative>>('wxGetTreeBeginLabelEditEventType');
  wxGetTreeBeginLabelEditEventType = wxGetTreeBeginLabelEditEventTypePtr.asFunction<WxGetTreeBeginLabelEditEventType>();

  final wxEvtHandlerBindTreeBeginLabelEditEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindTreeBeginLabelEditEventCallbackNative>>('wxEvtHandlerBindTreeBeginLabelEditEventCallback');
  wxEvtHandlerBindTreeBeginLabelEditEventCallback = wxEvtHandlerBindTreeBeginLabelEditEventCallbackPtr.asFunction<WxEvtHandlerBindTreeBeginLabelEditEventCallback>();

  final wxEvtHandlerUnbindTreeBeginLabelEditEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindTreeBeginLabelEditEventCallbackNative>>('wxEvtHandlerUnbindTreeBeginLabelEditEventCallback');
  wxEvtHandlerUnbindTreeBeginLabelEditEventCallback = wxEvtHandlerUnbindTreeBeginLabelEditEventCallbackPtr.asFunction<WxEvtHandlerUnbindTreeBeginLabelEditEventCallback>();

  // ------------------------- EVT_TREE_END_LABEL_EDIT ----------------------

  final wxGetTreeEndLabelEditEventTypePtr = dylib.lookup <NativeFunction<_WxGetTreeEndLabelEditEventTypeNative>>('wxGetTreeEndLabelEditEventType');
  wxGetTreeEndLabelEditEventType = wxGetTreeEndLabelEditEventTypePtr.asFunction<WxGetTreeEndLabelEditEventType>();

  final wxEvtHandlerBindTreeEndLabelEditEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindTreeEndLabelEditEventCallbackNative>>('wxEvtHandlerBindTreeEndLabelEditEventCallback');
  wxEvtHandlerBindTreeEndLabelEditEventCallback = wxEvtHandlerBindTreeEndLabelEditEventCallbackPtr.asFunction<WxEvtHandlerBindTreeEndLabelEditEventCallback>();

  final wxEvtHandlerUnbindTreeEndLabelEditEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindTreeEndLabelEditEventCallbackNative>>('wxEvtHandlerUnbindTreeEndLabelEditEventCallback');
  wxEvtHandlerUnbindTreeEndLabelEditEventCallback = wxEvtHandlerUnbindTreeEndLabelEditEventCallbackPtr.asFunction<WxEvtHandlerUnbindTreeEndLabelEditEventCallback>();

  // ------------------------- EVT_SPLITTER_SASH_POS_CHANGING ----------------------

  final wxGetSplitterSashPosChangingEventTypePtr = dylib.lookup <NativeFunction<_WxGetSplitterSashPosChangingEventTypeNative>>('wxGetSplitterSashPosChangingEventType');
  wxGetSplitterSashPosChangingEventType = wxGetSplitterSashPosChangingEventTypePtr.asFunction<WxGetSplitterSashPosChangingEventType>();

  final wxEvtHandlerBindSplitterSashPosChangingEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindSplitterSashPosChangingEventCallbackNative>>('wxEvtHandlerBindSplitterSashPosChangingEventCallback');
  wxEvtHandlerBindSplitterSashPosChangingEventCallback = wxEvtHandlerBindSplitterSashPosChangingEventCallbackPtr.asFunction<WxEvtHandlerBindSplitterSashPosChangingEventCallback>();

  final wxEvtHandlerUnbindSplitterSashPosChangingEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindSplitterSashPosChangingEventCallbackNative>>('wxEvtHandlerUnbindSplitterSashPosChangingEventCallback');
  wxEvtHandlerUnbindSplitterSashPosChangingEventCallback = wxEvtHandlerUnbindSplitterSashPosChangingEventCallbackPtr.asFunction<WxEvtHandlerUnbindSplitterSashPosChangingEventCallback>();

  // ------------------------- EVT_SPLITTER_SASH_POS_CHANGED ----------------------

  final wxGetSplitterSashPosChangedEventTypePtr = dylib.lookup <NativeFunction<_WxGetSplitterSashPosChangedEventTypeNative>>('wxGetSplitterSashPosChangedEventType');
  wxGetSplitterSashPosChangedEventType = wxGetSplitterSashPosChangedEventTypePtr.asFunction<WxGetSplitterSashPosChangedEventType>();

  final wxEvtHandlerBindSplitterSashPosChangedEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindSplitterSashPosChangedEventCallbackNative>>('wxEvtHandlerBindSplitterSashPosChangedEventCallback');
  wxEvtHandlerBindSplitterSashPosChangedEventCallback = wxEvtHandlerBindSplitterSashPosChangedEventCallbackPtr.asFunction<WxEvtHandlerBindSplitterSashPosChangedEventCallback>();

  final wxEvtHandlerUnbindSplitterSashPosChangedEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindSplitterSashPosChangedEventCallbackNative>>('wxEvtHandlerUnbindSplitterSashPosChangedEventCallback');
  wxEvtHandlerUnbindSplitterSashPosChangedEventCallback = wxEvtHandlerUnbindSplitterSashPosChangedEventCallbackPtr.asFunction<WxEvtHandlerUnbindSplitterSashPosChangedEventCallback>();

  // ------------------------- EVT_SPLITTER_UNSPLIT ----------------------

  final wxGetSplitterUnsplitEventTypePtr = dylib.lookup <NativeFunction<_WxGetSplitterUnsplitEventTypeNative>>('wxGetSplitterUnsplitEventType');
  wxGetSplitterUnsplitEventType = wxGetSplitterUnsplitEventTypePtr.asFunction<WxGetSplitterUnsplitEventType>();

  final wxEvtHandlerBindSplitterUnsplitEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindSplitterUnsplitEventCallbackNative>>('wxEvtHandlerBindSplitterUnsplitEventCallback');
  wxEvtHandlerBindSplitterUnsplitEventCallback = wxEvtHandlerBindSplitterUnsplitEventCallbackPtr.asFunction<WxEvtHandlerBindSplitterUnsplitEventCallback>();

  final wxEvtHandlerUnbindSplitterUnsplitEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindSplitterUnsplitEventCallbackNative>>('wxEvtHandlerUnbindSplitterUnsplitEventCallback');
  wxEvtHandlerUnbindSplitterUnsplitEventCallback = wxEvtHandlerUnbindSplitterUnsplitEventCallbackPtr.asFunction<WxEvtHandlerUnbindSplitterUnsplitEventCallback>();

  // ------------------------- EVT_SPLITTER_DOUBLECLICKED ----------------------

  final wxGetSplitterDoubleClickEventTypePtr = dylib.lookup <NativeFunction<_WxGetSplitterDoubleClickEventTypeNative>>('wxGetSplitterDoubleClickEventType');
  wxGetSplitterDoubleClickEventType = wxGetSplitterDoubleClickEventTypePtr.asFunction<WxGetSplitterDoubleClickEventType>();

  final wxEvtHandlerBindSplitterDoubleClickEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindSplitterDoubleClickEventCallbackNative>>('wxEvtHandlerBindSplitterDoubleClickEventCallback');
  wxEvtHandlerBindSplitterDoubleClickEventCallback = wxEvtHandlerBindSplitterDoubleClickEventCallbackPtr.asFunction<WxEvtHandlerBindSplitterDoubleClickEventCallback>();

  final wxEvtHandlerUnbindSplitterDoubleClickEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindSplitterDoubleClickEventCallbackNative>>('wxEvtHandlerUnbindSplitterDoubleClickEventCallback');
  wxEvtHandlerUnbindSplitterDoubleClickEventCallback = wxEvtHandlerUnbindSplitterDoubleClickEventCallbackPtr.asFunction<WxEvtHandlerUnbindSplitterDoubleClickEventCallback>();

  // ------------------------- EVT_HTML_LINK_CLICKED ----------------------

  final wxGetHtmlLinkClickEventTypePtr = dylib.lookup <NativeFunction<_WxGetHtmlLinkClickEventTypeNative>>('wxGetHtmlLinkClickEventType');
  wxGetHtmlLinkClickEventType = wxGetHtmlLinkClickEventTypePtr.asFunction<WxGetHtmlLinkClickEventType>();

  final wxEvtHandlerBindHtmlLinkClickEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindHtmlLinkClickEventCallbackNative>>('wxEvtHandlerBindHtmlLinkClickEventCallback');
  wxEvtHandlerBindHtmlLinkClickEventCallback = wxEvtHandlerBindHtmlLinkClickEventCallbackPtr.asFunction<WxEvtHandlerBindHtmlLinkClickEventCallback>();

  final wxEvtHandlerUnbindHtmlLinkClickEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindHtmlLinkClickEventCallbackNative>>('wxEvtHandlerUnbindHtmlLinkClickEventCallback');
  wxEvtHandlerUnbindHtmlLinkClickEventCallback = wxEvtHandlerUnbindHtmlLinkClickEventCallbackPtr.asFunction<WxEvtHandlerUnbindHtmlLinkClickEventCallback>();

  // ------------------------- EVT_COLLAPSIBLEPANE_CHANGED ----------------------

  final wxGetCollapsiblePaneChangedEventTypePtr = dylib.lookup <NativeFunction<_WxGetCollapsiblePaneChangedEventTypeNative>>('wxGetCollapsiblePaneChangedEventType');
  wxGetCollapsiblePaneChangedEventType = wxGetCollapsiblePaneChangedEventTypePtr.asFunction<WxGetCollapsiblePaneChangedEventType>();

  final wxEvtHandlerBindCollapsiblePaneChangedEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerBindCollapsiblePaneChangedEventCallbackNative>>('wxEvtHandlerBindCollapsiblePaneChangedEventCallback');
  wxEvtHandlerBindCollapsiblePaneChangedEventCallback = wxEvtHandlerBindCollapsiblePaneChangedEventCallbackPtr.asFunction<WxEvtHandlerBindCollapsiblePaneChangedEventCallback>();

  final wxEvtHandlerUnbindCollapsiblePaneChangedEventCallbackPtr = dylib.lookup <NativeFunction<_WxEvtHandlerUnbindCollapsiblePaneChangedEventCallbackNative>>('wxEvtHandlerUnbindCollapsiblePaneChangedEventCallback');
  wxEvtHandlerUnbindCollapsiblePaneChangedEventCallback = wxEvtHandlerUnbindCollapsiblePaneChangedEventCallbackPtr.asFunction<WxEvtHandlerUnbindCollapsiblePaneChangedEventCallback>();

}

void releaseWxControls2()
{
  wxTreeEventNativeCallable.close();
  wxSplitterEventNativeCallable.close();
  wxHtmlLinkEventNativeCallable.close();
  wxCollapsiblePaneEventNativeCallable.close();
}
