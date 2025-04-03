// Using Equatable for value equality comparison
// Could implement equals manually, but Equatable reduces boilerplate
import 'package:equatable/equatable.dart';

// Abstract base class for failures
// Using Failure instead of Exception allows for more controlled error handling
abstract class Failure extends Equatable {
  final String message;
  // Optional code for more detailed error handling
  final String? code;

  const Failure({required this.message, this.code});

  // Props for Equatable - ensures proper equality comparison
  @override
  List<Object?> get props => [message, code];
}

// Specific failure classes - following same pattern as exceptions
// Could use enum for types instead, but separate classes allow for extension
class GeneralFailure extends Failure {
  const GeneralFailure({
    required String message,
    String? code,
  }) : super(message: message, code: code);
}

class NetworkFailure extends Failure {
  const NetworkFailure({
    required String message,
    String? code,
  }) : super(message: message, code: code);
}

class ServerFailure extends Failure {
  const ServerFailure({
    required String message,
    String? code,
  }) : super(message: message, code: code);
}

class CacheFailure extends Failure {
  const CacheFailure({
    required String message,
    String? code,
  }) : super(message: message, code: code);
}