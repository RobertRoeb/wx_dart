// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- WxDropTarget ----------------------

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
/// | void bindDropDropEvent( void function( [WxDropEvent] event ), int id ) |
/// | void unbindDropDropEvent( int id ) |
///
/// [DropData](/wxdart/wxGetDropDataEventType.html) event gets sent after a DropDrop event. Call [WxDropTarget.getData] in the handler. |
/// | ----------------- |
/// | void bindDropDataEvent( void function( [WxDropEvent] event ), int id ) |
/// | void unbindDropDataEvent( int id ) |
///
/// [DropDragOver](/wxdart/wxGetDropDragOverEventType.html) event gets sent when data is being dragged above the window. |
/// | ----------------- |
/// | void bindDropDragOverEvent( void function( [WxDropEvent] event ), int id ) |
/// | void unbindDropDragOverEvent( int id ) |
/// 
/// [DropEnter](/wxdart/wxGetDropEnterEventType.html) event gets sent when mouse enters the drop window. Not supported everywhere. |
/// | ----------------- |
/// | void bindDropEnterEvent( void function( [WxDropEvent] event ), int id ) |
/// | void unbindDropEnterEvent( int id ) |
/// 
/// [DropLeave](/wxdart/wxGetDropLeaveEventType.html) event gets sent when mouse leaves the drop window. Not supported everywhere. |
/// | ----------------- |
/// | void bindDropLeaveEvent( void function( [WxDropEvent] event ), int id ) |
/// | void unbindDropLeaveEvent( int id ) |

class WxDropTarget extends WxClass {

/// Creates a drop target with given [data]. A [WxDropTarget] needs
/// to be associated with a [WxWindow] by calling [WxWindow.setDropTarget].
  WxDropTarget( WxDataObject data ) {
    _dataObject = data;
  }

  late WxDataObject _dataObject;
  WxDataObject? _receivedDataObject;
  bool _hasSentEnterEvent = false;

  /// Tells the drop target to acquire the data. This needs to be
  /// called from with bindDragDrop(). See example.
  bool getData( )
  {
    // TODO: what if a non-preferred format was negotiated
    final format = _dataObject.getPreferredFormat();

    if (_receivedDataObject != null) {
      final dataReceived = _receivedDataObject!.getData( format );
      if (dataReceived != null) {
        _dataObject.setData( format, dataReceived );
        return true;
      }
    }
    return false;
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
}
