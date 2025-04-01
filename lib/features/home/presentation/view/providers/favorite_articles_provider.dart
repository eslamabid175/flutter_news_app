import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/dataSources/local/article_local_datasource.dart';
import '../../viewModel/favorite_articles_cupit.dart';

class FavoriteArticlesProvider extends StatelessWidget {
  final Widget child;
  final ArticleLocalDataSource localDataSource;

  const FavoriteArticlesProvider({
    Key? key,
    required this.child,
    required this.localDataSource,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteArticlesCubit(
        localDataSource: localDataSource,
      ),
      child: child,
    );
  }
}