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

    // the sizes in the major direction, as in wxBoxSizer::RepositionChildren()
    final majorSizes = _distributeMajor(shown, majorSize);

    int pos = 0;
    for (int n = 0; n < shown.length; n++) {
      final item = shown[n];
      final minSize = item.getMinSizeWithBorder();
      final itemMajor = majorSizes[n];

      final flag = item.getFlag();
      int itemMinor = _minor(minSize);
      int minorPos = 0;
      // like wxWidgets: an item too big for the minor direction is truncated
      if ((flag & wxEXPAND) != 0 || itemMinor > minorSize) {
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

  /// Distributes [majorSize] among the [shown] items like
  /// wxBoxSizer::RepositionChildren() in wxWidgets (without max sizes):
  ///
  /// * if there is not even enough space for the min sizes, the items
  ///   without proportion get their min size (or what is left), then the
  ///   others get theirs (or what is left), the rest gets nothing
  /// * otherwise the whole size is shared according to the proportions;
  ///   an item whose share would be below its min size gets its min size
  ///   and the others share what remains
  List<int> _distributeMajor(List<WxSizerItem> shown, int majorSize) {
    final minMajor = [for (final item in shown) max(0, _major(item.getMinSizeWithBorder()))];
    final sizes = List<int>.filled(shown.length, -1);
    int remaining = majorSize;
    int totalProportion = 0;
    for (final item in shown) {
      totalProportion += item.getProportion();
    }

    int minOrRemaining(int n) {
      if (remaining <= 0) return 0;
      final size = min(minMajor[n], remaining);
      remaining -= size;
      return size;
    }

    if (majorSize < minMajor.fold(0, (a, b) => a + b)) {
      for (int n = 0; n < shown.length; n++) {
        if (shown[n].getProportion() == 0) sizes[n] = minOrRemaining(n);
      }
      for (int n = 0; n < shown.length; n++) {
        if (shown[n].getProportion() != 0) sizes[n] = minOrRemaining(n);
      }
      return sizes;
    }

    // fix the items without proportion, and those whose share would be too
    // small, at their min size; each one changes the shares of the others,
    // so start over after it
    bool changed = true;
    while (changed) {
      changed = false;
      for (int n = 0; n < shown.length; n++) {
        if (sizes[n] != -1) continue;
        final proportion = shown[n].getProportion();
        if (proportion != 0) {
          if (remaining * proportion ~/ totalProportion >= minMajor[n]) continue;
          totalProportion -= proportion;
        }
        sizes[n] = minMajor[n];
        remaining -= minMajor[n];
        changed = true;
        break;
      }
    }

    // share the rest among the other items
    for (int n = 0; n < shown.length; n++) {
      if (sizes[n] != -1) continue;
      final proportion = shown[n].getProportion();
      sizes[n] = remaining * proportion ~/ totalProportion;
      remaining -= sizes[n];
      totalProportion -= proportion;
    }
    return sizes;
  }
}
