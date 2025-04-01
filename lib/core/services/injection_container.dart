import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/home/data/repositories/article_repository_impl.dart';
import '../../features/home/domain/repositories/article_repository.dart';
import '../../features/home/presentation/viewModel/articles_cubit.dart';
import '../network/network_info.dart';
import '../api/dio_helper.dart';
import '../../features/home/data/dataSources/local/article_local_datasource.dart';
import '../../features/home/data/dataSources/remote/remote_data_source.dart';
import '../../features/home/domain/usecases/get_top_headlines.dart';
import '../../features/home/domain/usecases/search_article.dart';
import '../../features/home/presentation/viewModel/favorite_articles_cupit.dart';

final sl = GetIt.instance;

class DependencyInjector {
  static const currentTime = '2025-04-01 20:06:14';
  static const currentUser = 'eslamabid175';

  static Future<void> init() async {
    try {
      print('$currentTime - $currentUser: Starting dependency injection setup');

      // Cubits
      sl.registerFactory(() => FavoriteArticlesCubit(localDataSource: sl()));
      sl.registerFactory(() => ArticlesCubit(
        getTopHeadlines: sl(),
        searchArticles: sl(),
      ));

      // Local Data Source
      final sharedPreferences = await SharedPreferences.getInstance();
      sl.registerLazySingleton<ArticleLocalDataSource>(
            () => ArticleLocalDataSourceImpl(sharedPreferences: sharedPreferences),
      );

      await _initExternalDependencies();
      _initCoreDependencies();
      _initFeatureDependencies();

      print('$currentTime - $currentUser: Dependency injection completed');
    } catch (e) {
      print('$currentTime - $currentUser: Error in dependency injection: $e');
      rethrow;
    }
  }

  static Future<void> _initExternalDependencies() async {
    print('$currentTime - $currentUser: Initializing external dependencies');

    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPreferences);
    sl.registerLazySingleton(() => InternetConnectionChecker());

    await DioHelper.init();
  }

  static void _initCoreDependencies() {
    print('$currentTime - $currentUser: Initializing core dependencies');

    sl.registerLazySingleton<NetworkInfo>(
          () => NetworkInfoImpl(sl<InternetConnectionChecker>()),
    );
  }

  static void _initFeatureDependencies() {
    print('$currentTime - $currentUser: Initializing feature dependencies');

    // Use cases
    sl.registerLazySingleton(() => GetTopHeadlinesUseCase(sl()));
    sl.registerLazySingleton(() => SearchArticlesUseCase(sl()));

    // Repository
    sl.registerLazySingleton<ArticleRepository>(
          () => ArticleRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ),
    );

    // Data sources
    sl.registerLazySingleton<ArticleRemoteDataSource>(
          () => ArticleRemoteDataSourceImpl(),
    );
  }

  static void reset() {
    print('$currentTime - $currentUser: Resetting dependency injection');
    sl.reset();
  }
}