import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reto_asap/features/portal_news/domain/entities/article.dart';
import 'package:reto_asap/features/portal_news/domain/usecases/get_all_articles.dart';

part 'articles_event.dart';
part 'articles_state.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  final GetAllArticles _getAllArticles;
  ArticlesBloc({
    required GetAllArticles getAllArticles,
  })  : _getAllArticles = getAllArticles,
        super(ArticlesInitial()) {
    // Define el comportamiento del bloc para diferentes eventos
    on<OnFirstFetchEvent>((event, emit) => emit(ArticlesLoading()));
    on<FetchAllArticlesEvent>(_fetchAllArticles);
  }

  // Método privado para manejar el evento de obtener todos los artículos
  void _fetchAllArticles(
      FetchAllArticlesEvent event, Emitter<ArticlesState> emit) async {
    // Llama al caso de uso GetAllArticles para obtener los artículos
    final res = await _getAllArticles(
        GetAllArticlesParams(pageSize: event.pageSize, page: event.page));

    // Maneja el resultado del caso de uso
    res.fold(
      // Si hay un error, emite un estado de fallo
      (l) => emit(ArticlesFailure(l.message)),
      // Si tiene éxito, actualiza la lista de artículos y emite un estado de éxito
      (r) {
        final List<Article> currentArticles =
            state is ArticlesSuccess ? (state as ArticlesSuccess).articles : [];
        final List<Article> allArticles = [...currentArticles, ...r];
        emit(ArticlesSuccess(allArticles));
      },
    );
  }
}
