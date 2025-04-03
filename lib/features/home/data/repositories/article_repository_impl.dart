// Required imports for functionality
import 'package:dio/dio.dart';
import 'package:flutter_news_app_api/core/network/network_info.dart';
import 'package:flutter_news_app_api/features/home/domain/repositories/article_repository.dart';
import 'package:flutter_news_app_api/features/home/data/models/article_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../dataSources/local/article_local_datasource.dart';
import '../dataSources/remote/remote_data_source.dart';

// Implementation of the ArticleRepository interface
class ArticleRepositoryImpl implements ArticleRepository {
  // Dependencies required for repository operations
  final ArticleRemoteDataSource remoteDataSource;  // For API calls
  final ArticleLocalDataSource localDataSource;    // For local storage
  final NetworkInfo networkInfo;                   // For network status

  // Constructor requiring all dependencies
  // This enforces proper dependency injection
  ArticleRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  // Implementation of getTopHeadlines method
  @override
  Future<Either<Failure, List<ArticleModel>>> getTopHeadlines() async {
    // Check for internet connectivity
    if (await networkInfo.isConnected) {
      try {
        // If connected, fetch from remote source
        final remoteArticles = await remoteDataSource.getTopHeadlines();
        // Cache the fetched articles locally
        await localDataSource.cacheArticles(remoteArticles);
        // Return successful result
        return Right(remoteArticles);
      } on DioException catch (e) {
        // Handle Dio-specific errors (API errors)
        print('DioError: ${e.message}');
        print('DioError response: ${e.response?.data}');
        return Left(ServerFailure(
          message: e.response?.data?['message'] ?? 'Failed to fetch top headlines',
        ));
      } catch (e) {
        // Handle unexpected errors
        print('Unexpected error: $e');
        return Left(ServerFailure(
          message: 'An unexpected error occurred while fetching headlines',
        ));
      }
    } else {
      // If offline, try to fetch from local cache
      try {
        final localArticles = await localDataSource.getCachedArticles();
        if (localArticles.isEmpty) {
          return Left(CacheFailure(message: 'No cached articles available'));
        }
        return Right(localArticles);
      } catch (e) {
        // Handle cache errors
        print('Cache error: $e');
        return Left(CacheFailure(message: 'Failed to retrieve cached articles'));
      }
    }
  }

  // Implementation of searchArticles method
  @override
  Future<Either<Failure, List<ArticleModel>>> searchArticles(String query) async {
    // Check for internet connectivity
    if (await networkInfo.isConnected) {
      try {
        // If connected, perform search via API
        final remoteArticles = await remoteDataSource.searchArticles(query);
        return Right(remoteArticles);
      } on DioException catch (e) {
        // Handle API errors
        print('DioError: ${e.message}');
        print('DioError response: ${e.response?.data}');
        return Left(ServerFailure(
          message: e.response?.data?['message'] ?? 'Failed to search articles',
        ));
      } catch (e) {
        // Handle unexpected errors
        print('Unexpected error: $e');
        return Left(ServerFailure(
          message: 'An unexpected error occurred while searching articles',
        ));
      }
    } else {
      // Return network failure if offline
      return Left(NetworkFailure(message: 'No internet connection available'));
    }
  }
}