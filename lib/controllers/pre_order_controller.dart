// this is lib/controllers/pre_order_controller.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/models/pre_order_model.dart';
import 'package:myapp/models/product_model.dart';
import 'package:myapp/services/api_service.dart';


class PreOrderController extends StateNotifier<List<PreOrderModel>> {
  final ApiService _apiService;

  PreOrderController(this._apiService) : super([]);

  Future<void> schedulePreOrder(List<ProductModel> items, DateTime scheduledTime) async {
    try {
      final preOrder = await _apiService.schedulePreOrder(items, scheduledTime);
      state = [...state, preOrder];
    } catch (e) {
      // Handle error
    }
  }
}

final preOrderControllerProvider = StateNotifierProvider<PreOrderController, List<PreOrderModel>>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return PreOrderController(apiService);
});