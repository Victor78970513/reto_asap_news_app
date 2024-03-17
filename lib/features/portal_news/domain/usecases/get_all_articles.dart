import 'package:dartz/dartz.dart';
import 'package:reto_asap/core/error/failures.dart';
import 'package:reto_asap/core/usecase/use_case.dart';
import 'package:reto_asap/features/portal_news/domain/entities/article.dart';
import 'package:reto_asap/features/portal_news/domain/repositories/article_repository.dart';

// UseCase para obtener todos los artículos
class GetAllArticles implements UseCase<List<Article>, GetAllArticlesParams> {
  final ArticleRepository articleRepository;

  GetAllArticles(this.articleRepository);

  // Método call, que realiza la lógica del caso de uso
  @override
  Future<Either<Failure, List<Article>>> call(
      GetAllArticlesParams params) async {
    // Llama al método getArticles del repositorio de artículos
    return await articleRepository.getArticles(
        pageSize: params.pageSize, page: params.page);
  }
}

// Parámetros necesarios para el caso de uso GetAllArticles
class GetAllArticlesParams {
  final int pageSize; // Tamaño de la página
  final int page; // Número de página
  GetAllArticlesParams({required this.pageSize, required this.page});
}
