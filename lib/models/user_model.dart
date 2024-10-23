// this is lib/models/user_model.dart
class UserModel {
  final String id;
  final String email;
  final String? name;

  UserModel({
    required this.id,
    required this.email,
    this.name,
  });
}