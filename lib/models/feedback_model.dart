// this is lib/models/feedback_model.dart
class FeedbackModel {
  final String id;
  final String orderId;
  final int rating;
  final String review;

  FeedbackModel({
    required this.id,
    required this.orderId,
    required this.rating,
    required this.review,
  });
}