// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- EVT_TOOL ----------------------

/// @nodoc

extension ToolEventBinder on WxEvtHandler {
  void bindToolEvent( OnCommandEventFunc func, int id ) {
    _eventTable.add( WxCommandEventTableEntry(wxGetToolEventType(), id, func));
  }

  void unbindToolEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetToolEventType(), id));
  }
}

// ------------------------- EVT_TOOL_ENTER ----------------------

/// @nodoc

extension ToolEnterEventBinder on WxEvtHandler {
  void bindToolEnterEvent( OnCommandEventFunc func, int id ) {
    _eventTable.add( WxCommandEventTableEntry(wxGetToolEnterEventType(), id, func));
  }

  void unbindToolEnterEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetToolEnterEventType(), id));
  }
}

// ------------------------- EVT_TOOL_DROPDOWN ----------------------

/// @nodoc

extension ToolDropDownEventBinder on WxEvtHandler {
  void bindToolDropDownEvent( OnCommandEventFunc func, int id ) {
    _eventTable.add( WxCommandEventTableEntry(wxGetToolDropDownEventType(), id, func));
  }

  void unbindToolDropDownEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetToolDropDownEventType(), id));
  }
}
// ------------------------- wxToolBar ----------------------

const int wxITEM_SEPARATOR = -1;
const int wxITEM_NORMAL = 0;
const int wxITEM_CHECK = 1;
const int wxITEM_RADIO = 2;
const int wxITEM_DROPDOWN = 3;
const int wxITEM_MAX = 4;

const int wxTB_FLAT = 0x0020;
const int wxTB_DOCKABLE = 0x0040;
const int wxTB_HORIZONTAL = wxHORIZONTAL;
const int wxTB_NOICONS = 0x0080;
const int wxTB_TEXT = 0x0100;
const int wxTB_DEFAULT_STYLE = wxHORIZONTAL;


/// Small helper class to organize tools in a [WxToolBar] and [WxAppBar]
/// 
/// You usually do not need to keep or use instances of this class.
class WxToolBarToolBase extends WxObject {

  /// Rrturns ID of the tool
  int getId( ) {
    return _id;
  }

  /// Returns label of the tool
  String getLabel( ) {
    return _label;
  }

/// Retuns the kind of the tool
/// 
/// ## Toolbar item kind constants
/// | constant | value |
/// | -------- | -------- |
/// | wxITEM_SEPARATOR | -1 |
/// | wxITEM_NORMAL | 0 |
/// | wxITEM_CHECK | 1 |
/// | wxITEM_RADIO | 2 |
/// | wxITEM_DROPDOWN | 3 |
  int getKind( ) {
    return _kind;
  }

/// Returns true if tool is a control
  bool isControl( ) {
    return _isControl;
  }

/// Returns true if tool is stretchable space
  bool isStretchable( ) {
    return _isStretchable;
  }

/// Returns the control if the tool is a control, null otherwise
  WxControl? getControl( ) {
    return _control;
  }

  int _id = -1;
  WxControl? _control;
  bool _isEnabled = true;
  bool _isToggled = false;
  bool _isStretchable = false;
  bool _isButton = false;
  bool _isControl = false;
  int _style = 0;
  int _kind = wxITEM_NORMAL;
  String _label = "";
  String _shortHelp = "";
  WxBitmapBundle? _bundle;
  WxBitmap? _bitmap;
  WxBitmapBundle? _bundleDisabled;
  WxBitmap? _bitmapDisabled;
  WxMenu? _menu;
}

/// Represents a toolbar, often at the top of a [WxFrame] below the [WxMenuBar].
/// 
/// Note: once you have created the toolbar, you need to call [realize].
/// 
/// ```dart
/// // in your frame's constructor
/// final toolbar = createToolBar( style: wxTB_FLAT|wxTB_TEXT );
/// toolbar.addTool( idFileDialog, "Open..", WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.file_open, WxSize(32,32) ), shortHelp: "Open file dialog" );
/// toolbar.addTool( idDialog, "Dialog", WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.window, WxSize(32,32) ), shortHelp: "Show dialog" );
/// toolbar.addSeparator();
/// 
/// // don't forget this!
/// toolbar.realize();
/// ```
/// # Toolbar item kind constants
/// | constant | value |
/// | -------- | -------- |
/// | wxITEM_SEPARATOR | -1 |
/// | wxITEM_NORMAL | 0 |
/// | wxITEM_CHECK | 1 |
/// | wxITEM_RADIO | 2 |
/// | wxITEM_DROPDOWN | 3 |
/// | wxITEM_MAX | 4 |
/// 
/// # Toolbar window styles
/// | constant | value |
/// | -------- | -------- |
/// | wxTB_FLAT | 0x0020 |
/// | wxTB_DOCKABLE | 0x0040 |
/// | wxTB_HORIZONTAL | wxHORIZONTAL |
/// | wxTB_NOICONS | 0x0080 |
/// | wxTB_TEXT | 0x0100 |
/// | wxTB_DEFAULT_STYLE | wxHORIZONTAL |

class WxToolBar extends WxControl {

  /// Creates a toolbar. Use [WxFrame.createToolBar] instead.
  WxToolBar( WxWindow parent, int id, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = wxTB_DEFAULT_STYLE } ) 
  : super( parent, id, pos: pos, size: size, style: style );

  final List<WxToolBarToolBase> _tools = [];
  int _separation = 5;

  /// Needs to be called after creating the toolbar or changes to it.
  bool realize( ) {
    _setState();
    return true;
  }

  @override
  void _updateTheme()
  {
    for (final tool in _tools) {
      if (tool._bitmap != null) {
        tool._bitmap!._updateTheme();
        tool._bitmap!._addListener(this);
      }
    }
  }

  void _updateBitmaps( WxToolBarToolBase tool ) {
    if (tool._bundle != null) {
      tool._bitmap = tool._bundle!.getBitmapFor(this);
    } else {
      tool._bitmap = null;
    }
    if (tool._bundleDisabled != null) {
      tool._bitmapDisabled = tool._bundleDisabled!.getBitmapFor(this);
    } else {
      tool._bitmapDisabled = null;
    }
  }

  @override
  void onInternalIdle()
  {
    for (final tool in _tools) {
      final event = WxUpdateUIEvent( id: tool.getId() );
      event._isCheckable = (tool._kind == wxITEM_CHECK) || (tool._kind == wxITEM_RADIO);
      event.setEventObject( this );
      processEvent(event);
      if ((tool._kind == wxITEM_CHECK) || (tool._kind == wxITEM_RADIO)) {
        if (event.getSetChecked()) {
          if (tool._isToggled != event.getChecked()) {
            tool._isToggled = event.getChecked();
            _setState();
          }
        }
      }
    }
  }

  /// Adds a separator (space) 
  WxToolBarToolBase addSeparator( ) {
    final tool = WxToolBarToolBase();
    tool._kind = wxITEM_SEPARATOR;
    _tools.add( tool );
    return tool;
  }

  /// Inserts a separator (space) at position [pos]
  WxToolBarToolBase insertSeparator( int pos ) {
    final tool = WxToolBarToolBase();
    tool._kind = wxITEM_SEPARATOR;
    _tools.insert( pos, tool );
    return tool;
  }

  /// Adds a stretchable space. Surplus space will be evenly distributed
  /// among several stretchable spaces.
  WxToolBarToolBase addStretchableSpace( ) {
    final tool = WxToolBarToolBase();
    tool._kind = wxITEM_SEPARATOR;
    tool._isStretchable = true;
    _tools.add( tool );
    return tool;
  }

  /// Inserts a stretchable space at position [pos]. Surplus space will
  /// be evenly distributed among several stretchable spaces.
  WxToolBarToolBase insertStretchableSpace( int pos ) {
    final tool = WxToolBarToolBase();
    tool._kind = wxITEM_SEPARATOR;
    tool._isStretchable = true;
    _tools.insert( pos, tool );
    return tool;
  }
/// Adds tool with an [id], a [label] and a [bitmap] (and optionally a helptext
/// displayed in the statusbar of a [WxFrame]).
/// 
/// [kind] specifies the kind of tool:  
/// ## Item kind constants
/// | constant | value |
/// | -------- | -------- |
/// | wxITEM_SEPARATOR | -1 |
/// | wxITEM_NORMAL | 0 |
/// | wxITEM_CHECK | 1 |
/// | wxITEM_RADIO | 2 |
/// | wxITEM_DROPDOWN | 3 |
  WxToolBarToolBase addTool( int id, String label, WxBitmapBundle bitmap, { String shortHelp = "", int kind = wxITEM_NORMAL } ) {
    final tool = WxToolBarToolBase();
    tool._id = id;
    tool._label = label;
    tool._kind = kind;
    tool._bundle = bitmap;
    tool._shortHelp = shortHelp;
    _updateBitmaps( tool );
    _tools.add( tool );
    return tool;
  }

  /// Inserts tool at position [pos]. Otherwise see [addTool].
  WxToolBarToolBase insertTool( int pos, int id, String label, WxBitmapBundle bitmap, WxBitmapBundle? bmpDisabled, { int kind = wxITEM_NORMAL, String shortHelp = "" } ) {
    final tool = WxToolBarToolBase();
    tool._id = id;
    tool._label = label;
    tool._kind = kind;
    tool._bundle = bitmap;
    tool._bundleDisabled = bmpDisabled;
    tool._shortHelp = shortHelp;
    _updateBitmaps( tool );
    _tools.insert(pos, tool );
    return tool;
  }

/// Adds a checkable tool with an [id], a [label] and a [bitmap] and 
/// optionally a helptext. Optionally, a separate bitmap can be used
/// to show the checked or unchecked state.
/// 
/// Like for checkable menu items (see [WxMenu.appendCheckItem]), use [WxUpdateUIEvent]
/// to set the state of the tool or use [toggleTool] directly.
  WxToolBarToolBase addCheckTool( int id, String label, WxBitmapBundle bitmap, WxBitmapBundle? bmpDisabled, { String shortHelp = "" } ) {
    final tool = WxToolBarToolBase();
    tool._id = id;
    tool._label = label;
    tool._kind = wxITEM_CHECK;
    tool._bundle = bitmap;
    tool._bundleDisabled = bmpDisabled;
    tool._shortHelp = shortHelp;
    _updateBitmaps( tool );
    _tools.add( tool );
    return tool;
  }

/// Adds a radio button tool with an [id], a [label] and a [bitmap] and 
/// optionally a helptext. Optionally, a separate bitmap can be used
/// to show the checked or unchecked state.
/// 
/// Like for radio menu items (see [WxMenu.appendRadioItem]), use [WxUpdateUIEvent]
/// to set the state of the radio tool or use [toggleTool] directly.
  WxToolBarToolBase addRadioTool( int id, String label, WxBitmapBundle bitmap, WxBitmapBundle? bmpDisabled, { String shortHelp = "" } ) {
    final tool = WxToolBarToolBase();
    tool._id = id;
    tool._label = label;
    tool._kind = wxITEM_RADIO;
    tool._bundle = bitmap;
    tool._bundleDisabled = bmpDisabled;
    tool._shortHelp = shortHelp;
    _updateBitmaps( tool );
    _tools.add( tool );
    return tool;
  }

  /// Adds the [control] to the toolbar
  WxToolBarToolBase addControl( WxControl control, { String label = "" } ) {
    final tool = WxToolBarToolBase();
    tool._label = label;
    tool._control = control;
    tool._kind = wxITEM_NORMAL;
    tool._isControl = true;
    _tools.add( tool );
    return tool;
  }

  /// Inserts the [control] to the toolbar at position [pos]
  WxToolBarToolBase insertControl( int pos, WxControl control, { String label = "" } ) {
    final tool = WxToolBarToolBase();
    tool._label = label;
    tool._control = control;
    tool._kind = wxITEM_NORMAL;
    tool._isControl = true;
    _tools.insert( pos, tool );
    return tool;
  }

  /// Deletes all tools
  void clearTools( ) {
    _tools.clear();
  }

  /// Deletes and remove the tool with the [id]
  bool deleteTool( int id ) {
    final tool = findById( id );
    if (tool != null) {
      _tools.remove(tool);
      return true;
    }
    return false;
  }

  /// Enables or disables (usually greyed) a tool with the [id] based on
  /// the value of [enable]
  void enableTool( int id, { bool enable = true } ) {
    final tool = findById( id );
    if (tool != null) {
      tool._isEnabled = enable;
      _setState();
    }
  }

  /// Returns true if the tool with the [id] is enabled
  bool getToolEnabled( int id ) {
    final tool = findById( id );
    if (tool == null) {
      return false;
    } else {
      return tool._isEnabled;
    }
  }

  String getToolShortHelp( int id ) {
    final tool = findById( id );
    if (tool == null) {
      return "";
    } else {
      return tool._shortHelp;
    }
  }

  /// Returns the number of tools
  int getToolsCount( ) {
    return _tools.length;
  }

  /// Set the Sets the default separator size. The default value is 5.
  void setToolSeparation( int separation ) {
    _separation = separation;
    _setState();
  }

  /// Set the packing margin where supported.
  /// 
  /// The packing is used for spacing in the vertical direction if
  /// the toolbar is horizontal, and for spacing in the horizontal
  /// direction if the toolbar is vertical.
  void setToolPacking( int packing ) {
  }

  /// Returns true if the tool with [id] is togglable and is toggled. 
  /// 
  /// Only possible for radio and check tools.
  bool getToolState( int id ) {
    final tool = findById( id );
    if (tool == null) {
      return false;
    } else {
      return tool._isToggled;
    }
  }

  /// Toggles tool with given [id]
  /// 
  /// Only possible for radio and check tools.
  void toggleTool( int id, { bool toggle = true } ) {
    final tool = findById( id );
    if (tool != null) {
      tool._isToggled = toggle;
      _setState();
    }
  }

  /// Attach a dropdown menu to a tool. The tool must be of
  /// kind wxITEM_DROPDOWN.
  void setDropdownMenu( int id, WxMenu menu ) {
    final tool = findById( id );
    if (tool != null) {
      if (tool._kind != wxITEM_DROPDOWN) {
        wxLogError( "ToolbarTool kind must be wxITEM_DROPDOWN" );
      }
      tool._menu = menu;
      _setState();
    }
  }

  /// Returns control with the given ID, if any.
  WxControl? findControl( int id )
  {
    for (final tool in _tools) {
      if (tool._control == null) continue;
      if (tool._control!.getId() == id) return tool._control;
    }
    return null;
  }

  /// Returns tool at the position [pos]
  WxToolBarToolBase? getToolByPos( int pos ) {
    return _tools[pos];
  }

  /// Returns tool with id [id]
  WxToolBarToolBase? findById( int id )
  {
    for (final tool in _tools) {
      if (tool._id == id) return tool;
    }
    return null;
  }

  Widget _buildImage( WxToolBarToolBase tool, Color? background )
  {
    Widget? bitmap;
    if (tool._bitmap!.isOk()) {
        bitmap = RawImage( image: tool._bitmap!._image!, fit: BoxFit.fitHeight );
    } else {
        tool._bitmap!._addListener( this );
    }
    if (bitmap != null)
    {
        if (tool._shortHelp.isNotEmpty)
        {
          bitmap = Tooltip(
            message: tool._shortHelp,
            child: bitmap );
        } 
    }
    if (bitmap != null)
    {
      if (background != null) {
        bitmap = ColoredBox(color: background, child: bitmap );
      }

      if ((tool._menu != null) && (!wxTheApp.isTouch()))
      {
        bitmap = Row(
          children: [
            bitmap,
            Listener(
              onPointerDown: (event) {
                _eatEvent = true;
                popupMenu( tool._menu! );
              },
              onPointerUp: (event) {
              },
              child: 
              Padding(
                padding: EdgeInsetsGeometry.only(left: 2),
                child: CustomPaint(
                  size: const Size(13, 30), 
                  painter: TrianglePainter( false, border: 12, otherBorder: 10 ),
                )
              )
            )
          ]
        );
      } 

      return bitmap;
    }
    return CircularProgressIndicator();
  }

  @override
  Widget _build(BuildContext context)
  {
    List<Widget> actions = [];
    for (final tool in _tools)
    {
      if (tool._isControl)
      {
        Widget widget = tool._control!._build(context);
        if (tool._shortHelp.isNotEmpty) {
          widget = Tooltip(
            message: tool._shortHelp,
            child: widget );
        }
        actions.add( widget );
      } else       
      if (tool._kind == wxITEM_SEPARATOR) {
        if (tool._isStretchable) {
          actions.add( Expanded( child: SizedBox( width: _separation.toDouble() ) ) );
        } else {
          actions.add( SizedBox( width: _separation.toDouble() ) );
        }
      } else 
      if ((tool._kind == wxITEM_NORMAL) || (tool._kind == wxITEM_CHECK) ||
          (tool._kind == wxITEM_RADIO) || (tool._kind == wxITEM_DROPDOWN) )
      {
        if ((tool._bitmap == null) || (hasFlag(wxTB_NOICONS)))
        {
          Widget widget = TextButton(
            onPressed: tool._isEnabled ? () {
              WxCommandEvent event = WxCommandEvent( wxGetMenuEventType(), tool._id );
              event.setEventObject( this );
              processEvent( event ); 
            } : null,
            child: Text( tool._label )
          );
          if (tool._shortHelp.isNotEmpty) {
            widget = Tooltip(
              message: tool._shortHelp,
              child: widget );
          }
          actions.add( widget );
        } 
        else 
        {
          late Widget widget;
          {
              late Color accentFocus;
              if (!wxTheApp.isDark()) {
                final s = wxTheApp.getSecondaryAccentColour();
                accentFocus = Color.fromARGB( s.alpha, s.red, s.green, s.blue );
              } else {
                final s = wxTheApp.getPrimaryAccentColour();
                accentFocus = Color.fromARGB( s.alpha, s.red, s.green, s.blue );
              }
              Widget bitmap = _buildImage( tool, null );
              if (!hasFlag(wxTB_FLAT))
              {
              widget = ToggleButtons( 
              color: tool._isToggled ? accentFocus : null,
              onPressed: tool._isEnabled ? (button)
              {
                if (_eatEvent) {
                  _eatEvent = false;
                  return;
                }
                if (tool._kind == wxITEM_RADIO) {
                  if (tool._isToggled) return;
                }
                WxCommandEvent event = WxCommandEvent( wxGetMenuEventType(), tool._id );
                event.setInt( tool._isToggled ? 0 : 1 );
                event.setEventObject( this );
                processEvent( event ); 
                onInternalIdle();
              } : null,
                isSelected: [tool._isToggled],
                borderWidth: 1,
                renderBorder: true,
              children: [
                !hasFlag( wxTB_TEXT )
                  ? Padding(padding: EdgeInsetsGeometry.all(0), child: bitmap )
                  :  Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(padding: EdgeInsetsGeometry.all(2), child: bitmap ),
                        Text ( tool._label )
                      ] ) 
              ] );
              } 
              else 
              {
              widget = MaterialButton( 
              color: tool._isToggled ? accentFocus : null,
              onPressed: tool._isEnabled ? () {
                if (_eatEvent) {
                  _eatEvent = false;
                  return;
                }
                if (tool._kind == wxITEM_RADIO) {
                  if (tool._isToggled) return;
                }
                WxCommandEvent event = WxCommandEvent( wxGetMenuEventType(), tool._id );
                event.setInt( tool._isToggled ? 0 : 1 );
                event.setEventObject( this );
                processEvent( event ); 
                onInternalIdle();
              } : null,
              minWidth: 16,
              padding: EdgeInsetsGeometry.all(0),
              child: 
                !hasFlag( wxTB_TEXT )
                  ? Padding(padding: EdgeInsetsGeometry.all(0), child: bitmap )
                  : SizedBox( 
                      width: 64,
                      child:
                      Column(children: [
                        Padding(padding: EdgeInsetsGeometry.all(2), child: bitmap ),
                        Padding(padding: EdgeInsetsGeometry.only(bottom: 2), child: Text ( tool._label ) ) 
                      ] ) )
              );
            }
          }
          actions.add( widget );
        }
      }
    }
    Widget finalWidget = Row(
      children: actions 
    );
    return finalWidget;
  }

  bool _eatEvent = false;
}
