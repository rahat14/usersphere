class UserState {
  final List<dynamic> users;
  final bool isLoading;
  final String? errorMessage;
  final int currentPage;
  final bool hasMore;

  UserState({
    required this.users,
    this.isLoading = false,
    this.errorMessage,
    this.currentPage = 1,
    this.hasMore = true,
  });

  UserState copyWith({
    List<dynamic>? users,
    bool? isLoading,
    String? errorMessage,
    int? currentPage,
    bool? hasMore,
  }) {
    return UserState(
      users: users ?? this.users,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}
