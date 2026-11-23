// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-11-16
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxWrapSizer ----------------------

/// The last item on each line takes up the remaining space of the line
const int wxEXTEND_LAST_ON_EACH_LINE = 1;

/// Spacers at the beginning of a line are left out
const int wxREMOVE_LEADING_SPACES = 2;

/// wxEXTEND_LAST_ON_EACH_LINE | wxREMOVE_LEADING_SPACES
const int wxWRAPSIZER_DEFAULT_FLAGS = 3;

/// This sizer wraps the child items when there is not
/// enough space horizontally. Typically used on small
/// devices when only scrolling vertically is the norm.
///
/// Items are placed in lines (rows for wxHORIZONTAL, columns for
/// wxVERTICAL). Within a line, the items are aligned in the other direction
/// with the wxALIGN_xxx flags or fill the line with wxEXPAND; items with
/// a proportion > 0 share the free space of their line.
///
/// The sizer needs to know where to wrap before it can compute its minimal
/// size. It learns the available size from the containing sizer (e.g. the
/// width of a [WxColumn]) or from a [WxScrolledWindow] that scrolls only
/// vertically (see [informFirstDirection]). Without that information, its
/// minimal width is that of its widest item, so that it can shrink.
///
/// ```dart
///   final tags = WxWrapSizer();
///   for (final name in ["Dart", "Flutter", "wxWidgets", "HTML", "CSS"]) {
///     tags.add(WxButton(this, -1, name), flag: wxALL, border: 4);
///   }
///   column.addSizer(tags, flag: wxEXPAND);
/// ```
///
/// # Flags
/// | constant | meaning |
/// | -------- | -------- |
/// | wxEXTEND_LAST_ON_EACH_LINE | the last item of each line gets the remaining space |
/// | wxREMOVE_LEADING_SPACES | spacers at the beginning of a line are left out (default) |
/// | wxWRAPSIZER_DEFAULT_FLAGS | both |
class WxWrapSizer extends WxBoxSizer {
  WxWrapSizer({int orient = wxHORIZONTAL, int flags = wxREMOVE_LEADING_SPACES}) : super(orient) {
    _flags = flags;
  }

  late int _flags;

  /// The size in the major direction given by [informFirstDirection]
  int _availableSize = -1;

  bool _isSpacer(WxSizerItem item) => item.isSpacer() && item.getProportion() == 0;

  /// Distributes the shown items over lines that fit into [available]
  List<List<WxSizerItem>> _lines(int available) {
    final lines = <List<WxSizerItem>>[];
    List<WxSizerItem> line = [];
    int used = 0;
    for (final item in _items) {
      if (!item.isShown()) continue;
      final major = _major(item.getMinSizeWithBorder());
      if (line.isNotEmpty && used + major > available) {
        lines.add(line);
        line = [];
        used = 0;
      }
      if (line.isEmpty && (_flags & wxREMOVE_LEADING_SPACES) != 0 && _isSpacer(item)) {
        continue;
      }
      line.add(item);
      used += major;
    }
    if (line.isNotEmpty) lines.add(line);
    return lines;
  }

  int _lineMinor(List<WxSizerItem> line) {
    int minor = 0;
    for (final item in line) {
      minor = max(minor, _minor(item.getMinSizeWithBorder()));
    }
    return minor;
  }

  /// Uses the size in the major direction to know where to wrap
  @override
  bool informFirstDirection(int direction, int size, int availableOtherDir) {
    if (direction != (_horizontal ? wxHORIZONTAL : wxVERTICAL)) return false;
    _availableSize = size;
    return true;
  }

  @override
  WxSize calcMin() {
    // the widest item (so that the sizer can shrink down to it)
    int widest = 0;
    int highest = 0;
    for (final item in _items) {
      if (!item.isShown()) continue;
      final size = item.getMinSizeWithBorder();
      widest = max(widest, _major(size));
      highest = max(highest, _minor(size));
    }
    // Before the available size is known (see informFirstDirection), only
    // the largest single item, like wxWidgets (CalcMaxSingleItemSize).
    // Putting each item in a line of its own would add up the heights of
    // all items and make the parent much too large.
    if (_availableSize <= 0) return _make(widest, highest);
    final available = max(_availableSize, widest);
    int major = 0;
    int minor = 0;
    for (final line in _lines(available)) {
      int lineMajor = 0;
      for (final item in line) {
        lineMajor += _major(item.getMinSizeWithBorder());
      }
      major = max(major, lineMajor);
      minor += _lineMinor(line);
    }
    return _make(major, minor);
  }

  @override
  void repositionChildren() {
    final majorSize = _major(_size);
    int minorPos = 0;
    for (final line in _lines(majorSize)) {
      final lineMinor = _lineMinor(line);

      int sumMajor = 0;
      int totalProportion = 0;
      for (final item in line) {
        sumMajor += _major(item.getMinSizeWithBorder());
        totalProportion += item.getProportion();
      }
      int remainingExtra = max(0, majorSize - sumMajor);
      int remainingProportion = totalProportion;

      int majorPos = 0;
      for (int i = 0; i < line.length; i++) {
        final item = line[i];
        final minSize = item.getMinSizeWithBorder();
        int itemMajor = _major(minSize);
        final proportion = item.getProportion();
        if (proportion > 0 && remainingProportion > 0) {
          final share = (remainingExtra * proportion / remainingProportion).round();
          itemMajor += share;
          remainingExtra -= share;
          remainingProportion -= proportion;
        }
        if (i == line.length - 1 && (_flags & wxEXTEND_LAST_ON_EACH_LINE) != 0) {
          itemMajor = max(itemMajor, majorSize - majorPos);
        }

        final flag = item.getFlag();
        int itemMinor = _minor(minSize);
        int offset = 0;
        if ((flag & wxEXPAND) != 0) {
          itemMinor = lineMinor;
        } else if (_horizontal) {
          if ((flag & wxALIGN_CENTER_VERTICAL) != 0) {
            offset = (lineMinor - itemMinor) ~/ 2;
          } else if ((flag & wxALIGN_BOTTOM) != 0) {
            offset = lineMinor - itemMinor;
          }
        } else {
          if ((flag & wxALIGN_CENTER_HORIZONTAL) != 0) {
            offset = (lineMinor - itemMinor) ~/ 2;
          } else if ((flag & wxALIGN_RIGHT) != 0) {
            offset = lineMinor - itemMinor;
          }
        }

        final itemPos = _horizontal
            ? WxPoint(_position.x + majorPos, _position.y + minorPos + offset)
            : WxPoint(_position.x + minorPos + offset, _position.y + majorPos);
        item.setDimension(itemPos, _make(itemMajor, itemMinor));
        majorPos += itemMajor;
      }
      minorPos += lineMinor;
    }
  }
}
