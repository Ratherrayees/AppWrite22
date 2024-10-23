// this is lib/providers/sync_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/controllers/sync_controller.dart';
import 'package:myapp/services/api_service.dart';
import 'package:myapp/services/storage_service.dart';
import 'package:myapp/services/sync_service.dart';

final syncProvider = StateNotifierProvider<SyncController, bool>((ref) {
  final syncService = ref.watch(syncServiceProvider);
  return SyncController(syncService);
});

final syncServiceProvider = Provider<SyncService>((ref) {
  final storageService = ref.watch(storageServiceProvider).asData?.value; // Await the storage service
  final apiService = ref.watch(apiServiceProvider);
  
  if (storageService != null) {
    return SyncService(storageService, apiService);
  } else {
    throw Exception('StorageService is not initialized');
  }
});