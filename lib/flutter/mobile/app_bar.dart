// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ----------------------------- WxAppBar ---------------------------

const int wxAB_FLEXIBLE = 0x0200;
const int wxAB_PINNED = 0x0400;
const int wxAB_DEFAULT_STYLE = wxAB_FLEXIBLE;

/// Specialized toolbar that is used in smartphone apps.
/// 
/// It usually has a small number of text only buttons (add
/// using [addAction]) and a small number of bitmap-only buttons (add using [WxToolBar.addTool]).
/// 
/// A [WxAppBar] can be logically attached to a [WxScrolledWindow] so that they
/// scroll together (fade away when scrolling up, fade to front when scrolling down).
/// 
///```dart 
///class MyMobileFrame extends WxAdaptiveFrame {
///  MyMobileFrame( WxWindow ?parent ) 
///  : super( parent, -1, "Cool app", size: WxSize( 800, 600 ) )
///  {
///    // Let frame create appbar
///    final appBar = createAppBar( "Mobile Demo", style: 0);
///
///    // Add "About" text only action/button 
///    appBar.addAction( idAbout, "About" );
///
///    // Like for WxToolBar, call realize() at the end.
///    appBar.realize();
///
///    // Close if requested
///    bindMenuEvent( (_) => close(false), wxID_EXIT );
///    bindCloseWindowEvent( (_) => destroy() );
///
///    // Create main navigation control
///    final navi = WxNavigationCtrl(this,-1);
///
///    // Image list for navigation control with "home" button
///    List<WxBitmapBundle> images = [];
///    images.add( WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.home, WxSize(30,30) ) );
///    navi.setImages(images);
///
///    // Create main window
///    final home = MyScrolledWindow( navi );
///
///    // Add main window to navigation control
///    navi.addPage(home, "Home", image: 0);
///
///    // Connect scrolling of home to appbar to make it disappear
///    appBar.attach( home );
///  }
///}
///```
///
/// # Appbar window styles
/// | constant | value |
/// | -------- | -------- |
/// | wxAB_FLEXIBLE | 0x0200 (when attached to a scrollwindow, make it bigger) |
/// | wxAB_PINNED | 0x0400 (when attached to a scrollwindow, don't disappear )|
/// | wxAB_DEFAULT_STYLE | wxAB_FLEXIBLE |

class WxAppBar extends WxToolBar {
/// Creates app bar with a title. Usually done from [WxAdaptiveFrame.createAppBar]
/// 
/// ## Appbar window styles
/// | constant | value |
/// | -------- | -------- |
/// | wxAB_FLEXIBLE | 0x0200 (when attached to a scrollwindow, make it bigger) |
/// | wxAB_PINNED | 0x0400 (when attached to a scrollwindow, don't disappear )|
/// | wxAB_DEFAULT_STYLE | wxAB_FLEXIBLE |
  WxAppBar( super.parent, super.id, String title, { super.pos, super.size, super.style = wxAB_DEFAULT_STYLE } ) {
    _appBarTitle = title;
  }

  bool _isAttached = false;
  String _appBarTitle = "";

  /// Adds a text only button/action to the appbar. You would typically
  /// only have one or two of these
  WxToolBarToolBase addAction( int id, String label, { String shortHelp = "" } ) {
    final tool = WxToolBarToolBase();
    tool._id = id;
    tool._label = label;
    tool._kind = wxITEM_NORMAL;
    tool._shortHelp = shortHelp;
    _updateBitmaps( tool );
    _tools.add( tool );
    return tool;
  }
  /// Attaches the app bar logically to a [WxScrolledWindow] with the [wxVSCROLL] style 
  /// so that they scroll together (fade away when scrolling up, fade to front when
  /// scrolling down). This is a popular UI feature on smartphones.
  /// 
  /// An app bar can be attached to several [WxScrolledWindow]s, e.g. if they are
  /// different pages of a [WxNavigationCtrl].
  void attach( WxScrolledWindow window ) {
    if (!window.hasFlag(wxVSCROLL)) {
      wxLogError( "WxAppBar can only be attached to a WxScrolledWindow with the wxVSCROLL style" );
      return;
    }
    _isAttached = true;
    window._scrollTargetWindow._setSliverView( this );
  }

  List<Widget> _buildActionsFromAppBar()
  {
    List<Widget> actions = [];
      for (int i = 0; i < getToolsCount(); i++)
      {
        final tool = getToolByPos( i );
        if (tool != null)
        {
          if (tool.getLabel().isNotEmpty)
          {
            actions.add( TextButton( 
              child: Text( tool.getLabel() ),
              onPressed: () {
                WxCommandEvent event = WxCommandEvent( wxGetMenuEventType(), tool._id );
                event.setInt( tool._isToggled ? 0 : 1 );
                event.setEventObject( this );
                processEvent( event ); 
              }
            ));
          } else
          {
            Widget? bitmap;
            if (tool._bitmap!.isOk()) {
                bitmap = RawImage( image: tool._bitmap!._image!, fit: BoxFit.fitHeight );
            } else {
                tool._bitmap!._addListener( this );
            }
            if (bitmap != null) 
            {
              actions.add(
                MaterialButton( 
                onPressed:() {
                    WxCommandEvent event = WxCommandEvent( wxGetMenuEventType(), tool._id );
                    event.setInt( tool._isToggled ? 0 : 1 );
                    event.setEventObject( this );
                    processEvent( event ); 
                }, 
                minWidth: 16,
                /*
                padding: EdgeInsetsGeometry.all(0),
                shape: RoundedRectangleBorder(
                  side: BorderSide( width: 0.5 ),
                  borderRadius: BorderRadius.all(Radius.circular(4))
                ),
                */
                child: bitmap
              ) );
            }
          }
        }
      }

    return actions;
  }

  AppBar? _buildAppBar( BuildContext context ) 
  {
    if (_isAttached) {
      return null;
    }

    return       
      AppBar(  // main title should be in the titlebar of the browser
        title: Text(_appBarTitle),
        actions: _buildActionsFromAppBar(),
      );
  }

  @override 
  Widget _build( BuildContext context )
  {
    if (_isAttached) {
      return 
        SliverAppBar(
          pinned: hasFlag( wxAB_PINNED ),
          expandedHeight: 80.0,
          title: hasFlag( wxAB_FLEXIBLE )
            ? null 
            : Text( _appBarTitle ),
          flexibleSpace: hasFlag( wxAB_FLEXIBLE )
            ? FlexibleSpaceBar( title: Text( _appBarTitle ) )
            : null,
          actions: _buildActionsFromAppBar(),
        );
    } 
    else
    {
      wxLogError( "WxAppBar is build like a WxToolBar" );
      return        
        AppBar(  // main title should be in the titlebar of the browser
          title: Text(_appBarTitle),
          actions: _buildActionsFromAppBar(),
        );
    } 
  }

}

