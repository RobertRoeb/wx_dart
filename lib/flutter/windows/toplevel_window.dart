// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxNonOwnedWindow ----------------------

/// Base class for [WxTopLevelWindow] and a future, frameless WxPopUpWindow

class WxNonOwnedWindow extends WxWindow {
  WxNonOwnedWindow( WxWindow? parent, int id, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = 0 } ) 
    : super( parent, id, pos, size, style );
    
}

// ------------------------- wxTopLevelWindow ----------------------

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

/// Base class for [WxDialog] and [WxFrame]
/// 
/// This class defined the interface of the window with the window manager.
/// Many of the functions in this class are not available in wxDart Flutter
/// and do not make sense on mobile devices or in a web browser.
/// 
/// 
/// ## flag constants
/// | constant | value  |
/// | -------- | -------- |
/// | wxSTAY_ON_TOP | 0x8000 |
/// | wxCLOSE_BOX | 0x1000 |
/// | wxSYSTEM_MENU | 0x0800 |
/// | wxMINIMIZE_BOX | 0x0400 |
/// | wxMAXIMIZE_BOX | 0x0200 |
/// | wxTINY_CAPTION | 0x0080 |
/// | wxRESIZE_BORDER | 0x0040 |

class WxTopLevelWindow extends WxNonOwnedWindow {
  /// Creates a toplevel window. Don't use this class directly, use [WxFrame] or [WxDialog] instead.
  WxTopLevelWindow( super._parent, super._id, this._title, { super.pos = wxDefaultPosition, super.size = wxDefaultSize, super.style = wxDEFAULT_FRAME_STYLE } )
  {
    _topLevelWindows.add( this );

    _isTouch = wxTheApp.isTouch();

    bindSysColourChangedEvent( (_) {
      _recursiveSendSysColourChangedEvent( this );
    } );
  }

  void _recursiveSendSysColourChangedEvent( WxWindow current )
  {
    for (final child in current.getChildren()) {
      if (child is WxTopLevelWindow) continue;
      final event = WxSysColourChangedEvent( id: child.getId() );
      event.setEventObject( child );
      child.processEvent( event );
      _recursiveSendSysColourChangedEvent( child );
    }
  }

  /// Used internally
  @override
  void onInternalIdle()
  {
    super.onInternalIdle();
    if (wxTheApp.isTouch() != _isTouch)
    {
      _isTouch = wxTheApp.isTouch();
      _recursiveSendSysColourChangedEvent( this );
    }
  }

  String _title;
  bool _isBeingDeleted = false;
  bool _hasRequestedMoreIdleEvents = false;
  bool _isTouch = false;
  bool _isFullScreen = false;
  int _fullScreenFlags = 0;

  /// Shows window, or hides it if [show] is false.
  @override
  void show( { bool show = true } ) {
    if (_parent == null) {
      super.show( show: show );
      return;
    }

    if (show) {
      BuildContext? parentContext = _navigatorKey.currentContext;
      if (parentContext != null) {
        Navigator.push(parentContext, MaterialPageRoute(
           builder: (BuildContext context) => _build(context) ) );
      }
    } else {
      BuildContext? parentContext = _navigatorKey.currentContext;
      if (parentContext != null) {
        _isBeingDeleted = true;
        Navigator.pop(parentContext);
        _parent!._children.remove(this);
      }
    }
    _hidden != show;
    _setState();
  }

  /// Hide window
  @override
  void hide() {
    show( show: false );
  }

  /// Sets the title of the window, usually displayed above the window.
  void setTitle( String title ) {
    _title = title;
    _setState();
  }

  /// Returns the title of the window
  String getTitle() {
    return _title;
  }

  /// Destroys the window and removes it from the list of child
  /// windows from the parent window, if any.
  /// 
  /// Deletion may occur in a deferred way, not immediately.
  @override
  bool destroy()
  {
    _isBeingDeleted = true;
    if (_parent != null)
    {
      _parent!.removeChild(this);

      BuildContext? parentContext = _navigatorKey.currentContext;
      if (parentContext != null) {
        Navigator.pop(parentContext);
      }
    }
    else
    {
      SystemNavigator.pop();
    }

    _topLevelWindows.remove( this );
    return true;
  }

  /// Returns true if this toplevel window has been scheduled for deletion
  /// 
  /// Toplevel windows do not get deleted immediately.
  bool isBeingDeleted() {
    return _isBeingDeleted;
  }

  /// Requests to close the window. Don't allow a veto if [force] is true.
  void close( bool force )
  {
    WxCloseEvent event = WxCloseEvent( wxGetCloseWindowEventType(), id: getId() );
    event.setCanVeto(force);
    processEvent(event);
  }

  // Returns the position of the window on screen. This is unsupported
  // in wxDart Flutter.
  @override
  WxPoint getPosition() {
    return WxPoint( _position.x, _position.y );
  }

  // Set the position of the window on screen. This is unsupported
  // in wxDart Flutter.
  @override
  void setPosition( WxPoint pos ) {
  }

  /// Brings window to the top (among its window siblings)
  @override
  void raise()
  {
  }

  /// Brings window to the back (among its window siblings)
  @override
  void lower()
  {
  }

  /// Instructs window manager to set minimum size of toplevel window.
  /// 
  /// This will not have any effect on mobile devices and the web.
  void setMinSize( WxSize minSize )
  {
    if (theTLW == this) {
      DesktopWindow.setMinWindowSize(Size(minSize.x.toDouble(), minSize.y.toDouble()));
    }
  }

  /// Instructs window manager to set maximum size of toplevel window.
  /// 
  /// This will not have any effect on mobile devices and the web.
  void setMaxSize( WxSize maxSize )
  {
    if (theTLW == this) {
      DesktopWindow.setMaxWindowSize(Size(maxSize.x.toDouble(), maxSize.y.toDouble()));
    }
  }

  /// Set the size of the window on screen. 
  /// 
  /// This will not have any effect on mobile devices and the web.
  @override
  void setSize( WxSize size )
  {
    if (theTLW == this) {
      DesktopWindow.setWindowSize(Size(size.x.toDouble(), size.y.toDouble()));
    }
  }

  /// Returns true if window supports transparency
  /// 
  /// see [setTransparent]
  bool canSetTransparent( ) {
    return false;
  }

  /// Makes window transparent with the given [alpha] value if it 
  /// supports transparency
  void setTransparent( int alpha ) {
  }

  /// wxDart Native: centre window on screen
  void centreOnScreen( int direction ) {
  }

  /// Maximizes window
  /// 
  /// Not supported in wxDart Flutter
  void maximize() 
  {
  }

  /// Minimizes window
  /// 
  /// Not supported in wxDart Flutter
  void minimize() 
  {
  }

  /// wxDart Native: restores window if it was iconized or maximized
  /// 
  /// Not supported in wxDart Flutter
  void restore() 
  {
  }

  /// Returns true if this window is expected to be always maximized, 
  /// either due to platform policy or due to local policy regarding particular class.
  bool isAlwaysMaximized() {
    return true;
  }

/// Request to go into or leave fullscreen mode. Depending on the flags used,
/// this will hide menu, toolbar and titlebar- on contrast to [maximize].
/// 
/// ## flag constants
/// | constant | value (meaning) |
/// | -------- | -------- |
/// | wxFULLSCREEN_NOMENUBAR | 0x0001 |
/// | wxFULLSCREEN_NOTOOLBAR | 0x0002 |
/// | wxFULLSCREEN_NOSTATUSBAR | 0x0004 |
/// | wxFULLSCREEN_NOBORDER | 0x0008 |
/// | wxFULLSCREEN_NOCAPTION | 0x0010 |
/// | wxFULLSCREEN_ALL | all of them |
  void showFullScreen( { bool enable = true, int flags = wxFULLSCREEN_ALL } )
  {
    if (theTLW == this) {
      DesktopWindow.setFullScreen( enable );
      _isFullScreen = true;
      _fullScreenFlags = enable ? flags : 0;
    }
  }

  /// Returns true is the window is in full screen
  bool isFullScreen()
  {
    return _isFullScreen;
  }

  /// wxDart Native: request user attention
  void requestUserAttention( { int flags = wxUSER_ATTENTION_INFO } )
  {
    if (theTLW == this) {
      DesktopWindow.focus();
    }
  }

/// wxDart Native: enables fullscreen window button on macOS
/// 
/// ## flag constants
/// | constant | value (meaning) |
/// | -------- | -------- |
/// | wxFULLSCREEN_NOMENUBAR | 0x0001 |
/// | wxFULLSCREEN_NOTOOLBAR | 0x0002 |
/// | wxFULLSCREEN_NOSTATUSBAR | 0x0004 |
/// | wxFULLSCREEN_NOBORDER | 0x0008 |
/// | wxFULLSCREEN_NOCAPTION | 0x0010 |
/// | wxFULLSCREEN_ALL | all of them |
  bool enableFullScreenView( { bool enable = true, int flags = wxFULLSCREEN_ALL } )
  {
    return false;
  }

  /// wxDart Native: enables or disables close button
  bool enableCloseButton( bool enable ) {
    return false;
  }

  /// wxDart Native: enables or disables maximize button
  bool enableMaximizeButton( bool enable ) {
    return false;
  }

  /// wxDart Native: enables or disables minimize button
  bool enableMinimizeButton( bool enable ) {
    return false;
  }

  /// Returns button that gets triggered if ENTER is hit
  /// or null if unknown
  WxWindow? getDefaultItem( ) {
    return null;
  }

  Widget _buildTLW( BuildContext context, Widget child ) {
    final finalWidget = IdleDetector(
      onIdle: () {
        _hasRequestedMoreIdleEvents = false;
        _callRecursiveOnInternalIdle( this );
        if (_hasRequestedMoreIdleEvents) {
          // TODO, we cannot do this forever
          _hasRequestedMoreIdleEvents = false;
          _callRecursiveOnInternalIdle( this );
        }
      },
      idleTime: Duration(milliseconds: 0), 
      child: child );
    return finalWidget;
  }

  void _callRecursiveOnInternalIdle( WxWindow window )
  {
    for (final child in window.getChildren()) {
      if (child is! WxTopLevelWindow) {
        _callRecursiveOnInternalIdle(child);
      }
    }
    window.onInternalIdle();
    final event = WxIdleEvent( id: getId() );
    event.setEventObject( window );
    window.processEvent(event);
    if (event.moreRequested()) {
      _hasRequestedMoreIdleEvents = true;
    }
  }
}

