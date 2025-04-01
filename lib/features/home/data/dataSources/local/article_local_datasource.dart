import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_news_app_api/features/home/data/models/article_model.dart';
import 'dart:convert';

import '../../../../../core/utils/constants.dart';

abstract class ArticleLocalDataSource {
  Future<void> cacheArticles(List<ArticleModel> articles);
  Future<List<ArticleModel>> getCachedArticles();
}

class ArticleLocalDataSourceImpl implements ArticleLocalDataSource {
  final SharedPreferences sharedPreferences;

  ArticleLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheArticles(List<ArticleModel> articles) async {
    final jsonString = json.encode(articles.map((article) => article.toJson()).toList());
    sharedPreferences.setString(AppConstants.cacheKey, jsonString);
  }

  @override
  Future<List<ArticleModel>> getCachedArticles() async {
    final jsonString = sharedPreferences.getString(AppConstants.cacheKey);
    if (jsonString != null) {
      final List decodedList = json.decode(jsonString);
      return decodedList.map((article) => ArticleModel.fromJson(article)).toList();
    } else {
      throw Exception('No cached data found');
    }
  }
}