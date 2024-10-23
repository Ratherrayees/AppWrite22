// this is lib/services/auth_service.dart
import 'package:appwrite/appwrite.dart';
import 'package:myapp/initializer.dart';
import 'package:myapp/models/user_model.dart';
import 'package:riverpod/riverpod.dart';

class AuthService {
  final Client client;
  final Account account;

  AuthService(this.client) : account = Account(client);

  Future<UserModel> login(String email, String password) async {
    final session = await account.createEmailPasswordSession(email: email, password: password);
    return UserModel(id: session.$id, email: email);
  }

  Future<UserModel> signup(String email, String password) async {
    // Use a unique userId, e.g., generated or provided by your application logic
    String userId = 'unique_user_id'; // Replace with actual logic to generate userId or get it from the user input

    final user = await account.create(userId: userId, email: email, password: password);
    return UserModel(id: user.$id, email: email);
  }

  Future<void> logout() async {
    await account.deleteSession(sessionId: 'current');
  }
}

final authServiceProvider = Provider<AuthService>((ref) {
  final client = ref.watch(clientProvider);
  return AuthService(client);
});