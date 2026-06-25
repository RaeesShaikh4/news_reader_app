import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:news_reader_app/core/constant/api_constants.dart';
import 'package:news_reader_app/features/auth/data/data_source/auth_local_datasource.dart';
import 'package:news_reader_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:news_reader_app/features/auth/domain/repository/auth_repository.dart';
import 'package:news_reader_app/features/auth/domain/use_cases/log_in_use_case.dart';
import 'package:news_reader_app/features/auth/domain/use_cases/log_out_use_case.dart';
import 'package:news_reader_app/features/auth/domain/use_cases/set_user_name_case.dart';
import 'package:news_reader_app/features/auth/presentation/provider/login_provider.dart';
import 'package:news_reader_app/features/bookmarks/data/data_sources/bookmark_local_datasource.dart';
import 'package:news_reader_app/features/bookmarks/data/repository/book_mark_local_repo_impl.dart';
import 'package:news_reader_app/features/bookmarks/domain/repository/book_mark_local_repo.dart';
import 'package:news_reader_app/features/bookmarks/domain/use_cases/get_bookmarks_use_case.dart';
import 'package:news_reader_app/features/bookmarks/domain/use_cases/remove_bookmark_use_case.dart';
import 'package:news_reader_app/features/bookmarks/presentation/provider/bookmark_provider.dart';
import 'package:news_reader_app/features/home/data/data_sources/news_local_datasource.dart';
import 'package:news_reader_app/features/home/data/data_sources/news_remote_datasource.dart';
import 'package:news_reader_app/features/home/data/models/article_model.dart';
import 'package:news_reader_app/features/home/data/repositories/news_local_repository_impl.dart';
import 'package:news_reader_app/features/home/data/repositories/news_reposity_impl.dart';
import 'package:news_reader_app/features/home/domain/repositories/news_local_repository.dart';
import 'package:news_reader_app/features/home/domain/repositories/news_reposity.dart';
import 'package:news_reader_app/features/home/domain/use_cases/get_articles_list.dart';
import 'package:news_reader_app/features/bookmarks/domain/use_cases/save_bookmarked_article.dart';
import 'package:news_reader_app/features/home/presentation/provider/home_provider.dart';
import 'package:news_reader_app/features/wall_street_journal/data/data_sources/wall_street_journal_remote_datasorce.dart';
import 'package:news_reader_app/features/wall_street_journal/data/models/wall_street_article_model.dart';
import 'package:news_reader_app/features/wall_street_journal/data/repositories/wall_street_journal_remote_repository_impl.dart';
import 'package:news_reader_app/features/wall_street_journal/domain/repositories/wall_street_repository.dart';
import 'package:news_reader_app/features/wall_street_journal/domain/use_case/get_wall_street_journal_use_case.dart';
import 'package:news_reader_app/features/wall_street_journal/presentations/provider/wall_street_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initDependencies({
  required Box<ArticleModel> articleBox,
  // required Box<WallStreetArticleModel> wallStreetArticleBox,
}) async {
  final prefs = await SharedPreferences.getInstance();

  sl.registerLazySingleton<Dio>(() {
    final dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      options.queryParameters['apiKey'] = dotenv.env['NEWS_API_KEY'];
      handler.next(options);
    }));
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
    ));
    return dio;
  });

  sl.registerLazySingleton<SharedPreferences>(() => prefs);

  // model dependencies

  sl.registerLazySingleton<Box<ArticleModel>>(() => articleBox);

  // sl.registerLazySingleton<Box<WallStreetArticleModel>>(
  //     () => wallStreetArticleBox);

  // data dependencies

  sl.registerLazySingleton<NewsRemoteDataSource>(
      () => NewsRemoteDataSouceImpl(sl()));

  sl.registerLazySingleton<WallStreetJournalRemoteDatasorce>(
      () => WallStreetJournalRemoteDataSouceImpl(sl()));

  sl.registerLazySingleton<NewsLocalDataSource>(
      () => NewsLocalDataSourceImple(sl<Box<ArticleModel>>()));

  sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImple(sl()));

  sl.registerLazySingleton<BookMarkLocalDataSource>(
      () => BookMarkLocalDataSourceImple(sl<Box<ArticleModel>>()));

  // domain repositories

  sl.registerLazySingleton<NewsRepository>(() => NewsRepositorisImpl(sl()));

  sl.registerLazySingleton<WallStreetRepository>(
      () => WallStreetJournalRemoteRepositoryImpl(sl()));

  sl.registerLazySingleton<BookMarkLocalRepository>(
      () => BookMarkLocalRepositoryImpl(sl()));

  sl.registerLazySingleton<NewsLocalRepository>(
      () => NewsLocalRepositorisImpl(sl()));

  sl.registerLazySingleton<AuthLocalRepository>(
      () => AuthLocalRepositoryImpl(sl()));

  // provider dependencies

  sl.registerLazySingleton<LoginProvider>(() => LoginProvider(
      logOutUseCase: sl(), logInUseCase: sl(), setUserNameCase: sl()));

  sl.registerFactory(() => NewsProvider(
        getArticleUsecase: sl(),
      ));

  sl.registerFactory(() => WallStreetProvider(
        getWallStreetJournalUseCase: sl(),
      ));

  sl.registerFactory(() => BookMarkProvider(
      getBookmarkArticles: sl(),
      saveArticleBookmar: sl(),
      removeBookMarkedArticles: sl()));

// use case dependencies
  sl.registerLazySingleton(() => GetArticleListUseCase(sl()));
  sl.registerLazySingleton(() => SaveArticleAtBokkMarked(sl()));
  sl.registerLazySingleton(() => RemaveBookmarkArticle(sl()));
  sl.registerLazySingleton(() => GetBookmarkedArticles(sl()));

  sl.registerLazySingleton(() => LogOutUseCase(sl()));
  sl.registerLazySingleton(() => LogInUseCase(sl()));
  sl.registerLazySingleton(() => SetUserNameCAse(sl()));
  sl.registerLazySingleton(() => GetWallStreetJournalUseCase(sl()));
}
