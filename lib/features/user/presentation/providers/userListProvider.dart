import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../services/di.dart';
import '../../domain/repositories/UserListRepo.dart';
import 'UserListScreenState.dart';

class UserNotifier extends StateNotifier<UserState> {
  final UserListRepository repository;

  UserNotifier(this.repository) : super(UserState(users: []));

  Future<void> loadUsers({bool isRefresh = false}) async {
    if (state.isLoading || !state.hasMore && !isRefresh) return;
    try {
      state = state.copyWith(isLoading: true, errorMessage: null, users: isRefresh ? [] : state.users);
      final nextPage = isRefresh ? 1 : state.currentPage;
      final newUsersResp = await repository.getUsers(nextPage);
      final newUsers = newUsersResp.data ?? [];

      state = state.copyWith(
        users: isRefresh ? newUsers : [...state.users, ...newUsers],
        isLoading: false,
        currentPage: nextPage + 1,
        hasMore: (newUsersResp.totalPages ?? 1) > nextPage,
        tempSearchList: isRefresh ? newUsers : [...state.users, ...newUsers],
        isSearching: false,
      );

      if ((newUsersResp.total ?? 0) <= state.users.length) {
        Fluttertoast.showToast(
          msg: "You Are At The Last Page.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black45,
          textColor: Colors.white,
          fontSize: 12.0,
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> localSearch(String query) async {
    /// api limitation on search
    /// so doing a reactive local search
    // Normalize input

    final normalizedQuery = query.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ' ');

    final filtered =
        state.tempSearchList?.where((user) {
          final fullName = '${user.firstName} ${user.lastName}'.toLowerCase().replaceAll(RegExp(r'\s+'), ' ');

          return fullName.contains(normalizedQuery);
        }).toList();

    state = state.copyWith(isSearching: true, users: filtered, hasMore: false, isLoading: false);
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  final repository = sl<UserListRepository>();
  return UserNotifier(repository);
});
