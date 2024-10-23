// this is lib/providers/order_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/controllers/order_controller.dart';
import 'package:myapp/models/order_model.dart';
import 'package:myapp/services/api_service.dart';


final orderProvider = StateNotifierProvider<OrderController, List<OrderModel>>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return OrderController(apiService);
});