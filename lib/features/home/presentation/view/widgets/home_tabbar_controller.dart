import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../viewModel/articles_cubit.dart';
import '../../viewModel/articles_state.dart';
import 'home_custom_mid_tapbar.dart';
import 'home_latest_article_horizintal_section.dart';
import 'home_latest_stories_vertical_section_widget.dart';

class HomeTabbarController extends StatelessWidget {
  const HomeTabbarController({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticlesCubit, ArticlesState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CustomTabBar(),
            _buildContent(context, state),
          ],
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, ArticlesState state) {
    if (state is ArticlesLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (state is ArticlesLoaded) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LatestArticleSectionWidget(
            sectionName: 'Latest Articles',
            onViewAllPressed: () {
              print('View all pressed at 2025-04-01 14:54:09 by eslamabid175');
              context.read<ArticlesCubit>().refreshArticles();
            },
            articles: state.articles,
          ),
          const SizedBox(height: 16),
          HomeLatestStoriesVerticalSectionWidget(
            sectionName: "Top Stories",
            onViewAllPressed: () {
              print('View all stories pressed at 2025-04-01 14:54:09 by eslamabid175');
              context.read<ArticlesCubit>().loadTopHeadlines();
            },
            articles: state.articles,
          ),
        ],
      );
    } else if (state is ArticlesError) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            const SizedBox(height: 16),
            Text(
              'Error: ${state.message}',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                print('Retrying at 2025-04-01 14:54:09 by eslamabid175');
                context.read<ArticlesCubit>().loadTopHeadlines();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.article_outlined,
              size: 60,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            const Text(
              'No articles found',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                print('Loading articles at 2025-04-01 14:54:09 by eslamabid175');
                context.read<ArticlesCubit>().loadTopHeadlines();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Load Articles'),
            ),
          ],
        ),
      );
    }
  }
}