import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_news_app_api/core/usecase/usecase.dart';

import '../../../../core/errors/failure.dart';
import '../entities/article_entity.dart';
import '../repositories/article_repository.dart';

/// Parameters for GetTopHeadlines use case
/// Extends Equatable for value comparison
class GetTopHeadlinesParams extends Equatable {
  final String country;
  final String? category;

  /// Constructor with default country value
  const GetTopHeadlinesParams({
    this.country = 'eg',
    this.category,
  });

  @override
  List<Object?> get props => [country, category];
}

/// Use case for getting top headlines
/// Implements generic UseCase class
class GetTopHeadlinesUseCase implements UseCaseWithParams<List<ArticleEntity>, GetTopHeadlinesParams> {
  final ArticleRepository repository;

  /// Constructor requires repository
  /// Following Dependency Inversion Principle
  GetTopHeadlinesUseCase(this.repository);

  /// Executes the use case
  /// Returns Either type for functional error handling
  @override
  Future<Either<Failure, List<ArticleEntity>>> call(GetTopHeadlinesParams params) async {
    return await repository.getTopHeadlines(
      country: params.country,
      category: params.category,
    );
  }
}