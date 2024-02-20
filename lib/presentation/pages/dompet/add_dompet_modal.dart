import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../data/models/dompet_model.dart';
import '../../../domain/entities/dompet.dart';
import '../../bloc/dompet/dompet_cubit.dart';
import '../../constants/color_constant.dart';
import '../../constants/style_constant.dart';
import '../../widgets/button_with_asset.dart';
import '../../widgets/rounded_divider.dart';

class AddDompetModal extends StatefulWidget {
  const AddDompetModal({
    super.key,
  });

  @override
  State<AddDompetModal> createState() => _AddDompetModalState();
}

class _AddDompetModalState extends State<AddDompetModal> {
  final nameController = TextEditingController();
  final saldoController = TextEditingController();
  DompetIcon selectedIcon = DompetIcon.values[0];
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
                  buttonText: 'Dompet',
                  iconAsset: 'assets/icons/wallet_stretch.png',
                  borderRadius: 24,
                  backgroundColor: blue,
                ),
                const Spacer(),
              ],
            ),
            const Gap(24),
            Text(
              'Tambah Dompet',
              style: StyleConstant.subTitleStyle,
            ),
            const Gap(24),
            if (!isValid)
              Text(
                'Nama dan saldo tidak boleh kosong',
                style: StyleConstant.bodyStyle.copyWith(
                  color: Colors.red,
                ),
              ),
            TextField(
              controller: nameController,
              decoration: StyleConstant.underlinInputDecoration.copyWith(
                labelText: 'Nama Dompet',
              ),
            ),
            const Gap(24),
            TextField(
              controller: saldoController,
              decoration: StyleConstant.underlinInputDecoration.copyWith(
                labelText: 'Saldo Awal',
              ),
              keyboardType: TextInputType.number,
            ),
            const Gap(24),
            SizedBox(
              height: 48,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: DompetIcon.values.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                      onPressed: () => setState(() {
                        selectedIcon = DompetIcon.values[index];
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
                        Dompet.icons(DompetIcon.values[index]),
                        width: 32,
                        height: 32,
                      ),
                    ),
                  );
                },
              ),
            ),
            const Gap(24),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isEmpty || saldoController.text.isEmpty) {
                  isValid = false;
                  setState(() {});
                  return;
                }
                BlocProvider.of<DompetCubit>(context).createDompet(
                  DompetModel(
                    id: DateTime.now().toString(),
                    name: nameController.text,
                    iconPath: Dompet.icons(selectedIcon),
                    saldo: double.parse(saldoController.text),
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
