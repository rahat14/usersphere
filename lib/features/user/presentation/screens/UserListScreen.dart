import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/text_styles.dart';
import '../providers/connectivityProvider.dart';
import '../providers/userListProvider.dart';
import '../widgets/UserTile.dart';
import '../widgets/noInternetWidget.dart';
import '../widgets/searchWidget.dart';

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
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 300 &&
          !ref.read(userProvider).isLoading) {
        ref.read(userProvider.notifier).loadUsers();
      }
    });
  }

  void _loadInitialList() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userProvider.notifier).loadUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userProvider);
    final isConnected = ref.watch(connectivityStatusProvider);

    ref.listen<bool>(connectivityStatusProvider, (prev, next) {
      if (next == true) {
        ref.read(userProvider.notifier).loadUsers(isRefresh: true);
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      appBar: AppBar(
        title: Text('User List'),
        titleTextStyle: CustomTextStyle.of(context).headingSmallTextStyle(),
        elevation: 0,
        centerTitle: false,
      ),
      body: RefreshIndicator(
        key: const Key('pull-to-refresh'),
        onRefresh: () async {
         if(!userState.isLoading){
           await ref.read(userProvider.notifier).loadUsers(isRefresh: true);
         }
        },
        child:
            isConnected
                ? Column(
                  children: [
                    SearchInputField(
                      onChanged: (value) {
                        if (value == '') {
                          ref
                              .read(userProvider.notifier)
                              .loadUsers(isRefresh: true);
                          SystemChannels.textInput.invokeMethod<void>(
                            'TextInput.hide',
                          );
                        } else {
                          ref.read(userProvider.notifier).localSearch(value);
                        }
                      },
                      onReset: () {
                        ref
                            .read(userProvider.notifier)
                            .loadUsers(isRefresh: true);
                        SystemChannels.textInput.invokeMethod<void>(
                          'TextInput.hide',
                        );
                      },
                    ),
                    Expanded(
                      child: ListView.separated(
                        key: const Key('user_list_view'),
                        controller: _scrollController,
                        itemCount:
                            userState.users.length +
                            (userState.hasMore ? 1 : 0),
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          if (index == userState.users.length) {
                            return const Padding(
                              padding: EdgeInsets.all(16),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }
                          return Padding(

                            key: Key('user_list_item_$index'),
                            padding: EdgeInsets.only(
                              left: 16.0,
                              right: 16.0,
                              bottom:
                                  index == (userState.users.length - 1)
                                      ? 20
                                      : 0,
                            ),
                            child: InkWell(
                              onTap: () {
                                context.push(
                                  '/user-details',
                                  extra: userState.users[index],
                                );
                              },
                              child: userTile(context, userState.users[index]),
                            ),
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
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }
}
