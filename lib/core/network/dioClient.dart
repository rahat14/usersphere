import 'package:dio/dio.dart';
import 'package:usersphere/core/constants/Constants.dart';

class DioClient {
  static Dio create() {
    final dio = Dio(
        BaseOptions(
      baseUrl: BASE_URL,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {"x-api-key" : "reqres-free-v1"}    // as it is free api key so for now no scurity
    ));

    dio.interceptors.add(LogInterceptor(responseBody: true));
    return dio;
  }
}
