// this is lib/services/storage_service.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  final SharedPreferences _prefs;

  StorageService(this._prefs);

  Future<void> saveData(String key, String data) async {
    await _prefs.setString(key, data);
  }

  Future<String?> getData(String key) async {
    return _prefs.getString(key);
  }

  Future<void> clearData(String key) async {
    await _prefs.remove(key);
  }

  Future<void> clearOfflineData() async {
    await _prefs.clear();
  }

  Future<Map<String, dynamic>> getOfflineData() async {
    final data = _prefs.getKeys().map((key) => MapEntry(key, _prefs.get(key)));
    return Map.fromEntries(data);
  }
}

final storageServiceProvider = FutureProvider<StorageService>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return StorageService(prefs);
});