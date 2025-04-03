// Import the Dio package for making HTTP requests - Dio is chosen over http package
// because it provides more features like interceptors, transformers, and better configuration options
import 'package:dio/dio.dart';
import '../utils/constants.dart';

// DioHelper class is used to initialize and configure Dio instance
// Using a separate class follows the Single Responsibility Principle
class DioHelper {
  // Using static late allows initialization after declaration
  // Alternative: Could use singleton pattern, but static is simpler for this use case
  static late Dio dio;

  // Async initialization method
  // Could be constructor, but static method provides better control over initialization
  static Future<void> init() async {
    dio = Dio(
      BaseOptions(
        // Base URL from constants for better maintainability
        baseUrl: AppConstants.baseUrl,
        // API key in query parameters - could be in headers instead,
        // but query params are more common for public APIs
        queryParameters: {
          'apiKey': AppConstants.apiKey,
        },
        // Standard JSON headers - necessary for most REST APIs
        headers: {
          'Content-Type': 'application/json',
        },
        // Allows receiving error data - important for error handling
        receiveDataWhenStatusError: true,
        // Timeouts are set to 30 seconds - balanced between user experience and reliability
        // Could be shorter for better UX, but might cause issues with slower connections
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    )..interceptors.add(
      // LogInterceptor for debugging - could be disabled in production
      // Alternative: Could use custom logging solution, but Dio's interceptor is well-integrated
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        // Custom log format with timestamp and user context
        logPrint: (object) {
          print('${DateTime.parse('2025-04-01 14:57:12')} - eslamabid175: $object');
        },
      ),
    );
  }
}