
import 'package:wx_dart/wx_dart.dart';

// ------------------------- MyAsyncWindow ----------------------

class MyAsyncWindow extends WxScrolledWindow {
  MyAsyncWindow( WxWindow parent ) : super( parent, -1, style: wxVSCROLL )
  {
    final mainSizer = WxColumn();
    setSizer( mainSizer );

    _topSizer = WxColumn();
    mainSizer.addSizer( _topSizer, flag: wxALL|wxEXPAND, proportion: 1, border: 10 );

    final buttonSizer = WxRow();
    mainSizer.addSizer(buttonSizer, flag: wxALIGN_RIGHT );


    final removeButton = WxButton( this, -1, "Remove first control" );
    buttonSizer.add( removeButton, flag: wxALL, border: 10 );
    removeButton.bindButtonEvent( (_) {
      if (_topSizer.getItemCount() > 0)
      {
        final item = _topSizer.getItem( 0 );
        if (item == null) return;
        final win = item.getWindow();
        _topSizer.remove(0);
        if (win != null) {
          win.destroy();
        }
        layout();
      }
    }, -1 );

    final startAsyncButton = WxButton( this, -1, "Add controls asynchronously" );
    buttonSizer.add( startAsyncButton, flag: wxALL, border: 10 );
    startAsyncButton.bindButtonEvent( (_) {
      _topSizer.add( WxStaticText(this, -1, "Before calling async operation" ), border: 5, flag: wxALL );
      _topSizer.layout();
      loadImagesAsync();
      _topSizer.add( WxStaticText(this, -1, "After calling async operation" ), border: 5, flag: wxALL );
      _topSizer.layout();
    } , -1 );

    bindIdleEvent( (_) {
      if (removeButton.isShown() != (_topSizer.getItemCount() > 0)) {
        removeButton.show( show: (_topSizer.getItemCount() > 0) );
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
      _topSizer.add( WxStaticBitmap(this, -1, bundle), border:5, flag: wxALL );
      layout();
    } );
    // Load toucan from resources
    wxLoadImageFromResource( "toucan.png", (image) {
      final bundle = WxBitmapBundle.fromImage(image);
      _topSizer.add( WxStaticBitmap(this, -1, bundle), border:5, flag: wxALL );
      layout();
    } );
  }

  late WxColumn _topSizer;
}
