import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app_api/features/home/domain/entities/article_entity.dart';
// Handles vertical image display in article cards
class HomeArticalImageVertical extends StatelessWidget {
  final Article article;

  // Const constructor for better performance
  const HomeArticalImageVertical({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    // ClipRRect chosen over Container with decoration because:
    // 1. Better performance for image clipping
    // 2. More efficient memory usage
    // 3. Smoother rendering of rounded corners
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      // Image.network chosen over CachedNetworkImage because:
      // 1. Simpler implementation for basic needs
      // 2. Built-in error handling
      child: Image.network(
        article.urlToImage, // Null safety handling
        // Fixed dimensions for consistency and performance
        height: 80,
        width: 80,
        // BoxFit.cover chosen to:
        // 1. Maintain aspect ratio
        // 2. Fill available space without distortion
        fit: BoxFit.cover,
        // Error handling with fallback UI
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 80,
            width: 80,
            color: Colors.grey[300], // Light grey for error state
            child: const Icon(Icons.error),
          );
        },
      ),
    );
  }
}