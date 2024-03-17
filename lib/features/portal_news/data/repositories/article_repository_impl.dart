import 'package:dartz/dartz.dart';
import 'package:reto_asap/core/error/exceptions.dart';
import 'package:reto_asap/core/error/failures.dart';
import 'package:reto_asap/core/network/connection_checker.dart';
import 'package:reto_asap/features/portal_news/data/datasources/article_remote_data_source.dart';
import 'package:reto_asap/features/portal_news/domain/entities/article.dart';
import 'package:reto_asap/features/portal_news/domain/repositories/article_repository.dart';

// Implementación concreta del repositorio de artículos
class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteDataSource articleRemoteDataSource;
  final ConnectionChecker connectionChecker;

  ArticleRepositoryImpl(this.articleRemoteDataSource, this.connectionChecker);

  @override
  Future<Either<Failure, List<Article>>> getArticles(
      {required int pageSize, required int page}) async {
    try {
      // Verifica si hay conexión a Internet
      if (!await (connectionChecker.isConnected)) {
        // Si no hay conexión, devuelve un error de fallo
        return left(Failure('No internet Connection'));
      }
      // Obtiene los artículos del origen de datos remoto
      final articles = await articleRemoteDataSource.getAllArticles(
          page: page, pageSize: pageSize);
      // Devuelve los artículos como un éxito derecho
      return right(articles);
    } on ServerException catch (e) {
      // Si ocurre una excepción en el servidor, devuelve un error de fallo con el mensaje de la excepción
      return left(Failure(e.message));
    }
  }
}
