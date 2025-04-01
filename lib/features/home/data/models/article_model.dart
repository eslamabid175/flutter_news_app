import '../../domain/entities/article_entity.dart';

class ArticleModel extends Article {
  ArticleModel({
    required String title,
    required String description,
    required String url,
    required String urlToImage,
    required String publishedAt,
    required String content,
  }) : super(
    title: title,
    description: description,
    url: url,
    urlToImage: urlToImage,
    publishedAt: publishedAt,
    content: content,
  );

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    // Default values for missing or null fields
    const defaultImage = 'https://via.placeholder.com/600x400?text=No+Image';
    const defaultText = 'Not available';

    return ArticleModel(
      title: json['title']?.toString() ?? defaultText,
      description: json['description']?.toString() ?? defaultText,
      url: json['url']?.toString() ?? '',
      urlToImage: json['urlToImage']?.toString() ?? defaultImage,
      publishedAt: json['publishedAt']?.toString() ?? DateTime.now().toIso8601String(),
      content: json['content']?.toString() ?? defaultText,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
    };
  }
}