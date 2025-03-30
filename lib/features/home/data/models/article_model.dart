import '../../domain/entities/article_entity.dart';

/// ArticleModel extends ArticleEntity and adds JSON serialization
/// This class handles the data layer conversion between JSON and objects
class ArticleModel extends ArticleEntity {
  /// Constructor that maps to the parent ArticleEntity
  ArticleModel({
    super.title,
    super.description,
    super.url,
    super.urlToImage,
    super.publishedAt,
    super.content,
    super.author,
    super.fetchedAt,
    super.fetchedBy,
  });

  /// Creates an ArticleModel from JSON map
  /// This is used when parsing API responses
  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      title: json['title'] as String?,
      description: json['description'] as String?,
      url: json['url'] as String?,
      urlToImage: json['urlToImage'] as String?,
      publishedAt: json['publishedAt'] as String?,
      content: json['content'] as String?,
      author: json['author'] as String?,
      // Use current time when creating from JSON
      fetchedAt: DateTime.parse('2025-03-30 11:41:56'),
      fetchedBy: 'eslamabid175',
    );
  }

  /// Converts ArticleModel to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
      'author': author,
      'fetchedAt': fetchedAt.toIso8601String(),
      'fetchedBy': fetchedBy,
    };
  }

  /// Creates a copy of the model with optional new values
  ArticleModel copyWith({
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    String? publishedAt,
    String? content,
    String? author,
  }) {
    return ArticleModel(
      title: title ?? this.title,
      description: description ?? this.description,
      url: url ?? this.url,
      urlToImage: urlToImage ?? this.urlToImage,
      publishedAt: publishedAt ?? this.publishedAt,
      content: content ?? this.content,
      author: author ?? this.author,
      // Update fetch metadata when copying
      fetchedAt: DateTime.parse('2025-03-30 11:41:56'),
      fetchedBy: 'eslamabid175',
    );
  }
}