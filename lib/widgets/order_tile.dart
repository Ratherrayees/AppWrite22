// this is lib/widgets/order_tile.dart
import 'package:flutter/material.dart';
import '../models/order_model.dart';

class OrderTile extends StatelessWidget {
  final OrderModel order;

  const OrderTile({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Order #${order.id}'),
      subtitle: Text('Status: ${order.status}'),
      trailing: Text('\$${order.items.fold(0.0, (sum, item) => sum + item.price)}'),
    );
  }
}