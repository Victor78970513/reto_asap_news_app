import 'package:reto_asap/features/articles/domain/repositories/article_local_repository.dart';

// Caso de uso para eliminar un artículo local
class DeleteLocalArticle {
  final LocalArticleRepository localArticleRepository;

  DeleteLocalArticle(this.localArticleRepository);

  // Método para eliminar un artículo local
  Future<void> call(int localArticleIndex) {
    // Llama al método en el repositorio para eliminar el artículo local
    return localArticleRepository.deleteLocalArticle(localArticleIndex);
  }
}
