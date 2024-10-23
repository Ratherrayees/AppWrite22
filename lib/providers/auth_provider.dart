// this is lib/providers/auth_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/controllers/auth_controller.dart';
import 'package:myapp/models/user_model.dart';
import 'package:myapp/services/auth_service.dart';


final authProvider = StateNotifierProvider<AuthController, UserModel?>((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthController(authService);
});