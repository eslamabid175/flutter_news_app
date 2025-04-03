import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../viewModel/articles_cubit.dart';
import '../../viewModel/articles_state.dart';
import 'home_custom_mid_tapbar.dart';
import 'home_latest_article_horizintal_section.dart';
import 'home_latest_stories_vertical_section_widget.dart';

/// HomeTabbarController: Manages tab-based content and state-dependent UI
/// BlocBuilder used instead of Consumer because:
/// 1. We need to rebuild the entire widget tree on state changes
/// 2. No need for selective rebuilds in this case
/// 3. Simpler implementation for state-based UI
class HomeTabbarController extends StatelessWidget {
  const HomeTabbarController({super.key});

  @override
  Widget build(BuildContext context) {
    // BlocBuilder watches ArticlesCubit state changes
    return BlocBuilder<ArticlesCubit, ArticlesState>(
      builder: (context, state) {
        // Column used for vertical arrangement of tab bar and content
        return Column(
          // MainAxisSize.min prevents Column from taking all available space
          mainAxisSize: MainAxisSize.min,
          children: [
            const CustomTabBar(),
            _buildContent(context, state),
          ],
        );
      },
    );
  }

  // Private method to build content based on state
  Widget _buildContent(BuildContext context, ArticlesState state) {
    // State-specific UI handling
    if (state is ArticlesLoading) {
      // Center and Padding used for proper loading indicator placement
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (state is ArticlesLoaded) {
      // Column for vertical arrangement of article sections
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Latest articles section
          LatestArticleSectionWidget(
            sectionName: 'Latest Articles',
            onViewAllPressed: () {
              print('View all pressed at 2025-04-03 12:27:04 by eslamabid175');
              // Using context.read() instead of BlocProvider.of for simpler syntax
              context.read<ArticlesCubit>().refreshArticles();
            },
            articles: state.articles,
          ),
          const SizedBox(height: 16),
          // Top stories section
          HomeLatestStoriesVerticalSectionWidget(
            sectionName: "Top Stories",
            onViewAllPressed: () {
              print('View all stories pressed at 2025-04-03 12:27:04 by eslamabid175');
              context.read<ArticlesCubit>().loadTopHeadlines();
            },
            articles: state.articles,
          ),
        ],
      );
    } else if (state is ArticlesError) {
      // Error state UI
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Error icon
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            const SizedBox(height: 16),
            // Error message
            Text(
              'Error: ${state.message}',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 16),
            // Retry button
            ElevatedButton.icon(
              onPressed: () {
                print('Retrying at 2025-04-03 12:27:04 by eslamabid175');
                context.read<ArticlesCubit>().loadTopHeadlines();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      );
    } else {
      // Empty state UI
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
                print('Loading articles at 2025-04-03 12:27:04 by eslamabid175');
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