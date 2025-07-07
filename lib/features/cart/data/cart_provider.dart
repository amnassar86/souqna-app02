import 'package:flutter/material.dart';

// 1. أنشأنا كلاس بسيط للمنتج عشان نخزن الاسم والسعر
class Product {
  final String name;
  final double price;
  // ممكن نضيف صورة ومنتج ID في المستقبل
  Product({required this.name, required this.price});
}

class CartProvider with ChangeNotifier {
  // 2. غيرنا القائمة عشان تخزن منتجات كاملة
  final List<Product> _items = [];

  List<Product> get items => _items;

  int get itemCount => _items.length;

  // 3. دالة جديدة لحساب السعر الإجمالي للمنتجات
  double get subtotal {
    var total = 0.0;
    for (var cartItem in _items) {
      total += cartItem.price;
    }
    return total;
  }

  // 4. عدلنا دالة الإضافة عشان تستقبل منتج كامل
  void addItem(Product product) {
    _items.add(product);
    notifyListeners();
  }

  // 5. عدلنا دالة الحذف عشان تستقبل منتج كامل
  void removeItem(Product product) {
    _items.remove(product);
    notifyListeners();
  }
}