import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_news_app_api/core/usecase/usecase.dart';
import '../../../../core/errors/failure.dart';
import '../entities/article_entity.dart';
import '../repositories/article_repository.dart';

class SearchArticlesParams extends Equatable {
  final String query;
  final String? sortBy;
  final String? language;

  const SearchArticlesParams({
    required this.query,
    this.sortBy,
    this.language,
  });

  @override
  List<Object?> get props => [query, sortBy, language];
}

class SearchArticlesUsecase implements UseCaseWithParams<List<ArticleEntity>, SearchArticlesParams> {
  final ArticleRepository repository;

  SearchArticlesUsecase(this.repository);

  @override
  Future<Either<Failure, List<ArticleEntity>>> call(SearchArticlesParams params) async {
    return await repository.searchArticles(
      query: params.query,
      sortBy: params.sortBy,
      language: params.language,
    );
  }
}