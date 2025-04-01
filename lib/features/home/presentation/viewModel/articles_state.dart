import 'package:flutter_news_app_api/features/home/data/models/article_model.dart';
import 'package:equatable/equatable.dart';

/// Base class for all states related to ArticlesCubit
abstract class ArticlesState extends Equatable {
  const ArticlesState();

  @override
  List<Object> get props => [];
}

class ArticlesInitial extends ArticlesState {}

class ArticlesLoading extends ArticlesState {}

class ArticlesLoaded extends ArticlesState {
  final List<ArticleModel> articles;
  final String category;
  final DateTime lastRefreshed;

  const ArticlesLoaded({
    required this.articles,
    required this.category,
    required this.lastRefreshed,
  });

  @override
  List<Object> get props => [articles, category, lastRefreshed];
}

class ArticlesSearchResult extends ArticlesState {
  final List<ArticleModel> articles;
  final String searchQuery;
  final String? sortBy;

  const ArticlesSearchResult({
    required this.articles,
    required this.searchQuery,
    this.sortBy,
  });

  @override
  List<Object> get props => [articles, searchQuery, sortBy ?? ''];
}

class ArticlesError extends ArticlesState {
  final String message;
  final String? errorCode;
  final String lastOperation;
  final Map<String, dynamic>? errorContext;

  const ArticlesError({
    required this.message,
    this.errorCode,
    required this.lastOperation,
    this.errorContext,
  });

  @override
  List<Object> get props => [message, errorCode ?? '', lastOperation, errorContext ?? {}];
}