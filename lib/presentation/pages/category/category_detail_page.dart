import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../domain/entities/category.dart';
import '../../constants/color_constant.dart';
import '../../constants/style_constant.dart';
import '../../widgets/button_with_asset.dart';
import '../../widgets/rounded_divider.dart';

class CategoryDetailPage extends StatelessWidget {
  final Category category;
  const CategoryDetailPage({super.key, required this.category});

  static const routeName = '/category-detail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32),
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
                      backgroundColor: yellow,
                      color: Colors.black,
                      showShadow: false,
                    ),
                    const Spacer(),
                  ],
                ),
                const Gap(24),
                Text(
                  'Kategori',
                  style: StyleConstant.subTitleStyle,
                ),
                const Gap(32),
                Container(
                  padding: const EdgeInsets.all(24),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        category.iconPath,
                        scale: 0.7,
                      ),
                      const Gap(16),
                      Text(
                        category.name,
                        style: StyleConstant.bodyBoldStyle.copyWith(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(24),
                Container(
                  padding: const EdgeInsets.all(24),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Deskripsi',
                        style: StyleConstant.bodyBoldStyle.copyWith(color: Colors.white),
                      ),
                      const Gap(8),
                      Text(
                        category.description,
                        style: StyleConstant.bodyStyle.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
