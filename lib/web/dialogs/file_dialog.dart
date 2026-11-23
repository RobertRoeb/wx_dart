// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01 (wxDart Web: 2026-11-17)
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxPickedFile ----------------------

/// wxDart Web: a file chosen with [WxFileDialog] or [WxDirDialog].
///
/// Browsers do not give access to the file system: there are no paths
/// that could be opened later, only the file chosen by the user. Its
/// contents are read with [read] or [readAsString].
class WxPickedFile {
  WxPickedFile._( _JsPickedFile js )
    : name = js.name,
      path = js.path,
      size = js.size.toInt(),
      mimeType = js.type,
      _file = js.file;

  /// The file name without any path
  final String name;

  /// The file name relative to the chosen folder for files from a
  /// [WxDirDialog] (e.g. "photos/2026/beach.jpg"), otherwise the same
  /// as [name]
  final String path;

  /// The size in bytes
  final int size;

  /// The MIME type as reported by the browser, may be empty
  final String mimeType;

  final JSObject _file;

  /// Reads the contents of the file
  Future<Uint8List> read() async {
    final data = await _jsReadFile( _file ).toDart;
    return data.toDart;
  }

  /// Reads the contents of the file as text (UTF-8)
  Future<String> readAsString() async {
    return utf8.decode( await read(), allowMalformed: true );
  }
}

/// Converts a wildcard like "*.jpg;*.jpeg" or "JPEG files (*.jpg)|*.jpg|PNG files (*.png)|*.png"
/// to the accept attribute of an HTML file input (".jpg,.jpeg")
String _wxWildcardToAccept( String wildcard ) {
  final parts = wildcard.split( '|' );
  // "description|patterns|description|patterns": the browser has no list
  // of filters, so the first one (the default in wxWidgets) is used
  final patterns = parts.length > 1 ? parts[1].split( ';' ) : wildcard.split( ';' );
  final accept = <String>[];
  for (var pattern in patterns) {
    pattern = pattern.trim();
    if (pattern.isEmpty || pattern == '*' || pattern == '*.*') return '';
    final dot = pattern.lastIndexOf( '.' );
    if (dot == -1) continue;
    final ext = pattern.substring( dot );
    if (ext.contains( '*' ) || ext.contains( '?' )) return '';
    if (!accept.contains( ext )) accept.add( ext );
  }
  return accept.join( ',' );
}

/// wxDart Web: offers [data] as a download named [filename]. This is
/// how a web app saves a file, e.g. after the user chose a name with a
/// [WxFileDialog] with wxFD_SAVE. The browser decides where the file goes
/// (usually the downloads folder) and may ask the user.
///
/// See [wxDownloadTextFile]
void wxDownloadFile( String filename, Uint8List data, { String mimeType = 'application/octet-stream' } ) {
  _jsDownloadFile( filename, data.toJS, mimeType );
}

/// wxDart Web: offers [text] (as UTF-8) as a download named [filename].
///
/// See [wxDownloadFile]
void wxDownloadTextFile( String filename, String text, { String mimeType = 'text/plain' } ) {
  wxDownloadFile( filename, Uint8List.fromList( utf8.encode( text ) ), mimeType: '$mimeType;charset=utf-8' );
}

// ------------------------- wxFileDialog ----------------------

const int wxFD_OPEN = 0x0001;
const int wxFD_DEFAULT_STYLE = wxFD_OPEN;
const int wxFD_SAVE = 0x0002;
const int wxFD_OVERWRITE_PROMPT = 0x0004;
const int wxFD_NO_FOLLOW = 0x0008;
const int wxFD_FILE_MUST_EXIST = 0x0010;
const int wxFD_CHANGE_DIR = 0x0080;
const int wxFD_PREVIEW = 0x0100;
const int wxFD_MULTIPLE = 0x0200;
const int wxFD_SHOW_HIDDEN = 0x0400;

/// Standard dialog to open and save files. Uses the native dialogs in
/// both wxDart Native and wxDart Flutter to the extent possible and
/// it os available also on iOS, Android and the Web. Not all flags are
/// supported everywhere.
///```dart
///  final dialog = WxFileDialog(this, "Open JPEG", defaultWildCard: '*.jpg;*.jpeg' );
///  dialog.showModal( (value, data) {
///    if (value == wxID_OK)
///    {
///      final msg = WxMessageDialog( this, "Pressed OK", caption: "wxDart" );
///      msg.setExtendedMessage( "File: $data" );
///      msg.showModal(null);
///    }
///  } );
///```
///
/// # Constants
/// | constant | value/meaning |
/// | -------- | -------- |
/// | wxFD_OPEN | 0x0001 |
/// | wxFD_DEFAULT_STYLE | wxFD_OPEN |
/// | wxFD_SAVE | 0x0002 |
/// | wxFD_OVERWRITE_PROMPT | 0x0004 |
/// | wxFD_NO_FOLLOW | 0x0008 |
/// | wxFD_FILE_MUST_EXIST | 0x0010 |
/// | wxFD_CHANGE_DIR | 0x0080 |
/// | wxFD_PREVIEW | 0x0100 |
/// | wxFD_MULTIPLE | 0x0200 |
/// | wxFD_SHOW_HIDDEN | 0x0400 |
///
/// # wxDart Web
/// Browsers do not give web pages access to the file system, so:
/// * **Opening** (wxFD_OPEN) shows the browser's file chooser. [showModal]
///   must be called while handling a user action (a button, a menu item
///   or a key press), otherwise the browser does not show it. `data` in the
///   callback is the file name, or a list of names with wxFD_MULTIPLE, as
///   in the other ports, but without a path. Read the contents with
///   [getFiles] inside the callback:
///   ```dart
///   dialog.showModal( (value, data) async {
///     if (value != wxID_OK) return;
///     final text = await dialog.getFiles().first.readAsString();
///   } );
///   ```
///   The wildcard ("*.jpg;*.jpeg" or "JPEG files (*.jpg)|*.jpg|...") becomes
///   a filter in the file chooser, which the user can usually switch off.
///   Of several filters, only the first one is used.
///   defaultDir and defaultFile are ignored.
/// * **Saving** (wxFD_SAVE) shows a small dialog asking for the file name
///   (preset with defaultFile). `data` is the name; write the file with
///   [wxDownloadFile] or [wxDownloadTextFile], the browser puts it into
///   the downloads folder or asks where to put it. wxFD_OVERWRITE_PROMPT
///   has no effect.
/// * wxFD_FILE_MUST_EXIST, wxFD_CHANGE_DIR, wxFD_NO_FOLLOW, wxFD_PREVIEW and
///   wxFD_SHOW_HIDDEN have no effect.
/// * Older browsers don't report cancelling the file chooser. Then the
///   callback is not called at all.

class WxFileDialog extends WxDialog {
  WxFileDialog( WxWindow? parent, String message, { String defaultDir = '', String defaultFile = '', String defaultWildCard = '*.*', int style = wxFD_DEFAULT_STYLE, WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize } )
    : _fdStyle = style,
      _defaultDir = defaultDir,
      _defaultFile = defaultFile,
      _wildcard = defaultWildCard,
      super( parent, -1, message, pos: pos, size: size );

  final int _fdStyle;
  final String _defaultDir;
  final String _defaultFile;
  final String _wildcard;
  List<WxPickedFile> _files = [];
  String _savePath = '';

  bool _hasFdFlag( int flag ) => (_fdStyle & flag) != 0;

  /// Returns the directory given in the constructor (wxDart Web has no
  /// access to directories)
  String getDirectory() {
    return _defaultDir;
  }

  /// Returns the wildcard given in the constructor
  String getWildcard() {
    return _wildcard;
  }

  /// Returns the chosen file name (in wxDart Web without a path, see [WxPickedFile])
  String getPath() {
    if (_hasFdFlag( wxFD_SAVE )) return _savePath;
    return _files.isEmpty ? '' : _files.first.name;
  }

  /// Returns the chosen file names (with wxFD_MULTIPLE)
  List<String> getPaths() {
    if (_hasFdFlag( wxFD_SAVE )) return _savePath.isEmpty ? [] : [ _savePath ];
    return _files.map( (file) => file.name ).toList();
  }

  /// Returns the chosen file name, same as [getPath] in wxDart Web
  String getFilename() {
    return getPath();
  }

  /// Returns the chosen file names, same as [getPaths] in wxDart Web
  List<String> getFilenames() {
    return getPaths();
  }

  /// wxDart Web: returns the chosen files including access to their
  /// contents. Only valid in the callback of [showModal].
  List<WxPickedFile> getFiles() {
    return _files;
  }

  @override
  void showModal( void Function( int, dynamic )? onReturn )
  {
    if (_hasFdFlag( wxFD_SAVE )) {
      _showSaveDialog( onReturn );
      return;
    }
    final multiple = _hasFdFlag( wxFD_MULTIPLE );
    _jsPickFiles( _wxWildcardToAccept( _wildcard ), multiple, false ).toDart.then( (result) {
      if (result == null || result.toDart.isEmpty) {
        onReturn?.call( wxID_CANCEL, null );
      } else {
        _files = result.toDart.map( (js) => WxPickedFile._( js ) ).toList();
        onReturn?.call( wxID_OK, multiple ? getPaths() : getPath() );
      }
      destroy();
      _scheduleIdle();
    } );
  }

  /// Asks for the file name in a small dialog (this dialog)
  void _showSaveDialog( void Function( int, dynamic )? onReturn ) {
    final main = WxColumn();
    main.add( WxStaticText( this, -1, "File name:" ), flag: wxLEFT | wxRIGHT | wxTOP, border: 12 );
    final text = WxTextCtrl( this, -1, value: _defaultFile, size: const WxSize( 320, -1 ) );
    main.add( text, flag: wxEXPAND | wxALL, border: 12 );
    final buttons = createStdDialogButtonSizer( wxOK | wxCANCEL );
    main.addSizer( buttons, flag: wxEXPAND | wxLEFT | wxRIGHT | wxBOTTOM, border: 12 );
    setSizerAndFit( main );
    // the name must not be empty
    bindDialogValidateEvent( (event) {
      if (text.getValue().trim().isEmpty) event.veto();
    }, wxID_OK );
    super.showModal( (code, _) {
      _savePath = code == wxID_OK ? text.getValue().trim() : '';
      onReturn?.call( code, code == wxID_OK ? _savePath : null );
    } );
    text.setFocus();
    text.selectAll();
  }
}

// ------------------------- wxDirDialog ----------------------

const int wxDD_CHANGE_DIR = 0x0100;
const int wxDD_DIR_MUST_EXIST = 0x0200;
const int wxDD_MULTIPLE = 0x0400;
const int wxDD_SHOW_HIDDEN = 0x0001;
const int wxDD_DEFAULT_STYLE = (wxDEFAULT_DIALOG_STYLE|wxRESIZE_BORDER);

/// Standard dialog to pick a directory. Uses the native dialogs im
/// both wxDart Native and wxDart Flutter to the extent possible and
/// it os available also on iOS, Android and the Web. Not all flags are
/// supported everywhere.
///```dart
///  final dialog = WxDirDialog(this, "Choose directory" );
///  dialog.showModal( (value, data) {
///    if (value == wxID_OK)
///    {
///      final msg = WxMessageDialog( this, "Pressed OK", caption: "wxDart" );
///      msg.setExtendedMessage( "Folder: $data" );
///      msg.showModal(null);
///    }
///  } );
///```
///
/// # Constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxDD_CHANGE_DIR | 0x0100 |
/// | wxDD_DIR_MUST_EXIST | 0x0200 |
/// | wxDD_MULTIPLE | 0x0400 |
/// | wxDD_SHOW_HIDDEN | 0x0001 |
/// | wxDD_DEFAULT_STYLE | (wxDEFAULT_DIALOG_STYLE|wxRESIZE_BORDER) |
///
/// # wxDart Web
/// Browsers have no dialog to choose just a directory. The browser's
/// folder chooser lets the user pick a folder and then hands over all
/// files in it and its subfolders (most browsers ask the user to confirm
/// this "upload"; nothing is sent to a server). `data` in the callback is
/// the name of the folder, without a path. [getFiles] returns the files,
/// with their path relative to the parent of the chosen folder in
/// [WxPickedFile.path]. Their contents are only read when calling
/// [WxPickedFile.read], so large folders are no problem.
///
/// As with [WxFileDialog], [showModal] must be called while handling a
/// user action. An empty folder returns wxID_OK with an empty name, since
/// browsers don't report its name. The flags have no effect.

class WxDirDialog extends WxDialog {
  WxDirDialog( WxWindow? parent, String message, { String defaultDir = '', int style = wxDD_DEFAULT_STYLE, WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize } )
    : _defaultDir = defaultDir,
      super( parent, -1, message, pos: pos, size: size );

  final String _defaultDir;
  List<WxPickedFile> _files = [];
  String _path = '';

  /// Returns the name of the chosen folder (in wxDart Web without a path),
  /// or the default directory before a folder was chosen
  String getPath( ) {
    return _path.isEmpty ? _defaultDir : _path;
  }

  /// wxDart Web: returns the files in the chosen folder and its subfolders.
  /// Only valid in the callback of [showModal].
  List<WxPickedFile> getFiles() {
    return _files;
  }

  @override
  void showModal( void Function( int, dynamic )? onReturn )
  {
    _jsPickFiles( '', false, true ).toDart.then( (result) {
      if (result == null) {
        onReturn?.call( wxID_CANCEL, null );
      } else {
        _files = result.toDart.map( (js) => WxPickedFile._( js ) ).toList();
        if (_files.isNotEmpty) {
          final path = _files.first.path;
          final slash = path.indexOf( '/' );
          _path = slash == -1 ? '' : path.substring( 0, slash );
        }
        onReturn?.call( wxID_OK, _path );
      }
      destroy();
      _scheduleIdle();
    } );
  }
}
