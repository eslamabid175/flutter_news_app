
import 'package:dartz/dartz.dart';
import 'package:flutter_news_app_api/features/home/domain/repositories/article_repository.dart';
import 'package:flutter_news_app_api/features/home/data/models/article_model.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/usecase.dart';

class GetTopHeadlinesUseCase implements UseCase<List<ArticleModel>, GetTopHeadlinesParams> {
  final ArticleRepository repository;

  GetTopHeadlinesUseCase(this.repository);

  @override
  Future<Either<Failure, List<ArticleModel>>> call(GetTopHeadlinesParams params) async {
    return await repository.getTopHeadlines();
  }
}

class GetTopHeadlinesParams extends Params {
  final String country;
  final String? category;

  GetTopHeadlinesParams({
    required this.country,
    this.category,
  });

  @override
  List<Object?> get props => [country, category ?? ''];
}