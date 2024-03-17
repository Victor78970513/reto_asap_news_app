part of 'articles_bloc.dart';

@immutable
// Clase base para los eventos relacionados con los artículos
sealed class ArticlesEvent {}

// Evento para el primer fetch de artículos
final class OnFirstFetchEvent extends ArticlesEvent {}

// Evento para solicitar todos los artículos
final class FetchAllArticlesEvent extends ArticlesEvent {
  final int pageSize; // Tamaño de la página
  final int page; // Número de página

  FetchAllArticlesEvent({required this.pageSize, required this.page});
}
