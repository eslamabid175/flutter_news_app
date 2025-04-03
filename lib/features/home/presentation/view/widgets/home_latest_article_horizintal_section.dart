import 'package:flutter/material.dart';
import '../../../domain/entities/article_entity.dart';
import 'home_latest_articles_listview_horizintal.dart';
import 'home_header_row_sectionName_viewAllbtn.dart';
class LatestArticleSectionWidget extends StatelessWidget {
  final String sectionName;
  final VoidCallback onViewAllPressed;
  final List<Article> articles;

  const LatestArticleSectionWidget({
    super.key,
    required this.sectionName,
    required this.onViewAllPressed,
    required this.articles,
  });

  @override
  Widget build(BuildContext context) {
    // Empty state handling with SizedBox.shrink()
    // Chosen over Container() for better performance
    if (articles.isEmpty) {
      return const SizedBox.shrink();
    }

    // Column chosen for vertical layout because:
    // 1. Simple arrangement of header and content
    // 2. Better semantics than Stack
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HomeHeaderRowSectionnameViewallbtn(
          sectionName: sectionName,
          onViewAllPressed: onViewAllPressed,
        ),
        HomeLatestArticlesListviewHorizintal(articles: articles),
      ],
    );
  }
}