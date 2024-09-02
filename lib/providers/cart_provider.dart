import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_fashion_store/models/cart_attributes.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartAttr> _cartItems = {};
  Map<String, CartAttr> get getCartItem {
    return _cartItems;
  }

  double get totalPrice {
    var total = 0.00;

    _cartItems.forEach(
      (key, value) {
        total += value.price * value.quantity;
      },
    );

    return total;
  }

  void addProductToCart(
      String productName,
      String productId,
      List imageUrl,
      int productQuantity,
      int quantity,
      double price,
      String vendorId,
      String productSize,
      Timestamp scheduleDate) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
        productId,
        (existingCart) => CartAttr(
            productName: existingCart.productName,
            productId: existingCart.productId,
            imageUrl: existingCart.imageUrl,
            quantity: existingCart.quantity + 1,
            price: existingCart.price,
            productQuantity: existingCart.productQuantity,
            vendorId: existingCart.vendorId,
            productSize: existingCart.productSize,
            scheduleDate: existingCart.scheduleDate),
      );

      notifyListeners();
    } else {
      _cartItems.putIfAbsent(
        productId,
        () => CartAttr(
            productName: productName,
            productId: productId,
            imageUrl: imageUrl,
            quantity: quantity,
            productQuantity: productQuantity,
            price: price,
            vendorId: vendorId,
            productSize: productSize,
            scheduleDate: scheduleDate),
      );
      notifyListeners();
    }
  }

  void increament(CartAttr cartAttr) {
    cartAttr.increase();
    notifyListeners();
  }

  void decreament(CartAttr cartAttr) {
    cartAttr.decrease();
    notifyListeners();
  }

  removeItem(productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  removeAllItem() {
    _cartItems.clear();
    notifyListeners();
  }
}
