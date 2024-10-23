// this is lib/providers/cart_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/controllers/cart_controller.dart';
import 'package:myapp/models/cart_model.dart';


final cartProvider = StateNotifierProvider<CartController, CartModel>((ref) {
  return CartController();
});