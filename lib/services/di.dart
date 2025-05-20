import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:usersphere/features/user/data/datasources/userDataSource.dart';

import '../core/network/dio_client.dart';
import '../features/user/data/repositories/UserListRepoImpl.dart';
import '../features/user/domain/repositories/UserListRepo.dart';

final sl = GetIt.instance;

void init() {
  sl.registerLazySingleton<Dio>(() => DioClient.create());

  sl.registerLazySingleton<UserDataSource>(() => UserDataSource(sl()));
  sl.registerLazySingleton<UserListRepository>(() => UserRepositoryImpl(sl()));
}
