import 'package:flutter/material.dart';
import 'package:flutter_news_app_api/core/themeing/app_text_styles.dart';

class TitleSection extends StatelessWidget {
  final String title;
  final String author;
  final String publishDate;

  const TitleSection({
    super.key,
    required this.title,
    required this.author,
    required this.publishDate,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.all(16),
        height: MediaQuery.sizeOf(context).height / 2,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.86),
              Colors.black,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: AppTextStyles.font23Boldwhite,
            ),
            Row(
              children: [
                Text(
                  "By: ",
                  style: AppTextStyles.font12reqularwhite,
                ),
                Text(
                  author,
                  style: AppTextStyles.font12SemiBoldgreen.copyWith(
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Divider(color: Colors.white, thickness: 0.5),
            Text(
              publishDate,
              style: AppTextStyles.font12reqularwhite,
            ),
          ],
        ),
      ),
    );
  }
}