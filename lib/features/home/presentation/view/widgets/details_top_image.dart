import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
class TopImage extends StatelessWidget {
  final String imageUrl;
  final Function(String)? onError;

  const TopImage({
    super.key,
    required this.imageUrl,
    this.onError,
  });

  @override
  Widget build(BuildContext context) {
    // SizedBox used for fixed dimensions
    // Preferred over Container for simple size constraints
    return SizedBox(
      // Responsive height based on screen size
      height: MediaQuery.of(context).size.height * 0.4,
      width: double.infinity,
      // CachedNetworkImage chosen over Image.network for:
      // 1. Built-in caching
      // 2. Better loading states
      // 3. Improved performance for repeated images
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        // Error handling with custom callback
        errorWidget: (context, url, error) {
          if (onError != null) onError!(error.toString());
          return Container(
            color: Colors.grey[300],
            child: const Icon(Icons.error_outline, size: 50),
          );
        },
        // Loading placeholder
        placeholder: (context, url) => Container(
          color: Colors.grey[300],
          child: const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}