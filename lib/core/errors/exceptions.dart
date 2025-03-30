import '../utils/constants.dart';

/// Base Exception class for the app
/// All custom exceptions should extend this
abstract class AppException implements Exception {
  final String message;
  final DateTime timestamp;
  final String userContext;

  AppException(this.message)
      : timestamp = AppConstants.currentTime,
        userContext = AppConstants.currentUser;

  @override
  String toString() => 'AppException: $message\nTime: $timestamp\nUser: $userContext';
}

/// Exception for server-related errors
class ServerException extends AppException {
  ServerException(String message) : super(message);
}

/// Exception for network-related errors
class NetworkException extends AppException {
  NetworkException(String message) : super(message);
}

/// Exception for cache-related errors
class CacheException extends AppException {
  CacheException(String message) : super(message);
}