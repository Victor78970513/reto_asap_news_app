import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reto_asap/features/articles/domain/entities/local_article.dart';
import 'package:reto_asap/features/articles/domain/usecases/create_local_article.dart';
import 'package:reto_asap/features/articles/domain/usecases/delete_local_article.dart';
import 'package:reto_asap/features/articles/domain/usecases/get_local_articles.dart';

part 'local_article_event.dart';
part 'local_article_state.dart';

// Bloc para gestionar el estado de los artículos locales
class LocalArticleBloc extends Bloc<LocalArticleEvent, LocalArticleState> {
  final GetLocalArticles
      _getLocalArticles; // Caso de uso para obtener artículos locales
  final CreateLocalArticle
      _createLocalArticle; // Caso de uso para crear un artículo local
  final DeleteLocalArticle
      _deleteLocalArticle; // Caso de uso para eliminar un artículo local

  // Constructor que inicializa el Bloc con los casos de uso necesarios
  LocalArticleBloc({
    required GetLocalArticles getLocalArticles,
    required CreateLocalArticle createLocalArticle,
    required DeleteLocalArticle deleteLocalArticle,
  })  : _getLocalArticles = getLocalArticles,
        _createLocalArticle = createLocalArticle,
        _deleteLocalArticle = deleteLocalArticle,
        super(LocalArticleInitial()) {
    // Define las acciones a tomar en función de los eventos recibidos
    on<OnGetAllLocalArticles>(_onGetAllLocalArticles);
    on<OnCreateLocalArticle>(_onCreateLocalArticle);
    on<OnDeleteLocalArticle>(_onDeleteLocalArticle);
  }

  // Método para cargar todos los artículos locales
  void _onGetAllLocalArticles(
      OnGetAllLocalArticles event, Emitter<LocalArticleState> emit) async {
    // Llama al caso de uso para obtener todos los artículos locales
    final res = await _getLocalArticles();
    // Emite el estado de los artículos cargados
    emit(LocalArticlesLoaded(res));
  }

  // Método para crear un nuevo artículo local
  void _onCreateLocalArticle(
      OnCreateLocalArticle event, Emitter<LocalArticleState> emit) async {
    // Llama al caso de uso para crear un nuevo artículo local
    await _createLocalArticle(event.article);
    // Emite el estado de carga local
    emit(LoadingLocal());
    // Simula un retraso antes de cargar de nuevo todos los artículos locales
    await Future.delayed(Duration(milliseconds: 1000));
    // Dispara el evento para cargar todos los artículos locales después de crear uno nuevo
    add(OnGetAllLocalArticles());
  }

  // Método para eliminar un artículo local
  void _onDeleteLocalArticle(
      OnDeleteLocalArticle event, Emitter<LocalArticleState> emit) async {
    // Llama al caso de uso para eliminar un artículo local
    await _deleteLocalArticle(event.index);
    // Emite el estado de carga local
    emit(LoadingLocal());
    // Simula un retraso antes de cargar de nuevo todos los artículos locales
    await Future.delayed(Duration(milliseconds: 1000));
    // Dispara el evento para cargar todos los artículos locales después de eliminar uno
    add(OnGetAllLocalArticles());
  }
}
