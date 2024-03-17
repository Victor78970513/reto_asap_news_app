part of 'local_article_bloc.dart';

@immutable
sealed class LocalArticleState {}

// Estado inicial del Bloc de artículos locales
final class LocalArticleInitial extends LocalArticleState {}

// Estado de carga local, indica que se está realizando alguna operación en los datos locales
final class LoadingLocal extends LocalArticleState {}

// Estado que representa la carga exitosa de los artículos locales, contiene la lista de artículos locales cargados
final class LocalArticlesLoaded extends LocalArticleState {
  final List<LocalArticle> localArticles; // Lista de artículos locales cargados

  LocalArticlesLoaded(this.localArticles);
}
