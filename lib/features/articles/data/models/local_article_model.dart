import 'package:hive/hive.dart';
import 'package:reto_asap/features/articles/domain/entities/local_article.dart';

part 'local_article_model.g.dart';

@HiveType(typeId: 0)
class LocalArticleModel {
  @HiveField(0)
  final String autor;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String content;

  @HiveField(3)
  final String imageUrl;

  @HiveField(4)
  final List<String> topics;

  @HiveField(5)
  final DateTime updatedAt;

  LocalArticleModel({
    required this.autor,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.topics,
    required this.updatedAt,
  });

  factory LocalArticleModel.fromEntity(LocalArticle localArticle) =>
      LocalArticleModel(
        autor: localArticle.autor,
        title: localArticle.title,
        content: localArticle.content,
        imageUrl: localArticle.imageUrl,
        topics: localArticle.topics,
        updatedAt: localArticle.updatedAt,
      );

  LocalArticle toEntity() => LocalArticle(
      autor: autor,
      title: title,
      content: content,
      imageUrl: imageUrl,
      topics: topics,
      updatedAt: updatedAt);
}
