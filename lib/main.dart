import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app_api/features/home/presentation/view/screens/home_screen.dart';

import 'core/services/injection_container.dart' as di;
import 'core/themeing/app_theme.dart';
import 'features/home/presentation/viewModel/articles_cubit.dart';

/// Custom BlocObserver for debugging
class AppBlocObserver extends BlocObserver {
  final _currentTime = DateTime.parse('2025-03-30 12:16:14');
  final _currentUser = 'eslamabid175';

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType} by $_currentUser at $_currentTime');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }
}

/// Entry point of the application
void main() async {
  try {
    // Ensure Flutter bindings are initialized
    WidgetsFlutterBinding.ensureInitialized();

    // Set up custom error widget for the entire app
    ErrorWidget.builder = (FlutterErrorDetails details) {
      print('Global error handler: ${details.exception}');
      print('Stack trace: ${details.stack}');
      print('Time: ${DateTime.parse('2025-03-30 12:16:14')}');
      print('User: eslamabid175');

      return CustomErrorWidget(
        errorDetails: details,
      );
    };

    // Initialize dependencies
    await di.DependencyInjector.init();

    // Set up BlocObserver for debugging
    Bloc.observer = AppBlocObserver();

    // Run the app
    runApp(const MyApp());
  } catch (e) {
    print('Error starting application: $e');
    rethrow;
  }
}

/// Root widget of the application
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

/// Widget to handle uncaught errors in the widget tree
class _ErrorHandlingWrapper extends StatelessWidget {
  final Widget child;

  final _currentTime = DateTime.parse('2025-03-30 12:16:14');
  final _currentUser = 'eslamabid175';

  _ErrorHandlingWrapper({
    Key? key,
    required this.child,
  }) : super(key: key) {
    // Log wrapper creation
    print('ErrorHandlingWrapper created at $_currentTime by $_currentUser');
  }

  @override
  Widget build(BuildContext context) {
    // Simply return the child widget, error handling is done globally
    return child;
  }
}

/// Custom error widget for displaying user-friendly error messages
class CustomErrorWidget extends StatelessWidget {
  final FlutterErrorDetails errorDetails;

  // Track creation time and user
  final _currentTime = DateTime.parse('2025-03-30 12:16:14');
  final _currentUser = 'eslamabid175';

  CustomErrorWidget({
    Key? key,
    required this.errorDetails,
  }) : super(key: key) {
    // Log error widget creation
    print('CustomErrorWidget created for error: ${errorDetails.exception}');
    print('Time: $_currentTime, User: $_currentUser');
  }

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
                  'Were working on fixing this issue',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // Show error details in debug mode
            if (errorDetails.stack != null && true) // Replace true with !kReleaseMode for production
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
    // Retry button
    ElevatedButton(
    onPressed: () {
    print('Retry attempted at $_currentTime by $_currentUser');
    // Navigate to home page
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