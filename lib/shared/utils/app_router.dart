import 'package:flutter/material.dart';

import '../../core/constant/routes.dart';
import '../../features/home/screen/home_screen.dart';
import '../../features/splash/screen/splash_screen.dart';

class AppRouter {
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );
      case Routes.home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: settings,
        );
      default:
        // Falls through to onUnknownRoute.
        return null;
    }
  }

  Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(child: Text('Page not found')),
      ),
      settings: settings,
    );
  }
}
