// this is lib/screens/feedback/feedback_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/controllers/feedback_controller.dart';


class FeedbackScreen extends ConsumerStatefulWidget {
  final String orderId;

  const FeedbackScreen({super.key, required this.orderId});

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends ConsumerState<FeedbackScreen> {
  final _formKey = GlobalKey<FormState>();
  int _rating = 0;
  final TextEditingController _reviewController = TextEditingController();

  Future<void> _submitFeedback() async {
    if (_formKey.currentState!.validate()) {
      await ref.read(feedbackControllerProvider.notifier).submitFeedback(
            widget.orderId,
            _rating,
            _reviewController.text,
          );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Feedback')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text('Rate your experience'),
              Slider(
                value: _rating.toDouble(),
                min: 0,
                max: 5,
                divisions: 5,
                onChanged: (value) {
                  setState(() {
                    _rating = value.toInt();
                  });
                },
              ),
              TextFormField(
                controller: _reviewController,
                decoration: InputDecoration(labelText: 'Review'),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a review';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitFeedback,
                child: Text('Submit Feedback'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}