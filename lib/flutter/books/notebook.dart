// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxNotebookEvent ----------------------

typedef OnNotebookEventFunc = void Function( WxNotebookEvent event );

class WxNotebookEventTableEntry extends WxEventTableEntry {
  WxNotebookEventTableEntry( super.eventType, super.id, this.func );
  final OnNotebookEventFunc func;

  @override
  bool matches( int eventTypeTested, int idTested ) {
    return (eventType == eventTypeTested) && ((id == wxID_ANY) || (id == idTested));
  }

  @override
  void doCallFunction( WxEvent event ) {
    if (event is WxNotebookEvent) {
      func( event );
    }
  }
}

/// Event sent when the user selects a page in a [WxNotebook] or other control derived from [WxBookCtrlBase]
class WxNotebookEvent extends WxNotifyEvent {
  WxNotebookEvent( { int eventType = 0, int id = 0, sel = 0, oldSel = 0 } ) : super( eventType, id )
  {
    _sel = sel;
    _oldSel = oldSel;
  }

  int _sel = 0; // use commandint instead
  int _oldSel = 0;

  @override
  int getSelection( ) {
    return _sel;
  }

  int getOldSelection( ) {
    return _oldSel;
  }
}

/// @nodoc

extension NotebookPageChangedEventBinder on WxEvtHandler {
  void bindNotebookPageChangedEvent( OnNotebookEventFunc func, int id ) { 
    _eventTable.add( WxNotebookEventTableEntry(wxGetNotebookPageChangedEventType(), id, func));
  }
  void unbindNotebookPageChangedEvent( OnNotebookEventFunc func, int id ) { 
    _eventTable.removeWhere( (entry) => entry.matches(wxGetNotebookPageChangedEventType(), id));
  }
}

/// @nodoc

extension NotebookPageChangingEventBinder on WxEvtHandler {
  void bindNotebookPageChangingEvent( OnNotebookEventFunc func, int id ) { 
    _eventTable.add( WxNotebookEventTableEntry(wxGetNotebookPageChangingEventType(), id, func));
  }
  void unbindNotebookPageChangingEvent( OnNotebookEventFunc func, int id ) { 
    _eventTable.removeWhere( (entry) => entry.matches(wxGetNotebookPageChangingEventType(), id));
  }
}

// ------------------------- wxNotebook ----------------------

const int wxNB_DEFAULT = wxBK_DEFAULT;
const int wxNB_TOP = wxBK_TOP;
const int wxNB_BOTTOM = wxBK_BOTTOM;
const int wxNB_LEFT = wxBK_LEFT;
const int wxNB_RIGHT = wxBK_RIGHT;
const int wxNB_FIXEDWIDTH = 0x0100;
const int wxNB_MULTILINE = 0x0200;
const int wxNB_NOPAGETHEME = 0x0400;
const int wxNB_CLASSIC_THEME = 0x0800;

/// Represents a notebook that allows the user to choose different pages from tabs.
/// 
/// See [WxBookCtrlBase] for the main interface.
/// 
/// In wxDart Flutter, wxNotebook is implemented diferrently for desktop and touch mode
/// and currently only wxNB_TOP is implemented.
/// 
/// In wxDart Native on iOS, wxNB_BOTTOM will implement the smartphone control that you
/// can see in [WxNavigationCtrl]
/// 
/// Use case with two pages
/// ```dart
/// class MyFirstDialog extends WxDialog
/// {
///   MyFirstDialog( WxWindow parent ) : super( parent, -1, "Hello", size: WxSize(800,600) )
///   {
///     final mainSizer = WxBoxSizer( wxVERTICAL );
///     setSizer( mainSizer );
/// 
///     // create notebook
///     final notebook = WxNotebook( this, -1 );
/// 
///     // and make it fill most of the dialog
///     mainSizer.add( notebook, proportion: 1, flag: wxEXPAND|wxALL, border: 5 );
/// 
///     // first page
///     final page1 = WxPanel( notebook, -1 );
///     notebook.addPage(page1, "Tab 1" );
/// 
///     // second page
///     final page2 = WxPanel( notebook, -1 );
///     notebook.addPage( page2, "Tab 2" );
/// 
///     // add OK/Cancel buttons at the bottom
///     mainSizer.addSizer(createStdDialogButtonSizer(wxOK|wxCANCEL), flag: wxALL|wxALIGN_RIGHT, border: 10);
/// 
///     // transfer data to the dialog
///     bindInitDialogEvent( (_) {
///     });
/// 
///     // validate data and if ok, transfer data from the dialog
///     bindDialogValidateEvent( (_) {
///     }, -1); 
///   }
///```
/// # Events emitted
///
/// [NotebookPageChanged](/wxdart/wxGetNotebookPageChangedEventType.html) event gets sent when the changed the page |
/// | ----------------- |
/// | void bindNotebookPageChangedEvent( OnNotebookEventFunc ) |
/// | void unbindNotebookPageChangedEvent() |
/// 
/// Only in wxDart Native:
/// [NotebookPageChanging](/wxdart/wxGetNotebookPageChangingEventType.html) event gets sent when user is wished to change the page |
/// | ----------------- |
/// | void bindNotebookPageChangingEvent( OnNotebookEventFunc ) |
/// | void unbindNotebookPageChangingEvent() |
/// 
/// # Window styles
/// | constant | value |
/// | -------- | -------- |
/// | wxNB_DEFAULT | wxBK_DEFAULT |
/// | wxNB_TOP | wxBK_TOP |
/// | wxNB_BOTTOM | wxBK_BOTTOM (only wxDart Native) |
/// | wxNB_LEFT | wxBK_LEFT (only wxDart Native) |
/// | wxNB_RIGHT | wxBK_RIGHT (only wxDart Native) |
/// | wxNB_FIXEDWIDTH | 0x0100 (only wxDart Native) |
/// | wxNB_MULTILINE | 0x0200 (only wxDart Native) |
/// | wxNB_NOPAGETHEME | 0x0400 |
/// | wxNB_CLASSIC_THEME | 0x0800 (only wxDart Flutter) |

class WxNotebook extends WxBookCtrlBase {
  WxNotebook( super.parent, super.id, { super.pos = wxDefaultPosition, super.size = wxDefaultSize, super.style = 0 } )
  {
    // TabbedViewTheme crashes in WASM build
    _useTabbedView = !wxTheApp.isTouch() && !wxIsWeb();
}

bool _useTabbedView = true;
TabbedViewController? _controller; 
TabController? _materialController; 

@override
/// Selects page at index [selection] 
int changeSelection( int selection )
{
  if (selection == _currentSelection) {
    return _currentSelection;
  }
  int oldSel = _currentSelection;
  _currentSelection = selection;
  if (_useTabbedView)
  {
    _blockEvents = true;
    _setState();
  }
  else
  {
    if (_materialController != null) {
      _blockEvents = true;
      _materialController!.index = selection;
    } 
  }
  return oldSel;
}

void _recreateMaterialController() 
{
  if (_theWxDartAppState == null) return;
  _materialController = TabController(
    length: _pages.length, 
    vsync: _theWxDartAppState!,
    );
  _materialController!.addListener(() {
    if (!_materialController!.indexIsChanging)
    {
      _currentSelection = _materialController!.index;
      if (_blockEvents) 
      {
        _blockEvents = false;
        return;
      }
      final event = WxNotebookEvent( eventType:  wxGetNotebookPageChangedEventType(), id: getId(), 
           sel: _materialController!.index, oldSel: _materialController!.previousIndex ); 
      processEvent( event );
    }
  });  
}

void _recreateTabbedViewController() 
{
  _blockEvents = false;
  List<TabData> tabs = [];
  for (WxPageItem item in _pages) {
      tabs.add( TabData(
         text: item.text,
         closable: false
      ) );
    }

  _controller = TabbedViewController(
      tabs,
      onTabReorder: (int oldIndex, int newIndex) {
      },
      onTabSelection: (index, tabData) {
        if (index == null) return;
        _currentSelection = index;
        if (!_blockEvents)
        {
          final event = WxNotebookEvent( eventType:  wxGetNotebookPageChangedEventType(), id: getId(), 
            sel: index, oldSel: _oldSelection ); 
          event.setEventObject( this );
          processEvent( event );
        }
        _blockEvents = false;
        _oldSelection = index;
      },
      onTabRemove: (tabData) {},
    );
}

@override
void _recreateController() 
{
    if (_useTabbedView) {
      _recreateTabbedViewController();
    } else {
      _recreateMaterialController();
    }
}


Widget _buildMaterial( BuildContext context)
{
    if (_materialController == null) {
      _recreateController();
    }

    List<Tab> tabs = [];
    List<Widget> views = [];
    for (WxPageItem item in _pages) {

      tabs.add( Tab(text: item.text) );
      views.add( item.page._build( context ) );
    }
    Widget finalWidget = Column( children: [
      TabBar(
        controller: _materialController,
        tabs: tabs ),
      Expanded( child: 
        TabBarView(
          controller: _materialController,
          children: views,
        )
      )
    ] );

    finalWidget = _doBuildSizeEventHandler( context, finalWidget );

    return finalWidget;
}

Widget _buildTabbedView( BuildContext context)
{
    if (_controller == null) {
      _recreateController();
    }

    if (_controller == null) {
      return Text( "No controller" );
    }

    _controller!.selectedIndex = _currentSelection;

    final seedColor = wxTheApp._getSeedColor();

    Widget finalWidget = 
    TabbedViewTheme(       // TabbedViewTheme crashes in WASM build
      data: 
       !hasFlag( wxNB_CLASSIC_THEME )
        ? TabbedViewThemeData.underline(
            brightness: wxTheApp.isDark() ? Brightness.dark : Brightness.light,
            underlineColorSet:  MaterialColor( seedColor.toARGB32(), {} )
          ) 
        : TabbedViewThemeData.classic(
            tabRadius: 4,
            brightness: wxTheApp.isDark() ? Brightness.dark : Brightness.light,
        ),
      child: 
        TabbedView(
          controller: _controller!,
          contentBuilder: (context, index) {
            final item = _pages[index];
            return item.page._build( context );
          }, 
          tabsAreaVisible: true,
          tabReorderEnabled: false,
          onDraggableBuild: (controller, value, data) {
            final drag = DraggableConfig( canDrag: false );
            return drag;
          },
          tabRemoveInterceptor: (context, index, tabData) {
              return false;
            },
        ) );

    finalWidget = _doBuildSizeEventHandler( context, finalWidget );

    return finalWidget;
}

@override
  Widget _build(BuildContext context)
  {
    if (_useTabbedView) {
      return _buildTabbedView( context );
    } else {
      return _buildMaterial( context );
    }
  }
}




