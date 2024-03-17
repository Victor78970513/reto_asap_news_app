import 'package:reto_asap/features/articles/data/datasources/local_article_datasource.dart';
import 'package:reto_asap/features/articles/data/models/local_article_model.dart';
import 'package:reto_asap/features/articles/domain/entities/local_article.dart';
import 'package:reto_asap/features/articles/domain/repositories/article_local_repository.dart';

// Implementación concreta del repositorio de artículos locales
class LocalArticleRepositoryImpl implements LocalArticleRepository {
  final LocalArticleDataSource localArticleDataSource; // Origen de datos local

  LocalArticleRepositoryImpl(this.localArticleDataSource);

  @override
  Future<void> createLocalArticle(LocalArticle localArticle) async {
    // Convierte el artículo de entidad a modelo y lo crea en el origen de datos
    final localArticleModel = LocalArticleModel.fromEntity(localArticle);
    localArticleDataSource.createLocalArticle(localArticleModel);
  }

  @override
  Future<void> deleteLocalArticle(int localArticleIndex) async {
    // Elimina el artículo del origen de datos por su índice
    localArticleDataSource.deleteLocalArticle(localArticleIndex);
  }

  @override
  Future<List<LocalArticle>> getLocalArticles() async {
    // Obtiene todos los artículos locales del origen de datos
    final localArticles = localArticleDataSource.getLocalArticles();
    // Convierte los modelos de artículo a entidades y los devuelve como resultado
    final List<LocalArticle> res =
        localArticles.map((model) => model.toEntity()).toList();
    return res;
  }
}
