part of 'local_article_bloc.dart';

@immutable
sealed class LocalArticleEvent {}

// Evento para crear un nuevo artículo local
final class OnCreateLocalArticle extends LocalArticleEvent {
  final LocalArticle article; // Artículo a crear

  OnCreateLocalArticle({required this.article}); // Constructor
}

// Evento para eliminar un artículo local por su índice
final class OnDeleteLocalArticle extends LocalArticleEvent {
  final int index; // Índice del artículo a eliminar

  OnDeleteLocalArticle({required this.index});
}

// Evento para obtener todos los artículos locales
final class OnGetAllLocalArticles extends LocalArticleEvent {}
