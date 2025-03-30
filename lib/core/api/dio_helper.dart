import 'package:dio/dio.dart';
import '../errors/exceptions.dart';
import '../utils/constants.dart';

/// DioHelper: A singleton class that handles all HTTP requests
/// We use a singleton to ensure we only have one instance managing API calls
class DioHelper {
  // Private static instance for singleton pattern
  static late Dio _dio;

  /// Initialize DioHelper with default configuration
  /// Must be called at app startup (in main.dart)
  static Future<void> init() async {
    try {
      _dio = Dio(
        BaseOptions(
          // Base configuration for all requests
          baseUrl: ApiConstants.baseUrl,
          // Continue even if server returns error status code
          validateStatus: (status) => status != null && status < 500,
          // Headers that will be added to all requests
          headers: {
            'Content-Type': 'application/json',
            'X-Api-Key': ApiConstants.apiKey,
            // Adding user context for logging/debugging
            'X-User-Context': AppConstants.currentUser,
          },
          // Timeout settings
          connectTimeout: const Duration(
            milliseconds: AppConstants.connectionTimeoutInMs,
          ),
          receiveTimeout: const Duration(
            milliseconds: AppConstants.receiveTimeoutInMs,
          ),
        ),
      );

      // Add interceptors for logging and error handling
      _dio.interceptors.addAll([
        _LoggingInterceptor(),
        _ErrorInterceptor(),
      ]);

      print('DioHelper initialized successfully at ${AppConstants.currentTime}');
    } catch (e) {
      print('Error initializing DioHelper: $e');
      rethrow;
    }
  }

  /// GET request method
  /// [endpoint]: The API endpoint to call
  /// [queryParameters]: Optional query parameters
  /// [token]: Optional authentication token
  static Future<Response> getData({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    try {
      // Update headers if token is provided
      if (token != null) {
        _dio.options.headers['Authorization'] = 'Bearer $token';
      }

      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
      );

      // Log successful request
      print('GET Request successful: ${response.statusCode}');
      return response;
    } catch (e) {
      print('GET Request failed: $e');
      rethrow;
    }
  }

  /// POST request method
  static Future<Response> postData({
    required String endpoint,
    required Map<String, dynamic> data,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    try {
      if (token != null) {
        _dio.options.headers['Authorization'] = 'Bearer $token';
      }

      final response = await _dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
      );

      print('POST Request successful: ${response.statusCode}');
      return response;
    } catch (e) {
      print('POST Request failed: $e');
      rethrow;
    }
  }
}

/// Custom logging interceptor for debugging
class _LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('------- API Request - ${AppConstants.currentTime} -------');
    print('URL: ${options.uri}');
    print('Method: ${options.method}');
    print('Headers: ${options.headers}');
    print('Query Parameters: ${options.queryParameters}');
    print('Data: ${options.data}');
    print('User: ${AppConstants.currentUser}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('------- API Response - ${AppConstants.currentTime} -------');
    print('Status Code: ${response.statusCode}');
    print('Data: ${response.data}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('------- API Error - ${AppConstants.currentTime} -------');
    print('Error: ${err.message}');
    print('Error Type: ${err.type}');
    print('User: ${AppConstants.currentUser}');
    return super.onError(err, handler);
  }
}

/// Custom error interceptor for handling API errors
class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw NetworkException('Connection timeout. Please check your internet.');

      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode ?? -1;
        final message = _getErrorMessage(statusCode);
        throw ServerException(message);

      case DioExceptionType.unknown:
        if (err.error.toString().contains('SocketException')) {
          throw NetworkException(ErrorMessages.noInternet);
        }
        throw ServerException(ErrorMessages.generalError);

      default:
        throw ServerException(ErrorMessages.generalError);
    }
  }

  String _getErrorMessage(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request. Please check your input.';
      case 401:
        return 'Unauthorized. Please login again.';
      case 403:
        return 'Forbidden. You don\'t have permission.';
      case 404:
        return 'Resource not found.';
      case 429:
        return 'Too many requests. Please try again later.';
      default:
        return ErrorMessages.serverError;
    }
  }
}