import 'package:usersphere/features/user/data/datasources/userDataSource.dart';
import 'package:usersphere/features/user/domain/repositories/UserListRepo.dart';

import '../models/UserListResp.dart';

class UserRepositoryImpl implements UserListRepository {
  final UserDataSource apiService;

  UserRepositoryImpl(this.apiService);

  @override
  Future<UserListResp> getUsers(int page) async {
    return  apiService.fetchUsers(page) ;

  }
}
