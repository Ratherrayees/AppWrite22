// this is lib/widgets/cart_item_tile.dart
import 'package:flutter/material.dart';
import '../models/product_model.dart';

class CartItemTile extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onRemove;

  const CartItemTile({super.key, required this.product, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name),
      subtitle: Text('\$${product.price}'),
      trailing: IconButton(
        icon: Icon(Icons.remove_circle),
        onPressed: onRemove,
      ),
    );
  }
}