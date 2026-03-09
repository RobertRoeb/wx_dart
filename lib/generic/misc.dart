// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../wx_dart.dart';

// ----------------------- wxValidator --------------------
/*
  WxValidator? _validator;
  void setValidator( WxValidator? validator ) {
    _validator = validator;
  }
  WxValidator? getValidator() {
    return _validator;
  }
*/
/// Validators are currently not supported in wxDart.

class WxValidator {
  WxValidator();

  WxWindow? _window;

  void setWindow( WxWindow? window ) {
    _window = window;
  }
  WxWindow? getWindow() {
    return _window;
  }

  bool transferFromWindow() {
    return true;
  }
  bool transferToWindow() {
    return true;
  }
  bool validate( WxWindow parent ) {
    return true;
  }
}

// ----------------------- wxStopWatch --------------------

/// Represents a stop watch to measure time.
/// 
/// ```dart
/// final watch = WxStopWatch();
/// watch.start();
/// 
/// // do something interesting
/// 
/// if (watch.time() > 200) {
///   print( "You lost!" )
/// }
/// ```
/// 
/// This class is actually implementated in pure Dart and 
/// has only been added to make porting code from C++ easier.

class WxStopWatch {
  WxStopWatch() {
    _stopWatch = Stopwatch();
  }

  /// Start stop watch, optionally with a start time in milliseconds
  void start( { int milliseconds = 0 } ) {
    _startValue = milliseconds;
    _stopWatch.reset();
    _stopWatch.start();
  }

  /// Returns elapsed time in milliseconds
  int time() {
    return _stopWatch.elapsedMilliseconds + _startValue;
  }

  /// Returns elapsed time in microseconds
  int timeInMicro() {
    return _stopWatch.elapsedMicroseconds + _startValue*1000;
  }

  void stop() {
    _stopWatch.reset();
  }

  void resume() {
    _stopWatch.start();
  }

  void pause() {
    _stopWatch.stop();
  }

  bool isRunning() {
    return _stopWatch.isRunning;
  }

  late final Stopwatch _stopWatch;
  int _startValue = 0;
}

// ----------------------- wxSelectionStore ---------------------

/// Helper class that keeps track of a list of selected rows
/// or indeces.

class WxSelectionStore
{
    WxSelectionStore();

    void setItemCount(int count) {}

    void clear() { 
      _itemsSel.clear();
    }

    /// must be called when new items are inserted/added
    void onItemsInserted( int item, int numItems) {
      for (int i = 0; i < _itemsSel.length; i++) {
        if (item <= _itemsSel[i]) {
          _itemsSel[i] += numItems;
        }
      }
    }

    /// must be called when an item was deleted
    void onItemDelete( int item ) {
      for (int i = 0; i < _itemsSel.length; i++) {
        final value = _itemsSel[i];
        if (value == item) {
          _itemsSel.removeAt(i);
          i--;
        } else if (value > item) {
          _itemsSel[i] -= 1;
        }
      }
    } 

    /// must be called when a items were deleted
    bool onItemsDeleted( int item, int numItems) {
      for (int i = 0; i < _itemsSel.length; i++) {
        final value = _itemsSel[i];
        if (value >= item && value < item+numItems) {
          _itemsSel.removeAt(i);
          i--;
        } else if (value > item) {
          _itemsSel[i] -= numItems;
        }
      }
      return true;
    }

    /// Selects or deselects an item
    bool selectItem( int item, { bool select = true } ) {
      if (select) {
        if (_itemsSel.contains(item)) return false;
        _itemsSel.add(item);
        return true;
      } else {
        if (!_itemsSel.contains(item)) return false;
        _itemsSel.removeWhere( (element) { return element == item; } );
        return true;
      }
    }

    bool toggleItem( int item ) {
      return selectItem( item, select: !isSelected(item) );
    }

    bool selectRange(int itemFrom, int itemTo, { bool select = true } ) {
      if (select) {
        for (int i = itemFrom; i <= itemTo; i++) {
          if (!_itemsSel.contains(i)) {
            _itemsSel.add(i);
          }
        }
      } else {
        _itemsSel.removeWhere( (element) { return element >= itemFrom && element <= itemTo; } );
      }
      return true;
    }

    bool isSelected( int item ) {
      return _itemsSel.contains( item );
    }

    bool isEmpty() {
      return _itemsSel.isEmpty;
    }

    // return the total number of selected items
    int getSelectedCount() {
      return _itemsSel.length;
    }

    List<int> getList() {
      return _itemsSel;
    }

    int getFirstSelectedItem() {
      if (_itemsSel.isEmpty) return -1;
      int ret = _itemsSel[0];
      for (final item in _itemsSel) {
        if (item < ret) ret = item;
      }
      return ret;
    }

    final List <int> _itemsSel = [];


    void printList() {
      for (final end in _itemsSel) {
        print( "$end");
      }
    }
}

// ------------------------- wxHeightCache ----------------------

/// Helper class to cache the height of lines in controls
/// that allow for variable line heights
class WxHeightCache
{
    WxHeightCache();

    bool hasLineStart( int row ) {
      if (row < 0) return false;
      return row <= _ends.length; 
    }
    bool hasLineHeight( int row ) {
      if (row < 0) return false;
      return row < _ends.length; 
    }

    int getLineStart( int row ) {
      if (row == 0) return 0;
      return _ends[row-1] +1;
    }

    int getLineHeight( int row ) {
      if (row == 0) return _ends[0];
      return _ends[row] - _ends[row-1];
    }

    int getLineAt( int y )
    {
      int counter = 0;
      for (final end in _ends) {
        if (y < end) return counter;
        counter ++;
      }
      return counter; // one past the last one
    }

    void put( int row, int height )
    {
      if (row == _ends.length) 
      {
        add( height );
        return;
      }
      if (row > _ends.length)
      {
        wxLogError( "entry not in cache" );
        return;
      }
      int last = _ends[row];
      if (row > 0) {
        last -= _ends[row-1];
      }
      final diff = height - last;
      if (diff == 0) return;
      for (int i = row; i < _ends.length; i++) {
        _ends[i] += diff;
      }
    }

    void add( int height )
    {
      if (_ends.isEmpty) {
        _ends.add( height );
      } else {
        final last = _ends[_ends.length-1];
        _ends.add( last + height );
      }
    }

    void remove( int row )
    {
      if (row >= _ends.length) return;
      int diff = _ends[row];
      if (row > 0) {
        diff -= _ends[row-1];
      }
      _ends.removeAt(row);
      for (int i = row; i < _ends.length; i++) {
        _ends[i] -= diff;
      }
    }

    void clear()
    {
      _ends.clear();
    }

    /*  
    example
    Line height #0: 20
    Line height #1: 30
    Line height #2: 40

    _ends[0] = 20
    _ends[1] = 50
    _ends[2] = 90
    */
    final List <int> _ends = [];   

    void printList() {
      for (int i = 0; i < _ends.length; i++) {
        print( "Height of #$i: ${getLineHeight(i)}" );
      }
      for (final end in _ends) {
        print( "$end");
      }
      // print( "line at 49px: ${getLineAt(49)}" );
      // print( "line at 50px: ${getLineAt(50)}" );
    }
}

// ----------------------------------------------------------------------------
// wxMaxWidthCalculator: base class for calculating max column width
// ----------------------------------------------------------------------------

abstract class WxMaxWidthCalculator
{
    WxMaxWidthCalculator(this._column);

    final int _column;
    int _width = 0;

    void updateWithWidth(int width)
    {
        _width = max(_width, width);
    }

    // Update the max with for the expected row
    void updateWithRow(int row);

    int getMaxWidth() { 
      return _width;
    }
    int getColumn() { 
      return _column;
    }

    void computeBestColumnWidth( int count, int firstVisible, int lastVisible )
    {
        // Arbitrarily measure the first 200 rows and all visible rows and the
        // 20 rows around the visiable rows.
        // The original C++ code is measuring time and adapts the magic 200
        // (actually 500) depending on if things go fast or not

        firstVisible = max( 0, firstVisible+20 );
        lastVisible = min( count, lastVisible+20 );

        int topPartEnd = min(200, count);

        int row = 0;

        final watch = WxStopWatch();
        watch.start();
        for ( row = 0; row < topPartEnd; row++ )
        {
          // measure time each 10th row to see if we are too slow
          if (row % 10 == 0) {
            if (watch.time() > 20)  {
              // don't measure rows more than 20ms
              break;
            }
          }
            updateWithRow(row);
        }

        // row is the first unmeasured item now; that's our value of N/2
        if ( row < count )
        {
            topPartEnd = row;

            // add bottom N/2 items now:
            final bottomPartStart = max(row, count - row);
            for ( row = bottomPartStart; row < count; row++ )
            {
                updateWithRow(row);
            }

            // finally, include currently visible items in the calculation:
            firstVisible = max(firstVisible, topPartEnd);
            lastVisible = max(bottomPartStart, lastVisible);

            for ( row = firstVisible; row < lastVisible; row++ ) {
                updateWithRow(row);
            }
        }
    }
}

