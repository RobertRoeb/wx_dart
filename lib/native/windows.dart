// -------------------------------------------------------------
// Purpose:     Dart bindings for wxWidgets
// Author:      Robert Roebling
// Modified by: The magic C++ to Dart code generator
// Created:     07/01/2025
// Copyright:   (c) Robert Roebling
// Licence:     wxWindows licence 3.1
// -------------------------------------------------------------

part of '../wx_dart.dart';

// ------------------------- wxWindow ----------------------

typedef _WxWindowConstructorNative = Pointer Function( Pointer, Int32, Int32, Int32, Int32, Int32, Int32  );
typedef _WxWindowConstructor = Pointer Function( Pointer, int, int, int, int, int, int  );
late _WxWindowConstructor _wxWindowConstructor;

typedef _WxWindowGetChildCountNative = Int32 Function( Pointer  );
typedef _WxWindowGetChildCount = int Function( Pointer  );
late _WxWindowGetChildCount _wxWindowGetChildCount;

typedef _WxWindowGetChildNative = Pointer Function( Pointer, Int32  );
typedef _WxWindowGetChild = Pointer Function( Pointer, int  );
late _WxWindowGetChild _wxWindowGetChild;

typedef _WxWindowGetParentNative = Pointer Function( Pointer  );
typedef _WxWindowGetParent = Pointer Function( Pointer  );
late _WxWindowGetParent _wxWindowGetParent;

typedef _WxWindowIsTopLevelNative = Bool Function( Pointer  );
typedef _WxWindowIsTopLevel = bool Function( Pointer  );
late _WxWindowIsTopLevel _wxWindowIsTopLevel;

typedef _WxWindowFindWindowNative = Pointer Function( Pointer, Int32  );
typedef _WxWindowFindWindow = Pointer Function( Pointer, int  );
late _WxWindowFindWindow _wxWindowFindWindow;

typedef _WxWindowReparentNative = Void Function( Pointer, Pointer  );
typedef _WxWindowReparent = void Function( Pointer, Pointer  );
late _WxWindowReparent _wxWindowReparent;

typedef _WxWindowGetIdNative = Int32 Function( Pointer  );
typedef _WxWindowGetId = int Function( Pointer  );
late _WxWindowGetId _wxWindowGetId;

typedef _WxWindowSetLabelNative = Void Function( Pointer, Pointer<Utf8>  );
typedef _WxWindowSetLabel = void Function( Pointer, Pointer<Utf8>  );
late _WxWindowSetLabel _wxWindowSetLabel;

typedef _WxWindowGetLabelNative = Pointer<Utf8> Function( Pointer  );
typedef _WxWindowGetLabel = Pointer<Utf8> Function( Pointer  );
late _WxWindowGetLabel _wxWindowGetLabel;

typedef _WxWindowHasFlagNative = Bool Function( Pointer, Int32  );
typedef _WxWindowHasFlag = bool Function( Pointer, int  );
late _WxWindowHasFlag _wxWindowHasFlag;

typedef _WxWindowGetWindowStyleNative = Int32 Function( Pointer  );
typedef _WxWindowGetWindowStyle = int Function( Pointer  );
late _WxWindowGetWindowStyle _wxWindowGetWindowStyle;

typedef _WxWindowGetWindowStyleFlagNative = Int32 Function( Pointer  );
typedef _WxWindowGetWindowStyleFlag = int Function( Pointer  );
late _WxWindowGetWindowStyleFlag _wxWindowGetWindowStyleFlag;

typedef _WxWindowSetWindowStyleNative = Void Function( Pointer, Int32  );
typedef _WxWindowSetWindowStyle = void Function( Pointer, int  );
late _WxWindowSetWindowStyle _wxWindowSetWindowStyle;

typedef _WxWindowSetWindowStyleFlagNative = Void Function( Pointer, Int32  );
typedef _WxWindowSetWindowStyleFlag = void Function( Pointer, int  );
late _WxWindowSetWindowStyleFlag _wxWindowSetWindowStyleFlag;

typedef _WxWindowEnableTouchEventsNative = Void Function( Pointer, Int32  );
typedef _WxWindowEnableTouchEvents = void Function( Pointer, int  );
late _WxWindowEnableTouchEvents _wxWindowEnableTouchEvents;

typedef _WxWindowCloseNative = Bool Function( Pointer, Bool  );
typedef _WxWindowClose = bool Function( Pointer, bool  );
late _WxWindowClose _wxWindowClose;

typedef _WxWindowDestroyNative = Bool Function( Pointer  );
typedef _WxWindowDestroy = bool Function( Pointer  );
late _WxWindowDestroy _wxWindowDestroy;

typedef _WxWindowCentreNative = Void Function( Pointer, Int32  );
typedef _WxWindowCentre = void Function( Pointer, int  );
late _WxWindowCentre _wxWindowCentre;

typedef _WxWindowCentreOnParentNative = Void Function( Pointer, Int32  );
typedef _WxWindowCentreOnParent = void Function( Pointer, int  );
late _WxWindowCentreOnParent _wxWindowCentreOnParent;

typedef _WxWindowGetSizeNative = WxSizeNative Function( Pointer  );
typedef _WxWindowGetSize = WxSizeNative Function( Pointer  );
late _WxWindowGetSize _wxWindowGetSize;

typedef _WxWindowGetVirtualSizeNative = WxSizeNative Function( Pointer  );
typedef _WxWindowGetVirtualSize = WxSizeNative Function( Pointer  );
late _WxWindowGetVirtualSize _wxWindowGetVirtualSize;

typedef _WxWindowGetMinSizeNative = WxSizeNative Function( Pointer  );
typedef _WxWindowGetMinSize = WxSizeNative Function( Pointer  );
late _WxWindowGetMinSize _wxWindowGetMinSize;

typedef _WxWindowGetMaxClientSizeNative = WxSizeNative Function( Pointer  );
typedef _WxWindowGetMaxClientSize = WxSizeNative Function( Pointer  );
late _WxWindowGetMaxClientSize _wxWindowGetMaxClientSize;

typedef _WxWindowGetMaxSizeNative = WxSizeNative Function( Pointer  );
typedef _WxWindowGetMaxSize = WxSizeNative Function( Pointer  );
late _WxWindowGetMaxSize _wxWindowGetMaxSize;

typedef _WxWindowGetPositionNative = WxPointNative Function( Pointer  );
typedef _WxWindowGetPosition = WxPointNative Function( Pointer  );
late _WxWindowGetPosition _wxWindowGetPosition;

typedef _WxWindowGetRectNative = WxRectNative Function( Pointer  );
typedef _WxWindowGetRect = WxRectNative Function( Pointer  );
late _WxWindowGetRect _wxWindowGetRect;

typedef _WxWindowInvalidateBestSizeNative = Void Function( Pointer  );
typedef _WxWindowInvalidateBestSize = void Function( Pointer  );
late _WxWindowInvalidateBestSize _wxWindowInvalidateBestSize;

typedef _WxWindowSetSizeNative = Void Function( Pointer, Int32, Int32  );
typedef _WxWindowSetSize = void Function( Pointer, int, int  );
late _WxWindowSetSize _wxWindowSetSize;

typedef _WxWindowSetPositionNative = Void Function( Pointer, Int32, Int32  );
typedef _WxWindowSetPosition = void Function( Pointer, int, int  );
late _WxWindowSetPosition _wxWindowSetPosition;

typedef _WxWindowSetPositionAndSizeNative = Void Function( Pointer, Int32, Int32, Int32, Int32  );
typedef _WxWindowSetPositionAndSize = void Function( Pointer, int, int, int, int  );
late _WxWindowSetPositionAndSize _wxWindowSetPositionAndSize;

typedef _WxWindowSetMinSizeNative = Void Function( Pointer, Int32, Int32  );
typedef _WxWindowSetMinSize = void Function( Pointer, int, int  );
late _WxWindowSetMinSize _wxWindowSetMinSize;

typedef _WxWindowSetClientSizeNative = Void Function( Pointer, Int32, Int32  );
typedef _WxWindowSetClientSize = void Function( Pointer, int, int  );
late _WxWindowSetClientSize _wxWindowSetClientSize;

typedef _WxWindowSetVirtualSizeNative = Void Function( Pointer, Int32, Int32  );
typedef _WxWindowSetVirtualSize = void Function( Pointer, int, int  );
late _WxWindowSetVirtualSize _wxWindowSetVirtualSize;

typedef _WxWindowGetClientSizeNative = WxSizeNative Function( Pointer  );
typedef _WxWindowGetClientSize = WxSizeNative Function( Pointer  );
late _WxWindowGetClientSize _wxWindowGetClientSize;

typedef _WxWindowGetClientRectNative = WxRectNative Function( Pointer  );
typedef _WxWindowGetClientRect = WxRectNative Function( Pointer  );
late _WxWindowGetClientRect _wxWindowGetClientRect;

typedef _WxWindowGetClientAreaOriginNative = WxPointNative Function( Pointer  );
typedef _WxWindowGetClientAreaOrigin = WxPointNative Function( Pointer  );
late _WxWindowGetClientAreaOrigin _wxWindowGetClientAreaOrigin;

typedef _WxWindowGetUpdateClientRectNative = WxRectNative Function( Pointer  );
typedef _WxWindowGetUpdateClientRect = WxRectNative Function( Pointer  );
late _WxWindowGetUpdateClientRect _wxWindowGetUpdateClientRect;

typedef _WxWindowLowerNative = Void Function( Pointer  );
typedef _WxWindowLower = void Function( Pointer  );
late _WxWindowLower _wxWindowLower;

typedef _WxWindowRaiseNative = Void Function( Pointer  );
typedef _WxWindowRaise = void Function( Pointer  );
late _WxWindowRaise _wxWindowRaise;

typedef _WxWindowHideNative = Void Function( Pointer  );
typedef _WxWindowHide = void Function( Pointer  );
late _WxWindowHide _wxWindowHide;

typedef _WxWindowShowNative = Void Function( Pointer, Bool  );
typedef _WxWindowShow = void Function( Pointer, bool  );
late _WxWindowShow _wxWindowShow;

typedef _WxWindowIsShownNative = Bool Function( Pointer  );
typedef _WxWindowIsShown = bool Function( Pointer  );
late _WxWindowIsShown _wxWindowIsShown;

typedef _WxWindowDisableNative = Void Function( Pointer  );
typedef _WxWindowDisable = void Function( Pointer  );
late _WxWindowDisable _wxWindowDisable;

typedef _WxWindowEnableNative = Void Function( Pointer, Bool  );
typedef _WxWindowEnable = void Function( Pointer, bool  );
late _WxWindowEnable _wxWindowEnable;

typedef _WxWindowIsEnabledNative = Bool Function( Pointer  );
typedef _WxWindowIsEnabled = bool Function( Pointer  );
late _WxWindowIsEnabled _wxWindowIsEnabled;

typedef _WxWindowClientToScreenNative = WxPointNative Function( Pointer, Int32, Int32  );
typedef _WxWindowClientToScreen = WxPointNative Function( Pointer, int, int  );
late _WxWindowClientToScreen _wxWindowClientToScreen;

typedef _WxWindowScreenToClientNative = WxPointNative Function( Pointer, Int32, Int32  );
typedef _WxWindowScreenToClient = WxPointNative Function( Pointer, int, int  );
late _WxWindowScreenToClient _wxWindowScreenToClient;

typedef _WxWindowClientToWindowSizeNative = WxSizeNative Function( Pointer, Int32, Int32  );
typedef _WxWindowClientToWindowSize = WxSizeNative Function( Pointer, int, int  );
late _WxWindowClientToWindowSize _wxWindowClientToWindowSize;

typedef _WxWindowWindowToClientSizeNative = WxSizeNative Function( Pointer, Int32, Int32  );
typedef _WxWindowWindowToClientSize = WxSizeNative Function( Pointer, int, int  );
late _WxWindowWindowToClientSize _wxWindowWindowToClientSize;

typedef _WxWindowFitNative = Void Function( Pointer  );
typedef _WxWindowFit = void Function( Pointer  );
late _WxWindowFit _wxWindowFit;

typedef _WxWindowFitInsideNative = Void Function( Pointer  );
typedef _WxWindowFitInside = void Function( Pointer  );
late _WxWindowFitInside _wxWindowFitInside;

typedef _WxWindowSizeFromDIPNative = WxSizeNative Function( Pointer, Int32, Int32  );
typedef _WxWindowSizeFromDIP = WxSizeNative Function( Pointer, int, int  );
late _WxWindowSizeFromDIP _wxWindowSizeFromDIP;

typedef _WxWindowFromDIPNative = Int32 Function( Pointer, Int32  );
typedef _WxWindowFromDIP = int Function( Pointer, int  );
late _WxWindowFromDIP _wxWindowFromDIP;

typedef _WxWindowGetDPIScaleFactorNative = Double Function( Pointer  );
typedef _WxWindowGetDPIScaleFactor = double Function( Pointer  );
late _WxWindowGetDPIScaleFactor _wxWindowGetDPIScaleFactor;

typedef _WxWindowGetContentScaleFactorNative = Double Function( Pointer  );
typedef _WxWindowGetContentScaleFactor = double Function( Pointer  );
late _WxWindowGetContentScaleFactor _wxWindowGetContentScaleFactor;

typedef _WxWindowFreezeNative = Void Function( Pointer  );
typedef _WxWindowFreeze = void Function( Pointer  );
late _WxWindowFreeze _wxWindowFreeze;

typedef _WxWindowThawNative = Void Function( Pointer  );
typedef _WxWindowThaw = void Function( Pointer  );
late _WxWindowThaw _wxWindowThaw;

typedef _WxWindowIsFrozenNative = Bool Function( Pointer  );
typedef _WxWindowIsFrozen = bool Function( Pointer  );
late _WxWindowIsFrozen _wxWindowIsFrozen;

typedef _WxWindowRefreshNative = Void Function( Pointer  );
typedef _WxWindowRefresh = void Function( Pointer  );
late _WxWindowRefresh _wxWindowRefresh;

typedef _WxWindowRefreshRectNative = Void Function( Pointer, Int32, Int32, Int32, Int32  );
typedef _WxWindowRefreshRect = void Function( Pointer, int, int, int, int  );
late _WxWindowRefreshRect _wxWindowRefreshRect;

typedef _WxWindowCaptureMouseNative = Void Function( Pointer  );
typedef _WxWindowCaptureMouse = void Function( Pointer  );
late _WxWindowCaptureMouse _wxWindowCaptureMouse;

typedef _WxWindowReleaseMouseNative = Void Function( Pointer  );
typedef _WxWindowReleaseMouse = void Function( Pointer  );
late _WxWindowReleaseMouse _wxWindowReleaseMouse;

typedef _WxWindowHasCaptureNative = Bool Function( Pointer  );
typedef _WxWindowHasCapture = bool Function( Pointer  );
late _WxWindowHasCapture _wxWindowHasCapture;

typedef _WxWindowPopupMenuNative = Bool Function( Pointer, Pointer, Int32, Int32  );
typedef _WxWindowPopupMenu = bool Function( Pointer, Pointer, int, int  );
late _WxWindowPopupMenu _wxWindowPopupMenu;

typedef _WxWindowSetCursorNative = Void Function( Pointer, Pointer  );
typedef _WxWindowSetCursor = void Function( Pointer, Pointer  );
late _WxWindowSetCursor _wxWindowSetCursor;

typedef _WxWindowGetCursorNative = Pointer Function( Pointer  );
typedef _WxWindowGetCursor = Pointer Function( Pointer  );
late _WxWindowGetCursor _wxWindowGetCursor;

typedef _WxWindowSetFocusNative = Void Function( Pointer  );
typedef _WxWindowSetFocus = void Function( Pointer  );
late _WxWindowSetFocus _wxWindowSetFocus;

typedef _WxWindowHasFocusNative = Bool Function( Pointer  );
typedef _WxWindowHasFocus = bool Function( Pointer  );
late _WxWindowHasFocus _wxWindowHasFocus;

typedef _WxWindowSetCanFocusNative = Void Function( Pointer, Bool  );
typedef _WxWindowSetCanFocus = void Function( Pointer, bool  );
late _WxWindowSetCanFocus _wxWindowSetCanFocus;

typedef _WxWindowDisableFocusFromKeyboardNative = Void Function( Pointer  );
typedef _WxWindowDisableFocusFromKeyboard = void Function( Pointer  );
late _WxWindowDisableFocusFromKeyboard _wxWindowDisableFocusFromKeyboard;

typedef _WxWindowAcceptsFocusNative = Bool Function( Pointer  );
typedef _WxWindowAcceptsFocus = bool Function( Pointer  );
late _WxWindowAcceptsFocus _wxWindowAcceptsFocus;

typedef _WxWindowAcceptsFocusFromKeyboardNative = Bool Function( Pointer  );
typedef _WxWindowAcceptsFocusFromKeyboard = bool Function( Pointer  );
late _WxWindowAcceptsFocusFromKeyboard _wxWindowAcceptsFocusFromKeyboard;

typedef _WxWindowAcceptsFocusRecursivelyNative = Bool Function( Pointer  );
typedef _WxWindowAcceptsFocusRecursively = bool Function( Pointer  );
late _WxWindowAcceptsFocusRecursively _wxWindowAcceptsFocusRecursively;

typedef _WxWindowIsFocusableNative = Bool Function( Pointer  );
typedef _WxWindowIsFocusable = bool Function( Pointer  );
late _WxWindowIsFocusable _wxWindowIsFocusable;

typedef _WxWindowCanAcceptFocusFromKeyboardNative = Bool Function( Pointer  );
typedef _WxWindowCanAcceptFocusFromKeyboard = bool Function( Pointer  );
late _WxWindowCanAcceptFocusFromKeyboard _wxWindowCanAcceptFocusFromKeyboard;

typedef _WxWindowCanAcceptFocusNative = Bool Function( Pointer  );
typedef _WxWindowCanAcceptFocus = bool Function( Pointer  );
late _WxWindowCanAcceptFocus _wxWindowCanAcceptFocus;

typedef _WxWindowLayoutNative = Void Function( Pointer  );
typedef _WxWindowLayout = void Function( Pointer  );
late _WxWindowLayout _wxWindowLayout;

typedef _WxWindowSetSizerNative = Void Function( Pointer, Pointer, Bool  );
typedef _WxWindowSetSizer = void Function( Pointer, Pointer, bool  );
late _WxWindowSetSizer _wxWindowSetSizer;

typedef _WxWindowGetSizerNative = Pointer Function( Pointer  );
typedef _WxWindowGetSizer = Pointer Function( Pointer  );
late _WxWindowGetSizer _wxWindowGetSizer;

typedef _WxWindowSetSizerAndFitNative = Void Function( Pointer, Pointer, Bool  );
typedef _WxWindowSetSizerAndFit = void Function( Pointer, Pointer, bool  );
late _WxWindowSetSizerAndFit _wxWindowSetSizerAndFit;

typedef _WxWindowSetForegroundColourNative = Void Function( Pointer, Uint32  );
typedef _WxWindowSetForegroundColour = void Function( Pointer, int  );
late _WxWindowSetForegroundColour _wxWindowSetForegroundColour;

typedef _WxWindowGetForegroundColourNative = Uint32 Function( Pointer  );
typedef _WxWindowGetForegroundColour = int Function( Pointer  );
late _WxWindowGetForegroundColour _wxWindowGetForegroundColour;

typedef _WxWindowUseForegroundColourNative = Bool Function( Pointer  );
typedef _WxWindowUseForegroundColour = bool Function( Pointer  );
late _WxWindowUseForegroundColour _wxWindowUseForegroundColour;

typedef _WxWindowSetBackgroundColourNative = Void Function( Pointer, Uint32  );
typedef _WxWindowSetBackgroundColour = void Function( Pointer, int  );
late _WxWindowSetBackgroundColour _wxWindowSetBackgroundColour;

typedef _WxWindowGetBackgroundColourNative = Uint32 Function( Pointer  );
typedef _WxWindowGetBackgroundColour = int Function( Pointer  );
late _WxWindowGetBackgroundColour _wxWindowGetBackgroundColour;

typedef _WxWindowUseBackgroundColourNative = Bool Function( Pointer  );
typedef _WxWindowUseBackgroundColour = bool Function( Pointer  );
late _WxWindowUseBackgroundColour _wxWindowUseBackgroundColour;

typedef _WxWindowSetBackgroundStyleNative = Void Function( Pointer, Int32  );
typedef _WxWindowSetBackgroundStyle = void Function( Pointer, int  );
late _WxWindowSetBackgroundStyle _wxWindowSetBackgroundStyle;

typedef _WxWindowGetBackgroundStyleNative = Int32 Function( Pointer  );
typedef _WxWindowGetBackgroundStyle = int Function( Pointer  );
late _WxWindowGetBackgroundStyle _wxWindowGetBackgroundStyle;

typedef _WxWindowGetTextExtentNative = WxSizeNative Function( Pointer, Pointer<Utf8>  );
typedef _WxWindowGetTextExtent = WxSizeNative Function( Pointer, Pointer<Utf8>  );
late _WxWindowGetTextExtent _wxWindowGetTextExtent;

typedef _WxWindowSetFontNative = Void Function( Pointer, Pointer  );
typedef _WxWindowSetFont = void Function( Pointer, Pointer  );
late _WxWindowSetFont _wxWindowSetFont;

typedef _WxWindowSetToolTipNative = Void Function( Pointer, Pointer<Utf8>  );
typedef _WxWindowSetToolTip = void Function( Pointer, Pointer<Utf8>  );
late _WxWindowSetToolTip _wxWindowSetToolTip;

typedef _WxWindowUnsetToolTipNative = Void Function( Pointer  );
typedef _WxWindowUnsetToolTip = void Function( Pointer  );
late _WxWindowUnsetToolTip _wxWindowUnsetToolTip;

typedef _WxWindowGetToolTipTextNative = Pointer<Utf8> Function( Pointer  );
typedef _WxWindowGetToolTipText = Pointer<Utf8> Function( Pointer  );
late _WxWindowGetToolTipText _wxWindowGetToolTipText;

typedef _WxWindowSetDropTargetNative = Void Function( Pointer, Pointer  );
typedef _WxWindowSetDropTarget = void Function( Pointer, Pointer  );
late _WxWindowSetDropTarget _wxWindowSetDropTarget;

/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxCENTRE | 0x0001 |
/// | wxCENTER | wxCENTRE |
/// | wxCENTER_FRAME | 0x0000 |
/// | wxCENTRE_ON_SCREEN | 0x0002 |
/// | wxCENTER_ON_SCREEN | wxCENTRE_ON_SCREEN |
/// | wxHORIZONTAL | 0x0004 |
/// | wxVERTICAL | 0x0008 |
/// | wxBOTH | wxVERTICAL | wxHORIZONTAL |
/// | wxORIENTATION_MASK | wxBOTH |
/// | wxBG_STYLE_ERASE | 0 |
/// | wxBG_STYLE_SYSTEM | 1 |
/// | wxBG_STYLE_PAINT | 2 |
/// | wxBG_STYLE_TRANSPARENT | 3 |
/// | wxBORDER_DEFAULT | 0 |
/// | wxBORDER_NONE | 0x00200000 |
/// | wxBORDER_STATIC | 0x01000000 |
/// | wxBORDER_SIMPLE | 0x02000000 |
/// | wxBORDER_RAISED | 0x04000000 |
/// | wxBORDER_SUNKEN | 0x08000000 |
/// | wxBORDER_DOUBLE | 0x10000000 |
/// | wxBORDER_THEME | wxBORDER_DOUBLE |
/// | wxBORDER_MASK | 0x1f200000 |
/// | wxDEFAULT_CONTROL_BORDER | wxBORDER_SUNKEN |
/// | wxVSCROLL | 0x80000000 |
/// | wxHSCROLL | 0x40000000 |
/// | wxCAPTION | 0x20000000 |
/// | wxALWAYS_SHOW_SB | 0x00800000 |
/// | wxTRANSLUCENT_WINDOW | 0x00100000 |
/// | wxTAB_TRAVERSAL | 0x00080000 |
/// | wxWANTS_CHARS | 0x00040000 |
/// | wxPOPUP_WINDOW | 0x00020000 |
/// | wxFULL_REPAINT_ON_RESIZE | 0x00010000 |
/// | wxTOUCH_NONE | 0 |
/// | wxTOUCH_HORIZONTAL_PAN_GESTURE | 0x0001 |
/// | wxTOUCH_VERTICAL_PAN_GESTURE | 0x0002 |
/// | wxTOUCH_PAN_GESTURES | wxTOUCH_VERTICAL_PAN_GESTURE | wxTOUCH_HORIZONTAL_PAN_GESTURE |
/// | wxTOUCH_ZOOM_GESTURE | 0x0004 |
/// | wxTOUCH_ROTATE_GESTURE | 0x0008 |
/// | wxTOUCH_PRESS_GESTURES | 0x0010 |
/// | wxTOUCH_ALL_GESTURES | 0x001f |
/// | wxTOUCH_RAW_EVENTS | 0x0020 |

const int wxCENTRE = 0x0001;
const int wxCENTER = wxCENTRE;
const int wxCENTER_FRAME = 0x0000;
const int wxCENTRE_ON_SCREEN = 0x0002;
const int wxCENTER_ON_SCREEN = wxCENTRE_ON_SCREEN;
const int wxHORIZONTAL = 0x0004;
const int wxVERTICAL = 0x0008;
const int wxBOTH = wxVERTICAL | wxHORIZONTAL;
const int wxORIENTATION_MASK = wxBOTH;
const int wxBG_STYLE_ERASE = 0;
const int wxBG_STYLE_SYSTEM = 1;
const int wxBG_STYLE_PAINT = 2;
const int wxBG_STYLE_TRANSPARENT = 3;
const int wxBORDER_DEFAULT = 0;
const int wxBORDER_NONE = 0x00200000;
const int wxBORDER_STATIC = 0x01000000;
const int wxBORDER_SIMPLE = 0x02000000;
const int wxBORDER_RAISED = 0x04000000;
const int wxBORDER_SUNKEN = 0x08000000;
const int wxBORDER_DOUBLE = 0x10000000;
const int wxBORDER_THEME = wxBORDER_DOUBLE;
const int wxBORDER_MASK = 0x1f200000;
const int wxDEFAULT_CONTROL_BORDER = wxBORDER_SUNKEN;
const int wxVSCROLL = 0x80000000;
const int wxHSCROLL = 0x40000000;
const int wxCAPTION = 0x20000000;
const int wxALWAYS_SHOW_SB = 0x00800000;
const int wxTRANSLUCENT_WINDOW = 0x00100000;
const int wxTAB_TRAVERSAL = 0x00080000;
const int wxWANTS_CHARS = 0x00040000;
const int wxPOPUP_WINDOW = 0x00020000;
const int wxFULL_REPAINT_ON_RESIZE = 0x00010000;
const int wxTOUCH_NONE = 0;
const int wxTOUCH_HORIZONTAL_PAN_GESTURE = 0x0001;
const int wxTOUCH_VERTICAL_PAN_GESTURE = 0x0002;
const int wxTOUCH_PAN_GESTURES = wxTOUCH_VERTICAL_PAN_GESTURE | wxTOUCH_HORIZONTAL_PAN_GESTURE;
const int wxTOUCH_ZOOM_GESTURE = 0x0004;
const int wxTOUCH_ROTATE_GESTURE = 0x0008;
const int wxTOUCH_PRESS_GESTURES = 0x0010;
const int wxTOUCH_ALL_GESTURES = 0x001f;
const int wxTOUCH_RAW_EVENTS = 0x0020;

class WxWindow extends WxEvtHandler {
  WxWindow._defaultConstructor() : super._defaultConstructor();
  WxWindow( WxWindow parent, int id, WxPoint position, WxSize size, int style ) : super._defaultConstructor() {
    nativeHandle = _wxWindowConstructor( parent.nativeHandle, id, position.x, position.y, size.x, size.y, style );
    _postCreation();
    bindVMGetMinSizeEvent( (_) => wxLogError("VM event handler called.") );
  }
  WxWindow.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  int getChildCount( ) {
    return _wxWindowGetChildCount( nativeHandle  );
  }

  WxWindow? getChild( int index ) {
    final returnedNativeHandle = _wxWindowGetChild( nativeHandle, index );
    if (returnedNativeHandle == nullptr) return null;
    WxEvtHandler? eh = _evtHandlerList[returnedNativeHandle];
    if (eh != null) {
      // There already is a Dart class associated with this C++ object
      return eh as WxWindow;
    }
    return wxCreateBestMatchingClassFromWxWindowHandle( returnedNativeHandle );
  }

  WxWindow? getParent( ) {
    final returnedNativeHandle = _wxWindowGetParent( nativeHandle  );
    if (returnedNativeHandle == nullptr) return null;
    WxEvtHandler? eh = _evtHandlerList[returnedNativeHandle];
    if (eh != null) {
      // There already is a Dart class associated with this C++ object
      return eh as WxWindow;
    }
    return wxCreateBestMatchingClassFromWxWindowHandle( returnedNativeHandle );
  }

  bool isTopLevel( ) {
    return _wxWindowIsTopLevel( nativeHandle  );
  }

  WxWindow? findWindow( int id ) {
    final returnedNativeHandle = _wxWindowFindWindow( nativeHandle, id );
    if (returnedNativeHandle == nullptr) return null;
    WxEvtHandler? eh = _evtHandlerList[returnedNativeHandle];
    if (eh != null) {
      // There already is a Dart class associated with this C++ object
      return eh as WxWindow;
    }
    return wxCreateBestMatchingClassFromWxWindowHandle( returnedNativeHandle );
  }

  void reparent( WxWindow window ) {
    _wxWindowReparent( nativeHandle, window.nativeHandle );
  }

  int getId( ) {
    return _wxWindowGetId( nativeHandle  );
  }

  void setLabel( String label ) {
    final labelUtf8 = label.toNativeUtf8();
    _wxWindowSetLabel( nativeHandle, labelUtf8 );
    malloc.free( labelUtf8 );
  }

  String getLabel( ) {
    Pointer<Utf8> ptrReturn = _wxWindowGetLabel( nativeHandle  );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }

  bool hasFlag( int flag ) {
    return _wxWindowHasFlag( nativeHandle, flag );
  }

  int getWindowStyle( ) {
    return _wxWindowGetWindowStyle( nativeHandle  );
  }

  int getWindowStyleFlag( ) {
    return _wxWindowGetWindowStyleFlag( nativeHandle  );
  }

  void setWindowStyle( int style ) {
    _wxWindowSetWindowStyle( nativeHandle, style );
  }

  void setWindowStyleFlag( int style ) {
    _wxWindowSetWindowStyleFlag( nativeHandle, style );
  }

  void enableTouchEvents( int eventsMask ) {
    _wxWindowEnableTouchEvents( nativeHandle, eventsMask );
  }

  bool close( bool force ) {
    return _wxWindowClose( nativeHandle, force );
  }

  bool destroy( ) {
    return _wxWindowDestroy( nativeHandle  );
  }

  void centre( { int direction = wxBOTH } ) {
    _wxWindowCentre( nativeHandle, direction );
  }

  void centreOnParent( { int direction = wxBOTH } ) {
    _wxWindowCentreOnParent( nativeHandle, direction );
  }

  WxSize getSize( ) {
    final WxSizeNative sizeReturn = _wxWindowGetSize( nativeHandle  );
    return WxSize(sizeReturn.x, sizeReturn.y);
  }

  WxSize getVirtualSize( ) {
    final WxSizeNative sizeReturn = _wxWindowGetVirtualSize( nativeHandle  );
    return WxSize(sizeReturn.x, sizeReturn.y);
  }

  WxSize getMinSize( ) {
    final WxSizeNative sizeReturn = _wxWindowGetMinSize( nativeHandle  );
    return WxSize(sizeReturn.x, sizeReturn.y);
  }

  WxSize getMaxClientSize( ) {
    final WxSizeNative sizeReturn = _wxWindowGetMaxClientSize( nativeHandle  );
    return WxSize(sizeReturn.x, sizeReturn.y);
  }

  WxSize getMaxSize( ) {
    final WxSizeNative sizeReturn = _wxWindowGetMaxSize( nativeHandle  );
    return WxSize(sizeReturn.x, sizeReturn.y);
  }

  WxPoint getPosition( ) {
    final WxPointNative pointReturn = _wxWindowGetPosition( nativeHandle  );
    return WxPoint(pointReturn.x, pointReturn.y);
  }

  WxRect getRect( ) {
    final WxRectNative rectReturn = _wxWindowGetRect( nativeHandle  );
    return WxRect(rectReturn.x, rectReturn.y, rectReturn.width, rectReturn.height);
  }

  void invalidateBestSize( ) {
    _wxWindowInvalidateBestSize( nativeHandle  );
  }

  void setSize( WxSize size ) {
    _wxWindowSetSize( nativeHandle, size.x, size.y );
  }

  void setPosition( WxPoint pos ) {
    _wxWindowSetPosition( nativeHandle, pos.x, pos.y );
  }

  void setPositionAndSize( int x, int y, int w, int h ) {
    _wxWindowSetPositionAndSize( nativeHandle, x, y, w, h );
  }

  void setMinSize( WxSize minSize ) {
    _wxWindowSetMinSize( nativeHandle, minSize.x, minSize.y );
  }

  void setClientSize( WxSize size ) {
    _wxWindowSetClientSize( nativeHandle, size.x, size.y );
  }

  void setVirtualSize( WxSize size ) {
    _wxWindowSetVirtualSize( nativeHandle, size.x, size.y );
  }

  WxSize getClientSize( ) {
    final WxSizeNative sizeReturn = _wxWindowGetClientSize( nativeHandle  );
    return WxSize(sizeReturn.x, sizeReturn.y);
  }

  WxRect getClientRect( ) {
    final WxRectNative rectReturn = _wxWindowGetClientRect( nativeHandle  );
    return WxRect(rectReturn.x, rectReturn.y, rectReturn.width, rectReturn.height);
  }

  WxPoint getClientAreaOrigin( ) {
    final WxPointNative pointReturn = _wxWindowGetClientAreaOrigin( nativeHandle  );
    return WxPoint(pointReturn.x, pointReturn.y);
  }

  WxRect getUpdateClientRect( ) {
    final WxRectNative rectReturn = _wxWindowGetUpdateClientRect( nativeHandle  );
    return WxRect(rectReturn.x, rectReturn.y, rectReturn.width, rectReturn.height);
  }

  void lower( ) {
    _wxWindowLower( nativeHandle  );
  }

  void raise( ) {
    _wxWindowRaise( nativeHandle  );
  }

  void hide( ) {
    _wxWindowHide( nativeHandle  );
  }

  void show( { bool show = true } ) {
    _wxWindowShow( nativeHandle, show );
  }

  bool isShown( ) {
    return _wxWindowIsShown( nativeHandle  );
  }

  void disable( ) {
    _wxWindowDisable( nativeHandle  );
  }

  void enable( { bool enable = true } ) {
    _wxWindowEnable( nativeHandle, enable );
  }

  bool isEnabled( ) {
    return _wxWindowIsEnabled( nativeHandle  );
  }

  WxPoint clientToScreen( WxPoint point ) {
    final WxPointNative pointReturn = _wxWindowClientToScreen( nativeHandle, point.x, point.y );
    return WxPoint(pointReturn.x, pointReturn.y);
  }

  WxPoint screenToClient( WxPoint point ) {
    final WxPointNative pointReturn = _wxWindowScreenToClient( nativeHandle, point.x, point.y );
    return WxPoint(pointReturn.x, pointReturn.y);
  }

  WxSize clientToWindowSize( WxSize size ) {
    final WxSizeNative sizeReturn = _wxWindowClientToWindowSize( nativeHandle, size.x, size.y );
    return WxSize(sizeReturn.x, sizeReturn.y);
  }

  WxSize windowToClientSize( WxSize size ) {
    final WxSizeNative sizeReturn = _wxWindowWindowToClientSize( nativeHandle, size.x, size.y );
    return WxSize(sizeReturn.x, sizeReturn.y);
  }

  void fit( ) {
    _wxWindowFit( nativeHandle  );
  }

  void fitInside( ) {
    _wxWindowFitInside( nativeHandle  );
  }

  WxSize sizeFromDIP( WxSize size ) {
    final WxSizeNative sizeReturn = _wxWindowSizeFromDIP( nativeHandle, size.x, size.y );
    return WxSize(sizeReturn.x, sizeReturn.y);
  }

  int fromDIP( int d ) {
    return _wxWindowFromDIP( nativeHandle, d );
  }

  double getDPIScaleFactor( ) {
    return _wxWindowGetDPIScaleFactor( nativeHandle  );
  }

  double getContentScaleFactor( ) {
    return _wxWindowGetContentScaleFactor( nativeHandle  );
  }

  void freeze( ) {
    _wxWindowFreeze( nativeHandle  );
  }

  void thaw( ) {
    _wxWindowThaw( nativeHandle  );
  }

  bool isFrozen( ) {
    return _wxWindowIsFrozen( nativeHandle  );
  }

  void refresh( ) {
    _wxWindowRefresh( nativeHandle  );
  }

  void refreshRect( WxRect rect ) {
    _wxWindowRefreshRect( nativeHandle, rect.x, rect.y, rect.width, rect.height );
  }

  void captureMouse( ) {
    _wxWindowCaptureMouse( nativeHandle  );
  }

  void releaseMouse( ) {
    _wxWindowReleaseMouse( nativeHandle  );
  }

  bool hasCapture( ) {
    return _wxWindowHasCapture( nativeHandle  );
  }

  bool popupMenu( WxMenu menu, { WxPoint pos = wxDefaultPosition } ) {
    return _wxWindowPopupMenu( nativeHandle, menu.nativeHandle, pos.x, pos.y );
  }

  void setCursor( WxCursor? cursor ) {
    _wxWindowSetCursor( nativeHandle, (cursor == null) ? nullptr : cursor.nativeHandle );
  }

  WxCursor? getCursor( ) {
    final returnedNativeHandle = _wxWindowGetCursor( nativeHandle  );
    if (returnedNativeHandle == nullptr) return null;
    return WxCursor.fromHandle( returnedNativeHandle );
  }

  void setFocus( ) {
    _wxWindowSetFocus( nativeHandle  );
  }

  bool hasFocus( ) {
    return _wxWindowHasFocus( nativeHandle  );
  }

  void setCanFocus( bool canFocus ) {
    _wxWindowSetCanFocus( nativeHandle, canFocus );
  }

  void disableFocusFromKeyboard( ) {
    _wxWindowDisableFocusFromKeyboard( nativeHandle  );
  }

  bool acceptsFocus( ) {
    return _wxWindowAcceptsFocus( nativeHandle  );
  }

  bool acceptsFocusFromKeyboard( ) {
    return _wxWindowAcceptsFocusFromKeyboard( nativeHandle  );
  }

  bool acceptsFocusRecursively( ) {
    return _wxWindowAcceptsFocusRecursively( nativeHandle  );
  }

  bool isFocusable( ) {
    return _wxWindowIsFocusable( nativeHandle  );
  }

  bool canAcceptFocusFromKeyboard( ) {
    return _wxWindowCanAcceptFocusFromKeyboard( nativeHandle  );
  }

  bool canAcceptFocus( ) {
    return _wxWindowCanAcceptFocus( nativeHandle  );
  }

  void layout( ) {
    _wxWindowLayout( nativeHandle  );
  }

  void setSizer( WxSizer sizer, { bool deleteOld = true } ) {
    _wxWindowSetSizer( nativeHandle, sizer.nativeHandle, deleteOld );
  }

  WxSizer? getSizer( ) {
    final returnedNativeHandle = _wxWindowGetSizer( nativeHandle  );
    if (returnedNativeHandle == nullptr) return null;
    return WxSizer.fromHandle( returnedNativeHandle );
  }

  void setSizerAndFit( WxSizer sizer, { bool deleteOld = true } ) {
    _wxWindowSetSizerAndFit( nativeHandle, sizer.nativeHandle, deleteOld );
  }

  void setForegroundColour( WxColour colour ) {
    _wxWindowSetForegroundColour( nativeHandle, colour.getRGBA() );
  }

  WxColour getForegroundColour( ) {
    final int rgba = _wxWindowGetForegroundColour( nativeHandle  );
    return WxColour.fromRGBA( rgba );
  }

  bool useForegroundColour( ) {
    return _wxWindowUseForegroundColour( nativeHandle  );
  }

  void setBackgroundColour( WxColour colour ) {
    _wxWindowSetBackgroundColour( nativeHandle, colour.getRGBA() );
  }

  WxColour getBackgroundColour( ) {
    final int rgba = _wxWindowGetBackgroundColour( nativeHandle  );
    return WxColour.fromRGBA( rgba );
  }

  bool useBackgroundColour( ) {
    return _wxWindowUseBackgroundColour( nativeHandle  );
  }

  void setBackgroundStyle( int style ) {
    _wxWindowSetBackgroundStyle( nativeHandle, style );
  }

  int getBackgroundStyle( ) {
    return _wxWindowGetBackgroundStyle( nativeHandle  );
  }

  WxSize getTextExtent( String text ) {
    final textUtf8 = text.toNativeUtf8();
    final WxSizeNative sizeReturn = _wxWindowGetTextExtent( nativeHandle, textUtf8 );
    malloc.free( textUtf8 );
    return WxSize(sizeReturn.x, sizeReturn.y);
  }

  void setFont( WxFont? font ) {
    _wxWindowSetFont( nativeHandle, (font == null) ? nullptr : font.nativeHandle );
  }

  void setToolTip( String tip ) {
    final tipUtf8 = tip.toNativeUtf8();
    _wxWindowSetToolTip( nativeHandle, tipUtf8 );
    malloc.free( tipUtf8 );
  }

  void unsetToolTip( ) {
    _wxWindowUnsetToolTip( nativeHandle  );
  }

  String getToolTipText( ) {
    Pointer<Utf8> ptrReturn = _wxWindowGetToolTipText( nativeHandle  );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }

  void setDropTarget( WxDropTarget? target ) {
    _wxWindowSetDropTarget( nativeHandle, (target == null) ? nullptr : target.nativeHandle );
  }
}

// ------------------------- wxPanel ----------------------

typedef _WxPanelConstructorNative = Pointer Function( Pointer, Int32, Int32, Int32, Int32, Int32, Int32  );
typedef _WxPanelConstructor = Pointer Function( Pointer, int, int, int, int, int, int  );
late _WxPanelConstructor _wxPanelConstructor;

typedef _WxPanelSetFocusIgnoringChildrenNative = Void Function( Pointer  );
typedef _WxPanelSetFocusIgnoringChildren = void Function( Pointer  );
late _WxPanelSetFocusIgnoringChildren _wxPanelSetFocusIgnoringChildren;

typedef _WxPanelGetMinSizeNative = WxSizeNative Function( Pointer  );
typedef _WxPanelGetMinSize = WxSizeNative Function( Pointer  );
late _WxPanelGetMinSize _wxPanelGetMinSize;

class WxPanel extends WxWindow {
  WxPanel( WxWindow parent, int id, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = wxTAB_TRAVERSAL } ) : super._defaultConstructor() {
    nativeHandle = _wxPanelConstructor( parent.nativeHandle, id, pos.x, pos.y, size.x, size.y, style );
    _postCreation();
    bindVMGetMinSizeEvent( (_) => wxLogError("VM event handler called.") );
  }
  WxPanel.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  void setFocusIgnoringChildren( ) {
    _wxPanelSetFocusIgnoringChildren( nativeHandle  );
  }

  WxSize getMinSize( ) {
    final WxSizeNative sizeReturn = _wxPanelGetMinSize( nativeHandle  );
    return WxSize(sizeReturn.x, sizeReturn.y);
  }
}

// ------------------------- wxScrolledWindow ----------------------

typedef _WxScrolledWindowConstructorNative = Pointer Function( Pointer, Int32, Int32, Int32, Int32, Int32, Int32  );
typedef _WxScrolledWindowConstructor = Pointer Function( Pointer, int, int, int, int, int, int  );
late _WxScrolledWindowConstructor _wxScrolledWindowConstructor;

typedef _WxScrolledWindowGetMinSizeNative = WxSizeNative Function( Pointer  );
typedef _WxScrolledWindowGetMinSize = WxSizeNative Function( Pointer  );
late _WxScrolledWindowGetMinSize _wxScrolledWindowGetMinSize;

typedef _WxScrolledWindowSetTargetWindowNative = Void Function( Pointer, Pointer  );
typedef _WxScrolledWindowSetTargetWindow = void Function( Pointer, Pointer  );
late _WxScrolledWindowSetTargetWindow _wxScrolledWindowSetTargetWindow;

typedef _WxScrolledWindowScrollNative = Void Function( Pointer, Int32, Int32  );
typedef _WxScrolledWindowScroll = void Function( Pointer, int, int  );
late _WxScrolledWindowScroll _wxScrolledWindowScroll;

typedef _WxScrolledWindowScrollPixelsNative = Void Function( Pointer, Int32, Int32  );
typedef _WxScrolledWindowScrollPixels = void Function( Pointer, int, int  );
late _WxScrolledWindowScrollPixels _wxScrolledWindowScrollPixels;

typedef _WxScrolledWindowGetViewStartNative = WxPointNative Function( Pointer  );
typedef _WxScrolledWindowGetViewStart = WxPointNative Function( Pointer  );
late _WxScrolledWindowGetViewStart _wxScrolledWindowGetViewStart;

typedef _WxScrolledWindowGetViewStartPixelsNative = WxPointNative Function( Pointer  );
typedef _WxScrolledWindowGetViewStartPixels = WxPointNative Function( Pointer  );
late _WxScrolledWindowGetViewStartPixels _wxScrolledWindowGetViewStartPixels;

typedef _WxScrolledWindowSetScrollRateNative = Void Function( Pointer, Int32, Int32  );
typedef _WxScrolledWindowSetScrollRate = void Function( Pointer, int, int  );
late _WxScrolledWindowSetScrollRate _wxScrolledWindowSetScrollRate;

typedef _WxScrolledWindowSetScrollbarsNative = Void Function( Pointer, Int32, Int32, Int32, Int32, Int32, Int32  );
typedef _WxScrolledWindowSetScrollbars = void Function( Pointer, int, int, int, int, int, int  );
late _WxScrolledWindowSetScrollbars _wxScrolledWindowSetScrollbars;

typedef _WxScrolledWindowGetScrollPixelsPerUnitXNative = Int32 Function( Pointer  );
typedef _WxScrolledWindowGetScrollPixelsPerUnitX = int Function( Pointer  );
late _WxScrolledWindowGetScrollPixelsPerUnitX _wxScrolledWindowGetScrollPixelsPerUnitX;

typedef _WxScrolledWindowGetScrollPixelsPerUnitYNative = Int32 Function( Pointer  );
typedef _WxScrolledWindowGetScrollPixelsPerUnitY = int Function( Pointer  );
late _WxScrolledWindowGetScrollPixelsPerUnitY _wxScrolledWindowGetScrollPixelsPerUnitY;

typedef _WxScrolledWindowCalcScrolledPositionNative = WxPointNative Function( Pointer, Int32, Int32  );
typedef _WxScrolledWindowCalcScrolledPosition = WxPointNative Function( Pointer, int, int  );
late _WxScrolledWindowCalcScrolledPosition _wxScrolledWindowCalcScrolledPosition;

typedef _WxScrolledWindowCalcUnscrolledPositionNative = WxPointNative Function( Pointer, Int32, Int32  );
typedef _WxScrolledWindowCalcUnscrolledPosition = WxPointNative Function( Pointer, int, int  );
late _WxScrolledWindowCalcUnscrolledPosition _wxScrolledWindowCalcUnscrolledPosition;

typedef _WxScrolledWindowDoPrepareDCNative = Void Function( Pointer, Pointer  );
typedef _WxScrolledWindowDoPrepareDC = void Function( Pointer, Pointer  );
late _WxScrolledWindowDoPrepareDC _wxScrolledWindowDoPrepareDC;

class WxScrolledWindow extends WxWindow {
  WxScrolledWindow._defaultConstructor() : super._defaultConstructor();
  WxScrolledWindow( WxWindow parent, int id, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = 0 } ) : super._defaultConstructor() {
    nativeHandle = _wxScrolledWindowConstructor( parent.nativeHandle, id, pos.x, pos.y, size.x, size.y, style );
    _postCreation();
    bindVMGetMinSizeEvent( (_) => wxLogError("VM event handler called.") );
  }
  WxScrolledWindow.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  WxSize getMinSize( ) {
    final WxSizeNative sizeReturn = _wxScrolledWindowGetMinSize( nativeHandle  );
    return WxSize(sizeReturn.x, sizeReturn.y);
  }

  void setTargetWindow( WxWindow target ) {
    _wxScrolledWindowSetTargetWindow( nativeHandle, target.nativeHandle );
  }

  void scroll( int x, int y ) {
    _wxScrolledWindowScroll( nativeHandle, x, y );
  }

  void scrollPixels( int x, int y ) {
    _wxScrolledWindowScrollPixels( nativeHandle, x, y );
  }

  WxPoint getViewStart( ) {
    final WxPointNative pointReturn = _wxScrolledWindowGetViewStart( nativeHandle  );
    return WxPoint(pointReturn.x, pointReturn.y);
  }

  WxPoint getViewStartPixels( ) {
    final WxPointNative pointReturn = _wxScrolledWindowGetViewStartPixels( nativeHandle  );
    return WxPoint(pointReturn.x, pointReturn.y);
  }

  void setScrollRate( int xstep, int ystep ) {
    _wxScrolledWindowSetScrollRate( nativeHandle, xstep, ystep );
  }

  void setScrollbars( int pixelsPerUnitX, int pixelsPerUnitY, int noUnitsX, int noUnitsY, { int xPos = 0, int yPos = 0 } ) {
    _wxScrolledWindowSetScrollbars( nativeHandle, pixelsPerUnitX, pixelsPerUnitY, noUnitsX, noUnitsY, xPos, yPos );
  }

  int getScrollPixelsPerUnitX( ) {
    return _wxScrolledWindowGetScrollPixelsPerUnitX( nativeHandle  );
  }

  int getScrollPixelsPerUnitY( ) {
    return _wxScrolledWindowGetScrollPixelsPerUnitY( nativeHandle  );
  }

  WxPoint calcScrolledPosition( WxPoint pos ) {
    final WxPointNative pointReturn = _wxScrolledWindowCalcScrolledPosition( nativeHandle, pos.x, pos.y );
    return WxPoint(pointReturn.x, pointReturn.y);
  }

  WxPoint calcUnscrolledPosition( WxPoint pos ) {
    final WxPointNative pointReturn = _wxScrolledWindowCalcUnscrolledPosition( nativeHandle, pos.x, pos.y );
    return WxPoint(pointReturn.x, pointReturn.y);
  }

  void doPrepareDC( WxDC dc ) {
    _wxScrolledWindowDoPrepareDC( nativeHandle, dc.nativeHandle );
  }
}

// ------------------------- wxNonOwnedWindow ----------------------

typedef _WxNonOwnedWindowIsBeingDeletedNative = Bool Function( Pointer  );
typedef _WxNonOwnedWindowIsBeingDeleted = bool Function( Pointer  );
late _WxNonOwnedWindowIsBeingDeleted _wxNonOwnedWindowIsBeingDeleted;

class WxNonOwnedWindow extends WxWindow {
  WxNonOwnedWindow._defaultConstructor() : super._defaultConstructor();
  WxNonOwnedWindow.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  bool isBeingDeleted( ) {
    return _wxNonOwnedWindowIsBeingDeleted( nativeHandle  );
  }
}

// ------------------------- wxPopupWindow ----------------------

typedef _WxPopupWindowConstructorNative = Pointer Function( Pointer, Int32  );
typedef _WxPopupWindowConstructor = Pointer Function( Pointer, int  );
late _WxPopupWindowConstructor _wxPopupWindowConstructor;

typedef _WxPopupWindowPositionNative = Void Function( Pointer, Int32, Int32, Int32, Int32  );
typedef _WxPopupWindowPosition = void Function( Pointer, int, int, int, int  );
late _WxPopupWindowPosition _wxPopupWindowPosition;

/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxPU_CONTAINS_CONTROLS | 0x0001 |

const int wxPU_CONTAINS_CONTROLS = 0x0001;

class WxPopupWindow extends WxNonOwnedWindow {
  WxPopupWindow._defaultConstructor() : super._defaultConstructor();
  WxPopupWindow( WxWindow parent, { int flags = wxBORDER_NONE } ) : super._defaultConstructor() {
    nativeHandle = _wxPopupWindowConstructor( parent.nativeHandle, flags );
    _postCreation();
  }
  WxPopupWindow.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  void position( WxPoint origin, WxSize size ) {
    _wxPopupWindowPosition( nativeHandle, origin.x, origin.y, size.x, size.y );
  }
}

// ------------------------- wxPopupTransientWindow ----------------------

typedef _WxPopupTransientWindowConstructorNative = Pointer Function( Pointer, Int32  );
typedef _WxPopupTransientWindowConstructor = Pointer Function( Pointer, int  );
late _WxPopupTransientWindowConstructor _wxPopupTransientWindowConstructor;

typedef _WxPopupTransientWindowPopupNative = Void Function( Pointer, Pointer  );
typedef _WxPopupTransientWindowPopup = void Function( Pointer, Pointer  );
late _WxPopupTransientWindowPopup _wxPopupTransientWindowPopup;

typedef _WxPopupTransientWindowDismissNative = Void Function( Pointer  );
typedef _WxPopupTransientWindowDismiss = void Function( Pointer  );
late _WxPopupTransientWindowDismiss _wxPopupTransientWindowDismiss;

class WxPopupTransientWindow extends WxPopupWindow {
  WxPopupTransientWindow._defaultConstructor() : super._defaultConstructor();
  WxPopupTransientWindow( WxWindow parent, { int flags = wxBORDER_NONE } ) : super._defaultConstructor() {
    nativeHandle = _wxPopupTransientWindowConstructor( parent.nativeHandle, flags );
    _postCreation();
  }
  WxPopupTransientWindow.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  void popup( WxWindow? focus ) {
    _wxPopupTransientWindowPopup( nativeHandle, (focus == null) ? nullptr : focus.nativeHandle );
  }

  void dismiss( ) {
    _wxPopupTransientWindowDismiss( nativeHandle  );
  }
}

// ------------------------- wxTopLevelWindow ----------------------

typedef _WxTopLevelWindowSetTitleNative = Void Function( Pointer, Pointer<Utf8>  );
typedef _WxTopLevelWindowSetTitle = void Function( Pointer, Pointer<Utf8>  );
late _WxTopLevelWindowSetTitle _wxTopLevelWindowSetTitle;

typedef _WxTopLevelWindowGetTitleNative = Pointer<Utf8> Function( Pointer  );
typedef _WxTopLevelWindowGetTitle = Pointer<Utf8> Function( Pointer  );
late _WxTopLevelWindowGetTitle _wxTopLevelWindowGetTitle;

typedef _WxTopLevelWindowSetMinSizeNative = Void Function( Pointer, Int32, Int32  );
typedef _WxTopLevelWindowSetMinSize = void Function( Pointer, int, int  );
late _WxTopLevelWindowSetMinSize _wxTopLevelWindowSetMinSize;

typedef _WxTopLevelWindowSetMaxSizeNative = Void Function( Pointer, Int32, Int32  );
typedef _WxTopLevelWindowSetMaxSize = void Function( Pointer, int, int  );
late _WxTopLevelWindowSetMaxSize _wxTopLevelWindowSetMaxSize;

typedef _WxTopLevelWindowMaximizeNative = Void Function( Pointer  );
typedef _WxTopLevelWindowMaximize = void Function( Pointer  );
late _WxTopLevelWindowMaximize _wxTopLevelWindowMaximize;

typedef _WxTopLevelWindowRestoreNative = Void Function( Pointer  );
typedef _WxTopLevelWindowRestore = void Function( Pointer  );
late _WxTopLevelWindowRestore _wxTopLevelWindowRestore;

typedef _WxTopLevelWindowIsAlwaysMaximizedNative = Bool Function( Pointer  );
typedef _WxTopLevelWindowIsAlwaysMaximized = bool Function( Pointer  );
late _WxTopLevelWindowIsAlwaysMaximized _wxTopLevelWindowIsAlwaysMaximized;

typedef _WxTopLevelWindowIsFullScreenNative = Bool Function( Pointer  );
typedef _WxTopLevelWindowIsFullScreen = bool Function( Pointer  );
late _WxTopLevelWindowIsFullScreen _wxTopLevelWindowIsFullScreen;

typedef _WxTopLevelWindowShowFullScreenNative = Void Function( Pointer, Bool, Int32  );
typedef _WxTopLevelWindowShowFullScreen = void Function( Pointer, bool, int  );
late _WxTopLevelWindowShowFullScreen _wxTopLevelWindowShowFullScreen;

typedef _WxTopLevelWindowRequestUserAttentionNative = Void Function( Pointer, Int32  );
typedef _WxTopLevelWindowRequestUserAttention = void Function( Pointer, int  );
late _WxTopLevelWindowRequestUserAttention _wxTopLevelWindowRequestUserAttention;

typedef _WxTopLevelWindowEnableFullScreenViewNative = Void Function( Pointer, Bool, Int32  );
typedef _WxTopLevelWindowEnableFullScreenView = void Function( Pointer, bool, int  );
late _WxTopLevelWindowEnableFullScreenView _wxTopLevelWindowEnableFullScreenView;

typedef _WxTopLevelWindowSetContentProtectionNative = Void Function( Pointer, Int32  );
typedef _WxTopLevelWindowSetContentProtection = void Function( Pointer, int  );
late _WxTopLevelWindowSetContentProtection _wxTopLevelWindowSetContentProtection;

typedef _WxTopLevelWindowGetContentProtectionNative = Int32 Function( Pointer  );
typedef _WxTopLevelWindowGetContentProtection = int Function( Pointer  );
late _WxTopLevelWindowGetContentProtection _wxTopLevelWindowGetContentProtection;

typedef _WxTopLevelWindowCanSetTransparentNative = Bool Function( Pointer  );
typedef _WxTopLevelWindowCanSetTransparent = bool Function( Pointer  );
late _WxTopLevelWindowCanSetTransparent _wxTopLevelWindowCanSetTransparent;

typedef _WxTopLevelWindowSetTransparentNative = Void Function( Pointer, Int32  );
typedef _WxTopLevelWindowSetTransparent = void Function( Pointer, int  );
late _WxTopLevelWindowSetTransparent _wxTopLevelWindowSetTransparent;

typedef _WxTopLevelWindowCentreOnScreenNative = Void Function( Pointer, Int32  );
typedef _WxTopLevelWindowCentreOnScreen = void Function( Pointer, int  );
late _WxTopLevelWindowCentreOnScreen _wxTopLevelWindowCentreOnScreen;

typedef _WxTopLevelWindowEnableCloseButtonNative = Bool Function( Pointer, Bool  );
typedef _WxTopLevelWindowEnableCloseButton = bool Function( Pointer, bool  );
late _WxTopLevelWindowEnableCloseButton _wxTopLevelWindowEnableCloseButton;

typedef _WxTopLevelWindowEnableMaximizeButtonNative = Bool Function( Pointer, Bool  );
typedef _WxTopLevelWindowEnableMaximizeButton = bool Function( Pointer, bool  );
late _WxTopLevelWindowEnableMaximizeButton _wxTopLevelWindowEnableMaximizeButton;

typedef _WxTopLevelWindowEnableMinimizeButtonNative = Bool Function( Pointer, Bool  );
typedef _WxTopLevelWindowEnableMinimizeButton = bool Function( Pointer, bool  );
late _WxTopLevelWindowEnableMinimizeButton _wxTopLevelWindowEnableMinimizeButton;

typedef _WxTopLevelWindowGetDefaultItemNative = Pointer Function( Pointer  );
typedef _WxTopLevelWindowGetDefaultItem = Pointer Function( Pointer  );
late _WxTopLevelWindowGetDefaultItem _wxTopLevelWindowGetDefaultItem;

/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxSTAY_ON_TOP | 0x8000 |
/// | wxICONIZE | 0x4000 |
/// | wxMINIMIZE | wxICONIZE |
/// | wxMAXIMIZE | 0x2000 |
/// | wxCLOSE_BOX | 0x1000 |
/// | wxSYSTEM_MENU | 0x0800 |
/// | wxMINIMIZE_BOX | 0x0400 |
/// | wxMAXIMIZE_BOX | 0x0200 |
/// | wxTINY_CAPTION | 0x0080 |
/// | wxRESIZE_BORDER | 0x0040 |
/// | wxFULLSCREEN_NOMENUBAR | 0x0001 |
/// | wxFULLSCREEN_NOTOOLBAR | 0x0002 |
/// | wxFULLSCREEN_NOSTATUSBAR | 0x0004 |
/// | wxFULLSCREEN_NOBORDER | 0x0008 |
/// | wxFULLSCREEN_NOCAPTION | 0x0010 |
/// | wxFULLSCREEN_ALL | wxFULLSCREEN_NOMENUBAR | wxFULLSCREEN_NOTOOLBAR | wxFULLSCREEN_NOSTATUSBAR | wxFULLSCREEN_NOBORDER | wxFULLSCREEN_NOCAPTION |
/// | wxUSER_ATTENTION_INFO | 1 |
/// | wxUSER_ATTENTION_ERROR | 2 |
/// | wxCONTENT_PROTECTION_NONE | 0 |
/// | wxCONTENT_PROTECTION_ENABLED | 1 |

const int wxSTAY_ON_TOP = 0x8000;
const int wxICONIZE = 0x4000;
const int wxMINIMIZE = wxICONIZE;
const int wxMAXIMIZE = 0x2000;
const int wxCLOSE_BOX = 0x1000;
const int wxSYSTEM_MENU = 0x0800;
const int wxMINIMIZE_BOX = 0x0400;
const int wxMAXIMIZE_BOX = 0x0200;
const int wxTINY_CAPTION = 0x0080;
const int wxRESIZE_BORDER = 0x0040;
const int wxFULLSCREEN_NOMENUBAR = 0x0001;
const int wxFULLSCREEN_NOTOOLBAR = 0x0002;
const int wxFULLSCREEN_NOSTATUSBAR = 0x0004;
const int wxFULLSCREEN_NOBORDER = 0x0008;
const int wxFULLSCREEN_NOCAPTION = 0x0010;
const int wxFULLSCREEN_ALL = wxFULLSCREEN_NOMENUBAR | wxFULLSCREEN_NOTOOLBAR | wxFULLSCREEN_NOSTATUSBAR | wxFULLSCREEN_NOBORDER | wxFULLSCREEN_NOCAPTION;
const int wxUSER_ATTENTION_INFO = 1;
const int wxUSER_ATTENTION_ERROR = 2;
const int wxCONTENT_PROTECTION_NONE = 0;
const int wxCONTENT_PROTECTION_ENABLED = 1;

class WxTopLevelWindow extends WxNonOwnedWindow {
  WxTopLevelWindow._defaultConstructor() : super._defaultConstructor();
  WxTopLevelWindow.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  void setTitle( String title ) {
    final titleUtf8 = title.toNativeUtf8();
    _wxTopLevelWindowSetTitle( nativeHandle, titleUtf8 );
    malloc.free( titleUtf8 );
  }

  String getTitle( ) {
    Pointer<Utf8> ptrReturn = _wxTopLevelWindowGetTitle( nativeHandle  );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }

  void setMinSize( WxSize minSize ) {
    _wxTopLevelWindowSetMinSize( nativeHandle, minSize.x, minSize.y );
  }

  void setMaxSize( WxSize maxSize ) {
    _wxTopLevelWindowSetMaxSize( nativeHandle, maxSize.x, maxSize.y );
  }

  void maximize( ) {
    _wxTopLevelWindowMaximize( nativeHandle  );
  }

  void restore( ) {
    _wxTopLevelWindowRestore( nativeHandle  );
  }

  bool isAlwaysMaximized( ) {
    return _wxTopLevelWindowIsAlwaysMaximized( nativeHandle  );
  }

  bool isFullScreen( ) {
    return _wxTopLevelWindowIsFullScreen( nativeHandle  );
  }

  void showFullScreen( { bool enable = true, int flags = wxFULLSCREEN_ALL } ) {
    _wxTopLevelWindowShowFullScreen( nativeHandle, enable, flags );
  }

  void requestUserAttention( { int flags = wxUSER_ATTENTION_INFO } ) {
    _wxTopLevelWindowRequestUserAttention( nativeHandle, flags );
  }

  void enableFullScreenView( { bool enable = true, int flags = wxFULLSCREEN_ALL } ) {
    _wxTopLevelWindowEnableFullScreenView( nativeHandle, enable, flags );
  }

  void setContentProtection( int contentProtection ) {
    _wxTopLevelWindowSetContentProtection( nativeHandle, contentProtection );
  }

  int getContentProtection( ) {
    return _wxTopLevelWindowGetContentProtection( nativeHandle  );
  }

  bool canSetTransparent( ) {
    return _wxTopLevelWindowCanSetTransparent( nativeHandle  );
  }

  void setTransparent( int alpha ) {
    _wxTopLevelWindowSetTransparent( nativeHandle, alpha );
  }

  void centreOnScreen( int direction ) {
    _wxTopLevelWindowCentreOnScreen( nativeHandle, direction );
  }

  bool enableCloseButton( bool enable ) {
    return _wxTopLevelWindowEnableCloseButton( nativeHandle, enable );
  }

  bool enableMaximizeButton( bool enable ) {
    return _wxTopLevelWindowEnableMaximizeButton( nativeHandle, enable );
  }

  bool enableMinimizeButton( bool enable ) {
    return _wxTopLevelWindowEnableMinimizeButton( nativeHandle, enable );
  }

  WxWindow? getDefaultItem( ) {
    final returnedNativeHandle = _wxTopLevelWindowGetDefaultItem( nativeHandle  );
    if (returnedNativeHandle == nullptr) return null;
    WxEvtHandler? eh = _evtHandlerList[returnedNativeHandle];
    if (eh != null) {
      // There already is a Dart class associated with this C++ object
      return eh as WxWindow;
    }
    return wxCreateBestMatchingClassFromWxWindowHandle( returnedNativeHandle );
  }
}

// ------------------------- wxFrame ----------------------

typedef _WxFrameConstructorNative = Pointer Function( Pointer, Int32, Pointer<Utf8>, Int32, Int32, Int32, Int32, Int32  );
typedef _WxFrameConstructor = Pointer Function( Pointer, int, Pointer<Utf8>, int, int, int, int, int  );
late _WxFrameConstructor _wxFrameConstructor;

typedef _WxFrameSetMenuBarNative = Void Function( Pointer, Pointer  );
typedef _WxFrameSetMenuBar = void Function( Pointer, Pointer  );
late _WxFrameSetMenuBar _wxFrameSetMenuBar;

typedef _WxFrameCreateStatusBarNative = Pointer Function( Pointer, Int32  );
typedef _WxFrameCreateStatusBar = Pointer Function( Pointer, int  );
late _WxFrameCreateStatusBar _wxFrameCreateStatusBar;

typedef _WxFrameGetStatusBarNative = Pointer Function( Pointer  );
typedef _WxFrameGetStatusBar = Pointer Function( Pointer  );
late _WxFrameGetStatusBar _wxFrameGetStatusBar;

typedef _WxFrameSetStatusTextNative = Void Function( Pointer, Pointer<Utf8>, Int32  );
typedef _WxFrameSetStatusText = void Function( Pointer, Pointer<Utf8>, int  );
late _WxFrameSetStatusText _wxFrameSetStatusText;

typedef _WxFramePushStatusTextNative = Void Function( Pointer, Pointer<Utf8>, Int32  );
typedef _WxFramePushStatusText = void Function( Pointer, Pointer<Utf8>, int  );
late _WxFramePushStatusText _wxFramePushStatusText;

typedef _WxFramePopStatusTextNative = Void Function( Pointer, Int32  );
typedef _WxFramePopStatusText = void Function( Pointer, int  );
late _WxFramePopStatusText _wxFramePopStatusText;

typedef _WxFrameSetStatusWidthsNative = Void Function( Pointer, Int32, Pointer<Int32>  );
typedef _WxFrameSetStatusWidths = void Function( Pointer, int, Pointer<Int32>  );
late _WxFrameSetStatusWidths _wxFrameSetStatusWidths;

typedef _WxFrameCreateToolBarNative = Pointer Function( Pointer, Int32, Int32  );
typedef _WxFrameCreateToolBar = Pointer Function( Pointer, int, int  );
late _WxFrameCreateToolBar _wxFrameCreateToolBar;

typedef _WxFrameFindItemInMenuBarNative = Pointer Function( Pointer, Int32  );
typedef _WxFrameFindItemInMenuBar = Pointer Function( Pointer, int  );
late _WxFrameFindItemInMenuBar _wxFrameFindItemInMenuBar;

typedef _WxFrameShowInfoBarNative = Void Function( Pointer, Pointer<Utf8>, Int32, Int32, Int32, Pointer<Utf8>  );
typedef _WxFrameShowInfoBar = void Function( Pointer, Pointer<Utf8>, int, int, int, Pointer<Utf8>  );
late _WxFrameShowInfoBar _wxFrameShowInfoBar;

/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxDEFAULT_FRAME_STYLE | (wxSYSTEM_MENU | wxRESIZE_BORDER | wxMINIMIZE_BOX | wxMAXIMIZE_BOX | wxCLOSE_BOX | wxCAPTION | wxCLIP_CHILDREN) |
/// | wxINFOBAR_BOTTOM | 0 |
/// | wxINFOBAR_TOP | 1 |
/// | wxINFOBAR_FLOATING | 2 |

const int wxDEFAULT_FRAME_STYLE = (wxSYSTEM_MENU | wxRESIZE_BORDER | wxMINIMIZE_BOX | wxMAXIMIZE_BOX | wxCLOSE_BOX | wxCAPTION | wxCLIP_CHILDREN);
const int wxINFOBAR_BOTTOM = 0;
const int wxINFOBAR_TOP = 1;
const int wxINFOBAR_FLOATING = 2;

class WxFrame extends WxTopLevelWindow {
  WxFrame._defaultConstructor() : super._defaultConstructor();
  WxFrame( WxWindow? parent, int id, String title, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = wxDEFAULT_FRAME_STYLE } ) : super._defaultConstructor() {
    final titleUtf8 = title.toNativeUtf8();
    nativeHandle = _wxFrameConstructor( (parent == null) ? nullptr : parent.nativeHandle, id, titleUtf8, pos.x, pos.y, size.x, size.y, style );
    malloc.free( titleUtf8 );
    _postCreation();
  }
  WxFrame.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  void setMenuBar( WxMenuBar menubar ) {
    _wxFrameSetMenuBar( nativeHandle, menubar.nativeHandle );
  }

  WxStatusBar createStatusBar( { int number = 1 } ) {
    final returnedNativeHandle = _wxFrameCreateStatusBar( nativeHandle, number );
    WxEvtHandler? eh = _evtHandlerList[returnedNativeHandle];
    if (eh != null) {
      // There already is a Dart class associated with this C++ object
      return eh as WxStatusBar;
    }
    return WxStatusBar.fromHandle( returnedNativeHandle );
  }

  WxStatusBar? getStatusBar( ) {
    final returnedNativeHandle = _wxFrameGetStatusBar( nativeHandle  );
    if (returnedNativeHandle == nullptr) return null;
    WxEvtHandler? eh = _evtHandlerList[returnedNativeHandle];
    if (eh != null) {
      // There already is a Dart class associated with this C++ object
      return eh as WxStatusBar;
    }
    return WxStatusBar.fromHandle( returnedNativeHandle );
  }

  void setStatusText( String text, { int number = 0 } ) {
    final textUtf8 = text.toNativeUtf8();
    _wxFrameSetStatusText( nativeHandle, textUtf8, number );
    malloc.free( textUtf8 );
  }

  void pushStatusText( String text, { int number = 0 } ) {
    final textUtf8 = text.toNativeUtf8();
    _wxFramePushStatusText( nativeHandle, textUtf8, number );
    malloc.free( textUtf8 );
  }

  void popStatusText( { int number = 0 } ) {
    _wxFramePopStatusText( nativeHandle, number );
  }

  void setStatusWidths( List<int> widths ) {
    final Pointer<Int32> widthsptr = malloc.allocate(widths.length * sizeOf<Pointer<Int32>>());
    for (int i = 0; i < widths.length; i++) { widthsptr[i] = widths[i]; }
    _wxFrameSetStatusWidths( nativeHandle, widths.length, widthsptr );
    malloc.free( widthsptr );
  }

  WxToolBar createToolBar( { int style = wxTB_DEFAULT_STYLE, int id = -1 } ) {
    final returnedNativeHandle = _wxFrameCreateToolBar( nativeHandle, style, id );
    WxEvtHandler? eh = _evtHandlerList[returnedNativeHandle];
    if (eh != null) {
      // There already is a Dart class associated with this C++ object
      return eh as WxToolBar;
    }
    return WxToolBar.fromHandle( returnedNativeHandle );
  }

  WxMenuItem? findItemInMenuBar( int menuId ) {
    final returnedNativeHandle = _wxFrameFindItemInMenuBar( nativeHandle, menuId );
    if (returnedNativeHandle == nullptr) return null;
    return WxMenuItem.fromHandle( returnedNativeHandle );
  }

  void showInfoBar( String message, { int duration = 500, int style = wxINFOBAR_BOTTOM, int actionId = -1, String action = '' } ) {
    final messageUtf8 = message.toNativeUtf8();
    final actionUtf8 = action.toNativeUtf8();
    _wxFrameShowInfoBar( nativeHandle, messageUtf8, duration, style, actionId, actionUtf8 );
    malloc.free( messageUtf8 );
    malloc.free( actionUtf8 );
  }
}

// ------------------------- wxStatusBar ----------------------

typedef _WxStatusBarConstructorNative = Pointer Function( Pointer  );
typedef _WxStatusBarConstructor = Pointer Function( Pointer  );
late _WxStatusBarConstructor _wxStatusBarConstructor;

typedef _WxStatusBarSetStatusTextNative = Void Function( Pointer, Pointer<Utf8>, Int32  );
typedef _WxStatusBarSetStatusText = void Function( Pointer, Pointer<Utf8>, int  );
late _WxStatusBarSetStatusText _wxStatusBarSetStatusText;

typedef _WxStatusBarGetStatusTextNative = Pointer<Utf8> Function( Pointer, Int32  );
typedef _WxStatusBarGetStatusText = Pointer<Utf8> Function( Pointer, int  );
late _WxStatusBarGetStatusText _wxStatusBarGetStatusText;

typedef _WxStatusBarSetFieldsCountNative = Void Function( Pointer, Int32  );
typedef _WxStatusBarSetFieldsCount = void Function( Pointer, int  );
late _WxStatusBarSetFieldsCount _wxStatusBarSetFieldsCount;

typedef _WxStatusBarGetFieldsCountNative = Int32 Function( Pointer  );
typedef _WxStatusBarGetFieldsCount = int Function( Pointer  );
late _WxStatusBarGetFieldsCount _wxStatusBarGetFieldsCount;

typedef _WxStatusBarPushStatusTextNative = Void Function( Pointer, Pointer<Utf8>, Int32  );
typedef _WxStatusBarPushStatusText = void Function( Pointer, Pointer<Utf8>, int  );
late _WxStatusBarPushStatusText _wxStatusBarPushStatusText;

typedef _WxStatusBarPopStatusTextNative = Void Function( Pointer, Int32  );
typedef _WxStatusBarPopStatusText = void Function( Pointer, int  );
late _WxStatusBarPopStatusText _wxStatusBarPopStatusText;

typedef _WxStatusBarSetStatusWidthsNative = Void Function( Pointer, Int32, Pointer<Int32>  );
typedef _WxStatusBarSetStatusWidths = void Function( Pointer, int, Pointer<Int32>  );
late _WxStatusBarSetStatusWidths _wxStatusBarSetStatusWidths;

class WxStatusBar extends WxControl {
  WxStatusBar._defaultConstructor() : super._defaultConstructor();
  WxStatusBar( WxWindow parent ) : super._defaultConstructor() {
    nativeHandle = _wxStatusBarConstructor( parent.nativeHandle );
    _postCreation();
  }
  WxStatusBar.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  void setStatusText( String text, { int index = 0 } ) {
    final textUtf8 = text.toNativeUtf8();
    _wxStatusBarSetStatusText( nativeHandle, textUtf8, index );
    malloc.free( textUtf8 );
  }

  String getStatusText( { int index = 0 } ) {
    Pointer<Utf8> ptrReturn = _wxStatusBarGetStatusText( nativeHandle, index );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }

  void setFieldsCount( int count ) {
    _wxStatusBarSetFieldsCount( nativeHandle, count );
  }

  int getFieldsCount( ) {
    return _wxStatusBarGetFieldsCount( nativeHandle  );
  }

  void pushStatusText( String text, { int index = 0 } ) {
    final textUtf8 = text.toNativeUtf8();
    _wxStatusBarPushStatusText( nativeHandle, textUtf8, index );
    malloc.free( textUtf8 );
  }

  void popStatusText( { int index = 0 } ) {
    _wxStatusBarPopStatusText( nativeHandle, index );
  }

  void setStatusWidths( List<int> widths ) {
    final Pointer<Int32> widthsptr = malloc.allocate(widths.length * sizeOf<Pointer<Int32>>());
    for (int i = 0; i < widths.length; i++) { widthsptr[i] = widths[i]; }
    _wxStatusBarSetStatusWidths( nativeHandle, widths.length, widthsptr );
    malloc.free( widthsptr );
  }
}

// ------------------------- wxToolBarToolBase ----------------------

typedef _WxToolBarToolBaseConstructorNative = Pointer Function(  );
typedef _WxToolBarToolBaseConstructor = Pointer Function(  );
late _WxToolBarToolBaseConstructor _wxToolBarToolBaseConstructor;

typedef _WxToolBarToolBaseGetIdNative = Int32 Function( Pointer  );
typedef _WxToolBarToolBaseGetId = int Function( Pointer  );
late _WxToolBarToolBaseGetId _wxToolBarToolBaseGetId;

typedef _WxToolBarToolBaseGetLabelNative = Pointer<Utf8> Function( Pointer  );
typedef _WxToolBarToolBaseGetLabel = Pointer<Utf8> Function( Pointer  );
late _WxToolBarToolBaseGetLabel _wxToolBarToolBaseGetLabel;

typedef _WxToolBarToolBaseGetKindNative = Int32 Function( Pointer  );
typedef _WxToolBarToolBaseGetKind = int Function( Pointer  );
late _WxToolBarToolBaseGetKind _wxToolBarToolBaseGetKind;

typedef _WxToolBarToolBaseIsControlNative = Bool Function( Pointer  );
typedef _WxToolBarToolBaseIsControl = bool Function( Pointer  );
late _WxToolBarToolBaseIsControl _wxToolBarToolBaseIsControl;

typedef _WxToolBarToolBaseIsStretchableNative = Bool Function( Pointer  );
typedef _WxToolBarToolBaseIsStretchable = bool Function( Pointer  );
late _WxToolBarToolBaseIsStretchable _wxToolBarToolBaseIsStretchable;

typedef _WxToolBarToolBaseGetControlNative = Pointer Function( Pointer  );
typedef _WxToolBarToolBaseGetControl = Pointer Function( Pointer  );
late _WxToolBarToolBaseGetControl _wxToolBarToolBaseGetControl;

class WxToolBarToolBase extends WxObject {
  WxToolBarToolBase._defaultConstructor() : super._defaultConstructor();
  WxToolBarToolBase( ) : super._defaultConstructor() {
    nativeHandle = _wxToolBarToolBaseConstructor(  );
    attachFinalizer();
  }
  WxToolBarToolBase.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  int getId( ) {
    return _wxToolBarToolBaseGetId( nativeHandle  );
  }

  String getLabel( ) {
    Pointer<Utf8> ptrReturn = _wxToolBarToolBaseGetLabel( nativeHandle  );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }

  int getKind( ) {
    return _wxToolBarToolBaseGetKind( nativeHandle  );
  }

  bool isControl( ) {
    return _wxToolBarToolBaseIsControl( nativeHandle  );
  }

  bool isStretchable( ) {
    return _wxToolBarToolBaseIsStretchable( nativeHandle  );
  }

  WxControl? getControl( ) {
    final returnedNativeHandle = _wxToolBarToolBaseGetControl( nativeHandle  );
    if (returnedNativeHandle == nullptr) return null;
    WxEvtHandler? eh = _evtHandlerList[returnedNativeHandle];
    if (eh != null) {
      // There already is a Dart class associated with this C++ object
      return eh as WxControl;
    }
    return WxControl.fromHandle( returnedNativeHandle );
  }
}

// ------------------------- wxToolBar ----------------------

typedef _WxToolBarConstructorNative = Pointer Function( Pointer, Int32, Int32, Int32, Int32, Int32, Int32  );
typedef _WxToolBarConstructor = Pointer Function( Pointer, int, int, int, int, int, int  );
late _WxToolBarConstructor _wxToolBarConstructor;

typedef _WxToolBarRealizeNative = Bool Function( Pointer  );
typedef _WxToolBarRealize = bool Function( Pointer  );
late _WxToolBarRealize _wxToolBarRealize;

typedef _WxToolBarAddSeparatorNative = Pointer Function( Pointer  );
typedef _WxToolBarAddSeparator = Pointer Function( Pointer  );
late _WxToolBarAddSeparator _wxToolBarAddSeparator;

typedef _WxToolBarInsertSeparatorNative = Pointer Function( Pointer, Int32  );
typedef _WxToolBarInsertSeparator = Pointer Function( Pointer, int  );
late _WxToolBarInsertSeparator _wxToolBarInsertSeparator;

typedef _WxToolBarAddStretchableSpaceNative = Pointer Function( Pointer  );
typedef _WxToolBarAddStretchableSpace = Pointer Function( Pointer  );
late _WxToolBarAddStretchableSpace _wxToolBarAddStretchableSpace;

typedef _WxToolBarInsertStretchableSpaceNative = Pointer Function( Pointer, Int32  );
typedef _WxToolBarInsertStretchableSpace = Pointer Function( Pointer, int  );
late _WxToolBarInsertStretchableSpace _wxToolBarInsertStretchableSpace;

typedef _WxToolBarAddToolNative = Pointer Function( Pointer, Int32, Pointer<Utf8>, Pointer, Pointer<Utf8>, Int32  );
typedef _WxToolBarAddTool = Pointer Function( Pointer, int, Pointer<Utf8>, Pointer, Pointer<Utf8>, int  );
late _WxToolBarAddTool _wxToolBarAddTool;

typedef _WxToolBarInsertToolNative = Pointer Function( Pointer, Int32, Int32, Pointer<Utf8>, Pointer, Pointer, Int32, Pointer<Utf8>  );
typedef _WxToolBarInsertTool = Pointer Function( Pointer, int, int, Pointer<Utf8>, Pointer, Pointer, int, Pointer<Utf8>  );
late _WxToolBarInsertTool _wxToolBarInsertTool;

typedef _WxToolBarAddCheckToolNative = Pointer Function( Pointer, Int32, Pointer<Utf8>, Pointer, Pointer, Pointer<Utf8>  );
typedef _WxToolBarAddCheckTool = Pointer Function( Pointer, int, Pointer<Utf8>, Pointer, Pointer, Pointer<Utf8>  );
late _WxToolBarAddCheckTool _wxToolBarAddCheckTool;

typedef _WxToolBarAddRadioToolNative = Pointer Function( Pointer, Int32, Pointer<Utf8>, Pointer, Pointer, Pointer<Utf8>  );
typedef _WxToolBarAddRadioTool = Pointer Function( Pointer, int, Pointer<Utf8>, Pointer, Pointer, Pointer<Utf8>  );
late _WxToolBarAddRadioTool _wxToolBarAddRadioTool;

typedef _WxToolBarAddControlNative = Pointer Function( Pointer, Pointer, Pointer<Utf8>  );
typedef _WxToolBarAddControl = Pointer Function( Pointer, Pointer, Pointer<Utf8>  );
late _WxToolBarAddControl _wxToolBarAddControl;

typedef _WxToolBarInsertControlNative = Pointer Function( Pointer, Int32, Pointer, Pointer<Utf8>  );
typedef _WxToolBarInsertControl = Pointer Function( Pointer, int, Pointer, Pointer<Utf8>  );
late _WxToolBarInsertControl _wxToolBarInsertControl;

typedef _WxToolBarClearToolsNative = Void Function( Pointer  );
typedef _WxToolBarClearTools = void Function( Pointer  );
late _WxToolBarClearTools _wxToolBarClearTools;

typedef _WxToolBarDeleteToolNative = Bool Function( Pointer, Int32  );
typedef _WxToolBarDeleteTool = bool Function( Pointer, int  );
late _WxToolBarDeleteTool _wxToolBarDeleteTool;

typedef _WxToolBarEnableToolNative = Void Function( Pointer, Int32, Bool  );
typedef _WxToolBarEnableTool = void Function( Pointer, int, bool  );
late _WxToolBarEnableTool _wxToolBarEnableTool;

typedef _WxToolBarGetToolEnabledNative = Bool Function( Pointer, Int32  );
typedef _WxToolBarGetToolEnabled = bool Function( Pointer, int  );
late _WxToolBarGetToolEnabled _wxToolBarGetToolEnabled;

typedef _WxToolBarGetToolShortHelpNative = Pointer<Utf8> Function( Pointer, Int32  );
typedef _WxToolBarGetToolShortHelp = Pointer<Utf8> Function( Pointer, int  );
late _WxToolBarGetToolShortHelp _wxToolBarGetToolShortHelp;

typedef _WxToolBarGetToolsCountNative = Int32 Function( Pointer  );
typedef _WxToolBarGetToolsCount = int Function( Pointer  );
late _WxToolBarGetToolsCount _wxToolBarGetToolsCount;

typedef _WxToolBarGetToolPosNative = Int32 Function( Pointer, Int32  );
typedef _WxToolBarGetToolPos = int Function( Pointer, int  );
late _WxToolBarGetToolPos _wxToolBarGetToolPos;

typedef _WxToolBarGetToolByPosNative = Pointer Function( Pointer, Int32  );
typedef _WxToolBarGetToolByPos = Pointer Function( Pointer, int  );
late _WxToolBarGetToolByPos _wxToolBarGetToolByPos;

typedef _WxToolBarFindByIdNative = Pointer Function( Pointer, Int32  );
typedef _WxToolBarFindById = Pointer Function( Pointer, int  );
late _WxToolBarFindById _wxToolBarFindById;

typedef _WxToolBarSetToolSeparationNative = Void Function( Pointer, Int32  );
typedef _WxToolBarSetToolSeparation = void Function( Pointer, int  );
late _WxToolBarSetToolSeparation _wxToolBarSetToolSeparation;

typedef _WxToolBarSetToolPackingNative = Void Function( Pointer, Int32  );
typedef _WxToolBarSetToolPacking = void Function( Pointer, int  );
late _WxToolBarSetToolPacking _wxToolBarSetToolPacking;

typedef _WxToolBarGetToolStateNative = Int32 Function( Pointer, Int32  );
typedef _WxToolBarGetToolState = int Function( Pointer, int  );
late _WxToolBarGetToolState _wxToolBarGetToolState;

typedef _WxToolBarToggleToolNative = Void Function( Pointer, Int32, Bool  );
typedef _WxToolBarToggleTool = void Function( Pointer, int, bool  );
late _WxToolBarToggleTool _wxToolBarToggleTool;

typedef _WxToolBarSetDropdownMenuNative = Void Function( Pointer, Int32, Pointer  );
typedef _WxToolBarSetDropdownMenu = void Function( Pointer, int, Pointer  );
late _WxToolBarSetDropdownMenu _wxToolBarSetDropdownMenu;

/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxITEM_SEPARATOR | -1 |
/// | wxITEM_NORMAL | 0 |
/// | wxITEM_CHECK | 1 |
/// | wxITEM_RADIO | 2 |
/// | wxITEM_DROPDOWN | 3 |
/// | wxITEM_MAX | 4 |
/// | wxTB_FLAT | 0x0020 |
/// | wxTB_DOCKABLE | 0x0040 |
/// | wxTB_HORIZONTAL | wxHORIZONTAL |
/// | wxTB_NOICONS | 0x0080 |
/// | wxTB_TEXT | 0x0100 |
/// | wxTB_DEFAULT_STYLE | wxHORIZONTAL |

const int wxITEM_SEPARATOR = -1;
const int wxITEM_NORMAL = 0;
const int wxITEM_CHECK = 1;
const int wxITEM_RADIO = 2;
const int wxITEM_DROPDOWN = 3;
const int wxITEM_MAX = 4;
const int wxTB_FLAT = 0x0020;
const int wxTB_DOCKABLE = 0x0040;
const int wxTB_HORIZONTAL = wxHORIZONTAL;
const int wxTB_NOICONS = 0x0080;
const int wxTB_TEXT = 0x0100;
const int wxTB_DEFAULT_STYLE = wxHORIZONTAL;

class WxToolBar extends WxControl {
  WxToolBar._defaultConstructor() : super._defaultConstructor();
  WxToolBar( WxWindow parent, int id, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = wxTB_HORIZONTAL } ) : super._defaultConstructor() {
    nativeHandle = _wxToolBarConstructor( parent.nativeHandle, id, pos.x, pos.y, size.x, size.y, style );
    _postCreation();
  }
  WxToolBar.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  bool realize( ) {
    return _wxToolBarRealize( nativeHandle  );
  }

  WxToolBarToolBase addSeparator( ) {
    final returnedNativeHandle = _wxToolBarAddSeparator( nativeHandle  );
    return WxToolBarToolBase.fromHandle( returnedNativeHandle );
  }

  WxToolBarToolBase insertSeparator( int pos ) {
    final returnedNativeHandle = _wxToolBarInsertSeparator( nativeHandle, pos );
    return WxToolBarToolBase.fromHandle( returnedNativeHandle );
  }

  WxToolBarToolBase addStretchableSpace( ) {
    final returnedNativeHandle = _wxToolBarAddStretchableSpace( nativeHandle  );
    return WxToolBarToolBase.fromHandle( returnedNativeHandle );
  }

  WxToolBarToolBase insertStretchableSpace( int pos ) {
    final returnedNativeHandle = _wxToolBarInsertStretchableSpace( nativeHandle, pos );
    return WxToolBarToolBase.fromHandle( returnedNativeHandle );
  }

  WxToolBarToolBase addTool( int id, String label, WxBitmapBundle? bitmap, { String shortHelp = "", int kind = wxITEM_NORMAL } ) {
    final labelUtf8 = label.toNativeUtf8();
    final shortHelpUtf8 = shortHelp.toNativeUtf8();
    final returnedNativeHandle = _wxToolBarAddTool( nativeHandle, id, labelUtf8, (bitmap == null) ? nullptr : bitmap.nativeHandle, shortHelpUtf8, kind );
    return WxToolBarToolBase.fromHandle( returnedNativeHandle );
  }

  WxToolBarToolBase insertTool( int pos, int id, String label, WxBitmapBundle? bitmap, WxBitmapBundle? bmpDisabled, { int kind = wxITEM_NORMAL, String shortHelp = "" } ) {
    final labelUtf8 = label.toNativeUtf8();
    final shortHelpUtf8 = shortHelp.toNativeUtf8();
    final returnedNativeHandle = _wxToolBarInsertTool( nativeHandle, pos, id, labelUtf8, (bitmap == null) ? nullptr : bitmap.nativeHandle, (bmpDisabled == null) ? nullptr : bmpDisabled.nativeHandle, kind, shortHelpUtf8 );
    return WxToolBarToolBase.fromHandle( returnedNativeHandle );
  }

  WxToolBarToolBase addCheckTool( int id, String label, WxBitmapBundle? bitmap, WxBitmapBundle? bmpDisabled, { String shortHelp = "" } ) {
    final labelUtf8 = label.toNativeUtf8();
    final shortHelpUtf8 = shortHelp.toNativeUtf8();
    final returnedNativeHandle = _wxToolBarAddCheckTool( nativeHandle, id, labelUtf8, (bitmap == null) ? nullptr : bitmap.nativeHandle, (bmpDisabled == null) ? nullptr : bmpDisabled.nativeHandle, shortHelpUtf8 );
    return WxToolBarToolBase.fromHandle( returnedNativeHandle );
  }

  WxToolBarToolBase addRadioTool( int id, String label, WxBitmapBundle? bitmap, WxBitmapBundle? bmpDisabled, { String shortHelp = "" } ) {
    final labelUtf8 = label.toNativeUtf8();
    final shortHelpUtf8 = shortHelp.toNativeUtf8();
    final returnedNativeHandle = _wxToolBarAddRadioTool( nativeHandle, id, labelUtf8, (bitmap == null) ? nullptr : bitmap.nativeHandle, (bmpDisabled == null) ? nullptr : bmpDisabled.nativeHandle, shortHelpUtf8 );
    return WxToolBarToolBase.fromHandle( returnedNativeHandle );
  }

  WxToolBarToolBase addControl( WxControl control, { String label = "" } ) {
    final labelUtf8 = label.toNativeUtf8();
    final returnedNativeHandle = _wxToolBarAddControl( nativeHandle, control.nativeHandle, labelUtf8 );
    return WxToolBarToolBase.fromHandle( returnedNativeHandle );
  }

  WxToolBarToolBase insertControl( int pos, WxControl control, { String label = "" } ) {
    final labelUtf8 = label.toNativeUtf8();
    final returnedNativeHandle = _wxToolBarInsertControl( nativeHandle, pos, control.nativeHandle, labelUtf8 );
    return WxToolBarToolBase.fromHandle( returnedNativeHandle );
  }

  void clearTools( ) {
    _wxToolBarClearTools( nativeHandle  );
  }

  bool deleteTool( int id ) {
    return _wxToolBarDeleteTool( nativeHandle, id );
  }

  void enableTool( int id, { bool enable = true } ) {
    _wxToolBarEnableTool( nativeHandle, id, enable );
  }

  bool getToolEnabled( int id ) {
    return _wxToolBarGetToolEnabled( nativeHandle, id );
  }

  String getToolShortHelp( int id ) {
    Pointer<Utf8> ptrReturn = _wxToolBarGetToolShortHelp( nativeHandle, id );
    final String textReturn = ptrReturn.toDartString();
    malloc.free( ptrReturn );
    return textReturn;
  }

  int getToolsCount( ) {
    return _wxToolBarGetToolsCount( nativeHandle  );
  }

  int getToolPos( int id ) {
    return _wxToolBarGetToolPos( nativeHandle, id );
  }

  WxToolBarToolBase? getToolByPos( int pos ) {
    final returnedNativeHandle = _wxToolBarGetToolByPos( nativeHandle, pos );
    if (returnedNativeHandle == nullptr) return null;
    return WxToolBarToolBase.fromHandle( returnedNativeHandle );
  }

  WxToolBarToolBase? findById( int id ) {
    final returnedNativeHandle = _wxToolBarFindById( nativeHandle, id );
    if (returnedNativeHandle == nullptr) return null;
    return WxToolBarToolBase.fromHandle( returnedNativeHandle );
  }

  void setToolSeparation( int separation ) {
    _wxToolBarSetToolSeparation( nativeHandle, separation );
  }

  void setToolPacking( int packing ) {
    _wxToolBarSetToolPacking( nativeHandle, packing );
  }

  int getToolState( int id ) {
    return _wxToolBarGetToolState( nativeHandle, id );
  }

  void toggleTool( int id, { bool toggle = true } ) {
    _wxToolBarToggleTool( nativeHandle, id, toggle );
  }

  void setDropdownMenu( int id, WxMenu menu ) {
    _wxToolBarSetDropdownMenu( nativeHandle, id, menu.nativeHandle );
  }
}

// ------------------------- wxDialog ----------------------

typedef _WxDialogConstructorNative = Pointer Function( Pointer, Int32, Pointer<Utf8>, Int32, Int32, Int32, Int32, Int32  );
typedef _WxDialogConstructor = Pointer Function( Pointer, int, Pointer<Utf8>, int, int, int, int, int  );
late _WxDialogConstructor _wxDialogConstructor;

typedef _WxDialogCreateButtonSizerNative = Pointer Function( Pointer, Int32  );
typedef _WxDialogCreateButtonSizer = Pointer Function( Pointer, int  );
late _WxDialogCreateButtonSizer _wxDialogCreateButtonSizer;

typedef _WxDialogCreateSeparatedButtonSizerNative = Pointer Function( Pointer, Int32  );
typedef _WxDialogCreateSeparatedButtonSizer = Pointer Function( Pointer, int  );
late _WxDialogCreateSeparatedButtonSizer _wxDialogCreateSeparatedButtonSizer;

typedef _WxDialogCreateSeparatedSizerNative = Pointer Function( Pointer, Pointer  );
typedef _WxDialogCreateSeparatedSizer = Pointer Function( Pointer, Pointer  );
late _WxDialogCreateSeparatedSizer _wxDialogCreateSeparatedSizer;

typedef _WxDialogCreateStdDialogButtonSizerNative = Pointer Function( Pointer, Int32  );
typedef _WxDialogCreateStdDialogButtonSizer = Pointer Function( Pointer, int  );
late _WxDialogCreateStdDialogButtonSizer _wxDialogCreateStdDialogButtonSizer;

typedef _WxDialogCreateTextSizerNative = Pointer Function( Pointer, Pointer<Utf8>  );
typedef _WxDialogCreateTextSizer = Pointer Function( Pointer, Pointer<Utf8>  );
late _WxDialogCreateTextSizer _wxDialogCreateTextSizer;

typedef _WxDialogEndModalNative = Void Function( Pointer, Int32  );
typedef _WxDialogEndModal = void Function( Pointer, int  );
late _WxDialogEndModal _wxDialogEndModal;

typedef _WxDialog_showModalSyncNative = Int32 Function( Pointer  );
typedef _WxDialog_showModalSync = int Function( Pointer  );
late _WxDialog_showModalSync _wxDialog_showModalSync;

typedef _WxDialogGetReturnCodeNative = Int32 Function( Pointer  );
typedef _WxDialogGetReturnCode = int Function( Pointer  );
late _WxDialogGetReturnCode _wxDialogGetReturnCode;

typedef _WxDialogGetEscapeIdNative = Int32 Function( Pointer  );
typedef _WxDialogGetEscapeId = int Function( Pointer  );
late _WxDialogGetEscapeId _wxDialogGetEscapeId;

typedef _WxDialogSetEscapeIdNative = Void Function( Pointer, Int32  );
typedef _WxDialogSetEscapeId = void Function( Pointer, int  );
late _WxDialogSetEscapeId _wxDialogSetEscapeId;

typedef _WxDialogGetAffirmativeIdNative = Int32 Function( Pointer  );
typedef _WxDialogGetAffirmativeId = int Function( Pointer  );
late _WxDialogGetAffirmativeId _wxDialogGetAffirmativeId;

typedef _WxDialogSetAffirmativeIdNative = Void Function( Pointer, Int32  );
typedef _WxDialogSetAffirmativeId = void Function( Pointer, int  );
late _WxDialogSetAffirmativeId _wxDialogSetAffirmativeId;

class WxDialog extends WxTopLevelWindow {
  WxDialog._defaultConstructor() : super._defaultConstructor();
  WxDialog( WxWindow? parent, int id, String title, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = wxDEFAULT_DIALOG_STYLE } ) : super._defaultConstructor() {
    final titleUtf8 = title.toNativeUtf8();
    nativeHandle = _wxDialogConstructor( (parent == null) ? nullptr : parent.nativeHandle, id, titleUtf8, pos.x, pos.y, size.x, size.y, style );
    malloc.free( titleUtf8 );
    _postCreation();
  }
  WxDialog.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  void showModal( void Function( int, dynamic )? onReturn )
  {
    int ret = _showModalSync();
    if (onReturn != null) {
      onReturn( ret, null );
    }
    destroy();
  }

  WxSizer createButtonSizer( int flags ) {
    final returnedNativeHandle = _wxDialogCreateButtonSizer( nativeHandle, flags );
    return WxSizer.fromHandle( returnedNativeHandle );
  }

  WxSizer createSeparatedButtonSizer( int flags ) {
    final returnedNativeHandle = _wxDialogCreateSeparatedButtonSizer( nativeHandle, flags );
    return WxSizer.fromHandle( returnedNativeHandle );
  }

  WxSizer createSeparatedSizer( WxSizer sizer ) {
    final returnedNativeHandle = _wxDialogCreateSeparatedSizer( nativeHandle, sizer.nativeHandle );
    return WxSizer.fromHandle( returnedNativeHandle );
  }

  WxSizer createStdDialogButtonSizer( int flags ) {
    final returnedNativeHandle = _wxDialogCreateStdDialogButtonSizer( nativeHandle, flags );
    return WxSizer.fromHandle( returnedNativeHandle );
  }

  WxSizer createTextSizer( String message ) {
    final messageUtf8 = message.toNativeUtf8();
    final returnedNativeHandle = _wxDialogCreateTextSizer( nativeHandle, messageUtf8 );
    return WxSizer.fromHandle( returnedNativeHandle );
  }

  void endModal( int retCode ) {
    _wxDialogEndModal( nativeHandle, retCode );
  }

  int _showModalSync( ) {
    return _wxDialog_showModalSync( nativeHandle  );
  }

  int getReturnCode( ) {
    return _wxDialogGetReturnCode( nativeHandle  );
  }

  int getEscapeId( ) {
    return _wxDialogGetEscapeId( nativeHandle  );
  }

  void setEscapeId( int id ) {
    _wxDialogSetEscapeId( nativeHandle, id );
  }

  int getAffirmativeId( ) {
    return _wxDialogGetAffirmativeId( nativeHandle  );
  }

  void setAffirmativeId( int id ) {
    _wxDialogSetAffirmativeId( nativeHandle, id );
  }
}

// ------------------------- wxAppBar ----------------------

typedef _WxAppBarConstructorNative = Pointer Function( Pointer, Int32, Pointer<Utf8>, Int32, Int32, Int32, Int32, Int32  );
typedef _WxAppBarConstructor = Pointer Function( Pointer, int, Pointer<Utf8>, int, int, int, int, int  );
late _WxAppBarConstructor _wxAppBarConstructor;

typedef _WxAppBarAttachNative = Void Function( Pointer, Pointer  );
typedef _WxAppBarAttach = void Function( Pointer, Pointer  );
late _WxAppBarAttach _wxAppBarAttach;

typedef _WxAppBarAddActionNative = Void Function( Pointer, Int32, Pointer<Utf8>  );
typedef _WxAppBarAddAction = void Function( Pointer, int, Pointer<Utf8>  );
late _WxAppBarAddAction _wxAppBarAddAction;

/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxAB_FLEXIBLE | 0x0200 |
/// | wxAB_PINNED | 0x0400 |
/// | wxAB_DEFAULT_STYLE | wxAB_FLEXIBLE |

const int wxAB_FLEXIBLE = 0x0200;
const int wxAB_PINNED = 0x0400;
const int wxAB_DEFAULT_STYLE = wxAB_FLEXIBLE;

class WxAppBar extends WxToolBar {
  WxAppBar._defaultConstructor() : super._defaultConstructor();
  WxAppBar( WxWindow parent, int id, String title, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = wxAB_DEFAULT_STYLE } ) : super._defaultConstructor() {
    final titleUtf8 = title.toNativeUtf8();
    nativeHandle = _wxAppBarConstructor( parent.nativeHandle, id, titleUtf8, pos.x, pos.y, size.x, size.y, style );
    malloc.free( titleUtf8 );
    _postCreation();
  }
  WxAppBar.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  void attach( WxScrolledWindow window ) {
    _wxAppBarAttach( nativeHandle, window.nativeHandle );
  }

  void addAction( int id, String action ) {
    final actionUtf8 = action.toNativeUtf8();
    _wxAppBarAddAction( nativeHandle, id, actionUtf8 );
    malloc.free( actionUtf8 );
  }
}

// ------------------------- wxAdaptiveFrame ----------------------

typedef _WxAdaptiveFrameConstructorNative = Pointer Function( Pointer, Int32, Pointer<Utf8>, Int32, Int32, Int32, Int32, Int32  );
typedef _WxAdaptiveFrameConstructor = Pointer Function( Pointer, int, Pointer<Utf8>, int, int, int, int, int  );
late _WxAdaptiveFrameConstructor _wxAdaptiveFrameConstructor;

typedef _WxAdaptiveFrameCreateAppBarNative = Pointer Function( Pointer, Pointer<Utf8>, Int32, Int32  );
typedef _WxAdaptiveFrameCreateAppBar = Pointer Function( Pointer, Pointer<Utf8>, int, int  );
late _WxAdaptiveFrameCreateAppBar _wxAdaptiveFrameCreateAppBar;

typedef _WxAdaptiveFrameCreateFloatingActionButtonNative = Pointer Function( Pointer, Pointer<Utf8>, Int32, Pointer  );
typedef _WxAdaptiveFrameCreateFloatingActionButton = Pointer Function( Pointer, Pointer<Utf8>, int, Pointer  );
late _WxAdaptiveFrameCreateFloatingActionButton _wxAdaptiveFrameCreateFloatingActionButton;

typedef _WxAdaptiveFrameGetFloatingActionButtonNative = Pointer Function( Pointer  );
typedef _WxAdaptiveFrameGetFloatingActionButton = Pointer Function( Pointer  );
late _WxAdaptiveFrameGetFloatingActionButton _wxAdaptiveFrameGetFloatingActionButton;

typedef _WxAdaptiveFrameCloseDrawerNative = Void Function( Pointer  );
typedef _WxAdaptiveFrameCloseDrawer = void Function( Pointer  );
late _WxAdaptiveFrameCloseDrawer _wxAdaptiveFrameCloseDrawer;

typedef _WxAdaptiveFrameOpenDrawerNative = Void Function( Pointer  );
typedef _WxAdaptiveFrameOpenDrawer = void Function( Pointer  );
late _WxAdaptiveFrameOpenDrawer _wxAdaptiveFrameOpenDrawer;

typedef _WxAdaptiveFrameSetDrawerFromWindowNative = Void Function( Pointer, Pointer  );
typedef _WxAdaptiveFrameSetDrawerFromWindow = void Function( Pointer, Pointer  );
late _WxAdaptiveFrameSetDrawerFromWindow _wxAdaptiveFrameSetDrawerFromWindow;

typedef _WxAdaptiveFrameSetDrawerFromStandardMenuBarNative = Void Function( Pointer, Bool, Int32  );
typedef _WxAdaptiveFrameSetDrawerFromStandardMenuBar = void Function( Pointer, bool, int  );
late _WxAdaptiveFrameSetDrawerFromStandardMenuBar _wxAdaptiveFrameSetDrawerFromStandardMenuBar;

typedef _WxAdaptiveFrameSetDrawerFromMenuBarNative = Void Function( Pointer, Pointer  );
typedef _WxAdaptiveFrameSetDrawerFromMenuBar = void Function( Pointer, Pointer  );
late _WxAdaptiveFrameSetDrawerFromMenuBar _wxAdaptiveFrameSetDrawerFromMenuBar;

typedef _WxAdaptiveFrameSetDrawerTitleNative = Void Function( Pointer, Pointer<Utf8>  );
typedef _WxAdaptiveFrameSetDrawerTitle = void Function( Pointer, Pointer<Utf8>  );
late _WxAdaptiveFrameSetDrawerTitle _wxAdaptiveFrameSetDrawerTitle;

class WxAdaptiveFrame extends WxFrame {
  WxAdaptiveFrame._defaultConstructor() : super._defaultConstructor();
  WxAdaptiveFrame( WxWindow? parent, int id, String title, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = wxDEFAULT_FRAME_STYLE } ) : super._defaultConstructor() {
    final titleUtf8 = title.toNativeUtf8();
    nativeHandle = _wxAdaptiveFrameConstructor( (parent == null) ? nullptr : parent.nativeHandle, id, titleUtf8, pos.x, pos.y, size.x, size.y, style );
    malloc.free( titleUtf8 );
    _postCreation();
  }
  WxAdaptiveFrame.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _postCreation();
  }

  WxAppBar createAppBar( String title, { int style = wxTB_DEFAULT_STYLE, int id = -1 } ) {
    final titleUtf8 = title.toNativeUtf8();
    final returnedNativeHandle = _wxAdaptiveFrameCreateAppBar( nativeHandle, titleUtf8, style, id );
    WxEvtHandler? eh = _evtHandlerList[returnedNativeHandle];
    if (eh != null) {
      // There already is a Dart class associated with this C++ object
      return eh as WxAppBar;
    }
    return WxAppBar.fromHandle( returnedNativeHandle );
  }

  WxButton createFloatingActionButton( String label, int id, WxBitmapBundle? bitmap ) {
    final labelUtf8 = label.toNativeUtf8();
    final returnedNativeHandle = _wxAdaptiveFrameCreateFloatingActionButton( nativeHandle, labelUtf8, id, (bitmap == null) ? nullptr : bitmap.nativeHandle );
    WxEvtHandler? eh = _evtHandlerList[returnedNativeHandle];
    if (eh != null) {
      // There already is a Dart class associated with this C++ object
      return eh as WxButton;
    }
    return WxButton.fromHandle( returnedNativeHandle );
  }

  WxButton? getFloatingActionButton( ) {
    final returnedNativeHandle = _wxAdaptiveFrameGetFloatingActionButton( nativeHandle  );
    if (returnedNativeHandle == nullptr) return null;
    WxEvtHandler? eh = _evtHandlerList[returnedNativeHandle];
    if (eh != null) {
      // There already is a Dart class associated with this C++ object
      return eh as WxButton;
    }
    return WxButton.fromHandle( returnedNativeHandle );
  }

  void closeDrawer( ) {
    _wxAdaptiveFrameCloseDrawer( nativeHandle  );
  }

  void openDrawer( ) {
    _wxAdaptiveFrameOpenDrawer( nativeHandle  );
  }

  void setDrawerFromWindow( WxWindow window ) {
    _wxAdaptiveFrameSetDrawerFromWindow( nativeHandle, window.nativeHandle );
  }

  void setDrawerFromStandardMenuBar( { bool useMenuBar = true, int startMneu = 1 } ) {
    _wxAdaptiveFrameSetDrawerFromStandardMenuBar( nativeHandle, useMenuBar, startMneu );
  }

  void setDrawerFromMenuBar( WxMenuBar menubar ) {
    _wxAdaptiveFrameSetDrawerFromMenuBar( nativeHandle, menubar.nativeHandle );
  }

  void setDrawerTitle( String title ) {
    final titleUtf8 = title.toNativeUtf8();
    _wxAdaptiveFrameSetDrawerTitle( nativeHandle, titleUtf8 );
    malloc.free( titleUtf8 );
  }
}


void setupWxWindows( DynamicLibrary dylib )
{
  // ------------------------- wxWindow ----------------------

  final wxWindowConstructorPtr = dylib.lookup <NativeFunction<_WxWindowConstructorNative>>('wxWindowConstructor');
  _wxWindowConstructor = wxWindowConstructorPtr.asFunction<_WxWindowConstructor>();

  final wxWindowGetChildCountPtr = dylib.lookup <NativeFunction<_WxWindowGetChildCountNative>>('wxWindowGetChildCount');
  _wxWindowGetChildCount = wxWindowGetChildCountPtr.asFunction<_WxWindowGetChildCount>();

  final wxWindowGetChildPtr = dylib.lookup <NativeFunction<_WxWindowGetChildNative>>('wxWindowGetChild');
  _wxWindowGetChild = wxWindowGetChildPtr.asFunction<_WxWindowGetChild>();

  final wxWindowGetParentPtr = dylib.lookup <NativeFunction<_WxWindowGetParentNative>>('wxWindowGetParent');
  _wxWindowGetParent = wxWindowGetParentPtr.asFunction<_WxWindowGetParent>();

  final wxWindowIsTopLevelPtr = dylib.lookup <NativeFunction<_WxWindowIsTopLevelNative>>('wxWindowIsTopLevel');
  _wxWindowIsTopLevel = wxWindowIsTopLevelPtr.asFunction<_WxWindowIsTopLevel>();

  final wxWindowFindWindowPtr = dylib.lookup <NativeFunction<_WxWindowFindWindowNative>>('wxWindowFindWindow');
  _wxWindowFindWindow = wxWindowFindWindowPtr.asFunction<_WxWindowFindWindow>();

  final wxWindowReparentPtr = dylib.lookup <NativeFunction<_WxWindowReparentNative>>('wxWindowReparent');
  _wxWindowReparent = wxWindowReparentPtr.asFunction<_WxWindowReparent>();

  final wxWindowGetIdPtr = dylib.lookup <NativeFunction<_WxWindowGetIdNative>>('wxWindowGetId');
  _wxWindowGetId = wxWindowGetIdPtr.asFunction<_WxWindowGetId>();

  final wxWindowSetLabelPtr = dylib.lookup <NativeFunction<_WxWindowSetLabelNative>>('wxWindowSetLabel');
  _wxWindowSetLabel = wxWindowSetLabelPtr.asFunction<_WxWindowSetLabel>();

  final wxWindowGetLabelPtr = dylib.lookup <NativeFunction<_WxWindowGetLabelNative>>('wxWindowGetLabel');
  _wxWindowGetLabel = wxWindowGetLabelPtr.asFunction<_WxWindowGetLabel>();

  final wxWindowHasFlagPtr = dylib.lookup <NativeFunction<_WxWindowHasFlagNative>>('wxWindowHasFlag');
  _wxWindowHasFlag = wxWindowHasFlagPtr.asFunction<_WxWindowHasFlag>();

  final wxWindowGetWindowStylePtr = dylib.lookup <NativeFunction<_WxWindowGetWindowStyleNative>>('wxWindowGetWindowStyle');
  _wxWindowGetWindowStyle = wxWindowGetWindowStylePtr.asFunction<_WxWindowGetWindowStyle>();

  final wxWindowGetWindowStyleFlagPtr = dylib.lookup <NativeFunction<_WxWindowGetWindowStyleFlagNative>>('wxWindowGetWindowStyleFlag');
  _wxWindowGetWindowStyleFlag = wxWindowGetWindowStyleFlagPtr.asFunction<_WxWindowGetWindowStyleFlag>();

  final wxWindowSetWindowStylePtr = dylib.lookup <NativeFunction<_WxWindowSetWindowStyleNative>>('wxWindowSetWindowStyle');
  _wxWindowSetWindowStyle = wxWindowSetWindowStylePtr.asFunction<_WxWindowSetWindowStyle>();

  final wxWindowSetWindowStyleFlagPtr = dylib.lookup <NativeFunction<_WxWindowSetWindowStyleFlagNative>>('wxWindowSetWindowStyleFlag');
  _wxWindowSetWindowStyleFlag = wxWindowSetWindowStyleFlagPtr.asFunction<_WxWindowSetWindowStyleFlag>();

  final wxWindowEnableTouchEventsPtr = dylib.lookup <NativeFunction<_WxWindowEnableTouchEventsNative>>('wxWindowEnableTouchEvents');
  _wxWindowEnableTouchEvents = wxWindowEnableTouchEventsPtr.asFunction<_WxWindowEnableTouchEvents>();

  final wxWindowClosePtr = dylib.lookup <NativeFunction<_WxWindowCloseNative>>('wxWindowClose');
  _wxWindowClose = wxWindowClosePtr.asFunction<_WxWindowClose>();

  final wxWindowDestroyPtr = dylib.lookup <NativeFunction<_WxWindowDestroyNative>>('wxWindowDestroy');
  _wxWindowDestroy = wxWindowDestroyPtr.asFunction<_WxWindowDestroy>();

  final wxWindowCentrePtr = dylib.lookup <NativeFunction<_WxWindowCentreNative>>('wxWindowCentre');
  _wxWindowCentre = wxWindowCentrePtr.asFunction<_WxWindowCentre>();

  final wxWindowCentreOnParentPtr = dylib.lookup <NativeFunction<_WxWindowCentreOnParentNative>>('wxWindowCentreOnParent');
  _wxWindowCentreOnParent = wxWindowCentreOnParentPtr.asFunction<_WxWindowCentreOnParent>();

  final wxWindowGetSizePtr = dylib.lookup <NativeFunction<_WxWindowGetSizeNative>>('wxWindowGetSize');
  _wxWindowGetSize = wxWindowGetSizePtr.asFunction<_WxWindowGetSize>();

  final wxWindowGetVirtualSizePtr = dylib.lookup <NativeFunction<_WxWindowGetVirtualSizeNative>>('wxWindowGetVirtualSize');
  _wxWindowGetVirtualSize = wxWindowGetVirtualSizePtr.asFunction<_WxWindowGetVirtualSize>();

  final wxWindowGetMinSizePtr = dylib.lookup <NativeFunction<_WxWindowGetMinSizeNative>>('wxWindowGetMinSize');
  _wxWindowGetMinSize = wxWindowGetMinSizePtr.asFunction<_WxWindowGetMinSize>();

  final wxWindowGetMaxClientSizePtr = dylib.lookup <NativeFunction<_WxWindowGetMaxClientSizeNative>>('wxWindowGetMaxClientSize');
  _wxWindowGetMaxClientSize = wxWindowGetMaxClientSizePtr.asFunction<_WxWindowGetMaxClientSize>();

  final wxWindowGetMaxSizePtr = dylib.lookup <NativeFunction<_WxWindowGetMaxSizeNative>>('wxWindowGetMaxSize');
  _wxWindowGetMaxSize = wxWindowGetMaxSizePtr.asFunction<_WxWindowGetMaxSize>();

  final wxWindowGetPositionPtr = dylib.lookup <NativeFunction<_WxWindowGetPositionNative>>('wxWindowGetPosition');
  _wxWindowGetPosition = wxWindowGetPositionPtr.asFunction<_WxWindowGetPosition>();

  final wxWindowGetRectPtr = dylib.lookup <NativeFunction<_WxWindowGetRectNative>>('wxWindowGetRect');
  _wxWindowGetRect = wxWindowGetRectPtr.asFunction<_WxWindowGetRect>();

  final wxWindowInvalidateBestSizePtr = dylib.lookup <NativeFunction<_WxWindowInvalidateBestSizeNative>>('wxWindowInvalidateBestSize');
  _wxWindowInvalidateBestSize = wxWindowInvalidateBestSizePtr.asFunction<_WxWindowInvalidateBestSize>();

  final wxWindowSetSizePtr = dylib.lookup <NativeFunction<_WxWindowSetSizeNative>>('wxWindowSetSize');
  _wxWindowSetSize = wxWindowSetSizePtr.asFunction<_WxWindowSetSize>();

  final wxWindowSetPositionPtr = dylib.lookup <NativeFunction<_WxWindowSetPositionNative>>('wxWindowSetPosition');
  _wxWindowSetPosition = wxWindowSetPositionPtr.asFunction<_WxWindowSetPosition>();

  final wxWindowSetPositionAndSizePtr = dylib.lookup <NativeFunction<_WxWindowSetPositionAndSizeNative>>('wxWindowSetPositionAndSize');
  _wxWindowSetPositionAndSize = wxWindowSetPositionAndSizePtr.asFunction<_WxWindowSetPositionAndSize>();

  final wxWindowSetMinSizePtr = dylib.lookup <NativeFunction<_WxWindowSetMinSizeNative>>('wxWindowSetMinSize');
  _wxWindowSetMinSize = wxWindowSetMinSizePtr.asFunction<_WxWindowSetMinSize>();

  final wxWindowSetClientSizePtr = dylib.lookup <NativeFunction<_WxWindowSetClientSizeNative>>('wxWindowSetClientSize');
  _wxWindowSetClientSize = wxWindowSetClientSizePtr.asFunction<_WxWindowSetClientSize>();

  final wxWindowSetVirtualSizePtr = dylib.lookup <NativeFunction<_WxWindowSetVirtualSizeNative>>('wxWindowSetVirtualSize');
  _wxWindowSetVirtualSize = wxWindowSetVirtualSizePtr.asFunction<_WxWindowSetVirtualSize>();

  final wxWindowGetClientSizePtr = dylib.lookup <NativeFunction<_WxWindowGetClientSizeNative>>('wxWindowGetClientSize');
  _wxWindowGetClientSize = wxWindowGetClientSizePtr.asFunction<_WxWindowGetClientSize>();

  final wxWindowGetClientRectPtr = dylib.lookup <NativeFunction<_WxWindowGetClientRectNative>>('wxWindowGetClientRect');
  _wxWindowGetClientRect = wxWindowGetClientRectPtr.asFunction<_WxWindowGetClientRect>();

  final wxWindowGetClientAreaOriginPtr = dylib.lookup <NativeFunction<_WxWindowGetClientAreaOriginNative>>('wxWindowGetClientAreaOrigin');
  _wxWindowGetClientAreaOrigin = wxWindowGetClientAreaOriginPtr.asFunction<_WxWindowGetClientAreaOrigin>();

  final wxWindowGetUpdateClientRectPtr = dylib.lookup <NativeFunction<_WxWindowGetUpdateClientRectNative>>('wxWindowGetUpdateClientRect');
  _wxWindowGetUpdateClientRect = wxWindowGetUpdateClientRectPtr.asFunction<_WxWindowGetUpdateClientRect>();

  final wxWindowLowerPtr = dylib.lookup <NativeFunction<_WxWindowLowerNative>>('wxWindowLower');
  _wxWindowLower = wxWindowLowerPtr.asFunction<_WxWindowLower>();

  final wxWindowRaisePtr = dylib.lookup <NativeFunction<_WxWindowRaiseNative>>('wxWindowRaise');
  _wxWindowRaise = wxWindowRaisePtr.asFunction<_WxWindowRaise>();

  final wxWindowHidePtr = dylib.lookup <NativeFunction<_WxWindowHideNative>>('wxWindowHide');
  _wxWindowHide = wxWindowHidePtr.asFunction<_WxWindowHide>();

  final wxWindowShowPtr = dylib.lookup <NativeFunction<_WxWindowShowNative>>('wxWindowShow');
  _wxWindowShow = wxWindowShowPtr.asFunction<_WxWindowShow>();

  final wxWindowIsShownPtr = dylib.lookup <NativeFunction<_WxWindowIsShownNative>>('wxWindowIsShown');
  _wxWindowIsShown = wxWindowIsShownPtr.asFunction<_WxWindowIsShown>();

  final wxWindowDisablePtr = dylib.lookup <NativeFunction<_WxWindowDisableNative>>('wxWindowDisable');
  _wxWindowDisable = wxWindowDisablePtr.asFunction<_WxWindowDisable>();

  final wxWindowEnablePtr = dylib.lookup <NativeFunction<_WxWindowEnableNative>>('wxWindowEnable');
  _wxWindowEnable = wxWindowEnablePtr.asFunction<_WxWindowEnable>();

  final wxWindowIsEnabledPtr = dylib.lookup <NativeFunction<_WxWindowIsEnabledNative>>('wxWindowIsEnabled');
  _wxWindowIsEnabled = wxWindowIsEnabledPtr.asFunction<_WxWindowIsEnabled>();

  final wxWindowClientToScreenPtr = dylib.lookup <NativeFunction<_WxWindowClientToScreenNative>>('wxWindowClientToScreen');
  _wxWindowClientToScreen = wxWindowClientToScreenPtr.asFunction<_WxWindowClientToScreen>();

  final wxWindowScreenToClientPtr = dylib.lookup <NativeFunction<_WxWindowScreenToClientNative>>('wxWindowScreenToClient');
  _wxWindowScreenToClient = wxWindowScreenToClientPtr.asFunction<_WxWindowScreenToClient>();

  final wxWindowClientToWindowSizePtr = dylib.lookup <NativeFunction<_WxWindowClientToWindowSizeNative>>('wxWindowClientToWindowSize');
  _wxWindowClientToWindowSize = wxWindowClientToWindowSizePtr.asFunction<_WxWindowClientToWindowSize>();

  final wxWindowWindowToClientSizePtr = dylib.lookup <NativeFunction<_WxWindowWindowToClientSizeNative>>('wxWindowWindowToClientSize');
  _wxWindowWindowToClientSize = wxWindowWindowToClientSizePtr.asFunction<_WxWindowWindowToClientSize>();

  final wxWindowFitPtr = dylib.lookup <NativeFunction<_WxWindowFitNative>>('wxWindowFit');
  _wxWindowFit = wxWindowFitPtr.asFunction<_WxWindowFit>();

  final wxWindowFitInsidePtr = dylib.lookup <NativeFunction<_WxWindowFitInsideNative>>('wxWindowFitInside');
  _wxWindowFitInside = wxWindowFitInsidePtr.asFunction<_WxWindowFitInside>();

  final wxWindowSizeFromDIPPtr = dylib.lookup <NativeFunction<_WxWindowSizeFromDIPNative>>('wxWindowSizeFromDIP');
  _wxWindowSizeFromDIP = wxWindowSizeFromDIPPtr.asFunction<_WxWindowSizeFromDIP>();

  final wxWindowFromDIPPtr = dylib.lookup <NativeFunction<_WxWindowFromDIPNative>>('wxWindowFromDIP');
  _wxWindowFromDIP = wxWindowFromDIPPtr.asFunction<_WxWindowFromDIP>();

  final wxWindowGetDPIScaleFactorPtr = dylib.lookup <NativeFunction<_WxWindowGetDPIScaleFactorNative>>('wxWindowGetDPIScaleFactor');
  _wxWindowGetDPIScaleFactor = wxWindowGetDPIScaleFactorPtr.asFunction<_WxWindowGetDPIScaleFactor>();

  final wxWindowGetContentScaleFactorPtr = dylib.lookup <NativeFunction<_WxWindowGetContentScaleFactorNative>>('wxWindowGetContentScaleFactor');
  _wxWindowGetContentScaleFactor = wxWindowGetContentScaleFactorPtr.asFunction<_WxWindowGetContentScaleFactor>();

  final wxWindowFreezePtr = dylib.lookup <NativeFunction<_WxWindowFreezeNative>>('wxWindowFreeze');
  _wxWindowFreeze = wxWindowFreezePtr.asFunction<_WxWindowFreeze>();

  final wxWindowThawPtr = dylib.lookup <NativeFunction<_WxWindowThawNative>>('wxWindowThaw');
  _wxWindowThaw = wxWindowThawPtr.asFunction<_WxWindowThaw>();

  final wxWindowIsFrozenPtr = dylib.lookup <NativeFunction<_WxWindowIsFrozenNative>>('wxWindowIsFrozen');
  _wxWindowIsFrozen = wxWindowIsFrozenPtr.asFunction<_WxWindowIsFrozen>();

  final wxWindowRefreshPtr = dylib.lookup <NativeFunction<_WxWindowRefreshNative>>('wxWindowRefresh');
  _wxWindowRefresh = wxWindowRefreshPtr.asFunction<_WxWindowRefresh>();

  final wxWindowRefreshRectPtr = dylib.lookup <NativeFunction<_WxWindowRefreshRectNative>>('wxWindowRefreshRect');
  _wxWindowRefreshRect = wxWindowRefreshRectPtr.asFunction<_WxWindowRefreshRect>();

  final wxWindowCaptureMousePtr = dylib.lookup <NativeFunction<_WxWindowCaptureMouseNative>>('wxWindowCaptureMouse');
  _wxWindowCaptureMouse = wxWindowCaptureMousePtr.asFunction<_WxWindowCaptureMouse>();

  final wxWindowReleaseMousePtr = dylib.lookup <NativeFunction<_WxWindowReleaseMouseNative>>('wxWindowReleaseMouse');
  _wxWindowReleaseMouse = wxWindowReleaseMousePtr.asFunction<_WxWindowReleaseMouse>();

  final wxWindowHasCapturePtr = dylib.lookup <NativeFunction<_WxWindowHasCaptureNative>>('wxWindowHasCapture');
  _wxWindowHasCapture = wxWindowHasCapturePtr.asFunction<_WxWindowHasCapture>();

  final wxWindowPopupMenuPtr = dylib.lookup <NativeFunction<_WxWindowPopupMenuNative>>('wxWindowPopupMenu');
  _wxWindowPopupMenu = wxWindowPopupMenuPtr.asFunction<_WxWindowPopupMenu>();

  final wxWindowSetCursorPtr = dylib.lookup <NativeFunction<_WxWindowSetCursorNative>>('wxWindowSetCursor');
  _wxWindowSetCursor = wxWindowSetCursorPtr.asFunction<_WxWindowSetCursor>();

  final wxWindowGetCursorPtr = dylib.lookup <NativeFunction<_WxWindowGetCursorNative>>('wxWindowGetCursor');
  _wxWindowGetCursor = wxWindowGetCursorPtr.asFunction<_WxWindowGetCursor>();

  final wxWindowSetFocusPtr = dylib.lookup <NativeFunction<_WxWindowSetFocusNative>>('wxWindowSetFocus');
  _wxWindowSetFocus = wxWindowSetFocusPtr.asFunction<_WxWindowSetFocus>();

  final wxWindowHasFocusPtr = dylib.lookup <NativeFunction<_WxWindowHasFocusNative>>('wxWindowHasFocus');
  _wxWindowHasFocus = wxWindowHasFocusPtr.asFunction<_WxWindowHasFocus>();

  final wxWindowSetCanFocusPtr = dylib.lookup <NativeFunction<_WxWindowSetCanFocusNative>>('wxWindowSetCanFocus');
  _wxWindowSetCanFocus = wxWindowSetCanFocusPtr.asFunction<_WxWindowSetCanFocus>();

  final wxWindowDisableFocusFromKeyboardPtr = dylib.lookup <NativeFunction<_WxWindowDisableFocusFromKeyboardNative>>('wxWindowDisableFocusFromKeyboard');
  _wxWindowDisableFocusFromKeyboard = wxWindowDisableFocusFromKeyboardPtr.asFunction<_WxWindowDisableFocusFromKeyboard>();

  final wxWindowAcceptsFocusPtr = dylib.lookup <NativeFunction<_WxWindowAcceptsFocusNative>>('wxWindowAcceptsFocus');
  _wxWindowAcceptsFocus = wxWindowAcceptsFocusPtr.asFunction<_WxWindowAcceptsFocus>();

  final wxWindowAcceptsFocusFromKeyboardPtr = dylib.lookup <NativeFunction<_WxWindowAcceptsFocusFromKeyboardNative>>('wxWindowAcceptsFocusFromKeyboard');
  _wxWindowAcceptsFocusFromKeyboard = wxWindowAcceptsFocusFromKeyboardPtr.asFunction<_WxWindowAcceptsFocusFromKeyboard>();

  final wxWindowAcceptsFocusRecursivelyPtr = dylib.lookup <NativeFunction<_WxWindowAcceptsFocusRecursivelyNative>>('wxWindowAcceptsFocusRecursively');
  _wxWindowAcceptsFocusRecursively = wxWindowAcceptsFocusRecursivelyPtr.asFunction<_WxWindowAcceptsFocusRecursively>();

  final wxWindowIsFocusablePtr = dylib.lookup <NativeFunction<_WxWindowIsFocusableNative>>('wxWindowIsFocusable');
  _wxWindowIsFocusable = wxWindowIsFocusablePtr.asFunction<_WxWindowIsFocusable>();

  final wxWindowCanAcceptFocusFromKeyboardPtr = dylib.lookup <NativeFunction<_WxWindowCanAcceptFocusFromKeyboardNative>>('wxWindowCanAcceptFocusFromKeyboard');
  _wxWindowCanAcceptFocusFromKeyboard = wxWindowCanAcceptFocusFromKeyboardPtr.asFunction<_WxWindowCanAcceptFocusFromKeyboard>();

  final wxWindowCanAcceptFocusPtr = dylib.lookup <NativeFunction<_WxWindowCanAcceptFocusNative>>('wxWindowCanAcceptFocus');
  _wxWindowCanAcceptFocus = wxWindowCanAcceptFocusPtr.asFunction<_WxWindowCanAcceptFocus>();

  final wxWindowLayoutPtr = dylib.lookup <NativeFunction<_WxWindowLayoutNative>>('wxWindowLayout');
  _wxWindowLayout = wxWindowLayoutPtr.asFunction<_WxWindowLayout>();

  final wxWindowSetSizerPtr = dylib.lookup <NativeFunction<_WxWindowSetSizerNative>>('wxWindowSetSizer');
  _wxWindowSetSizer = wxWindowSetSizerPtr.asFunction<_WxWindowSetSizer>();

  final wxWindowGetSizerPtr = dylib.lookup <NativeFunction<_WxWindowGetSizerNative>>('wxWindowGetSizer');
  _wxWindowGetSizer = wxWindowGetSizerPtr.asFunction<_WxWindowGetSizer>();

  final wxWindowSetSizerAndFitPtr = dylib.lookup <NativeFunction<_WxWindowSetSizerAndFitNative>>('wxWindowSetSizerAndFit');
  _wxWindowSetSizerAndFit = wxWindowSetSizerAndFitPtr.asFunction<_WxWindowSetSizerAndFit>();

  final wxWindowSetForegroundColourPtr = dylib.lookup <NativeFunction<_WxWindowSetForegroundColourNative>>('wxWindowSetForegroundColour');
  _wxWindowSetForegroundColour = wxWindowSetForegroundColourPtr.asFunction<_WxWindowSetForegroundColour>();

  final wxWindowGetForegroundColourPtr = dylib.lookup <NativeFunction<_WxWindowGetForegroundColourNative>>('wxWindowGetForegroundColour');
  _wxWindowGetForegroundColour = wxWindowGetForegroundColourPtr.asFunction<_WxWindowGetForegroundColour>();

  final wxWindowUseForegroundColourPtr = dylib.lookup <NativeFunction<_WxWindowUseForegroundColourNative>>('wxWindowUseForegroundColour');
  _wxWindowUseForegroundColour = wxWindowUseForegroundColourPtr.asFunction<_WxWindowUseForegroundColour>();

  final wxWindowSetBackgroundColourPtr = dylib.lookup <NativeFunction<_WxWindowSetBackgroundColourNative>>('wxWindowSetBackgroundColour');
  _wxWindowSetBackgroundColour = wxWindowSetBackgroundColourPtr.asFunction<_WxWindowSetBackgroundColour>();

  final wxWindowGetBackgroundColourPtr = dylib.lookup <NativeFunction<_WxWindowGetBackgroundColourNative>>('wxWindowGetBackgroundColour');
  _wxWindowGetBackgroundColour = wxWindowGetBackgroundColourPtr.asFunction<_WxWindowGetBackgroundColour>();

  final wxWindowUseBackgroundColourPtr = dylib.lookup <NativeFunction<_WxWindowUseBackgroundColourNative>>('wxWindowUseBackgroundColour');
  _wxWindowUseBackgroundColour = wxWindowUseBackgroundColourPtr.asFunction<_WxWindowUseBackgroundColour>();

  final wxWindowSetBackgroundStylePtr = dylib.lookup <NativeFunction<_WxWindowSetBackgroundStyleNative>>('wxWindowSetBackgroundStyle');
  _wxWindowSetBackgroundStyle = wxWindowSetBackgroundStylePtr.asFunction<_WxWindowSetBackgroundStyle>();

  final wxWindowGetBackgroundStylePtr = dylib.lookup <NativeFunction<_WxWindowGetBackgroundStyleNative>>('wxWindowGetBackgroundStyle');
  _wxWindowGetBackgroundStyle = wxWindowGetBackgroundStylePtr.asFunction<_WxWindowGetBackgroundStyle>();

  final wxWindowGetTextExtentPtr = dylib.lookup <NativeFunction<_WxWindowGetTextExtentNative>>('wxWindowGetTextExtent');
  _wxWindowGetTextExtent = wxWindowGetTextExtentPtr.asFunction<_WxWindowGetTextExtent>();

  final wxWindowSetFontPtr = dylib.lookup <NativeFunction<_WxWindowSetFontNative>>('wxWindowSetFont');
  _wxWindowSetFont = wxWindowSetFontPtr.asFunction<_WxWindowSetFont>();

  final wxWindowSetToolTipPtr = dylib.lookup <NativeFunction<_WxWindowSetToolTipNative>>('wxWindowSetToolTip');
  _wxWindowSetToolTip = wxWindowSetToolTipPtr.asFunction<_WxWindowSetToolTip>();

  final wxWindowUnsetToolTipPtr = dylib.lookup <NativeFunction<_WxWindowUnsetToolTipNative>>('wxWindowUnsetToolTip');
  _wxWindowUnsetToolTip = wxWindowUnsetToolTipPtr.asFunction<_WxWindowUnsetToolTip>();

  final wxWindowGetToolTipTextPtr = dylib.lookup <NativeFunction<_WxWindowGetToolTipTextNative>>('wxWindowGetToolTipText');
  _wxWindowGetToolTipText = wxWindowGetToolTipTextPtr.asFunction<_WxWindowGetToolTipText>();

  final wxWindowSetDropTargetPtr = dylib.lookup <NativeFunction<_WxWindowSetDropTargetNative>>('wxWindowSetDropTarget');
  _wxWindowSetDropTarget = wxWindowSetDropTargetPtr.asFunction<_WxWindowSetDropTarget>();

  // ------------------------- wxPanel ----------------------

  final wxPanelConstructorPtr = dylib.lookup <NativeFunction<_WxPanelConstructorNative>>('wxPanelConstructor');
  _wxPanelConstructor = wxPanelConstructorPtr.asFunction<_WxPanelConstructor>();

  final wxPanelSetFocusIgnoringChildrenPtr = dylib.lookup <NativeFunction<_WxPanelSetFocusIgnoringChildrenNative>>('wxPanelSetFocusIgnoringChildren');
  _wxPanelSetFocusIgnoringChildren = wxPanelSetFocusIgnoringChildrenPtr.asFunction<_WxPanelSetFocusIgnoringChildren>();

  final wxPanelGetMinSizePtr = dylib.lookup <NativeFunction<_WxPanelGetMinSizeNative>>('wxPanelGetMinSize');
  _wxPanelGetMinSize = wxPanelGetMinSizePtr.asFunction<_WxPanelGetMinSize>();

  // ------------------------- wxScrolledWindow ----------------------

  final wxScrolledWindowConstructorPtr = dylib.lookup <NativeFunction<_WxScrolledWindowConstructorNative>>('wxScrolledWindowConstructor');
  _wxScrolledWindowConstructor = wxScrolledWindowConstructorPtr.asFunction<_WxScrolledWindowConstructor>();

  final wxScrolledWindowGetMinSizePtr = dylib.lookup <NativeFunction<_WxScrolledWindowGetMinSizeNative>>('wxScrolledWindowGetMinSize');
  _wxScrolledWindowGetMinSize = wxScrolledWindowGetMinSizePtr.asFunction<_WxScrolledWindowGetMinSize>();

  final wxScrolledWindowSetTargetWindowPtr = dylib.lookup <NativeFunction<_WxScrolledWindowSetTargetWindowNative>>('wxScrolledWindowSetTargetWindow');
  _wxScrolledWindowSetTargetWindow = wxScrolledWindowSetTargetWindowPtr.asFunction<_WxScrolledWindowSetTargetWindow>();

  final wxScrolledWindowScrollPtr = dylib.lookup <NativeFunction<_WxScrolledWindowScrollNative>>('wxScrolledWindowScroll');
  _wxScrolledWindowScroll = wxScrolledWindowScrollPtr.asFunction<_WxScrolledWindowScroll>();

  final wxScrolledWindowScrollPixelsPtr = dylib.lookup <NativeFunction<_WxScrolledWindowScrollPixelsNative>>('wxScrolledWindowScrollPixels');
  _wxScrolledWindowScrollPixels = wxScrolledWindowScrollPixelsPtr.asFunction<_WxScrolledWindowScrollPixels>();

  final wxScrolledWindowGetViewStartPtr = dylib.lookup <NativeFunction<_WxScrolledWindowGetViewStartNative>>('wxScrolledWindowGetViewStart');
  _wxScrolledWindowGetViewStart = wxScrolledWindowGetViewStartPtr.asFunction<_WxScrolledWindowGetViewStart>();

  final wxScrolledWindowGetViewStartPixelsPtr = dylib.lookup <NativeFunction<_WxScrolledWindowGetViewStartPixelsNative>>('wxScrolledWindowGetViewStartPixels');
  _wxScrolledWindowGetViewStartPixels = wxScrolledWindowGetViewStartPixelsPtr.asFunction<_WxScrolledWindowGetViewStartPixels>();

  final wxScrolledWindowSetScrollRatePtr = dylib.lookup <NativeFunction<_WxScrolledWindowSetScrollRateNative>>('wxScrolledWindowSetScrollRate');
  _wxScrolledWindowSetScrollRate = wxScrolledWindowSetScrollRatePtr.asFunction<_WxScrolledWindowSetScrollRate>();

  final wxScrolledWindowSetScrollbarsPtr = dylib.lookup <NativeFunction<_WxScrolledWindowSetScrollbarsNative>>('wxScrolledWindowSetScrollbars');
  _wxScrolledWindowSetScrollbars = wxScrolledWindowSetScrollbarsPtr.asFunction<_WxScrolledWindowSetScrollbars>();

  final wxScrolledWindowGetScrollPixelsPerUnitXPtr = dylib.lookup <NativeFunction<_WxScrolledWindowGetScrollPixelsPerUnitXNative>>('wxScrolledWindowGetScrollPixelsPerUnitX');
  _wxScrolledWindowGetScrollPixelsPerUnitX = wxScrolledWindowGetScrollPixelsPerUnitXPtr.asFunction<_WxScrolledWindowGetScrollPixelsPerUnitX>();

  final wxScrolledWindowGetScrollPixelsPerUnitYPtr = dylib.lookup <NativeFunction<_WxScrolledWindowGetScrollPixelsPerUnitYNative>>('wxScrolledWindowGetScrollPixelsPerUnitY');
  _wxScrolledWindowGetScrollPixelsPerUnitY = wxScrolledWindowGetScrollPixelsPerUnitYPtr.asFunction<_WxScrolledWindowGetScrollPixelsPerUnitY>();

  final wxScrolledWindowCalcScrolledPositionPtr = dylib.lookup <NativeFunction<_WxScrolledWindowCalcScrolledPositionNative>>('wxScrolledWindowCalcScrolledPosition');
  _wxScrolledWindowCalcScrolledPosition = wxScrolledWindowCalcScrolledPositionPtr.asFunction<_WxScrolledWindowCalcScrolledPosition>();

  final wxScrolledWindowCalcUnscrolledPositionPtr = dylib.lookup <NativeFunction<_WxScrolledWindowCalcUnscrolledPositionNative>>('wxScrolledWindowCalcUnscrolledPosition');
  _wxScrolledWindowCalcUnscrolledPosition = wxScrolledWindowCalcUnscrolledPositionPtr.asFunction<_WxScrolledWindowCalcUnscrolledPosition>();

  final wxScrolledWindowDoPrepareDCPtr = dylib.lookup <NativeFunction<_WxScrolledWindowDoPrepareDCNative>>('wxScrolledWindowDoPrepareDC');
  _wxScrolledWindowDoPrepareDC = wxScrolledWindowDoPrepareDCPtr.asFunction<_WxScrolledWindowDoPrepareDC>();

  // ------------------------- wxNonOwnedWindow ----------------------

  final wxNonOwnedWindowIsBeingDeletedPtr = dylib.lookup <NativeFunction<_WxNonOwnedWindowIsBeingDeletedNative>>('wxNonOwnedWindowIsBeingDeleted');
  _wxNonOwnedWindowIsBeingDeleted = wxNonOwnedWindowIsBeingDeletedPtr.asFunction<_WxNonOwnedWindowIsBeingDeleted>();

  // ------------------------- wxPopupWindow ----------------------

  final wxPopupWindowConstructorPtr = dylib.lookup <NativeFunction<_WxPopupWindowConstructorNative>>('wxPopupWindowConstructor');
  _wxPopupWindowConstructor = wxPopupWindowConstructorPtr.asFunction<_WxPopupWindowConstructor>();

  final wxPopupWindowPositionPtr = dylib.lookup <NativeFunction<_WxPopupWindowPositionNative>>('wxPopupWindowPosition');
  _wxPopupWindowPosition = wxPopupWindowPositionPtr.asFunction<_WxPopupWindowPosition>();

  // ------------------------- wxPopupTransientWindow ----------------------

  final wxPopupTransientWindowConstructorPtr = dylib.lookup <NativeFunction<_WxPopupTransientWindowConstructorNative>>('wxPopupTransientWindowConstructor');
  _wxPopupTransientWindowConstructor = wxPopupTransientWindowConstructorPtr.asFunction<_WxPopupTransientWindowConstructor>();

  final wxPopupTransientWindowPopupPtr = dylib.lookup <NativeFunction<_WxPopupTransientWindowPopupNative>>('wxPopupTransientWindowPopup');
  _wxPopupTransientWindowPopup = wxPopupTransientWindowPopupPtr.asFunction<_WxPopupTransientWindowPopup>();

  final wxPopupTransientWindowDismissPtr = dylib.lookup <NativeFunction<_WxPopupTransientWindowDismissNative>>('wxPopupTransientWindowDismiss');
  _wxPopupTransientWindowDismiss = wxPopupTransientWindowDismissPtr.asFunction<_WxPopupTransientWindowDismiss>();

  // ------------------------- wxTopLevelWindow ----------------------

  final wxTopLevelWindowSetTitlePtr = dylib.lookup <NativeFunction<_WxTopLevelWindowSetTitleNative>>('wxTopLevelWindowSetTitle');
  _wxTopLevelWindowSetTitle = wxTopLevelWindowSetTitlePtr.asFunction<_WxTopLevelWindowSetTitle>();

  final wxTopLevelWindowGetTitlePtr = dylib.lookup <NativeFunction<_WxTopLevelWindowGetTitleNative>>('wxTopLevelWindowGetTitle');
  _wxTopLevelWindowGetTitle = wxTopLevelWindowGetTitlePtr.asFunction<_WxTopLevelWindowGetTitle>();

  final wxTopLevelWindowSetMinSizePtr = dylib.lookup <NativeFunction<_WxTopLevelWindowSetMinSizeNative>>('wxTopLevelWindowSetMinSize');
  _wxTopLevelWindowSetMinSize = wxTopLevelWindowSetMinSizePtr.asFunction<_WxTopLevelWindowSetMinSize>();

  final wxTopLevelWindowSetMaxSizePtr = dylib.lookup <NativeFunction<_WxTopLevelWindowSetMaxSizeNative>>('wxTopLevelWindowSetMaxSize');
  _wxTopLevelWindowSetMaxSize = wxTopLevelWindowSetMaxSizePtr.asFunction<_WxTopLevelWindowSetMaxSize>();

  final wxTopLevelWindowMaximizePtr = dylib.lookup <NativeFunction<_WxTopLevelWindowMaximizeNative>>('wxTopLevelWindowMaximize');
  _wxTopLevelWindowMaximize = wxTopLevelWindowMaximizePtr.asFunction<_WxTopLevelWindowMaximize>();

  final wxTopLevelWindowRestorePtr = dylib.lookup <NativeFunction<_WxTopLevelWindowRestoreNative>>('wxTopLevelWindowRestore');
  _wxTopLevelWindowRestore = wxTopLevelWindowRestorePtr.asFunction<_WxTopLevelWindowRestore>();

  final wxTopLevelWindowIsAlwaysMaximizedPtr = dylib.lookup <NativeFunction<_WxTopLevelWindowIsAlwaysMaximizedNative>>('wxTopLevelWindowIsAlwaysMaximized');
  _wxTopLevelWindowIsAlwaysMaximized = wxTopLevelWindowIsAlwaysMaximizedPtr.asFunction<_WxTopLevelWindowIsAlwaysMaximized>();

  final wxTopLevelWindowIsFullScreenPtr = dylib.lookup <NativeFunction<_WxTopLevelWindowIsFullScreenNative>>('wxTopLevelWindowIsFullScreen');
  _wxTopLevelWindowIsFullScreen = wxTopLevelWindowIsFullScreenPtr.asFunction<_WxTopLevelWindowIsFullScreen>();

  final wxTopLevelWindowShowFullScreenPtr = dylib.lookup <NativeFunction<_WxTopLevelWindowShowFullScreenNative>>('wxTopLevelWindowShowFullScreen');
  _wxTopLevelWindowShowFullScreen = wxTopLevelWindowShowFullScreenPtr.asFunction<_WxTopLevelWindowShowFullScreen>();

  final wxTopLevelWindowRequestUserAttentionPtr = dylib.lookup <NativeFunction<_WxTopLevelWindowRequestUserAttentionNative>>('wxTopLevelWindowRequestUserAttention');
  _wxTopLevelWindowRequestUserAttention = wxTopLevelWindowRequestUserAttentionPtr.asFunction<_WxTopLevelWindowRequestUserAttention>();

  final wxTopLevelWindowEnableFullScreenViewPtr = dylib.lookup <NativeFunction<_WxTopLevelWindowEnableFullScreenViewNative>>('wxTopLevelWindowEnableFullScreenView');
  _wxTopLevelWindowEnableFullScreenView = wxTopLevelWindowEnableFullScreenViewPtr.asFunction<_WxTopLevelWindowEnableFullScreenView>();

  final wxTopLevelWindowSetContentProtectionPtr = dylib.lookup <NativeFunction<_WxTopLevelWindowSetContentProtectionNative>>('wxTopLevelWindowSetContentProtection');
  _wxTopLevelWindowSetContentProtection = wxTopLevelWindowSetContentProtectionPtr.asFunction<_WxTopLevelWindowSetContentProtection>();

  final wxTopLevelWindowGetContentProtectionPtr = dylib.lookup <NativeFunction<_WxTopLevelWindowGetContentProtectionNative>>('wxTopLevelWindowGetContentProtection');
  _wxTopLevelWindowGetContentProtection = wxTopLevelWindowGetContentProtectionPtr.asFunction<_WxTopLevelWindowGetContentProtection>();

  final wxTopLevelWindowCanSetTransparentPtr = dylib.lookup <NativeFunction<_WxTopLevelWindowCanSetTransparentNative>>('wxTopLevelWindowCanSetTransparent');
  _wxTopLevelWindowCanSetTransparent = wxTopLevelWindowCanSetTransparentPtr.asFunction<_WxTopLevelWindowCanSetTransparent>();

  final wxTopLevelWindowSetTransparentPtr = dylib.lookup <NativeFunction<_WxTopLevelWindowSetTransparentNative>>('wxTopLevelWindowSetTransparent');
  _wxTopLevelWindowSetTransparent = wxTopLevelWindowSetTransparentPtr.asFunction<_WxTopLevelWindowSetTransparent>();

  final wxTopLevelWindowCentreOnScreenPtr = dylib.lookup <NativeFunction<_WxTopLevelWindowCentreOnScreenNative>>('wxTopLevelWindowCentreOnScreen');
  _wxTopLevelWindowCentreOnScreen = wxTopLevelWindowCentreOnScreenPtr.asFunction<_WxTopLevelWindowCentreOnScreen>();

  final wxTopLevelWindowEnableCloseButtonPtr = dylib.lookup <NativeFunction<_WxTopLevelWindowEnableCloseButtonNative>>('wxTopLevelWindowEnableCloseButton');
  _wxTopLevelWindowEnableCloseButton = wxTopLevelWindowEnableCloseButtonPtr.asFunction<_WxTopLevelWindowEnableCloseButton>();

  final wxTopLevelWindowEnableMaximizeButtonPtr = dylib.lookup <NativeFunction<_WxTopLevelWindowEnableMaximizeButtonNative>>('wxTopLevelWindowEnableMaximizeButton');
  _wxTopLevelWindowEnableMaximizeButton = wxTopLevelWindowEnableMaximizeButtonPtr.asFunction<_WxTopLevelWindowEnableMaximizeButton>();

  final wxTopLevelWindowEnableMinimizeButtonPtr = dylib.lookup <NativeFunction<_WxTopLevelWindowEnableMinimizeButtonNative>>('wxTopLevelWindowEnableMinimizeButton');
  _wxTopLevelWindowEnableMinimizeButton = wxTopLevelWindowEnableMinimizeButtonPtr.asFunction<_WxTopLevelWindowEnableMinimizeButton>();

  final wxTopLevelWindowGetDefaultItemPtr = dylib.lookup <NativeFunction<_WxTopLevelWindowGetDefaultItemNative>>('wxTopLevelWindowGetDefaultItem');
  _wxTopLevelWindowGetDefaultItem = wxTopLevelWindowGetDefaultItemPtr.asFunction<_WxTopLevelWindowGetDefaultItem>();

  // ------------------------- wxFrame ----------------------

  final wxFrameConstructorPtr = dylib.lookup <NativeFunction<_WxFrameConstructorNative>>('wxFrameConstructor');
  _wxFrameConstructor = wxFrameConstructorPtr.asFunction<_WxFrameConstructor>();

  final wxFrameSetMenuBarPtr = dylib.lookup <NativeFunction<_WxFrameSetMenuBarNative>>('wxFrameSetMenuBar');
  _wxFrameSetMenuBar = wxFrameSetMenuBarPtr.asFunction<_WxFrameSetMenuBar>();

  final wxFrameCreateStatusBarPtr = dylib.lookup <NativeFunction<_WxFrameCreateStatusBarNative>>('wxFrameCreateStatusBar');
  _wxFrameCreateStatusBar = wxFrameCreateStatusBarPtr.asFunction<_WxFrameCreateStatusBar>();

  final wxFrameGetStatusBarPtr = dylib.lookup <NativeFunction<_WxFrameGetStatusBarNative>>('wxFrameGetStatusBar');
  _wxFrameGetStatusBar = wxFrameGetStatusBarPtr.asFunction<_WxFrameGetStatusBar>();

  final wxFrameSetStatusTextPtr = dylib.lookup <NativeFunction<_WxFrameSetStatusTextNative>>('wxFrameSetStatusText');
  _wxFrameSetStatusText = wxFrameSetStatusTextPtr.asFunction<_WxFrameSetStatusText>();

  final wxFramePushStatusTextPtr = dylib.lookup <NativeFunction<_WxFramePushStatusTextNative>>('wxFramePushStatusText');
  _wxFramePushStatusText = wxFramePushStatusTextPtr.asFunction<_WxFramePushStatusText>();

  final wxFramePopStatusTextPtr = dylib.lookup <NativeFunction<_WxFramePopStatusTextNative>>('wxFramePopStatusText');
  _wxFramePopStatusText = wxFramePopStatusTextPtr.asFunction<_WxFramePopStatusText>();

  final wxFrameSetStatusWidthsPtr = dylib.lookup <NativeFunction<_WxFrameSetStatusWidthsNative>>('wxFrameSetStatusWidths');
  _wxFrameSetStatusWidths = wxFrameSetStatusWidthsPtr.asFunction<_WxFrameSetStatusWidths>();

  final wxFrameCreateToolBarPtr = dylib.lookup <NativeFunction<_WxFrameCreateToolBarNative>>('wxFrameCreateToolBar');
  _wxFrameCreateToolBar = wxFrameCreateToolBarPtr.asFunction<_WxFrameCreateToolBar>();

  final wxFrameFindItemInMenuBarPtr = dylib.lookup <NativeFunction<_WxFrameFindItemInMenuBarNative>>('wxFrameFindItemInMenuBar');
  _wxFrameFindItemInMenuBar = wxFrameFindItemInMenuBarPtr.asFunction<_WxFrameFindItemInMenuBar>();

  final wxFrameShowInfoBarPtr = dylib.lookup <NativeFunction<_WxFrameShowInfoBarNative>>('wxFrameShowInfoBar');
  _wxFrameShowInfoBar = wxFrameShowInfoBarPtr.asFunction<_WxFrameShowInfoBar>();

  // ------------------------- wxStatusBar ----------------------

  final wxStatusBarConstructorPtr = dylib.lookup <NativeFunction<_WxStatusBarConstructorNative>>('wxStatusBarConstructor');
  _wxStatusBarConstructor = wxStatusBarConstructorPtr.asFunction<_WxStatusBarConstructor>();

  final wxStatusBarSetStatusTextPtr = dylib.lookup <NativeFunction<_WxStatusBarSetStatusTextNative>>('wxStatusBarSetStatusText');
  _wxStatusBarSetStatusText = wxStatusBarSetStatusTextPtr.asFunction<_WxStatusBarSetStatusText>();

  final wxStatusBarGetStatusTextPtr = dylib.lookup <NativeFunction<_WxStatusBarGetStatusTextNative>>('wxStatusBarGetStatusText');
  _wxStatusBarGetStatusText = wxStatusBarGetStatusTextPtr.asFunction<_WxStatusBarGetStatusText>();

  final wxStatusBarSetFieldsCountPtr = dylib.lookup <NativeFunction<_WxStatusBarSetFieldsCountNative>>('wxStatusBarSetFieldsCount');
  _wxStatusBarSetFieldsCount = wxStatusBarSetFieldsCountPtr.asFunction<_WxStatusBarSetFieldsCount>();

  final wxStatusBarGetFieldsCountPtr = dylib.lookup <NativeFunction<_WxStatusBarGetFieldsCountNative>>('wxStatusBarGetFieldsCount');
  _wxStatusBarGetFieldsCount = wxStatusBarGetFieldsCountPtr.asFunction<_WxStatusBarGetFieldsCount>();

  final wxStatusBarPushStatusTextPtr = dylib.lookup <NativeFunction<_WxStatusBarPushStatusTextNative>>('wxStatusBarPushStatusText');
  _wxStatusBarPushStatusText = wxStatusBarPushStatusTextPtr.asFunction<_WxStatusBarPushStatusText>();

  final wxStatusBarPopStatusTextPtr = dylib.lookup <NativeFunction<_WxStatusBarPopStatusTextNative>>('wxStatusBarPopStatusText');
  _wxStatusBarPopStatusText = wxStatusBarPopStatusTextPtr.asFunction<_WxStatusBarPopStatusText>();

  final wxStatusBarSetStatusWidthsPtr = dylib.lookup <NativeFunction<_WxStatusBarSetStatusWidthsNative>>('wxStatusBarSetStatusWidths');
  _wxStatusBarSetStatusWidths = wxStatusBarSetStatusWidthsPtr.asFunction<_WxStatusBarSetStatusWidths>();

  // ------------------------- wxToolBarToolBase ----------------------

  final wxToolBarToolBaseConstructorPtr = dylib.lookup <NativeFunction<_WxToolBarToolBaseConstructorNative>>('wxToolBarToolBaseConstructor');
  _wxToolBarToolBaseConstructor = wxToolBarToolBaseConstructorPtr.asFunction<_WxToolBarToolBaseConstructor>();

  final wxToolBarToolBaseGetIdPtr = dylib.lookup <NativeFunction<_WxToolBarToolBaseGetIdNative>>('wxToolBarToolBaseGetId');
  _wxToolBarToolBaseGetId = wxToolBarToolBaseGetIdPtr.asFunction<_WxToolBarToolBaseGetId>();

  final wxToolBarToolBaseGetLabelPtr = dylib.lookup <NativeFunction<_WxToolBarToolBaseGetLabelNative>>('wxToolBarToolBaseGetLabel');
  _wxToolBarToolBaseGetLabel = wxToolBarToolBaseGetLabelPtr.asFunction<_WxToolBarToolBaseGetLabel>();

  final wxToolBarToolBaseGetKindPtr = dylib.lookup <NativeFunction<_WxToolBarToolBaseGetKindNative>>('wxToolBarToolBaseGetKind');
  _wxToolBarToolBaseGetKind = wxToolBarToolBaseGetKindPtr.asFunction<_WxToolBarToolBaseGetKind>();

  final wxToolBarToolBaseIsControlPtr = dylib.lookup <NativeFunction<_WxToolBarToolBaseIsControlNative>>('wxToolBarToolBaseIsControl');
  _wxToolBarToolBaseIsControl = wxToolBarToolBaseIsControlPtr.asFunction<_WxToolBarToolBaseIsControl>();

  final wxToolBarToolBaseIsStretchablePtr = dylib.lookup <NativeFunction<_WxToolBarToolBaseIsStretchableNative>>('wxToolBarToolBaseIsStretchable');
  _wxToolBarToolBaseIsStretchable = wxToolBarToolBaseIsStretchablePtr.asFunction<_WxToolBarToolBaseIsStretchable>();

  final wxToolBarToolBaseGetControlPtr = dylib.lookup <NativeFunction<_WxToolBarToolBaseGetControlNative>>('wxToolBarToolBaseGetControl');
  _wxToolBarToolBaseGetControl = wxToolBarToolBaseGetControlPtr.asFunction<_WxToolBarToolBaseGetControl>();

  // ------------------------- wxToolBar ----------------------

  final wxToolBarConstructorPtr = dylib.lookup <NativeFunction<_WxToolBarConstructorNative>>('wxToolBarConstructor');
  _wxToolBarConstructor = wxToolBarConstructorPtr.asFunction<_WxToolBarConstructor>();

  final wxToolBarRealizePtr = dylib.lookup <NativeFunction<_WxToolBarRealizeNative>>('wxToolBarRealize');
  _wxToolBarRealize = wxToolBarRealizePtr.asFunction<_WxToolBarRealize>();

  final wxToolBarAddSeparatorPtr = dylib.lookup <NativeFunction<_WxToolBarAddSeparatorNative>>('wxToolBarAddSeparator');
  _wxToolBarAddSeparator = wxToolBarAddSeparatorPtr.asFunction<_WxToolBarAddSeparator>();

  final wxToolBarInsertSeparatorPtr = dylib.lookup <NativeFunction<_WxToolBarInsertSeparatorNative>>('wxToolBarInsertSeparator');
  _wxToolBarInsertSeparator = wxToolBarInsertSeparatorPtr.asFunction<_WxToolBarInsertSeparator>();

  final wxToolBarAddStretchableSpacePtr = dylib.lookup <NativeFunction<_WxToolBarAddStretchableSpaceNative>>('wxToolBarAddStretchableSpace');
  _wxToolBarAddStretchableSpace = wxToolBarAddStretchableSpacePtr.asFunction<_WxToolBarAddStretchableSpace>();

  final wxToolBarInsertStretchableSpacePtr = dylib.lookup <NativeFunction<_WxToolBarInsertStretchableSpaceNative>>('wxToolBarInsertStretchableSpace');
  _wxToolBarInsertStretchableSpace = wxToolBarInsertStretchableSpacePtr.asFunction<_WxToolBarInsertStretchableSpace>();

  final wxToolBarAddToolPtr = dylib.lookup <NativeFunction<_WxToolBarAddToolNative>>('wxToolBarAddTool');
  _wxToolBarAddTool = wxToolBarAddToolPtr.asFunction<_WxToolBarAddTool>();

  final wxToolBarInsertToolPtr = dylib.lookup <NativeFunction<_WxToolBarInsertToolNative>>('wxToolBarInsertTool');
  _wxToolBarInsertTool = wxToolBarInsertToolPtr.asFunction<_WxToolBarInsertTool>();

  final wxToolBarAddCheckToolPtr = dylib.lookup <NativeFunction<_WxToolBarAddCheckToolNative>>('wxToolBarAddCheckTool');
  _wxToolBarAddCheckTool = wxToolBarAddCheckToolPtr.asFunction<_WxToolBarAddCheckTool>();

  final wxToolBarAddRadioToolPtr = dylib.lookup <NativeFunction<_WxToolBarAddRadioToolNative>>('wxToolBarAddRadioTool');
  _wxToolBarAddRadioTool = wxToolBarAddRadioToolPtr.asFunction<_WxToolBarAddRadioTool>();

  final wxToolBarAddControlPtr = dylib.lookup <NativeFunction<_WxToolBarAddControlNative>>('wxToolBarAddControl');
  _wxToolBarAddControl = wxToolBarAddControlPtr.asFunction<_WxToolBarAddControl>();

  final wxToolBarInsertControlPtr = dylib.lookup <NativeFunction<_WxToolBarInsertControlNative>>('wxToolBarInsertControl');
  _wxToolBarInsertControl = wxToolBarInsertControlPtr.asFunction<_WxToolBarInsertControl>();

  final wxToolBarClearToolsPtr = dylib.lookup <NativeFunction<_WxToolBarClearToolsNative>>('wxToolBarClearTools');
  _wxToolBarClearTools = wxToolBarClearToolsPtr.asFunction<_WxToolBarClearTools>();

  final wxToolBarDeleteToolPtr = dylib.lookup <NativeFunction<_WxToolBarDeleteToolNative>>('wxToolBarDeleteTool');
  _wxToolBarDeleteTool = wxToolBarDeleteToolPtr.asFunction<_WxToolBarDeleteTool>();

  final wxToolBarEnableToolPtr = dylib.lookup <NativeFunction<_WxToolBarEnableToolNative>>('wxToolBarEnableTool');
  _wxToolBarEnableTool = wxToolBarEnableToolPtr.asFunction<_WxToolBarEnableTool>();

  final wxToolBarGetToolEnabledPtr = dylib.lookup <NativeFunction<_WxToolBarGetToolEnabledNative>>('wxToolBarGetToolEnabled');
  _wxToolBarGetToolEnabled = wxToolBarGetToolEnabledPtr.asFunction<_WxToolBarGetToolEnabled>();

  final wxToolBarGetToolShortHelpPtr = dylib.lookup <NativeFunction<_WxToolBarGetToolShortHelpNative>>('wxToolBarGetToolShortHelp');
  _wxToolBarGetToolShortHelp = wxToolBarGetToolShortHelpPtr.asFunction<_WxToolBarGetToolShortHelp>();

  final wxToolBarGetToolsCountPtr = dylib.lookup <NativeFunction<_WxToolBarGetToolsCountNative>>('wxToolBarGetToolsCount');
  _wxToolBarGetToolsCount = wxToolBarGetToolsCountPtr.asFunction<_WxToolBarGetToolsCount>();

  final wxToolBarGetToolPosPtr = dylib.lookup <NativeFunction<_WxToolBarGetToolPosNative>>('wxToolBarGetToolPos');
  _wxToolBarGetToolPos = wxToolBarGetToolPosPtr.asFunction<_WxToolBarGetToolPos>();

  final wxToolBarGetToolByPosPtr = dylib.lookup <NativeFunction<_WxToolBarGetToolByPosNative>>('wxToolBarGetToolByPos');
  _wxToolBarGetToolByPos = wxToolBarGetToolByPosPtr.asFunction<_WxToolBarGetToolByPos>();

  final wxToolBarFindByIdPtr = dylib.lookup <NativeFunction<_WxToolBarFindByIdNative>>('wxToolBarFindById');
  _wxToolBarFindById = wxToolBarFindByIdPtr.asFunction<_WxToolBarFindById>();

  final wxToolBarSetToolSeparationPtr = dylib.lookup <NativeFunction<_WxToolBarSetToolSeparationNative>>('wxToolBarSetToolSeparation');
  _wxToolBarSetToolSeparation = wxToolBarSetToolSeparationPtr.asFunction<_WxToolBarSetToolSeparation>();

  final wxToolBarSetToolPackingPtr = dylib.lookup <NativeFunction<_WxToolBarSetToolPackingNative>>('wxToolBarSetToolPacking');
  _wxToolBarSetToolPacking = wxToolBarSetToolPackingPtr.asFunction<_WxToolBarSetToolPacking>();

  final wxToolBarGetToolStatePtr = dylib.lookup <NativeFunction<_WxToolBarGetToolStateNative>>('wxToolBarGetToolState');
  _wxToolBarGetToolState = wxToolBarGetToolStatePtr.asFunction<_WxToolBarGetToolState>();

  final wxToolBarToggleToolPtr = dylib.lookup <NativeFunction<_WxToolBarToggleToolNative>>('wxToolBarToggleTool');
  _wxToolBarToggleTool = wxToolBarToggleToolPtr.asFunction<_WxToolBarToggleTool>();

  final wxToolBarSetDropdownMenuPtr = dylib.lookup <NativeFunction<_WxToolBarSetDropdownMenuNative>>('wxToolBarSetDropdownMenu');
  _wxToolBarSetDropdownMenu = wxToolBarSetDropdownMenuPtr.asFunction<_WxToolBarSetDropdownMenu>();

  // ------------------------- wxDialog ----------------------

  final wxDialogConstructorPtr = dylib.lookup <NativeFunction<_WxDialogConstructorNative>>('wxDialogConstructor');
  _wxDialogConstructor = wxDialogConstructorPtr.asFunction<_WxDialogConstructor>();

  final wxDialogCreateButtonSizerPtr = dylib.lookup <NativeFunction<_WxDialogCreateButtonSizerNative>>('wxDialogCreateButtonSizer');
  _wxDialogCreateButtonSizer = wxDialogCreateButtonSizerPtr.asFunction<_WxDialogCreateButtonSizer>();

  final wxDialogCreateSeparatedButtonSizerPtr = dylib.lookup <NativeFunction<_WxDialogCreateSeparatedButtonSizerNative>>('wxDialogCreateSeparatedButtonSizer');
  _wxDialogCreateSeparatedButtonSizer = wxDialogCreateSeparatedButtonSizerPtr.asFunction<_WxDialogCreateSeparatedButtonSizer>();

  final wxDialogCreateSeparatedSizerPtr = dylib.lookup <NativeFunction<_WxDialogCreateSeparatedSizerNative>>('wxDialogCreateSeparatedSizer');
  _wxDialogCreateSeparatedSizer = wxDialogCreateSeparatedSizerPtr.asFunction<_WxDialogCreateSeparatedSizer>();

  final wxDialogCreateStdDialogButtonSizerPtr = dylib.lookup <NativeFunction<_WxDialogCreateStdDialogButtonSizerNative>>('wxDialogCreateStdDialogButtonSizer');
  _wxDialogCreateStdDialogButtonSizer = wxDialogCreateStdDialogButtonSizerPtr.asFunction<_WxDialogCreateStdDialogButtonSizer>();

  final wxDialogCreateTextSizerPtr = dylib.lookup <NativeFunction<_WxDialogCreateTextSizerNative>>('wxDialogCreateTextSizer');
  _wxDialogCreateTextSizer = wxDialogCreateTextSizerPtr.asFunction<_WxDialogCreateTextSizer>();

  final wxDialogEndModalPtr = dylib.lookup <NativeFunction<_WxDialogEndModalNative>>('wxDialogEndModal');
  _wxDialogEndModal = wxDialogEndModalPtr.asFunction<_WxDialogEndModal>();

  final wxDialog_showModalSyncPtr = dylib.lookup <NativeFunction<_WxDialog_showModalSyncNative>>('wxDialog_showModalSync');
  _wxDialog_showModalSync = wxDialog_showModalSyncPtr.asFunction<_WxDialog_showModalSync>();

  final wxDialogGetReturnCodePtr = dylib.lookup <NativeFunction<_WxDialogGetReturnCodeNative>>('wxDialogGetReturnCode');
  _wxDialogGetReturnCode = wxDialogGetReturnCodePtr.asFunction<_WxDialogGetReturnCode>();

  final wxDialogGetEscapeIdPtr = dylib.lookup <NativeFunction<_WxDialogGetEscapeIdNative>>('wxDialogGetEscapeId');
  _wxDialogGetEscapeId = wxDialogGetEscapeIdPtr.asFunction<_WxDialogGetEscapeId>();

  final wxDialogSetEscapeIdPtr = dylib.lookup <NativeFunction<_WxDialogSetEscapeIdNative>>('wxDialogSetEscapeId');
  _wxDialogSetEscapeId = wxDialogSetEscapeIdPtr.asFunction<_WxDialogSetEscapeId>();

  final wxDialogGetAffirmativeIdPtr = dylib.lookup <NativeFunction<_WxDialogGetAffirmativeIdNative>>('wxDialogGetAffirmativeId');
  _wxDialogGetAffirmativeId = wxDialogGetAffirmativeIdPtr.asFunction<_WxDialogGetAffirmativeId>();

  final wxDialogSetAffirmativeIdPtr = dylib.lookup <NativeFunction<_WxDialogSetAffirmativeIdNative>>('wxDialogSetAffirmativeId');
  _wxDialogSetAffirmativeId = wxDialogSetAffirmativeIdPtr.asFunction<_WxDialogSetAffirmativeId>();

  // ------------------------- wxAppBar ----------------------

  final wxAppBarConstructorPtr = dylib.lookup <NativeFunction<_WxAppBarConstructorNative>>('wxAppBarConstructor');
  _wxAppBarConstructor = wxAppBarConstructorPtr.asFunction<_WxAppBarConstructor>();

  final wxAppBarAttachPtr = dylib.lookup <NativeFunction<_WxAppBarAttachNative>>('wxAppBarAttach');
  _wxAppBarAttach = wxAppBarAttachPtr.asFunction<_WxAppBarAttach>();

  final wxAppBarAddActionPtr = dylib.lookup <NativeFunction<_WxAppBarAddActionNative>>('wxAppBarAddAction');
  _wxAppBarAddAction = wxAppBarAddActionPtr.asFunction<_WxAppBarAddAction>();

  // ------------------------- wxAdaptiveFrame ----------------------

  final wxAdaptiveFrameConstructorPtr = dylib.lookup <NativeFunction<_WxAdaptiveFrameConstructorNative>>('wxAdaptiveFrameConstructor');
  _wxAdaptiveFrameConstructor = wxAdaptiveFrameConstructorPtr.asFunction<_WxAdaptiveFrameConstructor>();

  final wxAdaptiveFrameCreateAppBarPtr = dylib.lookup <NativeFunction<_WxAdaptiveFrameCreateAppBarNative>>('wxAdaptiveFrameCreateAppBar');
  _wxAdaptiveFrameCreateAppBar = wxAdaptiveFrameCreateAppBarPtr.asFunction<_WxAdaptiveFrameCreateAppBar>();

  final wxAdaptiveFrameCreateFloatingActionButtonPtr = dylib.lookup <NativeFunction<_WxAdaptiveFrameCreateFloatingActionButtonNative>>('wxAdaptiveFrameCreateFloatingActionButton');
  _wxAdaptiveFrameCreateFloatingActionButton = wxAdaptiveFrameCreateFloatingActionButtonPtr.asFunction<_WxAdaptiveFrameCreateFloatingActionButton>();

  final wxAdaptiveFrameGetFloatingActionButtonPtr = dylib.lookup <NativeFunction<_WxAdaptiveFrameGetFloatingActionButtonNative>>('wxAdaptiveFrameGetFloatingActionButton');
  _wxAdaptiveFrameGetFloatingActionButton = wxAdaptiveFrameGetFloatingActionButtonPtr.asFunction<_WxAdaptiveFrameGetFloatingActionButton>();

  final wxAdaptiveFrameCloseDrawerPtr = dylib.lookup <NativeFunction<_WxAdaptiveFrameCloseDrawerNative>>('wxAdaptiveFrameCloseDrawer');
  _wxAdaptiveFrameCloseDrawer = wxAdaptiveFrameCloseDrawerPtr.asFunction<_WxAdaptiveFrameCloseDrawer>();

  final wxAdaptiveFrameOpenDrawerPtr = dylib.lookup <NativeFunction<_WxAdaptiveFrameOpenDrawerNative>>('wxAdaptiveFrameOpenDrawer');
  _wxAdaptiveFrameOpenDrawer = wxAdaptiveFrameOpenDrawerPtr.asFunction<_WxAdaptiveFrameOpenDrawer>();

  final wxAdaptiveFrameSetDrawerFromWindowPtr = dylib.lookup <NativeFunction<_WxAdaptiveFrameSetDrawerFromWindowNative>>('wxAdaptiveFrameSetDrawerFromWindow');
  _wxAdaptiveFrameSetDrawerFromWindow = wxAdaptiveFrameSetDrawerFromWindowPtr.asFunction<_WxAdaptiveFrameSetDrawerFromWindow>();

  final wxAdaptiveFrameSetDrawerFromStandardMenuBarPtr = dylib.lookup <NativeFunction<_WxAdaptiveFrameSetDrawerFromStandardMenuBarNative>>('wxAdaptiveFrameSetDrawerFromStandardMenuBar');
  _wxAdaptiveFrameSetDrawerFromStandardMenuBar = wxAdaptiveFrameSetDrawerFromStandardMenuBarPtr.asFunction<_WxAdaptiveFrameSetDrawerFromStandardMenuBar>();

  final wxAdaptiveFrameSetDrawerFromMenuBarPtr = dylib.lookup <NativeFunction<_WxAdaptiveFrameSetDrawerFromMenuBarNative>>('wxAdaptiveFrameSetDrawerFromMenuBar');
  _wxAdaptiveFrameSetDrawerFromMenuBar = wxAdaptiveFrameSetDrawerFromMenuBarPtr.asFunction<_WxAdaptiveFrameSetDrawerFromMenuBar>();

  final wxAdaptiveFrameSetDrawerTitlePtr = dylib.lookup <NativeFunction<_WxAdaptiveFrameSetDrawerTitleNative>>('wxAdaptiveFrameSetDrawerTitle');
  _wxAdaptiveFrameSetDrawerTitle = wxAdaptiveFrameSetDrawerTitlePtr.asFunction<_WxAdaptiveFrameSetDrawerTitle>();

}
