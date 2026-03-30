// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';

// ------------------------- wxListbox ----------------------

/// @nodoc

extension ListboxEventBinder on WxEvtHandler {
  void bindListboxEvent( OnCommandEventFunc func, int id ) {
    _eventTable.add( WxCommandEventTableEntry(wxGetListboxEventType(), id, func));
  }

  void unbindListboxEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetListboxEventType(), id));
  }
}

/// @nodoc

extension ListboxDClickEventBinder on WxEvtHandler {
  void bindListboxDClickEvent( OnCommandEventFunc func, int id ) {
    _eventTable.add( WxCommandEventTableEntry(wxGetListboxDClickEventType(), id, func));
  }

  void unbindListboxDClickEvent( int id ) {
    _eventTable.removeWhere( (entry) => entry.matches(wxGetListboxDClickEventType(), id));
  }
}

const int wxLB_SORT = 0x0010;
const int wxLB_SINGLE = 0x0020;
const int wxLB_MULTIPLE = 0x0040;
const int wxLB_EXTENDED = 0x0080;
const int wxLB_ALWAYS_SB = 0x0200;
const int wxLB_NO_SB = 0x0400;
const int wxLB_HSCROLL = wxHSCROLL;


/// Allows the user to select an item from a list.
/// 
/// [Listbox](/wxdart/wxGetListboxEventType.html) event gets sent when the user selects an item. |
/// | ----------------- |
/// | void bindListboxEvent( void function( [WxCommandEvent] event ) ) |
/// | void unbindListboxEvent() |
/// 
/// # Window styles
/// | constant | meaning |
/// | -------- | -------- |
/// | wxLB_SORT | 0x0010 sort items |
/// | wxLB_SINGLE | 0x0020 allow only 1 item to be selected|
/// | wxLB_MULTIPLE | 0x0040 multiple selection allowed |
/// | wxLB_EXTENDED | 0x0080  |
/// | wxLB_ALWAYS_SB | 0x0200 |
/// | wxLB_NO_SB | 0x0400 |
/// | wxLB_HSCROLL | wxHSCROLL |

class WxListBox extends WxItemContainer {  
  WxListBox( super.parent, super.id, 
    { super.pos, super.size, List<String>? choices, super.style } ) 
  {
    if (choices != null) {
      for (final str in choices) {
        _items.add( _WxItem( str ) );
      }
    }
    _selection = 0;
    _resort();
  }

  final WxSelectionStore _selectionStore = WxSelectionStore();
  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener = ItemPositionsListener.create();

  /// Returns true if sorted
  bool isSorted( ) {
    return false;
  }

  /// Returns the list of selected items
  List<int> getSelections() {
    List <int> res = [];
    if (hasFlag(wxLB_MULTIPLE)) {
      for (final num in _selectionStore.getList()) {
        res.add( num );
      }
    } else {
      if (_selection != -1) res.add( _selection );
    }
    return res;
  }

  @override
  void select( int index ) {
    if (hasFlag( wxLB_MULTIPLE)) {
      _selectionStore.selectItem(index);
      _setState();
    } else {
      super.select( index );
    }
  }

  @override
  void clear( ) {
    if (hasFlag( wxLB_MULTIPLE)) {
      _selectionStore.clear();
    }
    super.clear();
  }

  @override
  void delete( int index ) {
    if (hasFlag( wxLB_MULTIPLE)) {
      _selectionStore.onItemDelete(index);
    }
    super.delete( index );
  }

  @override
  void set( List<String> items, { List? data } ) {
    if (hasFlag( wxLB_MULTIPLE)) {
      _selectionStore.clear();
    }
    super.set( items, data: data );
  }

  @override
  void insert( String item, int pos, { dynamic data } ) {
    if (hasFlag( wxLB_MULTIPLE)) {
      _selectionStore.onItemsInserted(pos,1);
    }
    super.insert( item, pos, data: data );
  }

  @override
  void insertList( List<String> items, int pos, { List? data } ) {
    if (hasFlag( wxLB_MULTIPLE)) {
      _selectionStore.onItemsInserted(pos,items.length);
    }
    super.insertList( items, pos, data: data );
  }

  /// Returns true if the [n]th item is selected
  bool isSelected( int n ) {
    if ((n < 0) || (n >= _items.length)) return false;
    if (hasFlag( wxLB_MULTIPLE)) {
      return _selectionStore.isSelected(n);
    }
    return _selection == n;
  }

  /// Deselects the [n]th item (if it was selected)
  void deselect( int n ) {
    if ((n < 0) || (n >= _items.length)) return;
    if (hasFlag( wxLB_MULTIPLE)) {
      _selectionStore.selectItem(n, select: false);
    }
    _setState();
  }

  /// Make the [n]th item the first visible item
  void setFirstItem( int n ) {
    if ((n < 0) || (n >= _items.length)) return;
    _itemScrollController.jumpTo(index: n);
  }

  /// Scroll the list so that the [n]th item is visible
  void ensureVisible( int n ) {
    if ((n < 0) || (n >= _items.length)) return;
    if (_items.length < 3) return;
    if (_items.length < _itemPositionsListener.itemPositions.value.length) return;

    if (_itemPositionsListener.itemPositions.value.isEmpty) return;
    final firstVisible = _itemPositionsListener.itemPositions.value.first.index;
    final lastVisible = _itemPositionsListener.itemPositions.value.last.index;

    for (final pos in _itemPositionsListener.itemPositions.value) {
      if ((n == pos.index) && (firstVisible != pos.index) && (lastVisible != pos.index)) return;
    }

    if (n <= firstVisible) {
      // scroll up
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _itemScrollController.scrollTo(index: n, duration: Duration( milliseconds: 100 ));
      });
    } else {
      // scroll down
      n = n - _itemPositionsListener.itemPositions.value.length + 2;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _itemScrollController.scrollTo(index: n, duration: Duration( milliseconds: 100 ));
      });
    }

  }

  /// Returns the number of items visible
  int getCountPerPage( ) {
    return max( _itemPositionsListener.itemPositions.value.length-1, 1 );
  }

  /// Returns the top visible item. If that includes a potentially partially
  /// visible top item is implementation dependent.
  int getTopItem( ) {
    for (final pos in _itemPositionsListener.itemPositions.value) {
      return pos.index;
    }
    return 0;
  }

  @override
  Widget _build( BuildContext context )
  {
    _focusNode ??= FocusNode();
    Widget finalWidget = _buildControl(context, 
       Focus (
        focusNode: _focusNode,
        autofocus: true,
        onFocusChange: (enter) => _sendFocusEvents(enter),
        onKeyEvent: (node, event)
        {
          if ((event is KeyDownEvent) || (event is KeyRepeatEvent))
          {
            if (hasFlag(wxLB_MULTIPLE)) {
              if ((!HardwareKeyboard.instance.isShiftPressed) &&
                  (!HardwareKeyboard.instance.isControlPressed))
              {
                if (event.logicalKey != LogicalKeyboardKey.space) {
                  _selectionStore.clear();
                }
              }
            }
            switch (event.logicalKey) {
              case LogicalKeyboardKey.arrowUp:
              if (_selection > 0) {
                _selection--;
                if (hasFlag(wxLB_MULTIPLE)) {
                  _selectionStore.selectItem(_selection);
                }
                _setState();
                ensureVisible(_selection);
              }
              return KeyEventResult.handled;
              case LogicalKeyboardKey.arrowDown:
              if (_selection < _items.length-1) {
                _selection++;
                if (hasFlag(wxLB_MULTIPLE)) {
                  _selectionStore.selectItem(_selection);
                }
                _setState();
                ensureVisible(_selection);
              }
              return KeyEventResult.handled;
              case LogicalKeyboardKey.home:
              if (_selection != 0) {
                _selection = 0;
                _setState();
                ensureVisible(_selection);
              }
              return KeyEventResult.handled;
              case LogicalKeyboardKey.home:
              if (_selection < _items.length-1) {
                _selection = _items.length-1;
                _setState();
                ensureVisible(_selection);
              }
              return KeyEventResult.handled;
              case LogicalKeyboardKey.space:
                int sel = getSelection();
                if (sel != -1) {
                  if (hasFlag(wxLB_MULTIPLE)) {
                    _selectionStore.toggleItem(sel);
                    _setState();
                    final event = WxCommandEvent( wxGetListboxDClickEventType(), getId() );
                    event.setEventObject(this);
                    event.setInt(sel);
                    event.setString(getStringSelection());
                    event.setClientData( getClientData(sel) );
                    processEvent(event);
                  } else {
                    final event = WxCommandEvent( wxGetListboxDClickEventType(), getId() );
                    event.setEventObject(this);
                    event.setInt(sel);
                    event.setClientData( getClientData(sel) );
                    event.setString(getStringSelection());
                    processEvent(event);
                  }

                }
              return KeyEventResult.handled;
            }

          }
          return KeyEventResult.ignored;
        },
      child: 
      Listener(
        onPointerDown: (event)
        {
              if (!_hasFocus2) {
                if (_focusNode != null) {
                  _focusNode!.requestFocus();
                }
              }
        },
/*
  This version exposes the scrollController so that you could show the 
  scrollbar permanently:
scrollable_positioned_list:
git:
  url: https://github.com/nabil6391/flutter.widgets.git   
  ref: master
  path: packages/scrollable_positioned_list/
*/

        child:
        ScrollablePositionedList.builder(
          itemScrollController: _itemScrollController,
          itemPositionsListener: _itemPositionsListener,
          physics: ClampingScrollPhysics(),
          itemCount: _items.length,
          itemBuilder: (context,index)
          {
            final p = wxTheApp.getPrimaryAccentColour();
            final s = wxTheApp.getSecondaryAccentColour();
            Color accent = Color.fromARGB( p.alpha, p.red, p.green, p.blue );
            Color accentFocus = Color.fromARGB( s.alpha, s.red, s.green, s.blue );

            Color? background;
            if (hasFlag(wxLB_MULTIPLE)) {
              if (_selectionStore.isSelected(index))  {
                if (_hasFocus2) {
                  background = accent;
                } else {
                  background = wxTheApp.isDark() ? Colors.grey[600]! : Colors.grey[400]!;
                }
              }
            } else {
              if (index == _selection) {
                if (_hasFocus2) {
                  background = accent;
                } else {
                  background = wxTheApp.isDark() ? Colors.grey[600]! : Colors.grey[400]!;
                }
              }
            }
            Border? focusBorder;
            if ((hasFlag(wxLB_MULTIPLE)) && (index==_selection)) {
              focusBorder = Border.all( width:1, color: accentFocus );

            }
            return Listener(
              onPointerDown: (event) {
                if (!_hasFocus2) {
                  if (_focusNode != null) {
                    _focusNode!.requestFocus();
                  }
                }
                if (hasFlag(wxLB_MULTIPLE))
                {
                  final oldIndex =_selection;
                  _selection = index;
                  if ((!HardwareKeyboard.instance.isShiftPressed) &&
                    (!HardwareKeyboard.instance.isControlPressed)) {
                    _selectionStore.clear();
                  }
                  if ((HardwareKeyboard.instance.isShiftPressed) && (oldIndex!=-1)) {
                    if (oldIndex > _selection) {
                      for (int i = _selection; i <= oldIndex; i++) {
                        _selectionStore.selectItem( i);
                      }
                    } else {
                      for (int i = oldIndex; i <= _selection; i++) {
                        _selectionStore.selectItem( i);
                      }
                    }
                  } else {
                    _selectionStore.toggleItem(index);
                  }
                } 
                else 
                {
                  _selection = index;
                }
                _setState();
                final event = WxCommandEvent( wxGetListboxEventType(), getId() );
                event.setEventObject(this);
                event.setInt(index);
                event.setString(getStringSelection());
                event.setClientData( getClientData(index) );
                processEvent(event);
                
              },
              child: 
                Container (
                    decoration: BoxDecoration(
                      color: background,
                      border: focusBorder,
                    ),
                    child: Padding(
                        padding: EdgeInsetsGeometry.all( 
                          ((focusBorder==null)?2:1)
                          + (wxTheApp.isTouch()?7:0) ), 
                        child:  Text( _items[index].text) )
                 )
            );
          }
        ) 
      )
    
    ) );

    if (!hasFlag(wxNO_BORDER)) {
      finalWidget = DecoratedBox( 
        decoration: BoxDecoration(
           border: Border.all( 
             width: 0.5,
             color: wxTheApp.isDark() ? Colors.grey : Colors.black  
             ) ),
        child: Padding(padding: EdgeInsetsGeometry.all(1), child: finalWidget ) );
    } 

    return finalWidget;
  }
}
