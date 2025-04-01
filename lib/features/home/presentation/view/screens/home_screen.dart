import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app_api/features/home/presentation/view/screens/search_screen.dart';
import 'package:flutter_news_app_api/features/home/presentation/viewModel/articles_cubit.dart';

import '../../viewModel/articles_state.dart';
import '../widgets/article_list_item.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Headlines'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<ArticlesCubit, ArticlesState>(
        builder: (context, state) {
          if (state is ArticlesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ArticlesLoaded) {
            return ListView.builder(
              itemCount: state.articles.length,
              itemBuilder: (context, index) {
                return ArticleListItem(article: state.articles[index]);
              },
            );
          } else if (state is ArticlesError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('No articles found'));
          }
        },
      ),
    );
  }
}