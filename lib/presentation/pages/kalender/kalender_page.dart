import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pretest/common/datetime_extentions.dart';
import 'package:pretest/common/format_decimal.dart';
import 'package:pretest/data/models/transaction_model.dart';
import 'package:pretest/presentation/bloc/transaction/transaction_cubit.dart';
import 'package:pretest/presentation/constants/color_constant.dart';
import 'package:pretest/presentation/constants/size_constant.dart';
import 'package:pretest/presentation/constants/style_constant.dart';

import '../../../domain/entities/transaction.dart';

class KalenderPage extends StatefulWidget {
  const KalenderPage({super.key});

  static const routeName = '/kalender';

  @override
  State<KalenderPage> createState() => _KalenderPageState();
}

class _KalenderPageState extends State<KalenderPage> {
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
        title: const Text('Kalender'),
      ),
      body: Padding(
        padding: screenPadding,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _roundedButton(
                  text: 'Pemasukan',
                  isIncome: _isIncome,
                  onPressed: () => setState(() {
                    _isIncome = true;
                  }),
                ),
                _roundedButton(
                  text: 'Pengeluaran',
                  isIncome: !_isIncome,
                  onPressed: () => setState(() {
                    _isIncome = false;
                  }),
                ),
              ],
            ),
            const Gap(24),
            Expanded(
              child: BlocBuilder<TransactionCubit, TransactionState>(
                builder: (context, state) {
                  if (state is! TransactionLoaded) {
                    BlocProvider.of<TransactionCubit>(context).getTransactionList();
                  }
                  state as TransactionLoaded;
                  final transactionList = switch (_isIncome) {
                    true => (state).transactionList.sortedByIncome,
                    false => (state).transactionList.sortedByExpense,
                  }
                      .groupedByMonthYear();
                  if (transactionList.isEmpty) {
                    return const Center(
                      child: Text('Tidak ada transaksi'),
                    );
                  }
                  return ListView.builder(
                    itemCount: transactionList.length,
                    itemBuilder: (context, index) {
                      return _groupedTransactionCard(transactionList[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton _roundedButton(
      {required String text, required bool isIncome, required VoidCallback? onPressed}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: yellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: StyleConstant.bodyPoppinsStyle.copyWith(
          color: isIncome ? Colors.white : Colors.grey,
        ),
      ),
    );
  }

  Container _groupedTransactionCard(Transaction transaction) {
    return Container(
      decoration: BoxDecoration(
        color: blue,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                transaction.name,
                style: StyleConstant.bodyBoldStyle.copyWith(
                  color: Colors.white,
                ),
              ),
              Text(
                transaction.date.yearInString,
                style: StyleConstant.bodyPoppinsStyle.copyWith(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const Gap(16),
          RichText(
            text: TextSpan(
              text: 'Amount ',
              style: StyleConstant.bodyPoppinsStyle.copyWith(color: Colors.grey),
              children: [
                TextSpan(
                  text: 'Rp${FormatDecimal.format(transaction.amount)}',
                  style: StyleConstant.bodyPoppinsStyle.copyWith(
                    color: yellow,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
