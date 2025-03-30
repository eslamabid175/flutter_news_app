import 'package:equatable/equatable.dart';
import '../../domain/entities/article_entity.dart';

/// Base state class for all article-related states
abstract class ArticlesState extends Equatable {
  // Instead of initializing directly, we'll use a getter
  DateTime get stateTimestamp => DateTime.parse('2025-03-30 11:57:03');
  String get stateUser => 'eslamabid175';

  // Remove const from constructor
  ArticlesState();

  @override
  List<Object?> get props => [stateTimestamp, stateUser];
}

/// Initial state when the app starts
class ArticlesInitial extends ArticlesState {
  @override
  List<Object?> get props => [
    stateTimestamp,
    stateUser,
    'initial_state'
  ];
}

/// State while loading articles
class ArticlesLoading extends ArticlesState {
  // Use getter instead of final field
  DateTime get loadStartTime => DateTime.parse('2025-03-30 11:57:03');

  @override
  List<Object?> get props => [
    stateTimestamp,
    stateUser,
    loadStartTime
  ];
}

/// State when articles are successfully loaded
class ArticlesLoaded extends ArticlesState {
  final List<ArticleEntity> articles;
  final String category;
  final DateTime lastRefreshed;
  final int totalResults;

  // Modified constructor without const
  ArticlesLoaded({
    required this.articles,
    this.category = 'general',
    DateTime? lastRefreshed,
  }) : lastRefreshed = lastRefreshed ?? DateTime.parse('2025-03-30 11:57:03'),
        totalResults = articles.length;

  @override
  List<Object?> get props => [
    articles,
    category,
    lastRefreshed,
    totalResults,
    stateTimestamp,
    stateUser
  ];
}

/// State when search results are available
class ArticlesSearchResult extends ArticlesState {
  final List<ArticleEntity> articles;
  final String searchQuery;
  final String? sortBy;
  final int resultCount;
  final DateTime searchTime;

  // Modified constructor without const
  ArticlesSearchResult({
    required this.articles,
    required this.searchQuery,
    this.sortBy,
  }) : resultCount = articles.length,
        searchTime = DateTime.parse('2025-03-30 11:57:03');

  @override
  List<Object?> get props => [
    articles,
    searchQuery,
    sortBy,
    resultCount,
    searchTime,
    stateTimestamp,
    stateUser
  ];
}

/// State when an error occurs
class ArticlesError extends ArticlesState {
  final String message;
  final String errorCode;
  final DateTime errorTime;
  final String? lastOperation;
  final Map<String, dynamic>? errorContext;

  ArticlesError({
    required this.message,
    this.errorCode = 'UNKNOWN',
    this.lastOperation,
    this.errorContext,
  }) : errorTime = DateTime.parse('2025-03-30 11:57:03');

  @override
  List<Object?> get props => [
    message,
    errorCode,
    errorTime,
    lastOperation,
    errorContext,
    stateTimestamp,
    stateUser
  ];

  Map<String, dynamic> toLog() => {
    'message': message,
    'code': errorCode,
    'time': errorTime.toIso8601String(),
    'user': stateUser,
    'operation': lastOperation,
    'context': errorContext,
  };
}