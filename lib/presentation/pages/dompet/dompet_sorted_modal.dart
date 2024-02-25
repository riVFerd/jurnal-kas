import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pretest/common/datetime_extentions.dart';
import 'package:pretest/common/format_decimal.dart';
import 'package:pretest/data/models/transaction_model.dart';
import 'package:pretest/domain/entities/dompet.dart';
import 'package:pretest/presentation/bloc/transaction/transaction_cubit.dart';
import 'package:pretest/presentation/constants/style_constant.dart';

import '../../../domain/entities/transaction.dart';
import '../../bloc/category/category_cubit.dart';
import '../../constants/color_constant.dart';
import '../../widgets/button_with_asset.dart';
import '../../widgets/rounded_divider.dart';

class DompetSortedModal extends StatelessWidget {
  final DateTimeRange dateRange;
  final Dompet dompet;

  const DompetSortedModal({
    super.key,
    required this.dateRange,
    required this.dompet,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
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
                  buttonText: 'Detail Dompet',
                  iconAsset: 'assets/icons/wallet_stretch.png',
                  borderRadius: 24,
                  backgroundColor: blue,
                ),
                const Spacer(),
              ],
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 42),
              padding: const EdgeInsets.symmetric(vertical: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                color: lightGrey,
              ),
              child: Text(
                '${dateRange.start.toFormattedString()} - ${dateRange.end.toFormattedString()}',
                style: StyleConstant.bodyPoppinsStyle.copyWith(color: Colors.black),
              ),
            ),
            BlocBuilder<TransactionCubit, TransactionState>(
              builder: (context, state) {
                state as TransactionLoaded;
                final transactionList = state.transactionList
                    .where((transaction) {
                      return transaction.dompetId == dompet.id;
                    })
                    .toList()
                    .sortedByDateRange(dateRange);
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total',
                            style: StyleConstant.subTitleStyle.copyWith(fontSize: 14),
                          ),
                          _labelWithAmount(
                            'Pengeluaran',
                            transactionList.totalExpense.toFormattedString(),
                            textColor: Colors.red,
                            keepVisible: true,
                          ),
                          _labelWithAmount(
                            'Pemasukan',
                            transactionList.totalIncome.toFormattedString(),
                            textColor: green,
                            keepVisible: true,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      child: _labelWithAmount(
                        'Selisih',
                        transactionList.totalAmount.toFormattedString(),
                      ),
                    ),
                    BlocBuilder<CategoryCubit, CategoryState>(
                      builder: (context, state) {
                        if (state is! CategoryLoaded) {
                          BlocProvider.of<CategoryCubit>(context).getCategoryList();
                        }
                        state as CategoryLoaded;
                        final categoryList = state.categoryList;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Kategori Pengeluaran',
                                    style: StyleConstant.subTitleStyle.copyWith(fontSize: 14),
                                  ),
                                  Wrap(
                                    children: categoryList
                                        .map(
                                          (category) => _labelWithAmount(
                                            category.name,
                                            transactionList
                                                .where((transaction) =>
                                                    transaction.categoryId == category.id &&
                                                    transaction.type == TransactionType.expense)
                                                .fold(
                                                    0.0,
                                                    (previousValue, transaction) =>
                                                        previousValue + transaction.amount)
                                                .toFormattedString(),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 16),
                              color: Colors.grey,
                              height: 1,
                              width: double.infinity,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Kategori Pengeluaran',
                                    style: StyleConstant.subTitleStyle.copyWith(fontSize: 14),
                                  ),
                                  Wrap(
                                    children: categoryList
                                        .map(
                                          (category) => _labelWithAmount(
                                            category.name,
                                            transactionList
                                                .where((transaction) =>
                                                    transaction.categoryId == category.id &&
                                                    transaction.type == TransactionType.income)
                                                .fold(
                                                    0.0,
                                                    (previousValue, transaction) =>
                                                        previousValue + transaction.amount)
                                                .toFormattedString(),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Visibility _labelWithAmount(String label, String amount,
      {Color textColor = Colors.black, bool keepVisible = false}) {
    return Visibility(
      visible: amount != '0' || keepVisible,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: StyleConstant.bodyStyle.copyWith(color: textColor),
          ),
          Text(
            'Rp $amount',
            style: StyleConstant.bodyPoppinsStyle.copyWith(color: textColor),
          )
        ],
      ),
    );
  }
}
