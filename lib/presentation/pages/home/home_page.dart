import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pretest/presentation/constants/size_constant.dart';
import 'package:pretest/presentation/widgets/button_with_asset.dart';

import '../../constants/color_constant.dart';

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
                Container(
                  width: 64,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(24),
                  ),
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
                      return PhysicalModel(
                        color: Colors.transparent,
                        elevation: 1,
                        borderRadius: BorderRadius.circular(17),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 3 - 16,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(17),
                          ),
                          child: Column(
                            children: [
                              Image.asset(
                                listMenu[index]['icon'] ?? 'assets/icons/profile.png',
                              ),
                              const Gap(8),
                              Text(
                                listMenu[index]['title'] ?? 'Profile',
                              )
                            ],
                          ),
                        ),
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

const listMenu = [
  {
    'icon': 'assets/icons/profile.png',
    'title': 'Profile',
  },
  {
    'icon': 'assets/icons/book.png',
    'title': 'Buku',
  },
  {
    'icon': 'assets/icons/wallet.png',
    'title': 'Dompet',
  },
  {
    'icon': 'assets/icons/search.png',
    'title': 'Cari',
  },
  {
    'title': 'Pengingat',
    'icon': 'assets/icons/reminder.png',
  },
  {
    'title': 'Kategori',
    'icon': 'assets/icons/category.png',
  },
  {
    'title': 'Tentang',
    'icon': 'assets/icons/about.png',
  },
  {
    'title': 'Google Drive',
    'icon': 'assets/icons/google-drive.png',
  },
  {
    'title': 'Premium',
    'icon': 'assets/icons/premium.png',
  }
];
