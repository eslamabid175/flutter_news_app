
/// Application-wide constants
class AppConstants {
  const AppConstants._();

  // Current user and time information
  static const String currentUser = 'eslamabid175';
  static final DateTime currentTime = DateTime.parse('2025-03-30 12:21:45');

  // API Configuration
  static const String baseUrl = 'https://newsapi.org/v2';
  static const String apiKey = 'c4d3545084334a5a82dbdfbde50d5549';

  // API Endpoints
  static const String topHeadlines = '/top-headlines';
  static const String everything = '/everything';

  // Default Parameters
  static const String defaultCountry = 'us';
  static const String defaultLanguage = 'en';
  static const int defaultPageSize = 20;

  // Cache Configuration
  static const Duration cacheValidDuration = Duration(hours: 1);
  static const String cacheKey = 'CACHED_NEWS_DATA';
}

/// Error messages used throughout the app
class ErrorMessages {
  const ErrorMessages._();

  static const String noInternet = 'No internet connection. Please check your network.';
  static const String serverError = 'Server error occurred. Please try again.';
  static const String unexpectedError = 'An unexpected error occurred.';
  static const String cacheError = 'Error retrieving cached data.';
}