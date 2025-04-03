// File imports for theming and data
import 'package:flutter/material.dart';
import '../../../../../core/themeing/app_colors.dart';
import '../../../../../core/themeing/app_text_styles.dart';
import '../../../domain/entities/article_entity.dart';
import 'home_latest_stories_image_vertical.dart';
import 'home_article_readmorebtn.dart';

/// VerticalArticleCard: Displays an article in a vertical card format
/// We chose Card widget because:
/// 1. It provides built-in elevation and rounded corners
/// 2. Material Design look and feel
/// 3. Built-in padding and margin handling
class VerticalArticleCard extends StatelessWidget {
  // Required article data
  final Article article;

  // Constructor with required article parameter
  const VerticalArticleCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    // Card widget chosen for material design elevation and styling
    return Card(
      // Bottom margin only for proper spacing between cards
      margin: const EdgeInsets.only(bottom: 12),
      // Custom dark color for dark theme compatibility
      color: AppColors.darkgreyColor,
      child: Padding(
        // Even padding around content
        padding: const EdgeInsets.all(8.0),
        // Row used to place image and text side by side
        // Row preferred over Stack for better accessibility and simpler layout
        child: Row(
          // Align items to top of row
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Article image component
            HomeArticalImageVertical(article: article),
            // Spacing between image and text
            const SizedBox(width: 12),
            // Expanded used to ensure text takes remaining space
            // Prevents overflow issues
            Expanded(
              child: Column(
                // Align text to start (left in LTR languages)
                crossAxisAlignment: CrossAxisAlignment.start,
                // Space between title and button
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Article title with ellipsis for overflow
                  Text(
                    article.title,
                    style: AppTextStyles.font12reqularwhite,
                    maxLines: 2, // Limit to 2 lines for consistent height
                    overflow: TextOverflow.ellipsis, // Show ... for overflow
                  ),
                  const SizedBox(height: 12),
                  // Read more button component
                  HomeArticleReadmorebtn(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}