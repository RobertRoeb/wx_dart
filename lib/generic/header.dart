// ---------------------------------------------------------------------------
// Name:        header.dart
// Name:        src/generic/headerctrlg.cpp (wxWidgets C++)
// Purpose:     generic wxHeaderCtrl implementation
// Author:      Vadim Zeitlin
// Created:     2008-12-03
// Copyright:   (c) 2008 Vadim Zeitlin
// Copyright:   (c) 2026 Robert Roebling (Dart version)
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../wx_dart.dart';

// ------------------------- event types ----------------------
final _wxHeaderCtrlClickEventType = wxNewEventType();
int wxGetHeaderCtrlClickEventType()                 { return _wxHeaderCtrlClickEventType; }

final _wxHeaderCtrlRightClickEventType = wxNewEventType();
int wxGetHeaderCtrlRightClickEventType()            { return _wxHeaderCtrlRightClickEventType; }

final _wxHeaderCtrlDClickEventType = wxNewEventType();
int wxGetHeaderCtrlDClickEventType()                { return _wxHeaderCtrlDClickEventType; }

final _wxHeaderCtrlRightDClickEventType = wxNewEventType();
int wxGetHeaderCtrlRightDClickEventType()           { return _wxHeaderCtrlRightDClickEventType; }

final _wxGetHeaderCtrlSeparatorDClickEventType = wxNewEventType();
int wxGetHeaderCtrlSeparatorDClickEventType()       { return _wxGetHeaderCtrlSeparatorDClickEventType; }

final _wxGetHeaderCtrlBeginResizeEventType = wxNewEventType();
int wxGetHeaderCtrlBeginResizeEventType()           { return _wxGetHeaderCtrlBeginResizeEventType; }

final _wxHeaderCtrlResizingEventType = wxNewEventType();
int wxGetHeaderCtrlResizingEventType()              { return _wxHeaderCtrlResizingEventType; }

final _wxHeaderCtrlEndResizeEventType = wxNewEventType();
int wxGetHeaderCtrlEndResizeEventType()             { return _wxHeaderCtrlEndResizeEventType; }

final _wxHeaderCtrlBeginReorderEventType = wxNewEventType();
int wxGetHeaderCtrlBeginReorderEventType()          { return _wxHeaderCtrlBeginReorderEventType; }

final _wxHeaderCtrlEndReorderEventType = wxNewEventType();
int wxGetHeaderCtrlEndReorderEventType()            { return _wxHeaderCtrlEndReorderEventType; }

final _wxHeaderCtrlDraggingCancelledEventType = wxNewEventType();
int wxGetHeaderCtrlDraggingCancelledEventType()     { return _wxHeaderCtrlDraggingCancelledEventType; }

// ------------------------- wxHeaderColumn ----------------------

const int wxCOL_WIDTH_DEFAULT = -1;
const int wxCOL_WIDTH_AUTOSIZE = -2;
const int wxCOL_RESIZABLE = 1;
const int wxCOL_SORTABLE = 2;
const int wxCOL_REORDERABLE = 4;
const int wxCOL_HIDDEN = 8;
const int wxCOL_DEFAULT_FLAGS = wxCOL_RESIZABLE | wxCOL_REORDERABLE;

class WxHeaderColumn {

  late String _title;
  late WxBitmap _bitmap;
  late int _width;
  int _minWidth = 0;
  late int _flags;
  late int _alignment;
  bool _isSortKey = false;
  bool _isSortOrderAscending = true;

  String getTitle( ) {
    return _title;
  }

  WxBitmap getBitmap( ) {
    return _bitmap;
  }

  int getWidth( ) {
    return _width;
  }

  int getMinWidth( ) {
    return _minWidth;
  }

  int getFlags( ) {
    return _flags;
  }

  int getAlignment( ) {
    return _alignment;
  }

  bool hasFlag( int flag ) {
    return ((_flags & flag) != 0);
  }

  bool isHidden( ) {
    return hasFlag( wxCOL_HIDDEN );
  }

  bool isShown( ) {
    return !hasFlag( wxCOL_HIDDEN );
  }

  bool isResizeable( ) {
    return hasFlag( wxCOL_RESIZABLE );
  }

  bool isReorderable() {
    return hasFlag( wxCOL_REORDERABLE );
  }

  bool isSortable( ) {
    return hasFlag( wxCOL_SORTABLE );
  }

  bool isSortKey( ) {
    return _isSortKey;
  }

  bool isSortOrderAscending( ) {
    return _isSortOrderAscending;
  }
}

// ------------------------- wxSettableHeaderColumn ----------------------

class WxSettableHeaderColumn extends WxHeaderColumn {

  void setTitle( String title ) {
    _title = title;
  }

  void setBitmap( WxBitmap bitmap ) {
    _bitmap = bitmap;
  }

  void setWidth( int width ) {
    _width = width;
  }

  void setMinWidth( int minWidth ) {
    _minWidth = minWidth;
  }

  void setFlags( int flags ) {
    _flags = flags;
  }

  void setFlag( int flag ) {
    _flags = _flags | flag;
  }

  void clearFlag( int flag ) {
    _flags = _flags & ~flag;
  }

  void toggleFlag( int flag ) {
    if (hasFlag(flag)) {
      clearFlag(flag);
    } else {
      setFlag(flag);
    }
  }

  void setAlignment( int alignment ) {
    _alignment = alignment;
  }

  void setResizeable( bool resizable ) {
    setFlag( wxCOL_RESIZABLE );
  }

  void setSortable( bool sortable ) {
    setFlag( wxCOL_SORTABLE );
  }

  void setHidden( bool hidden ) {
    setFlag( wxCOL_HIDDEN );
  }

  void unsetAsSortKey( ) {
    _isSortKey = false;
  }

  void setSortOrder( bool ascending ) {
    _isSortOrderAscending = ascending;
  }

  void toggleSortOrder( ) {
    _isSortOrderAscending = !_isSortOrderAscending;
  }
}

// ------------------------- wxHeaderColumnSimple ----------------------

class WxHeaderColumnSimple extends WxSettableHeaderColumn {
  WxHeaderColumnSimple( String title, { int width = wxCOL_WIDTH_DEFAULT, int alignment = wxALIGN_NOT, int flags = wxCOL_DEFAULT_FLAGS } ) {
    _title = title;
    _width = width;
    _alignment = alignment;
    _flags = flags;
  }
}

// ------------------------- wxHeaderCtrlBase ----------------------

const int wxHD_ALLOW_REORDER = 0x0001;
const int wxHD_ALLOW_HIDE = 0x0002;
const int wxHD_BITMAP_ON_RIGHT = 0x0004;
const int wxHD_DEFAULT_STYLE = wxHD_ALLOW_REORDER;

abstract class WxHeaderCtrlBase extends WxWindow {
  WxHeaderCtrlBase( WxWindow parent,  int id, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = 0 } ) : 
    super( parent, id, pos, size, style ) 
  {
    bindHeaderCtrlSeparatorDClickEvent( onSeparatorDClick, wxID_ANY );
    bindHeaderCtrlRightClickEvent( onRClick, wxID_ANY );
  }

  // pure virtuals 
  WxHeaderColumn getColumn( int index );
  void updateColumnVisibility( int index, bool show ) {}
  void updateColumnsOrder( List<int> order ) {}
  bool updateColumnWidthToFit( int index, int widthTitle );
  void onColumnCountChanging( int count ) {}


  void setColumnCount( int count ) {
    if ( count != getColumnCount() ) {
        onColumnCountChanging(count);
    }
    doSetCount(count);
  }

  int getColumnCount() {
    return doGetCount();
  }

  bool isEmpty( ) {
    return true;
  }

  void updateColumn( int index ) {
    doUpdate(index);
  }

  List<int> getColumnsOrder() {
    return doGetColumnsOrder();
  }

  void setColumnsOrder( List<int> order ) {

    // check the array validity
    // final count = getColumnCount();

    doSetColumnsOrder(order);
  }

  int getColumnAt( int pos ) {
    return getColumnsOrder()[pos];
  }

  int getColumnPos( int index ) {
    final order = getColumnsOrder();
    int pos = order.indexOf(index);
    if (pos < 0) {
      return -1;
    }
    return pos;
  }

  void resetColumnsOrder( ) {
    final count = getColumnCount();
    List<int> order = [];
    for ( int n = 0; n < count; n++ ) {
        order.add( n );
    }
    doSetColumnsOrder(order);
  }

  bool showColumnsMenu( WxPoint pos, { String title = "" } ) {
    return false;
  }

  bool showCustomizeDialog( ) {
    return false;
  }

  void addColumnsItems( WxMenu menu, { int idColumnsBase = 0 } ) {
  }

  int getColumnTitleWidthFromIndex(int idx) {
    return getColumnTitleWidth(getColumn(idx));
  }

  int getColumnTitleWidth( WxHeaderColumn col ) {

    int w = getTextExtent(col.getTitle()).x;

    w += wxGetRendererNative().getHeaderButtonMargin(this);

    // if a bitmap is used, add space for it and 2px border:
    /* 
    final bmp = col.getBitmap();  // TODO getBitmapBundle();
    if ( bmp.isOk() ) {
        w += bmp.getWidth()+2; //   bmp.GetPreferredLogicalSizeFor(this).GetWidth() + 2;
    }
    */

    return w;
  }

  @override
  bool acceptsFocusFromKeyboard() { 
    return false;
  }

  @override
  bool acceptsFocus() { 
    return false;
  }

  @override
  void scrollWindow( int dx, int dy ) {
    doScrollHorz(dx);
  }

  void doResizeColumnIndices( List<int> colIndices,int count)
  {
    // update the column indices array if necessary
    final countOld = colIndices.length;
    if ( count > countOld )
    {
        // all new columns have default positions equal to their indices
        for ( int n = countOld; n < count; n++ ) {
            colIndices.add(n);
        }
    }
    else if ( count < countOld )
    {
        // filter out all the positions which are invalid now while keeping the
        // order of the remaining ones
        List<int> colIndicesNew= [];
        for ( int n = 0; n < countOld; n++ )
        {
            final idx = colIndices[n];
            if ( idx < count ) {
              colIndicesNew.add(idx);
            }
        }

        colIndices = colIndicesNew;
    }
    //else: count didn't really change, nothing to do
  }

  void doSetCount(int count) {
  }
  
  // pure virtuals 
  int doGetCount();
  void doUpdate(int idx);
  void doScrollHorz(int dx);
  void doSetColumnsOrder( List<int> order);
  List<int> doGetColumnsOrder();


  void onSeparatorDClick(WxHeaderCtrlEvent event)
  {
    int col = event.getColumn();
    final column = getColumn(col);
    if ( !column.isResizeable() )
    {
        event.skip();
        return;
    }
    int w = getColumnTitleWidth(column);
    if ( !updateColumnWidthToFit(col, w) ) {
        event.skip();
    } else {
        updateColumn(col);
    }
  }

  void onRClick(WxHeaderCtrlEvent event)
  {
    if ( !hasFlag(wxHD_ALLOW_HIDE) )
    {
        event.skip();
        return;
    }
    // showColumnsMenu(ScreenToClient(wxGetMousePosition()));
  }

  static void moveColumnInOrderArray(List<int> order, int idx, int pos)
  {
      int posOld = order.indexOf(idx);
      if (posOld == -1) {
        wxLogError("invalid index in HeaderCtrl column order");
        return;
      }

      if ( pos != posOld )
      {
          order.removeAt(posOld);
          order.insert(idx, pos);
      }
  } 

}

// ------------------------- wxHeaderCtrl ----------------------


abstract class WxHeaderCtrl extends WxHeaderCtrlBase {
  WxHeaderCtrl(super.parent, super.id, { super.pos = wxDefaultPosition, super.size = wxDefaultSize, super.style = wxHD_DEFAULT_STYLE } ) {
    bindPaintEvent(onPaint);
    bindLeftDownEvent(onMouseEvents);
    bindLeftUpEvent(onMouseEvents);
    bindLeftDClickEvent(onMouseEvents);
    bindRightDownEvent(onMouseEvents);
    bindRightUpEvent(onMouseEvents);
    bindRightDClickEvent(onMouseEvents);
    bindMotionEvent(onMouseEvents);
    bindLeaveWindowEvent(onMouseEvents);
  }

  int _numColumns = 0;
  int _hover = -1;
  int _colBeingResized = -1;
  int _colBeingReordered = -1;
  int _dragOffset = 0;
  int _scrollOffset = 0;
  List<int> _colIndices = [];
  bool _wasSeparatorDClick = false;
  bool _localOnSeparator = false;
  int _localXPhysical = 0;

  // implement base class pure virtuals
  @override
  void doSetCount( int count)
  {
    doResizeColumnIndices(_colIndices, count);
    _numColumns = count;
    if ( _hover >= count ) {
      _hover = -1;
    }
    invalidateBestSize();
    refresh();
  }

  @override
  int doGetCount() {
    return _numColumns;
  } 

  @override
  void doUpdate(int idx) {
    invalidateBestSize();
    refreshColsAfter(idx);
  }

  @override
  void doScrollHorz(int dx) {
    _scrollOffset += dx;
    refresh();
  }

  @override
  void doSetColumnsOrder(List<int> order) {
    _colIndices = order;
    refresh();
  }

  @override
  List<int> doGetColumnsOrder() {
    return _colIndices;
  }

  void onPaint(WxPaintEvent event)
  {
    final clientSize = getClientSize();

    final dc = WxPaintDC(this);

    dc.setDeviceOrigin(_scrollOffset, 0);

    final count = _numColumns;
    int xpos = 0;
    for ( int i = 0; i < count; i++ )
    {
        final idx = _colIndices[i];
        final WxHeaderColumn col = getColumn(idx);
        if ( col.isHidden() ) continue;

        int colWidth = col.getWidth();

        int sortArrow = wxHDR_SORT_ICON_NONE;
        if ( col.isSortKey() )
        {
            sortArrow = col.isSortOrderAscending() ? wxHDR_SORT_ICON_UP
                                                   : wxHDR_SORT_ICON_DOWN;
        }
        // else not sorting by this column

        int state = 0;
        if ( isEnabled() )
        {
            if ( idx == _hover ) {
                state = wxCONTROL_CURRENT;
            }
        }
        else // disabled
        {
            state = wxCONTROL_DISABLED;
        }

        if (i == 0) {
           state |= wxCONTROL_SPECIAL;
        }

        wxGetRendererNative().drawHeaderButton
                                (
                                    this,
                                    dc,
                                    WxRect(xpos, 0, colWidth, clientSize.y),
                                    flags: state,
                                    sortArrow: sortArrow
                                ); 
        dc.setTextForeground(  wxTheApp.isDark() ? wxWHITE : wxBLACK );

        String finalText = col.getTitle();
        final text = col.getTitle();
        final textExtent = dc.getTextExtent( text );
        if (textExtent.x > colWidth)
        {
          for (int i = text.length; i > 0; i--) {
            finalText = "${text.substring(0,i)}...";
            if (dc.getTextExtent(finalText).x <= colWidth) break;
          }
        }
        dc.drawText( finalText, xpos+3, (clientSize.y-textExtent.y)~/2 - 1 ); 

        xpos += colWidth;
    }
    if (xpos < clientSize.x)
    {
        int state = wxCONTROL_DIRTY;
        if (!isEnabled()) {
            state |= wxCONTROL_DISABLED;
        }
        wxGetRendererNative().drawHeaderButton(
            this, dc, 
            WxRect(xpos, 0, clientSize.x - xpos, clientSize.y), 
            flags: state);
    }
    dc.setPen( wxTheApp.isDark() ? wxGREY_PEN : wxLIGHT_GREY_PEN );
    dc.setBrush( wxTRANSPARENT_BRUSH );
    dc.drawRectangle(0, 0, clientSize.x, clientSize.y );
  }

  void onMouseEvents(WxMouseEvent mevent)
  {
    final wasSeparatorDClick = _wasSeparatorDClick;
    _wasSeparatorDClick = false;

    // do this in advance to allow simply returning if we're not interested,
    // we'll undo it if we do handle the event below
    mevent.skip();


    // account for the control displacement
    final xPhysical = mevent.getX();

    // first deal with the [continuation of any] dragging operations in
    // progress
    if ( isResizing() )
    {
        if ( mevent.leftUp() ) {
            endResizing(xPhysical);
        }  else {
          // update the live separator position
            startOrContinueResizing(_colBeingResized, xPhysical);
        }

        return;
    }

    if ( isReordering() )
    {
        if ( !mevent.leftUp() )
        {
            // update the column position
            // updateReorderingMarker(xPhysical);

            return;
        }

        // finish reordering and continue to generate a click event below if we
        // didn't really reorder anything
        if ( endReordering(xPhysical) ) {
            return;
        }
    }


    // find if the event is over a column at all
    bool onSeparator;
    _localOnSeparator = false;
    final col = mevent.leaving()
                            ? -1
                            : findColumnAtPoint(xPhysical /*, &onSeparator*/);
    onSeparator = _localOnSeparator;

    // update the highlighted column if it changed
    if ( col != _hover )
    {
        final hoverOld = _hover;
        _hover = col;

        refreshColIfNotNone(hoverOld);
        refreshColIfNotNone(_hover);
    }

    // update mouse cursor as it moves around
    if ( mevent.moving() )
    {
        setCursor(onSeparator ? WxCursor(wxCURSOR_SIZEWE) : null);
        return;
    }

    // all the other events only make sense when they happen over a column
    if ( col == -1 )
        return;


    // enter various dragging modes on left mouse press
    if ( mevent.leftDown() )
    {
        if ( onSeparator )
        {
            // start resizing the column
            if (isResizing()) {
              wxLogError( "reentering column resize mode?" );
              return;
            } 
            startOrContinueResizing(col, xPhysical);
        }
        // on column itself - both header and column must have the appropriate
        // flags to allow dragging the column
        else if ( hasFlag(wxHD_ALLOW_REORDER) && getColumn(col).isReorderable() )
        {
            // start resizing the column
            if (isReordering()) {
              wxLogError( "reentering column reorder mode?" );
              return;
            } 

            startReordering(col, xPhysical);
        }

        return;
    }

    // determine the type of header event corresponding to click events
    int evtType = 0;
    final click = mevent.buttonUp();
    final dblclk = mevent.buttonDClick();
    if ( click || dblclk )
    {
        switch ( mevent.getButton() )
        {
            case wxMOUSE_BTN_LEFT:
                // treat left double clicks on separator specially
                if ( onSeparator && dblclk )
                {
                    evtType = wxGetHeaderCtrlSeparatorDClickEventType();
                    _wasSeparatorDClick = true;
                }
                else if (!wasSeparatorDClick)
                {
                    evtType = click ? wxGetHeaderCtrlClickEventType()
                                    : wxGetHeaderCtrlDClickEventType();
                }
                break;

            case wxMOUSE_BTN_RIGHT:
                evtType = click ? wxGetHeaderCtrlRightClickEventType()
                                : wxGetHeaderCtrlRightDClickEventType();
                break;

            default:
                // ignore clicks from other mouse buttons
                ;
        }
    }

    if ( evtType == 0 )  return;

    final event = WxHeaderCtrlEvent (evtType, id: getId());
    event.setEventObject(this);
    event.setColumn(col);

    if ( processEvent(event) ) {
        mevent.skip( skip: false );
    }
  }

  void doMoveCol( int idx, int pos) {
    WxHeaderCtrlBase.moveColumnInOrderArray(_colIndices, idx, pos );
    refresh();
  }

  int getColStart( int idx)
  {
    int pos = _scrollOffset;
    for ( int n = 0; ; n++ )
    {
        final i = _colIndices[n];
        if ( i == idx ) break;

        final WxHeaderColumn col = getColumn(i);
        if ( col.isShown() ) {
            pos += col.getWidth();
        }
    }

    return pos;
  }

  int getColEnd( int idx) {
    int x = getColStart(idx);
    return x + getColumn(idx).getWidth();
  }

  void refreshCol( int idx) {
    refresh();
  }

  void refreshColIfNotNone( int idx) {
    refresh();
  }

  void refreshColsAfter( int idx) {
    refresh();
  }

  int findColumnAtPoint(int xPhysical /*, bool *onSeparator = nullptr*/ )
  {
    int pos = 0;
    int xLogical = xPhysical - _scrollOffset;
    final count = getColumnCount();
    for ( int n = 0; n < count; n++ )
    {
        final idx = _colIndices[n];
        final WxHeaderColumn col = getColumn(idx);
        if ( col.isHidden() ) continue;

        pos += col.getWidth();

        // TODO: don't hardcode sensitivity
        final separatorClickMargin = fromDIP(8);

        // if the column is resizable, check if we're approximatively over the
        // line separating it from the next column
        if ( col.isResizeable() && (xLogical - pos).abs() < separatorClickMargin )
        {
            _localOnSeparator = true;
            return idx;
        }

        // inside this column?
        if ( xLogical < pos )
        {
            _localOnSeparator = false;
            return idx;
        }
    }

    _localOnSeparator = false;
    return -1;
  }

    // return the result of FindColumnAtPoint() if it is a valid column,
    // otherwise the index of the last (rightmost) displayed column
  int findColumnClosestToPoint(int xPhysical)
  {
    final colIndexAtPoint = findColumnAtPoint(xPhysical);

    // valid column found?
    if ( colIndexAtPoint != -1 ) {
        return colIndexAtPoint;
    }

    // if not, xPhysical must be beyond the rightmost column, so return its
    // index instead -- if we have it
    final count = getColumnCount();
    if ( count == 0) {
        return -1;
    }

    return _colIndices[count - 1];
  }

  bool isResizing() {
    return _colBeingResized != -1;;
  }

  bool isReordering() {
    return _colBeingReordered != -1;
  }

  bool isDragging() { 
    return isResizing() || isReordering();
  }

  void endDragging() {
    setCursor( null );
  }

  void cancelDragging()
  {
    endDragging();

    final col = isResizing() ? _colBeingResized : _colBeingReordered;

    final event = WxHeaderCtrlEvent(wxGetHeaderCtrlDraggingCancelledEventType(), id: getId());
    event.setEventObject(this);
    event.setColumn(col);

    processEvent(event);

    _colBeingResized = -1;
    _colBeingReordered = -1;
  }

  void startOrContinueResizing( int col, int xPhysical)
  {
    final event = WxHeaderCtrlEvent(
        isResizing() ? wxGetHeaderCtrlResizingEventType()
                     : wxGetHeaderCtrlBeginResizeEventType(),
                      id: getId());
    event.setEventObject(this);
    event.setColumn(col);

    _localXPhysical = xPhysical;
    event.setWidth(constrainByMinWidth(col));

    if ( processEvent(event) && !event.isAllowed() )
    {
        if ( isResizing() )
        {
            releaseMouse();
            cancelDragging();
        }
        //else: nothing to do -- we just don't start to resize
    }
    else // go ahead with resizing
    {
        if ( !isResizing() )
        {
            _colBeingResized = col;
            setCursor( WxCursor(wxCURSOR_SIZEWE) );
            captureMouse();
        }
        //else: we had already done the above when we started
    }
  }

  void endResizing(int xPhysical)
  {
    if (!isResizing()) return;

    endDragging();

    releaseMouse();

    final event = WxHeaderCtrlEvent( wxGetHeaderCtrlEndResizeEventType(), id: getId());
    event.setEventObject(this);
    event.setColumn(_colBeingResized);
    _localXPhysical = xPhysical;
    event.setWidth(constrainByMinWidth(_colBeingResized));

    processEvent(event);

    _colBeingResized = -1;
  }

  void startReordering( int col, int xPhysical)
  {
    final event = WxHeaderCtrlEvent (wxGetHeaderCtrlBeginReorderEventType(), id: getId());
    event.setEventObject(this);
    event.setColumn(col);

    if ( processEvent(event) && !event.isAllowed() )
    {
        // don't start dragging it, nothing to do otherwise
        return;
    }

    _dragOffset = xPhysical - getColStart(col);

    _colBeingReordered = col;
    setCursor( WxCursor(wxCURSOR_HAND) );
    captureMouse();
  }

  bool endReordering(int xPhysical)
  {
    if (!isReordering()) return false;

    endDragging();

    releaseMouse();

    final colOld = _colBeingReordered;
    final colNew = findColumnClosestToPoint(xPhysical);

    _colBeingReordered = -1;

    // mouse drag must be longer than min distance m_dragOffset
    if ( xPhysical - getColStart(colOld) == _dragOffset )
    {
        return false;
    }

    // cannot proceed without a valid column index
    if ( colNew == -1 )
    {
        return false;
    }

    if ( colNew != colOld )
    {
        final event = WxHeaderCtrlEvent(wxGetHeaderCtrlEndReorderEventType(), id: getId());
        event.setEventObject(this);
        event.setColumn(colOld);

        final pos = getColumnPos(colNew);
        event.setNewOrder(pos);

        final processed = processEvent(event);

        if ( !processed )
        {
            // get the reordered columns
            List<int> order = getColumnsOrder();
            WxHeaderCtrlBase.moveColumnInOrderArray(order, colOld, pos);

            // As the event wasn't processed, call the virtual function
            // callback.
            updateColumnsOrder(order);

            // update columns order
            setColumnsOrder(order);
        }
        else if ( event.isAllowed() )
        {
            // do reorder the columns
            doMoveCol(colOld, pos);
        }
    }
    return true;
  }

  int constrainByMinWidth( int col /*, int& xPhysical*/ )
  {
    final xStart = getColStart(col);

    // notice that GetMinWidth() returns 0 if there is no minimal width so it
    // still makes sense to use it even in this case
    final xMinEnd = xStart + getColumn(col).getMinWidth();

    if ( _localXPhysical < xMinEnd ) {
      _localXPhysical = xMinEnd;
    }

    return _localXPhysical - xStart;
  }

}

// ------------------------- wxHeaderCtrl ----------------------

class WxHeaderCtrlSimple extends WxHeaderCtrl {
  WxHeaderCtrlSimple( super.parent, super.id, { super.pos = wxDefaultPosition, super.size = wxDefaultSize, super.style = wxHD_DEFAULT_STYLE } )
  {
    bindHeaderCtrlResizingEvent((event) {
      _cols[event.getColumn()].setWidth(event.getWidth());
      refresh();
    }, wxID_ANY ); 
  }

  final List<WxHeaderColumnSimple> _cols = [];
  int _sortKey = -1;

  void _updateColumnCount() {
    setColumnCount(_cols.length);
  }

  @override
  WxHeaderColumn getColumn( int index ) {
    return _cols[index];
  }

  @override
  void updateColumnVisibility( int index, bool show ) {
    showColumn(index, show: show );
  }

  @override
  bool updateColumnWidthToFit( int index, int widthTitle ) {
    final widthContents = getBestFittingWidth();
    if (widthContents == -1) return false;
    _cols[index].setWidth(widthContents>widthTitle?widthContents:widthTitle);
    return true;
  }

  int getBestFittingWidth() {
    return -1;
  }

  void insertColumn( WxHeaderColumnSimple col, int index ) {
    _cols.insert(index, 
      WxHeaderColumnSimple (col.getTitle(), width: col.getWidth(), flags: col.getFlags(), alignment: col.getAlignment()) );
    _updateColumnCount();
  }

  void appendColumn( WxHeaderColumnSimple col ) {
    _cols.add(
      WxHeaderColumnSimple (col.getTitle(), width: col.getWidth(), flags: col.getFlags(), alignment: col.getAlignment()) );
    _updateColumnCount();
  }

  void deleteColumn( int index ) {
    _cols.removeAt(index);
    if (index == _sortKey) {
      _sortKey = -1;
    }
    _updateColumnCount();
  }

  void deleteAllColumns() {
    _cols.clear();
    _sortKey = -1;
    _updateColumnCount();
  }

  void showColumn( int index, { bool show = true } ) {
    if (show != _cols[index].isShown()) {
      _cols[index].setHidden(!show);
      updateColumn(index);
    }
  }

  void hideColumn( int index ) {
    showColumn(index, show: false );
  }

  void showSortIndicator( int index, { bool ascending = true } ) {
    removeSortIndicator();
    _cols[index].setSortOrder(ascending);
    _sortKey = index;
    updateColumn(index);
  }

  void removeSortIndicator( ) {
    if (_sortKey != -1) {
      final sortOld = _sortKey;
      _sortKey = -1;
      _cols[sortOld].unsetAsSortKey();
      updateColumn(sortOld);
    }
  }
}


// ------------------------- wxHeaderCtrlEvent ----------------------

class WxHeaderCtrlEvent extends WxNotifyEvent {
  WxHeaderCtrlEvent( int eventType, { int id = 0 } ) : super( eventType, id );

  int _column = -1;
  int _width = -1;
  int _order = -1;

  int getColumn( ) {
    return _column;
  }

  void setColumn( int column ) {
    _column = column;
  }

  int getWidth( ) {
    return _width;
  }

  void setWidth( int width ) {
    _width = width;
  }

  int getNewOrder( ) {
    return _order;
  }

  void setNewOrder( int order ) {
    _order = order;
  }
}

// ------------------------- wxHeaderCtrlEvent ----------------------

typedef OnHeaderCtrlEventFunc = void Function( WxHeaderCtrlEvent event );

class WxHeaderCtrlEventTableEntry extends WxEventTableEntry {
  WxHeaderCtrlEventTableEntry( super.eventType, super.id, this.func );
  final OnHeaderCtrlEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return (eventType == eventTypeTested) && ((id == wxID_ANY) || (id == idTested));
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxHeaderCtrlEvent) {
      func( event );
    }
  }
}

/// @nodoc

extension HeaderCtrlClickEventBinder on WxEvtHandler {
  void bindHeaderCtrlClickEvent( OnHeaderCtrlEventFunc func, int id ) {
    _eventTable.add( WxHeaderCtrlEventTableEntry(wxGetHeaderCtrlClickEventType(), id, func));
  }

  void unbindHeaderCtrlClickEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetHeaderCtrlClickEventType(), id));
  }
}

/// @nodoc

extension HeaderCtrlRightClickEventBinder on WxEvtHandler {
  void bindHeaderCtrlRightClickEvent( OnHeaderCtrlEventFunc func, int id ) {
    _eventTable.add( WxHeaderCtrlEventTableEntry(wxGetHeaderCtrlRightClickEventType(), id, func));
  }

  void unbindHeaderCtrlRightClickEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetHeaderCtrlRightClickEventType(), id));
  }
}

/// @nodoc

extension HeaderCtrlDClickEventBinder on WxEvtHandler {
  void bindHeaderCtrlDClickEvent( OnHeaderCtrlEventFunc func, int id ) {
    _eventTable.add( WxHeaderCtrlEventTableEntry(wxGetHeaderCtrlDClickEventType(), id, func));
  }

  void unbindHeaderCtrlDClickEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetHeaderCtrlDClickEventType(), id));
  }
}

/// @nodoc

extension HeaderCtrlRightDClickEventBinder on WxEvtHandler {
  void bindHeaderCtrlRightDClickEvent( OnHeaderCtrlEventFunc func, int id ) {
    _eventTable.add( WxHeaderCtrlEventTableEntry(wxGetHeaderCtrlRightDClickEventType(), id, func));
  }

  void unbindHeaderCtrlRightDClickEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetHeaderCtrlRightDClickEventType(), id));
  }
}

/// @nodoc

extension HeaderCtrlSeparatorDClickEventBinder on WxEvtHandler {
  void bindHeaderCtrlSeparatorDClickEvent( OnHeaderCtrlEventFunc func, int id ) {
    _eventTable.add( WxHeaderCtrlEventTableEntry(wxGetHeaderCtrlSeparatorDClickEventType(), id, func));
  }

  void unbindHeaderCtrlSeparatorDClickEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetHeaderCtrlSeparatorDClickEventType(), id));
  }
}

/// @nodoc

extension HeaderCtrlBeginResizeEventBinder on WxEvtHandler {
  void bindHeaderCtrlBeginResizeEvent( OnHeaderCtrlEventFunc func, int id ) {
    _eventTable.add( WxHeaderCtrlEventTableEntry(wxGetHeaderCtrlBeginResizeEventType(), id, func));
  }

  void unbindHeaderCtrlBeginResizeEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetHeaderCtrlBeginResizeEventType(), id));
  }
}

/// @nodoc

extension HeaderCtrlResizingEventBinder on WxEvtHandler {
  void bindHeaderCtrlResizingEvent( OnHeaderCtrlEventFunc func, int id ) {
    _eventTable.add( WxHeaderCtrlEventTableEntry(wxGetHeaderCtrlResizingEventType(), id, func));
  }

  void unbindHeaderCtrlResizingEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetHeaderCtrlResizingEventType(), id));
  }
}

/// @nodoc

extension HeaderCtrlEndResizeEventBinder on WxEvtHandler {
  void bindHeaderCtrlEndResizeEvent( OnHeaderCtrlEventFunc func, int id ) {
    _eventTable.add( WxHeaderCtrlEventTableEntry(wxGetHeaderCtrlEndResizeEventType(), id, func));
  }

  void unbindHeaderCtrlEndResizeEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetHeaderCtrlEndResizeEventType(), id));
  }
}

/// @nodoc

extension HeaderCtrlBeginReorderEventBinder on WxEvtHandler {
  void bindHeaderCtrlBeginReorderEvent( OnHeaderCtrlEventFunc func, int id ) {
    _eventTable.add( WxHeaderCtrlEventTableEntry(wxGetHeaderCtrlBeginReorderEventType(), id, func));
  }

  void unbindHeaderCtrlBeginReorderEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetHeaderCtrlBeginReorderEventType(), id));
  }
}

/// @nodoc

extension HeaderCtrlEndReorderEventBinder on WxEvtHandler {
  void bindHeaderCtrlEndReorderEvent( OnHeaderCtrlEventFunc func, int id ) {
    _eventTable.add( WxHeaderCtrlEventTableEntry(wxGetHeaderCtrlEndReorderEventType(), id, func));
  }

  void unbindHeaderCtrlEndReorderEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetHeaderCtrlEndReorderEventType(), id));
  }
}

/// @nodoc

extension HeaderCtrlDraggingCancelledEventBinder on WxEvtHandler {
  void bindHeaderCtrlDraggingCancelledEvent( OnHeaderCtrlEventFunc func, int id ) {
    _eventTable.add( WxHeaderCtrlEventTableEntry(wxGetHeaderCtrlDraggingCancelledEventType(), id, func));
  }

  void unbindHeaderCtrlDraggingCancelledEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetHeaderCtrlDraggingCancelledEventType(), id));
  }
}












