


import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../core/network/dio_client.dart';
import '../datasources/user_api_service.dart';

final sl = GetIt.instance;

void init() {
  sl.registerLazySingleton<Dio>(() => DioClient.create());
  sl.registerLazySingleton<UserApiService>(() => UserApiService(sl()));
}
