// import 'package:flutter/cupertino.dart';
// import 'package:flutter_news_app_api/features/home/domain/entities/article_entity.dart';
// import 'home_latest_articles_card_horizintal.dart';
//
// class HomeLatestArticlesListviewHorizintal extends StatelessWidget {
//   final List<Article> articles;
//   const HomeLatestArticlesListviewHorizintal({super.key, required this.articles});
//
//   @override
//   Widget build(BuildContext context) {
//     return      SizedBox(
//       height: 260,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: articles.length,
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         itemBuilder: (context, index) {
//           return Container(
//             width: 180,
//             margin: EdgeInsets.symmetric(horizontal: 8),
//             child: HomeArticalCardHorizintal(article: articles[index]),
//           );
//         },
//       ),
//     );
//   }
// }
