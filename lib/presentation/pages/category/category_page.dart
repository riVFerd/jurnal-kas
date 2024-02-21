import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pretest/presentation/constants/style_constant.dart';
import 'package:pretest/presentation/pages/category/category_detail_page.dart';

import '../../bloc/category/category_cubit.dart';
import '../../constants/color_constant.dart';
import '../../constants/size_constant.dart';
import '../../widgets/button_with_asset.dart';
import '../../widgets/card_button.dart';
import '../../widgets/rounded_divider.dart';
import 'add_category_modal.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  static const routeName = '/category';

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
                const Gap(46),
                Text(
                  'Kategori',
                  style: StyleConstant.subTitleStyle,
                ),
                const Gap(46),
                BlocBuilder<CategoryCubit, CategoryState>(
                  builder: (context, state) {
                    switch (state) {
                      case CategoryInitial _:
                        BlocProvider.of<CategoryCubit>(context).getCategoryList();
                        return const CircularProgressIndicator();
                      case CategoryLoaded _:
                        final categoryList = state.categoryList;
                        return Wrap(
                          spacing: 13.0,
                          runSpacing: 13.0,
                          alignment: WrapAlignment.center,
                          children: List.generate(
                            categoryList.length + 1,
                            (index) {
                              if (index == categoryList.length) {
                                return CardButton(
                                  icon: 'assets/icons/add.png',
                                  title: '',
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (context) {
                                        return const AddCategoryModal();
                                      },
                                    );
                                  },
                                );
                              } else {
                                return CardButton(
                                  icon: categoryList[index].iconPath,
                                  title: categoryList[index].name,
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      CategoryDetailPage.routeName,
                                      arguments: categoryList[index],
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        );
                    }
                  },
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
