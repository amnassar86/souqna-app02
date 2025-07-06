import 'package:flutter/material.dart';

// هذا الكلاس هو "ذاكرة" سلة التسوق
class CartProvider with ChangeNotifier {
  final List<String> _items = []; // قائمة وهمية بأسماء المنتجات

  // دالة لجلب قائمة المنتجات
  List<String> get items => _items;

  // دالة لجلب عدد المنتجات في السلة
  int get itemCount => _items.length;

  // دالة لإضافة منتج للسلة
  void addItem(String productName) {
    _items.add(productName);
    // السطر ده مهم جداً، هو اللي بيبلغ كل الشاشات إن فيه تغيير حصل
    notifyListeners();
  }

  // دالة لحذف منتج من السلة
  void removeItem(String productName) {
    _items.remove(productName);
    notifyListeners();
  }
}