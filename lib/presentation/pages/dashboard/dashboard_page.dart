import 'package:flutter/material.dart';
import 'package:pretest/presentation/pages/home/home_page.dart';
import 'package:pretest/presentation/pages/setting/setting_page.dart';
import 'package:pretest/presentation/pages/transaction/add_transaction_page.dart';

import '../../constants/color_constant.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  static const routeName = '/dashboard';

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _pageController = PageController(initialPage: 1);
  int _currentPage = 1;

  void _onItemTapped(int index) {
    setState(() {
      _currentPage = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: _onItemTapped,
        controller: _pageController,
        children: const [
          SettingPage(),
          HomePage(),
          AddTransactionPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              _currentPage == 0
                  ? 'assets/icons/navbar/wallet_active.png'
                  : 'assets/icons/navbar/wallet.png',
            ),
            label: 'Dompet',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              _currentPage == 1
                  ? 'assets/icons/navbar/home_active.png'
                  : 'assets/icons/navbar/home.png',
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/navbar/analytic.png',
              color: _currentPage == 2 ? yellow : null,
            ),
            label: 'Analitik',
          ),
        ],
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
