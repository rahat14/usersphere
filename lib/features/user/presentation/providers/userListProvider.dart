import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:usersphere/features/user/data/models/UserListResp.dart';

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
      final result = await repository.getUsers(nextPage);

      result.fold(
        (failure) {
          Fluttertoast.showToast(
            msg: failure.message,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
          );
          state.copyWith(isLoading: false, errorMessage: failure.message);
        },
        (response) {
          updateListState(response, nextPage, isRefresh);
        },
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  localSearch(String query) async {
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

  void updateListState(UserListResp response, int nextPage, bool isRefresh) {
    final newUsers = response.data ?? [];

    state = state.copyWith(
      users: isRefresh ? newUsers : [...state.users, ...newUsers],
      isLoading: false,
      currentPage: nextPage + 1,
      hasMore: (response.totalPages ?? 1) > nextPage,
      tempSearchList: isRefresh ? newUsers : [...state.users, ...newUsers],
      isSearching: false,
    );

    if ((response.total ?? 0) <= state.users.length) {
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
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  final repository = sl<UserListRepository>();
  return UserNotifier(repository);
});
