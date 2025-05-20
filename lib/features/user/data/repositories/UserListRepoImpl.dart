import 'package:dartz/dartz.dart';
import 'package:usersphere/features/user/data/datasources/userDataSource.dart';
import 'package:usersphere/features/user/domain/repositories/UserListRepo.dart';

import '../../../../core/network/Failure.dart';
import '../../../../core/network/networkExceptions.dart';
import '../models/UserListResp.dart';

class UserRepositoryImpl implements UserListRepository {
  final UserDataSource apiService;

  UserRepositoryImpl(this.apiService);

  @override
  ResultFuture<UserListResp> getUsers(int page) async {
    try {
      final result = await apiService.fetchUsers(page);
      return Right(result);
    } on CustomException catch (e) {

      return Left(ServerFailure(
        message: e.message,
        statusCode: e.statusCode ?? 500,
      ));
    }
  }

}
