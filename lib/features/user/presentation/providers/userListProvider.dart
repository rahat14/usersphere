import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../../services/di.dart';
import '../../domain/repositories/UserListRepo.dart';
import 'UserListScreenState.dart';

class UserNotifier extends StateNotifier<UserState> {
  final UserListRepository repository;

  UserNotifier(this.repository) : super(UserState(users: []));

  Future<void> loadUsers({bool isRefresh = false}) async {
    if (state.isLoading || !state.hasMore && !isRefresh) return;
    try {
      state = state.copyWith(isLoading: true, errorMessage: null);
      final nextPage = isRefresh ? 1 : state.currentPage;
      final newUsers = await repository.getUsers(nextPage);

      state = state.copyWith(
        users: isRefresh ? newUsers : [...state.users, ...newUsers],
        isLoading: false,
        currentPage: nextPage + 1,
        hasMore: newUsers.isNotEmpty,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  final repository = sl<UserListRepository>();
  return UserNotifier(repository);
});
