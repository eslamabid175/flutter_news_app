import 'package:flutter/material.dart';
import '../../../domain/entities/article_entity.dart';
import 'home_latest_articles_card_horizintal.dart';

class HomeLatestArticlesListviewHorizintal extends StatelessWidget {
  final List<Article> articles;

  const HomeLatestArticlesListviewHorizintal({
    super.key,
    required this.articles
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
                right: index == articles.length - 1 ? 0 : 16
            ),
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