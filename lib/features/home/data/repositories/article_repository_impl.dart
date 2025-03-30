import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/article_entity.dart';
import '../../domain/repositories/article_repository.dart';
import '../dataSources/local/article_local_datasource.dart';
import '../dataSources/remote/remote_data_source.dart';

/// Implementation of ArticleRepository that coordinates between
/// remote and local data sources with proper error handling
class ArticleRepositoryImpl implements ArticleRepository {
  // Dependencies required for the repository
  final ArticleRemoteDataSource remoteDataSource;
  final ArticleLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  // Track current user and time for operations
  final _currentTime = DateTime.parse('2025-03-30 11:44:58');
  final _currentUser = 'eslamabid175';

  // Constructor requiring all dependencies
  ArticleRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  }) {
    // Log initialization
    print('Repository initialized - User: $_currentUser, Time: $_currentTime');
  }

  @override
  Future<Either<Failure, List<ArticleEntity>>> getTopHeadlines({
    String country = 'eg',
    String? category,
  }) async {
    // Log operation attempt
    print('Fetching top headlines - Country: $country, Category: $category');

    // Check network connectivity
    if (await networkInfo.isConnected) {
      try {
        // Attempt to fetch from remote source
        final remoteArticles = await remoteDataSource.getTopHeadlines(
          country: country,
          category: category,
        );

        // Cache the fetched articles
        await localDataSource.cacheArticles(remoteArticles);

        // Log success
        print('Successfully fetched and cached ${remoteArticles.length} articles');

        // Return success with articles
        return Right(remoteArticles);
      } on ServerException catch (e) {
        // Log server error
        print('Server error: ${e.message}');
        return Left(ServerFailure(e.message));
      } catch (e) {
        // Log unexpected error
        print('Unexpected error: $e');
        return Left(ServerFailure(e.toString()));
      }
    } else {
      // No internet connection, try to get cached data
      print('No internet connection, attempting to use cached data');

      try {
        // Attempt to get cached articles
        final localArticles = await localDataSource.getCachedArticles();

        // Log success
        print('Successfully retrieved ${localArticles.length} cached articles');

        return Right(localArticles);
      } on CacheException catch (e) {
        // Log cache error
        print('Cache error: ${e.message}');
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, List<ArticleEntity>>> searchArticles({
    required String query,
    String? sortBy,
    String? language,
  }) async {
    // Log search attempt
    print('Searching articles - Query: $query, User: $_currentUser');

    // Check network connectivity
    if (await networkInfo.isConnected) {
      try {
        // Attempt to search articles
        final articles = await remoteDataSource.searchArticles(
          query: query,
          sortBy: sortBy,
          language: language,
        );

        // Log success
        print('Found ${articles.length} articles matching query: $query');

        return Right(articles);
      } on ServerException catch (e) {
        // Log server error
        print('Server error during search: ${e.message}');
        return Left(ServerFailure(e.message));
      }
    } else {
      // Log network error
      print('No internet connection available for search');
      return Left(NetworkFailure('No internet connection available'));
    }
  }
}