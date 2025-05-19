import 'package:usersphere/features/user/domain/repositories/UserListRepo.dart';

import '../datasources/user_api_service.dart';

class UserRepositoryImpl implements UserListRepository {
  final UserApiService apiService;

  UserRepositoryImpl(this.apiService);

  @override
  Future<dynamic> getUsers(int page) async {
    return [];
  }
}
