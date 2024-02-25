import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pretest/common/format_decimal.dart';
import 'package:pretest/data/models/transaction_model.dart';
import 'package:pretest/presentation/bloc/category/category_cubit.dart';
import 'package:pretest/presentation/constants/color_constant.dart';
import 'package:pretest/presentation/constants/size_constant.dart';
import 'package:pretest/presentation/constants/style_constant.dart';

import '../../../domain/entities/category.dart';
import '../../../domain/entities/transaction.dart';
import '../../bloc/dompet/dompet_cubit.dart';
import '../../bloc/transaction/transaction_cubit.dart';

class KeuanganPage extends StatefulWidget {
  const KeuanganPage({super.key});

  static const routeName = '/keuangan';

  @override
  State<KeuanganPage> createState() => _KeuanganPageState();
}

class _KeuanganPageState extends State<KeuanganPage> {
  bool _isIncome = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FBFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6FBFF),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Detail Keuangan'),
      ),
      body: BlocBuilder<DompetCubit, DompetState>(
        builder: (context, state) {
          final dompetList = (state as DompetLoaded).dompetList;
          final totalDompetAmount = dompetList.fold(
            0.0,
            (previousValue, dompet) => previousValue + dompet.saldo,
          );
          return Center(
            child: Column(
              children: [
                Padding(
                  padding: screenPadding,
                  child: Column(
                    children: [
                      Text(
                        'Rp ${totalDompetAmount.toFormattedString()}',
                        style: StyleConstant.bodyPoppinsStyle.copyWith(
                          fontSize: 24,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Total keuangan anda',
                        style: StyleConstant.bodyPoppinsStyle.copyWith(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(32),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: blue,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                top: -24,
                                left: MediaQuery.of(context).size.width / 4,
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: darkYellow,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      AnimatedPositioned(
                                        duration: const Duration(milliseconds: 200),
                                        left: _isIncome ? 0 : 100,
                                        right: !_isIncome ? 0 : 100,
                                        child: _roundedButton(
                                          text: _isIncome ? 'Pemasukan' : 'Pengeluaran',
                                          textColor: blue,
                                          backgroundColor: blue,
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          _roundedButton(
                                            text: 'Pemasukan',
                                            textColor: _isIncome ? yellow : Colors.white,
                                            onPressed: () => setState(() => _isIncome = true),
                                          ),
                                          const Gap(8),
                                          _roundedButton(
                                            text: 'Pengeluaran',
                                            textColor: !_isIncome ? yellow : Colors.white,
                                            onPressed: () => setState(() => _isIncome = false),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Gap(36),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 24),
                          width: double.infinity,
                          height: 160,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: _lineChart(),
                        ),
                        const Gap(36),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 24),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            child: BlocBuilder<CategoryCubit, CategoryState>(
                              builder: (context, state) {
                                if (state is! CategoryLoaded) {
                                  BlocProvider.of<CategoryCubit>(context).getCategoryList();
                                }
                                final categoryList = (state as CategoryLoaded).categoryList;
                                final transactionState = BlocProvider.of<TransactionCubit>(context)
                                    .state as TransactionLoaded;
                                final transactionList = transactionState.transactionList
                                    .groupedByCategory(categoryList, isIncome: _isIncome);
                                if (transactionList.isEmpty) {
                                  return const Center(
                                    child: Text('Tidak ada transaksi'),
                                  );
                                }
                                return ListView.builder(
                                  itemCount: transactionList.length,
                                  itemBuilder: (context, index) {
                                    final category = categoryList.firstWhere(
                                      (category) =>
                                          category.id == transactionList[index].categoryId,
                                    );
                                    return _groupedTransactionCard(
                                        transactionList[index], category);
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _roundedButton(
      {required String text, Color? textColor, Color? backgroundColor, VoidCallback? onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: StyleConstant.bodyPoppinsStyle.copyWith(color: textColor ?? Colors.white),
        ),
      ),
    );
  }

  Widget _groupedTransactionCard(Transaction transaction, Category category) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(category.iconPath, width: 36, height: 36),
              const Gap(8),
              Text(
                category.name,
                style: StyleConstant.bodyBoldStyle,
              ),
            ],
          ),
          Text(
            'Rp ${transaction.amount.abs().toFormattedString()}',
            style: StyleConstant.bodyBoldStyle,
          ),
        ],
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
            barWidth: 2,
            dotData: const FlDotData(show: false),
            color: darkYellow,
            belowBarData: BarAreaData(
              show: true,
              applyCutOffY: true,
              gradient: const LinearGradient(
                colors: [yellow, Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
