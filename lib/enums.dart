
part of 'wx_dart.dart';

// ----------------------------- wxDart version ---------------------------

/// wxDart major version
const int wxDART_MAJOR_VERSION = 0;
/// wxDart minor version
const int wxDART_MINOR_VERSION = 9;
/// wxDart micro version
const int wxDART_MICRO_VERSION = 1;


// ------------- constants that don't belong to a single class ------------


// from enum wxSizerFlagBits
const int    wxADJUST_MINSIZE               = 0;
const int    wxFIXED_MINSIZE                = 0x8000;
const int    wxRESERVE_SPACE_EVEN_IF_HIDDEN = 0x0002;
const int    wxSIZER_FLAG_BITS_MASK         = 0x8002;

// from enum wxEllipsizeFlags
const int wxELLIPSIZE_FLAGS_NONE = 0;
const int wxELLIPSIZE_FLAGS_PROCESS_MNEMONICS = 1;
const int wxELLIPSIZE_FLAGS_EXPAND_TABS = 2;
const int wxELLIPSIZE_FLAGS_DEFAULT = wxELLIPSIZE_FLAGS_PROCESS_MNEMONICS |
                                      wxELLIPSIZE_FLAGS_EXPAND_TABS;

// from enum wxEllipsizeMode
const int wxELLIPSIZE_NONE = 0;
const int wxELLIPSIZE_START = 1;
const int wxELLIPSIZE_MIDDLE = 2;
const int wxELLIPSIZE_END = 3;

// old window style flags 
const int wxDOUBLE_BORDER       = wxBORDER_DOUBLE;
const int wxSUNKEN_BORDER       = wxBORDER_SUNKEN;
const int wxRAISED_BORDER       = wxBORDER_RAISED;
const int wxBORDER              = wxBORDER_SIMPLE;
const int wxSIMPLE_BORDER       = wxBORDER_SIMPLE;
const int wxSTATIC_BORDER       = wxBORDER_STATIC;
const int wxNO_BORDER           = wxBORDER_NONE;


/*  Clip children when painting, which reduces flicker in e.g. frames and */
/*  splitter windows, but can't be used in a panel where a static box must be */
/*  'transparent' (panel paints the background for it) */
const int wxCLIP_CHILDREN       = 0x00400000;

/*  Note we're reusing the wxCAPTION style because we won't need captions */
/*  for subwindows/controls */
const int wxCLIP_SIBLINGS        = 0x20000000;


/* A mask which can be used to filter (out) all wxWindow-specific styles.
 */
const int wxWINDOW_STYLE_MASK     =
    (wxVSCROLL|wxHSCROLL|wxBORDER_MASK|wxALWAYS_SHOW_SB|wxCLIP_CHILDREN| 
     wxCLIP_SIBLINGS|wxTRANSLUCENT_WINDOW|wxTAB_TRAVERSAL|wxWANTS_CHARS| 
     wxPOPUP_WINDOW|wxFULL_REPAINT_ON_RESIZE);

/*
 * Extra window style flags (use wxWS_EX prefix to make it clear that they
 * should be passed to wxWindow::SetExtraStyle(), not SetWindowStyle())
 */

/* This flag is obsolete as recursive validation is now the default (and only
 * possible) behaviour. Simply don't use it any more in the new code. */
const int wxWS_EX_VALIDATE_RECURSIVELY  = 0x00000000; /* used to be 1 */

/*  wxCommandEvents and the objects of the derived classes are forwarded to the */
/*  parent window and so on recursively by default. Using this flag for the */
/*  given window allows to block this propagation at this window, i.e. prevent */
/*  the events from being propagated further upwards. The dialogs have this */
/*  flag on by default. */
const int wxWS_EX_BLOCK_EVENTS          = 0x00000002;

/*  don't use this window as an implicit parent for the other windows: this must */
/*  be used with transient windows as otherwise there is the risk of creating a */
/*  dialog/frame with this window as a parent which would lead to a crash if the */
/*  parent is destroyed before the child */
const int wxWS_EX_TRANSIENT             = 0x00000004;

/*  don't paint the window background, we'll assume it will */
/*  be done by a theming engine. This is not yet used but could */
/*  possibly be made to work in the future, at least on Windows */
const int wxWS_EX_THEMED_BACKGROUND     = 0x00000008;

/*  this window should always process idle events */
const int wxWS_EX_PROCESS_IDLE          = 0x00000010;

/*  this window should always process UI update events */
const int wxWS_EX_PROCESS_UI_UPDATES    = 0x00000020;

/*  Draw the window in a metal theme on Mac */
const int wxFRAME_EX_METAL              = 0x00000040;
const int wxDIALOG_EX_METAL             = 0x00000040;

/*  Use this style to add a context-sensitive help to the window (currently for */
/*  Win32 only and it doesn't work if wxMINIMIZE_BOX or wxMAXIMIZE_BOX are used) */
const int wxWS_EX_CONTEXTHELP           = 0x00000080;

/* synonyms for wxWS_EX_CONTEXTHELP for compatibility */
const int wxFRAME_EX_CONTEXTHELP        = wxWS_EX_CONTEXTHELP;
const int wxDIALOG_EX_CONTEXTHELP       = wxWS_EX_CONTEXTHELP;

/*  Create a window which is attachable to another top level window */
const int wxFRAME_DRAWER         = 0x0020;

/*
 * MDI parent frame style flags
 * Can overlap with some of the above.
 */

const int wxFRAME_NO_WINDOW_MENU = 0x0100;


/*
 * extended dialog specifiers. these values are stored in a different
 * flag and thus do not overlap with other style flags. note that these
 * values do not correspond to the return values of the dialogs (for
 * those values, look at the wxID_XXX defines).
 */

/*  wxCENTRE already defined as  0x00000001 */
const int wxYES                   = 0x00000002;
const int wxOK                    = 0x00000004;
const int wxNO                    = 0x00000008;
const int wxYES_NO                = (wxYES | wxNO);
const int wxCANCEL                = 0x00000010;
const int wxAPPLY                 = 0x00000020;
const int wxCLOSE                 = 0x00000040;

const int wxOK_DEFAULT            = 0x00000000;  /* has no effect (default) */
const int wxYES_DEFAULT           = 0x00000000;  /* has no effect (default) */
const int wxNO_DEFAULT            = 0x00000080;  /* only valid with wxYES_NO */
const int wxCANCEL_DEFAULT        = 0x80000000;  /* only valid with wxCANCEL */

const int wxICON_WARNING          = 0x00000100;
const int wxICON_ERROR            = 0x00000200;
const int wxICON_QUESTION         = 0x00000400;
const int wxICON_INFORMATION      = 0x00000800;
const int wxICON_EXCLAMATION      = wxICON_WARNING;
const int wxICON_HAND             = wxICON_ERROR;
const int wxICON_STOP             = wxICON_ERROR;
const int wxICON_ASTERISK         = wxICON_INFORMATION;

const int wxHELP                  = 0x00001000;
const int wxFORWARD               = 0x00002000;
const int wxBACKWARD              = 0x00004000;
const int wxRESET                 = 0x00008000;
const int wxMORE                  = 0x00010000;
const int wxSETUP                 = 0x00020000;
const int wxICON_NONE             = 0x00040000;
const int wxICON_AUTH_NEEDED      = 0x00080000;

const int wxICON_MASK =
    (wxICON_EXCLAMATION|wxICON_HAND|wxICON_QUESTION|wxICON_INFORMATION|wxICON_NONE|wxICON_AUTH_NEEDED);




/*
 * Key types used by (old style) lists and hashes.
 */
// enum WxKeyType
const int  wxKEY_NONE     = 0;
const int  wxKEY_INTEGER  = 1;
const int  wxKEY_STRING   = 2;

/*  ---------------------------------------------------------------------------- */
/*  standard IDs */
/*  ---------------------------------------------------------------------------- */

/*  Standard menu IDs */

    /* no id matches this one when compared to it */
    const int wxID_NONE             = -3;

    /*  id for a separator line in the menu (invalid for normal item) */
    const int wxID_SEPARATOR        = -2;

    /* any id: means that we don't care about the id, whether when installing
     * an event handler or when creating a new window */
    const int wxID_ANY              = -1;


    /* all predefined ids are between wxID_LOWEST and wxID_HIGHEST */
    const int wxID_LOWEST           = 4999;

    const int  wxID_OPEN            = 5000;
    const int  wxID_CLOSE           = 5001;
    const int  wxID_NEW             = 5002;
    const int  wxID_SAVE            = 5003;
    const int  wxID_SAVEAS          = 5004;
    const int  wxID_REVERT          = 5005;
    const int  wxID_EXIT            = 5006;
    const int  wxID_UNDO            = 5007;
    const int  wxID_REDO            = 5008;
    const int  wxID_HELP            = 5009;
    const int  wxID_PRINT           = 5010;
    const int  wxID_PRINT_SETUP     = 5011;
    const int  wxID_PAGE_SETUP      = 5012;
    const int  wxID_PREVIEW         = 5013;
    const int  wxID_ABOUT           = 5014;
    const int  wxID_HELP_CONTENTS   = 5015;
    const int  wxID_HELP_INDEX      = 5016;
    const int  wxID_HELP_SEARCH     = 5017;
    const int  wxID_HELP_COMMANDS   = 5018;
    const int  wxID_HELP_PROCEDURES = 5019;
    const int  wxID_HELP_CONTEXT    = 5020;
    const int  wxID_CLOSE_ALL       = 5021;
    const int  wxID_PREFERENCES     = 5022;

    const int  wxID_EDIT            = 5030;
    const int  wxID_CUT             = 5031;
    const int  wxID_COPY            = 5032;
    const int  wxID_PASTE           = 5033;
    const int  wxID_CLEAR           = 5034;
    const int  wxID_FIND            = 5035;
    const int  wxID_DUPLICATE       = 5036;
    const int  wxID_SELECTALL       = 5037;
    const int  wxID_DELETE          = 5038;
    const int  wxID_REPLACE         = 5039;
    const int  wxID_REPLACE_ALL     = 5040;
    const int  wxID_PROPERTIES      = 5041;

    const int  wxID_VIEW_DETAILS    = 5042;
    const int  wxID_VIEW_LARGEICONS = 5043;
    const int  wxID_VIEW_SMALLICONS = 5044;
    const int  wxID_VIEW_LIST       = 5045;
    const int  wxID_VIEW_SORTDATE   = 5046;
    const int  wxID_VIEW_SORTNAME   = 5047;
    const int  wxID_VIEW_SORTSIZE   = 5048;
    const int  wxID_VIEW_SORTTYPE   = 5049;

    const int  wxID_FILE            = 5050;
    const int  wxID_FILE1           = 5051;
    const int  wxID_FILE2           = 5052;
    const int  wxID_FILE3           = 5053;
    const int  wxID_FILE4           = 5054;
    const int  wxID_FILE5           = 5055;
    const int  wxID_FILE6           = 5056;
    const int  wxID_FILE7           = 5057;
    const int  wxID_FILE8           = 5058;
    const int  wxID_FILE9           = 5059;

    /*  Standard button and menu IDs */
    const int  wxID_OK              = 5100;
    const int  wxID_CANCEL          = 5101;
    const int  wxID_APPLY           = 5102;
    const int  wxID_YES             = 5103;
    const int  wxID_NO              = 5104;
    const int  wxID_STATIC          = 5105;
    const int  wxID_FORWARD         = 5106;
    const int  wxID_BACKWARD        = 5107;
    const int  wxID_DEFAULT         = 5108;
    const int  wxID_MORE            = 5109;
    const int  wxID_SETUP           = 5110;
    const int  wxID_RESET           = 5111;
    const int  wxID_CONTEXT_HELP    = 5112;
    const int  wxID_YESTOALL        = 5113;
    const int  wxID_NOTOALL         = 5114;
    const int  wxID_ABORT           = 5115;
    const int  wxID_RETRY           = 5116;
    const int  wxID_IGNORE          = 5117;
    const int  wxID_ADD             = 5118;
    const int  wxID_REMOVE          = 5110;

    const int  wxID_UP              = 5120;
    const int  wxID_DOWN            = 5121;
    const int  wxID_HOME            = 5122;
    const int  wxID_REFRESH         = 5123;
    const int  wxID_STOP            = 5124;
    const int  wxID_INDEX           = 5125;


    /*  System menu IDs (used by const int  wxUniv): */
    const int  wxID_SYSTEM_MENU               = 5200;
    const int  wxID_CLOSE_FRAME               = 5201;
    const int  wxID_MOVE_FRAME                = 5202;
    const int  wxID_RESIZE_FRAME              = 5203;
    const int  wxID_MAXIMIZE_FRAME            = 5204;
    const int  wxID_ICONIZE_FRAME             = 5205;
    const int  wxID_RESTORE_FRAME             = 5206;

    /* MDI window menu ids */
    const int  wxID_MDI_WINDOW_FIRST          = 5230;
    const int  wxID_MDI_WINDOW_CASCADE        = wxID_MDI_WINDOW_FIRST;
    const int  wxID_MDI_WINDOW_TILE_HORZ      = 5231;
    const int  wxID_MDI_WINDOW_TILE_VERT      = 5232;
    const int  wxID_MDI_WINDOW_ARRANGE_ICONS  = 5233;
    const int  wxID_MDI_WINDOW_PREV           = 5234;
    const int  wxID_MDI_WINDOW_NEXT           = 5235;
    const int  wxID_MDI_WINDOW_LAST           = wxID_MDI_WINDOW_NEXT;

    /* OS X system menu ids */
    const int  wxID_OSX_MENU_FIRST            = 5250;
    const int  wxID_OSX_HIDE                  = wxID_OSX_MENU_FIRST;
    const int  wxID_OSX_HIDEOTHERS            = 5251;
    const int  wxID_OSX_SHOWALL               = 5252;
    const int  wxID_OSX_SERVICES              = 5253;
    const int  wxID_OSX_MENU_LAST             = wxID_OSX_SERVICES;

    /*  IDs used by generic file dialog (13 consecutive starting from this value) */
    const int  wxID_FILEDLGG = 5900;

    /*  IDs used by generic file ctrl (4 consecutive starting from this value) */
    const int  wxID_FILECTRL = 5950;

    const int  wxID_HIGHEST = 5999;


/*  ---------------------------------------------------------------------------- */
/*  wxWindowID type                                                              */
/*  ---------------------------------------------------------------------------- */

/* Note that this is defined even in non-GUI code as the same type is also used
   for e.g. timer IDs. */
// typedef int wxWindowID;

/*  ---------------------------------------------------------------------------- */
/*  other constants */
/*  ---------------------------------------------------------------------------- */


/*  hit test results */
// enum wxHitTest
const int  wxHT_NOWHERE = 0;
const int  wxHT_SCROLLBAR_FIRST = wxHT_NOWHERE;
const int  wxHT_SCROLLBAR_ARROW_LINE_1 = 1;    /*  left or upper arrow to scroll by line */
const int  wxHT_SCROLLBAR_ARROW_LINE_2 = 2;    /*  right or down */
const int  wxHT_SCROLLBAR_ARROW_PAGE_1 = 3;    /*  left or upper arrow to scroll by page */
const int  wxHT_SCROLLBAR_ARROW_PAGE_2 = 4;    /*  right or down */
const int  wxHT_SCROLLBAR_THUMB        = 5;    /*  on the thumb */
const int  wxHT_SCROLLBAR_BAR_1        = 6;    /*  bar to the left/above the thumb */
const int  wxHT_SCROLLBAR_BAR_2        = 7;    /*  bar to the right/below the thumb */
const int  wxHT_SCROLLBAR_LAST         = 8;
const int  wxHT_WINDOW_OUTSIDE         = 9;    /*  not in this window at all */
const int  wxHT_WINDOW_INSIDE          = 10;   /*  in the client area */
const int  wxHT_WINDOW_VERT_SCROLLBAR  = 11;   /*  on the vertical scrollbar */
const int  wxHT_WINDOW_HORZ_SCROLLBAR  = 12;   /*  on the horizontal scrollbar */
const int  wxHT_WINDOW_CORNER          = 13;  /*  on the corner between 2 scrollbars */
const int  wxHT_MAX                    = 14;

/*  ---------------------------------------------------------------------------- */
/*  Possible SetSize flags */
/*  ---------------------------------------------------------------------------- */

/*  Use internally-calculated width if -1 */
const int wxSIZE_AUTO_WIDTH       = 0x0001;
/*  Use internally-calculated height if -1 */
const int wxSIZE_AUTO_HEIGHT      = 0x0002;
/*  Use internally-calculated width and height if each is -1 */
const int wxSIZE_AUTO             = (wxSIZE_AUTO_WIDTH|wxSIZE_AUTO_HEIGHT);
/*  Ignore missing (-1) dimensions (use existing). */
/*  For readability only: test for wxSIZE_AUTO_WIDTH/HEIGHT in code. */
const int wxSIZE_USE_EXISTING     = 0x0000;
/*  Allow -1 as a valid position */
const int wxSIZE_ALLOW_MINUS_ONE  = 0x0004;
/*  Don't do parent client adjustments (for implementation only) */
const int wxSIZE_NO_ADJUSTMENTS   = 0x0008;
/*  Change the window position even if it seems to be already correct */
const int wxSIZE_FORCE            = 0x0010;
/*  Emit size event even if size didn't change */
const int wxSIZE_FORCE_EVENT      = 0x0020;

/*  ---------------------------------------------------------------------------- */
/*  GDI descriptions */
/*  ---------------------------------------------------------------------------- */

// Hatch styles used by both pen and brush styles.
//
// NB: Do not use these constants directly, they're for internal use only, use
//     wxBRUSHSTYLE_XXX_HATCH and wxPENSTYLE_XXX_HATCH instead.
// enum wxHatchStyle

const int  wxHATCHSTYLE_INVALID     = -1;
const int  wxHATCHSTYLE_FIRST       = 111;
const int  wxHATCHSTYLE_BDIAGONAL   = wxHATCHSTYLE_FIRST;
const int  wxHATCHSTYLE_CROSSDIAG   = 112;
const int  wxHATCHSTYLE_FDIAGONAL   = 113;
const int  wxHATCHSTYLE_CROSS       = 114;
const int  wxHATCHSTYLE_HORIZONTAL  = 115;
const int  wxHATCHSTYLE_VERTICAL    = 116;
const int  wxHATCHSTYLE_LAST        = wxHATCHSTYLE_VERTICAL;

// toolbar ?
const int  wxTOOL_TOP     = 1;
const int  wxTOOL_BOTTOM  = 2;
const int  wxTOOL_LEFT    = 3;
const int  wxTOOL_RIGHT   = 4;

/*  the values of the format constants should be the same as corresponding */
/*  CF_XXX constants in Windows API */
// enum wxDataFormatId

const int  wxDF_INVALID =          0;
const int  wxDF_TEXT =             1;  /* CF_TEXT */
const int  wxDF_BITMAP =           2;  /* CF_BITMAP */
const int  wxDF_METAFILE =         3;  /* CF_METAFILEPICT */
const int  wxDF_SYLK =             4;
const int  wxDF_DIF =              5;
const int  wxDF_TIFF =             6;
const int  wxDF_OEMTEXT =          7;  /* CF_OEMTEXT */
const int  wxDF_DIB =              8;  /* CF_DIB */
const int  wxDF_PALETTE =          9;
const int  wxDF_PENDATA =          10;
const int  wxDF_RIFF =             11;
const int  wxDF_WAVE =             12;
const int  wxDF_UNICODETEXT =      13;
const int  wxDF_ENHMETAFILE =      14;
const int  wxDF_FILENAME =         15; /* CF_HDROP */
const int  wxDF_LOCALE =           16;
const int  wxDF_PRIVATE =          20;
const int  wxDF_HTML =             30; /* Note: does not correspond to CF_ constant */
const int  wxDF_PNG =              31; /* Note: does not correspond to CF_ constant */
const int  wxDF_MAX =              32;

/* Key codes */
// enum wxKeyCode

const int  WXK_NONE    =    0;
const int  WXK_BACK    =    8; /* backspace */
const int  WXK_TAB     =    9;
const int  WXK_RETURN  =    13;
const int  WXK_ESCAPE  =    27;

const int  WXK_SPACE   =    32;
    /* values from 33 to 126 are reserved for the standard ASCII characters */
const int  WXK_DELETE  =    127;

    /* values from 128 to 255 are reserved for ASCII extended characters
       (note that there isn't a single fixed standard for the meaning
       of these values; avoid them in portable apps!) */

    /* These are not compatible with unicode characters.
       If you want to get a unicode character from a key event, use
       wxKeyEvent::GetUnicodeKey                                    */
const int  WXK_START       = 300;
const int  WXK_LBUTTON     = 301;
const int  WXK_RBUTTON     = 302;
const int  WXK_CANCEL      = 303;
const int  WXK_MBUTTON     = 304;
const int  WXK_CLEAR       = 305;
const int  WXK_SHIFT       = 306;
const int  WXK_ALT         = 307;
const int  WXK_CONTROL     = 308;
const int  WXK_MENU        = 309;
const int  WXK_PAUSE       = 310;
const int  WXK_CAPITAL     = 311;
const int  WXK_END         = 312;
const int  WXK_HOME        = 313;
const int  WXK_LEFT        = 314;
const int  WXK_UP          = 315;
const int  WXK_RIGHT       = 316;
const int  WXK_DOWN        = 317;
const int  WXK_SELECT      = 318;
const int  WXK_PRINT       = 319;
const int  WXK_EXECUTE     = 320;
const int  WXK_SNAPSHOT    = 321;
const int  WXK_INSERT      = 322;
const int  WXK_HELP        = 323;
const int  WXK_NUMPAD0     = 324;
const int  WXK_NUMPAD1     = 325;
const int  WXK_NUMPAD2     = 326;
const int  WXK_NUMPAD3     = 327;
const int  WXK_NUMPAD4     = 328;
const int  WXK_NUMPAD5     = 329;
const int  WXK_NUMPAD6     = 330;
const int  WXK_NUMPAD7     = 331;
const int  WXK_NUMPAD8     = 332;
const int  WXK_NUMPAD9     = 333;
const int  WXK_MULTIPLY    = 334;
const int  WXK_ADD         = 335;
const int  WXK_SEPARATOR   = 336;
const int  WXK_SUBTRACT    = 337;
const int  WXK_DECIMAL     = 338;
const int  WXK_DIVIDE      = 339;
const int  WXK_F1          = 340;
const int  WXK_F2          = 341;
const int  WXK_F3          = 342;
const int  WXK_F4          = 343;
const int  WXK_F5          = 344;
const int  WXK_F6          = 345;
const int  WXK_F7          = 346;
const int  WXK_F8          = 347;
const int  WXK_F9          = 348;
const int  WXK_F10         = 349;
const int  WXK_F11         = 350;
const int  WXK_F12         = 351;
const int  WXK_F13         = 352;
const int  WXK_F14         = 353;
const int  WXK_F15         = 354;
const int  WXK_F16         = 355;
const int  WXK_F17         = 356;
const int  WXK_F18         = 357;
const int  WXK_F19         = 358;
const int  WXK_F20         = 359;
const int  WXK_F21         = 360;
const int  WXK_F22         = 361;
const int  WXK_F23         = 362;
const int  WXK_F24         = 363;
const int  WXK_NUMLOCK          = 364;
const int  WXK_SCROLL           = 365;
const int  WXK_PAGEUP           = 366;
const int  WXK_PAGEDOWN         = 367;
const int  WXK_NUMPAD_SPACE     = 368;
const int  WXK_NUMPAD_TAB       = 369;
const int  WXK_NUMPAD_ENTER     = 370;
const int  WXK_NUMPAD_F1        = 371;
const int  WXK_NUMPAD_F2        = 372;
const int  WXK_NUMPAD_F3        = 373;
const int  WXK_NUMPAD_F4        = 374;
const int  WXK_NUMPAD_HOME      = 375;
const int  WXK_NUMPAD_LEFT      = 376;
const int  WXK_NUMPAD_UP        = 377;
const int  WXK_NUMPAD_RIGHT     = 378;
const int  WXK_NUMPAD_DOWN      = 379;
const int  WXK_NUMPAD_PAGEUP    = 380;
const int  WXK_NUMPAD_PAGEDOWN  = 381;
const int  WXK_NUMPAD_END       = 382;
const int  WXK_NUMPAD_BEGIN     = 383;
const int  WXK_NUMPAD_INSERT    = 384;
const int  WXK_NUMPAD_DELETE    = 385;
const int  WXK_NUMPAD_EQUAL     = 386;
const int  WXK_NUMPAD_MULTIPLY  = 387;
const int  WXK_NUMPAD_ADD       = 388;
const int  WXK_NUMPAD_SEPARATOR = 389;
const int  WXK_NUMPAD_SUBTRACT  = 390;
const int  WXK_NUMPAD_DECIMAL   = 391;
const int  WXK_NUMPAD_DIVIDE    = 392;
const int  WXK_WINDOWS_LEFT     = 393;
const int  WXK_WINDOWS_RIGHT    = 394;
const int  WXK_WINDOWS_MENU     = 395;

/* This enum contains bit mask constants used in wxKeyEvent */
// enum wxKeyModifier

const int  wxMOD_NONE      = 0x0000;
const int  wxMOD_ALT       = 0x0001;
const int  wxMOD_CONTROL   = 0x0002;
const int  wxMOD_ALTGR     = wxMOD_ALT | wxMOD_CONTROL;
const int  wxMOD_SHIFT     = 0x0004;
const int  wxMOD_META      = 0x0008;
const int  wxMOD_WIN       = wxMOD_META;
// #if defined(__WXMAC__)
const int  wxMOD_RAW_CONTROL = 0x0010;
//#else
//    wxMOD_RAW_CONTROL = wxMOD_CONTROL,
//#endif
const int  wxMOD_CMD       = wxMOD_CONTROL;
const int  wxMOD_ALL       = 0xffff;


/* Paper types */
enum wxPaperSize
{
    wxPAPER_NONE,               /*  Use specific dimensions */
    wxPAPER_LETTER,             /*  Letter, 8 1/2 by 11 inches */
    wxPAPER_LEGAL,              /*  Legal, 8 1/2 by 14 inches */
    wxPAPER_A4,                 /*  A4 Sheet, 210 by 297 millimeters */
    wxPAPER_CSHEET,             /*  C Sheet, 17 by 22 inches */
    wxPAPER_DSHEET,             /*  D Sheet, 22 by 34 inches */
    wxPAPER_ESHEET,             /*  E Sheet, 34 by 44 inches */
    wxPAPER_LETTERSMALL,        /*  Letter Small, 8 1/2 by 11 inches */
    wxPAPER_TABLOID,            /*  Tabloid, 11 by 17 inches */
    wxPAPER_LEDGER,             /*  Ledger, 17 by 11 inches */
    wxPAPER_STATEMENT,          /*  Statement, 5 1/2 by 8 1/2 inches */
    wxPAPER_EXECUTIVE,          /*  Executive, 7 1/4 by 10 1/2 inches */
    wxPAPER_A3,                 /*  A3 sheet, 297 by 420 millimeters */
    wxPAPER_A4SMALL,            /*  A4 small sheet, 210 by 297 millimeters */
    wxPAPER_A5,                 /*  A5 sheet, 148 by 210 millimeters */
    wxPAPER_B4,                 /*  B4 sheet, 250 by 354 millimeters */
    wxPAPER_B5,                 /*  B5 sheet, 182-by-257-millimeter paper */
    wxPAPER_FOLIO,              /*  Folio, 8-1/2-by-13-inch paper */
    wxPAPER_QUARTO,             /*  Quarto, 215-by-275-millimeter paper */
    wxPAPER_10X14,              /*  10-by-14-inch sheet */
    wxPAPER_11X17,              /*  11-by-17-inch sheet */
    wxPAPER_NOTE,               /*  Note, 8 1/2 by 11 inches */
    wxPAPER_ENV_9,              /*  #9 Envelope, 3 7/8 by 8 7/8 inches */
    wxPAPER_ENV_10,             /*  #10 Envelope, 4 1/8 by 9 1/2 inches */
    wxPAPER_ENV_11,             /*  #11 Envelope, 4 1/2 by 10 3/8 inches */
    wxPAPER_ENV_12,             /*  #12 Envelope, 4 3/4 by 11 inches */
    wxPAPER_ENV_14,             /*  #14 Envelope, 5 by 11 1/2 inches */
    wxPAPER_ENV_DL,             /*  DL Envelope, 110 by 220 millimeters */
    wxPAPER_ENV_C5,             /*  C5 Envelope, 162 by 229 millimeters */
    wxPAPER_ENV_C3,             /*  C3 Envelope, 324 by 458 millimeters */
    wxPAPER_ENV_C4,             /*  C4 Envelope, 229 by 324 millimeters */
    wxPAPER_ENV_C6,             /*  C6 Envelope, 114 by 162 millimeters */
    wxPAPER_ENV_C65,            /*  C65 Envelope, 114 by 229 millimeters */
    wxPAPER_ENV_B4,             /*  B4 Envelope, 250 by 353 millimeters */
    wxPAPER_ENV_B5,             /*  B5 Envelope, 176 by 250 millimeters */
    wxPAPER_ENV_B6,             /*  B6 Envelope, 176 by 125 millimeters */
    wxPAPER_ENV_ITALY,          /*  Italy Envelope, 110 by 230 millimeters */
    wxPAPER_ENV_MONARCH,        /*  Monarch Envelope, 3 7/8 by 7 1/2 inches */
    wxPAPER_ENV_PERSONAL,       /*  6 3/4 Envelope, 3 5/8 by 6 1/2 inches */
    wxPAPER_FANFOLD_US,         /*  US Std Fanfold, 14 7/8 by 11 inches */
    wxPAPER_FANFOLD_STD_GERMAN, /*  German Std Fanfold, 8 1/2 by 12 inches */
    wxPAPER_FANFOLD_LGL_GERMAN, /*  German Legal Fanfold, 8 1/2 by 13 inches */

    wxPAPER_ISO_B4,             /*  B4 (ISO) 250 x 353 mm */
    wxPAPER_JAPANESE_POSTCARD,  /*  Japanese Postcard 100 x 148 mm */
    wxPAPER_9X11,               /*  9 x 11 in */
    wxPAPER_10X11,              /*  10 x 11 in */
    wxPAPER_15X11,              /*  15 x 11 in */
    wxPAPER_ENV_INVITE,         /*  Envelope Invite 220 x 220 mm */
    wxPAPER_LETTER_EXTRA,       /*  Letter Extra 9 \275 x 12 in */
    wxPAPER_LEGAL_EXTRA,        /*  Legal Extra 9 \275 x 15 in */
    wxPAPER_TABLOID_EXTRA,      /*  Tabloid Extra 11.69 x 18 in */
    wxPAPER_A4_EXTRA,           /*  A4 Extra 9.27 x 12.69 in */
    wxPAPER_LETTER_TRANSVERSE,  /*  Letter Transverse 8 \275 x 11 in */
    wxPAPER_A4_TRANSVERSE,      /*  A4 Transverse 210 x 297 mm */
    wxPAPER_LETTER_EXTRA_TRANSVERSE, /*  Letter Extra Transverse 9\275 x 12 in */
    wxPAPER_A_PLUS,             /*  SuperA/SuperA/A4 227 x 356 mm */
    wxPAPER_B_PLUS,             /*  SuperB/SuperB/A3 305 x 487 mm */
    wxPAPER_LETTER_PLUS,        /*  Letter Plus 8.5 x 12.69 in */
    wxPAPER_A4_PLUS,            /*  A4 Plus 210 x 330 mm */
    wxPAPER_A5_TRANSVERSE,      /*  A5 Transverse 148 x 210 mm */
    wxPAPER_B5_TRANSVERSE,      /*  B5 (JIS) Transverse 182 x 257 mm */
    wxPAPER_A3_EXTRA,           /*  A3 Extra 322 x 445 mm */
    wxPAPER_A5_EXTRA,           /*  A5 Extra 174 x 235 mm */
    wxPAPER_B5_EXTRA,           /*  B5 (ISO) Extra 201 x 276 mm */
    wxPAPER_A2,                 /*  A2 420 x 594 mm */
    wxPAPER_A3_TRANSVERSE,      /*  A3 Transverse 297 x 420 mm */
    wxPAPER_A3_EXTRA_TRANSVERSE, /*  A3 Extra Transverse 322 x 445 mm */

    wxPAPER_DBL_JAPANESE_POSTCARD,/* Japanese Double Postcard 200 x 148 mm */
    wxPAPER_A6,                 /* A6 105 x 148 mm */
    wxPAPER_JENV_KAKU2,         /* Japanese Envelope Kaku #2 */
    wxPAPER_JENV_KAKU3,         /* Japanese Envelope Kaku #3 */
    wxPAPER_JENV_CHOU3,         /* Japanese Envelope Chou #3 */
    wxPAPER_JENV_CHOU4,         /* Japanese Envelope Chou #4 */
    wxPAPER_LETTER_ROTATED,     /* Letter Rotated 11 x 8 1/2 in */
    wxPAPER_A3_ROTATED,         /* A3 Rotated 420 x 297 mm */
    wxPAPER_A4_ROTATED,         /* A4 Rotated 297 x 210 mm */
    wxPAPER_A5_ROTATED,         /* A5 Rotated 210 x 148 mm */
    wxPAPER_B4_JIS_ROTATED,     /* B4 (JIS) Rotated 364 x 257 mm */
    wxPAPER_B5_JIS_ROTATED,     /* B5 (JIS) Rotated 257 x 182 mm */
    wxPAPER_JAPANESE_POSTCARD_ROTATED,/* Japanese Postcard Rotated 148 x 100 mm */
    wxPAPER_DBL_JAPANESE_POSTCARD_ROTATED,/* Double Japanese Postcard Rotated 148 x 200 mm */
    wxPAPER_A6_ROTATED,         /* A6 Rotated 148 x 105 mm */
    wxPAPER_JENV_KAKU2_ROTATED, /* Japanese Envelope Kaku #2 Rotated */
    wxPAPER_JENV_KAKU3_ROTATED, /* Japanese Envelope Kaku #3 Rotated */
    wxPAPER_JENV_CHOU3_ROTATED, /* Japanese Envelope Chou #3 Rotated */
    wxPAPER_JENV_CHOU4_ROTATED, /* Japanese Envelope Chou #4 Rotated */
    wxPAPER_B6_JIS,             /* B6 (JIS) 128 x 182 mm */
    wxPAPER_B6_JIS_ROTATED,     /* B6 (JIS) Rotated 182 x 128 mm */
    wxPAPER_12X11,              /* 12 x 11 in */
    wxPAPER_JENV_YOU4,          /* Japanese Envelope You #4 */
    wxPAPER_JENV_YOU4_ROTATED,  /* Japanese Envelope You #4 Rotated */
    wxPAPER_P16K,               /* PRC 16K 146 x 215 mm */
    wxPAPER_P32K,               /* PRC 32K 97 x 151 mm */
    wxPAPER_P32KBIG,            /* PRC 32K(Big) 97 x 151 mm */
    wxPAPER_PENV_1,             /* PRC Envelope #1 102 x 165 mm */
    wxPAPER_PENV_2,             /* PRC Envelope #2 102 x 176 mm */
    wxPAPER_PENV_3,             /* PRC Envelope #3 125 x 176 mm */
    wxPAPER_PENV_4,             /* PRC Envelope #4 110 x 208 mm */
    wxPAPER_PENV_5,             /* PRC Envelope #5 110 x 220 mm */
    wxPAPER_PENV_6,             /* PRC Envelope #6 120 x 230 mm */
    wxPAPER_PENV_7,             /* PRC Envelope #7 160 x 230 mm */
    wxPAPER_PENV_8,             /* PRC Envelope #8 120 x 309 mm */
    wxPAPER_PENV_9,             /* PRC Envelope #9 229 x 324 mm */
    wxPAPER_PENV_10,            /* PRC Envelope #10 324 x 458 mm */
    wxPAPER_P16K_ROTATED,       /* PRC 16K Rotated */
    wxPAPER_P32K_ROTATED,       /* PRC 32K Rotated */
    wxPAPER_P32KBIG_ROTATED,    /* PRC 32K(Big) Rotated */
    wxPAPER_PENV_1_ROTATED,     /* PRC Envelope #1 Rotated 165 x 102 mm */
    wxPAPER_PENV_2_ROTATED,     /* PRC Envelope #2 Rotated 176 x 102 mm */
    wxPAPER_PENV_3_ROTATED,     /* PRC Envelope #3 Rotated 176 x 125 mm */
    wxPAPER_PENV_4_ROTATED,     /* PRC Envelope #4 Rotated 208 x 110 mm */
    wxPAPER_PENV_5_ROTATED,     /* PRC Envelope #5 Rotated 220 x 110 mm */
    wxPAPER_PENV_6_ROTATED,     /* PRC Envelope #6 Rotated 230 x 120 mm */
    wxPAPER_PENV_7_ROTATED,     /* PRC Envelope #7 Rotated 230 x 160 mm */
    wxPAPER_PENV_8_ROTATED,     /* PRC Envelope #8 Rotated 309 x 120 mm */
    wxPAPER_PENV_9_ROTATED,     /* PRC Envelope #9 Rotated 324 x 229 mm */
    wxPAPER_PENV_10_ROTATED,    /* PRC Envelope #10 Rotated 458 x 324 m */
    wxPAPER_A0,                 /* A0 Sheet 841 x 1189 mm */
    wxPAPER_A1                  /* A1 Sheet 594 x 841 mm */
}

/* Printing orientation */
// enum wxPrintOrientation
const int  wxPORTRAIT   = 1;
const int  wxLANDSCAPE  = 2;


// enum wxDuplexMode
const int  wxDUPLEX_SIMPLEX     = 0; /*  Non-duplex */
const int  wxDUPLEX_HORIZONTAL  = 1;
const int  wxDUPLEX_VERTICAL    = 2;


const int  wxPRINT_QUALITY_HIGH    = -1;
const int  wxPRINT_QUALITY_MEDIUM  = -2;
const int  wxPRINT_QUALITY_LOW     = -3;
const int  wxPRINT_QUALITY_DRAFT   = -4;

// enum wxPrintMode
const int  wxPRINT_MODE_NONE     = 0;
const int  wxPRINT_MODE_PREVIEW  = 1;   /*  Preview in external application */
const int  wxPRINT_MODE_FILE     = 2;   /*  Print to file */
const int  wxPRINT_MODE_PRINTER  = 3;   /*  Send to printer */
const int  wxPRINT_MODE_STREAM   = 4;   /*  Send postscript data into a stream */


// enum wxUpdateUI
const int  wxUPDATE_UI_NONE      = 0x0000;
const int  wxUPDATE_UI_RECURSE   = 0x0001;
const int  wxUPDATE_UI_FROMIDLE  = 0x0002; /*  Invoked from On(Internal)Idle */


// Dialogs are created in a special way
const int  wxTOPLEVEL_EX_DIALOG     =  0x00000008;


// Also see the bit summary table in wx/toplevel.h.
const int  wxFRAME_NO_TASKBAR                  = 0x0002;  // No taskbar button (MSW only)
const int  wxFRAME_TOOL_WINDOW                 = 0x0004;  // No taskbar button, no system menu
const int  wxFRAME_FLOAT_ON_PARENT             = 0x0008;  // Always above its parent



const int  wxDIALOG_NO_PARENT                  = 0x00000020;  // Don't make owned by apps top window

const int  wxDEFAULT_DIALOG_STYLE              = (wxCAPTION | wxSYSTEM_MENU | wxCLOSE_BOX);

// Layout adaptation levels, for SetLayoutAdaptationLevel

// Don't do any layout adaptation
const int  wxDIALOG_ADAPTATION_NONE            = 0;

// Only look for wxStdDialogButtonSizer for non-scrolling part
const int  wxDIALOG_ADAPTATION_STANDARD_SIZER  = 1;

// Also look for any suitable sizer for non-scrolling part
const int  wxDIALOG_ADAPTATION_ANY_SIZER       = 2;

// Also look for 'loose' standard buttons for non-scrolling part
const int  wxDIALOG_ADAPTATION_LOOSE_BUTTONS   = 3;

// Layout adaptation mode, for SetLayoutAdaptationMode
const int  wxDIALOG_ADAPTATION_MODE_DEFAULT    = 0;   // use global adaptation enabled status
const int  wxDIALOG_ADAPTATION_MODE_ENABLED    = 1;   // enable this dialog overriding global status
const int  wxDIALOG_ADAPTATION_MODE_DISABLED   = 2;   // disable this dialog overriding global status

// enum wxDialogModality
const int  wxDIALOG_MODALITY_NONE              = 0;
const int  wxDIALOG_MODALITY_WINDOW_MODAL      = 1;
const int  wxDIALOG_MODALITY_APP_MODAL         = 2;

