import 'package:go_router/go_router.dart';

import '../features/user/presentation/screens/UserListScreen.dart';

class AppRouter {
  static final router = GoRouter(routes: [GoRoute(path: '/', builder: (_, __) => UserListScreen())]);
}
