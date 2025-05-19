import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../main.dart';


class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (_, __) => MyHomePage(title: "ddd"),
      ),

    ],
  );
}
