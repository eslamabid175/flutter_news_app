import 'package:flutter/material.dart';

class TopIconsRow extends StatelessWidget {
  final VoidCallback onBackPressed;
  final VoidCallback onFavoritePressed;

  const TopIconsRow({
    super.key,
    required this.onBackPressed,
    required this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: onBackPressed,
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            ),
            IconButton(
              onPressed: onFavoritePressed,
              icon: Icon(Icons.favorite, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}