// Import the base entity class from domain layer
import '../../domain/entities/article_entity.dart';

// ArticleModel extends Article entity, adding JSON serialization capabilities
class ArticleModel extends Article {
  // Constructor that takes all required fields
  // This maintains consistency with the base Article entity
  ArticleModel({
    required String title,
    required String description,
    required String url,
    required String urlToImage,
    required String publishedAt,
    required String content,
  }) : super(  // Calls the parent (Article) constructor with the provided values
    title: title,
    description: description,
    url: url,
    urlToImage: urlToImage,
    publishedAt: publishedAt,
    content: content,
  );

  // Factory constructor to create an ArticleModel instance from JSON data
  // Used when deserializing data from API or local storage
  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    // Define default values for missing or null fields
    // This ensures the app doesn't crash with incomplete data
    const defaultImage = 'https://via.placeholder.com/600x400?text=No+Image';
    const defaultText = 'Not available';

    // Create and return a new ArticleModel instance
    // Uses null-aware operators (?.) and null coalescing operators (??) for safe access
    return ArticleModel(
      // Convert each JSON field to string, use default if null/missing
      title: json['title']?.toString() ?? defaultText,
      description: json['description']?.toString() ?? defaultText,
      url: json['url']?.toString() ?? '',
      urlToImage: json['urlToImage']?.toString() ?? defaultImage,
      // Use current time as fallback for missing publication date
      publishedAt: json['publishedAt']?.toString() ?? DateTime.now().toIso8601String(),
      content: json['content']?.toString() ?? defaultText,
    );
  }

  // Convert ArticleModel instance to JSON format
  // Used when storing data locally or sending to an API
  Map<String, dynamic> toJson() {
    return {
      'title': title,           // Store article title
      'description': description, // Store article description
      'url': url,               // Store article URL
      'urlToImage': urlToImage,  // Store image URL
      'publishedAt': publishedAt, // Store publication date
      'content': content,        // Store article content
    };
  }
}