// Import Equatable for value comparison
import 'package:equatable/equatable.dart';
// Import article entity for type definition
import '../../domain/entities/article_entity.dart';

/// Base abstract class for favorite articles states
abstract class FavoriteArticlesState extends Equatable {
  // Const constructor for performance
  const FavoriteArticlesState();

  // Default props implementation
  @override
  List<Object> get props => [];
}

/// Initial state when favorites are not yet loaded
class FavoriteArticlesInitial extends FavoriteArticlesState {}

/// Loading state while fetching favorites
class FavoriteArticlesLoading extends FavoriteArticlesState {}

/// State when favorites are successfully loaded
class FavoriteArticlesLoaded extends FavoriteArticlesState {
  // List of favorite articles
  final List<Article> articles;
  // Default timestamp for tracking state changes
  static final DateTime defaultTime = DateTime.parse('2025-04-03 12:24:03');

  // Constructor with required articles list
  const FavoriteArticlesLoaded({
    required this.articles,
  });

  // Props including articles and timestamp for equality comparison
  @override
  List<Object> get props => [articles, defaultTime];
}

/// Error state for favorites operations
class FavoriteArticlesError extends FavoriteArticlesState {
  // Error message
  final String message;
  // Default timestamp for tracking errors
  static final DateTime defaultTime = DateTime.parse('2025-04-03 12:24:03');

  // Constructor with required error message
  const FavoriteArticlesError({
    required this.message,
  });

  // Props including error message and timestamp
  @override
  List<Object> get props => [message, defaultTime];
}