import 'package:flutter/material.dart';
import 'package:flutter_news_app_api/core/themeing/app_text_styles.dart';

class DescriptionSection extends StatelessWidget {
  final String description;

  const DescriptionSection({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: MediaQuery.sizeOf(context).height / 2.5,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Text(
              description,
              style: AppTextStyles.font18SemiBoldwhite,
            ),
          ],
        ),
      ),
    );
  }
}