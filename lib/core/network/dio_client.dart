import 'package:dio/dio.dart';
import 'package:usersphere/core/constants/Constants.dart';

class DioClient {
  static Dio create() {
    final dio = Dio(BaseOptions(
      baseUrl: BASE_URL,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ));

    dio.interceptors.add(LogInterceptor(responseBody: true));
    return dio;
  }
}
