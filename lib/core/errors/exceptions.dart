import '../utils/constants.dart';

// Abstract base class for all app exceptions
// Could use Error instead of Exception, but Exception is more appropriate for recoverable errors
abstract class AppException implements Exception {
  final String message;
  // Adding timestamp and user context for better debugging
  // Could be optional, but having them mandatory ensures better error tracking
  final DateTime timestamp;
  final String userContext;

  AppException(this.message)
      : timestamp = AppConstants.currentTime,
        userContext = AppConstants.currentUser;

  // Override toString for better error reporting
  @override
  String toString() => 'AppException: $message\nTime: $timestamp\nUser: $userContext';
}

// Specific exception types - following separation of concerns
// Could have single exception type with error codes, but separate classes are more type-safe
class ServerException extends AppException {
  ServerException(String message) : super(message);
}

class NetworkException extends AppException {
  NetworkException(String message) : super(message);
}

class CacheException extends AppException {
  CacheException(String message) : super(message);
}