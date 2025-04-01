
import 'package:dartz/dartz.dart';
import 'package:flutter_news_app_api/features/home/domain/repositories/article_repository.dart';
import 'package:flutter_news_app_api/features/home/data/models/article_model.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/usecase.dart';

class SearchArticlesUseCase implements UseCase<List<ArticleModel>, SearchArticlesParams> {
  final ArticleRepository repository;

  SearchArticlesUseCase(this.repository);

  @override
  Future<Either<Failure, List<ArticleModel>>> call(SearchArticlesParams params) async {
    return await repository.searchArticles(params.query);
  }
}

class SearchArticlesParams extends Params {
  final String query;
  final String? sortBy;
  final String? language;

  SearchArticlesParams({
    required this.query,
    this.sortBy,
    this.language,
  });

  @override
  List<Object?> get props => [query, sortBy ?? '', language ?? ''];
}