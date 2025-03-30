import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/themeing/app_text_styles.dart';

class HomeHeaderRowSectionnameViewallbtn extends StatelessWidget {
  final String sectionName;
  final VoidCallback onViewAllPressed;

  const HomeHeaderRowSectionnameViewallbtn(
      {super.key, required this.sectionName, required this.onViewAllPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            sectionName,
            style: AppTextStyles.font18SemiBoldwhite,
          ),
          TextButton(
            onPressed: onViewAllPressed,
            child: const Text('View All'),
          ),
        ],
      ),
    );

  }
}
