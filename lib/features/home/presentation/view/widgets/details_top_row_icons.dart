import 'package:flutter/material.dart';
class TopIconsRow extends StatelessWidget {
  // Required callbacks and state
  final VoidCallback onBackPressed;
  final VoidCallback onFavoritePressed;
  final bool isFavorite;

  // Constants for logging
  static const currentTime = '2025-04-03 12:49:17';
  static const currentUser = 'eslamabid175';

  const TopIconsRow({
    super.key,
    required this.onBackPressed,
    required this.onFavoritePressed,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    print('$currentTime - $currentUser: Building TopIconsRow, isFavorite: $isFavorite');

    // Positioned widget chosen for:
    // 1. Absolute positioning in Stack
    // 2. Respect system UI (status bar) padding
    return Positioned(
      top: MediaQuery.of(context).padding.top,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        // Row for horizontal layout of icons
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Back button with IconButton for better touch target
            IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: onBackPressed,
            ),
            // Favorite button with dynamic icon
            IconButton(
              icon: Icon(
                // Conditional icon based on favorite state
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.white,
              ),
              onPressed: () {
                print('$currentTime - $currentUser: Favorite button pressed');
                onFavoritePressed();
              },
            ),
          ],
        ),
      ),
    );
  }
}