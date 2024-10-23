// this is lib/controllers/order_controller.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/models/order_model.dart';
import 'package:myapp/models/product_model.dart';
import 'package:myapp/services/api_service.dart';


class OrderController extends StateNotifier<List<OrderModel>> {
  final ApiService _apiService;

  OrderController(this._apiService) : super([]);

  Future<void> placeOrder(List<ProductModel> items) async {
    try {
      final order = await _apiService.placeOrder(items);
      state = [...state, order];
    } catch (e) {
      // Handle error
    }
  }

  Future<void> scheduleOrder(List<ProductModel> items, DateTime scheduledTime) async {
    try {
      final order = await _apiService.scheduleOrder(items, scheduledTime);
      state = [...state, order];
    } catch (e) {
      // Handle error
    }
  }

  Future<void> trackOrder(String orderId) async {
    try {
      final order = await _apiService.getOrder(orderId);
      state = state.map((o) => o.id == orderId ? order : o).toList();
    } catch (e) {
      // Handle error
    }
  }
}

final orderControllerProvider = StateNotifierProvider<OrderController, List<OrderModel>>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return OrderController(apiService);
});