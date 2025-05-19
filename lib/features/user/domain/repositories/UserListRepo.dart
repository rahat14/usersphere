import 'package:usersphere/features/user/data/models/UserListResp.dart';

abstract class UserListRepository {
  Future<UserListResp> getUsers(int page);
}
