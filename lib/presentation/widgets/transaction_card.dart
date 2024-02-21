import 'package:flutter/material.dart';

import '../../common/format_decimal.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/transaction.dart';
import '../constants/color_constant.dart';
import '../constants/style_constant.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    super.key,
    required this.category,
    required this.transaction,
  });

  final Category category;
  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white, // Set your desired background color
        borderRadius: BorderRadius.circular(12), // Set your desired border radius
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Set your desired shadow color
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        leading: Image.asset(
          category.iconPath,
          width: 48,
        ),
        title: Text(
          category.name,
          style: StyleConstant.bodyStyle.copyWith(fontSize: 14),
        ),
        subtitle: Text(
          transaction.name,
          style: StyleConstant.bodyStyle.copyWith(color: Colors.grey),
        ),
        trailing: switch (transaction.type) {
          TransactionType.income => Text(
              '+Rp${FormatDecimal.format(transaction.amount)}',
              style: StyleConstant.bodyBoldStyle.copyWith(color: green, fontSize: 12),
            ),
          TransactionType.expense => Text(
              '-Rp${FormatDecimal.format(transaction.amount)}',
              style: StyleConstant.bodyBoldStyle.copyWith(color: Colors.red, fontSize: 12),
            ),
        },
      ),
    );
  }
}
