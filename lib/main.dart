// Core Flutter Material Design widgets and functionality
import 'package:flutter/material.dart';
// BLoC state management library for handling application state
import 'package:flutter_bloc/flutter_bloc.dart';
// Main screen of the application
import 'package:flutter_news_app_api/features/home/presentation/view/screens/home_screen.dart';
// Dependency injection container (using GetIt under the alias 'di')
import 'core/services/injection_container.dart' as di;
// Custom theme configurations for the app
import 'core/themeing/app_theme.dart';
// BLoC/Cubit classes for managing article and favorites state
import 'features/home/presentation/viewModel/articles_cubit.dart';
import 'features/home/presentation/viewModel/favorite_articles_cupit.dart';

// Custom BLoC observer for debugging and monitoring state changes
// Extends BlocObserver to provide custom logging behavior
class AppBlocObserver extends BlocObserver {
  // Constants for logging timestamp and user identification
  static const currentTime = '2025-04-01 20:06:14';
  static const currentUser = 'eslamabid175';

  // Called when a new BLoC is created
  // Important for tracking BLoC lifecycle and debugging memory leaks
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    // Log BLoC creation with timestamp and type information
    print('$currentTime - $currentUser: onCreate -- ${bloc.runtimeType}');
  }

  // Called when a BLoC's state changes
  // Critical for debugging state transitions and data flow
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    // Log state changes with detailed information about the change
    print('$currentTime - $currentUser: onChange -- ${bloc.runtimeType}, $change');
  }

  // Called when a BLoC throws an error
  // Essential for error tracking and debugging
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    // Log error details before calling super to ensure capture
    print('$currentTime - $currentUser: onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }
}

// Application entry point
// async because we need to perform initialization tasks
void main() async {
  try {
    // Ensure Flutter bindings are initialized
    // Required before calling native code or platform channels
    WidgetsFlutterBinding.ensureInitialized();

    // Custom error widget builder for handling UI errors gracefully
    // Replaces the default red screen of death with a more user-friendly error display
    ErrorWidget.builder = (FlutterErrorDetails details) {
      // Log the error with context information
      print('${AppBlocObserver.currentTime} - ${AppBlocObserver.currentUser}: Global error: ${details.exception}');
      // Return custom error widget instead of default red screen
      return CustomErrorWidget(errorDetails: details);
    };

    // Initialize dependency injection
    // Sets up all services, repositories, and BLoCs
    await di.DependencyInjector.init();
    // Set up global BLoC observer for state management monitoring
    Bloc.observer = AppBlocObserver();

    // Launch the application with MyApp as the root widget
    runApp(const MyApp());
  } catch (e) {
    // Global error handling for initialization errors
    print('${AppBlocObserver.currentTime} - ${AppBlocObserver.currentUser}: Error starting application: $e');
    // Rethrow to ensure error is not silently swallowed
    rethrow;
  }
}

// Root widget of the application
// Stateless because it doesn't need to maintain any internal state
class MyApp extends StatelessWidget {
  // Constructor with optional key parameter
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // MultiBlocProvider for providing multiple BLoCs to the widget tree
    return MultiBlocProvider(
      providers: [
        // Provider for ArticlesCubit
        // lazy: false means it's initialized immediately rather than on first use
        BlocProvider<ArticlesCubit>(
          create: (context) => di.sl<ArticlesCubit>(),
          lazy: false, // Immediate initialization
        ),
        // Provider for FavoriteArticlesCubit
        BlocProvider<FavoriteArticlesCubit>(
          create: (context) => di.sl<FavoriteArticlesCubit>(),
          lazy: false, // Immediate initialization
        ),
      ],
      // MaterialApp configuration
      child: MaterialApp(
        title: 'News App', // App title shown in task switcher
        debugShowCheckedModeBanner: false, // Removes debug banner
        theme: AppTheme.lightTheme, // Light theme configuration
        darkTheme: AppTheme.darkTheme, // Dark theme configuration
        themeMode: ThemeMode.system, // Use system theme preference
        home: HomeScreen(), // Initial screen
        // Global builder for adding functionality to all screens
        builder: (context, child) {
          // Safety check for null child
          if (child == null) return const SizedBox.shrink();

          // Wrap child with error handling and custom scroll behavior
          return _ErrorHandlingWrapper(
            child: ScrollConfiguration(
              // Configure scrolling behavior with bouncing physics
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

// Private widget for handling errors throughout the app
// Name starts with underscore to indicate it's private to this file
class _ErrorHandlingWrapper extends StatelessWidget {
  final Widget child;
  // Constants for logging

  // Constructor requiring a child widget
  const _ErrorHandlingWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Simply returns the child widget
    // Could be extended to add error boundary functionality
    return child;
  }
}

// Custom widget for displaying errors in a user-friendly way
class CustomErrorWidget extends StatelessWidget {
  // Details about the error that occurred
  final FlutterErrorDetails errorDetails;
  // Constants for logging
  static const currentTime = '2025-04-01 20:06:14';
  static const currentUser = 'eslamabid175';

  // Constructor requiring error details
  const CustomErrorWidget({
    Key? key,
    required this.errorDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Material widget ensures proper theming
    return Material(
      child: SafeArea(
        // Container with padding for content
        child: Container(
          padding: const EdgeInsets.all(16),
          // Column for vertical layout of error information
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Error icon
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              const SizedBox(height: 16),
              // Error message title
              Text(
                'Oops! Something went wrong',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              // Friendly error message
              Text(
                'We\'re working on fixing this issue',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              // Stack trace display (if available)
              if (errorDetails.stack != null)
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  // Scrollable stack trace with monospace font
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
                  // Log retry attempt
                  print('$currentTime - $currentUser: Retry attempt');
                  // Navigate back to home screen, clearing navigation stack
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