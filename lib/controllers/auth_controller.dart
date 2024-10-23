// this is lib/controllers/auth_controller.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/models/user_model.dart';
import 'package:myapp/services/auth_service.dart';


class AuthController extends StateNotifier<UserModel?> {
  final AuthService _authService;

  AuthController(this._authService) : super(null);

  Future<void> login(String email, String password) async {
    try {
      final user = await _authService.login(email, password);
      state = user;
    } catch (e) {
      // Handle error
    }
  }

  Future<void> signup(String email, String password) async {
    try {
      final user = await _authService.signup(email, password);
      state = user;
    } catch (e) {
      // Handle error
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    state = null;
  }
}

final authControllerProvider = StateNotifierProvider<AuthController, UserModel?>((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthController(authService);
});