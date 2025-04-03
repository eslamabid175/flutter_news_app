// Clean Architecture: Use Case implementation in domain layer
// SOLID Principle: Single Responsibility Principle (SRP)
// This class has one responsibility: searching articles

import 'package:dartz/dartz.dart';
import 'package:flutter_news_app_api/features/home/domain/repositories/article_repository.dart';
import 'package:flutter_news_app_api/features/home/data/models/article_model.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/usecase.dart';

// Use case class implementing generic UseCase interface
class SearchArticlesUseCase implements UseCase<List<ArticleModel>, SearchArticlesParams> {
  // Repository dependency
  final ArticleRepository repository;

  // Constructor injection
  SearchArticlesUseCase(this.repository);

  // Implementation of call method
  @override
  Future<Either<Failure, List<ArticleModel>>> call(SearchArticlesParams params) async {
    // Delegates search operation to repository
    return await repository.searchArticles(params.query);
  }
}

// Parameters class for search operation
// Clean Architecture: Value Object pattern
class SearchArticlesParams extends Params {
  final String query;      // Required search query
  final String? sortBy;    // Optional sort parameter
  final String? language;  // Optional language parameter

  SearchArticlesParams({
    required this.query,
    this.sortBy,
    this.language,
  });

  // Implementation of props for equality comparison
  @override
  List<Object?> get props => [query, sortBy ?? '', language ?? ''];
}