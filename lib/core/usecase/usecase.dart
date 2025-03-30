//
// // any use case with no params will implment this class
// abstract class UseCase<T> {
//   const UseCase();
//   Future<T> call();
// }
//
// abstract class UseCaseWithParams<T, Params> {
//   const UseCaseWithParams();
//   Future<T> call(Params params);
// }
//Open/Closed Principle (OCP):Classes are open for extension but closed for modification
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../errors/failure.dart';

abstract class UseCaseWithParams<Type, Params> {
  const UseCaseWithParams();
  Future<Either<Failure, Type>> call(Params params);
}

// For use cases that don't need parameters
class UsecaseWithNoParams extends Equatable {
  const UsecaseWithNoParams();
  @override
  List<Object?> get props => [];
}