import 'package:flutter/material.dart';
import '../../../domain/entities/article_entity.dart';
import 'home_articles_listview_vertical.dart';
import 'home_header_row_sectionName_viewAllbtn.dart';

class HomeLatestStoriesVerticalSectionWidget extends StatelessWidget {
  final String sectionName;
  final VoidCallback onViewAllPressed;
  final List<Article> articles;

  const HomeLatestStoriesVerticalSectionWidget({
    super.key,
    required this.sectionName,
    required this.onViewAllPressed,
    required this.articles,
  });

  @override
  Widget build(BuildContext context) {
    if (articles.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HomeHeaderRowSectionnameViewallbtn(
          sectionName: sectionName,
          onViewAllPressed: onViewAllPressed,
        ),
        HomeLatestStoriesListviewVertical(articles: articles),
      ],
    );
  }
}