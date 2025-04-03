import 'package:flutter/material.dart';
import 'package:flutter_news_app_api/features/home/domain/entities/article_entity.dart';

class HomeArticleImage extends StatelessWidget {
  final Article article;
  const HomeArticleImage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    // ClipRRect chosen for image rounding because:
    // 1. Hardware-accelerated clipping
    // 2. Better performance than Container decoration
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.network(
        article.urlToImage,
        height: 150,
        // Double.infinity allows image to fill available width
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          // Fallback container for error states
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