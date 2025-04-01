import 'package:dio/dio.dart';
import '../utils/constants.dart';

class DioHelper {
  static late Dio dio;

  static Future<void> init() async {
    dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        queryParameters: {
          'apiKey': AppConstants.apiKey,
        },
        headers: {
          'Content-Type': 'application/json',
        },
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    )..interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        logPrint: (object) {
          print('${DateTime.parse('2025-04-01 14:57:12')} - eslamabid175: $object');
        },
      ),
    );
  }
}