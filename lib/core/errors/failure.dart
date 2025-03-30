import 'package:equatable/equatable.dart';

import '../utils/constants.dart';

/// Base Failure class for the app
/// Using Equatable for value comparison
abstract class Failure extends Equatable {
  final String message;
  final DateTime timestamp;
  final String userContext;

  const Failure(this.message)
      : timestamp = AppConstants.currentTime ,
        userContext = AppConstants.currentUser;

  @override
  List<Object> get props => [message, timestamp, userContext];
}

/// Failure for server errors
class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);
}

/// Failure for network errors
class NetworkFailure extends Failure {
  const NetworkFailure(String message) : super(message);
}

/// Failure for cache errors
class CacheFailure extends Failure {
  const CacheFailure(String message) : super(message);
}