import 'package:flutter/material.dart';
import 'package:reto_asap/features/portal_news/domain/entities/article.dart';

class ArticleWidget extends StatelessWidget {
  final Article article;
  const ArticleWidget({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              width: 95,
              height: 105,
              child: FadeInImage(
                  placeholder: const AssetImage("assets/images/no-image.jpg"),
                  image: NetworkImage(article.imageUrl),
                  fit: BoxFit.cover),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    article.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    const Icon(Icons.auto_stories_sharp),
                    const SizedBox(width: 20),
                    Text(article.autor),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    article.updatedAt.substring(0, 10),
                    style: const TextStyle(
                      color: Color(0xffFF9900),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
