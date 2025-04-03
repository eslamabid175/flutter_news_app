import 'package:flutter/material.dart';

import '../themeing/app_text_styles.dart';

class CustomTobAppbar extends StatelessWidget {
  const CustomTobAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hello Eslam", style: AppTextStyles.font18SemiBoldwhite),
            SizedBox(height: 5),
            Text("Welcome Back", style: AppTextStyles.font12requlargreyDark),
          ],
        ),
        CircleAvatar(
          radius: 25,
          child: Image.asset("assets/icons/user.png", height: 45, width: 45),
        ),
      ],
    );
  }
}
