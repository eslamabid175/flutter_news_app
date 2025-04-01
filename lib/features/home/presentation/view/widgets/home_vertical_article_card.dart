import 'package:flutter/material.dart';
import '../../../../../core/themeing/app_colors.dart';
import '../../../../../core/themeing/app_text_styles.dart';
import '../../../domain/entities/article_entity.dart';
import 'home_latest_stories_image_vertical.dart';
import 'home_article_readmorebtn.dart';

class VerticalArticleCard extends StatelessWidget {
  final Article article;

  const VerticalArticleCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: AppColors.darkgreyColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Article Image
            HomeArticalImageVertical(article: article),
            const SizedBox(width: 12),
            // Title and Read More Button Column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    article.title,
                    style: AppTextStyles.font12reqularwhite,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
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
