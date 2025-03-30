import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/themeing/app_colors.dart';
import '../../../../../core/themeing/app_text_styles.dart';

class HomeArticleReadmorebtn extends StatelessWidget {
  const HomeArticleReadmorebtn({super.key});

  @override
  Widget build(BuildContext context) {
    return   GestureDetector(
        onTap: () {},
        child: Row(
          children: [
            Icon(Icons.book, color: AppColors.whiteColor, size: 16),

            const SizedBox(width: 4),
            Text(
              'Read More',
              style: AppTextStyles.font12requlargreyDark.copyWith(
                color: AppColors.whiteColor,
              ),
            ),
          ],
        ),
      );

  }
}
