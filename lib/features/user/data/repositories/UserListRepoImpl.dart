import 'package:usersphere/features/user/domain/repositories/UserListRepo.dart';

import '../datasources/user_api_service.dart';
import '../models/UserListResp.dart';

class UserRepositoryImpl implements UserListRepository {
  final UserApiService apiService;

  UserRepositoryImpl(this.apiService);

  @override
  Future<UserListResp> getUsers(int page) async {
    return  apiService.fetchUsers(page) ;

  }
}
