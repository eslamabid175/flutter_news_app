// Import BLoC library for state management
import 'package:bloc/bloc.dart';
// Import Equatable for value comparison
// Import use cases and entities
import 'package:flutter_news_app_api/features/home/domain/usecases/search_article.dart';
import '../../domain/usecases/get_top_headlines.dart';
import 'articles_state.dart';

/// ArticlesCubit: Manages article-related state and operations
/// Extends Cubit<ArticlesState> to provide state management capabilities
class ArticlesCubit extends Cubit<ArticlesState> {
  // Use cases required for business logic
  final GetTopHeadlinesUseCase getTopHeadlines;    // For fetching top headlines
  final SearchArticlesUseCase searchArticles;       // For searching articles

  // Time tracking for operations and logging
  final DateTime _currentTime = DateTime.parse('2025-03-30 11:49:19');
  final String _currentUser = 'eslamabid175';
  DateTime _lastRefreshTime = DateTime.parse('2025-03-30 11:49:19');

  // Configuration constant for refresh interval
  static const refreshIntervalMinutes = 5;  // Minimum time between refreshes

  // Constructor initializes the cubit with required use cases
  ArticlesCubit({
    required this.getTopHeadlines,
    required this.searchArticles,
  }) : super(ArticlesInitial()) {  // Initialize with initial state
    // Log initialization with timestamp and user
    print('ArticlesCubit initialized by: $_currentUser at $_currentTime');

    // Automatically load initial articles
    loadTopHeadlines();
  }

  /// Fetches top headlines articles with optional filters
  /// @param country: Country code for filtering articles (default: 'eg')
  /// @param category: Optional category filter
  Future<void> loadTopHeadlines({
    String country = 'eg',
    String? category,
  }) async {
    try {
      // Log operation start
      print('Loading top headlines - User: $_currentUser');

      // Emit loading state to show progress
      emit(ArticlesLoading());

      // Execute use case with parameters
      final result = await getTopHeadlines(
        GetTopHeadlinesParams(
          country: country,
          category: category,
        ),
      );

      // Handle the result using Either fold method
      result.fold(
        // Failure handler
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
        // Success handler
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

  /// Searches for articles based on provided criteria
  /// @param query: Required search term
  /// @param sortBy: Optional sorting parameter
  /// @param language: Optional language filter
  Future<void> searchArticless({
    required String query,
    String? sortBy,
    String? language,
  }) async {
    // ... (similar detailed comments for search implementation)
  }

  /// Refreshes articles if enough time has passed since last refresh
  Future<void> refreshArticles() async {
    // Calculate elapsed time since last refresh
    final timeSinceRefresh = _currentTime.difference(_lastRefreshTime);

    // Check if refresh interval has passed
    if (timeSinceRefresh.inMinutes < refreshIntervalMinutes) {
      print('Skipping refresh - Last refresh was ${timeSinceRefresh.inMinutes} minutes ago');
      return;
    }

    // Get current state for context
    final currentState = state;

    // Refresh based on current state type
    if (currentState is ArticlesLoaded) {
      // Refresh top headlines
      await loadTopHeadlines(category: currentState.category);
    } else if (currentState is ArticlesSearchResult) {
      // Refresh search results
      await searchArticless(
        query: currentState.searchQuery,
        sortBy: currentState.sortBy,
      );
    }
  }
}