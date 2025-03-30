import 'package:flutter/cupertino.dart';

import '../../../domain/entities/article_entity.dart';
import 'home_custom_mid_tapbar.dart';
import 'home_latest_article_horizintal_section.dart';
import 'home_latest_stories_vertical_section_widget.dart';

class HomeTabbarController extends StatelessWidget {
  const HomeTabbarController({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTabBar(),
        // Featured Articles Section
        LatestArticleSectionWidget(
          sectionName: 'Latest Articles',
          onViewAllPressed: () {
            print('View all articles pressed');
          },
          articles: ArticleEntity.articles,
        ),

        // Vertical Section
        HomeLatestStoriesVerticalSectionWidget(
          sectionName: "Top Stories",
          onViewAllPressed: () {},
          articles: ArticleEntity.articles,
        ),
      ],
    );
  }
}
