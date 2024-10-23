// this is lib/services/sync_service.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/models/product_model.dart';
import 'storage_service.dart';
import 'api_service.dart';
import '../models/order_model.dart';

class SyncService {
  final StorageService _storageService;
  final ApiService _apiService;

  SyncService(this._storageService, this._apiService);

  Future<void> syncData() async {
    // Fetch offline data
    final offlineData = await _storageService.getOfflineData(); 
    // Convert offline data to List<OrderModel>
    List<OrderModel> offlineOrders = _convertToOrderModels(offlineData);
    
    // Sync offline data with the backend
    await _apiService.syncOfflineData(offlineOrders);
    await _storageService.clearOfflineData();
  }

  // Convert Map<String, dynamic> to List<OrderModel>
  List<OrderModel> _convertToOrderModels(Map<String, dynamic> data) {
    return data.entries.map((entry) {
      final orderData = entry.value as Map<String, dynamic>; // Ensure your data structure here
      return OrderModel(
        id: orderData['id'],
        items: (orderData['items'] as List).map((item) => ProductModel.fromMap(item)).toList(),
        status: orderData['status'],
        scheduledTime: DateTime.tryParse(orderData['scheduledTime'] ?? ''),
      );
    }).toList();
  }
}

final syncServiceProvider = Provider<SyncService>((ref) {
  final storageService = ref.watch(storageServiceProvider).asData?.value; // Await the storage service
  final apiService = ref.watch(apiServiceProvider);
  
  if (storageService != null) {
    return SyncService(storageService, apiService);
  } else {
    throw Exception('StorageService is not initialized');
  }
});