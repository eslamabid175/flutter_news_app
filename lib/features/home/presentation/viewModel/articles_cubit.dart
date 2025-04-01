import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_news_app_api/features/home/domain/usecases/search_article.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/article_entity.dart';
import '../../domain/usecases/get_top_headlines.dart';
import 'articles_state.dart';

/// ArticlesCubit manages the state of articles in the app
/// It handles loading, refreshing, and searching articles
class ArticlesCubit extends Cubit<ArticlesState> {
  // Use cases required by this cubit
  final GetTopHeadlinesUseCase getTopHeadlines;
  final SearchArticlesUseCase searchArticles;

  // Tracking metadata
  final DateTime _currentTime = DateTime.parse('2025-03-30 11:49:19');
  final String _currentUser = 'eslamabid175';
  DateTime _lastRefreshTime = DateTime.parse('2025-03-30 11:49:19');

  // Refresh interval configuration
  static const refreshIntervalMinutes = 5;

  // Constructor requiring use cases
  ArticlesCubit({
    required this.getTopHeadlines,
    required this.searchArticles,
  }) : super(ArticlesInitial()) {
    // Log initialization
    print('ArticlesCubit initialized by: $_currentUser at $_currentTime');

    // Load initial articles
    loadTopHeadlines();
  }

  /// Loads top headlines articles
  /// [country]: Optional country code (default: 'eg')
  /// [category]: Optional category filter
  Future<void> loadTopHeadlines({
    String country = 'eg',
    String? category,
  }) async {
    try {
      // Log operation start
      print('Loading top headlines - User: $_currentUser');

      // Emit loading state
      emit(ArticlesLoading());

      // Call use case with parameters
      final result = await getTopHeadlines(
        GetTopHeadlinesParams(
          country: country,
          category: category,
        ),
      );

      // Handle result using fold
      result.fold(
        // Handle failure
            (failure) {
          print('Failed to load headlines: ${failure.message}');
          emit(ArticlesError(
            message: failure.message,
            lastOperation: 'loadTopHeadlines',
            errorContext: {
              'country': country,
              'category': category,
              'time': _currentTime.toIso8601String(),
            },
          ));
        },
        // Handle success
            (articles) {
          print('Successfully loaded ${articles.length} articles');
          _lastRefreshTime = _currentTime;
          emit(ArticlesLoaded(
            articles: articles,
            category: category ?? 'general',
            lastRefreshed: _lastRefreshTime,
          ));
        },
      );
    } catch (e) {
      // Handle unexpected errors
      print('Unexpected error in loadTopHeadlines: $e');
      emit(ArticlesError(
        message: 'An unexpected error occurred',
        errorCode: 'UNEXPECTED',
        lastOperation: 'loadTopHeadlines',
      ));
    }
  }

  /// Searches for articles based on query
  /// [query]: Search term
  /// [sortBy]: Optional sort parameter
  /// [language]: Optional language filter
  Future<void> searchArticless({
    required String query,
    String? sortBy,
    String? language,
  }) async {
    try {
      // Only search if query is not empty
      if (query.isEmpty) {
        print('Empty search query, ignoring request');
        return;
      }

      // Log search attempt
      print('Searching articles - Query: $query, User: $_currentUser');

      // Emit loading state
      emit(ArticlesLoading());

      // Call search use case
      final result = await this.searchArticles(
        SearchArticlesParams(
          query: query,
          sortBy: sortBy,
          language: language,
        ),
      );

      // Handle result using fold
      result.fold(
        // Handle failure
            (failure) {
          print('Search failed: ${failure.message}');
          emit(ArticlesError(
            message: failure.message,
            lastOperation: 'searchArticles',
            errorContext: {
              'query': query,
              'sortBy': sortBy,
              'language': language,
            },
          ));
        },
        // Handle success
            (articles) {
          print('Search found ${articles.length} articles');
          emit(ArticlesSearchResult(
            articles: articles,
            searchQuery: query,
            sortBy: sortBy,
          ));
        },
      );
    } catch (e) {
      // Handle unexpected errors
      print('Unexpected error in searchArticles: $e');
      emit(ArticlesError(
        message: 'An unexpected error occurred during search',
        errorCode: 'SEARCH_ERROR',
        lastOperation: 'searchArticles',
      ));
    }
  }

  /// Refreshes current articles if enough time has passed
  Future<void> refreshArticles() async {
    // Calculate time since last refresh
    final timeSinceRefresh = _currentTime.difference(_lastRefreshTime);

    // Check if refresh is needed
    if (timeSinceRefresh.inMinutes < refreshIntervalMinutes) {
      print('Skipping refresh - Last refresh was ${timeSinceRefresh.inMinutes} minutes ago');
      return;
    }

    // Get current state
    final currentState = state;

    // Refresh based on current state
    if (currentState is ArticlesLoaded) {
      await loadTopHeadlines(category: currentState.category);
    } else if (currentState is ArticlesSearchResult) {
      await searchArticless(
        query: currentState.searchQuery,
        sortBy: currentState.sortBy,
      );
    }
  }
}