import 'package:flutter/material.dart';
import 'cart_item.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addItem(String productName, double productPrice, int quantity, String imagePath) {
    _items.add(CartItem(
      productName: productName,
      productPrice: productPrice,
      quantity: quantity,
      imagePath: imagePath,
    ));
    notifyListeners();
  }

  void updateItemQuantity(int index, int newQuantity) {
    if (index >= 0 && index < _items.length) {
      _items[index].quantity = newQuantity;
      notifyListeners();
    }
  }

  void removeItem(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      notifyListeners();
    }
  }
}
