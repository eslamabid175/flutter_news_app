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
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      width: double.infinity,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) {
          if (onError != null) onError!(error.toString());
          return Container(
            color: Colors.grey[300],
            child: const Icon(Icons.error_outline, size: 50),
          );
        },
        placeholder: (context, url) => Container(
          color: Colors.grey[300],
          child: const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}