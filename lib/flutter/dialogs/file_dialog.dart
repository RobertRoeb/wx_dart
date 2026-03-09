// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

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

class WxFileDialog extends WxDialog {
  WxFileDialog( WxWindow? parent, String message, { String defaultDir = '', String defaultFile = '', String defaultWildCard = '*.*', int style = wxFD_DEFAULT_STYLE, WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize } )
    : super( parent, -1, message, pos: pos, size: size, style: style )
    {
      _defaultDir = defaultDir;
      _defaultFile = defaultFile;
      _wildcard = defaultWildCard;
    }

    late String _defaultDir;
    late String _defaultFile;
    late String _wildcard;

    String getPath() {
      return "";
    }

    @override
    void showModal( void Function( int, dynamic )? onReturn )
    {
      _isModal = true;

      if (hasFlag( wxFD_SAVE ))
      {
        _showModalSaveFileDialogAsync().then( (result)
        {
          if (result == null)
          {
            if (onReturn != null) {
              onReturn( wxID_CANCEL, null );
            }
          }
          else
          {
            if (onReturn != null) {
              onReturn( wxID_OK, result );
            }
          }
        } );
      }
      else
      {
        _showModalOpenFileDialogAsync().then( (results)
        {
          if (results == null)
          {
            if (onReturn != null) {
              onReturn( wxID_CANCEL, null );
            }
          }
          else
          {
            if (onReturn != null) {
              if (hasFlag( wxFD_MULTIPLE )) {
                List<String> paths = [];
                for (final file in results.files) {
                  paths.add( file.path! );
                }
                onReturn( wxID_OK, paths );
              } 
              else
              {
                  String filename = results.files.single.path!;
                if (hasFlag(wxFD_FILE_MUST_EXIST)) 
                {
                  if (!wxIsWeb())
                  {
                    final file = File(filename);
                    if (!file.existsSync()) {
                      onReturn( wxID_CANCEL, null );
                      return;
                    }
                  }
                }
                onReturn( wxID_OK, filename );
              }
            }
          }
        });
      }
      _isModal = false;
      destroy();
    }

    Future<String?> _showModalSaveFileDialogAsync()
    {
      return FilePicker.platform.saveFile(
        initialDirectory: _defaultDir.isNotEmpty ? _defaultDir : null,
        fileName: _defaultFile,
        dialogTitle: _title,
        lockParentWindow: true,
      );
    }

    Future<FilePickerResult?> _showModalOpenFileDialogAsync()
    {
      List<String> exts = [];
      if (_wildcard.isNotEmpty && (_wildcard != "*.*")) {
        final types = _wildcard.split(";");
        for (final filetype in types) {
          final index = filetype.lastIndexOf( "." );
          exts.add( filetype.substring( index+1 ) );
        }
      }
      return FilePicker.platform.pickFiles(
        allowMultiple: hasFlag( wxFD_MULTIPLE ),
        initialDirectory: _defaultDir.isNotEmpty ? _defaultDir : null,
        type: exts.isEmpty ? FileType.any : FileType.custom,
        allowedExtensions: exts.isEmpty ? null : exts,
        dialogTitle: _title,
        lockParentWindow: true,
      );
    }

}



