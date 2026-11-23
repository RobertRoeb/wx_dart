// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-11-15
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- EVT_TOOL ----------------------

// ------------------------- EVT_TOOL_ENTER ----------------------

// ------------------------- EVT_TOOL_DROPDOWN ----------------------

// ------------------------- wxToolBarToolBase ----------------------

/// Small helper class to organize tools in a [WxToolBar] and [WxAppBar]
///
/// You usually do not need to keep or use instances of this class.
class WxToolBarToolBase extends WxObject {
  /// Rrturns ID of the tool
  int getId() {
    return _id;
  }

  /// Returns label of the tool
  String getLabel() {
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
  int getKind() {
    return _kind;
  }

  bool isButton() {
    return !_isControl && _kind != wxITEM_SEPARATOR;
  }

  /// Returns true if tool is a control
  bool isControl() {
    return _isControl;
  }

  bool isSeparator() {
    return _kind == wxITEM_SEPARATOR;
  }

  /// Returns true if tool is stretchable space
  bool isStretchable() {
    return _isStretchable;
  }

  bool isEnabled() {
    return _isEnabled;
  }

  bool isToggled() {
    return _isToggled;
  }

  bool canBeToggled() {
    return (_kind == wxITEM_CHECK) || (_kind == wxITEM_RADIO);
  }

  /// Returns the control if the tool is a control, null otherwise
  WxControl? getControl() {
    return _control;
  }

  String getShortHelp() {
    return _shortHelp;
  }

  WxMenu? getDropdownMenu() {
    return _menu;
  }

  WxToolBar? getToolBar() {
    return _toolBar;
  }

  int _id = -1;
  WxControl? _control;
  bool _isEnabled = true;
  bool _isToggled = false;
  bool _isStretchable = false;
  bool _isControl = false;
  int _kind = wxITEM_NORMAL;
  String _label = "";
  String _shortHelp = "";
  WxBitmapBundle? _bundle;
  WxBitmapBundle? _bundleDisabled;
  WxMenu? _menu;
  WxToolBar? _toolBar;
}

// ------------------------- wxToolBar ----------------------

/// A tool bar with buttons (normal, check, radio, drop-down), separators,
/// stretchable space and controls, rendered with HTML/CSS.
///
/// Created with [WxFrame.createToolBar], it is shown between the menu bar
/// and the client area of the frame. It can also be created as a normal
/// child window anywhere (e.g. in a sizer).
///
/// Tool clicks send tool events, which have the same type as menu events,
/// so one handler can serve a menu item and a tool with the same id.
/// Check and radio tools toggle automatically. Before tools are shown and
/// during idle time, tools receive [WxUpdateUIEvent]s.
///
/// Changes are shown after [realize] or, automatically, during idle time.
///
/// ```dart
///   final toolbar = createToolBar(style: wxTB_DEFAULT_STYLE | wxTB_TEXT);
///   toolbar.addTool(wxID_OPEN, "Open", WxBitmapBundle.fromSVGAsset("icons/open.svg", WxSize(24, 24)));
///   toolbar.addCheckTool(idGrid, "Grid", gridIcon, null, shortHelp: "Show grid");
///   toolbar.realize();
/// ```
///
/// # Styles
/// | constant | meaning |
/// | -------- | -------- |
/// | wxTB_HORIZONTAL | horizontal (default) |
/// | wxTB_VERTICAL | vertical (not for frame tool bars) |
/// | wxTB_TEXT | shows labels below the icons |
/// | wxTB_NOICONS | shows only labels |
///
/// # Events emitted
/// [Tool](/wxdart/wxGetToolEventType.html) event gets sent when a tool is clicked
/// | ----------------- |
/// | void bindToolEvent( OnCommandEventFunc, int id ) |
/// | void unbindToolEvent( int id ) |
/// [ToolEnter](/wxdart/wxGetToolEnterEventType.html) event gets sent when the mouse enters a tool (int value: tool id, -1 when leaving)
/// | ----------------- |
/// | void bindToolEnterEvent( OnCommandEventFunc, int id ) |
/// | void unbindToolEnterEvent( int id ) |
/// [ToolDropDown](/wxdart/wxGetToolDropDownEventType.html) event gets sent when the arrow of a drop-down tool is clicked
/// | ----------------- |
/// | void bindToolDropDownEvent( OnCommandEventFunc, int id ) |
/// | void unbindToolDropDownEvent( int id ) |
class WxToolBar extends WxControl {
  /// Creates a toolbar. Use [WxFrame.createToolBar] instead.
  WxToolBar(WxWindow parent, int id,
      {WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = wxTB_DEFAULT_STYLE})
      : super(parent, id, pos: pos, size: size, style: style);

  final List<WxToolBarToolBase> _tools = [];
  int _separation = 5;
  bool _dirty = false;

  @override
  String get _jsKind => 'toolbar';

  // ------------------------- rendering ----------------------

  /// Needs to be called after creating the toolbar or changes to it.
  bool realize() {
    _render();
    return true;
  }

  void _changed() {
    _dirty = true;
    _scheduleIdle();
  }

  void _render() {
    _dirty = false;
    final tools = <Object>[];
    for (final tool in _tools) {
      final json = <String, Object>{
        "id": tool._id,
        "kind": _kindName(tool),
        "label": _wxStripMnemonic(tool._label),
        "help": tool._shortHelp,
        "enabled": tool._isEnabled,
        "toggled": tool._isToggled,
        "bitmap": 0,
        "bw": 0,
        "bh": 0,
        "control": tool._control?._handle ?? 0,
      };
      WxBitmapBundle? bundle = tool._bundle;
      if (!tool._isEnabled && tool._bundleDisabled != null) bundle = tool._bundleDisabled;
      if (bundle != null) {
        final bitmap = bundle.getBitmapFor(this);
        final size = bundle._logicalSize();
        json["bitmap"] = bitmap._handle;
        json["bw"] = size.x;
        json["bh"] = size.y;
      }
      tools.add(json);
    }
    _jsToolbarSet(
        _handle,
        jsonEncode(<String, Object>{
          "vertical": hasFlag(wxTB_VERTICAL),
          "text": hasFlag(wxTB_TEXT),
          "noicons": hasFlag(wxTB_NOICONS),
          "separation": _separation,
          "tools": tools,
        }));
    _labelOrFontChanged(); // the best size has changed
  }

  String _kindName(WxToolBarToolBase tool) {
    if (tool._isControl) return "control";
    if (tool._kind == wxITEM_SEPARATOR) return tool._isStretchable ? "stretch" : "separator";
    switch (tool._kind) {
      case wxITEM_CHECK:
        return "check";
      case wxITEM_RADIO:
        return "radio";
      case wxITEM_DROPDOWN:
        return "dropdown";
      default:
        return "normal";
    }
  }

  /// Sends [WxUpdateUIEvent]s to all tools and renders changes
  @override
  void onInternalIdle() {
    for (final tool in List<WxToolBarToolBase>.of(_tools)) {
      if (!tool.isButton()) continue;
      final event = WxUpdateUIEvent(id: tool._id);
      event._isCheckable = tool.canBeToggled();
      event._isChecked = tool._isToggled;
      event._isEnabled = tool._isEnabled;
      event.setEventObject(this);
      processEvent(event);
      if (event.getSetEnabled() && event.getEnabled() != tool._isEnabled) {
        tool._isEnabled = event.getEnabled();
        _dirty = true;
      }
      if (tool.canBeToggled() && event.getSetChecked() && event.getChecked() != tool._isToggled) {
        if (tool._kind == wxITEM_RADIO && event.getChecked()) {
          _toggleRadio(tool);
        } else {
          tool._isToggled = event.getChecked();
        }
        _dirty = true;
      }
    }
    if (_dirty) _render();
  }

  // ------------------------- adding tools ----------------------

  WxToolBarToolBase _insert(int pos, WxToolBarToolBase tool) {
    tool._toolBar = this;
    if (pos < 0 || pos > _tools.length) pos = _tools.length;
    _tools.insert(pos, tool);
    if (tool._kind == wxITEM_RADIO && !_tools.any((t) => t != tool && _sameRadioGroup(t, tool) && t._isToggled)) {
      tool._isToggled = true; // the first tool of a radio group is selected
    }
    _changed();
    return tool;
  }

  WxToolBarToolBase _makeTool(int id, String label, WxBitmapBundle? bitmap, WxBitmapBundle? bmpDisabled,
      int kind, String shortHelp) {
    final tool = WxToolBarToolBase();
    tool._id = (id == wxID_ANY) ? _wxNewControlId() : id;
    tool._label = label;
    tool._kind = kind;
    tool._bundle = bitmap;
    tool._bundleDisabled = bmpDisabled;
    tool._shortHelp = shortHelp;
    return tool;
  }

  /// Adds a separator (space)
  WxToolBarToolBase addSeparator() {
    final tool = WxToolBarToolBase();
    tool._kind = wxITEM_SEPARATOR;
    return _insert(-1, tool);
  }

  /// Inserts a separator (space) at position [pos]
  WxToolBarToolBase insertSeparator(int pos) {
    final tool = WxToolBarToolBase();
    tool._kind = wxITEM_SEPARATOR;
    return _insert(pos, tool);
  }

  /// Adds a stretchable space. Surplus space will be evenly distributed
  /// among several stretchable spaces.
  WxToolBarToolBase addStretchableSpace() {
    final tool = WxToolBarToolBase();
    tool._kind = wxITEM_SEPARATOR;
    tool._isStretchable = true;
    return _insert(-1, tool);
  }

  /// Inserts a stretchable space at position [pos]. Surplus space will
  /// be evenly distributed among several stretchable spaces.
  WxToolBarToolBase insertStretchableSpace(int pos) {
    final tool = WxToolBarToolBase();
    tool._kind = wxITEM_SEPARATOR;
    tool._isStretchable = true;
    return _insert(pos, tool);
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
  WxToolBarToolBase addTool(int id, String label, WxBitmapBundle bitmap,
      {String shortHelp = "", int kind = wxITEM_NORMAL}) {
    return _insert(-1, _makeTool(id, label, bitmap, null, kind, shortHelp));
  }

  /// Inserts tool at position [pos]. Otherwise see [addTool].
  WxToolBarToolBase insertTool(int pos, int id, String label, WxBitmapBundle bitmap, WxBitmapBundle? bmpDisabled,
      {int kind = wxITEM_NORMAL, String shortHelp = ""}) {
    return _insert(pos, _makeTool(id, label, bitmap, bmpDisabled, kind, shortHelp));
  }

  /// Adds a checkable tool with an [id], a [label] and a [bitmap] and
  /// optionally a helptext. Optionally, a separate bitmap can be used
  /// to show the checked or unchecked state.
  ///
  /// Like for checkable menu items (see [WxMenu.appendCheckItem]), use [WxUpdateUIEvent]
  /// to set the state of the tool or use [toggleTool] directly.
  WxToolBarToolBase addCheckTool(int id, String label, WxBitmapBundle bitmap, WxBitmapBundle? bmpDisabled,
      {String shortHelp = ""}) {
    return _insert(-1, _makeTool(id, label, bitmap, bmpDisabled, wxITEM_CHECK, shortHelp));
  }

  /// Adds a radio button tool with an [id], a [label] and a [bitmap] and
  /// optionally a helptext. Optionally, a separate bitmap can be used
  /// to show the checked or unchecked state.
  ///
  /// Like for radio menu items (see [WxMenu.appendRadioItem]), use [WxUpdateUIEvent]
  /// to set the state of the radio tool or use [toggleTool] directly.
  WxToolBarToolBase addRadioTool(int id, String label, WxBitmapBundle bitmap, WxBitmapBundle? bmpDisabled,
      {String shortHelp = ""}) {
    return _insert(-1, _makeTool(id, label, bitmap, bmpDisabled, wxITEM_RADIO, shortHelp));
  }

  /// wxDart Web only: a tool showing just its label (no bitmap)
  WxToolBarToolBase addLabelTool(int id, String label, {String shortHelp = "", int kind = wxITEM_NORMAL}) {
    return _insert(-1, _makeTool(id, label, null, null, kind, shortHelp));
  }

  /// Adds the [control] to the toolbar
  WxToolBarToolBase addControl(WxControl control, {String label = ""}) {
    return insertControl(-1, control, label: label);
  }

  /// Inserts the [control] to the toolbar at position [pos]
  WxToolBarToolBase insertControl(int pos, WxControl control, {String label = ""}) {
    if (control.getParent() != this) {
      wxLogError("WxToolBar: the parent of a tool bar control must be the tool bar");
    }
    final tool = WxToolBarToolBase();
    tool._id = control.getId();
    tool._label = label;
    tool._control = control;
    tool._kind = wxITEM_NORMAL;
    tool._isControl = true;
    return _insert(pos, tool);
  }

  // ------------------------- managing tools ----------------------

  /// Deletes all tools
  void clearTools() {
    _tools.clear();
    _changed();
  }

  /// Deletes and remove the tool with the [id]
  bool deleteTool(int id) {
    final tool = findById(id);
    if (tool == null) return false;
    _tools.remove(tool);
    _changed();
    return true;
  }

  bool deleteToolByPos(int pos) {
    if (pos < 0 || pos >= _tools.length) return false;
    _tools.removeAt(pos);
    _changed();
    return true;
  }

  /// Enables or disables (usually greyed) a tool with the [id] based on
  /// the value of [enable]
  void enableTool(int id, {bool enable = true}) {
    final tool = findById(id);
    if (tool != null && tool._isEnabled != enable) {
      tool._isEnabled = enable;
      _changed();
    }
  }

  /// Returns true if the tool with the [id] is enabled
  bool getToolEnabled(int id) {
    return findById(id)?._isEnabled ?? false;
  }

  String getToolShortHelp(int id) {
    return findById(id)?._shortHelp ?? "";
  }

  void setToolShortHelp(int id, String help) {
    final tool = findById(id);
    if (tool != null) {
      tool._shortHelp = help;
      _changed();
    }
  }

  String getToolLabel(int id) {
    return findById(id)?._label ?? "";
  }

  void setToolLabel(int id, String label) {
    final tool = findById(id);
    if (tool != null) {
      tool._label = label;
      _changed();
    }
  }

  void setToolNormalBitmap(int id, WxBitmapBundle bitmap) {
    final tool = findById(id);
    if (tool != null) {
      tool._bundle = bitmap;
      _changed();
    }
  }

  /// Returns the number of tools
  int getToolsCount() {
    return _tools.length;
  }

  /// Set the Sets the default separator size. The default value is 5.
  void setToolSeparation(int separation) {
    _separation = separation;
    _changed();
  }

  int getToolSeparation() {
    return _separation;
  }

  /// Set the packing margin where supported.
  ///
  /// The packing is used for spacing in the vertical direction if
  /// the toolbar is horizontal, and for spacing in the horizontal
  /// direction if the toolbar is vertical.
  void setToolPacking(int packing) {}

  /// Returns true if the tool with [id] is togglable and is toggled.
  ///
  /// Only possible for radio and check tools.
  bool getToolState(int id) {
    return findById(id)?._isToggled ?? false;
  }

  /// Toggles tool with given [id]
  ///
  /// Only possible for radio and check tools.
  void toggleTool(int id, {bool toggle = true}) {
    final tool = findById(id);
    if (tool == null) return;
    if (tool._kind == wxITEM_RADIO && toggle) {
      _toggleRadio(tool);
    } else {
      tool._isToggled = toggle;
    }
    _changed();
  }

  /// Attach a dropdown menu to a tool. The tool must be of
  /// kind wxITEM_DROPDOWN.
  void setDropdownMenu(int id, WxMenu menu) {
    final tool = findById(id);
    if (tool == null) return;
    if (tool._kind != wxITEM_DROPDOWN) {
      wxLogError("ToolbarTool kind must be wxITEM_DROPDOWN");
    }
    tool._menu = menu;
  }

  /// Returns control with the given ID, if any.
  WxControl? findControl(int id) {
    for (final tool in _tools) {
      if (tool._control != null && tool._control!.getId() == id) return tool._control;
    }
    return null;
  }

  /// Returns tool at the position [pos]
  WxToolBarToolBase? getToolByPos(int pos) {
    return _tools.elementAtOrNull(pos);
  }

  int getToolPos(int id) {
    return _tools.indexWhere((tool) => tool._id == id);
  }

  /// Returns tool with id [id]
  WxToolBarToolBase? findById(int id) {
    for (final tool in _tools) {
      if (tool._id == id) return tool;
    }
    return null;
  }

  // ------------------------- radio groups ----------------------

  /// Radio tools next to each other form a group
  bool _sameRadioGroup(WxToolBarToolBase a, WxToolBarToolBase b) {
    if (a._kind != wxITEM_RADIO || b._kind != wxITEM_RADIO) return false;
    int ia = _tools.indexOf(a), ib = _tools.indexOf(b);
    if (ia < 0 || ib < 0) return false;
    if (ia > ib) {
      final t = ia;
      ia = ib;
      ib = t;
    }
    for (int i = ia; i <= ib; i++) {
      if (_tools[i]._kind != wxITEM_RADIO) return false;
    }
    return true;
  }

  void _toggleRadio(WxToolBarToolBase tool) {
    for (final other in _tools) {
      if (_sameRadioGroup(other, tool)) other._isToggled = (other == tool);
    }
  }

  // ------------------------- events from wxc.js ----------------------

  bool _onJsTool(String type, int index, int x, int y) {
    final tool = (index >= 0) ? _tools.elementAtOrNull(index) : null;
    switch (type) {
      case 'tool': {
        if (tool == null || !tool._isEnabled) return false;
        if (tool._kind == wxITEM_CHECK) {
          tool._isToggled = !tool._isToggled;
          _changed();
        } else if (tool._kind == wxITEM_RADIO) {
          if (tool._isToggled) return true; // already selected
          _toggleRadio(tool);
          _changed();
        }
        final event = WxCommandEvent(wxGetToolEventType(), tool._id);
        event.setInt(tool._isToggled ? 1 : 0);
        event.setEventObject(this);
        processEvent(event);
        return true;
      }
      case 'toolenter': {
        final event = WxCommandEvent(wxGetToolEnterEventType(), getId());
        event.setInt(tool?._id ?? -1);
        event.setEventObject(this);
        processEvent(event);
        return false;
      }
      case 'tooldropdown': {
        if (tool == null || !tool._isEnabled) return false;
        final event = WxCommandEvent(wxGetToolDropDownEventType(), tool._id);
        event.setEventObject(this);
        if (!processEvent(event) && tool._menu != null) {
          popupMenu(tool._menu!, pos: WxPoint(x, y));
        }
        return true;
      }
      default:
        return false;
    }
  }
}
