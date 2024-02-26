import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pretest/presentation/widgets/horizontal_divider_with_text.dart';

import '../../bloc/dompet/dompet_cubit.dart';
import '../../bloc/transaction/transaction_cubit.dart';
import '../../constants/color_constant.dart';
import '../../widgets/button_with_asset.dart';
import '../../widgets/rounded_divider.dart';
import 'add_dompet_modal.dart';
import 'dompet_card.dart';

class DompetPage extends StatelessWidget {
  const DompetPage({super.key});

  static const routeName = '/dompet';

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
                  child: BlocBuilder<TransactionCubit, TransactionState>(
                    builder: (context, state) {
                      return _lineChart();
                    },
                  ),
                ),
                const Gap(24),
                const HorizontalDividerWithText(text: 'detail'),
                const Gap(24),
                Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height / 2,
                  ),
                  child: BlocBuilder<TransactionCubit, TransactionState>(
                    builder: (context, state) {
                      // get the updated wallet
                      BlocProvider.of<DompetCubit>(context).getDompetList();
                      return BlocBuilder<DompetCubit, DompetState>(
                        builder: (context, state) {
                          switch (state) {
                            case DompetLoaded _:
                              final dompetList = state.dompetList;
                              return ListView.builder(
                                itemCount: dompetList.length,
                                itemBuilder: (context, index) {
                                  return DompetCard(
                                    width: MediaQuery.of(context).size.width - 16,
                                    dompet: dompetList[index],
                                  );
                                },
                              );
                            case DompetInitial():
                              BlocProvider.of<DompetCubit>(context).getDompetList();
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                          }
                        },
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
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return const AddDompetModal();
            },
          );
        },
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }

  LineChart _lineChart() {
    return LineChart(
      LineChartData(
        borderData: FlBorderData(show: false),
        titlesData: const FlTitlesData(show: false),
        gridData: const FlGridData(show: false),
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
