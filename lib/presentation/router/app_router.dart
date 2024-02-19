import 'package:flutter/material.dart';
import 'package:pretest/presentation/pages/home/home_page.dart';
import 'package:pretest/presentation/pages/login/login_page.dart';
import 'package:pretest/presentation/pages/login/signup_page.dart';

class AppRouter {
  static PageRoute onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginPage.routeName:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case SignupPage.routeName:
        return MaterialPageRoute(builder: (_) => const SignupPage());
      case HomePage.routeName:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      default:
        return MaterialPageRoute(builder: (_) => const Placeholder());
    }
  }
}
