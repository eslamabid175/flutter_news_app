// Import Flutter's material design library
import 'package:flutter/material.dart';
// Import BLoC for state management
import 'package:flutter_bloc/flutter_bloc.dart';
// Import necessary models and widgets
import '../../../domain/entities/article_entity.dart';
import '../../viewModel/favorite_article_state.dart';
import '../../viewModel/favorite_articles_cupit.dart';
import '../widgets/details_top_image.dart';
import '../widgets/details_top_row_icons.dart';
// Import date formatting library
import 'package:intl/intl.dart';
// Import URL launcher for opening links
import 'package:url_launcher/url_launcher.dart';

// ArticleDetailScreen widget definition
class ArticleDetailScreen extends StatelessWidget {
  // Required article data
  final Article article;
  // Constants for logging
  static const currentTime = '2025-04-01 20:42:14';
  static const currentUser = 'eslamabid175';

  // Constructor with required article parameter
  const ArticleDetailScreen({
    super.key,
    required this.article,
  });

  // Private method to format date strings
  String _formatDate(String dateString) {
    try {
      // Parse the date string to DateTime
      final date = DateTime.parse(dateString);
      // Format the date in "Month DD, YYYY" format
      return DateFormat('MMMM dd, yyyy').format(date);
    } catch (e) {
      // Log error if date parsing fails
      print('$currentTime - $currentUser: Error parsing date: $e');
      return 'Date not available';
    }
  }

  // Private method to handle URL launching
  Future<void> _launchURL(BuildContext context, String url) async {
    try {
      // Log URL launch attempt
      print('$currentTime - $currentUser: Attempting to launch URL: $url');
      // Parse the URL string to Uri
      final uri = Uri.parse(url);
      // Check if URL can be launched
      if (await canLaunchUrl(uri)) {
        // Launch URL in external application
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        // Log and show error if URL cannot be launched
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
      // Handle any errors during URL launch
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
    // Log screen building
    print('$currentTime - $currentUser: Building ArticleDetailScreen for ${article.title}');

    // Use BlocBuilder to react to favorite state changes
    return BlocBuilder<FavoriteArticlesCubit, FavoriteArticlesState>(
      builder: (context, state) {
        // Check if current article is in favorites
        final isFavorite = state is FavoriteArticlesLoaded &&
            state.articles.any((a) => a.url == article.url);

        // Log favorite status
        print('$currentTime - $currentUser: Article favorite status: $isFavorite');

        // Build the main scaffold
        return Scaffold(
          body: SafeArea(
            // CustomScrollView for flexible scrolling behavior
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      // Stack for overlaying elements
                      Stack(
                        children: [
                          // Article image
                          TopImage(
                            imageUrl: article.urlToImage,
                            onError: (error) {
                              print('$currentTime - $currentUser: Error loading image: $error');
                            },
                          ),
                          // Back and favorite buttons
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
                      // Article content section
                      Expanded(
                        child: Container(
                          // Container styling
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          // Move container up to overlap with image
                          transform: Matrix4.translationValues(0, -20, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title section
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Article title
                                    Text(
                                      article.title,
                                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    // Article description
                                    Text(
                                      article.description,
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                    const SizedBox(height: 12),
                                    // Metadata row (source and date)
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
                              // Article content
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
                              // Read full article button
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