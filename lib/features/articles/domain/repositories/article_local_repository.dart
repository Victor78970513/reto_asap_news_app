import 'package:reto_asap/features/articles/domain/entities/local_article.dart';

// Interfaz abstracta que define las operaciones que deben implementar los repositorios de artículos locales
abstract interface class LocalArticleRepository {
  // Método para obtener todos los artículos locales
  Future<List<LocalArticle>> getLocalArticles();

  // Método para crear un nuevo artículo local
  Future<void> createLocalArticle(LocalArticle localArticle);

  // Método para eliminar un artículo local por su índice
  Future<void> deleteLocalArticle(int localArticleIndex);
}
