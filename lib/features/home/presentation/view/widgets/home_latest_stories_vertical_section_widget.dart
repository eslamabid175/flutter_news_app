import 'package:flutter/material.dart';
import '../../../domain/entities/article_entity.dart';
import 'home_articles_listview_vertical.dart';
import 'home_header_row_sectionName_viewAllbtn.dart';

/// HomeLatestStoriesVerticalSectionWidget: Displays stories in a vertical layout
/// We chose this structure because:
/// 1. Column provides natural vertical flow
/// 2. Separation of concerns between header and content
/// 3. Easy to maintain and modify individual components
class HomeLatestStoriesVerticalSectionWidget extends StatelessWidget {
  // Required properties for customization and data
  final String sectionName;
  final VoidCallback onViewAllPressed;
  final List<Article> articles;

  // Constructor with named parameters for clarity
  const HomeLatestStoriesVerticalSectionWidget({
    super.key,
    required this.sectionName,
    required this.onViewAllPressed,
    required this.articles,
  });

  @override
  Widget build(BuildContext context) {
    // Check for empty articles list
    // SizedBox.shrink() chosen over Container() for better performance
    if (articles.isEmpty) {
      return const SizedBox.shrink();
    }

    // Column used for vertical arrangement
    // Preferred over ListView for header + content pattern
    return Column(
      // Left alignment for better visual hierarchy
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header component with section name and view all button
        HomeHeaderRowSectionnameViewallbtn(
          sectionName: sectionName,
          onViewAllPressed: onViewAllPressed,
        ),
        // Vertical list of stories
        HomeLatestStoriesListviewVertical(articles: articles),
      ],
    );
  }
}