import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reto_asap/features/articles/presentation/bloc/local_article_bloc.dart';
import 'package:reto_asap/features/home/presentation/home_cubit/home_cubit.dart';
import 'package:reto_asap/features/portal_news/presentation/bloc/articles_bloc.dart';
import 'package:reto_asap/service_locator.dart';
import 'package:reto_asap/core/theme/app_theme.dart';
import 'package:reto_asap/core/cubits/app_user/app_user_cubit.dart';
import 'package:reto_asap/features/home/presentation/pages/home_screen.dart';
import 'package:reto_asap/features/auth/presentation/bloc/auth_bloc.dart';

import 'features/auth/presentation/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependecies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => serviceLocator<AppUserCubit>()),
        BlocProvider(create: (context) => serviceLocator<AuthBloc>()),
        BlocProvider(create: (context) => serviceLocator<HomeCubit>()),
        BlocProvider(create: (context) => serviceLocator<ArticlesBloc>()),
        BlocProvider(create: (context) => serviceLocator<LocalArticleBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedInEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      title: 'Material App',
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn) {
            return const HomeScreen();
          }
          return const LoginPage();
        },
      ),
    );
  }
}
