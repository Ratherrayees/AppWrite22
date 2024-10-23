// this is lib/services/encryption_service.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptionService {
  final encrypt.Encrypter _encrypter;

  EncryptionService(this._encrypter);

  String encryptData(String data) {
    final encrypted = _encrypter.encrypt(data);
    return encrypted.base64;
  }

  String decryptData(String encryptedData) {
    final decrypted = _encrypter.decrypt64(encryptedData);
    return decrypted;
  }
}

final encryptionServiceProvider = Provider<EncryptionService>((ref) {
  final key = encrypt.Key.fromUtf8('your-32-character-key');
  final iv = encrypt.IV.fromLength(16); // IV is declared but not used.
  final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: 'PKCS7')); // Using IV with CBC mode
  return EncryptionService(encrypter);
});
