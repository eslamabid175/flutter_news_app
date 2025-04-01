import 'package:flutter/material.dart';
import 'package:flutter_news_app_api/features/home/data/models/article_model.dart';

import '../screens/article_details_screen.dart';

class ArticleListItem extends StatelessWidget {
  final ArticleModel article;

  const ArticleListItem({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: article.urlToImage != null
            ? Image.network(article.urlToImage, width: 100, fit: BoxFit.cover)
            : const SizedBox.shrink(),
        title: Text(
          article.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(article.description ?? ''),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleDetailScreen(article: article),
            ),
          );
        },
      ),
    );
  }
}