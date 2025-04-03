import 'package:flutter/material.dart';
import '../../../domain/entities/article_entity.dart';
import 'home_latest_articles_card_horizintal.dart';
// Handles horizontal scrolling list of articles
class HomeLatestArticlesListviewHorizintal extends StatelessWidget {
  final List<Article> articles;

  const HomeLatestArticlesListviewHorizintal({
    super.key,
    required this.articles
  });

  @override
  Widget build(BuildContext context) {
    // SizedBox used to constrain height because:
    // 1. Explicit dimensions prevent layout issues
    // 2. Better performance than Container
    return SizedBox(
      height: 260,
      // ListView.builder chosen over ListView because:
      // 1. Lazy loading of items
      // 2. Better memory management
      // 3. Improved performance for long lists
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        // BouncingScrollPhysics chosen for:
        // 1. iOS-style bouncing effect
        // 2. Better user experience
        physics: const BouncingScrollPhysics(),
        itemCount: articles.length,
        itemBuilder: (context, index) {
          // Padding with conditional logic for last item
          return Padding(
            padding: EdgeInsets.only(
                right: index == articles.length - 1 ? 0 : 16
            ),
            // Fixed width for consistent card size
            child: SizedBox(
              width: 180,
              child: HomeArticalCardHorizintal(article: articles[index]),
            ),
          );
        },
      ),
    );
  }
}