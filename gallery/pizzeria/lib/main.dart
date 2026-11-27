// Pizzeria Da Lucia: a restaurant page written with wxDart
//
// A WxScrolledWindow (vertical only) paints a Tuscan landscape as its
// background; in front of it, semi-transparent cards laid out with sizers:
// intro, directions with a drawn street map, the menu and the drinks.
// All content is made-up sample data.

import 'dart:math';

import 'dart:typed_data';

import 'package:wx_dart/wx_dart.dart';

// ------------------------------------------------------------ Colours

final terracotta = WxColour(178, 74, 44);
final olive = WxColour(92, 104, 52);
final ink = WxColour(48, 36, 28);
final muted = WxColour(116, 98, 84);
final cardColour = WxColour(255, 250, 241, alpha: 236);   // slightly translucent

// ------------------------------------------------------------ Data

class Dish {
  const Dish(this.name, this.description, this.price);
  final String name;
  final String description;
  final double price;
}

class Section {
  const Section(this.title, this.icon, this.dishes);
  final String title;
  final WxMaterialIcon icon;
  final List<Dish> dishes;
}

final food = [
  Section("Starters", WxMaterialIcon.tapas, [
    Dish("Bruschetta al pomodoro", "Toasted bread with tomatoes, basil and garlic", 6.50),
    Dish("Vitello tonnato", "Thinly sliced veal with tuna sauce and capers", 12.90),
    Dish("Burrata", "With cherry tomatoes, rocket and olive oil from Apulia", 11.50),
  ]),
  Section("Pizza", WxMaterialIcon.local_pizza, [
    Dish("Margherita", "Tomatoes, fior di latte, basil", 8.90),
    Dish("Diavola", "Tomatoes, mozzarella, spicy salami, chili", 11.50),
    Dish("Quattro Formaggi", "Mozzarella, gorgonzola, taleggio, parmigiano", 12.50),
    Dish("Capricciosa", "Ham, mushrooms, artichokes, olives", 12.90),
    Dish("Lucia", "Our house pizza: burrata, Parma ham, rocket, cherry tomatoes", 14.90),
  ]),
  Section("Pasta", WxMaterialIcon.dinner_dining, [
    Dish("Spaghetti Carbonara", "Guanciale, egg yolk, pecorino romano, black pepper", 12.50),
    Dish("Penne all'arrabbiata", "Tomato sauce with garlic and peperoncino", 10.50),
    Dish("Tagliatelle al ragù", "Homemade ribbon pasta with Bolognese-style beef ragù", 13.90),
  ]),
  Section("Salads", WxMaterialIcon.spa, [
    Dish("Insalata mista", "Leaf salad, tomatoes, cucumber, carrots", 7.50),
    Dish("Caprese", "Tomatoes, buffalo mozzarella, basil", 10.50),
    Dish("Insalata Lucia", "Rocket, pear, walnuts, gorgonzola", 11.90),
  ]),
  Section("Ice cream", WxMaterialIcon.icecream, [
    Dish("Stracciatella", "Cream ice cream with chocolate flakes", 2.20),
    Dish("Pistacchio", "With pistachios from Bronte", 2.50),
    Dish("Limone", "Sorbet made from Amalfi lemons", 2.20),
    Dish("Cioccolato", "Dark chocolate", 2.20),
    Dish("Fragola", "Strawberry", 2.20),
  ]),
  Section("Coffee", WxMaterialIcon.coffee, [
    Dish("Espresso", "", 2.40),
    Dish("Cappuccino", "", 3.40),
    Dish("Caffè latte", "", 3.80),
    Dish("Caffè corretto", "Espresso with a dash of grappa", 4.50),
  ]),
];

final drinks = [
  Section("Soft drinks", WxMaterialIcon.local_drink, [
    Dish("Acqua naturale", "Still water, 0.75 l", 5.50),
    Dish("Acqua frizzante", "Sparkling water, 0.75 l", 5.50),
    Dish("Cola", "0.33 l", 3.50),
    Dish("Aranciata", "Orange soda, 0.33 l", 3.50),
  ]),
  Section("Red wine", WxMaterialIcon.wine_bar, [
    Dish("Chianti Classico", "Tuscany, Sangiovese, dry – glass 0.2 l", 7.50),
    Dish("Montepulciano d'Abruzzo", "Abruzzo, full and fruity – glass 0.2 l", 6.50),
    Dish("Primitivo di Manduria", "Apulia, full-bodied – glass 0.2 l", 7.90),
    Dish("Nero d'Avola", "Sicily, velvety – glass 0.2 l", 6.90),
  ]),
  Section("White wine", WxMaterialIcon.wine_bar, [
    Dish("Pinot Grigio", "Veneto, fresh and light – glass 0.2 l", 6.50),
    Dish("Vermentino", "Sardinia, mineral – glass 0.2 l", 7.20),
  ]),
];

String euro(double price) => "€${price.toStringAsFixed(2)}";

// ------------------------------------------------------------ Street map

/// A small drawn street map with the station, streets and the restaurant
class StreetMap extends WxWindow {
  StreetMap(WxWindow parent) : super(parent, -1, wxDefaultPosition, const WxSize(-1, 220), 0) {
    setMinSize(const WxSize(200, 220));
    bindPaintEvent(onPaint);
  }

  void onPaint(WxPaintEvent event) {
    final dc = WxPaintDC(this);
    final size = getClientSize();
    final w = size.x, h = size.y;
    dc.setPen(wxTRANSPARENT_PEN);
    dc.setBrush(WxBrush(WxColour(238, 232, 218)));
    dc.drawRectangle(0, 0, w, h);
    // park and river
    dc.setBrush(WxBrush(WxColour(196, 216, 170)));
    dc.drawRoundedRectangle((w * 0.62).round(), 14, (w * 0.3).round(), 70, 10);
    dc.setPen(WxPen(WxColour(150, 190, 215), width: 14));
    dc.drawSpline([WxPoint(0, h - 30), WxPoint((w * 0.3).round(), h - 50), WxPoint((w * 0.7).round(), h - 20), WxPoint(w, h - 40)]);
    // streets
    dc.setPen(WxPen(wxWHITE, width: 9));
    for (final x in [0.18, 0.5, 0.82]) {
      dc.drawLine((w * x).round(), 0, (w * x).round(), h - 60);
    }
    dc.drawLine(0, 110, w, 110);
    dc.drawLine(0, 40, (w * 0.55).round(), 40);
    // route from the station to the restaurant
    final station = WxPoint((w * 0.18).round(), 40);
    final target = WxPoint((w * 0.82).round(), 110);
    dc.setPen(WxPen(terracotta, width: 3, style: wxPENSTYLE_SHORT_DASH));
    dc.drawLines([station, WxPoint(station.x, 110), target]);
    // station
    dc.setPen(wxTRANSPARENT_PEN);
    dc.setBrush(WxBrush(WxColour(70, 80, 110)));
    dc.drawRoundedRectangle(station.x - 30, station.y - 16, 60, 32, 6);
    dc.setFont(WxFont(11, weight: wxFONTWEIGHT_BOLD));
    dc.setTextForeground(wxWHITE);
    dc.drawText("Station", station.x - 23, station.y - 8);
    // the restaurant: a map pin
    dc.setBrush(WxBrush(terracotta));
    dc.drawCircle(target.x, target.y - 22, 13);
    dc.drawPolygon([WxPoint(target.x - 9, target.y - 15), WxPoint(target.x + 9, target.y - 15), WxPoint(target.x, target.y)]);
    dc.setBrush(wxWHITE_BRUSH);
    dc.drawCircle(target.x, target.y - 22, 5);
    dc.setTextForeground(ink);
    dc.setFont(WxFont(12, weight: wxFONTWEIGHT_BOLD));
    final label = "Da Lucia";
    final extent = dc.getTextExtent(label);
    dc.drawText(label, min(target.x - extent.x ~/ 2, w - extent.x - 6), target.y + 6);
    dc.setFont(WxFont(10));
    dc.setTextForeground(muted);
    dc.drawText("Via Roma", 8, 114 - 22);
    dc.drawText("Riverside", 8, h - 26);
  }
}

// ------------------------------------------------------------ Page

class RestaurantPage extends WxScrolledWindow {
  RestaurantPage(WxWindow parent) : super(parent, -1, style: wxVSCROLL) {
    bindPaintEvent(onPaint);
    // the landscape stays put while the cards scroll
    setPaintFixed(true);
    // the cards are 760 pixels wide and determine the width of the column,
    // which the two stretchable spacers keep in the middle
    final page = WxColumn();

    // heading directly on the landscape
    final name = WxStaticText(this, -1, "Pizzeria Da Lucia", style: wxST_WRAP);
    name.setFont(WxFont(40, family: wxFONTFAMILY_ROMAN, weight: wxFONTWEIGHT_BOLD, style: wxFONTSTYLE_ITALIC));
    name.setForegroundColour(wxWHITE);
    page.addSpacer(70);
    page.add(name);
    final claim = WxStaticText(this, -1, "Neapolitan wood-fired pizza · since 1987", style: wxST_WRAP);
    claim.setFont(WxFont(17));
    claim.setForegroundColour(WxColour(255, 246, 228));
    page.addSpacer(6);
    page.add(claim);
    page.addSpacer(156);

    // Intro
    final intro = card(page, "Benvenuti!", WxMaterialIcon.restaurant);
    start = intro.panel;
    paragraph(intro, "At Lucia's the dough rises for 48 hours, the tomatoes come from Vesuvius "
        "and the mozzarella arrives from Campania twice a week. Our wood-fired oven heats up to 450 °C – "
        "your pizza is ready in 90 seconds.");
    paragraph(intro, "Open Tuesday to Sunday, 12:00–14:30 and 18:00–23:00. Closed on Mondays. "
        "Book a table on 0761 123 456.");
    intro.sizer.addSpacer(16);

    // Directions
    final way = card(page, "Getting here", WxMaterialIcon.directions);
    directions = way.panel;
    paragraph(way, "Via Roma 12, 79098 Freiburg (sample address). It is a five-minute walk from the "
        "station: down Station Street, turn left into Via Roma and walk on to the park. There is "
        "parking in the multi-storey car park by the river.");
    way.sizer.add(StreetMap(way.panel), flag: wxEXPAND | wxLEFT | wxRIGHT | wxTOP, border: 16);
    way.sizer.add(WxHyperlinkCtrl(way.panel, -1, "Plan your route in OpenStreetMap", "https://www.openstreetmap.org"),
        flag: wxALL, border: 16);

    // Menu and drinks
    final menu = card(page, "Menu", WxMaterialIcon.restaurant_menu);
    menuCard = menu.panel;
    for (final section in food) {
      addSection(menu, section);
    }
    final drink = card(page, "Drinks", WxMaterialIcon.local_bar);
    drinksCard = drink.panel;
    for (final section in drinks) {
      addSection(drink, section);
    }

    final footer = WxStaticText(this, -1, "All prices in euros incl. VAT · All details are sample data.",
        style: wxST_WRAP);
    footer.setForegroundColour(wxWHITE);
    page.addSpacer(24);
    page.add(footer);
    page.addSpacer(24);

    final row = WxRow();
    row.addStretchSpacer(prop: 1);
    row.addSizer(page, flag: wxEXPAND);
    row.addStretchSpacer(prop: 1);
    setSizer(row);
  }

  late WxWindow start, directions, menuCard, drinksCard;

  WxUIAnimation? _scrolling;

  /// Scrolls smoothly to the card: WxUIAnimation delivers a value from
  /// 0 to 1 per frame (here accelerating and decelerating), which becomes
  /// the position between start and target
  void scrollToCard(WxWindow card) {
    _scrolling?.stop();
    final from = getViewStartPixels().y;
    // not beyond the end of the page
    final end = max(0, getVirtualSize().y - getClientSize().y);
    // getPosition() is relative to the visible area (as in wxWidgets),
    // calcUnscrolledPosition() turns it into the position on the whole page
    final to = min(end, max(0, calcUnscrolledPosition(card.getPosition()).y - 12));
    if (from == to) return;
    // long distances take a little longer, but never more than 0.7 seconds
    final millisecs = min(700, 250 + (to - from).abs() ~/ 6);
    _scrolling = WxUIAnimation((t) {
      scrollPixels(-1, (from + (to - from) * t).round());
    }, millisecs, curve: wxCURVE_EASE_IN_EASE_OUT);
    _scrolling!.start();
  }

  ({WxPanel panel, WxBoxSizer sizer}) card(WxSizer page, String title, WxMaterialIcon icon) {
    final panel = WxPanel(this, -1, size: const WxSize(760, -1));
    panel.setBackgroundColour(cardColour);
    final sizer = WxBoxSizer(wxVERTICAL);
    final head = WxRow();
    head.add(WxStaticBitmap(panel, -1, WxBitmapBundle.fromMaterialIcon(icon, const WxSize(32, 32), colour: terracotta)),
        flag: wxALIGN_CENTER_VERTICAL | wxRIGHT, border: 10);
    final text = WxStaticText(panel, -1, title);
    text.setFont(WxFont(26, family: wxFONTFAMILY_ROMAN, weight: wxFONTWEIGHT_BOLD));
    text.setForegroundColour(ink);
    head.add(text, flag: wxALIGN_CENTER_VERTICAL);
    sizer.addSizer(head, flag: wxLEFT | wxRIGHT | wxTOP, border: 20);
    panel.setSizer(sizer);
    page.addSpacer(20);
    page.add(panel, flag: wxEXPAND);
    return (panel: panel, sizer: sizer);
  }

  void paragraph(({WxPanel panel, WxBoxSizer sizer}) card, String text) {
    final st = WxStaticText(card.panel, -1, text, style: wxST_WRAP);
    st.setFont(WxFont(15));
    st.setForegroundColour(ink);
    card.sizer.add(st, flag: wxEXPAND | wxLEFT | wxRIGHT | wxTOP, border: 16);
    // gap at the end of the card
    card.sizer.addSpacer(4);
  }

  void addSection(({WxPanel panel, WxBoxSizer sizer}) card, Section section) {
    final panel = card.panel;
    final head = WxRow();
    head.add(WxStaticBitmap(panel, -1, WxBitmapBundle.fromMaterialIcon(section.icon, const WxSize(22, 22), colour: olive)),
        flag: wxALIGN_CENTER_VERTICAL | wxRIGHT, border: 8);
    final title = WxStaticText(panel, -1, section.title);
    title.setFont(WxFont(18, weight: wxFONTWEIGHT_BOLD));
    title.setForegroundColour(olive);
    head.add(title, flag: wxALIGN_CENTER_VERTICAL);
    card.sizer.addSizer(head, flag: wxLEFT | wxRIGHT | wxTOP, border: 20);
    card.sizer.add(WxStaticLine(panel, -1), flag: wxEXPAND | wxLEFT | wxRIGHT | wxTOP, border: 20);

    for (final dish in section.dishes) {
      final row = WxRow();
      final texts = WxColumn();
      final name = WxStaticText(panel, -1, dish.name, style: wxST_WRAP);
      name.setFont(WxFont(15, weight: wxFONTWEIGHT_BOLD));
      name.setForegroundColour(ink);
      texts.add(name, flag: wxEXPAND);
      if (dish.description.isNotEmpty) {
        final desc = WxStaticText(panel, -1, dish.description, style: wxST_WRAP);
        desc.setFont(WxFont(13));
        desc.setForegroundColour(muted);
        texts.add(desc, flag: wxEXPAND | wxTOP, border: 2);
      }
      row.addSizer(texts, proportion: 1, flag: wxRIGHT, border: 16);
      final price = WxStaticText(panel, -1, euro(dish.price));
      price.setFont(WxFont(15, weight: wxFONTWEIGHT_BOLD));
      price.setForegroundColour(terracotta);
      row.add(price);
      card.sizer.addSizer(row, flag: wxEXPAND | wxLEFT | wxRIGHT | wxTOP, border: 20);
    }
    card.sizer.addSpacer(16);
  }

  // ---------------------------------------------- Background landscape

  /// Tuscany: sky, sun, hills, cypresses and a village. Without
  /// doPrepareDC the picture stays put while the cards scroll.
  void onPaint(WxPaintEvent event) {
    final dc = WxPaintDC(this);
    final size = getClientSize();
    final w = size.x, h = size.y;
    // sky
    dc.gradientFillLinear(WxRect(0, 0, w, (h * 0.62).round()), WxColour(244, 170, 110), WxColour(120, 160, 210),
        nDirection: wxUP);
    // sun
    dc.setPen(wxTRANSPARENT_PEN);
    dc.setBrush(WxBrush(WxColour(255, 226, 160, alpha: 200)));
    dc.drawCircle((w * 0.78).round(), (h * 0.36).round(), 46);
    dc.setBrush(WxBrush(WxColour(255, 244, 214)));
    dc.drawCircle((w * 0.78).round(), (h * 0.36).round(), 30);

    // ranges of hills from back to front
    hills(dc, w, h, 0.48, 0.05, WxColour(150, 150, 170), 1.3);
    hills(dc, w, h, 0.56, 0.06, WxColour(122, 140, 110), 2.1);
    village(dc, (w * 0.28).round(), (h * 0.55).round());
    hills(dc, w, h, 0.66, 0.07, WxColour(110, 128, 70), 3.2);
    // vineyard: rows on the front hill
    hills(dc, w, h, 0.78, 0.06, WxColour(132, 140, 66), 4.4);
    dc.setPen(WxPen(WxColour(96, 110, 50), width: 2));
    for (int i = 0; i < 9; i++) {
      final y = (h * (0.82 + i * 0.022)).round();
      dc.drawLine(0, y + i * 3, w, y - 8 + i * 2);
    }
    // cypresses along the road
    for (int i = 0; i < 7; i++) {
      final x = (w * (0.55 + i * 0.065)).round();
      final y = (h * (0.66 - i * 0.012)).round();
      cypress(dc, x, y, 22 - i * 2);
    }
  }

  void hills(WxDC dc, int w, int h, double base, double amp, WxColour colour, double phase) {
    final points = <WxPoint>[WxPoint(0, h)];
    for (int i = 0; i <= (w / 12).ceil(); i++) {
      final x = min(w, i * 12);   // the last point lies exactly on the edge
      final y = h * base - h * amp * (sin(x / w * 5 + phase) * 0.6 + sin(x / w * 11 + phase * 2) * 0.4);
      points.add(WxPoint(x, y.round()));
    }
    points.add(WxPoint(w, h));
    dc.setPen(wxTRANSPARENT_PEN);
    dc.setBrush(WxBrush(colour));
    dc.drawPolygon(points, fillStyle: wxWINDING_RULE);
  }

  void cypress(WxDC dc, int x, int base, int scale) {
    dc.setPen(wxTRANSPARENT_PEN);
    dc.setBrush(WxBrush(WxColour(40, 66, 36)));
    dc.drawEllipse(x - scale ~/ 4, base - scale * 4, scale ~/ 2, scale * 4);
    dc.setBrush(WxBrush(WxColour(60, 40, 30)));
    dc.drawRectangle(x - 1, base - 3, 3, 6);
  }

  void village(WxDC dc, int x, int y) {
    final houses = [(0, 0, 26, 18), (24, -6, 20, 24), (42, 2, 30, 16), (-20, 6, 22, 14)];
    for (final (dx, dy, hw, hh) in houses) {
      dc.setPen(wxTRANSPARENT_PEN);
      dc.setBrush(WxBrush(WxColour(236, 214, 180)));
      dc.drawRectangle(x + dx, y + dy - hh, hw, hh);
      dc.setBrush(WxBrush(WxColour(186, 92, 60)));
      dc.drawPolygon([WxPoint(x + dx - 2, y + dy - hh), WxPoint(x + dx + hw ~/ 2, y + dy - hh - 8), WxPoint(x + dx + hw + 2, y + dy - hh)]);
    }
    // church tower
    dc.setBrush(WxBrush(WxColour(226, 200, 160)));
    dc.drawRectangle(x + 30, y - 52, 10, 34);
    dc.setBrush(WxBrush(WxColour(186, 92, 60)));
    dc.drawPolygon([WxPoint(x + 28, y - 52), WxPoint(x + 35, y - 64), WxPoint(x + 42, y - 52)]);
  }
}

// ------------------------------------------------------------ Menu as PDF

/// The menu as a PDF (A4): a drawn header on the first page, then the
/// sections, spread over as many pages as needed
class MenuPdf {
  static const pageW = 595.28, pageH = 841.89, margin = 50.0;
  static const contentW = pageW - 2 * margin;
  static const headerH = 170.0, footerH = 40.0;

  final nameFont = WxPDFFont.std(size: 11, bold: true);
  final descFont = WxPDFFont.std(size: 9);
  final sectionFont = WxPDFFont.std(family: wxFONTFAMILY_ROMAN, size: 17, bold: true);
  final groupFont = WxPDFFont.std(family: wxFONTFAMILY_ROMAN, size: 24, bold: true, italic: true);

  /// A block is a section title or a dish
  late final List<({String? title, Dish? dish, double height})> blocks;
  /// For every page: the indices of the blocks on it
  final pages = <List<int>>[];

  MenuPdf() {
    blocks = [];
    void addGroup(String group, List<Section> sections) {
      blocks.add((title: "#$group", dish: null, height: 46));
      for (final section in sections) {
        blocks.add((title: section.title, dish: null, height: 34));
        for (final dish in section.dishes) {
          blocks.add((title: null, dish: dish, height: dishHeight(dish)));
        }
      }
    }
    addGroup("Food", food);
    addGroup("Drinks", drinks);
    paginate();
  }

  /// Splits [text] into lines at most [width] wide
  List<String> wrap(String text, WxPDFFont font, double width) {
    final lines = <String>[];
    var line = "";
    for (final word in text.split(' ')) {
      final candidate = line.isEmpty ? word : "$line $word";
      if (line.isNotEmpty && font.lineWidth(candidate) > width) {
        lines.add(line);
        line = word;
      } else {
        line = candidate;
      }
    }
    if (line.isNotEmpty) lines.add(line);
    return lines;
  }

  double dishHeight(Dish dish) {
    final desc = dish.description.isEmpty ? 0 : wrap(dish.description, descFont, contentW - 90).length;
    return 16 + desc * 11 + 7;
  }

  /// Distributes the blocks over pages; a title is never left alone at the bottom of a page
  void paginate() {
    var page = <int>[];
    var y = margin + headerH;
    for (int i = 0; i < blocks.length; i++) {
      final b = blocks[i];
      var needed = b.height;
      if (b.title != null && i + 1 < blocks.length) needed += blocks[i + 1].height;
      if (y + needed > pageH - footerH - margin && page.isNotEmpty) {
        pages.add(page);
        page = [];
        y = margin;
      }
      page.add(i);
      y += b.height;
    }
    if (page.isNotEmpty) pages.add(page);
  }

  Future<Uint8List> build() async {
    final out = WxPDFUint8ListOutput();
    // without deflate the PDF is uncompressed, which is fine for a menu
    final gc = WxPDFGraphicsContext(out, title: "Menu Pizzeria Da Lucia", author: "Pizzeria Da Lucia");
    await gc.generate(pageCount: pages.length, renderPage: renderPage);
    return out.result;
  }

  void text(WxPDFGraphicsContext gc, String s, WxPDFFont font, WxColour colour, double x, double y) {
    gc.setPDFFont(font, colour);
    gc.drawText(s, x, y);
  }

  void renderPage(WxPDFGraphicsContext gc, int page) {
    var y = margin;
    if (page == 0) {
      drawHeader(gc);
      y += headerH;
    }
    for (final i in pages[page]) {
      final b = blocks[i];
      final title = b.title;
      if (title != null && title.startsWith('#')) {
        text(gc, title.substring(1), groupFont, ink, margin, y + 8);
        gc.setPenWithConstantColour(terracotta, width: 1.5);
        gc.strokeLine(margin, y + 40, margin + contentW, y + 40);
      } else if (title != null) {
        text(gc, title, sectionFont, olive, margin, y + 10);
      } else {
        final dish = b.dish!;
        text(gc, dish.name, nameFont, ink, margin, y);
        final price = euro(dish.price);
        text(gc, price, nameFont, terracotta, margin + contentW - nameFont.lineWidth(price), y);
        // dotted line between name and price
        final from = margin + nameFont.lineWidth(dish.name) + 6;
        final to = margin + contentW - nameFont.lineWidth(price) - 6;
        if (to > from) {
          gc.setPenWithConstantColour(WxColour(190, 175, 160), width: 0.6, style: wxPENSTYLE_DOT);
          gc.strokeLine(from, y + 10, to, y + 10);
        }
        var dy = y + 15;
        if (dish.description.isNotEmpty) {
          for (final line in wrap(dish.description, descFont, contentW - 90)) {
            text(gc, line, descFont, muted, margin, dy);
            dy += 11;
          }
        }
      }
      y += b.height;
    }
    // footer
    // hairline: setPenWithConstantColour() takes the width as a double
    gc.setPenWithConstantColour(WxColour(220, 205, 190), width: 0.5);
    gc.strokeLine(margin, pageH - margin - 14, margin + contentW, pageH - margin - 14);
    final small = WxPDFFont.std(size: 8);
    text(gc, "Pizzeria Da Lucia · Via Roma 12 · Tel. 0761 123 456 · All prices in euros incl. VAT · Sample data",
        small, muted, margin, pageH - margin - 8);
    final number = "Page ${page + 1} of ${pages.length}";
    text(gc, number, small, muted, margin + contentW - small.lineWidth(number), pageH - margin - 8);
  }

  /// The header: sky, hills and cypresses, with the name on top
  void drawHeader(WxPDFGraphicsContext gc) {
    const x = margin, y = margin, w = contentW, h = headerH - 24;
    gc.pushState();
    gc.clip(x, y, w, h);
    gc.setPen(wxTRANSPARENT_PEN);
    gc.setBrush(WxBrush(WxColour(232, 168, 112)));
    gc.drawRectangle(x, y, w, h);
    gc.setBrush(WxBrush(WxColour(250, 226, 170)));
    gc.drawEllipse(x + w * 0.74, y + h * 0.32, 44, 44);
    void hill(double base, double amp, WxColour colour, double phase) {
      final path = gc.createPath()..moveTo(x, y + h);
      for (int i = 0; i <= 40; i++) {
        final px = x + w * i / 40;
        path.addLineTo(px, y + h * base - h * amp * (sin(i / 40 * 5 + phase) * 0.6 + sin(i / 40 * 11 + phase * 2) * 0.4));
      }
      path.addLineTo(x + w, y + h);
      path.closeSubpath();
      gc.setBrush(WxBrush(colour));
      gc.fillPath(path);
    }
    hill(0.62, 0.08, WxColour(150, 150, 170), 1.3);
    hill(0.74, 0.08, WxColour(122, 140, 110), 2.1);
    hill(0.88, 0.07, WxColour(110, 128, 70), 3.2);
    gc.setBrush(WxBrush(WxColour(40, 66, 36)));
    for (int i = 0; i < 6; i++) {
      final cx = x + w * (0.56 + i * 0.07);
      final base = y + h * (0.86 - i * 0.02);
      gc.drawEllipse(cx - 4, base - 34 + i * 2, 8, 34 - i * 2);
    }
    gc.popState();
    text(gc, "Pizzeria Da Lucia", WxPDFFont.std(family: wxFONTFAMILY_ROMAN, size: 32, bold: true, italic: true),
        wxWHITE, x + 20, y + 20);
    text(gc, "Neapolitan wood-fired pizza · since 1987", WxPDFFont.std(size: 11),
        WxColour(255, 246, 228), x + 22, y + 62);
  }
}

// ------------------------------------------------------------ Frame

const idStart = 100, idWay = 101, idMenu = 102, idDrinks = 103, idPdf = 104;

class RestaurantFrame extends WxFrame {
  RestaurantFrame() : super(null, -1, "Pizzeria Da Lucia") {
    final page = RestaurantPage(this);
    final toolbar = createToolBar(style: wxTB_DEFAULT_STYLE | wxTB_TEXT);
    WxBitmapBundle icon(WxMaterialIcon i) => WxBitmapBundle.fromMaterialIcon(i, const WxSize(24, 24), colour: terracotta);
    toolbar.addTool(idStart, "Welcome", icon(WxMaterialIcon.restaurant));
    toolbar.addTool(idWay, "Directions", icon(WxMaterialIcon.location_on));
    toolbar.addTool(idMenu, "Menu", icon(WxMaterialIcon.local_pizza));
    toolbar.addTool(idDrinks, "Drinks", icon(WxMaterialIcon.wine_bar));
    toolbar.addSeparator();
    toolbar.addTool(idPdf, "PDF", icon(WxMaterialIcon.picture_as_pdf));
    toolbar.realize();
    bindMenuEvent((_) => page.scrollToCard(page.start), idStart);
    bindMenuEvent((_) => page.scrollToCard(page.directions), idWay);
    bindMenuEvent((_) => page.scrollToCard(page.menuCard), idMenu);
    bindMenuEvent((_) => page.scrollToCard(page.drinksCard), idDrinks);
    // The menu as a PDF: saved, downloaded or shared, depending on the
    // device. The PDF is built right inside the click handler so that the
    // browser still allows the save dialog or the share sheet.
    bindMenuEvent((_) async {
      final pdf = await MenuPdf().build();
      await wxExportDocument(this, pdf, "Menu Da Lucia.pdf",
          mimeType: "application/pdf", message: "Menu of Pizzeria Da Lucia");
    }, idPdf);
  }
}

class RestaurantApp extends WxApp {
  @override
  bool onInit() {
    RestaurantFrame().show();
    return true;
  }
}

void main() {
  final app = RestaurantApp();
  app.run();
  app.dispose();
}
