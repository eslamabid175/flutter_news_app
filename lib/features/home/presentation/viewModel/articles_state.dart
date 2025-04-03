// Import article model for data structure
import 'package:flutter_news_app_api/features/home/data/models/article_model.dart';
// Import Equatable for value-based equality comparison
import 'package:equatable/equatable.dart';

/// Base abstract class for all article-related states
/// Extends Equatable to enable value comparison between states
abstract class ArticlesState extends Equatable {
  // Constructor marked as const for performance optimization
  const ArticlesState();

  // Default props implementation returns empty list
  // Each subclass will override this with their specific properties
  @override
  List<Object> get props => [];
}

/// Initial state when the ArticlesCubit is first created
/// Contains no data, represents the starting point
class ArticlesInitial extends ArticlesState {}

/// Loading state while fetching articles
/// Indicates that an operation is in progress
class ArticlesLoading extends ArticlesState {}

/// State when articles are successfully loaded
/// Contains the loaded articles and metadata
class ArticlesLoaded extends ArticlesState {
  // List of loaded articles
  final List<ArticleModel> articles;
  // Current category of loaded articles
  final String category;
  // Timestamp of when the articles were last refreshed
  final DateTime lastRefreshed;

  // Constructor with required parameters
  const ArticlesLoaded({
    required this.articles,
    required this.category,
    required this.lastRefreshed,
  });

  // Override props to include all state properties for equality comparison
  @override
  List<Object> get props => [articles, category, lastRefreshed];
}

/// State representing search results
/// Contains search-specific data and results
class ArticlesSearchResult extends ArticlesState {
  // List of articles matching the search criteria
  final List<ArticleModel> articles;
  // The search query that produced these results
  final String searchQuery;
  // Optional sorting parameter used in the search
  final String? sortBy;

  // Constructor with required and optional parameters
  const ArticlesSearchResult({
    required this.articles,
    required this.searchQuery,
    this.sortBy,
  });

  // Override props to include all state properties
  // Uses empty string for null sortBy to maintain consistency
  @override
  List<Object> get props => [articles, searchQuery, sortBy ?? ''];
}

/// Error state when something goes wrong
/// Contains detailed error information for debugging and user feedback
class ArticlesError extends ArticlesState {
  // User-friendly error message
  final String message;
  // Optional error code for categorizing errors
  final String? errorCode;
  // Name of the operation that failed
  final String lastOperation;
  // Additional context about the error
  final Map<String, dynamic>? errorContext;

  // Constructor with required and optional parameters
  const ArticlesError({
    required this.message,
    this.errorCode,
    required this.lastOperation,
    this.errorContext,
  });

  // Override props to include all error information
  // Uses empty string/map for null values
  @override
  List<Object> get props => [
    message,
    errorCode ?? '',
    lastOperation,
    errorContext ?? {},
  ];
}