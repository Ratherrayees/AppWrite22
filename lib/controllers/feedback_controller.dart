// this is lib/controllers/feedback_controller.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/models/feedback_model.dart';
import 'package:myapp/services/api_service.dart';


class FeedbackController extends StateNotifier<List<FeedbackModel>> {
  final ApiService _apiService;

  FeedbackController(this._apiService) : super([]);

  Future<void> submitFeedback(String orderId, int rating, String review) async {
    try {
      final feedback = await _apiService.submitFeedback(orderId, rating, review);
      state = [...state, feedback];
    } catch (e) {
      // Handle error
    }
  }

  Future<void> getFeedback(String orderId) async {
    try {
      final feedback = await _apiService.getFeedback(orderId);
      state = feedback;
    } catch (e) {
      // Handle error
    }
  }
}

final feedbackControllerProvider = StateNotifierProvider<FeedbackController, List<FeedbackModel>>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return FeedbackController(apiService);
});