import 'package:dio/dio.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reto_asap/core/cubits/app_user/app_user_cubit.dart';
import 'package:reto_asap/core/network/connection_checker.dart';
import 'package:reto_asap/features/articles/data/datasources/local_article_datasource.dart';
import 'package:reto_asap/features/articles/data/models/local_article_model.dart';
import 'package:reto_asap/features/articles/data/repositories/local_article_repository_impl.dart';
import 'package:reto_asap/features/articles/domain/repositories/article_local_repository.dart';
import 'package:reto_asap/features/articles/domain/usecases/create_local_article.dart';
import 'package:reto_asap/features/articles/domain/usecases/delete_local_article.dart';
import 'package:reto_asap/features/articles/domain/usecases/get_local_articles.dart';
import 'package:reto_asap/features/articles/presentation/bloc/local_article_bloc.dart';
import 'package:reto_asap/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:reto_asap/features/auth/data/repository/auth_repository_impl.dart';
import 'package:reto_asap/features/auth/domain/repository/auth_repository.dart';
import 'package:reto_asap/features/auth/domain/usecases/current_user.dart';
import 'package:reto_asap/features/auth/domain/usecases/user_login.dart';
import 'package:reto_asap/features/auth/domain/usecases/user_sign_up.dart';
import 'package:reto_asap/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:reto_asap/features/home/presentation/home_cubit/home_cubit.dart';
import 'package:reto_asap/features/portal_news/data/datasources/article_remote_data_source.dart';
import 'package:reto_asap/features/portal_news/data/repositories/article_repository_impl.dart';
import 'package:reto_asap/features/portal_news/domain/repositories/article_repository.dart';
import 'package:reto_asap/features/portal_news/domain/usecases/get_all_articles.dart';
import 'package:reto_asap/features/portal_news/presentation/bloc/articles_bloc.dart';
import 'package:reto_asap/firebase_options.dart';
import 'package:hive_flutter/hive_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependecies() async {
  _initAuth();
  _initArticlesBloc();
  _initLocalArticlesBloc();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance
      .activate(androidProvider: AndroidProvider.playIntegrity);

  serviceLocator.registerFactory(() => InternetConnection());
  await Hive.initFlutter((await getApplicationDocumentsDirectory()).path);
  Hive.registerAdapter(LocalArticleModelAdapter());
  await Hive.openBox<LocalArticleModel>('local_articles');
  serviceLocator
      .registerFactory(() => Hive.box<LocalArticleModel>('local_articles'));

  //core
  serviceLocator.registerLazySingleton(() => AppUserCubit());

  serviceLocator.registerFactory<ConnectionChecker>(
      () => ConnectionCheckerImpl(serviceLocator<InternetConnection>()));

  serviceLocator.registerLazySingleton(() => HomeCubit());

  serviceLocator.registerLazySingleton(() => Dio());
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );

  serviceLocator.registerFactory<AuthRepository>(() => AuthRepositoryImpl(
      serviceLocator<AuthRemoteDataSource>(), serviceLocator()));

  serviceLocator
      .registerFactory(() => UserSignUp(serviceLocator<AuthRepository>()));

  serviceLocator
      .registerFactory(() => UserLogin(serviceLocator<AuthRepository>()));

  serviceLocator
      .registerFactory(() => CurrentUser(serviceLocator<AuthRepository>()));

  serviceLocator.registerLazySingleton(() => AuthBloc(
      userSignUp: serviceLocator<UserSignUp>(),
      userLogin: serviceLocator<UserLogin>(),
      currentUser: serviceLocator<CurrentUser>(),
      appUserCubit: serviceLocator<AppUserCubit>()));
}

void _initArticlesBloc() {
  serviceLocator.registerFactory<ArticleRemoteDataSource>(
      () => ArticleRemoteDataSourceImpl(serviceLocator<Dio>()));

  serviceLocator.registerFactory<ArticleRepository>(() => ArticleRepositoryImpl(
      serviceLocator<ArticleRemoteDataSource>(), serviceLocator()));

  serviceLocator.registerFactory(() => GetAllArticles(serviceLocator()));

  serviceLocator.registerFactory(
      () => ArticlesBloc(getAllArticles: serviceLocator<GetAllArticles>()));
}

void _initLocalArticlesBloc() {
  serviceLocator
      .registerFactory(() => LocalArticleDataSource(serviceLocator()));

  serviceLocator.registerFactory<LocalArticleRepository>(() =>
      LocalArticleRepositoryImpl(serviceLocator<LocalArticleDataSource>()));

  serviceLocator.registerFactory(
      () => GetLocalArticles(serviceLocator<LocalArticleRepository>()));
  serviceLocator.registerFactory(
      () => CreateLocalArticle(serviceLocator<LocalArticleRepository>()));

  serviceLocator.registerFactory(
      () => DeleteLocalArticle(serviceLocator<LocalArticleRepository>()));

  serviceLocator.registerFactory(() => LocalArticleBloc(
        getLocalArticles: serviceLocator(),
        createLocalArticle: serviceLocator(),
        deleteLocalArticle: serviceLocator(),
      ));
}
