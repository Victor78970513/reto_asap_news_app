import 'package:flutter/material.dart';
import 'package:reto_asap/features/portal_news/domain/entities/article.dart';
import 'package:reto_asap/features/portal_news/presentation/pages/new_detail_page.dart';
import 'package:reto_asap/features/portal_news/presentation/widgets/article_widget.dart';

class ArticlesList extends StatefulWidget {
  final List<Article> articles;
  final VoidCallback loadNextPage;
  final bool hasReachedMax;
  const ArticlesList({
    super.key,
    required this.articles,
    required this.loadNextPage,
    required this.hasReachedMax,
  });

  @override
  State<ArticlesList> createState() => _ArticlesListState();
}

class _ArticlesListState extends State<ArticlesList> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      widget.loadNextPage();
    }
  }

  bool get _isBottom {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      controller: scrollController,
      itemCount: widget.articles.length + 1,
      itemBuilder: (context, index) {
        if (index < widget.articles.length) {
          final article = widget.articles[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewDetailPage(article: article)));
            },
            child: ArticleWidget(article: article),
          );
        } else if (widget.hasReachedMax) {
          return const SizedBox(height: 5, width: double.infinity);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
