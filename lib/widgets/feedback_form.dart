// this is lib/widgets/feedback_form.dart
import 'package:flutter/material.dart';

class FeedbackForm extends StatefulWidget {
  final Function(int rating, String review) onSubmit;

  const FeedbackForm({super.key, required this.onSubmit});

  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final _formKey = GlobalKey<FormState>();
  int _rating = 0;
  final TextEditingController _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
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
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                widget.onSubmit(_rating, _reviewController.text);
              }
            },
            child: Text('Submit Feedback'),
          ),
        ],
      ),
    );
  }
}