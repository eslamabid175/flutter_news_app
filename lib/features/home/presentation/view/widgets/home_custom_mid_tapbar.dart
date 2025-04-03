import 'package:flutter/material.dart';
class CustomTabBar extends StatefulWidget {
  // StatefulWidget chosen because:
  // 1. Needs to maintain selected tab state
  // 2. Requires UI updates on selection changes
  const CustomTabBar({super.key});

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  // Track selected tab index
  int selectedIndex = 0;

  // Static list of tab items for maintainability
  final List<String> tabItems = ['Home', 'Search', 'Profile', 'Settings'];

  @override
  Widget build(BuildContext context) {
    // Container used for overall tab bar styling
    // Preferred over DecoratedBox for padding and margin support
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey[700],
        borderRadius: BorderRadius.circular(25), // Rounded corners
      ),
      // Row for horizontal tab arrangement
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // List.generate used for dynamic tab creation
        children: List.generate(
          tabItems.length,
              (index) => Expanded(
            // Expanded ensures equal width distribution
            child: GestureDetector(
              // GestureDetector chosen over InkWell for:
              // 1. No ripple effect needed
              // 2. Better performance
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  // Dynamic color based on selection
                  color: selectedIndex == index ? Colors.black : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  tabItems[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: selectedIndex == index ? Colors.white : Colors.black,
                    fontWeight: selectedIndex == index ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}