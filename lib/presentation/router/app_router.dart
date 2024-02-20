import 'package:flutter/material.dart';
import 'package:pretest/presentation/pages/dompet/detail_dompet_page.dart';
import 'package:pretest/presentation/pages/dompet/dompet_page.dart';
import 'package:pretest/presentation/pages/home/home_page.dart';
import 'package:pretest/presentation/pages/login/login_page.dart';
import 'package:pretest/presentation/pages/login/signup_page.dart';

import '../../domain/entities/dompet.dart';

class AppRouter {
  static PageRoute onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginPage.routeName:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case SignupPage.routeName:
        return MaterialPageRoute(builder: (_) => const SignupPage());
      case HomePage.routeName:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case DompetPage.routeName:
        return MaterialPageRoute(builder: (_) => const DompetPage());
      case DetailDompetPage.routeName:
        final dompet = settings.arguments as Dompet;
        return MaterialPageRoute(
          builder: (_) => DetailDompetPage(
            dompet: dompet,
          ),
        );
      case '/':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      default:
        return MaterialPageRoute(builder: (_) => const Placeholder());
    }
  }
}
