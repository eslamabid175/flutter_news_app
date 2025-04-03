import 'package:flutter/material.dart';
import 'package:flutter_news_app_api/features/home/presentation/view/widgets/home_article_readmorebtn.dart';
import '../../../../../core/themeing/app_colors.dart';
import '../../../../../core/themeing/app_text_styles.dart';
import '../screens/article_details_screen.dart';
import '../../../domain/entities/article_entity.dart';
import 'home_latest_articles_image_horzintal.dart';
class HomeArticalCardHorizintal extends StatelessWidget {
  final Article article;

  const HomeArticalCardHorizintal({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    // GestureDetector chosen over InkWell because:
    // 1. No need for ripple effect
    // 2. Better performance for simple tap handling
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ArticleDetailScreen(article: article))
      ),
      // Card widget provides:
      // 1. Built-in elevation and shadows
      // 2. Material Design look
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        color: AppColors.darkgreyColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          // Column for vertical layout of elements
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeArticleImage(article: article),
              const SizedBox(height: 8),
              // Title with ellipsis overflow
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Text(
                  article.title,
                  style: AppTextStyles.font12reqularwhite,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 8),
              // Read more button with specific padding
              Padding(
                  padding: const EdgeInsets.only(left: 2, right: 16, bottom: 2),
                  child: HomeArticleReadmorebtn()
              ),
            ],
          ),
        ),
      ),
    );
  }
}
