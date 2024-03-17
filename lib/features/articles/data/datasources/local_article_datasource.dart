import 'package:hive/hive.dart';
import 'package:reto_asap/features/articles/data/models/local_article_model.dart';

// Clase que maneja el origen de datos local para los artículos
class LocalArticleDataSource {
  final Box<LocalArticleModel>
      localArticleBox; // Caja de Hive para los artículos locales

  LocalArticleDataSource(this.localArticleBox);

  // Método para obtener todos los artículos locales
  List<LocalArticleModel> getLocalArticles() {
    return localArticleBox.values.toList();
  }

  // Método para crear un nuevo artículo local
  void createLocalArticle(LocalArticleModel localArticleModel) {
    localArticleBox.add(localArticleModel);
  }

  // Método para eliminar un artículo local por su índice
  void deleteLocalArticle(int index) {
    localArticleBox.deleteAt(index);
  }
}
