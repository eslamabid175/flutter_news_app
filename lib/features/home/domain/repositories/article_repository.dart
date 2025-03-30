import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/article_entity.dart';
//Create abstract repository interface (Dependency Inversion Principle)
//Dependency Inversion Principle (DIP):
//
// High-level modules depend on abstractions
// Using dependency injection
// Repository depends on abstract data sources
abstract class ArticleRepository {
  Future<Either<Failure, List<ArticleEntity>>> getTopHeadlines({
    String country = 'eg',
    String? category,
  });

  Future<Either<Failure, List<ArticleEntity>>> searchArticles({
    required String query,
    String? sortBy,
    String? language,
  });
}