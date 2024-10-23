// this is lib/models/order_model.dart
import 'package:myapp/models/product_model.dart';

class OrderModel {
  final String id;                  // Unique identifier for the order
  final List<ProductModel> items;   // List of products included in the order
  final String status;              // Status of the order (e.g., pending, completed)
  final DateTime? scheduledTime;    // Optional scheduled time for the order

  OrderModel({
    required this.id,
    required this.items,
    required this.status,
    this.scheduledTime,
  });
}
