import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'constants/app_config.dart';
import 'constants/app_theme.dart';
import 'screens/home_screen.dart';

/// Application root — mirrors App.tsx (BrowserRouter + title).
class PortfolioApp extends StatelessWidget {
  PortfolioApp({super.key});

  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (_, __) => const HomeScreen(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConfig.title,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      routerConfig: _router,
    );
  }
}
