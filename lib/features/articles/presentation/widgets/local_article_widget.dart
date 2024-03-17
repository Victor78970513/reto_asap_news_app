import 'dart:io';

import 'package:flutter/material.dart';
import 'package:reto_asap/features/articles/domain/entities/local_article.dart';

class LocalArticleWidget extends StatelessWidget {
  final LocalArticle localArticle;
  const LocalArticleWidget({super.key, required this.localArticle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 270,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.white),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 150,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                child: Image.file(
                  File(localArticle.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              localArticle.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                const Icon(Icons.auto_stories_sharp),
                const SizedBox(width: 20),
                Text(localArticle.autor),
                const Spacer(),
                Text((localArticle.updatedAt.toString()).substring(0, 10))
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                    localArticle.topics.length,
                    (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Chip(
                            label: Text(localArticle.topics[index]),
                            side: const BorderSide(color: Colors.white),
                          ),
                        )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
