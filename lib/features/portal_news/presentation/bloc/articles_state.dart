part of 'articles_bloc.dart';

@immutable
// Clase base para los estados relacionados con los artículos
sealed class ArticlesState {}

// Estado inicial de los artículos
final class ArticlesInitial extends ArticlesState {}

// Estado de carga de los artículos
final class ArticlesLoading extends ArticlesState {}

// Estado de fallo al cargar los artículos
final class ArticlesFailure extends ArticlesState {
  final String error; // Mensaje de error

  ArticlesFailure(this.error);
}

// Estado de éxito al cargar los artículos
final class ArticlesSuccess extends ArticlesState {
  final List<Article> articles; // Lista de artículos

  ArticlesSuccess(this.articles);
}
