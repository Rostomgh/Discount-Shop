import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constant/routes.dart';
import '../../features/add_product/logic/add_product_cubit.dart';
import '../../features/add_product/screen/add_product_screen.dart';
import '../../features/become_partner/screen/become_partner_screen.dart';
import '../../features/confirm_number/screen/confirm_number_screen.dart';
import '../../features/home/model/product_model.dart';
import '../../features/login/screen/login_screen.dart';
import '../../features/navigation/screen/navigation_screen.dart';
import '../../features/splash/screen/splash_screen.dart';

class AppRouter {
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );
      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          settings: settings,
        );
      case Routes.confirmNumber:
        return MaterialPageRoute(
          builder: (_) => ConfirmNumberScreen(
            phoneNumber: settings.arguments as String? ?? '',
          ),
          settings: settings,
        );
      case Routes.becomePartner:
        return MaterialPageRoute(
          builder: (_) => const BecomePartnerScreen(),
          settings: settings,
        );
      case Routes.home:
        // The main app: the navigation bar, starting on the Home tab.
        return MaterialPageRoute(
          builder: (_) => const NavigationScreen(),
          settings: settings,
        );
      case Routes.addProduct:
        // The argument is a photo already picked from the gallery, if any.
        // The cubit is created here so every visit starts with an empty form.
        // Pops with the new ProductModel.
        return MaterialPageRoute<ProductModel>(
          builder: (_) => BlocProvider(
            create: (_) =>
                AddProductCubit(imagePath: settings.arguments as String?),
            child: const AddProductScreen(),
          ),
          settings: settings,
        );
      default:
        // Falls through to onUnknownRoute.
        return null;
    }
  }

  Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) =>
          const Scaffold(body: Center(child: Text('Page not found'))),
      settings: settings,
    );
  }
}
