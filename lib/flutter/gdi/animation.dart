// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxAnimation ----------------------

/// Represent a simple image animation owned by [WxAnimationCtrl]
/// 
/// Not to be mixed up with [WxUIAnimation]

class WxAnimation extends WxObject {
  /// Creates an animation from a GIF image.
  /// 
  /// [path] is relative to [WxStandardPaths.getResourcesDir]
  WxAnimation( String path ) {
    _path = path;
  }

  late String _path;
}

