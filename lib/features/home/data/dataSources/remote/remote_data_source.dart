import 'package:dio/dio.dart';
import 'package:flutter_news_app_api/core/api/dio_helper.dart';
import 'package:flutter_news_app_api/features/home/data/models/article_model.dart';
import 'package:flutter_news_app_api/core/utils/constants.dart';

abstract class ArticleRemoteDataSource {
  Future<List<ArticleModel>> getTopHeadlines();
  Future<List<ArticleModel>> searchArticles(String query);
}

class ArticleRemoteDataSourceImpl implements ArticleRemoteDataSource {
  @override
  Future<List<ArticleModel>> getTopHeadlines() async {
    try {
      final response = await DioHelper.dio.get(
        AppConstants.topHeadlines,
        queryParameters: {
          'country': AppConstants.defaultCountry,
          'pageSize': AppConstants.defaultPageSize,
        },
      );
      return (response.data['articles'] as List)
          .map((article) => ArticleModel.fromJson(article))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch top headlines');
    }
  }

  @override
  Future<List<ArticleModel>> searchArticles(String query) async {
    try {
      final response = await DioHelper.dio.get(
        AppConstants.everything,
        queryParameters: {
          'q': query,
          'language': AppConstants.defaultLanguage,
          'pageSize': AppConstants.defaultPageSize,
        },
      );
      return (response.data['articles'] as List)
          .map((article) => ArticleModel.fromJson(article))
          .toList();
    } catch (e) {
      throw Exception('Failed to search articles');
    }
  }
}