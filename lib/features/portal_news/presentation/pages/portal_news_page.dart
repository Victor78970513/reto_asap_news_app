import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reto_asap/core/common/widgets/loader.dart';
import 'package:reto_asap/core/cubits/app_user/app_user_cubit.dart';
import 'package:reto_asap/core/utils/show_snackbar.dart';
import 'package:reto_asap/features/portal_news/presentation/bloc/articles_bloc.dart';
import 'package:reto_asap/features/portal_news/presentation/widgets/articles_list.dart';

class PortalNewsPage extends StatefulWidget {
  const PortalNewsPage({super.key});

  @override
  State<PortalNewsPage> createState() => _PortalNewsPageState();
}

class _PortalNewsPageState extends State<PortalNewsPage> {
  ScrollController scrollController = ScrollController();
  int currentPage = 1;
  bool isLoading = false;
  bool hasReachedMax = false;
  @override
  void initState() {
    context.read<ArticlesBloc>()
      ..add(OnFirstFetchEvent())
      ..add(FetchAllArticlesEvent(pageSize: 10, page: currentPage));

    super.initState();
  }

  void loadNextPage() async {
    currentPage = currentPage + 1;
    if (currentPage <= 5) {
      context
          .read<ArticlesBloc>()
          .add(FetchAllArticlesEvent(pageSize: 10, page: currentPage));
    } else {
      setState(() {
        hasReachedMax = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "News App",
            style: TextStyle(color: Colors.red, fontSize: 35),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  context.read<AppUserCubit>().updateUser(null);
                },
                icon: const Icon(
                  Icons.logout,
                  size: 30,
                ))
          ],
        ),
        body: BlocConsumer<ArticlesBloc, ArticlesState>(
          listener: (context, state) {
            if (state is ArticlesFailure) {
              return showSnackBar(context, state.error);
            }
          },
          builder: (context, state) {
            log(state.toString());
            if (state is ArticlesLoading) {
              return const Loader();
            }
            if (state is ArticlesSuccess) {
              return ArticlesList(
                articles: state.articles,
                loadNextPage: loadNextPage,
                hasReachedMax: hasReachedMax,
              );
            }
            return const SizedBox(
              child: Center(child: Text("Sin articulos ")),
            );
          },
        ));
  }
}
