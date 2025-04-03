// Clean Architecture: Presentation Layer Component
// SOLID Principle: Single Responsibility Principle (SRP)
// This widget is responsible only for providing FavoriteArticlesCubit to its children

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/dataSources/local/article_local_datasource.dart';
import '../../viewModel/favorite_articles_cupit.dart';

// Widget that provides FavoriteArticlesCubit to its child widgets
// SOLID Principle: Dependency Injection
class FavoriteArticlesProvider extends StatelessWidget {
  // Child widget to be wrapped
  final Widget child;
  // Data source dependency
  final ArticleLocalDataSource localDataSource;

  // Constructor with required parameters
  const FavoriteArticlesProvider({
    Key? key,
    required this.child,
    required this.localDataSource,
  }) : super(key: key);

  // Build method implementing the widget tree
  @override
  Widget build(BuildContext context) {
    // BlocProvider for dependency injection of FavoriteArticlesCubit
    return BlocProvider(
      // Create new instance of FavoriteArticlesCubit
      create: (context) => FavoriteArticlesCubit(
        localDataSource: localDataSource,
      ),
      // Pass through child widget
      child: child,
    );
  }
}