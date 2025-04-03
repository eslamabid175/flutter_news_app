// Import Flutter's material design library
import 'package:flutter/material.dart';
// Import custom app bar widget
import 'package:flutter_news_app_api/core/widgets/custom_tob_appbar.dart';
// Import tab bar controller widget
import 'package:flutter_news_app_api/features/home/presentation/view/widgets/home_tabbar_controller.dart';

// Import app colors
import '../../../../../core/themeing/app_colors.dart';
// Import article entity for type definitions
// Import custom widgets for home screen
import '../widgets/home_carousel_with_indicator_with5networkimages.dart';

// HomeScreen widget definition - Stateless because it doesn't manage its own state
class HomeScreen extends StatelessWidget {
  // Constructor with optional key parameter
  HomeScreen({super.key});

  // Build method to create the widget tree
  @override
  Widget build(BuildContext context) {
    // Scaffold provides the basic material design visual layout structure
    return Scaffold(
      // Set background color using predefined colors
      backgroundColor: AppColors.scaffolddarkbgcolor,
      // SafeArea prevents content from being hidden by system UI (notches, status bars)
      body: SafeArea(
        // SingleChildScrollView allows content to be scrollable
        child: SingleChildScrollView(
          // Padding adds horizontal space around content
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            // Column arranges children vertically
            child: Column(
              children: [
                // Add vertical spacing
                const SizedBox(height: 10),
                // Custom app bar at the top
                CustomTobAppbar(),
                // More vertical spacing
                SizedBox(height: 20),
                // Carousel slider with indicators
                CarouselWithIndicator(),
                // Tab bar for different news categories
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