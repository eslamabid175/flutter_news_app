import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../errors/failure.dart';

/// Base class for all use cases
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// No parameters class for use cases that don't require parameters
class NoParams extends Params {
  @override
  List<Object?> get props => [];
}

/// Base class for use case parameters
abstract class Params extends Equatable {
  const Params();
}