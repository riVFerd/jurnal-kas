import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pretest/presentation/constants/size_constant.dart';
import 'package:pretest/presentation/widgets/button_with_asset.dart';
import 'package:pretest/presentation/widgets/card_button.dart';

import '../../constants/color_constant.dart';
import '../../widgets/rounded_divider.dart';
import '../category/category_page.dart';
import '../dompet/dompet_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: screenPadding,
            child: Column(
              children: [
                const RoundedDivider(
                  width: 64,
                  height: 4,
                  color: Colors.grey,
                  borderRadius: 24,
                ),
                const Gap(24),
                Row(
                  children: [
                    const Spacer(),
                    ButtonWithAsset(
                      onPressed: () {},
                      buttonText: 'Pengaturan',
                      iconAsset: 'assets/icons/settings.png',
                      borderRadius: 24,
                      backgroundColor: blue,
                    ),
                    const Spacer(),
                  ],
                ),
                const Gap(64),
                Wrap(
                  spacing: 13.0,
                  runSpacing: 13.0,
                  alignment: WrapAlignment.center,
                  children: List.generate(
                    listMenu.length,
                    (index) {
                      return CardButton(
                        icon: listMenu[index].icon,
                        title: listMenu[index].title,
                        onTap: () => listMenu[index].callback(context),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

class _Menu {
  final String icon;
  final String title;
  final Function(BuildContext) callback;

  _Menu({
    required this.icon,
    required this.title,
    required this.callback,
  });
}

final listMenu = [
  _Menu(
    icon: 'assets/icons/profile.png',
    title: 'Profile',
    callback: (_) {},
  ),
  _Menu(
    icon: 'assets/icons/book.png',
    title: 'Buku',
    callback: (_) {},
  ),
  _Menu(
    icon: 'assets/icons/wallet.png',
    title: 'Dompet',
    callback: (context) => Navigator.of(context).pushNamed(DompetPage.routeName),
  ),
  _Menu(
    icon: 'assets/icons/search.png',
    title: 'Cari',
    callback: (_) {},
  ),
  _Menu(
    icon: 'assets/icons/reminder.png',
    title: 'Pengingat',
    callback: (_) {},
  ),
  _Menu(
    icon: 'assets/icons/category.png',
    title: 'Kategori',
    callback: (context) => Navigator.of(context).pushNamed(CategoryPage.routeName),
  ),
  _Menu(
    icon: 'assets/icons/about.png',
    title: 'Tentang',
    callback: (_) {},
  ),
  _Menu(
    icon: 'assets/icons/google-drive.png',
    title: 'Google Drive',
    callback: (_) {},
  ),
  _Menu(
    icon: 'assets/icons/premium.png',
    title: 'Premium',
    callback: (_) {},
  ),
];
