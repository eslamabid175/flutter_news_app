import 'package:flutter_news_app_api/core/utils/constants.dart';
// Utility class for handling all date-related operations
class DateFormatter {
  // Private constructor prevents instantiation
  DateFormatter._();

  /// Converts a date string to a human-readable relative time
  static String getRelativeTime(String? dateStr) {
    // Returns 'No date' if input is null
    if (dateStr == null) return 'No date';

    try {
      // Parse the input string to DateTime
      final date = DateTime.parse(dateStr);
      final now = AppConstants.currentTime;
      // Calculate time difference between now and the date
      final difference = now.difference(date);

      // Convert difference to appropriate format based on time elapsed
      if (difference.inDays > 7) {
        // For dates older than a week, show full date
        return _formatFullDate(date);
      } else if (difference.inDays > 0) {
        // Show days for 1-7 days ago
        return '${difference.inDays}d ago';
      } else if (difference.inHours > 0) {
        // Show hours for recent dates
        return '${difference.inHours}h ago';
      } else if (difference.inMinutes > 0) {
        // Show minutes for very recent dates
        return '${difference.inMinutes}m ago';
      } else {
        // Show 'Just now' for current minute
        return 'Just now';
      }
    } catch (e) {
      print('Date parsing error: $e');
      return 'Invalid date';
    }
  }

  /// Formats a date to "Month Day, Year" format
  static String _formatFullDate(DateTime date) {
    // Array of month abbreviations
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    // Returns formatted date string
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  /// Converts DateTime to ISO 8601 format
  static String toIso8601String(DateTime date) {
    return date.toUtc().toIso8601String();
  }

  /// Safely parses ISO 8601 string to DateTime
  static DateTime? parseIso8601String(String? dateStr) {
    if (dateStr == null) return null;
    try {
      return DateTime.parse(dateStr);
    } catch (e) {
      print('Error parsing date: $e');
      return null;
    }
  }
}