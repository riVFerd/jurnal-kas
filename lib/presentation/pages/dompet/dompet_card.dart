import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pretest/presentation/pages/dompet/detail_dompet_page.dart';

import '../../../common/format_decimal.dart';
import '../../../logic/models/dompet.dart';
import '../../constants/color_constant.dart';
import '../../constants/style_constant.dart';

class DompetCard extends StatelessWidget {
  final double width;
  final Dompet dompet;

  const DompetCard({
    super.key,
    required this.width,
    required this.dompet,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Material(
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(DetailDompetPage.routeName, arguments: dompet);
          },
          child: Container(
            width: width,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.withOpacity(0.2),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(dompet.iconPath),
                const Gap(24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Saldo ${dompet.name}',
                      style: StyleConstant.bodyStyle.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Rp ${FormatDecimal.format(dompet.saldo)}',
                      style: StyleConstant.bodyBoldStyle.copyWith(color: green),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: blue,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  alignment: Alignment.center,
                  child: Image.asset('assets/icons/arrow.png'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
