import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/connectivity_provider.dart';
import '../providers/userListProvider.dart';
import '../widgets/UserTile.dart';
import '../widgets/no_internet_widget.dart';

class UserListScreen extends ConsumerStatefulWidget {
  const UserListScreen({super.key});

  @override
  ConsumerState<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends ConsumerState<UserListScreen> {
  final _searchController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _loadInitialList();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 300 &&
          !ref.read(userProvider).isLoading) {
        ref.read(userProvider.notifier).loadUsers();
      }
    });
  }

  void _loadInitialList() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userProvider.notifier).loadUsers();
    });

    // Future.microtask(() => );
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userProvider);
    final isConnected = ref.watch(connectivityStatusProvider);

    ref.listen<bool>(connectivityStatusProvider, (prev, next) {
      if (next == true) {
        ref.read(userProvider.notifier).loadUsers(isRefresh: true );
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      appBar: AppBar(title: Text('User List'), backgroundColor: Colors.black, elevation: 0, centerTitle: true),
      body:
          isConnected
              ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search users...',
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      controller: _scrollController,
                      itemCount: userState.users.length + (userState.hasMore ? 1 : 0),
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        if (index == userState.users.length) {
                          return const Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        return Padding(
                          padding: EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                            bottom: index == (userState.users.length - 1) ? 20 : 0,
                          ),
                          child: userTile(userState.users[index]),
                        );
                      },
                    ),
                  ),
                ],
              )
              : NoInternetWidget(
                onRetry: () {
                  ref.read(userProvider.notifier).loadUsers();
                },
              ),
    );
  }
}
