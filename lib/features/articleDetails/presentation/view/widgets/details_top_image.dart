import 'package:flutter/material.dart';

class TopImage extends StatelessWidget {
  final String imageUrl;

  const TopImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      height: MediaQuery.sizeOf(context).height / 1.8,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }
}