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
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
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