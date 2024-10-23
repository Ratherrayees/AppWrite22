// this is lib/controllers/error_controller.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/utils/error_handler.dart';


class ErrorController extends StateNotifier<void> {
  final ErrorHandler _errorHandler;

  ErrorController(this._errorHandler) : super(null);

  void logError(dynamic error, [StackTrace? stackTrace]) {
    _errorHandler.logError(error, stackTrace);
  }
}

final errorControllerProvider = StateNotifierProvider<ErrorController, void>((ref) {
  final errorHandler = ref.watch(errorHandlerProvider);
  return ErrorController(errorHandler);
});