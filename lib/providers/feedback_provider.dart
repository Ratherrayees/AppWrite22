// this is lib/providers/feedback_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/controllers/feedback_controller.dart';
import 'package:myapp/models/feedback_model.dart';
import 'package:myapp/services/api_service.dart';


final feedbackProvider = StateNotifierProvider<FeedbackController, List<FeedbackModel>>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return FeedbackController(apiService);
});