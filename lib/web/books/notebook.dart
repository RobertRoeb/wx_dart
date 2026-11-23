// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01 (wxDart Web: 2026-11-15)
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxNotebookEvent ----------------------

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
const int wxNB_ANIMATED_THEME = 0x1000;

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
///     // bind to notebook change
///     notebook.bindNotebookPageChangedEvent( (event) {
///       // do something when page changed
///     }, -1 );
/// 
///     // validate data and if ok, transfer data from the dialog
///     bindDialogValidateEvent( (_) {
///     }, -1); 
///   }
///```
///
/// Page interface
/// * [addPage]
/// * [insertPage]
/// * [findPage]
/// * [getPage]
/// * [deletePage]
/// * [deleteAllPages]
/// * [findPage]
/// 
/// Image interface
/// * [setImages]
/// * [hasImages]
/// * [getImageCount]
/// 
/// Title interface
/// * [setPageText]
/// * [getPageText]
/// 
/// Selection interface
/// * [setSelection]
/// * [getSelection]
/// * [getCurrentPage]
/// 
/// # Events emitted
///
/// [NotebookPageChanged](/wxdart/wxGetNotebookPageChangedEventType.html) event gets sent when the changed the page |
/// | ----------------- |
/// | void bindNotebookPageChangedEvent( void Function( WxNotebookEvent event ), int id ) |
/// | void unbindNotebookPageChangedEvent() |
/// 
/// Only in wxDart Native:
/// [NotebookPageChanging](/wxdart/wxGetNotebookPageChangingEventType.html) event gets sent when user is wished to change the page |
/// | ----------------- |
/// | void bindNotebookPageChangingEvent( void Function( WxNotebookEvent event ), int id ) ) |
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
/// | wxNB_ANIMATED_THEME | 0x1000 (only wxDart Flutter) |

class WxNotebook extends WxBookCtrlBase {
  WxNotebook( super.parent, super.id, { super.pos = wxDefaultPosition, super.size = wxDefaultSize, super.style = 0 } );

  @override
  int get _changingEventType => wxGetNotebookPageChangingEventType();
  @override
  int get _changedEventType => wxGetNotebookPageChangedEventType();
}
