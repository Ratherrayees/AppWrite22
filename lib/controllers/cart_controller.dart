// this is lib/controllers/cart_controller.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/models/cart_model.dart';
import 'package:myapp/models/product_model.dart';


class CartController extends StateNotifier<CartModel> {
  CartController() : super(CartModel(items: [], totalPrice: 0));

  void addToCart(ProductModel product) {
    state = CartModel(
      items: [...state.items, product],
      totalPrice: state.totalPrice + product.price,
    );
  }

  void removeFromCart(ProductModel product) {
    state = CartModel(
      items: state.items.where((item) => item.id != product.id).toList(),
      totalPrice: state.totalPrice - product.price,
    );
  }
}

final cartControllerProvider = StateNotifierProvider<CartController, CartModel>((ref) {
  return CartController();
});