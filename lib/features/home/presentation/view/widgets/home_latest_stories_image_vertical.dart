import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app_api/features/home/domain/entities/article_entity.dart';

class HomeArticalImageVertical extends StatelessWidget {
final ArticleEntity article;
  const HomeArticalImageVertical({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return    ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        article.urlToImage ?? "",
        height: 80,
        width: 80,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 80,
            width: 80,
            color: Colors.grey[300],
            child: const Icon(Icons.error),
          );
        },
      ),
    );
  }
}
