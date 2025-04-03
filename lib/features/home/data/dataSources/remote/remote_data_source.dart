import 'package:dio/dio.dart';
import '../../../../../core/api/dio_helper.dart';
import '../../../../../core/utils/constants.dart';
import '../../models/article_model.dart';

// Abstract class defining the contract for remote data operations
abstract class ArticleRemoteDataSource {
  Future<List<ArticleModel>> getTopHeadlines();
  Future<List<ArticleModel>> searchArticles(String query);
}

// Implementation of remote data source using Dio
class ArticleRemoteDataSourceImpl implements ArticleRemoteDataSource {
  // Constants for logging
  static const _currentTime = '2025-04-01 15:30:22';
  static const _currentUser = 'eslamabid175';

  @override
  Future<List<ArticleModel>> getTopHeadlines() async {
    try {
      print('$_currentTime - $_currentUser: Fetching top headlines');
      // Make API request using DioHelper

      final response = await DioHelper.dio.get(
        AppConstants.topHeadlines,
        queryParameters: {
          'country': AppConstants.defaultCountry,
          'pageSize': AppConstants.defaultPageSize,
        },
      );

      print('$_currentTime - $_currentUser: Response status: ${response.statusCode}');
      // Handle response

      if (response.statusCode == 200) {
        if (response.data['status'] == 'error') {
          print('$_currentTime - $_currentUser: API returned error: ${response.data['message']}');
          throw DioException(
            requestOptions: RequestOptions(path: AppConstants.topHeadlines),
            error: response.data['message'] ?? 'API returned an error',
          );
        }
        // Parse articles from response

        final articlesList = response.data['articles'] as List?;
        if (articlesList == null || articlesList.isEmpty) {
          print('$_currentTime - $_currentUser: No articles found in response');
          return [];
        }
        // Convert JSON to ArticleModel objects

        final articles = <ArticleModel>[];
        for (var articleData in articlesList) {
          try {
            final article = ArticleModel.fromJson(articleData);
            articles.add(article);
          } catch (e) {
            print('$_currentTime - $_currentUser: Error parsing article: $e');
            print('$_currentTime - $_currentUser: Problematic article data: $articleData');
            // Continue to next article if one fails to parse
            continue;
          }
        }

        print('$_currentTime - $_currentUser: Successfully parsed ${articles.length} articles');
        return articles;
      } else {
        print('$_currentTime - $_currentUser: Server returned error status: ${response.statusCode}');
        throw DioException(
          requestOptions: RequestOptions(path: AppConstants.topHeadlines),
          response: response,
          error: 'Server returned ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      print('$_currentTime - $_currentUser: DioError: ${e.message}');
      print('$_currentTime - $_currentUser: Response: ${e.response?.data}');
      throw Exception(e.response?.data?['message'] ?? e.message ?? 'Failed to fetch headlines');
    } catch (e, stackTrace) {
      print('$_currentTime - $_currentUser: Error: $e');
      print('$_currentTime - $_currentUser: Stack trace: $stackTrace');
      throw Exception('Failed to fetch headlines: $e');
    }
  }

  @override
  Future<List<ArticleModel>> searchArticles(String query) async {
    try {
      print('$_currentTime - $_currentUser: Searching articles with query: $query');

      final response = await DioHelper.dio.get(
        AppConstants.everything,
        queryParameters: {
          'q': query,
          'language': AppConstants.defaultLanguage,
          'pageSize': AppConstants.defaultPageSize,
        },
      );

      print('$_currentTime - $_currentUser: Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        if (response.data['status'] == 'error') {
          print('$_currentTime - $_currentUser: API returned error: ${response.data['message']}');
          throw DioException(
            requestOptions: RequestOptions(path: AppConstants.everything),
            error: response.data['message'] ?? 'API returned an error',
          );
        }

        final articlesList = response.data['articles'] as List?;
        if (articlesList == null || articlesList.isEmpty) {
          print('$_currentTime - $_currentUser: No articles found for query: $query');
          return [];
        }

        final articles = <ArticleModel>[];
        for (var articleData in articlesList) {
          try {
            final article = ArticleModel.fromJson(articleData);
            articles.add(article);
          } catch (e) {
            print('$_currentTime - $_currentUser: Error parsing article: $e');
            print('$_currentTime - $_currentUser: Problematic article data: $articleData');
            // Continue to next article if one fails to parse
            continue;
          }
        }

        print('$_currentTime - $_currentUser: Found ${articles.length} articles for query: $query');
        return articles;
      } else {
        print('$_currentTime - $_currentUser: Server returned error status: ${response.statusCode}');
        throw DioException(
          requestOptions: RequestOptions(path: AppConstants.everything),
          response: response,
          error: 'Server returned ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      print('$_currentTime - $_currentUser: DioError: ${e.message}');
      print('$_currentTime - $_currentUser: Response: ${e.response?.data}');
      throw Exception(e.response?.data?['message'] ?? e.message ?? 'Failed to search articles');
    } catch (e, stackTrace) {
      print('$_currentTime - $_currentUser: Error: $e');
      print('$_currentTime - $_currentUser: Stack trace: $stackTrace');
      throw Exception('Failed to search articles: $e');
    }
  }
}