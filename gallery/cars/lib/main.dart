// Car Search: an almost endless list written with wxDart
//
// - WxDataViewCtrl with a WxDataViewVirtualListModel: the cars are not
//   stored, but generated per row from the search criteria
// - a custom renderer draws every row (photo, title, details, price)
// - thumbnails are "loaded" asynchronously (generated after a random
//   delay, as if from a server) and kept in a cache
// - when you approach the end of the list, more cars are loaded
// - a click opens a detail page with 1 to 7 photos
//
// All vehicles, prices and dealers are made up.

import 'dart:async';
import 'dart:math';

import 'dart:typed_data';

import 'package:wx_dart/wx_dart.dart';

// ------------------------------------------------------------ Data

const brands = {
  "Audi": ["A3", "A4", "A6", "Q5"],
  "BMW": ["1 Series", "3 Series", "5 Series", "X3", "i4"],
  "Fiat": ["500", "Panda", "Tipo"],
  "Ford": ["Fiesta", "Focus", "Kuga"],
  "Mercedes": ["A-Class", "C-Class", "E-Class", "GLC"],
  "Opel": ["Corsa", "Astra", "Mokka"],
  "Skoda": ["Fabia", "Octavia", "Superb"],
  "Tesla": ["Model 3", "Model Y"],
  "Toyota": ["Yaris", "Corolla", "RAV4"],
  "VW": ["Polo", "Golf", "Passat", "Tiguan", "ID.3"],
};
const electricModels = {"i4", "Model 3", "Model Y", "ID.3"};
const suvModels = {"Q5", "X3", "Kuga", "GLC", "Mokka", "RAV4", "Tiguan", "Model Y"};
const fuels = ["Petrol", "Diesel", "Hybrid", "Electric"];
const gearboxes = ["Manual", "Automatic"];
const colourNames = ["Black", "White", "Silver", "Blue", "Red", "Grey", "Green"];
final paints = [
  WxColour(30, 30, 34), WxColour(236, 236, 232), WxColour(176, 180, 186), WxColour(36, 76, 150),
  WxColour(170, 30, 36), WxColour(96, 100, 106), WxColour(40, 96, 66),
];
const cities = ["Berlin", "Hamburg", "Munich", "Cologne", "Frankfurt", "Stuttgart", "Leipzig", "Freiburg", "Bremen", "Dresden"];
const dealers = ["Sunshine Motors", "Car Center North", "Private seller", "Weber Cars", "Auto World South"];
const priceLimits = [0, 10000, 20000, 30000, 50000, 80000];
const kmLimits = [0, 20000, 50000, 100000, 150000];
const yearLimits = [0, 2016, 2018, 2020, 2022, 2024];

/// The search criteria; 0 or -1 means "any"
class Filter {
  String brand = "";
  int fuel = -1;
  int gearbox = -1;
  int maxPrice = 0;
  int maxKm = 0;
  int minYear = 0;
  int colour = -1;

  int get seed => Object.hash(brand, fuel, gearbox, maxPrice, maxKm, minYear, colour);
}

class Car {
  Car(this.row, this.generation, this.brand, this.model, this.year, this.month, this.km, this.fuel, this.gearbox,
      this.colour, this.price, this.city, this.dealer, this.power, this.photoCount);
  final int row, generation;
  final String brand, model;
  final int year, month, km, fuel, gearbox, colour, price, power, photoCount;
  final String city, dealer;

  String get title => "$brand $model";
  bool get isSuv => suvModels.contains(model);
  String get key => "$generation/$row";
}

String thousands(int value) {
  final s = value.toString();
  final buffer = StringBuffer();
  for (int i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buffer.write(',');
    buffer.write(s[i]);
  }
  return buffer.toString();
}

/// Generates the car in row [row] matching the search criteria. The same
/// criteria and the same row always give the same car.
Car makeCar(Filter f, int generation, int row) {
  final rnd = Random(f.seed ^ (row * 7919 + 17));
  T pick<T>(List<T> list) => list[rnd.nextInt(list.length)];
  var fuel = f.fuel >= 0 ? f.fuel : rnd.nextInt(fuels.length);
  String brand;
  String model;
  if (fuel == 3) {
    // electric cars only from matching models
    final candidates = <(String, String)>[];
    brands.forEach((b, models) {
      for (final m in models) {
        if (electricModels.contains(m) && (f.brand.isEmpty || f.brand == b)) candidates.add((b, m));
      }
    });
    (brand, model) = candidates.isEmpty ? (f.brand, pick(brands[f.brand]!)) : pick(candidates);
  } else {
    brand = f.brand.isNotEmpty ? f.brand : pick(brands.keys.toList());
    final models = brands[brand]!.where((m) => !electricModels.contains(m)).toList();
    model = pick(models.isEmpty ? brands[brand]! : models);
    // a brand with only electric cars (Tesla) does not run on diesel
    if (models.isEmpty) fuel = 3;
  }
  final minYear = f.minYear > 0 ? f.minYear : 2012;
  final year = minYear + rnd.nextInt(2026 - minYear + 1);
  final age = 2026 - year;
  final maxKm = f.maxKm > 0 ? f.maxKm : 220000;
  final km = min(maxKm, (age * 9000 + rnd.nextInt(16000)) * (0.6 + rnd.nextDouble() * 0.8)).round() ~/ 100 * 100;
  // the price drops with age and mileage, but stays below the limit
  var price = (52000 * pow(0.86, age) * (1 - km / 400000) * (0.7 + rnd.nextDouble() * 0.6)).round();
  if (f.maxPrice > 0 && price > f.maxPrice) price = (f.maxPrice * (0.75 + rnd.nextDouble() * 0.25)).round();
  price = max(1500, price ~/ 100 * 100 - 10);
  return Car(row, generation, brand, model, year, 1 + rnd.nextInt(12), km, fuel,
      f.gearbox >= 0 ? f.gearbox : (fuel == 3 ? 1 : rnd.nextInt(2)),
      f.colour >= 0 ? f.colour : rnd.nextInt(colourNames.length),
      price, pick(cities), pick(dealers), 70 + rnd.nextInt(230), 1 + rnd.nextInt(7));
}

// ------------------------------------------------------------ Images

/// Draws a car from the side (view 0), the front (1), the back (2),
/// the cockpit (3) or a wheel (4) into the area w x h
void drawCar(WxDC dc, int w, int h, Car car, int view, int variant) {
  final paint = paints[car.colour];
  dc.setPen(wxTRANSPARENT_PEN);
  // background: sky and road, slightly different per photo
  final skies = [WxColour(196, 216, 236), WxColour(232, 220, 204), WxColour(208, 214, 222)];
  dc.gradientFillLinear(WxRect(0, 0, w, h * 2 ~/ 3), skies[variant % 3], wxWHITE, nDirection: wxDOWN);
  dc.setBrush(WxBrush(variant.isEven ? WxColour(150, 150, 150) : WxColour(122, 132, 110)));
  dc.drawRectangle(0, h * 2 ~/ 3, w, h - h * 2 ~/ 3);
  dc.setBrush(WxBrush(WxColour(0, 0, 0, alpha: 40)));
  dc.drawEllipse(w ~/ 10, h * 3 ~/ 4 - 4, w * 8 ~/ 10, h ~/ 9);

  final dark = WxBrush(WxColour(34, 34, 38));
  final glass = WxBrush(WxColour(70, 96, 120));
  final body = WxBrush(paint);
  final outline = WxPen(WxColour(0, 0, 0, alpha: 90), width: 1);

  switch (view) {
    case 1: // front
    case 2: // back
      final cx = w ~/ 2, bw = w * 54 ~/ 100, bh = h * 36 ~/ 100, top = h * 34 ~/ 100;
      dc.setBrush(dark);
      dc.drawRoundedRectangle(cx - bw ~/ 2 + 6, top + bh - 8, 22, h ~/ 7, 4);
      dc.drawRoundedRectangle(cx + bw ~/ 2 - 28, top + bh - 8, 22, h ~/ 7, 4);
      dc.setPen(outline);
      dc.setBrush(body);
      dc.drawRoundedRectangle(cx - bw ~/ 2, top + bh ~/ 3, bw, bh, 12);
      dc.drawRoundedRectangle(cx - bw * 36 ~/ 100, top - bh ~/ 6, bw * 72 ~/ 100, bh ~/ 2 + 8, 14);
      dc.setBrush(glass);
      dc.drawRoundedRectangle(cx - bw * 30 ~/ 100, top - bh ~/ 10, bw * 60 ~/ 100, bh * 34 ~/ 100, 8);
      dc.setPen(wxTRANSPARENT_PEN);
      final lamp = WxBrush(view == 1 ? WxColour(250, 246, 220) : WxColour(200, 30, 30));
      dc.setBrush(lamp);
      dc.drawRoundedRectangle(cx - bw * 44 ~/ 100, top + bh * 50 ~/ 100, bw * 18 ~/ 100, bh * 14 ~/ 100, 4);
      dc.drawRoundedRectangle(cx + bw * 26 ~/ 100, top + bh * 50 ~/ 100, bw * 18 ~/ 100, bh * 14 ~/ 100, 4);
      dc.setBrush(WxBrush(view == 1 ? WxColour(40, 40, 44) : WxColour(236, 236, 236)));
      dc.drawRoundedRectangle(cx - bw * 15 ~/ 100, top + bh * 72 ~/ 100, bw * 30 ~/ 100, bh * 14 ~/ 100, 3);
      break;
    case 3: // cockpit
      dc.setBrush(WxBrush(WxColour(46, 46, 50)));
      dc.drawRectangle(0, 0, w, h);
      dc.setBrush(WxBrush(WxColour(150, 176, 200)));
      dc.drawRoundedRectangle(w ~/ 12, h ~/ 12, w * 10 ~/ 12, h * 35 ~/ 100, 18);
      dc.setBrush(WxBrush(WxColour(64, 64, 70)));
      dc.drawRoundedRectangle(0, h * 40 ~/ 100, w, h * 60 ~/ 100, 20);
      dc.setBrush(WxBrush(WxColour(20, 26, 34)));
      dc.drawRoundedRectangle(w * 56 ~/ 100, h * 48 ~/ 100, w * 28 ~/ 100, h * 22 ~/ 100, 6);
      dc.setBrush(WxBrush(WxColour(60, 140, 200, alpha: 200)));
      dc.drawRoundedRectangle(w * 58 ~/ 100, h * 51 ~/ 100, w * 24 ~/ 100, h * 16 ~/ 100, 4);
      dc.setPen(WxPen(WxColour(24, 24, 26), width: max(4, w ~/ 40)));
      dc.setBrush(wxTRANSPARENT_BRUSH);
      dc.drawCircle(w * 30 ~/ 100, h * 70 ~/ 100, h * 26 ~/ 100);
      dc.drawLine(w * 30 ~/ 100 - h * 24 ~/ 100, h * 70 ~/ 100, w * 30 ~/ 100 + h * 24 ~/ 100, h * 70 ~/ 100);
      break;
    case 4: // wheel
      dc.setBrush(body);
      dc.drawRectangle(0, 0, w, h * 45 ~/ 100);
      final r = h * 42 ~/ 100;
      dc.setBrush(dark);
      dc.drawCircle(w ~/ 2, h * 58 ~/ 100, r);
      dc.setBrush(WxBrush(WxColour(190, 194, 200)));
      dc.drawCircle(w ~/ 2, h * 58 ~/ 100, r * 66 ~/ 100);
      dc.setPen(WxPen(WxColour(120, 124, 130), width: max(3, r ~/ 9)));
      for (int i = 0; i < 5; i++) {
        final a = i * 2 * pi / 5 + variant;
        dc.drawLine(w ~/ 2, h * 58 ~/ 100, w ~/ 2 + (cos(a) * r * 0.6).round(), h * 58 ~/ 100 + (sin(a) * r * 0.6).round());
      }
      break;
    default: // side
      final left = w * 8 ~/ 100, right = w * 92 ~/ 100, bottom = h * 74 ~/ 100;
      final bodyH = h * (car.isSuv ? 26 : 20) ~/ 100;
      final roof = bottom - bodyH - h * (car.isSuv ? 22 : 18) ~/ 100;
      final mirror = variant.isOdd;
      int x(int v) => mirror ? w - v : v;
      dc.setPen(outline);
      dc.setBrush(body);
      dc.drawPolygon([
        WxPoint(x(left), bottom - bodyH ~/ 3), WxPoint(x(left + w ~/ 30), bottom - bodyH),
        WxPoint(x(w * 30 ~/ 100), bottom - bodyH - 4), WxPoint(x(w * 40 ~/ 100), roof),
        WxPoint(x(w * 68 ~/ 100), roof), WxPoint(x(w * 80 ~/ 100), bottom - bodyH - 2),
        WxPoint(x(right), bottom - bodyH + 6), WxPoint(x(right), bottom - 6), WxPoint(x(left), bottom - 6),
      ]);
      dc.setBrush(glass);
      dc.drawPolygon([
        WxPoint(x(w * 33 ~/ 100), bottom - bodyH - 4), WxPoint(x(w * 41 ~/ 100), roof + 5),
        WxPoint(x(w * 66 ~/ 100), roof + 5), WxPoint(x(w * 76 ~/ 100), bottom - bodyH - 3),
      ]);
      dc.setPen(WxPen(paint, width: 3));
      dc.drawLine(x(w * 53 ~/ 100), roof + 4, x(w * 53 ~/ 100), bottom - bodyH - 3);
      dc.setPen(wxTRANSPARENT_PEN);
      final r = h * 11 ~/ 100;
      for (final wx in [w * 24 ~/ 100, w * 76 ~/ 100]) {
        dc.setBrush(dark);
        dc.drawCircle(x(wx), bottom - 4, r);
        dc.setBrush(WxBrush(WxColour(186, 190, 196)));
        dc.drawCircle(x(wx), bottom - 4, r * 55 ~/ 100);
      }
      dc.setBrush(WxBrush(WxColour(250, 240, 200)));
      dc.drawEllipse(x(mirror ? left + 10 : right - 10) - 5, bottom - bodyH + 8, 10, 6);
  }
}

/// A picture with the logical size w x h, sharp on high-density screens;
/// [scale] sets the resolution (for the PDF)
WxBitmap renderPhoto(Car car, int w, int h, int view, int variant, {double? scale}) {
  scale ??= wxTheApp.getTopWindow()?.getDPIScaleFactor() ?? 1.0;
  final dc = WxMemoryDC((w * scale).round(), (h * scale).round());
  dc.setUserScale(scale, scale);
  drawCar(dc, w, h, car, view, variant);
  final bitmap = dc.getBitmap();
  bitmap.setScaleFactor(scale);
  return bitmap;
}

/// "Loads" pictures: generates them after a random delay, like a server,
/// and keeps the most recently used ones (the oldest are released)
class ImageLoader {
  ImageLoader(this.capacity);
  final int capacity;
  final _cache = <String, WxBitmap>{};    // in order of use
  final _pending = <String>{};
  final _random = Random();
  int requests = 0;

  WxBitmap? get(String key) {
    final bitmap = _cache.remove(key);
    if (bitmap != null) _cache[key] = bitmap;   // move to the end: most recently used
    return bitmap;
  }

  /// Requests a picture; [onLoaded] is called when it has arrived
  void request(String key, WxBitmap Function() create, void Function() onLoaded) {
    if (_cache.containsKey(key) || _pending.contains(key)) return;
    _pending.add(key);
    requests++;
    Timer(Duration(milliseconds: 150 + _random.nextInt(900)), () {
      _pending.remove(key);
      _cache[key] = create();
      while (_cache.length > capacity) {
        final oldest = _cache.keys.first;
        _cache.remove(oldest)!.dispose();
      }
      onLoaded();
    });
  }

  void clear() {
    for (final bitmap in _cache.values) {
      bitmap.dispose();
    }
    _cache.clear();
    _pending.clear();
  }
}

final thumbnails = ImageLoader(400);
final photos = ImageLoader(60);

// ------------------------------------------------------------ Model

/// Virtual model: it only knows the number of rows and generates the cars
/// on demand. At the end of the list it loads more.
class CarModel extends WxDataViewVirtualListModel {
  CarModel(this.onStatus);
  final void Function(String text) onStatus;
  Filter filter = Filter();
  int generation = 0;
  bool _loading = false;
  static const pageSize = 30;
  static const total = 5000;   // "almost endless"

  @override
  dynamic getValueByRow(int row, int col) {
    if (row >= getCount() - 6) loadMore();
    return makeCar(filter, generation, row);
  }

  @override
  bool setValueByRow(dynamic value, int row, int col) => false;

  /// New search: the list starts with one page
  void search(Filter f) {
    filter = f;
    generation++;
    thumbnails.clear();
    _loading = false;
    reset(pageSize);
    cleared();
    onStatus("${thousands(total)} offers found");
  }

  /// Appends the next page after a short delay, as if from a server
  void loadMore() {
    if (_loading || getCount() >= total) return;
    _loading = true;
    final gen = generation;
    onStatus("Loading more offers …");
    Timer(const Duration(milliseconds: 500), () {
      if (gen != generation) return;
      final more = min(pageSize, total - getCount());
      for (int i = 0; i < more; i++) {
        rowAppended();
      }
      _loading = false;
      onStatus("${thousands(getCount())} of ${thousands(total)} offers loaded");
    });
  }
}

// ------------------------------------------------------------ Renderer

/// Requests the thumbnail of a car; once it has arrived the row is redrawn
/// (only if it still belongs to the current search)
void requestThumbnail(CarModel model, Car car) {
  final gen = car.generation, row = car.row;
  thumbnails.request(car.key, () => renderPhoto(car, thumbW, thumbH, 0, row), () {
    if (gen == model.generation && row < model.getCount()) model.rowChanged(row);
  });
}

const rowHeight = 112;
const thumbW = 150, thumbH = 96;

/// Draws a row: thumbnail, title, key details, location and price
class CarRenderer extends WxDataViewRenderer {
  // wxEXPAND: the cell gets the full width of the column
  CarRenderer(this.model) : super("Car", mode: wxDATAVIEW_CELL_ACTIVATABLE, alignment: wxEXPAND);
  final CarModel model;

  // checks the type directly instead of by class name ("Car" is renamed
  // by dart compile js)
  @override
  bool isCompatibleValue(dynamic value) => value is Car;

  @override
  WxSize getSize() => const WxSize(360, rowHeight);

  @override
  bool render(WxRect cell, WxDC dc, int state) {
    final car = getValue();
    if (car is! Car) return false;
    final selected = (state & wxDATAVIEW_CELL_SELECTED) != 0;
    final text = selected ? wxTheApp.getColourOnAccent() : WxColour(30, 30, 34);
    final grey = selected ? text : WxColour(110, 110, 116);
    final x = cell.x + 8, y = cell.y + (cell.height - thumbH) ~/ 2;

    // thumbnail, or a placeholder while it is still loading
    final bitmap = thumbnails.get(car.key);
    if (bitmap != null) {
      dc.drawBitmap(bitmap, x, y);
    } else {
      dc.setPen(wxTRANSPARENT_PEN);
      dc.setBrush(WxBrush(WxColour(226, 228, 232)));
      dc.drawRoundedRectangle(x, y, thumbW, thumbH, 6);
      dc.setFont(WxFont(11));
      dc.setTextForeground(WxColour(140, 140, 146));
      dc.drawText("loading …", x + thumbW ~/ 2 - 28, y + thumbH ~/ 2 - 8);
      requestThumbnail(model, car);
    }

    // texts to the right, the price right-aligned
    final tx = x + thumbW + 14;
    dc.setFont(WxFont(17, weight: wxFONTWEIGHT_BOLD));
    final price = "€${thousands(car.price)}";
    final priceWidth = dc.getTextExtent(price).x;
    final priceX = cell.x + cell.width - priceWidth - 12;
    dc.setTextForeground(selected ? text : WxColour(30, 100, 60));
    dc.drawText(price, priceX, cell.y + 14);

    // the title ends before the price, with "..." on narrow screens
    final textWidth = max(40, priceX - tx - 10);
    dc.setFont(WxFont(15, weight: wxFONTWEIGHT_BOLD));
    dc.setTextForeground(text);
    renderText(car.title, 0, WxRect(tx, cell.y + 14, textWidth, 20), dc, state);
    dc.setFont(WxFont(12));
    dc.setTextForeground(grey);
    final line2 = "Reg. ${car.month.toString().padLeft(2, '0')}/${car.year} · ${thousands(car.km)} km · ${car.power} hp";
    renderText(line2, 0, WxRect(tx, cell.y + 42, cell.x + cell.width - tx - 12, 18), dc, state);
    final line3 = "${fuels[car.fuel]} · ${gearboxes[car.gearbox]} · ${colourNames[car.colour]}";
    renderText(line3, 0, WxRect(tx, cell.y + 62, cell.x + cell.width - tx - 12, 18), dc, state);
    renderText("${car.dealer}, ${car.city}", 0, WxRect(tx, cell.y + 82, cell.x + cell.width - tx - 12, 18), dc, state);
    return true;
  }
}

// ------------------------------------------------------------ Data sheet as PDF


/// A data sheet for the car (A4): title, price, large photo, details and
/// the other photos. The photos are drawn at double resolution.
Future<Uint8List> buildExposePdf(Car car) async {
  const pageW = 595.28, margin = 48.0, contentW = pageW - 2 * margin;
  final out = WxPDFUint8ListOutput();
  // without deflate the PDF stays uncompressed (several MB with photos)
  final gc = WxPDFGraphicsContext(out, title: "Data sheet ${car.title}", author: car.dealer);
  final green = WxColour(30, 100, 60);
  final grey = WxColour(110, 110, 116);
  final dark = WxColour(30, 30, 34);

  await gc.generate(pageCount: 1, renderPage: (gc, page)
  {
    void text(String s, WxPDFFont font, WxColour colour, double x, double y) {
      gc.setPDFFont(font, colour);
      gc.drawText(s, x, y);
    }
    var y = margin;
    text(car.title, WxPDFFont.std(size: 24, bold: true), dark, margin, y);
    final priceFont = WxPDFFont.std(size: 22, bold: true);
    final price = "€${thousands(car.price)}";
    text(price, priceFont, green, margin + contentW - priceFont.lineWidth(price), y + 2);
    y += 34;
    text("Offered by ${car.dealer}, ${car.city}", WxPDFFont.std(size: 10), grey, margin, y);
    y += 22;

    // the large photo
    const photoH = contentW * 0.62;
    final photo = renderPhoto(car, 420, 260, 0, 0, scale: 2);
    final gphoto = gc.createBitmap(photo);
    gc.drawBitmap(gphoto, margin, y, contentW, photoH);
    y += photoH + 18;

    // the details in two columns
    final rows = [
      ("First registration", "${car.month.toString().padLeft(2, '0')}/${car.year}"),
      ("Mileage", "${thousands(car.km)} km"),
      ("Power", "${car.power} hp (${(car.power * 0.7355).round()} kW)"),
      ("Fuel", fuels[car.fuel]),
      ("Gearbox", gearboxes[car.gearbox]),
      ("Colour", colourNames[car.colour]),
    ];
    final label = WxPDFFont.std(size: 10), value = WxPDFFont.std(size: 10, bold: true);
    for (int i = 0; i < rows.length; i++) {
      final x = margin + (i % 2) * contentW / 2;
      final ry = y + (i ~/ 2) * 18;
      text(rows[i].$1, label, grey, x, ry);
      text(rows[i].$2, value, dark, x + 100, ry);
    }
    y += (rows.length / 2).ceil() * 18 + 14;

    // the other photos, three per row
    if (car.photoCount > 1) {
      gc.setPen(WxPen(WxColour(220, 220, 224), width: 1));
      gc.strokeLine(margin, y, margin + contentW, y);
      y += 12;
      const gap = 8.0;
      const thumbW = (contentW - 2 * gap) / 3, thumbH = thumbW * 0.62;
      for (int i = 1; i < car.photoCount; i++) {
        final col = (i - 1) % 3, row = (i - 1) ~/ 3;
        final photo = renderPhoto(car, 200, 124, i % 5, i, scale: 2);
        gc.drawBitmap(gc.createBitmap(photo), margin + col * (thumbW + gap), y + row * (thumbH + gap), thumbW, thumbH);
      }
    }

    // footer
    text("Created with wxDart · all details are sample data", WxPDFFont.std(size: 8), grey, margin, 841.89 - margin);
  });
  return out.result;
}

// ------------------------------------------------------------ Detail page

/// A photo that only appears once it has loaded
class PhotoView extends WxWindow {
  PhotoView(WxWindow parent, this.car, this.index, this.w, this.h)
      : super(parent, -1, wxDefaultPosition, WxSize(w, h), 0) {
    setMinSize(WxSize(w, h));
    bindPaintEvent(onPaint);
    photos.request(key, () => renderPhoto(car, w, h, index == 0 ? 0 : index % 5, index), () {
      if (!isBeingDeletedOrGone()) refresh();
    });
  }
  final Car car;
  final int index, w, h;
  String get key => "${car.key}/$index";
  bool _gone = false;

  bool isBeingDeletedOrGone() => _gone;

  @override
  void dispose() {
    _gone = true;
    super.dispose();
  }

  void onPaint(WxPaintEvent event) {
    final dc = WxPaintDC(this);
    final bitmap = photos.get(key);
    if (bitmap != null) {
      dc.drawBitmap(bitmap, 0, 0);
      return;
    }
    dc.setPen(wxTRANSPARENT_PEN);
    dc.setBrush(WxBrush(WxColour(226, 228, 232)));
    dc.drawRectangle(0, 0, w, h);
    dc.setTextForeground(WxColour(140, 140, 146));
    dc.drawText("Loading photo ${index + 1} …", w ~/ 2 - 56, h ~/ 2 - 8);
  }
}

class CarFrame extends WxFrame {
  CarFrame(WxWindow parent, Car car) : super(parent, -1, car.title, size: const WxSize(720, 640)) {
    final page = WxScrolledWindow(this, -1, style: wxVSCROLL);
    page.setBackgroundColour(wxWHITE);
    final col = WxColumn();

    final title = WxStaticText(page, -1, car.title, style: wxST_WRAP);
    title.setFont(WxFont(24, weight: wxFONTWEIGHT_BOLD));
    col.add(title, flag: wxEXPAND | wxLEFT | wxRIGHT | wxTOP, border: 16);
    final price = WxStaticText(page, -1, "€${thousands(car.price)}");
    price.setFont(WxFont(22, weight: wxFONTWEIGHT_BOLD));
    price.setForegroundColour(WxColour(30, 100, 60));
    col.add(price, flag: wxLEFT | wxRIGHT | wxTOP, border: 16);

    // the photos: the first one large, the others as a wrapping gallery
    col.add(PhotoView(page, car, 0, 420, 260), flag: wxLEFT | wxRIGHT | wxTOP, border: 16);
    final gallery = WxWrapSizer();
    for (int i = 1; i < car.photoCount; i++) {
      gallery.add(PhotoView(page, car, i, 200, 124), flag: wxRIGHT | wxBOTTOM, border: 8);
    }
    col.addSizer(gallery, flag: wxEXPAND | wxLEFT | wxRIGHT | wxTOP, border: 16);
    final count = WxStaticText(page, -1, car.photoCount == 1 ? "1 photo" : "${car.photoCount} photos");
    count.setForegroundColour(WxColour(110, 110, 116));
    col.add(count, flag: wxLEFT | wxRIGHT, border: 16);

    // the details as a table
    final grid = WxFlexGridSizer(2, vgap: 6, hgap: 24);
    void row(String label, String value) {
      final l = WxStaticText(page, -1, label);
      l.setForegroundColour(WxColour(110, 110, 116));
      grid.add(l);
      grid.add(WxStaticText(page, -1, value));
    }
    row("First registration", "${car.month.toString().padLeft(2, '0')}/${car.year}");
    row("Mileage", "${thousands(car.km)} km");
    row("Power", "${car.power} hp (${(car.power * 0.7355).round()} kW)");
    row("Fuel", fuels[car.fuel]);
    row("Gearbox", gearboxes[car.gearbox]);
    row("Colour", colourNames[car.colour]);
    row("Seller", car.dealer);
    row("Location", car.city);
    col.addSizer(grid, flag: wxALL, border: 16);

    final buttons = WxRow();
    final contact = WxButton(page, -1, "Contact seller");
    buttons.add(contact, flag: wxRIGHT, border: 8);
    final expose = WxButton(page, -1, "Data sheet (PDF)");
    expose.setBitmap(WxBitmapBundle.fromMaterialIcon(WxMaterialIcon.picture_as_pdf, const WxSize(20, 20)));
    buttons.add(expose);
    col.addSizer(buttons, flag: wxLEFT | wxRIGHT | wxBOTTOM, border: 16);
    // the PDF is built right inside the click handler (the browser only
    // allows the dialog shortly after a user action)
    expose.bindButtonEvent((_) async {
      final pdf = await buildExposePdf(car);
      await wxExportDocument(this, pdf, "Data sheet ${car.title}.pdf",
          mimeType: "application/pdf", message: "Data sheet ${car.title}, €${thousands(car.price)}");
    }, expose.getId());
    contact.bindButtonEvent((_) {
      WxMessageDialog(this, "No message is sent in this demo.", caption: car.dealer,
          style: wxOK | wxICON_INFORMATION).showModal(null);
    }, contact.getId());

    page.setSizer(col);
  }
}

// ------------------------------------------------------------ Main window

class SearchFrame extends WxFrame {
  SearchFrame() : super(null, -1, "Car Search", size: WxSize( 800,600 )) {
    final panel = WxPanel(this, -1);
    final main = WxColumn();

    late WxWindow area;
    late WxCollapsiblePane pane;

    if (wxUsesNative()) {
      area = panel;
    } else {
      // seven search criteria that wrap in narrow windows
      pane = WxCollapsiblePane(panel, -1, "Search criteria");
      area = pane.getPane();
    }
    final criteria = WxWrapSizer();
    WxChoice field(String label, List<String> choices) {
      final box = WxColumn();
      box.add(WxStaticText(area, -1, label));
      final choice = WxChoice(area, -1, choices: choices, size: const WxSize(150, -1));
      choice.setSelection(0);
      box.add(choice, flag: wxTOP, border: 2);
      criteria.addSizer(box, flag: wxRIGHT | wxBOTTOM, border: 12);
      return choice;
    }
    String any(int v, String Function(int) f) => v == 0 ? "any" : f(v);
    brand = field("Make", ["any", ...brands.keys]);
    fuel = field("Fuel", ["any", ...fuels]);
    gearbox = field("Gearbox", ["any", ...gearboxes]);
    price = field("Max. price", [for (final p in priceLimits) any(p, (v) => "€${thousands(v)}")]);
    km = field("Max. mileage", [for (final k in kmLimits) any(k, (v) => "${thousands(v)} km")]);
    year = field("Registered from", [for (final y in yearLimits) any(y, (v) => "$v")]);
    colour = field("Colour", ["any", ...colourNames]);
    
    if (wxUsesNative()) {
      main.addSizer( criteria );
    } else { 
      area.setSizer(criteria);
      main.add(pane, flag: wxEXPAND | wxLEFT | wxRIGHT | wxTOP, border: 8);
      // collapsed at first on touch devices, leaving room for the list
      if (!wxTheApp.isTouch()) pane.expand();
    }

    // the list
    final status = createStatusBar();
    model = CarModel((text) => status.setStatusText(text));
    list = WxDataViewCtrl(panel, -1, style: wxDV_NO_HEADER | wxDV_ROW_LINES);
    list.associateModel(model);
    list.appendColumn(WxDataViewColumn("", CarRenderer(model), 0, width: 300));
    list.setRowHeight(rowHeight);
    main.add(list, proportion: 1, flag: wxEXPAND | wxALL, border: 8);
    panel.setSizer(main);

    for (final c in [brand, fuel, gearbox, price, km, year, colour]) {
      c.bindChoiceEvent((_) => search(), c.getId());
    }
    // before painting, the list reports which rows it is about to need:
    // request their pictures, and those of the next ten rows, right away
    list.bindDataViewCacheHintEvent((event) {
      final last = min(model.getCount() - 1, event.getCacheTo() + 10);
      for (int row = max(0, event.getCacheFrom()); row <= last; row++) {
        final car = makeCar(model.filter, model.generation, row);
        if (thumbnails.get(car.key) == null) requestThumbnail(model, car);
      }
    }, list.getId());
    list.bindDataViewItemActivatedEvent((event) {
      final row = model.getRow(event.getItem());
      CarFrame(this, makeCar(model.filter, model.generation, row)).show();
    }, list.getId());
    search();
  }

  late WxChoice brand, fuel, gearbox, price, km, year, colour;
  late CarModel model;
  late WxDataViewCtrl list;

  void search() {
    final f = Filter();
    f.brand = brand.getSelection() > 0 ? brand.getStringSelection() : "";
    f.fuel = fuel.getSelection() - 1;
    f.gearbox = gearbox.getSelection() - 1;
    f.maxPrice = priceLimits[price.getSelection()];
    f.maxKm = kmLimits[km.getSelection()];
    f.minYear = yearLimits[year.getSelection()];
    f.colour = colour.getSelection() - 1;
    model.search(f);
  }
}

class CarApp extends WxApp {
  @override
  bool onInit() {
    SearchFrame().show();
    return true;
  }
}

void main() {
  final app = CarApp();
  app.run();
  app.dispose();
}
