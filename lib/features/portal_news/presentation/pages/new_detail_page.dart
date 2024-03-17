import 'package:flutter/material.dart';
import 'package:reto_asap/features/portal_news/domain/entities/article.dart';

class NewDetailPage extends StatelessWidget {
  final Article article;
  const NewDetailPage({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Details Page",
                style: TextStyle(color: Colors.red))),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                          image: NetworkImage(article.imageUrl))),
                ),
                const SizedBox(height: 10),
                Text(
                  article.title,
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
                      article.autor,
                      style: const TextStyle(fontSize: 15),
                    ),
                    const Spacer(),
                    Text(
                      article.updatedAt.substring(0, 10),
                      style: const TextStyle(
                          color: Color(0xffFF9900), fontSize: 15),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                Text("${article.content}  ${article.description}"),
                Text("${article.content}  ${article.description}"),
              ],
            ),
          ),
        ));
  }
}
