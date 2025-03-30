
/// This file contains all constant values used throughout the app
/// We keep them here to make it easier to modify them in one place

/// API related constants
class ApiConstants {
  // Private constructor to prevent instantiation
  ApiConstants._();

  // Base URL for the News API
  static const String baseUrl = 'https://newsapi.org/v2';

  // Your API key - In production, this should be stored securely
  static const String apiKey = 'c4d3545084334a5a82dbdfbde50d5549';

  // Available endpoints
  static const String topHeadlines = '/top-headlines';
  static const String everything = '/everything';

  // Default query parameters
  static const String defaultCountry = 'eg';
  static const String defaultLanguage = 'en';
  static const int defaultPageSize = 20;
}

/// Application-wide constants
class AppConstants {
  // Private constructor to prevent instantiation
  AppConstants._();

  // Current user and time information
  // These would typically come from a user session or system
  static const String currentUser = 'eslamabid175';
  static final DateTime currentTime = DateTime.parse('2025-03-30 09:46:22');
  //static final DateTime currentTime = DateTime.parse('2025-03-30 09:46:22');

  // Cache duration settings
  static const Duration cacheValidityDuration = Duration(hours: 1);
  static const Duration refreshInterval = Duration(minutes: 5);

  // API timeout settings
  static const int connectionTimeoutInMs = 30000; // 30 seconds
  static const int receiveTimeoutInMs = 30000;    // 30 seconds

  // Local Storage Keys
  static const String cachedArticlesKey = 'CACHED_ARTICLES';
  static const String userPreferencesKey = 'USER_PREFERENCES';
  static const String lastUpdateTimeKey = 'LAST_UPDATE_TIME';

  // Pagination settings
  static const int itemsPerPage = 20;
  static const int maxSearchResults = 100;
}

/// Navigation route names
class Routes {
  // Private constructor to prevent instantiation
  Routes._();

  static const String home = '/';
  static const String articleDetails = '/article-details';
  static const String search = '/search';
  static const String settings = '/settings';
}

/// Error Messages
class ErrorMessages {
  // Private constructor to prevent instantiation
  ErrorMessages._();

  static const String noInternet = 'No internet connection. Please check your network.';
  static const String serverError = 'Server error occurred. Please try again.';
  static const String cacheError = 'Could not load cached data.';
  static const String generalError = 'Something went wrong. Please try again.';
}