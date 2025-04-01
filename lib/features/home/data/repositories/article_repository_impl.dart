import 'package:dio/dio.dart';
import 'package:flutter_news_app_api/core/network/network_info.dart';
import 'package:flutter_news_app_api/features/home/domain/repositories/article_repository.dart';
import 'package:flutter_news_app_api/features/home/data/models/article_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../dataSources/local/article_local_datasource.dart';
import '../dataSources/remote/remote_data_source.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteDataSource remoteDataSource;
  final ArticleLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ArticleRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<ArticleModel>>> getTopHeadlines() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteArticles = await remoteDataSource.getTopHeadlines();
        await localDataSource.cacheArticles(remoteArticles);
        return Right(remoteArticles);
      } on DioException catch (e) {
        print('DioError: ${e.message}');
        print('DioError response: ${e.response?.data}');
        return Left(ServerFailure(
          message: e.response?.data?['message'] ?? 'Failed to fetch top headlines',
        ));
      } catch (e) {
        print('Unexpected error: $e');
        return Left(ServerFailure(
          message: 'An unexpected error occurred while fetching headlines',
        ));
      }
    } else {
      try {
        final localArticles = await localDataSource.getCachedArticles();
        if (localArticles.isEmpty) {
          return Left(CacheFailure(message: 'No cached articles available'));
        }
        return Right(localArticles);
      } catch (e) {
        print('Cache error: $e');
        return Left(CacheFailure(message: 'Failed to retrieve cached articles'));
      }
    }
  }

  @override
  Future<Either<Failure, List<ArticleModel>>> searchArticles(String query) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteArticles = await remoteDataSource.searchArticles(query);
        return Right(remoteArticles);
      } on DioException catch (e) {
        print('DioError: ${e.message}');
        print('DioError response: ${e.response?.data}');
        return Left(ServerFailure(
          message: e.response?.data?['message'] ?? 'Failed to search articles',
        ));
      } catch (e) {
        print('Unexpected error: $e');
        return Left(ServerFailure(
          message: 'An unexpected error occurred while searching articles',
        ));
      }
    } else {
      return Left(NetworkFailure(message: 'No internet connection available'));
    }
  }
}