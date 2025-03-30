import '../../../../../core/api/dio_helper.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/utils/constants.dart';
import '../../models/article_model.dart';

/// Abstract class defining the contract for remote data operations
abstract class ArticleRemoteDataSource {
  Future<List<ArticleModel>> getTopHeadlines({
    String country = 'eg',
    String? category,
  });

  Future<List<ArticleModel>> searchArticles({
    required String query,
    String? sortBy,
    String? language,
  });
}

/// Implementation of ArticleRemoteDataSource using DioHelper
class ArticleRemoteDataSourceImpl implements ArticleRemoteDataSource {
  final _currentTime = DateTime.parse('2025-03-30 11:41:56');
  final _currentUser = 'eslamabid175';

  @override
  Future<List<ArticleModel>> getTopHeadlines({
    String country = 'eg',
    String? category,
  }) async {
    try {
      // Log the request attempt
      print('Fetching top headlines - User: $_currentUser, Time: $_currentTime');

      final response = await DioHelper.getData(
        endpoint: ApiConstants.topHeadlines,
        queryParameters: {
          'country': country,
          if (category != null) 'category': category,
        },
      );

      if (response.statusCode == 200) {
        final articles = (response.data['articles'] as List)
            .map((json) => ArticleModel.fromJson(json))
            .toList();

        print('Successfully fetched ${articles.length} articles');
        return articles;
      } else {
        throw ServerException(
            'Failed to fetch top headlines. Status: ${response.statusCode}'
        );
      }
    } catch (e) {
      print('Error fetching top headlines: $e');
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ArticleModel>> searchArticles({
    required String query,
    String? sortBy,
    String? language,
  }) async {
    try {
      print('Searching articles - Query: $query, User: $_currentUser');

      final response = await DioHelper.getData(
        endpoint: ApiConstants.everything,
        queryParameters: {
          'q': query,
          if (sortBy != null) 'sortBy': sortBy,
          if (language != null) 'language': language,
        },
      );

      if (response.statusCode == 200) {
        final articles = (response.data['articles'] as List)
            .map((json) => ArticleModel.fromJson(json))
            .toList();

        print('Found ${articles.length} articles matching query: $query');
        return articles;
      } else {
        throw ServerException(
            'Failed to search articles. Status: ${response.statusCode}'
        );
      }
    } catch (e) {
      print('Error searching articles: $e');
      throw ServerException(e.toString());
    }
  }
}