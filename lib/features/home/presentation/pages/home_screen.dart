import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reto_asap/features/articles/presentation/pages/my_articles_page.dart';
import 'package:reto_asap/features/home/presentation/home_cubit/home_cubit.dart';
import 'package:reto_asap/features/home/presentation/widgets/portal_news_navigation_bar.dart';
import 'package:reto_asap/features/portal_news/presentation/pages/portal_news_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, int>(
      builder: (context, currentIndex) {
        return Scaffold(
            body: Column(
          children: [
            Expanded(
              child: IndexedStack(
                index: currentIndex,
                children: const [
                  PortalNewsPage(),
                  MyArticlesPage(),
                ],
              ),
            ),
            PortalNewsNavigationBar(
              index: currentIndex,
              onIndexSelected: (index) {
                context.read<HomeCubit>().updateIndex(index);
              },
            ),
          ],
        ));
      },
    );
  }
}
