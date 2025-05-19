import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:usersphere/features/user/presentation/screens/UserDetailsScreen.dart';

import '../features/user/data/models/UserListResp.dart';
import '../features/user/presentation/screens/UserListScreen.dart';

class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (_, __) => UserListScreen()),
      GoRoute(
        path: '/user-details',
        pageBuilder: (context, state) {
          final user = state.extra as User;
          return CustomTransitionPage(
            key: state.pageKey,
            child: UserDetailsScreen(user: user),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: Tween(begin: Offset(0, 0.2), end: Offset.zero).animate(animation),
                child: FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              );

            },
          );
        },
      ),
    ],
  );
}
