// Import Equatable for value comparison
import 'package:equatable/equatable.dart';

// Base entity class for articles
// Extends Equatable for value equality comparison
class Article extends Equatable {
  // Class fields with documentation
  /// The headline or title of the article
  final String title;

  /// A description or snippet from the article
  final String description;

  /// The direct URL to the article
  final String url;

  /// The URL to a relevant image for the article
  final String urlToImage;

  /// The date and time the article was published
  final String publishedAt;

  /// The unformatted content of the article
  final String content;

  // Constructor requiring all fields
  // const constructor for improved performance
  const Article({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  // Override props for Equatable
  // Defines which fields are used for equality comparison
  @override
  List<Object?> get props => [
    title,
    description,
    url,
    urlToImage,
    publishedAt,
    content,
  ];
}