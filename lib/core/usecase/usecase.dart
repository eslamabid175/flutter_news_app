import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../errors/failure.dart';
// This file implements the base classes for the Clean Architecture use case pattern
// It uses Either type from dartz for handling success/failure scenarios

// Generic abstract class for all use cases
// Type: return type of the use case
// Params: type of parameters the use case needs
abstract class UseCase<Type, Params> {
  // The call method makes the class callable like a function
  // Returns Either type - Left side is Failure, Right side is success (Type)
  Future<Either<Failure, Type>> call(Params params);
}

// Used when a use case doesn't need any parameters
// Implements empty props list since no parameters are needed
class NoParams extends Params {
  @override
  List<Object?> get props => [];
}

// Base class for all parameter classes
// Extends Equatable to enable value comparison
abstract class Params extends Equatable {
  const Params();
}