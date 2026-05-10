import 'package:flutter/material.dart';

class Category {
  final String id;
  final String nameEn;
  final String nameAr;
  final IconData icon;
  final Color accent;

  const Category({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.icon,
    required this.accent,
  });
}

class MenuItem {
  final String id;
  final String nameEn;
  final String nameAr;
  final double price;
  final String categoryId;
  final bool isPopular;

  const MenuItem({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.price,
    required this.categoryId,
    this.isPopular = false,
  });
}

class CartItem {
  final MenuItem item;
  int quantity;

  CartItem({required this.item, this.quantity = 1});

  double get totalPrice => item.price * quantity;
}

class CartController extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);
  int get totalItems => _items.fold(0, (s, i) => s + i.quantity);
  double get totalPrice => _items.fold(0.0, (s, i) => s + i.totalPrice);

  void add(MenuItem item) {
    final idx = _items.indexWhere((e) => e.item.id == item.id);
    if (idx >= 0) {
      _items[idx].quantity++;
    } else {
      _items.add(CartItem(item: item));
    }
    notifyListeners();
  }

  void remove(String id) {
    _items.removeWhere((e) => e.item.id == id);
    notifyListeners();
  }

  void decrement(String id) {
    final idx = _items.indexWhere((e) => e.item.id == id);
    if (idx < 0) return;
    if (_items[idx].quantity <= 1) {
      _items.removeAt(idx);
    } else {
      _items[idx].quantity--;
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  int quantityOf(String id) {
    final idx = _items.indexWhere((e) => e.item.id == id);
    return idx >= 0 ? _items[idx].quantity : 0;
  }
}

const List<Category> kCategories = [
  Category(id: 'ramadan', nameEn: 'Ramadan', nameAr: 'رمضان', icon: Icons.nightlight_round, accent: Color(0xFF8B5E3C)),
  Category(id: 'black', nameEn: 'Black Coffee', nameAr: 'قهوة بلاك', icon: Icons.coffee, accent: Color(0xFF3A3A3A)),
  Category(id: 'milk', nameEn: 'Milk Coffee', nameAr: 'قهوة ميلك', icon: Icons.local_cafe, accent: Color(0xFF8B6A4A)),
  Category(id: 'sweet', nameEn: 'Sweet Coffee', nameAr: 'قهوة سويت', icon: Icons.favorite, accent: Color(0xFF8B4A6A)),
  Category(id: 'matcha', nameEn: 'Matcha', nameAr: 'ماتشا', icon: Icons.eco, accent: Color(0xFF4A7A4A)),
  Category(id: 'juice', nameEn: 'Juice', nameAr: 'عصير', icon: Icons.local_drink, accent: Color(0xFF8B7A2A)),
  Category(id: 'barrrd', nameEn: 'Barrrd', nameAr: 'بررد', icon: Icons.ac_unit, accent: Color(0xFF3A5A8B)),
  Category(id: 'sandwich', nameEn: 'Sandwiches', nameAr: 'ساندويتشات', icon: Icons.lunch_dining, accent: Color(0xFF7A6A3A)),
  Category(id: 'bakery', nameEn: 'Bakery', nameAr: 'المخبوزات', icon: Icons.cake, accent: Color(0xFF8B6A3A)),
];

const List<MenuItem> kMenuItems = [
  // Ramadan
  MenuItem(id: 'r1', nameEn: 'Karkadeh', nameAr: 'كركديه', price: 3.5, categoryId: 'ramadan'),
  MenuItem(id: 'r2', nameEn: 'Hot Salted Honey Latte', nameAr: 'لاتيه العسل ساخن', price: 5.0, categoryId: 'ramadan', isPopular: true),
  MenuItem(id: 'r3', nameEn: 'Iced Salted Honey Latte', nameAr: 'لاتيه العسل بارد', price: 5.0, categoryId: 'ramadan'),
  MenuItem(id: 'r4', nameEn: 'Hot Chai Karak', nameAr: 'شاي كرك ساخن', price: 3.5, categoryId: 'ramadan'),
  MenuItem(id: 'r5', nameEn: 'Iced Chai Karak', nameAr: 'شاي كرك بارد', price: 3.5, categoryId: 'ramadan'),
  MenuItem(id: 'r6', nameEn: 'Tiramisu Tin', nameAr: 'علبة تيراميسو', price: 8.0, categoryId: 'ramadan'),
  MenuItem(id: 'r7', nameEn: 'Tiramisu Single', nameAr: 'تيراميسو سنجل', price: 4.0, categoryId: 'ramadan'),

  // Black Coffee
  MenuItem(id: 'b1', nameEn: 'Turkish Coffee', nameAr: 'قهوة غلي', price: 3.0, categoryId: 'black', isPopular: true),
  MenuItem(id: 'b2', nameEn: 'Espresso', nameAr: 'اسبريسو', price: 2.5, categoryId: 'black'),
  MenuItem(id: 'b3', nameEn: 'Iced Americano', nameAr: 'ابسد أمريكانو', price: 3.5, categoryId: 'black', isPopular: true),
  MenuItem(id: 'b4', nameEn: 'Hot Americano', nameAr: 'أمريكانو ساخن', price: 3.0, categoryId: 'black'),
  MenuItem(id: 'b5', nameEn: 'American', nameAr: 'أمريكان', price: 3.0, categoryId: 'black'),
  MenuItem(id: 'b6', nameEn: 'American Box', nameAr: 'أمريكان سفري', price: 18.0, categoryId: 'black'),

  // Milk Coffee
  MenuItem(id: 'm1', nameEn: 'Iced Latte', nameAr: 'لاتيه بارد', price: 4.0, categoryId: 'milk', isPopular: true),
  MenuItem(id: 'm2', nameEn: 'Cappuccino', nameAr: 'كابوتشينو', price: 4.0, categoryId: 'milk'),
  MenuItem(id: 'm3', nameEn: 'Hot Latte', nameAr: 'لاتيه ساخن', price: 4.0, categoryId: 'milk'),
  MenuItem(id: 'm4', nameEn: 'Hot Flat White', nameAr: 'فلات وايت ساخن', price: 4.5, categoryId: 'milk'),

  // Sweet Coffee
  MenuItem(id: 's1', nameEn: 'Iced Pistachio Latte', nameAr: 'بستاشيو لاتيه', price: 5.0, categoryId: 'sweet', isPopular: true),
  MenuItem(id: 's2', nameEn: 'Hot Hazelnut Latte', nameAr: 'لاتيه هيزلنت ساخن', price: 4.5, categoryId: 'sweet'),
  MenuItem(id: 's3', nameEn: 'Iced Hazelnut Latte', nameAr: 'هيزلنت لاتيه', price: 4.5, categoryId: 'sweet'),
  MenuItem(id: 's4', nameEn: 'Hot Caramel Latte', nameAr: 'لاتيه كراميل ساخن', price: 4.5, categoryId: 'sweet'),
  MenuItem(id: 's5', nameEn: 'Iced Caramel Latte', nameAr: 'كراميل لاتيه', price: 4.5, categoryId: 'sweet'),
  MenuItem(id: 's6', nameEn: 'Hot Rose Latte', nameAr: 'لاتيه ورد ساخن', price: 4.5, categoryId: 'sweet'),
  MenuItem(id: 's7', nameEn: 'Iced Rose Latte', nameAr: 'ورد لاتيه', price: 4.5, categoryId: 'sweet'),
  MenuItem(id: 's8', nameEn: 'Hot Spanish Latte', nameAr: 'لاتيه سبانيش ساخن', price: 5.0, categoryId: 'sweet', isPopular: true),
  MenuItem(id: 's9', nameEn: 'Iced Spanish Latte', nameAr: 'سبانيش لاتيه', price: 5.0, categoryId: 'sweet'),
  MenuItem(id: 's10', nameEn: 'Hot Pistachio Latte', nameAr: 'لاتيه بستاشيو ساخن', price: 5.0, categoryId: 'sweet'),
  MenuItem(id: 's11', nameEn: 'Iced Khareef Latte', nameAr: 'خريف لاتيه بارد', price: 5.0, categoryId: 'sweet'),
  MenuItem(id: 's12', nameEn: 'Hot White Mocha', nameAr: 'وايت موكا ساخن', price: 4.5, categoryId: 'sweet'),
  MenuItem(id: 's13', nameEn: 'Iced White Mocha Latte', nameAr: 'وايت موكا لاتيه بارد', price: 5.0, categoryId: 'sweet'),
  MenuItem(id: 's14', nameEn: 'Hot Lotus Latte', nameAr: 'لاتيه لوتس ساخن', price: 5.0, categoryId: 'sweet'),
  MenuItem(id: 's15', nameEn: 'Iced Lotus Latte', nameAr: 'لوتس لاتيه', price: 5.0, categoryId: 'sweet'),

  // Matcha
  MenuItem(id: 'mt1', nameEn: 'Classic Matcha', nameAr: 'كلاسيك ماتشا', price: 4.5, categoryId: 'matcha', isPopular: true),
  MenuItem(id: 'mt2', nameEn: 'Hot Matcha', nameAr: 'ماتشا ساخن', price: 4.5, categoryId: 'matcha'),
  MenuItem(id: 'mt3', nameEn: 'Cinnamon Matcha', nameAr: 'ماتشا بالقرفة', price: 5.0, categoryId: 'matcha'),
  MenuItem(id: 'mt4', nameEn: 'Vanilla Brown Sugar Matcha', nameAr: 'فانيلا ماتشا مع سكر بني', price: 5.5, categoryId: 'matcha'),
  MenuItem(id: 'mt5', nameEn: 'Agave Matcha', nameAr: 'أغافي ماتشا', price: 5.0, categoryId: 'matcha'),
  MenuItem(id: 'mt6', nameEn: 'Hot Agave Matcha', nameAr: 'أغافي ماتشا ساخن', price: 5.0, categoryId: 'matcha'),
  MenuItem(id: 'mt7', nameEn: 'Early Grey Matcha', nameAr: 'إيرل غراي ماتشا', price: 5.0, categoryId: 'matcha'),
  MenuItem(id: 'mt8', nameEn: 'Hot Cinnamon Matcha', nameAr: 'ماتشا بالقرفة ساخن', price: 5.0, categoryId: 'matcha'),

  // Juice
  MenuItem(id: 'j1', nameEn: 'Date Juice', nameAr: 'عصير تمر', price: 3.5, categoryId: 'juice'),
  MenuItem(id: 'j2', nameEn: 'Red Juice', nameAr: 'عصير أحمر', price: 3.5, categoryId: 'juice'),
  MenuItem(id: 'j3', nameEn: 'Orange Juice', nameAr: 'عصير برتقال', price: 3.5, categoryId: 'juice'),
  MenuItem(id: 'j4', nameEn: 'Green Juice', nameAr: 'عصير أخضر', price: 3.5, categoryId: 'juice'),

  // Barrrd
  MenuItem(id: 'br1', nameEn: 'Hot Chocolate', nameAr: 'هوت تشوكوليت', price: 4.0, categoryId: 'barrrd', isPopular: true),
  MenuItem(id: 'br2', nameEn: 'Iced Hot Chocolate', nameAr: 'ابسد هوت شوكوليت', price: 4.5, categoryId: 'barrrd'),

  // Sandwiches
  MenuItem(id: 'sw1', nameEn: 'Cheese & Zataar', nameAr: 'سندويشة جبنة وز عتر', price: 3.5, categoryId: 'sandwich'),
  MenuItem(id: 'sw2', nameEn: 'Spread Cheese Sandwich', nameAr: 'سندويشة جبنة دهن', price: 3.5, categoryId: 'sandwich'),
  MenuItem(id: 'sw3', nameEn: 'Sinora & Kashkawan', nameAr: 'سنيورة وكشكوان', price: 4.0, categoryId: 'sandwich'),
  MenuItem(id: 'sw4', nameEn: 'Turkey & Cheese', nameAr: 'سندويشة تبركي وجبنة', price: 4.0, categoryId: 'sandwich', isPopular: true),
  MenuItem(id: 'sw5', nameEn: 'Halloumi & Summaq Kaek', nameAr: 'كعكيك حلوم وسماق', price: 4.5, categoryId: 'sandwich'),
  MenuItem(id: 'sw6', nameEn: 'Turkey Gouda Sandwich', nameAr: 'سندويشة تبركي جودا', price: 4.5, categoryId: 'sandwich'),
  MenuItem(id: 'sw7', nameEn: 'Halloumi Sandwich', nameAr: 'سندويشة حلوم', price: 4.0, categoryId: 'sandwich'),
  MenuItem(id: 'sw8', nameEn: 'Deli Twirl', nameAr: 'سندويشة ديلي', price: 4.5, categoryId: 'sandwich'),

  // Bakery
  MenuItem(id: 'bk1', nameEn: 'Chocolate Cookie', nameAr: 'كوكي شوكولاتة', price: 2.0, categoryId: 'bakery'),
  MenuItem(id: 'bk2', nameEn: 'Classic Cookie', nameAr: 'كوكي كلاسيك', price: 2.0, categoryId: 'bakery'),
  MenuItem(id: 'bk3', nameEn: 'Latte Cookie', nameAr: 'كوكي لاتيه', price: 2.0, categoryId: 'bakery'),
  MenuItem(id: 'bk4', nameEn: 'Tomato & Olive Fateerah', nameAr: 'فطيرة بندورة وزيتون', price: 3.0, categoryId: 'bakery'),
  MenuItem(id: 'bk5', nameEn: 'Cheese & Zataar Fateerah', nameAr: 'فطيرة ز عتر وجبنة', price: 3.0, categoryId: 'bakery'),
  MenuItem(id: 'bk6', nameEn: 'Date Cake', nameAr: 'كيكة تمر', price: 3.0, categoryId: 'bakery', isPopular: true),
  MenuItem(id: 'bk7', nameEn: 'Banana Chocolate Cake', nameAr: 'كيكة شوكولاتة الموز', price: 3.5, categoryId: 'bakery'),
  MenuItem(id: 'bk8', nameEn: 'Biscotti', nameAr: 'بسكوتي', price: 2.5, categoryId: 'bakery'),
  MenuItem(id: 'bk9', nameEn: 'Brownie', nameAr: 'براوني', price: 2.5, categoryId: 'bakery'),
  MenuItem(id: 'bk10', nameEn: 'Pumpkin Crumble Muffin', nameAr: 'بامبكن كرمبل مافن', price: 3.0, categoryId: 'bakery'),
  MenuItem(id: 'bk11', nameEn: 'Crumble Cake', nameAr: 'كرميل كيك', price: 3.5, categoryId: 'bakery'),
];
