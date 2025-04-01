import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DescriptionSection extends StatelessWidget {
  final String description;
  final String content;
  final String url;
  static const currentTime = '2025-04-01 20:38:33';
  static const currentUser = 'eslamabid175';

  const DescriptionSection({
    super.key,
    required this.description,
    required this.content,
    required this.url,
  });

  Future<void> _launchURL(BuildContext context) async {
    try {
      print('$currentTime - $currentUser: Attempting to launch URL: $url');
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        print('$currentTime - $currentUser: Could not launch URL: $url');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not open article URL'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('$currentTime - $currentUser: Error launching URL: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error opening article: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.55,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              content,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _launchURL(context),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Read Full Article'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}