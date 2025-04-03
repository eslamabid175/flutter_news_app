import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselWithIndicator extends StatefulWidget {
  const CarouselWithIndicator({super.key});

  @override
  State<CarouselWithIndicator> createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  // Track current carousel index
  int activeIndex = 0;

  // Logging constants
  static const String currentTime = '2025-04-03 13:06:18';
  static const String currentUser = 'eslamabid175';

  // List of actual news images with their titles
  final List<Map<String, String>> newsItems = [
    {
      'image': 'https://images.unsplash.com/photo-1585829365295-ab7cd400c167?ixlib=rb-4.0.3',
      'title': 'Breaking News: Technology Summit 2025'
    },
    {
      'image': 'https://images.unsplash.com/photo-1504711434969-e33886168f5c?ixlib=rb-4.0.3',
      'title': 'Global Climate Conference'
    },
    {
      'image': 'https://images.unsplash.com/photo-1557992260-ec58e38d363c?ixlib=rb-4.0.3',
      'title': 'Sports: World Cup Finals'
    },
    {
      'image': 'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?ixlib=rb-4.0.3',
      'title': 'Business: Stock Market Update'
    },
    {
      'image': 'https://images.unsplash.com/photo-1576086213369-97a306d36557?ixlib=rb-4.0.3',
      'title': 'Health: Medical Breakthrough'
    }
  ];

  @override
  Widget build(BuildContext context) {
    print('$currentTime - $currentUser: Building CarouselWithIndicator');

    return Stack(
      alignment: Alignment.center,
      children: [
        CarouselSlider.builder(
          itemCount: newsItems.length,
          itemBuilder: (context, index, realIndex) {
            print('$currentTime - $currentUser: Building carousel item $index');

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Image with rounded corners
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      newsItems[index]['image']!,
                      fit: BoxFit.cover,
                      // Error handling and loading states
                      errorBuilder: (context, error, stackTrace) {
                        print('$currentTime - $currentUser: Error loading image: $error');
                        return Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.error_outline, size: 40),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: Colors.grey[200],
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                    ),
                  ),
                  // Title overlay with gradient background
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.8),
                            Colors.transparent,
                          ],
                        ),
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(15),
                        ),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        newsItems[index]['title']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              offset: Offset(1, 1),
                              blurRadius: 2,
                              color: Colors.black,
                            ),
                          ],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          options: CarouselOptions(
            height: 200.0,
            viewportFraction: 0.9,
            aspectRatio: 16/9,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                activeIndex = index;
                print('$currentTime - $currentUser: Carousel page changed to $index');
              });
            },
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 1200),
            autoPlayCurve: Curves.fastOutSlowIn,
          ),
        ),

        // Page indicator
        Positioned(
          bottom: 20,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: AnimatedSmoothIndicator(
              activeIndex: activeIndex,
              count: newsItems.length,
              effect: const SwapEffect(
                spacing: 8.0,
                radius: 5.0,
                dotWidth: 8.0,
                dotHeight: 8.0,
                paintStyle: PaintingStyle.fill,
                dotColor: Colors.grey,
                activeDotColor: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}