import 'package:equatable/equatable.dart';
import '../../domain/entities/article_entity.dart';

abstract class FavoriteArticlesState extends Equatable {
  const FavoriteArticlesState();

  @override
  List<Object> get props => [];
}

class FavoriteArticlesInitial extends FavoriteArticlesState {}

class FavoriteArticlesLoading extends FavoriteArticlesState {}

class FavoriteArticlesLoaded extends FavoriteArticlesState {
  final List<Article> articles;
  static final DateTime defaultTime = DateTime.parse('2025-04-01 20:02:01');

  const FavoriteArticlesLoaded({
    required this.articles,
  });

  @override
  List<Object> get props => [articles, defaultTime];
}

class FavoriteArticlesError extends FavoriteArticlesState {
  final String message;
  static final DateTime defaultTime = DateTime.parse('2025-04-01 20:02:01');

  const FavoriteArticlesError({
    required this.message,
  });

  @override
  List<Object> get props => [message, defaultTime];
}