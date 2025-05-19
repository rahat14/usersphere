import '../../data/models/UserListResp.dart';

class UserState {
  final List<User> users;
  final List<User>? tempSearchList;
  final bool isLoading;
  final String? errorMessage;
  final int currentPage;
  final bool hasMore;
  final bool isSearching;

  UserState({
    required this.users,
    this.isLoading = false,
    this.errorMessage,
    this.currentPage = 1,
    this.hasMore = true,
    this.isSearching = false,
    this.tempSearchList,
  });

  UserState copyWith({
    List<User>? users,
    bool? isLoading,
    String? errorMessage,
    int? currentPage,
    bool? hasMore,
    bool? isSearching,
    List<User>? tempSearchList,
  }) {
    return UserState(
      users: users ?? this.users,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      isSearching: isSearching ?? this.isSearching,
      tempSearchList: tempSearchList ?? this.tempSearchList,
    );
  }
}
