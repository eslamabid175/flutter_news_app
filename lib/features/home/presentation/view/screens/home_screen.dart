import 'package:flutter/material.dart';
import 'package:flutter_news_app_api/core/widgets/custom_tob_appbar.dart';
import 'package:flutter_news_app_api/features/home/presentation/view/widgets/home_tabbar_controller.dart';

import '../../../../../core/themeing/app_colors.dart';
import '../../../domain/entities/article_entity.dart';
import '../widgets/home_carousel_with_indicator_with5networkimages.dart';
import '../widgets/home_custom_mid_tapbar.dart';
import '../widgets/home_latest_article_horizintal_section.dart';
import '../widgets/home_latest_stories_vertical_section_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffolddarkbgcolor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(height: 10),
                // Header
                CustomTobAppbar(),
                SizedBox(height: 20),
                // Carousel
                CarouselWithIndicator(),
                // Tab Bar
       HomeTabbarController(),

                // Bottom padding
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
