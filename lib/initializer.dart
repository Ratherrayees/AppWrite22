// this is lib/initializer.dart
import 'package:appwrite/appwrite.dart'; 
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'services/api_service.dart';
import 'services/auth_service.dart';

// Create a Provider for the Appwrite Client
final clientProvider = Provider<Client>((ref) {
  final client = Client()
    ..setEndpoint('https://cloud.appwrite.io/v1')
    ..setProject('gulposh121');
  return client;
});

// Create providers for ApiService and AuthService using the Client provider
final apiServiceProvider = Provider<ApiService>((ref) {
  final client = ref.watch(clientProvider); // Watch the Client provider
  return ApiService(client);
});

final authServiceProvider = Provider<AuthService>((ref) {
  final client = ref.watch(clientProvider); // Watch the Client provider
  return AuthService(client);
});

// Optional: Create a ProviderContainer if needed for overriding in tests or different environments
final providerContainer = ProviderContainer();

Future<void> initializeApp() async {
  // Initialize the ProviderContainer, can be used for overriding providers if necessary
  // In most cases, you don't need to manually call this unless you're doing specific testing or setup.
}
