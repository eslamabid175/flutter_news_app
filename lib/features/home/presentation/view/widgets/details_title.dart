import 'package:flutter/material.dart';
class TitleSection extends StatelessWidget {
  // Required text content
  final String title;
  final String author;
  final String description;
  final String publishDate;

  // Logging constants
  static const currentTime = '2025-04-03 12:49:17';
  static const currentUser = 'eslamabid175';

  const TitleSection({
    super.key,
    required this.title,
    required this.author,
    required this.description,
    required this.publishDate,
  });

  @override
  Widget build(BuildContext context) {
    print('$currentTime - $currentUser: Building TitleSection');

    // Positioned for overlay effect on image
    return Positioned(
      // Calculate position based on screen height
      top: MediaQuery.of(context).size.height * 0.35,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(20),
        // Decoration for material card effect
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        // Column for vertical content layout
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title with theme-aware styling
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            // Description
            Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            // Metadata row (author and date)
            Row(
              children: [
                Text(
                  author,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 8),
                // Bullet separator
                Text(
                  '•',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  publishDate,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}