import 'package:flutter/material.dart';
import '../widgets/details_description.dart';
import '../widgets/details_title.dart';
import '../widgets/details_top_image.dart';
import '../widgets/top_row_icons.dart';


class NewsItemDetails extends StatelessWidget {
  const NewsItemDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Stack(
              children: [
                TopImage(imageUrl: 'https://picsum.photos/id/1019/800/600'),
                TopIconsRow(
                  onBackPressed: () => Navigator.pop(context),
                  onFavoritePressed: () {},
                ),
                TitleSection(
                  title: "This is title",
                  author: "Author Name",
                  publishDate: "Published May 13, 2020",
                ),
                DescriptionSection(
                  description:
                  "Published May 13, 2020 and this is a description. Published May 13, 2020 and this is a description. Published May 13, 2020 and this is a description. Published May 13, 2020 and this is a description. Published May 13, 2020 and this is a description.",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}