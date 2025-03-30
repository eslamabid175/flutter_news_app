import 'package:flutter_news_app_api/core/utils/constants.dart';
/// Utility class for handling date formatting throughout the app
class DateFormatter {
  // Private constructor to prevent instantiation
  DateFormatter._();

  /// Formats a date string to a relative time string (e.g., "2 hours ago")
  static String getRelativeTime(String? dateStr) {
    if (dateStr == null) return 'No date';

    try {
      final date = DateTime.parse(dateStr);
      final now = AppConstants.currentTime;
      final difference = now.difference(date);

      if (difference.inDays > 7) {
        return _formatFullDate(date);
      } else if (difference.inDays > 0) {
        return '${difference.inDays}d ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours}h ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes}m ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      print('Date parsing error: $e');
      return 'Invalid date';
    }
  }

  /// Formats a DateTime to a full date string
  static String _formatFullDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];

    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  /// Formats a DateTime to ISO 8601 string
  static String toIso8601String(DateTime date) {
    return date.toUtc().toIso8601String();
  }

  /// Parses an ISO 8601 string to DateTime
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