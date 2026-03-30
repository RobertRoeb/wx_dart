// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- constants ----------------------

const int wxNO_IMAGE = -1;
const int wxNOT_FOUND = -1;

// ----------- appearance (light/dark mode) ------------

const int wxAPPEARANCE_SYSTEM = 0;
const int wxAPPEARANCE_LIGHT = 1;
const int wxAPPEARANCE_DARK = 2;

const int wxAPPEARANCE_RESULT_FAILURE = 0;
const int wxAPPEARANCE_RESULT_OK = 1;
const int wxAPPEARANCE_RESULT_CANNOT_CHANGE = 2;

// ----------- global access to BuildContext --------------

final _navigatorKey = GlobalKey<NavigatorState>();
final _scaffoldKey = GlobalKey<ScaffoldState>();

WxPoint _globalMousePosition = WxPoint.zero;

// ------------------------- wxApp ----------------------

  void _updateThemeData()
  {
    if (wxTheApp.isTouch())
    {
      _darkTheme = ThemeData(
          brightness: Brightness.dark,
          colorScheme: ColorScheme.fromSeed(
            seedColor: wxTheApp._getSeedColor(),
            brightness: Brightness.dark,
          )
        );
      _lightTheme = ThemeData(
          brightness: Brightness.light,
          colorScheme: ColorScheme.fromSeed(
            seedColor: wxTheApp._getSeedColor(),
          )
        );        
    }
    else
    {
      _darkTheme = ThemeData(
          brightness: Brightness.dark,
          textTheme: TextTheme(
            bodyLarge: TextStyle(fontSize: 14.0),
            bodyMedium: TextStyle(fontSize: 13.0)
          ),
          inputDecorationTheme: InputDecorationTheme( 
            filled: true,
            isDense: true
          ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: wxTheApp._getSeedColor(),
            brightness: Brightness.dark,
          )
        );
      _lightTheme = ThemeData(
          brightness: Brightness.light,
          iconButtonTheme: IconButtonThemeData(
            style: ButtonStyle(
              visualDensity: VisualDensity.compact,
            )
          ),
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              visualDensity: VisualDensity.compact,
            )
          ),
          inputDecorationTheme: InputDecorationTheme( 
            isDense: true,
            filled: true,
            border: UnderlineInputBorder(),
          ),
          textTheme: TextTheme(
            bodyLarge: TextStyle(fontSize: 14.0),
            bodyMedium: TextStyle(fontSize: 13.0)
          ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: wxTheApp._getSeedColor(),
          ) );       
    }
  }

/// @nodoc

WxDartAppWidgetState? _theWxDartAppState;

ThemeData? _lightTheme;
ThemeData? _darkTheme;

/// @nodoc

class WxDartAppWidgetState extends State<WxDartAppWidget> 
  with TickerProviderStateMixin, WidgetsBindingObserver {
  WxDartAppWidgetState()
  {
    _theWxDartAppState = this;
  }

  final List <WxUIAnimation> _animationControllers = [];
  late final AppLifecycleListener _listener;
  double _screenWidth = 1280;
  double _screenHeight = 800;

  @override
  void initState()
  {
    super.initState();

    _listener = AppLifecycleListener( onExitRequested: () async
    {
      if (theTLW != null) {
        if (theTLW!.isBeingDeleted()) {  // close event has been sent already
          return ui.AppExitResponse.exit;  
        }
        WxCloseEvent event = WxCloseEvent( wxGetCloseWindowEventType(), id: theTLW!.getId() );
        event.setCanVeto(true);
        if (theTLW!.processEvent(event)) {
          if (event.getVeto()) {
            return ui.AppExitResponse.cancel;
          }
        }
      }
      return ui.AppExitResponse.exit;
    }, onShow: () {
        final event = WxActivateEvent( wxGetActivateAppEventType(), active: true );
        event.setEventObject(wxTheApp);
        wxTheApp.processEvent(event);
    }, onResume: () {
        final event = WxActivateEvent( wxGetActivateAppEventType(), active: true );
        event.setEventObject(wxTheApp);
        wxTheApp.processEvent(event);
    }, onRestart: () {
        final event = WxActivateEvent( wxGetActivateAppEventType(), active: true ); // de-hibernate ?
        event.setEventObject(wxTheApp);
        wxTheApp.processEvent(event);
    }, onHide: () {
        final event = WxActivateEvent( wxGetActivateAppEventType(), active: false );
        event.setEventObject(wxTheApp);
        wxTheApp.processEvent(event);
    }, onInactive: () {
        final event = WxActivateEvent( wxGetHibernateEventType(), active: false );
        event.setEventObject(wxTheApp);
        wxTheApp.processEvent(event);
    }, onPause: () {
        final event = WxActivateEvent( wxGetActivateAppEventType(), active: false );
        event.setEventObject(wxTheApp);
        wxTheApp.processEvent(event);
    });
  }

  @override
  void dispose()
  {
    _listener.dispose();
    for (final animation in _animationControllers) {
      animation.dispose();
    }
    super.dispose();
  }

  void _doSetState()
  {
    setState(() {
      // update it!
    });
  }

  @override
  Widget build(BuildContext context)
  {
    _screenWidth = MediaQuery.sizeOf(context).width;
    _screenHeight = MediaQuery.sizeOf(context).height;

    if (theTLW == null) {
      return Text( "There is no WxFrame for WxApp to show!" );
    }
    
    _updateThemeData();

    final Map<ShortcutActivator, Intent>  shortcuts = {};
    WxMenuBar ?menuBar = theTLW!.getMenuBar();
    if (menuBar != null) { 
      menuBar._addShortcuts( shortcuts );
    }

    return MouseRegion(
      onHover: (event) {
        _globalMousePosition = WxPoint( event.position.dx.floor(), event.position.dy.floor() );
      },
      child:
      MaterialApp(
        title: wxTheApp.getAppDisplayName(),
        color: wxTheApp._getSeedColor(),
        themeMode: wxTheApp.isDark() ? ThemeMode.dark : ThemeMode.light,
        darkTheme: _darkTheme,
        theme: _lightTheme,      
        home: Shortcuts(
          shortcuts: shortcuts,
          child:  theTLW!._build( context ),
        ),
        navigatorKey: _navigatorKey
    ) );
  }
}

/// @nodoc

class WxDartAppWidget extends StatefulWidget {
  const WxDartAppWidget({super.key});

  @override
  State<WxDartAppWidget> createState() => WxDartAppWidgetState();
}

/// Global reference to the single instance of your WxApp
late WxApp wxTheApp;
List <WxTopLevelWindow> _topLevelWindows = [];

/// Represents the application itself. Keeps track of the top window
/// and adds support setting dark/light mode appearance and theme colours.
/// 
/// [isTouch] returns true if the app is running on a touch device and 
/// adapts the interface accordingly. This is also true if the app is
/// running in a browser on a smart phone or tablet (mobile web).
/// 
/// You can override this function to change the detection or to always
/// test you app in touch mode. Adaptation to touch interfaces are currently
/// only implemented in wxDart Flutter.
/// 
/// # Global objects 
/// | Object | value |
/// | -------- | -------- |
///  |  [wxTheApp]  |  Reference to the single instance of your app | 
/// 
/// # Events emitted
/// [Idle](/wxdart/wxGetIdleEventType.html) event gets sent when the app is idle |
/// | ----------------- |
/// | void bindIdleEvent( OnIdleEventFunc ) |
/// | void unbindIdleEvent() |
/// [ActivateApp](/wxdart/wxGetActivateAppEventType.html) event gets sent when the app gets activated or deactivated |
/// | ----------------- |
/// | void bindActivateAppEvent( OnActivateEventFunc ) |
/// | void unbindActivateAppEvent() |
/// [Hibernate](/wxdart/wxGetHibernateEventType.html) event gets sent when the app gets hibernated |
/// | ----------------- |
/// | void bindHibernateEvent( OnActivateEventFunc ) |
/// | void unbindHibernateEvent() |
/// [QueryEndSession](/wxdart/wxGetQueryEndSessionEventType.html) event gets sent when the system wants to end the session |
/// | ----------------- |
/// | void bindQueryEndSessionEvent( OnCloseEventFunc ) |
/// | void unbindQueryEndSessionEvent() |
/// [EndSession](/wxdart/wxGetEndSessionEventType.html) event gets sent when session ends |
/// | ----------------- |
/// | void bindEndSessionEvent( OnCloseEventFunc ) |
/// | void unbindEndSessionEvent() |
/// 
/// An app needs to override [onInit] and create the main window there.
/// 
/// ```dart
///class MyFrame extends WxFrame {
///  MyFrame( WxWindow ?parent ) 
///  : super( parent, -1, "MyFrame demo", size: WxSize( 800, 600 ) )
///  {
///    final menubar = WxMenuBar();
///    final filemenu = WxMenu();
///    filemenu.appendItem( wxID_EXIT, "Quit\tCtrl-Q", help: "Run baby, run!" );
///    menubar.append(filemenu, "&File");
///    setMenuBar(menubar);
///
///    bindMenuEvent( (_) => close(false), wxID_EXIT );
///    bindCloseWindowEvent( (_) => destroy() );
///  }
///}
///
/// class MyApp extends WxApp {
///   MyApp();
/// 
///   @override
///   bool onInit() {
///       MyFrame myFrame = MyFrame(null);
///       myFrame.show();
///     return true;
///   }
/// }
/// 
/// void main()
/// {
///   final myApp = MyApp();
///   myApp.run();
///   myApp.dispose();
/// }
/// ```

class WxApp extends WxEvtHandler
{
  WxApp()
  {
    // init engine
    WidgetsFlutterBinding.ensureInitialized();

    _isTouch = ((defaultTargetPlatform == TargetPlatform.iOS) || 
                (defaultTargetPlatform == TargetPlatform.android));
    if (!wxIsWeb()) 
    {
      // init standard paths
      getApplicationDocumentsDirectory().then( (value) {
        WxStandardPaths._documentsDir = value.path;
      } );
      getApplicationSupportDirectory().then( (value) {
        WxStandardPaths._configDir = value.path;
      } );
      getTemporaryDirectory().then( (value) {
        WxStandardPaths._temporaryDir = value.path;
      } );

      var uri = Platform.script;
      var path = uri.toFilePath();
      if (path.isNotEmpty) {
        int pos = path.lastIndexOf( wxIsMSW() ? "\\" : "/" );
        if (pos != -1) {
          String filename = path.substring(pos+1);
          int posEnding = filename.lastIndexOf("." );
          if (posEnding != -1) {
            filename = filename.substring(0,posEnding);
          }
          _appName = filename;
          filename = filename.replaceAll("_", " ");
          _appDisplayName = filename;
        }
      }
    }
    wxTheApp = this;
    setAccentColour( WxColour(138, 184, 221) );  // standard light blue
    onInit();
  }

  /// Actually runs the app.
  void run()
  {
    if (theTLW != null) {
        _appWidget = WxDartAppWidget();
        runApp( _appWidget! );
    }
  }

  /// static function returning the main toplevel window
  static WxWindow? getMainTopWindow() {
    return theTLW;
  }

  /// Returns the main toplevel window
  WxWindow? getTopWindow() {
    return theTLW;
  }

  /// Sets the main toplevel window
  void setTopWindow( WxWindow window ) {
    if (window is WxFrame) {
      theTLW = window;
    }
  }

  String getApearanceName( ) {
    return "Flutter";
  }

  /// Returns true if currently running in dark mode
  bool isDark( ) {
    return _isDark;
  }

  /// Returns true if currently running on a touch device. 
  /// Override this to define your own criteria when an
  /// adaptive app should be in touch mode.
  bool isTouch() 
  {
    if (_theWxDartAppState != null) {
      if (_theWxDartAppState!._screenWidth < 700) {
        return true;
      }
    }
    return _isTouch;
  }

  bool isUsingDarkBackground( ) {
    return isDark();
  }

  /// Switch to dark mode, if [mode] is wxAPPEARANCE_DARK and to 
  /// light mode otherwise. Switching at runtime is not supported
  /// under Windows in wxDart Native (but it is when using the 
  /// Flutter backend anywhere, including Windows).
  int setAppearance( int mode ) {
    _isDark = (mode == wxAPPEARANCE_DARK);
    _setState();
    _updateTheme();
    return wxAPPEARANCE_RESULT_OK;
  }

  /// Sets the application name
  void setAppName( String name ) {
    _appName = name;
  } 

  /// Returns the name of the application
  /// 
  /// If SetAppName() had been called, returns the string
  /// passed to it. Otherwise returns the program name.

  String getAppName() {
    return _appName;
  }

  /// Sets the user-visible application name
  /// 
  /// See [getAppDisplayName]
  void setAppDisplayName( String name ) {
    _appDisplayName = name;
  } 

  /// Returns the user-readable application name. 
  /// 
  /// The difference between this string and the one returned by
  /// [getAppName] is that this one is meant to be shown to the
  /// user and so should be used for the window titles, page headers
  /// and so on while the other one should be only used internally,
  /// e.g. for the file names or configuration file keys.
  String getAppDisplayName() {
    return _appDisplayName;
  }


  WxDartAppWidget? _appWidget;

  /// wxDart Flutter only: return the App Widget
  Widget? getFlutterWidget() {
    return _appWidget;
  }

  bool _isDark = false;
  bool _isTouch = false;
  late WxColour _primaryAccent;
  late WxColour _secondaryAccent;
  late Color _seedColour;
  String _appName = "wxdart_app";
  String _appDisplayName = "wxDart";

  // Sets the main accents colour of the app for wxDart Flutter.
  // Typically used directly in selected areas and icons. Many
  // other colours including the backgrounds are derived from
  // this colour. 
  void setAccentColour( WxColour accent )
  {
    _primaryAccent = accent;
    _secondaryAccent = accent.changeLightness(60);
    _seedColour = Color.fromARGB( _primaryAccent.alpha, _primaryAccent.red, _primaryAccent.green, _primaryAccent.blue );
    _setState();
    _updateTheme();
  }

  void _updateTheme()
  {
    _updateThemeData();
    WxRendererNative._updateTheme();
    for (final current in _topLevelWindows) 
    {
      final event = WxSysColourChangedEvent( id: current.getId() );
      event.setEventObject( current );
      current.processEvent( event );
    }

    if (theTLW == null) return;
    _recursiveUpdateTheme( theTLW! );
  }

  void _recursiveUpdateTheme( WxWindow current )
  {
    current._updateTheme();
    for (final child in current.getChildren()) {
      _recursiveUpdateTheme( child );
    }
  }

  void _setState()
  {
    if (_appWidget != null) {
        if (_theWxDartAppState != null) {
          _theWxDartAppState!._doSetState();
        }
    }
  }

  /// Returns the accent colour set by [setAccentColour] ignoring whether or
  /// not the app is in dark or light mode
  /// 
  /// See [getPrimaryAccentColour] and [getSecondaryAccentColour]
  /// 
  /// Only available in Dart Flutter
  WxColour getAccentColour() {
    return _primaryAccent;
  }

  /// Returns the unchanged accent colour in light mode and a darkened tone
  /// of it in dark mode
  /// 
  /// See  [getSecondaryAccentColour]
  /// 
  /// Only available in Dart Flutter
  WxColour getPrimaryAccentColour() {
    return (_isDark) ? _secondaryAccent : _primaryAccent;
  }

  /// Returns a darkened tone of the accent colour in light mode and the unchanged accent
  /// colour in dark mode
  /// 
  /// See  [getPrimaryAccentColour]
  /// 
  /// Only available in Dart Flutter
  WxColour getSecondaryAccentColour() {
    return (!_isDark) ? _secondaryAccent : _primaryAccent;
  }

  Color _getSeedColor() {
    return _seedColour;
  }

  /// Override this and create main window here
  bool onInit() {
    return true;
  }

  /// Override this to return exit code other than 0 indicating an error has occurred
  int onExit() {
    return 0;
  }

  @override
  void dispose() {
    onExit();
    super.dispose();
  }
}
