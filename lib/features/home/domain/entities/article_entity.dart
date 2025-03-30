import 'package:equatable/equatable.dart';

/// ArticleEntity: The core business object for articles
/// This is a pure domain class that doesn't know about data layer
class ArticleEntity extends Equatable {
  // Basic article properties
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;
  final String? author;

  // Metadata for tracking
  final DateTime fetchedAt;
  final String fetchedBy;

  /// Constructor with named parameters
  /// We store the fetch time and user when the article is created
  ArticleEntity({
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
    this.author,
    DateTime? fetchedAt,  // Make it optional
    String? fetchedBy,    // Make it optional
  })  : fetchedAt = fetchedAt ?? DateTime.parse('2025-03-30 11:41:56'),
        fetchedBy = fetchedBy ?? 'eslamabid175';

  /// Create an empty article with current timestamp
  factory ArticleEntity.empty() => ArticleEntity();

  @override
  List<Object?> get props => [
    title,
    description,
    url,
    urlToImage,
    publishedAt,
    content,
    author,
    fetchedAt,
    fetchedBy,
  ];

  bool get isValid => title != null && url != null;
}