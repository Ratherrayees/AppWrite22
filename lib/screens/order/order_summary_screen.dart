// this is lib/screens/order/order_summary_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/models/order_model.dart';


class OrderSummaryScreen extends ConsumerWidget {
  final OrderModel order;

  const OrderSummaryScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Order Summary')),
      body: ListView.builder(
        itemCount: order.items.length,
        itemBuilder: (context, index) {
          final product = order.items[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('\$${product.price}'),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Total: \$${order.items.fold(0.0, (sum, item) => sum + item.price).toStringAsFixed(2)}', // Ensure starting value is double
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}