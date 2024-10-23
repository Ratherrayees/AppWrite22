// this is lib/models/pre_order_model.dart
import 'package:myapp/models/product_model.dart';

class PreOrderModel {
  final String id;
  final List<ProductModel> items;
  final DateTime scheduledTime;

  PreOrderModel({
    required this.id,
    required this.items,
    required this.scheduledTime,
  });
}