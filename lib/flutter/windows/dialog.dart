// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxDialog ----------------------

/// WxDialos a is toplevel window that usually asks the user for some input - although it can be informational only.
/// 
/// Different from a [WxFrame], a [WxDialog] is usually used modally, i.e. when the dialog is shown
/// using [showModal], no other window or frame on screen can receive any input such as mouse clicks.
/// 
/// On small mobile devices, dialogs can be implemented either as a sheet appearing from the bottom
/// or a window filling out most of the screen.
/// 
/// [WxDialog] provides a way to place standard buttons at the bottom of the dialog and their
/// ordering will be done in platform dependent way, using the [createStdDialogButtonSizer] method.
/// 
/// wxDart (Flutter and Native) uses events ([WxInitDialogEvent] and [WxDialogValidateEvent])
/// to inform about when to transfer data to/from the dialog and when to validate input (see below).
/// 
/// Dialogs are most often closed with a button having a standard id like [wxID_OK] or [wxID_CANCEL]
/// and this is returned to the calling code for information. The return value from WxDialog.showModal()
/// is retrieved through a callback function.
/// ```dart
///     void showSomeDialog()
///     {
///       final dialog = MyDialog(this);
///       dialog.showModal( (ret, data) {
///         if (ret == wxID_OK) {
///           // Pressed OK
///         } else {
///           // Cancelled dialog
///         }
///       });
///     }
/// ```
/// 
/// If the return value is not relevant, you can pass null to [showModal]:
/// 
/// ```dart
///     void showSomeDialog()
///     {
///       final dialog = MyDialog(this);
///       dialog.showModal(null);
///     }
/// ```
/// [showModal] will also destroy the dialog, so you cannot call [showModal] twice.
/// 
/// Here is a simple example
/// 
/// ```dart
/// class MyDialog extends WxDialog {
///   MyDialog( super.parent, super.id, super.title, String data ) 
///   {
///     // create main sizer 
///     final mainSizer = WxColumn();
/// 
///     // and tell dialog to actually use it
///     setSizer( mainSizer );
/// 
///     // create text field
///     final text = WxTextCtrl( this, -1, style: wxTE_MULTILINE );
///     // and tell main sizer to make it stretch and have a border
///     mainSizer.add( text, border: 5, flag: wxALL|wxEXPAND, proportion: 1 );
/// 
///     // create OK and Cancel buttons
///     final buttons = createStdDialogButtonSizer( wxOK|wxCANCEL );
///     mainSizer.addSizer( buttons, flags: wxALL|wxALIGN_RIGHT );
/// 
///     // Transfer data to the dialog (controls). In many cases
///     // this can also be done when creating the control 
///     bindInitDialogEvent( (_) {
///       text.setValue( data );
///     });
///
///     // Validate entered data and transfer it somewhere if OK
///     bindDialogValidateEvent( (event) {
///       final newdata = text.getValue();
///       // do some test on newdata
///       if (newdata.length > 17) {
///         // text too long! veto event (don't allow to close the dialog)
///         event.veto();
///         return;
///       } else {
///         // data looks good, transfer data back
///         data = newdata;
///       }
///     }, -1); 
///   }
/// }
/// ``` 
/// 
/// 

class WxDialog extends WxTopLevelWindow {
  /// Creates a dialog with the given [id] and [title].
  /// 
  /// It will also install event handlers for default dialog buttons.
  WxDialog( super.parent, super.id, super.title, { super.pos, super.size, super.style = wxDEFAULT_DIALOG_STYLE } )
  {
    bindButtonEvent( _onButton, wxID_YES );
    bindButtonEvent( _onButton, wxID_NO );
    bindButtonEvent( _onButton, wxID_OK );
    bindButtonEvent( _onButton, wxID_APPLY );
    bindButtonEvent( _onButton, wxID_CANCEL );
  }

  int _retCode = 0;
  int _affirmativeId = wxID_OK;
  int _escapeId = wxID_CANCEL;
  bool _isModal = false;
  bool _hasSentInitEvent = false;
  int _buttonFlags = 0;
  bool _synchronous = false;
  void Function( int, dynamic )? _onReturn;
  
  /// Returns ID that closes the dialog with user indicating to accept the
  /// input (like hitting OK). 
  /// 
  /// Default is wxID_OK.
  int getAffirmativeId() {
    return _affirmativeId;
  }

  /// Sets ID that closes the dialog like hitting OK. Default is wxID_OK.
  void setAffirmativeId( int id ) {
    _affirmativeId = id;
  }

  /// Returns ID that closes the dialog like hitting ESC.
  /// 
  /// Default is wxID_CANCEL.
  int getEscapeId() {
    return _escapeId;
  }
  /// Sets ID that closes the dialog like hitting ESC. Default is wxID_CANCEL.
  void setEscapeId( int id ) {
    _escapeId = id;
  }

  /// Returns a sizer with buttons in a platform dependent order
  /// and layout. For possible values of [flag], see [createStdDialogButtonSizer]
  WxSizer createButtonSizer( int flags ) {
    return createStdDialogButtonSizer( flags );
  }

  WxSizer createSeparatedButtonSizer( int flags ) {
    return createStdDialogButtonSizer( flags );
  }

  /// Returns a [WxSizer] containing a horizontal element
  /// separating logical groups in a platform dependent way.
  /// It may return the incoming [sizer] unchanged.
  WxSizer createSeparatedSizer( WxSizer sizer ) {
    return sizer;
  }

/// Returns a sizer with standard dialotg buttons in a platform dependent order
/// and layout. For possible values of [flag], see [createStdDialogButtonSizer]
/// and sets the respective affirmative and escape IDs that close the dialog,
/// 
/// # flag 
/// [ constant | value |
/// | -------- | -------- |
/// | wxYES | button with id wxID_YES |
/// | wxNO | button with id wxID_NO |
/// | wxYES_NO | 2 button with id wxID_NO and wxID_YES |
/// | wxOK | button with id wxID_OK |
/// | wxCANCEL | button with id wxID_CANCEL |
/// | wxAPPLY | button with if wxID_APPLY |
/// | wxHELP | button with if wxID_HELP |
  WxSizer createStdDialogButtonSizer( int flags )
  {
    _buttonFlags = flags;
    WxBoxSizer sizer = WxBoxSizer( wxHORIZONTAL );
    if ((flags & wxHELP) != 0) {
      sizer.add( WxButton(this, wxID_HELP, "Help"), flag: wxALL, border: 10  );
      sizer.addStretchSpacer();
    } else {
      sizer.addStretchSpacer();
    }
    if ((flags & wxYES) != 0) {
      _affirmativeId = wxID_YES;
      sizer.add( WxButton(this, wxID_YES, "Yes" ), flag: wxALL, border: 10 );
    }
    if ((flags & wxNO) != 0) {
      _escapeId = wxID_NO;
      sizer.addSpacer(30);
      sizer.add( WxButton(this, wxID_NO, "No"), flag: wxALL, border: 10 );
    }
    if ((flags & wxOK) != 0) {
      sizer.add( WxButton(this, wxID_OK, "Ok" ), flag: wxALL, border: 10 );
    }
    if ((flags & wxAPPLY) != 0) {
      _affirmativeId = wxID_APPLY;
      sizer.addSpacer(30);
      sizer.add( WxButton(this, wxID_APPLY, "Apply"), flag: wxALL, border: 10 );
    }
    if ((flags & wxCANCEL) != 0) {
      sizer.addSpacer(30);
      sizer.add( WxButton(this, wxID_CANCEL, "Cancel"), flag: wxALL, border: 10 );
    }
    return sizer;
  }

  /// Returns a [WxSizer] containing a text message in a platform dependant way.
  WxSizer createTextSizer( String message ) {
    final ret = WxBoxSizer( wxVERTICAL );
    ret.add( WxStaticText( this, -1, message, style: wxST_WRAP  ) );
    return ret;
  }

  /// Returns the return code of the dialog once it has been closed. 
  /// The return code is the ID of the button that closed the dialog,
  /// often either of [wxID_OK] or [wxID_CANCEL].
  /// 
  /// For modal dialogs, the way to be informed about the return
  /// code is via the callback given to [showModal]
  int getReturnCode( ) {
    return _retCode;
  }

  /// Destroy the window. This will happen in a deferred way.
  @override
  bool destroy() {
    _isBeingDeleted = true;
    if (_parent != null) {
      _parent!.removeChild(this);
    }
    // SystemNavigator.pop();
    _topLevelWindows.remove( this );
    return true;
  }

  void _onButton( WxCommandEvent event ) 
  {
    final id = event.getId();
    if (id == getAffirmativeId())
    {
      final wxevent = WxDialogValidateEvent( id: getId() );
      wxevent.setEventObject( this );
      processEvent( wxevent );
      if (wxevent.isAllowed()) {
        _endDialog( id );
      }
    } else 
    if (id == wxID_APPLY) {
      final wxevent = WxDialogValidateEvent( id: getId() );
      wxevent.setEventObject( this );
      processEvent( wxevent );
    } else 
    if (id == getEscapeId()) {
      _endDialog( id );
    }
  }

  void _endDialog( int retCode ) {
    if (_isModal) {
      endModal( retCode );
    } else {
      // ???
    }
  }

  /// Returns true if the dialog is a modal dialog (blocking input
  /// to all other windows)
  bool isModal() {
    return _isModal;
  }

  /// Closes the modal dialog with the given [retCode]. The code that
  /// created and showed the dialog will be informed about this
  /// return code via the callback given to [showModal]
  void endModal( int retCode ) {
    _retCode = retCode;
    BuildContext? parentContext = _navigatorKey.currentContext;
    if (parentContext != null) {
      Navigator.pop(parentContext);
    }
    _isModal = false;
    if (_synchronous)
    {
      if (_onReturn != null) {
        _onReturn!( _retCode, null );
      }
      destroy();
    }
  }

  Widget _buildTitleBar()
  {
    final p = wxTheApp.getPrimaryAccentColour();
    Color accent = Color.fromARGB( p.alpha, p.red, p.green, p.blue );

    Widget titleBar = 
          MouseRegion(
            cursor: SystemMouseCursors.grab,
            child:
            Padding(
              padding: EdgeInsets.only( right: 30 ),
              child: 
              Container(
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(22.0),
                    topRight: Radius.circular(22.0),
                  ), 
                ),
                child: Padding( 
                  padding: EdgeInsets.all(3),
                  child: Center( child: Text( _title ) ) )
          )  )                           
      );

    return titleBar;
  }

  Widget _buildTitleBarTouch()
  {
    final p = wxTheApp.getPrimaryAccentColour();
    Color accent = Color.fromARGB( p.alpha, p.red, p.green, p.blue );

    Widget titleBar = 
          MouseRegion(
            cursor: SystemMouseCursors.grab,
            child:
              Container(
                decoration: (hasFlag(wxCAPTION)) ? BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ), 
                ) : null,
                child: Padding( 
                  padding: EdgeInsets.all(3),
                  child: Center( child: 
                    Text( _title, style: TextStyle( color: wxTheApp.isDark() ? Colors.white : Colors.black)  ) ) )
          )                           
      );

    return titleBar;
  }

  bool _isNumberOfAncestorGreaterThan( WxWindow current, int number, int start )
  {
    start++;
    if (start > number) return true;
    for (final child in current._children)
    {
      if (!child.isShown()) continue;
      if (child is WxTopLevelWindow) continue;
      if (child is WxButton) continue;
      if (_isNumberOfAncestorGreaterThan(child, number,start)) return true;
    }

    return false;
  }

  void showModal( void Function( int, dynamic )? onReturn )
  {
    if (wxTheApp.isTouch() && _isNumberOfAncestorGreaterThan(this,4,0))
    {
      final ok = findWindow( wxID_OK );
      if (ok != null) {
        ok.hide();
      }
      final cancel = findWindow( wxID_CANCEL );
      if (cancel != null) {
        cancel.hide();
      }
      final apply = findWindow( wxID_APPLY );
      if (apply != null) {
        apply.hide();
      }
      _isModal = true;
      _synchronous = true;
      _onReturn = onReturn;
          if (!_hasSentInitEvent)
            {
              final event = WxInitDialogEvent( id: getId() );
              event.setEventObject( this );
              processEvent( event );
              _hasSentInitEvent = true;
            }
      super.show();
      return;
    }

    _showModalAsync().then( (id) {
      if (onReturn != null) {
        onReturn( id, null );
      }
    });
    destroy();
  }

  Future<int> _showModalAsync( ) async
  {
    BuildContext? parentContext = _navigatorKey.currentContext;
    if (parentContext == null) {
      return wxID_CANCEL;
    } 
    _isModal = true;

    if (wxTheApp.isTouch())
    {
      final double screenWidth = MediaQuery.sizeOf(parentContext).width;
      double windowWidth = screenWidth-10;

      await showModalBottomSheet<void>(
          context: parentContext,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (BuildContext context)
          {
          if (!_hasSentInitEvent)
            {
              final event = WxInitDialogEvent( id: getId() );
              event.setEventObject( this );
              processEvent( event );
              _hasSentInitEvent = true;
            }
            return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15.0),
                        topLeft: Radius.circular(15.0)),
                    color: wxTheApp.isDark() ? Colors.grey[800] : Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withAlpha(80),
                          spreadRadius: 0,
                          blurRadius: 8,
                          offset: Offset(0, 4))
                    ]),
                width: windowWidth,
                // height: windowHeight,
                child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildTitleBarTouch(),
                        _initialSize.y == -1 
                          ? super._build(context)
                          : SizedBox( height: _initialSize.y.toDouble(), child: super._build(context) ),
//                          : Expanded( child: super._build(context) ),
                        SizedBox(height:30)
                      ]
                    )
                    
                    ));
          }).whenComplete( () {
            if (_retCode == 0) {
              _retCode = wxID_CANCEL;
            }
          }); 
      return _retCode;
    }


    await showDialog( 
      context: parentContext, 
      barrierDismissible: true,
      builder: (BuildContext context)
      {
          if (!_hasSentInitEvent)
          {
            final event = WxInitDialogEvent( id: getId() );
            event.setEventObject( this );
            processEvent( event );
            _hasSentInitEvent = true;
          }
          return  
            FloatingDialog(
              onClose:() {
                _endDialog( wxID_CANCEL );
              },
              child: SizedBox(
                width: _initialSize.x == -1 ? 500 : _initialSize.x.toDouble(),
                height: _initialSize.y == -1 ? null : _initialSize.y.toDouble(),
                child: 
                Padding(
                  padding: EdgeInsets.all(5),
                  child: _title.isEmpty 
                    ? super._build(context) 
                    : Column( 
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row( 
                          mainAxisSize: MainAxisSize.max,
                          children:[
                            Expanded( 
                              child: _buildTitleBar(),
                            ) 
                          ] 
                        ), 
                        Expanded( child: Row( 
                          children:[
                            Expanded( 
                              child: 
                                Container( 
                                  child: super._build(context) )
                            )
                          ]
                        ) )
                      ]
                    )
                )
              )
            );

                  }
      ).whenComplete(() {
          if (_retCode == 0) {
            _retCode = wxID_CANCEL;
          }
        
      },); 
    
    return _retCode;
  }

  @override
  Widget _build(BuildContext context)
  {
    List<Widget> actions = [];
    if ((_buttonFlags & wxOK) != 0)
    {
      actions.add( TextButton( 
              child: Text( "Ok" ),
              onPressed: () {
                WxCommandEvent event = WxCommandEvent( wxGetButtonEventType(), wxID_OK );
                event.setEventObject( this );
                processEvent( event ); 
              }
            ));
    }
    if ((_buttonFlags & wxAPPLY) != 0)
    {
      actions.add( TextButton( 
              child: Text( "Apply" ),
              onPressed: () {
                WxCommandEvent event = WxCommandEvent( wxGetButtonEventType(), wxID_APPLY );
                event.setEventObject( this );
                processEvent( event ); 
              }
            ));
    }
    return Scaffold(
      appBar: AppBar(  
        title: Text(_title),
        actions: actions.isEmpty ? null : actions,
      ),
      body: _doBuildChildrenWithOrWithoutSizer( context ),
    );
  }
}
