// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxSplitterEvent ----------------------

typedef OnSplitterEventFunc = void Function( WxSplitterEvent event );

/// @nodoc

class WxSplitterEventTableEntry extends WxEventTableEntry {
  WxSplitterEventTableEntry( super.eventType, super.id, this.func );
  final OnSplitterEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return (eventType == eventTypeTested) && ((id == wxID_ANY) || (id == idTested));
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxSplitterEvent) {
      func( event );
    }
  }
}

/// @nodoc

extension SplitterSashPosChangingEventBinder on WxEvtHandler {
  void bindSplitterSashPosChangingEvent( OnSplitterEventFunc func, int id ) {
    _eventTable.add( WxSplitterEventTableEntry(wxGetSplitterSashPosChangingEventType(), id, func));
  }

  void unbindSplitterSashPosChangingEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetSplitterSashPosChangingEventType(), id));
  }
}

/// @nodoc

extension SplitterSashPosChangedEventBinder on WxEvtHandler {
  void bindSplitterSashPosChangedEvent( OnSplitterEventFunc func, int id ) {
    _eventTable.add( WxSplitterEventTableEntry(wxGetSplitterSashPosChangedEventType(), id, func));
  }

  void unbindSplitterSashPosChangedEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetSplitterSashPosChangedEventType(), id));
  }
}

/// @nodoc

extension SplitterUnsplitEventBinder on WxEvtHandler {
  void bindSplitterUnsplitEvent( OnSplitterEventFunc func, int id ) {
    _eventTable.add( WxSplitterEventTableEntry(wxGetSplitterUnsplitEventType(), id, func));
  }

  void unbindSplitterUnsplitEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetSplitterUnsplitEventType(), id));
  }
}

/// Event sent out for [WxSplitterWindow] 
class WxSplitterEvent extends WxNotifyEvent {
  WxSplitterEvent( super.eventType, super.id );

  WxWindow? _windowBeingRemoved;
  int _x = 0;
  int _y = 0;
  int _pos = 0;

  int getSashPosition( ) {
    return _pos;
  }

  int getX( ) {
    return _x;
  }

  int getY( ) {
    return _y; 
  }

  WxWindow? getWindowBeingRemoved( ) {
    return _windowBeingRemoved;
  }
}

// ------------------------- wxSplitterWindow ----------------------

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

/// This class manages up to two subwindows. The current view can be split
/// either horizontally or vertically. 
/// 
/// The user can change the dimensions of the two windows by dragging the
/// splitter sash around. If the wxSP_PERMIT_UNSPLIT flag is set, then the
/// user can unsplit the window, i.e. one window gets hidden. 
///
/// # Events emitted
/// [SplitterSashPosChanging](/wxdart/wxGetSplitterSashPosChangingEventType.html) event gets sent when the user drags the sash. |
/// | ----------------- |
/// | void bindSplitterSashPosChangingEvent( void function( [WxSplitterEvent] event ) ) |
/// | void unbindSplitterSashPosChangingEvent() |
/// [SplitterSashPosChanged](/wxdart/wxGetSplitterSashPosChangedEventType.html) event gets sent when the drag is finished. |
/// | ----------------- |
/// | void bindSplitterSashPosChangedEvent( void function( [WxSplitterEvent] event ) ) |
/// | void unbindSplitterSashPosChangedEvent() |
/// [SplitterUnsplit](/wxdart/wxGetSplitterUnsplitEventType.html) event gets sent when user ended the split. |
/// | ----------------- |
/// | void bindSplitterUnsplitEvent( void function( [WxSplitterEvent] event ) ) |
/// | void unbindSplitterUnsplitEvent() |
/// 
/// # Window styles
/// | constant | meaning |
/// | -------- | -------- |
/// | wxSP_NOBORDER | 0x0000 |
/// | wxSP_THIN_SASH | 0x0000 |
/// | wxSP_NOSASH | 0x0010 |
/// | wxSP_PERMIT_UNSPLIT | 0x0040 |
/// | wxSP_LIVE_UPDATE | 0x0080 |
/// | wxSP_3DSASH | 0x0100 |
/// | wxSP_3DBORDER | 0x0200 |
/// | wxSP_BORDER | wxSP_3DBORDER |
/// | wxSP_3D | (wxSP_3DBORDER | wxSP_3DSASH) |

class WxSplitterWindow extends WxWindow {
  /// Creates the splitter window. Call [splitHorizontally] or [splitVertically] afterwards
  WxSplitterWindow( WxWindow parent, int id, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = wxSP_3D } ) :
    super( parent, id, pos, size, style );

  bool _horizontal = true;
  bool _isSplit = false;
  bool _window1Hidden = false;
  bool _window2Hidden = false;
  int _minimumPaneSize = 0;
  WxWindow? _window1;
  WxWindow? _window2;
  int _pos = -1;
  bool _sashInvisible = false;

  final MultiSplitViewController _controller = MultiSplitViewController();

  void _rebuildController() {
    final List<Area> areas = [];
    if ((_window1 != null) && (_window2 != null)) {
      areas.add( 
        Area( 
        size: _pos == -1 ? null : _pos.toDouble(),
        min: _minimumPaneSize > 0 ? _minimumPaneSize.toDouble() : null,
        builder: (BuildContext context, Area area) {
          return _window1!._build(context);
        }
      ) );
      areas.add( 
        Area( 
        min: _minimumPaneSize > 0 ? _minimumPaneSize.toDouble() : null,
        builder: (BuildContext context, Area area) {
          return _window2!._build(context);
        }
      ) );
    }
    _pos = -1;
    _controller.areas = areas;
  }

  /// Split the window horizontally with the two child windows [window1],[window2] at position [sashPosition]
  bool splitHorizontally( WxWindow window1, WxWindow window2, { int sashPosition = 0 } ) {
    _isSplit = true;
    _window1 = window1;
    _window2 = window2;
    _horizontal = true;
    _rebuildController();
    _setState();
    return true;
  }

  /// Split the window vertically with the two child windows [window1],[window2] at position [sashPosition]
  bool splitVertically( WxWindow window1, WxWindow window2, { int sashPosition = 0 } ) {
    _isSplit = true;
    _horizontal = false;
    _window1 = window1;
    _window2 = window2;
    _rebuildController();
    _setState();
    return true;
  }

  /// Set the minimum size of the two panes (currently not supported in wxDart Flutter)
  void setMinimumPaneSize( int paneSize ) {
    _minimumPaneSize = paneSize;
    _rebuildController();
    _setState();
  }

  /// Returns true, if the window is split
  bool isSplit( ) {
    return _isSplit;
  }

  /// Returns true of the sash is visible. This can return true even if the window
  /// is currently not actually split.
  bool isSashInvisible( ) {
    return _sashInvisible;
  }

  /// Retunrs the position of the sash in pixels, either from the left or the top
  int getSashPosition( ) {
    if ((_window1 == null) || (_window2 == null)) {
      return 0;
    }
    WxSize size = _window1!.getSize();

    return (!_horizontal&&!wxTheApp.isTouch()) ? size.x : size.y;
  }

  /// Makes the sash invisible (or visible, dependin gon [invisible])
  void setSashInvisible( { bool invisible = true } )
  {
    _sashInvisible = invisible;
    _setState();
  }

  /// Sets the position of the sash in pixels, either from the left or the top
  void setSashPosition( int pos, { bool redraw = true } ) {
    _pos = pos;
    _rebuildController();
    _setState();
  }

  /// Unsplit the splitter window, removing [toRemove] from the splitter without actually deleting it
  bool unsplit( WxWindow toRemove ) {
    if ((_window1 == null) || (_window2 == null)) return false;
    if (!_isSplit) return false;
    if (toRemove == _window1) {
      _window1Hidden = true;
      _isSplit = false;
      _setState();
      return true;
    }
    if (toRemove == _window2) {
      _window2Hidden = true;
      _isSplit = false;
      _setState();
      return true;
    }
    return false;
  }

  /// In wxDart native, updates the window if the update otherwise would be deferred to idle time
  void updateSize( ) {
  }


  @override
  Widget _build(BuildContext context) {

    if (!_isSplit) {
      if (_window1Hidden && (_window2 != null)) {
        return _window2!._build( context );
      }
      if (_window2Hidden && (_window1 != null)) {
        return _window1!._build( context );
      }
      return Text("No content");
    }

    return _doBuildBackgroundAndBorder(context, 
      _doBuildSizeEventHandler(context, 
      MultiSplitViewTheme(
              data: MultiSplitViewThemeData(
                dividerThickness: _sashInvisible ? 0 : 
                  MultiSplitViewThemeData.defaultDividerThickness+2 
                  + (wxTheApp.isTouch()?2:0),  // not sure if 0 actually works
                dividerPainter: 
                  DividerPainters.grooved1(
                    highlightedColor: wxTheApp._getSeedColor(),
                    // thickness: MultiSplitViewThemeData.defaultDividerThickness,
                    highlightedSize: 45,
                    highlightedThickness: 5,
                  )),
              child:
      MultiSplitView(
        axis: (!_horizontal && !wxTheApp.isTouch()) ? Axis.horizontal : Axis.vertical,
        onDividerDragUpdate: (int index) {
          int pos = getSashPosition();
          if (hasFlag(wxSP_PERMIT_UNSPLIT)) {
            if (pos < 5) {
              _isSplit = false;
              _window1Hidden = true;
              final event = WxSplitterEvent( wxGetSplitterUnsplitEventType(), getId() );
              event._windowBeingRemoved = _window1;
              processEvent( event );
              _setState();
              return;
            }
            WxSize size = getSize();
            int length = (_horizontal || wxTheApp.isTouch()) ? size.y : size.x;
            if (pos > length-5-10) {
              _isSplit = false;
              _window2Hidden = true;
              final event = WxSplitterEvent( wxGetSplitterUnsplitEventType(), getId() );
              event._windowBeingRemoved = _window2;
              processEvent( event );
              _setState();
              return;
            }
          }

          final event = WxSplitterEvent( wxGetSplitterSashPosChangedEventType(), getId() );
          event._pos = pos;
          processEvent( event );
        },

        onDividerDoubleTap: (int index) {
          final event = WxSplitterEvent( wxGetSplitterDoubleClickEventType(), getId() );
          processEvent( event );
        },
        controller: _controller,
    )) ));
  }
}

