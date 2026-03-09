// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

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

class WxDirDialog extends WxDialog {
  WxDirDialog( WxWindow? parent, String message, { String defaultDir = '', int style = wxDD_DEFAULT_STYLE, WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize } ) 
    : super( parent, -1, message, pos: pos, size: size, style: style )
  {
      _defaultDir = defaultDir;
  }

  late String _defaultDir;

  @override
  void showModal( void Function( int, dynamic )? onReturn )
  {
    _isModal = true;

        _showModalPickDirDialogAsync().then( (result)
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

    _isModal = false;
    destroy();
  }

  String getPath( ) {
    return "";
  }

  Future<String?> _showModalPickDirDialogAsync()
  {
    return FilePicker.platform.getDirectoryPath(
        initialDirectory: _defaultDir.isNotEmpty ? _defaultDir : null,
        dialogTitle: _title,
        lockParentWindow: true,
    );
  }
}

