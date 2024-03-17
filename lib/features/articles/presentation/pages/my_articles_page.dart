import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reto_asap/core/common/widgets/loader.dart';
import 'package:reto_asap/features/articles/presentation/bloc/local_article_bloc.dart';
import 'package:reto_asap/features/articles/presentation/pages/create_article_page.dart';
import 'package:reto_asap/features/articles/presentation/pages/local_article_detail_page.dart';
import 'package:reto_asap/features/articles/presentation/widgets/local_article_widget.dart';

class MyArticlesPage extends StatefulWidget {
  const MyArticlesPage({super.key});

  @override
  State<MyArticlesPage> createState() => _MyArticlesPageState();
}

class _MyArticlesPageState extends State<MyArticlesPage> {
  @override
  void initState() {
    context.read<LocalArticleBloc>().add(OnGetAllLocalArticles());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "MY ARTICLES",
          style: TextStyle(color: Colors.red),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, CreateArticlePage.route());
              },
              icon: const Icon(
                Icons.add_circle,
                size: 30,
              ))
        ],
      ),
      body: BlocBuilder<LocalArticleBloc, LocalArticleState>(
        builder: (context, state) {
          if (state is LoadingLocal) {
            return const Loader();
          }
          if (state is LocalArticlesLoaded) {
            if (state.localArticles.isNotEmpty) {
              return ListView.builder(
                itemCount: state.localArticles.length,
                itemBuilder: (context, index) {
                  final article = state.localArticles[index];
                  return Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LocalArticleDetailPage(
                                        localArticle: article,
                                      )));
                        },
                        child: LocalArticleWidget(localArticle: article),
                      ),
                      Positioned(
                          right: 10,
                          top: 10,
                          child: IconButton(
                            onPressed: () {
                              context
                                  .read<LocalArticleBloc>()
                                  .add(OnDeleteLocalArticle(index: index));
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 40,
                            ),
                          )),
                    ],
                  );
                },
              );
            } else {
              return const Center(
                child: Text("Sin articulos"),
              );
            }
          }
          return const Center(
            child: Text('Cargando..'),
          );
        },
      ),
    );
  }
}
