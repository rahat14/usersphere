import 'package:usersphere/features/user/data/models/UserListResp.dart';

import '../../../../core/network/Failure.dart';

abstract class UserListRepository {
  ResultFuture<UserListResp> getUsers(int page);
}
