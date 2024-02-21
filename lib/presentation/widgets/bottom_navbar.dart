import 'package:flutter/material.dart';
import 'package:pretest/presentation/pages/transaction/add_transaction_page.dart';

import '../constants/color_constant.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Image.asset('assets/icons/navbar/wallet_active.png'),
          label: 'Dompet',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/icons/navbar/home.png'),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/icons/navbar/analytic.png'),
          label: 'Analitik',
        ),
      ],
      onTap: (index) {
        if (index == 0) {
          // Navigator.pushNamed(context, '/dompet');
        } else if (index == 1) {
          // Navigator.pushNamed(context, '/home');
        } else if (index == 2) {
          Navigator.of(context).pushNamed(AddTransactionPage.routeName);
        }
      },
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: blue,
      unselectedItemColor: Colors.grey,
    );
  }
}
