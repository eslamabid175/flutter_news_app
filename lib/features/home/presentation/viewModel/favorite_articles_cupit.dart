import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/dataSources/local/article_local_datasource.dart';
import '../../data/models/article_model.dart';
import '../../domain/entities/article_entity.dart';
import 'favorite_article_state.dart';

class FavoriteArticlesCubit extends Cubit<FavoriteArticlesState> {
  final ArticleLocalDataSource localDataSource;
  static const currentTime = '2025-04-01 20:09:02';
  static const currentUser = 'eslamabid175';

  FavoriteArticlesCubit({
    required this.localDataSource,
  }) : super(FavoriteArticlesInitial()) {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    try {
      print('$currentTime - $currentUser: Loading favorite articles');
      emit(FavoriteArticlesLoading());

      final articles = await localDataSource.getFavoriteArticles();

      print('$currentTime - $currentUser: Loaded ${articles.length} favorite articles');
      emit(FavoriteArticlesLoaded(articles: articles));
    } catch (e) {
      print('$currentTime - $currentUser: Error loading favorites: $e');
      emit(FavoriteArticlesError(message: 'Failed to load favorites: $e'));
    }
  }

  Future<void> toggleFavorite(Article article) async {
    try {
      print('$currentTime - $currentUser: Toggling favorite for article: ${article.title}');

      // Convert Article to ArticleModel
      final articleModel = ArticleModel(
        title: article.title,
        description: article.description,
        url: article.url,
        urlToImage: article.urlToImage,
        publishedAt: article.publishedAt,
        content: article.content,
      );

      final isFavorite = await localDataSource.isArticleFavorite(article.url);

      if (isFavorite) {
        await localDataSource.removeArticleFromFavorites(article.url);
        print('$currentTime - $currentUser: Article removed from favorites');
      } else {
        await localDataSource.saveArticleAsFavorite(articleModel);
        print('$currentTime - $currentUser: Article added to favorites');
      }

      await loadFavorites();
    } catch (e) {
      print('$currentTime - $currentUser: Error toggling favorite: $e');
      emit(FavoriteArticlesError(message: 'Failed to update favorite status'));
    }
  }

  Future<bool> isFavorite(String articleUrl) async {
    try {
      return await localDataSource.isArticleFavorite(articleUrl);
    } catch (e) {
      print('$currentTime - $currentUser: Error checking favorite status: $e');
      return false;
    }
  }

  Future<void> removeFromFavorites(String articleUrl) async {
    try {
      print('$currentTime - $currentUser: Removing article from favorites: $articleUrl');
      await localDataSource.removeArticleFromFavorites(articleUrl);
      await loadFavorites();
    } catch (e) {
      print('$currentTime - $currentUser: Error removing from favorites: $e');
      emit(FavoriteArticlesError(message: 'Failed to remove from favorites'));
    }
  }

  Future<void> clearAllFavorites() async {
    try {
      print('$currentTime - $currentUser: Clearing all favorites');
      final favorites = await localDataSource.getFavoriteArticles();
      for (var article in favorites) {
        await localDataSource.removeArticleFromFavorites(article.url);
      }
      await loadFavorites();
      print('$currentTime - $currentUser: All favorites cleared');
    } catch (e) {
      print('$currentTime - $currentUser: Error clearing favorites: $e');
      emit(FavoriteArticlesError(message: 'Failed to clear favorites'));
    }
  }
}