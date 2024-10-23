// this is lib/controllers/sync_controller.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/services/sync_service.dart';


class SyncController extends StateNotifier<bool> {
  final SyncService _syncService;

  SyncController(this._syncService) : super(false);

  Future<void> syncData() async {
    try {
      await _syncService.syncData();
      state = true;
    } catch (e) {
      state = false;
    }
  }
}

final syncControllerProvider = StateNotifierProvider<SyncController, bool>((ref) {
  final syncService = ref.watch(syncServiceProvider);
  return SyncController(syncService);
});