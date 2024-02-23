import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pretest/data/models/category_model.dart';
import 'package:pretest/domain/entities/category.dart';
import 'package:pretest/presentation/bloc/category/category_cubit.dart';

import '../../bloc/user/user_cubit.dart';
import '../../constants/color_constant.dart';
import '../../constants/style_constant.dart';
import '../../widgets/button_with_asset.dart';
import '../../widgets/rounded_divider.dart';

class AddCategoryModal extends StatefulWidget {
  const AddCategoryModal({
    super.key,
  });

  @override
  State<AddCategoryModal> createState() => _AddCategoryModalState();
}

class _AddCategoryModalState extends State<AddCategoryModal> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  CategoryIcon selectedIcon = CategoryIcon.values[0];
  int selectedIconIndex = 0;
  bool isValid = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      width: double.infinity,
      child: Center(
        child: Column(
          children: [
            const Gap(24),
            RoundedDivider(
              width: MediaQuery.of(context).size.width / 4,
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
            const Gap(24),
            Text(
              'Tambah Kategori',
              style: StyleConstant.subTitleStyle,
            ),
            const Gap(24),
            if (!isValid)
              Text(
                'Nama & deskripsi kategori tidak boleh kosong',
                style: StyleConstant.bodyStyle.copyWith(
                  color: Colors.red,
                ),
              ),
            TextField(
              controller: nameController,
              decoration: StyleConstant.underlinInputDecoration.copyWith(
                labelText: 'Nama Kategori',
              ),
            ),
            const Gap(24),
            TextField(
              controller: descriptionController,
              decoration: StyleConstant.underlinInputDecoration.copyWith(
                labelText: 'Deskripsi Kategori',
              ),
            ),
            const Gap(24),
            Scrollbar(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                height: 48,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: CategoryIcon.values.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                        onPressed: () => setState(() {
                          selectedIcon = CategoryIcon.values[index];
                          selectedIconIndex = index;
                        }),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: selectedIconIndex == index ? yellow : Colors.transparent,
                          minimumSize: Size.zero,
                          padding: const EdgeInsets.all(10),
                        ),
                        child: Image.asset(
                          Category.icons(CategoryIcon.values[index]),
                          width: 32,
                          height: 32,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const Gap(24),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isEmpty || descriptionController.text.isEmpty) {
                  isValid = false;
                  setState(() {});
                  return;
                }
                final user = (BlocProvider.of<UserCubit>(context).state as UserAuthenticated).user;
                BlocProvider.of<CategoryCubit>(context).createCategory(
                  CategoryModel(
                    id: '',
                    name: nameController.text,
                    description: descriptionController.text,
                    iconPath: Category.icons(selectedIcon),
                    userId: user.id,
                  ),
                );
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: blue,
                minimumSize: Size.zero,
                padding: const EdgeInsets.all(10),
              ),
              child: const Icon(
                Icons.check,
                color: darkYellow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
