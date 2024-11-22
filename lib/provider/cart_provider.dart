import 'package:flutter/cupertino.dart';
import 'package:flutter_course_batch_2/models/cart_model.dart';
import 'package:flutter_course_batch_2/models/food.dart';

class CartProvider extends ChangeNotifier {
  final List<CartModel> _cart = [];
  List<CartModel> get cart => _cart;

  void addToCart(Food foodItem, int qty) {
    _cart.add(
      CartModel(
        nama: foodItem.name,
        price: foodItem.price,
        imagePath: foodItem.imagePath,
        quantity: qty.toString(),
      ),
    );
    notifyListeners();
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  void deleteItemCart(CartModel item) {
    _cart.remove(item);
    notifyListeners();
  }
}
