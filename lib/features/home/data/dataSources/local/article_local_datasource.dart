import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_news_app_api/features/home/data/models/article_model.dart';
import 'dart:convert';
import '../../../../../core/utils/constants.dart';
// Abstract class defining local storage operations for articles

abstract class ArticleLocalDataSource {
  // Method contracts for article storage operations

  Future<void> cacheArticles(List<ArticleModel> articles);
  Future<List<ArticleModel>> getCachedArticles();
  Future<void> saveArticleAsFavorite(ArticleModel article);
  Future<void> removeArticleFromFavorites(String articleUrl);
  Future<List<ArticleModel>> getFavoriteArticles();
  Future<bool> isArticleFavorite(String articleUrl);
}
// Implementation using SharedPreferences for persistent storage

class ArticleLocalDataSourceImpl implements ArticleLocalDataSource {
  final SharedPreferences sharedPreferences;
  // Key for storing favorite articles

  static const _favoriteArticlesKey = 'FAVORITE_ARTICLES';
  static const _currentTime = '2025-04-01 19:47:49';
  static const _currentUser = 'eslamabid175';
  // Constructor requiring SharedPreferences instance

  ArticleLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheArticles(List<ArticleModel> articles) async {
    try {
      // Log the caching operation start

      print('$_currentTime - $_currentUser: Caching ${articles.length} articles');
      // Convert articles to JSON and store in SharedPreferences

      final jsonString = json.encode(articles.map((article) => article.toJson()).toList());
      await sharedPreferences.setString(AppConstants.cacheKey, jsonString);
      print('$_currentTime - $_currentUser: Articles cached successfully');
    } catch (e) {
      // Log error and throw exception if caching fails

      print('$_currentTime - $_currentUser: Error caching articles: $e');
      throw Exception('Failed to cache articles');
    }
  }

  @override
  Future<List<ArticleModel>> getCachedArticles() async {
    try {
      // Retrieve JSON string from SharedPreferences

      final jsonString = sharedPreferences.getString(AppConstants.cacheKey);
      if (jsonString != null) {
        // Convert JSON back to ArticleModel list
        final List decodedList = json.decode(jsonString);
        final articles = decodedList.map((article) => ArticleModel.fromJson(article)).toList();
        print('$_currentTime - $_currentUser: Retrieved ${articles.length} cached articles');
        return articles;
      } else {
        print('$_currentTime - $_currentUser: No cached articles found');
        throw Exception('No cached data found');
      }
    } catch (e) {
      print('$_currentTime - $_currentUser: Error retrieving cached articles: $e');
      throw Exception('Failed to get cached articles');
    }
  }

  @override
  Future<void> saveArticleAsFavorite(ArticleModel article) async {
    try {
      // Get current favorites

      print('$_currentTime - $_currentUser: Saving article to favorites: ${article.title}');
      final favorites = await getFavoriteArticles();

      // Check if article already exists
      // Check for duplicates before adding

      if (!favorites.any((a) => a.url == article.url)) {
        favorites.add(article);
        // Save updated favorites list

        final jsonString = json.encode(favorites.map((a) => a.toJson()).toList());
        await sharedPreferences.setString(_favoriteArticlesKey, jsonString);
        print('$_currentTime - $_currentUser: Article saved to favorites successfully');
      } else {
        print('$_currentTime - $_currentUser: Article already in favorites');
      }
    } catch (e) {
      print('$_currentTime - $_currentUser: Error saving article to favorites: $e');
      throw Exception('Failed to save article to favorites');
    }
  }

  @override
  Future<void> removeArticleFromFavorites(String articleUrl) async {
    try {
      print('$_currentTime - $_currentUser: Removing article from favorites: $articleUrl');
      final favorites = await getFavoriteArticles();
      favorites.removeWhere((article) => article.url == articleUrl);
      final jsonString = json.encode(favorites.map((a) => a.toJson()).toList());
      await sharedPreferences.setString(_favoriteArticlesKey, jsonString);
      print('$_currentTime - $_currentUser: Article removed from favorites successfully');
    } catch (e) {
      print('$_currentTime - $_currentUser: Error removing article from favorites: $e');
      throw Exception('Failed to remove article from favorites');
    }
  }

  @override
  Future<List<ArticleModel>> getFavoriteArticles() async {
    try {
      final jsonString = sharedPreferences.getString(_favoriteArticlesKey);
      if (jsonString != null) {
        final List decodedList = json.decode(jsonString);
        final articles = decodedList.map((article) => ArticleModel.fromJson(article)).toList();
        print('$_currentTime - $_currentUser: Retrieved ${articles.length} favorite articles');
        return articles;
      }
      print('$_currentTime - $_currentUser: No favorite articles found');
      return [];
    } catch (e) {
      print('$_currentTime - $_currentUser: Error retrieving favorite articles: $e');
      return [];
    }
  }

  @override
  Future<bool> isArticleFavorite(String articleUrl) async {
    try {
      final favorites = await getFavoriteArticles();
      return favorites.any((article) => article.url == articleUrl);
    } catch (e) {
      print('$_currentTime - $_currentUser: Error checking if article is favorite: $e');
      return false;
    }
  }
}