import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:garasi_gitar/models/cart_model.dart';
import 'package:garasi_gitar/models/product_model.dart';

class CartProvider with ChangeNotifier {
  List<CartModel> _carts = [];

  List<CartModel> get carts => _carts;

  set carts(List<CartModel> carts) {
    _carts = carts;
    notifyListeners();
  }

  addCart(ProductModel product) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      if (productExist(product)) {
        int index =
            _carts.indexWhere((element) => element.product.id == product.id);
        _carts[index].quantity++;
        _carts[index].totalprice =
            _carts[index].product.harga * _carts[index].quantity;
      } else {
        _carts.add(
          CartModel(
            id: _carts.length,
            userid: user.uid,
            product: product,
            quantity: 1,
            totalprice: product.harga,
          ),
        );
      }
    }
  }

  productExist(ProductModel product) {
    if (_carts.indexWhere((element) => element.product.id == product.id) ==
        -1) {
      return false;
    } else {
      return true;
    }
  }

  removeCart(int id) {
    _carts.removeAt(id);
    notifyListeners();
  }

  void clearCart() {
    _carts.clear();
    notifyListeners();
  }

  addQuantity(int id) {
    _carts[id].quantity++;
    _carts[id].totalprice = _carts[id].product.harga * _carts[id].quantity;
    notifyListeners();
  }

  reduceQuantity(int id) {
    if (_carts[id].quantity > 1) {
      _carts[id].quantity--;
      _carts[id].totalprice = _carts[id].product.harga * _carts[id].quantity;
    } else {
      _carts.removeAt(id);
    }
    notifyListeners();
  }

  totalItems() {
    int total = 0;
    for (var item in _carts) {
      total += item.quantity;
    }
    return total;
  }

  totalPrice() {
    double total = 0;
    for (var item in _carts) {
      total += (item.quantity * item.product.harga);
    }
    return total;
  }
}
