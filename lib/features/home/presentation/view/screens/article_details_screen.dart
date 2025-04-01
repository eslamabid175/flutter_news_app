import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/article_entity.dart';
import '../../viewModel/favorite_article_state.dart';
import '../../viewModel/favorite_articles_cupit.dart';
import '../widgets/details_description.dart';
import '../widgets/details_title.dart';
import '../widgets/details_top_image.dart';
import '../widgets/details_top_row_icons.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleDetailScreen extends StatelessWidget {
  final Article article;
  static const currentTime = '2025-04-01 20:42:14';
  static const currentUser = 'eslamabid175';

  const ArticleDetailScreen({
    super.key,
    required this.article,
  });

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('MMMM dd, yyyy').format(date);
    } catch (e) {
      print('$currentTime - $currentUser: Error parsing date: $e');
      return 'Date not available';
    }
  }

  Future<void> _launchURL(BuildContext context, String url) async {
    try {
      print('$currentTime - $currentUser: Attempting to launch URL: $url');
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        print('$currentTime - $currentUser: Could not launch URL: $url');
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Could not open article URL'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      print('$currentTime - $currentUser: Error launching URL: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error opening article: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print('$currentTime - $currentUser: Building ArticleDetailScreen for ${article.title}');

    return BlocBuilder<FavoriteArticlesCubit, FavoriteArticlesState>(
      builder: (context, state) {
        final isFavorite = state is FavoriteArticlesLoaded &&
            state.articles.any((a) => a.url == article.url);

        print('$currentTime - $currentUser: Article favorite status: $isFavorite');

        return Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          // Image Section
                          TopImage(
                            imageUrl: article.urlToImage,
                            onError: (error) {
                              print('$currentTime - $currentUser: Error loading image: $error');
                            },
                          ),
                          // Top Icons
                          TopIconsRow(
                            onBackPressed: () {
                              print('$currentTime - $currentUser: Navigating back from article details');
                              Navigator.pop(context);
                            },
                            onFavoritePressed: () {
                              print('$currentTime - $currentUser: Toggle favorite for article: ${article.title}');
                              context.read<FavoriteArticlesCubit>().toggleFavorite(article);
                            },
                            isFavorite: isFavorite,
                          ),
                        ],
                      ),
                      // Content Section
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          transform: Matrix4.translationValues(0, -20, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title Section
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      article.title,
                                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      article.description,
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      children: [
                                        Text(
                                          'News API',
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          '•',
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          _formatDate(article.publishedAt),
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // Content Section
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                child: Text(
                                  article.content,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Read Full Article Button
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () => _launchURL(context, article.url),
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text('Read Full Article'),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}