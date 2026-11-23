// ---------------------------------------------------------------------------
// wxDart Web – browser runtime
//
// This tiny script owns the DOM. The Dart side (package:wx_dart_web)
// creates windows, menus and dialogs through the functions on `window.wxc`
// and receives every user interaction as a plain event object through a
// single dispatcher function registered with wxc.init().
//
// Every event object has the same shape (all fields always present):
//   { type, id, x, y, button, wheel, w, h, key, code, text, url,
//     ctrl, shift, alt, meta, leftDown, middleDown, rightDown, canVeto }
//
// The dispatcher returns true if the event was handled by the app, in
// which case the browser default action is suppressed.
//
// Licence: wxWindows licence
// ---------------------------------------------------------------------------

(function () {
  'use strict';

  /** id -> { id, kind, el, client, canvas, ctx, painting, needsPaint } */
  const wins = new Map();
  /** bitmap handle -> HTMLImageElement */
  const images = new Map();
  /** frame id -> { menus: [...] } */
  const menuBars = new Map();
  /** menu item id -> { item, row } */
  const menuItems = new Map();

  const dirty = new Set();
  const modalStack = [];
  let rafPending = false;
  let dispatcher = null;
  let root = null;
  let mainFrame = 0;
  let zCounter = 1000;
  let captureId = 0;
  let lastPointerId = 0;
  let measureBox = null;
  let measureCtx = null;
  let lastMouse = { x: 0, y: 0 };

  // ------------------------------------------------------------------ util

  function ev(type, id, extra) {
    const e = {
      type: type, id: id, x: 0, y: 0, button: 0, wheel: 0, w: 0, h: 0,
      key: '', code: '', text: '', url: '', ctrl: false, shift: false, alt: false, meta: false,
      leftDown: false, middleDown: false, rightDown: false, canVeto: false, files: null,
      dx: 0, dy: 0, zoom: 1, start: false, end: false
    };
    if (extra) Object.assign(e, extra);
    return e;
  }

  function send(e) {
    if (!dispatcher) return false;
    try {
      return dispatcher(e) === true;
    } catch (err) {
      console.error('wxc: exception in Dart event handler', err);
      return false;
    }
  }

  function dpr() { return window.devicePixelRatio || 1; }

  function container(parentId) {
    const p = wins.get(parentId);
    if (!p) return root;
    return p.client || p.el;
  }

  function wxIdOf(node) {
    const el = node && node.closest ? node.closest('[data-wxid]') : null;
    return el ? (+el.dataset.wxid) : 0;
  }

  function mods(e) {
    return { ctrl: e.ctrlKey, shift: e.shiftKey, alt: e.altKey, meta: e.metaKey };
  }

  // --------------------------------------------------------------- mouse

  function attachMouse(w, target) {
    w.mouseTarget = target;
    const own = (e) => wxIdOf(e.target) === w.id;
    const pos = (e) => {
      const r = target.getBoundingClientRect();
      return {
        x: Math.round(e.clientX - r.left), y: Math.round(e.clientY - r.top),
        leftDown: (e.buttons & 1) !== 0, rightDown: (e.buttons & 2) !== 0,
        middleDown: (e.buttons & 4) !== 0,
        ctrl: e.ctrlKey, shift: e.shiftKey, alt: e.altKey, meta: e.metaKey
      };
    };
    const captured = () => captureId === w.id;
    const custom = w.kind === 'window' || w.kind === 'frame' || w.kind === 'dialog';
    // with enableTouchEvents(), fingers produce gestures (see touchEvents)
    const gesture = (e) => e.pointerType === 'touch' && w.touchMask > 0;

    target.addEventListener('pointerdown', (e) => {
      if (!own(e)) return;
      if (gesture(e)) return;
      // clicks on the scroll bars of a scroll container are not for the app
      if (e.target === target && (e.offsetX >= target.clientWidth || e.offsetY >= target.clientHeight)) return;
      lastPointerId = e.pointerId;
      if (w.kind === 'window') target.focus({ preventScroll: true });
      const p = pos(e); p.button = e.button;
      if (send(ev('mousedown', w.id, p)) && custom) e.preventDefault();
    });
    target.addEventListener('pointerup', (e) => {
      if (!own(e) && !captured()) return;
      if (gesture(e)) return;
      const p = pos(e); p.button = e.button;
      send(ev('mouseup', w.id, p));
    });
    target.addEventListener('pointermove', (e) => {
      if (!own(e) && !captured()) return;
      if (gesture(e)) return;
      send(ev('motion', w.id, pos(e)));
    });
    target.addEventListener('dblclick', (e) => {
      if (!own(e)) return;
      const p = pos(e); p.button = e.button;
      send(ev('dclick', w.id, p));
    });
    target.addEventListener('pointerenter', (e) => send(ev('enter', w.id, pos(e))));
    target.addEventListener('pointerleave', (e) => send(ev('leave', w.id, pos(e))));
    target.addEventListener('wheel', (e) => {
      if (!own(e)) return;
      const p = pos(e);
      const scale = e.deltaMode === 1 ? 40 : (e.deltaMode === 2 ? 400 : 1.2);
      p.wheel = Math.round(-e.deltaY * scale);
      if (send(ev('wheel', w.id, p))) e.preventDefault();
    }, { passive: false });
    if (custom) {
      target.addEventListener('contextmenu', (e) => { if (own(e)) e.preventDefault(); });
    }
    // focus events (only for the element itself, they do not bubble)
    const focusTarget = w.kind === 'checkbox' || w.kind === 'slider' ? null : target;
    if (focusTarget) {
      focusTarget.addEventListener('focus', () => send(ev('setfocus', w.id)));
      focusTarget.addEventListener('blur', () => send(ev('killfocus', w.id)));
    }
  }

  // ------------------------------------------------------------- windows

  function createWindow(id, parentId, kind, style) {
    if (wins.has(id)) destroyWindow(id);
    const w = { id: id, kind: kind, el: null, client: null, canvas: null, ctx: null,
                painting: false, needsPaint: false, title: null };
    let el;
    switch (kind) {
      case 'frame': {
        el = document.createElement('div');
        el.className = 'wxc-frame wxc-hidden';
        const bar = document.createElement('div');
        bar.className = 'wxc-menubar wxc-hidden';
        const client = document.createElement('div');
        client.className = 'wxc-client';
        client.tabIndex = -1;
        el.appendChild(bar);
        el.appendChild(client);
        w.bar = bar;
        w.client = client;
        root.appendChild(el);
        if (!mainFrame) mainFrame = id;
        break;
      }
      case 'dialog': {
        el = document.createElement('div');
        el.className = 'wxc-backdrop wxc-hidden';
        const dlg = document.createElement('div');
        dlg.className = 'wxc-dialog';
        dlg.setAttribute('role', 'dialog');
        const title = document.createElement('div');
        title.className = 'wxc-titlebar';
        const text = document.createElement('span');
        text.className = 'wxc-title';
        const close = document.createElement('button');
        close.className = 'wxc-close';
        close.setAttribute('aria-label', 'Close');
        close.textContent = '×';
        close.tabIndex = -1;
        close.addEventListener('click', () => send(ev('close', id, { canVeto: true })));
        title.appendChild(text);
        title.appendChild(close);
        const client = document.createElement('div');
        client.className = 'wxc-client';
        client.tabIndex = -1;
        dlg.appendChild(title);
        dlg.appendChild(client);
        el.appendChild(dlg);
        const requestClose = () => send(ev('close', id, { canVeto: true }));
        makeDraggable(title, dlg, requestClose);
        // a bottom sheet closes when tapping beside it
        el.addEventListener('pointerdown', (e) => {
          if (e.target === el && el.classList.contains('wxc-sheet')) requestClose();
        });
        w.dialog = dlg;
        w.title = text;
        w.client = client;
        root.appendChild(el);
        break;
      }
      case 'button':
      case 'togglebutton': {
        el = document.createElement('button');
        el.className = 'wxc-button' + (kind === 'togglebutton' ? ' wxc-togglebutton' : '');
        el.type = 'button';
        w.btnLabel = el.appendChild(document.createElement('span'));
        w.btnLabel.className = 'wxc-btn-label';
        if (kind === 'togglebutton') {
          el.setAttribute('aria-pressed', 'false');
          el.addEventListener('click', () => {
            const on = el.getAttribute('aria-pressed') !== 'true';
            el.setAttribute('aria-pressed', on ? 'true' : 'false');
            send(ev('toggle', id, { x: on ? 1 : 0 }));
          });
        } else {
          el.addEventListener('click', () => send(ev('button', id)));
        }
        container(parentId).appendChild(el);
        break;
      }
      case 'staticline': {
        el = document.createElement('div');
        el.className = 'wxc-staticline' + ((style & 0x0008) ? ' wxc-staticline-v' : '');
        el.setAttribute('role', 'separator');
        container(parentId).appendChild(el);
        break;
      }
      case 'staticbitmap': {
        el = document.createElement('div');
        el.className = 'wxc-staticbitmap';
        w.sbCanvas = el.appendChild(document.createElement('canvas'));
        container(parentId).appendChild(el);
        break;
      }
      case 'staticbox': {
        el = document.createElement('div');
        el.className = 'wxc-staticbox';
        w.label = el.appendChild(document.createElement('div'));
        w.label.className = 'wxc-staticbox-label';
        w.client = el.appendChild(document.createElement('div'));
        w.client.className = 'wxc-staticbox-client';
        container(parentId).appendChild(el);
        break;
      }
      case 'radio': {
        el = document.createElement('label');
        el.className = 'wxc-checkbox wxc-radio';
        const r = el.appendChild(document.createElement('input'));
        r.type = 'radio';
        r.name = 'wxc-radio-' + id;
        w.label = el.appendChild(document.createElement('span'));
        r.addEventListener('change', () => { if (r.checked) send(ev('radio', id)); });
        w.input = r;
        container(parentId).appendChild(el);
        break;
      }
      case 'radiobox': {
        el = document.createElement('div');
        el.className = 'wxc-radiobox';
        el.setAttribute('role', 'radiogroup');
        w.label = el.appendChild(document.createElement('div'));
        w.label.className = 'wxc-staticbox-label';
        w.grid = el.appendChild(document.createElement('div'));
        w.grid.className = 'wxc-radiobox-grid';
        container(parentId).appendChild(el);
        break;
      }
      case 'spin': {
        el = document.createElement('input');
        el.type = 'number';
        el.className = 'wxc-text wxc-spin';
        el.addEventListener('input', () => send(ev('spin', id, { text: el.value })));
        el.addEventListener('change', () => send(ev('spin', id, { text: el.value, x: 1 })));
        container(parentId).appendChild(el);
        break;
      }
      case 'search': {
        el = document.createElement('div');
        el.className = 'wxc-search';
        const go = el.appendChild(document.createElement('button'));
        go.type = 'button'; go.tabIndex = -1; go.className = 'wxc-search-go';
        go.setAttribute('aria-label', 'Search');
        go.innerHTML = '<svg viewBox="0 0 24 24" width="16" height="16"><path d="M15.5 14h-.79l-.28-.27A6.47 6.47 0 0 0 16 9.5 6.5 6.5 0 1 0 9.5 16c1.61 0 3.09-.59 4.23-1.57l.27.28v.79l5 4.99L20.49 19l-4.99-5zm-6 0C7.01 14 5 11.99 5 9.5S7.01 5 9.5 5 14 7.01 14 9.5 11.99 14 9.5 14z"/></svg>';
        const input = el.appendChild(document.createElement('input'));
        input.type = 'text'; input.className = 'wxc-search-input'; input.spellcheck = false;
        const cancel = el.appendChild(document.createElement('button'));
        cancel.type = 'button'; cancel.tabIndex = -1; cancel.className = 'wxc-search-cancel';
        cancel.setAttribute('aria-label', 'Clear');
        cancel.textContent = '×';
        input.addEventListener('input', () => send(ev('text', id, { text: input.value })));
        go.addEventListener('click', () => { input.focus(); send(ev('search', id, { text: input.value })); });
        cancel.addEventListener('click', () => { input.focus(); send(ev('searchcancel', id)); });
        w.textInput = input; w.searchGo = go; w.searchCancel = cancel;
        container(parentId).appendChild(el);
        break;
      }
      case 'combobox': {
        el = document.createElement('div');
        el.className = 'wxc-combo';
        w.comboIcon = el.appendChild(document.createElement('canvas'));
        w.comboIcon.className = 'wxc-combo-icon';
        const input = el.appendChild(document.createElement('input'));
        input.type = 'text'; input.className = 'wxc-combo-input'; input.spellcheck = false;
        input.setAttribute('role', 'combobox'); input.setAttribute('aria-expanded', 'false');
        const arrow = el.appendChild(document.createElement('button'));
        arrow.type = 'button'; arrow.tabIndex = -1; arrow.className = 'wxc-combo-arrow';
        arrow.setAttribute('aria-label', 'Open');
        input.addEventListener('input', () => send(ev('text', id, { text: input.value })));
        arrow.addEventListener('pointerdown', (e) => { e.preventDefault(); input.focus(); comboToggle(w); });
        input.addEventListener('pointerdown', () => { if (input.readOnly) comboToggle(w); });
        w.textInput = input;
        w.combo = { items: [], sel: -1, hi: -1, popup: null };
        container(parentId).appendChild(el);
        break;
      }
      case 'collapsible': {
        el = document.createElement('div');
        el.className = 'wxc-collapsible';
        const head = el.appendChild(document.createElement('button'));
        head.type = 'button'; head.className = 'wxc-cp-header';
        head.setAttribute('aria-expanded', 'false');
        head.appendChild(document.createElement('span')).className = 'wxc-tb-chevron wxc-tb-closed';
        w.label = head.appendChild(document.createElement('span'));
        head.addEventListener('click', () => send(ev('collapsible', id)));
        w.cpHead = head;
        w.client = el.appendChild(document.createElement('div'));
        w.client.className = 'wxc-cp-client';
        container(parentId).appendChild(el);
        break;
      }
      case 'statictext': {
        el = document.createElement('div');
        el.className = 'wxc-statictext';
        container(parentId).appendChild(el);
        break;
      }
      case 'text':
      case 'password':
      case 'textarea': {
        el = document.createElement(kind === 'textarea' ? 'textarea' : 'input');
        if (kind !== 'textarea') el.type = kind;
        el.className = 'wxc-text' + (kind === 'textarea' ? ' wxc-textarea' : '');
        el.spellcheck = false;
        el.addEventListener('input', () => send(ev('text', id, { text: el.value })));
        container(parentId).appendChild(el);
        break;
      }
      case 'checkbox': {
        el = document.createElement('label');
        el.className = 'wxc-checkbox';
        const box = document.createElement('input');
        box.type = 'checkbox';
        const span = document.createElement('span');
        el.appendChild(box);
        el.appendChild(span);
        box.addEventListener('change', () => send(ev('checkbox', id, { x: box.checked ? 1 : 0 })));
        w.input = box;
        w.label = span;
        container(parentId).appendChild(el);
        break;
      }
      case 'choice': {
        el = document.createElement('select');
        el.className = 'wxc-choice';
        el.addEventListener('change', () => send(ev('choice', id, { x: el.selectedIndex })));
        w.input = el;
        container(parentId).appendChild(el);
        break;
      }
      case 'hyperlink': {
        el = document.createElement('a');
        el.className = 'wxc-hyperlink';
        el.target = '_blank';
        el.rel = 'noopener noreferrer';
        el.addEventListener('click', (e) => {
          e.preventDefault();
          send(ev('hyperlink', id, { url: el.href }));
        });
        container(parentId).appendChild(el);
        break;
      }
      case 'html': {
        el = document.createElement('div');
        el.className = 'wxc-html';
        el.tabIndex = -1;
        el.addEventListener('click', (e) => {
          const a = e.target.closest ? e.target.closest('a[href]') : null;
          if (!a || !el.contains(a)) return;
          e.preventDefault();
          const href = a.getAttribute('href');
          let url = href;
          try { url = new URL(href, w.baseUrl || document.baseURI).href; } catch (_) { /* keep */ }
          send(ev('htmllink', id, { text: href, url: url }));
        });
        container(parentId).appendChild(el);
        break;
      }
      case 'slider': {
        el = document.createElement('div');
        el.className = 'wxc-slider';
        el.innerHTML = '<span class="wxc-sl-min"></span><input type="range" step="1">' +
                       '<span class="wxc-sl-max"></span><span class="wxc-sl-val"></span>';
        const input = el.querySelector('input');
        input.addEventListener('input', () => {
          el.querySelector('.wxc-sl-val').textContent = input.value;
          send(ev('slider', id, { x: Math.round(+input.value) }));
        });
        w.input = input;
        container(parentId).appendChild(el);
        break;
      }
      case 'toolbar': {
        el = document.createElement('div');
        el.className = 'wxc-toolbar';
        el.setAttribute('role', 'toolbar');
        container(parentId).appendChild(el);
        break;
      }
      case 'listbox': {
        el = document.createElement('div');
        el.className = 'wxc-listbox';
        el.tabIndex = 0;
        el.setAttribute('role', 'listbox');
        w.lb = { items: [], selected: new Set(), current: -1, anchor: -1, mode: 0 };
        lbAttach(w, el);
        container(parentId).appendChild(el);
        break;
      }
      case 'gauge': {
        el = document.createElement('div');
        el.className = 'wxc-gauge';
        el.setAttribute('role', 'progressbar');
        const bar = document.createElement('div');
        bar.className = 'wxc-gauge-bar';
        el.appendChild(bar);
        w.bar = bar;
        container(parentId).appendChild(el);
        break;
      }
      case 'popup': {
        el = document.createElement('div');
        el.className = 'wxc-popup wxc-hidden';
        el.style.zIndex = String(zCounter + 50);
        root.appendChild(el);
        break;
      }
      case 'glcanvas': {
        el = document.createElement('div');
        el.className = 'wxc-window wxc-glcanvas';
        el.tabIndex = -1;
        const c = document.createElement('canvas');
        c.className = 'wxc-gl';
        c.width = c.height = 1;
        el.appendChild(c);
        w.glc = c;
        container(parentId).appendChild(el);
        break;
      }
      case 'activity': {
        el = document.createElement('div');
        el.className = 'wxc-activity';
        el.setAttribute('role', 'progressbar');
        el.setAttribute('aria-busy', 'false');
        el.appendChild(document.createElement('div')).className = 'wxc-activity-ring';
        container(parentId).appendChild(el);
        break;
      }
      case 'animation': {
        el = document.createElement('div');
        el.className = 'wxc-animation';
        const canvas = document.createElement('canvas');
        canvas.width = canvas.height = 1;
        el.appendChild(canvas);
        w.anim = { canvas: canvas, handle: 0, playing: false, frame: 0, timer: 0, inactive: 0 };
        container(parentId).appendChild(el);
        break;
      }
      case 'notebook':
      case 'treebook':
      case 'navigation': {
        el = document.createElement('div');
        const side = kind === 'navigation' ? 'bottom'
          : (style & 0x40) ? 'left' : (style & 0x80) ? 'right' : (style & 0x20) ? 'bottom' : 'top';
        el.className = 'wxc-book wxc-book-' + (kind === 'treebook' ? 'left' : side);
        if (kind === 'navigation') el.classList.add('wxc-nav');
        const head = document.createElement('div');
        head.tabIndex = 0;
        const client = document.createElement('div');
        client.className = 'wxc-book-client';
        client.tabIndex = -1;
        el.appendChild(head);
        el.appendChild(client);
        w.head = head;
        w.client = client;
        w.book = { kind: kind, pages: [], sel: -1, vertical: side === 'left' || side === 'right' };
        if (kind === 'treebook') {
          head.className = 'wxc-tb-tree';
          head.setAttribute('role', 'tree');
        } else if (kind === 'navigation') {
          head.className = 'wxc-nav-bar';
          head.setAttribute('role', 'tablist');
        } else {
          head.className = 'wxc-nb-tabs';
          head.setAttribute('role', 'tablist');
        }
        bookAttach(w);
        container(parentId).appendChild(el);
        break;
      }
      default: {
        el = document.createElement('div');
        el.className = 'wxc-window';
        el.tabIndex = -1;
        container(parentId).appendChild(el);
        break;
      }
    }
    el.dataset.wxid = id;
    if (w.client) w.client.dataset.wxid = id;
    w.el = el;
    wins.set(id, w);
    attachMouse(w, w.client || el);

    if (kind === 'frame' || kind === 'dialog') {
      const ro = new ResizeObserver(() => {
        const c = w.client;
        if (c.clientWidth === 0 && c.clientHeight === 0) return; // hidden
        send(ev('size', id, { w: c.clientWidth, h: c.clientHeight }));
      });
      ro.observe(w.client);
      w.ro = ro;
    }
  }

  function destroyWindow(id) {
    const w = wins.get(id);
    if (!w) return;
    if (w.ro) w.ro.disconnect();
    if (w.hist) frameHistory(id, false);
    // forget all windows living inside this one
    for (const [cid, c] of wins) {
      if (cid !== id && w.el.contains(c.el)) { wins.delete(cid); dirty.delete(cid); }
    }
    for (const [, c] of wins) {
      if (c === w || w.el.contains(c.el)) {
        if (c.anim) clearTimeout(c.anim.timer);
        if (c.gl) { const lose = c.gl.getExtension('WEBGL_lose_context'); if (lose) lose.loseContext(); }
      }
    }
    if (openCombo && (openCombo === w || w.el.contains(openCombo.el))) comboClose(openCombo);
    if (w.popupOff) { w.popupOff(); w.popupOff = null; }
    w.el.remove();
    wins.delete(id);
    dirty.delete(id);
    const i = modalStack.indexOf(id);
    if (i >= 0) modalStack.splice(i, 1);
    if (mainFrame === id) mainFrame = 0;
    if (captureId === id) captureId = 0;
    menuBars.delete(id);
  }

  function setRect(id, x, y, width, height) {
    const w = wins.get(id);
    if (!w) return;
    if (w.kind === 'frame') return;           // frames always fill the viewport
    if (w.el.classList.contains('wxc-frame-toolbar')) return; // laid out by the frame
    if (w.kind === 'dialog') {               // size refers to the client area
      w.client.style.width = width >= 0 ? width + 'px' : '';
      w.client.style.height = height >= 0 ? height + 'px' : '';
    } else {
      const s = w.el.style;
      s.left = (x >= 0 ? x : 0) + 'px';
      s.top = (y >= 0 ? y : 0) + 'px';
      s.width = width >= 0 ? width + 'px' : '';
      s.height = height >= 0 ? height + 'px' : '';
      if (w.glc) {
        // the drawing buffer has the size of the window (1 pixel per DIP as in
        // wxDart Flutter); resizing it clears it, the app redraws on WxSizeEvent
        const gw = Math.max(1, width), gh = Math.max(1, height);
        if (w.glc.width !== gw) w.glc.width = gw;
        if (w.glc.height !== gh) w.glc.height = gh;
      }
    }
    if (w.canvas) refresh(id);
  }

  function measure(id, width) {
    const w = wins.get(id);
    if (!w) return { w: 0, h: 0 };
    if (!measureBox) {
      measureBox = document.createElement('div');
      measureBox.className = 'wxc-measure';
      document.body.appendChild(measureBox);
    }
    const clone = w.el.cloneNode(true);
    clone.style.left = '0px';
    clone.style.top = '0px';
    clone.style.width = width > 0 ? width + 'px' : '';
    clone.style.height = '';
    clone.classList.remove('wxc-hidden');
    measureBox.appendChild(clone);
    const r = { w: Math.ceil(clone.offsetWidth), h: Math.ceil(clone.offsetHeight) };
    clone.remove();
    return r;
  }

  function clientSize(id) {
    const w = wins.get(id);
    if (!w) return { w: 0, h: 0 };
    const c = w.client || w.el;
    return { w: c.clientWidth, h: c.clientHeight };
  }

  function setLabel(id, text) {
    const w = wins.get(id);
    if (!w) return;
    if (w.kind === 'frame') {
      if (id === mainFrame) document.title = text;
      if (w.chrome) { w.chrome.title = text; frameChromeRender(w); }
    } else if (w.kind === 'dialog') {
      w.title.textContent = text;
    } else if (w.kind === 'checkbox' || w.kind === 'radio' || w.kind === 'collapsible') {
      w.label.textContent = text;
    } else if (w.kind === 'staticbox' || w.kind === 'radiobox') {
      w.label.textContent = text;
      w.label.style.display = text ? '' : 'none';
    } else if (w.btnLabel) {
      w.btnLabel.textContent = text;
    } else if (w.kind === 'statictext' || w.kind === 'hyperlink') {
      w.el.textContent = text;
    }
  }

  function setTextAlign(id, align, wrap) {
    const w = wins.get(id);
    if (!w) return;
    w.el.style.textAlign = align;
    w.el.classList.toggle('wxc-wrap', !!wrap);
  }

  function show(id, visible) {
    const w = wins.get(id);
    if (!w) return;
    w.el.classList.toggle('wxc-hidden', !visible);
    if (visible) {
      if (w.kind === 'dialog' || w.kind === 'frame') w.el.style.zIndex = String(++zCounter);
      // repaint canvases that could not be painted while hidden
      for (const c of wins.values()) {
        if (c.canvas && c.needsPaint && w.el.contains(c.el)) refresh(c.id);
      }
    }
  }

  function enable(id, enabled) {
    const w = wins.get(id);
    if (!w) return;
    if (w.kind === 'button' || w.kind === 'togglebutton' || w.kind === 'text' || w.kind === 'password' ||
        w.kind === 'textarea' || w.kind === 'spin' || w.kind === 'collapsible') {
      (w.cpHead || w.el).disabled = !enabled;
    }
    if (w.kind === 'search' || w.kind === 'combobox' || w.kind === 'radiobox') {
      w.el.querySelectorAll('input,button').forEach((e) => {
        e.disabled = !enabled || (w.rbOff && w.rbOff.has(+e.dataset.i));
      });
      w.disabled = !enabled;
      if (!enabled && w.combo) comboClose(w);
    }
    if (w.input) w.input.disabled = !enabled;
    w.el.classList.toggle('wxc-disabled', !enabled);
  }

  function setColours(id, fg, bg) {
    const w = wins.get(id);
    if (!w) return;
    const t = w.client || w.el;
    t.style.color = fg;
    t.style.backgroundColor = bg;
    if (w.canvas) refresh(id);
  }

  function setFont(id, css) {
    const w = wins.get(id);
    if (!w) return;
    (w.client || w.el).style.font = css;
  }

  function setToolTip(id, text) {
    const w = wins.get(id);
    if (w) w.el.title = text;
  }

  function setFocus(id) {
    const w = wins.get(id);
    if (w) (w.textInput || w.cpHead || w.client || w.el).focus({ preventScroll: true });
  }

  function hasFocus(id) {
    const a = document.activeElement;
    return !!a && wxIdOf(a) === id;
  }

  function setDefaultButton(id) {
    const w = wins.get(id);
    if (w) w.el.classList.add('wxc-default');
  }

  function captureMouse(id) {
    const w = wins.get(id);
    if (!w) return;
    captureId = id;
    try { (w.client || w.el).setPointerCapture(lastPointerId); } catch (_) { /* no active pointer */ }
  }

  function releaseMouse(id) {
    const w = wins.get(id);
    if (captureId === id) captureId = 0;
    if (!w) return;
    try { (w.client || w.el).releasePointerCapture(lastPointerId); } catch (_) { /* ignore */ }
  }

  // -------------------------------------------------------------- dialogs

  // A dialog is moved by its title bar. A bottom sheet can only be pulled
  // down: far enough, and it closes (onClose), otherwise it snaps back.
  const SHEET_CLOSE_DISTANCE = 80;

  function makeDraggable(handle, box, onClose) {
    let sx = 0, sy = 0, ox = 0, oy = 0, dragging = false;
    const isSheet = () => box.parentElement && box.parentElement.classList.contains('wxc-sheet');
    handle.addEventListener('pointerdown', (e) => {
      if (e.target.closest('.wxc-close')) return;
      dragging = true;
      sx = e.clientX; sy = e.clientY;
      ox = box._dx || 0; oy = box._dy || 0;
      handle.setPointerCapture(e.pointerId);
      if (isSheet()) box.classList.add('wxc-sheet-dragging');
    });
    handle.addEventListener('pointermove', (e) => {
      if (!dragging) return;
      if (isSheet()) {
        box._dx = 0;
        box._dy = Math.max(0, e.clientY - sy);
        box.style.transform = `translateY(${box._dy}px)`;
        return;
      }
      box._dx = ox + e.clientX - sx;
      box._dy = oy + e.clientY - sy;
      box.style.transform = `translate(${box._dx}px, ${box._dy}px)`;
    });
    const end = () => {
      if (!dragging) return;
      dragging = false;
      if (!isSheet()) return;
      box.classList.remove('wxc-sheet-dragging');
      const pulled = box._dy || 0;
      box._dy = 0;
      box.style.transform = '';
      if (pulled > SHEET_CLOSE_DISTANCE && onClose) onClose();
    };
    handle.addEventListener('pointerup', end);
    handle.addEventListener('pointercancel', end);
  }

  // sheet: shown as a bottom sheet sliding up (touch devices); its title
  // has the accent colour only with caption (wxCAPTION), as in wxDart Flutter
  function showModal(id, sheet, caption) {
    const w = wins.get(id);
    if (!w) return;
    closeMenus();
    modalStack.push(id);
    w.el.classList.remove('wxc-modeless');
    w.el.classList.toggle('wxc-sheet', !!sheet);
    w.el.classList.toggle('wxc-sheet-plain', !!sheet && !caption);
    if (sheet && w.dialog) {
      w.dialog._dx = 0; w.dialog._dy = 0;
      w.dialog.style.transform = '';
    }
    show(id, true);
    // focus the default button, else the first button, else the dialog
    const btn = w.client.querySelector('.wxc-default:not(:disabled)') ||
                w.client.querySelector('button:not(:disabled)');
    (btn || w.client).focus({ preventScroll: true });
  }

  function endModal(id) {
    const i = modalStack.indexOf(id);
    if (i >= 0) modalStack.splice(i, 1);
    show(id, false);
  }

  function showModeless(id, visible) {
    const w = wins.get(id);
    if (!w) return;
    w.el.classList.add('wxc-modeless');
    show(id, visible);
  }

  // ---------------------------------------------------------------- paint

  function enablePaint(id) {
    const w = wins.get(id);
    if (!w || w.canvas) return;
    if (w.glc) { w.canvas = w.glc; w.ctx = null; refresh(id); return; }
    const c = document.createElement('canvas');
    c.className = 'wxc-canvas';
    const host = w.client || w.el;
    host.insertBefore(c, host.firstChild);
    w.canvas = c;
    w.ctx = c.getContext('2d');
    refresh(id);
  }

  function refresh(id) {
    const w = wins.get(id);
    if (!w || !w.canvas) return;
    dirty.add(id);
    if (!rafPending) {
      rafPending = true;
      requestAnimationFrame(flushPaint);
    }
  }

  function flushPaint() {
    rafPending = false;
    const ids = Array.from(dirty);
    dirty.clear();
    for (const id of ids) paintOne(id);
  }

  function paintOne(id) {
    const w = wins.get(id);
    if (!w || !w.canvas) return;
    if (w.glc) { send(ev('paint', id, { w: w.glc.width, h: w.glc.height })); return; }
    const host = w.client || w.el;
    const cw = host.clientWidth, ch = host.clientHeight;
    if (cw === 0 || ch === 0) { w.needsPaint = true; return; }
    w.needsPaint = false;
    const r = dpr();
    const pw = Math.max(1, Math.round(cw * r)), ph = Math.max(1, Math.round(ch * r));
    const c = w.canvas;
    if (c.width !== pw) c.width = pw;
    if (c.height !== ph) c.height = ph;
    if (w.extent) {
      c.style.left = host.scrollLeft + 'px';
      c.style.top = host.scrollTop + 'px';
    }
    const ctx = w.ctx;
    ctx.setTransform(1, 0, 0, 1, 0, 0);
    ctx.clearRect(0, 0, pw, ph);
    ctx.setTransform(r, 0, 0, r, 0, 0);
    ctx.save();
    w.painting = true;
    try {
      send(ev('paint', id, { w: cw, h: ch }));
    } finally {
      w.painting = false;
      ctx.restore();
    }
  }

  function paintContext(id) {
    const w = wins.get(id);
    return (w && w.painting) ? w.ctx : null;
  }

  // --------------------------------------------------------------- images

  function loadImage(handle, url) {
    const img = new Image();
    img.decoding = 'async';
    img.onload = () => send(ev('imageload', handle, { w: img.naturalWidth, h: img.naturalHeight }));
    img.onerror = () => send(ev('imageerror', handle));
    images.set(handle, img);
    img.src = url;
  }

  function getImage(handle) { return images.get(handle) || null; }
  function freeImage(handle) { images.delete(handle); }

  function measureText(font, text) {
    if (!measureCtx) measureCtx = document.createElement('canvas').getContext('2d');
    measureCtx.font = font;
    const m = measureCtx.measureText(text);
    const ascent = m.fontBoundingBoxAscent !== undefined ? m.fontBoundingBoxAscent : m.actualBoundingBoxAscent;
    const descent = m.fontBoundingBoxDescent !== undefined ? m.fontBoundingBoxDescent : m.actualBoundingBoxDescent;
    return { w: m.width, ascent: ascent || 0, descent: descent || 0 };
  }

  // ------------------------------------------------------------- controls

  function el(id) { const w = wins.get(id); return w ? (w.textInput || w.el) : null; }

  function textGet(id) { const e = el(id); return e ? e.value : ''; }

  function textSet(id, value) { const e = el(id); if (e) e.value = value; }

  function textReplace(id, from, to, text) {
    const e = el(id);
    if (!e) return;
    const len = e.value.length;
    if (from < 0) from = e.selectionStart;
    if (to < 0) to = (from === e.selectionStart) ? e.selectionEnd : len;
    e.setRangeText(text, Math.min(from, len), Math.min(to, len), 'end');
  }

  function textSelection(id) {
    const e = el(id);
    if (!e) return { from: 0, to: 0 };
    return { from: e.selectionStart || 0, to: e.selectionEnd || 0 };
  }

  function textSetSelection(id, from, to) {
    const e = el(id);
    if (!e) return;
    const len = e.value.length;
    if (from < 0 && to < 0) { from = 0; to = len; }
    if (to < 0) to = len;
    e.setSelectionRange(Math.min(from, len), Math.min(to, len));
  }

  function textCommand(id, cmd) {
    const e = el(id);
    if (!e) return;
    e.focus({ preventScroll: true });
    if (cmd === 'paste') {
      if (navigator.clipboard && navigator.clipboard.readText) {
        navigator.clipboard.readText().then((t) => {
          e.setRangeText(t, e.selectionStart, e.selectionEnd, 'end');
          send(ev('text', id, { text: e.value }));
        }).catch(() => { /* permission denied */ });
      }
      return;
    }
    try { document.execCommand(cmd); } catch (_) { /* unsupported */ }
  }

  function textSetOptions(id, editable, maxLength, hint, align, wrap) {
    const e = el(id);
    if (!e) return;
    e.readOnly = !editable;
    if (maxLength > 0) e.maxLength = maxLength; else e.removeAttribute('maxlength');
    e.placeholder = hint;
    e.style.textAlign = align;
    if (e.tagName === 'TEXTAREA') e.wrap = wrap ? 'soft' : 'off';
  }

  function checkSet(id, state) {
    const w = wins.get(id);
    if (!w || !w.input) return;
    w.input.checked = state === 1;
    w.input.indeterminate = state === 2;
  }

  function choiceSetItems(id, json, selection) {
    const w = wins.get(id);
    if (!w) return;
    const items = JSON.parse(json);
    w.el.textContent = '';
    for (const text of items) {
      const o = document.createElement('option');
      o.textContent = text;
      w.el.appendChild(o);
    }
    w.el.selectedIndex = selection;
  }

  function choiceSelect(id, index) {
    const e = el(id);
    if (e) e.selectedIndex = index;
  }

  function linkSet(id, url, normal, hover, visited, isVisited) {
    const e = el(id);
    if (!e) return;
    e.href = url;
    e.style.setProperty('--wxc-link', normal);
    e.style.setProperty('--wxc-link-hover', hover);
    e.style.setProperty('--wxc-link-visited', visited);
    e.classList.toggle('wxc-visited', !!isVisited);
  }

  function openUrl(url) {
    window.open(url, '_blank', 'noopener,noreferrer');
  }

  // Removes everything that could run code or change the page outside
  // of the html window. Not a full sanitizer: only pass HTML you trust.
  function sanitize(html) {
    const doc = new DOMParser().parseFromString(html, 'text/html');
    doc.querySelectorAll('script,iframe,object,embed,link,meta,base,style,frame,frameset')
       .forEach((n) => n.remove());
    doc.body.querySelectorAll('*').forEach((n) => {
      for (const a of Array.from(n.attributes)) {
        const name = a.name.toLowerCase();
        const value = a.value.trim().toLowerCase().replace(/\s+/g, '');
        if (name.startsWith('on')) n.removeAttribute(a.name);
        else if ((name === 'href' || name === 'src' || name === 'action' || name === 'formaction' ||
                  name === 'xlink:href') && value.startsWith('javascript:')) n.removeAttribute(a.name);
      }
    });
    return doc.body.innerHTML;
  }

  function htmlSet(id, html, append) {
    const w = wins.get(id);
    if (!w) return;
    const clean = sanitize(html);
    if (append) w.el.insertAdjacentHTML('beforeend', clean);
    else { w.el.innerHTML = clean; w.el.scrollTop = 0; }
  }

  function htmlLoad(id, url) {
    const w = wins.get(id);
    if (!w) return;
    let abs = url;
    try { abs = new URL(url, w.baseUrl || document.baseURI).href; } catch (_) { /* keep */ }
    fetch(abs).then((r) => {
      if (!r.ok) throw new Error(String(r.status));
      return r.text();
    }).then((text) => {
      if (!wins.has(id)) return;
      w.baseUrl = abs;
      htmlSet(id, text, false);
      const hash = abs.indexOf('#');
      if (hash >= 0) htmlScrollTo(id, abs.substring(hash + 1));
      send(ev('htmlloaded', id, { url: abs }));
    }).catch(() => send(ev('htmlerror', id, { url: abs })));
  }

  function htmlScrollTo(id, anchor) {
    const w = wins.get(id);
    if (!w) return;
    const target = w.el.querySelector('#' + CSS.escape(anchor)) ||
                   w.el.querySelector('a[name="' + CSS.escape(anchor) + '"]');
    if (target) w.el.scrollTop = target.offsetTop - w.el.offsetTop;
  }

  // flags: 1 vertical, 2 min/max labels, 4 value label, 8 inverse
  function sliderSet(id, value, min, max, flags) {
    const w = wins.get(id);
    if (!w || !w.input) return;
    const i = w.input;
    i.min = String(min);
    i.max = String(max);
    i.value = String(value);
    w.el.classList.toggle('wxc-vertical', (flags & 1) !== 0);
    w.el.classList.toggle('wxc-minmax', (flags & 2) !== 0);
    w.el.classList.toggle('wxc-value', (flags & 4) !== 0);
    w.el.classList.toggle('wxc-inverse', (flags & 8) !== 0);
    w.el.querySelector('.wxc-sl-min').textContent = String(min);
    w.el.querySelector('.wxc-sl-max').textContent = String(max);
    w.el.querySelector('.wxc-sl-val').textContent = String(value);
  }

  function gaugeSet(id, value, range, vertical, pulse) {
    const w = wins.get(id);
    if (!w || !w.bar) return;
    const pct = range > 0 ? Math.max(0, Math.min(100, value * 100 / range)) : 0;
    w.el.classList.toggle('wxc-vertical', !!vertical);
    w.el.classList.toggle('wxc-pulse', !!pulse);
    if (vertical) { w.bar.style.height = pct + '%'; w.bar.style.width = ''; }
    else { w.bar.style.width = pct + '%'; w.bar.style.height = ''; }
    w.el.setAttribute('aria-valuenow', String(value));
    w.el.setAttribute('aria-valuemax', String(range));
  }

  // ------------------------------------------------------ image <-> bitmap

  function imageFromRGBA(handle, width, height, data) {
    const c = document.createElement('canvas');
    c.width = Math.max(1, width);
    c.height = Math.max(1, height);
    if (width > 0 && height > 0) {
      const pixels = new Uint8ClampedArray(data.buffer, data.byteOffset, width * height * 4);
      c.getContext('2d').putImageData(new ImageData(pixels, width, height), 0, 0);
    }
    images.set(handle, c);
  }

  // a scaled copy of the image src (WxBitmapBundle.getBitmapForSize)
  function scaleImage(handle, src, width, height) {
    const s = images.get(src);
    const c = document.createElement('canvas');
    c.width = Math.max(1, width);
    c.height = Math.max(1, height);
    if (s) {
      const ctx = c.getContext('2d');
      ctx.imageSmoothingQuality = 'high';
      ctx.drawImage(s, 0, 0, c.width, c.height);
    }
    images.set(handle, c);
  }

  function imageToRGBA(handle, width, height) {
    const src = images.get(handle);
    if (!src || width <= 0 || height <= 0) return new Uint8Array(0);
    const c = document.createElement('canvas');
    c.width = width;
    c.height = height;
    const ctx = c.getContext('2d', { willReadFrequently: true });
    ctx.drawImage(src, 0, 0, width, height);
    try {
      const d = ctx.getImageData(0, 0, width, height).data;
      return new Uint8Array(d.buffer, d.byteOffset, d.length);
    } catch (err) {
      console.error('wxc: cannot read pixels (cross-origin image?)', err);
      return new Uint8Array(0);
    }
  }

  // ------------------------------------------------------------- scrolling
  //
  // The scroll target (a WxScrolledWindow or its target window) becomes a
  // native scroll container: wheel, touch, scroll bars and keyboard scroll
  // natively. An invisible "extent" element defines the virtual size; the
  // children scroll with the content while the canvas stays in view.

  function onScroll(w) {
    const host = w.client || w.el;
    if (w.canvas) {
      w.canvas.style.left = host.scrollLeft + 'px';
      w.canvas.style.top = host.scrollTop + 'px';
      refresh(w.id);
    }
    send(ev('scroll', w.id, { x: Math.round(host.scrollLeft), y: Math.round(host.scrollTop) }));
  }

  // hmode/vmode: 'auto', 'scroll' (always) or 'hidden'; ownerId 0 ends scrolling
  function setScrollTarget(id, ownerId, hmode, vmode) {
    const w = wins.get(id);
    if (!w) return;
    const host = w.client || w.el;
    if (!ownerId) {
      host.classList.remove('wxc-scrolling');
      host.style.overflowX = '';
      host.style.overflowY = '';
      if (w.extent) { w.extent.remove(); w.extent = null; }
      host.scrollLeft = 0;
      host.scrollTop = 0;
      if (w.canvas) { w.canvas.style.left = '0px'; w.canvas.style.top = '0px'; }
      return;
    }
    host.classList.add('wxc-scrolling');
    host.style.overflowX = hmode;
    host.style.overflowY = vmode;
    if (!w.extent) {
      w.extent = document.createElement('div');
      w.extent.className = 'wxc-extent';
      host.appendChild(w.extent);
      if (!w.scrollListener) {
        w.scrollListener = () => { if (w.extent) onScroll(w); };
        host.addEventListener('scroll', w.scrollListener, { passive: true });
      }
    }
  }

  function setVirtualSize(id, width, height) {
    const w = wins.get(id);
    if (!w || !w.extent) return;
    w.extent.style.width = Math.max(0, width) + 'px';
    w.extent.style.height = Math.max(0, height) + 'px';
  }

  function scrollTo(id, x, y) {
    const w = wins.get(id);
    if (!w) return;
    const host = w.client || w.el;
    if (x >= 0) host.scrollLeft = x;
    if (y >= 0) host.scrollTop = y;
  }

  function scrollPos(id) {
    const w = wins.get(id);
    if (!w) return { x: 0, y: 0 };
    const host = w.client || w.el;
    return { x: Math.round(host.scrollLeft), y: Math.round(host.scrollTop) };
  }

  // -------------------------------------------------------------- toolbar
  //
  // JSON: { vertical, text, noicons, separation,
  //         tools: [{ id, kind, label, help, enabled, toggled, bitmap, bw, bh, control }] }
  // kind: normal|check|radio|dropdown|separator|stretch|control

  function drawIcon(canvas, handle, bw, bh) {
    const img = images.get(handle);
    if (!img) return;
    const draw = () => {
      const w = bw > 0 ? bw : (img.naturalWidth || img.width || 16);
      const h = bh > 0 ? bh : (img.naturalHeight || img.height || 16);
      const r = dpr();
      canvas.style.width = w + 'px';
      canvas.style.height = h + 'px';
      canvas.width = Math.max(1, Math.round(w * r));
      canvas.height = Math.max(1, Math.round(h * r));
      const ctx = canvas.getContext('2d');
      ctx.clearRect(0, 0, canvas.width, canvas.height);
      ctx.drawImage(img, 0, 0, canvas.width, canvas.height);
    };
    if (img.tagName === 'IMG' && !(img.complete && img.naturalWidth)) {
      if (bw > 0 && bh > 0) { canvas.style.width = bw + 'px'; canvas.style.height = bh + 'px'; }
      img.addEventListener('load', draw, { once: true });
    } else {
      draw();
    }
  }

  function toolbarSet(id, json) {
    const w = wins.get(id);
    if (!w) return;
    const data = JSON.parse(json);
    const tb = w.el;
    // keep the elements of controls placed in the toolbar
    const keep = [];
    for (const t of data.tools) {
      if (t.kind === 'control') {
        const c = wins.get(t.control);
        if (c) { keep.push(c); c.el.remove(); }
      }
    }
    tb.textContent = '';
    tb.classList.toggle('wxc-vertical', !!data.vertical);
    tb.classList.toggle('wxc-tb-text', !!data.text);
    tb.classList.toggle('wxc-tb-noicons', !!data.noicons);
    tb.style.setProperty('--wxc-tool-gap', data.separation + 'px');
    data.tools.forEach((t, index) => {
      if (t.kind === 'separator') {
        const sep = document.createElement('div');
        sep.className = 'wxc-tool-sep';
        tb.appendChild(sep);
        return;
      }
      if (t.kind === 'stretch') {
        const sp = document.createElement('div');
        sp.className = 'wxc-tool-stretch';
        tb.appendChild(sp);
        return;
      }
      if (t.kind === 'control') {
        const slot = document.createElement('div');
        slot.className = 'wxc-tool-control';
        const c = wins.get(t.control);
        if (c) slot.appendChild(c.el);
        if (t.label && data.text) {
          const l = document.createElement('span');
          l.className = 'wxc-tool-label';
          l.textContent = t.label;
          slot.appendChild(l);
        }
        tb.appendChild(slot);
        return;
      }
      const b = document.createElement('button');
      b.type = 'button';
      b.className = 'wxc-tool';
      b.tabIndex = -1;
      b.disabled = !t.enabled;
      if (t.help) b.title = t.help;
      if (t.kind === 'check' || t.kind === 'radio') b.setAttribute('aria-pressed', t.toggled ? 'true' : 'false');
      b.classList.toggle('wxc-toggled', !!t.toggled);
      if (t.bitmap && !data.noicons) {
        const icon = document.createElement('canvas');
        icon.className = 'wxc-tool-icon';
        drawIcon(icon, t.bitmap, t.bw, t.bh);
        b.appendChild(icon);
      }
      if (data.text || !t.bitmap || data.noicons) {
        const l = document.createElement('span');
        l.className = 'wxc-tool-label';
        l.textContent = t.label;
        b.appendChild(l);
      }
      b.addEventListener('click', () => send(ev('tool', id, { x: index })));
      b.addEventListener('pointerenter', () => send(ev('toolenter', id, { x: index })));
      b.addEventListener('pointerleave', () => send(ev('toolenter', id, { x: -1 })));
      if (t.kind === 'dropdown') {
        const group = document.createElement('div');
        group.className = 'wxc-tool-group';
        const arrow = document.createElement('button');
        arrow.type = 'button';
        arrow.className = 'wxc-tool wxc-tool-arrow';
        arrow.tabIndex = -1;
        arrow.disabled = !t.enabled;
        // an SVG triangle: the glyph '▾' depends on the font and is tiny
        arrow.innerHTML = '<svg class="wxc-tool-arrow-icon" width="8" height="5" viewBox="0 0 8 5" aria-hidden="true">'
          + '<path d="M0 0H8L4 5Z" fill="currentColor"/></svg>';
        arrow.addEventListener('click', () => {
          const r = group.getBoundingClientRect();
          const o = tb.getBoundingClientRect();
          send(ev('tooldropdown', id, { x: index, w: Math.round(r.left - o.left), y: Math.round(r.bottom - o.top) }));
        });
        group.appendChild(b);
        group.appendChild(arrow);
        tb.appendChild(group);
      } else {
        tb.appendChild(b);
      }
    });
    // controls not listed anymore stay children of the toolbar (hidden)
    for (const c of keep) if (!c.el.isConnected) { c.el.classList.add('wxc-hidden'); tb.appendChild(c.el); }
    if (w.appbar) appBarTitle(w);
    if (w.frameId) frameChromeRender(wins.get(w.frameId));
  }

  function attachToolBar(frameId, toolbarId) {
    const f = wins.get(frameId);
    const t = wins.get(toolbarId);
    if (!f || !t || !f.client) return;
    t.el.classList.add('wxc-frame-toolbar');
    t.el.style.left = t.el.style.top = t.el.style.width = t.el.style.height = '';
    f.el.insertBefore(t.el, f.client);
    f.toolbarId = toolbarId;
    t.frameId = frameId;
    frameChromeRender(f);
  }

  // ------------------------------------------------------------- mobile
  //
  // Secondary frames fill the viewport like the main frame and get a back
  // arrow (and a browser history entry, so that the back button of the
  // browser or of the phone works). WxAdaptiveFrame adds an app bar, a
  // drawer and a floating action button; WxNavigationCtrl is a book with
  // its tabs at the bottom.

  const ICONS = {
    back: 'M20 11H7.83l5.59-5.59L12 4l-8 8 8 8 1.41-1.41L7.83 13H20v-2z',
    menu: 'M3 18h18v-2H3v2zm0-5h18v-2H3v2zm0-7v2h18V6H3z',
  };

  function iconButton(kind, label) {
    const b = document.createElement('button');
    b.type = 'button';
    b.className = 'wxc-chrome-button';
    b.setAttribute('aria-label', label);
    b.title = label;
    b.innerHTML = '<svg viewBox="0 0 24 24" width="24" height="24"><path d="' + ICONS[kind] + '"/></svg>';
    return b;
  }

  // state: { back, menu, title }; called by Dart whenever it changes
  function frameChrome(id, back, menu, title) {
    const f = wins.get(id);
    if (!f || f.kind !== 'frame') return;
    f.chrome = { back: !!back, menu: !!menu, title: title || '' };
    frameChromeRender(f);
  }

  function visibleBar(barId) {
    const b = barId && wins.get(barId);
    return b && b.el.isConnected && !b.el.classList.contains('wxc-hidden') ? b : null;
  }

  // puts the back arrow and the drawer button at the start of the app bar,
  // the tool bar or a header bar of its own
  function frameChromeRender(f) {
    if (!f || !f.chrome) return;
    if (f.backBtn) f.backBtn.remove();
    if (f.menuBtn) f.menuBtn.remove();
    const lead = [];
    // as in Flutter: the drawer button replaces the back arrow
    if (f.chrome.menu) {
      if (!f.menuBtn) {
        f.menuBtn = iconButton('menu', 'Menu');
        f.menuBtn.addEventListener('click', () => drawerOpen(f.id, true));
      }
      lead.push(f.menuBtn);
    } else if (f.chrome.back) {
      if (!f.backBtn) {
        f.backBtn = iconButton('back', 'Back');
        f.backBtn.addEventListener('click', () => frameGoBack(f.id));
      }
      lead.push(f.backBtn);
    }
    const bar = visibleBar(f.appbarId) || visibleBar(f.toolbarId);
    let host = bar ? bar.el : null;
    if (!host && lead.length) {
      if (!f.header) {
        f.header = document.createElement('div');
        f.header.className = 'wxc-frame-header';
        f.headerTitle = document.createElement('span');
        f.headerTitle.className = 'wxc-appbar-title';
        f.header.appendChild(f.headerTitle);
      }
      f.headerTitle.textContent = f.chrome.title;
      f.el.insertBefore(f.header, f.bar.nextSibling);
      host = f.header;
    } else if (f.header) {
      f.header.remove();
    }
    if (!host) return;
    for (let i = lead.length - 1; i >= 0; i--) host.insertBefore(lead[i], host.firstChild);
  }

  // browser history: one entry per secondary frame on top of the main frame
  const historyFrames = [];
  let ignorePops = 0;

  function frameHistory(id, on) {
    const f = wins.get(id);
    if (on) {
      if (!f || f.hist) return;
      f.hist = true;
      historyFrames.push(id);
      history.pushState({ wxcFrame: id }, '');
    } else {
      if (f) {
        if (!f.hist) return;
        f.hist = false;
      }
      const i = historyFrames.indexOf(id);
      if (i < 0) return;
      historyFrames.splice(i, 1);
      ignorePops++;
      history.back();
    }
  }

  window.addEventListener('popstate', () => {
    if (ignorePops > 0) { ignorePops--; return; }
    const id = historyFrames.pop();
    if (id === undefined) return;
    const f = wins.get(id);
    if (!f) return;
    f.hist = false;
    send(ev('frameback', id));
  });

  function frameGoBack(id) {
    const f = wins.get(id);
    if (f && f.hist && historyFrames[historyFrames.length - 1] === id) {
      history.back();   // popstate sends 'frameback'
    } else {
      send(ev('frameback', id));
    }
  }

  // ---- app bar: a tool bar with a title, attached above the tool bar

  function appBarSet(id, title, flags) {
    const t = wins.get(id);
    if (!t) return;
    t.appbar = { title: title, flexible: !!(flags & 0x0200), pinned: !!(flags & 0x0400) };
    t.el.classList.add('wxc-appbar');
    appBarTitle(t);
    if (t.frameId) frameChromeRender(wins.get(t.frameId));
  }

  function appBarTitle(t) {
    if (!t.titleEl) {
      t.titleEl = document.createElement('span');
      t.titleEl.className = 'wxc-appbar-title';
    }
    t.titleEl.textContent = t.appbar.title;
    t.el.insertBefore(t.titleEl, t.el.firstChild);
  }

  function attachAppBar(frameId, appbarId) {
    const f = wins.get(frameId);
    const t = wins.get(appbarId);
    if (!f || !t || !f.client) return;
    t.el.classList.add('wxc-frame-toolbar');
    t.el.style.left = t.el.style.top = t.el.style.width = t.el.style.height = '';
    f.el.insertBefore(t.el, f.bar.nextSibling);
    f.appbarId = appbarId;
    t.frameId = frameId;
    frameChromeRender(f);
  }

  // the app bar reacts to scrolling of a window: it gets smaller
  // (wxAB_FLEXIBLE) and disappears when scrolling down (unless wxAB_PINNED)
  function appBarAttach(appbarId, scrollId) {
    const t = wins.get(appbarId);
    const s = wins.get(scrollId);
    if (!t || !s || !t.appbar) return;
    const el = s.el;
    let last = el.scrollTop;
    const update = () => {
      const y = el.scrollTop;
      if (t.appbar.flexible) t.el.classList.toggle('wxc-appbar-expanded', y <= 0);
      if (!t.appbar.pinned) {
        if (y > last + 4 && y > 48) t.el.classList.add('wxc-appbar-away');
        else if (y < last - 4 || y <= 0) t.el.classList.remove('wxc-appbar-away');
      }
      last = y;
    };
    el.addEventListener('scroll', update, { passive: true });
    update();
  }

  // ---- menu bar visibility (WxAdaptiveFrame in touch mode)

  function frameMenuBar(id, visible) {
    const f = wins.get(id);
    if (!f || !f.bar) return;
    f.bar.classList.toggle('wxc-mobile-hidden', !visible);
  }

  // ---- floating action button

  function fabSet(frameId, buttonId, visible) {
    const f = wins.get(frameId);
    const b = wins.get(buttonId);
    if (!f || !b) return;
    b.el.classList.add('wxc-fab');
    b.el.style.left = b.el.style.top = b.el.style.width = b.el.style.height = '';
    if (b.el.parentNode !== f.client) f.client.appendChild(b.el);
    b.el.classList.toggle('wxc-hidden', !visible);
    // above the bar of a navigation control, as in Flutter
    const nav = f.client.querySelector('.wxc-nav-bar');
    b.el.style.bottom = ((nav ? (nav.offsetHeight || 64) : 0) + 16) + 'px';
  }

  // ---- drawer: a panel sliding in from the left

  function drawerEnsure(f) {
    if (f.drawer) return f.drawer;
    const back = document.createElement('div');
    back.className = 'wxc-drawer-backdrop';
    const panel = document.createElement('div');
    panel.className = 'wxc-drawer';
    panel.setAttribute('role', 'dialog');
    back.addEventListener('pointerdown', (e) => { if (e.target === back) drawerOpen(f.id, false); });
    back.appendChild(panel);
    f.el.appendChild(back);
    f.drawer = { back: back, panel: panel, win: 0, home: null };
    return f.drawer;
  }

  // json: { title, items: [{ k: 'menu'|'normal'|'check'|'radio', t: text, id, c: checked }] }
  // or ''; winId: a window shown in the drawer (0: none)
  function drawerSet(frameId, json, winId) {
    const f = wins.get(frameId);
    if (!f) return;
    if (!json && !winId) {
      drawerRelease(f);
      if (f.drawer) { f.drawer.back.remove(); f.drawer = null; }
      return;
    }
    const d = drawerEnsure(f);
    if (d.win && d.win !== winId) drawerRelease(f);
    const data = json ? JSON.parse(json) : { title: '', items: [] };
    // keep an adopted window, rebuild the rest
    const keep = d.win ? wins.get(d.win) : null;
    d.panel.textContent = '';
    if (data.title) {
      const h = document.createElement('div');
      h.className = 'wxc-drawer-title';
      h.textContent = data.title;
      d.panel.appendChild(h);
    }
    for (const it of data.items || []) {
      if (it.k === 'menu') {
        const h = document.createElement('div');
        h.className = 'wxc-drawer-heading';
        h.textContent = it.t;
        d.panel.appendChild(h);
        continue;
      }
      const b = document.createElement('button');
      b.type = 'button';
      b.className = 'wxc-drawer-item';
      if (it.k === 'check' || it.k === 'radio') {
        const mark = document.createElement('span');
        mark.className = 'wxc-drawer-mark';
        mark.textContent = it.c ? (it.k === 'check' ? '✓' : '●') : '';
        b.appendChild(mark);
      }
      const label = document.createElement('span');
      label.textContent = it.t;
      b.appendChild(label);
      b.disabled = it.e === false;
      b.addEventListener('click', () => {
        if (it.k !== 'check') drawerOpen(f.id, false);
        send(ev('drawermenu', f.id, { x: it.id }));
      });
      d.panel.appendChild(b);
    }
    if (winId) {
      const w = keep || wins.get(winId);
      if (w) {
        if (!d.win) d.home = { parent: w.el.parentNode, next: w.el.nextSibling };
        d.win = winId;
        const slot = document.createElement('div');
        slot.className = 'wxc-drawer-slot';
        slot.appendChild(w.el);
        w.el.classList.remove('wxc-hidden');
        d.panel.appendChild(slot);
        d.slot = slot;
      }
    }
  }

  // puts a window shown in the drawer back where it was
  function drawerRelease(f) {
    const d = f.drawer;
    if (!d || !d.win) return;
    const w = wins.get(d.win);
    if (w && d.home && d.home.parent && d.home.parent.isConnected) {
      d.home.parent.insertBefore(w.el, d.home.next && d.home.next.parentNode === d.home.parent ? d.home.next : null);
    }
    d.win = 0;
    d.home = null;
    d.slot = null;
  }

  // size of the area for a window in the drawer
  function drawerSlotSize(frameId) {
    const f = wins.get(frameId);
    if (!f || !f.drawer || !f.drawer.slot) return { w: 0, h: 0 };
    const was = f.drawer.back.classList.contains('wxc-drawer-open');
    if (!was) f.drawer.back.classList.add('wxc-drawer-measure');
    const r = { w: f.drawer.slot.clientWidth, h: f.drawer.slot.clientHeight };
    f.drawer.back.classList.remove('wxc-drawer-measure');
    return r;
  }

  function drawerOpen(frameId, open) {
    const f = wins.get(frameId);
    if (!f || !f.drawer) return;
    const was = f.drawer.back.classList.contains('wxc-drawer-open');
    if (was === !!open) return;
    f.drawer.back.classList.toggle('wxc-drawer-open', !!open);
    send(ev('drawer', frameId, { x: open ? 1 : 0 }));
  }

  function drawerIsOpen(frameId) {
    const f = wins.get(frameId);
    return !!(f && f.drawer && f.drawer.back.classList.contains('wxc-drawer-open'));
  }

  // ---- info bar (WxFrame.showInfoBar): a snack bar at the bottom or top

  // style: 0 bottom, 1 top, 2 floating; action: label of the action button
  // or '' (then the bar disappears after duration ms)
  function infoBar(frameId, message, duration, style, action) {
    const f = wins.get(frameId);
    if (!f || !f.client) return;
    if (f.infoBar) f.infoBar.remove();
    const bar = document.createElement('div');
    bar.className = 'wxc-infobar ' + (style === 1 ? 'wxc-infobar-top' : style === 2 ? 'wxc-infobar-floating' : 'wxc-infobar-bottom');
    bar.setAttribute('role', 'status');
    const text = document.createElement('span');
    text.className = 'wxc-infobar-text';
    text.textContent = message;
    bar.appendChild(text);
    let timer = 0;
    // the floating action button moves up while the bar is shown (as in Flutter)
    const fab = style !== 1 ? f.client.querySelector(':scope > .wxc-fab') : null;
    const hide = () => {
      clearTimeout(timer);
      if (fab && f.infoBar === bar) fab.style.transform = '';
      bar.classList.remove('wxc-infobar-shown');
      setTimeout(() => { bar.remove(); if (f.infoBar === bar) f.infoBar = null; }, 200);
    };
    if (action) {
      const b = document.createElement('button');
      b.type = 'button';
      b.className = 'wxc-infobar-action';
      b.textContent = action;
      b.addEventListener('click', () => { hide(); send(ev('infobaraction', frameId)); });
      bar.appendChild(b);
      const close = document.createElement('button');
      close.type = 'button';
      close.className = 'wxc-infobar-close';
      close.setAttribute('aria-label', 'Close');
      close.textContent = '\u2715';
      close.addEventListener('click', hide);
      bar.appendChild(close);
    } else {
      timer = setTimeout(hide, Math.max(duration, 0) + 200);
    }
    f.client.appendChild(bar);
    f.infoBar = bar;
    // above the bar of a navigation control
    const nav = f.client.querySelector('.wxc-nav-bar');
    if (style !== 1 && nav) bar.style.bottom = ((nav.offsetHeight || 64) + (style === 2 ? 12 : 0)) + 'px';
    requestAnimationFrame(() => {
      bar.classList.add('wxc-infobar-shown');
      if (fab) fab.style.transform = 'translateY(-' + (bar.offsetHeight + 8) + 'px)';
    });
  }

  // touch mode (WxApp.isTouch): small screen or a touch screen without mouse
  // current modifier keys, for events created by Dart (_wxInitModifiers)
  let modState = 0;
  const trackMods = (e) => {
    modState = (e.ctrlKey ? 1 : 0) | (e.shiftKey ? 2 : 0) | (e.altKey ? 4 : 0) | (e.metaKey ? 8 : 0);
  };
  for (const type of ['keydown', 'keyup', 'pointerdown', 'pointermove', 'pointerup', 'wheel']) {
    document.addEventListener(type, trackMods, { capture: true, passive: true });
  }
  window.addEventListener('blur', () => { modState = 0; });
  function modifiers() { return modState; }

  // A device is operated with fingers if its primary pointer is coarse,
  // whatever the size of the screen (phones and tablets). Then the class
  // wxc-touch makes the targets larger; the larger font is chosen once at
  // start-up, since the Dart side caches the CSS of fonts.
  const coarseQuery = matchMedia('only screen and (pointer: coarse)');
  const FINGER_FONT_SCALE = 15 / 13;
  const fingerFont = coarseQuery.matches;
  const html0 = document.documentElement;
  html0.classList.toggle('wxc-touch', coarseQuery.matches);
  html0.classList.toggle('wxc-touch-font', fingerFont);
  let touchCache = null;
  window.addEventListener('resize', () => { touchCache = null; });
  coarseQuery.addEventListener('change', () => {
    touchCache = null;
    html0.classList.toggle('wxc-touch', coarseQuery.matches);
  });
  // touch layout (app bar, navigation at the bottom): finger input or a
  // narrow window, like in wxDart Flutter
  function isTouch() {
    if (touchCache === null) touchCache = coarseQuery.matches || window.innerWidth < 700;
    return touchCache;
  }
  // factor for the size of all fonts, see WxFont
  function fontScale() { return fingerFont ? FINGER_FONT_SCALE : 1; }

  // ---------------------------------------------------------- popup menus

  function popupMenu(ownerId, json, x, y) {
    closeMenus(true); // the app has already closed a previous popup menu
    const items = JSON.parse(json);
    indexItems(items);
    let px = lastMouse.x, py = lastMouse.y;
    if (x >= 0 || y >= 0) {
      const w = wins.get(ownerId);
      const host = w ? (w.client || w.el) : root;
      const r = host.getBoundingClientRect();
      px = r.left + Math.max(0, x);
      py = r.top + Math.max(0, y);
    }
    menu.frame = ownerId;
    menu.index = -1;
    menu.popup = true;
    menu.openedAt = performance.now();
    menu.stack.push(buildDropdown(items, px, py, 0));
  }

  // ------------------------------------------------------------- list box
  //
  // mode flags: 1 multiple, 2 extended, 4 horizontal scrolling,
  //             8 always show scroll bar, 16 never show scroll bar

  function lbRows(w) { return w.el.children; }

  function lbUpdate(w) {
    const rows = lbRows(w);
    for (let i = 0; i < rows.length; i++) {
      const sel = w.lb.selected.has(i);
      rows[i].classList.toggle('wxc-sel', sel);
      rows[i].classList.toggle('wxc-cur', i === w.lb.current);
      rows[i].setAttribute('aria-selected', sel ? 'true' : 'false');
    }
  }

  function lbRender(w) {
    const el = w.el;
    el.textContent = '';
    w.lb.items.forEach((text, i) => {
      const row = document.createElement('div');
      row.className = 'wxc-lb-item';
      row.setAttribute('role', 'option');
      row.dataset.i = String(i);
      row.textContent = text;
      el.appendChild(row);
    });
    el.setAttribute('aria-multiselectable', (w.lb.mode & 3) ? 'true' : 'false');
    el.classList.toggle('wxc-hscroll', (w.lb.mode & 4) !== 0);
    el.style.overflowY = (w.lb.mode & 8) ? 'scroll' : ((w.lb.mode & 16) ? 'hidden' : '');
    lbUpdate(w);
  }

  function lbNotify(w, index) {
    send(ev('listbox', w.id, { x: index, y: w.lb.current, text: JSON.stringify(Array.from(w.lb.selected)) }));
  }

  function lbShow(w, index) {
    const row = lbRows(w)[index];
    if (row) row.scrollIntoView({ block: 'nearest' });
  }

  function lbRange(a, b) {
    const s = new Set();
    for (let i = Math.min(a, b); i <= Math.max(a, b); i++) s.add(i);
    return s;
  }

  // a click or a key selected index i (with the given modifiers)
  function lbChoose(w, i, shift, ctrl, fromKey) {
    const lb = w.lb;
    const multiple = (lb.mode & 1) !== 0, extended = (lb.mode & 2) !== 0;
    lb.current = i;
    if (multiple) {
      if (!fromKey) { if (lb.selected.has(i)) lb.selected.delete(i); else lb.selected.add(i); }
      else { lbUpdate(w); lbShow(w, i); return; } // keys only move the focus
    } else if (extended) {
      if (shift && lb.anchor >= 0) {
        const range = lbRange(lb.anchor, i);
        lb.selected = ctrl ? new Set([...lb.selected, ...range]) : range;
      } else if (ctrl) {
        if (fromKey) { lbUpdate(w); lbShow(w, i); return; }
        if (lb.selected.has(i)) lb.selected.delete(i); else lb.selected.add(i);
        lb.anchor = i;
      } else {
        lb.selected = new Set([i]);
        lb.anchor = i;
      }
    } else {
      if (lb.selected.size === 1 && lb.selected.has(i)) { lbUpdate(w); lbShow(w, i); return; }
      lb.selected = new Set([i]);
    }
    lbUpdate(w);
    lbShow(w, i);
    lbNotify(w, i);
  }

  function lbAttach(w, el) {
    el.addEventListener('pointerdown', (e) => {
      const row = e.target.closest('.wxc-lb-item');
      if (!row || e.button !== 0) return;
      el.focus({ preventScroll: true });
      lbChoose(w, +row.dataset.i, e.shiftKey, e.ctrlKey || e.metaKey, false);
    });
    el.addEventListener('dblclick', (e) => {
      const row = e.target.closest('.wxc-lb-item');
      if (row) send(ev('listboxdclick', w.id, { x: +row.dataset.i }));
    });
    el.addEventListener('keydown', (e) => {
      if (e.defaultPrevented) return; // handled by the app
      const lb = w.lb, n = lb.items.length;
      if (!n) return;
      const per = Math.max(1, lbPerPage(w.id) - 1);
      let i = lb.current;
      switch (e.key) {
        case 'ArrowDown': i = Math.min(n - 1, i + 1); break;
        case 'ArrowUp': i = Math.max(0, i < 0 ? 0 : i - 1); break;
        case 'Home': i = 0; break;
        case 'End': i = n - 1; break;
        case 'PageDown': i = Math.min(n - 1, Math.max(0, i) + per); break;
        case 'PageUp': i = Math.max(0, i - per); break;
        case ' ':
          if ((lb.mode & 1) && i >= 0) {
            if (lb.selected.has(i)) lb.selected.delete(i); else lb.selected.add(i);
            lbUpdate(w);
            lbNotify(w, i);
          }
          e.preventDefault();
          return;
        case 'Enter':
          if (i >= 0) send(ev('listboxdclick', w.id, { x: i }));
          e.preventDefault();
          return;
        default:
          return;
      }
      e.preventDefault();
      lbChoose(w, i, e.shiftKey, e.ctrlKey || e.metaKey, true);
    });
  }

  function listboxSet(id, itemsJson, selectedJson, current, mode) {
    const w = wins.get(id);
    if (!w || !w.lb) return;
    w.lb.items = JSON.parse(itemsJson);
    w.lb.selected = new Set(JSON.parse(selectedJson));
    w.lb.current = current;
    w.lb.anchor = current;
    w.lb.mode = mode;
    lbRender(w);
  }

  function listboxSelect(id, selectedJson, current) {
    const w = wins.get(id);
    if (!w || !w.lb) return;
    w.lb.selected = new Set(JSON.parse(selectedJson));
    w.lb.current = current;
    w.lb.anchor = current;
    lbUpdate(w);
  }

  function listboxScroll(id, index, toTop) {
    const w = wins.get(id);
    if (!w || !w.lb) return;
    const row = lbRows(w)[index];
    if (!row) return;
    if (toTop) w.el.scrollTop = row.offsetTop - w.el.clientTop;
    else lbShow(w, index);
  }

  function listboxTopItem(id) {
    const w = wins.get(id);
    if (!w || !w.lb) return 0;
    const rows = lbRows(w);
    for (let i = 0; i < rows.length; i++) {
      if (rows[i].offsetTop + rows[i].offsetHeight > w.el.scrollTop) return i;
    }
    return 0;
  }

  function lbPerPage(id) {
    const w = wins.get(id);
    if (!w || !w.lb) return 0;
    const row = lbRows(w)[0];
    const h = row ? row.offsetHeight : 20;
    return h > 0 ? Math.floor(w.el.clientHeight / h) : 0;
  }

  // ------------------------------------------------------------- misc

  function setCursor(id, css) {
    const w = wins.get(id);
    if (w) (w.client || w.el).style.cursor = css;
  }

  function setCanFocus(id, canFocus) {
    const w = wins.get(id);
    if (!w) return;
    const t = w.client || w.el;
    if (canFocus) t.tabIndex = (w.kind === 'window' || w.kind === 'frame' || w.kind === 'dialog') ? -1 : 0;
    else t.removeAttribute('tabindex');
  }

  function screenSize() {
    return { w: window.innerWidth, h: window.innerHeight };
  }

  // ------------------------------------------------------- material icons
  //
  // paths: SVG path data in a 24 x 24 box, entries separated by '|';
  // "opacity;rule;d" entries and a leading "#x y w h" view box are allowed.

  function iconFromPaths(handle, paths, width, height, colour) {
    const c = document.createElement('canvas');
    c.width = width;
    c.height = height;
    const ctx = c.getContext('2d');
    ctx.fillStyle = colour;
    const entries = paths ? paths.split('|') : [];
    if (!entries.length) {
      // placeholder: outlines not generated yet
      const lw = Math.max(1, width / 16);
      ctx.strokeStyle = colour;
      ctx.lineWidth = lw;
      ctx.setLineDash([width / 8, width / 10]);
      ctx.strokeRect(width * 0.15, height * 0.15, width * 0.7, height * 0.7);
      images.set(handle, c);
      return;
    }
    let vb = [0, 0, 24, 24];
    if (entries[0].charAt(0) === '#') vb = entries.shift().slice(1).trim().split(/[\s,]+/).map(Number);
    ctx.setTransform(width / vb[2], 0, 0, height / vb[3], -vb[0] * width / vb[2], -vb[1] * height / vb[3]);
    for (const entry of entries) {
      let opacity = 1, rule = 'nonzero', d = entry;
      const parts = entry.split(';');
      if (parts.length === 3) {
        opacity = parseFloat(parts[0]);
        if (!(opacity >= 0)) opacity = 1;
        rule = parts[1] === 'e' ? 'evenodd' : 'nonzero';
        d = parts[2];
      }
      try {
        ctx.globalAlpha = opacity;
        ctx.fill(new Path2D(d), rule);
      } catch (err) {
        console.error('wxc: bad icon path', err);
      }
    }
    images.set(handle, c);
  }

  // ---------------------------------------------------------------- menus
  //
  // Menu bar JSON (sent by Dart):
  // { menus: [ { title: "&File", items: [ item, ... ] } ] }
  // item: { id, kind: normal|check|radio|separator|submenu, text, shortcut,
  //         help, enabled, checked, items? }

  const menu = {
    frame: 0,        // frame whose menu is open (or owner of a popup menu)
    index: -1,       // open top level menu
    stack: [],       // [{ el, items, rows, hi }] open dropdown levels
    popup: false,    // true for a popup menu (WxWindow.popupMenu)
    openedAt: 0,
  };

  function mnemonicHtml(title) {
    const span = document.createElement('span');
    const i = title.indexOf('&');
    if (i < 0 || i === title.length - 1) { span.textContent = title; return { span, key: '' }; }
    span.appendChild(document.createTextNode(title.substring(0, i)));
    const u = document.createElement('u');
    u.textContent = title[i + 1];
    span.appendChild(u);
    span.appendChild(document.createTextNode(title.substring(i + 2)));
    return { span, key: title[i + 1].toLowerCase() };
  }

  function indexItems(items) {
    for (const it of items) {
      menuItems.set(it.id, { item: it, row: null });
      if (it.items) indexItems(it.items);
    }
  }

  function setMenuBar(frameId, json) {
    const w = wins.get(frameId);
    if (!w || w.kind !== 'frame') return;
    if (menu.frame === frameId) closeMenus();
    const data = JSON.parse(json);
    menuBars.set(frameId, data);
    for (const m of data.menus) indexItems(m.items);
    const bar = w.bar;
    bar.textContent = '';
    data.menus.forEach((m, index) => {
      const t = document.createElement('div');
      t.className = 'wxc-menutitle';
      const mh = mnemonicHtml(m.title);
      m.mnemonic = mh.key;
      t.appendChild(mh.span);
      t.addEventListener('pointerdown', (e) => {
        e.preventDefault();
        if (menu.frame === frameId && menu.index === index) closeMenus();
        else openTopMenu(frameId, index);
      });
      t.addEventListener('pointerenter', () => {
        if (menu.frame === frameId && !menu.popup && menu.index !== index) openTopMenu(frameId, index);
      });
      bar.appendChild(t);
    });
    bar.classList.toggle('wxc-hidden', data.menus.length === 0);
  }

  function updateMenuItem(id, enabled, checked, text) {
    const rec = menuItems.get(id);
    if (!rec) return;
    rec.item.enabled = enabled;
    rec.item.checked = checked;
    if (text !== null && text !== undefined && text !== '') rec.item.text = text;
    if (rec.row && rec.row.isConnected) fillRow(rec.row, rec.item);
  }

  function fillRow(row, it) {
    row.classList.toggle('wxc-disabled', !it.enabled);
    row.querySelector('.wxc-mi-check').textContent =
      it.checked ? (it.kind === 'radio' ? '●' : '✓') : '';
    row.querySelector('.wxc-mi-label').textContent = it.text;
  }

  function buildDropdown(items, x, y, level) {
    const el = document.createElement('div');
    el.className = 'wxc-menu';
    el.style.zIndex = String(zCounter + 10 + level);
    const rows = [];
    items.forEach((it, i) => {
      let row;
      if (it.kind === 'separator') {
        row = document.createElement('div');
        row.className = 'wxc-mi-sep';
      } else {
        row = document.createElement('div');
        row.className = 'wxc-mi';
        row.innerHTML = '<span class="wxc-mi-check"></span><span class="wxc-mi-label"></span>' +
                        '<span class="wxc-mi-short"></span><span class="wxc-mi-arrow"></span>';
        row.querySelector('.wxc-mi-short').textContent = it.shortcut || '';
        row.querySelector('.wxc-mi-arrow').textContent = it.kind === 'submenu' ? '▸' : '';
        if (it.help) row.title = it.help;
        fillRow(row, it);
        const rec = menuItems.get(it.id);
        if (rec) rec.row = row;
        row.addEventListener('pointerenter', () => highlight(level, i, true));
        row.addEventListener('pointerup', (e) => {
          e.preventDefault();
          // the release of the click that opened a popup menu must not select
          if (menu.popup && performance.now() - menu.openedAt < 300) return;
          activate(level, i);
        });
      }
      rows.push(row);
      el.appendChild(row);
    });
    root.appendChild(el);
    // keep inside the viewport
    const r = el.getBoundingClientRect();
    if (x + r.width > window.innerWidth) x = Math.max(0, window.innerWidth - r.width - 2);
    if (y + r.height > window.innerHeight) y = Math.max(0, window.innerHeight - r.height - 2);
    el.style.left = x + 'px';
    el.style.top = y + 'px';
    return { el: el, items: items, rows: rows, hi: -1 };
  }

  function closeLevelsFrom(level) {
    while (menu.stack.length > level) {
      const l = menu.stack.pop();
      l.el.remove();
    }
  }

  function openTopMenu(frameId, index) {
    const data = menuBars.get(frameId);
    const w = wins.get(frameId);
    if (!data || !w) return;
    const wasOpen = menu.frame !== 0;
    closeLevelsFrom(0);
    if (wasOpen && (menu.frame !== frameId || menu.popup)) closeMenus();
    menu.popup = false;
    menu.frame = frameId;
    menu.index = index;
    // let Dart update enabled/checked state (WxUpdateUIEvent) before rendering
    send(ev('menuopen', frameId, { x: index }));
    const titles = w.bar.children;
    for (let i = 0; i < titles.length; i++) titles[i].classList.toggle('wxc-open', i === index);
    const r = titles[index].getBoundingClientRect();
    menu.stack.push(buildDropdown(data.menus[index].items, r.left, r.bottom, 0));
  }

  function closeMenus(silent) {
    if (!menu.frame) return;
    const frameId = menu.frame;
    const popup = menu.popup;
    closeLevelsFrom(0);
    const w = wins.get(frameId);
    if (w && w.bar) for (const t of w.bar.children) t.classList.remove('wxc-open');
    menu.frame = 0;
    menu.index = -1;
    menu.popup = false;
    if (popup) {
      // the popup may have replaced item records of menu bars with the same ids
      for (const d of menuBars.values()) for (const m of d.menus) indexItems(m.items);
    }
    if (silent === true) return;
    send(ev(popup ? 'popupclose' : 'menuclose', frameId));
  }

  function highlight(level, i, fromMouse) {
    const l = menu.stack[level];
    if (!l) return;
    closeLevelsFrom(level + 1);
    if (l.hi >= 0 && l.rows[l.hi]) l.rows[l.hi].classList.remove('wxc-hi');
    l.hi = i;
    const it = l.items[i];
    if (!it || it.kind === 'separator') return;
    l.rows[i].classList.add('wxc-hi');
    if (menu.frame && it.id !== undefined) send(ev('menuhighlight', menu.frame, { x: it.id }));
    if (it.kind === 'submenu' && it.enabled && fromMouse) openSubmenu(level, i);
  }

  function openSubmenu(level, i) {
    const l = menu.stack[level];
    const it = l.items[i];
    if (!it || it.kind !== 'submenu' || !it.items) return;
    closeLevelsFrom(level + 1);
    const r = l.rows[i].getBoundingClientRect();
    menu.stack.push(buildDropdown(it.items, r.right - 2, r.top - 4, level + 1));
  }

  function activate(level, i) {
    const l = menu.stack[level];
    if (!l) return;
    const it = l.items[i];
    if (!it || it.kind === 'separator' || !it.enabled) return;
    if (it.kind === 'submenu') { openSubmenu(level, i); return; }
    if (menu.popup) {
      // the app needs to know the popup menu while handling the selection
      send(ev('menu', it.id));
      closeMenus();
    } else {
      closeMenus();
      send(ev('menu', it.id));
    }
  }

  function moveHighlight(dir) {
    const level = menu.stack.length - 1;
    const l = menu.stack[level];
    if (!l) return;
    const n = l.items.length;
    let i = l.hi;
    for (let k = 0; k < n; k++) {
      i = (i + dir + n) % n;
      const it = l.items[i];
      if (it.kind !== 'separator' && it.enabled) { highlight(level, i, false); return; }
    }
  }

  function handleMenuKey(e) {
    const data = menu.popup ? null : menuBars.get(menu.frame);
    const level = menu.stack.length - 1;
    const l = menu.stack[level];
    switch (e.key) {
      case 'Escape':
        if (level > 0) closeLevelsFrom(level); else closeMenus();
        break;
      case 'ArrowDown': moveHighlight(1); break;
      case 'ArrowUp': moveHighlight(-1); break;
      case 'ArrowRight':
        if (l && l.hi >= 0 && l.items[l.hi].kind === 'submenu') {
          openSubmenu(level, l.hi);
          moveHighlight(1);
        } else if (data && data.menus.length) {
          openTopMenu(menu.frame, (menu.index + 1) % data.menus.length);
        }
        break;
      case 'ArrowLeft':
        if (level > 0) closeLevelsFrom(level);
        else if (data && data.menus.length) openTopMenu(menu.frame, (menu.index - 1 + data.menus.length) % data.menus.length);
        break;
      case 'Enter':
      case ' ':
        if (l && l.hi >= 0) activate(level, l.hi);
        break;
      default:
        return; // let other keys pass
    }
    e.preventDefault();
    e.stopPropagation();
  }

  function frameForKeys() {
    if (mainFrame && wins.has(mainFrame)) return mainFrame;
    for (const w of wins.values()) if (w.kind === 'frame') return w.id;
    return 0;
  }

  // ------------------------------------------------------------ keyboard

  function keyTarget() {
    const a = document.activeElement;
    let id = (a && a !== document.body) ? wxIdOf(a) : 0;
    if (modalStack.length) {
      const top = modalStack[modalStack.length - 1];
      const tw = wins.get(top);
      if (!id || !tw || !tw.el.contains(a)) id = top;
    }
    return id || frameForKeys();
  }

  function onKeyDown(e) {
    if (menu.frame) { handleMenuKey(e); return; }
    if (comboKey(e)) return;
    // Alt+mnemonic opens a menu of the main frame
    if (e.altKey && !e.ctrlKey && !e.metaKey && !modalStack.length && e.key.length === 1) {
      const f = frameForKeys();
      const data = menuBars.get(f);
      if (data) {
        const k = e.key.toLowerCase();
        const idx = data.menus.findIndex((m) => m.mnemonic === k);
        if (idx >= 0) { openTopMenu(f, idx); moveHighlight(1); e.preventDefault(); return; }
      }
    }
    const id = keyTarget();
    if (!id) return;
    const x = mods(e); x.key = e.key; x.code = e.code;
    if (send(ev('keydown', id, x))) e.preventDefault();
  }

  function onKeyUp(e) {
    if (menu.frame) return;
    const id = keyTarget();
    if (!id) return;
    const x = mods(e); x.key = e.key; x.code = e.code;
    if (send(ev('keyup', id, x))) e.preventDefault();
  }

  // ----------------------------------------------------------------- init

  function init(fn) {
    dispatcher = fn;
    if (root) return;
    root = document.getElementById('wxc-root');
    if (!root) {
      root = document.createElement('div');
      root.id = 'wxc-root';
      document.body.appendChild(root);
    }
    document.addEventListener('keydown', onKeyDown, true);
    document.addEventListener('keyup', onKeyUp, true);
    document.addEventListener('pointermove', (e) => { lastMouse = { x: e.clientX, y: e.clientY }; }, true);
    document.addEventListener('pointerup', (e) => { lastMouse = { x: e.clientX, y: e.clientY }; }, true);
    // dropping a file outside of a drop target must not make the browser
    // navigate to it; text fields keep their native text drop
    const nativeDrop = (e) => !Array.from(e.dataTransfer ? e.dataTransfer.types : []).includes('Files') &&
        e.target.closest && e.target.closest('input,textarea,[contenteditable="true"]');
    document.addEventListener('dragover', (e) => {
      if (e.defaultPrevented || nativeDrop(e)) return;
      e.preventDefault();
      e.dataTransfer.dropEffect = 'none';
    });
    document.addEventListener('drop', (e) => {
      if (!e.defaultPrevented && !nativeDrop(e)) e.preventDefault();
    });
    document.addEventListener('pointerdown', (e) => {
      lastMouse = { x: e.clientX, y: e.clientY };
      if (openCombo && !e.target.closest('.wxc-combo-popup') && !openCombo.el.contains(e.target)) comboClose(openCombo);
      if (!menu.frame) return;
      if (e.target.closest('.wxc-menu') || e.target.closest('.wxc-menubar')) return;
      closeMenus();
    }, true);
    window.addEventListener('blur', () => {
      closeMenus();
      if (openCombo) comboClose(openCombo);
      // a drag within the app is cancelled when the browser loses focus
      if (dragKind) send(ev('keydown', frameForKeys(), { key: 'Escape', code: 'Escape' }));
    });
    window.addEventListener('resize', () => {
      // device pixel ratio may have changed (zoom, other monitor)
      for (const w of wins.values()) if (w.canvas) refresh(w.id);
    });
    window.addEventListener('beforeunload', (e) => {
      if (!mainFrame) return;
      if (send(ev('close', mainFrame, { canVeto: true }))) {
        e.preventDefault();
        e.returnValue = '';
      }
    });
    const splash = document.getElementById('wxc-loading');
    if (splash) splash.remove();
  }


  // -------------------------------------------------------- drag and drop

  // geometry helpers (viewport coordinates = wxDart "screen" coordinates)

  function mouseTargetOf(w) { return w.mouseTarget || w.client || w.el; }

  function mousePosition() { return { x: Math.round(lastMouse.x), y: Math.round(lastMouse.y) }; }

  function clientOrigin(id) {
    const w = wins.get(id);
    if (!w) return { x: 0, y: 0 };
    const r = mouseTargetOf(w).getBoundingClientRect();
    return { x: Math.round(r.left), y: Math.round(r.top) };
  }

  function windowAt(x, y) {
    const node = document.elementFromPoint(x, y);
    const id = wxIdOf(node);
    const w = wins.get(id);
    if (!w) return { id: 0, x: 0, y: 0 };
    const r = mouseTargetOf(w).getBoundingClientRect();
    return { id: id, x: Math.round(x - r.left), y: Math.round(y - r.top) };
  }

  // ------------------------------------------------------------ gestures

  // WxWindow.enableTouchEvents(): one finger pans, two fingers zoom, like
  // in wxDart Flutter. Fingers on such a window send no mouse events, only
  // a tap (a touch without movement) arrives as left down and left up.
  // Mouse and pen keep sending mouse events.

  const TAP_SLOP = 8;   // pixels a finger may move and still tap

  function touchEvents(id, mask) {
    const w = wins.get(id);
    if (!w) return;
    w.touchMask = mask;
    const target = mouseTargetOf(w);
    const pan = mask & 3;
    // the browser must not scroll or zoom where the app handles gestures
    target.style.touchAction = (mask & 4) || pan === 3 ? 'none'
      : (pan === 1 ? 'pan-y' : (pan === 2 ? 'pan-x' : ''));
    if (w.gestures) return;
    const g = w.gestures = { pts: new Map(), mode: 'none', x0: 0, y0: 0, dx: 0, dy: 0, dist0: 1, zoom: 1 };
    const local = (e) => {
      const r = target.getBoundingClientRect();
      return { x: e.clientX - r.left, y: e.clientY - r.top };
    };
    const pair = () => {
      const [a, b] = Array.from(g.pts.values());
      return { x: (a.x + b.x) / 2, y: (a.y + b.y) / 2, d: Math.max(1, Math.hypot(a.x - b.x, a.y - b.y)) };
    };
    const keys = (e) => ({ ctrl: e.ctrlKey, shift: e.shiftKey, alt: e.altKey, meta: e.metaKey });
    const sendPan = (p, dx, dy, start, end) =>
      send(ev('gesturepan', id, { x: Math.round(p.x), y: Math.round(p.y), dx: dx, dy: dy, start: start, end: end }));
    const sendZoom = (c, start, end) =>
      send(ev('gesturezoom', id, { x: Math.round(c.x), y: Math.round(c.y), zoom: g.zoom, start: start, end: end }));
    const mine = (e) => e.pointerType === 'touch' && w.touchMask > 0;

    target.addEventListener('pointerdown', (e) => {
      if (!mine(e) || wxIdOf(e.target) !== id) return;
      const p = local(e);
      g.pts.set(e.pointerId, p);
      try { target.setPointerCapture(e.pointerId); } catch (_) { }
      if (g.pts.size === 1) {
        g.mode = 'pending'; g.x0 = p.x; g.y0 = p.y; g.dx = 0; g.dy = 0;
      } else if (g.pts.size === 2) {
        if (g.mode === 'pan') sendPan(p, 0, 0, false, true);
        if (w.touchMask & 4) {
          const c = pair();
          g.mode = 'zoom'; g.dist0 = c.d; g.zoom = 1;
          sendZoom(c, true, false);
        } else {
          g.mode = 'blocked';
        }
      }
    });
    target.addEventListener('pointermove', (e) => {
      if (!g.pts.has(e.pointerId)) return;
      const p = local(e);
      g.pts.set(e.pointerId, p);
      if (g.mode === 'pending' && g.pts.size === 1) {
        if (Math.hypot(p.x - g.x0, p.y - g.y0) <= TAP_SLOP) return;
        if (!(w.touchMask & 3)) { g.mode = 'blocked'; return; }
        g.mode = 'pan';
        sendPan(p, 0, 0, true, false);
      }
      if (g.mode === 'pan') {
        // whole pixels since the last event, only along the enabled axes
        const tx = (w.touchMask & 1) ? Math.floor(p.x - g.x0) : 0;
        const ty = (w.touchMask & 2) ? Math.floor(p.y - g.y0) : 0;
        if (tx === g.dx && ty === g.dy) return;
        sendPan(p, tx - g.dx, ty - g.dy, false, false);
        g.dx = tx; g.dy = ty;
      } else if (g.mode === 'zoom' && g.pts.size === 2) {
        const c = pair();
        const zoom = c.d / g.dist0;
        if (Math.abs(zoom - g.zoom) < 0.002) return;
        g.zoom = zoom;
        sendZoom(c, false, false);
      }
    });
    const up = (e) => {
      if (!g.pts.has(e.pointerId)) return;
      const p = local(e);
      if (g.mode === 'pending' && g.pts.size === 1 && e.type === 'pointerup') {
        // a tap is a click
        const m = Object.assign({ x: Math.round(p.x), y: Math.round(p.y), button: 0 }, keys(e));
        send(ev('mousedown', id, Object.assign({ leftDown: true }, m)));
        send(ev('mouseup', id, m));
      } else if (g.mode === 'pan') {
        sendPan(p, 0, 0, false, true);
        g.mode = 'blocked';
      } else if (g.mode === 'zoom') {
        sendZoom(pair(), false, true);
        g.mode = 'blocked';    // the remaining finger does not pan
      }
      g.pts.delete(e.pointerId);
      if (g.pts.size === 0) g.mode = 'none';
    };
    target.addEventListener('pointerup', up);
    target.addEventListener('pointercancel', up);
  }

  // feedback for a drag within the app (WxDropSource): only the mouse
  // cursor, like the browser does for its own drags (an extra icon next to
  // the cursor duplicated it); kind is 'copy', 'move', 'none', 'hidden' or
  // '' (end); 'hidden' leaves the feedback to the application

  function dragFeedback(kind) {
    const html = document.documentElement;
    html.classList.remove('wxc-drag-copy', 'wxc-drag-move', 'wxc-drag-none');
    if (kind && kind !== 'hidden') html.classList.add('wxc-drag-' + kind);
  }

  // HTML5 drag and drop from outside the app into a WxDropTarget

  function dndTypes(dt) {
    const types = Array.from(dt.types || []);
    if (dt.items) {
      for (const it of dt.items) if (it.kind === 'file' && it.type) types.push(it.type);
    }
    return types.join(',');
  }

  function readDroppedFile(f) {
    return f.arrayBuffer().then((b) => ({
      name: f.name, type: f.type || '', data: new Uint8Array(b),
      url: (f.type || '').startsWith('image/') ? URL.createObjectURL(f) : ''
    }));
  }

  function setDropTarget(id, enable) {
    const w = wins.get(id);
    if (!w) return;
    w.dropTarget = !!enable;
    if (!enable || w.dndAttached) return;
    w.dndAttached = true;
    const target = mouseTargetOf(w);
    let depth = 0;          // dragenter/dragleave also fire for children
    let last = null;        // last dragover position and answer
    const local = (e) => {
      const r = target.getBoundingClientRect();
      return Object.assign({ x: Math.round(e.clientX - r.left), y: Math.round(e.clientY - r.top) }, mods(e));
    };
    const over = (e) => {
      const p = local(e);
      let ok;
      if (last && last.x === p.x && last.y === p.y && last.shift === p.shift) {
        ok = last.ok;       // dragover repeats every few ms without movement
      } else {
        p.text = dndTypes(e.dataTransfer);
        ok = send(ev('dndover', id, p));
        last = { x: p.x, y: p.y, shift: p.shift, ok: ok };
      }
      if (ok) { e.preventDefault(); e.dataTransfer.dropEffect = 'copy'; }
      else e.dataTransfer.dropEffect = 'none';
    };
    target.addEventListener('dragenter', (e) => {
      if (!w.dropTarget) return;
      e.stopPropagation();
      if (depth++ === 0) { last = null; send(ev('dndenter', id, local(e))); }
      over(e);
    });
    target.addEventListener('dragover', (e) => {
      if (!w.dropTarget) return;
      e.stopPropagation();
      over(e);
    });
    target.addEventListener('dragleave', (e) => {
      if (!w.dropTarget) return;
      e.stopPropagation();
      if (depth > 0 && --depth === 0) { last = null; send(ev('dndleave', id, local(e))); }
    });
    target.addEventListener('drop', (e) => {
      if (!w.dropTarget) return;
      e.stopPropagation();
      const accepted = last && last.ok;
      depth = 0; last = null;
      send(ev('dndleave', id, local(e)));
      if (!accepted) return;
      e.preventDefault();
      const dt = e.dataTransfer;
      const p = local(e);
      p.text = dt.getData('text/plain') || '';
      p.url = dt.getData('text/uri-list') || '';
      const files = Array.from(dt.files || []);
      // file contents can only be read asynchronously
      Promise.all(files.map(readDroppedFile)).then((list) => {
        p.files = list;
        send(ev('dnddrop', id, p));
      }).catch((err) => {
        console.error('wxc: could not read dropped files', err);
        p.files = [];
        send(ev('dnddrop', id, p));
      });
    });
  }


  // ------------------------------------------------- notebook and treebook

  // pages: [{t: text, i: bitmap handle or 0, bw, bh, l: level, e: expanded}]
  // The page windows themselves are ordinary wxDart child windows living in
  // w.client; Dart shows the selected one and sizes it to the client area.

  function bookVisible(b, i) {
    // a tree row is visible if all its ancestors are expanded
    let level = b.pages[i].l;
    for (let j = i - 1; j >= 0 && level > 0; j--) {
      if (b.pages[j].l < level) {
        if (!b.pages[j].e) return false;
        level = b.pages[j].l;
      }
    }
    return true;
  }

  function bookHasChildren(b, i) {
    return i + 1 < b.pages.length && b.pages[i + 1].l > b.pages[i].l;
  }

  function bookRender(w) {
    const b = w.book;
    const head = w.head;
    head.textContent = '';
    b.pages.forEach((p, i) => {
      const item = document.createElement(b.kind === 'treebook' ? 'div' : 'button');
      item.dataset.i = i;
      if (b.kind === 'treebook') {
        item.className = 'wxc-tb-row';
        item.setAttribute('role', 'treeitem');
        item.style.paddingLeft = (4 + p.l * 16) + 'px';
        const chevron = document.createElement('span');
        chevron.className = 'wxc-tb-chevron';
        if (bookHasChildren(b, i)) {
          chevron.classList.add(p.e ? 'wxc-tb-open' : 'wxc-tb-closed');
          item.setAttribute('aria-expanded', p.e ? 'true' : 'false');
        }
        item.appendChild(chevron);
        if (!bookVisible(b, i)) item.style.display = 'none';
      } else {
        item.className = b.kind === 'navigation' ? 'wxc-nav-item' : 'wxc-nb-tab';
        item.setAttribute('role', 'tab');
        item.tabIndex = -1;
      }
      if (p.i) {
        const c = document.createElement('canvas');
        c.className = 'wxc-book-icon';
        item.appendChild(c);
        drawIcon(c, p.i, p.bw, p.bh);
      }
      const label = document.createElement('span');
      label.textContent = p.t;
      item.appendChild(label);
      head.appendChild(item);
    });
    bookShowSelection(w);
  }

  function bookShowSelection(w) {
    const b = w.book;
    for (const item of w.head.children) {
      const on = +item.dataset.i === b.sel;
      item.classList.toggle('wxc-book-selected', on);
      item.setAttribute('aria-selected', on ? 'true' : 'false');
      if (on) item.scrollIntoView({ block: 'nearest', inline: 'nearest' });
    }
  }

  function bookChoose(w, i) {
    const b = w.book;
    if (i < 0 || i >= b.pages.length || i === b.sel) return;
    // Dart decides (page changing can be vetoed) and calls bookSelect
    send(ev('booksel', w.id, { x: i }));
  }

  function bookToggle(w, i, expand) {
    const b = w.book;
    if (!bookHasChildren(b, i) || b.pages[i].e === expand) return;
    b.pages[i].e = expand;
    bookRender(w);
    send(ev('bookexpand', w.id, { x: i, y: expand ? 1 : 0 }));
  }

  function bookAttach(w) {
    const head = w.head;
    head.addEventListener('pointerdown', (e) => {
      const item = e.target.closest('[data-i]');
      if (!item) return;
      const i = +item.dataset.i;
      head.focus({ preventScroll: true });
      e.preventDefault();
      if (e.target.classList.contains('wxc-tb-chevron')) {
        bookToggle(w, i, !w.book.pages[i].e);
      } else {
        bookChoose(w, i);
      }
    });
    head.addEventListener('dblclick', (e) => {
      const item = e.target.closest('.wxc-tb-row');
      if (item && !e.target.classList.contains('wxc-tb-chevron')) {
        const i = +item.dataset.i;
        bookToggle(w, i, !w.book.pages[i].e);
      }
    });
    head.addEventListener('keydown', (e) => {
      const b = w.book;
      const n = b.pages.length;
      if (!n) return;
      const cur = b.sel;
      let next = -2;
      if (b.kind === 'treebook') {
        const visible = [];
        for (let i = 0; i < n; i++) if (bookVisible(b, i)) visible.push(i);
        const pos = visible.indexOf(cur);
        switch (e.key) {
          case 'ArrowDown': next = visible[Math.min(visible.length - 1, pos + 1)]; break;
          case 'ArrowUp': next = visible[Math.max(0, pos - 1)]; break;
          case 'Home': next = visible[0]; break;
          case 'End': next = visible[visible.length - 1]; break;
          case 'ArrowRight':
            if (cur >= 0 && bookHasChildren(b, cur) && !b.pages[cur].e) bookToggle(w, cur, true);
            else if (cur >= 0 && bookHasChildren(b, cur)) next = cur + 1;
            else next = -1;
            break;
          case 'ArrowLeft':
            if (cur >= 0 && bookHasChildren(b, cur) && b.pages[cur].e) { bookToggle(w, cur, false); next = -1; break; }
            next = -1;
            for (let j = cur - 1; j >= 0; j--) if (b.pages[j].l < b.pages[cur].l) { next = j; break; }
            break;
          default: return;
        }
      } else {
        const back = b.vertical ? 'ArrowUp' : 'ArrowLeft';
        const fwd = b.vertical ? 'ArrowDown' : 'ArrowRight';
        if (e.key === fwd) next = (cur + 1) % n;
        else if (e.key === back) next = (cur - 1 + n) % n;
        else if (e.key === 'Home') next = 0;
        else if (e.key === 'End') next = n - 1;
        else return;
      }
      e.preventDefault();
      e.stopPropagation();
      if (next >= 0) bookChoose(w, next);
    });
  }

  function bookSet(id, json, sel) {
    const w = wins.get(id);
    if (!w || !w.book) return;
    w.book.pages = JSON.parse(json);
    w.book.sel = sel;
    bookRender(w);
  }

  function bookSelect(id, sel) {
    const w = wins.get(id);
    if (!w || !w.book) return;
    w.book.sel = sel;
    // the selected tree row must be visible
    const b = w.book;
    if (b.kind === 'treebook' && sel >= 0 && !bookVisible(b, sel)) {
      let level = b.pages[sel].l;
      for (let j = sel - 1; j >= 0 && level > 0; j--) {
        if (b.pages[j].l < level) {
          if (!b.pages[j].e) { b.pages[j].e = true; send(ev('bookexpand', id, { x: j, y: 1 })); }
          level = b.pages[j].l;
        }
      }
      bookRender(w);
      return;
    }
    bookShowSelection(w);
  }

  function bookExpand(id, index, expand) {
    const w = wins.get(id);
    if (!w || !w.book || !w.book.pages[index]) return;
    w.book.pages[index].e = !!expand;
    bookRender(w);
  }

  // size of the tab bar or tree next to the pages
  function bookChrome(id) {
    const w = wins.get(id);
    if (!w || !w.book) return { w: 0, h: 0 };
    const head = w.head;
    if (w.book.kind === 'navigation') return { w: 0, h: head.offsetHeight || 64 };
    if (w.book.kind === 'treebook' || w.book.vertical) {
      return { w: head.offsetWidth || (w.book.kind === 'treebook' ? 180 : 100), h: 0 };
    }
    return { w: 0, h: head.offsetHeight || 34 };
  }





  // ------------------------------------------------------------- memory DC

  // A canvas that a WxMemoryDC draws into; it is also the bitmap's image
  function memCanvas(handle, width, height, alpha) {
    const c = document.createElement('canvas');
    c.width = Math.max(1, width);
    c.height = Math.max(1, height);
    images.set(handle, c);
    return c.getContext('2d', { alpha: !!alpha });
  }

  // ------------------------------------------------------------ status bar

  // json: { fields: [{ t: text, w: width (negative: proportional) }], help } or '' to remove
  function statusBarSet(frameId, json) {
    const f = wins.get(frameId);
    if (!f || !f.client) return;
    if (!json) {
      if (f.statusBar) { f.statusBar.remove(); f.statusBar = null; }
      return;
    }
    const d = JSON.parse(json);
    if (!f.statusBar) {
      f.statusBar = document.createElement('div');
      f.statusBar.className = 'wxc-statusbar';
      f.statusBar.setAttribute('role', 'status');
      f.el.appendChild(f.statusBar);
    }
    const bar = f.statusBar;
    while (bar.children.length > d.fields.length) bar.lastChild.remove();
    while (bar.children.length < d.fields.length) bar.appendChild(document.createElement('div')).className = 'wxc-sb-field';
    d.fields.forEach((field, i) => {
      const cell = bar.children[i];
      cell.textContent = (i === 0 && d.help) ? d.help : field.t;
      cell.style.flex = field.w < 0 ? (-field.w) + ' 1 0' : '0 0 ' + field.w + 'px';
    });
  }

  // ---------------------------------------------------------------- popups

  // a transient popup is dismissed by a click outside or by Escape
  function popupTransient(id, on) {
    const w = wins.get(id);
    if (!w) return;
    if (w.popupOff) { w.popupOff(); w.popupOff = null; }
    if (!on) return;
    const down = (e) => {
      if (!w.el.contains(e.target)) send(ev('popupdismiss', id));
    };
    const key = (e) => {
      if (e.key === 'Escape') { e.preventDefault(); e.stopPropagation(); send(ev('popupdismiss', id)); }
    };
    // registered after the click that opened the popup has been handled
    setTimeout(() => {
      if (!wins.has(id) || w.el.classList.contains('wxc-hidden')) return;
      document.addEventListener('pointerdown', down, true);
      document.addEventListener('keydown', key, true);
      w.popupOff = () => {
        document.removeEventListener('pointerdown', down, true);
        document.removeEventListener('keydown', key, true);
      };
    }, 0);
  }

  function consoleLog(level, text) {
    (console[level] || console.log).call(console, text);
  }

  // ---------------------------------------------- buttons with bitmaps

  // dir: wxLEFT 0x10, wxRIGHT 0x20, wxTOP 0x40, wxBOTTOM 0x80
  function buttonSetBitmap(id, handle, bw, bh, dir, noText) {
    const w = wins.get(id);
    if (!w || !w.btnLabel) return;
    if (!handle) {
      if (w.btnIcon) { w.btnIcon.remove(); w.btnIcon = null; }
    } else {
      if (!w.btnIcon) {
        w.btnIcon = document.createElement('canvas');
        w.btnIcon.className = 'wxc-btn-icon';
        w.el.insertBefore(w.btnIcon, w.btnLabel);
      }
      drawIcon(w.btnIcon, handle, bw, bh);
    }
    w.el.classList.toggle('wxc-btn-hasicon', !!handle);
    const side = dir === 0x20 ? 'right' : dir === 0x40 ? 'top' : dir === 0x80 ? 'bottom' : 'left';
    w.el.classList.remove('wxc-btn-right', 'wxc-btn-top', 'wxc-btn-bottom');
    if (side !== 'left') w.el.classList.add('wxc-btn-' + side);
    w.btnLabel.style.display = (noText || !w.btnLabel.textContent) ? 'none' : '';
  }

  function toggleSet(id, on) {
    const w = wins.get(id);
    if (w) w.el.setAttribute('aria-pressed', on ? 'true' : 'false');
  }

  // --------------------------------------------------------- static bitmap

  // mode: 0 none (top left), 1 fill, 2 aspect fit, 3 aspect fill
  function staticBitmapSet(id, handle, bw, bh, mode) {
    const w = wins.get(id);
    if (!w || !w.sbCanvas) return;
    const c = w.sbCanvas;
    const img = images.get(handle);
    if (!img) { c.width = c.height = 1; return; }
    const draw = () => {
      const iw = bw > 0 ? bw : (img.naturalWidth || img.width || 16);
      const ih = bh > 0 ? bh : (img.naturalHeight || img.height || 16);
      const r = dpr();
      c.width = Math.max(1, Math.round(iw * r));
      c.height = Math.max(1, Math.round(ih * r));
      const ctx = c.getContext('2d');
      ctx.clearRect(0, 0, c.width, c.height);
      ctx.drawImage(img, 0, 0, c.width, c.height);
      c.style.width = mode ? '100%' : iw + 'px';
      c.style.height = mode ? '100%' : ih + 'px';
      c.style.objectFit = ['', 'fill', 'contain', 'cover'][mode] || '';
      c.style.objectPosition = 'left top';
    };
    if (img.tagName === 'IMG' && !(img.complete && img.naturalWidth)) {
      img.addEventListener('load', draw, { once: true });
    } else {
      draw();
    }
  }

  // ------------------------------------------------------------ static box

  // space taken by the frame and the label around the client area
  function staticBoxChrome(id) {
    const w = wins.get(id);
    if (!w || !w.label) return { l: 0, t: 0, r: 0, b: 0 };
    const hasLabel = !!w.label.textContent;
    const lh = hasLabel ? (w.label.offsetHeight || 16) : 0;
    const chrome = { l: 9, t: hasLabel ? lh + 6 : 9, r: 9, b: 9 };
    if (w.client) {
      const st = w.client.style;
      st.left = chrome.l + 'px'; st.top = chrome.t + 'px'; st.right = chrome.r + 'px'; st.bottom = chrome.b + 'px';
    }
    return chrome;
  }

  // -------------------------------------------------- radio buttons, box

  function radioSetGroup(id, group) {
    const w = wins.get(id);
    if (w && w.input) w.input.name = 'wxc-radio-' + group;
  }

  // json: { items: [...], cols, rows, byRows, sel, off: [indices] }
  function radioboxSet(id, json) {
    const w = wins.get(id);
    if (!w || !w.grid) return;
    const d = JSON.parse(json);
    const g = w.grid;
    g.textContent = '';
    w.rbOff = new Set(d.off);
    if (d.byRows) {
      g.style.gridAutoFlow = 'column';
      g.style.gridTemplateRows = 'repeat(' + Math.max(1, d.rows) + ', auto)';
      g.style.gridTemplateColumns = '';
    } else {
      g.style.gridAutoFlow = 'row';
      g.style.gridTemplateColumns = 'repeat(' + Math.max(1, d.cols) + ', auto)';
      g.style.gridTemplateRows = '';
    }
    d.items.forEach((text, i) => {
      const l = g.appendChild(document.createElement('label'));
      l.className = 'wxc-checkbox wxc-radio';
      const r = l.appendChild(document.createElement('input'));
      r.type = 'radio'; r.name = 'wxc-rb-' + id; r.dataset.i = i;
      r.checked = i === d.sel;
      r.disabled = !!w.disabled || w.rbOff.has(i);
      l.appendChild(document.createElement('span')).textContent = text;
      r.addEventListener('change', () => { if (r.checked) send(ev('radiobox', id, { x: i })); });
    });
  }

  function radioboxSelect(id, sel) {
    const w = wins.get(id);
    if (!w || !w.grid) return;
    w.grid.querySelectorAll('input').forEach((r) => { r.checked = +r.dataset.i === sel; });
  }

  // ---------------------------------------------------------- spin control

  function spinSet(id, min, max, step, value) {
    const w = wins.get(id);
    if (!w) return;
    w.el.min = String(min);
    w.el.max = String(max);
    w.el.step = String(step);
    if (value !== null && w.el.value !== value) w.el.value = value;
  }

  // --------------------------------------------------------- search control

  function searchSet(id, showSearch, showCancel, descriptive) {
    const w = wins.get(id);
    if (!w || !w.searchGo) return;
    w.searchGo.style.display = showSearch ? '' : 'none';
    w.searchCancel.style.display = showCancel ? '' : 'none';
    w.textInput.placeholder = descriptive;
  }

  // ------------------------------------------------------------- combo box

  let openCombo = null;

  // items: [{ t: text, i: bitmap handle or 0, bw, bh }]
  function comboSetItems(id, json, sel, readonly) {
    const w = wins.get(id);
    if (!w || !w.combo) return;
    w.combo.items = JSON.parse(json);
    w.textInput.readOnly = !!readonly;
    w.el.classList.toggle('wxc-combo-readonly', !!readonly);
    comboSelect(id, sel);
    if (w.combo.popup) comboRender(w);
  }

  function comboSelect(id, sel) {
    const w = wins.get(id);
    if (!w || !w.combo) return;
    w.combo.sel = sel;
    const it = w.combo.items[sel];
    if (it && it.i) {
      w.comboIcon.style.display = '';
      drawIcon(w.comboIcon, it.i, it.bw, it.bh);
    } else {
      w.comboIcon.style.display = 'none';
    }
  }

  function comboRender(w) {
    const c = w.combo;
    const p = c.popup;
    p.textContent = '';
    c.items.forEach((it, i) => {
      const row = p.appendChild(document.createElement('div'));
      row.className = 'wxc-combo-item' + (i === c.hi ? ' wxc-hi' : '');
      row.setAttribute('role', 'option');
      row.dataset.i = i;
      if (it.i) {
        const cv = row.appendChild(document.createElement('canvas'));
        cv.className = 'wxc-book-icon';
        drawIcon(cv, it.i, it.bw, it.bh);
      }
      row.appendChild(document.createElement('span')).textContent = it.t;
    });
  }

  function comboOpen(w) {
    if (openCombo === w || w.disabled) return;
    if (openCombo) comboClose(openCombo);
    const c = w.combo;
    if (!c.items.length) return;
    const p = document.createElement('div');
    p.className = 'wxc-combo-popup';
    p.setAttribute('role', 'listbox');
    const r = w.el.getBoundingClientRect();
    p.style.left = r.left + 'px';
    p.style.minWidth = r.width + 'px';
    const below = window.innerHeight - r.bottom;
    if (below < 160 && r.top > below) {
      p.style.bottom = (window.innerHeight - r.top + 2) + 'px';
      p.style.maxHeight = Math.max(80, r.top - 8) + 'px';
    } else {
      p.style.top = (r.bottom + 2) + 'px';
      p.style.maxHeight = Math.max(80, below - 8) + 'px';
    }
    p.addEventListener('pointerdown', (e) => e.preventDefault());   // keep the focus
    p.addEventListener('click', (e) => {
      const row = e.target.closest('[data-i]');
      if (row) comboChoose(w, +row.dataset.i);
    });
    p.addEventListener('pointermove', (e) => {
      const row = e.target.closest('[data-i]');
      if (row && +row.dataset.i !== c.hi) { c.hi = +row.dataset.i; comboRender(w); }
    });
    document.body.appendChild(p);
    c.popup = p;
    c.hi = c.sel;
    comboRender(w);
    const hi = p.querySelector('.wxc-hi');
    if (hi) hi.scrollIntoView({ block: 'nearest' });
    w.textInput.setAttribute('aria-expanded', 'true');
    w.el.classList.add('wxc-combo-open');
    openCombo = w;
  }

  function comboClose(w) {
    const c = w.combo;
    if (c.popup) { c.popup.remove(); c.popup = null; }
    w.textInput.setAttribute('aria-expanded', 'false');
    w.el.classList.remove('wxc-combo-open');
    if (openCombo === w) openCombo = null;
  }

  function comboToggle(w) {
    if (openCombo === w) comboClose(w); else comboOpen(w);
  }

  function comboChoose(w, i) {
    comboClose(w);
    if (i >= 0 && i < w.combo.items.length) send(ev('combo', w.id, { x: i }));
  }

  // keys for the combo box with the focus; returns true if used
  function comboKey(e) {
    const a = document.activeElement;
    const w = a ? wins.get(wxIdOf(a)) : null;
    if (!w || !w.combo || a !== w.textInput) return false;
    const c = w.combo;
    const n = c.items.length;
    if (!c.popup) {
      if ((e.key === 'ArrowDown' && (e.altKey || w.textInput.readOnly)) || e.key === 'F4') {
        comboOpen(w); e.preventDefault(); return true;
      }
      return false;
    }
    switch (e.key) {
      case 'ArrowDown': c.hi = Math.min(n - 1, c.hi + 1); break;
      case 'ArrowUp': c.hi = Math.max(0, c.hi - 1); break;
      case 'Home': c.hi = 0; break;
      case 'End': c.hi = n - 1; break;
      case 'Enter': comboChoose(w, c.hi); e.preventDefault(); e.stopPropagation(); return true;
      case 'Escape': case 'Tab': case 'F4': comboClose(w); if (e.key !== 'Tab') { e.preventDefault(); e.stopPropagation(); } return e.key !== 'Tab';
      default: return false;
    }
    comboRender(w);
    const hi = c.popup.querySelector('.wxc-hi');
    if (hi) hi.scrollIntoView({ block: 'nearest' });
    e.preventDefault();
    e.stopPropagation();
    return true;
  }

  // -------------------------------------------------------- collapsible pane

  function comboOpenId(id) { const w = wins.get(id); if (w && w.combo) comboOpen(w); }
  function comboCloseId(id) { const w = wins.get(id); if (w && w.combo) comboClose(w); }

  function collapsibleSet(id, expanded) {
    const w = wins.get(id);
    if (!w || !w.cpHead) return;
    w.cpHead.setAttribute('aria-expanded', expanded ? 'true' : 'false');
    w.cpHead.firstChild.className = 'wxc-tb-chevron ' + (expanded ? 'wxc-tb-open' : 'wxc-tb-closed');
    w.client.style.display = expanded ? '' : 'none';
  }

  function collapsibleHeader(id) {
    const w = wins.get(id);
    if (!w || !w.cpHead) return { w: 0, h: 0 };
    // measured on a detached copy if not laid out yet
    let width = w.cpHead.offsetWidth, height = w.cpHead.offsetHeight;
    if (!height) { const m = measure(id, -1); width = m.w; height = 30; }
    w.client.style.top = Math.ceil(height) + 'px';
    return { w: Math.ceil(width), h: Math.ceil(height) };
  }

  // ------------------------------------------------------------- WebGL

  // Returns the WebGL 2 context of a WxGLCanvas, created on first use
  function glContext(id, depth, stencil, antialias) {
    const w = wins.get(id);
    if (!w || !w.glc) return null;
    if (!w.gl) {
      w.gl = w.glc.getContext('webgl2', { depth: !!depth, stencil: !!stencil, antialias: !!antialias,
                                           alpha: false, premultipliedAlpha: false, preserveDrawingBuffer: true });
      if (!w.gl) console.error('wxc: WebGL 2 is not available');
    }
    return w.gl;
  }

  // ------------------------------------------------- activity indicator

  function activitySet(id, running) {
    const w = wins.get(id);
    if (!w) return;
    w.el.classList.toggle('wxc-activity-running', !!running);
    w.el.setAttribute('aria-busy', running ? 'true' : 'false');
  }

  // ---------------------------------------------------------- animations

  // GIF decoder (GIF87a/89a, interlacing, transparency, disposal methods),
  // so that WxAnimation works in every browser. Each frame is stored as a
  // complete RGBA picture of the logical screen.

  function gifLzw(minCode, data, npix) {
    const out = new Uint8Array(npix);
    const clear = 1 << minCode, eoi = clear + 1;
    let size = minCode + 1, mask = (1 << size) - 1, next = eoi + 1;
    const prefix = new Int16Array(4096), suffix = new Uint8Array(4096), stack = new Uint8Array(4097);
    for (let i = 0; i < clear; i++) { prefix[i] = -1; suffix[i] = i; }
    let old = -1, first = 0, op = 0, bits = 0, acc = 0, dp = 0;
    while (op < npix) {
      while (bits < size) {
        if (dp >= data.length) return out;
        acc |= data[dp++] << bits;
        bits += 8;
      }
      let code = acc & mask;
      acc >>>= size;
      bits -= size;
      if (code === clear) { size = minCode + 1; mask = (1 << size) - 1; next = eoi + 1; old = -1; continue; }
      if (code === eoi) break;
      if (old === -1) {
        if (code >= clear) break;  // corrupt data
        out[op++] = suffix[code]; old = code; first = code;
        continue;
      }
      const incoming = code;
      let sp = 0;
      if (code >= next) { stack[sp++] = first; code = old; }
      while (code >= clear) {
        if (sp >= 4096) return out;  // corrupt data
        stack[sp++] = suffix[code]; code = prefix[code];
      }
      first = suffix[code];
      stack[sp++] = first;
      while (sp > 0 && op < npix) out[op++] = stack[--sp];
      if (next < 4096) {
        prefix[next] = old; suffix[next] = first; next++;
        if ((next & mask) === 0 && next < 4096) { size++; mask = (1 << size) - 1; }
      }
      old = incoming;
    }
    return out;
  }

  function decodeGif(buffer) {
    const d = new Uint8Array(buffer);
    if (d.length < 13 || d[0] !== 0x47 || d[1] !== 0x49 || d[2] !== 0x46) throw new Error('not a GIF file');
    let p = 6;
    const u16 = () => { const v = d[p] | (d[p + 1] << 8); p += 2; return v; };
    const W = u16(), H = u16();
    const flags = d[p++];
    p += 2;  // background colour index, aspect ratio
    let gct = null;
    if (flags & 0x80) { const n = 2 << (flags & 7); gct = d.subarray(p, p + 3 * n); p += 3 * n; }
    const screen = new Uint8ClampedArray(W * H * 4);
    const frames = [];
    let gce = { delay: 0, transparent: -1, disposal: 0 };
    let prev = null;  // disposal of the previous frame: { disposal, x, y, w, h, saved }
    while (p < d.length) {
      const block = d[p++];
      if (block === 0x3B) break;                      // trailer
      if (block === 0x21) {                           // extension
        const label = d[p++];
        if (label === 0xF9 && d[p] >= 4) {            // graphic control extension
          const f = d[p + 1];
          gce = { disposal: (f >> 2) & 7, delay: (d[p + 2] | (d[p + 3] << 8)) * 10,
                  transparent: (f & 1) ? d[p + 4] : -1 };
        }
        while (p < d.length) { const n = d[p++]; if (!n) break; p += n; }
        continue;
      }
      if (block !== 0x2C) break;                      // not an image descriptor
      const fx = u16(), fy = u16(), fw = u16(), fh = u16();
      const lf = d[p++];
      let ct = gct;
      if (lf & 0x80) { const n = 2 << (lf & 7); ct = d.subarray(p, p + 3 * n); p += 3 * n; }
      const minCode = d[p++];
      const chunks = [];
      let total = 0;
      while (p < d.length) {
        const n = d[p++];
        if (!n) break;
        chunks.push(d.subarray(p, p + n)); total += n; p += n;
      }
      const data = new Uint8Array(total);
      let o = 0;
      for (const c of chunks) { data.set(c, o); o += c.length; }
      const pixels = gifLzw(minCode, data, fw * fh);

      // dispose the previous frame
      if (prev) {
        if (prev.disposal === 2) {
          for (let y = prev.y; y < Math.min(H, prev.y + prev.h); y++) {
            screen.fill(0, (y * W + prev.x) * 4, (y * W + Math.min(W, prev.x + prev.w)) * 4);
          }
        } else if (prev.disposal === 3 && prev.saved) {
          screen.set(prev.saved);
        }
      }
      const saved = gce.disposal === 3 ? screen.slice() : null;

      // rows of an interlaced image come in four passes
      const rows = new Array(fh);
      if (lf & 0x40) {
        let r = 0;
        for (const [start, step] of [[0, 8], [4, 8], [2, 4], [1, 2]]) {
          for (let y = start; y < fh; y += step) rows[r++] = y;
        }
      } else {
        for (let y = 0; y < fh; y++) rows[y] = y;
      }
      if (ct) {
        for (let r = 0; r < fh; r++) {
          const sy = fy + rows[r];
          if (sy >= H) continue;
          for (let x = 0; x < fw; x++) {
            const sx = fx + x;
            if (sx >= W) continue;
            const ci = pixels[r * fw + x];
            if (ci === gce.transparent || 3 * ci + 2 >= ct.length) continue;
            const q = (sy * W + sx) * 4;
            screen[q] = ct[3 * ci]; screen[q + 1] = ct[3 * ci + 1]; screen[q + 2] = ct[3 * ci + 2]; screen[q + 3] = 255;
          }
        }
      }
      // browsers show frames with a delay of up to 10 ms for 100 ms
      frames.push({ delay: gce.delay <= 10 ? 100 : gce.delay, data: screen.slice() });
      prev = { disposal: gce.disposal, x: fx, y: fy, w: fw, h: fh, saved: saved };
      gce = { delay: 0, transparent: -1, disposal: 0 };
    }
    if (!frames.length) throw new Error('GIF without frames');
    return { w: W, h: H, frames: frames };
  }

  const anims = new Map();   // WxAnimation handle -> decoded animation

  function animLoad(handle, url) {
    return fetch(url).then((r) => {
      if (!r.ok) throw new Error('HTTP ' + r.status);
      return r.arrayBuffer();
    }).then((buffer) => {
      const a = decodeGif(buffer);
      anims.set(handle, a);
      return { w: a.w, h: a.h };
    });
  }

  function animFrameCount(handle) { const a = anims.get(handle); return a ? a.frames.length : 0; }

  function animDelay(handle, i) {
    const a = anims.get(handle);
    return (a && a.frames[i]) ? a.frames[i].delay : -1;
  }

  function animFrame(handle, i) {
    const a = anims.get(handle);
    return (a && a.frames[i]) ? new Uint8Array(a.frames[i].data) : null;
  }

  function animFree(handle) { anims.delete(handle); }

  // WxAnimationCtrl: a canvas showing the frames

  function animShow(w) {
    const st = w.anim;
    const a = anims.get(st.handle);
    const c = st.canvas;
    if (!a) return;
    if (c.width !== a.w || c.height !== a.h) { c.width = a.w; c.height = a.h; }
    const ctx = c.getContext('2d');
    if (!st.playing && st.inactive) {
      // inactive bitmap, scaled to the size of the animation
      const img = images.get(st.inactive);
      ctx.clearRect(0, 0, c.width, c.height);
      if (!img) return;
      if (img.tagName === 'IMG' && !(img.complete && img.naturalWidth)) {
        img.addEventListener('load', () => animShow(w), { once: true });
        return;
      }
      ctx.drawImage(img, 0, 0, c.width, c.height);
      return;
    }
    const f = a.frames[st.frame] || a.frames[0];
    ctx.putImageData(new ImageData(f.data, a.w, a.h), 0, 0);
  }

  function animTick(w) {
    const st = w.anim;
    const a = anims.get(st.handle);
    if (!st.playing || !a || !wins.has(w.id)) return;
    animShow(w);
    const delay = a.frames[st.frame].delay;
    st.frame = (st.frame + 1) % a.frames.length;
    st.timer = setTimeout(() => animTick(w), delay);
  }

  function animCtrlSet(id, handle) {
    const w = wins.get(id);
    if (!w || !w.anim) return;
    clearTimeout(w.anim.timer);
    w.anim.handle = handle;
    w.anim.frame = 0;
    if (w.anim.playing) animTick(w); else animShow(w);
  }

  function animPlay(id, play) {
    const w = wins.get(id);
    if (!w || !w.anim) return;
    const st = w.anim;
    clearTimeout(st.timer);
    st.playing = !!play;
    if (play) { animTick(w); } else { st.frame = 0; animShow(w); }
  }

  function animSetInactive(id, bitmapHandle) {
    const w = wins.get(id);
    if (!w || !w.anim) return;
    w.anim.inactive = bitmapHandle;
    if (!w.anim.playing) animShow(w);
  }

  // text resources (wxLoadStringFromResource)
  function fetchText(url) {
    return fetch(url).then((r) => {
      if (!r.ok) throw new Error('HTTP ' + r.status);
      return r.text();
    });
  }

  // ------------------------- file and directory dialogs -------------------

  // Shows the browser's file chooser. Resolves with an array of
  // { name, path, size, type, file } or with null if the user cancelled.
  // Must be called while handling a user action (click, key press).
  function pickFiles(accept, multiple, directory) {
    return new Promise((resolve) => {
      const input = document.createElement('input');
      input.type = 'file';
      if (accept) input.accept = accept;
      input.multiple = !!multiple;
      if (directory) input.webkitdirectory = true;
      input.style.display = 'none';
      document.body.appendChild(input);
      let done = false;
      const finish = (result) => {
        if (done) return;
        done = true;
        input.remove();
        resolve(result);
      };
      input.addEventListener('change', () => {
        finish(Array.from(input.files || []).map((f) => ({
          name: f.name, path: f.webkitRelativePath || f.name, size: f.size, type: f.type || '', file: f
        })));
      });
      input.addEventListener('cancel', () => finish(null));
      input.click();
    });
  }

  function readFile(file) {
    return file.arrayBuffer().then((b) => new Uint8Array(b));
  }

  // Offers data as a download with the given file name
  function downloadFile(name, data, mime) {
    const url = URL.createObjectURL(new Blob([data], { type: mime || 'application/octet-stream' }));
    const a = document.createElement('a');
    a.href = url;
    a.download = name;
    a.style.display = 'none';
    document.body.appendChild(a);
    a.click();
    a.remove();
    setTimeout(() => URL.revokeObjectURL(url), 30000);
  }

  function blobUrl(data, mime) {
    return URL.createObjectURL(new Blob([data], { type: mime }));
  }

  function revokeUrl(url) {
    try { URL.revokeObjectURL(url); } catch (_) { /* ignore */ }
  }

  function bitmapToPng(handle) {
    const img = images.get(handle);
    if (!img) return null;
    const c = document.createElement('canvas');
    c.width = img.naturalWidth || img.width;
    c.height = img.naturalHeight || img.height;
    if (!c.width || !c.height) return null;
    try {
      c.getContext('2d').drawImage(img, 0, 0);
      const b64 = c.toDataURL('image/png').split(',')[1];
      const bin = atob(b64);
      const out = new Uint8Array(bin.length);
      for (let i = 0; i < bin.length; i++) out[i] = bin.charCodeAt(i);
      return out;
    } catch (err) {
      return null;  // e.g. an image from another origin
    }
  }

  function isDark() {
    return !!(window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches);
  }

  function setDark(dark) {
    document.documentElement.classList.toggle('wxc-dark', !!dark);
  }

  function setAccent(css, onAccent) {
    const root = document.documentElement.style;
    root.setProperty('--wxc-accent', css);
    root.setProperty('--wxc-on-accent', onAccent || '#000');
  }

  window.wxc = {
    init, createWindow, destroyWindow, setRect, measure, clientSize, setLabel,
    setTextAlign, show, enable, setColours, setFont, setToolTip, setFocus, hasFocus,
    setDefaultButton, captureMouse, releaseMouse, showModal, endModal, showModeless,
    enablePaint, refresh, paintContext, loadImage, getImage, freeImage, measureText,
    setMenuBar, updateMenuItem, closeMenus, isDark, setDark, setAccent, dpr,
    textGet, textSet, textReplace, textSelection, textSetSelection, textCommand, textSetOptions,
    checkSet, choiceSetItems, choiceSelect, linkSet, openUrl, htmlSet, htmlLoad, htmlScrollTo,
    sliderSet, gaugeSet, imageFromRGBA, scaleImage, imageToRGBA,
    setScrollTarget, setVirtualSize, scrollTo, scrollPos, toolbarSet, attachToolBar, popupMenu,
    listboxSet, listboxSelect, listboxScroll, listboxTopItem, listboxPerPage: lbPerPage, iconFromPaths,
    setCursor, setCanFocus, screenSize,
    memCanvas, statusBarSet, popupTransient, consoleLog,
    buttonSetBitmap, toggleSet, staticBitmapSet, staticBoxChrome, radioSetGroup, radioboxSet, radioboxSelect,
    spinSet, searchSet, comboSetItems, comboSelect, comboOpen: comboOpenId, comboClose: comboCloseId, collapsibleSet, collapsibleHeader,
    glContext, activitySet, animLoad, animFrameCount, animDelay, animFrame, animFree, animCtrlSet, animPlay, animSetInactive,
    bookSet, bookSelect, bookExpand, bookChrome, fetchText, setDropTarget, dragFeedback, fontScale, touchEvents, mousePosition, windowAt, clientOrigin, blobUrl, revokeUrl, bitmapToPng,
    pickFiles, readFile, downloadFile,
    frameChrome, frameHistory, appBarSet, attachAppBar, appBarAttach, frameMenuBar, fabSet,
    drawerSet, drawerSlotSize, drawerOpen, drawerIsOpen, isTouch, modifiers, infoBar,
    version: '0.7.0'
  };
})();
