
import 'package:wx_dart/wx_dart.dart';

// ------------------------- MyAsyncWindow ----------------------

class MyAsyncWindow extends WxScrolledWindow {
  MyAsyncWindow( WxWindow parent ) : super( parent, -1, style: wxVSCROLL )
  {
    _mainSizer = WxColumn();
    setSizer( _mainSizer );

    final buttonSizer = WxRow();
    _mainSizer.addSizer(buttonSizer, flag: wxALIGN_RIGHT );

    final removeButton = WxButton( this, -1, "Remove first control" );
    buttonSizer.add( removeButton, flag: wxALL, border: 10 );
    removeButton.bindButtonEvent( (_) {
      if (_mainSizer.getItemCount() > 0)
      {
        final item = _mainSizer.getItem( 1 );
        if (item == null) return;
        final win = item.getWindow();
        _mainSizer.remove(1);
        if (win != null) {
          win.destroy();
        }
        layout();
      }
    }, -1 );

    final startAsyncButton = WxButton( this, -1, "Add controls asynchronously" );
    buttonSizer.add( startAsyncButton, flag: wxALL, border: 10 );
    startAsyncButton.bindButtonEvent( (_) {
      _mainSizer.add( WxStaticText(this, -1, "Before calling async operation" ), border: 5, flag: wxALL );
      _mainSizer.layout();
      loadImagesAsync();
      _mainSizer.add( WxStaticText(this, -1, "After calling async operation" ), border: 5, flag: wxALL );
      _mainSizer.layout();
    } , -1 );

    bindIdleEvent( (_) {
      if (removeButton.isShown() != (_mainSizer.getItemCount() > 0)) {
        removeButton.show( show: (_mainSizer.getItemCount() > 0) );
        layout();
      }
    } );
  }

  Future<void> loadImagesAsync() async
  {
    // give scheduler a chance to postpone
    // await Future.delayed( const Duration( milliseconds: 5 ));
    
    // Load horse from resources
    wxLoadImageFromResource( "horse.png", (image) {
      final bundle = WxBitmapBundle.fromImage(image);
      _mainSizer.add( WxStaticBitmap(this, -1, bundle), border:5, flag: wxALL );
      layout();
    } );
    // Load toucan from resources
    wxLoadImageFromResource( "toucan.png", (image) {
      final bundle = WxBitmapBundle.fromImage(image);
      _mainSizer.add( WxStaticBitmap(this, -1, bundle), border:5, flag: wxALL );
      layout();
    } );
  }

  late WxColumn _mainSizer;
}
