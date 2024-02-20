import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pretest/presentation/constants/style_constant.dart';

import '../../../domain/entities/dompet.dart';
import '../../constants/color_constant.dart';
import '../../widgets/button_with_asset.dart';
import '../../widgets/rounded_divider.dart';

class DetailDompetPage extends StatelessWidget {
  final Dompet dompet;

  const DetailDompetPage({super.key, required this.dompet});

  static const routeName = '/detail-dompet';

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
                      buttonText: 'Dompet',
                      iconAsset: 'assets/icons/wallet_stretch.png',
                      borderRadius: 24,
                      backgroundColor: blue,
                    ),
                    const Spacer(),
                  ],
                ),
                const Gap(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      dompet.iconPath,
                      scale: 0.7,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Your onPressed action here
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(10),
                        backgroundColor: Colors.white,
                        side: const BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.filter_alt_outlined,
                            color: blue,
                          ),
                          const Gap(8),
                          Text(
                            'Rentang Waktu',
                            style: StyleConstant.bodyStyle.copyWith(
                              color: blue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(24),
                _incomeOutcome(),
                const Gap(24),
                // ListView.builder(
                //   itemCount: 3,
                //   itemBuilder: (context, index) {
                //     return Card(
                //       child: ListTile(
                //         title: Text('Transaksi ke-${index + 1}'),
                //         subtitle: const Text('Rp100.000'),
                //         trailing: const Icon(Icons.arrow_forward_ios),
                //       ),
                //     );
                //   },
                // ),
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
      ),
    );
  }

  Widget _incomeOutcome() {
    return PhysicalModel(
      color: Colors.transparent,
      elevation: 8,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.arrow_downward, color: green),
                          const Gap(4),
                          Text(
                            'Pemasukan',
                            style: StyleConstant.bodyStyle.copyWith(
                              color: grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Rp500.000',
                        style: StyleConstant.bodyBoldStyle.copyWith(color: blue),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 100,
                  color: Colors.grey,
                ),
                Flexible(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.arrow_upward, color: Colors.red),
                          const Gap(4),
                          Text(
                            'Pengeluaran',
                            style: StyleConstant.bodyStyle.copyWith(
                              color: grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Rp82.000',
                        style: StyleConstant.bodyBoldStyle.copyWith(color: blue),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              ),
              child: RichText(
                text: TextSpan(
                  text: 'Selisih ',
                  style: StyleConstant.bodyBoldStyle.copyWith(color: blue),
                  children: [
                    TextSpan(
                      text: ' Rp418.000',
                      style: StyleConstant.bodyBoldStyle.copyWith(color: green),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
