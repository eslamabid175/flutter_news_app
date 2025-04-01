import 'package:flutter/material.dart';

class TopIconsRow extends StatelessWidget {
  final VoidCallback onBackPressed;
  final VoidCallback onFavoritePressed;
  final bool isFavorite;
  static const currentTime = '2025-04-01 20:38:33';
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
    return Positioned(
      top: MediaQuery.of(context).padding.top,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: onBackPressed,
            ),
            IconButton(
              icon: Icon(
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