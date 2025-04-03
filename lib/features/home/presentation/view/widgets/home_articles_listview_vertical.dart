import 'package:flutter/material.dart';
import '../../../domain/entities/article_entity.dart';
import 'home_vertical_article_card.dart';
class HomeLatestStoriesListviewVertical extends StatelessWidget {
  final List<Article> articles;

  const HomeLatestStoriesListviewVertical({
    super.key,
    required this.articles
  });

  @override
  Widget build(BuildContext context) {
    // ListView.builder chosen over ListView for:
    // 1. Lazy loading of items
    // 2. Better performance with large lists
    return ListView.builder(
      // NeverScrollableScrollPhysics prevents nested scrolling issues
      physics: const NeverScrollableScrollPhysics(),
      // shrinkWrap true because this is nested in another scrollable
      shrinkWrap: true,
      itemCount: articles.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: VerticalArticleCard(article: articles[index]),
        );
      },
    );
  }
}