// this is lib/utils/error_handler.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class ErrorHandler {
  void logError(dynamic error, [StackTrace? stackTrace]) {
    Sentry.captureException(error, stackTrace: stackTrace);
  }
}

final errorHandlerProvider = Provider<ErrorHandler>((ref) {
  return ErrorHandler();
});