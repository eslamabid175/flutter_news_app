import 'package:flutter/cupertino.dart';
import 'package:flutter_news_app_api/features/home/domain/entities/article_entity.dart';
import 'package:flutter_news_app_api/features/home/presentation/view/widgets/home_latest_stories_vertical_section_widget.dart';

import 'home_vertical_article_card.dart';

class HomeLatestStoriesListviewVertical extends StatelessWidget {
  final List<Article> articles;
  const HomeLatestStoriesListviewVertical({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 400,
      // Adjust this height based on how many items you want to show
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: articles.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          return VerticalArticleCard(article: articles[index]);
        },
      ),
    );
  }
}
