import 'package:reto_asap/features/articles/domain/entities/local_article.dart';
import 'package:reto_asap/features/articles/domain/repositories/article_local_repository.dart';

// Caso de uso para crear un artículo local
class CreateLocalArticle {
  final LocalArticleRepository localArticleRepository;

  CreateLocalArticle(this.localArticleRepository);

  // Método para crear un artículo local
  Future<void> call(LocalArticle localArticle) {
    // Llama al método en el repositorio para crear un artículo local
    return localArticleRepository.createLocalArticle(localArticle);
  }
}
