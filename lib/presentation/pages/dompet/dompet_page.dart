import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pretest/presentation/widgets/horizontal_divider_with_text.dart';

import '../../../logic/models/dompet.dart';
import '../../../logic/statics/dompet_static.dart';
import '../../constants/color_constant.dart';
import '../../widgets/button_with_asset.dart';
import '../../widgets/rounded_divider.dart';
import 'dompet_card.dart';

class DompetPage extends StatefulWidget {
  const DompetPage({super.key});

  static const routeName = '/dompet';

  @override
  State<DompetPage> createState() => _DompetPageState();
}

class _DompetPageState extends State<DompetPage> {
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
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 5,
                  constraints: const BoxConstraints(minHeight: 180),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  child: _lineChart(),
                ),
                const Gap(24),
                const HorizontalDividerWithText(text: 'detail'),
                const Gap(24),
                Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height / 2,
                  ),
                  child: ListView.builder(
                    itemCount: DompetStatic.listDompet.length,
                    itemBuilder: (context, index) {
                      return DompetCard(
                        width: MediaQuery.of(context).size.width - 16,
                        dompet: DompetStatic.listDompet[index],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 8,
        onPressed: () {
          DompetStatic.listDompet.add(
            const Dompet(
              name: 'BNI',
              iconPath: 'assets/icons/bni.png',
              saldo: 5000000,
            ),
          );
          setState(() {});
        },
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Icon(Icons.add),
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

  LineChart _lineChart() {
    return LineChart(
      LineChartData(
        borderData: FlBorderData(show: false),
        titlesData: const FlTitlesData(show: false),
        gridData: FlGridData(show: false),
        minX: 0,
        minY: 0,
        maxY: 10,
        lineBarsData: [
          LineChartBarData(
            spots: [
              const FlSpot(0, 2),
              const FlSpot(1, 4),
              const FlSpot(2, 3),
              const FlSpot(3, 6),
              const FlSpot(4, 4),
              const FlSpot(5, 5),
              const FlSpot(6, 7),
            ],
            isCurved: true,
            barWidth: 4,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              applyCutOffY: true,
              gradient: const LinearGradient(
                colors: [lighterBlue, Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          LineChartBarData(
            spots: [
              const FlSpot(0, 4),
              const FlSpot(1, 2),
              const FlSpot(2, 4),
              const FlSpot(3, 3),
              const FlSpot(4, 5),
              const FlSpot(5, 6),
              const FlSpot(6, 4),
            ],
            isCurved: true,
            color: Colors.red,
            barWidth: 4,
            dotData: const FlDotData(show: false),
          ),
        ],
      ),
    );
  }
}
