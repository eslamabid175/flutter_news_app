import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app_api/features/home/presentation/view/screens/home_screen.dart';
import 'core/services/injection_container.dart' as di;
import 'core/themeing/app_theme.dart';
import 'features/home/presentation/viewModel/articles_cubit.dart';
import 'features/home/presentation/viewModel/favorite_articles_cupit.dart';

class AppBlocObserver extends BlocObserver {
  static const currentTime = '2025-04-01 20:06:14';
  static const currentUser = 'eslamabid175';

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('$currentTime - $currentUser: onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('$currentTime - $currentUser: onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('$currentTime - $currentUser: onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }
}

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    ErrorWidget.builder = (FlutterErrorDetails details) {
      print('${AppBlocObserver.currentTime} - ${AppBlocObserver.currentUser}: Global error: ${details.exception}');
      return CustomErrorWidget(errorDetails: details);
    };

    await di.DependencyInjector.init();
    Bloc.observer = AppBlocObserver();

    runApp(const MyApp());
  } catch (e) {
    print('${AppBlocObserver.currentTime} - ${AppBlocObserver.currentUser}: Error starting application: $e');
    rethrow;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ArticlesCubit>(
          create: (context) => di.sl<ArticlesCubit>(),
          lazy: false,
        ),
        BlocProvider<FavoriteArticlesCubit>(
          create: (context) => di.sl<FavoriteArticlesCubit>(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        title: 'News App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: HomeScreen(),
        builder: (context, child) {
          if (child == null) return const SizedBox.shrink();

          return _ErrorHandlingWrapper(
            child: ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(
                physics: const BouncingScrollPhysics(),
              ),
              child: child,
            ),
          );
        },
      ),
    );
  }
}

class _ErrorHandlingWrapper extends StatelessWidget {
  final Widget child;
  static const currentTime = '2025-04-01 20:06:14';
  static const currentUser = 'eslamabid175';

  const _ErrorHandlingWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class CustomErrorWidget extends StatelessWidget {
  final FlutterErrorDetails errorDetails;
  static const currentTime = '2025-04-01 20:06:14';
  static const currentUser = 'eslamabid175';

  const CustomErrorWidget({
    Key? key,
    required this.errorDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              const SizedBox(height: 16),
              Text(
                'Oops! Something went wrong',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'We\'re working on fixing this issue',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              if (errorDetails.stack != null)
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      errorDetails.stack.toString(),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontFamily: 'monospace',
                      ),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  print('$currentTime - $currentUser: Retry attempt');
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => HomeScreen()),
                        (route) => false,
                  );
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}