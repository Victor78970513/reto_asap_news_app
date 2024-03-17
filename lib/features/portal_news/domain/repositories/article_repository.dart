import 'package:dartz/dartz.dart';
import 'package:reto_asap/core/error/failures.dart';
import 'package:reto_asap/features/portal_news/domain/entities/article.dart';

// Interfaz abstracta para el repositorio de artículos
abstract interface class ArticleRepository {
  // Método para obtener una lista de artículos paginados
  Future<Either<Failure, List<Article>>> getArticles(
      {required int pageSize, required int page});
}
