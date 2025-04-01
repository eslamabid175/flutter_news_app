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
    return GestureDetector(
     onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context){
       return ArticleDetailScreen(article: article);
     }
     )
     ),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        color: AppColors.darkgreyColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Article Image
             HomeArticleImage(article: article),
              const SizedBox(height: 8),
              // Article Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Text(
                  article.title ??"title in card",
                  style: AppTextStyles.font12reqularwhite,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 8),
          Padding(padding: const EdgeInsets.only(left: 2, right: 16, bottom: 2),
            child:// Read More Button
             HomeArticleReadmorebtn()),
            ],
          ),
        ),
      ),
    );
  }
}
