// -------------------------------------------------------------
// Purpose:     Dart bindings for wxWidgets
// Author:      Robert Roebling
// Modified by: The magic C++ to Dart code generator
// Created:     07/01/2025
// Copyright:   (c) Robert Roebling
// Licence:     wxWindows licence 3.1
// -------------------------------------------------------------

part of '../wx_dart.dart';

// ------------------------- wxGraphicsObject ----------------------

class WxGraphicsObject extends WxObject {
  WxGraphicsObject._defaultConstructor() : super._defaultConstructor();
  WxGraphicsObject.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }
}

// ------------------------- wxGraphicsBitmap ----------------------

typedef _WxGraphicsBitmapConstructorNative = Pointer Function(  );
typedef _WxGraphicsBitmapConstructor = Pointer Function(  );
late _WxGraphicsBitmapConstructor _wxGraphicsBitmapConstructor;

class WxGraphicsBitmap extends WxGraphicsObject {
  WxGraphicsBitmap._defaultConstructor() : super._defaultConstructor();
  WxGraphicsBitmap( ) : super._defaultConstructor() {
    nativeHandle = _wxGraphicsBitmapConstructor(  );
    attachFinalizer();
  }
  WxGraphicsBitmap.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    attachFinalizer();
  }
}

// ------------------------- wxGraphicsPath ----------------------

typedef _WxGraphicsPathConstructorNative = Pointer Function(  );
typedef _WxGraphicsPathConstructor = Pointer Function(  );
late _WxGraphicsPathConstructor _wxGraphicsPathConstructor;

typedef _WxGraphicsPathMoveToNative = Void Function( Pointer, Double, Double  );
typedef _WxGraphicsPathMoveTo = void Function( Pointer, double, double  );
late _WxGraphicsPathMoveTo _wxGraphicsPathMoveTo;

typedef _WxGraphicsPathCloseSubpathNative = Void Function( Pointer  );
typedef _WxGraphicsPathCloseSubpath = void Function( Pointer  );
late _WxGraphicsPathCloseSubpath _wxGraphicsPathCloseSubpath;

typedef _WxGraphicsPathAddLineToNative = Void Function( Pointer, Double, Double  );
typedef _WxGraphicsPathAddLineTo = void Function( Pointer, double, double  );
late _WxGraphicsPathAddLineTo _wxGraphicsPathAddLineTo;

typedef _WxGraphicsPathAddPathNative = Void Function( Pointer, Pointer  );
typedef _WxGraphicsPathAddPath = void Function( Pointer, Pointer  );
late _WxGraphicsPathAddPath _wxGraphicsPathAddPath;

typedef _WxGraphicsPathAddRectangleNative = Void Function( Pointer, Double, Double, Double, Double  );
typedef _WxGraphicsPathAddRectangle = void Function( Pointer, double, double, double, double  );
late _WxGraphicsPathAddRectangle _wxGraphicsPathAddRectangle;

typedef _WxGraphicsPathAddRoundedRectangleNative = Void Function( Pointer, Double, Double, Double, Double, Double  );
typedef _WxGraphicsPathAddRoundedRectangle = void Function( Pointer, double, double, double, double, double  );
late _WxGraphicsPathAddRoundedRectangle _wxGraphicsPathAddRoundedRectangle;

typedef _WxGraphicsPathAddCircleNative = Void Function( Pointer, Double, Double, Double  );
typedef _WxGraphicsPathAddCircle = void Function( Pointer, double, double, double  );
late _WxGraphicsPathAddCircle _wxGraphicsPathAddCircle;

typedef _WxGraphicsPathAddEllipseNative = Void Function( Pointer, Double, Double, Double, Double  );
typedef _WxGraphicsPathAddEllipse = void Function( Pointer, double, double, double, double  );
late _WxGraphicsPathAddEllipse _wxGraphicsPathAddEllipse;

typedef _WxGraphicsPathAddArcNative = Void Function( Pointer, Double, Double, Double, Double, Double, Bool  );
typedef _WxGraphicsPathAddArc = void Function( Pointer, double, double, double, double, double, bool  );
late _WxGraphicsPathAddArc _wxGraphicsPathAddArc;

class WxGraphicsPath extends WxGraphicsObject {
  WxGraphicsPath._defaultConstructor() : super._defaultConstructor();
  WxGraphicsPath( ) : super._defaultConstructor() {
    nativeHandle = _wxGraphicsPathConstructor(  );
    attachFinalizer();
  }
  WxGraphicsPath.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    attachFinalizer();
  }

  void moveTo( double x, double y ) {
    _wxGraphicsPathMoveTo( nativeHandle, x, y );
  }

  void closeSubpath( ) {
    _wxGraphicsPathCloseSubpath( nativeHandle  );
  }

  void addLineTo( double x, double y ) {
    _wxGraphicsPathAddLineTo( nativeHandle, x, y );
  }

  void addPath( WxGraphicsPath path ) {
    _wxGraphicsPathAddPath( nativeHandle, path.nativeHandle );
  }

  void addRectangle( double x, double y, double width, double height ) {
    _wxGraphicsPathAddRectangle( nativeHandle, x, y, width, height );
  }

  void addRoundedRectangle( double x, double y, double width, double height, double radius ) {
    _wxGraphicsPathAddRoundedRectangle( nativeHandle, x, y, width, height, radius );
  }

  void addCircle( double x, double y, double radius ) {
    _wxGraphicsPathAddCircle( nativeHandle, x, y, radius );
  }

  void addEllipse( double x, double y, double width, double height ) {
    _wxGraphicsPathAddEllipse( nativeHandle, x, y, width, height );
  }

  void addArc( double x, double y, double radius, double startAngle, double endAngle, bool clockwise ) {
    _wxGraphicsPathAddArc( nativeHandle, x, y, radius, startAngle, endAngle, clockwise );
  }
}

// ------------------------- wxGraphicsContext ----------------------

typedef _WxGraphicsContextConstructorNative = Pointer Function(  );
typedef _WxGraphicsContextConstructor = Pointer Function(  );
late _WxGraphicsContextConstructor _wxGraphicsContextConstructor;

typedef _WxGraphicsContextConstructorFromDCNative = Pointer Function( Pointer  );
typedef _WxGraphicsContextConstructorFromDC = Pointer Function( Pointer  );
late _WxGraphicsContextConstructorFromDC _wxGraphicsContextConstructorFromDC;
typedef _WxGraphicsContextConstructorFromMemoryDCNative = Pointer Function( Pointer  );
typedef _WxGraphicsContextConstructorFromMemoryDC = Pointer Function( Pointer  );
late _WxGraphicsContextConstructorFromMemoryDC _wxGraphicsContextConstructorFromMemoryDC;
typedef _WxGraphicsContextStartDocNative = Void Function( Pointer, Pointer<Utf8>  );
typedef _WxGraphicsContextStartDoc = void Function( Pointer, Pointer<Utf8>  );
late _WxGraphicsContextStartDoc _wxGraphicsContextStartDoc;

typedef _WxGraphicsContextEndDocNative = Void Function( Pointer  );
typedef _WxGraphicsContextEndDoc = void Function( Pointer  );
late _WxGraphicsContextEndDoc _wxGraphicsContextEndDoc;

typedef _WxGraphicsContextStartPageNative = Void Function( Pointer, Double, Double  );
typedef _WxGraphicsContextStartPage = void Function( Pointer, double, double  );
late _WxGraphicsContextStartPage _wxGraphicsContextStartPage;

typedef _WxGraphicsContextEndPageNative = Void Function( Pointer  );
typedef _WxGraphicsContextEndPage = void Function( Pointer  );
late _WxGraphicsContextEndPage _wxGraphicsContextEndPage;

typedef _WxGraphicsContextFlushNative = Void Function( Pointer  );
typedef _WxGraphicsContextFlush = void Function( Pointer  );
late _WxGraphicsContextFlush _wxGraphicsContextFlush;

typedef _WxGraphicsContextSetFontNative = Void Function( Pointer, Pointer, Uint32  );
typedef _WxGraphicsContextSetFont = void Function( Pointer, Pointer, int  );
late _WxGraphicsContextSetFont _wxGraphicsContextSetFont;

typedef _WxGraphicsContextGetTextExtentNative = WxSizeNative Function( Pointer, Pointer<Utf8>  );
typedef _WxGraphicsContextGetTextExtent = WxSizeNative Function( Pointer, Pointer<Utf8>  );
late _WxGraphicsContextGetTextExtent _wxGraphicsContextGetTextExtent;

typedef _WxGraphicsContextSetPenNative = Void Function( Pointer, Uint32, Int32, Int32, Int32, Int32  );
typedef _WxGraphicsContextSetPen = void Function( Pointer, int, int, int, int, int  );
late _WxGraphicsContextSetPen _wxGraphicsContextSetPen;

typedef _WxGraphicsContextSetPenWithConstantColourNative = Void Function( Pointer, Uint32, Double, Int32, Int32, Int32  );
typedef _WxGraphicsContextSetPenWithConstantColour = void Function( Pointer, int, double, int, int, int  );
late _WxGraphicsContextSetPenWithConstantColour _wxGraphicsContextSetPenWithConstantColour;

typedef _WxGraphicsContextSetPenWithLinearGradientNative = Void Function( Pointer, Double, Double, Double, Double, Uint32, Uint32, Double, Int32, Int32, Int32  );
typedef _WxGraphicsContextSetPenWithLinearGradient = void Function( Pointer, double, double, double, double, int, int, double, int, int, int  );
late _WxGraphicsContextSetPenWithLinearGradient _wxGraphicsContextSetPenWithLinearGradient;

typedef _WxGraphicsContextSetPenWithRadialGradientNative = Void Function( Pointer, Double, Double, Double, Double, Double, Uint32, Uint32, Double, Int32, Int32, Int32  );
typedef _WxGraphicsContextSetPenWithRadialGradient = void Function( Pointer, double, double, double, double, double, int, int, double, int, int, int  );
late _WxGraphicsContextSetPenWithRadialGradient _wxGraphicsContextSetPenWithRadialGradient;

typedef _WxGraphicsContextSetBrushNative = Void Function( Pointer, Uint32, Int32  );
typedef _WxGraphicsContextSetBrush = void Function( Pointer, int, int  );
late _WxGraphicsContextSetBrush _wxGraphicsContextSetBrush;

typedef _WxGraphicsContextSetCompositionModeNative = Bool Function( Pointer, Int32  );
typedef _WxGraphicsContextSetCompositionMode = bool Function( Pointer, int  );
late _WxGraphicsContextSetCompositionMode _wxGraphicsContextSetCompositionMode;

typedef _WxGraphicsContextCreateBitmapNative = Pointer Function( Pointer, Pointer  );
typedef _WxGraphicsContextCreateBitmap = Pointer Function( Pointer, Pointer  );
late _WxGraphicsContextCreateBitmap _wxGraphicsContextCreateBitmap;

typedef _WxGraphicsContextCreateBitmapFromImageNative = Pointer Function( Pointer, Pointer  );
typedef _WxGraphicsContextCreateBitmapFromImage = Pointer Function( Pointer, Pointer  );
late _WxGraphicsContextCreateBitmapFromImage _wxGraphicsContextCreateBitmapFromImage;

typedef _WxGraphicsContextClipNative = Void Function( Pointer, Double, Double, Double, Double  );
typedef _WxGraphicsContextClip = void Function( Pointer, double, double, double, double  );
late _WxGraphicsContextClip _wxGraphicsContextClip;

typedef _WxGraphicsContextResetClipNative = Void Function( Pointer  );
typedef _WxGraphicsContextResetClip = void Function( Pointer  );
late _WxGraphicsContextResetClip _wxGraphicsContextResetClip;

typedef _WxGraphicsContextPushStateNative = Void Function( Pointer  );
typedef _WxGraphicsContextPushState = void Function( Pointer  );
late _WxGraphicsContextPushState _wxGraphicsContextPushState;

typedef _WxGraphicsContextPopStateNative = Void Function( Pointer  );
typedef _WxGraphicsContextPopState = void Function( Pointer  );
late _WxGraphicsContextPopState _wxGraphicsContextPopState;

typedef _WxGraphicsContextRotateNative = Void Function( Pointer, Double  );
typedef _WxGraphicsContextRotate = void Function( Pointer, double  );
late _WxGraphicsContextRotate _wxGraphicsContextRotate;

typedef _WxGraphicsContextTranslateNative = Void Function( Pointer, Double, Double  );
typedef _WxGraphicsContextTranslate = void Function( Pointer, double, double  );
late _WxGraphicsContextTranslate _wxGraphicsContextTranslate;

typedef _WxGraphicsContextScaleNative = Void Function( Pointer, Double, Double  );
typedef _WxGraphicsContextScale = void Function( Pointer, double, double  );
late _WxGraphicsContextScale _wxGraphicsContextScale;

typedef _WxGraphicsContextCreatePathNative = Pointer Function( Pointer  );
typedef _WxGraphicsContextCreatePath = Pointer Function( Pointer  );
late _WxGraphicsContextCreatePath _wxGraphicsContextCreatePath;

typedef _WxGraphicsContextStrokePathNative = Void Function( Pointer, Pointer  );
typedef _WxGraphicsContextStrokePath = void Function( Pointer, Pointer  );
late _WxGraphicsContextStrokePath _wxGraphicsContextStrokePath;

typedef _WxGraphicsContextFillPathNative = Void Function( Pointer, Pointer, Int32  );
typedef _WxGraphicsContextFillPath = void Function( Pointer, Pointer, int  );
late _WxGraphicsContextFillPath _wxGraphicsContextFillPath;

typedef _WxGraphicsContextDrawPathNative = Void Function( Pointer, Pointer, Int32  );
typedef _WxGraphicsContextDrawPath = void Function( Pointer, Pointer, int  );
late _WxGraphicsContextDrawPath _wxGraphicsContextDrawPath;

typedef _WxGraphicsContextStrokeLineNative = Void Function( Pointer, Double, Double, Double, Double  );
typedef _WxGraphicsContextStrokeLine = void Function( Pointer, double, double, double, double  );
late _WxGraphicsContextStrokeLine _wxGraphicsContextStrokeLine;

typedef _WxGraphicsContextStrokeLinesNative = Void Function( Pointer, Pointer  );
typedef _WxGraphicsContextStrokeLines = void Function( Pointer, Pointer  );
late _WxGraphicsContextStrokeLines _wxGraphicsContextStrokeLines;

typedef _WxGraphicsContextDrawEllipseNative = Void Function( Pointer, Double, Double, Double, Double  );
typedef _WxGraphicsContextDrawEllipse = void Function( Pointer, double, double, double, double  );
late _WxGraphicsContextDrawEllipse _wxGraphicsContextDrawEllipse;

typedef _WxGraphicsContextDrawRectangleNative = Void Function( Pointer, Double, Double, Double, Double  );
typedef _WxGraphicsContextDrawRectangle = void Function( Pointer, double, double, double, double  );
late _WxGraphicsContextDrawRectangle _wxGraphicsContextDrawRectangle;

typedef _WxGraphicsContextDrawRoundedRectangleNative = Void Function( Pointer, Double, Double, Double, Double, Double  );
typedef _WxGraphicsContextDrawRoundedRectangle = void Function( Pointer, double, double, double, double, double  );
late _WxGraphicsContextDrawRoundedRectangle _wxGraphicsContextDrawRoundedRectangle;

typedef _WxGraphicsContextDrawBitmapNative = Void Function( Pointer, Pointer, Double, Double, Double, Double  );
typedef _WxGraphicsContextDrawBitmap = void Function( Pointer, Pointer, double, double, double, double  );
late _WxGraphicsContextDrawBitmap _wxGraphicsContextDrawBitmap;

typedef _WxGraphicsContextDrawTextNative = Void Function( Pointer, Pointer<Utf8>, Double, Double  );
typedef _WxGraphicsContextDrawText = void Function( Pointer, Pointer<Utf8>, double, double  );
late _WxGraphicsContextDrawText _wxGraphicsContextDrawText;

/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxCOMPOSITION_INVALID | -1 |
/// | wxCOMPOSITION_CLEAR | 0 |
/// | wxCOMPOSITION_SOURCE | 1 |
/// | wxCOMPOSITION_OVER | 2 |
/// | wxCOMPOSITION_IN | 3 |
/// | wxCOMPOSITION_OUT | 4 |
/// | wxCOMPOSITION_ATOP | 5 |
/// | wxCOMPOSITION_DEST | 6 |
/// | wxCOMPOSITION_DEST_OVER | 7 |
/// | wxCOMPOSITION_DEST_IN | 8 |
/// | wxCOMPOSITION_DEST_OUT | 9 |
/// | wxCOMPOSITION_DEST_ATOP | 10 |
/// | wxCOMPOSITION_XOR | 11 |
/// | wxCOMPOSITION_ADD | 12 |
/// | wxCOMPOSITION_DIFF | 13 |

const int wxCOMPOSITION_INVALID = -1;
const int wxCOMPOSITION_CLEAR = 0;
const int wxCOMPOSITION_SOURCE = 1;
const int wxCOMPOSITION_OVER = 2;
const int wxCOMPOSITION_IN = 3;
const int wxCOMPOSITION_OUT = 4;
const int wxCOMPOSITION_ATOP = 5;
const int wxCOMPOSITION_DEST = 6;
const int wxCOMPOSITION_DEST_OVER = 7;
const int wxCOMPOSITION_DEST_IN = 8;
const int wxCOMPOSITION_DEST_OUT = 9;
const int wxCOMPOSITION_DEST_ATOP = 10;
const int wxCOMPOSITION_XOR = 11;
const int wxCOMPOSITION_ADD = 12;
const int wxCOMPOSITION_DIFF = 13;

class WxGraphicsContext extends WxGraphicsObject {
  WxGraphicsContext._defaultConstructor() : super._defaultConstructor();
  WxGraphicsContext( ) : super._defaultConstructor() {
    nativeHandle = _wxGraphicsContextConstructor(  );
    attachFinalizer();
  }
  WxGraphicsContext.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }
  WxGraphicsContext.fromDC( WxPaintDC dc ) : super._defaultConstructor() {
    nativeHandle = _wxGraphicsContextConstructorFromDC( dc.nativeHandle );
    attachFinalizer();
   _theGraphicsContext = this;
  }
  WxGraphicsContext.fromMemoryDC( WxMemoryDC dc ) : super._defaultConstructor() {
    nativeHandle = _wxGraphicsContextConstructorFromMemoryDC( dc.nativeHandle );
    attachFinalizer();
   _theGraphicsContext = this;
  }

  void startDoc( String message ) {
    final messageUtf8 = message.toNativeUtf8();
    _wxGraphicsContextStartDoc( nativeHandle, messageUtf8 );
    malloc.free( messageUtf8 );
  }

  void endDoc( ) {
    _wxGraphicsContextEndDoc( nativeHandle  );
  }

  void startPage( double width, double height ) {
    _wxGraphicsContextStartPage( nativeHandle, width, height );
  }

  void endPage( ) {
    _wxGraphicsContextEndPage( nativeHandle  );
  }

  void flush( ) {
    _wxGraphicsContextFlush( nativeHandle  );
  }

  void setFont( WxFont? font, WxColour colour ) {
    _wxGraphicsContextSetFont( nativeHandle, (font == null) ? nullptr : font.nativeHandle, colour.getRGBA() );
  }

  WxSize getTextExtent( String text ) {
    final textUtf8 = text.toNativeUtf8();
    final WxSizeNative sizeReturn = _wxGraphicsContextGetTextExtent( nativeHandle, textUtf8 );
    malloc.free( textUtf8 );
    return WxSize(sizeReturn.x, sizeReturn.y);
  }

  void setPen( WxPen pen ) {
    _wxGraphicsContextSetPen( nativeHandle, pen.colour.getRGBA(), pen.width, pen.style, pen.capStyle, pen.joinStyle );
  }

  void setPenWithConstantColour( WxColour colour, { double width = 1.0, int style = wxPENSTYLE_SOLID, int cap = wxCAP_ROUND, int join = wxJOIN_MITER } ) {
    _wxGraphicsContextSetPenWithConstantColour( nativeHandle, colour.getRGBA(), width, style, cap, join );
  }

  void setPenWithLinearGradient( double x1, double y1, double x2, double y2, WxColour colour1, WxColour colour2, { double width = 1.0, int style = wxPENSTYLE_SOLID, int cap = wxCAP_ROUND, int join = wxJOIN_MITER } ) {
    _wxGraphicsContextSetPenWithLinearGradient( nativeHandle, x1, y1, x2, y2, colour1.getRGBA(), colour2.getRGBA(), width, style, cap, join );
  }

  void setPenWithRadialGradient( double startX, double startY, double endX, double endY, double radius, WxColour outerColour, WxColour innerColour, { double width = 1.0, int style = wxPENSTYLE_SOLID, int cap = wxCAP_ROUND, int join = wxJOIN_MITER } ) {
    _wxGraphicsContextSetPenWithRadialGradient( nativeHandle, startX, startY, endX, endY, radius, outerColour.getRGBA(), innerColour.getRGBA(), width, style, cap, join );
  }

  void setBrush( WxBrush brush ) {
    _wxGraphicsContextSetBrush( nativeHandle, brush.colour.getRGBA(), brush.style );
  }

  bool setCompositionMode( int mode ) {
    return _wxGraphicsContextSetCompositionMode( nativeHandle, mode );
  }

  WxGraphicsBitmap createBitmap( WxBitmap bitmap ) {
    final returnedNativeHandle = _wxGraphicsContextCreateBitmap( nativeHandle, bitmap.nativeHandle );
    return WxGraphicsBitmap.fromHandle( returnedNativeHandle );
  }

  WxGraphicsBitmap createBitmapFromImage( WxImage image ) {
    final returnedNativeHandle = _wxGraphicsContextCreateBitmapFromImage( nativeHandle, image.nativeHandle );
    return WxGraphicsBitmap.fromHandle( returnedNativeHandle );
  }

  void clip( double x, double y, double width, double height ) {
    _wxGraphicsContextClip( nativeHandle, x, y, width, height );
  }

  void resetClip( ) {
    _wxGraphicsContextResetClip( nativeHandle  );
  }

  void pushState( ) {
    _wxGraphicsContextPushState( nativeHandle  );
  }

  void popState( ) {
    _wxGraphicsContextPopState( nativeHandle  );
  }

  void rotate( double angle ) {
    _wxGraphicsContextRotate( nativeHandle, angle );
  }

  void translate( double x, double y ) {
    _wxGraphicsContextTranslate( nativeHandle, x, y );
  }

  void scale( double xScale, double yScale ) {
    _wxGraphicsContextScale( nativeHandle, xScale, yScale );
  }

  WxGraphicsPath createPath( ) {
    final returnedNativeHandle = _wxGraphicsContextCreatePath( nativeHandle  );
    return WxGraphicsPath.fromHandle( returnedNativeHandle );
  }

  void strokePath( WxGraphicsPath path ) {
    _wxGraphicsContextStrokePath( nativeHandle, path.nativeHandle );
  }

  void fillPath( WxGraphicsPath path, { int fillStyle = wxODDEVEN_RULE } ) {
    _wxGraphicsContextFillPath( nativeHandle, path.nativeHandle, fillStyle );
  }

  void drawPath( WxGraphicsPath path, { int fillStyle = wxODDEVEN_RULE } ) {
    _wxGraphicsContextDrawPath( nativeHandle, path.nativeHandle, fillStyle );
  }

  void strokeLine( double x1, double y1, double x2, double y2 ) {
    _wxGraphicsContextStrokeLine( nativeHandle, x1, y1, x2, y2 );
  }

  void strokeLines( List<WxRealPoint> lines ) {
    final linesList = wxListToRealPointList( lines );
    _wxGraphicsContextStrokeLines( nativeHandle, linesList.nativeHandle );
    // linesList.dispose();
  }

  void drawEllipse( double x, double y, double width, double height ) {
    _wxGraphicsContextDrawEllipse( nativeHandle, x, y, width, height );
  }

  void drawRectangle( double x, double y, double width, double height ) {
    _wxGraphicsContextDrawRectangle( nativeHandle, x, y, width, height );
  }

  void drawRoundedRectangle( double x, double y, double width, double height, double radius ) {
    _wxGraphicsContextDrawRoundedRectangle( nativeHandle, x, y, width, height, radius );
  }

  void drawBitmap( WxGraphicsBitmap bitmap, double x, double y, double width, double height ) {
    _wxGraphicsContextDrawBitmap( nativeHandle, bitmap.nativeHandle, x, y, width, height );
  }

  void drawText( String text, double x, double y ) {
    final textUtf8 = text.toNativeUtf8();
    _wxGraphicsContextDrawText( nativeHandle, textUtf8, x, y );
    malloc.free( textUtf8 );
  }
}

// ------------------------- wxRealPointList ----------------------

typedef _WxRealPointListConstructorNative = Pointer Function(  );
typedef _WxRealPointListConstructor = Pointer Function(  );
late _WxRealPointListConstructor _wxRealPointListConstructor;

typedef _WxRealPointListDestructorNative = Pointer Function( Pointer );
typedef _WxRealPointListDestructor = Pointer Function( Pointer );
late _WxRealPointListDestructor _wxRealPointListDestructor;

typedef _WxRealPointListFinalizerNative = Pointer Function( Pointer );
late NativeFinalizer _wxRealPointListNativeFinalizer;

typedef _WxRealPointListAddNative = Void Function( Pointer, Double, Double  );
typedef _WxRealPointListAdd = void Function( Pointer, double, double  );
late _WxRealPointListAdd _wxRealPointListAdd;

class WxRealPointList extends WxClass {
  WxRealPointList._defaultConstructor() : super._defaultConstructor();
  WxRealPointList( ) {
    nativeHandle = _wxRealPointListConstructor(  );
    attachFinalizer();
  }
  WxRealPointList.fromHandle( Pointer handle ) {
    nativeHandle = handle;
    ownsHandle = false;
  }
  @override
  void nativeDestroy() {
    nativeHandle = _wxRealPointListDestructor( nativeHandle );
  }

  @override
  void attachFinalizer() {
    hasFinalizer = true;
    _wxRealPointListNativeFinalizer.attach( this, nativeHandle.cast(), detach: this );
  }

  @override
  void detachFinalizer() {
     hasFinalizer = false;
     _wxRealPointListNativeFinalizer.detach( this );
  }


  void add( WxRealPoint point ) {
    _wxRealPointListAdd( nativeHandle, point.x, point.y );
  }
}

// ------------------------- wxPointList ----------------------

typedef _WxPointListConstructorNative = Pointer Function(  );
typedef _WxPointListConstructor = Pointer Function(  );
late _WxPointListConstructor _wxPointListConstructor;

typedef _WxPointListDestructorNative = Pointer Function( Pointer );
typedef _WxPointListDestructor = Pointer Function( Pointer );
late _WxPointListDestructor _wxPointListDestructor;

typedef _WxPointListFinalizerNative = Pointer Function( Pointer );
late NativeFinalizer _wxPointListNativeFinalizer;

typedef _WxPointListAddNative = Void Function( Pointer, Int32, Int32  );
typedef _WxPointListAdd = void Function( Pointer, int, int  );
late _WxPointListAdd _wxPointListAdd;

typedef _WxPointListDeleteContentsNative = Void Function( Pointer, Bool  );
typedef _WxPointListDeleteContents = void Function( Pointer, bool  );
late _WxPointListDeleteContents _wxPointListDeleteContents;

class WxPointList extends WxClass {
  WxPointList._defaultConstructor() : super._defaultConstructor();
  WxPointList( ) {
    nativeHandle = _wxPointListConstructor(  );
    attachFinalizer();
  }
  WxPointList.fromHandle( Pointer handle ) {
    nativeHandle = handle;
    ownsHandle = false;
  }
  @override
  void nativeDestroy() {
    nativeHandle = _wxPointListDestructor( nativeHandle );
  }

  @override
  void attachFinalizer() {
    hasFinalizer = true;
    _wxPointListNativeFinalizer.attach( this, nativeHandle.cast(), detach: this );
  }

  @override
  void detachFinalizer() {
     hasFinalizer = false;
     _wxPointListNativeFinalizer.detach( this );
  }


  void add( WxPoint point ) {
    _wxPointListAdd( nativeHandle, point.x, point.y );
  }

  void deleteContents( bool destroy ) {
    _wxPointListDeleteContents( nativeHandle, destroy );
  }
}

// ------------------------- wxImage ----------------------

typedef _WxImageConstructorNative = Pointer Function( Int32, Int32, Bool  );
typedef _WxImageConstructor = Pointer Function( int, int, bool  );
late _WxImageConstructor _wxImageConstructor;

typedef _WxImageConstructorFromFileNative = Pointer Function( Pointer<Utf8>, Int32, Int32  );
typedef _WxImageConstructorFromFile = Pointer Function( Pointer<Utf8>, int, int  );
late _WxImageConstructorFromFile _wxImageConstructorFromFile;
typedef _WxImageInitAlphaNative = Void Function( Pointer  );
typedef _WxImageInitAlpha = void Function( Pointer  );
late _WxImageInitAlpha _wxImageInitAlpha;

typedef _WxImageClearAlphaNative = Void Function( Pointer  );
typedef _WxImageClearAlpha = void Function( Pointer  );
late _WxImageClearAlpha _wxImageClearAlpha;

typedef _WxImageHasAlphaNative = Bool Function( Pointer  );
typedef _WxImageHasAlpha = bool Function( Pointer  );
late _WxImageHasAlpha _wxImageHasAlpha;

typedef _WxImageGetWidthNative = Int32 Function( Pointer  );
typedef _WxImageGetWidth = int Function( Pointer  );
late _WxImageGetWidth _wxImageGetWidth;

typedef _WxImageGetHeightNative = Int32 Function( Pointer  );
typedef _WxImageGetHeight = int Function( Pointer  );
late _WxImageGetHeight _wxImageGetHeight;

typedef _WxImageIsOkNative = Bool Function( Pointer  );
typedef _WxImageIsOk = bool Function( Pointer  );
late _WxImageIsOk _wxImageIsOk;

typedef _WxImageSetRGBNative = Void Function( Pointer, Int32, Int32, Int32, Int32, Int32  );
typedef _WxImageSetRGB = void Function( Pointer, int, int, int, int, int  );
late _WxImageSetRGB _wxImageSetRGB;

typedef _WxImageSetAlphaNative = Void Function( Pointer, Int32, Int32, Int32  );
typedef _WxImageSetAlpha = void Function( Pointer, int, int, int  );
late _WxImageSetAlpha _wxImageSetAlpha;

typedef _WxImageGetRedNative = Int32 Function( Pointer, Int32, Int32  );
typedef _WxImageGetRed = int Function( Pointer, int, int  );
late _WxImageGetRed _wxImageGetRed;

typedef _WxImageGetGreenNative = Int32 Function( Pointer, Int32, Int32  );
typedef _WxImageGetGreen = int Function( Pointer, int, int  );
late _WxImageGetGreen _wxImageGetGreen;

typedef _WxImageGetBlueNative = Int32 Function( Pointer, Int32, Int32  );
typedef _WxImageGetBlue = int Function( Pointer, int, int  );
late _WxImageGetBlue _wxImageGetBlue;

typedef _WxImageGetAlphaNative = Int32 Function( Pointer, Int32, Int32  );
typedef _WxImageGetAlpha = int Function( Pointer, int, int  );
late _WxImageGetAlpha _wxImageGetAlpha;

typedef _WxImageGetDataNative = Pointer<Uint8> Function( Pointer  );
typedef _WxImageGetData = Pointer<Uint8> Function( Pointer  );
late _WxImageGetData _wxImageGetData;

typedef _WxImageGetAlphaDataNative = Pointer<Uint8> Function( Pointer  );
typedef _WxImageGetAlphaData = Pointer<Uint8> Function( Pointer  );
late _WxImageGetAlphaData _wxImageGetAlphaData;

typedef _WxImageReplaceNative = Void Function( Pointer, Int32, Int32, Int32, Int32, Int32, Int32  );
typedef _WxImageReplace = void Function( Pointer, int, int, int, int, int, int  );
late _WxImageReplace _wxImageReplace;

typedef _WxImageCopyNative = Pointer Function( Pointer  );
typedef _WxImageCopy = Pointer Function( Pointer  );
late _WxImageCopy _wxImageCopy;

typedef _WxImageGetSubImageNative = Pointer Function( Pointer, Int32, Int32, Int32, Int32  );
typedef _WxImageGetSubImage = Pointer Function( Pointer, int, int, int, int  );
late _WxImageGetSubImage _wxImageGetSubImage;

typedef _WxImageScaleNative = Pointer Function( Pointer, Int32, Int32, Int32  );
typedef _WxImageScale = Pointer Function( Pointer, int, int, int  );
late _WxImageScale _wxImageScale;

/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxIMAGE_QUALITY_NORMAL | 0 |
/// | wxIMAGE_QUALITY_NEAREST | 5 |
/// | wxIMAGE_QUALITY_BILINEAR | 1 |
/// | wxIMAGE_QUALITY_BICUBIC | 2 |
/// | wxIMAGE_QUALITY_BOX_AVERAGE | 3 |
/// | wxIMAGE_QUALITY_HIGH | 4 |

const int wxIMAGE_QUALITY_NORMAL = 0;
const int wxIMAGE_QUALITY_NEAREST = 5;
const int wxIMAGE_QUALITY_BILINEAR = 1;
const int wxIMAGE_QUALITY_BICUBIC = 2;
const int wxIMAGE_QUALITY_BOX_AVERAGE = 3;
const int wxIMAGE_QUALITY_HIGH = 4;

class WxImage extends WxObject {
  WxImage._defaultConstructor() : super._defaultConstructor();
  WxImage( int x, int y, { bool clear = true } ) : super._defaultConstructor() {
    nativeHandle = _wxImageConstructor( x, y, clear );
    attachFinalizer();
  }
  WxImage.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }
  WxImage.fromFile( String file, int format, { int index = -1 } ) : super._defaultConstructor() {
    final fileUtf8 = file.toNativeUtf8();
    nativeHandle = _wxImageConstructorFromFile( fileUtf8, format, index );
    malloc.free( fileUtf8 );
    attachFinalizer();
  }

  WxImage.fromRGB( int width, int height, Uint8List rgb ) : super._defaultConstructor() {
    nativeHandle = _wxImageConstructor( width, height, false );
    final data = getData();
    for (int i = 0; i < width * height * 3; i++) {
      data[i] = rgb[i];
    }
    attachFinalizer();
  }

  WxImage.fromRGBA( int width, int height, Uint8List rgba ) : super._defaultConstructor() {
    nativeHandle = _wxImageConstructor( width, height, false );
    initAlpha();
    final data = getData();
    final alpha = getAlphaData()!;
    int rgbaIndex = 0;
    int rgbIndex = 0;
    int alphaIndex = 0;
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
          data[rgbIndex] = rgba[rgbaIndex];
          rgbaIndex++;
          rgbIndex++;
          data[rgbIndex] = rgba[rgbaIndex];
          rgbaIndex++;
          rgbIndex++;
          data[rgbIndex] = rgba[rgbaIndex];
          rgbaIndex++;
          rgbIndex++;
          alpha[alphaIndex] = rgba[rgbaIndex];
          rgbaIndex++;
          alphaIndex++;
      }
    }
    attachFinalizer();
  }

  Uint8List getRGBA()
  {
    final rgba = Uint8List( getWidth() * getHeight() * 4 );
    final rgb = getData();
    final alpha = getAlphaData();
    int rgbIndex = 0;
    int rgbaIndex = 0;
    int alphaIndex = 0;
    for (int y = 0; y < getHeight(); y++) {
      for (int x = 0; x < getWidth(); x++) {
        rgba[rgbaIndex] = rgb[rgbIndex];
        rgbaIndex++;
        rgbIndex++;
        rgba[rgbaIndex] = rgb[rgbIndex];
        rgbaIndex++;
        rgbIndex++;
        rgba[rgbaIndex] = rgb[rgbIndex];
        rgbaIndex++;
        rgbIndex++;
        if (alpha != null) {
          rgba[rgbaIndex] = alpha[alphaIndex];
          alphaIndex++;
        } else {
          rgba[rgbaIndex] = 255;
        }
        rgbaIndex++;
        }
      }
    return rgba;
  }

  void initAlpha( ) {
    _wxImageInitAlpha( nativeHandle  );
  }

  void clearAlpha( ) {
    _wxImageClearAlpha( nativeHandle  );
  }

  bool hasAlpha( ) {
    return _wxImageHasAlpha( nativeHandle  );
  }

  int getWidth( ) {
    return _wxImageGetWidth( nativeHandle  );
  }

  int getHeight( ) {
    return _wxImageGetHeight( nativeHandle  );
  }

  bool isOk( ) {
    return _wxImageIsOk( nativeHandle  );
  }

  void setRGB( int x, int y, int red, int green, int blue ) {
    _wxImageSetRGB( nativeHandle, x, y, red, green, blue );
  }

  void setAlpha( int x, int y, int alpha ) {
    _wxImageSetAlpha( nativeHandle, x, y, alpha );
  }

  int getRed( int x, int y ) {
    return _wxImageGetRed( nativeHandle, x, y );
  }

  int getGreen( int x, int y ) {
    return _wxImageGetGreen( nativeHandle, x, y );
  }

  int getBlue( int x, int y ) {
    return _wxImageGetBlue( nativeHandle, x, y );
  }

  int getAlpha( int x, int y ) {
    return _wxImageGetAlpha( nativeHandle, x, y );
  }

  Uint8List getData( ) {
    Pointer<Uint8> ptrReturn = _wxImageGetData( nativeHandle  );
    return  ptrReturn.asTypedList(getHeight()*getWidth()*3);
  }

  Uint8List? getAlphaData( ) {
    Pointer<Uint8> ptrReturn = _wxImageGetAlphaData( nativeHandle  );
    if (ptrReturn == nullptr) return null;
    return  ptrReturn.asTypedList(getHeight()*getWidth());
  }

  void replace( int r1, int g1, int b1, int r2, int g2, int b2 ) {
    _wxImageReplace( nativeHandle, r1, g1, b1, r2, g2, b2 );
  }

  WxImage? copy( ) {
    final returnedNativeHandle = _wxImageCopy( nativeHandle  );
    if (returnedNativeHandle == nullptr) return null;
    return WxImage.fromHandle( returnedNativeHandle );
  }

  WxImage? getSubImage( WxRect rect ) {
    final returnedNativeHandle = _wxImageGetSubImage( nativeHandle, rect.x, rect.y, rect.width, rect.height );
    if (returnedNativeHandle == nullptr) return null;
    return WxImage.fromHandle( returnedNativeHandle );
  }

  WxImage? scale( int width, int height, { int quality = wxIMAGE_QUALITY_NORMAL } ) {
    final returnedNativeHandle = _wxImageScale( nativeHandle, width, height, quality );
    if (returnedNativeHandle == nullptr) return null;
    return WxImage.fromHandle( returnedNativeHandle );
  }
}

// ------------------------- wxVectorBitmapBundle ----------------------

typedef _WxVectorBitmapBundleConstructorNative = Pointer Function(  );
typedef _WxVectorBitmapBundleConstructor = Pointer Function(  );
late _WxVectorBitmapBundleConstructor _wxVectorBitmapBundleConstructor;

typedef _WxVectorBitmapBundleDestructorNative = Pointer Function( Pointer );
typedef _WxVectorBitmapBundleDestructor = Pointer Function( Pointer );
late _WxVectorBitmapBundleDestructor _wxVectorBitmapBundleDestructor;

typedef _WxVectorBitmapBundleFinalizerNative = Pointer Function( Pointer );
late NativeFinalizer _wxVectorBitmapBundleNativeFinalizer;

typedef _WxVectorBitmapBundleAddNative = Void Function( Pointer, Pointer  );
typedef _WxVectorBitmapBundleAdd = void Function( Pointer, Pointer  );
late _WxVectorBitmapBundleAdd _wxVectorBitmapBundleAdd;

class WxVectorBitmapBundle extends WxClass {
  WxVectorBitmapBundle._defaultConstructor() : super._defaultConstructor();
  WxVectorBitmapBundle( ) {
    nativeHandle = _wxVectorBitmapBundleConstructor(  );
    attachFinalizer();
  }
  WxVectorBitmapBundle.fromHandle( Pointer handle ) {
    nativeHandle = handle;
    ownsHandle = false;
  }
  @override
  void nativeDestroy() {
    nativeHandle = _wxVectorBitmapBundleDestructor( nativeHandle );
  }

  @override
  void attachFinalizer() {
    hasFinalizer = true;
    _wxVectorBitmapBundleNativeFinalizer.attach( this, nativeHandle.cast(), detach: this );
  }

  @override
  void detachFinalizer() {
     hasFinalizer = false;
     _wxVectorBitmapBundleNativeFinalizer.detach( this );
  }


  void add( WxBitmapBundle bundle ) {
    _wxVectorBitmapBundleAdd( nativeHandle, bundle.nativeHandle );
  }
}

// ------------------------- wxBitmap ----------------------

typedef _WxBitmapConstructorNative = Pointer Function( Int32, Int32, Int32  );
typedef _WxBitmapConstructor = Pointer Function( int, int, int  );
late _WxBitmapConstructor _wxBitmapConstructor;

typedef _WxBitmapConstructorFromAssetNative = Pointer Function( Pointer<Utf8>, Int32  );
typedef _WxBitmapConstructorFromAsset = Pointer Function( Pointer<Utf8>, int  );
late _WxBitmapConstructorFromAsset _wxBitmapConstructorFromAsset;
typedef _WxBitmapConstructorFromImageNative = Pointer Function( Pointer  );
typedef _WxBitmapConstructorFromImage = Pointer Function( Pointer  );
late _WxBitmapConstructorFromImage _wxBitmapConstructorFromImage;
typedef _WxBitmapConstructorFromMaterialIconNative = Pointer Function( Pointer<Utf8>, Int32, Int32, Uint32  );
typedef _WxBitmapConstructorFromMaterialIcon = Pointer Function( Pointer<Utf8>, int, int, int  );
late _WxBitmapConstructorFromMaterialIcon _wxBitmapConstructorFromMaterialIcon;
typedef _WxBitmap_convertToImageSyncNative = Pointer Function( Pointer  );
typedef _WxBitmap_convertToImageSync = Pointer Function( Pointer  );
late _WxBitmap_convertToImageSync _wxBitmap_convertToImageSync;

typedef _WxBitmapGetLogicalWidthNative = Double Function( Pointer  );
typedef _WxBitmapGetLogicalWidth = double Function( Pointer  );
late _WxBitmapGetLogicalWidth _wxBitmapGetLogicalWidth;

typedef _WxBitmapGetLogicalHeightNative = Double Function( Pointer  );
typedef _WxBitmapGetLogicalHeight = double Function( Pointer  );
late _WxBitmapGetLogicalHeight _wxBitmapGetLogicalHeight;

typedef _WxBitmapGetScaleFactorNative = Double Function( Pointer  );
typedef _WxBitmapGetScaleFactor = double Function( Pointer  );
late _WxBitmapGetScaleFactor _wxBitmapGetScaleFactor;

typedef _WxBitmapSetScaleFactorNative = Void Function( Pointer, Double  );
typedef _WxBitmapSetScaleFactor = void Function( Pointer, double  );
late _WxBitmapSetScaleFactor _wxBitmapSetScaleFactor;

typedef _WxBitmapGetWidthNative = Int32 Function( Pointer  );
typedef _WxBitmapGetWidth = int Function( Pointer  );
late _WxBitmapGetWidth _wxBitmapGetWidth;

typedef _WxBitmapGetHeightNative = Int32 Function( Pointer  );
typedef _WxBitmapGetHeight = int Function( Pointer  );
late _WxBitmapGetHeight _wxBitmapGetHeight;

typedef _WxBitmapIsOkNative = Bool Function( Pointer  );
typedef _WxBitmapIsOk = bool Function( Pointer  );
late _WxBitmapIsOk _wxBitmapIsOk;

/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxBITMAP_TYPE_BMP | 1 |
/// | wxBITMAP_TYPE_GIF | 13 |
/// | wxBITMAP_TYPE_PNG | 15 |
/// | wxBITMAP_TYPE_JPEG | 17 |
/// | wxBITMAP_TYPE_WEBP | 32 |
/// | wxBITMAP_TYPE_ANY | 50 |

const int wxBITMAP_TYPE_BMP = 1;
const int wxBITMAP_TYPE_GIF = 13;
const int wxBITMAP_TYPE_PNG = 15;
const int wxBITMAP_TYPE_JPEG = 17;
const int wxBITMAP_TYPE_WEBP = 32;
const int wxBITMAP_TYPE_ANY = 50;

class WxBitmap extends WxObject {
  WxBitmap._defaultConstructor() : super._defaultConstructor();
  WxBitmap( int width, int height, { int bits = 24 } ) : super._defaultConstructor() {
    nativeHandle = _wxBitmapConstructor( width, height, bits );
    attachFinalizer();
  }
  WxBitmap.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    attachFinalizer();
  }
  WxBitmap.fromAsset( String path, int format ) : super._defaultConstructor() {
    path = _wxConvertToAssetPath( path );
    final pathUtf8 = path.toNativeUtf8();
    nativeHandle = _wxBitmapConstructorFromAsset( pathUtf8, format );
    malloc.free( pathUtf8 );
    attachFinalizer();
  }
  WxBitmap.fromImage( WxImage image ) : super._defaultConstructor() {
    nativeHandle = _wxBitmapConstructorFromImage( image.nativeHandle );
    attachFinalizer();
  }
  WxBitmap.fromMaterialIcon( WxMaterialIcon icon, WxSize size, WxColour? colour ) : super._defaultConstructor() {
    colour ??= wxGREY;
    final iconArtId = wxMaterialArtIdFromId(icon);
    final iconUtf8 = iconArtId.toNativeUtf8();
    nativeHandle = _wxBitmapConstructorFromMaterialIcon( iconUtf8, size.x, size.y, colour.getRGBA() );
    malloc.free( iconUtf8 );
    attachFinalizer();
  }
  WxBitmap.fromUIImage( ui.Image image ) {
    wxLogError( "WxBitmap.fromUIImage not implemented in wxDart Native" );
  }

  Future<WxImage?> convertToImage() async {
    return _convertToImageSync();
  }

  // WxBitmap is not asynchronous in wxDart Native
  Future<bool> waitUntilOk({int maxMillis = 2000}) async => isOk();
  
  WxImage? _convertToImageSync( ) {
    final returnedNativeHandle = _wxBitmap_convertToImageSync( nativeHandle  );
    if (returnedNativeHandle == nullptr) return null;
    return WxImage.fromHandle( returnedNativeHandle );
  }

  double getLogicalWidth( ) {
    return _wxBitmapGetLogicalWidth( nativeHandle  );
  }

  double getLogicalHeight( ) {
    return _wxBitmapGetLogicalHeight( nativeHandle  );
  }

  double getScaleFactor( ) {
    return _wxBitmapGetScaleFactor( nativeHandle  );
  }

  void setScaleFactor( double factor ) {
    _wxBitmapSetScaleFactor( nativeHandle, factor );
  }

  int getWidth( ) {
    return _wxBitmapGetWidth( nativeHandle  );
  }

  int getHeight( ) {
    return _wxBitmapGetHeight( nativeHandle  );
  }

  bool isOk( ) {
    return _wxBitmapIsOk( nativeHandle  );
  }
}

// ------------------------- wxBitmapBundle ----------------------

typedef _WxBitmapBundleConstructorNative = Pointer Function( Pointer  );
typedef _WxBitmapBundleConstructor = Pointer Function( Pointer  );
late _WxBitmapBundleConstructor _wxBitmapBundleConstructor;

typedef _WxBitmapBundleDestructorNative = Pointer Function( Pointer );
typedef _WxBitmapBundleDestructor = Pointer Function( Pointer );
late _WxBitmapBundleDestructor _wxBitmapBundleDestructor;

typedef _WxBitmapBundleFinalizerNative = Pointer Function( Pointer );
late NativeFinalizer _wxBitmapBundleNativeFinalizer;

typedef _WxBitmapBundleConstructorFromMaterialIconNative = Pointer Function( Pointer<Utf8>, Int32, Int32, Uint32  );
typedef _WxBitmapBundleConstructorFromMaterialIcon = Pointer Function( Pointer<Utf8>, int, int, int  );
late _WxBitmapBundleConstructorFromMaterialIcon _wxBitmapBundleConstructorFromMaterialIcon;
typedef _WxBitmapBundleConstructorFromJPEGAssetNative = Pointer Function( Pointer<Utf8>  );
typedef _WxBitmapBundleConstructorFromJPEGAsset = Pointer Function( Pointer<Utf8>  );
late _WxBitmapBundleConstructorFromJPEGAsset _wxBitmapBundleConstructorFromJPEGAsset;
typedef _WxBitmapBundleConstructorFromPNGAssetNative = Pointer Function( Pointer<Utf8>  );
typedef _WxBitmapBundleConstructorFromPNGAsset = Pointer Function( Pointer<Utf8>  );
late _WxBitmapBundleConstructorFromPNGAsset _wxBitmapBundleConstructorFromPNGAsset;
typedef _WxBitmapBundleConstructorFromSVGAssetNative = Pointer Function( Pointer<Utf8>, Int32, Int32  );
typedef _WxBitmapBundleConstructorFromSVGAsset = Pointer Function( Pointer<Utf8>, int, int  );
late _WxBitmapBundleConstructorFromSVGAsset _wxBitmapBundleConstructorFromSVGAsset;
typedef _WxBitmapBundleConstructorFromBitmapNative = Pointer Function( Pointer  );
typedef _WxBitmapBundleConstructorFromBitmap = Pointer Function( Pointer  );
late _WxBitmapBundleConstructorFromBitmap _wxBitmapBundleConstructorFromBitmap;
typedef _WxBitmapBundleConstructorFromBitmapsNative = Pointer Function( Pointer, Pointer  );
typedef _WxBitmapBundleConstructorFromBitmaps = Pointer Function( Pointer, Pointer  );
late _WxBitmapBundleConstructorFromBitmaps _wxBitmapBundleConstructorFromBitmaps;
typedef _WxBitmapBundleConstructorFromImageNative = Pointer Function( Pointer  );
typedef _WxBitmapBundleConstructorFromImage = Pointer Function( Pointer  );
late _WxBitmapBundleConstructorFromImage _wxBitmapBundleConstructorFromImage;
typedef _WxBitmapBundleConstructorFromSVGNative = Pointer Function( Pointer<Utf8>, Int32, Int32  );
typedef _WxBitmapBundleConstructorFromSVG = Pointer Function( Pointer<Utf8>, int, int  );
late _WxBitmapBundleConstructorFromSVG _wxBitmapBundleConstructorFromSVG;
typedef _WxBitmapBundleConstructorFromSVGFileNative = Pointer Function( Pointer<Utf8>, Int32, Int32  );
typedef _WxBitmapBundleConstructorFromSVGFile = Pointer Function( Pointer<Utf8>, int, int  );
late _WxBitmapBundleConstructorFromSVGFile _wxBitmapBundleConstructorFromSVGFile;
typedef _WxBitmapBundleGetBitmapForNative = Pointer Function( Pointer, Pointer  );
typedef _WxBitmapBundleGetBitmapFor = Pointer Function( Pointer, Pointer  );
late _WxBitmapBundleGetBitmapFor _wxBitmapBundleGetBitmapFor;

typedef _WxBitmapBundleGetBitmapNative = Pointer Function( Pointer, Int32, Int32  );
typedef _WxBitmapBundleGetBitmap = Pointer Function( Pointer, int, int  );
late _WxBitmapBundleGetBitmap _wxBitmapBundleGetBitmap;

typedef _WxBitmapBundleGetDefaultSizeNative = WxSizeNative Function( Pointer  );
typedef _WxBitmapBundleGetDefaultSize = WxSizeNative Function( Pointer  );
late _WxBitmapBundleGetDefaultSize _wxBitmapBundleGetDefaultSize;

typedef _WxBitmapBundleMakeDisabledNative = Pointer Function( Pointer  );
typedef _WxBitmapBundleMakeDisabled = Pointer Function( Pointer  );
late _WxBitmapBundleMakeDisabled _wxBitmapBundleMakeDisabled;

class WxBitmapBundle extends WxClass {
  WxBitmapBundle._defaultConstructor() : super._defaultConstructor();
  WxBitmapBundle( WxBitmap bitmap ) : super._defaultConstructor() {
    nativeHandle = _wxBitmapBundleConstructor( bitmap.nativeHandle );
    attachFinalizer();
  }
  WxBitmapBundle.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    attachFinalizer();
  }
  WxBitmapBundle.fromMaterialIcon( WxMaterialIcon icon, WxSize size, { WxColour? colour } ) : super._defaultConstructor() {
    final iconArtId = wxMaterialArtIdFromId(icon);
    final iconUtf8 = iconArtId.toNativeUtf8();
    colour ??= wxMEDIUM_GREY;
    nativeHandle = _wxBitmapBundleConstructorFromMaterialIcon( iconUtf8, size.x, size.y, colour.getRGBA() );
    malloc.free( iconUtf8 );
    attachFinalizer();
  }
  WxBitmapBundle.fromJPEGAsset( String path ) : super._defaultConstructor() {
    path = _wxConvertToAssetPath( path );
    final pathUtf8 = path.toNativeUtf8();
    nativeHandle = _wxBitmapBundleConstructorFromJPEGAsset( pathUtf8 );
    malloc.free( pathUtf8 );
    attachFinalizer();
  }
  WxBitmapBundle.fromPNGAsset( String path ) : super._defaultConstructor() {
    path = _wxConvertToAssetPath( path );
    final pathUtf8 = path.toNativeUtf8();
    nativeHandle = _wxBitmapBundleConstructorFromPNGAsset( pathUtf8 );
    malloc.free( pathUtf8 );
    attachFinalizer();
  }
  WxBitmapBundle.fromSVGAsset( String path, WxSize sizeDef ) : super._defaultConstructor() {
    path = _wxConvertToAssetPath( path );
    final pathUtf8 = path.toNativeUtf8();
    nativeHandle = _wxBitmapBundleConstructorFromSVGAsset( pathUtf8, sizeDef.x, sizeDef.y );
    malloc.free( pathUtf8 );
    attachFinalizer();
  }
  WxBitmapBundle.fromBitmap( WxBitmap bitmap ) : super._defaultConstructor() {
    nativeHandle = _wxBitmapBundleConstructorFromBitmap( bitmap.nativeHandle );
    attachFinalizer();
  }
  WxBitmapBundle.fromBitmaps( WxBitmap bitmap1, WxBitmap bitmap2 ) : super._defaultConstructor() {
    nativeHandle = _wxBitmapBundleConstructorFromBitmaps( bitmap1.nativeHandle, bitmap2.nativeHandle );
    attachFinalizer();
  }
  WxBitmapBundle.fromImage( WxImage image ) : super._defaultConstructor() {
    nativeHandle = _wxBitmapBundleConstructorFromImage( image.nativeHandle );
    attachFinalizer();
  }
  WxBitmapBundle.fromSVG( String svg, WxSize sizeDef ) : super._defaultConstructor() {
    final svgUtf8 = svg.toNativeUtf8();
    nativeHandle = _wxBitmapBundleConstructorFromSVG( svgUtf8, sizeDef.x, sizeDef.y );
    malloc.free( svgUtf8 );
    attachFinalizer();
  }
  WxBitmapBundle.fromSVGFile( String path, WxSize sizeDef ) : super._defaultConstructor() {
    final pathUtf8 = path.toNativeUtf8();
    nativeHandle = _wxBitmapBundleConstructorFromSVGFile( pathUtf8, sizeDef.x, sizeDef.y );
    malloc.free( pathUtf8 );
    attachFinalizer();
  }
  @override
  void nativeDestroy() {
    nativeHandle = _wxBitmapBundleDestructor( nativeHandle );
  }

  @override
  void attachFinalizer() {
    hasFinalizer = true;
    _wxBitmapBundleNativeFinalizer.attach( this, nativeHandle.cast(), detach: this );
  }

  @override
  void detachFinalizer() {
     hasFinalizer = false;
     _wxBitmapBundleNativeFinalizer.detach( this );
  }

  WxBitmap getBitmapForSize( WxWindow window, WxSize dipSize )
  {
    final phys = WxSize( window.fromDIP( dipSize.width ),
                         window.fromDIP( dipSize.height ) );
    final bitmap = getBitmap( phys );
    bitmap.setScaleFactor( phys.height / dipSize.height );
    return bitmap;
  }

  WxBitmap getBitmapFor( WxWindow window ) {
    final returnedNativeHandle = _wxBitmapBundleGetBitmapFor( nativeHandle, window.nativeHandle );
    return WxBitmap.fromHandle( returnedNativeHandle );
  }

  WxBitmap getBitmap( WxSize size ) {
    final returnedNativeHandle = _wxBitmapBundleGetBitmap( nativeHandle, size.x, size.y );
    return WxBitmap.fromHandle( returnedNativeHandle );
  }

  WxSize getDefaultSize( ) {
    final WxSizeNative sizeReturn = _wxBitmapBundleGetDefaultSize( nativeHandle  );
    return WxSize(sizeReturn.x, sizeReturn.y);
  }

  WxBitmapBundle makeDisabled( ) {
    final returnedNativeHandle = _wxBitmapBundleMakeDisabled( nativeHandle  );
    return WxBitmapBundle.fromHandle( returnedNativeHandle );
  }
}

// ------------------------- wxCursor ----------------------

typedef _WxCursorConstructorNative = Pointer Function( Int32  );
typedef _WxCursorConstructor = Pointer Function( int  );
late _WxCursorConstructor _wxCursorConstructor;

typedef _WxCursorIsOkNative = Bool Function( Pointer  );
typedef _WxCursorIsOk = bool Function( Pointer  );
late _WxCursorIsOk _wxCursorIsOk;

class WxCursor extends WxObject {
  WxCursor._defaultConstructor() : super._defaultConstructor();
  WxCursor( int stockCursor ) : super._defaultConstructor() {
    nativeHandle = _wxCursorConstructor( stockCursor );
    attachFinalizer();
  }
  WxCursor.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    attachFinalizer();
  }

  bool isOk( ) {
    return _wxCursorIsOk( nativeHandle  );
  }
}

// ------------------------- wxFont ----------------------

typedef _WxFontConstructorNative = Pointer Function( Double, Int32, Int32, Int32, Bool  );
typedef _WxFontConstructor = Pointer Function( double, int, int, int, bool  );
late _WxFontConstructor _wxFontConstructor;

typedef _WxFontConstructorFromPixelSizeNative = Pointer Function( Int32, Int32, Int32, Int32, Int32, Bool  );
typedef _WxFontConstructorFromPixelSize = Pointer Function( int, int, int, int, int, bool  );
late _WxFontConstructorFromPixelSize _wxFontConstructorFromPixelSize;
typedef _WxFontIsOkNative = Bool Function( Pointer  );
typedef _WxFontIsOk = bool Function( Pointer  );
late _WxFontIsOk _wxFontIsOk;

typedef _WxFontGetPointSizeNative = Double Function( Pointer  );
typedef _WxFontGetPointSize = double Function( Pointer  );
late _WxFontGetPointSize _wxFontGetPointSize;

typedef _WxFontGetPixelSizeNative = WxSizeNative Function( Pointer  );
typedef _WxFontGetPixelSize = WxSizeNative Function( Pointer  );
late _WxFontGetPixelSize _wxFontGetPixelSize;

typedef _WxFontGetFamilyNative = Int32 Function( Pointer  );
typedef _WxFontGetFamily = int Function( Pointer  );
late _WxFontGetFamily _wxFontGetFamily;

typedef _WxFontGetWeightNative = Int32 Function( Pointer  );
typedef _WxFontGetWeight = int Function( Pointer  );
late _WxFontGetWeight _wxFontGetWeight;

typedef _WxFontGetStyleNative = Int32 Function( Pointer  );
typedef _WxFontGetStyle = int Function( Pointer  );
late _WxFontGetStyle _wxFontGetStyle;

typedef _WxFontGetUnderlinedNative = Bool Function( Pointer  );
typedef _WxFontGetUnderlined = bool Function( Pointer  );
late _WxFontGetUnderlined _wxFontGetUnderlined;

typedef _WxFontGetStrikethroughNative = Bool Function( Pointer  );
typedef _WxFontGetStrikethrough = bool Function( Pointer  );
late _WxFontGetStrikethrough _wxFontGetStrikethrough;

typedef _WxFontMakeLargerNative = Void Function( Pointer  );
typedef _WxFontMakeLarger = void Function( Pointer  );
late _WxFontMakeLarger _wxFontMakeLarger;

typedef _WxFontMakeSmallerNative = Void Function( Pointer  );
typedef _WxFontMakeSmaller = void Function( Pointer  );
late _WxFontMakeSmaller _wxFontMakeSmaller;

typedef _WxFontBoldNative = Pointer Function( Pointer  );
typedef _WxFontBold = Pointer Function( Pointer  );
late _WxFontBold _wxFontBold;

typedef _WxFontItalicNative = Pointer Function( Pointer  );
typedef _WxFontItalic = Pointer Function( Pointer  );
late _WxFontItalic _wxFontItalic;

typedef _WxFontScaledNative = Pointer Function( Pointer, Double  );
typedef _WxFontScaled = Pointer Function( Pointer, double  );
late _WxFontScaled _wxFontScaled;

/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxFONTFAMILY_DEFAULT | 70 |
/// | wxFONTFAMILY_DECORATIVE | 71 |
/// | wxFONTFAMILY_ROMAN | 72 |
/// | wxFONTFAMILY_SCRIPT | 73 |
/// | wxFONTFAMILY_SWISS | 74 |
/// | wxFONTFAMILY_MODERN | 75 |
/// | wxFONTFAMILY_TELETYPE | 76 |
/// | wxFONTSTYLE_NORMAL | 90 |
/// | wxFONTSTYLE_ITALIC | 93 |
/// | wxFONTSTYLE_SLANT | 94 |
/// | wxFONTWEIGHT_INVALID | 0 |
/// | wxFONTWEIGHT_THIN | 100 |
/// | wxFONTWEIGHT_EXTRALIGHT | 200 |
/// | wxFONTWEIGHT_LIGHT | 300 |
/// | wxFONTWEIGHT_NORMAL | 400 |
/// | wxFONTWEIGHT_MEDIUM | 500 |
/// | wxFONTWEIGHT_SEMIBOLD | 600 |
/// | wxFONTWEIGHT_BOLD | 700 |
/// | wxFONTWEIGHT_EXTRABOLD | 800 |
/// | wxFONTWEIGHT_HEAVY | 900 |
/// | wxFONTWEIGHT_EXTRAHEAVY | 1000 |

const int wxFONTFAMILY_DEFAULT = 70;
const int wxFONTFAMILY_DECORATIVE = 71;
const int wxFONTFAMILY_ROMAN = 72;
const int wxFONTFAMILY_SCRIPT = 73;
const int wxFONTFAMILY_SWISS = 74;
const int wxFONTFAMILY_MODERN = 75;
const int wxFONTFAMILY_TELETYPE = 76;
const int wxFONTSTYLE_NORMAL = 90;
const int wxFONTSTYLE_ITALIC = 93;
const int wxFONTSTYLE_SLANT = 94;
const int wxFONTWEIGHT_INVALID = 0;
const int wxFONTWEIGHT_THIN = 100;
const int wxFONTWEIGHT_EXTRALIGHT = 200;
const int wxFONTWEIGHT_LIGHT = 300;
const int wxFONTWEIGHT_NORMAL = 400;
const int wxFONTWEIGHT_MEDIUM = 500;
const int wxFONTWEIGHT_SEMIBOLD = 600;
const int wxFONTWEIGHT_BOLD = 700;
const int wxFONTWEIGHT_EXTRABOLD = 800;
const int wxFONTWEIGHT_HEAVY = 900;
const int wxFONTWEIGHT_EXTRAHEAVY = 1000;

class WxFont extends WxObject {
  WxFont._defaultConstructor() : super._defaultConstructor();
  WxFont( double pointSize, { int family = wxFONTFAMILY_DEFAULT, int style = wxFONTSTYLE_NORMAL, int weight = wxFONTWEIGHT_NORMAL, bool underline = false } ) : super._defaultConstructor() {
    nativeHandle = _wxFontConstructor( pointSize, family, style, weight, underline );
    attachFinalizer();
  }
  WxFont.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    attachFinalizer();
  }
  WxFont.fromPixelSize( WxSize pixelSize, { int family = wxFONTFAMILY_DEFAULT, int style = wxFONTSTYLE_NORMAL, int weight = wxFONTWEIGHT_NORMAL, bool underline = false } ) : super._defaultConstructor() {
    nativeHandle = _wxFontConstructorFromPixelSize( pixelSize.x, pixelSize.y, family, style, weight, underline );
    attachFinalizer();
  }

  bool isOk( ) {
    return _wxFontIsOk( nativeHandle  );
  }

  double getPointSize( ) {
    return _wxFontGetPointSize( nativeHandle  );
  }

  WxSize getPixelSize( ) {
    final WxSizeNative sizeReturn = _wxFontGetPixelSize( nativeHandle  );
    return WxSize(sizeReturn.x, sizeReturn.y);
  }

  int getFamily( ) {
    return _wxFontGetFamily( nativeHandle  );
  }

  int getWeight( ) {
    return _wxFontGetWeight( nativeHandle  );
  }

  int getStyle( ) {
    return _wxFontGetStyle( nativeHandle  );
  }

  bool getUnderlined( ) {
    return _wxFontGetUnderlined( nativeHandle  );
  }

  bool getStrikethrough( ) {
    return _wxFontGetStrikethrough( nativeHandle  );
  }

  void makeLarger( ) {
    _wxFontMakeLarger( nativeHandle  );
  }

  void makeSmaller( ) {
    _wxFontMakeSmaller( nativeHandle  );
  }

  WxFont bold( ) {
    final returnedNativeHandle = _wxFontBold( nativeHandle  );
    return WxFont.fromHandle( returnedNativeHandle );
  }

  WxFont italic( ) {
    final returnedNativeHandle = _wxFontItalic( nativeHandle  );
    return WxFont.fromHandle( returnedNativeHandle );
  }

  WxFont scaled( double scale ) {
    final returnedNativeHandle = _wxFontScaled( nativeHandle, scale );
    return WxFont.fromHandle( returnedNativeHandle );
  }
}

// ------------------------- wxAnimation ----------------------

typedef _WxAnimationConstructorNative = Pointer Function( Pointer<Utf8>  );
typedef _WxAnimationConstructor = Pointer Function( Pointer<Utf8>  );
late _WxAnimationConstructor _wxAnimationConstructor;

typedef _WxAnimationIsOkNative = Bool Function( Pointer  );
typedef _WxAnimationIsOk = bool Function( Pointer  );
late _WxAnimationIsOk _wxAnimationIsOk;

typedef _WxAnimationGetSizeNative = WxSizeNative Function( Pointer  );
typedef _WxAnimationGetSize = WxSizeNative Function( Pointer  );
late _WxAnimationGetSize _wxAnimationGetSize;

typedef _WxAnimationGetFrameCountNative = Int32 Function( Pointer  );
typedef _WxAnimationGetFrameCount = int Function( Pointer  );
late _WxAnimationGetFrameCount _wxAnimationGetFrameCount;

typedef _WxAnimationGetDelayNative = Int32 Function( Pointer, Int32  );
typedef _WxAnimationGetDelay = int Function( Pointer, int  );
late _WxAnimationGetDelay _wxAnimationGetDelay;

typedef _WxAnimationGetFrameNative = Pointer Function( Pointer, Int32  );
typedef _WxAnimationGetFrame = Pointer Function( Pointer, int  );
late _WxAnimationGetFrame _wxAnimationGetFrame;

class WxAnimation extends WxObject {
  WxAnimation._defaultConstructor() : super._defaultConstructor();
  WxAnimation( String path ) : super._defaultConstructor() {
    path = _wxConvertToAssetPath( path );
    final pathUtf8 = path.toNativeUtf8();
    nativeHandle = _wxAnimationConstructor( pathUtf8 );
    malloc.free( pathUtf8 );
    attachFinalizer();
  }
  WxAnimation.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    attachFinalizer();
  }

  Future<void> load() async {
    // give scheduler a chance to postpone
    await Future.delayed( const Duration( milliseconds: 0 ));
    // defer loading later
  }

  bool isOk( ) {
    return _wxAnimationIsOk( nativeHandle  );
  }

  WxSize getSize( ) {
    final WxSizeNative sizeReturn = _wxAnimationGetSize( nativeHandle  );
    return WxSize(sizeReturn.x, sizeReturn.y);
  }

  int getFrameCount( ) {
    return _wxAnimationGetFrameCount( nativeHandle  );
  }

  int getDelay( int frame ) {
    return _wxAnimationGetDelay( nativeHandle, frame );
  }

  WxImage? getFrame( int frame ) {
    final returnedNativeHandle = _wxAnimationGetFrame( nativeHandle, frame );
    if (returnedNativeHandle == nullptr) return null;
    return WxImage.fromHandle( returnedNativeHandle );
  }
}

// ------------------------- wxReadOnlyDC ----------------------

typedef _WxReadOnlyDCGetContentScaleFactorNative = Double Function( Pointer  );
typedef _WxReadOnlyDCGetContentScaleFactor = double Function( Pointer  );
late _WxReadOnlyDCGetContentScaleFactor _wxReadOnlyDCGetContentScaleFactor;

typedef _WxReadOnlyDCSetAxisOrientationNative = Void Function( Pointer, Bool, Bool  );
typedef _WxReadOnlyDCSetAxisOrientation = void Function( Pointer, bool, bool  );
late _WxReadOnlyDCSetAxisOrientation _wxReadOnlyDCSetAxisOrientation;

typedef _WxReadOnlyDCSetDeviceOriginNative = Void Function( Pointer, Int32, Int32  );
typedef _WxReadOnlyDCSetDeviceOrigin = void Function( Pointer, int, int  );
late _WxReadOnlyDCSetDeviceOrigin _wxReadOnlyDCSetDeviceOrigin;

typedef _WxReadOnlyDCGetDeviceOriginNative = WxPointNative Function( Pointer  );
typedef _WxReadOnlyDCGetDeviceOrigin = WxPointNative Function( Pointer  );
late _WxReadOnlyDCGetDeviceOrigin _wxReadOnlyDCGetDeviceOrigin;

typedef _WxReadOnlyDCSetUserScaleNative = Void Function( Pointer, Double, Double  );
typedef _WxReadOnlyDCSetUserScale = void Function( Pointer, double, double  );
late _WxReadOnlyDCSetUserScale _wxReadOnlyDCSetUserScale;

typedef _WxReadOnlyDCSetLogicalScaleNative = Void Function( Pointer, Double, Double  );
typedef _WxReadOnlyDCSetLogicalScale = void Function( Pointer, double, double  );
late _WxReadOnlyDCSetLogicalScale _wxReadOnlyDCSetLogicalScale;

typedef _WxReadOnlyDCDeviceToLogicalXNative = Int32 Function( Pointer, Int32  );
typedef _WxReadOnlyDCDeviceToLogicalX = int Function( Pointer, int  );
late _WxReadOnlyDCDeviceToLogicalX _wxReadOnlyDCDeviceToLogicalX;

typedef _WxReadOnlyDCDeviceToLogicalXRelNative = Int32 Function( Pointer, Int32  );
typedef _WxReadOnlyDCDeviceToLogicalXRel = int Function( Pointer, int  );
late _WxReadOnlyDCDeviceToLogicalXRel _wxReadOnlyDCDeviceToLogicalXRel;

typedef _WxReadOnlyDCDeviceToLogicalYNative = Int32 Function( Pointer, Int32  );
typedef _WxReadOnlyDCDeviceToLogicalY = int Function( Pointer, int  );
late _WxReadOnlyDCDeviceToLogicalY _wxReadOnlyDCDeviceToLogicalY;

typedef _WxReadOnlyDCDeviceToLogicalYRelNative = Int32 Function( Pointer, Int32  );
typedef _WxReadOnlyDCDeviceToLogicalYRel = int Function( Pointer, int  );
late _WxReadOnlyDCDeviceToLogicalYRel _wxReadOnlyDCDeviceToLogicalYRel;

typedef _WxReadOnlyDCLogicalToDeviceXNative = Int32 Function( Pointer, Int32  );
typedef _WxReadOnlyDCLogicalToDeviceX = int Function( Pointer, int  );
late _WxReadOnlyDCLogicalToDeviceX _wxReadOnlyDCLogicalToDeviceX;

typedef _WxReadOnlyDCLogicalToDeviceXRelNative = Int32 Function( Pointer, Int32  );
typedef _WxReadOnlyDCLogicalToDeviceXRel = int Function( Pointer, int  );
late _WxReadOnlyDCLogicalToDeviceXRel _wxReadOnlyDCLogicalToDeviceXRel;

typedef _WxReadOnlyDCLogicalToDeviceYNative = Int32 Function( Pointer, Int32  );
typedef _WxReadOnlyDCLogicalToDeviceY = int Function( Pointer, int  );
late _WxReadOnlyDCLogicalToDeviceY _wxReadOnlyDCLogicalToDeviceY;

typedef _WxReadOnlyDCLogicalToDeviceYRelNative = Int32 Function( Pointer, Int32  );
typedef _WxReadOnlyDCLogicalToDeviceYRel = int Function( Pointer, int  );
late _WxReadOnlyDCLogicalToDeviceYRel _wxReadOnlyDCLogicalToDeviceYRel;

typedef _WxReadOnlyDCSetFontNative = Void Function( Pointer, Pointer  );
typedef _WxReadOnlyDCSetFont = void Function( Pointer, Pointer  );
late _WxReadOnlyDCSetFont _wxReadOnlyDCSetFont;

typedef _WxReadOnlyDCGetFontNative = Pointer Function( Pointer  );
typedef _WxReadOnlyDCGetFont = Pointer Function( Pointer  );
late _WxReadOnlyDCGetFont _wxReadOnlyDCGetFont;

typedef _WxReadOnlyDCGetTextExtentNative = WxSizeNative Function( Pointer, Pointer<Utf8>  );
typedef _WxReadOnlyDCGetTextExtent = WxSizeNative Function( Pointer, Pointer<Utf8>  );
late _WxReadOnlyDCGetTextExtent _wxReadOnlyDCGetTextExtent;

typedef _WxReadOnlyDCFromDIPNative = Int32 Function( Pointer, Int32  );
typedef _WxReadOnlyDCFromDIP = int Function( Pointer, int  );
late _WxReadOnlyDCFromDIP _wxReadOnlyDCFromDIP;

typedef _WxReadOnlyDCGetPartialTextExtentsNative = Pointer<Utf8> Function( Pointer, Pointer<Utf8>  );
typedef _WxReadOnlyDCGetPartialTextExtents = Pointer<Utf8> Function( Pointer, Pointer<Utf8>  );
late _WxReadOnlyDCGetPartialTextExtents _wxReadOnlyDCGetPartialTextExtents;

typedef _WxReadOnlyDCGetTextExtentExNative = WxTextExtentNative Function( Pointer, Pointer<Utf8>  );
typedef _WxReadOnlyDCGetTextExtentEx = WxTextExtentNative Function( Pointer, Pointer<Utf8>  );
late _WxReadOnlyDCGetTextExtentEx _wxReadOnlyDCGetTextExtentEx;

class WxReadOnlyDC extends WxObject {
  WxReadOnlyDC._defaultConstructor() : super._defaultConstructor();
  WxReadOnlyDC.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  double getContentScaleFactor( ) {
    return _wxReadOnlyDCGetContentScaleFactor( nativeHandle  );
  }

  void setAxisOrientation( bool xLeftRight, bool yBottomUp ) {
    _wxReadOnlyDCSetAxisOrientation( nativeHandle, xLeftRight, yBottomUp );
  }

  void setDeviceOrigin( int x, int y ) {
    _wxReadOnlyDCSetDeviceOrigin( nativeHandle, x, y );
  }

  WxPoint getDeviceOrigin( ) {
    final WxPointNative pointReturn = _wxReadOnlyDCGetDeviceOrigin( nativeHandle  );
    return WxPoint(pointReturn.x, pointReturn.y);
  }

  void setUserScale( double xScale, double yScale ) {
    _wxReadOnlyDCSetUserScale( nativeHandle, xScale, yScale );
  }

  void setLogicalScale( double x, double y ) {
    _wxReadOnlyDCSetLogicalScale( nativeHandle, x, y );
  }

  int deviceToLogicalX( int x ) {
    return _wxReadOnlyDCDeviceToLogicalX( nativeHandle, x );
  }

  int deviceToLogicalXRel( int x ) {
    return _wxReadOnlyDCDeviceToLogicalXRel( nativeHandle, x );
  }

  int deviceToLogicalY( int y ) {
    return _wxReadOnlyDCDeviceToLogicalY( nativeHandle, y );
  }

  int deviceToLogicalYRel( int y ) {
    return _wxReadOnlyDCDeviceToLogicalYRel( nativeHandle, y );
  }

  int logicalToDeviceX( int x ) {
    return _wxReadOnlyDCLogicalToDeviceX( nativeHandle, x );
  }

  int logicalToDeviceXRel( int x ) {
    return _wxReadOnlyDCLogicalToDeviceXRel( nativeHandle, x );
  }

  int logicalToDeviceY( int y ) {
    return _wxReadOnlyDCLogicalToDeviceY( nativeHandle, y );
  }

  int logicalToDeviceYRel( int y ) {
    return _wxReadOnlyDCLogicalToDeviceYRel( nativeHandle, y );
  }

  void setFont( WxFont? font ) {
    _wxReadOnlyDCSetFont( nativeHandle, (font == null) ? nullptr : font.nativeHandle );
  }

  WxFont getFont( ) {
    final returnedNativeHandle = _wxReadOnlyDCGetFont( nativeHandle  );
    return WxFont.fromHandle( returnedNativeHandle );
  }

  WxSize getTextExtent( String text ) {
    final textUtf8 = text.toNativeUtf8();
    final WxSizeNative sizeReturn = _wxReadOnlyDCGetTextExtent( nativeHandle, textUtf8 );
    malloc.free( textUtf8 );
    return WxSize(sizeReturn.x, sizeReturn.y);
  }

  int fromDIP( int value ) {
    return _wxReadOnlyDCFromDIP( nativeHandle, value );
  }

  List<int> getPartialTextExtents( String text ) {
    final textUtf8 = text.toNativeUtf8();
    Pointer<Utf8> ptrReturn = _wxReadOnlyDCGetPartialTextExtents( nativeHandle, textUtf8 );
    final List dynValues = jsonDecode(ptrReturn.toDartString());
    malloc.free( ptrReturn );
    final List<int> values = [];
    for ( final value in dynValues) { values.add( value as int ); }
    malloc.free( textUtf8 );
    return values;
  }

  WxTextExtent getTextExtentEx( String text ) {
    final textUtf8 = text.toNativeUtf8();
    final WxTextExtentNative extReturn = _wxReadOnlyDCGetTextExtentEx( nativeHandle, textUtf8 );
    malloc.free( textUtf8 );
    return WxTextExtent(extReturn.width, extReturn.height, extReturn.descent, extReturn.externalLeading);
  }
}

// ------------------------- wxDC ----------------------

typedef _WxDCSetTextForegroundNative = Void Function( Pointer, Uint32  );
typedef _WxDCSetTextForeground = void Function( Pointer, int  );
late _WxDCSetTextForeground _wxDCSetTextForeground;

typedef _WxDCGetTextForegroundNative = Uint32 Function( Pointer  );
typedef _WxDCGetTextForeground = int Function( Pointer  );
late _WxDCGetTextForeground _wxDCGetTextForeground;

typedef _WxDCSetTextBackgroundNative = Void Function( Pointer, Uint32  );
typedef _WxDCSetTextBackground = void Function( Pointer, int  );
late _WxDCSetTextBackground _wxDCSetTextBackground;

typedef _WxDCGetTextBackgroundNative = Uint32 Function( Pointer  );
typedef _WxDCGetTextBackground = int Function( Pointer  );
late _WxDCGetTextBackground _wxDCGetTextBackground;

typedef _WxDCSetBackgroundModeNative = Void Function( Pointer, Int32  );
typedef _WxDCSetBackgroundMode = void Function( Pointer, int  );
late _WxDCSetBackgroundMode _wxDCSetBackgroundMode;

typedef _WxDCGetBackgroundModeNative = Int32 Function( Pointer  );
typedef _WxDCGetBackgroundMode = int Function( Pointer  );
late _WxDCGetBackgroundMode _wxDCGetBackgroundMode;

typedef _WxDCSetClippingRegionNative = Void Function( Pointer, Int32, Int32, Int32, Int32  );
typedef _WxDCSetClippingRegion = void Function( Pointer, int, int, int, int  );
late _WxDCSetClippingRegion _wxDCSetClippingRegion;

typedef _WxDCSetClippingRegionRectNative = Void Function( Pointer, Int32, Int32, Int32, Int32  );
typedef _WxDCSetClippingRegionRect = void Function( Pointer, int, int, int, int  );
late _WxDCSetClippingRegionRect _wxDCSetClippingRegionRect;

typedef _WxDCDestroyClippingRegionNative = Void Function( Pointer  );
typedef _WxDCDestroyClippingRegion = void Function( Pointer  );
late _WxDCDestroyClippingRegion _wxDCDestroyClippingRegion;

typedef _WxDCGetClippingBoxNative = WxRectNative Function( Pointer  );
typedef _WxDCGetClippingBox = WxRectNative Function( Pointer  );
late _WxDCGetClippingBox _wxDCGetClippingBox;

typedef _WxDCSetPenNative = Void Function( Pointer, Uint32, Int32, Int32, Int32, Int32  );
typedef _WxDCSetPen = void Function( Pointer, int, int, int, int, int  );
late _WxDCSetPen _wxDCSetPen;

typedef _WxDCGetPenNative = WxPenNative Function( Pointer  );
typedef _WxDCGetPen = WxPenNative Function( Pointer  );
late _WxDCGetPen _wxDCGetPen;

typedef _WxDCSetBrushNative = Void Function( Pointer, Uint32, Int32  );
typedef _WxDCSetBrush = void Function( Pointer, int, int  );
late _WxDCSetBrush _wxDCSetBrush;

typedef _WxDCGetBrushNative = WxBrushNative Function( Pointer  );
typedef _WxDCGetBrush = WxBrushNative Function( Pointer  );
late _WxDCGetBrush _wxDCGetBrush;

typedef _WxDCDrawLineNative = Void Function( Pointer, Int32, Int32, Int32, Int32  );
typedef _WxDCDrawLine = void Function( Pointer, int, int, int, int  );
late _WxDCDrawLine _wxDCDrawLine;

typedef _WxDCDrawLinePtsNative = Void Function( Pointer, Int32, Int32, Int32, Int32  );
typedef _WxDCDrawLinePts = void Function( Pointer, int, int, int, int  );
late _WxDCDrawLinePts _wxDCDrawLinePts;

typedef _WxDCDrawRectangleNative = Void Function( Pointer, Int32, Int32, Int32, Int32  );
typedef _WxDCDrawRectangle = void Function( Pointer, int, int, int, int  );
late _WxDCDrawRectangle _wxDCDrawRectangle;

typedef _WxDCDrawRectangleRectNative = Void Function( Pointer, Int32, Int32, Int32, Int32  );
typedef _WxDCDrawRectangleRect = void Function( Pointer, int, int, int, int  );
late _WxDCDrawRectangleRect _wxDCDrawRectangleRect;

typedef _WxDCDrawRoundedRectangleNative = Void Function( Pointer, Int32, Int32, Int32, Int32, Double  );
typedef _WxDCDrawRoundedRectangle = void Function( Pointer, int, int, int, int, double  );
late _WxDCDrawRoundedRectangle _wxDCDrawRoundedRectangle;

typedef _WxDCDrawRoundedRectangleRectNative = Void Function( Pointer, Int32, Int32, Int32, Int32, Double  );
typedef _WxDCDrawRoundedRectangleRect = void Function( Pointer, int, int, int, int, double  );
late _WxDCDrawRoundedRectangleRect _wxDCDrawRoundedRectangleRect;

typedef _WxDCDrawTextNative = Void Function( Pointer, Pointer<Utf8>, Int32, Int32  );
typedef _WxDCDrawText = void Function( Pointer, Pointer<Utf8>, int, int  );
late _WxDCDrawText _wxDCDrawText;

typedef _WxDCDrawRotatedTextNative = Void Function( Pointer, Pointer<Utf8>, Int32, Int32, Double  );
typedef _WxDCDrawRotatedText = void Function( Pointer, Pointer<Utf8>, int, int, double  );
late _WxDCDrawRotatedText _wxDCDrawRotatedText;

typedef _WxDCDrawEllipticArcNative = Void Function( Pointer, Int32, Int32, Int32, Int32, Double, Double  );
typedef _WxDCDrawEllipticArc = void Function( Pointer, int, int, int, int, double, double  );
late _WxDCDrawEllipticArc _wxDCDrawEllipticArc;

typedef _WxDCDrawArcNative = Void Function( Pointer, Int32, Int32, Int32, Int32, Int32, Int32  );
typedef _WxDCDrawArc = void Function( Pointer, int, int, int, int, int, int  );
late _WxDCDrawArc _wxDCDrawArc;

typedef _WxDCDrawArcPtsNative = Void Function( Pointer, Int32, Int32, Int32, Int32, Int32, Int32  );
typedef _WxDCDrawArcPts = void Function( Pointer, int, int, int, int, int, int  );
late _WxDCDrawArcPts _wxDCDrawArcPts;

typedef _WxDCDrawEllipseNative = Void Function( Pointer, Int32, Int32, Int32, Int32  );
typedef _WxDCDrawEllipse = void Function( Pointer, int, int, int, int  );
late _WxDCDrawEllipse _wxDCDrawEllipse;

typedef _WxDCDrawEllipseRectNative = Void Function( Pointer, Int32, Int32, Int32, Int32  );
typedef _WxDCDrawEllipseRect = void Function( Pointer, int, int, int, int  );
late _WxDCDrawEllipseRect _wxDCDrawEllipseRect;

typedef _WxDCDrawCircleNative = Void Function( Pointer, Int32, Int32, Int32  );
typedef _WxDCDrawCircle = void Function( Pointer, int, int, int  );
late _WxDCDrawCircle _wxDCDrawCircle;

typedef _WxDCDrawCirclePtsNative = Void Function( Pointer, Int32, Int32, Int32  );
typedef _WxDCDrawCirclePts = void Function( Pointer, int, int, int  );
late _WxDCDrawCirclePts _wxDCDrawCirclePts;

typedef _WxDCDrawPointNative = Void Function( Pointer, Int32, Int32  );
typedef _WxDCDrawPoint = void Function( Pointer, int, int  );
late _WxDCDrawPoint _wxDCDrawPoint;

typedef _WxDCDrawPointPtNative = Void Function( Pointer, Int32, Int32  );
typedef _WxDCDrawPointPt = void Function( Pointer, int, int  );
late _WxDCDrawPointPt _wxDCDrawPointPt;

typedef _WxDCDrawBitmapNative = Void Function( Pointer, Pointer, Int32, Int32  );
typedef _WxDCDrawBitmap = void Function( Pointer, Pointer, int, int  );
late _WxDCDrawBitmap _wxDCDrawBitmap;

typedef _WxDCDrawLinesNative = Void Function( Pointer, Pointer  );
typedef _WxDCDrawLines = void Function( Pointer, Pointer  );
late _WxDCDrawLines _wxDCDrawLines;

typedef _WxDCDrawSplineNative = Void Function( Pointer, Pointer  );
typedef _WxDCDrawSpline = void Function( Pointer, Pointer  );
late _WxDCDrawSpline _wxDCDrawSpline;

typedef _WxDCDrawPolygonNative = Void Function( Pointer, Pointer, Int32, Int32, Int32  );
typedef _WxDCDrawPolygon = void Function( Pointer, Pointer, int, int, int  );
late _WxDCDrawPolygon _wxDCDrawPolygon;

typedef _WxDCGradientFillLinearNative = Void Function( Pointer, Int32, Int32, Int32, Int32, Uint32, Uint32, Int32  );
typedef _WxDCGradientFillLinear = void Function( Pointer, int, int, int, int, int, int, int  );
late _WxDCGradientFillLinear _wxDCGradientFillLinear;

typedef _WxDCGradientFillConcentricNative = Void Function( Pointer, Int32, Int32, Int32, Int32, Uint32, Uint32  );
typedef _WxDCGradientFillConcentric = void Function( Pointer, int, int, int, int, int, int  );
late _WxDCGradientFillConcentric _wxDCGradientFillConcentric;

typedef _WxDCGradientFillConcentricWithCenterNative = Void Function( Pointer, Int32, Int32, Int32, Int32, Uint32, Uint32, Int32, Int32  );
typedef _WxDCGradientFillConcentricWithCenter = void Function( Pointer, int, int, int, int, int, int, int, int  );
late _WxDCGradientFillConcentricWithCenter _wxDCGradientFillConcentricWithCenter;

/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxODDEVEN_RULE | 1 |
/// | wxWINDING_RULE | 2 |

const int wxODDEVEN_RULE = 1;
const int wxWINDING_RULE = 2;

class WxDC extends WxReadOnlyDC {
  WxDC._defaultConstructor() : super._defaultConstructor();
  WxDC.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  void setTextForeground( WxColour colour ) {
    _wxDCSetTextForeground( nativeHandle, colour.getRGBA() );
  }

  WxColour getTextForeground( ) {
    final int rgba = _wxDCGetTextForeground( nativeHandle  );
    return WxColour.fromRGBA( rgba );
  }

  void setTextBackground( WxColour colour ) {
    _wxDCSetTextBackground( nativeHandle, colour.getRGBA() );
  }

  WxColour getTextBackground( ) {
    final int rgba = _wxDCGetTextBackground( nativeHandle  );
    return WxColour.fromRGBA( rgba );
  }

  void setBackgroundMode( int mode ) {
    _wxDCSetBackgroundMode( nativeHandle, mode );
  }

  int getBackgroundMode( ) {
    return _wxDCGetBackgroundMode( nativeHandle  );
  }

  void setClippingRegion( int x, int y, int width, int height ) {
    _wxDCSetClippingRegion( nativeHandle, x, y, width, height );
  }

  void setClippingRegionRect( WxRect x ) {
    _wxDCSetClippingRegionRect( nativeHandle, x.x, x.y, x.width, x.height );
  }

  void destroyClippingRegion( ) {
    _wxDCDestroyClippingRegion( nativeHandle  );
  }

  WxRect? getClippingBox( ) {
    final WxRectNative rectReturn = _wxDCGetClippingBox( nativeHandle  );
    // secret return value for no clipping
    if ((rectReturn.width == -1) && (rectReturn.height == -1) && (rectReturn.x == 0) && (rectReturn.y == 0)) return null;
    return WxRect(rectReturn.x, rectReturn.y, rectReturn.width, rectReturn.height);
  }

  void setPen( WxPen pen ) {
    _wxDCSetPen( nativeHandle, pen.colour.getRGBA(), pen.width, pen.style, pen.capStyle, pen.joinStyle );
  }

  WxPen getPen( ) {
    final WxPenNative penReturn = _wxDCGetPen( nativeHandle  );
    return WxPen( WxColour.fromRGBA(penReturn.rgba), width: penReturn.width, style: penReturn.style, capStyle: penReturn.capStyle, joinStyle: penReturn.joinStyle );
  }

  void setBrush( WxBrush brush ) {
    _wxDCSetBrush( nativeHandle, brush.colour.getRGBA(), brush.style );
  }

  WxBrush getBrush( ) {
    final WxBrushNative brushReturn = _wxDCGetBrush( nativeHandle  );
    return WxBrush( WxColour.fromRGBA(brushReturn.rgba), style: brushReturn.style );
  }

  void drawLine( int x1, int y1, int x2, int y2 ) {
    _wxDCDrawLine( nativeHandle, x1, y1, x2, y2 );
  }

  void drawLinePts( WxPoint p1, WxPoint p2 ) {
    _wxDCDrawLinePts( nativeHandle, p1.x, p1.y, p2.x, p2.y );
  }

  void drawRectangle( int x, int y, int width, int height ) {
    _wxDCDrawRectangle( nativeHandle, x, y, width, height );
  }

  void drawRectangleRect( WxRect rect ) {
    _wxDCDrawRectangleRect( nativeHandle, rect.x, rect.y, rect.width, rect.height );
  }

  void drawRoundedRectangle( int x1, int y1, int x2, int y2, double radius ) {
    _wxDCDrawRoundedRectangle( nativeHandle, x1, y1, x2, y2, radius );
  }

  void drawRoundedRectangleRect( WxRect rect, double radius ) {
    _wxDCDrawRoundedRectangleRect( nativeHandle, rect.x, rect.y, rect.width, rect.height, radius );
  }

  void drawText( String text, int x, int y ) {
    final textUtf8 = text.toNativeUtf8();
    _wxDCDrawText( nativeHandle, textUtf8, x, y );
    malloc.free( textUtf8 );
  }

  void drawRotatedText( String text, int x, int y, double angle ) {
    final textUtf8 = text.toNativeUtf8();
    _wxDCDrawRotatedText( nativeHandle, textUtf8, x, y, angle );
    malloc.free( textUtf8 );
  }

  void drawEllipticArc( int x, int y, int width, int height, double start, double end ) {
    _wxDCDrawEllipticArc( nativeHandle, x, y, width, height, start, end );
  }

  void drawArc( int x1, int y1, int x2, int y2, int xc, int yc ) {
    _wxDCDrawArc( nativeHandle, x1, y1, x2, y2, xc, yc );
  }

  void drawArcPts( WxPoint p1, WxPoint p2, WxPoint center ) {
    _wxDCDrawArcPts( nativeHandle, p1.x, p1.y, p2.x, p2.y, center.x, center.y );
  }

  void drawEllipse( int x, int y, int width, int height ) {
    _wxDCDrawEllipse( nativeHandle, x, y, width, height );
  }

  void drawEllipseRect( WxRect rect ) {
    _wxDCDrawEllipseRect( nativeHandle, rect.x, rect.y, rect.width, rect.height );
  }

  void drawCircle( int x, int y, int radius ) {
    _wxDCDrawCircle( nativeHandle, x, y, radius );
  }

  void drawCirclePts( WxPoint pt, int radius ) {
    _wxDCDrawCirclePts( nativeHandle, pt.x, pt.y, radius );
  }

  void drawPoint( int x, int y ) {
    _wxDCDrawPoint( nativeHandle, x, y );
  }

  void drawPointPt( WxPoint pt ) {
    _wxDCDrawPointPt( nativeHandle, pt.x, pt.y );
  }

  void drawBitmap( WxBitmap bitmap, int x, int y ) {
    _wxDCDrawBitmap( nativeHandle, bitmap.nativeHandle, x, y );
  }

  void drawLines( List<WxPoint> points ) {
    final pointsList = wxListToPointList( points );
    _wxDCDrawLines( nativeHandle, pointsList.nativeHandle );
    // pointsList.dispose();
  }

  void drawSpline( List<WxPoint> points ) {
    final pointsList = wxListToPointList( points );
    _wxDCDrawSpline( nativeHandle, pointsList.nativeHandle );
    // pointsList.dispose();
  }

  void drawPolygon( List<WxPoint> points, { int xOffset = 0, int yOffset = 0, int fillStyle = wxODDEVEN_RULE } ) {
    final pointsList = wxListToPointList( points );
    _wxDCDrawPolygon( nativeHandle, pointsList.nativeHandle, xOffset, yOffset, fillStyle );
    // pointsList.dispose();
  }

  void gradientFillLinear( WxRect rect, WxColour initialColour, WxColour destColour, { int nDirection = wxRIGHT } ) {
    _wxDCGradientFillLinear( nativeHandle, rect.x, rect.y, rect.width, rect.height, initialColour.getRGBA(), destColour.getRGBA(), nDirection );
  }

  void gradientFillConcentric( WxRect rect, WxColour initialColour, WxColour destColour ) {
    _wxDCGradientFillConcentric( nativeHandle, rect.x, rect.y, rect.width, rect.height, initialColour.getRGBA(), destColour.getRGBA() );
  }

  void gradientFillConcentricWithCenter( WxRect rect, WxColour initialColour, WxColour destColour, WxPoint center ) {
    _wxDCGradientFillConcentricWithCenter( nativeHandle, rect.x, rect.y, rect.width, rect.height, initialColour.getRGBA(), destColour.getRGBA(), center.x, center.y );
  }
}

// ------------------------- wxPaintDC ----------------------

typedef _WxPaintDCConstructorNative = Pointer Function( Pointer  );
typedef _WxPaintDCConstructor = Pointer Function( Pointer  );
late _WxPaintDCConstructor _wxPaintDCConstructor;

class WxPaintDC extends WxDC {
  WxPaintDC._defaultConstructor() : super._defaultConstructor();
  WxPaintDC( WxWindow window ) : super._defaultConstructor() {
    nativeHandle = _wxPaintDCConstructor( window.nativeHandle );
    _thePaintDC = this;
  }
  WxPaintDC.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
    _thePaintDC = this;
  }
}

// ------------------------- wxInfoDC ----------------------

typedef _WxInfoDCConstructorNative = Pointer Function( Pointer  );
typedef _WxInfoDCConstructor = Pointer Function( Pointer  );
late _WxInfoDCConstructor _wxInfoDCConstructor;

class WxInfoDC extends WxReadOnlyDC {
  WxInfoDC._defaultConstructor() : super._defaultConstructor();
  WxInfoDC( WxWindow window ) : super._defaultConstructor() {
    nativeHandle = _wxInfoDCConstructor( window.nativeHandle );
    attachFinalizer();
  }
  WxInfoDC.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }
}

// ------------------------- wxMemoryDC ----------------------

typedef _WxMemoryDCConstructorNative = Pointer Function( Int32, Int32, Bool  );
typedef _WxMemoryDCConstructor = Pointer Function( int, int, bool  );
late _WxMemoryDCConstructor _wxMemoryDCConstructor;

typedef _WxMemoryDCGetBitmapNative = Pointer Function( Pointer  );
typedef _WxMemoryDCGetBitmap = Pointer Function( Pointer  );
late _WxMemoryDCGetBitmap _wxMemoryDCGetBitmap;

class WxMemoryDC extends WxDC {
  WxMemoryDC._defaultConstructor() : super._defaultConstructor();
  WxMemoryDC( int width, int height, { bool hasAlpha = true } ) : super._defaultConstructor() {
    nativeHandle = _wxMemoryDCConstructor( width, height, hasAlpha );
  }
  WxMemoryDC.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  WxBitmap getBitmap( ) {
    final returnedNativeHandle = _wxMemoryDCGetBitmap( nativeHandle  );
    return WxBitmap.fromHandle( returnedNativeHandle );
  }
}

// ------------------------- wxRendererNative ----------------------

typedef _WxRendererNativeDrawItemTextNative = Void Function( Pointer, Pointer, Pointer, Pointer<Utf8>, Int32, Int32, Int32, Int32, Int32, Int32, Int32  );
typedef _WxRendererNativeDrawItemText = void Function( Pointer, Pointer, Pointer, Pointer<Utf8>, int, int, int, int, int, int, int  );
late _WxRendererNativeDrawItemText _wxRendererNativeDrawItemText;

typedef _WxRendererNativeDrawCheckBoxNative = Void Function( Pointer, Pointer, Pointer, Int32, Int32, Int32, Int32, Int32  );
typedef _WxRendererNativeDrawCheckBox = void Function( Pointer, Pointer, Pointer, int, int, int, int, int  );
late _WxRendererNativeDrawCheckBox _wxRendererNativeDrawCheckBox;

typedef _WxRendererNativeDrawCheckMarkNative = Void Function( Pointer, Pointer, Pointer, Int32, Int32, Int32, Int32, Int32  );
typedef _WxRendererNativeDrawCheckMark = void Function( Pointer, Pointer, Pointer, int, int, int, int, int  );
late _WxRendererNativeDrawCheckMark _wxRendererNativeDrawCheckMark;

typedef _WxRendererNativeDrawRadioBitmapNative = Void Function( Pointer, Pointer, Pointer, Int32, Int32, Int32, Int32, Int32  );
typedef _WxRendererNativeDrawRadioBitmap = void Function( Pointer, Pointer, Pointer, int, int, int, int, int  );
late _WxRendererNativeDrawRadioBitmap _wxRendererNativeDrawRadioBitmap;

typedef _WxRendererNativeDrawGaugeNative = Void Function( Pointer, Pointer, Pointer, Int32, Int32, Int32, Int32, Int32, Int32, Int32  );
typedef _WxRendererNativeDrawGauge = void Function( Pointer, Pointer, Pointer, int, int, int, int, int, int, int  );
late _WxRendererNativeDrawGauge _wxRendererNativeDrawGauge;

typedef _WxRendererNativeDrawTreeItemButtonNative = Void Function( Pointer, Pointer, Pointer, Int32, Int32, Int32, Int32, Int32  );
typedef _WxRendererNativeDrawTreeItemButton = void Function( Pointer, Pointer, Pointer, int, int, int, int, int  );
late _WxRendererNativeDrawTreeItemButton _wxRendererNativeDrawTreeItemButton;

typedef _WxRendererNativeGetExpanderSizeNative = WxSizeNative Function( Pointer, Pointer  );
typedef _WxRendererNativeGetExpanderSize = WxSizeNative Function( Pointer, Pointer  );
late _WxRendererNativeGetExpanderSize _wxRendererNativeGetExpanderSize;

typedef _WxRendererNativeDrawFocusRectNative = Void Function( Pointer, Pointer, Pointer, Int32, Int32, Int32, Int32, Int32  );
typedef _WxRendererNativeDrawFocusRect = void Function( Pointer, Pointer, Pointer, int, int, int, int, int  );
late _WxRendererNativeDrawFocusRect _wxRendererNativeDrawFocusRect;

typedef _WxRendererNativeDrawItemSelectionRectNative = Void Function( Pointer, Pointer, Pointer, Int32, Int32, Int32, Int32, Int32  );
typedef _WxRendererNativeDrawItemSelectionRect = void Function( Pointer, Pointer, Pointer, int, int, int, int, int  );
late _WxRendererNativeDrawItemSelectionRect _wxRendererNativeDrawItemSelectionRect;

typedef _WxRendererNativeDrawHeaderButtonNative = Int32 Function( Pointer, Pointer, Pointer, Int32, Int32, Int32, Int32, Int32, Int32  );
typedef _WxRendererNativeDrawHeaderButton = int Function( Pointer, Pointer, Pointer, int, int, int, int, int, int  );
late _WxRendererNativeDrawHeaderButton _wxRendererNativeDrawHeaderButton;

typedef _WxRendererNativeGetHeaderButtonHeightNative = Int32 Function( Pointer, Pointer  );
typedef _WxRendererNativeGetHeaderButtonHeight = int Function( Pointer, Pointer  );
late _WxRendererNativeGetHeaderButtonHeight _wxRendererNativeGetHeaderButtonHeight;

typedef _WxRendererNativeGetHeaderButtonMarginNative = Int32 Function( Pointer, Pointer  );
typedef _WxRendererNativeGetHeaderButtonMargin = int Function( Pointer, Pointer  );
late _WxRendererNativeGetHeaderButtonMargin _wxRendererNativeGetHeaderButtonMargin;

class WxRendererNative extends WxClass {
  WxRendererNative._defaultConstructor() : super._defaultConstructor();
  WxRendererNative.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    ownsHandle = false;
  }

  void drawItemText( WxWindow win, WxDC dc, String text, WxRect rect, { int align = wxALIGN_LEFT|wxALIGN_TOP, int flags = 0, int ellipsizeMode = wxELLIPSIZE_END } ) {
    final textUtf8 = text.toNativeUtf8();
    _wxRendererNativeDrawItemText( nativeHandle, win.nativeHandle, dc.nativeHandle, textUtf8, rect.x, rect.y, rect.width, rect.height, align, flags, ellipsizeMode );
    malloc.free( textUtf8 );
  }

  void drawCheckBox( WxWindow win, WxDC dc, WxRect rect, { int flags = 0 } ) {
    _wxRendererNativeDrawCheckBox( nativeHandle, win.nativeHandle, dc.nativeHandle, rect.x, rect.y, rect.width, rect.height, flags );
  }

  void drawCheckMark( WxWindow win, WxDC dc, WxRect rect, { int flags = 0 } ) {
    _wxRendererNativeDrawCheckMark( nativeHandle, win.nativeHandle, dc.nativeHandle, rect.x, rect.y, rect.width, rect.height, flags );
  }

  void drawRadioBitmap( WxWindow win, WxDC dc, WxRect rect, { int flags = 0 } ) {
    _wxRendererNativeDrawRadioBitmap( nativeHandle, win.nativeHandle, dc.nativeHandle, rect.x, rect.y, rect.width, rect.height, flags );
  }

  void drawGauge( WxWindow win, WxDC dc, WxRect rect, int value, int max, { int flags = 0 } ) {
    _wxRendererNativeDrawGauge( nativeHandle, win.nativeHandle, dc.nativeHandle, rect.x, rect.y, rect.width, rect.height, value, max, flags );
  }

  void drawTreeItemButton( WxWindow win, WxDC dc, WxRect rect, { int flags = 0 } ) {
    _wxRendererNativeDrawTreeItemButton( nativeHandle, win.nativeHandle, dc.nativeHandle, rect.x, rect.y, rect.width, rect.height, flags );
  }

  WxSize getExpanderSize( WxWindow win ) {
    final WxSizeNative sizeReturn = _wxRendererNativeGetExpanderSize( nativeHandle, win.nativeHandle );
    return WxSize(sizeReturn.x, sizeReturn.y);
  }

  void drawFocusRect( WxWindow win, WxDC dc, WxRect rect, { int flags = 0 } ) {
    _wxRendererNativeDrawFocusRect( nativeHandle, win.nativeHandle, dc.nativeHandle, rect.x, rect.y, rect.width, rect.height, flags );
  }

  void drawItemSelectionRect( WxWindow win, WxDC dc, WxRect rect, { int flags = 0 } ) {
    _wxRendererNativeDrawItemSelectionRect( nativeHandle, win.nativeHandle, dc.nativeHandle, rect.x, rect.y, rect.width, rect.height, flags );
  }

  int drawHeaderButton( WxWindow win, WxDC dc, WxRect rect, { int flags = 0, int sortArrow = 0 } ) {
    return _wxRendererNativeDrawHeaderButton( nativeHandle, win.nativeHandle, dc.nativeHandle, rect.x, rect.y, rect.width, rect.height, flags, sortArrow );
  }

  int getHeaderButtonHeight( WxWindow win ) {
    return _wxRendererNativeGetHeaderButtonHeight( nativeHandle, win.nativeHandle );
  }

  int getHeaderButtonMargin( WxWindow win ) {
    return _wxRendererNativeGetHeaderButtonMargin( nativeHandle, win.nativeHandle );
  }
}


void setupWxGdi( DynamicLibrary dylib )
{
  // ------------------------- wxGraphicsObject ----------------------

  // ------------------------- wxGraphicsBitmap ----------------------

  final wxGraphicsBitmapConstructorPtr = dylib.lookup <NativeFunction<_WxGraphicsBitmapConstructorNative>>('wxGraphicsBitmapConstructor');
  _wxGraphicsBitmapConstructor = wxGraphicsBitmapConstructorPtr.asFunction<_WxGraphicsBitmapConstructor>();

  // ------------------------- wxGraphicsPath ----------------------

  final wxGraphicsPathConstructorPtr = dylib.lookup <NativeFunction<_WxGraphicsPathConstructorNative>>('wxGraphicsPathConstructor');
  _wxGraphicsPathConstructor = wxGraphicsPathConstructorPtr.asFunction<_WxGraphicsPathConstructor>();

  final wxGraphicsPathMoveToPtr = dylib.lookup <NativeFunction<_WxGraphicsPathMoveToNative>>('wxGraphicsPathMoveTo');
  _wxGraphicsPathMoveTo = wxGraphicsPathMoveToPtr.asFunction<_WxGraphicsPathMoveTo>();

  final wxGraphicsPathCloseSubpathPtr = dylib.lookup <NativeFunction<_WxGraphicsPathCloseSubpathNative>>('wxGraphicsPathCloseSubpath');
  _wxGraphicsPathCloseSubpath = wxGraphicsPathCloseSubpathPtr.asFunction<_WxGraphicsPathCloseSubpath>();

  final wxGraphicsPathAddLineToPtr = dylib.lookup <NativeFunction<_WxGraphicsPathAddLineToNative>>('wxGraphicsPathAddLineTo');
  _wxGraphicsPathAddLineTo = wxGraphicsPathAddLineToPtr.asFunction<_WxGraphicsPathAddLineTo>();

  final wxGraphicsPathAddPathPtr = dylib.lookup <NativeFunction<_WxGraphicsPathAddPathNative>>('wxGraphicsPathAddPath');
  _wxGraphicsPathAddPath = wxGraphicsPathAddPathPtr.asFunction<_WxGraphicsPathAddPath>();

  final wxGraphicsPathAddRectanglePtr = dylib.lookup <NativeFunction<_WxGraphicsPathAddRectangleNative>>('wxGraphicsPathAddRectangle');
  _wxGraphicsPathAddRectangle = wxGraphicsPathAddRectanglePtr.asFunction<_WxGraphicsPathAddRectangle>();

  final wxGraphicsPathAddRoundedRectanglePtr = dylib.lookup <NativeFunction<_WxGraphicsPathAddRoundedRectangleNative>>('wxGraphicsPathAddRoundedRectangle');
  _wxGraphicsPathAddRoundedRectangle = wxGraphicsPathAddRoundedRectanglePtr.asFunction<_WxGraphicsPathAddRoundedRectangle>();

  final wxGraphicsPathAddCirclePtr = dylib.lookup <NativeFunction<_WxGraphicsPathAddCircleNative>>('wxGraphicsPathAddCircle');
  _wxGraphicsPathAddCircle = wxGraphicsPathAddCirclePtr.asFunction<_WxGraphicsPathAddCircle>();

  final wxGraphicsPathAddEllipsePtr = dylib.lookup <NativeFunction<_WxGraphicsPathAddEllipseNative>>('wxGraphicsPathAddEllipse');
  _wxGraphicsPathAddEllipse = wxGraphicsPathAddEllipsePtr.asFunction<_WxGraphicsPathAddEllipse>();

  final wxGraphicsPathAddArcPtr = dylib.lookup <NativeFunction<_WxGraphicsPathAddArcNative>>('wxGraphicsPathAddArc');
  _wxGraphicsPathAddArc = wxGraphicsPathAddArcPtr.asFunction<_WxGraphicsPathAddArc>();

  // ------------------------- wxGraphicsContext ----------------------

  final wxGraphicsContextConstructorPtr = dylib.lookup <NativeFunction<_WxGraphicsContextConstructorNative>>('wxGraphicsContextConstructor');
  _wxGraphicsContextConstructor = wxGraphicsContextConstructorPtr.asFunction<_WxGraphicsContextConstructor>();

  final wxGraphicsContextConstructorFromDCPtr = dylib.lookup <NativeFunction<_WxGraphicsContextConstructorFromDCNative>>('wxGraphicsContextConstructorFromDC');
  _wxGraphicsContextConstructorFromDC = wxGraphicsContextConstructorFromDCPtr.asFunction<_WxGraphicsContextConstructorFromDC>();

  final wxGraphicsContextConstructorFromMemoryDCPtr = dylib.lookup <NativeFunction<_WxGraphicsContextConstructorFromMemoryDCNative>>('wxGraphicsContextConstructorFromMemoryDC');
  _wxGraphicsContextConstructorFromMemoryDC = wxGraphicsContextConstructorFromMemoryDCPtr.asFunction<_WxGraphicsContextConstructorFromMemoryDC>();

  final wxGraphicsContextStartDocPtr = dylib.lookup <NativeFunction<_WxGraphicsContextStartDocNative>>('wxGraphicsContextStartDoc');
  _wxGraphicsContextStartDoc = wxGraphicsContextStartDocPtr.asFunction<_WxGraphicsContextStartDoc>();

  final wxGraphicsContextEndDocPtr = dylib.lookup <NativeFunction<_WxGraphicsContextEndDocNative>>('wxGraphicsContextEndDoc');
  _wxGraphicsContextEndDoc = wxGraphicsContextEndDocPtr.asFunction<_WxGraphicsContextEndDoc>();

  final wxGraphicsContextStartPagePtr = dylib.lookup <NativeFunction<_WxGraphicsContextStartPageNative>>('wxGraphicsContextStartPage');
  _wxGraphicsContextStartPage = wxGraphicsContextStartPagePtr.asFunction<_WxGraphicsContextStartPage>();

  final wxGraphicsContextEndPagePtr = dylib.lookup <NativeFunction<_WxGraphicsContextEndPageNative>>('wxGraphicsContextEndPage');
  _wxGraphicsContextEndPage = wxGraphicsContextEndPagePtr.asFunction<_WxGraphicsContextEndPage>();

  final wxGraphicsContextFlushPtr = dylib.lookup <NativeFunction<_WxGraphicsContextFlushNative>>('wxGraphicsContextFlush');
  _wxGraphicsContextFlush = wxGraphicsContextFlushPtr.asFunction<_WxGraphicsContextFlush>();

  final wxGraphicsContextSetFontPtr = dylib.lookup <NativeFunction<_WxGraphicsContextSetFontNative>>('wxGraphicsContextSetFont');
  _wxGraphicsContextSetFont = wxGraphicsContextSetFontPtr.asFunction<_WxGraphicsContextSetFont>();

  final wxGraphicsContextGetTextExtentPtr = dylib.lookup <NativeFunction<_WxGraphicsContextGetTextExtentNative>>('wxGraphicsContextGetTextExtent');
  _wxGraphicsContextGetTextExtent = wxGraphicsContextGetTextExtentPtr.asFunction<_WxGraphicsContextGetTextExtent>();

  final wxGraphicsContextSetPenPtr = dylib.lookup <NativeFunction<_WxGraphicsContextSetPenNative>>('wxGraphicsContextSetPen');
  _wxGraphicsContextSetPen = wxGraphicsContextSetPenPtr.asFunction<_WxGraphicsContextSetPen>();

  final wxGraphicsContextSetPenWithConstantColourPtr = dylib.lookup <NativeFunction<_WxGraphicsContextSetPenWithConstantColourNative>>('wxGraphicsContextSetPenWithConstantColour');
  _wxGraphicsContextSetPenWithConstantColour = wxGraphicsContextSetPenWithConstantColourPtr.asFunction<_WxGraphicsContextSetPenWithConstantColour>();

  final wxGraphicsContextSetPenWithLinearGradientPtr = dylib.lookup <NativeFunction<_WxGraphicsContextSetPenWithLinearGradientNative>>('wxGraphicsContextSetPenWithLinearGradient');
  _wxGraphicsContextSetPenWithLinearGradient = wxGraphicsContextSetPenWithLinearGradientPtr.asFunction<_WxGraphicsContextSetPenWithLinearGradient>();

  final wxGraphicsContextSetPenWithRadialGradientPtr = dylib.lookup <NativeFunction<_WxGraphicsContextSetPenWithRadialGradientNative>>('wxGraphicsContextSetPenWithRadialGradient');
  _wxGraphicsContextSetPenWithRadialGradient = wxGraphicsContextSetPenWithRadialGradientPtr.asFunction<_WxGraphicsContextSetPenWithRadialGradient>();

  final wxGraphicsContextSetBrushPtr = dylib.lookup <NativeFunction<_WxGraphicsContextSetBrushNative>>('wxGraphicsContextSetBrush');
  _wxGraphicsContextSetBrush = wxGraphicsContextSetBrushPtr.asFunction<_WxGraphicsContextSetBrush>();

  final wxGraphicsContextSetCompositionModePtr = dylib.lookup <NativeFunction<_WxGraphicsContextSetCompositionModeNative>>('wxGraphicsContextSetCompositionMode');
  _wxGraphicsContextSetCompositionMode = wxGraphicsContextSetCompositionModePtr.asFunction<_WxGraphicsContextSetCompositionMode>();

  final wxGraphicsContextCreateBitmapPtr = dylib.lookup <NativeFunction<_WxGraphicsContextCreateBitmapNative>>('wxGraphicsContextCreateBitmap');
  _wxGraphicsContextCreateBitmap = wxGraphicsContextCreateBitmapPtr.asFunction<_WxGraphicsContextCreateBitmap>();

  final wxGraphicsContextCreateBitmapFromImagePtr = dylib.lookup <NativeFunction<_WxGraphicsContextCreateBitmapFromImageNative>>('wxGraphicsContextCreateBitmapFromImage');
  _wxGraphicsContextCreateBitmapFromImage = wxGraphicsContextCreateBitmapFromImagePtr.asFunction<_WxGraphicsContextCreateBitmapFromImage>();

  final wxGraphicsContextClipPtr = dylib.lookup <NativeFunction<_WxGraphicsContextClipNative>>('wxGraphicsContextClip');
  _wxGraphicsContextClip = wxGraphicsContextClipPtr.asFunction<_WxGraphicsContextClip>();

  final wxGraphicsContextResetClipPtr = dylib.lookup <NativeFunction<_WxGraphicsContextResetClipNative>>('wxGraphicsContextResetClip');
  _wxGraphicsContextResetClip = wxGraphicsContextResetClipPtr.asFunction<_WxGraphicsContextResetClip>();

  final wxGraphicsContextPushStatePtr = dylib.lookup <NativeFunction<_WxGraphicsContextPushStateNative>>('wxGraphicsContextPushState');
  _wxGraphicsContextPushState = wxGraphicsContextPushStatePtr.asFunction<_WxGraphicsContextPushState>();

  final wxGraphicsContextPopStatePtr = dylib.lookup <NativeFunction<_WxGraphicsContextPopStateNative>>('wxGraphicsContextPopState');
  _wxGraphicsContextPopState = wxGraphicsContextPopStatePtr.asFunction<_WxGraphicsContextPopState>();

  final wxGraphicsContextRotatePtr = dylib.lookup <NativeFunction<_WxGraphicsContextRotateNative>>('wxGraphicsContextRotate');
  _wxGraphicsContextRotate = wxGraphicsContextRotatePtr.asFunction<_WxGraphicsContextRotate>();

  final wxGraphicsContextTranslatePtr = dylib.lookup <NativeFunction<_WxGraphicsContextTranslateNative>>('wxGraphicsContextTranslate');
  _wxGraphicsContextTranslate = wxGraphicsContextTranslatePtr.asFunction<_WxGraphicsContextTranslate>();

  final wxGraphicsContextScalePtr = dylib.lookup <NativeFunction<_WxGraphicsContextScaleNative>>('wxGraphicsContextScale');
  _wxGraphicsContextScale = wxGraphicsContextScalePtr.asFunction<_WxGraphicsContextScale>();

  final wxGraphicsContextCreatePathPtr = dylib.lookup <NativeFunction<_WxGraphicsContextCreatePathNative>>('wxGraphicsContextCreatePath');
  _wxGraphicsContextCreatePath = wxGraphicsContextCreatePathPtr.asFunction<_WxGraphicsContextCreatePath>();

  final wxGraphicsContextStrokePathPtr = dylib.lookup <NativeFunction<_WxGraphicsContextStrokePathNative>>('wxGraphicsContextStrokePath');
  _wxGraphicsContextStrokePath = wxGraphicsContextStrokePathPtr.asFunction<_WxGraphicsContextStrokePath>();

  final wxGraphicsContextFillPathPtr = dylib.lookup <NativeFunction<_WxGraphicsContextFillPathNative>>('wxGraphicsContextFillPath');
  _wxGraphicsContextFillPath = wxGraphicsContextFillPathPtr.asFunction<_WxGraphicsContextFillPath>();

  final wxGraphicsContextDrawPathPtr = dylib.lookup <NativeFunction<_WxGraphicsContextDrawPathNative>>('wxGraphicsContextDrawPath');
  _wxGraphicsContextDrawPath = wxGraphicsContextDrawPathPtr.asFunction<_WxGraphicsContextDrawPath>();

  final wxGraphicsContextStrokeLinePtr = dylib.lookup <NativeFunction<_WxGraphicsContextStrokeLineNative>>('wxGraphicsContextStrokeLine');
  _wxGraphicsContextStrokeLine = wxGraphicsContextStrokeLinePtr.asFunction<_WxGraphicsContextStrokeLine>();

  final wxGraphicsContextStrokeLinesPtr = dylib.lookup <NativeFunction<_WxGraphicsContextStrokeLinesNative>>('wxGraphicsContextStrokeLines');
  _wxGraphicsContextStrokeLines = wxGraphicsContextStrokeLinesPtr.asFunction<_WxGraphicsContextStrokeLines>();

  final wxGraphicsContextDrawEllipsePtr = dylib.lookup <NativeFunction<_WxGraphicsContextDrawEllipseNative>>('wxGraphicsContextDrawEllipse');
  _wxGraphicsContextDrawEllipse = wxGraphicsContextDrawEllipsePtr.asFunction<_WxGraphicsContextDrawEllipse>();

  final wxGraphicsContextDrawRectanglePtr = dylib.lookup <NativeFunction<_WxGraphicsContextDrawRectangleNative>>('wxGraphicsContextDrawRectangle');
  _wxGraphicsContextDrawRectangle = wxGraphicsContextDrawRectanglePtr.asFunction<_WxGraphicsContextDrawRectangle>();

  final wxGraphicsContextDrawRoundedRectanglePtr = dylib.lookup <NativeFunction<_WxGraphicsContextDrawRoundedRectangleNative>>('wxGraphicsContextDrawRoundedRectangle');
  _wxGraphicsContextDrawRoundedRectangle = wxGraphicsContextDrawRoundedRectanglePtr.asFunction<_WxGraphicsContextDrawRoundedRectangle>();

  final wxGraphicsContextDrawBitmapPtr = dylib.lookup <NativeFunction<_WxGraphicsContextDrawBitmapNative>>('wxGraphicsContextDrawBitmap');
  _wxGraphicsContextDrawBitmap = wxGraphicsContextDrawBitmapPtr.asFunction<_WxGraphicsContextDrawBitmap>();

  final wxGraphicsContextDrawTextPtr = dylib.lookup <NativeFunction<_WxGraphicsContextDrawTextNative>>('wxGraphicsContextDrawText');
  _wxGraphicsContextDrawText = wxGraphicsContextDrawTextPtr.asFunction<_WxGraphicsContextDrawText>();

  // ------------------------- wxRealPointList ----------------------

  final wxRealPointListConstructorPtr = dylib.lookup <NativeFunction<_WxRealPointListConstructorNative>>('wxRealPointListConstructor');
  _wxRealPointListConstructor = wxRealPointListConstructorPtr.asFunction<_WxRealPointListConstructor>();

  final wxRealPointListDestructorPtr = dylib.lookup <NativeFunction<_WxRealPointListDestructorNative>>('wxRealPointListDestructor');
  _wxRealPointListDestructor = wxRealPointListDestructorPtr.asFunction<_WxRealPointListDestructor>();

  final wxRealPointListFinalizerPtr = dylib.lookup <NativeFunction<_WxRealPointListFinalizerNative>>('wxRealPointListFinalizer');
  _wxRealPointListNativeFinalizer = NativeFinalizer( wxRealPointListFinalizerPtr.cast() );

  final wxRealPointListAddPtr = dylib.lookup <NativeFunction<_WxRealPointListAddNative>>('wxRealPointListAdd');
  _wxRealPointListAdd = wxRealPointListAddPtr.asFunction<_WxRealPointListAdd>();

  // ------------------------- wxPointList ----------------------

  final wxPointListConstructorPtr = dylib.lookup <NativeFunction<_WxPointListConstructorNative>>('wxPointListConstructor');
  _wxPointListConstructor = wxPointListConstructorPtr.asFunction<_WxPointListConstructor>();

  final wxPointListDestructorPtr = dylib.lookup <NativeFunction<_WxPointListDestructorNative>>('wxPointListDestructor');
  _wxPointListDestructor = wxPointListDestructorPtr.asFunction<_WxPointListDestructor>();

  final wxPointListFinalizerPtr = dylib.lookup <NativeFunction<_WxPointListFinalizerNative>>('wxPointListFinalizer');
  _wxPointListNativeFinalizer = NativeFinalizer( wxPointListFinalizerPtr.cast() );

  final wxPointListAddPtr = dylib.lookup <NativeFunction<_WxPointListAddNative>>('wxPointListAdd');
  _wxPointListAdd = wxPointListAddPtr.asFunction<_WxPointListAdd>();

  final wxPointListDeleteContentsPtr = dylib.lookup <NativeFunction<_WxPointListDeleteContentsNative>>('wxPointListDeleteContents');
  _wxPointListDeleteContents = wxPointListDeleteContentsPtr.asFunction<_WxPointListDeleteContents>();

  // ------------------------- wxImage ----------------------

  final wxImageConstructorPtr = dylib.lookup <NativeFunction<_WxImageConstructorNative>>('wxImageConstructor');
  _wxImageConstructor = wxImageConstructorPtr.asFunction<_WxImageConstructor>();

  final wxImageConstructorFromFilePtr = dylib.lookup <NativeFunction<_WxImageConstructorFromFileNative>>('wxImageConstructorFromFile');
  _wxImageConstructorFromFile = wxImageConstructorFromFilePtr.asFunction<_WxImageConstructorFromFile>();

  final wxImageInitAlphaPtr = dylib.lookup <NativeFunction<_WxImageInitAlphaNative>>('wxImageInitAlpha');
  _wxImageInitAlpha = wxImageInitAlphaPtr.asFunction<_WxImageInitAlpha>();

  final wxImageClearAlphaPtr = dylib.lookup <NativeFunction<_WxImageClearAlphaNative>>('wxImageClearAlpha');
  _wxImageClearAlpha = wxImageClearAlphaPtr.asFunction<_WxImageClearAlpha>();

  final wxImageHasAlphaPtr = dylib.lookup <NativeFunction<_WxImageHasAlphaNative>>('wxImageHasAlpha');
  _wxImageHasAlpha = wxImageHasAlphaPtr.asFunction<_WxImageHasAlpha>();

  final wxImageGetWidthPtr = dylib.lookup <NativeFunction<_WxImageGetWidthNative>>('wxImageGetWidth');
  _wxImageGetWidth = wxImageGetWidthPtr.asFunction<_WxImageGetWidth>();

  final wxImageGetHeightPtr = dylib.lookup <NativeFunction<_WxImageGetHeightNative>>('wxImageGetHeight');
  _wxImageGetHeight = wxImageGetHeightPtr.asFunction<_WxImageGetHeight>();

  final wxImageIsOkPtr = dylib.lookup <NativeFunction<_WxImageIsOkNative>>('wxImageIsOk');
  _wxImageIsOk = wxImageIsOkPtr.asFunction<_WxImageIsOk>();

  final wxImageSetRGBPtr = dylib.lookup <NativeFunction<_WxImageSetRGBNative>>('wxImageSetRGB');
  _wxImageSetRGB = wxImageSetRGBPtr.asFunction<_WxImageSetRGB>();

  final wxImageSetAlphaPtr = dylib.lookup <NativeFunction<_WxImageSetAlphaNative>>('wxImageSetAlpha');
  _wxImageSetAlpha = wxImageSetAlphaPtr.asFunction<_WxImageSetAlpha>();

  final wxImageGetRedPtr = dylib.lookup <NativeFunction<_WxImageGetRedNative>>('wxImageGetRed');
  _wxImageGetRed = wxImageGetRedPtr.asFunction<_WxImageGetRed>();

  final wxImageGetGreenPtr = dylib.lookup <NativeFunction<_WxImageGetGreenNative>>('wxImageGetGreen');
  _wxImageGetGreen = wxImageGetGreenPtr.asFunction<_WxImageGetGreen>();

  final wxImageGetBluePtr = dylib.lookup <NativeFunction<_WxImageGetBlueNative>>('wxImageGetBlue');
  _wxImageGetBlue = wxImageGetBluePtr.asFunction<_WxImageGetBlue>();

  final wxImageGetAlphaPtr = dylib.lookup <NativeFunction<_WxImageGetAlphaNative>>('wxImageGetAlpha');
  _wxImageGetAlpha = wxImageGetAlphaPtr.asFunction<_WxImageGetAlpha>();

  final wxImageGetDataPtr = dylib.lookup <NativeFunction<_WxImageGetDataNative>>('wxImageGetData');
  _wxImageGetData = wxImageGetDataPtr.asFunction<_WxImageGetData>();

  final wxImageGetAlphaDataPtr = dylib.lookup <NativeFunction<_WxImageGetAlphaDataNative>>('wxImageGetAlphaData');
  _wxImageGetAlphaData = wxImageGetAlphaDataPtr.asFunction<_WxImageGetAlphaData>();

  final wxImageReplacePtr = dylib.lookup <NativeFunction<_WxImageReplaceNative>>('wxImageReplace');
  _wxImageReplace = wxImageReplacePtr.asFunction<_WxImageReplace>();

  final wxImageCopyPtr = dylib.lookup <NativeFunction<_WxImageCopyNative>>('wxImageCopy');
  _wxImageCopy = wxImageCopyPtr.asFunction<_WxImageCopy>();

  final wxImageGetSubImagePtr = dylib.lookup <NativeFunction<_WxImageGetSubImageNative>>('wxImageGetSubImage');
  _wxImageGetSubImage = wxImageGetSubImagePtr.asFunction<_WxImageGetSubImage>();

  final wxImageScalePtr = dylib.lookup <NativeFunction<_WxImageScaleNative>>('wxImageScale');
  _wxImageScale = wxImageScalePtr.asFunction<_WxImageScale>();

  // ------------------------- wxVectorBitmapBundle ----------------------

  final wxVectorBitmapBundleConstructorPtr = dylib.lookup <NativeFunction<_WxVectorBitmapBundleConstructorNative>>('wxVectorBitmapBundleConstructor');
  _wxVectorBitmapBundleConstructor = wxVectorBitmapBundleConstructorPtr.asFunction<_WxVectorBitmapBundleConstructor>();

  final wxVectorBitmapBundleDestructorPtr = dylib.lookup <NativeFunction<_WxVectorBitmapBundleDestructorNative>>('wxVectorBitmapBundleDestructor');
  _wxVectorBitmapBundleDestructor = wxVectorBitmapBundleDestructorPtr.asFunction<_WxVectorBitmapBundleDestructor>();

  final wxVectorBitmapBundleFinalizerPtr = dylib.lookup <NativeFunction<_WxVectorBitmapBundleFinalizerNative>>('wxVectorBitmapBundleFinalizer');
  _wxVectorBitmapBundleNativeFinalizer = NativeFinalizer( wxVectorBitmapBundleFinalizerPtr.cast() );

  final wxVectorBitmapBundleAddPtr = dylib.lookup <NativeFunction<_WxVectorBitmapBundleAddNative>>('wxVectorBitmapBundleAdd');
  _wxVectorBitmapBundleAdd = wxVectorBitmapBundleAddPtr.asFunction<_WxVectorBitmapBundleAdd>();

  // ------------------------- wxBitmap ----------------------

  final wxBitmapConstructorPtr = dylib.lookup <NativeFunction<_WxBitmapConstructorNative>>('wxBitmapConstructor');
  _wxBitmapConstructor = wxBitmapConstructorPtr.asFunction<_WxBitmapConstructor>();

  final wxBitmapConstructorFromAssetPtr = dylib.lookup <NativeFunction<_WxBitmapConstructorFromAssetNative>>('wxBitmapConstructorFromAsset');
  _wxBitmapConstructorFromAsset = wxBitmapConstructorFromAssetPtr.asFunction<_WxBitmapConstructorFromAsset>();

  final wxBitmapConstructorFromImagePtr = dylib.lookup <NativeFunction<_WxBitmapConstructorFromImageNative>>('wxBitmapConstructorFromImage');
  _wxBitmapConstructorFromImage = wxBitmapConstructorFromImagePtr.asFunction<_WxBitmapConstructorFromImage>();

  final wxBitmapConstructorFromMaterialIconPtr = dylib.lookup <NativeFunction<_WxBitmapConstructorFromMaterialIconNative>>('wxBitmapConstructorFromMaterialIcon');
  _wxBitmapConstructorFromMaterialIcon = wxBitmapConstructorFromMaterialIconPtr.asFunction<_WxBitmapConstructorFromMaterialIcon>();

  final wxBitmap_convertToImageSyncPtr = dylib.lookup <NativeFunction<_WxBitmap_convertToImageSyncNative>>('wxBitmap_convertToImageSync');
  _wxBitmap_convertToImageSync = wxBitmap_convertToImageSyncPtr.asFunction<_WxBitmap_convertToImageSync>();

  final wxBitmapGetLogicalWidthPtr = dylib.lookup <NativeFunction<_WxBitmapGetLogicalWidthNative>>('wxBitmapGetLogicalWidth');
  _wxBitmapGetLogicalWidth = wxBitmapGetLogicalWidthPtr.asFunction<_WxBitmapGetLogicalWidth>();

  final wxBitmapGetLogicalHeightPtr = dylib.lookup <NativeFunction<_WxBitmapGetLogicalHeightNative>>('wxBitmapGetLogicalHeight');
  _wxBitmapGetLogicalHeight = wxBitmapGetLogicalHeightPtr.asFunction<_WxBitmapGetLogicalHeight>();

  final wxBitmapGetScaleFactorPtr = dylib.lookup <NativeFunction<_WxBitmapGetScaleFactorNative>>('wxBitmapGetScaleFactor');
  _wxBitmapGetScaleFactor = wxBitmapGetScaleFactorPtr.asFunction<_WxBitmapGetScaleFactor>();

  final wxBitmapSetScaleFactorPtr = dylib.lookup <NativeFunction<_WxBitmapSetScaleFactorNative>>('wxBitmapSetScaleFactor');
  _wxBitmapSetScaleFactor = wxBitmapSetScaleFactorPtr.asFunction<_WxBitmapSetScaleFactor>();

  final wxBitmapGetWidthPtr = dylib.lookup <NativeFunction<_WxBitmapGetWidthNative>>('wxBitmapGetWidth');
  _wxBitmapGetWidth = wxBitmapGetWidthPtr.asFunction<_WxBitmapGetWidth>();

  final wxBitmapGetHeightPtr = dylib.lookup <NativeFunction<_WxBitmapGetHeightNative>>('wxBitmapGetHeight');
  _wxBitmapGetHeight = wxBitmapGetHeightPtr.asFunction<_WxBitmapGetHeight>();

  final wxBitmapIsOkPtr = dylib.lookup <NativeFunction<_WxBitmapIsOkNative>>('wxBitmapIsOk');
  _wxBitmapIsOk = wxBitmapIsOkPtr.asFunction<_WxBitmapIsOk>();

  // ------------------------- wxBitmapBundle ----------------------

  final wxBitmapBundleConstructorPtr = dylib.lookup <NativeFunction<_WxBitmapBundleConstructorNative>>('wxBitmapBundleConstructor');
  _wxBitmapBundleConstructor = wxBitmapBundleConstructorPtr.asFunction<_WxBitmapBundleConstructor>();

  final wxBitmapBundleConstructorFromMaterialIconPtr = dylib.lookup <NativeFunction<_WxBitmapBundleConstructorFromMaterialIconNative>>('wxBitmapBundleConstructorFromMaterialIcon');
  _wxBitmapBundleConstructorFromMaterialIcon = wxBitmapBundleConstructorFromMaterialIconPtr.asFunction<_WxBitmapBundleConstructorFromMaterialIcon>();

  final wxBitmapBundleConstructorFromJPEGAssetPtr = dylib.lookup <NativeFunction<_WxBitmapBundleConstructorFromJPEGAssetNative>>('wxBitmapBundleConstructorFromJPEGAsset');
  _wxBitmapBundleConstructorFromJPEGAsset = wxBitmapBundleConstructorFromJPEGAssetPtr.asFunction<_WxBitmapBundleConstructorFromJPEGAsset>();

  final wxBitmapBundleConstructorFromPNGAssetPtr = dylib.lookup <NativeFunction<_WxBitmapBundleConstructorFromPNGAssetNative>>('wxBitmapBundleConstructorFromPNGAsset');
  _wxBitmapBundleConstructorFromPNGAsset = wxBitmapBundleConstructorFromPNGAssetPtr.asFunction<_WxBitmapBundleConstructorFromPNGAsset>();

  final wxBitmapBundleConstructorFromSVGAssetPtr = dylib.lookup <NativeFunction<_WxBitmapBundleConstructorFromSVGAssetNative>>('wxBitmapBundleConstructorFromSVGAsset');
  _wxBitmapBundleConstructorFromSVGAsset = wxBitmapBundleConstructorFromSVGAssetPtr.asFunction<_WxBitmapBundleConstructorFromSVGAsset>();

  final wxBitmapBundleConstructorFromBitmapPtr = dylib.lookup <NativeFunction<_WxBitmapBundleConstructorFromBitmapNative>>('wxBitmapBundleConstructorFromBitmap');
  _wxBitmapBundleConstructorFromBitmap = wxBitmapBundleConstructorFromBitmapPtr.asFunction<_WxBitmapBundleConstructorFromBitmap>();

  final wxBitmapBundleConstructorFromBitmapsPtr = dylib.lookup <NativeFunction<_WxBitmapBundleConstructorFromBitmapsNative>>('wxBitmapBundleConstructorFromBitmaps');
  _wxBitmapBundleConstructorFromBitmaps = wxBitmapBundleConstructorFromBitmapsPtr.asFunction<_WxBitmapBundleConstructorFromBitmaps>();

  final wxBitmapBundleConstructorFromImagePtr = dylib.lookup <NativeFunction<_WxBitmapBundleConstructorFromImageNative>>('wxBitmapBundleConstructorFromImage');
  _wxBitmapBundleConstructorFromImage = wxBitmapBundleConstructorFromImagePtr.asFunction<_WxBitmapBundleConstructorFromImage>();

  final wxBitmapBundleConstructorFromSVGPtr = dylib.lookup <NativeFunction<_WxBitmapBundleConstructorFromSVGNative>>('wxBitmapBundleConstructorFromSVG');
  _wxBitmapBundleConstructorFromSVG = wxBitmapBundleConstructorFromSVGPtr.asFunction<_WxBitmapBundleConstructorFromSVG>();

  final wxBitmapBundleConstructorFromSVGFilePtr = dylib.lookup <NativeFunction<_WxBitmapBundleConstructorFromSVGFileNative>>('wxBitmapBundleConstructorFromSVGFile');
  _wxBitmapBundleConstructorFromSVGFile = wxBitmapBundleConstructorFromSVGFilePtr.asFunction<_WxBitmapBundleConstructorFromSVGFile>();

  final wxBitmapBundleDestructorPtr = dylib.lookup <NativeFunction<_WxBitmapBundleDestructorNative>>('wxBitmapBundleDestructor');
  _wxBitmapBundleDestructor = wxBitmapBundleDestructorPtr.asFunction<_WxBitmapBundleDestructor>();

  final wxBitmapBundleFinalizerPtr = dylib.lookup <NativeFunction<_WxBitmapBundleFinalizerNative>>('wxBitmapBundleFinalizer');
  _wxBitmapBundleNativeFinalizer = NativeFinalizer( wxBitmapBundleFinalizerPtr.cast() );

  final wxBitmapBundleGetBitmapForPtr = dylib.lookup <NativeFunction<_WxBitmapBundleGetBitmapForNative>>('wxBitmapBundleGetBitmapFor');
  _wxBitmapBundleGetBitmapFor = wxBitmapBundleGetBitmapForPtr.asFunction<_WxBitmapBundleGetBitmapFor>();

  final wxBitmapBundleGetBitmapPtr = dylib.lookup <NativeFunction<_WxBitmapBundleGetBitmapNative>>('wxBitmapBundleGetBitmap');
  _wxBitmapBundleGetBitmap = wxBitmapBundleGetBitmapPtr.asFunction<_WxBitmapBundleGetBitmap>();

  final wxBitmapBundleGetDefaultSizePtr = dylib.lookup <NativeFunction<_WxBitmapBundleGetDefaultSizeNative>>('wxBitmapBundleGetDefaultSize');
  _wxBitmapBundleGetDefaultSize = wxBitmapBundleGetDefaultSizePtr.asFunction<_WxBitmapBundleGetDefaultSize>();

  final wxBitmapBundleMakeDisabledPtr = dylib.lookup <NativeFunction<_WxBitmapBundleMakeDisabledNative>>('wxBitmapBundleMakeDisabled');
  _wxBitmapBundleMakeDisabled = wxBitmapBundleMakeDisabledPtr.asFunction<_WxBitmapBundleMakeDisabled>();

  // ------------------------- wxCursor ----------------------

  final wxCursorConstructorPtr = dylib.lookup <NativeFunction<_WxCursorConstructorNative>>('wxCursorConstructor');
  _wxCursorConstructor = wxCursorConstructorPtr.asFunction<_WxCursorConstructor>();

  final wxCursorIsOkPtr = dylib.lookup <NativeFunction<_WxCursorIsOkNative>>('wxCursorIsOk');
  _wxCursorIsOk = wxCursorIsOkPtr.asFunction<_WxCursorIsOk>();

  // ------------------------- wxFont ----------------------

  final wxFontConstructorPtr = dylib.lookup <NativeFunction<_WxFontConstructorNative>>('wxFontConstructor');
  _wxFontConstructor = wxFontConstructorPtr.asFunction<_WxFontConstructor>();

  final wxFontConstructorFromPixelSizePtr = dylib.lookup <NativeFunction<_WxFontConstructorFromPixelSizeNative>>('wxFontConstructorFromPixelSize');
  _wxFontConstructorFromPixelSize = wxFontConstructorFromPixelSizePtr.asFunction<_WxFontConstructorFromPixelSize>();

  final wxFontIsOkPtr = dylib.lookup <NativeFunction<_WxFontIsOkNative>>('wxFontIsOk');
  _wxFontIsOk = wxFontIsOkPtr.asFunction<_WxFontIsOk>();

  final wxFontGetPointSizePtr = dylib.lookup <NativeFunction<_WxFontGetPointSizeNative>>('wxFontGetPointSize');
  _wxFontGetPointSize = wxFontGetPointSizePtr.asFunction<_WxFontGetPointSize>();

  final wxFontGetPixelSizePtr = dylib.lookup <NativeFunction<_WxFontGetPixelSizeNative>>('wxFontGetPixelSize');
  _wxFontGetPixelSize = wxFontGetPixelSizePtr.asFunction<_WxFontGetPixelSize>();

  final wxFontGetFamilyPtr = dylib.lookup <NativeFunction<_WxFontGetFamilyNative>>('wxFontGetFamily');
  _wxFontGetFamily = wxFontGetFamilyPtr.asFunction<_WxFontGetFamily>();

  final wxFontGetWeightPtr = dylib.lookup <NativeFunction<_WxFontGetWeightNative>>('wxFontGetWeight');
  _wxFontGetWeight = wxFontGetWeightPtr.asFunction<_WxFontGetWeight>();

  final wxFontGetStylePtr = dylib.lookup <NativeFunction<_WxFontGetStyleNative>>('wxFontGetStyle');
  _wxFontGetStyle = wxFontGetStylePtr.asFunction<_WxFontGetStyle>();

  final wxFontGetUnderlinedPtr = dylib.lookup <NativeFunction<_WxFontGetUnderlinedNative>>('wxFontGetUnderlined');
  _wxFontGetUnderlined = wxFontGetUnderlinedPtr.asFunction<_WxFontGetUnderlined>();

  final wxFontGetStrikethroughPtr = dylib.lookup <NativeFunction<_WxFontGetStrikethroughNative>>('wxFontGetStrikethrough');
  _wxFontGetStrikethrough = wxFontGetStrikethroughPtr.asFunction<_WxFontGetStrikethrough>();

  final wxFontMakeLargerPtr = dylib.lookup <NativeFunction<_WxFontMakeLargerNative>>('wxFontMakeLarger');
  _wxFontMakeLarger = wxFontMakeLargerPtr.asFunction<_WxFontMakeLarger>();

  final wxFontMakeSmallerPtr = dylib.lookup <NativeFunction<_WxFontMakeSmallerNative>>('wxFontMakeSmaller');
  _wxFontMakeSmaller = wxFontMakeSmallerPtr.asFunction<_WxFontMakeSmaller>();

  final wxFontBoldPtr = dylib.lookup <NativeFunction<_WxFontBoldNative>>('wxFontBold');
  _wxFontBold = wxFontBoldPtr.asFunction<_WxFontBold>();

  final wxFontItalicPtr = dylib.lookup <NativeFunction<_WxFontItalicNative>>('wxFontItalic');
  _wxFontItalic = wxFontItalicPtr.asFunction<_WxFontItalic>();

  final wxFontScaledPtr = dylib.lookup <NativeFunction<_WxFontScaledNative>>('wxFontScaled');
  _wxFontScaled = wxFontScaledPtr.asFunction<_WxFontScaled>();

  // ------------------------- wxAnimation ----------------------

  final wxAnimationConstructorPtr = dylib.lookup <NativeFunction<_WxAnimationConstructorNative>>('wxAnimationConstructor');
  _wxAnimationConstructor = wxAnimationConstructorPtr.asFunction<_WxAnimationConstructor>();

  final wxAnimationIsOkPtr = dylib.lookup <NativeFunction<_WxAnimationIsOkNative>>('wxAnimationIsOk');
  _wxAnimationIsOk = wxAnimationIsOkPtr.asFunction<_WxAnimationIsOk>();

  final wxAnimationGetSizePtr = dylib.lookup <NativeFunction<_WxAnimationGetSizeNative>>('wxAnimationGetSize');
  _wxAnimationGetSize = wxAnimationGetSizePtr.asFunction<_WxAnimationGetSize>();

  final wxAnimationGetFrameCountPtr = dylib.lookup <NativeFunction<_WxAnimationGetFrameCountNative>>('wxAnimationGetFrameCount');
  _wxAnimationGetFrameCount = wxAnimationGetFrameCountPtr.asFunction<_WxAnimationGetFrameCount>();

  final wxAnimationGetDelayPtr = dylib.lookup <NativeFunction<_WxAnimationGetDelayNative>>('wxAnimationGetDelay');
  _wxAnimationGetDelay = wxAnimationGetDelayPtr.asFunction<_WxAnimationGetDelay>();

  final wxAnimationGetFramePtr = dylib.lookup <NativeFunction<_WxAnimationGetFrameNative>>('wxAnimationGetFrame');
  _wxAnimationGetFrame = wxAnimationGetFramePtr.asFunction<_WxAnimationGetFrame>();

  // ------------------------- wxReadOnlyDC ----------------------

  final wxReadOnlyDCGetContentScaleFactorPtr = dylib.lookup <NativeFunction<_WxReadOnlyDCGetContentScaleFactorNative>>('wxReadOnlyDCGetContentScaleFactor');
  _wxReadOnlyDCGetContentScaleFactor = wxReadOnlyDCGetContentScaleFactorPtr.asFunction<_WxReadOnlyDCGetContentScaleFactor>();

  final wxReadOnlyDCSetAxisOrientationPtr = dylib.lookup <NativeFunction<_WxReadOnlyDCSetAxisOrientationNative>>('wxReadOnlyDCSetAxisOrientation');
  _wxReadOnlyDCSetAxisOrientation = wxReadOnlyDCSetAxisOrientationPtr.asFunction<_WxReadOnlyDCSetAxisOrientation>();

  final wxReadOnlyDCSetDeviceOriginPtr = dylib.lookup <NativeFunction<_WxReadOnlyDCSetDeviceOriginNative>>('wxReadOnlyDCSetDeviceOrigin');
  _wxReadOnlyDCSetDeviceOrigin = wxReadOnlyDCSetDeviceOriginPtr.asFunction<_WxReadOnlyDCSetDeviceOrigin>();

  final wxReadOnlyDCGetDeviceOriginPtr = dylib.lookup <NativeFunction<_WxReadOnlyDCGetDeviceOriginNative>>('wxReadOnlyDCGetDeviceOrigin');
  _wxReadOnlyDCGetDeviceOrigin = wxReadOnlyDCGetDeviceOriginPtr.asFunction<_WxReadOnlyDCGetDeviceOrigin>();

  final wxReadOnlyDCSetUserScalePtr = dylib.lookup <NativeFunction<_WxReadOnlyDCSetUserScaleNative>>('wxReadOnlyDCSetUserScale');
  _wxReadOnlyDCSetUserScale = wxReadOnlyDCSetUserScalePtr.asFunction<_WxReadOnlyDCSetUserScale>();

  final wxReadOnlyDCSetLogicalScalePtr = dylib.lookup <NativeFunction<_WxReadOnlyDCSetLogicalScaleNative>>('wxReadOnlyDCSetLogicalScale');
  _wxReadOnlyDCSetLogicalScale = wxReadOnlyDCSetLogicalScalePtr.asFunction<_WxReadOnlyDCSetLogicalScale>();

  final wxReadOnlyDCDeviceToLogicalXPtr = dylib.lookup <NativeFunction<_WxReadOnlyDCDeviceToLogicalXNative>>('wxReadOnlyDCDeviceToLogicalX');
  _wxReadOnlyDCDeviceToLogicalX = wxReadOnlyDCDeviceToLogicalXPtr.asFunction<_WxReadOnlyDCDeviceToLogicalX>();

  final wxReadOnlyDCDeviceToLogicalXRelPtr = dylib.lookup <NativeFunction<_WxReadOnlyDCDeviceToLogicalXRelNative>>('wxReadOnlyDCDeviceToLogicalXRel');
  _wxReadOnlyDCDeviceToLogicalXRel = wxReadOnlyDCDeviceToLogicalXRelPtr.asFunction<_WxReadOnlyDCDeviceToLogicalXRel>();

  final wxReadOnlyDCDeviceToLogicalYPtr = dylib.lookup <NativeFunction<_WxReadOnlyDCDeviceToLogicalYNative>>('wxReadOnlyDCDeviceToLogicalY');
  _wxReadOnlyDCDeviceToLogicalY = wxReadOnlyDCDeviceToLogicalYPtr.asFunction<_WxReadOnlyDCDeviceToLogicalY>();

  final wxReadOnlyDCDeviceToLogicalYRelPtr = dylib.lookup <NativeFunction<_WxReadOnlyDCDeviceToLogicalYRelNative>>('wxReadOnlyDCDeviceToLogicalYRel');
  _wxReadOnlyDCDeviceToLogicalYRel = wxReadOnlyDCDeviceToLogicalYRelPtr.asFunction<_WxReadOnlyDCDeviceToLogicalYRel>();

  final wxReadOnlyDCLogicalToDeviceXPtr = dylib.lookup <NativeFunction<_WxReadOnlyDCLogicalToDeviceXNative>>('wxReadOnlyDCLogicalToDeviceX');
  _wxReadOnlyDCLogicalToDeviceX = wxReadOnlyDCLogicalToDeviceXPtr.asFunction<_WxReadOnlyDCLogicalToDeviceX>();

  final wxReadOnlyDCLogicalToDeviceXRelPtr = dylib.lookup <NativeFunction<_WxReadOnlyDCLogicalToDeviceXRelNative>>('wxReadOnlyDCLogicalToDeviceXRel');
  _wxReadOnlyDCLogicalToDeviceXRel = wxReadOnlyDCLogicalToDeviceXRelPtr.asFunction<_WxReadOnlyDCLogicalToDeviceXRel>();

  final wxReadOnlyDCLogicalToDeviceYPtr = dylib.lookup <NativeFunction<_WxReadOnlyDCLogicalToDeviceYNative>>('wxReadOnlyDCLogicalToDeviceY');
  _wxReadOnlyDCLogicalToDeviceY = wxReadOnlyDCLogicalToDeviceYPtr.asFunction<_WxReadOnlyDCLogicalToDeviceY>();

  final wxReadOnlyDCLogicalToDeviceYRelPtr = dylib.lookup <NativeFunction<_WxReadOnlyDCLogicalToDeviceYRelNative>>('wxReadOnlyDCLogicalToDeviceYRel');
  _wxReadOnlyDCLogicalToDeviceYRel = wxReadOnlyDCLogicalToDeviceYRelPtr.asFunction<_WxReadOnlyDCLogicalToDeviceYRel>();

  final wxReadOnlyDCSetFontPtr = dylib.lookup <NativeFunction<_WxReadOnlyDCSetFontNative>>('wxReadOnlyDCSetFont');
  _wxReadOnlyDCSetFont = wxReadOnlyDCSetFontPtr.asFunction<_WxReadOnlyDCSetFont>();

  final wxReadOnlyDCGetFontPtr = dylib.lookup <NativeFunction<_WxReadOnlyDCGetFontNative>>('wxReadOnlyDCGetFont');
  _wxReadOnlyDCGetFont = wxReadOnlyDCGetFontPtr.asFunction<_WxReadOnlyDCGetFont>();

  final wxReadOnlyDCGetTextExtentPtr = dylib.lookup <NativeFunction<_WxReadOnlyDCGetTextExtentNative>>('wxReadOnlyDCGetTextExtent');
  _wxReadOnlyDCGetTextExtent = wxReadOnlyDCGetTextExtentPtr.asFunction<_WxReadOnlyDCGetTextExtent>();

  final wxReadOnlyDCFromDIPPtr = dylib.lookup <NativeFunction<_WxReadOnlyDCFromDIPNative>>('wxReadOnlyDCFromDIP');
  _wxReadOnlyDCFromDIP = wxReadOnlyDCFromDIPPtr.asFunction<_WxReadOnlyDCFromDIP>();

  final wxReadOnlyDCGetPartialTextExtentsPtr = dylib.lookup <NativeFunction<_WxReadOnlyDCGetPartialTextExtentsNative>>('wxReadOnlyDCGetPartialTextExtents');
  _wxReadOnlyDCGetPartialTextExtents = wxReadOnlyDCGetPartialTextExtentsPtr.asFunction<_WxReadOnlyDCGetPartialTextExtents>();

  final wxReadOnlyDCGetTextExtentExPtr = dylib.lookup <NativeFunction<_WxReadOnlyDCGetTextExtentExNative>>('wxReadOnlyDCGetTextExtentEx');
  _wxReadOnlyDCGetTextExtentEx = wxReadOnlyDCGetTextExtentExPtr.asFunction<_WxReadOnlyDCGetTextExtentEx>();

  // ------------------------- wxDC ----------------------

  final wxDCSetTextForegroundPtr = dylib.lookup <NativeFunction<_WxDCSetTextForegroundNative>>('wxDCSetTextForeground');
  _wxDCSetTextForeground = wxDCSetTextForegroundPtr.asFunction<_WxDCSetTextForeground>();

  final wxDCGetTextForegroundPtr = dylib.lookup <NativeFunction<_WxDCGetTextForegroundNative>>('wxDCGetTextForeground');
  _wxDCGetTextForeground = wxDCGetTextForegroundPtr.asFunction<_WxDCGetTextForeground>();

  final wxDCSetTextBackgroundPtr = dylib.lookup <NativeFunction<_WxDCSetTextBackgroundNative>>('wxDCSetTextBackground');
  _wxDCSetTextBackground = wxDCSetTextBackgroundPtr.asFunction<_WxDCSetTextBackground>();

  final wxDCGetTextBackgroundPtr = dylib.lookup <NativeFunction<_WxDCGetTextBackgroundNative>>('wxDCGetTextBackground');
  _wxDCGetTextBackground = wxDCGetTextBackgroundPtr.asFunction<_WxDCGetTextBackground>();

  final wxDCSetBackgroundModePtr = dylib.lookup <NativeFunction<_WxDCSetBackgroundModeNative>>('wxDCSetBackgroundMode');
  _wxDCSetBackgroundMode = wxDCSetBackgroundModePtr.asFunction<_WxDCSetBackgroundMode>();

  final wxDCGetBackgroundModePtr = dylib.lookup <NativeFunction<_WxDCGetBackgroundModeNative>>('wxDCGetBackgroundMode');
  _wxDCGetBackgroundMode = wxDCGetBackgroundModePtr.asFunction<_WxDCGetBackgroundMode>();

  final wxDCSetClippingRegionPtr = dylib.lookup <NativeFunction<_WxDCSetClippingRegionNative>>('wxDCSetClippingRegion');
  _wxDCSetClippingRegion = wxDCSetClippingRegionPtr.asFunction<_WxDCSetClippingRegion>();

  final wxDCSetClippingRegionRectPtr = dylib.lookup <NativeFunction<_WxDCSetClippingRegionRectNative>>('wxDCSetClippingRegionRect');
  _wxDCSetClippingRegionRect = wxDCSetClippingRegionRectPtr.asFunction<_WxDCSetClippingRegionRect>();

  final wxDCDestroyClippingRegionPtr = dylib.lookup <NativeFunction<_WxDCDestroyClippingRegionNative>>('wxDCDestroyClippingRegion');
  _wxDCDestroyClippingRegion = wxDCDestroyClippingRegionPtr.asFunction<_WxDCDestroyClippingRegion>();

  final wxDCGetClippingBoxPtr = dylib.lookup <NativeFunction<_WxDCGetClippingBoxNative>>('wxDCGetClippingBox');
  _wxDCGetClippingBox = wxDCGetClippingBoxPtr.asFunction<_WxDCGetClippingBox>();

  final wxDCSetPenPtr = dylib.lookup <NativeFunction<_WxDCSetPenNative>>('wxDCSetPen');
  _wxDCSetPen = wxDCSetPenPtr.asFunction<_WxDCSetPen>();

  final wxDCGetPenPtr = dylib.lookup <NativeFunction<_WxDCGetPenNative>>('wxDCGetPen');
  _wxDCGetPen = wxDCGetPenPtr.asFunction<_WxDCGetPen>();

  final wxDCSetBrushPtr = dylib.lookup <NativeFunction<_WxDCSetBrushNative>>('wxDCSetBrush');
  _wxDCSetBrush = wxDCSetBrushPtr.asFunction<_WxDCSetBrush>();

  final wxDCGetBrushPtr = dylib.lookup <NativeFunction<_WxDCGetBrushNative>>('wxDCGetBrush');
  _wxDCGetBrush = wxDCGetBrushPtr.asFunction<_WxDCGetBrush>();

  final wxDCDrawLinePtr = dylib.lookup <NativeFunction<_WxDCDrawLineNative>>('wxDCDrawLine');
  _wxDCDrawLine = wxDCDrawLinePtr.asFunction<_WxDCDrawLine>();

  final wxDCDrawLinePtsPtr = dylib.lookup <NativeFunction<_WxDCDrawLinePtsNative>>('wxDCDrawLinePts');
  _wxDCDrawLinePts = wxDCDrawLinePtsPtr.asFunction<_WxDCDrawLinePts>();

  final wxDCDrawRectanglePtr = dylib.lookup <NativeFunction<_WxDCDrawRectangleNative>>('wxDCDrawRectangle');
  _wxDCDrawRectangle = wxDCDrawRectanglePtr.asFunction<_WxDCDrawRectangle>();

  final wxDCDrawRectangleRectPtr = dylib.lookup <NativeFunction<_WxDCDrawRectangleRectNative>>('wxDCDrawRectangleRect');
  _wxDCDrawRectangleRect = wxDCDrawRectangleRectPtr.asFunction<_WxDCDrawRectangleRect>();

  final wxDCDrawRoundedRectanglePtr = dylib.lookup <NativeFunction<_WxDCDrawRoundedRectangleNative>>('wxDCDrawRoundedRectangle');
  _wxDCDrawRoundedRectangle = wxDCDrawRoundedRectanglePtr.asFunction<_WxDCDrawRoundedRectangle>();

  final wxDCDrawRoundedRectangleRectPtr = dylib.lookup <NativeFunction<_WxDCDrawRoundedRectangleRectNative>>('wxDCDrawRoundedRectangleRect');
  _wxDCDrawRoundedRectangleRect = wxDCDrawRoundedRectangleRectPtr.asFunction<_WxDCDrawRoundedRectangleRect>();

  final wxDCDrawTextPtr = dylib.lookup <NativeFunction<_WxDCDrawTextNative>>('wxDCDrawText');
  _wxDCDrawText = wxDCDrawTextPtr.asFunction<_WxDCDrawText>();

  final wxDCDrawRotatedTextPtr = dylib.lookup <NativeFunction<_WxDCDrawRotatedTextNative>>('wxDCDrawRotatedText');
  _wxDCDrawRotatedText = wxDCDrawRotatedTextPtr.asFunction<_WxDCDrawRotatedText>();

  final wxDCDrawEllipticArcPtr = dylib.lookup <NativeFunction<_WxDCDrawEllipticArcNative>>('wxDCDrawEllipticArc');
  _wxDCDrawEllipticArc = wxDCDrawEllipticArcPtr.asFunction<_WxDCDrawEllipticArc>();

  final wxDCDrawArcPtr = dylib.lookup <NativeFunction<_WxDCDrawArcNative>>('wxDCDrawArc');
  _wxDCDrawArc = wxDCDrawArcPtr.asFunction<_WxDCDrawArc>();

  final wxDCDrawArcPtsPtr = dylib.lookup <NativeFunction<_WxDCDrawArcPtsNative>>('wxDCDrawArcPts');
  _wxDCDrawArcPts = wxDCDrawArcPtsPtr.asFunction<_WxDCDrawArcPts>();

  final wxDCDrawEllipsePtr = dylib.lookup <NativeFunction<_WxDCDrawEllipseNative>>('wxDCDrawEllipse');
  _wxDCDrawEllipse = wxDCDrawEllipsePtr.asFunction<_WxDCDrawEllipse>();

  final wxDCDrawEllipseRectPtr = dylib.lookup <NativeFunction<_WxDCDrawEllipseRectNative>>('wxDCDrawEllipseRect');
  _wxDCDrawEllipseRect = wxDCDrawEllipseRectPtr.asFunction<_WxDCDrawEllipseRect>();

  final wxDCDrawCirclePtr = dylib.lookup <NativeFunction<_WxDCDrawCircleNative>>('wxDCDrawCircle');
  _wxDCDrawCircle = wxDCDrawCirclePtr.asFunction<_WxDCDrawCircle>();

  final wxDCDrawCirclePtsPtr = dylib.lookup <NativeFunction<_WxDCDrawCirclePtsNative>>('wxDCDrawCirclePts');
  _wxDCDrawCirclePts = wxDCDrawCirclePtsPtr.asFunction<_WxDCDrawCirclePts>();

  final wxDCDrawPointPtr = dylib.lookup <NativeFunction<_WxDCDrawPointNative>>('wxDCDrawPoint');
  _wxDCDrawPoint = wxDCDrawPointPtr.asFunction<_WxDCDrawPoint>();

  final wxDCDrawPointPtPtr = dylib.lookup <NativeFunction<_WxDCDrawPointPtNative>>('wxDCDrawPointPt');
  _wxDCDrawPointPt = wxDCDrawPointPtPtr.asFunction<_WxDCDrawPointPt>();

  final wxDCDrawBitmapPtr = dylib.lookup <NativeFunction<_WxDCDrawBitmapNative>>('wxDCDrawBitmap');
  _wxDCDrawBitmap = wxDCDrawBitmapPtr.asFunction<_WxDCDrawBitmap>();

  final wxDCDrawLinesPtr = dylib.lookup <NativeFunction<_WxDCDrawLinesNative>>('wxDCDrawLines');
  _wxDCDrawLines = wxDCDrawLinesPtr.asFunction<_WxDCDrawLines>();

  final wxDCDrawSplinePtr = dylib.lookup <NativeFunction<_WxDCDrawSplineNative>>('wxDCDrawSpline');
  _wxDCDrawSpline = wxDCDrawSplinePtr.asFunction<_WxDCDrawSpline>();

  final wxDCDrawPolygonPtr = dylib.lookup <NativeFunction<_WxDCDrawPolygonNative>>('wxDCDrawPolygon');
  _wxDCDrawPolygon = wxDCDrawPolygonPtr.asFunction<_WxDCDrawPolygon>();

  final wxDCGradientFillLinearPtr = dylib.lookup <NativeFunction<_WxDCGradientFillLinearNative>>('wxDCGradientFillLinear');
  _wxDCGradientFillLinear = wxDCGradientFillLinearPtr.asFunction<_WxDCGradientFillLinear>();

  final wxDCGradientFillConcentricPtr = dylib.lookup <NativeFunction<_WxDCGradientFillConcentricNative>>('wxDCGradientFillConcentric');
  _wxDCGradientFillConcentric = wxDCGradientFillConcentricPtr.asFunction<_WxDCGradientFillConcentric>();

  final wxDCGradientFillConcentricWithCenterPtr = dylib.lookup <NativeFunction<_WxDCGradientFillConcentricWithCenterNative>>('wxDCGradientFillConcentricWithCenter');
  _wxDCGradientFillConcentricWithCenter = wxDCGradientFillConcentricWithCenterPtr.asFunction<_WxDCGradientFillConcentricWithCenter>();

  // ------------------------- wxPaintDC ----------------------

  final wxPaintDCConstructorPtr = dylib.lookup <NativeFunction<_WxPaintDCConstructorNative>>('wxPaintDCConstructor');
  _wxPaintDCConstructor = wxPaintDCConstructorPtr.asFunction<_WxPaintDCConstructor>();

  // ------------------------- wxInfoDC ----------------------

  final wxInfoDCConstructorPtr = dylib.lookup <NativeFunction<_WxInfoDCConstructorNative>>('wxInfoDCConstructor');
  _wxInfoDCConstructor = wxInfoDCConstructorPtr.asFunction<_WxInfoDCConstructor>();

  // ------------------------- wxMemoryDC ----------------------

  final wxMemoryDCConstructorPtr = dylib.lookup <NativeFunction<_WxMemoryDCConstructorNative>>('wxMemoryDCConstructor');
  _wxMemoryDCConstructor = wxMemoryDCConstructorPtr.asFunction<_WxMemoryDCConstructor>();

  final wxMemoryDCGetBitmapPtr = dylib.lookup <NativeFunction<_WxMemoryDCGetBitmapNative>>('wxMemoryDCGetBitmap');
  _wxMemoryDCGetBitmap = wxMemoryDCGetBitmapPtr.asFunction<_WxMemoryDCGetBitmap>();

  // ------------------------- wxRendererNative ----------------------

  final wxRendererNativeDrawItemTextPtr = dylib.lookup <NativeFunction<_WxRendererNativeDrawItemTextNative>>('wxRendererNativeDrawItemText');
  _wxRendererNativeDrawItemText = wxRendererNativeDrawItemTextPtr.asFunction<_WxRendererNativeDrawItemText>();

  final wxRendererNativeDrawCheckBoxPtr = dylib.lookup <NativeFunction<_WxRendererNativeDrawCheckBoxNative>>('wxRendererNativeDrawCheckBox');
  _wxRendererNativeDrawCheckBox = wxRendererNativeDrawCheckBoxPtr.asFunction<_WxRendererNativeDrawCheckBox>();

  final wxRendererNativeDrawCheckMarkPtr = dylib.lookup <NativeFunction<_WxRendererNativeDrawCheckMarkNative>>('wxRendererNativeDrawCheckMark');
  _wxRendererNativeDrawCheckMark = wxRendererNativeDrawCheckMarkPtr.asFunction<_WxRendererNativeDrawCheckMark>();

  final wxRendererNativeDrawRadioBitmapPtr = dylib.lookup <NativeFunction<_WxRendererNativeDrawRadioBitmapNative>>('wxRendererNativeDrawRadioBitmap');
  _wxRendererNativeDrawRadioBitmap = wxRendererNativeDrawRadioBitmapPtr.asFunction<_WxRendererNativeDrawRadioBitmap>();

  final wxRendererNativeDrawGaugePtr = dylib.lookup <NativeFunction<_WxRendererNativeDrawGaugeNative>>('wxRendererNativeDrawGauge');
  _wxRendererNativeDrawGauge = wxRendererNativeDrawGaugePtr.asFunction<_WxRendererNativeDrawGauge>();

  final wxRendererNativeDrawTreeItemButtonPtr = dylib.lookup <NativeFunction<_WxRendererNativeDrawTreeItemButtonNative>>('wxRendererNativeDrawTreeItemButton');
  _wxRendererNativeDrawTreeItemButton = wxRendererNativeDrawTreeItemButtonPtr.asFunction<_WxRendererNativeDrawTreeItemButton>();

  final wxRendererNativeGetExpanderSizePtr = dylib.lookup <NativeFunction<_WxRendererNativeGetExpanderSizeNative>>('wxRendererNativeGetExpanderSize');
  _wxRendererNativeGetExpanderSize = wxRendererNativeGetExpanderSizePtr.asFunction<_WxRendererNativeGetExpanderSize>();

  final wxRendererNativeDrawFocusRectPtr = dylib.lookup <NativeFunction<_WxRendererNativeDrawFocusRectNative>>('wxRendererNativeDrawFocusRect');
  _wxRendererNativeDrawFocusRect = wxRendererNativeDrawFocusRectPtr.asFunction<_WxRendererNativeDrawFocusRect>();

  final wxRendererNativeDrawItemSelectionRectPtr = dylib.lookup <NativeFunction<_WxRendererNativeDrawItemSelectionRectNative>>('wxRendererNativeDrawItemSelectionRect');
  _wxRendererNativeDrawItemSelectionRect = wxRendererNativeDrawItemSelectionRectPtr.asFunction<_WxRendererNativeDrawItemSelectionRect>();

  final wxRendererNativeDrawHeaderButtonPtr = dylib.lookup <NativeFunction<_WxRendererNativeDrawHeaderButtonNative>>('wxRendererNativeDrawHeaderButton');
  _wxRendererNativeDrawHeaderButton = wxRendererNativeDrawHeaderButtonPtr.asFunction<_WxRendererNativeDrawHeaderButton>();

  final wxRendererNativeGetHeaderButtonHeightPtr = dylib.lookup <NativeFunction<_WxRendererNativeGetHeaderButtonHeightNative>>('wxRendererNativeGetHeaderButtonHeight');
  _wxRendererNativeGetHeaderButtonHeight = wxRendererNativeGetHeaderButtonHeightPtr.asFunction<_WxRendererNativeGetHeaderButtonHeight>();

  final wxRendererNativeGetHeaderButtonMarginPtr = dylib.lookup <NativeFunction<_WxRendererNativeGetHeaderButtonMarginNative>>('wxRendererNativeGetHeaderButtonMargin');
  _wxRendererNativeGetHeaderButtonMargin = wxRendererNativeGetHeaderButtonMarginPtr.asFunction<_WxRendererNativeGetHeaderButtonMargin>();

}
