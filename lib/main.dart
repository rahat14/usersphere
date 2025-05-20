import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:usersphere/router/app_router.dart';

import 'core/theme/theme_data.dart';
import 'services/di.dart' as di;

void main() {
  di.init();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Demo',
      theme: lightTheme, //custom light theme
     // darkTheme: darkTheme,     // custom dark mode
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
