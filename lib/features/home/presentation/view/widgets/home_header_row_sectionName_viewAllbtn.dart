import 'package:flutter/material.dart';

import '../../../../../core/themeing/app_text_styles.dart';
class HomeHeaderRowSectionnameViewallbtn extends StatelessWidget {
  final String sectionName;
  final VoidCallback onViewAllPressed;

  const HomeHeaderRowSectionnameViewallbtn({
    super.key,
    required this.sectionName,
    required this.onViewAllPressed
  });

  @override
  Widget build(BuildContext context) {
    // Padding widget chosen for consistent spacing
    return Padding(
      padding: const EdgeInsets.all(16.0),
      // Row chosen for horizontal layout because:
      // 1. Simple arrangement of title and button
      // 2. MainAxisAlignment.spaceBetween for proper spacing
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            sectionName,
            style: AppTextStyles.font18SemiBoldwhite,
          ),
          // TextButton chosen over FlatButton because:
          // 1. More modern API
          // 2. Better default styling
          TextButton(
            onPressed: onViewAllPressed,
            child: const Text('View All'),
          ),
        ],
      ),
    );
  }
}