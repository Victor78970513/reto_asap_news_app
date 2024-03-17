import 'package:reto_asap/features/articles/domain/entities/local_article.dart';
import 'package:reto_asap/features/articles/domain/repositories/article_local_repository.dart';

// Caso de uso para obtener todos los artículos locales
class GetLocalArticles {
  final LocalArticleRepository localArticleRepository;

  GetLocalArticles(this.localArticleRepository);

  // Método para obtener todos los artículos locales
  Future<List<LocalArticle>> call() {
    // Llama al método en el repositorio para obtener todos los artículos locales
    return localArticleRepository.getLocalArticles();
  }
}
