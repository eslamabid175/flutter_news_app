import 'package:flutter_news_app_api/features/home/data/models/article_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';

abstract class ArticleRepository {
  Future<Either<Failure, List<ArticleModel>>> getTopHeadlines();
  Future<Either<Failure, List<ArticleModel>>> searchArticles(String query);
}