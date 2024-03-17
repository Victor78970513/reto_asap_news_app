import 'package:dio/dio.dart';
import 'package:reto_asap/core/error/exceptions.dart';
import 'package:reto_asap/features/portal_news/data/models/article_model.dart';

// Interfaz abstracta para el origen de datos remoto de los artículos
abstract interface class ArticleRemoteDataSource {
  Future<List<ArticleModel>> getAllArticles(
      {required int pageSize, required int page});
}

// Implementación del origen de datos remoto de los artículos
class ArticleRemoteDataSourceImpl implements ArticleRemoteDataSource {
  final Dio dio;

  ArticleRemoteDataSourceImpl(this.dio);

  @override
  Future<List<ArticleModel>> getAllArticles(
      {required int pageSize, required int page}) async {
    try {
      final List<ArticleModel> articlesList = [];

      // Realiza una solicitud HTTP GET para obtener los artículos
      final response = await dio.get(
          "https://newsapi.org/v2/everything?q=tesla&apiKey=d76361b6236b4f029ff430321e86ce08&pageSize=$pageSize&page=$page");

      // Itera sobre los artículos en la respuesta y los convierte en modelos de artículo
      for (var article in response.data['articles']) {
        articlesList.add(ArticleModel.fromJson(article));
      }

      // Devuelve la lista de modelos de artículo
      return articlesList;
    } catch (e) {
      // Si ocurre un error, lanza una excepción de servidor con el mensaje de error
      throw ServerException(e.toString());
    }
  }
}
