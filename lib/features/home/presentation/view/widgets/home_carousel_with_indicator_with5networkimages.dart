import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselWithIndicator extends StatefulWidget {
  const CarouselWithIndicator({super.key});

  @override
  State<CarouselWithIndicator> createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int activeIndex = 0;
  final List<String> imgList = List.filled(5, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLat8bZvhXD3ChSXyzGsFVh6qgplm1KhYPKA&s');

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Carousel Slider
        CarouselSlider.builder(
          itemCount: imgList.length,
          itemBuilder: (context, index, realIndex) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15), // Rounded corners
                child: Image.network(
                  imgList[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
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
              });
            },
            autoPlay: true,
             autoPlayInterval: const Duration(seconds: 3),
             autoPlayAnimationDuration: const Duration(milliseconds: 1200),
            autoPlayCurve: Curves.fastOutSlowIn,
          ),
        ),

        // Page Indicator
        Positioned(
          bottom: 10,
          child: AnimatedSmoothIndicator(
            activeIndex: activeIndex,
            count: imgList.length,
            effect: const SwapEffect(
              spacing: 8.0,
              radius: 5.0,
              dotWidth: 8.0,
              dotHeight: 8.0,
              paintStyle: PaintingStyle.fill,
              dotColor: Colors.grey,
              activeDotColor: Colors.green,
            ),
          ),
        ),
      ],
    );
  }
}