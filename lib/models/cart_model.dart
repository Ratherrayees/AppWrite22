// this is lib/models/cart_model.dart
import 'package:myapp/models/product_model.dart';

class CartModel {
  final List<ProductModel> items;
  final double totalPrice;

  CartModel({
    required this.items,
    required this.totalPrice,
  });
}