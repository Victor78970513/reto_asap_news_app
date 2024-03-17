import 'dart:convert';

import 'package:reto_asap/features/portal_news/domain/entities/article.dart';

class ArticleModel extends Article {
  ArticleModel({
    required super.id,
    required super.autor,
    required super.content,
    required super.description,
    required super.imageUrl,
    required super.title,
    required super.updatedAt,
  });

  factory ArticleModel.fromRawJson(String str) =>
      ArticleModel.fromJson(jsonDecode(str));

  factory ArticleModel.fromJson(Map<String, dynamic> map) {
    return ArticleModel(
      id: map['source']['id'] ?? "no-id",
      autor: map['author'] ?? 'no-autor',
      content: map['content'] ?? "no-content",
      description: map['description'] ?? 'no-description',
      imageUrl: map['urlToImage'] ??
          'https://www.ncenet.com/wp-content/uploads/2020/04/No-image-found.jpg',
      title: map['title'] ?? "no-title",
      updatedAt: map['publishedAt'] ?? "no-date",
    );
  }
}
