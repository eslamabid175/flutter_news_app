// Import necessary packages and files
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/dataSources/local/article_local_datasource.dart';
import '../../data/models/article_model.dart';
import '../../domain/entities/article_entity.dart';
import 'favorite_article_state.dart';

/// Cubit for managing favorite articles functionality
class FavoriteArticlesCubit extends Cubit<FavoriteArticlesState> {
  // Data source for local storage operations
  final ArticleLocalDataSource localDataSource;
  // Constants for logging
  static const currentTime = '2025-04-03 12:24:03';
  static const currentUser = 'eslamabid175';

  // Constructor initializes the cubit and loads favorites
  FavoriteArticlesCubit({
    required this.localDataSource,
  }) : super(FavoriteArticlesInitial()) {
    // Load favorites immediately upon creation
    loadFavorites();
  }

  /// Loads all favorite articles from local storage
  Future<void> loadFavorites() async {
    try {
      // Log operation start
      print('$currentTime - $currentUser: Loading favorite articles');
      // Emit loading state
      emit(FavoriteArticlesLoading());

      // Fetch favorites from local storage
      final articles = await localDataSource.getFavoriteArticles();

      // Log success and emit loaded state
      print('$currentTime - $currentUser: Loaded ${articles.length} favorite articles');
      emit(FavoriteArticlesLoaded(articles: articles));
    } catch (e) {
      // Handle and log errors
      print('$currentTime - $currentUser: Error loading favorites: $e');
      emit(FavoriteArticlesError(message: 'Failed to load favorites: $e'));
    }
  }

  /// Toggles favorite status of an article
  Future<void> toggleFavorite(Article article) async {
    try {
      // Log operation start
      print('$currentTime - $currentUser: Toggling favorite for article: ${article.title}');

      // Convert domain entity to data model
      final articleModel = ArticleModel(
        title: article.title,
        description: article.description,
        url: article.url,
        urlToImage: article.urlToImage,
        publishedAt: article.publishedAt,
        content: article.content,
      );

      // Check current favorite status
      final isFavorite = await localDataSource.isArticleFavorite(article.url);

      // Toggle favorite status
      if (isFavorite) {
        await localDataSource.removeArticleFromFavorites(article.url);
        print('$currentTime - $currentUser: Article removed from favorites');
      } else {
        await localDataSource.saveArticleAsFavorite(articleModel);
        print('$currentTime - $currentUser: Article added to favorites');
      }

      // Reload favorites to update state
      await loadFavorites();
    } catch (e) {
      // Handle and log errors
      print('$currentTime - $currentUser: Error toggling favorite: $e');
      emit(FavoriteArticlesError(message: 'Failed to update favorite status'));
    }
  }

  /// Checks if an article is marked as favorite
  Future<bool> isFavorite(String articleUrl) async {
    try {
      return await localDataSource.isArticleFavorite(articleUrl);
    } catch (e) {
      // Log error and return false as safe default
      print('$currentTime - $currentUser: Error checking favorite status: $e');
      return false;
    }
  }

  /// Removes an article from favorites
  Future<void> removeFromFavorites(String articleUrl) async {
    try {
      // Log operation
      print('$currentTime - $currentUser: Removing article from favorites: $articleUrl');
      // Remove from storage
      await localDataSource.removeArticleFromFavorites(articleUrl);
      // Reload to update state
      await loadFavorites();
    } catch (e) {
      // Handle and log errors
      print('$currentTime - $currentUser: Error removing from favorites: $e');
      emit(FavoriteArticlesError(message: 'Failed to remove from favorites'));
    }
  }

  /// Clears all favorite articles
  Future<void> clearAllFavorites() async {
    try {
      // Log operation start
      print('$currentTime - $currentUser: Clearing all favorites');
      // Get all favorites
      final favorites = await localDataSource.getFavoriteArticles();
      // Remove each favorite
      for (var article in favorites) {
        await localDataSource.removeArticleFromFavorites(article.url);
      }
      // Reload to update state
      await loadFavorites();
      print('$currentTime - $currentUser: All favorites cleared');
    } catch (e) {
      // Handle and log errors
      print('$currentTime - $currentUser: Error clearing favorites: $e');
      emit(FavoriteArticlesError(message: 'Failed to clear favorites'));
    }
  }
}