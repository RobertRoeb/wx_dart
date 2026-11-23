// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01 (wxDart Web: 2026-11-15)
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxDropTarget ----------------------

/// A [WxDropTarget] can be associated with a [WxWindow] by calling
/// [WxWindow.setDropTarget] so that data can be dropped on the
/// window using Drag and Drop operations.
/// 
/// A [WxDataObject] needs to assigned to the [WxDropTarget] and it
/// will receive the data in DragData where you can call [getData].
/// 
/// In wxDart Flutter, drag and drop is only implemented within the app,
/// except for wxDart Flutter on the Web, where you can also drop text or
/// and a bitmap from other apps into a [WxDropTarget] holding a [WxTextDataObject]
/// or a [WxBitmapDataObject].
/// 
/// While the wxWidgets C++ library uses overloaded functions,
/// wxDart uses events as the main interface for [WxDropTarget]. 
/// 
/// Main interface:
/// * [getData]
/// 
/// Example usage:
/// ```Dart
/// class MyDropWindow extends WxWindow {
///   MyDropWindow( WxWindow parent, WxSize size ) : super( parent, -1, wxDefaultPosition, size, 0)
///   {  
///     _dataObject = WxTextDataObject( "" );
///     _dropTarget = WxDropTarget( _dataObject );
///     setDropTarget( _dropTarget );
/// 
///     bindDropEnterEvent( (_) { 
///       // Show some highlight
///     }, -1 );
///     bindDropLeaveEvent( (_) {
///       // Remove some highlight
///     }, -1 );
///     bindDropDragOverEvent( (event) {
///       // Show insertion hint
///       final pos = event.getPosition();
///     }, -1 );
///     bindDropDropEvent( onDrop, -1);
///     bindDropDataEvent( onData, -1);
///   }
/// 
///   late WxTextDataObject _dataObject;
///   late WxDropTarget _dropTarget;
///   String _dropText = "";
/// 
///   void onDrop( WxDropEvent event )
///   {
///     // You can reject the drop using 
///     // event.veto();
///   }
///   void onData( WxDropEvent event )
///   {
///     // The data has arrived. Now transfer it
///     // from _dropTarget to the _dataObject
///     _dropTarget.getData();
/// 
///     // We got it!
///     _dropText = _dataObject.getText();
/// 
///     // Update window (or something else)
///     refresh();
///   }
/// }
///```
/// 
/// Events emitted (to associated window):
/// [DropDrop](/wxdart/wxGetDropDropEventType.html) event gets sent when user dropped the data. You can [WxDropEvent.veto] the drop. |
/// | ----------------- |
/// | void bindDropDropEvent( void function( [WxDropEvent] event ) ) |
/// | void unbindDropDropEvent() |
///
/// [DropData](/wxdart/wxGetDropDataEventType.html) event gets sent after a DropDrop event. Call [WxDropTarget.getData] in the handler. |
/// | ----------------- |
/// | void bindDropDataEvent( void function( [WxDropEvent] event ) ) |
/// | void unbindDropDataEvent() |
///
/// [DropDragOver](/wxdart/wxGetDropDragOverEventType.html) event gets sent when data is being dragged above the window. |
/// | ----------------- |
/// | void bindDropDragOverEvent( void function( [WxDropEvent] event ) ) |
/// | void unbindDropDragOverEvent() |
/// 
/// [DropEnter](/wxdart/wxGetDropEnterEventType.html) event gets sent when mouse enters the drop window. Not supported everywhere. |
/// | ----------------- |
/// | void bindDropEnterEvent( void function( [WxDropEvent] event ) ) |
/// | void unbindDropEnterEvent() |
/// 
/// [DropLeave](/wxdart/wxGetDropLeaveEventType.html) event gets sent when mouse leaves the drop window. Not supported everywhere. |
/// | ----------------- |
/// | void bindDropLeaveEvent( void function( [WxDropEvent] event ) ) |
/// | void unbindDropLeaveEvent() |

class WxDropTarget extends WxClass {

/// Creates a drop target with given [data]. A [WxDropTarget] needs
/// to be associated with a [WxWindow] by calling [WxWindow.setDropTarget].
/// 
/// In wxDart Web, a drop target accepts data dragged within the app and
/// data dropped from other apps or browser tabs:
/// * [WxTextDataObject]: text and links
/// * [WxBitmapDataObject]: image files and images from other web pages
/// * [WxFileDataObject]: files, use [WxFileDataObject.getFiles] for their contents
  WxDropTarget( WxDataObject data ) {
    _dataObject = data;
  }

  late WxDataObject _dataObject;
  WxDataObject? _receivedDataObject;

  /// Tells the drop target to acquire the data. This needs to be
  /// called from with bindDragDrop(). See example.
  bool getData( )
  {
    final source = _receivedDataObject;
    if (source == null) return false;
    // TODO: what if a non-preferred format was negotiated
    final format = _dataObject.getPreferredFormat();
    return _dataObject._takeFrom( source, format );
  }

/// Sets the default drop action, defaults to wxDRAG_COPY_ONLY.
/// 
/// # Drag operation constants
/// | constant | meaning |
/// | -------- | -------- |
/// | wxDRAG_COPY_ONLY | 0 |
/// | wxDRAG_ALLOW_MOVE | 1 |
/// | wxDRAG_DEFAULT_MOVE | 3 |
  void setDefaultAction( int action ) {
  }

  // ---------------- wxDart Web: data from outside the app (HTML5 DnD)

  /// True if the browser's list of data types [types] (comma separated,
  /// plus the MIME types of dragged files) contains something we can use.
  bool _acceptsBrowserTypes( String types ) {
    final list = types.split(',');
    switch (_dataObject.getPreferredFormat().getType()) {
      case wxDF_TEXT:
      case wxDF_UNICODETEXT:
        return list.contains('text/plain') || list.contains('text/uri-list');
      case wxDF_BITMAP:
        return list.any( (t) => t.startsWith('image/') ) || list.contains('text/uri-list');
      case wxDF_FILENAME:
        return list.contains('Files');
    }
    return false;
  }
}

WxDropEvent _makeDropEvent( int type, WxWindow win, int x, int y ) {
  final event = WxDropEvent( type, win.getId() );
  event.setEventObject( win );
  event.setPosition( WxPoint( x, y ) );
  return event;
}

/// Sends DropDrop and, unless vetoed, DropData with [data] to [win]
bool _wxDoDrop( WxWindow win, WxDropTarget target, WxDataObject data, int x, int y ) {
  final dropEvent = _makeDropEvent( wxGetDropDropEventType(), win, x, y );
  win.processEvent( dropEvent );
  if (!dropEvent.isAllowed()) return false;
  target._receivedDataObject = data;
  dropEvent.setEventType( wxGetDropDataEventType() );
  /// Target has to request data copy in this event
  win.processEvent( dropEvent );
  target._receivedDataObject = null;
  return true;
}

/// HTML5 drag and drop events from wxc.js: dndenter, dndover, dndleave, dnddrop
bool _dispatchDnd( _JsEvent e ) {
  final win = _windowFromHandle( e.id );
  if (win == null) return false;
  final target = win._dropTarget;
  if (target == null) return false;
  switch (e.type) {
    case 'dndenter':
      win.processEvent( _makeDropEvent( wxGetDropEnterEventType(), win, e.x, e.y ) );
      return true;
    case 'dndleave':
      win.processEvent( _makeDropEvent( wxGetDropLeaveEventType(), win, e.x, e.y ) );
      return true;
    case 'dndover':
      if (!target._acceptsBrowserTypes( e.text )) return false;
      final event = _makeDropEvent( wxGetDropDragOverEventType(), win, e.x, e.y );
      win.processEvent( event );
      return event.isAllowed() && (event.getResult() != wxDRAG_RESULT_NONE);
    case 'dnddrop':
      _wxBrowserDrop( win, target, e );
      return true;
  }
  return false;
}

void _wxBrowserDrop( WxWindow win, WxDropTarget target, _JsEvent e ) {
  final x = e.x;
  final y = e.y;
  final files = <_JsFile>[];
  final jsFiles = e.files;
  if (jsFiles != null) files.addAll( jsFiles.toDart );
  // image blob URLs that are not used are released
  void releaseUrls( [_JsFile? keep] ) {
    for (final f in files) {
      if (f.url.isNotEmpty && f != keep) _jsRevokeUrl( f.url );
    }
  }

  switch (target._dataObject.getPreferredFormat().getType()) {
    case wxDF_TEXT:
    case wxDF_UNICODETEXT: {
      releaseUrls();
      final text = e.text.isNotEmpty ? e.text : e.url;
      _wxDoDrop( win, target, WxTextDataObject( text ), x, y );
      break;
    }

    case wxDF_FILENAME: {
      releaseUrls();
      final data = WxFileDataObject();
      for (final f in files) {
        data.addFile( f.name );
        data._files.add( WxDroppedFile( f.name, f.type, f.data.toDart ) );
      }
      _wxDoDrop( win, target, data, x, y );
      break;
    }

    case wxDF_BITMAP: {
      _JsFile? image;
      for (final f in files) {
        if (f.url.isNotEmpty) { image = f; break; }
      }
      releaseUrls( image );
      String url = image?.url ?? '';
      if (url.isEmpty) {
        // an image dragged from another web page: take the first link
        url = e.url.split('\n').map( (s) => s.trim() ).firstWhere(
                (s) => s.isNotEmpty && !s.startsWith('#'), orElse: () => '' );
      }
      if (url.isEmpty) return;
      final bitmap = WxBitmap.fromUrl( url );
      final bytes = image?.data.toDart;
      bitmap.ready.then( (_) {
        if (image != null) _jsRevokeUrl( url );
        if (!bitmap.isOk() || win._isDestroyed) return;
        _wxDoDrop( win, target, WxBitmapDataObject._fromBitmapAndData( bitmap, bytes ), x, y );
        _scheduleIdle();
      } );
      break;
    }
  }
}
