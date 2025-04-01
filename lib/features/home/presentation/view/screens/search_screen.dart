import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app_api/features/home/presentation/viewModel/articles_cubit.dart';
import 'package:flutter_news_app_api/features/home/presentation/view/widgets/article_list_item.dart';

import '../../viewModel/articles_state.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Articles'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
              onSubmitted: (query) {
                if (query.isNotEmpty) {
                  context.read<ArticlesCubit>().searchArticless(query: query);
                }
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<ArticlesCubit, ArticlesState>(
              builder: (context, state) {
                if (state is ArticlesLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ArticlesSearchResult) {
                  return ListView.builder(
                    itemCount: state.articles.length,
                    itemBuilder: (context, index) {
                      return ArticleListItem(article: state.articles[index]);
                    },
                  );
                } else if (state is ArticlesError) {
                  return Center(child: Text('Error: ${state.message}'));
                } else {
                  return const Center(child: Text('No results found'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}