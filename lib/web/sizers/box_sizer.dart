// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-11-15
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxBoxSizer ----------------------

/// Arranges items in a row (wxHORIZONTAL, see [WxRow]) or a column
/// (wxVERTICAL, see [WxColumn]).
///
/// Items get their minimal size in the main direction; remaining space
/// is distributed among items with a proportion > 0 according to their
/// proportion. In the other direction, items fill the sizer with wxEXPAND
/// or are aligned with wxALIGN_CENTER_xxx, wxALIGN_RIGHT or wxALIGN_BOTTOM.
class WxBoxSizer extends WxSizer {
  /// Creates a box sizer with the given orientation
  WxBoxSizer(int orientation) {
    _orientation = orientation;
  }

  late int _orientation;

  /// Sets the orientation
  void setOrientation(int orientation) {
    _orientation = orientation;
    _requestLayout();
  }

  /// Returns the orientation
  int getOrientation() {
    return _orientation;
  }

  bool isVertical() {
    return _orientation == wxVERTICAL;
  }

  bool get _horizontal => _orientation != wxVERTICAL;
  int _major(WxSize s) => _horizontal ? s.x : s.y;
  int _minor(WxSize s) => _horizontal ? s.y : s.x;
  WxSize _make(int major, int minor) => _horizontal ? WxSize(major, minor) : WxSize(minor, major);

  int get _minorDirection => _horizontal ? wxVERTICAL : wxHORIZONTAL;

  /// Passes the available size on to the items: in the minor direction
  /// (the width of a [WxColumn]) every item gets all of it, in the major
  /// direction (the width of a [WxRow]) the items with a proportion > 0
  /// get their share of what the other items leave.
  @override
  bool informFirstDirection(int direction, int size, int availableOtherDir) {
    final shown = _items.where((item) => item.isShown()).toList();
    bool used = false;
    if (direction == _minorDirection) {
      for (final item in shown) {
        used |= item.informFirstDirection(direction, size, -1);
      }
      return used;
    }
    int fixed = 0;
    int totalProportion = 0;
    for (final item in shown) {
      if (item.getProportion() > 0) {
        totalProportion += item.getProportion();
      } else {
        fixed += _major(item.getMinSizeWithBorder());
      }
    }
    if (totalProportion == 0) return false;
    int remaining = max(0, size - fixed);
    int remainingProportion = totalProportion;
    for (final item in shown) {
      final proportion = item.getProportion();
      if (proportion == 0) continue;
      final share = (remaining * proportion / remainingProportion).round();
      remaining -= share;
      remainingProportion -= proportion;
      used |= item.informFirstDirection(direction, share, -1);
    }
    return used;
  }

  @override
  WxSize calcMin() {
    int totalProportion = 0;
    int fixedMajor = 0;
    double maxMajorPerProportion = 0;
    int minor = 0;
    for (final item in _items) {
      if (!item.isShown()) continue;
      final size = item.getMinSizeWithBorder();
      final proportion = item.getProportion();
      if (proportion > 0) {
        // like wxWidgets: respect the proportions in the minimal size too
        totalProportion += proportion;
        maxMajorPerProportion = max(maxMajorPerProportion, _major(size) / proportion);
      } else {
        fixedMajor += _major(size);
      }
      minor = max(minor, _minor(size));
    }
    final major = fixedMajor + (maxMajorPerProportion * totalProportion).ceil();
    return _make(major, minor);
  }

  @override
  void repositionChildren() {
    final shown = _items.where((item) => item.isShown()).toList();
    if (shown.isEmpty) return;

    final majorSize = _major(_size);
    final minorSize = _minor(_size);

    // the items know their size in the minor direction already, which
    // can change their minimal size in the major direction (wrapping)
    for (final item in shown) {
      item.informFirstDirection(_minorDirection, minorSize, -1);
    }

    int totalProportion = 0;
    int sumMinMajor = 0;
    for (final item in shown) {
      totalProportion += item.getProportion();
      sumMinMajor += _major(item.getMinSizeWithBorder());
    }
    int remainingExtra = max(0, majorSize - sumMinMajor);
    int remainingProportion = totalProportion;

    int pos = 0;
    for (final item in shown) {
      final minSize = item.getMinSizeWithBorder();
      int itemMajor = _major(minSize);
      final proportion = item.getProportion();
      if (proportion > 0 && remainingProportion > 0) {
        final share = (remainingExtra * proportion / remainingProportion).round();
        itemMajor += share;
        remainingExtra -= share;
        remainingProportion -= proportion;
      }

      final flag = item.getFlag();
      int itemMinor = _minor(minSize);
      int minorPos = 0;
      if ((flag & wxEXPAND) != 0) {
        itemMinor = minorSize;
      } else if (_horizontal) {
        if ((flag & wxALIGN_CENTER_VERTICAL) != 0) {
          minorPos = (minorSize - itemMinor) ~/ 2;
        } else if ((flag & wxALIGN_BOTTOM) != 0) {
          minorPos = minorSize - itemMinor;
        }
      } else {
        if ((flag & wxALIGN_CENTER_HORIZONTAL) != 0) {
          minorPos = (minorSize - itemMinor) ~/ 2;
        } else if ((flag & wxALIGN_RIGHT) != 0) {
          minorPos = minorSize - itemMinor;
        }
      }

      final itemPos = _horizontal
          ? WxPoint(_position.x + pos, _position.y + minorPos)
          : WxPoint(_position.x + minorPos, _position.y + pos);
      item.setDimension(itemPos, _make(itemMajor, itemMinor));
      pos += itemMajor;
    }
  }
}
