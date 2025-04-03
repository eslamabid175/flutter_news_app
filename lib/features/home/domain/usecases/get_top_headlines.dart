// Clean Architecture: Use Case implementation in domain layer
// SOLID Principle: Single Responsibility Principle (SRP)
// This class has one responsibility: getting top headlines

import 'package:dartz/dartz.dart';
import 'package:flutter_news_app_api/features/home/domain/repositories/article_repository.dart';
import 'package:flutter_news_app_api/features/home/data/models/article_model.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/usecase.dart';

// Use case class implementing generic UseCase interface
// SOLID Principle: Liskov Substitution Principle (LSP)
class GetTopHeadlinesUseCase implements UseCase<List<ArticleModel>, GetTopHeadlinesParams> {
  // Repository dependency
  final ArticleRepository repository;

  // Constructor injection for repository dependency
  GetTopHeadlinesUseCase(this.repository);

  // Implementation of call method from UseCase interface
  // This makes the class callable like a function
  @override
  Future<Either<Failure, List<ArticleModel>>> call(GetTopHeadlinesParams params) async {
    // Delegates to repository implementation
    return await repository.getTopHeadlines();
  }
}

// Parameters class for the use case
// SOLID Principle: Open/Closed Principle (OCP)
// Can be extended with new parameters without modifying existing code
class GetTopHeadlinesParams extends Params {
  final String country;     // Required country parameter
  final String? category;   // Optional category parameter

  GetTopHeadlinesParams({
    required this.country,
    this.category,
  });

  // Implementation of props for equality comparison
  @override
  List<Object?> get props => [country, category ?? ''];
}