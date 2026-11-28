// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-11-15
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// Constants that live in Flutter specific files in wxDart Flutter
// (window.dart, toplevel_window.dart, sizer.dart, tool_bar.dart, ...).
// Values are identical so that code can be shared between the variants.

const int wxNO_IMAGE = -1;
const int wxNOT_FOUND = -1;

const int wxAPPEARANCE_SYSTEM = 0;
const int wxAPPEARANCE_LIGHT = 1;
const int wxAPPEARANCE_DARK = 2;

const int wxAPPEARANCE_RESULT_FAILURE = 0;
const int wxAPPEARANCE_RESULT_OK = 1;
const int wxAPPEARANCE_RESULT_CANNOT_CHANGE = 2;

// --- window styles (window.dart)
const int wxCENTRE = 0x0001;
const int wxCENTER = wxCENTRE;
const int wxCENTER_FRAME = 0x0000;
const int wxCENTRE_ON_SCREEN = 0x0002;
const int wxCENTER_ON_SCREEN = wxCENTRE_ON_SCREEN;
const int wxHORIZONTAL = 0x0004;
const int wxVERTICAL = 0x0008;
const int wxBOTH = wxVERTICAL | wxHORIZONTAL;
const int wxORIENTATION_MASK = wxBOTH;
const int wxBORDER_DEFAULT = 0;
const int wxBORDER_NONE = 0x00200000;
const int wxBORDER_STATIC = 0x01000000;
const int wxBORDER_SIMPLE = 0x02000000;
const int wxBORDER_RAISED = 0x04000000;
const int wxBORDER_SUNKEN = 0x08000000;
const int wxBORDER_DOUBLE = 0x10000000;
const int wxBORDER_THEME = wxBORDER_DOUBLE;
const int wxBORDER_MASK = 0x1f200000;
const int wxDEFAULT_CONTROL_BORDER = wxBORDER_SUNKEN;
const int wxVSCROLL = 0x80000000;
const int wxHSCROLL = 0x40000000;
const int wxCAPTION = 0x20000000;
const int wxALWAYS_SHOW_SB = 0x00800000;
const int wxTRANSLUCENT_WINDOW = 0x00100000;
const int wxTAB_TRAVERSAL = 0x00080000;
const int wxWANTS_CHARS = 0x00040000;
const int wxPOPUP_WINDOW = 0x00020000;
const int wxFULL_REPAINT_ON_RESIZE = 0x00010000;

const int wxBG_STYLE_ERASE = 0;
const int wxBG_STYLE_SYSTEM = 1;
const int wxBG_STYLE_PAINT = 2;
const int wxBG_STYLE_TRANSPARENT = 3;

const int wxTOUCH_NONE = 0;
const int wxTOUCH_HORIZONTAL_PAN_GESTURE = 0x0001;
const int wxTOUCH_VERTICAL_PAN_GESTURE = 0x0002;
const int wxTOUCH_PAN_GESTURES = wxTOUCH_VERTICAL_PAN_GESTURE | wxTOUCH_HORIZONTAL_PAN_GESTURE;
const int wxTOUCH_ZOOM_GESTURE = 0x0004;
const int wxTOUCH_ROTATE_GESTURE = 0x0008;
const int wxTOUCH_PRESS_GESTURES = 0x0010;
const int wxTOUCH_ALL_GESTURES = 0x001f;
const int wxTOUCH_RAW_EVENTS = 0x0020;

// --- top level window styles (toplevel_window.dart)
const int wxFULLSCREEN_NOMENUBAR   = 0x0001;
const int wxFULLSCREEN_NOTOOLBAR   = 0x0002;
const int wxFULLSCREEN_NOSTATUSBAR = 0x0004;
const int wxFULLSCREEN_NOBORDER    = 0x0008;
const int wxFULLSCREEN_NOCAPTION   = 0x0010;
const int wxFULLSCREEN_ALL         = wxFULLSCREEN_NOMENUBAR | wxFULLSCREEN_NOTOOLBAR |
                                     wxFULLSCREEN_NOSTATUSBAR | wxFULLSCREEN_NOBORDER |
                                     wxFULLSCREEN_NOCAPTION;

const int wxUSER_ATTENTION_INFO = 1;
const int wxUSER_ATTENTION_ERROR = 2;

const int wxCONTENT_PROTECTION_NONE = 0;
const int wxCONTENT_PROTECTION_ENABLED = 1;

const int wxSTAY_ON_TOP = 0x8000;
const int wxICONIZE = 0x4000;
const int wxMINIMIZE = wxICONIZE;
const int wxMAXIMIZE = 0x2000;
const int wxCLOSE_BOX = 0x1000;
const int wxSYSTEM_MENU = 0x0800;
const int wxMINIMIZE_BOX = 0x0400;
const int wxMAXIMIZE_BOX = 0x0200;
const int wxTINY_CAPTION = 0x0080;
const int wxRESIZE_BORDER = 0x0040;

// --- directions and alignment (sizer.dart)
const int wxLEFT = 0x0010;
const int wxRIGHT = 0x0020;
const int wxUP = 0x0040;
const int wxDOWN = 0x0080;
const int wxTOP = wxUP;
const int wxBOTTOM = wxDOWN;
const int wxNORTH = wxUP;
const int wxSOUTH = wxDOWN;
const int wxWEST = wxLEFT;
const int wxEAST = wxRIGHT;
const int wxALL = (wxUP | wxDOWN | wxRIGHT | wxLEFT);
const int wxDIRECTION_MASK = wxALL;

const int wxALIGN_INVALID = -1;
const int wxALIGN_NOT = 0x0000;
const int wxALIGN_CENTER_HORIZONTAL = 0x0100;
const int wxALIGN_CENTRE_HORIZONTAL = wxALIGN_CENTER_HORIZONTAL;
const int wxALIGN_LEFT = wxALIGN_NOT;
const int wxALIGN_TOP = wxALIGN_NOT;
const int wxALIGN_RIGHT = 0x0200;
const int wxALIGN_BOTTOM = 0x0400;
const int wxALIGN_CENTER_VERTICAL = 0x0800;
const int wxALIGN_CENTRE_VERTICAL = wxALIGN_CENTER_VERTICAL;
const int wxALIGN_CENTER = (wxALIGN_CENTER_HORIZONTAL | wxALIGN_CENTER_VERTICAL);
const int wxALIGN_CENTRE = wxALIGN_CENTER;
const int wxALIGN_MASK = 0x0f00;


// --- item kinds (tool_bar.dart)
const int wxITEM_SEPARATOR = -1;
const int wxITEM_NORMAL = 0;
const int wxITEM_CHECK = 1;
const int wxITEM_RADIO = 2;
const int wxITEM_DROPDOWN = 3;
const int wxITEM_MAX = 4;

// --- static text styles (static_text.dart)
const int wxST_NO_AUTORESIZE = 0x0001;
const int wxST_WRAP = 0x0002;
const int wxST_ELLIPSIZE_START = 0x0004;
const int wxST_ELLIPSIZE_MIDDLE = 0x0008;
const int wxST_ELLIPSIZE_END = 0x0010;
const int wxST_SELECTABLE = 0x0020;

// --- button styles (any_button.dart)
const int wxBU_LEFT = 0x0040;
const int wxBU_TOP = 0x0080;
const int wxBU_RIGHT = 0x0100;
const int wxBU_BOTTOM = 0x0200;
const int wxBU_ALIGN_MASK = ( wxBU_LEFT | wxBU_TOP | wxBU_RIGHT | wxBU_BOTTOM );
const int wxBU_EXACTFIT = 0x0001;
const int wxBU_NOTEXT = 0x0002;

// --- menu styles
const int wxMENU_TEAROFF = 0x0001;
const int wxMB_DOCKABLE = 0x0001;
const int wxMB_UNDERLINE = 0x0002;

// --- bitmap types (bitmap.dart)
const int wxBITMAP_TYPE_BMP = 1;
const int wxBITMAP_TYPE_GIF = 13;
const int wxBITMAP_TYPE_PNG = 15;
const int wxBITMAP_TYPE_JPEG = 17;
const int wxBITMAP_TYPE_WEBP = 32;
const int wxBITMAP_TYPE_ANY = 50;

// --- fill rules (dc.dart)
const int wxODDEVEN_RULE = 1;
const int wxWINDING_RULE = 2;

// --- font constants (font.dart)
const int wxFONTFAMILY_DEFAULT = 70;
const int wxFONTFAMILY_DECORATIVE = 71;
const int wxFONTFAMILY_ROMAN = 72;
const int wxFONTFAMILY_SCRIPT = 73;
const int wxFONTFAMILY_SWISS = 74;
const int wxFONTFAMILY_MODERN = 75;
const int wxFONTFAMILY_TELETYPE = 76;
const int wxFONTSTYLE_NORMAL = 90;
const int wxFONTSTYLE_ITALIC = 93;
const int wxFONTSTYLE_SLANT = 94;
const int wxFONTWEIGHT_INVALID = 0;
const int wxFONTWEIGHT_THIN = 100;
const int wxFONTWEIGHT_EXTRALIGHT = 200;
const int wxFONTWEIGHT_LIGHT = 300;
const int wxFONTWEIGHT_NORMAL = 400;
const int wxFONTWEIGHT_MEDIUM = 500;
const int wxFONTWEIGHT_SEMIBOLD = 600;
const int wxFONTWEIGHT_BOLD = 700;
const int wxFONTWEIGHT_EXTRABOLD = 800;
const int wxFONTWEIGHT_HEAVY = 900;
const int wxFONTWEIGHT_EXTRAHEAVY = 1000;

// --- sizer stretch flags (sizer.dart)
const int wxSTRETCH_NOT = 0x0000;
const int wxSHRINK = 0x1000;
const int wxGROW = 0x2000;
const int wxEXPAND = wxGROW;
const int wxSHAPED = 0x4000;
const int wxTILE = 0xc000;
const int wxSTRETCH_MASK = 0x7000;

// --- text control styles (text_ctrl.dart)
const int wxTE_READONLY = 0x0010;
const int wxTE_MULTILINE = 0x0020;
const int wxTE_PROCESS_TAB = 0x0040;
const int wxTE_PROCESS_ENTER = 0x0400;
const int wxTE_PASSWORD = 0x0800;
// not (yet) in wxDart Flutter, values as in wxWidgets
const int wxTE_NO_VSCROLL = 0x0002;
const int wxTE_LEFT = 0x0000;
const int wxTE_CENTRE = wxALIGN_CENTER_HORIZONTAL;
const int wxTE_CENTER = wxTE_CENTRE;
const int wxTE_RIGHT = wxALIGN_RIGHT;
const int wxTE_DONTWRAP = wxHSCROLL;

// --- check box styles (check_box.dart)
const int wxCHK_2STATE = 0x4000;
const int wxCHK_3STATE = 0x1000;
const int wxCHK_ALLOW_3RD_STATE_FOR_USER = 0x2000;
const int wxCHK_UNCHECKED = 0;
const int wxCHK_CHECKED = 1;
const int wxCHK_UNDETERMINED = 2;

// --- choice/combo box styles (combo_box.dart)
const int wxCB_SIMPLE = 0x0004;
const int wxCB_SORT = 0x0008;
const int wxCB_READONLY = 0x0010;
const int wxCB_DROPDOWN = 0x0020;

// --- hyperlink styles (hyperlink_ctrl.dart)
const int wxHL_CONTEXTMENU = 0x0001;
const int wxHL_ALIGN_LEFT = 0x0002;
const int wxHL_ALIGN_RIGHT = 0x0004;
const int wxHL_ALIGN_CENTRE = 0x0008;
const int wxHL_DEFAULT_STYLE = (wxHL_CONTEXTMENU|wxNO_BORDER|wxHL_ALIGN_CENTRE);

// --- slider styles (slider.dart)
const int wxSL_HORIZONTAL = wxHORIZONTAL;
const int wxSL_VERTICAL = wxVERTICAL;
const int wxSL_LEFT = 0x0040;
const int wxSL_RIGHT = 0x0100;
const int wxSL_TOP = 0x0080;
const int wxSL_BOTTOM = 0x0200;
const int wxSL_AUTOTICKS = 0x0010;
const int wxSL_MIN_MAX_LABELS = 0x2000;
const int wxSL_VALUE_LABEL = 0x4000;
const int wxSL_LABELS = (wxSL_MIN_MAX_LABELS|wxSL_VALUE_LABEL);
const int wxSL_INVERSE = 0x1000;

// --- gauge styles (gauge.dart)
const int wxGA_HORIZONTAL = wxHORIZONTAL;
const int wxGA_VERTICAL = wxVERTICAL;
const int wxGA_SMOOTH = 0x0020;
const int wxGA_TEXT = 0x0040;

// --- flex grid sizer grow modes (not in wxDart Flutter, values as in wxWidgets)
const int wxFLEX_GROWMODE_NONE = 0;
const int wxFLEX_GROWMODE_SPECIFIED = 1;
const int wxFLEX_GROWMODE_ALL = 2;

// --- tool bar styles (tool_bar.dart)
const int wxTB_FLAT = 0x0020;
const int wxTB_DOCKABLE = 0x0040;
const int wxTB_HORIZONTAL = wxHORIZONTAL;
const int wxTB_NOICONS = 0x0080;
const int wxTB_TEXT = 0x0100;
const int wxTB_DEFAULT_STYLE = wxHORIZONTAL;
// not (yet) in wxDart Flutter, values as in wxWidgets
const int wxTB_VERTICAL = wxVERTICAL;

// --- scroll bar visibility (not in wxDart Flutter, values as in wxWidgets)
const int wxSHOW_SB_NEVER = -1;
const int wxSHOW_SB_DEFAULT = 0;
const int wxSHOW_SB_ALWAYS = 1;
