import 'package:flutter_news_app_api/features/home/domain/usecases/search_article.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_news_app_api/features/home/data/repositories/article_repository_impl.dart';
import 'package:flutter_news_app_api/features/home/domain/repositories/article_repository.dart';
import 'package:flutter_news_app_api/features/home/presentation/viewModel/articles_cubit.dart';
import 'package:flutter_news_app_api/core/network/network_info.dart';
import 'package:flutter_news_app_api/core/api/dio_helper.dart';

import '../../features/home/data/dataSources/local/article_local_datasource.dart';
import '../../features/home/data/dataSources/remote/remote_data_source.dart';
import '../../features/home/domain/usecases/get_top_headlines.dart';

/// GetIt instance for dependency injection
final sl = GetIt.instance;

/// Class to handle dependency injection setup
class DependencyInjector {
  // Current user and time for tracking
  static final _currentTime = DateTime.parse('2025-03-30 12:16:14');
  static const _currentUser = 'eslamabid175';

  /// Initialize all dependencies
  /// This method must be called before running the app
  static Future<void> init() async {
    try {
      print('Starting dependency injection setup - $_currentUser');
      print('Initialization time: $_currentTime');

      // Register external dependencies first
      await _initExternalDependencies();

      // Register core dependencies
      _initCoreDependencies();

      // Register feature specific dependencies
      _initFeatureDependencies();

      print('Dependency injection setup completed successfully');
    } catch (e) {
      print('Error during dependency injection setup: $e');
      rethrow;
    }
  }

  /// Initialize external dependencies like SharedPreferences
  static Future<void> _initExternalDependencies() async {
    print('Initializing external dependencies...');

    // SharedPreferences instance
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPreferences);

    // Internet connection checker
    sl.registerLazySingleton(() => InternetConnectionChecker());

    // Initialize Dio for network requests
    await DioHelper.init();
  }

  /// Initialize core dependencies
  static void _initCoreDependencies() {
    print('Initializing core dependencies...');

    // Network info
    sl.registerLazySingleton<NetworkInfo>(
          () => NetworkInfoImpl(sl<InternetConnectionChecker>()),
    );
  }

  /// Initialize feature specific dependencies
  static void _initFeatureDependencies() {
    print('Initializing feature dependencies...');

    // Cubit
    sl.registerFactory(
          () => ArticlesCubit(
        getTopHeadlines: sl(),
        searchArticles: sl(),
      ),
    );

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

    sl.registerLazySingleton<ArticleLocalDataSource>(
          () => ArticleLocalDataSourceImpl(
        sharedPreferences: sl(),
      ),
    );
  }

  /// Cleanup method for testing
  static void reset() {
    print('Resetting dependency injection...');
    sl.reset();
  }
}