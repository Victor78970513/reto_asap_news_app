import 'dart:io';

import 'package:flutter/material.dart';
import 'package:reto_asap/features/articles/domain/entities/local_article.dart';

class LocalArticleDetailPage extends StatelessWidget {
  final LocalArticle localArticle;
  const LocalArticleDetailPage({super.key, required this.localArticle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Local Article Detail",
          style: TextStyle(color: Colors.red),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                      image: FileImage(File(localArticle.imageUrl)),
                      fit: BoxFit.cover)),
            ),
            const SizedBox(height: 10),
            Text(
              // article.title,
              localArticle.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.auto_stories_sharp),
                const SizedBox(width: 20),
                Text(
                  // article.autor,
                  localArticle.autor,
                  style: const TextStyle(fontSize: 15),
                ),
                const Spacer(),
                Text(
                  // article.updatedAt.substring(0, 10),
                  (localArticle.updatedAt.toString()).substring(0, 10),
                  style:
                      const TextStyle(color: Color(0xffFF9900), fontSize: 15),
                )
              ],
            ),
            const SizedBox(height: 30),
            Text(localArticle.content),
          ],
        ),
      ),
    );
  }
}
