import 'package:flutter/material.dart';
import 'package:flutter_news_app_api/features/home/domain/entities/article_entity.dart';

class HomeArticleImage extends StatelessWidget {
  final Article article;
  const HomeArticleImage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    //this is cliprrect is used to make the image rounded corners and
    // its means the image will be circular
    return  ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.network(
        article.urlToImage  ?? '',
        height: 150,
        //this is used to make the image fit to the screen
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 120,
            color: Colors.grey[300],
            child: const Icon(Icons.error),
          );
        },
      ),
    );
  }
}
