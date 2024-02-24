import 'package:flutter/material.dart';
import 'package:pretest/presentation/pages/category/category_detail_page.dart';
import 'package:pretest/presentation/pages/category/category_page.dart';
import 'package:pretest/presentation/pages/dashboard/dashboard_page.dart';
import 'package:pretest/presentation/pages/dompet/dompet_detail_page.dart';
import 'package:pretest/presentation/pages/dompet/dompet_page.dart';
import 'package:pretest/presentation/pages/login/login_page.dart';
import 'package:pretest/presentation/pages/login/signup_page.dart';
import 'package:pretest/presentation/pages/profile/profile_edit_page.dart';
import 'package:pretest/presentation/pages/profile/profile_page.dart';
import 'package:pretest/presentation/pages/transaction/add_transaction_page.dart';

import '../../domain/entities/category.dart';
import '../../domain/entities/dompet.dart';
import '../../domain/entities/user.dart';
import '../pages/search/search_page.dart';

class AppRouter {
  static PageRoute onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginPage.routeName:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case SignupPage.routeName:
        return MaterialPageRoute(builder: (_) => const SignupPage());
      case DompetPage.routeName:
        return MaterialPageRoute(builder: (_) => const DompetPage());
      case DompetDetailPage.routeName:
        final dompet = settings.arguments as Dompet;
        return MaterialPageRoute(
          builder: (_) => DompetDetailPage(
            dompet: dompet,
          ),
        );
      case CategoryPage.routeName:
        return MaterialPageRoute(builder: (_) => const CategoryPage());
      case CategoryDetailPage.routeName:
        final category = settings.arguments as Category;
        return MaterialPageRoute(
          builder: (_) => CategoryDetailPage(
            category: category,
          ),
        );
      case AddTransactionPage.routeName:
        return MaterialPageRoute(builder: (_) => const AddTransactionPage());
      case DashboardPage.routeName:
        return MaterialPageRoute(builder: (_) => const DashboardPage());
      case SearchPage.routeName:
        return MaterialPageRoute(builder: (_) => const SearchPage());
      case ProfilePage.routeName:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case ProfileEditPage.routeName:
        final user = settings.arguments as User;
        return MaterialPageRoute(builder: (_) => ProfileEditPage(user: user));
      case '/':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      default:
        return MaterialPageRoute(builder: (_) => const Placeholder());
    }
  }
}
