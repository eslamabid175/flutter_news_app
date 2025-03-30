import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../models/article_model.dart';

/// This class handles all local storage operations for articles
/// We use SharedPreferences for persistence storage
abstract class ArticleLocalDataSource {
  Future<List<ArticleModel>> getCachedArticles();
  Future<void> cacheArticles(List<ArticleModel> articles);
  Future<void> clearCache();
}

class ArticleLocalDataSourceImpl implements ArticleLocalDataSource {
  // Store current time and user for tracking operations
  final _currentTime = DateTime.parse('2025-03-30 11:44:58');
  final _currentUser = 'eslamabid175';

  // Define storage keys to avoid typos
  static const String CACHED_ARTICLES_KEY = 'CACHED_ARTICLES_KEY';
  static const String LAST_CACHE_TIME_KEY = 'LAST_CACHE_TIME_KEY';

  // Instance of SharedPreferences for data persistence
  final SharedPreferences sharedPreferences;

  // Constructor requiring SharedPreferences instance
  ArticleLocalDataSourceImpl({required this.sharedPreferences}) {
    // Log initialization
    print('LocalDataSource initialized by: $_currentUser at $_currentTime');
  }

  @override
  Future<List<ArticleModel>> getCachedArticles() async {
    try {
      // Log attempt to retrieve cached data
      print('Attempting to retrieve cached articles - User: $_currentUser');

      // Check if we have cached data
      final jsonString = sharedPreferences.getString(CACHED_ARTICLES_KEY);

      // If no cached data exists, throw exception
      if (jsonString == null) {
        print('No cached articles found');
        throw CacheException('No cached articles available');
      }

      // Check cache age
      final lastCacheTime = DateTime.parse(
          sharedPreferences.getString(LAST_CACHE_TIME_KEY) ?? _currentTime.toString()
      );

      // Calculate how old the cache is
      final cacheAge = _currentTime.difference(lastCacheTime).inHours;

      // If cache is older than 1 hour, consider it stale
      if (cacheAge > 1) {
        print('Cache is stale (${cacheAge}h old)');
        throw CacheException('Cache is stale');
      }

      // Parse the cached JSON string into a List
      final List<dynamic> jsonList = json.decode(jsonString);

      // Convert each JSON object to an ArticleModel
      final articles = jsonList
          .map((jsonMap) => ArticleModel.fromJson(jsonMap))
          .toList();

      // Log success
      print('Successfully retrieved ${articles.length} cached articles');

      return articles;
    } catch (e) {
      // Log error and rethrow as CacheException
      print('Error retrieving cached articles: $e');
      throw CacheException(e.toString());
    }
  }

  @override
  Future<void> cacheArticles(List<ArticleModel> articles) async {
    try {
      // Log caching attempt
      print('Attempting to cache ${articles.length} articles - User: $_currentUser');

      // Convert each ArticleModel to a JSON map
      final List<Map<String, dynamic>> jsonList =
      articles.map((article) => article.toJson()).toList();

      // Convert the list of JSON maps to a single JSON string
      final String jsonString = json.encode(jsonList);

      // Save both the articles and the cache timestamp
      await Future.wait([
        // Save the articles data
        sharedPreferences.setString(
          CACHED_ARTICLES_KEY,
          jsonString,
        ),
        // Save the current time as cache timestamp
        sharedPreferences.setString(
          LAST_CACHE_TIME_KEY,
          _currentTime.toIso8601String(),
        ),
      ]);

      // Log success
      print('Successfully cached ${articles.length} articles');
    } catch (e) {
      // Log error and rethrow as CacheException
      print('Error caching articles: $e');
      throw CacheException('Failed to cache articles: $e');
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      // Log cache clearing attempt
      print('Attempting to clear cache - User: $_currentUser');

      // Remove both articles and timestamp
      await Future.wait([
        sharedPreferences.remove(CACHED_ARTICLES_KEY),
        sharedPreferences.remove(LAST_CACHE_TIME_KEY),
      ]);

      // Log success
      print('Cache cleared successfully');
    } catch (e) {
      // Log error and rethrow as CacheException
      print('Error clearing cache: $e');
      throw CacheException('Failed to clear cache: $e');
    }
  }

  /// Helper method to check if cache is valid
  bool _isCacheValid() {
    try {
      // Get the last cache time
      final lastCacheTimeStr =
      sharedPreferences.getString(LAST_CACHE_TIME_KEY);

      // If no cache time exists, cache is invalid
      if (lastCacheTimeStr == null) return false;

      // Parse the cache time
      final lastCacheTime = DateTime.parse(lastCacheTimeStr);

      // Calculate cache age
      final cacheAge = _currentTime.difference(lastCacheTime).inHours;

      // Cache is valid if less than 1 hour old
      return cacheAge <= 1;
    } catch (e) {
      // If any error occurs, consider cache invalid
      print('Error checking cache validity: $e');
      return false;
    }
  }
}