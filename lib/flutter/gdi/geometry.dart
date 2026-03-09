// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxSize ----------------------

/// Represents a size on screen. 
/// 
/// This class is constant.
/// 
/// # Global objects 
/// | Object | value |
/// | -------- | -------- |
/// | wxDefaultSize | WxSize( -1, -1 ) |

class WxSize {
  const WxSize( this.x, this.y );
  static WxSize zero = WxSize(0, 0);
  final int x;
  final int y;
  bool isEmpty() {
    return (x <= 0) || (y <= 0);
  }
  int getHeight() {
    return y;
  }
  int getWidth() {
    return x;
  }
}

/// Constant describing default size, or no size at all
const wxDefaultSize = WxSize( -1, -1 );

// ------------------------- wxPoint ----------------------

/// Represents a position on screen. 
/// 
/// This class is constant.
/// 
/// # Global objects 
/// | Object | value |
/// | -------- | -------- |
/// | wxDefaultPosition | WxPoint( -1, -1 ) |

class WxPoint {
  const WxPoint( this.x, this.y );
  static WxPoint zero = WxPoint(0, 0);
  final int x;
  final int y;
}

/// Constant describing the default position, or no position at all
const wxDefaultPosition = WxPoint( -1, -1 );

// ------------------------- wxRect ----------------------

/// Represents a rectangle on screen. 
/// 
/// Use [WxRect.fromRect] to create a deep copy.

class WxRect {
  /// Creates a rectangle with the given start and dimensions
  WxRect( this.x, this.y, this.width, this.height );
  /// Creates a empty rectangle at the origin
  WxRect.zero() {
    x = 0;
    y = 0;
    width = 0;
    height = 0;
  }
  /// Creates a deep-copy from [rect]
  WxRect.fromRect( WxRect rect ) {
    x = rect.x;
    y = rect.y;
    width = rect.width;
    height = rect.height;
  }
  /// Creates a rectangle from [pos] and [size]
  WxRect.fromPositionAndSize( WxPoint pos, WxSize size ) {
    x = pos.x;
    y = pos.y;
    width = size.x;
    height = size.y;
  }
  /// Creates a rectangle from two points. The two points only
  /// need to be at any opposite corners.
  WxRect.fromPoints( WxPoint point1, WxPoint point2 ) {
    x = point1.x;
    y = point1.y;
    width = point2.x - point1.x;
    height = point2.y - point1.y;
    if (width < 0) {
        width = -width;
        x = point2.x;
    }
    if (height < 0) {
        height = -height;
        y = point2.y;
    }
    width++;
    height++;
  }
  /// Creates rectangle from size at origin 0,0
  WxRect.fromSize( WxSize size ) {
    x = 0;
    y = 0;
    width = size.x;
    height = size.y;
  }
  /// Get left border
  int getX() {
    return x;
  }
  /// Get top border
  int getY() {
    return y;
  }
  /// Get width
  int getWidth() {
    return width;
  }
  /// Get height
  int getHeight() {
    return height;
  }

  late int x;
  late int y;
  late int width;
  late int height;
  WxPoint getPosition() {
    return WxPoint(x, y);
  }
  void setPosition( WxPoint pos ) {
    x = pos.x;
    y = pos.y;
  }
  WxSize getSize() {
    return WxSize(width,height);
  }
  bool isEmpty() {
    return (width <= 0) || (height <= 0);
  }
  WxPoint getTopLeft() {
    return WxPoint(x, y);
  }
  WxPoint getTopRight() {
    return WxPoint(x+width-1, y);
  }
  WxPoint getBottomLeft() {
    return WxPoint(x,y+height-1);
  }
  WxPoint getBottomRight() {
    return WxPoint(x+width-1,y+height-1);
  }
  int getLeft() {
    return x;
  }
  int getTop() {
    return y;
  }
  int getRight() {
    return x+width-1;
  }
  int getBottom() {
    return y+height-1;
  }
  bool contains( int x1, int y1 ) {
    return ( (x1 >= x) && (y1 >= y) && ((y1 - y) < height) && ((x1 - x) < width) );
  }
  /// Returns true of the rect contains the point [pos]
  bool containsPoint( WxPoint pos ) {
    return ( (pos.x >= x) && (pos.y >= y) && ((pos.y - y) < height) && ((pos.x - x) < width) );
  }
  bool containsRect( WxRect rect ) {
    return containsPoint(rect.getTopLeft()) && containsPoint(rect.getBottomRight());
  }
  /// Grows this rectangle by [dx] and [dy]. Shrinks it when given negative values,
  /// but not below the width or height of 0.
  void inflate( int dx, int dy ) {
    x -= dx;
    y -= dy;
    width += 2*dx;
    height += 2*dy;
    if (width < 0) {
      x += width~/2;
      width = 0;
    }
    if (height < 0) {
      y += height~/2;
      height = 0;
    }
  }
  /// Shrinks this rectangle by [dx] and [dy] but not below the width or height of 0.
  void deflate( int dx, int dy ) {
    inflate( -dx, -dy );
  }

  /// Returns true if this rectangle intersects with [rect]
  bool intersects( final WxRect rect )
  {
    final x1 = max( getLeft(), rect.getLeft() );
    final y1 = max( getTop(), rect.getTop() );
    final x2 = min( getRight(), rect.getRight() );
    final y2 = min( getBottom(), rect.getBottom() );
    return (x2 - x1 + 1 > 0) && (y2 - y1 + 1 > 0);
  }
}